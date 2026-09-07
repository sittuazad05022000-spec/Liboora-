#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""PRD-013 Stage 6 gate -- task/requirement coverage, computed not asserted.

WHY THIS EXISTS
---------------
`PRD_LIFECYCLE.md` Stage 6's gate is *"an `IMPL-*` range allocated and a task
document in which **every task traces back to requirements**."*

That gate has been missed before.  `PRD-004_IMPLEMENTATION_TASKS.md` held 18
tasks while its PRD declared 24 -- six tasks added by a correction pass were
never propagated (second-review finding `SR-01`, HIGH).  Reading did not catch
it; a count did.  This script is the equivalent check for `PRD-013`, and it is
deliberately the same shape as `prd007_task_coverage.py` so that the backlogs
are held to one standard rather than several.

It verifies, mechanically:

 1. **Every task traces to requirements** -- the literal Stage 6 gate.  A task
    with an empty Requirements cell fails the run.
 2. **Every cited requirement exists AND IS IN FORCE** in `PRD-013`.  This is
    stricter than `PRD-007`'s equivalent for a reason: `PRD-013` retired 12
    identifiers, and `PRD_LIFECYCLE.md` Stage 6 rule 1 forbids reuse.  A task
    citing `TEN-FR-016` would be tracing to a withdrawn obligation while
    looking like coverage.
 3. **`IMPL-*` IDs are unique** and lie inside the allocated range.  Allocation
    rule 1: a number is never reused or reassigned.
 4. **No collision with an existing allocation.**  Every `IMPL-*` below 800 is
    owned elsewhere; the check is therefore "nothing below the range", which is
    stronger and cannot go stale as new backlogs are added.
 5. **Obligation coverage** -- which `TEN-*` obligations are claimed by at
    least one task.  `TEN-AC-*` are excluded: an acceptance criterion is
    *verified by* a task's test, not *implemented by* a task.  `TEN-GAP-*` are
    excluded: they are open questions, and citing one as verifiable would
    resolve it by implementation choice.  `TEN-CFG-*` is declared empty.
 6. **Dependencies resolve** -- every `Blocked by` names a task that exists.
 7. **`Blocks` is the exact inverse of `Blocked by`.**  Rule 3 requires all
    three of `Priority`, `Blocks`, `Blocked by`; recording two directions of one
    edge is only useful if they agree, and by hand they drift.
 8. **The graph is acyclic**, and the longest chain is computed rather than
    asserted -- the critical-path claim in the document must be reproducible.
 9. **The document's own published totals are recomputed**, not trusted.

WHY THE REQUIREMENTS CELL IS COLUMN 7
-------------------------------------
The task tables are `Task | Scope | Module | Priority | Blocked by | Blocks |
Requirements | Test requirement`.  Requirements is read positionally rather
than by scanning the whole row, because *Test requirement* cells legitimately
name `TEN-AC-*` and `TEN-GAP-*` -- recording which criterion observes the task,
or which gap it must leave untouched.  A row-wide scan would read those as
claimed obligations and report coverage that was never asserted, and would
simultaneously fire check 5's `TEN-GAP-*` prohibition on a document that
obeys it.  The same positional discipline is why `Blocks` and `Blocked by`
cannot be confused with each other.

RANGE EXPANSION
---------------
Both the fully-qualified range form (prefix repeated on each endpoint) and the
short form (bare three-digit upper endpoint) are expanded, and a cited range
containing an identifier `PRD-013` does not define is reported rather than
silently absorbed.

RE-RUN
------
    python3 tool/docs_check/prd013_task_coverage.py

Exit 0 = gate satisfied.  Exit 1 = at least one check failed.
"""

import io
import os
import re
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
PRD = os.path.join('docs', '30-product', 'tenancy', 'PRD-013_TENANCY.md')
TASKS = os.path.join('docs', '40-implementation', 'tenancy',
                     'PRD-013_IMPLEMENTATION_TASKS.md')

LOW = 800
HIGH = 829

OBLIGATION = ['FR', 'BR', 'INV', 'EVT', 'XC']
EXCLUDED = ['AC', 'GAP', 'CFG']

PROBLEMS = []


def fail(message):
    PROBLEMS.append(message)


def read(relative):
    path = os.path.join(ROOT, relative)
    if not os.path.exists(path):
        fail('MISSING FILE: %s' % relative)
        return ''
    return io.open(path, encoding='utf-8').read()


def section(text, heading):
    """The text of one heading's block, or None."""
    lines = text.split('\n')
    start = None
    for index, line in enumerate(lines):
        if line.startswith(heading):
            start = index
            break
    if start is None:
        return None
    level = len(lines[start]) - len(lines[start].lstrip('#'))
    for index in range(start + 1, len(lines)):
        stripped = lines[index]
        if stripped.startswith('#'):
            this = len(stripped) - len(stripped.lstrip('#'))
            if this <= level:
                return '\n'.join(lines[start:index])
    return '\n'.join(lines[start:])


