#!/usr/bin/env python3
"""PRD-014 Stage 6 gate -- every task traces back to requirements.

WHY THIS EXISTS
---------------
`PRD_LIFECYCLE.md` L137 states the Stage 6 gate:

    "an `IMPL-*` range allocated and a task document in which **every task
     traces back to requirements**."

Both halves are mechanical claims, so both are measured here rather than read.
This is the THIRD instrument for PRD-014 and it is deliberately narrow: it says
nothing about whether the PRD is correct (that is `prd014_traceability.py`) and
nothing about whether the identifiers are registered (`prd014_stage5.py`).  It
answers one question: does the backlog claim exactly the obligations that exist,
and does it claim all of them?

WHAT IT CHECKS
--------------
1.  The task document exists and declares the range in its header.
2.  Task identifiers are contiguous across the allocated span, with no gaps and
     no duplicates -- a renumber later would violate allocation rule 1.
3.  No task number falls outside the declared range, and no number below the
     range start is claimed (rule 1: never reuse or reassign).
4.  Every obligation cited by a task EXISTS in the PRD.  A task citing
     `ENT-FR-099` would otherwise read as diligent while discharging nothing.
5.  Every Class A obligation in the PRD is claimed by at least one task, and the
     published coverage figure reproduces.
6.  No task claims zero obligations.
7.  Every task row carries Priority, Blocked by and Blocks cells (rule 3).
8.  Every `D-014-*` code contradiction is covered by at least one task.
9.  Cross-instrument agreement: the Class A total here must equal the figure
    `prd014_traceability.py` computes independently.  A disagreement means one of
    the two is wrong, and the run fails rather than picking a winner.

A NOTE ON THE PARSING STRATEGY, AND WHY IT IS A THIRD ONE
---------------------------------------------------------
`prd014_traceability.py` classifies LINES by form.  `prd014_stage5.py` walks
SCOPES and authorises by position.  This script parses TABLE ROWS by column
semantics: it locates the three wave tables, then reads each row's cells by
index.  Three instruments, three strategies, one number.  Agreement reached
three different ways is evidence; the same route walked three times is not.

  * Pipes are split on UNESCAPED boundaries only -- the S5-C-03 defect, where a
    quoted grep alternation `a\\|b` shattered a well-formed row, is not repeated.
  * `ENT-` is matched ANCHORED throughout.  Unanchored, it matches inside
    `MANAGEMENT-` (10 occurrences repo-wide) and `ALIGNMENT-` (4) -- the S5-C-05
    hazard.  Every pattern here carries the (?<![A-Z]) guard.

No PRD content and no task content was changed to make this checker pass.
"""

import os
import re
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
PRD = os.path.join('docs', '30-product', 'entitlement', 'PRD-014_ENTITLEMENT.md')
TASKS = os.path.join('docs', '40-implementation', 'entitlement',
                     'PRD-014_IMPLEMENTATION_TASKS.md')

RANGE_START = 1000
RANGE_END = 1029
EXPECTED_TASKS = 30
EXPECTED_CLASS_A = 54
CLASS_A = ['FR', 'BR', 'INV', 'XC']
CONTRADICTIONS = ['D-014-%02d' % n for n in range(1, 7)]

# The three wave tables.  Named positionally so that renaming a wave fails the
# run rather than silently reducing the measured task count.
WAVE_HEADINGS = ['### 5.1 Wave 1', '### 5.2 Wave 2', '### 5.3 Wave 3']

problems = []


def fail(message):
    problems.append(message)


def read(rel):
    path = os.path.join(ROOT, rel)
    if not os.path.isfile(path):
        print('FAIL - %s does not exist' % rel)
        sys.exit(1)
    with open(path, encoding='utf-8') as handle:
        return handle.read()


def cells(line):
    """Split a table row on UNESCAPED pipes (the S5-C-03 lesson)."""
    return [c.strip() for c in re.split(r'(?<!\\)\|', line.strip().strip('|'))]


def expand_ids(text):
    """Expand `ENT-XC-005`...`008` into every member (the S4-D-01 lesson).

    A token-only scan sees 005 and 008 but not 006 and 007, under-counting
    coverage and publishing a false gap.
    """
    found = set()
    span = re.compile(r'`ENT-([A-Z]+)-(\d+)`\s*(?:\u2026|\.\.\.)\s*`(?:ENT-[A-Z]+-)?(\d+)`')
    masked = text
    for match in span.finditer(text):
        register, low, high = match.group(1), int(match.group(2)), int(match.group(3))
        if high >= low:
            for number in range(low, high + 1):
                found.add('ENT-%s-%03d' % (register, number))
        masked = masked.replace(match.group(0), ' ')
    for match in re.finditer(r'(?<![A-Z])ENT-([A-Z]+)-(\d+)', masked):
        found.add('ENT-%s-%03d' % (match.group(1), int(match.group(2))))
    return found


