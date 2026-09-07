#!/usr/bin/env python3
"""PRD-013 internal traceability -- does the PRD agree with itself?

WHY THIS EXISTS
---------------
`PRD_LIFECYCLE.md` Stage 5 demands counts and ranges "verified mechanically",
and `TRACEABILITY_MATRIX.md` section 2H records the reason a one-off script is
not enough:

    "A number computed once is not a number verified mechanically on every
     commit."

This script is the first of the two the `PRD-008` pattern requires.  It checks
`PRD-013_TENANCY.md` against **itself** -- section 0.2's declared classes and
counts against the identifiers actually defined in the body -- and it **never
opens `TRACEABILITY_MATRIX.md`**.  That separation is deliberate and copied
from `prd008_traceability.py`: if one script both wrote the register and
checked it, it would verify agreement with itself.  `prd013_stage5.py` is the
second script and checks the matrix against this same computation.

THE CONCEPT PRD-008 DID NOT NEED: RETIRED IDENTIFIERS
-----------------------------------------------------
`PRD-013` section 9 retires **12** identifiers permanently.  Five of its eight
registers therefore contain holes: `TEN-FR` skips 012/016/017, `TEN-BR` skips
002/003, `TEN-INV` skips 003..005, `TEN-AC` skips 003..005, and `TEN-CFG-001`
is retired leaving that register with no member in force at all.

A naive contiguity test over the **in-force** set fails five registers.  That
would be the wrong answer, and the matrix already says why -- section 2D.2,
where `MM-GAP-006`/`007` have no definition row:

    "Their numbers are retained, not reused, so citations written against them
     stay resolvable ... Contiguity is judged over the declared set, so
     MM-GAP-001..010 is contiguous."

So this script computes three sets per register -- in force, retired, declared
(their union) -- and judges contiguity over **declared**, exactly as section
2D.2 directs.  It also enforces the rule that makes that safe: a retired
number must never appear as an in-force definition (`PRD_LIFECYCLE.md` Stage 6
rule 1, "Never reuse or reassign a number").

WHAT IT CHECKS
--------------
1. Section 0.2 exists and declares classes A, B and C with subtotals.
2. Every register defined in the body is declared in section 0.2, and every
   count in section 0.2 matches the count computed from the body.
3. Every range is contiguous 1..max over the DECLARED set (section 2D.2).
4. `in_force + retired == declared` for every register, and no retired number
   is also defined in force -- the reuse prohibition, tested not assumed.
5. Zero dangling citations: every `TEN-*` cited anywhere in the PRD resolves
   to either an in-force definition or a retired entry.
6. Zero orphan acceptance criteria: every `TEN-AC-*` maps to at least one
   obligation.  Range notation (`TEN-XC-001`..`006`) is expanded, because a
   literal per-identifier match cannot resolve a range and would under-report
   -- the practice frozen `PRD-007` already uses (`SEAT-AC-166` maps via
   `SEAT-EVT-001`..`004`).
7. `TEN-CFG-*` is reported as DECLARED EMPTY, never silently skipped.  Rank 7
   `CONFIGURATION_GUIDE.md` defines no tenancy parameter, so publishing a
   configurable would be the unbounded-configuration hole Stage 4 check 3
   forbids.  An empty register is a finding to state, not a gap to hide.

Exit 0 = the PRD agrees with itself.  Exit 1 = it does not.
"""

import os
import re
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
MODULE_DIR = os.path.join('docs', '30-product', 'tenancy')
DOC = os.path.join(MODULE_DIR, 'PRD-013_TENANCY.md')

ORDER = ['FR', 'BR', 'INV', 'EVT', 'XC', 'CFG', 'AC', 'GAP']
OBLIGATION = ['FR', 'BR', 'INV', 'EVT', 'XC']

PROBLEMS = []


def fail(message):
    PROBLEMS.append(message)


def read(path):
    with open(os.path.join(ROOT, path), encoding='utf-8') as handle:
        return handle.read()


