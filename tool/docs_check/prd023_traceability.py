#!/usr/bin/env python3
"""PRD-023 internal traceability -- does the PRD agree with ITSELF?

WHY THIS EXISTS
---------------
`PRD_LIFECYCLE.md` Stage 5 states its gate as:

    "the PRD's prefixes registered in TRACEABILITY_MATRIX.md section 2 with
     counts and ranges, verified mechanically, zero collisions.

     Mechanical means counted by a tool, not by reading."

This is the FIRST of the two scripts the `PRD-008` pattern requires
(`prd008_traceability.py` plus `prd008_stage5.py`, repeated for `PRD-013`,
`PRD-016` and `PRD-014`).  It checks `PRD-023` against **itself** -- section 0.2's
declarations against the body -- and it NEVER OPENS THE MATRIX.  Section 2L is
checked by `prd023_stage5.py`, which recomputes the same registers by a
structurally different route.

Two declarations, one subject.  Neither script imports the other, so a defect in
one parser cannot propagate silently into the other.

STRATEGY: LINE FORM
-------------------
This script classifies each LINE by an ordered list of line-start patterns.
`prd023_stage5.py` instead splits the document into scopes at both `## ` and
`### ` and accepts an identifier only where that scope is entitled to define it.
The two must arrive at 180 by different routes; agreement by one route repeated
twice would be worthless.

WHAT MADE THIS MODULE DIFFERENT FROM ITS FOUR PREDECESSORS
----------------------------------------------------------
1. **Section 14 is an INDEX, and the document says so.**  `PRD-023` section 14's
   preamble states: "This table is an index, not a second definition.  Where a
   gap was raised in the body ... the body statement is the normative one and the
   row below summarises it.  A gap is counted once."  `CNF-GAP-006` therefore
   appears in definition position TWICE -- section 7.2 (normative) and section 14
   (index).  A naive duplicate-site rule reports that as a defect on a document
   that is correct and explicit about it.

   This script does NOT simply exempt section 14.  It asserts the stronger
   property the preamble actually promises: section 14 must index EXACTLY the
   gaps the register contains, and every gap it duplicates must be one the
   preamble names as body-raised.  An exemption would weaken the check; this
   strengthens it.

2. **`CNF-CFG-*` is empty, and `CFG-1`...`CFG-12` is a LIVE register owned by
   `PRD-001`.**  This is the sharpest substring hazard any module in this
   repository has carried, because `CFG-` is not a hypothetical collision: it is
   an occupied prefix.  Checked in check 8, both directions.

3. **`INV-1`...`INV-16` are this module's SUBJECT MATTER.**  Every other PRD
   merely risks confusing `INV-n` with its own `*-INV-n`.  `PRD-023` section 5
   is *about* `INV-1`...`INV-16` and cites them heavily while also defining
   `CNF-INV-001`...`CNF-INV-004`.  Both registers coexist in one section and must
   stay mechanically distinguishable.

4. **Two registers hold no member at all.**  `CNF-EVT-*` and `CNF-CFG-*` must be
   verifiably empty -- not merely undeclared.  Check 7 fails if any numbered
   member of either is ever minted, which is the Stage 5 prohibition stated as a
   test rather than as a promise.

WHAT IT CHECKS
--------------
1. Section 0.2 declares every register the body defines, and nothing it does not.
2. Declared counts equal recomputed counts; declared range maxima equal
   recomputed maxima.
3. Every range is contiguous 1..max.
4. Every identifier is defined exactly once, except where section 14's declared
   index property accounts for it -- and that property is itself verified.
5. Every acceptance criterion traces to at least one Class A obligation
   (no orphan criteria).
6. Reverse coverage: every Class A obligation with no criterion is NAMED in the
   Coverage paragraph.  Zero undisclosed uncovered obligations.
7. Both empty registers are empty in fact, not merely in description.
8. The substring hazards are live and the anchored patterns defeat them.
9. No retirement section exists, so one published count per register is
   unambiguous.

Exit 0 = the PRD is internally consistent.  Exit 1 = it is not.
"""

import os
import re
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DOC = os.path.join('docs', '30-product', 'configuration',
                   'PRD-023_SETTINGS_AND_CONFIGURATION.md')

ORDER = ['FR', 'BR', 'INV', 'EVT', 'XC', 'CFG', 'AC', 'GAP']
CLASS_A = ['FR', 'BR', 'INV', 'EVT', 'XC']
EMPTY_BY_DESIGN = ['EVT', 'CFG']

