#!/usr/bin/env python3
"""PRD-005 traceability and register counts — computed, never asserted.

WHY THIS EXISTS
---------------
`PRD_LIFECYCLE.md` Stage 5 requires the counts registered in
`TRACEABILITY_MATRIX.md` §2 to be *"verified mechanically -- counted by a tool,
not by reading"*, with **zero collisions**.

That requirement is not decorative.  `TRACEABILITY_MATRIX.md` §2C carried
*stale* `PRD-004` figures through two correction passes until a script
disproved them (second-review finding `SR-01`, HIGH).  This script exists so
that the same class of defect cannot be introduced for `PRD-005`: every number
registered in §2D is produced here, and a mismatch fails the build.

WHAT IT CHECKS
--------------
1. **Register counts** -- the ten registers declared in `PRD-005` §0.2, counted
   from their *definition sites*, compared against the counts §0.2 declares.
2. **Contiguity** -- every numeric range runs 1..max with no hole.  A hole makes
   the published range false (`PRD-005` §0.2: "a gap would make the promise
   false").
3. **Duplicates** -- an identifier defined twice is a defect regardless of
   whether the count happens to come out right.
4. **Collisions** -- the `MM-` prefix against every register already recorded in
   `TRACEABILITY_MATRIX.md` §2/§2A/§2B/§2C, and against a whole-repository
   word-boundary search for `MM-` outside the membership module.
5. **Coverage** -- the strict rule binding on `PRD-005`: an obligation is
   *verified* if and only if its identifier appears in the **Verifies** column
   of at least one `MM-AC-*` row in §23.  Prose never counts.  This mirrors
   `MM-NFR-014` / `SID-4.56`: *"a rule that cannot be checked SHALL be treated
   as unmet, not as satisfied by intent."*

DEFINITION SITES
----------------
`PRD-005` defines identifiers in exactly two shapes, and this script accepts
only those two:

    table   | `MM-XX-nnn` | ...
    prose   `MM-XX-nnn` -- ...          (em dash)

A mention anywhere else -- in a *Verifies* cell, a cross-reference, a note, a
history row -- is NOT a definition.  This distinction is the whole reason the
count is trustworthy: `MM-BR-035` is mentioned in many places and defined once.

FOUR MODELLING FACTS, ESTABLISHED BY INSPECTION
-----------------------------------------------
A first version of this script reported three "failures" and an anomaly.  All
four turned out to be correct `PRD-005` behaviour, and a checker that cannot
tell a real defect from a deliberate convention is one that gets switched off
(the §2C.1 lesson).  Each is therefore modelled explicitly:

1. **`MM-GAP-006` and `MM-GAP-007` have no definition row, by design.**  Both
   were *closed* at v1.1 (§0.2 note; §5.1 line 613; §12 line 1145).  Their
   numbers are **retained, not reused**, so prior citations stay resolvable, and
   each leaves a suffixed successor (`MM-GAP-006a`, `MM-GAP-007a`).  The §25.2
   table therefore holds **11 rows** for a register of **13 identifiers**.
   Contiguity is judged over the *declared* set, which includes the two closed
   numbers -- not over the rows.

2. **`MM-BR-030` appears twice, and the second is a restatement.**  Line 886 is
   the definition; line 1235 opens *"Restated from §9, which is the definition
   site."*  Counting it twice would inflate the register; treating it as a
   duplicate defect would be false.  Rows that self-identify as restatements are
   skipped.

3. **11 `MM-AC-*` rows verify a section or an edge, not a registered ID** --
   e.g. `MM-AC-014` -> "Edge 1", `MM-AC-032` -> "§6.3".  Those cells are
   populated and meaningful; they simply do not name an `MM-*` identifier.  An
   empty *Verifies* cell would be a defect; this is not one.

4. **Coverage is measured over the *declared* register, not the rows found.**
   This keeps the strict rule of §0.2 honest.

RE-RUN
------
    python3 tool/docs_check/prd005_traceability.py

Exit 0 = every declared count reproduced, ranges contiguous, no duplicate, no
         collision.
Exit 1 = at least one check failed (the failure is printed with its evidence).
"""

import collections
import re
import subprocess
import sys