def definition_sites(text, exclude_retired_register=False):
    """prefix -> sorted ints, counted from definition sites only.

    Deliberately identical to prd008_traceability.py's rule -- a line
    beginning with the backticked identifier, or a table row whose first cell
    is the identifier -- so the gates cannot disagree about what a definition
    is.  The `###` form is added because PRD-013 section 10 gives each
    `TEN-GAP-*` its own heading.

    `exclude_retired_register` drops section 9, which is what makes the
    reuse check possible.  Section 9's rows are themselves definition sites
    by the rule above, so a scan of the whole document cannot distinguish
    "defined in section 9 as retired" from "defined in the body as live".
    Computing in-force as (all definitions minus retired) hides a reuse
    perfectly: the reused number is subtracted by the very set that should
    have flagged it.  Excluding section 9 first means a retired number found
    in the remaining text is unambiguously a live redefinition.
    """
    if exclude_retired_register:
        block = section(text, '## 9. Retired identifiers')
        if block is not None:
            text = text.replace(block, '')
    found = {}
    for line in text.split('\n'):
        # A retirement NOTE is not a definition.  Sections 3 and 5.1 each open
        # a line with a retired identifier to say it is retired -- "`TEN-FR-012`
        # is **retired** (section 9): it restated this state machine".  By the
        # line-start rule that looks exactly like a definition, so without this
        # guard the reuse check reports the PRD's own retirement disclosures as
        # reuses.  The PRD is right and the coarse rule is wrong; a checker that
        # cannot tell a definition from a sentence about one is the kind that
        # gets switched off.
        if re.match(r'^`TEN-[A-Z]+-\d+` is (?:\*\*)?retired', line):
            continue
        match = re.match(r'^`TEN-([A-Z]+)-(\d+)`', line)
        if match is None:
            match = re.match(r'^\|\s*`TEN-([A-Z]+)-(\d+)`\s*\|', line)
        if match is None:
            match = re.match(r'^###\s+`TEN-([A-Z]+)-(\d+)`', line)
        if match is None:
            continue
        found.setdefault(match.group(1), set()).add(int(match.group(2)))
    return {key: sorted(value) for key, value in found.items()}


def section(text, heading):
    """Return the text of one '## ' section, or None."""
    start = text.find(heading)
    if start < 0:
        return None
    end = text.find('\n## ', start + len(heading))
    return text[start:end if end > 0 else len(text)]


def retired_sites(text):
    """prefix -> sorted ints, from section 9's FIRST CELL only.

    The first-cell restriction matters.  Section 9's "Retired because" column
    cites successor identifiers -- `TEN-BR-003` was withdrawn because it
    "Duplicated TEN-BR-001's subject" -- so a regex that scans the whole row
    harvests those citations and reports live requirements as retired.  That
    error inflates the retired set and deflates the in-force count.
    """
    block = section(text, '## 9. Retired identifiers')
    if block is None:
        fail('PRD-013 has no section 9 -- the retired-identifier register is '
             'missing, so contiguity over the declared set cannot be judged')
        return {}
    found = {}
    for line in block.split('\n'):
        match = re.match(r'^\|\s*`TEN-([A-Z]+)-(\d+)`\s*\|', line)
        if match:
            found.setdefault(match.group(1), set()).add(int(match.group(2)))
    return {key: sorted(value) for key, value in found.items()}


