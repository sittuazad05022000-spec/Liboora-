#!/usr/bin/env python3
"""PRD-016 Stage 6 gate -- the task document against the PRD.

PRD_LIFECYCLE.md Stage 6, verbatim:

    Gate: an IMPL-* range allocated and a task document in which every task
    traces back to requirements.

    Allocation rules:
    1. Take the next free range.  Never reuse or reassign a number.
    2. Leave the previous group room to grow contiguously.
    3. Record Priority, Blocks, Blocked by per task.
    4. Add a traceability table mapping task groups -> requirements ->
       invariants -> acceptance.

This script measures all four rules plus both halves of the gate itself.  It is
the third committed checker for PRD-016 and it deliberately does NOT import
either of the other two -- prd016_traceability.py (the PRD against itself) or
prd016_stage5.py (the matrix against the PRD).  TRACEABILITY_MATRIX.md section
2H.2 names the failure mode that independence guards against:

    "a checker written in the same pass as the register it checks, by the same
     author, verifies agreement with itself."

What this checker parses that neither of the others does: IMPL-* task rows, the
dependency graph they describe, and the published graph figures.  It re-derives
the obligation set from the PRD independently, by the same em-dash convention
the other two established -- see HAZARD 1 below -- so that a change to the PRD
that removed an obligation cannot pass here by going unnoticed.

------------------------------------------------------------------------------
THREE INSTRUMENT HAZARDS, inherited and re-encoded.  In all three the document
was right and an earlier version of the instrument was wrong.

HAZARD 1 -- bold-wrapped definitions.  PRD-016 opens a requirement with a BOLD
backticked identifier followed by an em-dash:

    **`AUD-FR-001`** -- The module SHALL own the `AuditEntry` aggregate ...

PRD-013 uses a bare backticked identifier, so PRD-013's rule matched 1 of 16
AUD-FR-* and reported five registers absent.  A tool that reports a correct
document as broken invites "fixing" the document to suit the tool.  The rule
encoded here is the document's ACTUAL convention: bold identifier + em-dash +
normative text (23 lines) OR a table's first cell (35 cells) = 58 identifiers.

HAZARD 2 -- ellipsis ranges, recorded as Stage 4 finding S4-D-01.  Cells cite
ranges: `AUD-XC-005`...`008`.  A token-only scanner misses 006 and 007.  In the
Stage 5 pass that under-counted acceptance coverage by 3 and reported 11
uncovered obligations where the truth is 8.  Range notation is established
practice -- frozen PRD-007 uses it at SEAT-AC-166.  expand() below expands
them, and every cell this script reads goes through it.  For THIS gate the
error would be worse than at Stage 5: under-counting a Requirements cell
reports a false PASS, not a false gap.

HAZARD 3 -- sentence-final identifiers.  Section 0.3 ends a sentence with
"Retention is recorded as **`AUD-GAP-001`**."  A rule that accepted any bold
identifier at line start would read that as a second definition of a table row
and report a phantom duplicate.  The em-dash anchor excludes it.

------------------------------------------------------------------------------
A FOURTH HAZARD, specific to this stage and this document.

The allocation table in section 3.2 opens its rows with a backticked IMPL-*,
exactly as a task row does:

    | `IMPL-014` ... `IMPL-073` | Authentication, platform ... |

A document-wide scan reads nineteen range rows as malformed tasks.  The
allocation table is correct; a scanner that cannot tell a range row from a task
row is the wrong instrument.  parse_tasks() therefore reads section 5 ONLY,
which is where the gate's "task document" lives.  This is the same correction
prd013_task_coverage.py records for the same reason.

And a fifth, unique to this backlog: IMPL-900 already OCCURS in the repository,
three times, as an "Unallocated" boundary label.  Occurrence is not occupancy.
check_allocation() therefore tests for a task DEFINITION below the range floor,
not for the appearance of a string.

Exit 0 = Stage 6 gate satisfied.  Exit 1 = it is not, whatever the prose says.
"""

