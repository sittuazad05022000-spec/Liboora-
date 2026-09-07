#!/usr/bin/env python3
"""PRD-023 Stage 5 gate -- does TRACEABILITY_MATRIX.md agree with the PRD?

WHY THIS EXISTS
---------------
`PRD_LIFECYCLE.md` Stage 5 states its gate as:

    "the PRD's prefixes registered in TRACEABILITY_MATRIX.md section 2 with
     counts and ranges, verified mechanically, zero collisions.

     Mechanical means counted by a tool, not by reading."

`prd023_traceability.py` checks `PRD-023` against **itself** and never opens the
matrix, so without this script section 2L could have been written with any
numbers in it and nothing would have objected.  This is the second of the two
scripts the `PRD-008` pattern requires (`prd008_traceability.py` plus
`prd008_stage5.py`, repeated for `PRD-013`, `PRD-016` and `PRD-014`), and it is
deliberately **not** an import of the first: the two recompute the register
independently, so a bug in one does not propagate silently into the other.
Two declarations, one subject.

It adds a check and weakens nothing.  All twenty-one pre-existing scripts under
`tool/docs_check/` are untouched and must continue to behave exactly as before.

INDEPENDENCE IS STRUCTURAL, NOT PROMISED
----------------------------------------
`TRACEABILITY_MATRIX.md` section 2H.2 names the failure mode this pair exists to
avoid: "a checker written in the same pass as the register it checks, by the
same author, verifies agreement with itself."  Two mitigations are applied:

  * No import.  This file re-derives every register from the PRD body with its
    own parser.  A defect in one parser cannot be inherited by the other.
  * A DIFFERENT parsing strategy.  `prd023_traceability.py` classifies each line
    by line-start form.  This script splits the document into scopes at BOTH
    `## ` and `### ` and accepts an identifier only where that scope is
    ENTITLED to define it.  The two arrive at 180 by structurally different
    routes, which is evidence; agreement by one route repeated twice would not
    be.

    The difference is load-bearing rather than cosmetic.  The scope parser
    catches a class the line parser cannot see at all: a register defined in a
    section that has no business defining it -- for instance a `CNF-INV-*`
    appearing inside section 12 UI/UX, or a `CNF-FR-*` minted inside the
    acceptance-criteria section.  Conversely the line parser catches shapes this
    one would miss.  Neither subsumes the other.

WHAT MADE THIS MODULE DIFFERENT FROM ITS FOUR PREDECESSORS
----------------------------------------------------------
1. **The registers are spread across FAR more scopes than any predecessor.**
   `PRD-014` defines `ENT-FR-*` in six sections; `PRD-023` defines `CNF-FR-*` in
   TWENTY-ONE, because the settings hierarchy, the `E-19` contract, flags,
   branding, secrets, audit, authority, isolation, observability and UI each
   carry functional requirements.  The authorisation table below is therefore
   long, and it is derived from a measurement of the document rather than
   guessed -- see `SCOPE_REGISTERS`.

2. **`CNF-CFG-*` is empty while `CFG-1`...`CFG-12` is an OCCUPIED register**
   owned by `PRD-001`.  Every predecessor's substring hazard was hypothetical
   in at least one direction.  This one is live: `CFG-` is a real prefix with
   real members, and `CNF-CFG-001` must not be reachable by a search for it.

3. **`INV-1`...`INV-16` are this module's SUBJECT MATTER**, not merely a
   neighbouring register.  Section 5 is about enforcing them and cites them
   throughout while also defining `CNF-INV-001`...`CNF-INV-004`.

4. **Both empty registers must stay empty.**  The Stage 5 mandate is explicit:
   numbered `CNF-EVT-*` or `CNF-CFG-*` members may not be created unless
   authoritative evidence requires them.  Check 7 enforces that as a test.

WHAT IT CHECKS
--------------
1. Section 2L exists.  Its absence IS the Stage 5 failure, so it is reported as
   such rather than as a missing section.
2. Every register `PRD-023` defines has a row in section 2L whose count and
   range maximum agree with values recomputed from the PRD body, and section 2L
   registers nothing the PRD does not define.
3. Every range is contiguous 1..max.
4. Zero collisions, in three directions:
   (a) inward -- no `CNF-<REG>` stem collides with a prefix already registered
       elsewhere in the matrix, and no bare `CNF-<n>` identifier exists;
   (b) the substring hazard -- `CNF-CFG-001` must not be reachable by a search
       for a bare `CFG-001`, nor `CNF-INV-001` by `INV-001`, tested in both
       directions so the test cannot become vacuous;
   (c) outward -- no document outside the configuration module DEFINES a
       `CNF-*` identifier.  A citation is not a collision (section 2C.1), so
       each outside occurrence is resolved against the defined set rather than
       counted as a failure.
5. Section 2L's own totals arithmetic is recomputed, not trusted.
6. No retirement register exists, and section 2L does not publish an
   "in force (declared)" pair that would imply one.
7. Both empty registers appear in section 2L, are published as 0, are stated to
   be DECLARED EMPTY, and hold no member in the PRD.
8. Section 2L's published coverage figure is recomputed from the PRD, with
   ellipsis ranges expanded.
9. The four traceability directions Stage 5 requires are each present and
   non-vacuous: to authoritative source, to architecture decision, to
   acceptance criterion, to implementation task.

Exit 0 = Stage 5 gate satisfied.  Exit 1 = it is not.
"""