def declared_rows(text):
    """prefix -> declared count, summed over section 0.2's class rows.

    Section 0.2 splits a register across several rows when retirements
    interrupt it -- `TEN-FR` occupies three rows (001..011, 013..015,
    018..021) because 012, 016 and 017 are retired.  The declared count for a
    register is therefore the SUM of its rows, not the value in any one of
    them, and the parser must accept both the range form
    (`TEN-FR-001` ... `TEN-FR-011`) and the single form (`TEN-BR-001`).

    The count is column 3 of the row (Register | Range | Count | ...), not
    column 2; column 2 holds the word "contiguous" or "single".
    """
    block = section(text, '### 0.2')
    if block is None:
        block = section(text, '## 0.2')
    if block is None:
        fail('PRD-013 has no section 0.2 -- the Stage 2 gate requires the '
             'identifier registers "declared up front with ranges"')
        return {}
    out = {}
    row = re.compile(
        r'^\|\s*`TEN-([A-Z]+)-\d+`\s*(?:(?:\u2026|\.\.\.)\s*`TEN-[A-Z]+-\d+`\s*)?'
        r'\|[^|]*\|\s*\*\*(\d+)\*\*')
    for line in block.split('\n'):
        match = row.match(line)
        if match:
            out.setdefault(match.group(1), 0)
            out[match.group(1)] += int(match.group(2))
    return out


def expand_citations(cell):
    """All TEN-* ids in a mapping cell, expanding range notation."""
    ids = set()
    for match in re.finditer(
            r'`(TEN-[A-Z]+)-(\d+)`\s*(?:\u2026|\.\.\.|\u2013)\s*`?(\d+)`?', cell):
        for number in range(int(match.group(2)), int(match.group(3)) + 1):
            ids.add('%s-%03d' % (match.group(1), number))
    for match in re.finditer(r'`(TEN-[A-Z]+-\d+)`', cell):
        ids.add(match.group(1))
    return ids


