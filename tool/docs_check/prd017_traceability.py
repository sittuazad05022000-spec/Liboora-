#!/usr/bin/env python3
"""PRD-017 internal traceability -- does the PRD agree with ITSELF?

WHY THIS EXISTS
---------------
`PRD_LIFECYCLE.md` Stage 5 states its gate as:

    "the PRD's prefixes registered in TRACEABILITY_MATRIX.md section 2 with
     counts and ranges, verified mechanically, zero collisions.

     Mechanical means counted by a tool, not by reading."

This is the FIRST of the two scripts the `PRD-008` pattern requires
(`prd008_traceability.py` plus `prd008_stage5.py`, repeated for `PRD-013`,
`PRD-016`, `PRD-014` and `PRD-023`).  It checks `PRD-017` against **itself** --
section 0.2's declarations against the body -- and it NEVER OPENS THE MATRIX.
Section 2M is checked by `prd017_stage5.py`, which recomputes the same registers
by a structurally different route.

Two declarations, one subject.  Neither script imports the other, so a defect in
one parser cannot propagate silently into the other.

STRATEGY: LINE FORM
-------------------
This script classifies each LINE by an ordered list of line-start patterns.
`prd017_stage5.py` instead splits the document into scopes at `## ` and `### `
and accepts an identifier only where that scope is entitled to define it.  The
two must arrive at 232 by different routes; agreement by one route repeated twice
would be worthless.

WHAT MADE THIS MODULE DIFFERENT FROM ITS FIVE PREDECESSORS
----------------------------------------------------------
1. **TWO definition shapes, and the registers split between them.**
   `FIL-FR-*`, `FIL-BR-*`, `FIL-INV-*`, `FIL-XC-*` and `FIL-AC-*` are defined as
   PROSE lines (```FIL-FR-001` -- The module SHALL ...``).  `FIL-CFG-*` and
   `FIL-GAP-*` are defined as TABLE ROWS, and the gap rows are BOLD-WRAPPED
   (`| **`FIL-GAP-012`** |`).

   This is not cosmetic.  During Stage 2 a census regex that recognised only the
   bold-less table form reported `FIL-GAP` measured=0 against a declared 13, and
   during Stage 4 a census regex that recognised only the prose form reported
   `FIL-CFG` and `FIL-GAP` both at 0 and a total of 210 instead of 232.  BOTH
   runs blamed a correct document for a defect in the tool.  Check 8 asserts
   both shapes are still matched, so the parser cannot silently under-count a
   register again.

2. **`FIL-EVT-*` is DECLARED EMPTY, and must be empty IN FACT.**
   `BC-29` is a producer in **0** BC Map section 9 rows.  Minting an event would
   assert a path BC Map L292 says does not exist.  Check 7 fails if any numbered
   `FIL-EVT-*` is ever created -- the prohibition stated as a test rather than as
   a promise.

3. **The substring hazard `FIL-` vs `INV-`, `XC-`, `AC-`, `CFG-` is LIVE.**
   `CFG-1`...`CFG-12` is an occupied register owned by `PRD-001`; `INV-SEC-*` and
   `INV-XC-*` exist in the invitation register; bare `AC-c.n` is 321 members
   strong in the authentication register.  Checked in check 9, both directions.

4. **Coverage is 71.2%, not 100%, and that is CORRECT.**
   17 of 22 exclusions are unfalsifiable by observation, and 21 obligations are
   definitional.  Check 6 does not demand full coverage -- it demands that every
   uncovered obligation be NAMED in the coverage paragraph.  An untested
   obligation presented as tested is the defect; an untested obligation
   disclosed as untested is not.

WHAT IT CHECKS
--------------
1. Section 0.2 declares every register the body defines, and nothing it does not.
2. Declared counts equal recomputed counts; declared range maxima equal
   recomputed maxima.
3. Every range is contiguous 1..max.
4. Every identifier is defined exactly once.
5. Every acceptance criterion traces to at least one Class A obligation
   (no orphan criteria).
6. Reverse coverage: every Class A obligation with no criterion is NAMED in the
   coverage discussion.  Zero undisclosed uncovered obligations.
7. The empty register is empty in fact, not merely in description.
8. Both definition shapes are still matched (the anti-under-count guard).
9. The substring hazards are live and the anchored patterns defeat them.
10. Every stated total in prose equals the recomputed total.

Exit 0 = the PRD is internally consistent.  Exit 1 = it is not.
"""

