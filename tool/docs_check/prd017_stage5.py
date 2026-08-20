#!/usr/bin/env python3
"""PRD-017 Stage 5 gate -- does TRACEABILITY_MATRIX.md agree with the PRD?

WHY THIS EXISTS
---------------
`PRD_LIFECYCLE.md` Stage 5 states its gate as:

    "the PRD's prefixes registered in TRACEABILITY_MATRIX.md section 2 with
     counts and ranges, verified mechanically, zero collisions.

     Mechanical means counted by a tool, not by reading."

`prd017_traceability.py` checks `PRD-017` against **itself** and never opens the
matrix, so without this script section 2M could have been written with any
numbers in it and nothing would have objected.  This is the second of the two
scripts the `PRD-008` pattern requires (`prd008_traceability.py` plus
`prd008_stage5.py`, repeated for `PRD-013`, `PRD-016`, `PRD-014` and `PRD-023`),
and it is deliberately **not** an import of the first: the two recompute the
register independently, so a bug in one does not propagate silently into the
other.  Two declarations, one subject.

It adds a check and weakens nothing.  All twenty-three pre-existing scripts
under `tool/docs_check/` are untouched and must continue to behave exactly as
before -- including the five that already exit 1 for their own recorded
reasons.

INDEPENDENCE IS STRUCTURAL, NOT PROMISED
----------------------------------------
`TRACEABILITY_MATRIX.md` section 2H.2 names the failure mode this pair exists to
avoid: "a checker written in the same pass as the register it checks, by the
same author, verifies agreement with itself."  Two mitigations are applied:

  * No import.  This file re-derives every register from the PRD body with its
    own parser.  A defect in one parser cannot be inherited by the other.
  * A DIFFERENT parsing strategy.  `prd017_traceability.py` classifies each line
    by line-start FORM -- prose definition, table cell -- and does not care
    where in the document the line sits.  This script splits the document into
    scopes at BOTH `## ` and `### ` and accepts an identifier only where that
    scope is ENTITLED to define it.  The two arrive at 232 by structurally
    different routes, which is evidence; agreement by one route repeated twice
    would not be.

    The difference is load-bearing rather than cosmetic.  The scope parser
    catches a class the line parser cannot see at all: a register defined in a
    section that has no business defining it -- a `FIL-INV-*` minted inside
    section 11 UI/UX, or a `FIL-FR-*` minted inside section 14 among the
    acceptance criteria.  Conversely the line parser catches shapes this one
    would miss.  Neither subsumes the other.

WHAT MADE THIS MODULE DIFFERENT FROM ITS FIVE PREDECESSORS
----------------------------------------------------------
1. **The inward substring hazard is the sharpest yet, because BOTH registers
   are occupied.**  `PRD-023` carried `CNF-CFG-*` against an occupied
   `CFG-1`...`CFG-12`, and section 2L records that as the sharpest case any
   module had carried -- but `CNF-CFG-*` is EMPTY, so a naive scan that swept it
   up would have been counting members of a register with none.  Here
   `FIL-CFG-001`...`FIL-CFG-009` are **nine real members**, and `CFG-1`...`CFG-12`
   (owned by `PRD-001`, FROZEN v2.0) are twelve real members.  A naive
   `CFG-\\d+` scan would silently merge two live registers owned by two
   different FROZEN-status documents.  Checked in both directions, and the
   assertion that the anchored form still matches its own members is what stops
   the test becoming vacuous.

2. **The reverse hazard is PRESENT IN THE DOCUMENT, as prose about itself.**
   Every predecessor either had no reverse hazard or manufactured a decoy.
   `PRD-017` section 0.4 records the measurement `grep -roE '\\b[A-Z]*FIL-'` ->
   0 matches, and the sentence naming a "hypothetical `PROFIL-`" is the ONLY
   occurrence in the entire `docs/` tree of an alphanumeric immediately
   preceding `FIL-`.  That is prose *about* a pattern, not a word embedding the
   prefix -- the `S5-C-02` family that section 2L.4 item 3 records one layer on.
   Check 4b therefore asserts the anchored form rejects both `XFIL-` and
   `PROFIL-`, so the document's own claim is tested rather than believed.

3. **Only ONE register is empty, and it is empty for an ARCHITECTURAL reason
   that a later edit could silently break.**  `FIL-EVT-*` is declared empty
   because BC Map section 9 lists no `BC-29` producer row and L292 rules that an
   edge not in the table does not exist.  `PRD-017` section 13.2 goes further and
   records that `E-20` is therefore *not available* to this module.  Minting one
   `FIL-EVT-001` would assert an edge the BC Map does not carry.  Check 7
   enforces the emptiness as a test.

4. **Architecture alignment is NOT clean, and this script must not let section
   2M pretend otherwise.**  `FIL-GAP-012` and blocker `B-11` -- `E-22` does not
   list `BC-12` as a consumer -- are OPEN.  Check 10 fails if section 2M claims
   architecture alignment, or claims Stage 6 or freeze.  This is the only
   predecessor to carry a check whose purpose is to stop the matrix
   over-claiming; it exists because the Stage 5 instruction for this module
   said, in terms, "do not falsely mark alignment if a governance/architecture
   dependency remains unresolved."

WHAT IT CHECKS
--------------
1.  Section 2M exists.  Its absence IS the Stage 5 failure, so it is reported as
    such rather than as a missing section.
2.  Every register `PRD-017` defines has a row in section 2M whose count and
    range maximum agree with values recomputed from the PRD body, and section 2M
    registers nothing the PRD does not define.
3.  Every range is contiguous 1..max.
4.  Zero collisions, in three directions:
    (a) inward -- no `FIL-<REG>` stem collides with a prefix already registered
        elsewhere in the matrix, and no bare `FIL-<n>` identifier exists;
    (b) the substring hazard -- `FIL-CFG-001` must not be reachable by a search
        for a bare `CFG-001`, nor `FIL-INV-001` by `INV-001`, tested in BOTH
        directions so the test cannot become vacuous, plus the reverse
        direction against `XFIL-` and `PROFIL-`;
    (c) outward -- no document outside the file-media module DEFINES a `FIL-*`
        identifier.  A citation is not a collision (the section 2C.1
        principle), so each outside occurrence is resolved against the defined
        set rather than counted as a failure.
5.  Section 2M's own totals arithmetic is recomputed, not trusted.
6.  No retirement register exists, and section 2M does not publish an
    "in force (declared)" pair that would imply one.
7.  `FIL-EVT-*` appears in section 2M, is published as 0, is stated to be
    DECLARED EMPTY, and holds no member in the PRD.
8.  Section 2M's published coverage figure is recomputed from the PRD, with
    ellipsis ranges expanded.
9.  The four traceability directions Stage 5 requires are each present and
    non-vacuous: to authoritative source, to architecture decision, to
    acceptance criterion, to implementation task.
10. Section 2M does NOT claim architecture alignment, Stage 6, or freeze while
    `FIL-GAP-012` is open -- and the openness is read from the PRD, not from
    section 2M's own say-so.

Exit 0 = Stage 5 gate satisfied.  Exit 1 = it is not.
"""