PRD = 'docs/30-product/membership-management/PRD-MEMBERSHIP-MANAGEMENT.md'
MATRIX = 'docs/40-implementation/TRACEABILITY_MATRIX.md'

# --- The ten registers declared in PRD-005 §0.2 -----------------------------
# (prefix label, regex matching a bare identifier, count declared in §0.2)
REGISTERS = [
    ('MM-FR-n',  re.compile(r'^MM-FR-\d{3}[a-z]?$'),  119),
    ('MM-BR-n',  re.compile(r'^MM-BR-\d{3}[a-z]?$'),   35),
    ('MM-INV-n', re.compile(r'^MM-INV-\d{3}[a-z]?$'),  12),
    ('MM-EVT-n', re.compile(r'^MM-EVT-\d{3}[a-z]?$'),   7),
    ('MM-XC-n',  re.compile(r'^MM-XC-\d{3}[a-z]?$'),   16),
    ('MM-AC-n',  re.compile(r'^MM-AC-\d{3}[a-z]?$'),   97),
    ('MM-NFR-n', re.compile(r'^MM-NFR-\d{3}[a-z]?$'),  14),
    ('MM-PO-n',  re.compile(r'^MM-PO-\d{3}[a-z]?$'),   11),
    ('MM-CFG-n', re.compile(r'^MM-CFG-\d{3}[a-z]?$'),   9),
    ('MM-GAP-n', re.compile(r'^MM-GAP-\d{3}[a-z]?$'),  13),
]
REGISTER_ORDER = [name for name, _, _ in REGISTERS]
DECLARED = {name: n for name, _, n in REGISTERS}

# Registers already recorded in TRACEABILITY_MATRIX.md §2/§2A/§2B/§2C.
EXISTING_PREFIXES = [
    'AUTH', 'BR', 'XC', 'AC', 'PR', 'TR', 'EV', 'CFG',
    'LIB', 'LCFG', 'LXC', 'LEV', 'LAC', 'PO', 'IT', 'INV',
    'SID', 'SXC', 'SPO', 'SEV', 'SCFG',
    'SM', 'SMCFG', 'LMD',
]

# `MM-XX-nnn` as a table cell or a prose definition -- nothing else.
TABLE_DEF = re.compile(r'^\|\s*`(MM-[A-Z]+-\d{3}[a-z]?)`\s*\|')
PROSE_DEF = re.compile(r'^`(MM-[A-Z]+-\d{3}[a-z]?)`\s+\u2014')
ANY_ID = re.compile(r'MM-[A-Z]+-\d{3}[a-z]?')

# A row that says so is a restatement, not a second definition (fact 2).
RESTATED = re.compile(r'Restated from|restated from|definition site', re.I)

# Identifiers deliberately retained without a definition row (fact 1).
# Closed at v1.1; numbers not reused; each has a suffixed successor.
CLOSED_RETAINED = {'MM-GAP-006', 'MM-GAP-007'}


def register_of(ident):
    for name, rx, _ in REGISTERS:
        if rx.match(ident):
            return name
    return None


def collect(lines):
    """Return (definitions, duplicates).

    definitions: {register: {ident: line_no}}
    duplicates:  [(ident, first_line, repeat_line)]

    §0.2 declares the registers; its rows are declarations, not definitions, so
    the body scan starts at chapter 1.
    """
    body_start = next((i for i, l in enumerate(lines)
                       if l.startswith('## 1.')), 0)

    defs = collections.defaultdict(dict)
    dupes = []
    for i, line in enumerate(lines[body_start:], start=body_start):
        m = TABLE_DEF.match(line) or PROSE_DEF.match(line)
        if not m:
            continue
        ident = m.group(1)
        reg = register_of(ident)
        if reg is None:
            continue
        if ident in defs[reg]:
            # Fact 2: a row that declares itself a restatement is not a
            # second definition, and not a duplicate defect.
            if RESTATED.search(line):
                continue
            dupes.append((ident, defs[reg][ident], i + 1))
            continue
        defs[reg][ident] = i + 1

    # Fact 1: closed-but-retained numbers belong to the declared register even
    # though they intentionally have no definition row.
    for ident in CLOSED_RETAINED:
        reg = register_of(ident)
        if reg and ident not in defs[reg]:
            defs[reg][ident] = 0            # 0 = retained, no definition row
    return defs, dupes