def main():
    text = read(DOC)
    retired_all = retired_sites(text)
    # Live definitions are counted with section 9 EXCLUDED, so a retired
    # number appearing here is a genuine reuse rather than its own retirement
    # row.  See definition_sites().
    live = definition_sites(text, exclude_retired_register=True)
    in_force_all = definition_sites(text)

    in_force = {}
    for prefix in set(list(live) + list(retired_all)):
        retired = set(retired_all.get(prefix, []))
        in_force[prefix] = sorted(
            n for n in live.get(prefix, []) if n not in retired)

    declared = {}
    for prefix in set(list(in_force_all) + list(retired_all)):
        declared[prefix] = sorted(
            set(in_force_all.get(prefix, [])) | set(retired_all.get(prefix, [])))

    # --- check 3/4: contiguity over declared, and the arithmetic
    for prefix in sorted(declared):
        numbers = declared[prefix]
        if not numbers:
            continue
        expected = list(range(1, max(numbers) + 1))
        if numbers != expected:
            missing = sorted(set(expected) - set(numbers))
            fail('TEN-%s-* is NOT contiguous over the declared set: '
                 'missing %s (declared %d, max %d).  Section 2D.2 judges '
                 'contiguity over declared = in force + retired, so a hole '
                 'here means an identifier was dropped without retiring it'
                 % (prefix, ', '.join('%03d' % m for m in missing),
                    len(numbers), max(numbers)))
        overlap = set(live.get(prefix, [])) & set(retired_all.get(prefix, []))
        if overlap:
            fail('TEN-%s-* REUSES retired number(s) %s in force.  '
                 'PRD_LIFECYCLE.md Stage 6 rule 1: "Never reuse or reassign '
                 'a number"' % (prefix,
                                ', '.join('%03d' % o for o in sorted(overlap))))
        if len(in_force.get(prefix, [])) + len(retired_all.get(prefix, [])) \
                != len(numbers):
            fail('TEN-%s-*: in_force + retired != declared' % prefix)

    # --- check 2: section 0.2 declarations vs the body
    rows = declared_rows(text)
    for prefix in sorted(in_force):
        if not in_force[prefix]:
            continue
        if prefix not in rows:
            fail('TEN-%s-* is defined in the body but not declared in '
                 'section 0.2' % prefix)
        elif rows[prefix] != len(in_force[prefix]):
            fail('TEN-%s-*: section 0.2 declares %d, body defines %d in force'
                 % (prefix, rows[prefix], len(in_force[prefix])))

    # --- check 5: dangling citations
    defined_ids = set()
    for prefix, numbers in in_force_all.items():
        for number in numbers:
            defined_ids.add('TEN-%s-%03d' % (prefix, number))
    for prefix, numbers in retired_all.items():
        for number in numbers:
            defined_ids.add('TEN-%s-%03d' % (prefix, number))
    cited = set(re.findall(r'`(TEN-[A-Z]+-\d+)`', text))
    dangling = sorted(cited - defined_ids)
    if dangling:
        fail('%d dangling TEN-* citation(s) resolve to nothing: %s'
             % (len(dangling), ', '.join(dangling)))

    # --- check 6: orphan acceptance criteria + obligation coverage
    ac_block = section(text, '## 8.')
    obligations = set()
    for prefix in OBLIGATION:
        for number in in_force.get(prefix, []):
            obligations.add('TEN-%s-%03d' % (prefix, number))
    covered = set()
    orphans = []
    if ac_block is None:
        fail('PRD-013 has no section 8 -- the acceptance-criteria register')
    else:
        for line in ac_block.split('\n'):
            if not re.match(r'^\|\s*`TEN-AC-\d+`\s*\|', line):
                continue
            cells = [c.strip() for c in line.strip('|').split('|')]
            criterion = re.match(r'`(TEN-AC-\d+)`', cells[0]).group(1)
            mapped = expand_citations(cells[-1])
            resolved = mapped & obligations
            if not resolved:
                orphans.append(criterion)
            covered |= resolved
    if orphans:
        fail('%d orphan acceptance criterion/criteria verify no obligation: %s'
             % (len(orphans), ', '.join(orphans)))

    uncovered = sorted(obligations - covered)

    # ---------------- report ----------------
    line = '-' * 66
    print(line)
    print('PRD-013 Tenancy -- internal traceability (PRD vs itself)')
    print(line)
    for prefix in ORDER:
        force = in_force.get(prefix, [])
        retired = retired_all.get(prefix, [])
        decl = declared.get(prefix, [])
        if not decl:
            continue
        note = ''
        if not force:
            note = '  <- DECLARED EMPTY'
        print('  TEN-%-5s in force %-3d retired %-2d declared %-3d '
              'range 001..%03d%s'
              % (prefix + '-*', len(force), len(retired), len(decl),
                 max(decl), note))
    total_force = sum(len(v) for v in in_force.values())
    total_retired = sum(len(v) for v in retired_all.values())
    print(line)
    print('identifiers in force                     : %d' % total_force)
    print('identifiers retired (never reused)       : %d' % total_retired)
    print('declared set (in force + retired)        : %d'
          % (total_force + total_retired))
    print('obligation-bearing (FR+BR+INV+EVT+XC)    : %d' % len(obligations))
    print('obligations carrying a TEN-AC-*          : %d' % len(covered))
    print('coverage                                 : %.1f%%'
          % (100.0 * len(covered) / len(obligations) if obligations else 0.0))
    print('orphan criteria                          : %d' % len(orphans))
    print('dangling citations                       : %d' % len(dangling))
    print(line)
    if PROBLEMS:
        print('FAIL - %d problem(s):' % len(PROBLEMS))
        for problem in PROBLEMS:
            print('  * %s' % problem)
    else:
        print('PASS - PRD-013 agrees with itself: section 0.2 reproduces the')
        print('       body, every range contiguous over the declared set')
        print('       (section 2D.2), no retired number reused, zero orphan')
        print('       criteria, zero dangling citations.')
    if uncovered:
        print()
        print('DISCLOSED, not a failure - %d obligation(s) carry no '
              'acceptance' % len(uncovered))
        print('criterion: %s' % ', '.join(uncovered))
        print('  PRD-013 section 8 names these and states why: each is a')
        print('  structural or ownership statement verified by the module\'s')
        print('  shape rather than by a runtime assertion.  Stage 4 rated the')
        print('  equivalent shortfall LOW for PRD-007 (7 of 12 SEAT-NFR-*).')
        print('  This gate prints it on every run so it cannot decay into an')
        print('  unnoticed silence.')
    print(line)
    return 1 if PROBLEMS else 0


if __name__ == '__main__':
    sys.exit(main())
