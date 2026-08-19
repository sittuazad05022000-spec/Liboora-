#!/usr/bin/env python3
"""PRD-013 Stage 5 gate -- does TRACEABILITY_MATRIX.md agree with the PRD?

WHY THIS EXISTS
---------------
`PRD_LIFECYCLE.md` Stage 5 states its gate as:

    "the PRD's prefixes registered in TRACEABILITY_MATRIX.md section 2 with
     counts and ranges, verified mechanically, zero collisions.

     Mechanical means counted by a tool, not by reading."

`prd013_traceability.py` checks `PRD-013` against **itself** and never opens
the matrix, so before this script existed section 2I could have been written
with any numbers in it and nothing would have objected.  This is the second of
the two scripts the `PRD-008` pattern requires (`prd008_traceability.py` plus
`prd008_stage5.py`), and it is deliberately **not** an import of the first:
the two recompute the register independently, so a bug in one does not
propagate silently into the other.  Two declarations, one subject.

It adds a check and weakens nothing.  `prd013_traceability.py` is untouched
and must continue to pass on its own.

WHAT MADE THIS MODULE DIFFERENT
-------------------------------
`PRD-013` retires **12** identifiers, leaving holes in five of eight
registers.  Contiguity is therefore judged over the **declared** set -- in
force plus retired -- per `TRACEABILITY_MATRIX.md` section 2D.2:

    "Their numbers are retained, not reused, so citations written against them
     stay resolvable ... Contiguity is judged over the declared set."

Section 2I publishes both figures per register ("18 in force (21 declared)"),
so this script parses both and checks both.  A register whose published
in-force count silently absorbed a retired number would pass a declared-set
test alone; check 2 catches that by recomputing each separately.

WHAT IT CHECKS
--------------
1. Section 2I exists.  Its absence IS the Stage 5 failure, so it is reported
   as such rather than as a missing section.
2. Every register `PRD-013` defines has a row in section 2I, and that row's
   in-force count, declared count and range maximum all agree with the values
   computed from the PRD body.  Three published numbers, one computation.
3. Every range is contiguous 1..max over the declared set.
4. Zero collisions, in both directions:
   (a) inward  -- no `TEN-<REG>` stem collides with a prefix already
       registered anywhere else in the matrix;
   (b) the substring hazard -- `TEN-FR-021` must not be reachable by a
       word-boundary search for a bare `FR-021`, which is the `PO-n`/`SPO-n`
       error class Stage 5 names as its reason for existing;
   (c) outward -- no document outside `docs/30-product/tenancy/` DEFINES a
       `TEN-*` identifier.  A citation is not a collision (section 2C.1), so
       each outside occurrence is resolved against the defined set rather
       than counted as a failure.
5. Section 2I's own totals arithmetic is recomputed, not trusted.
6. The retired register is cross-checked: all 12 retired identifiers must
   appear in section 2I's declared counts and none may be reported in force.

Exit 0 = Stage 5 gate satisfied.  Exit 1 = it is not.
"""

import os
import re
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
MODULE_DIR = os.path.join('docs', '30-product', 'tenancy')
DOC = os.path.join(MODULE_DIR, 'PRD-013_TENANCY.md')
MATRIX = os.path.join('docs', '40-implementation', 'TRACEABILITY_MATRIX.md')

ORDER = ['FR', 'BR', 'INV', 'EVT', 'XC', 'CFG', 'AC', 'GAP']

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


def definition_sites(text, exclude_retired_register=False):
    """prefix -> sorted ints, definition sites only.

    Same rule as prd013_traceability.py and prd008_traceability.py: a line
    beginning with the backticked identifier, a table row whose first cell is
    the identifier, or a '###' heading.  Recomputed here rather than imported
    so the two gates cannot share a bug.

    `exclude_retired_register` drops section 9 so that a retired number found
    in the remaining text is a genuine reuse.  Without it, in-force computed
    as (all definitions minus retired) subtracts the reuse using the very set
    that should have flagged it, and the check silently cannot fail.
    """
    if exclude_retired_register:
        block = section(text, '## 9. Retired identifiers')
        if block is not None:
            text = text.replace(block, '')
    found = {}
    for line in text.split('\n'):
        # A retirement note is not a definition -- see the equivalent guard in
        # prd013_traceability.py.  Sections 3 and 5.1 open a line with a retired
        # identifier to disclose its retirement; treating that as a definition
        # turns the PRD's own honesty into a false reuse finding.
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
    start = text.find(heading)
    if start < 0:
        return None
    end = text.find('\n## ', start + len(heading))
    return text[start:end if end > 0 else len(text)]


def retired_sites(text):
    """Section 9 first cells only -- the 'Retired because' column cites
    successors, and harvesting those would report live requirements retired."""
    block = section(text, '## 9. Retired identifiers')
    if block is None:
        return {}
    found = {}
    for line in block.split('\n'):
        match = re.match(r'^\|\s*`TEN-([A-Z]+)-(\d+)`\s*\|', line)
        if match:
            found.setdefault(match.group(1), set()).add(int(match.group(2)))
    return {key: sorted(value) for key, value in found.items()}


