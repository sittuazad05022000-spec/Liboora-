#!/usr/bin/env python3
"""PRD-023 Stage 6 gate -- every task traces back to requirements.

WHY THIS EXISTS
---------------
`PRD_LIFECYCLE.md` L137 states the Stage 6 gate:

    "an `IMPL-*` range allocated and a task document in which **every task
     traces back to requirements**."

Both halves are mechanical claims, so both are measured here rather than read.
This is the THIRD instrument for PRD-023 and it is deliberately narrow: it says
nothing about whether the PRD is correct (that is `prd023_traceability.py`) and
nothing about whether the identifiers are registered (`prd023_stage5.py`).  It
answers one question: does the backlog claim exactly the obligations that exist,
and does it claim all of them?

WHAT IT CHECKS
--------------
1.  The task document exists and declares the range in its header.
2.  Task identifiers are contiguous across the allocated span, with no gaps and
    no duplicates -- a renumber later would violate allocation rule 1.
3.  No task number falls outside the declared range.  In particular no task may
    reach back into `IMPL-1030`...`1099`, which is PRD-014's declared growth
    reserve (rule 2: "leave the previous group room to grow contiguously"), and
    none may claim `IMPL-015`/`IMPL-016`, which PRD-001 holds.
4.  Every obligation cited by a task EXISTS in the PRD.  A task citing
    `CNF-FR-099` would otherwise read as diligent while discharging nothing --
    the failure `prd016_*` mutation-tested with `AUD-FR-099`.
5.  Every Class A obligation in the PRD is claimed by at least one task, and the
    published coverage figure reproduces.
6.  No task claims zero obligations.
7.  Every task row carries Priority, Blocked by and Blocks cells (rule 3).
8.  The traceability table required by rule 4 exists and is non-vacuous.
9.  The two registers PRD-023 declares EMPTY are still empty -- a Stage 6
    document must not mint a configurable by naming one in a task.  This is the
    Stage 5 prohibition, re-checked one stage later, because a backlog is the
    likeliest place for a parameter to be invented.

WHAT IT DELIBERATELY DOES NOT CHECK
-----------------------------------
Whether the work is well decomposed, correctly prioritised, or achievable.
Those are review judgements and belong to a role holder, not a script.  It also
does not check that acceptance criteria PASS -- none can, because no
implementation exists.  Claimed is not proven, and conflating the two would be
the `PRD-006` v1.0 failure in a new column.

INDEPENDENCE
------------
This script does not import the other two, and it parses the TASK document,
which neither of them opens.  It re-derives the PRD's obligation set itself
rather than trusting a number either of them published.
"""

import os
import re
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(
    os.path.abspath(__file__))))
os.chdir(ROOT)

PRD = os.path.join('docs', '30-product', 'configuration',
                   'PRD-023_SETTINGS_AND_CONFIGURATION.md')
TASKS = os.path.join('docs', '40-implementation', 'configuration',
                     'PRD-023_IMPLEMENTATION_TASKS.md')

RANGE_START = 1100
RANGE_END = 1129
EXPECTED_TASKS = 30

# PRD-014's declared growth reserve, ratified at ADR-0052:279.  Allocation
# rule 2 requires it be left alone; a task reaching into it is a rule breach.
FOREIGN_RESERVE = (1030, 1099)
# Held by PRD-001 startup validation.  CNF-GAP-005 records the INV-10..16
# discrepancy; PRD-023 must state the equality obligation without duplicating
# the task.
FOREIGN_TASKS = {15, 16}

CLASS_A = ['FR', 'BR', 'INV', 'XC']
EMPTY_BY_DESIGN = ['EVT', 'CFG']

problems = []


def fail(message):
    problems.append(message)


def read(path):
    if not os.path.exists(path):
        fail('%s does not exist -- the Stage 6 gate is a document that must '
             'exist, not an intention to write one' % path)
        return ''
    with open(path, encoding='utf-8') as handle:
        return handle.read()


def expand_ids(text):
    """Every `CNF-*` token, with ellipsis ranges expanded.

    Ranges matter here: a task legitimately cites `CNF-AC-001`...`CNF-AC-059`
    rather than listing 59 identifiers, and a token-only scan would under-count
    the claim by 57 -- the `S4-D-01` class of error, in the opposite
    direction.
    """
    ids = set()
    span = (r'`CNF-([A-Z]+)-(\d+)`\s*(?:\u2026|\.\.\.|\.\.)\s*'
            r'`(?:CNF-[A-Z]+-)?(\d+)`')
    for match in re.finditer(span, text):
        register = match.group(1)
        low, high = int(match.group(2)), int(match.group(3))
        if high < low or high - low > 999:
            continue
        for number in range(low, high + 1):
            ids.add('CNF-%s-%03d' % (register, number))
    for match in re.finditer(r'`CNF-([A-Z]+)-(\d+)`', text):
        ids.add('CNF-%s-%03d' % (match.group(1), int(match.group(2))))
    return ids