import os
import re
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DOC = os.path.join('docs', '30-product', 'file-media',
                   'PRD-017_FILE_AND_MEDIA.md')
MATRIX = os.path.join('docs', '40-implementation', 'TRACEABILITY_MATRIX.md')

# Directories entitled to DEFINE a FIL-* identifier.
OWNED_DIRS = [
    os.path.join('docs', '30-product', 'file-media'),
    os.path.join('docs', '40-implementation', 'file-media'),
]

ORDER = ['FR', 'BR', 'INV', 'EVT', 'XC', 'AC', 'CFG', 'GAP']
CLASS_A = ['FR', 'BR', 'INV', 'EVT', 'XC']
EMPTY_BY_DESIGN = ['EVT']

PROBLEMS = []

# ---------------------------------------------------------------------------
# The authorisation table: which scope may define which register.
#
# DERIVED FROM A MEASUREMENT OF THE DOCUMENT, NOT GUESSED.  It was produced by
# harvesting every definition site in `PRD-017` and grouping by scope, then
# read back.  Guessing it would defeat the purpose: a guessed table either
# forbids something the document legitimately does (a false failure) or permits
# a scope the document never uses (a hole the parser cannot see through).
#
# `PRD-023` needed twenty-one scopes for `CNF-FR-*` alone.  `PRD-017` needs
# FIFTEEN for `FIL-FR-*`, because upload, the `FileRef` contract, metadata,
# read/access, isolation, lifecycle, derivatives, failure/retry, progress,
# extensibility and shared-object access each carry functional requirements,
# and three more sit in the boundary sections 2.1/2.4/2.5 where the module's
# position and its two frozen consumers are fixed normatively.
#
# Two scopes are DUAL-REGISTER and that is deliberate rather than sloppy:
#   * `### 3.2` defines both `FIL-FR-*` and `FIL-BR-*`, because the section
#     states what the module must do about permissions AND the rule that it
#     never defines them.
# A scope listed here that DISAPPEARS from the document fails the run -- see
# `definitions_by_scope`.  That is the guard against a register migrating to a
# section this parser does not look at.
# ---------------------------------------------------------------------------
SCOPE_REGISTERS = {
    '### 2.1':  ['FR'],
    '### 2.3':  ['XC'],
    '### 2.4':  ['FR'],
    '### 2.5':  ['FR'],
    '### 3.2':  ['FR', 'BR'],
    '### 4.1':  ['FR'],
    '### 4.2':  ['FR'],
    '### 4.3':  ['FR'],
    '### 4.4':  ['FR'],
    '### 4.5':  ['FR'],
    '### 4.6':  ['FR'],
    '### 4.7':  ['FR'],
    '### 4.8':  ['FR'],
    '### 4.9':  ['FR'],
    '### 4.10': ['FR'],
    '### 4.11': ['FR'],
    '## 5.':    ['BR'],
    '### 6.2':  ['INV'],
    '### 8.5':  ['CFG'],
    '### 14.1': ['AC'],
    '### 14.2': ['AC'],
    '### 14.3': ['AC'],
    '### 14.4': ['AC'],
    '## 16.':   ['GAP'],
}