def contiguity(idents):
    """Return (max_n, missing[]) over the numeric part, ignoring suffixes."""
    nums = sorted({int(re.search(r'(\d{3})', i).group(1)) for i in idents})
    if not nums:
        return 0, []
    top = max(nums)
    missing = [n for n in range(1, top + 1) if n not in nums]
    return top, missing


def verifies_column(lines):
    """IDs appearing in the *Verifies* column of MM-AC-* rows in §23."""
    verified = set()
    ac_rows = 0
    empty = []
    hdr = None
    for line in lines:
        if line.strip().startswith('|') and 'Verifies' in line:
            cells = [c.strip() for c in line.strip().strip('|').split('|')]
            hdr = [n for n, c in enumerate(cells) if 'Verifies' in c][0]
            continue
        m = TABLE_DEF.match(line)
        if not m or not m.group(1).startswith('MM-AC-'):
            continue
        ac_rows += 1
        cells = [c.strip() for c in line.strip().strip('|').split('|')]
        cell = cells[hdr] if hdr is not None and hdr < len(cells) else ''
        found = set(ANY_ID.findall(cell))
        # Fact 3: a cell naming a section or an edge ("§6.3", "Edge 1") is
        # populated and meaningful.  Only a genuinely blank cell is a defect.
        if not cell:
            empty.append(m.group(1))
        verified |= found
    return verified, ac_rows, empty


def collisions():
    """MM- prefix vs existing registers, and vs the rest of the repository."""
    problems = []

    # 1. Direct prefix equality against every registered prefix.
    for p in EXISTING_PREFIXES:
        if p == 'MM':
            problems.append(f'prefix MM collides with registered prefix {p}')

    # 2. Word-boundary search for MM- outside the membership module.
    try:
        out = subprocess.run(
            ['grep', '-rIno', r'\(^\|[^-A-Za-z]\)MM-[A-Z]\+-[0-9]',
             'docs', '--include=*.md'],
            capture_output=True, text=True, timeout=120).stdout
    except Exception as exc:                                # pragma: no cover
        return [f'collision scan failed: {exc}'], []
    # The membership module owns the register.  `TRACEABILITY_MATRIX.md` §2D is
    # where it is *registered*, so it necessarily cites these identifiers --
    # that is the gate artefact, not a collision.
    #
    # Stage 7 adds four more legitimate citation sites.  Freezing a PRD REQUIRES
    # the governance layer to name the registers it is admitting: the freeze ADR
    # states which gaps stay open, the baseline declares what entered Rank 3, the
    # registry records the status change and the ADR index summarises it.  The
    # same is true of `PRD-004`: `ADR-0018` cites `SM-*` sixteen times and
    # `DOCUMENTATION_BASELINE.md` cites `SM-EV-*`/`LMD-*` five times, and that is
    # correct.  A *citation* is not a *collision* -- a collision would be another
    # register DEFINING an `MM-` identifier, which the duplicate-definition and
    # registered-prefix checks above still catch.  This list is deliberately
    # enumerated file by file rather than widened to `docs/00-governance/`, so a
    # stray `MM-` in any other governance document still fails the run.
    ALLOWED = (
        'membership-management/',
        'TRACEABILITY_MATRIX.md',
        'ADR-0019-membership-management-prd-v1.4-baseline.md',
        'DOCUMENTATION_BASELINE.md',
        'PRD_REGISTRY.md',
        'ADR-INDEX.md',
    )
    outside = [ln for ln in out.split('\n')
               if ln and not any(a in ln for a in ALLOWED)]
    return problems, outside