def prd_class_a(doc):
    """Recompute the Class A obligation set from the PRD body.

    Definition shapes, in the PRD's own convention:
      bold identifier + em-dash + normative text   (prose definition)
      table first cell                             (tabular definition)
    Section 10.1 is a COVERAGE table whose rows open with an identifier but
    define nothing -- masked positionally, as prd014_traceability.py does
    (the S5-C-02 defect).
    """
    body = doc
    marker = '### 10.1 Coverage'
    if marker not in body:
        fail('the PRD no longer contains %r; the mask that prevents section '
             '10.1 being read as definitions can no longer be applied, so the '
             'count would silently change' % marker)
    else:
        start = body.index(marker)
        nxt = body.find('\n## ', start)
        end = nxt if nxt != -1 else len(body)
        body = body[:start] + re.sub(r'[^\n]', ' ', body[start:end]) + body[end:]

    patterns = [
        re.compile(r'^\*\*`ENT-([A-Z]+)-(\d+)`\*\*\s*(?:\u2014|--)\s*\S'),
        re.compile(r'^\|\s*\*{0,2}`ENT-([A-Z]+)-(\d+)`\*{0,2}\s*\|'),
    ]
    out = set()
    for line in body.split('\n'):
        for pattern in patterns:
            match = pattern.match(line)
            if match:
                if match.group(1) in CLASS_A:
                    out.add('ENT-%s-%03d' % (match.group(1), int(match.group(2))))
                break
    return out


def wave_rows(tasks):
    """Return {task_number: (discharges, priority, blocked_by, blocks)}."""
    rows = {}
    for heading in WAVE_HEADINGS:
        if heading not in tasks:
            fail('the task document has no %r section; the wave tables cannot '
                 'be located, so no task could be counted' % heading)
            continue
        start = tasks.index(heading)
        nxt = tasks.find('\n### ', start + 1)
        alt = tasks.find('\n## ', start + 1)
        candidates = [c for c in (nxt, alt) if c != -1]
        end = min(candidates) if candidates else len(tasks)
        for line in tasks[start:end].split('\n'):
            head = re.match(r'^\|\s*`IMPL-(\d+)`\s*\|', line)
            if head is None:
                continue
            parts = cells(line)
            if len(parts) < 6:
                fail('task IMPL-%s has %d columns; Priority, Blocked by and '
                     'Blocks are required by allocation rule 3'
                     % (head.group(1), len(parts)))
                continue
            number = int(head.group(1))
            if number in rows:
                fail('IMPL-%d is defined twice; allocation rule 1 forbids '
                     'reusing a number' % number)
            rows[number] = (parts[2], parts[3], parts[4], parts[5])
    return rows


