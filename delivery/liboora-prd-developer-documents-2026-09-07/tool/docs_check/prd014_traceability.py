#!/usr/bin/env python3
"""PRD-014 internal traceability -- does the PRD agree with itself?

WHY THIS EXISTS
---------------
`PRD_LIFECYCLE.md` Stage 5 demands counts and ranges "verified mechanically",
and `TRACEABILITY_MATRIX.md` section 2H records why a one-off script is not
enough:

    "A number computed once is not a number verified mechanically on every
     commit."

This is the first of the two scripts the `PRD-008` pattern requires
(`prd008_traceability.py` plus `prd008_stage5.py`, repeated for `PRD-013` and
`PRD-016`).  It checks `PRD-014_ENTITLEMENT.md` against **itself** -- section
0.2's declared registers and counts against the identifiers actually defined in
the body -- and it **never opens `TRACEABILITY_MATRIX.md`**.  `prd014_stage5.py`
is the second script and checks the matrix against an independent
recomputation.  If one script both wrote the register and checked it, it would
verify agreement with itself; that failure mode is named in section 2H.2 and is
structurally avoided here.

WHERE THE PRD-016 INSTRUMENT COULD NOT BE REUSED
------------------------------------------------
`prd016_traceability.py` was NOT copied.  Its `ORDER`, `CLASS_A` and
`EMPTY_BY_DESIGN` lists happen to be identical for this module, but its
section-0.2 parser is wrong for this document, and that difference is recorded
rather than silently accommodated.

    PRD-016 section 0.2 row:  | `AUD-FR-001` ... `AUD-FR-016` | contiguous | **16** | ...
                              ^ cell 0 is the RANGE SPAN, count in cell 2

    PRD-014 section 0.2 row:  | `ENT-FR-` | Functional requirement | **28** | `ENT-FR-001` ... `ENT-FR-028` | Yes |
                              ^ cell 0 is the BARE PREFIX, count in cell 2, range in cell 3

Running the inherited parser against this document yields **zero** declared
registers -- every register would be reported "defined in the body but NOT
declared in section 0.2", i.e. a catastrophic false FAIL against a correct
document.  This is the same hazard class `prd016_traceability.py` records for
bold-wrapped definitions, recurring one layer up: an instrument inherited
across documents encodes the previous document's layout, not the rule.  Recorded
as finding `S5-C-01` of the Stage 5 conferral record.

    The rule is changed to match the document.  The document is NOT changed to
    match the tool -- the direction `PRD-013_STAGE5_CONFERRAL.md` section 3.2
    records as correct.

The parser below therefore accepts BOTH shapes, so it stays honest if a future
register is published in either form, and it fails loudly if a row is parsable
in neither.

WHAT ELSE DIFFERS FROM PRD-016
------------------------------
1. NO REVERSE-COVERAGE PARAGRAPH.  `PRD-016` names its uncovered obligations in
   a prose paragraph containing the words "Reverse coverage".  `PRD-014` names
   them in a two-column TABLE in section 10.1 ("Uncovered | Why no criterion
   can be written yet").  Check 8 reads the table, and fails if neither shape is
   present -- a guard that matches nothing would pass vacuously.

2. ACCEPTANCE CRITERIA ARE IN SECTION 10, not section 9.

3. SECTION NUMBERING IS OFFSET.  `PRD-014` carries a section 7.1 edge
   inventory and a section 13 code-contradiction table that `PRD-016` does not,
   so no section index is hardcoded beyond the two headings named above.

WHAT PRD-013 HAD AND THIS MODULE DOES NOT
-----------------------------------------
`PRD-013` retires 12 identifiers, so contiguity there is judged over the
DECLARED set (in force + retired) per section 2D.2.  `PRD-014` retires
**nothing** -- section 0.2 states "No identifier is retired; none has ever been
issued before."  Declared therefore equals in force, and check 4 proves that
rather than assuming it: if a retirement section ever appears, the check fails
loudly instead of silently changing meaning.

THE SUBSTRING HAZARD THIS MODULE CARRIES AND PRD-016 DID NOT
------------------------------------------------------------
`INV-1`...`INV-16` are **platform invariants** registered at
`TRACEABILITY_MATRIX.md` L82, and `INV-SEC-*` / `INV-XC-*` also exist.  A bare
`grep 'INV-'` over this document over-counts by matching `ENT-INV-*`.  Every
pattern in this file is therefore anchored on the full `ENT-` prefix, never on
a register stem alone.  The PRD registers the hazard itself, at section 0.4.

WHAT IT CHECKS
--------------
1. Section 0.2 exists and declares classes A, B and C.
2. Every register defined in the body is declared in section 0.2 with a
   matching count and range maximum.
3. Every range is contiguous 1..max.
4. No retirement register exists, so declared == in force (asserted, not
   assumed), and no number is defined twice at two different sites.
5. Zero dangling citations: every `ENT-*` cited anywhere in the PRD resolves
   to a definition.
6. Zero orphan acceptance criteria: every `ENT-AC-*` traces to at least one
   Class A obligation, with ellipsis ranges expanded.
7. `ENT-EVT-*` and `ENT-CFG-*` are reported as DECLARED EMPTY, never silently
   skipped.  An empty register is a finding to state, not a hole to hide.
8. Reverse coverage is computed, and the PRD's own named list of uncovered
   obligations must agree with the computation.
9. The totals sentence in section 0.2 must agree with the computed totals --
   88 identifiers, 8 registers, 2 empty, 54 obligation-bearing.

Exit 0 = the PRD agrees with itself.  Exit 1 = it does not.
"""