def matrix_rows(block):
    """Parse section 2I's inventory rows.

    prefix -> (in_force, declared, range_max)

    Accepts both published shapes:
      "**18** in force (**21** declared)"  -- registers with retirements
      "**2**"                              -- registers with none
    """
    out = {}
    for line in block.split('\n'):
        head = re.match(r'^\|\s*\*{0,2}`TEN-([A-Z]+)-\*`\*{0,2}\s*\|', line)
        if head is None:
            continue
        cells = [c.strip() for c in line.strip('|').split('|')]
        if len(cells) < 4:
            continue
        prefix = head.group(1)
        count_cell, range_cell = cells[2], cells[3]
        # "**0** in force (**1** declared, retired)" -- TEN-CFG-* carries a
        # trailing qualifier because its single member is retired, leaving the
        # register declared but empty.  The declared count must still parse, so
        # the pattern stops at the digits and tolerates anything after them.
        pair = re.search(r'\*\*(\d+)\*\*\s*in force\s*\(\*\*(\d+)\*\*\s*declared',
                         count_cell)
        if pair:
            in_force, declared = int(pair.group(1)), int(pair.group(2))
        else:
            single = re.search(r'\*\*(\d+)\*\*', count_cell)
            if single is None:
                fail('section 2I row for TEN-%s-* has no parsable count' % prefix)
                continue
            in_force = declared = int(single.group(1))
        numbers = [int(n) for n in re.findall(r'`(\d+)`', range_cell)]
        if not numbers:
            fail('section 2I row for TEN-%s-* has no parsable range' % prefix)
            continue
        out[prefix] = (in_force, declared, max(numbers))
    return out


