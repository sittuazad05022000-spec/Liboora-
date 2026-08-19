#!/usr/bin/env python3
"""PRD-014 Stage 5 gate -- does TRACEABILITY_MATRIX.md agree with the PRD?

WHY THIS EXISTS
---------------
`PRD_LIFECYCLE.md` Stage 5 states its gate as:

    "the PRD's prefixes registered in TRACEABILITY_MATRIX.md section 2 with
     counts and ranges, verified mechanically, zero collisions.

     Mechanical means counted by a tool, not by reading."

`prd014_traceability.py` checks `PRD-014` against **itself** and never opens the
matrix, so without this script section 2K could have been written with any
numbers in it and nothing would have objected.  This is the second of the two
scripts the `PRD-008` pattern requires (`prd008_traceability.py` plus
`prd008_stage5.py`, repeated for `PRD-013` and `PRD-016`), and it is
deliberately **not** an import of the first: the two recompute the register
independently, so a bug in one does not propagate silently into the other.
Two declarations, one subject.

It adds a check and weakens nothing.  `prd014_traceability.py` is untouched and
must continue to pass on its own.

INDEPENDENCE IS STRUCTURAL, NOT PROMISED
----------------------------------------
`TRACEABILITY_MATRIX.md` section 2H.2 names the failure mode this pair exists to
avoid: "a checker written in the same pass as the register it checks, by the
same author, verifies agreement with itself."  Two mitigations are applied:

  * No import.  This file re-derives every register from the PRD body with its
    own parser.  A defect in one parser cannot be inherited by the other.
  * A DIFFERENT parsing strategy.  `prd014_traceability.py` classifies each line
    by matching an ordered list of line-start patterns, then masks one section
    by name.  This script instead splits the document into scopes at BOTH `## `
    and `### ` headings and accepts an identifier only where that scope is
    entitled to define it.  The two arrive at 88 by structurally different
    routes, which is evidence; agreement by one route repeated twice would not
    be.

    The difference is load-bearing rather than cosmetic.  The section-scope
    parser catches a class the line parser cannot see at all: a register defined
    in a section that has no business defining it -- for instance an
    `ENT-INV-*` appearing inside section 9 Exclusions.  Conversely the line
    parser catches a shape this one would miss.  Neither subsumes the other.

    It also resolves the section 10.1 hazard *by position instead of by name*.
    `prd014_traceability.py` must mask "### 10.1 Coverage" explicitly, because
    10.1's reverse-coverage table opens rows with `ENT-FR-017` and the line rule
    cannot tell that cell from a definition.  Here 10.1 is simply a scope that
    is not entitled to define anything, which is the same conclusion reached
    without hardcoding a section title as an exception.

WHAT MADE THIS MODULE DIFFERENT FROM PRD-016
--------------------------------------------
`PRD-016` publishes its section 0.2 registers as RANGE SPANS in the first cell;
`PRD-014` publishes a BARE PREFIX in the first cell with the range in cell 3.
The inherited section-0.2 parser therefore yields zero declared registers
against this document -- a catastrophic false FAIL.  That is recorded as finding
`S5-C-01` of the Stage 5 conferral record.  This script does not read section
0.2 at all; it recomputes from the body, so it is immune to that shape by
construction and provides a genuinely independent second opinion on the counts.

`PRD-014` retires **nothing**, so section 2K publishes ONE count per register.
That simplicity is itself checked: check 6 asserts no retirement register has
appeared, because if one ever does, a single published count silently becomes
ambiguous and both scripts must be revised before the gate can be trusted again.

Two registers -- `ENT-EVT-*` and `ENT-CFG-*` -- hold no member by design.  They
must be REGISTERED AS EMPTY rather than omitted (check 7).  An omitted empty
register is indistinguishable from an oversight; a registered one records the
decision.  Neither has any identifier issued at all, so their range cells state
no number, and the parser must accept that shape without inventing a maximum
of 0.

THE COLLISION HAZARDS THIS MODULE CARRIES
-----------------------------------------
  * `INV-1`...`INV-16` are **platform invariants** registered at this matrix's
    L82, and `INV-SEC-*` / `INV-XC-*` exist too.  `ENT-INV-*` must not be
    reachable by a word-boundary search for a bare `INV-\\d+`, or a naive scan
    over-counts.  Checked in check 4b, both directions.
  * The matrix registers a bare **`FR-*`** stem from the Authentication chapter
    map, so the `PO-n`/`SPO-n` error class Stage 5 names as its reason for
    existing is not hypothetical here either.  Also checked in 4b.
  * `ENT-` versus the tail of `MANAGEMENT-`: an unanchored `ENT-` search matches
    inside `MANAGEMENT-R...`.  Every pattern here is anchored on a word
    boundary before `ENT-`.

WHAT IT CHECKS
--------------
1. Section 2K exists.  Its absence IS the Stage 5 failure, so it is reported as
   such rather than as a missing section.
2. Every register `PRD-014` defines has a row in section 2K whose count and
   range maximum agree with values recomputed from the PRD body, and section 2K
   registers nothing the PRD does not define.
3. Every range is contiguous 1..max.
4. Zero collisions, in three directions:
   (a) inward -- no `ENT-<REG>` stem collides with a prefix already registered
       elsewhere in the matrix;
   (b) the substring hazard -- `ENT-INV-001` must not be reachable by a
       word-boundary search for a bare `INV-001`, nor `ENT-FR-001` by `FR-001`,
       and `ENT-` must not be reachable inside `MANAGEMENT-`;
   (c) outward -- no document outside `docs/30-product/entitlement/` and
       `docs/40-implementation/entitlement/` DEFINES an `ENT-*` identifier.  A
       citation is not a collision (section 2C.1), so each outside occurrence is
       resolved against the defined set rather than counted as a failure.
5. Section 2K's own totals arithmetic is recomputed, not trusted.
6. No retirement register exists, and section 2K does not publish an
   "in force (declared)" pair that would imply one.
7. Both empty registers appear in section 2K.
8. Section 2K's published coverage figure is recomputed from the PRD, with
   ellipsis ranges expanded per finding `S4-D-01` of the `PRD-016` review.

Exit 0 = Stage 5 gate satisfied.  Exit 1 = it is not.
"""

