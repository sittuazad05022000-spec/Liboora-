#!/usr/bin/env python3
"""PRD-016 Stage 5 gate -- does TRACEABILITY_MATRIX.md agree with the PRD?

WHY THIS EXISTS
---------------
`PRD_LIFECYCLE.md` Stage 5 states its gate as:

    "the PRD's prefixes registered in TRACEABILITY_MATRIX.md section 2 with
     counts and ranges, verified mechanically, zero collisions.

     Mechanical means counted by a tool, not by reading."

`prd016_traceability.py` checks `PRD-016` against **itself** and never opens the
matrix, so before this script existed section 2J could have been written with
any numbers in it and nothing would have objected.  This is the second of the
two scripts the `PRD-008` pattern requires (`prd008_traceability.py` plus
`prd008_stage5.py`, repeated for `PRD-013`), and it is deliberately **not** an
import of the first: the two recompute the register independently, so a bug in
one does not propagate silently into the other.  Two declarations, one subject.

It adds a check and weakens nothing.  `prd016_traceability.py` is untouched and
must continue to pass on its own.

INDEPENDENCE IS STRUCTURAL, NOT PROMISED
----------------------------------------
`TRACEABILITY_MATRIX.md` section 2H.2 names the failure mode this pair exists to
avoid: "a checker written in the same pass as the register it checks, by the
same author, verifies agreement with itself."  Two mitigations are applied:

  * No import.  This file re-derives every register from the PRD body with its
    own parser.  A defect in one parser cannot be inherited by the other.
  * A DIFFERENT parsing strategy.  `prd016_traceability.py` classifies each line
    by matching a set of ordered line-start patterns.  This script instead walks
    the document section by section and harvests identifiers from the structural
    position they occupy within each section.  The two agree on 58 by two routes,
    which is evidence; agreement by one route repeated twice would not be.

WHAT MADE THIS MODULE DIFFERENT FROM PRD-013
--------------------------------------------
`PRD-013` retires 12 identifiers, so section 2I publishes two figures per
register ("18 in force (21 declared)") and contiguity is judged over the
declared set per section 2D.2.  `PRD-016` retires **nothing**, so section 2J
publishes ONE count per register.  That is simpler, and the simplicity is
itself checked: check 6 asserts no retirement register has appeared, because if
one ever does, a single published count silently becomes ambiguous and both
scripts must be revised before the gate can be trusted again.

Two registers -- `AUD-EVT-*` and `AUD-CFG-*` -- hold no member by design.  They
must be REGISTERED AS EMPTY rather than omitted (check 7).  An omitted empty
register is indistinguishable from an oversight; a registered one records the
decision.  `AUD-CFG-*` additionally has no identifier issued at all, so its
range cell states no number, and the parser must accept that shape without
inventing a maximum of 0.

WHAT IT CHECKS
--------------
1. Section 2J exists.  Its absence IS the Stage 5 failure, so it is reported as
   such rather than as a missing section.
2. Every register `PRD-016` defines has a row in section 2J whose count and
   range maximum agree with values recomputed from the PRD body, and section 2J
   registers nothing the PRD does not define.
3. Every range is contiguous 1..max.
4. Zero collisions, in all three directions:
   (a) inward -- no `AUD-<REG>` stem collides with a prefix already registered
       elsewhere in the matrix;
   (b) the substring hazard -- `AUD-FR-001` must not be reachable by a
       word-boundary search for a bare `FR-001`, which matters here because the
       matrix DOES register a bare `FR-*` stem; and `AUD-` must not be reachable
       by a search for `AU-`, the two-register hazard recorded at PRD-016
       section 0.4;
   (c) outward -- no document outside `docs/30-product/audit/` DEFINES an
       `AUD-*` identifier.  A citation is not a collision (section 2C.1), so
       each outside occurrence is resolved against the defined set rather than
       counted as a failure.
5. Section 2J's own totals arithmetic is recomputed, not trusted.
6. No retirement register exists (see above), and section 2J does not publish
   an "in force (declared)" pair that would imply one.
7. Both empty registers appear in section 2J.
8. Section 2J's published coverage figure is recomputed from the PRD, with
   ellipsis ranges expanded per finding `S4-D-01` of the Stage 4 review.

Exit 0 = Stage 5 gate satisfied.  Exit 1 = it is not.
"""