def prd_obligations(prd):
    """Re-derive the PRD's identifier set, by definition form.

    PRD-023 defines an identifier either as a bold line-opening requirement
    (`**`CNF-FR-001`** -- text`) or as the leading cell of a table row.  Both
    forms are accepted; a citation mid-sentence is not a definition.
    """
    defined = {}
    for line in prd.split('\n'):
        stripped = line.strip()
        for pattern in [r'^\*\*`CNF-([A-Z]+)-(\d+)`\*\*\s*(?:\u2014|--)\s*\S',
                        r'^\|\s*\*{0,2}`CNF-([A-Z]+)-(\d+)`\*{0,2}\s*\|']:
            match = re.match(pattern, stripped)
            if match:
                register = match.group(1)
                number = int(match.group(2))
                defined.setdefault(register, set()).add(number)
                break
    if not defined:
        fail('the PRD parsed to ZERO definitions -- a parser that reads '
             'nothing must never report a clean run')
    return defined


def task_rows(tasks):
    """Parse the task tables.

    A task row opens with a `IMPL-nnnn` cell.  The allocation table in section
    3.2 opens with a RANGE cell (`IMPL-1100` ... `IMPL-1109`) and must not be
    read as a task -- so a row whose first cell contains an ellipsis or a `+`
    is skipped.  Splitting is on UNESCAPED pipes only, the `S5-C-03` lesson.
    """
    rows = []
    for lineno, line in enumerate(tasks.split('\n'), 1):
        stripped = line.strip()
        if not stripped.startswith('|'):
            continue
        cells = [cell.strip()
                 for cell in re.split(r'(?<!\\)\|', stripped)[1:-1]]
        if not cells:
            continue
        first = cells[0]
        if not re.match(r'^\*{0,2}`IMPL-\d+`\*{0,2}$', first):
            continue
        number = int(re.search(r'IMPL-(\d+)', first).group(1))
        rows.append((lineno, number, cells))
    return rows