import os
import re
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DOC = os.path.join('docs', '30-product', 'entitlement', 'PRD-014_ENTITLEMENT.md')
MATRIX = os.path.join('docs', '40-implementation', 'TRACEABILITY_MATRIX.md')

# Directories entitled to DEFINE an ENT-* identifier.
OWNED_DIRS = [
    os.path.join('docs', '30-product', 'entitlement'),
    os.path.join('docs', '40-implementation', 'entitlement'),
]

ORDER = ['FR', 'BR', 'INV', 'EVT', 'XC', 'CFG', 'AC', 'GAP']
CLASS_A = ['FR', 'BR', 'INV', 'EVT', 'XC']
EMPTY_BY_DESIGN = ['EVT', 'CFG']

# Which scope may define which register.  A scope not listed here defines
# NOTHING -- section 0.x, 7.1, 10.1, 11, 13, 14, 15, 16 all cite without
# defining.  This is the authorisation table the whole parser turns on.
SCOPE_REGISTERS = {
    '## 2.': ['FR'],    # the aggregate
    '## 3.': ['FR'],    # derivation and inputs
    '## 4.': ['FR'],    # the E-17 port
    '## 5.': ['BR'],    # business rules
    '## 6.': ['INV'],   # invariants
    '## 7.': ['FR'],    # events and integration
    '## 8.': ['FR'],    # query and access
    '## 9.': ['XC'],    # exclusions
    '## 10.': ['AC'],   # acceptance criteria
    '## 12.': ['GAP'],  # open gaps
}

# Scopes that carry identifier-shaped table rows but define nothing.  Listed so
# that an unexpected definition elsewhere still FAILS rather than being ignored.
CITING_SCOPES = ['### 7.1', '### 10.1', '### 0.']

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