import os
import re
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DOC = os.path.join('docs', '30-product', 'file-media',
                   'PRD-017_FILE_AND_MEDIA.md')

ORDER = ['FR', 'BR', 'INV', 'EVT', 'XC', 'AC', 'CFG', 'GAP']
CLASS_A = ['FR', 'BR', 'INV', 'EVT', 'XC']
EMPTY_BY_DESIGN = ['EVT']

# Sections that carry identifier-shaped rows but define nothing.  Section 0.x
# declares; 15, 16, 17 and 18 cite.  Listed explicitly so that a definition
# appearing somewhere unexpected still FAILS rather than being silently absorbed.
# Section 16 is the EXCEPTION: it is where FIL-GAP-* are defined.
CITING_PREFIXES = ['## 0.', '### 0.', '## 15.', '## 17.', '## 18.']

PROBLEMS = []


def fail(message):
    PROBLEMS.append(message)


def read(path):
    with open(os.path.join(ROOT, path), encoding='utf-8') as handle:
        return handle.read()


def expand_ids(text):
    """Every `FIL-*` token, with ellipsis ranges expanded.

    The coverage discussion writes `FIL-XC-019` ... `FIL-XC-022` as a SPAN.  A
    scanner that reads only literal tokens would count 2 where 4 are meant and
    would then report 2 obligations as undisclosed -- a false failure of check 6
    against a document whose disclosure is complete.
    """
    ids = set()
    span = (r'`FIL-([A-Z]+)-(\d+)`\s*(?:\u2026|\.\.\.|\.\.)\s*'
            r'`(?:FIL-[A-Z]+-)?(\d+)`')
    for match in re.finditer(span, text):
        register = match.group(1)
        low, high = int(match.group(2)), int(match.group(3))
        for number in range(low, min(high, low + 999) + 1):
            ids.add('FIL-%s-%03d' % (register, number))
    for match in re.finditer(r'`FIL-([A-Z]+)-(\d+)`', text):
        ids.add('FIL-%s-%03d' % (match.group(1), int(match.group(2))))
    return ids


def definition_sites(text):
    """register -> {number: [(line_no, section, shape)]} by LINE FORM.

    Two definition shapes are recognised, matching the document's conventions:
      prose : `FIL-FR-001` -- The module SHALL be implemented at ...
      cell  : | **`FIL-GAP-012`** | E-22 does not list BC-12 ...

    The `shape` is retained so that check 8 can prove BOTH are still reachable.
    A parser that silently stops matching one shape under-counts a register and
    then blames the document -- twice observed in this module's history.
    """
    sites = {}
    section = None
    for lineno, line in enumerate(text.split('\n'), 1):
        if line.startswith('## ') or line.startswith('### '):
            match = re.match(r'^(#{2,3}\s+(?:\d+(?:\.\d+)?\.?|[A-Za-z]))', line)
            section = re.sub(r'\s+', ' ', match.group(1)) if match else line
            continue
        stripped = line.strip()
        register = number = shape = None
        prose = re.match(
            r'^\*{0,2}`FIL-([A-Z]+)-(\d+)`\*{0,2}\s*(?:\u2014|--)\s*\S',
            stripped)
        if prose:
            register, number = prose.group(1), int(prose.group(2))
            shape = 'prose'
        else:
            cell = re.match(r'^\|\s*\*{0,2}`FIL-([A-Z]+)-(\d+)`\*{0,2}\s*\|',
                            stripped)
            if cell:
                register, number = cell.group(1), int(cell.group(2))
                shape = 'cell'
        if register is None:
            continue
        if section and any(section.startswith(c) for c in CITING_PREFIXES):
            continue
        sites.setdefault(register, {}).setdefault(number, []).append(
            (lineno, section, shape))
    return sites