# ---------------------------------------------------------------- PRD register

def definition_sites(text, exclude_retired_register=False):
    """prefix -> sorted ints defined in the PRD body.

    Identical rule to `prd013_traceability.py` and `prd008_traceability.py`:
    a line beginning with the backticked identifier, or a table row whose FIRST
    cell is the identifier.  Deliberately the same so that the Stage 5 and
    Stage 6 gates cannot disagree about what a definition is.

    `exclude_retired_register` drops section 9, whose rows are themselves
    definition sites by the rule above.
    """
    if exclude_retired_register:
        block = section(text, '## 9. Retired identifiers')
        if block is not None:
            text = text.replace(block, '')
    found = {}
    for line in text.split('\n'):
        # A retirement NOTE is not a definition.  The PRD writes
        # "`TEN-FR-012` is **retired** (§9): ..." in the body, which the coarse
        # rule would read as a live definition.
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
    return dict((key, sorted(value)) for key, value in found.items())


def retired_sites(text):
    """prefix -> sorted ints, from section 9's FIRST CELL only.

    The restriction matters: section 9's "Retired because" column cites
    SUCCESSOR identifiers, so a whole-row regex reports live requirements as
    retired.
    """
    block = section(text, '## 9. Retired identifiers')
    if block is None:
        fail('PRD-013 has no section 9 -- cannot establish the retired set')
        return {}
    found = {}
    for line in block.split('\n'):
        match = re.match(r'^\|\s*`TEN-([A-Z]+)-(\d+)`\s*\|', line)
        if match is None:
            continue
        found.setdefault(match.group(1), set()).add(int(match.group(2)))
    return dict((key, sorted(value)) for key, value in found.items())


# ------------------------------------------------------------------ task table

def expand(cell):
    """Identifiers cited in a cell, with ranges expanded.

    Reports a malformed range rather than absorbing it.
    """
    ids = set()
    pattern = (r'`(TEN-[A-Z]+)-(\d+)`\s*(?:\u2026|\.\.\.|\u2013|-)\s*'
               r'`(?:TEN-[A-Z]+-)?(\d+)`')
    for match in re.finditer(pattern, cell):
        low = int(match.group(2))
        high = int(match.group(3))
        if high < low:
            fail('malformed range in Requirements cell: %s' % match.group(0))
            continue
        for number in range(low, high + 1):
            ids.add('%s-%03d' % (match.group(1), number))
    for match in re.finditer(r'`(TEN-[A-Z]+-\d+)`', cell):
        ids.add(match.group(1))
    return ids


def parse_tasks(text):
    """number -> dict(prio, by, blocks, reqs), from SECTION 5 ONLY.

    The section restriction is load-bearing.  Section 3.2's allocation table
    also opens its rows with a backticked `IMPL-*` -- "| `IMPL-014` …
    `IMPL-073` | Authentication ... |" -- and a document-wide scan reads
    fourteen range rows as malformed tasks.  The allocation table is correct
    and a scanner that cannot tell a range row from a task row is the wrong
    instrument, the same correction `prd013_stage5.py` records for prose
    wildcards.  Section 5 is where the gate's "task document" lives.
    """
    block = section(text, '## 5. The 30 tasks')
    if block is None:
        fail('the task document has no section 5 -- the Stage 6 artefact has '
             'no task table, which IS the Stage 6 failure')
        return {}, []
    tasks = {}
    order = []
    for line in block.split('\n'):
        if not line.startswith('| `IMPL-'):
            continue
        cells = [c.strip() for c in line.strip().strip('|').split('|')]
        if len(cells) < 8:
            fail('task row has %d cells, expected 8: %s'
                 % (len(cells), cells[0]))
            continue
        match = re.match(r'^`IMPL-(\d+)`$', cells[0])
        if match is None:
            fail('unparseable task identifier: %s' % cells[0])
            continue
        number = int(match.group(1))
        if number in tasks:
            fail('IMPL-%d is DUPLICATED -- allocation rule 1 forbids reuse'
                 % number)
            continue
        by = set(int(m) for m in re.findall(r'`IMPL-(\d+)`', cells[4]))
        blocks = set(int(m) for m in re.findall(r'`IMPL-(\d+)`', cells[5]))
        tasks[number] = dict(prio=cells[3], by=by, blocks=blocks,
                             reqs=cells[6])
        order.append(number)
    return tasks, order


