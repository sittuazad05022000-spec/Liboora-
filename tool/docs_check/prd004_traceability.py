#!/usr/bin/env python3
"""PRD-004 traceability — recalculated per identifier, mechanically.

WHY THIS EXISTS
---------------
`PRD-004` §10.5 originally asserted "233 of 242 identifiers (96.3%) carry an
authoritative source".  The independent review (finding `RF-07`) disproved that
number: §10.5 is a ten-row *group* table, so no per-identifier mapping existed
anywhere in the repository.  A declared count that is not checked is not a fact
(`PRD-004` §0; `SID-4.56`).

This script replaces the assertion with a computation.  It is deliberately
conservative: where a judgement call exists, it counts against coverage.

THE MODEL
---------
An identifier is traced at one of two tiers.

  DIRECT   Its defining line -- or the preamble of the section that defines it
           -- cites at least one EXTERNAL authoritative source: a ranked
           document identifier (`MP-*`, `SID-*`, `LIB-*`, `AUTH-*`), a Bounded
           Context Map rule/edge/prohibition (`E-nn`, `ID-n`, `X-nn`, `F-n`,
           `L1`-`L5`), an architecture ruling (`AR-n`), or an ADR.

  DERIVED  It cites another PRD-004 identifier that is itself traced
           (transitively).  A requirement may legitimately be a refinement of
           another requirement in the same document; an acceptance criterion
           legitimately verifies a requirement rather than a ranked document.

Section-scope inheritance is allowed because the PRD uses it deliberately: the
§8.2 preamble establishes `LIB-4.1` / `AUTH-7.21` / `TR-1`-`TR-5` for every
`SM-PO-*` row in the table beneath it, rather than repeating the citation
twelve times.

An internal-only citation chain that never reaches an external source does NOT
count.  A document cannot be its own authority.

`SM-GAP-*` are excluded from the denominator: a proposed gap carries no source
BY DEFINITION -- that is what makes it a gap.

RE-RUN
------
    python3 tool/docs_check/prd004_traceability.py

Exit code 0 = every non-gap identifier is traced at some tier.
Exit code 1 = at least one identifier is untraced (it should be corrected, or
              declared as a proposed gap).
"""

import collections
import re
import sys

PRD = 'docs/30-product/student-management/Student_Management_PRD_v1.md'

# --- The ten registers declared in PRD-004 §0 -------------------------------
REGISTERS = [
    ('SM-c.n', re.compile(r'^SM-\d+\.\d+$')),
    ('SM-BR-n', re.compile(r'^SM-BR-\d+$')),
    ('SM-XC-n', re.compile(r'^SM-XC-\d+$')),
    ('SM-INV-n', re.compile(r'^SM-INV-\d+$')),
    ('SM-EV-n', re.compile(r'^SM-EV-\d+$')),
    ('SM-PO-n', re.compile(r'^SM-PO-\d+$')),
    ('SM-AC-n', re.compile(r'^SM-AC-\d+$')),
    ('SMCFG-n', re.compile(r'^SMCFG-\d+$')),
    ('LMD-n', re.compile(r'^LMD-\d+$')),
    ('SM-GAP-n', re.compile(r'^SM-GAP-\d+$')),
]
REGISTER_ORDER = [name for name, _ in REGISTERS]

# --- External authoritative sources ONLY ------------------------------------
EXTERNAL = re.compile('|'.join([
    r'MP-[A-Z]+-\d+',          # Master PRD global rules / assumptions
    r'Master PRD',
    r'SID-\d+\.\d+', r'SID-[A-Z]+-\d+', r'SID-\d+\.\d+',
    r'LIB-\d+\.\d+',
    r'AUTH-\d+\.\d+',
    r'\bAR-\d+\b',             # Architecture rulings
    r'ADR-\d{4}',
    r'\bE-\d{2}\b',            # BC Map integration edges
    r'\bID-\d\b',              # BC Map identity linkage rules
    r'\bX-\d{2}\b',            # BC Map prohibitions
    r'\bF-\d\b',               # BC Map capability rules
    r'\bL[1-5]\b',             # Dependency laws
    r'BC Map',
    r'\bAP-\d\b',              # Architecture principles
    r'\bCFG-\d+\b', r'\bLCFG-\d+\b',
    r'\bTR-[1-5]\b',           # Closed role set (Authentication PRD)
    r'\bPRD-0\d\d\b',
    r'\b14[AB]\b',
    r'Student_Identity_PRD',
]))

# --- Internal PRD-004 identifiers ------------------------------------------
INTERNAL = re.compile(
    r'`(SM-BR-\d+|SM-XC-\d+|SM-INV-\d+|SM-EV-\d+|SM-PO-\d+|SM-AC-\d+'
    r'|SM-GAP-\d+|SMCFG-\d+|LMD-\d+|SM-\d+\.\d+)`'
)

PROSE_DEF = re.compile(r'^`([A-Z][A-Za-z0-9.\-]*)`\s+—')
TABLE_DEF = re.compile(r'^\|\s*`([A-Z][A-Za-z0-9.\-]*)`\s*\|')
HEADING = re.compile(r'^#{2,4}\s')