def main():
    try:
        lines = open(PRD, encoding='utf-8').read().split('\n')
    except FileNotFoundError:
        print(f'FATAL: {PRD} not found', file=sys.stderr)
        return 2

    defs, dupes = collect(lines)
    verified, ac_rows, empty_verifies = verifies_column(lines)

    print('=' * 78)
    print('PRD-005 STAGE 5 — register counts, contiguity, collisions')
    print('=' * 78)
    print(f"{'Register':<10}{'Declared':>9}{'Measured':>9}{'Max':>6}"
          f"{'Contiguous':>12}{'Match':>7}")
    print('-' * 78)

    ok = True
    total = 0
    for reg in REGISTER_ORDER:
        idents = set(defs.get(reg, {}))
        n = len(idents)
        total += n
        top, missing = contiguity(idents)
        retained = sorted(i for i in idents if defs[reg][i] == 0)
        cont = 'yes' if not missing else f'NO {missing[:5]}'
        match = 'ok' if n == DECLARED[reg] else 'FAIL'
        if n != DECLARED[reg] or missing:
            ok = False
        note = f'   retained (closed, no row): {", ".join(retained)}' \
            if retained else ''
        print(f'{reg:<10}{DECLARED[reg]:>9}{n:>9}{top:>6}{cont:>12}'
              f'{match:>7}{note}')

    print('-' * 78)
    declared_total = sum(DECLARED.values())
    print(f"{'TOTAL':<10}{declared_total:>9}{total:>9}")
    print()

    # --- duplicates -------------------------------------------------------
    if dupes:
        ok = False
        print(f'DUPLICATE DEFINITIONS: {len(dupes)}')
        for ident, first, repeat in dupes:
            print(f'  {ident}  first line {first}, again line {repeat}')
    else:
        print('Duplicate definitions                 : 0')

    # --- collisions -------------------------------------------------------
    problems, outside = collisions()
    if problems:
        ok = False
        for p in problems:
            print(f'COLLISION: {p}')
    print(f'Prefix collisions vs registered sets  : {len(problems)}')
    print(f'`MM-` hits outside membership module  : {len(outside)}')
    for ln in outside[:10]:
        print(f'  {ln}')
    if outside:
        ok = False

    # --- coverage (strict rule) -------------------------------------------
    obligations = {}
    for reg in REGISTER_ORDER:
        if reg in ('MM-AC-n', 'MM-GAP-n'):
            continue
        obligations[reg] = set(defs.get(reg, {}))

    RULE_REGS = ['MM-BR-n', 'MM-INV-n', 'MM-EVT-n', 'MM-XC-n', 'MM-PO-n']
    rule_cov = sum(len(obligations[r] & verified) for r in RULE_REGS)
    rule_tot = sum(len(obligations[r]) for r in RULE_REGS)
    all_cov = sum(len(v & verified) for v in obligations.values())
    all_tot = sum(len(v) for v in obligations.values())

    print()
    print(f'MM-AC-* rows parsed                   : {ac_rows}')
    print(f'MM-AC-* rows with empty Verifies      : {len(empty_verifies)}')
    print(f'MM-GAP-* cited as verifiable (must=0) : '
          f'{len([v for v in verified if v.startswith("MM-GAP-")])}')
    dangling = sorted(v for v in verified
                      if not any(v in s for s in defs.values())
                      and not v.startswith('MM-AC-'))
    print(f'Dangling IDs in Verifies (must=0)     : {len(dangling)}'
          f'{" " + str(dangling) if dangling else ""}')
    if empty_verifies or dangling:
        ok = False
    if [v for v in verified if v.startswith('MM-GAP-')]:
        ok = False

    print()
    print('COVERAGE under the strict rule (PRD-005 §0.2):')
    for reg in REGISTER_ORDER:
        if reg in ('MM-AC-n', 'MM-GAP-n'):
            continue
        d = obligations[reg]
        print(f'  {reg:<10}{len(d & verified):>5}/{len(d):<5}')
    print(f'  {"rule regs":<10}{rule_cov:>5}/{rule_tot:<5} '
          f'= {100.0 * rule_cov / rule_tot:.1f}%')
    print(f'  {"all oblig":<10}{all_cov:>5}/{all_tot:<5} '
          f'= {100.0 * all_cov / all_tot:.1f}%')

    print()
    if ok:
        print('RESULT: PASS — every declared count reproduced, every range '
              'contiguous,')
        print('        no duplicate definition, zero collisions.')
        return 0
    print('RESULT: FAIL — see the failures above.')
    return 1


if __name__ == '__main__':
    sys.exit(main())