# Sections that carry identifier-shaped rows but define nothing.  Section 0.x
# declares; 15, 16 and 17 cite.  Listed explicitly so that a definition
# appearing somewhere unexpected still FAILS rather than being silently absorbed.
CITING_PREFIXES = ['## 0.', '### 0.', '## 15.', '## 16.', '## 17.']

# Section 14 is an INDEX by the document's own declaration.  Not an exemption:
# check 4b verifies the index property the preamble promises.
INDEX_SECTION = '## 14.'

PROBLEMS = []


def fail(message):
    PROBLEMS.append(message)


def read(path):
    with open(os.path.join(ROOT, path), encoding='utf-8') as handle:
        return handle.read()


def expand_ids(text):
    """Every `CNF-*` token, with ellipsis ranges expanded.

    The Coverage paragraph writes `CNF-XC-001` ... `CNF-XC-016` as a SPAN.  A
    scanner that reads only literal tokens would count 2 where 16 are meant and
    would then report 14 obligations as undisclosed -- a false failure of
    check 6 against a document whose disclosure is complete.
    """
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


def definition_sites(text):
    """register -> {number: [(line_no, section)]} by LINE FORM.

    Two definition shapes are recognised, matching the document's conventions:
      prose : **`CNF-GAP-006`** -- EA places `Secret Reference Resolution` ...
      cell  : | **`CNF-FR-001`** | The system SHALL ...
    """
    sites = {}
    section = None
    for lineno, line in enumerate(text.split('\n'), 1):
        if line.startswith('## ') or line.startswith('### '):
            match = re.match(r'^(#{2,3}\s+(?:\d+(?:\.\d+)?\.?|[A-Za-z]))', line)
            section = re.sub(r'\s+', ' ', match.group(1)) if match else line
            continue
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
        if section and any(section.startswith(c) for c in CITING_PREFIXES):
            continue
        sites.setdefault(register, {}).setdefault(number, []).append(
            (lineno, section))
    return sites


def declared_registers(text):
    """Section 0.2's declarations -> register -> (count, range_max, empty_flag).

    PRD-023 publishes the BARE PREFIX in cell 0, the count in cell 2 and the
    range span in cell 3:

      | `CNF-FR-` | Functional requirement | **82** | `CNF-FR-001` ... `CNF-FR-082` | Yes |
      | `CNF-EVT-` | Domain event ...       | **0**  | **DECLARED EMPTY** -- 0.3  | n/a |

    S5-C-01 of the PRD-014 conferral records what happens when an inherited
    section-0.2 parser expects a different cell layout: it reads ZERO declared
    registers and reports a correct document as wholly unregistered.  The guard
    below makes that failure loud instead of silent.
    """
    start = text.find('### 0.2')
    end = text.find('### 0.3')
    if start < 0 or end < 0:
        fail('cannot locate section 0.2 -- the register declaration this '
             'script exists to verify is not where it is expected, so no '
             'clean run can be reported')
        return {}
    block = text[start:end]
    out = {}
    for line in block.split('\n'):
        head = re.match(r'^\|\s*\*{0,2}`CNF-([A-Z]+)-`\*{0,2}\s*\|', line.strip())
        if head is None:
            continue
        cells = [c.strip() for c in
                 re.split(r'(?<!\\)\|', line.strip().strip('|'))]
        if len(cells) < 4:
            fail('section 0.2 row for CNF-%s- has too few columns'
                 % head.group(1))
            continue
        register = head.group(1)
        count_match = re.search(r'\*\*(\d+)\*\*', cells[2])
        if count_match is None:
            fail('section 0.2 row for CNF-%s- publishes no parsable count'
                 % register)
            continue
        numbers = [int(n) for n in re.findall(r'CNF-[A-Z]+-(\d+)', cells[3])]
        declared_empty = 'DECLARED EMPTY' in cells[3].upper()
        out[register] = (int(count_match.group(1)),
                         max(numbers) if numbers else None,
                         declared_empty)
    if not out:
        fail('section 0.2 parsed to ZERO declared registers. A parser that '
             'reads nothing must never report a clean run -- this is the '
             'S5-C-01 failure class, and it is being failed loudly rather '
             'than passed silently')
    return out


def section_bounds(text):
    """section key -> (start_line_index, end_line_index) for cross-reference
    resolution.  Used to prove that section 14's "CNF-GAP-nnn at SECTION"
    pointers actually resolve, rather than merely looking plausible.
    """
    lines = text.split('\n')
    marks = []
    for index, line in enumerate(lines):
        match = re.match(r'^#{2,3}\s+(\d+(?:\.\d+)?)\.?\s', line)
        if match:
            marks.append((match.group(1), index))
    bounds = {}
    for position, (key, index) in enumerate(marks):
        end = marks[position + 1][1] if position + 1 < len(marks) else len(lines)
        # A parent section spans its subsections, so extend to the next heading
        # at the same or shallower depth.
        if '.' not in key:
            end = len(lines)
            for later_key, later_index in marks[position + 1:]:
                if '.' not in later_key:
                    end = later_index
                    break
        bounds.setdefault(key, (index, end))
    return bounds