def register_of(ident):
    for name, rx in REGISTERS:
        if rx.match(ident):
            return name
    return None


def collect(lines):
    """Return {ident: (line_no, register, own_text, section_preamble)}."""
    # Section 0 declares the registers; its rows are not definitions.
    body_start = next((i for i, l in enumerate(lines)
                       if l.startswith('## 1.')), 0)

    # Build, for every line, the preamble text of the section it sits in.
    preamble = [''] * len(lines)
    buf = []
    for i, line in enumerate(lines):
        if HEADING.match(line):
            buf = []
        elif len(buf) < 8 and line.strip() and not line.startswith('|'):
            buf.append(line)
        preamble[i] = ' '.join(buf)

    found = {}
    for i, line in enumerate(lines):
        if i < body_start:
            continue
        m = PROSE_DEF.match(line) or TABLE_DEF.match(line)
        if not m:
            continue
        ident = m.group(1)
        reg = register_of(ident)
        if reg is None or ident in found:
            continue
        # A prose requirement may wrap onto continuation lines.
        text = line
        if PROSE_DEF.match(line):
            for nxt in lines[i + 1:i + 5]:
                if (not nxt.strip() or PROSE_DEF.match(nxt)
                        or nxt.startswith(('#', '|', '>'))):
                    break
                text += ' ' + nxt
        found[ident] = (i + 1, reg, text, preamble[i])
    return found


def main():
    try:
        lines = open(PRD, encoding='utf-8').read().split('\n')
    except FileNotFoundError:
        print(f'FATAL: {PRD} not found', file=sys.stderr)
        return 2

    found = collect(lines)

    # ---- Tier 1: DIRECT -------------------------------------------------
    direct, refs = {}, {}
    for ident, (ln, reg, text, pre) in found.items():
        own = sorted(set(EXTERNAL.findall(text)))
        inherited = sorted(set(EXTERNAL.findall(pre)))
        direct[ident] = bool(own) or bool(inherited)
        refs[ident] = {r for r in INTERNAL.findall(text)
                       if r != ident and r in found}

    # A proposed gap carries no source by definition.
    for ident in found:
        if found[ident][1] == 'SM-GAP-n':
            direct[ident] = False

    # ---- Tier 2: DERIVED (transitive closure) ---------------------------
    traced = {i: ('DIRECT' if direct[i] else None) for i in found}
    changed = True
    while changed:
        changed = False
        for ident in found:
            if traced[ident] or found[ident][1] == 'SM-GAP-n':
                continue
            for r in refs[ident]:
                if traced.get(r):
                    traced[ident] = 'DERIVED'
                    changed = True
                    break

    # ---- Report ---------------------------------------------------------
    by_reg = collections.defaultdict(list)
    for ident, (ln, reg, _, _) in found.items():
        by_reg[reg].append((ident, ln, traced[ident]))

    print('=' * 74)
    print('PRD-004 TRACEABILITY — recalculated per identifier')
    print('=' * 74)
    print(f"{'Register':<10}{'Found':>7}{'Direct':>8}{'Derived':>9}"
          f"{'Untraced':>10}")
    print('-' * 74)

    tot = d_tot = v_tot = 0
    gaps = 0
    untraced = []
    for reg in REGISTER_ORDER:
        rows = sorted(by_reg.get(reg, []), key=lambda r: r[1])
        n = len(rows)
        tot += n
        if reg == 'SM-GAP-n':
            gaps = n
            print(f'{reg:<10}{n:>7}{"—":>8}{"—":>9}{"—":>10}'
                  f'   proposed gaps: no source by definition')
            continue
        dn = sum(1 for _, _, t in rows if t == 'DIRECT')
        vn = sum(1 for _, _, t in rows if t == 'DERIVED')
        un = [r for r in rows if r[2] is None]
        d_tot += dn
        v_tot += vn
        untraced += un
        print(f'{reg:<10}{n:>7}{dn:>8}{vn:>9}{len(un):>10}')

    denom = tot - gaps
    print('-' * 74)
    print(f'{"TOTAL":<10}{tot:>7}{d_tot:>8}{v_tot:>9}{len(untraced):>10}')
    print()
    print(f'Identifiers located in the PRD      : {tot}')
    print(f'Proposed gaps (SM-GAP-*, excluded)  : {gaps}')
    print(f'Denominator — real requirements     : {denom}')
    print(f'  traced DIRECT  (external source)  : {d_tot}')
    print(f'  traced DERIVED (via a traced req) : {v_tot}')
    print(f'  UNTRACED                          : {len(untraced)}')
    if denom:
        pct = 100.0 * (d_tot + v_tot) / denom
        print(f'Coverage                            : '
              f'{d_tot + v_tot}/{denom} = {pct:.1f}%')
    print()

    if untraced:
        print('UNTRACED — no external source, and no chain to a traced '
              'requirement:')
        for ident, ln, _ in sorted(untraced, key=lambda r: r[1]):
            print(f'  line {ln:>4}  {ident}')
        print()
        print('Each must either gain a citation or be declared a proposed gap.')
        return 1

    print('RESULT: every non-gap identifier is traced at DIRECT or DERIVED '
          'tier.')
    return 0


if __name__ == '__main__':
    sys.exit(main())