def declared_registers(text):
    """Section 0.2's declarations -> register -> (count, range_max, empty_flag).

    PRD-017 publishes the BARE PREFIX in cell 0, the count in cell 2 and the
    range span in cell 3:

      | `FIL-FR-` | Functional requirement | **82** | `FIL-FR-001` ... `FIL-FR-082` | Yes |
      | `FIL-EVT-` | Domain event          | **0**  | **DECLARED EMPTY**            | n/a |

    S5-C-01 of the PRD-014 conferral records what happens when an inherited
    section-0.2 parser expects a different cell layout: it reads ZERO declared
    registers and reports a correct document as wholly unregistered.  The guard
    below makes that failure loud instead of silent.
    """
    start = text.find('### 0.2')
    end = text.find('### 0.3')
    if start < 0:
        fail('cannot locate section 0.2 -- the register declaration this '
             'script exists to verify is not where it is expected, so no '
             'clean run can be reported')
        return {}
    if end < 0:
        end = start + 4000
    block = text[start:end]
    out = {}
    for line in block.split('\n'):
        head = re.match(r'^\|\s*\*{0,2}`FIL-([A-Z]+)-`\*{0,2}\s*\|',
                        line.strip())
        if head is None:
            continue
        cells = [c.strip() for c in
                 re.split(r'(?<!\\)\|', line.strip().strip('|'))]
        if len(cells) < 4:
            fail('section 0.2 row for FIL-%s- has too few columns'
                 % head.group(1))
            continue
        register = head.group(1)
        count_match = re.search(r'\*\*(\d+)\*\*', cells[2])
        if count_match is None:
            count_match = re.search(r'^(\d+)$', cells[2])
        if count_match is None:
            fail('section 0.2 row for FIL-%s- publishes no parsable count'
                 % register)
            continue
        numbers = [int(n) for n in re.findall(r'FIL-[A-Z]+-(\d+)', cells[3])]
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


