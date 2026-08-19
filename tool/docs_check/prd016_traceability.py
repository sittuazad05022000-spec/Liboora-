#!/usr/bin/env python3
"""PRD-016 internal traceability -- does the PRD agree with itself?

WHY THIS EXISTS
---------------
`PRD_LIFECYCLE.md` Stage 5 demands counts and ranges "verified mechanically",
and `TRACEABILITY_MATRIX.md` section 2H records why a one-off script is not
enough:

    "A number computed once is not a number verified mechanically on every
     commit."

This is the first of the two scripts the `PRD-008` pattern requires
(`prd008_traceability.py` plus `prd008_stage5.py`, repeated for `PRD-013`).
It checks `PRD-016_AUDIT_TRAIL.md` against **itself** -- section 0.2's declared
registers and counts against the identifiers actually defined in the body --
and it **never opens `TRACEABILITY_MATRIX.md`**.  `prd016_stage5.py` is the
second script and checks the matrix against an independent recomputation.  If
one script both wrote the register and checked it, it would verify agreement
with itself; that failure mode is named in section 2H.2 and is structurally
avoided here.

TWO INSTRUMENT HAZARDS THIS MODULE EXPOSED
------------------------------------------
Both were found by running the `PRD-013` rules against this document and
getting an answer that was obviously wrong.  They are recorded because a
tool's failure history is evidence about the tool.

1. BOLD-WRAPPED DEFINITIONS.  `PRD-013` opens a requirement line with a bare
   backticked identifier.  `PRD-016` opens it with a **bold** one:

       **`AUD-FR-001`** -- The module SHALL own the `AuditEntry` aggregate ...

   The `PRD-013` definition rule matched 1 of 16 `AUD-FR-*` and reported five
   registers absent.  A checker inheriting that rule unchanged would have
   declared a correct document catastrophically broken -- or, worse, been
   "fixed" by editing the PRD to suit the tool.

2. ELLIPSIS RANGES -- finding `S4-D-01` of the Stage 4 review.  `AUD-AC-017`
   traces to ``AUD-FR-013`, `AUD-XC-005`...`008`'' .  A token-only scanner sees
   `AUD-XC-005` and `AUD-XC-008` but not `006` or `007`, under-reporting
   coverage by 3 and inventing a gap the document does not have.  The Stage 4
   record states the constraint:

       "Any mechanical checker for `AUD-*` must expand ellipsis ranges.  A
        token-only scanner under-counts coverage by 3 and would report a false
        gap -- as this review's own first script did."

   Range notation is established practice in frozen `PRD-007` (`SEAT-AC-166`
   maps via `SEAT-EVT-001`...`004`), so expansion is compliance with existing
   convention, not an accommodation invented here.

3. SENTENCE-FINAL AND WRAPPED IDENTIFIERS.  Found by this script FAILING on a
   correct document.  Fixing hazard 1 by accepting any line that opens with a
   bold identifier also accepted line 80, which is the tail of a sentence in
   section 0.3 -- "Retention is recorded as **`AUD-GAP-001`**." -- and reported
   `AUD-GAP-001` as defined twice.  Two more lines (307, 310) open with a plain
   identifier mid-sentence in section 9's reverse-coverage paragraph.

   The document's own convention is exact and is what the rule now encodes: a
   prose definition is a bold identifier followed by an em-dash and normative
   text.  There are 23 such lines -- 16 `AUD-FR` + 3 `AUD-BR` + 4 `AUD-INV` --
   and the remaining 35 identifiers are defined as table first cells.  23 + 35
   = 58, section 0.2's published total.

   In all three hazards the PRD was right and the instrument was wrong.  No PRD
   content was changed to make a checker pass -- the rule was changed to match
   the document, which is the direction section 3.2 of
   `PRD-013_STAGE5_CONFERRAL.md` records as correct.

WHAT PRD-013 HAD AND THIS MODULE DOES NOT
-----------------------------------------
`PRD-013` retires 12 identifiers, so contiguity there is judged over the
DECLARED set (in force + retired) per section 2D.2.  `PRD-016` retires
**nothing** -- section 0.2 states "No identifier is retired; none has ever
been issued before."  Declared therefore equals in force, and check 4 proves
that rather than assuming it: if a retirement section ever appears, the check
fails loudly instead of silently changing meaning.

WHAT IT CHECKS
--------------
1. Section 0.2 exists and declares classes A, B and C with subtotals.
2. Every register defined in the body is declared in section 0.2 with a
   matching count and range maximum.
3. Every range is contiguous 1..max.
4. No retirement register exists, so declared == in force (asserted, not
   assumed), and no number is defined twice at two different requirements.
5. Zero dangling citations: every `AUD-*` cited anywhere in the PRD resolves
   to a definition.
6. Zero orphan acceptance criteria: every `AUD-AC-*` traces to at least one
   Class A obligation, with ellipsis ranges expanded (hazard 2).
7. `AUD-EVT-*` and `AUD-CFG-*` are reported as DECLARED EMPTY, never silently
   skipped.  An empty register is a finding to state, not a hole to hide.
8. Reverse coverage is computed and printed, and the PRD's own named list of
   uncovered obligations must agree with the computation.

Exit 0 = the PRD agrees with itself.  Exit 1 = it does not.
"""