import os
import re
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DOC = os.path.join('docs', '30-product', 'entitlement', 'PRD-014_ENTITLEMENT.md')

# Declaration order in section 0.2: Class A, then Class B, then Class C.
ORDER = ['FR', 'BR', 'INV', 'EVT', 'XC', 'CFG', 'AC', 'GAP']
CLASS_A = ['FR', 'BR', 'INV', 'EVT', 'XC']
EMPTY_BY_DESIGN = ['EVT', 'CFG']

# Section 0.2's published totals sentence, checked rather than trusted.
EXPECTED_TOTAL = 88
EXPECTED_REGISTERS = 8
EXPECTED_EMPTY = 2
EXPECTED_OBLIGATIONS = 54

PROBLEMS = []


def fail(message):
    PROBLEMS.append(message)


def read(path):
    with open(os.path.join(ROOT, path), encoding='utf-8') as handle:
        return handle.read()


def section(text, heading):
    """Text from `heading` to the next heading at the same or shallower depth."""
    start = text.find(heading)
    if start < 0:
        return None
    depth = len(heading) - len(heading.lstrip('#'))
    rest = text[start + len(heading):]
    best = len(rest)
    for level in range(1, depth + 1):
        marker = '\n' + '#' * level + ' '
        at = rest.find(marker)
        if 0 <= at < best:
            best = at
    return text[start:start + len(heading) + best]


# --- the definition rule -------------------------------------------------
# A definition is a line that OPENS with the identifier: bold prose, a table
# first cell, or a heading.
#   prose : a BOLD identifier, an em-dash, then normative text.  The em-dash is
#           load-bearing: it separates a definition from a sentence that merely
#           ENDS with an identifier.  PRD-014 has several of the latter -- e.g.
#           section 11 closes "recorded as `ENT-GAP-001` and `ENT-GAP-002`
#           rather than filled."
#   table : the identifier as the first cell, bold or plain.  This is how
#           `ENT-AC-*` and `ENT-GAP-*` are defined in this document.
#   heading : reserved.  PRD-014 uses none, but PRD-008 and PRD-013 do, so the
#           form is accepted rather than left silently unsupported.
DEF_PATTERNS = [
    r'^\*\*`ENT-([A-Z]+)-(\d+)`\*\*\s*(?:\u2014|--)\s*\S',
    r'^\|\s*\*{0,2}`ENT-([A-Z]+)-(\d+)`\*{0,2}\s*\|',
    r'^###\s+\*{0,2}`ENT-([A-Z]+)-(\d+)`',
]