def scopes(text):
    """Split into scopes at BOTH '## ' and '### ' -> [(key, body)].

    Splitting at the deeper level is what makes 10.1 and 7.1 separate scopes
    rather than part of 10 and 7, and is the structural difference from
    prd014_traceability.py's line-form approach.
    """
    out = []
    key = None
    buffer = []
    for line in text.split('\n'):
        if line.startswith('## ') or line.startswith('### '):
            if key is not None:
                out.append((key, '\n'.join(buffer)))
            match = re.match(r'^(#{2,3}\s+(?:\d+(?:\.\d+)?\.?|[A-Za-z]))', line)
            key = re.sub(r'\s+', ' ', match.group(1)) if match else line
            buffer = []
        else:
            buffer.append(line)
    if key is not None:
        out.append((key, '\n'.join(buffer)))
    return out


def definitions_by_scope(text):
    """register -> sorted numbers, harvested per scope."""
    found = {}
    seen_scopes = set()
    for key, body in scopes(text):
        allowed = None
        for prefix, registers in SCOPE_REGISTERS.items():
            # '## 10.' must not be matched by '## 1.'  -- compare on the full
            # normalised key, which already carries its trailing dot.
            if key == prefix.rstrip() or key.startswith(prefix):
                allowed = registers
                seen_scopes.add(prefix)
                break
        citing = any(key.startswith(c) for c in CITING_SCOPES)
        for line in body.split('\n'):
            stripped = line.strip()
            register = number = None
            prose = re.match(r'^\*\*`ENT-([A-Z]+)-(\d+)`\*\*\s*(?:\u2014|--)\s*\S',
                             stripped)
            if prose:
                register, number = prose.group(1), int(prose.group(2))
            else:
                cell = re.match(r'^\|\s*\*{0,2}`ENT-([A-Z]+)-(\d+)`\*{0,2}\s*\|',
                                stripped)
                if cell:
                    register, number = cell.group(1), int(cell.group(2))
            if register is None:
                continue
            if citing:
                continue
            if allowed is None:
                fail('ENT-%s-%03d appears in definition position in scope "%s", '
                     'which is not entitled to define any register'
                     % (register, number, key))
                continue
            if register not in allowed:
                fail('ENT-%s-%03d is defined in scope "%s", which defines %s'
                     % (register, number, key, '/'.join(allowed)))
                continue
            found.setdefault(register, set()).add(number)

    missing = sorted(set(SCOPE_REGISTERS) - seen_scopes)
    if missing:
        fail('the PRD has no scope matching %s -- the authorisation table no '
             'longer describes the document, so a register could be defined '
             'nowhere this parser looks' % ', '.join(repr(m) for m in missing))
    return {key: sorted(value) for key, value in found.items()}


def expand_ids(text):
    """Every `ENT-*` token, with ellipsis ranges expanded -- finding S4-D-01."""
    ids = set()
    pattern = (r'`ENT-([A-Z]+)-(\d+)`\s*(?:\u2026|\.\.\.|\.\.)\s*'
               r'`(?:ENT-[A-Z]+-)?(\d+)`')
    for match in re.finditer(pattern, text):
        register = match.group(1)
        low, high = int(match.group(2)), int(match.group(3))
        for number in range(low, min(high, low + 999) + 1):
            ids.add('ENT-%s-%03d' % (register, number))
    for match in re.finditer(r'`ENT-([A-Z]+)-(\d+)`', text):
        ids.add('ENT-%s-%03d' % (match.group(1), int(match.group(2))))
    return ids


def section_2k(matrix):
    start = matrix.find('## 2K.')
    if start < 0:
        return None
    end = matrix.find('\n## ', start + 6)
    return matrix[start:end if end > 0 else len(matrix)]