import os
import re
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DOC = os.path.join('docs', '30-product', 'audit', 'PRD-016_AUDIT_TRAIL.md')

# Declaration order in section 0.2: Class A, then Class B, then Class C.
ORDER = ['FR', 'BR', 'INV', 'EVT', 'XC', 'CFG', 'AC', 'GAP']
CLASS_A = ['FR', 'BR', 'INV', 'EVT', 'XC']
EMPTY_BY_DESIGN = ['EVT', 'CFG']

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
# A definition is a line that OPENS with the identifier: bold prose, plain
# prose, a table first cell, or a heading.  Hazard 1 above is why the bold
# form comes first and why `**` is tolerated in the table form.
DEF_PATTERNS = [
    r'^\*\*`AUD-([A-Z]+)-(\d+)`\*\*',
    r'^`AUD-([A-Z]+)-(\d+)`',
    r'^\|\s*\*{0,2}`AUD-([A-Z]+)-(\d+)`\*{0,2}\s*\|',
    r'^###\s+\*{0,2}`AUD-([A-Z]+)-(\d+)`',
]

# Lines that OPEN with an identifier but are prose continuations, not
# definitions.  Section 9's reverse-coverage paragraph and section 10's lead-in
# wrap onto a line beginning with an identifier; counting those as definitions
# would report three phantom duplicates.  The guard is a positive test for
# sentence continuation, not a line-number exclusion, so it keeps working if the
# document is re-flowed.
CONTINUATION = re.compile(
    r'^`AUD-[A-Z]+-\d+`(?:,|\s+and\b|\s+are\b|\s*…|\s*\.\.\.)'
)


def definition_sites(text):
    """register -> {number: [line numbers]}, definition sites only."""
    found = {}
    for lineno, line in enumerate(text.split('\n'), 1):
        if CONTINUATION.match(line):
            continue
        for pattern in DEF_PATTERNS:
            match = re.match(pattern, line)
            if match:
                register = match.group(1)
                number = int(match.group(2))
                found.setdefault(register, {}).setdefault(number, []).append(lineno)
                break
    return found


def expand_ids(cell):
    """Every `AUD-*` in `cell`, with ellipsis ranges expanded -- see S4-D-01.

    Handles ``AUD-XC-005`...`008`'' (successor abbreviated) and the fully
    written ``AUD-XC-005`...`AUD-XC-008`''.  Ranges are expanded FIRST, then
    literal tokens are added, so a mixed cell is fully resolved either way.
    """
    ids = set()
    range_pattern = (r'`AUD-([A-Z]+)-(\d+)`\s*(?:\u2026|\.\.\.|\.\.)\s*'
                     r'`(?:AUD-([A-Z]+)-)?(\d+)`')
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
            ids.add('AUD-%s-%03d' % (register, number))
    for match in re.finditer(r'`AUD-([A-Z]+)-(\d+)`', cell):
        ids.add('AUD-%s-%03d' % (match.group(1), int(match.group(2))))
    return ids


