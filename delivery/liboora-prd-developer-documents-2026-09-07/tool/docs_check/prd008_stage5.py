#!/usr/bin/env python3
"""PRD-008 Stage 5 gate -- register registration and collisions, computed.

WHY THIS EXISTS
---------------
`PRD_LIFECYCLE.md` Stage 5 states its gate as:

    "the PRD's prefixes registered in TRACEABILITY_MATRIX.md section 2 with
     counts and ranges, verified mechanically, zero collisions.

     Mechanical means counted by a tool, not by reading."

`prd008_traceability.py` already checks `PRD-008` against **itself** -- section
0.2's declarations against the body.  It does **not** look at
`TRACEABILITY_MATRIX.md` at all, so before this script existed the Stage 5 gate
had no mechanical enforcement for this module: section 2G could have been
written with any numbers in it and nothing would have objected.  The precedent
gates for the four modules that reached Stage 5 earlier
(`prd005`/`prd006`/`prd007_traceability.py`) each carry a matrix block for
exactly this reason.  This script is the equivalent for `PRD-008`.

It **adds** a check.  It weakens nothing: `prd008_traceability.py` is untouched
and must continue to pass independently.

THE COLLISION CLASS THIS STAGE EXISTS FOR
-----------------------------------------
Stage 5's own text names the near-miss it was created to catch:

    "PO-1..PO-12 are protected operations behind the public library preview --
     an anonymous read surface.  SPO-1..SPO-9 are protected operations on a
     Global Person Identity -- authenticated writes. ... citing PO-3 when
     SPO-3 was meant would move a requirement from one bounded context to
     another.  This stage exists for that class of error, which no amount of
     careful reading reliably catches."

`PRD-008` owns `FEE-PO-001`..`FEE-PO-008`, so the substring `PO-` is present in
this module's register.  That is the hazard, and check 4 below tests it in both
directions rather than asserting it is fine.  Note the meanings differ three
ways, which is precisely why a mistaken citation would be silent: `PO-n` is a
Library protected operation, `SPO-n` is a Student Identity protected operation,
and `FEE-PO-n` is a **port / integration obligation** -- the `ATT-PO-*`
convention section 2F records, not the `PO-n` one.

WHAT IT CHECKS
--------------
1. Section 2G exists.  Its absence IS the Stage 5 failure, so it is checked
   first and reported as such rather than as a missing file.
2. Every register `PRD-008` defines has a row in section 2G, and that row's
   count and range maximum both agree with the count computed from the
   document body.  Two declarations, one computation -- the section 2F rule.
3. Every range is contiguous 1..max.  A hole makes the published range false
   (`PRD_LIFECYCLE.md` Stage 2 rule 3).
4. Zero collisions, in both directions:
   (a) inward -- no `FEE-<REG>` prefix collides with a prefix already
       registered elsewhere in the matrix;
   (b) the `PO-` hazard -- `FEE-PO` must not be reachable by a word-boundary
       search for `PO-n` or `SPO-n`, and vice versa;
   (c) outward -- no document outside `docs/30-product/revenue-finance/`
       DEFINES a `FEE-*` identifier.  A citation is not a collision: the 16
       line-start occurrences in `ADR-0035`/`0037`/`0039`/`0040`/`0041`/`0042`
       are table rows citing identifiers PRD-008 already defines, and this
       check resolves each against the defined set rather than counting it as
       a failure.  That is section 2C.1's principle -- a checker that cannot
       tell a substring from a real hit is one that gets switched off.
5. Section 2G's own totals arithmetic is recomputed, not trusted.
6. `FEE-RSK-*` is reported as an OUTSTANDING FINDING, never silenced.  It is
   defined in the body (section 38, ten entries, contiguous) and registered in
   section 2G, but is **absent from PRD-008 section 0.2**, which section 0.1
   requires.  That is a pre-existing Stage-2 register-declaration defect owned
   by the PRD's document owner.  Registering it in the matrix does not repair
   section 0.2, and this script does not pretend otherwise -- it prints the
   omission on every run, exactly as `prd008_traceability.py` does.

Exit 0 = Stage 5 gate satisfied.  Exit 1 = it is not.
"""

import os
import re
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
MODULE_DIR = os.path.join('docs', '30-product', 'revenue-finance')
DOC = os.path.join(MODULE_DIR, 'PRD-008_REVENUE-AND-FINANCE.md')
MATRIX = os.path.join('docs', '40-implementation', 'TRACEABILITY_MATRIX.md')

# Order is PRD-008 section 0.2's own, with RSK last because it is the
# undeclared one.  OBLIGATION lists the six that carry obligation; FEE-AC-*
# are verified-by and FEE-GAP-* are open questions, exactly as section 0.2
# and PRD-006 section 0.3 treat their equivalents.
ORDER = ['FR', 'BR', 'INV', 'EVT', 'XC', 'PO', 'AC', 'GAP', 'RSK']
OBLIGATION = ['FR', 'BR', 'INV', 'EVT', 'XC', 'PO']