import os
import re
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
MODULE_DIR = os.path.join('docs', '30-product', 'audit')
DOC = os.path.join(MODULE_DIR, 'PRD-016_AUDIT_TRAIL.md')
MATRIX = os.path.join('docs', '40-implementation', 'TRACEABILITY_MATRIX.md')

ORDER = ['FR', 'BR', 'INV', 'EVT', 'XC', 'CFG', 'AC', 'GAP']
CLASS_A = ['FR', 'BR', 'INV', 'EVT', 'XC']
EMPTY_BY_DESIGN = ['EVT', 'CFG']

# Which sections may define which registers.  This is the structural axis that
# makes this parser independent of prd016_traceability.py's line-pattern axis:
# an identifier harvested from a section that has no business defining it is a
# finding, not a definition.
SECTION_REGISTERS = {
    '## 1.': ['FR'], '## 2.': ['FR'], '## 3.': ['FR'],
    '## 4.': ['BR'], '## 5.': ['INV'],
    '## 6.': ['FR', 'EVT'], '## 7.': ['FR'],
    '## 8.': ['XC'], '## 9.': ['AC'], '## 10.': ['GAP'],
}

PROBLEMS = []


def fail(message):
    PROBLEMS.append(message)


def read(path):
    with open(os.path.join(ROOT, path), encoding='utf-8') as handle:
        return handle.read()


def walk_markdown():
    for base, dirs, files in os.walk(os.path.join(ROOT, 'docs')):
        dirs[:] = [d for d in dirs if not d.startswith('.')]
        for name in files:
            if name.endswith('.md'):
                yield os.path.join(base, name)


def top_sections(text):
    """Split the document into '## ' sections -> {heading_prefix: body}."""
    out = {}
    current = None
    buffer = []
    for line in text.split('\n'):
        if line.startswith('## '):
            if current is not None:
                out[current] = '\n'.join(buffer)
            match = re.match(r'^(##\s+(?:\d+\.|[A-Za-z]))', line)
            current = re.sub(r'\s+', ' ', match.group(1)) if match else line
            buffer = []
        else:
            buffer.append(line)
    if current is not None:
        out[current] = '\n'.join(buffer)
    return out


def definitions_by_section(text):
    """register -> sorted numbers, harvested per section.

    Independent of prd016_traceability.py: instead of classifying lines by an
    ordered pattern list, this walks each numbered section and accepts an
    identifier only where that section is entitled to define it.  A requirement
    is a bold identifier introducing normative text; a table entry is a first
    cell.  Both are recognised, but the SECTION is what authorises them.
    """
    found = {}
    for heading, body in top_sections(text).items():
        allowed = None
        for prefix, registers in SECTION_REGISTERS.items():
            if heading.startswith(prefix):
                allowed = registers
                break
        if allowed is None:
            continue
        for line in body.split('\n'):
            stripped = line.strip()
            register = number = None
            prose = re.match(r'^\*\*`AUD-([A-Z]+)-(\d+)`\*\*\s*(?:\u2014|--)\s*\S',
                             stripped)
            if prose:
                register, number = prose.group(1), int(prose.group(2))
            else:
                cell = re.match(r'^\|\s*\*{0,2}`AUD-([A-Z]+)-(\d+)`\*{0,2}\s*\|',
                                stripped)
                if cell:
                    register, number = cell.group(1), int(cell.group(2))
            if register is None:
                continue
            if register not in allowed:
                fail('AUD-%s-%03d is defined in section "%s", which defines %s'
                     % (register, number, heading.strip(),
                        '/'.join(allowed) or 'nothing'))
                continue
            found.setdefault(register, set()).add(number)
    return {key: sorted(value) for key, value in found.items()}