def main():
    prd = read(PRD)
    doc = read(TASKS)
    if not prd or not doc:
        return

    live = definition_sites(prd, exclude_retired_register=True)
    retired = retired_sites(prd)

    in_force = set()
    retired_ids = set()
    for prefix, numbers in live.items():
        dead = set(retired.get(prefix, []))
        for number in numbers:
            if number not in dead:
                in_force.add('TEN-%s-%03d' % (prefix, number))
    for prefix, numbers in retired.items():
        for number in numbers:
            retired_ids.add('TEN-%s-%03d' % (prefix, number))

    obligations = set(i for i in in_force
                      if i.split('-')[1] in OBLIGATION)

    tasks, order = parse_tasks(doc)
    if not tasks:
        fail('no task rows parsed from %s -- the Stage 6 artefact is EMPTY, '
             'which IS the Stage 6 failure' % TASKS)
        return report(0, 0, 0, 0)

    # ---- check 3 / 4: range, uniqueness, no collision below the range
    for number in sorted(tasks):
        if number < LOW:
            fail('IMPL-%d is BELOW the allocated range IMPL-%d..%d -- it '
                 'collides with an allocation owned elsewhere.  '
                 'PRD_LIFECYCLE.md Stage 6 rule 1: "Never reuse or reassign '
                 'a number"' % (number, LOW, HIGH))
        elif number > HIGH:
            fail('IMPL-%d is ABOVE the allocated range IMPL-%d..%d'
                 % (number, LOW, HIGH))

    span = sorted(n for n in tasks if LOW <= n <= HIGH)
    if span and span != list(range(span[0], span[-1] + 1)):
        missing = [n for n in range(span[0], span[-1] + 1) if n not in tasks]
        fail('allocated span has gaps: %s'
             % ', '.join('IMPL-%d' % n for n in missing))

    # ---- check 1 / 2 / 5: requirements
    claimed = set()
    for number in sorted(tasks):
        cell = tasks[number]['reqs']
        cited = expand(cell)
        if not cited:
            if cell in ('\u2014', '-', ''):
                # IMPL-829's Requirements cell is TEN-BR-004, not empty; a
                # genuinely empty cell fails the literal gate.
                fail('IMPL-%d has an EMPTY Requirements cell -- '
                     'PRD_LIFECYCLE.md Stage 6 requires that "every task '
                     'traces back to requirements"' % number)
            else:
                fail('IMPL-%d cites no TEN-* identifier in its Requirements '
                     'cell: %r' % (number, cell[:60]))
            continue
        for identifier in sorted(cited):
            prefix = identifier.split('-')[1]
            if prefix in EXCLUDED:
                fail('IMPL-%d cites %s as an OBLIGATION.  TEN-AC-* are '
                     'verified by a task, not implemented by one; TEN-GAP-* '
                     'are open questions and citing one as verifiable '
                     'resolves it by implementation choice; TEN-CFG-* is '
                     'declared empty' % (number, identifier))
                continue
            if identifier in retired_ids:
                fail('IMPL-%d cites %s, which PRD-013 section 9 RETIRED.  '
                     'Retired identifiers are retained, not reused, and a '
                     'task tracing to one traces to nothing'
                     % (number, identifier))
                continue
            if identifier not in in_force:
                fail('IMPL-%d cites %s, which PRD-013 does not define'
                     % (number, identifier))
                continue
            claimed.add(identifier)

    uncovered = sorted(obligations - claimed)
    for identifier in uncovered:
        fail('%s is claimed by NO task -- an obligation with no task is an '
             'obligation nothing will implement' % identifier)

    # ---- check 6 / 7: dependencies and their inverse
    for number in sorted(tasks):
        for other in sorted(tasks[number]['by']):
            if other not in tasks:
                fail('IMPL-%d is Blocked by IMPL-%d, which is not a task in '
                     'this document' % (number, other))
            elif number not in tasks[other]['blocks']:
                fail('IMPL-%d says it is Blocked by IMPL-%d, but IMPL-%d does '
                     'not list IMPL-%d in Blocks -- rule 3\'s two directions '
                     'disagree' % (number, other, other, number))
        for other in sorted(tasks[number]['blocks']):
            if other not in tasks:
                fail('IMPL-%d says it Blocks IMPL-%d, which is not a task in '
                     'this document' % (number, other))
            elif number not in tasks[other]['by']:
                fail('IMPL-%d says it Blocks IMPL-%d, but IMPL-%d does not '
                     'list IMPL-%d in Blocked by -- rule 3\'s two directions '
                     'disagree' % (number, other, other, number))
        if not re.match(r'^P[123]$', tasks[number]['prio']):
            fail('IMPL-%d has no valid Priority (found %r) -- allocation '
                 'rule 3 requires it'
                 % (number, tasks[number]['prio']))

    # ---- check 8: acyclic, longest chain computed
    colour = {}
    cycles = []

    def visit(node, trail):
        state = colour.get(node)
        if state == 2:
            return
        if state == 1:
            cycles.append(trail[trail.index(node):] + [node])
            return
        colour[node] = 1
        for parent in sorted(tasks[node]['by']):
            if parent in tasks:
                visit(parent, trail + [node])
        colour[node] = 2

    sys.setrecursionlimit(10000)
    for node in sorted(tasks):
        visit(node, [])
    for cycle in cycles:
        fail('dependency CYCLE: %s'
             % ' -> '.join('IMPL-%d' % n for n in cycle))

    depth = {}

    def chain(node):
        if node in depth:
            return depth[node]
        parents = [p for p in tasks[node]['by'] if p in tasks]
        depth[node] = 1 if not parents else 1 + max(chain(p) for p in parents)
        return depth[node]

    longest = 0
    if not cycles:
        longest = max(chain(n) for n in tasks)

    roots = [n for n in sorted(tasks) if not tasks[n]['by']]
    leaves = [n for n in sorted(tasks) if not tasks[n]['blocks']]

    # ---- check 9: the document's own published totals, recomputed
    published = re.search(
        r'\|\s*\*\*TOTAL obligations\*\*\s*\|\s*\*\*(\d+)\s*/\s*(\d+)'
        r'\s*=\s*([\d.]+)%\*\*', doc)
    if published is None:
        fail('the task document publishes no "TOTAL obligations" row -- '
             'allocation rule 4\'s traceability table is incomplete')
    else:
        if int(published.group(1)) != len(claimed & obligations):
            fail('published claimed total %s != computed %d'
                 % (published.group(1), len(claimed & obligations)))
        if int(published.group(2)) != len(obligations):
            fail('published obligation total %s != computed %d'
                 % (published.group(2), len(obligations)))

    published_chain = re.search(r'longest chain (\d+)', doc)
    if published_chain and not cycles:
        if int(published_chain.group(1)) != longest:
            fail('published longest chain %s != computed %d'
                 % (published_chain.group(1), longest))

    published_count = re.search(r'Tasks parsed (\d+)', doc)
    if published_count and int(published_count.group(1)) != len(tasks):
        fail('published task count %s != parsed %d'
             % (published_count.group(1), len(tasks)))

    report(len(tasks), len(claimed & obligations), len(obligations), longest,
           roots, leaves, uncovered)