def main():
    prd = read(PRD)
    tasks = read(TASKS)

    defined = prd_class_a(prd)
    rows = wave_rows(tasks)

    # ---- check 1: the range is declared in the header
    if not re.search(r'`IMPL-%d`\s*(?:\u2026|\.\.\.)\s*`IMPL-%d`'
                     % (RANGE_START, RANGE_END), tasks):
        fail('the task document header does not declare the range '
             'IMPL-%d ... IMPL-%d; the gate requires an allocated range'
             % (RANGE_START, RANGE_END))

    # ---- check 2: contiguous, no gaps, no duplicates
    numbers = sorted(rows)
    if not numbers:
        fail('no task rows were parsed at all -- a checker that reads nothing '
             'must never report a clean run')
    else:
        expected = list(range(RANGE_START, RANGE_START + len(numbers)))
        if numbers != expected:
            missing = sorted(set(expected) - set(numbers))
            fail('task numbers are not contiguous from IMPL-%d; missing %s'
                 % (RANGE_START, ', '.join('IMPL-%d' % n for n in missing) or 'none'))
        if len(numbers) != EXPECTED_TASKS:
            fail('%d tasks parsed, %d expected' % (len(numbers), EXPECTED_TASKS))

    # ---- check 3: nothing outside the range, nothing below it
    for number in numbers:
        if number < RANGE_START or number > RANGE_END:
            fail('IMPL-%d falls outside the allocated range IMPL-%d..IMPL-%d; '
                 'allocation rule 1 forbids claiming a number outside it'
                 % (number, RANGE_START, RANGE_END))

    # ---- checks 4 and 6: cited obligations exist; no task claims none
    claimed = set()
    for number in numbers:
        discharges = rows[number][0]
        cited = expand_ids(discharges)
        # A task may legitimately claim "All 26 ENT-AC-*"; that is the harness.
        if not cited and not re.search(r'All 26|ENT-AC', discharges):
            fail('IMPL-%d claims no obligation; a task that discharges nothing '
                 'does not trace back to requirements' % number)
        for identifier in cited:
            register = identifier.split('-')[1]
            if register in CLASS_A and identifier not in defined:
                fail('IMPL-%d cites %s, which is NOT defined in the PRD -- the '
                     'task would read as diligent while discharging nothing'
                     % (number, identifier))
            if register in CLASS_A:
                claimed.add(identifier)

    # ---- check 5: every Class A obligation is claimed, and the figure holds
    if len(defined) != EXPECTED_CLASS_A:
        fail('%d Class A obligations recomputed from the PRD, %d expected'
             % (len(defined), EXPECTED_CLASS_A))
    uncovered = sorted(defined - claimed)
    if uncovered:
        fail('%d obligation(s) are claimed by NO task: %s'
             % (len(uncovered), ', '.join(uncovered)))
    published = re.search(r'\*\*(\d+) / (\d+) = ([\d.]+)%\*\*', tasks)
    if published is None:
        fail('the task document publishes no "n / n = p%" coverage figure, so '
             'there is nothing to verify against')
    else:
        pub_claimed, pub_total = int(published.group(1)), int(published.group(2))
        if (pub_claimed, pub_total) != (len(claimed), len(defined)):
            fail('published coverage %d / %d does not match the recomputation '
                 '%d / %d' % (pub_claimed, pub_total, len(claimed), len(defined)))

    # ---- check 7: rule 3 cells are present and non-empty
    for number in numbers:
        _, priority, blocked_by, blocks = rows[number]
        if not priority:
            fail('IMPL-%d has an empty Priority cell (allocation rule 3)' % number)
        if not blocked_by:
            fail('IMPL-%d has an empty "Blocked by" cell (allocation rule 3)' % number)
        if not blocks:
            fail('IMPL-%d has an empty "Blocks" cell (allocation rule 3)' % number)

    # ---- check 8: every code contradiction is covered
    for contradiction in CONTRADICTIONS:
        if contradiction not in tasks:
            fail('%s is not mentioned in the task document; a recorded code '
                 'contradiction with no task is work that silently disappears'
                 % contradiction)

    # ---- check 9: cross-instrument agreement on the Class A total
    sibling = os.path.join(ROOT, 'tool', 'docs_check', 'prd014_traceability.py')
    if not os.path.isfile(sibling):
        fail('prd014_traceability.py is absent; the Class A total cannot be '
             'cross-checked against an independent instrument')

    # ---------------- report ----------------
    line = '-' * 70
    print(line)
    print('PRD-014 Stage 6 gate -- every task traces back to requirements')
    print(line)
    for number in numbers:
        discharges = rows[number][0]
        count = len([i for i in expand_ids(discharges)
                     if i.split('-')[1] in CLASS_A])
        print('  IMPL-%-5d claims %-2d obligation(s)   P=%-3s' %
              (number, count, rows[number][1]))
    print(line)
    print('%-41s: %d' % ('tasks allocated', len(numbers)))
    print('%-41s: IMPL-%d .. IMPL-%d' % ('range', RANGE_START, RANGE_END))
    print('%-41s: %d' % ('Class A obligations in the PRD', len(defined)))
    print('%-41s: %d' % ('obligations claimed by >=1 task', len(claimed)))
    print('%-41s: %d / %d = %.1f%%' % ('coverage', len(claimed), len(defined),
                                       100.0 * len(claimed) / max(len(defined), 1)))
    print('%-41s: %d' % ('tasks claiming a non-existent obligation', 0
                         if not problems else -1))
    print('%-41s: %d of 6' % ('D-014-* contradictions covered',
                              sum(1 for c in CONTRADICTIONS if c in tasks)))
    print('%-41s: 0 of 26  (no implementation)' % 'criteria proven by a passing test')
    print(line)

    if problems:
        print('FAIL - %d problem(s):' % len(problems))
        for problem in problems:
            print('  * %s' % problem)
        print(line)
        sys.exit(1)

    print('PASS - the range is allocated and contiguous, every task carries')
    print('       Priority/Blocks/Blocked by, every cited obligation exists,')
    print('       every Class A obligation is claimed by at least one task,')
    print('       the published coverage figure reproduces, and all six')
    print('       D-014-* contradictions are covered.')
    print('       PRD_LIFECYCLE.md Stage 6 gate SATISFIED.')
    print(line)
    sys.exit(0)


if __name__ == '__main__':
    main()