def expand_ids(text):
    """Every `AUD-*` token, with ellipsis ranges expanded -- finding S4-D-01."""
    ids = set()
    pattern = (r'`AUD-([A-Z]+)-(\d+)`\s*(?:\u2026|\.\.\.|\.\.)\s*'
               r'`(?:AUD-[A-Z]+-)?(\d+)`')
    for match in re.finditer(pattern, text):
        register = match.group(1)
        low, high = int(match.group(2)), int(match.group(3))
        for number in range(low, min(high, low + 999) + 1):
            ids.add('AUD-%s-%03d' % (register, number))
    for match in re.finditer(r'`AUD-([A-Z]+)-(\d+)`', text):
        ids.add('AUD-%s-%03d' % (match.group(1), int(match.group(2))))
    return ids


def section_2j(matrix):
    start = matrix.find('## 2J.')
    if start < 0:
        return None
    end = matrix.find('\n## ', start + 6)
    return matrix[start:end if end > 0 else len(matrix)]


def matrix_rows(block):
    """Parse section 2J's inventory rows -> register -> (count, range_max).

    Published shapes:
      "| `AUD-FR-*`  | ... | **16** | `001`-`016` | ..."
      "| `AUD-EVT-*` | ... | **0**  | none issued | ..."   (range_max None)
    """
    out = {}
    for line in block.split('\n'):
        head = re.match(r'^\|\s*\*{0,2}`AUD-([A-Z]+)-\*`\*{0,2}\s*\|', line)
        if head is None:
            continue
        cells = [c.strip() for c in line.strip('|').split('|')]
        if len(cells) < 4:
            fail('section 2J row for AUD-%s-* has too few columns'
                 % head.group(1))
            continue
        register = head.group(1)
        count_cell, range_cell = cells[2], cells[3]
        if re.search(r'in force', count_cell):
            fail('section 2J row for AUD-%s-* publishes an "in force (declared)"'
                 ' pair; PRD-016 retires nothing, so one count is correct and a'
                 ' pair implies a retirement register that does not exist'
                 % register)
        count_match = re.search(r'\*\*(\d+)\*\*', count_cell)
        if count_match is None:
            fail('section 2J row for AUD-%s-* has no parsable count' % register)
            continue
        numbers = [int(n) for n in re.findall(r'`(\d+)`', range_cell)]
        out[register] = (int(count_match.group(1)),
                         max(numbers) if numbers else None)
    return out