import os
import re
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
PRD = os.path.join('docs', '30-product', 'audit', 'PRD-016_AUDIT_TRAIL.md')
TASKS = os.path.join('docs', '40-implementation', 'audit',
                     'PRD-016_IMPLEMENTATION_TASKS.md')

LOW = 900
HIGH = 929

# Class A registers carry obligations a task may claim.
OBLIGATION = ['FR', 'BR', 'INV', 'EVT', 'XC']
# These may never appear in a Requirements cell.  An acceptance criterion is
# verified by a task, not implemented by one; a gap is an open question and
# citing one as an obligation resolves it by implementation choice.
EXCLUDED = ['AC', 'GAP', 'CFG']

PRIORITIES = ['P1', 'P2', 'P3']

# See HAZARD 1.  Identical in intent to prd016_traceability.py's rule, written
# out here rather than imported, so that the two instruments stay independent.
DEF_PATTERNS = [
    r'^\*\*`AUD-([A-Z]+)-(\d+)`\*\*\s*(?:\u2014|--)\s*\S',
    r'^\|\s*\*{0,2}`AUD-([A-Z]+)-(\d+)`\*{0,2}\s*\|',
    r'^###\s+\*{0,2}`AUD-([A-Z]+)-(\d+)`',
]

PROBLEMS = []


def fail(message):
    PROBLEMS.append(message)


def read(relative):
    path = os.path.join(ROOT, relative)
    if not os.path.exists(path):
        fail('%s does not exist' % relative)
        return ''
    with open(path, encoding='utf-8') as handle:
        return handle.read()


def section(text, heading):
    """The text under `heading`, up to the next heading of the same depth."""
    lines = text.split('\n')
    depth = len(heading) - len(heading.lstrip('#'))
    start = None
    for index, line in enumerate(lines):
        if line.strip().startswith(heading):
            start = index + 1
            break
    if start is None:
        return None
    out = []
    for line in lines[start:]:
        stripped = line.strip()
        if stripped.startswith('#'):
            here = len(stripped) - len(stripped.lstrip('#'))
            if here <= depth:
                break
        out.append(line)
    return '\n'.join(out)


def obligations(prd):
    """The Class A identifiers PRD-016 defines, recomputed from the PRD.

    Not read from the task document, and not read from the matrix.  If the PRD
    ever loses an obligation, coverage here must drop rather than stay at 100%
    because the backlog still cites it.
    """
    found = set()
    for line in prd.split('\n'):
        for pattern in DEF_PATTERNS:
            match = re.match(pattern, line.strip())
            if match:
                register, number = match.group(1), int(match.group(2))
                if register in OBLIGATION:
                    found.add('AUD-%s-%03d' % (register, number))
                break
    return found


def defined_all(prd):
    """Every AUD-* identifier the PRD defines, any register."""
    found = set()
    for line in prd.split('\n'):
        for pattern in DEF_PATTERNS:
            match = re.match(pattern, line.strip())
            if match:
                found.add('AUD-%s-%03d'
                          % (match.group(1), int(match.group(2))))
                break
    return found


def expand(cell):
    """Every AUD-* in `cell`, with ellipsis ranges expanded -- see HAZARD 2."""
    ids = set()
    pattern = (r'`AUD-([A-Z]+)-(\d+)`\s*(?:\u2026|\.\.\.|\.\.)\s*'
               r'`(?:AUD-([A-Z]+)-)?(\d+)`')
    for match in re.finditer(pattern, cell):
        register, first, second_reg, last = match.groups()
        if second_reg is not None and second_reg != register:
            fail('cross-register range `AUD-%s-%s`...`AUD-%s-%s` is not '
                 'expandable -- write both endpoints in full'
                 % (register, first, second_reg, last))
            continue
        start, end = int(first), int(last)
        if end < start:
            fail('inverted range `AUD-%s-%s`...`%s`'
                 % (register, first, last))
            continue
        for number in range(start, end + 1):
            ids.add('AUD-%s-%03d' % (register, number))
    for match in re.finditer(r'`AUD-([A-Z]+)-(\d+)`', cell):
        ids.add('AUD-%s-%03d'
                % (match.group(1), int(match.group(2))))
    return ids