def main():
    prd = read(PRD)
    tasks = read(TASKS)
    if not prd or not tasks:
        return report(0, 0, set(), set())

    # ---- check 1: range declared in the header
    header = tasks.split('---', 1)[0]
    declared = re.search(r'`IMPL-(\d+)`\s*(?:\u2026|\.\.\.)\s*`IMPL-(\d+)`',
                         header)
    if not declared:
        fail('the task document header does not declare an IMPL range -- the '
             'gate requires an allocated range, stated where it can be found')
    else:
        low, high = int(declared.group(1)), int(declared.group(2))
        if (low, high) != (RANGE_START, RANGE_END):
            fail('header declares IMPL-%d..IMPL-%d, expected IMPL-%d..IMPL-%d'
                 % (low, high, RANGE_START, RANGE_END))

    rows = task_rows(tasks)
    numbers = [number for _, number, _ in rows]

    # ---- check 2: contiguity, no duplicates
    duplicates = sorted({n for n in numbers if numbers.count(n) > 1})
    if duplicates:
        fail('duplicate task identifiers %s -- allocation rule 1 forbids '
             'reusing a number' % duplicates)
    if len(set(numbers)) != EXPECTED_TASKS:
        fail('%d distinct tasks parsed, %d expected'
             % (len(set(numbers)), EXPECTED_TASKS))
    missing = [n for n in range(RANGE_START, RANGE_END + 1)
               if n not in set(numbers)]
    if missing:
        fail('allocated span has holes: %s -- a gap inside an allocated range '
             'makes the published range false' % missing)

    # ---- check 3: nothing outside the range, nothing foreign
    for lineno, number, _ in rows:
        if not RANGE_START <= number <= RANGE_END:
            fail('IMPL-%d at line %d falls outside the allocated range'
                 % (number, lineno))
        if FOREIGN_RESERVE[0] <= number <= FOREIGN_RESERVE[1]:
            fail('IMPL-%d reaches into IMPL-%d..IMPL-%d, PRD-014\'s declared '
                 'growth reserve -- allocation rule 2 requires the previous '
                 'group keep room to grow contiguously'
                 % (number, FOREIGN_RESERVE[0], FOREIGN_RESERVE[1]))
        if number in FOREIGN_TASKS:
            fail('IMPL-%d is held by PRD-001 -- this backlog must state its '
                 'obligation without duplicating the task' % number)

    # ---- check 4/6: citations exist, and no task claims nothing
    defined = prd_obligations(prd)
    exists = set()
    for register, members in defined.items():
        for number in members:
            exists.add('CNF-%s-%03d' % (register, number))

    claimed = set()
    for lineno, number, cells in rows:
        row_text = ' | '.join(cells)
        cited = expand_ids(row_text)
        if not cited:
            fail('IMPL-%d (line %d) cites no obligation -- a task that '
                 'discharges nothing is not traceable to requirements'
                 % (number, lineno))
        for ident in sorted(cited - exists):
            fail('IMPL-%d cites %s, which is defined nowhere in PRD-023 -- a '
                 'task citing a non-existent obligation reads as diligent '
                 'while discharging nothing' % (number, ident))
        claimed |= cited

        # ---- check 7: rule 3 fields present
        if len(cells) < 6:
            fail('IMPL-%d (line %d) has %d cells; rule 3 requires Priority, '
                 'Blocked by and Blocks alongside id, task and traceability'
                 % (number, lineno, len(cells)))
        else:
            if not cells[3]:
                fail('IMPL-%d has an empty Priority cell (rule 3)' % number)
            if not cells[4]:
                fail('IMPL-%d has an empty "Blocked by" cell (rule 3)'
                     % number)
            if not cells[5]:
                fail('IMPL-%d has an empty "Blocks" cell (rule 3)' % number)

    # ---- check 5: every Class A obligation claimed
    class_a = set()
    for register in CLASS_A:
        for number in defined.get(register, set()):
            class_a.add('CNF-%s-%03d' % (register, number))

    unclaimed = sorted(class_a - claimed)
    if unclaimed:
        fail('%d Class A obligation(s) are claimed by NO task: %s -- the gate '
             'requires the backlog cover the requirements, not a subset'
             % (len(unclaimed), ', '.join(unclaimed[:12])))

    published = re.search(r'\*\*(\d+) of (\d+) = ([\d.]+)%\*\*', tasks)
    if published:
        claim_n = int(published.group(1))
        total_n = int(published.group(2))
        if total_n != len(class_a):
            fail('the document publishes a Class A total of %d, recomputed %d'
                 % (total_n, len(class_a)))
        if claim_n != len(class_a & claimed):
            fail('the document publishes %d claimed, recomputed %d'
                 % (claim_n, len(class_a & claimed)))
    else:
        fail('no coverage figure of the form "N of M = P%" found -- an '
             'unpublished figure cannot be checked against a recomputation')

    # ---- check 8: rule 4 traceability table, non-vacuous
    if not re.search(r'task group\s*\u2192\s*requirement', tasks,
                     re.IGNORECASE):
        fail('no "task group -> requirements -> invariants -> acceptance" '
             'table found -- allocation rule 4 requires one')
    invariants = {'CNF-INV-%03d' % n for n in defined.get('INV', set())}
    if invariants and not invariants <= claimed:
        fail('invariants claimed by no task: %s'
             % sorted(invariants - claimed))

    # ---- check 9: the empty registers are STILL empty
    for register in EMPTY_BY_DESIGN:
        minted = re.findall(r'`CNF-%s-(\d+)`' % register, tasks)
        if minted:
            fail('the task document names CNF-%s-%s, but that register is '
                 'DECLARED EMPTY. A backlog is the likeliest place for a '
                 'configurable to be invented, and all 104 belong to eight '
                 'FROZEN PRDs' % (register, sorted(set(minted))))

    return report(len(rows), len(class_a), claimed, class_a)


def report(task_count, class_a_count, claimed, class_a):
    line = '-' * 70
    print(line)
    print('PRD-023 Stage 6 gate -- task coverage')
    print(line)
    print('tasks parsed                             : %d' % task_count)
    print('allocated range                          : IMPL-%d..IMPL-%d'
          % (RANGE_START, RANGE_END))
    print('Class A obligations in the PRD            : %d' % class_a_count)
    if class_a:
        covered = len(class_a & claimed)
        print('claimed by at least one task             : %d (%.1f%%)'
              % (covered, 100.0 * covered / len(class_a)))
    print('acceptance criteria PROVEN by a test     : 0  (no implementation)')
    print(line)
    if problems:
        print('FAIL - %d problem(s):' % len(problems))
        for problem in problems:
            print('  * %s' % problem)
        print(line)
        return 1
    print('PASS - range allocated contiguously without reaching into a')
    print('       foreign reserve, every task cites at least one real')
    print('       obligation, every Class A obligation is claimed, rule 3')
    print('       fields present on every row, rule 4 table present, and')
    print('       both empty registers are still empty.')
    print(line)
    return 0


if __name__ == '__main__':
    sys.exit(main())