def declared_counts(block):
    """Section 0.2 rows -> register -> (count, range_max).

    Two published shapes:
      "| `AUD-FR-001` ... `AUD-FR-016` | contiguous | **16** | ..."
      "| `AUD-EVT-*` | **DECLARED EMPTY** | **0** | ..."
    """
    out = {}
    for line in block.split('\n'):
        if not line.startswith('|'):
            continue
        cells = [c.strip() for c in line.strip('|').split('|')]
        if len(cells) < 3:
            continue
        head = cells[0]
        wildcard = re.match(r'^\*{0,2}`AUD-([A-Z]+)-\*`\*{0,2}$', head)
        if wildcard:
            register = wildcard.group(1)
            count_match = re.search(r'\*\*(\d+)\*\*', cells[2])
            if count_match is None:
                fail('section 0.2 row for AUD-%s-* has no parsable count'
                     % register)
                continue
            out[register] = (int(count_match.group(1)), None)
            continue
        span = re.match(r'^`AUD-([A-Z]+)-(\d+)`\s*(?:\u2026|\.\.\.)\s*'
                        r'`AUD-([A-Z]+)-(\d+)`$', head)
        if span is None:
            continue
        if span.group(1) != span.group(3):
            fail('section 0.2 declares a range across two registers: %s' % head)
            continue
        register = span.group(1)
        if int(span.group(2)) != 1:
            fail('section 0.2 declares AUD-%s-* starting at %s, not 001'
                 % (register, span.group(2)))
        count_match = re.search(r'\*\*(\d+)\*\*', cells[2])
        if count_match is None:
            fail('section 0.2 row for AUD-%s-* has no parsable count' % register)
            continue
        out[register] = (int(count_match.group(1)), int(span.group(4)))
    return out


def main():
    doc = read(DOC)

    # ---- check 1: section 0.2 exists and declares three classes
    block = section(doc, '### 0.2 Identifier registers')
    if block is None:
        fail('PRD-016 has no section 0.2 -- the Stage 2 gate requires the '
             'registers declared up front with ranges')
        report({}, {}, set(), set(), 0)
        return 1
    for label in ['Class A', 'Class B', 'Class C']:
        if label not in block:
            fail('section 0.2 does not declare %s' % label)

    sites = definition_sites(doc)
    computed = {r: sorted(sites.get(r, {})) for r in ORDER}
    published = declared_counts(block)

    # ---- check 2: published vs computed, per register
    for register in ORDER:
        numbers = computed[register]
        if register not in published:
            if numbers:
                fail('AUD-%s-* is defined %d time(s) in the body but is NOT '
                     'declared in section 0.2' % (register, len(numbers)))
            continue
        pub_count, pub_max = published[register]
        if pub_count != len(numbers):
            fail('AUD-%s-*: section 0.2 declares %d, the body defines %d'
                 % (register, pub_count, len(numbers)))
        if pub_max is None:
            if numbers:
                fail('AUD-%s-* is declared with no range but the body defines '
                     '%d identifier(s)' % (register, len(numbers)))
        elif not numbers:
            fail('AUD-%s-* declares range max %03d but the body defines none'
                 % (register, pub_max))
        elif pub_max != max(numbers):
            fail('AUD-%s-*: section 0.2 declares range max %03d, the body '
                 'reaches %03d' % (register, pub_max, max(numbers)))

    for register in sorted(published):
        if register not in ORDER:
            fail('section 0.2 declares unknown register AUD-%s-*' % register)

    # ---- check 3: contiguity
    for register in ORDER:
        numbers = computed[register]
        if not numbers:
            continue
        expected = list(range(1, max(numbers) + 1))
        if numbers != expected:
            missing = sorted(set(expected) - set(numbers))
            fail('AUD-%s-* is not contiguous: missing %s'
                 % (register, ', '.join('%03d' % m for m in missing)))

    # ---- check 4: no retirement register, and no number defined twice
    if re.search(r'^##\s+\d+\.\s+Retired identifiers', doc, re.MULTILINE):
        fail('PRD-016 now has a retirement section; section 0.2 states "No '
             'identifier is retired", and contiguity would have to be judged '
             'over the declared set instead (section 2D.2). Both this script '
             'and prd016_stage5.py must be revised before that is safe')
    if 'No identifier is retired' not in block:
        fail('section 0.2 no longer states that no identifier is retired -- '
             'declared == in force can no longer be assumed')
    for register in ORDER:
        for number, linenos in sorted(sites.get(register, {}).items()):
            if len(linenos) > 1:
                fail('AUD-%s-%03d is defined at %d sites (lines %s) -- one '
                     'identifier, one definition'
                     % (register, number, len(linenos),
                        ', '.join(str(n) for n in linenos)))

    defined = set()
    for register in ORDER:
        for number in computed[register]:
            defined.add('AUD-%s-%03d' % (register, number))

    # ---- check 5: zero dangling citations anywhere in the PRD
    cited = expand_ids(doc)
    dangling = sorted(cited - defined)
    for ident in dangling:
        fail('%s is cited in PRD-016 but never defined -- a dangling citation'
             % ident)

    # ---- check 6: zero orphan acceptance criteria
    ac_block = section(doc, '## 9. Acceptance criteria')
    class_a = set()
    for register in CLASS_A:
        for number in computed[register]:
            class_a.add('AUD-%s-%03d' % (register, number))
    covered = set()
    ac_rows = 0
    if ac_block is None:
        fail('PRD-016 has no section 9 -- acceptance criteria are unreadable')
    else:
        for line in ac_block.split('\n'):
            if not re.match(r'^\|\s*\*{0,2}`AUD-AC-\d+`', line):
                continue
            ac_rows += 1
            cells = [c.strip() for c in line.strip('|').split('|')]
            criterion = re.match(r'^\*{0,2}`(AUD-AC-\d+)`', cells[0]).group(1)
            traces = expand_ids(' '.join(cells[1:]))
            traces = {i for i in traces if not i.startswith('AUD-AC-')}
            if not traces:
                fail('%s traces to no requirement -- an orphan criterion, the '
                     'Stage 4 check 4 failure mode' % criterion)
            outside = sorted(traces - class_a)
            if outside:
                fail('%s traces to %s, which is not a Class A obligation'
                     % (criterion, ', '.join(outside)))
            covered |= traces & class_a
        if ac_rows != len(computed['AC']):
            fail('section 9 has %d criterion rows but %d AUD-AC-* are defined'
                 % (ac_rows, len(computed['AC'])))

    # ---- check 7: the two empty registers are stated, not skipped
    for register in EMPTY_BY_DESIGN:
        if computed[register]:
            fail('AUD-%s-* holds %d member(s); section 0.3 declares it EMPTY. '
                 'If that changed, section 0.3 must change with it'
                 % (register, len(computed[register])))

    # ---- check 8: the PRD's own uncovered list must match the computation
    uncovered = sorted(class_a - covered)
    if ac_block is not None:
        reverse = None
        for para in ac_block.split('\n\n'):
            if 'Reverse coverage' in para:
                reverse = para
                break
        if reverse is None:
            fail('section 9 has no reverse-coverage paragraph, so the '
                 'uncovered obligations are named nowhere')
        else:
            named = expand_ids(reverse) & class_a
            if named != set(uncovered):
                only_doc = sorted(named - set(uncovered))
                only_calc = sorted(set(uncovered) - named)
                fail('section 9 names %d uncovered obligation(s), the '
                     'computation finds %d%s%s'
                     % (len(named), len(uncovered),
                        '; named but covered: ' + ', '.join(only_doc) if only_doc else '',
                        '; uncovered but unnamed: ' + ', '.join(only_calc) if only_calc else ''))
            stated = re.search(r'Of the \*\*(\d+)\*\* Class A identifiers', reverse)
            if stated and int(stated.group(1)) != len(class_a):
                fail('section 9 states %s Class A identifiers, computed %d'
                     % (stated.group(1), len(class_a)))

    report(computed, published, class_a, covered, ac_rows)
    return 1 if PROBLEMS else 0