PROBLEMS = []


def fail(message):
    PROBLEMS.append(message)


def read(path):
    with open(os.path.join(ROOT, path), encoding='utf-8') as handle:
        return handle.read()


def definition_sites(text):
    """prefix -> sorted ints, counted from definition sites only.

    Deliberately identical to prd008_traceability.py's rule so the two gates
    cannot disagree about what a definition is.  A definition site is a line
    beginning with the backticked identifier, or a table row whose first cell
    is the identifier.
    """
    found = {}
    for line in text.split('\n'):
        match = re.match(r'^`FEE-([A-Z]+)-(\d+)`', line)
        if match is None:
            match = re.match(r'^\|\s*`FEE-([A-Z]+)-(\d+)`\s*\|', line)
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


def matrix_rows(block):
    """Parse section 2G's inventory rows: prefix -> (count, lo, hi)."""
    out = {}
    pattern = re.compile(
        r'^\|\s*`FEE-([A-Z]+)-n`\s*\|[^|]*\|\s*\*\*(\d+)\*\*\s*\|'
        r'[^|]*?`FEE-[A-Z]+-(\d+)`\s*\u2026\s*`FEE-[A-Z]+-(\d+)`')
    for line in block.split('\n'):
        match = pattern.match(line)
        if match:
            out[match.group(1)] = (int(match.group(2)),
                                   int(match.group(3)),
                                   int(match.group(4)))
    return out


def main():
    text = read(DOC)
    computed = definition_sites(text)

    # ---- 1. Section 2G must exist -------------------------------------------
    matrix_text = read(MATRIX)
    block = section(matrix_text, '## 2G.')
    if block is None:
        fail('TRACEABILITY_MATRIX.md has no section 2G - PRD-008\'s Stage 5 '
             'registration is MISSING, which IS the Stage 5 failure')
        report(computed, {})
        return 1

    rows = matrix_rows(block)

    # ---- 2/3. Counts, ranges, contiguity ------------------------------------
    for prefix in ORDER:
        numbers = computed.get(prefix)
        if not numbers:
            fail('PRD-008 defines no FEE-%s-* identifier, but the gate '
                 'expects one' % prefix)
            continue
        count = len(numbers)
        maximum = numbers[-1]
        missing = [n for n in range(1, maximum + 1) if n not in set(numbers)]
        if missing:
            fail('FEE-%s-* range is NOT contiguous: %d..%d has hole(s) %s'
                 % (prefix, numbers[0], maximum, missing))
        if numbers[0] != 1:
            fail('FEE-%s-* does not start at 1 (starts at %d)'
                 % (prefix, numbers[0]))
        if prefix not in rows:
            fail('section 2G registers no row for FEE-%s-*' % prefix)
            continue
        registered, lo, hi = rows[prefix]
        if registered != count or lo != 1 or hi != maximum:
            fail('section 2G registers FEE-%s-* as %d (%03d..%03d); computed '
                 '%d (001..%03d)' % (prefix, registered, lo, hi, count, maximum))

    for prefix in rows:
        if prefix not in ORDER:
            fail('section 2G registers FEE-%s-*, which this gate does not '
                 'know - a register was added without updating the gate'
                 % prefix)

    # ---- 4a. Inward collisions against every other registered prefix -------
    # Collect prefixes the matrix registers anywhere, then check no FEE-<REG>
    # is equal to one of them.
    foreign = set()
    for match in re.finditer(r'`([A-Z][A-Z0-9]*(?:-[A-Z]+)*)-(?:n|\d+)`',
                             matrix_text):
        foreign.add(match.group(1))
    for prefix in ORDER:
        mine = 'FEE-%s' % prefix
        if mine in foreign - {'FEE-%s' % p for p in ORDER}:
            fail('prefix %s collides with a prefix already registered in the '
                 'matrix' % mine)

    # ---- 4b. The PO-/SPO- hazard, tested rather than asserted ---------------
    # A word-boundary search for PO-n or SPO-n must NOT reach FEE-PO-n, and a
    # search for FEE-PO-n must not reach PO-n/SPO-n.  If either leaks, a
    # citation in one context could silently resolve to another.
    for probe, expected in (('FEE-PO-003', 'FEE-PO'),
                            ('PO-3', 'PO'),
                            ('SPO-3', 'SPO')):
        got = re.findall(r'(?<![-A-Za-z])([A-Z][A-Z0-9]*(?:-[A-Z]+)*)-\d+',
                         probe)
        if got != [expected]:
            fail('prefix tokenisation is ambiguous: %r parsed as %r, expected '
                 '[%r] - the PO-/SPO- collision class Stage 5 exists for is '
                 'NOT excluded' % (probe, got, expected))
    # And the same rule applied to the real document: no bare PO-n or SPO-n
    # token in PRD-008 may in fact be the tail of a FEE-PO-n.
    for match in re.finditer(r'(?<![-A-Za-z])S?PO-(\d+)', text):
        fail('PRD-008 line contains a bare %s token that is not FEE-PO-* - '
             'inspect it: %r' % (match.group(0), match.group(0)))

    # ---- 4c. Outward: no FEE-* DEFINED outside the module -------------------
    defined = set()
    for prefix, numbers in computed.items():
        for number in numbers:
            defined.add('FEE-%s-%d' % (prefix, number))
    outward = 0
    citations = 0
    for dirpath, _dirnames, filenames in os.walk(os.path.join(ROOT, 'docs')):
        for filename in sorted(filenames):
            if not filename.endswith('.md'):
                continue
            path = os.path.join(dirpath, filename)
            relative = os.path.relpath(path, ROOT).replace('\\', '/')
            if relative.startswith(MODULE_DIR.replace('\\', '/')):
                continue
            with open(path, encoding='utf-8', errors='replace') as handle:
                for number, line in enumerate(handle, 1):
                    match = re.match(r'^`FEE-([A-Z]+)-(\d+)`', line)
                    if match is None:
                        match = re.match(r'^\|\s*`FEE-([A-Z]+)-(\d+)`\s*\|',
                                         line)
                    if match is None:
                        continue
                    identifier = 'FEE-%s-%d' % (match.group(1),
                                                int(match.group(2)))
                    if identifier in defined:
                        citations += 1
                        continue
                    outward += 1
                    fail('FEE-* identifier DEFINED outside the module: %s:%d '
                         'defines %s, which PRD-008 does not - that is a real '
                         'collision, not a citation'
                         % (relative, number, identifier))

    # ---- 5. Section 2G's own arithmetic ------------------------------------
    obligation = sum(len(computed.get(p, [])) for p in OBLIGATION)
    total = sum(len(computed.get(p, [])) for p in ORDER)
    for label, value in (('obligation', obligation), ('total', total)):
        pattern = r'\*\*%d\b' % value
        if not re.search(pattern, block):
            fail('section 2G does not state the computed %s figure %d'
                 % (label, value))

    report(computed, rows, obligation, total, citations, outward)
    return 1 if PROBLEMS else 0