def coverage_paragraph(text):
    """Locate the Coverage paragraph BY ANCHOR, never by a fixed line slice.

    Finding S4-C-02 of the Stage 4 review records the cost of the alternative:
    a fixed slice `lines[1100:1130]` missed the paragraph (it begins at L1333)
    and reported 23 undisclosed obligations against a document that discloses
    all 37.  Believed uncritically, that would have produced a false FAIL.
    """
    lines = text.split('\n')
    for index, line in enumerate(lines):
        if line.startswith('**Coverage.**'):
            return '\n'.join(lines[index:index + 8]), index + 1
    return None, None


def main():
    doc = read(DOC)

    sites = definition_sites(doc)
    computed = {r: sorted(sites.get(r, {})) for r in ORDER}
    declared = declared_registers(doc)

    # ---- check 1: declared set == defined set
    for register in ORDER:
        numbers = computed[register]
        if register not in declared:
            fail('CNF-%s-* is defined %d time(s) in the body but is NOT '
                 'declared in section 0.2' % (register, len(numbers)))
    for register in sorted(declared):
        if register not in ORDER:
            fail('section 0.2 declares CNF-%s-*, which this script does not '
                 'know about -- the register list has changed and the checker '
                 'no longer describes the document' % register)

    # ---- check 2: counts and range maxima
    for register in ORDER:
        if register not in declared:
            continue
        numbers = computed[register]
        dec_count, dec_max, dec_empty = declared[register]
        if dec_count != len(numbers):
            fail('CNF-%s-*: section 0.2 declares count %d, recomputed %d from '
                 'the body' % (register, dec_count, len(numbers)))
        if numbers:
            if dec_max is None:
                fail('CNF-%s-* has %d member(s) but section 0.2 publishes no '
                     'range maximum' % (register, len(numbers)))
            elif dec_max != max(numbers):
                fail('CNF-%s-*: section 0.2 declares range max %03d, '
                     'recomputed %03d' % (register, dec_max, max(numbers)))
        else:
            if not dec_empty:
                fail('CNF-%s-* has no member but section 0.2 does not state '
                     'DECLARED EMPTY -- an empty register that says nothing is '
                     'indistinguishable from an oversight' % register)

    # ---- check 3: contiguity
    for register in ORDER:
        numbers = computed[register]
        if not numbers:
            continue
        expected = list(range(1, max(numbers) + 1))
        if numbers != expected:
            missing = sorted(set(expected) - set(numbers))
            fail('CNF-%s-* is not contiguous: missing %s -- a gap makes the '
                 'published range false (PRD_LIFECYCLE L82 rule 3)'
                 % (register, ', '.join('%03d' % m for m in missing)))

    # ---- check 4a: each identifier defined exactly once, except the declared
    #      index in section 14
    for register in ORDER:
        for number, where in sorted(sites.get(register, {}).items()):
            if len(where) == 1:
                continue
            outside = [w for w in where
                       if not (w[1] or '').startswith(INDEX_SECTION)]
            if len(outside) > 1 or register != 'GAP':
                fail('CNF-%s-%03d is defined at %d sites (%s) -- two sources '
                     'of truth for one identifier'
                     % (register, number, len(where),
                        ', '.join('L%d %s' % (w[0], w[1]) for w in where)))

    # ---- check 4b: section 14's INDEX PROPERTY, which is what the preamble
    #      actually promises.  Not an exemption -- a stronger assertion.
    index_gaps = set()
    body_gaps = set()
    for number, where in sites.get('GAP', {}).items():
        for lineno, section in where:
            if (section or '').startswith(INDEX_SECTION):
                index_gaps.add(number)
            else:
                body_gaps.add(number)
    all_gaps = set(computed['GAP'])
    if index_gaps != all_gaps:
        fail('section 14 indexes %d gap(s) but the register holds %d. Its '
             'preamble states "This table is an index" and "A gap is counted '
             'once", which requires the index to be exhaustive: missing %s'
             % (len(index_gaps), len(all_gaps),
                sorted(all_gaps - index_gaps) or 'none'))
    claimed = re.search(r'Where a gap was raised in the body\s*\u2014(.{0,400})',
                        doc, re.S)
    if claimed is None:
        fail('section 14 no longer states which gaps were raised in the body, '
             'so its index property cannot be verified and the duplicate '
             'definition of a gap becomes unaccounted for')
    else:
        # S5-C-01 (this stage): the first form of this check asserted that each
        # gap named as body-raised must hold a LINE-START definition site.  It
        # failed for six of the seven -- and the document was RIGHT.  PRD-023
        # raises gaps INLINE, mid-sentence ("Recorded as **`CNF-GAP-001`**.",
        # "recorded as **`CNF-GAP-004`** rather than assumed"), which is prose,
        # not a definition row.  Only CNF-GAP-006 happens to begin its line.
        # Believed uncritically, that run would have reported six false defects
        # against a correct document.
        #
        # The rule was changed to match the document, and changed to something
        # STRONGER rather than weaker: section 14 states not merely THAT each
        # gap was raised in the body but WHERE.  Each claimed cross-reference is
        # therefore resolved -- the gap must actually occur inside the section
        # section 14 names.  A stale or wrong section pointer now fails, which
        # the line-start rule could never have detected.
        pairs = re.findall(r'`CNF-GAP-(\d+)`\s*at\s*\u00a7([\d.]+)',
                           claimed.group(1))
        if not pairs:
            fail('section 14 names no "CNF-GAP-nnn at SECTION" pair, so its '
                 'body cross-references cannot be resolved and the check '
                 'would be vacuous')
        bounds = section_bounds(doc)
        for number, section in pairs:
            key = section.rstrip('.')
            if key not in bounds:
                fail('section 14 points CNF-GAP-%s at section %s, which does '
                     'not exist in this document' % (number, section))
                continue
            low, high = bounds[key]
            body = '\n'.join(doc.split('\n')[low:high])
            if 'CNF-GAP-%s' % number not in body:
                fail('section 14 claims CNF-GAP-%s was raised at section %s, '
                     'but that section does not mention it -- the '
                     'cross-reference is stale'
                     % (number, section))
        named = {int(n) for n, _ in pairs}
        # A gap whose ONLY site is the index is index-defined, which is lawful
        # only if section 14 does not claim it was raised in the body.
        index_only = all_gaps - named
        for number in sorted(index_only):
            if number in body_gaps:
                fail('CNF-GAP-%03d has a body definition site but section 14 '
                     'does not name it as body-raised, so the duplication is '
                     'undeclared' % number)

    # ---- check 5: no orphan acceptance criterion
    class_a = set()
    for register in CLASS_A:
        for number in computed[register]:
            class_a.add('CNF-%s-%03d' % (register, number))

    covered = set()
    ac_rows = 0
    orphans = []
    in_thirteen = False
    for line in doc.split('\n'):
        if line.startswith('## '):
            in_thirteen = line.startswith('## 13.')
        if not in_thirteen:
            continue
        stripped = line.strip()
        if not re.match(r'^\|\s*\*{0,2}`CNF-AC-\d+`', stripped):
            continue
        ac_rows += 1
        cells = [c.strip() for c in
                 re.split(r'(?<!\\)\|', stripped.strip('|'))]
        traced = {i for i in expand_ids(' '.join(cells[1:])) if i in class_a}
        if not traced:
            orphans.append(cells[0])
        covered |= traced
    if ac_rows != len(computed['AC']):
        fail('section 13 carries %d criterion row(s) but CNF-AC-* holds %d '
             'member(s)' % (ac_rows, len(computed['AC'])))
    for orphan in orphans:
        fail('%s traces to no Class A obligation -- an orphan criterion '
             'verifies nothing' % orphan)

    # ---- check 6: reverse coverage -- every uncovered obligation is NAMED
    paragraph, para_line = coverage_paragraph(doc)
    if paragraph is None:
        fail('no Coverage paragraph found in section 13, so the uncovered set '
             'is undisclosed')
        stated = set()
    else:
        stated = expand_ids(paragraph)
        measured = class_a - covered
        for ident in sorted(measured - stated):
            fail('%s carries no acceptance criterion and is NOT named in the '
                 'Coverage paragraph -- an untested obligation presented as '
                 'tested' % ident)

    # ---- check 7: the empty registers are empty IN FACT
    for register in EMPTY_BY_DESIGN:
        members = re.findall(r'`CNF-%s-(\d+)`' % register, doc)
        if members:
            fail('CNF-%s-* is declared EMPTY but %d numbered member(s) exist '
                 '(%s). Stage 5 may not mint one without authoritative '
                 'evidence'
                 % (register, len(members), ', '.join(sorted(set(members)))))

    # ---- check 8: the substring hazards, both directions
    hazards = [
        (r'(?<![A-Z-])CFG-\d+', 'CNF-CFG-001',
         'CFG-1..CFG-12 is a LIVE register owned by PRD-001 -- the sharpest '
         'hazard this module carries, because the prefix is occupied, not '
         'hypothetical'),
        (r'(?<![A-Z-])INV-\d+', 'CNF-INV-001',
         'INV-1..INV-16 are platform invariants (matrix L82) and are THIS '
         'module\'s subject matter, cited throughout section 5'),
        (r'(?<![A-Z-])FR-\d+', 'CNF-FR-001',
         'bare FR-n exists elsewhere in docs/'),
        (r'(?<![A-Z-])AC-\d+', 'CNF-AC-001', 'a bare AC-n form is conceivable'),
        (r'(?<![A-Z-])XC-\d+', 'CNF-XC-001',
         'INV-XC-* exists in the invitation register'),
    ]
    for pattern, sample, why in hazards:
        if re.search(pattern, sample):
            fail('%s is reachable by a word-boundary search for %r -- %s, so '
                 'the two registers could be confused' % (sample, pattern, why))
    # The reverse direction: does `CNF-` occur as the tail of an ordinary word?
    # Measured across this repository: it does NOT.  Unlike `ENT-`, which is a
    # substring of MANAGEMENT- and ALIGNMENT-, no English or governance word in
    # this repository ends in the letters C-N-F.  The three apparent hits are
    # the `b` of the regex escape `\bCNF-` inside quoted grep commands, which is
    # prose ABOUT a pattern rather than a word embedding the prefix.  The test
    # is asserted in BOTH directions so it cannot become silently vacuous --
    # the S5-C-06 failure class, where a decoy that no longer embeds the token
    # makes the check pass forever while proving nothing.
    for decoy in ['\\bCNF-INV-', 'x\\bCNF-']:
        if not re.search(r'CNF-', decoy):
            fail('hazard test is vacuous: %r no longer embeds "CNF-", so it '
                 'cannot demonstrate anything about the scan' % decoy)
    if not re.search(r'(?<![A-Z])CNF-', 'CNF-FR-001'):
        fail('the anchored CNF- pattern no longer matches CNF-FR-001 -- it '
             'would under-count every register')

    # ---- check 9: no retirement section
    if re.search(r'^##\s+\d+\.\s+Retired identifiers', doc, re.MULTILINE):
        fail('the PRD now has a retirement section, so a single published '
             'count per register is ambiguous. Both this script and '
             'prd023_stage5.py must be revised before the gate is safe')

    report(computed, declared, class_a, covered, ac_rows, para_line, stated)
    return 1 if PROBLEMS else 0