def report(computed, published, class_a, covered, ac_rows):
    line = '-' * 70
    print(line)
    print('PRD-016 internal traceability -- the PRD against itself')
    print(line)
    total = 0
    for register in ORDER:
        numbers = computed.get(register, [])
        total += len(numbers)
        if not numbers:
            state = 'DECLARED EMPTY' if register in EMPTY_BY_DESIGN else 'absent'
            print('  AUD-%-4s* %-14s count 0' % (register + '-', state))
            continue
        mark = 'declared' if register in published else 'UNDECLARED'
        print('  AUD-%-4s* %-14s count %-3d range 001..%03d  contiguous'
              % (register + '-', mark, len(numbers), max(numbers)))
    print(line)
    print('identifiers defined                      : %d' % total)
    print('acceptance criterion rows                : %d' % ac_rows)
    if class_a:
        print('Class A obligations                      : %d' % len(class_a))
        print('obligations carrying a criterion         : %d' % len(covered))
        print('coverage                                 : %d / %d = %.1f%%'
              % (len(covered), len(class_a), 100.0 * len(covered) / len(class_a)))
        print('uncovered, named in section 9            : %d'
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
        print('       criteria, both empty registers stated, and the')
        print('       reverse-coverage list agrees with the computation.')
    print(line)
    return 0


if __name__ == '__main__':
    sys.exit(main())