def fail(message):
    PROBLEMS.append(message)


def read(path):
    full = os.path.join(ROOT, path)
    if not os.path.isfile(full):
        fail('missing file: %s' % path)
        return ''
    with open(full, encoding='utf-8') as handle:
        return handle.read()


def walk_markdown():
    """Every .md under docs/, plus tool/ python and test/ dart, as (rel, text)."""
    out = []
    for base, exts in (('docs', ('.md',)),
                       ('tool', ('.py', '.dart', '.yaml')),
                       ('lib', ('.dart',)),
                       ('test', ('.dart',))):
        root = os.path.join(ROOT, base)
        if not os.path.isdir(root):
            continue
        for folder, _dirs, files in os.walk(root):
            for name in files:
                if not name.endswith(exts):
                    continue
                full = os.path.join(folder, name)
                rel = os.path.relpath(full, ROOT)
                try:
                    with open(full, encoding='utf-8') as handle:
                        out.append((rel, handle.read()))
                except (UnicodeDecodeError, OSError):
                    continue
    return out


def scopes(text):
    """Split into scopes at BOTH '## ' and '### ' -> [(key, body)].

    Splitting at the deeper level is what makes 4.11 and 14.4 separate scopes
    rather than part of 4 and 14, and is the structural difference from
    prd017_traceability.py's line-form approach.  The line parser has no
    concept of position at all; this one has nothing else.
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
    """register -> sorted numbers, harvested PER SCOPE.

    An identifier counts only where its scope is entitled to define it.  Two
    shapes are recognised, because `PRD-017` uses both:

      * prose  -- `` `FIL-FR-001` — The module SHALL ... ``
      * cell   -- ``| `FIL-CFG-001` | ... |`` and the bold-wrapped gap form
                  ``| **`FIL-GAP-012`** | ... |``

    The bold-wrapped cell is the shape that fooled a census tool at Stage 2 of
    this very module, so it is matched explicitly rather than by hope.
    """
    found = {}
    seen_scopes = set()
    for key, body in scopes(text):
        allowed = None
        # Longest-prefix match, so '### 4.11' is not captured by '### 4.1'.
        for prefix in sorted(SCOPE_REGISTERS, key=len, reverse=True):
            if key == prefix.rstrip() or key.startswith(prefix):
                allowed = SCOPE_REGISTERS[prefix]
                seen_scopes.add(prefix)
                break
        for line in body.split('\n'):
            stripped = line.strip()
            register = number = None
            prose = re.match(
                r'^`FIL-([A-Z]+)-(\d+)`\s*(?:\u2014|--)\s*\S', stripped)
            if prose:
                register, number = prose.group(1), int(prose.group(2))
            else:
                cell = re.match(
                    r'^\|\s*\*{0,2}`FIL-([A-Z]+)-(\d+)`\*{0,2}\s*\|', stripped)
                if cell:
                    register, number = cell.group(1), int(cell.group(2))
            if register is None:
                continue
            if allowed is None:
                fail('FIL-%s-%03d appears in definition position in scope "%s", '
                     'which is not entitled to define any register'
                     % (register, number, key))
                continue
            if register not in allowed:
                fail('FIL-%s-%03d is defined in scope "%s", which defines %s'
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
    """Every `FIL-*` token, with ellipsis ranges expanded.

    `FIL-FR-013`...`FIL-FR-033` cites twenty-one requirements in eleven
    characters.  A scan that reads only the endpoints reports nineteen dangling
    citations that are not dangling, and -- worse for check 8 -- undercounts
    coverage.
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