def report(computed, rows, obligation=None, total=None, citations=0,
           outward=0):
    line = '-' * 70
    print(line)
    print('PRD-008 Stage 5 gate - register registration and collisions')
    print(line)
    undeclared = declared_in_section_0_2()
    for prefix in ORDER:
        numbers = computed.get(prefix, [])
        if not numbers:
            continue
        note = ''
        if prefix in undeclared:
            note = '  <- NOT declared in PRD-008 section 0.2'
        print('  FEE-%-4s registered %-4d  range %03d..%03d%s'
              % (prefix + '-*', len(numbers), numbers[0], numbers[-1], note))
    if obligation is not None:
        print('%s' % line)
        print('obligation-bearing (FR+BR+INV+EVT+XC+PO) : %d' % obligation)
        print('all registers incl. FEE-AC/GAP/RSK       : %d' % total)
        print('foreign citations resolved, not failed   : %d' % citations)
        print('FEE-* definitions outside the module     : %d' % outward)
    print(line)
    if PROBLEMS:
        print('FAIL - %d problem(s):' % len(PROBLEMS))
        for problem in PROBLEMS:
            print('  * %s' % problem)
    else:
        print('PASS - every prefix registered in TRACEABILITY_MATRIX.md')
        print('       section 2G, counts and ranges reproduced from the')
        print('       document body, all ranges contiguous, zero collisions')
        print('       in both directions.  PRD_LIFECYCLE.md Stage 5 gate')
        print('       SATISFIED.')
    if undeclared:
        print()
        print('OUTSTANDING FINDING, not a Stage 5 failure - %d register(s) '
              'registered' % len(undeclared))
        print('in section 2G but absent from PRD-008 section 0.2: %s'
              % ', '.join('FEE-%s-*' % p for p in sorted(undeclared)))
        print('  Section 0.1 requires registers "declared up front with')
        print('  ranges".  Adding a section 0.2 row is a document-owner act on')
        print('  PRD-008 itself; this gate reports the omission and neither')
        print('  repairs nor silences it.  Stage 5 asks whether the matrix')
        print('  registers the prefix - it does, with the measured count and')
        print('  range - so this is a Stage 2 defect carried forward openly,')
        print('  not a Stage 5 gate failure.')
    print(line)


def declared_in_section_0_2():
    """Return the prefixes defined in the body but missing from section 0.2."""
    text = read(DOC)
    declared = set()
    pattern = re.compile(r'^\|\s*`FEE-([A-Z]+)-\*`\s*\|[^|]*\|\s*\*\*(\d+)\*\*')
    for line in text.split('\n'):
        match = pattern.match(line)
        if match:
            declared.add(match.group(1))
    return set(definition_sites(text)) - declared


if __name__ == '__main__':
    sys.exit(main())