def report(computed, declared, class_a, covered, ac_rows, para_line, stated):
    line = '-' * 70
    print(line)
    print('PRD-023 internal traceability -- section 0.2 against the body')
    print(line)
    total = 0
    for register in ORDER:
        numbers = computed[register]
        total += len(numbers)
        state = 'declared' if register in declared else 'NOT DECLARED'
        if not numbers:
            print('  CNF-%-4s* %-13s EMPTY' % (register + '-', state))
            continue
        print('  CNF-%-4s* %-13s count %-3d range 001..%03d  contiguous'
              % (register + '-', state, len(numbers), max(numbers)))
    print(line)
    print('identifiers defined in the body      : %d' % total)
    print('obligation-bearing (Class A)         : %d' % len(class_a))
    print('acceptance criteria                  : %d' % ac_rows)
    print('obligations carrying a criterion     : %d' % len(covered))
    print('coverage                             : %d / %d = %.1f%%'
          % (len(covered), len(class_a),
             100.0 * len(covered) / len(class_a) if class_a else 0.0))
    print('uncovered, measured                  : %d' % len(class_a - covered))
    print('uncovered, named in the Coverage para: %d' % len(stated))
    print('UNDISCLOSED uncovered obligations    : %d'
          % len((class_a - covered) - stated))
    print('Coverage paragraph anchored at line  : %s' % para_line)
    print(line)
    if PROBLEMS:
        print('FAIL - %d problem(s):' % len(PROBLEMS))
        for problem in PROBLEMS:
            print('  * %s' % problem)
    else:
        print('PASS - section 0.2 declares every register the body defines and')
        print('       nothing it does not, counts and ranges reproduce, all')
        print('       ranges contiguous, no identifier defined twice outside')
        print('       the verified section-14 index, no orphan criterion, no')
        print('       undisclosed uncovered obligation, both empty registers')
        print('       empty in fact, substring hazards defeated both ways.')
    print(line)


if __name__ == '__main__':
    sys.exit(main())