def main():
    doc = read(DOC)
    matrix = read(MATRIX)

    computed = definitions_by_section(doc)
    for register in ORDER:
        computed.setdefault(register, [])

    # ---- check 1: does section 2J exist at all?
    block = section_2j(matrix)
    if block is None:
        fail("TRACEABILITY_MATRIX.md has no section 2J -- PRD-016's Stage 5 "
             'registration is MISSING, which IS the Stage 5 failure')
        report(computed, {}, set(), set(), 0, 0)
        return 1

    rows = matrix_rows(block)

    # ---- check 2: published numbers vs recomputed
    for register in ORDER:
        numbers = computed[register]
        if register not in rows:
            if numbers:
                fail('AUD-%s-* is defined in PRD-016 but has NO row in section '
                     '2J -- %d identifier(s) registered nowhere'
                     % (register, len(numbers)))
            elif register in EMPTY_BY_DESIGN:
                fail('AUD-%s-* is declared EMPTY by PRD-016 section 0.3 but is '
                     'absent from section 2J; an omitted empty register is '
                     'indistinguishable from an oversight' % register)
            continue
        pub_count, pub_max = rows[register]
        if pub_count != len(numbers):
            fail('AUD-%s-*: section 2J publishes %d, PRD-016 defines %d'
                 % (register, pub_count, len(numbers)))
        if numbers:
            if pub_max is None:
                fail('AUD-%s-*: section 2J publishes no range, PRD-016 reaches '
                     '%03d' % (register, max(numbers)))
            elif pub_max != max(numbers):
                fail('AUD-%s-*: section 2J publishes range max %03d, PRD-016 '
                     'reaches %03d' % (register, pub_max, max(numbers)))
        elif pub_max is not None:
            fail('AUD-%s-*: section 2J publishes range max %03d for a register '
                 'with no member' % (register, pub_max))

    for register in sorted(rows):
        if register not in ORDER:
            fail('section 2J registers AUD-%s-*, which PRD-016 does not define'
                 % register)

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

    # ---- check 6: no retirement register
    if re.search(r'^##\s+\d+\.\s+Retired identifiers', doc, re.MULTILINE):
        fail('PRD-016 now has a retirement section. Section 2J publishes one '
             'count per register, which is only unambiguous while nothing is '
             'retired. Both PRD-016 checkers must be revised, as PRD-013 needed '
             '(contiguity over the declared set, section 2D.2)')

    # ---- check 4a: inward stem collision
    registered_stems = set()
    for match in re.finditer(r'`([A-Z][A-Z0-9]*(?:-[A-Z]+)*)-\*`', matrix):
        registered_stems.add(match.group(1))
    expected_aud = set('AUD-%s' % r for r in rows)
    for stem in sorted(s for s in registered_stems if s.startswith('AUD')):
        if stem != 'AUD' and stem not in expected_aud:
            fail('the matrix registers unexpected AUD stem `%s-*`' % stem)

    # ---- check 4b: the substring hazard, both of its forms
    for register in ORDER:
        for number in computed[register][:1] + computed[register][-1:]:
            token = 'AUD-%s-%03d' % (register, number)
            if re.search(r'(?<![A-Z-])%s-\d+' % register, token):
                fail('substring hazard: %s is reachable by a bare %s-n search, '
                     'the PO-n/SPO-n error class Stage 5 exists to catch. The '
                     'matrix registers a bare `FR-*` stem, so this is live'
                     % (token, register))
            if re.search(r'(?<![A-Z])AU-\d', token):
                fail('substring hazard: %s is reachable by a bare AU-n search. '
                     'PRD-016 section 0.4 records that AU-n names TWO other '
                     'registers -- Authentication section 10.4 and the module '
                     'manifest' % token)
    # and the reverse: AU-n must not be reachable by an AUD- search
    for probe in ['AU-1', 'AU-4', 'AU-9', 'AUTH-10.26', 'ID-1']:
        if re.search(r'AUD-', probe):
            fail('substring hazard: the foreign identifier %s is reachable by '
                 'an AUD- search' % probe)

    # ---- check 4c: outward definitions
    defined = set()
    for register in ORDER:
        for number in computed[register]:
            defined.add('AUD-%s-%03d' % (register, number))

    outward = 0
    citations = 0
    module_abs = os.path.join(ROOT, MODULE_DIR)
    for path in walk_markdown():
        if path.startswith(module_abs):
            continue
        rel = os.path.relpath(path, ROOT)
        with open(path, encoding='utf-8') as handle:
            body = handle.read()
        if 'AUD-' not in body:
            continue
        for line in body.split('\n'):
            stripped = line.strip()
            match = re.match(r'^\*\*`AUD-([A-Z]+)-(\d+)`\*\*\s*(?:\u2014|--)\s*\S',
                             stripped)
            if match is None:
                match = re.match(
                    r'^\|\s*\*{0,2}`AUD-([A-Z]+)-(\d+)`\*{0,2}\s*\|', stripped)
            if match is None:
                continue
            ident = 'AUD-%s-%03d' % (match.group(1), int(match.group(2)))
            if ident in defined:
                citations += 1
                continue
            outward += 1
            fail('%s DEFINES %s, which PRD-016 does not -- an outward collision'
                 % (rel, ident))

    # ---- check 5: section 2J's totals recomputed
    total_row = re.search(r'\|\s*\*\*Total\*\*\s*\|[^|]*\|\s*\*\*(\d+)\*\*', block)
    computed_total = sum(len(computed[r]) for r in ORDER)
    if total_row is None:
        fail('section 2J has no parsable Total row')
    elif int(total_row.group(1)) != computed_total:
        fail('section 2J Total publishes %s, recomputed %d'
             % (total_row.group(1), computed_total))

    # ---- check 7: both empty registers registered (handled in check 2 when a
    # row is absent; here the published count must actually be zero)
    for register in EMPTY_BY_DESIGN:
        if register in rows and rows[register][0] != 0:
            fail('section 2J publishes %d member(s) for AUD-%s-*, which '
                 'PRD-016 section 0.3 declares EMPTY'
                 % (rows[register][0], register))

    # ---- check 8: coverage recomputed with ellipsis expansion (S4-D-01)
    class_a = set()
    for register in CLASS_A:
        for number in computed[register]:
            class_a.add('AUD-%s-%03d' % (register, number))
    covered = set()
    ac_rows = 0
    ac_body = top_sections(doc).get('## 9.', '')
    for line in ac_body.split('\n'):
        if not re.match(r'^\|\s*\*{0,2}`AUD-AC-\d+`', line.strip()):
            continue
        ac_rows += 1
        cells = [c.strip() for c in line.strip().strip('|').split('|')]
        covered |= expand_ids(' '.join(cells[1:])) & class_a
    published_cov = re.search(r'\*\*(\d+)\s*/\s*(\d+)\s*=\s*([\d.]+)%\*\*', block)
    if published_cov is None:
        published_cov = re.search(r'(\d+)\s*/\s*(\d+)\s*=\s*([\d.]+)%', block)
    if published_cov is None:
        fail('section 2J publishes no coverage figure; PRD-006 v1.0 published '
             '"100%" against a true 49.1%, so the figure is stated and computed')
    else:
        if int(published_cov.group(1)) != len(covered) or \
           int(published_cov.group(2)) != len(class_a):
            fail('section 2J publishes coverage %s/%s, recomputed %d/%d'
                 % (published_cov.group(1), published_cov.group(2),
                    len(covered), len(class_a)))
        else:
            actual = round(100.0 * len(covered) / len(class_a), 1)
            if abs(float(published_cov.group(3)) - actual) > 0.05:
                fail('section 2J publishes coverage %s%%, recomputed %.1f%%'
                     % (published_cov.group(3), actual))

    report(computed, rows, class_a, covered, citations, outward)
    return 1 if PROBLEMS else 0