# --- sections that CITE in a table's first cell without DEFINING -----------
# Found by this script FAILING against a correct document -- finding `S5-C-02`
# of the Stage 5 conferral record, and the same class as hazard 3 of
# `prd016_traceability.py` one structure up.
#
# Section 10.1's reverse-coverage table is:
#
#     | Uncovered | Why no criterion can be written yet |
#     | `ENT-FR-017` | Proving that *no caller needs a duplicate limit* is ... |
#
# The first cell is an identifier, so the inherited table rule counted
# `ENT-FR-017`, `ENT-FR-018` and `ENT-FR-026` as defined TWICE and failed the
# run with three phantom duplicate definitions.  PRD-016 never hit this because
# it names its uncovered obligations in PROSE; PRD-014 names them in a TABLE.
#
# The fix is positional, because the row form is genuinely indistinguishable
# from a definition: a register is defined in the section that owns it, and
# section 10.1 owns no register -- it is a measurement OF section 10.  Its lines
# are blanked for definition scanning only.  Citation scanning (check 5) still
# reads the whole document, so a dangling reference in 10.1 is still caught.
NON_DEFINING_SECTIONS = ['### 10.1 Coverage']


def definition_sites(text):
    """register -> {number: [line numbers]}, definition sites only.

    Line numbers are preserved against the ORIGINAL document, so a reported
    duplicate points at a real line.
    """
    lines = text.split('\n')
    masked = list(lines)
    for heading in NON_DEFINING_SECTIONS:
        block = section(text, heading)
        if block is None:
            fail('the non-defining section %r was not found. It is masked for '
                 'definition scanning, so a rename would silently restore the '
                 'phantom-duplicate failure it exists to suppress' % heading)
            continue
        first = text[:text.find(block)].count('\n')
        for offset in range(block.count('\n') + 1):
            if first + offset < len(masked):
                masked[first + offset] = ''

    found = {}
    for lineno, line in enumerate(masked, 1):
        for pattern in DEF_PATTERNS:
            match = re.match(pattern, line)
            if match:
                register = match.group(1)
                number = int(match.group(2))
                found.setdefault(register, {}).setdefault(number, []).append(lineno)
                break
    return found


def expand_ids(cell):
    """Every `ENT-*` in `cell`, with ellipsis ranges expanded.

    Handles ``ENT-XC-005`...`008`'' (successor abbreviated) and the fully
    written ``ENT-XC-005`...`ENT-XC-008`''.  Ranges are expanded FIRST, then
    literal tokens are added, so a mixed cell is fully resolved either way.

    PRD-014's section 10 does not currently use range notation in a Proves
    cell, but section 16's changelog does ("`ENT-FR-001` to `028`"), and a
    future revision of section 10 might.  A scanner that cannot expand ranges
    under-reports coverage silently -- finding `S4-D-01` of the PRD-016 review.
    """
    ids = set()
    range_pattern = (r'`ENT-([A-Z]+)-(\d+)`\s*(?:\u2026|\.\.\.|\.\.)\s*'
                     r'`(?:ENT-([A-Z]+)-)?(\d+)`')
    for match in re.finditer(range_pattern, cell):
        register = match.group(1)
        tail_register = match.group(3)
        if tail_register is not None and tail_register != register:
            fail('range notation crosses registers: %s' % match.group(0))
            continue
        low, high = int(match.group(2)), int(match.group(4))
        if high < low:
            fail('range notation is inverted: %s' % match.group(0))
            continue
        for number in range(low, high + 1):
            ids.add('ENT-%s-%03d' % (register, number))
    for match in re.finditer(r'`ENT-([A-Z]+)-(\d+)`', cell):
        ids.add('ENT-%s-%03d' % (match.group(1), int(match.group(2))))
    return ids