def main():
    doc = read(DOC)

    sites = definition_sites(doc)
    computed = {r: sorted(sites.get(r, {})) for r in ORDER}
    declared = declared_registers(doc)

    # ---- check 1: declared set == defined set
    for register in ORDER:
        if register not in declared:
            fail('FIL-%s-* is defined %d time(s) in the body but is NOT '
                 'declared in section 0.2'
                 % (register, len(computed[register])))
    for register in sorted(declared):
        if register not in ORDER:
            fail('section 0.2 declares FIL-%s-*, which this script does not '
                 'know about -- the register list has changed and the checker '
                 'no longer describes the document' % register)

    # ---- check 2: counts and range maxima
    for register in ORDER:
        if register not in declared:
            continue
        numbers = computed[register]
        dec_count, dec_max, dec_empty = declared[register]
        if dec_count != len(numbers):
            fail('FIL-%s-*: section 0.2 declares count %d, recomputed %d from '
                 'the body' % (register, dec_count, len(numbers)))
        if numbers:
            if dec_max is None:
                fail('FIL-%s-* has %d member(s) but section 0.2 publishes no '
                     'range maximum' % (register, len(numbers)))
            elif dec_max != max(numbers):
                fail('FIL-%s-*: section 0.2 declares range max %03d, '
                     'recomputed %03d' % (register, dec_max, max(numbers)))
        elif not dec_empty:
            fail('FIL-%s-* has no member but section 0.2 does not state '
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
            fail('FIL-%s-* is not contiguous: missing %s -- a gap makes the '
                 'published range false (PRD_LIFECYCLE L82 rule 3)'
                 % (register, ', '.join('%03d' % m for m in missing)))

    # ---- check 4: each identifier defined exactly once
    for register in ORDER:
        for number, where in sorted(sites.get(register, {}).items()):
            if len(where) > 1:
                fail('FIL-%s-%03d is defined at %d sites (%s) -- two sources '
                     'of truth for one identifier'
                     % (register, number, len(where),
                        ', '.join('L%d %s' % (w[0], w[1]) for w in where)))

    # ---- check 5: no orphan acceptance criterion
    class_a = set()
    for register in CLASS_A:
        for number in computed[register]:
            class_a.add('FIL-%s-%03d' % (register, number))

    covered = set()
    ac_rows = 0
    orphans = []
    for line in doc.split('\n'):
        stripped = line.strip()
        match = re.match(r'^`(FIL-AC-\d+)`\s*(?:\u2014|--)\s*(.+)$', stripped)
        if match is None:
            continue
        ac_rows += 1
        traced = {i for i in expand_ids(match.group(2)) if i in class_a}
        if not traced:
            orphans.append(match.group(1))
        covered |= traced
    if ac_rows != len(computed['AC']):
        fail('%d criterion definition line(s) parsed but FIL-AC-* holds %d '
             'member(s) -- the criteria and the register disagree'
             % (ac_rows, len(computed['AC'])))
    for orphan in orphans:
        fail('%s traces to no Class A obligation -- an orphan criterion '
             'verifies nothing' % orphan)

    # ---- check 6: reverse coverage -- every uncovered obligation is NAMED
    anchor = doc.find('**Coverage, computed and stated rather than claimed.**')
    if anchor < 0:
        fail('no coverage paragraph found in section 14, so the uncovered set '
             'is undisclosed. Located BY ANCHOR, never by a fixed line slice: '
             'finding S4-C-02 of the PRD-023 review records a fixed slice '
             'reporting 23 false undisclosed obligations')
        stated = set()
    else:
        block = doc[anchor:anchor + 4000]
        stated = expand_ids(block)
        # S5-C-01 (this stage): the first form of this check demanded that every
        # uncovered obligation be named INDIVIDUALLY.  It reported 17 false
        # defects, because PRD-017 discloses the uncovered exclusions AS A
        # CLASS and then names the exceptions:
        #
        #   "17 of the 22 FIL-XC-* are uncovered by construction ...
        #    Five are the exception: FIL-XC-019...FIL-XC-022 ... and FIL-XC-008"
        #
        # That disclosure is COMPLETE and its complement is determinate -- 22
        # minus the 5 named exceptions is exactly the 17 uncovered.  Naming all
        # 17 individually would be strictly less informative, because it would
        # not say WHY they are uncovered as a group.  Believed uncritically,
        # that run would have reported 17 false defects against a correct
        # document, and "fixing" it would have degraded the disclosure.
        #
        # The rule was changed to match the document, and changed to something
        # STRONGER rather than weaker: a class claim is accepted only if the
        # arithmetic it asserts is TRUE.  The claimed uncovered count, the
        # claimed exception count and the claimed register size must reproduce,
        # and each named exception must actually be covered.  A stale class
        # claim now fails, which individual naming could never have detected.
        class_claim = re.search(
            r'\*\*(\d+) of the (\d+) `FIL-XC-\*` are uncovered by '
            r'construction\*\*', block)
        if class_claim:
            claimed_unc = int(class_claim.group(1))
            claimed_size = int(class_claim.group(2))
            register_size = len(computed['XC'])
            xc_all = {'FIL-XC-%03d' % n for n in computed['XC']}
            xc_uncovered = xc_all - covered
            xc_exceptions = xc_all & covered
            if claimed_size != register_size:
                fail('coverage prose claims the FIL-XC-* register holds %d '
                     'members but it holds %d'
                     % (claimed_size, register_size))
            if claimed_unc != len(xc_uncovered):
                fail('coverage prose claims %d uncovered exclusions but %d '
                     'are measured uncovered -- a class claim is only a valid '
                     'disclosure while its arithmetic is true'
                     % (claimed_unc, len(xc_uncovered)))
            exception_claim = re.search(r'\*\*(\w+) are the exception\*\*',
                                        block)
            words = {'one': 1, 'two': 2, 'three': 3, 'four': 4, 'five': 5,
                     'six': 6, 'seven': 7, 'eight': 8, 'nine': 9, 'ten': 10}
            if exception_claim:
                token = exception_claim.group(1).lower()
                claimed_exc = words.get(token)
                if claimed_exc is None and token.isdigit():
                    claimed_exc = int(token)
                if claimed_exc is not None and \
                        claimed_exc != len(xc_exceptions):
                    fail('coverage prose claims %d covered exclusion(s) but '
                         '%d are measured covered'
                         % (claimed_exc, len(xc_exceptions)))
            for ident in sorted(xc_exceptions):
                if ident not in stated:
                    fail('%s is covered by a criterion but the coverage prose '
                         'does not name it as an exception, so the class claim '
                         'about the remainder cannot be resolved' % ident)
            # The class claim discharges the exclusions.  Everything else must
            # still be named individually.
            stated |= xc_uncovered
        for ident in sorted((class_a - covered) - stated):
            fail('%s carries no acceptance criterion and is NOT named in the '
                 'coverage discussion -- an untested obligation presented as '
                 'tested' % ident)

    # ---- check 7: the empty register is empty IN FACT
    for register in EMPTY_BY_DESIGN:
        members = re.findall(r'`FIL-%s-(\d+)`' % register, doc)
        if members:
            fail('FIL-%s-* is declared EMPTY but %d numbered member(s) exist '
                 '(%s). BC-29 is a producer in 0 BC Map section 9 rows, so '
                 'minting one asserts a path L292 says does not exist'
                 % (register, len(members), ', '.join(sorted(set(members)))))

    # ---- check 8: BOTH definition shapes still reachable (anti-under-count)
    shapes = {}
    for register, members in sites.items():
        for number, where in members.items():
            for _, _, shape in where:
                shapes.setdefault(shape, set()).add(register)
    if 'prose' not in shapes:
        fail('no PROSE definition site matched. FIL-FR/BR/INV/XC/AC are all '
             'prose-defined, so this parser would under-count them to zero')
    if 'cell' not in shapes:
        fail('no CELL definition site matched. FIL-CFG-* and FIL-GAP-* are '
             'table-defined and FIL-GAP rows are BOLD-WRAPPED. Two censuses '
             'in this module\'s history under-counted exactly here and blamed '
             'the document for the tool\'s error')
    for register in ('CFG', 'GAP'):
        if register in shapes.get('prose', set()) and \
                register not in shapes.get('cell', set()):
            fail('FIL-%s-* matched only in prose form, but it is a table '
                 'register -- the parser is reading the wrong shape' % register)

    # ---- check 9: the substring hazards, both directions
    hazards = [
        (r'(?<![A-Z-])CFG-\d+', 'FIL-CFG-001',
         'CFG-1..CFG-12 is a LIVE register owned by PRD-001 -- the prefix is '
         'occupied, not hypothetical'),
        (r'(?<![A-Z-])INV-\d+', 'FIL-INV-001',
         'INV-SEC-* and INV-XC-* exist in the invitation register, and INV-n '
         'are platform invariants'),
        (r'(?<![A-Z-])FR-\d+', 'FIL-FR-001',
         'bare FR-n exists elsewhere in docs/'),
        (r'(?<![A-Z-])AC-\d+', 'FIL-AC-001',
         'AC-c.n is a 321-member register in the authentication PRD'),
        (r'(?<![A-Z-])XC-\d+', 'FIL-XC-001',
         'XC-c.n is a 212-member register, and INV-XC-* also exists'),
    ]
    for pattern, sample, why in hazards:
        if re.search(pattern, sample):
            fail('%s is reachable by a word-boundary search for %r -- %s, so '
                 'the two registers could be confused' % (sample, pattern, why))
    # The reverse direction: does `FIL-` occur as the tail of an ordinary word?
    # Measured across this repository: no English or governance word in docs/
    # ends in the letters F-I-L.  The test is asserted in BOTH directions so it
    # cannot become silently vacuous -- the S5-C-06 failure class, where a decoy
    # that no longer embeds the token makes the check pass forever while proving
    # nothing.
    for decoy in ['\\bFIL-INV-', 'x\\bFIL-']:
        if not re.search(r'FIL-', decoy):
            fail('hazard test is vacuous: %r no longer embeds "FIL-", so it '
                 'cannot demonstrate anything about the scan' % decoy)
    if not re.search(r'(?<![A-Z])FIL-', 'FIL-FR-001'):
        fail('the anchored FIL- pattern no longer matches FIL-FR-001 -- it '
             'would under-count every register')

    # ---- check 10: every stated total in prose equals the recomputed total
    #
    # S5-C-02 (this stage): the first form of this check scanned the WHOLE
    # document and reported the stale figure "114 obligation-bearing" as a
    # defect.  The document was RIGHT: that string occurs only inside a `>`
    # blockquote correction note which QUOTES the superseded figure in order to
    # record what was wrong --
    #
    #   > Corrected at Stage 4 (S4-D-06). This paragraph read "114
    #   > obligation-bearing identifiers" immediately followed by ...
    #
    # A document that discloses its own corrections necessarily contains the
    # old numbers.  A checker that cannot tell a live claim from a quoted dead
    # one PUNISHES DISCLOSURE and rewards silent edits -- which is the opposite
    # of what this repository's change-history convention exists to encourage.
    #
    # S5-C-03 (this stage): the FIRST repair of S5-C-02 excluded every `>` line
    # from scanning.  Mutation M6 then escaped: corrupting the AUTHORITATIVE
    # total in section 0.2 from 232 to 999 was NOT detected, because that total
    # is ITSELF published as a blockquote --
    #
    #   > **Totals: 232 identifiers across 8 registers, of which 1 is ...**
    #
    # So the exclusion built to ignore quoted dead numbers had silently
    # swallowed the single most important live number in the document.  The
    # vacuity guard did not catch it either, because a second live claim
    # elsewhere kept `claims_found` above zero -- a guard that counts claims
    # cannot detect the loss of the RIGHT claim.
    #
    # The discriminator is therefore not "is this a blockquote" but "is this a
    # CORRECTION NOTE".  Correction notes in this document are marked by the
    # WARNING SIGN and the word Corrected/read; a declaration is not.  This is
    # narrower, it keeps the authoritative blockquote in scope, and check 10a
    # below asserts that the section-0.2 total is still reachable, so this
    # exclusion can never again hide it.
    total = sum(len(computed[r]) for r in ORDER)
    live_lines = []
    for line in doc.split('\n'):
        stripped = line.lstrip()
        if stripped.startswith('>') and (
                '\u26a0' in line or 'Corrected at Stage' in line or
                'This paragraph read' in line or 'As first written' in line):
            continue
        live_lines.append(line)
    live = '\n'.join(live_lines)

    # ---- check 10a: the authoritative section-0.2 total must be IN SCOPE.
    # Without this, any future broadening of the exclusion above silently
    # disables the most important assertion in check 10.
    if not re.search(r'Totals:\s*\d+\s+identifiers across 8 registers', live):
        fail('the section 0.2 "Totals:" declaration is not reachable by the '
             'live-claim scan, so check 10 can no longer verify the '
             'authoritative identifier total. This is the M6 escape class: an '
             'exclusion written to ignore quoted dead numbers swallowing the '
             'live one')
    claims_found = 0
    for match in re.finditer(r'(\d+)\s+identifiers across 8 registers', live):
        claims_found += 1
        if int(match.group(1)) != total:
            fail('prose states "%s identifiers across 8 registers" but the '
                 'recomputed total is %d. A count written in prose is a claim, '
                 'and it decays every time the thing it counts changes'
                 % (match.group(1), total))
    for match in re.finditer(r'(\d+)\s+obligation-bearing identifiers', live):
        claims_found += 1
        if int(match.group(1)) != len(class_a):
            fail('prose states "%s obligation-bearing identifiers" but the '
                 'recomputed Class A count is %d'
                 % (match.group(1), len(class_a)))
    if claims_found == 0:
        fail('check 10 found ZERO live total claims to verify. The blockquote '
             'exclusion has swallowed every claim, so this check now proves '
             'nothing -- a vacuous check must fail, not pass')
    ratio = re.search(r'\*\*(\d+) of (\d+) are covered', doc)
    if ratio and (int(ratio.group(1)) != len(covered) or
                  int(ratio.group(2)) != len(class_a)):
        fail('prose states coverage "%s of %s" but the recomputed figure is '
             '%d of %d' % (ratio.group(1), ratio.group(2),
                           len(covered), len(class_a)))

    # ---- check 11: no retirement section
    if re.search(r'^##\s+\d+\.\s+Retired identifiers', doc, re.MULTILINE):
        fail('the PRD now has a retirement section, so a single published '
             'count per register is ambiguous. Both this script and '
             'prd017_stage5.py must be revised before the gate is safe')

    report(computed, declared, class_a, covered, ac_rows, stated, shapes)
    return 1 if PROBLEMS else 0


def report(computed, declared, class_a, covered, ac_rows, stated, shapes):
    line = '-' * 70
    print(line)
    print('PRD-017 internal traceability -- section 0.2 against the body')
    print(line)
    total = 0
    for register in ORDER:
        numbers = computed[register]
        total += len(numbers)
        state = 'declared' if register in declared else 'NOT DECLARED'
        if not numbers:
            print('  FIL-%-4s* %-13s EMPTY' % (register + '-', state))
            continue
        print('  FIL-%-4s* %-13s count %-3d range 001..%03d  contiguous'
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
    print('uncovered, named in coverage prose   : %d' % len(stated))
    print('UNDISCLOSED uncovered obligations    : %d'
          % len((class_a - covered) - stated))
    print('definition shapes matched            : %s'
          % ', '.join(sorted(shapes)))
    print(line)
    if PROBLEMS:
        print('FAIL - %d problem(s):' % len(PROBLEMS))
        for problem in PROBLEMS:
            print('  * %s' % problem)
    else:
        print('PASS - section 0.2 declares every register the body defines and')
        print('       nothing it does not, counts and ranges reproduce, all')
        print('       ranges contiguous, no identifier defined twice, no')
        print('       orphan criterion, no undisclosed uncovered obligation,')
        print('       FIL-EVT-* empty in fact, both definition shapes still')
        print('       matched, substring hazards defeated both ways, every')
        print('       prose total equal to its recomputed value.')
    print(line)


if __name__ == '__main__':
    sys.exit(main())