def report(count, claimed, total, longest, roots=None, leaves=None,
           uncovered=None):
    print('PRD-013 Stage 6 gate -- task/requirement coverage')
    print('-' * 66)
    print('  tasks parsed        : %d  (IMPL-%d..%d)' % (count, LOW, HIGH))
    print('  obligations         : %d claimed / %d in force%s'
          % (claimed, total,
             '  = %.1f%%' % (100.0 * claimed / total) if total else ''))
    print('  longest chain       : %d' % longest)
    if roots is not None:
        print('  roots / leaves      : %s / %s'
              % (', '.join('IMPL-%d' % n for n in roots) or '-',
                 ', '.join('IMPL-%d' % n for n in leaves) or '-'))
    print('-' * 66)
    if PROBLEMS:
        print('FAIL - %d problem(s):' % len(PROBLEMS))
        for problem in PROBLEMS:
            print('  * %s' % problem)
        sys.exit(1)
    print('PASS - every task traces to an in-force requirement; every')
    print('       obligation is claimed; IMPL identifiers are unique, in')
    print('       range and collide with nothing; Blocks and Blocked by')
    print('       agree; the graph is acyclic.')
    print('       PRD_LIFECYCLE.md Stage 6 gate SATISFIED.')
    print()
    print('       NOT claimed: 0 of 13 TEN-AC-* are proven by a passing test.')
    print('       A pre-existing scaffold (lib/platform/tenancy/tenancy.dart,')
    print('       commit a44ebb0) satisfies 9 obligations UNTESTED and')
    print('       CONTRADICTS 2 (D-013-01 Branch ownership, D-013-02 context')
    print('       not async-scoped).  See the task document section 4.1.')
    print('       Stage 6 closes the PLAN, not the work.')
    sys.exit(0)


if __name__ == '__main__':
    main()