def declared_counts(block):
    """Section 0.2 rows -> register -> (count, range_max).

    THREE published shapes are accepted.  Shape 1 is what PRD-014 uses; shapes
    2 and 3 are PRD-016's, accepted so that this parser does not encode one
    document's layout as if it were the rule -- the defect that made
    `prd016_traceability.py` unusable here (see the module docstring).

      1. | `ENT-FR-` | Functional requirement | **28** | `ENT-FR-001` ... `ENT-FR-028` | Yes |
         bare prefix in cell 0, count in cell 2, range span in cell 3
      2. | `ENT-FR-001` ... `ENT-FR-028` | contiguous | **28** | ...
         range span in cell 0, count in cell 2
      3. | `ENT-EVT-*` | ... | **0** | **DECLARED EMPTY** | n/a |
         wildcard prefix, zero count, no range

    A row whose first cell names an ENT- register but parses under none of the
    three is a FAILURE, not a skip.  A parser that silently ignores rows it
    cannot read reports a clean run against a register it never saw.
    """
    out = {}
    for line in block.split('\n'):
        if not line.startswith('|'):
            continue
        cells = [c.strip() for c in line.strip('|').split('|')]
        if len(cells) < 3:
            continue
        head = cells[0]
        if head.startswith('---') or 'Prefix' in head:
            continue

        def count_of(index):
            if index >= len(cells):
                return None
            match = re.search(r'\*\*(\d+)\*\*', cells[index])
            if match is None:
                match = re.match(r'^(\d+)$', cells[index])
            return int(match.group(1)) if match else None

        # shape 1: bare prefix in cell 0
        bare = re.match(r'^\*{0,2}`ENT-([A-Z]+)-`\*{0,2}$', head)
        if bare:
            register = bare.group(1)
            count = count_of(2)
            if count is None:
                fail('section 0.2 row for ENT-%s- has no parsable count' % register)
                continue
            rng = cells[3] if len(cells) > 3 else ''
            span = re.search(r'`ENT-([A-Z]+)-(\d+)`\s*(?:\u2026|\.\.\.)\s*'
                             r'`ENT-([A-Z]+)-(\d+)`', rng)
            if span:
                if span.group(1) != register or span.group(3) != register:
                    fail('section 0.2 range for ENT-%s- names another register: %s'
                         % (register, rng))
                    continue
                if int(span.group(2)) != 1:
                    fail('section 0.2 declares ENT-%s-* starting at %s, not 001'
                         % (register, span.group(2)))
                out[register] = (count, int(span.group(4)))
            elif 'DECLARED EMPTY' in rng.upper() or count == 0:
                out[register] = (count, None)
            else:
                fail('section 0.2 row for ENT-%s- declares neither a range nor '
                     'DECLARED EMPTY: %r' % (register, rng))
            continue

        # shape 3: wildcard prefix
        wildcard = re.match(r'^\*{0,2}`ENT-([A-Z]+)-\*`\*{0,2}$', head)
        if wildcard:
            register = wildcard.group(1)
            count = count_of(2)
            if count is None:
                fail('section 0.2 row for ENT-%s-* has no parsable count' % register)
                continue
            out[register] = (count, None)
            continue

        # shape 2: range span in cell 0
        span = re.match(r'^`ENT-([A-Z]+)-(\d+)`\s*(?:\u2026|\.\.\.)\s*'
                        r'`ENT-([A-Z]+)-(\d+)`$', head)
        if span:
            if span.group(1) != span.group(3):
                fail('section 0.2 declares a range across two registers: %s' % head)
                continue
            register = span.group(1)
            if int(span.group(2)) != 1:
                fail('section 0.2 declares ENT-%s-* starting at %s, not 001'
                     % (register, span.group(2)))
            count = count_of(2)
            if count is None:
                fail('section 0.2 row for ENT-%s-* has no parsable count' % register)
                continue
            out[register] = (count, int(span.group(4)))
            continue

        # a row that names an ENT- register but parses under no shape
        if re.search(r'`ENT-[A-Z]+-', head):
            fail('section 0.2 row %r names an ENT- register but matches none of '
                 'the three accepted shapes -- a silently skipped row would '
                 'report a clean run against a register never read' % head)
    return out