def section_2m(matrix):
    """The text of section 2M, or '' if it does not exist."""
    match = re.search(r'^## 2M\.[^\n]*\n(.*?)(?=^## \d)', matrix,
                      re.M | re.S)
    return match.group(1) if match else ''


def matrix_rows(block):
    """register -> (count, range_max) parsed from section 2M's inventory table."""
    rows = {}
    for line in block.split('\n'):
        if not line.startswith('|'):
            continue
        cells = [cell.strip() for cell in line.strip().strip('|').split('|')]
        if len(cells) < 4:
            continue
        head = re.match(r'^\*{0,2}`FIL-([A-Z]+)-\*`\*{0,2}$', cells[0])
        if not head:
            continue
        register = head.group(1)
        count_cell = cells[2]
        count_match = re.search(r'\*{0,2}(\d+)\*{0,2}', count_cell)
        if not count_match:
            fail('section 2M row for FIL-%s-* publishes no count' % register)
            continue
        count = int(count_match.group(1))
        range_cell = cells[3]
        numbers = [int(n) for n in re.findall(r'(\d{2,3})', range_cell)]
        rows[register] = (count, max(numbers) if numbers else 0)
    return rows


def main():
    doc = read(DOC)
    matrix = read(MATRIX)
    if not doc or not matrix:
        return report(None, None, None, None, None, None, None)

    computed = definitions_by_scope(doc)

    # ---- check 1: does section 2M exist at all?
    block = section_2m(matrix)
    if not block:
        fail('TRACEABILITY_MATRIX.md has no section 2M -- the Stage 5 gate is '
             'not satisfied. The gate is the registration, not the intention '
             'to register. (%d identifiers were nonetheless recomputed from '
             'the PRD body across %d registers, so the numbers are ready.)'
             % (sum(len(v) for v in computed.values()), len(computed)))
        return report(computed, {}, None, None, None, None, None)

    rows = matrix_rows(block)

    # ---- check 2: published numbers vs recomputed
    for register in ORDER:
        have = computed.get(register, [])
        if register in rows:
            count, top = rows[register]
            if count != len(have):
                fail('section 2M publishes FIL-%s-* count %d; the PRD body '
                     'defines %d' % (register, count, len(have)))
            if have and top != max(have):
                fail('section 2M publishes FIL-%s-* range max %03d; the PRD '
                     'body reaches %03d' % (register, top, max(have)))
            if not have and count != 0:
                fail('section 2M publishes FIL-%s-* count %d but the PRD body '
                     'defines none' % (register, count))
        elif have:
            fail('the PRD defines %d FIL-%s-* identifier(s) but section 2M has '
                 'no row for that register -- an unregistered register is the '
                 'exact condition Stage 5 exists to prevent'
                 % (len(have), register))
    for register in sorted(rows):
        if register not in ORDER:
            fail('section 2M registers FIL-%s-*, which is not one of the eight '
                 'registers PRD-017 section 0.2 declares' % register)
        elif register not in computed and rows[register][0] != 0:
            fail('section 2M registers FIL-%s-* with count %d, but the PRD '
                 'body defines no such identifier'
                 % (register, rows[register][0]))

    # ---- check 3: contiguity 1..max
    for register, numbers in sorted(computed.items()):
        if not numbers:
            continue
        expected = list(range(1, max(numbers) + 1))
        if numbers != expected:
            holes = sorted(set(expected) - set(numbers))
            fail('FIL-%s-* is not contiguous 001..%03d -- missing %s'
                 % (register, max(numbers),
                    ', '.join('%03d' % h for h in holes[:12])))

    # ---- check 6: no retirement register, and no "in force (declared)" pair
    if re.search(r'\bFIL-[A-Z]+-\d+\b[^\n]{0,80}\bretired\b', doc, re.I):
        fail('the PRD appears to retire an identifier -- section 0.2 states '
             'none is retired, so one count per register would no longer be '
             'unambiguous and both scripts must be revisited')
    if re.search(r'in force\s*\(declared\)', block, re.I):
        fail('section 2M publishes an "in force (declared)" pair, which implies '
             'a retirement this PRD does not have')

    # ---- check 4a: inward stem collision against every prefix the matrix
    #      already registers, parsed rather than read from a hand-list.
    stems = set()
    for match in re.finditer(
            r'^\|\s*\*{0,2}`([A-Z][A-Z0-9]*(?:-[A-Z]+)*)-\*`\*{0,2}\s*\|',
            matrix, re.M):
        stems.add(match.group(1))
    for match in re.finditer(
            r'`([A-Z][A-Z0-9]{1,9})-(?:FR|BR|INV|EVT|XC|AC|CFG|GAP|NFR)-\*?`',
            matrix):
        stems.add(match.group(1))
    if not stems:
        fail('check 4a is vacuous: no prefix stem was parsed out of the matrix '
             'at all, so "no collision" would be meaningless')
    for register in computed:
        stem = 'FIL-%s' % register
        if stem in stems and stem not in ('FIL-%s' % r for r in ORDER):
            fail('stem %s collides with a prefix already registered elsewhere '
                 'in the matrix' % stem)
    foreign = sorted(s for s in stems if s == 'FIL' or s.startswith('FIL-'))
    expected_own = {'FIL'} | {'FIL-%s' % r for r in ORDER}
    for stem in foreign:
        if stem not in expected_own:
            fail('the matrix registers stem %s, which PRD-017 does not declare'
                 % stem)
    if re.search(r'(?<![A-Za-z0-9-])FIL-\d+(?![0-9])', doc):
        fail('the PRD contains a bare FIL-<n> identifier with no register '
             'segment -- every identifier must name its register')

    # ---- check 4b: the substring hazard, in BOTH directions.
    #
    # This is the sharpest inward hazard any module in this repository has
    # carried, and the reason is arithmetic rather than rhetorical.  PRD-023
    # carried `CNF-CFG-*` against an occupied `CFG-1`...`CFG-12`, but
    # `CNF-CFG-*` is EMPTY -- a naive scan sweeping it up would have counted
    # members of a register with none.  `FIL-CFG-*` has NINE real members
    # against twelve real `CFG-n` owned by PRD-001 (FROZEN v2.0).  A naive
    # `CFG-\d+` scan silently merges two live registers owned by two different
    # documents.
    #
    # Each case asserts BOTH that the bare pattern misses the FIL- member and
    # that the anchored pattern still hits its own.  Only asserting the first
    # would pass for a pattern that matches nothing at all.
    hazards = [
        (r'(?<![A-Z-])CFG-\d+', 'FIL-CFG-001', r'(?<![A-Za-z0-9-])FIL-CFG-\d+'),
        (r'(?<![A-Z-])INV-\d+', 'FIL-INV-001', r'(?<![A-Za-z0-9-])FIL-INV-\d+'),
        (r'(?<![A-Z-])FR-\d+',  'FIL-FR-001',  r'(?<![A-Za-z0-9-])FIL-FR-\d+'),
        (r'(?<![A-Z-])AC-\d+',  'FIL-AC-001',  r'(?<![A-Za-z0-9-])FIL-AC-\d+'),
    ]
    for bare, vector, anchored in hazards:
        if re.search(bare, vector):
            fail('substring hazard LIVE: a bare search %r reaches %s, so a '
                 'census of the neighbouring register would absorb this '
                 'module\'s members' % (bare, vector))
        if not re.search(anchored, vector):
            fail('check 4b is vacuous for %s: the anchored form %r does not '
                 'match its own member, so the negative result above proves '
                 'nothing' % (vector, anchored))

    # The REVERSE direction.  PRD-017 section 0.4 claims, by measurement, that
    # no register such as a hypothetical `PROFIL-` exists.  That sentence is
    # the ONLY place in the docs tree where an alphanumeric immediately
    # precedes `FIL-` -- prose ABOUT a pattern, not a word embedding the
    # prefix.  The claim is tested rather than believed.
    for bad in ('XFIL-FR-001', 'PROFIL-FR-001', 'AFIL-CFG-001'):
        if re.search(r'(?<![A-Za-z0-9-])FIL-[A-Z]+-\d+', bad):
            fail('reverse substring hazard LIVE: the anchored form reaches %s, '
                 'so a longer prefix ending in FIL would be counted as this '
                 'module\'s' % bad)
    if not re.search(r'(?<![A-Za-z0-9-])FIL-[A-Z]+-\d+', 'see `FIL-FR-001` now'):
        fail('check 4b reverse is vacuous: the anchored form cannot find a '
             'genuine identifier in ordinary prose')

    # ---- check 4c: outward definitions.  A citation is not a collision.
    defined = set()
    for register, numbers in computed.items():
        for number in numbers:
            defined.add('FIL-%s-%03d' % (register, number))
    outward = []
    citations = 0
    files_scanned = 0
    for rel, text in walk_markdown():
        files_scanned += 1
        owned = any(rel.startswith(d + os.sep) for d in OWNED_DIRS)
        if owned:
            continue
        for line in text.split('\n'):
            stripped = line.strip()
            hit = (re.match(r'^`FIL-([A-Z]+)-(\d+)`\s*(?:\u2014|--)\s*\S',
                            stripped)
                   or re.match(r'^\|\s*\*{0,2}`FIL-([A-Z]+)-(\d+)`\*{0,2}\s*\|',
                               stripped))
            if hit:
                outward.append('%s defines FIL-%s-%03d'
                               % (rel, hit.group(1), int(hit.group(2))))
        for ident in expand_ids(text):
            citations += 1
            if ident not in defined:
                # A python checker naming its own test vectors is not citing a
                # requirement.  Narrowly excluded, and only for tool/ files,
                # so it cannot rot into a blanket exemption for docs.
                if rel.startswith('tool' + os.sep):
                    continue
                outward.append('%s cites %s, which is defined nowhere'
                               % (rel, ident))
    if files_scanned < 50:
        fail('check 4c is vacuous: only %d file(s) were scanned, so "no '
             'outward definition" would be an artefact of not looking'
             % files_scanned)
    for problem in outward:
        fail('outward collision -- %s' % problem)

    # ---- check 5: section 2M's own totals arithmetic, recomputed
    total = sum(len(v) for v in computed.values())
    class_a = sum(len(computed.get(r, [])) for r in CLASS_A)
    published_total = None
    match = re.search(r'\|\s*\*{0,2}Total\*{0,2}\s*\|[^|]*\|\s*\*{0,2}(\d+)\*{0,2}\s*\|',
                      block)
    if match:
        published_total = int(match.group(1))
        if published_total != total:
            fail('section 2M publishes a Total of %d; the PRD body defines %d'
                 % (published_total, total))
    else:
        fail('section 2M has no Total row -- the arithmetic cannot be checked, '
             'and a table of counts without a total is where the 114-vs-132 '
             'defect of Stage 4 lived')
    match = re.search(r'obligation-bearing[^|\n]*\|\s*\*{0,2}(\d+)\*{0,2}', block, re.I)
    if match and int(match.group(1)) != class_a:
        fail('section 2M publishes %s obligation-bearing identifiers; the PRD '
             'body defines %d' % (match.group(1), class_a))

    # ---- check 7: FIL-EVT-* registered as empty AND empty in fact
    for register in EMPTY_BY_DESIGN:
        if register not in rows:
            fail('FIL-%s-* is declared EMPTY by the PRD but has no row in '
                 'section 2M -- an empty register must be REGISTERED as empty, '
                 'not omitted, or a later reader cannot tell emptiness from '
                 'oversight' % register)
            continue
        if rows[register][0] != 0:
            fail('section 2M publishes FIL-%s-* count %d; it must be 0'
                 % (register, rows[register][0]))
        row_text = ''
        for line in block.split('\n'):
            if re.match(r'^\|\s*\*{0,2}`FIL-%s-\*`' % register, line):
                row_text = line
        if 'EMPTY' not in row_text.upper():
            fail('section 2M\'s FIL-%s-* row does not state that the register '
                 'is DECLARED EMPTY' % register)
        if computed.get(register):
            fail('FIL-%s-* is declared EMPTY but the PRD body defines %d '
                 'member(s) -- minting one asserts an edge the BC Map does not '
                 'carry' % (register, len(computed[register])))

    # ---- check 8: coverage recomputed from the PRD, with ellipsis expansion.
    #
    # Anchored on the acceptance-criteria section rather than a line slice.
    # `S4-C-02` of PRD-023 records a fixed lines[1100:1130] that missed the
    # Coverage paragraph and reported 23 undisclosed obligations against a
    # document that disclosed all 37 -- a false FAIL from a slice, not from the
    # document.  Sections move; anchors survive edits.
    ac_block = ''
    match = re.search(r'^## 14\.[^\n]*\n(.*?)(?=^## 15)', doc, re.M | re.S)
    if match:
        ac_block = match.group(1)
    else:
        fail('check 8 cannot find section 14 (acceptance criteria) in the PRD, '
             'so coverage cannot be recomputed')
    covered = set()
    for line in ac_block.split('\n'):
        if not re.match(r'^`FIL-AC-\d+`\s*(?:\u2014|--)', line.strip()):
            continue
        for ident in expand_ids(line):
            if not ident.startswith('FIL-AC-'):
                covered.add(ident)
    class_a_ids = set()
    for register in CLASS_A:
        for number in computed.get(register, []):
            class_a_ids.add('FIL-%s-%03d' % (register, number))
    covered &= class_a_ids
    if not class_a_ids:
        fail('check 8 is vacuous: no Class A identifier was recomputed')
    pct = (100.0 * len(covered) / len(class_a_ids)) if class_a_ids else 0.0
    for match in re.finditer(r'\*{0,2}(\d+)\s*/\s*(\d+)\s*=\s*(\d+\.\d)%',
                             block):
        num, den, published_pct = (int(match.group(1)), int(match.group(2)),
                                   float(match.group(3)))
        if (num, den) != (len(covered), len(class_a_ids)):
            fail('section 2M publishes coverage %d / %d; recomputed from the '
                 'PRD it is %d / %d'
                 % (num, den, len(covered), len(class_a_ids)))
        elif abs(published_pct - pct) > 0.05:
            fail('section 2M publishes %.1f%%; recomputed it is %.1f%%'
                 % (published_pct, pct))

    # ---- check 9: the four traceability directions Stage 5 requires
    directions = {
        'to authoritative source': r'^### 18\.1',
        'to architecture decision': r'ADR-0013',
        'to acceptance criterion': r'^## 14\.',
        'to implementation task': r'IMPL-1200',
    }
    present = {}
    for label, pattern in directions.items():
        present[label] = bool(re.search(pattern, doc, re.M))
        if not present[label]:
            fail('traceability direction "%s" is absent from the PRD -- Stage 5 '
                 'requires all four' % label)

    # ---- check 10: section 2M must NOT over-claim while FIL-GAP-012 is open.
    #
    # The single most important check in this file, and the only one of its kind
    # in the repository.  The Stage 5 instruction for this module said, in
    # terms: "do not falsely mark alignment if a governance/architecture
    # dependency remains unresolved."  `FIL-GAP-012` -- E-22 does not list
    # BC-12 as a consumer -- is OPEN, and its openness is read FROM THE PRD, so
    # section 2M cannot exempt itself by simply not mentioning it.
    gap_open = bool(re.search(
        r'`FIL-GAP-012`[^\n]*\bOPEN\b', doc, re.I))
    if not gap_open:
        fail('check 10 is vacuous or the situation changed: FIL-GAP-012 is no '
             'longer recorded as OPEN in the PRD. If the E-22 consumer '
             'question has genuinely been resolved by an ADR, this check must '
             'be revisited deliberately rather than allowed to lapse silently')
    else:
        overclaims = [
            (r'architecture alignment[^\n]{0,60}\b(clean|clear|complete|resolved)\b',
             'architecture alignment as clean/complete'),
            (r'\bStage 6\b[^\n]{0,40}\b(conferred|satisfied|complete)\b',
             'Stage 6'),
            (r'\bFROZEN\b(?![^\n]{0,80}(not|never|cannot|does not))',
             'FROZEN status'),
        ]
        for pattern, what in overclaims:
            hit = re.search(pattern, block, re.I)
            if hit:
                fail('section 2M appears to claim %s while FIL-GAP-012 is OPEN '
                     '-- found %r. Stage 5 confers registration only; the E-22 '
                     'consumer question for BC-12 is unresolved and must be '
                     'carried forward, not papered over'
                     % (what, hit.group(0)[:70]))

    return report(computed, rows, class_a, covered, citations, outward,
                  present)