import os
import re
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DOC = os.path.join('docs', '30-product', 'configuration',
                   'PRD-023_SETTINGS_AND_CONFIGURATION.md')
MATRIX = os.path.join('docs', '40-implementation', 'TRACEABILITY_MATRIX.md')

# Directories entitled to DEFINE a CNF-* identifier.
OWNED_DIRS = [
    os.path.join('docs', '30-product', 'configuration'),
    os.path.join('docs', '40-implementation', 'configuration'),
]

ORDER = ['FR', 'BR', 'INV', 'EVT', 'XC', 'CFG', 'AC', 'GAP']
CLASS_A = ['FR', 'BR', 'INV', 'EVT', 'XC']
EMPTY_BY_DESIGN = ['EVT', 'CFG']

# Which scope may define which register.  Measured from the document, not
# assumed: every entry below corresponds to a scope in which at least one
# definition was found, and check "authorisation table still describes the
# document" fails if any listed scope disappears.  A scope NOT listed here
# defines NOTHING -- sections 0.x, 1.x, 15, 16 and 17 cite without defining.
SCOPE_REGISTERS = {
    '## 2.': ['FR'],            # settings vs configuration
    '### 2.1': ['FR'],
    '### 2.2': ['FR'],
    '### 2.3': ['FR'],
    '### 3.1': ['FR'],          # the hierarchy
    '### 3.2': ['FR'],
    '### 3.3': ['FR'],
    '### 3.4': ['FR'],
    '### 3.5': ['FR'],
    '### 3.6': ['FR', 'XC'],
    '### 4.2': ['FR'],          # the E-19 typed-accessor contract
    '### 4.3': ['FR'],
    '### 4.4': ['FR'],
    '### 4.5': ['FR'],
    '## 5.': ['FR', 'INV', 'XC'],   # invariant enforcement
    '### 6.1': ['FR'],          # feature flags
    '### 6.2': ['BR', 'XC'],
    '### 6.3': ['BR'],
    '### 7.1': ['FR', 'XC'],    # branding values
    '### 7.2': ['FR', 'XC', 'GAP'],  # secret references
    '## 8.': ['FR', 'BR', 'XC'],     # change history and audit
    '### 9.1': ['FR'],          # permissions and write authority
    '### 9.2': ['BR', 'XC'],
    '### 10.2': ['FR', 'INV', 'XC'],  # tenant isolation
    '### 11.1': ['FR', 'BR'],   # observability
    '### 11.2': ['XC'],
    '### 12.1': ['FR'],         # UI/UX
    '### 12.2': ['XC'],
    '### 13.1': ['AC'],         # acceptance criteria
    '### 13.2': ['AC'],
    '### 13.3': ['AC'],
    '### 13.4': ['AC'],
    '### 13.5': ['AC'],
    '### 13.6': ['AC'],
    '### 13.7': ['AC'],
    '### 13.8': ['AC'],
    '### 13.9': ['AC'],
    '## 14.': ['GAP'],          # open gaps -- an INDEX, see below
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


def scopes(text):
    """Split into scopes at BOTH '## ' and '### ' -> [(key, body)].

    Splitting at the deeper level is what makes 13.1 and 7.2 separate scopes
    rather than part of 13 and 7, and is the structural difference from
    prd023_traceability.py's line-form approach.
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
    index_gaps = set()
    for key, body in scopes(text):
        allowed = None
        matched = None
        # Longest-prefix match, so '### 13.1' is not captured by '## 13.'
        for prefix in sorted(SCOPE_REGISTERS, key=len, reverse=True):
            if key == prefix.rstrip() or key.startswith(prefix):
                allowed = SCOPE_REGISTERS[prefix]
                matched = prefix
                seen_scopes.add(prefix)
                break
        for line in body.split('\n'):
            stripped = line.strip()
            register = number = None
            prose = re.match(r'^\*\*`CNF-([A-Z]+)-(\d+)`\*\*\s*(?:\u2014|--)\s*\S',
                             stripped)
            if prose:
                register, number = prose.group(1), int(prose.group(2))
            else:
                cell = re.match(r'^\|\s*\*{0,2}`CNF-([A-Z]+)-(\d+)`\*{0,2}\s*\|',
                                stripped)
                if cell:
                    register, number = cell.group(1), int(cell.group(2))
            if register is None:
                continue
            if allowed is None:
                fail('CNF-%s-%03d appears in definition position in scope "%s", '
                     'which is not entitled to define any register'
                     % (register, number, key))
                continue
            if register not in allowed:
                fail('CNF-%s-%03d is defined in scope "%s", which defines %s'
                     % (register, number, key, '/'.join(allowed)))
                continue
            # Section 14 is an INDEX by the document's own declaration:
            # "This table is an index, not a second definition ... A gap is
            # counted once."  Its rows are recorded separately so that the
            # count is not doubled, and so that the index property can be
            # asserted rather than assumed.
            if matched == '## 14.':
                index_gaps.add(number)
                continue
            found.setdefault(register, set()).add(number)

    # Gaps raised ONLY in section 14 are still members of the register -- the
    # index is exhaustive, so anything it lists that the body did not raise
    # inline is index-defined and must be counted exactly once.
    for number in index_gaps:
        found.setdefault('GAP', set()).add(number)

    if index_gaps != found.get('GAP', set()):
        fail('section 14 indexes %d gap(s) but the register holds %d -- its '
             'preamble promises an exhaustive index ("A gap is counted once"), '
             'so the two sets must be equal'
             % (len(index_gaps), len(found.get('GAP', set()))))

    missing = sorted(set(SCOPE_REGISTERS) - seen_scopes)
    if missing:
        fail('the PRD has no scope matching %s -- the authorisation table no '
             'longer describes the document, so a register could be defined '
             'nowhere this parser looks' % ', '.join(repr(m) for m in missing))
    return {key: sorted(value) for key, value in found.items()}


def expand_ids(text):
    """Every `CNF-*` token, with ellipsis ranges expanded."""
    ids = set()
    span = (r'`CNF-([A-Z]+)-(\d+)`\s*(?:\u2026|\.\.\.|\.\.)\s*'
            r'`(?:CNF-[A-Z]+-)?(\d+)`')
    for match in re.finditer(span, text):
        register = match.group(1)
        low, high = int(match.group(2)), int(match.group(3))
        for number in range(low, min(high, low + 999) + 1):
            ids.add('CNF-%s-%03d' % (register, number))
    for match in re.finditer(r'`CNF-([A-Z]+)-(\d+)`', text):
        ids.add('CNF-%s-%03d' % (match.group(1), int(match.group(2))))
    return ids


def strip_regex_vectors(rel, text):
    """Remove REGEX TEST VECTORS before the dangling-citation scan.

    `S5-C-03`.  Section 2L proves the two inward substring hazards are
    defeated by publishing the measurement itself, in the form

        `re.search(r'(?<![A-Z-])CFG-\\d+', 'CNF-CFG-001')` -> no match

    The single-quoted `'CNF-CFG-001'` there is a STRING FED TO A PATTERN to
    demonstrate that the pattern does NOT match it.  It is not a citation: no
    reader is being pointed at a requirement, and `CNF-CFG-*` is declared
    EMPTY precisely so that no such member exists.  A naive citation scan
    reads it as a reference to an undefined identifier and fails the run --
    the same family of defect as `S5-C-02`, an instrument mistaking prose
    ABOUT a pattern for a use OF the thing.

    The exclusion is deliberately NARROW and GUARDED, following the `S5-C-02`
    precedent: only single-quoted tokens sitting inside an inline-code span
    that also contains `re.search` are removed, only in the matrix, and only
    while that convention is actually present.  If the convention disappears
    the guard fails loudly, so this cannot rot into a blanket exemption that
    hides a real dangling citation.  Line numbers are preserved because
    other checks report positions.
    """
    if rel != MATRIX:
        return text
    vector = re.compile(r'`[^`]*re\.search\([^`]*`')
    spans = list(vector.finditer(text))
    if not spans:
        fail('section 2L no longer publishes any `re.search(...)` measurement, '
             'so the regex-test-vector exclusion is masking nothing and must '
             'be removed rather than left to rot into a blanket exemption')
        return text
    out = list(text)
    removed = 0
    for span in spans:
        for index in range(span.start(), span.end()):
            if out[index] != '\n':
                out[index] = ' '
                removed += 1
    if not removed:
        fail('the regex-test-vector exclusion matched but removed nothing')
    return ''.join(out)


def section_2l(matrix):
    start = matrix.find('## 2L.')
    if start < 0:
        return None
    end = matrix.find('\n## ', start + 6)
    return matrix[start:end if end > 0 else len(matrix)]


def matrix_rows(block):
    """Parse section 2L's inventory rows -> register -> (count, range_max).

    Published shapes:
      "| `CNF-FR-*`  | ... | **82** | `001`-`082` | ..."
      "| `CNF-EVT-*` | ... | **0**  | none issued | ..."   (range_max None)
    """
    out = {}
    for line in block.split('\n'):
        head = re.match(r'^\|\s*\*{0,2}`CNF-([A-Z]+)-\*`\*{0,2}\s*\|', line)
        if head is None:
            continue
        # Split on UNESCAPED pipes only -- finding S5-C-03 of the PRD-014
        # conferral.  A row quoting a grep alternation such as
        # `settings\|config\|flag` carries `\|` as a correctly escaped literal
        # pipe in GFM, not a cell boundary; a naive split shatters the row and
        # reports "no parsable count" against a well-formed one.
        cells = [c.strip() for c in
                 re.split(r'(?<!\\)\|', line.strip().strip('|'))]
        if len(cells) < 4:
            fail('section 2L row for CNF-%s-* has too few columns'
                 % head.group(1))
            continue
        register = head.group(1)
        count_cell, range_cell = cells[2], cells[3]
        if re.search(r'in force', count_cell):
            fail('section 2L row for CNF-%s-* publishes an "in force '
                 '(declared)" pair; PRD-023 retires nothing, so one count is '
                 'correct and a pair implies a retirement register that does '
                 'not exist' % register)
        count_match = re.search(r'\*\*(\d+)\*\*', count_cell)
        if count_match is None:
            fail('section 2L row for CNF-%s-* has no parsable count' % register)
            continue
        numbers = [int(n) for n in re.findall(r'`(\d+)`', range_cell)]
        out[register] = (int(count_match.group(1)),
                         max(numbers) if numbers else None)
    return out


def main():
    doc = read(DOC)
    matrix = read(MATRIX)

    computed = definitions_by_scope(doc)

    # ---- check 1: does section 2L exist at all?
    block = section_2l(matrix)
    if block is None:
        fail('TRACEABILITY_MATRIX.md has no section 2L -- the Stage 5 gate is '
             'not satisfied. The gate is the registration, not the intention '
             'to register')
        report(computed, {}, set(), set(), 0, [], {})
        return 1

    rows = matrix_rows(block)
    if not rows:
        fail('section 2L exists but registers no CNF- prefix row -- a section '
             'that registers nothing satisfies nothing')

    # ---- check 2: published numbers vs recomputed
    for register in ORDER:
        numbers = computed.get(register, [])
        if register not in rows:
            fail('CNF-%s-* is defined %d time(s) in PRD-023 but has no row in '
                 'section 2L' % (register, len(numbers)))
            continue
        pub_count, pub_max = rows[register]
        if pub_count != len(numbers):
            fail('CNF-%s-*: section 2L publishes count %d, recomputed %d'
                 % (register, pub_count, len(numbers)))
        if numbers:
            if pub_max is None:
                fail('CNF-%s-* has %d member(s) but section 2L publishes no '
                     'range' % (register, len(numbers)))
            elif pub_max != max(numbers):
                fail('CNF-%s-*: section 2L publishes range max %03d, '
                     'recomputed %03d' % (register, pub_max, max(numbers)))
        elif pub_max is not None:
            fail('CNF-%s-* is empty but section 2L publishes a range max of %s'
                 % (register, pub_max))

    for register in sorted(rows):
        if register not in ORDER:
            fail('section 2L registers CNF-%s-*, which PRD-023 does not define'
                 % register)

    # ---- check 3: contiguity
    for register in ORDER:
        numbers = computed.get(register, [])
        if not numbers:
            continue
        expected = list(range(1, max(numbers) + 1))
        if numbers != expected:
            missing = sorted(set(expected) - set(numbers))
            fail('CNF-%s-* is not contiguous: missing %s'
                 % (register, ', '.join('%03d' % m for m in missing)))

    # ---- check 6: no retirement register
    if re.search(r'^##\s+\d+\.\s+Retired identifiers', doc, re.MULTILINE):
        fail('PRD-023 now has a retirement section, so a single published '
             'count per register is ambiguous. Both this script and '
             'prd023_traceability.py must be revised before the gate is safe')

    # ---- check 4a: inward stem collision against every prefix the matrix
    #      already registers
    registered_stems = set()
    for line in matrix.split('\n'):
        for match in re.finditer(r'`([A-Z][A-Z0-9]*(?:-[A-Z]+)*)-\*`', line):
            registered_stems.add(match.group(1))
    for register in ORDER:
        stem = 'CNF-%s' % register
        if stem in registered_stems and stem not in block:
            fail('%s-* is registered elsewhere in the matrix, outside '
                 'section 2L' % stem)
    # A wildcard in PROSE is not a bare register declaration -- finding S5-C-04
    # of the PRD-014 conferral, whose exemption the baselined prd016_stage5.py
    # L321 already carries.  What WOULD be a genuine defect is a bare
    # `CNF-<n>` IDENTIFIER, belonging to no sub-register, so that is tested
    # instead.
    bare = [line for line in matrix.split('\n')
            if re.search(r'(?<![A-Z-])CNF-\d+', line)]
    if bare:
        fail('a bare `CNF-<n>` identifier appears in the matrix (%d line(s)); '
             'PRD-023 declares eight sub-registers and no bare register, so '
             'such a token belongs to no register' % len(bare))

    # ---- check 4b: the substring hazard, in both directions
    hazards = [
        (r'(?<![A-Z-])CFG-\d+', 'CNF-CFG-001',
         'CFG-1..CFG-12 is a LIVE register owned by PRD-001 -- the sharpest '
         'hazard this module carries, because the prefix is OCCUPIED rather '
         'than hypothetical'),
        (r'(?<![A-Z-])INV-\d+', 'CNF-INV-001',
         'INV-1..INV-16 are platform invariants (matrix L82) and are THIS '
         "module's subject matter"),
        (r'(?<![A-Z-])FR-\d+', 'CNF-FR-001', 'bare FR-n exists in docs/'),
        (r'(?<![A-Z-])AC-\d+', 'CNF-AC-001', 'a bare AC-n form is conceivable'),
        (r'(?<![A-Z-])XC-\d+', 'CNF-XC-001', 'INV-XC-* exists'),
        (r'(?<![A-Z-])GAP-\d+', 'CNF-GAP-001', 'a bare GAP-n form is conceivable'),
    ]
    for pattern, sample, why in hazards:
        if re.search(pattern, sample):
            fail('%s is reachable by a word-boundary search for %r -- %s, so '
                 'the two registers could be confused' % (sample, pattern, why))
    # The reverse direction.  Unlike `ENT-`, which is a live substring of
    # MANAGEMENT- and ALIGNMENT-, `CNF-` is NOT the tail of any word in this
    # repository: a corrected scan found exactly three apparent hits, all of
    # them the `b` of the regex escape `\bCNF-` inside quoted grep commands --
    # prose ABOUT a pattern, not a word embedding the prefix.  The hazard class
    # is therefore ABSENT here rather than merely defeated, and saying so is
    # more honest than manufacturing a decoy.  What IS asserted is that the
    # anchored form still matches the real thing, because a pattern that
    # matched nothing would under-count every register silently.
    if not re.search(r'(?<![A-Z])CNF-', 'CNF-FR-001'):
        fail('the anchored CNF- pattern no longer matches CNF-FR-001 -- it '
             'would under-count every register')
    if re.search(r'(?<![A-Z])CNF-', 'XCNF-FR-001'):
        fail('the anchored CNF- pattern matches inside a longer token, so the '
             'guard against over-counting is not actually anchored')

    # ---- check 4c: outward definitions
    _ = strip_regex_vectors  # used below; named here for readers of the flow
    defined = set()
    for register in ORDER:
        for number in computed.get(register, []):
            defined.add('CNF-%s-%03d' % (register, number))

    outward = []
    citations = 0
    for path in walk_markdown():
        rel = os.path.relpath(path, ROOT)
        if any(rel.startswith(owned) for owned in OWNED_DIRS):
            continue
        text = read(rel)
        for lineno, line in enumerate(text.split('\n'), 1):
            for pattern in [r'^\*\*`CNF-([A-Z]+)-(\d+)`\*\*\s*(?:\u2014|--)\s*\S',
                            r'^\|\s*\*{0,2}`CNF-([A-Z]+)-(\d+)`\*{0,2}\s*\|']:
                match = re.match(pattern, line.strip())
                if match:
                    ident = 'CNF-%s-%03d' % (match.group(1),
                                             int(match.group(2)))
                    # The matrix's own section 2L is a registration, not a
                    # definition; it is the document under test.
                    if rel == MATRIX:
                        break
                    outward.append((rel, lineno, ident))
                    break
        found = expand_ids(strip_regex_vectors(rel, text))
        citations += len(found)
        for ident in sorted(found - defined):
            fail('%s is cited in %s but is defined nowhere in PRD-023'
                 % (ident, rel))
    for rel, lineno, ident in outward:
        fail('%s is DEFINED at %s:%d, outside the configuration module -- a '
             'definition outside the owning module is a collision, though a '
             'mere citation is not' % (ident, rel, lineno))

    # ---- check 5: section 2L's totals recomputed
    total = sum(len(computed.get(r, [])) for r in ORDER)
    total_row = re.search(r'\|\s*\*{0,2}Total\*{0,2}\s*\|[^|]*\|\s*\*\*(\d+)\*\*',
                          block)
    if total_row is None:
        fail('section 2L publishes no parsable Total row, so its arithmetic '
             'cannot be recomputed')
    elif int(total_row.group(1)) != total:
        fail('section 2L publishes total %s, recomputed %d'
             % (total_row.group(1), total))

    # ---- check 7: both empty registers registered as empty AND empty in fact
    for register in EMPTY_BY_DESIGN:
        members = re.findall(r'`CNF-%s-(\d+)`' % register, doc)
        if members:
            fail('CNF-%s-* is declared EMPTY but %d numbered member(s) now '
                 'exist in the PRD. The Stage 5 mandate forbids minting one '
                 'without authoritative evidence'
                 % (register, len(set(members))))
        if register not in rows:
            fail('CNF-%s-* is empty by design but has no row in section 2L. An '
                 'omitted empty register is indistinguishable from an '
                 'oversight' % register)
            continue
        if rows[register][0] != 0:
            fail('section 2L publishes %d for CNF-%s-*, which is empty by '
                 'design' % (rows[register][0], register))
        tail = block.split('`CNF-%s-*`' % register)
        if len(tail) < 2 or 'EMPTY' not in tail[1][:1400].upper():
            fail("section 2L's CNF-%s-* row does not state that it is DECLARED "
                 'EMPTY, so the emptiness reads as an omission' % register)

    # ---- check 8: coverage recomputed with ellipsis expansion
    class_a = set()
    for register in CLASS_A:
        for number in computed.get(register, []):
            class_a.add('CNF-%s-%03d' % (register, number))
    covered = set()
    ac_rows = 0
    for key, body in scopes(doc):
        if not key.startswith('## 13') and not key.startswith('### 13'):
            continue
        for line in body.split('\n'):
            stripped = line.strip()
            if not re.match(r'^\|\s*\*{0,2}`CNF-AC-\d+`', stripped):
                continue
            ac_rows += 1
            cells = [c.strip() for c in
                     re.split(r'(?<!\\)\|', stripped.strip('|'))]
            traces = expand_ids(' '.join(cells[1:]))
            covered |= {i for i in traces if i in class_a}
    if class_a:
        pct = 100.0 * len(covered) / len(class_a)
        published = re.search(
            r'\*\*(\d+)\s*/\s*(\d+)\s*=\s*([\d.]+)\s*%\*\*', block)
        if published is None:
            fail('section 2L publishes no parsable coverage figure')
        else:
            if int(published.group(1)) != len(covered) or \
                    int(published.group(2)) != len(class_a):
                fail('section 2L publishes coverage %s/%s, recomputed %d/%d'
                     % (published.group(1), published.group(2),
                        len(covered), len(class_a)))
            if abs(float(published.group(3)) - pct) > 0.05:
                fail('section 2L publishes %s%%, recomputed %.1f%%'
                     % (published.group(3), pct))

    # ---- check 9: the four traceability directions Stage 5 requires
    directions = {
        'authoritative source': len(re.findall(r'ADR-0017', doc)),
        'architecture decision': len(re.findall(r'\bE-(?:19|20)\b', doc)),
        'acceptance criterion': len(covered),
        'implementation task': len(re.findall(r'IMPL-1100', doc)),
    }
    for name, count in directions.items():
        if count == 0:
            fail('traceability direction "%s" is empty -- Stage 5 requires all '
                 'four directions to resolve, and a direction with no evidence '
                 'is not traceable' % name)

    report(computed, rows, class_a, covered, citations, outward, directions)
    return 1 if PROBLEMS else 0


def report(computed, rows, class_a, covered, citations, outward, directions):
    line = '-' * 70
    print(line)
    print('PRD-023 Stage 5 gate -- section 2L against a recomputation')
    print(line)
    total = 0
    for register in ORDER:
        numbers = computed.get(register, [])
        total += len(numbers)
        state = 'in 2L' if register in rows else 'NOT IN 2L'
        if not numbers:
            print('  CNF-%-4s* %-10s DECLARED EMPTY' % (register + '-', state))
            continue
        print('  CNF-%-4s* %-10s count %-3d range 001..%03d  contiguous'
              % (register + '-', state, len(numbers), max(numbers)))
    print(line)
    print('identifiers recomputed from the PRD body : %d' % total)
    print('rows registered in section 2L            : %d' % len(rows))
    if class_a:
        print('Class A obligations                      : %d' % len(class_a))
        print('coverage                                 : %d / %d = %.1f%%'
              % (len(covered), len(class_a),
                 100.0 * len(covered) / len(class_a)))
    print('CNF- citations outside the module        : %d' % citations)
    print('CNF- DEFINITIONS outside the module      : %d' % len(outward))
    for name, count in sorted(directions.items()):
        print('traceability -> %-24s : %d' % (name, count))
    print(line)
    if PROBLEMS:
        print('FAIL - %d problem(s):' % len(PROBLEMS))
        for problem in PROBLEMS:
            print('  * %s' % problem)
    else:
        print('PASS - section 2L registers every register PRD-023 defines and')
        print('       nothing it does not, counts and ranges reproduce from an')
        print('       independent recomputation, all ranges contiguous, zero')
        print('       collisions inward, outward and by substring, both empty')
        print('       registers registered as empty AND empty in fact, totals')
        print('       and coverage recomputed, four directions resolve.')
    print(line)


if __name__ == '__main__':
    sys.exit(main())