def matrix_rows(block):
    """Parse section 2K's inventory rows -> register -> (count, range_max).

    Published shapes:
      "| `ENT-FR-*`  | ... | **28** | `001`-`028` | ..."
      "| `ENT-EVT-*` | ... | **0**  | none issued | ..."   (range_max None)
    """
    out = {}
    for line in block.split('\n'):
        head = re.match(r'^\|\s*\*{0,2}`ENT-([A-Z]+)-\*`\*{0,2}\s*\|', line)
        if head is None:
            continue
        cells = [c.strip() for c in line.strip('|').split('|')]
        if len(cells) < 4:
            fail('section 2K row for ENT-%s-* has too few columns' % head.group(1))
            continue
        register = head.group(1)
        count_cell, range_cell = cells[2], cells[3]
        if re.search(r'in force', count_cell):
            fail('section 2K row for ENT-%s-* publishes an "in force (declared)"'
                 ' pair; PRD-014 retires nothing, so one count is correct and a'
                 ' pair implies a retirement register that does not exist'
                 % register)
        count_match = re.search(r'\*\*(\d+)\*\*', count_cell)
        if count_match is None:
            fail('section 2K row for ENT-%s-* has no parsable count' % register)
            continue
        numbers = [int(n) for n in re.findall(r'`(\d+)`', range_cell)]
        out[register] = (int(count_match.group(1)),
                         max(numbers) if numbers else None)
    return out