def report(computed, rows, class_a, covered, citations, outward, directions):
    line = '-' * 70
    print(line)
    print('PRD-017 Stage 5 gate -- TRACEABILITY_MATRIX.md section 2M')
    print('                        against PRD-017_FILE_AND_MEDIA.md')
    print(line)
    if computed:
        total = sum(len(v) for v in computed.values())
        for register in ORDER:
            numbers = computed.get(register, [])
            published = ''
            if rows and register in rows:
                published = '  2M says count %-3d max %03d' % rows[register]
            elif rows is not None:
                published = '  2M has NO ROW'
            if numbers:
                print('  FIL-%-4s recomputed count %-3d range %03d..%03d%s'
                      % (register + '-', len(numbers), min(numbers),
                         max(numbers), published))
            else:
                print('  FIL-%-4s recomputed EMPTY%s'
                      % (register + '-', published))
        print(line)
        print('recomputed by SCOPE POSITION, independently of')
        print('prd017_traceability.py which parses by LINE FORM')
        print(line)
        print('identifiers recomputed from the PRD body : %d' % total)
        if class_a is not None:
            print('obligation-bearing (Class A)             : %d' % class_a)
        if covered is not None and class_a:
            print('obligations carrying a criterion         : %d' % len(covered))
            print('coverage                                 : %d / %d = %.1f%%'
                  % (len(covered), class_a, 100.0 * len(covered) / class_a))
        if citations is not None:
            print('FIL-* citations resolved outside module  : %d' % citations)
        if outward is not None:
            print('outward DEFINITIONS outside the module   : %d'
                  % len([o for o in outward if 'defines' in o]))
        if directions:
            print('traceability directions present          : %d of 4'
                  % sum(1 for v in directions.values() if v))
        print(line)
    if PROBLEMS:
        print('FAIL - %d problem(s):' % len(PROBLEMS))
        for problem in PROBLEMS:
            print('  * %s' % problem)
        print(line)
        return 1
    print('PASS - section 2M registers every FIL-* prefix the PRD defines,')
    print('       counts and ranges agree with an independent recomputation,')
    print('       all ranges contiguous, zero collisions in all three')
    print('       directions, both substring hazards defeated in both')
    print('       directions, FIL-EVT-* registered as empty and empty in')
    print('       fact, totals and coverage recomputed rather than trusted,')
    print('       all four traceability directions present, and section 2M')
    print('       claims NO architecture alignment while FIL-GAP-012 is OPEN.')
    print(line)
    return 0


if __name__ == '__main__':
    os.chdir(ROOT)
    sys.exit(main())