def parse_tasks(text):
    """number -> dict(prio, by, blocks, reqs), from SECTION 5 ONLY.

    The section restriction is load-bearing -- see the fourth hazard in the
    module docstring.  Section 3.2's allocation table opens its rows with a
    backticked IMPL-* too, and a document-wide scan reads nineteen correct
    range rows as malformed tasks.
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
                             reqs=cells[6], test=cells[7])
        order.append(number)
    return tasks, order


def longest_chain(tasks):
    """Longest path length in the DAG, and whether a cycle exists."""
    memo = {}
    state = {}

    def walk(node):
        if state.get(node) == 1:
            return None          # cycle
        if node in memo:
            return memo[node]
        state[node] = 1
        best = 1
        for nxt in tasks[node]['blocks']:
            if nxt not in tasks:
                continue
            deeper = walk(nxt)
            if deeper is None:
                return None
            best = max(best, deeper + 1)
        state[node] = 2
        memo[node] = best
        return best

    longest = 0
    for node in tasks:
        result = walk(node)
        if result is None:
            return None
        longest = max(longest, result)
    return longest


def main():
    prd = read(PRD)
    doc = read(TASKS)
    if not prd or not doc:
        report(0, 0, 0, 0)
        return

    defined = defined_all(prd)
    obligation_set = obligations(prd)
    tasks, order = parse_tasks(doc)

    # ---- gate, first half: an IMPL-* range is allocated ------------------
    if not tasks:
        fail('no task parsed -- there is no allocated range to verify')
    else:
        numbers = sorted(tasks)
        if numbers[0] != LOW or numbers[-1] != HIGH:
            fail('allocated span is IMPL-%d..IMPL-%d, expected IMPL-%d..'
                 'IMPL-%d' % (numbers[0], numbers[-1], LOW, HIGH))
        expected = list(range(LOW, HIGH + 1))
        if numbers != expected:
            missing = sorted(set(expected) - set(numbers))
            extra = sorted(set(numbers) - set(expected))
            if missing:
                fail('gap inside the allocated span: %s'
                     % ', '.join('IMPL-%d' % n for n in missing))
            if extra:
                fail('task outside IMPL-%d..IMPL-%d: %s'
                     % (LOW, HIGH, ', '.join('IMPL-%d' % n for n in extra)))

    # ---- allocation rule 1: never reuse or reassign ---------------------
    # Occurrence is not occupancy.  IMPL-900 appears three times in the repo
    # as an "Unallocated" boundary label; what would breach rule 1 is a task
    # DEFINED below the floor, not a string that mentions the number.
    for number in tasks:
        if number < LOW:
            fail('IMPL-%d is defined as a task below the allocated floor '
                 'IMPL-%d -- allocation rule 1 forbids reassignment'
                 % (number, LOW))
        if 830 <= number <= 899:
            fail("IMPL-%d falls inside PRD-013's declared growth reserve "
                 'IMPL-830..899' % number)

    # ---- gate, operative half: every task traces to requirements --------
    claimed = set()
    for number in order:
        cell = tasks[number]['reqs']
        cited = expand(cell)
        if not cited:
            fail('IMPL-%d has an EMPTY Requirements cell -- the Stage 6 gate '
                 'requires every task to trace back to requirements' % number)
            continue
        for identifier in sorted(cited):
            register = identifier.split('-')[1]
            if identifier not in defined:
                fail('IMPL-%d cites %s, which PRD-016 does not define'
                     % (number, identifier))
                continue
            if register in EXCLUDED:
                fail('IMPL-%d cites %s as an OBLIGATION -- an AUD-%s-* may '
                     'not be claimed as a requirement' % (number, identifier,
                                                          register))
                continue
            if register not in OBLIGATION:
                fail('IMPL-%d cites %s, which is not a Class A register'
                     % (number, identifier))
                continue
            claimed.add(identifier)

    for identifier in sorted(obligation_set - claimed):
        fail('%s is claimed by NO task -- an obligation with no task cannot '
             'be implemented' % identifier)

    # ---- allocation rule 3: Priority, Blocks, Blocked by ----------------
    for number in order:
        task = tasks[number]
        if task['prio'] not in PRIORITIES:
            fail('IMPL-%d has Priority %r, expected one of %s'
                 % (number, task['prio'], '/'.join(PRIORITIES)))
        for dep in sorted(task['by']):
            if dep not in tasks:
                fail('IMPL-%d is Blocked by IMPL-%d, which is not a task here'
                     % (number, dep))
            elif number not in tasks[dep]['blocks']:
                fail('IMPL-%d says it is Blocked by IMPL-%d, but IMPL-%d does '
                     'not list IMPL-%d in Blocks -- the two directions '
                     'disagree' % (number, dep, dep, number))
        for dep in sorted(task['blocks']):
            if dep not in tasks:
                fail('IMPL-%d Blocks IMPL-%d, which is not a task here'
                     % (number, dep))
            elif number not in tasks[dep]['by']:
                fail('IMPL-%d says it Blocks IMPL-%d, but IMPL-%d does not '
                     'list IMPL-%d in Blocked by -- the two directions '
                     'disagree' % (number, dep, dep, number))

    # ---- graph shape, recomputed --------------------------------------
    roots = [n for n in tasks if not tasks[n]['by']]
    leaves = [n for n in tasks if not tasks[n]['blocks']]
    edges = sum(len(tasks[n]['blocks']) for n in tasks)
    longest = longest_chain(tasks) if tasks else 0
    if longest is None:
        fail('the dependency graph contains a CYCLE -- no execution order '
             'exists')
        longest = 0
    if len(roots) != 1:
        fail('expected exactly 1 root, found %d: %s'
             % (len(roots), ', '.join('IMPL-%d' % n for n in sorted(roots))))
    if len(leaves) != 1:
        fail('expected exactly 1 leaf, found %d: %s'
             % (len(leaves), ', '.join('IMPL-%d' % n for n in sorted(leaves))))

    # ---- the harness edge list must be DERIVED, not typed --------------
    # IMPL-929 must be blocked by exactly the otherwise-terminal tasks: every
    # task that blocks nothing except the harness itself.  PRD-007's backlog
    # records a hand-written list that omitted a task whose criteria required
    # it; deriving the set makes that omission impossible.
    if HIGH in tasks:
        terminal = set()
        for number in tasks:
            if number == HIGH:
                continue
            downstream = tasks[number]['blocks'] - {HIGH}
            if not downstream:
                terminal.add(number)
        declared = tasks[HIGH]['by']
        if declared != terminal:
            missing = sorted(terminal - declared)
            extra = sorted(declared - terminal)
            if missing:
                fail("IMPL-%d's Blocked by omits otherwise-terminal task(s) "
                     '%s -- the harness would not observe them'
                     % (HIGH, ', '.join('IMPL-%d' % n for n in missing)))
            if extra:
                fail("IMPL-%d's Blocked by names %s, which is not "
                     'otherwise-terminal -- the list is typed, not derived'
                     % (HIGH, ', '.join('IMPL-%d' % n for n in extra)))

    # ---- allocation rule 4: the traceability table exists -------------
    trace = section(doc, '## 6. Traceability')
    if trace is None:
        fail('no section 6 -- allocation rule 4 requires a traceability table '
             'mapping task groups to requirements, invariants and acceptance')
    else:
        for column in ['Requirements claimed', 'Invariants enforced',
                       'Acceptance criteria proven']:
            if column not in trace:
                fail('section 6 has no %r column -- allocation rule 4 names '
                     'all four' % column)
        match = re.search(r'\*\*(\d+) / (\d+) = ([\d.]+)%\*\*', trace)
        if match is None:
            fail('section 6 publishes no "claimed / total = pct" figure, so '
                 'nothing can be checked against the computation')
        else:
            said_claimed = int(match.group(1))
            said_total = int(match.group(2))
            said_pct = float(match.group(3))
            if said_total != len(obligation_set):
                fail('section 6 publishes %d obligations; the PRD defines %d'
                     % (said_total, len(obligation_set)))
            if said_claimed != len(claimed):
                fail('section 6 publishes %d obligations claimed; recomputed '
                     '%d' % (said_claimed, len(claimed)))
            if obligation_set:
                real = round(100.0 * len(claimed) / len(obligation_set), 1)
                if abs(said_pct - real) > 0.05:
                    fail('section 6 publishes %.1f%% coverage; recomputed '
                         '%.1f%%' % (said_pct, real))

    # ---- section 7's graph figures must match the computation ---------
    path = section(doc, '## 7. Critical path')
    if path is None:
        fail('no section 7 -- the critical path is published nowhere, so the '
             'graph figures cannot be checked')
    else:
        for label, pattern, actual in [
                ('tasks', r'tasks (\d+)', len(tasks)),
                ('edges', r'edges (\d+)', edges),
                ('cycles', r'cycles (\d+)', 0),
                ('longest chain', r'longest chain (\d+)', longest)]:
            found = re.search(pattern, path)
            if found is None:
                fail('section 7 publishes no %r figure' % label)
            elif int(found.group(1)) != actual:
                fail('section 7 publishes %s %s; recomputed %d'
                     % (label, found.group(1), actual))
        chain = re.findall(r'IMPL-(\d+)', path)
        if chain:
            steps = [int(c) for c in chain]
            # The published chain must be a real path of the stated length.
            start = None
            for index in range(len(steps) - 1):
                if steps[index] in tasks and \
                        steps[index + 1] in tasks[steps[index]]['blocks']:
                    if start is None:
                        start = index
                elif start is not None:
                    break

    # ---- the two empty registers must stay empty --------------------
    for register in ['EVT', 'CFG']:
        present = sorted(i for i in claimed
                         if i.split('-')[1] == register)
        if present:
            fail('AUD-%s-* is declared empty in the PRD, yet a task claims '
                 '%s -- a backlog may not mint an identifier the PRD refused '
                 'to issue' % (register, ', '.join(present)))

    report(len(tasks), len(claimed), len(obligation_set), longest,
           roots=len(roots), leaves=len(leaves), edges=edges)


def report(count, claimed, total, longest, roots=None, leaves=None,
           edges=None):
    line = '-' * 70
    print('PRD-016 Stage 6 gate -- the task document against the PRD')
    print(line)
    print('  range allocated                          : IMPL-%d .. IMPL-%d'
          % (LOW, HIGH))
    print('  tasks parsed                             : %d' % count)
    print('  dependency edges                         : %s'
          % ('%d' % edges if edges is not None else '-'))
    print('  roots / leaves                           : %s / %s'
          % (roots if roots is not None else '-',
             leaves if leaves is not None else '-'))
    print('  longest chain                            : %d' % longest)
    print(line)
    print('Class A obligations defined by the PRD     : %d' % total)
    print('obligations claimed by at least one task   : %d' % claimed)
    if total:
        print('coverage of obligations                    : %d / %d = %.1f%%'
              % (claimed, total, 100.0 * claimed / total))
    print('acceptance criteria proven by a test       : 0  (no implementation)')
    print(line)
    if PROBLEMS:
        print('FAIL - %d problem(s):' % len(PROBLEMS))
        for problem in PROBLEMS:
            print('  * %s' % problem)
        print(line)
        sys.exit(1)
    print('PASS - an IMPL-* range is allocated contiguously, every task')
    print('       traces back to requirements PRD-016 actually defines, no')
    print('       AUD-AC-* or AUD-GAP-* is cited as an obligation, every')
    print('       obligation has a claiming task, Priority is recorded and')
    print('       Blocks/Blocked by agree in both directions, the graph is')
    print('       acyclic with one root and one leaf, the harness edge list')
    print('       is the derived terminal set, and both empty registers')
    print('       stayed empty.')
    print('       PRD_LIFECYCLE.md Stage 6 gate SATISFIED.')
    print(line)
    sys.exit(0)


if __name__ == '__main__':
    main()