def main():
    doc = read(DOC)
    matrix = read(MATRIX)

    computed = definitions_by_scope(doc)

    # ---- check 1: does section 2K exist at all?
    block = section_2k(matrix)
    if block is None:
        fail('TRACEABILITY_MATRIX.md has no section 2K -- the Stage 5 gate is '
             'not satisfied. The gate is the registration, not the intention '
             'to register')
        report(computed, {}, set(), set(), 0, [])
        return 1

    rows = matrix_rows(block)
    if not rows:
        fail('section 2K exists but registers no ENT- prefix row -- a section '
             'that registers nothing satisfies nothing')

    # ---- check 2: published numbers vs recomputed
    for register in ORDER:
        numbers = computed.get(register, [])
        if register not in rows:
            fail('ENT-%s-* is defined %d time(s) in PRD-014 but has no row in '
                 'section 2K' % (register, len(numbers)))
            continue
        pub_count, pub_max = rows[register]
        if pub_count != len(numbers):
            fail('ENT-%s-*: section 2K publishes count %d, recomputed %d'
                 % (register, pub_count, len(numbers)))
        if numbers:
            if pub_max is None:
                fail('ENT-%s-* has %d member(s) but section 2K publishes no '
                     'range' % (register, len(numbers)))
            elif pub_max != max(numbers):
                fail('ENT-%s-*: section 2K publishes range max %03d, '
                     'recomputed %03d' % (register, pub_max, max(numbers)))
        elif pub_max is not None:
            fail('ENT-%s-* is empty but section 2K publishes a range max of %s'
                 % (register, pub_max))

    for register in sorted(rows):
        if register not in ORDER:
            fail('section 2K registers ENT-%s-*, which PRD-014 does not define'
                 % register)

    # ---- check 3: contiguity
    for register in ORDER:
        numbers = computed.get(register, [])
        if not numbers:
            continue
        expected = list(range(1, max(numbers) + 1))
        if numbers != expected:
            missing = sorted(set(expected) - set(numbers))
            fail('ENT-%s-* is not contiguous: missing %s'
                 % (register, ', '.join('%03d' % m for m in missing)))

    # ---- check 6: no retirement register
    if re.search(r'^##\s+\d+\.\s+Retired identifiers', doc, re.MULTILINE):
        fail('PRD-014 now has a retirement section, so a single published count '
             'per register is ambiguous. Both this script and '
             'prd014_traceability.py must be revised before the gate is safe')

    # ---- check 4a: inward stem collision against every prefix the matrix
    #      already registers
    registered_stems = set()
    for line in matrix.split('\n'):
        for match in re.finditer(r'`([A-Z][A-Z0-9]*(?:-[A-Z]+)*)-\*`', line):
            registered_stems.add(match.group(1))
    for register in ORDER:
        stem = 'ENT-%s' % register
        if stem in registered_stems and section_2k(matrix) and stem not in block:
            fail('%s-* is registered elsewhere in the matrix, outside section 2K'
                 % stem)
    if 'ENT' in registered_stems:
        fail('a bare `ENT-*` stem is registered in the matrix; PRD-014 declares '
             'eight sub-registers and no bare register')

    # ---- check 4b: the substring hazard, in both directions
    hazards = [
        (r'(?<![A-Z-])INV-\d+', 'ENT-INV-001',
         'a bare INV-n platform-invariant register exists (matrix L82)'),
        (r'(?<![A-Z-])FR-\d+', 'ENT-FR-001',
         'a bare FR-* register exists (Authentication chapter map)'),
        (r'(?<![A-Z-])AC-\d+', 'ENT-AC-001', 'a bare AC-* form is conceivable'),
    ]
    for pattern, sample, why in hazards:
        if re.search(pattern, sample):
            fail('%s is reachable by a word-boundary search for %r -- %s, so '
                 'the two registers could be confused' % (sample, pattern, why))
    # reverse direction: an unanchored ENT- search matches inside MANAGEMENT-
    if not re.search(r'\bENT-FR-001\b', 'MANAGEMENT-ENT') and \
            re.search(r'ENT-', 'MANAGEMENT-ENT-FR-001'):
        # this is expected; assert the ANCHORED form does NOT match
        if re.search(r'(?<![A-Z])ENT-', 'MANAGEMENT-ENT-FR-001'):
            fail('an anchored ENT- search still matches inside MANAGEMENT- -- '
                 'every scan in this pass would over-count')

    # ---- check 4c: outward definitions
    defined = set()
    for register in ORDER:
        for number in computed.get(register, []):
            defined.add('ENT-%s-%03d' % (register, number))

    outward = []
    citations = 0
    for path in walk_markdown():
        rel = os.path.relpath(path, ROOT)
        if any(rel.startswith(owned) for owned in OWNED_DIRS):
            continue
        text = read(rel)
        for lineno, line in enumerate(text.split('\n'), 1):
            for pattern in [r'^\*\*`ENT-([A-Z]+)-(\d+)`\*\*\s*(?:\u2014|--)\s*\S',
                            r'^\|\s*\*{0,2}`ENT-([A-Z]+)-(\d+)`\*{0,2}\s*\|']:
                match = re.match(pattern, line.strip())
                if match:
                    ident = 'ENT-%s-%03d' % (match.group(1), int(match.group(2)))
                    # The matrix's own section 2K is a registration, not a
                    # definition; it is the document under test.
                    if rel == MATRIX:
                        break
                    outward.append((rel, lineno, ident))
                    break
        found = expand_ids(text)
        citations += len(found)
        for ident in sorted(found - defined):
            fail('%s is cited in %s but is defined nowhere in PRD-014'
                 % (ident, rel))
    for rel, lineno, ident in outward:
        fail('%s is DEFINED at %s:%d, outside the entitlement module -- a '
             'definition outside the owning module is a collision, though a '
             'mere citation is not' % (ident, rel, lineno))

    # ---- check 5: section 2K's totals recomputed
    total = sum(len(computed.get(r, [])) for r in ORDER)
    total_row = re.search(r'\|\s*\*{0,2}Total\*{0,2}\s*\|[^|]*\|\s*\*\*(\d+)\*\*',
                          block)
    if total_row is None:
        fail('section 2K publishes no parsable Total row, so its arithmetic '
             'cannot be recomputed')
    elif int(total_row.group(1)) != total:
        fail('section 2K publishes total %s, recomputed %d'
             % (total_row.group(1), total))

    # ---- check 7: both empty registers registered as empty
    for register in EMPTY_BY_DESIGN:
        if register not in rows:
            fail('ENT-%s-* is empty by design but has no row in section 2K. An '
                 'omitted empty register is indistinguishable from an oversight'
                 % register)
            continue
        if rows[register][0] != 0:
            fail('section 2K publishes %d for ENT-%s-*, which is empty by design'
                 % (rows[register][0], register))
        if 'EMPTY' not in block.split('`ENT-%s-*`' % register)[1][:1200].upper():
            fail('section 2K\'s ENT-%s-* row does not state that it is DECLARED '
                 'EMPTY, so the emptiness reads as an omission' % register)

    # ---- check 8: coverage recomputed with ellipsis expansion
    class_a = set()
    for register in CLASS_A:
        for number in computed.get(register, []):
            class_a.add('ENT-%s-%03d' % (register, number))
    covered = set()
    ac_rows = 0
    for key, body in scopes(doc):
        if not key.startswith('## 10.'):
            continue
        for line in body.split('\n'):
            if not re.match(r'^\|\s*\*{0,2}`ENT-AC-\d+`', line.strip()):
                continue
            ac_rows += 1
            cells = [c.strip() for c in line.strip().strip('|').split('|')]
            traces = expand_ids(' '.join(cells[1:]))
            covered |= {i for i in traces if i in class_a}
    if class_a:
        pct = 100.0 * len(covered) / len(class_a)
        published = re.search(r'\*\*(\d+)\s*/\s*(\d+)\s*=\s*([\d.]+)\s*%\*\*', block)
        if published is None:
            published = re.search(r'\*\*([\d.]+)\s*%\*\*', block)
            if published is None:
                fail('section 2K publishes no parsable coverage figure')
            elif abs(float(published.group(1)) - pct) > 0.05:
                fail('section 2K publishes coverage %s%%, recomputed %.1f%%'
                     % (published.group(1), pct))
        else:
            if int(published.group(1)) != len(covered) or \
                    int(published.group(2)) != len(class_a):
                fail('section 2K publishes coverage %s/%s, recomputed %d/%d'
                     % (published.group(1), published.group(2),
                        len(covered), len(class_a)))
            if abs(float(published.group(3)) - pct) > 0.05:
                fail('section 2K publishes %s%%, recomputed %.1f%%'
                     % (published.group(3), pct))

    report(computed, rows, class_a, covered, citations, outward)
    return 1 if PROBLEMS else 0