def main():
    doc = read(DOC)

    # ---- check 1: section 0.2 exists and declares three classes
    block = section(doc, '### 0.2 Identifier registers')
    if block is None:
        fail('PRD-014 has no section 0.2 -- the Stage 2 gate requires the '
             'registers declared up front with ranges')
        report({}, {}, set(), set(), 0)
        return 1
    for label in ['Class A', 'Class B', 'Class C']:
        if label not in block:
            fail('section 0.2 does not declare %s' % label)

    sites = definition_sites(doc)
    computed = {r: sorted(sites.get(r, {})) for r in ORDER}
    published = declared_counts(block)

    # A parser that found nothing must fail, not pass vacuously.
    if not published:
        fail('section 0.2 yielded ZERO declared registers -- the parser read '
             'no row it understood. This is the failure mode that made '
             'prd016_traceability.py unusable for this document; it must never '
             'be reported as a clean run')

    # ---- check 2: published vs computed, per register
    for register in ORDER:
        numbers = computed[register]
        if register not in published:
            if numbers:
                fail('ENT-%s-* is defined %d time(s) in the body but is NOT '
                     'declared in section 0.2' % (register, len(numbers)))
            continue
        pub_count, pub_max = published[register]
        if pub_count != len(numbers):
            fail('ENT-%s-*: section 0.2 declares %d, the body defines %d'
                 % (register, pub_count, len(numbers)))
        if pub_max is None:
            if numbers:
                fail('ENT-%s-* is declared with no range but the body defines '
                     '%d identifier(s)' % (register, len(numbers)))
        elif not numbers:
            fail('ENT-%s-* declares range max %03d but the body defines none'
                 % (register, pub_max))
        elif pub_max != max(numbers):
            fail('ENT-%s-*: section 0.2 declares range max %03d, the body '
                 'reaches %03d' % (register, pub_max, max(numbers)))

    for register in sorted(published):
        if register not in ORDER:
            fail('section 0.2 declares unknown register ENT-%s-*' % register)

    # ---- check 3: contiguity
    for register in ORDER:
        numbers = computed[register]
        if not numbers:
            continue
        expected = list(range(1, max(numbers) + 1))
        if numbers != expected:
            missing = sorted(set(expected) - set(numbers))
            fail('ENT-%s-* is not contiguous: missing %s'
                 % (register, ', '.join('%03d' % m for m in missing)))

    # ---- check 4: no retirement register, and no number defined twice
    if re.search(r'^##\s+\d+\.\s+Retired identifiers', doc, re.MULTILINE):
        fail('PRD-014 now has a retirement section; section 0.2 states "No '
             'identifier is retired", and contiguity would have to be judged '
             'over the declared set instead (section 2D.2). Both this script '
             'and prd014_stage5.py must be revised before that is safe')
    if 'No identifier is retired' not in block:
        fail('section 0.2 no longer states that no identifier is retired -- '
             'declared == in force can no longer be assumed')
    for register in ORDER:
        for number, linenos in sorted(sites.get(register, {}).items()):
            if len(linenos) > 1:
                fail('ENT-%s-%03d is defined at %d sites (lines %s) -- one '
                     'identifier, one definition'
                     % (register, number, len(linenos),
                        ', '.join(str(n) for n in linenos)))

    defined = set()
    for register in ORDER:
        for number in computed[register]:
            defined.add('ENT-%s-%03d' % (register, number))

    # ---- check 5: zero dangling citations anywhere in the PRD
    cited = expand_ids(doc)
    for ident in sorted(cited - defined):
        fail('%s is cited in PRD-014 but never defined -- a dangling citation'
             % ident)

    # ---- check 6: zero orphan acceptance criteria
    ac_block = section(doc, '## 10. Acceptance criteria')
    class_a = set()
    for register in CLASS_A:
        for number in computed[register]:
            class_a.add('ENT-%s-%03d' % (register, number))
    covered = set()
    ac_rows = 0
    if ac_block is None:
        fail('PRD-014 has no section 10 -- acceptance criteria are unreadable')
    else:
        for line in ac_block.split('\n'):
            if not re.match(r'^\|\s*\*{0,2}`ENT-AC-\d+`', line):
                continue
            ac_rows += 1
            cells = [c.strip() for c in line.strip('|').split('|')]
            criterion = re.match(r'^\*{0,2}`(ENT-AC-\d+)`', cells[0]).group(1)
            traces = expand_ids(' '.join(cells[1:]))
            traces = {i for i in traces if not i.startswith('ENT-AC-')}
            if not traces:
                fail('%s traces to no requirement -- an orphan criterion, the '
                     'Stage 4 check 4 failure mode' % criterion)
            outside = sorted(traces - class_a)
            if outside:
                fail('%s traces to %s, which is not a Class A obligation'
                     % (criterion, ', '.join(outside)))
            covered |= traces & class_a
        if ac_rows != len(computed['AC']):
            fail('section 10 has %d criterion rows but %d ENT-AC-* are defined'
                 % (ac_rows, len(computed['AC'])))

    # ---- check 7: the two empty registers are stated, not skipped
    for register in EMPTY_BY_DESIGN:
        if computed[register]:
            fail('ENT-%s-* holds %d member(s); section 0.3 declares it EMPTY. '
                 'If that changed, section 0.3 must change with it'
                 % (register, len(computed[register])))

    # ---- check 8: the PRD's own uncovered list must match the computation
    #
    # PRD-016 names its uncovered obligations in a paragraph; PRD-014 names them
    # in the section 10.1 table.  Both shapes are tried, and absence of BOTH is
    # a failure -- a guard that matches nothing passes vacuously.
    uncovered = sorted(class_a - covered)
    cov_block = section(doc, '### 10.1 Coverage')
    named = None
    if cov_block is not None:
        rows = [l for l in cov_block.split('\n')
                if re.match(r'^\|\s*`ENT-(FR|BR|INV|EVT|XC)-\d+`', l)]
        if rows:
            named = set()
            for row in rows:
                named |= expand_ids(row.split('|')[1]) & class_a
        else:
            for para in cov_block.split('\n\n'):
                if 'not** covered' in para or 'not covered' in para:
                    named = expand_ids(para) & class_a
                    break
    if named is None:
        fail('section 10.1 names the uncovered obligations in neither a table '
             'nor a prose paragraph -- they are named nowhere, so the coverage '
             'figure cannot be checked against the document')
    elif named != set(uncovered):
        only_doc = sorted(named - set(uncovered))
        only_calc = sorted(set(uncovered) - named)
        fail('section 10.1 names %d uncovered obligation(s), the computation '
             'finds %d%s%s'
             % (len(named), len(uncovered),
                '; named but covered: ' + ', '.join(only_doc) if only_doc else '',
                '; uncovered but unnamed: ' + ', '.join(only_calc) if only_calc else ''))

    # the published coverage table's own numbers
    if cov_block is not None:
        for label, actual in [('Obligation-bearing identifiers', len(class_a)),
                              ('Obligations carrying at least one acceptance criterion',
                               len(covered))]:
            match = re.search(re.escape(label) + r'[^|]*\|\s*\*\*(\d+)\*\*', cov_block)
            if match and int(match.group(1)) != actual:
                fail('section 10.1 states %s = %s, computed %d'
                     % (label, match.group(1), actual))
        pct = re.search(r'\*\*Coverage\*\*\s*\|\s*\*\*([\d.]+)\s*%\*\*', cov_block)
        if pct and class_a:
            true_pct = 100.0 * len(covered) / len(class_a)
            if abs(float(pct.group(1)) - true_pct) > 0.05:
                fail('section 10.1 states coverage %s%%, computed %.1f%%'
                     % (pct.group(1), true_pct))

    # ---- check 9: the totals sentence in section 0.2
    total = sum(len(computed[r]) for r in ORDER)
    empty = sum(1 for r in ORDER if not computed[r])
    if total != EXPECTED_TOTAL:
        fail('the body defines %d identifiers; section 0.2 publishes %d'
             % (total, EXPECTED_TOTAL))
    if len(ORDER) != EXPECTED_REGISTERS:
        fail('ORDER lists %d registers; section 0.2 publishes %d'
             % (len(ORDER), EXPECTED_REGISTERS))
    if empty != EXPECTED_EMPTY:
        fail('%d register(s) are empty; section 0.2 publishes %d'
             % (empty, EXPECTED_EMPTY))
    if len(class_a) != EXPECTED_OBLIGATIONS:
        fail('%d obligation-bearing identifiers computed; section 0.2 '
             'publishes %d' % (len(class_a), EXPECTED_OBLIGATIONS))
    stated = re.search(r'\*\*Totals:\s*(\d+)\s*identifiers declared across\s*'
                       r'(\d+)\s*registers,\s*of which\s*(\d+)\s*are empty\.\s*'
                       r'(\d+)\s*are obligation-bearing', block)
    if stated is None:
        fail('section 0.2 has no parsable totals sentence -- the published '
             'totals cannot be checked against the body')
    else:
        for label, published_value, actual in [
                ('total identifiers', int(stated.group(1)), total),
                ('registers', int(stated.group(2)), len(ORDER)),
                ('empty registers', int(stated.group(3)), empty),
                ('obligation-bearing', int(stated.group(4)), len(class_a))]:
            if published_value != actual:
                fail('section 0.2 totals sentence states %s = %d, computed %d'
                     % (label, published_value, actual))

    report(computed, published, class_a, covered, ac_rows)
    return 1 if PROBLEMS else 0