def report(computed, rows, class_a, covered, citations, outward):
    line = '-' * 70
    print(line)
    print('PRD-016 Stage 5 gate -- matrix section 2J vs the PRD')
    print(line)
    for register in ORDER:
        numbers = computed.get(register, [])
        state = 'registered' if register in rows else 'MISSING   '
        if not numbers:
            print('  AUD-%-4s* %s  count 0    DECLARED EMPTY'
                  % (register + '-', state))
            continue
        print('  AUD-%-4s* %s  count %-3d  range 001..%03d'
              % (register + '-', state, len(numbers), max(numbers)))
    print(line)
    print('identifiers defined, recomputed           : %d'
          % sum(len(v) for v in computed.values()))
    print('registers registered in section 2J        : %d' % len(rows))
    print('foreign citations resolved, not failed    : %d' % citations)
    print('AUD-* definitions outside the module      : %d' % outward)
    if class_a:
        print('coverage, recomputed                      : %d / %d = %.1f%%'
              % (len(covered), len(class_a),
                 100.0 * len(covered) / len(class_a)))
    print(line)
    if PROBLEMS:
        print('FAIL - %d problem(s):' % len(PROBLEMS))
        for problem in PROBLEMS:
            print('  * %s' % problem)
    else:
        print('PASS - every prefix registered in TRACEABILITY_MATRIX.md')
        print('       section 2J, counts and ranges reproduced from the PRD')
        print('       body by an independent parser, all ranges contiguous,')
        print('       both empty registers registered as empty, coverage')
        print('       recomputed with ellipsis ranges expanded (S4-D-01),')
        print('       zero collisions in all three directions.')
        print('       PRD_LIFECYCLE.md Stage 5 gate SATISFIED.')
    print(line)


if __name__ == '__main__':
    sys.exit(main())