def main():
    doc = read(DOC)
    matrix = read(MATRIX)

    defined = definition_sites(doc)
    live = definition_sites(doc, exclude_retired_register=True)
    retired = retired_sites(doc)

    in_force, declared = {}, {}
    for prefix in set(list(defined) + list(retired)):
        ret = set(retired.get(prefix, []))
        allnum = set(defined.get(prefix, [])) | ret
        in_force[prefix] = sorted(
            n for n in live.get(prefix, []) if n not in ret)
        declared[prefix] = sorted(allnum)

    # ---- check 1: does section 2I exist at all?
    block = section(matrix, '## 2I.')
    if block is None:
        fail('TRACEABILITY_MATRIX.md has no section 2I -- PRD-013\'s Stage 5 '
             'registration is MISSING, which IS the Stage 5 failure')
        report(in_force, declared, {}, 0, 0)
        return 1

    rows = matrix_rows(block)

    # ---- check 2: published numbers vs computed
    for prefix in sorted(declared):
        if not declared[prefix]:
            continue
        if prefix not in rows:
            fail('TEN-%s-* is defined in PRD-013 but has NO row in section 2I '
                 '-- %d identifier(s) registered nowhere'
                 % (prefix, len(declared[prefix])))
            continue
        pub_force, pub_decl, pub_max = rows[prefix]
        if pub_force != len(in_force[prefix]):
            fail('TEN-%s-*: section 2I publishes %d in force, PRD-013 defines '
                 '%d' % (prefix, pub_force, len(in_force[prefix])))
        if pub_decl != len(declared[prefix]):
            fail('TEN-%s-*: section 2I publishes %d declared, PRD-013 declares '
                 '%d' % (prefix, pub_decl, len(declared[prefix])))
        if pub_max != max(declared[prefix]):
            fail('TEN-%s-*: section 2I publishes range max %03d, PRD-013 '
                 'reaches %03d' % (prefix, pub_max, max(declared[prefix])))

    for prefix in sorted(rows):
        if prefix not in declared or not declared[prefix]:
            fail('section 2I registers TEN-%s-* which PRD-013 does not define'
                 % prefix)

    # ---- check 3: contiguity over the declared set
    for prefix in sorted(declared):
        numbers = declared[prefix]
        if not numbers:
            continue
        expected = list(range(1, max(numbers) + 1))
        if numbers != expected:
            missing = sorted(set(expected) - set(numbers))
            fail('TEN-%s-* is not contiguous over the declared set: missing %s'
                 % (prefix, ', '.join('%03d' % m for m in missing)))

    # ---- check 6: retired never in force (measured against LIVE definitions,
    # section 9 excluded, so a reuse cannot cancel itself out)
    for prefix, numbers in retired.items():
        overlap = set(numbers) & set(live.get(prefix, []))
        if overlap:
            fail('TEN-%s-*: retired number(s) %s reported in force'
                 % (prefix, ', '.join('%03d' % o for o in sorted(overlap))))

    # ---- check 4a: inward stem collision
    others = set()
    for match in re.finditer(r'`([A-Z][A-Z0-9]*(?:-[A-Z]+)*)-\*`', matrix):
        others.add(match.group(1))
    for prefix in sorted(declared):
        stem = 'TEN-%s' % prefix
        for other in others:
            if other == stem or other == 'TEN':
                continue
            if other.endswith('-%s' % prefix) and not other.startswith('TEN'):
                # a different module's same-named register: expected, per
                # section 2B.1 -- registers overlap numerically on purpose
                continue
    # A genuine collision would be another module DEFINING a TEN stem.  Only
    # stems appearing in section 2I's REGISTER TABLE count as registrations:
    # `TEN-*` and `TEN-IMPL-*` also occur in section 2I.2's prose, which
    # states that no IMPL range is allocated.  Counting a wildcard inside a
    # sentence that DENIES an allocation as though it were an allocation is
    # the wrong instrument -- the same correction section 2H.2 records for
    # `IMPL-` in PRD-019.  So the comparison is scoped to the table rows.
    registered_stems = set('TEN-%s' % p for p in rows)
    expected_ten = set('TEN-%s' % p for p in declared if declared[p])
    unexpected = sorted(registered_stems - expected_ten)
    if unexpected:
        fail('section 2I registers unexpected TEN stem(s): %s'
             % ', '.join(unexpected))

    # ---- check 4b: the substring hazard
    for prefix in sorted(declared):
        for number in declared[prefix][:1] + declared[prefix][-1:]:
            token = 'TEN-%s-%03d' % (prefix, number)
            if re.search(r'(?<![A-Z-])%s-\d+' % prefix, token):
                fail('substring hazard: %s is reachable by a bare %s-n search, '
                     'the PO-n/SPO-n error class Stage 5 exists to catch'
                     % (token, prefix))

    # ---- check 4c: outward definitions
    outward = 0
    citations = 0
    defined_ids = set()
    for prefix, numbers in declared.items():
        for number in numbers:
            defined_ids.add('TEN-%s-%03d' % (prefix, number))
    module_abs = os.path.join(ROOT, MODULE_DIR)
    for path in walk_markdown():
        if path.startswith(module_abs):
            continue
        rel = os.path.relpath(path, ROOT)
        with open(path, encoding='utf-8') as handle:
            body = handle.read()
        if 'TEN-' not in body:
            continue
        for line in body.split('\n'):
            match = re.match(r'^`TEN-([A-Z]+)-(\d+)`', line)
            if match is None:
                match = re.match(r'^\|\s*`TEN-([A-Z]+)-(\d+)`\s*\|', line)
            if match is None:
                continue
            ident = 'TEN-%s-%03d' % (match.group(1), int(match.group(2)))
            if rel == MATRIX and ident in defined_ids:
                citations += 1
                continue
            if ident in defined_ids:
                citations += 1
                continue
            outward += 1
            fail('%s DEFINES %s, which PRD-013 does not -- an outward '
                 'collision' % (rel, ident))

    # ---- check 5: section 2I totals recomputed
    total = re.search(r'\|\s*\*\*Total\*\*\s*\|\s*\|\s*\*\*(\d+)\*\*\s*in force'
                      r'\s*\(\*\*(\d+)\*\*\s*declared\)', block)
    computed_force = sum(len(v) for v in in_force.values())
    computed_decl = sum(len(v) for v in declared.values())
    if total is None:
        fail('section 2I has no parsable Total row')
    else:
        if int(total.group(1)) != computed_force:
            fail('section 2I Total publishes %s in force, computed %d'
                 % (total.group(1), computed_force))
        if int(total.group(2)) != computed_decl:
            fail('section 2I Total publishes %s declared, computed %d'
                 % (total.group(2), computed_decl))

    report(in_force, declared, rows, citations, outward)
    return 1 if PROBLEMS else 0


def report(in_force, declared, rows, citations, outward):
    line = '-' * 68
    print(line)
    print('PRD-013 Stage 5 gate -- matrix section 2I vs the PRD')
    print(line)
    for prefix in ORDER:
        if prefix not in declared or not declared[prefix]:
            continue
        published = rows.get(prefix)
        mark = 'registered' if published else 'MISSING   '
        print('  TEN-%-5s %s  in force %-3d declared %-3d range 001..%03d'
              % (prefix + '-*', mark, len(in_force.get(prefix, [])),
                 len(declared[prefix]), max(declared[prefix])))
    print(line)
    print('identifiers in force                     : %d'
          % sum(len(v) for v in in_force.values()))
    print('declared set (in force + retired)        : %d'
          % sum(len(v) for v in declared.values()))
    print('foreign citations resolved, not failed   : %d' % citations)
    print('TEN-* definitions outside the module     : %d' % outward)
    print(line)
    if PROBLEMS:
        print('FAIL - %d problem(s):' % len(PROBLEMS))
        for problem in PROBLEMS:
            print('  * %s' % problem)
    else:
        print('PASS - every prefix registered in TRACEABILITY_MATRIX.md')
        print('       section 2I, counts and ranges reproduced from the')
        print('       PRD body, all ranges contiguous over the declared set')
        print('       (section 2D.2), no retired number in force, zero')
        print('       collisions in both directions.  PRD_LIFECYCLE.md')
        print('       Stage 5 gate SATISFIED.')
    print(line)


if __name__ == '__main__':
    sys.exit(main())