def report(computed, published, class_a, covered, ac_rows):
    line = '-' * 70
    print(line)
    print('PRD-014 internal traceability -- the PRD against itself')
    print(line)
    total = 0
    for register in ORDER:
        numbers = computed.get(register, [])
        total += len(numbers)
        if not numbers:
            state = 'DECLARED EMPTY' if register in EMPTY_BY_DESIGN else 'absent'
            print('  ENT-%-4s* %-14s count 0' % (register + '-', state))
            continue
        mark = 'declared' if register in published else 'UNDECLARED'
        print('  ENT-%-4s* %-14s count %-3d range 001..%03d  contiguous'
              % (register + '-', mark, len(numbers), max(numbers)))
    print(line)
    print('identifiers defined                      : %d' % total)
    print('registers declared in section 0.2        : %d' % len(published))
    print('acceptance criterion rows                : %d' % ac_rows)
    if class_a:
        print('Class A obligations                      : %d' % len(class_a))
        print('obligations carrying a criterion         : %d' % len(covered))
        print('coverage                                 : %d / %d = %.1f%%'
              % (len(covered), len(class_a), 100.0 * len(covered) / len(class_a)))
        print('uncovered, named in section 10.1         : %d'
              % (len(class_a) - len(covered)))
    print('criteria proven by a passing test        : 0  (no implementation)')
    print(line)
    if PROBLEMS:
        print('FAIL - %d problem(s):' % len(PROBLEMS))
        for problem in PROBLEMS:
            print('  * %s' % problem)
    else:
        print('PASS - section 0.2 declares every register the body defines,')
        print('       counts and range maxima reproduce, all ranges')
        print('       contiguous, no identifier defined twice, no retired')
        print('       register, zero dangling citations, zero orphan')
        print('       criteria, both empty registers stated, the section')
        print('       10.1 uncovered list agrees with the computation, and')
        print('       the published totals reproduce.')
    print(line)
    return 0


if __name__ == '__main__':
    sys.exit(main())