def report(computed, rows, class_a, covered, citations, outward):
    line = '-' * 70
    print(line)
    print('PRD-014 Stage 5 gate -- section 2K against a recomputation')
    print(line)
    total = 0
    for register in ORDER:
        numbers = computed.get(register, [])
        total += len(numbers)
        state = 'in 2K' if register in rows else 'NOT IN 2K'
        if not numbers:
            print('  ENT-%-4s* %-10s DECLARED EMPTY' % (register + '-', state))
            continue
        print('  ENT-%-4s* %-10s count %-3d range 001..%03d  contiguous'
              % (register + '-', state, len(numbers), max(numbers)))
    print(line)
    print('identifiers recomputed from the PRD body : %d' % total)
    print('rows registered in section 2K            : %d' % len(rows))
    if class_a:
        print('Class A obligations                      : %d' % len(class_a))
        print('coverage                                 : %d / %d = %.1f%%'
              % (len(covered), len(class_a),
                 100.0 * len(covered) / len(class_a)))
    print('ENT- citations outside the module        : %d' % citations)
    print('ENT- DEFINITIONS outside the module      : %d' % len(outward))
    print(line)
    if PROBLEMS:
        print('FAIL - %d problem(s):' % len(PROBLEMS))
        for problem in PROBLEMS:
            print('  * %s' % problem)
    else:
        print('PASS - section 2K registers every register PRD-014 defines and')
        print('       nothing it does not, counts and ranges reproduce from an')
        print('       independent recomputation, all ranges contiguous, zero')
        print('       collisions inward, outward and by substring, both empty')
        print('       registers registered as empty, totals and coverage')
        print('       arithmetic recomputed.')
    print(line)
    return 0


if __name__ == '__main__':
    sys.exit(main())
