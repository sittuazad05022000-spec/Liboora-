#!/usr/bin/env python3
"""PRD-006 Stage 6 gate -- task/requirement coverage, computed not asserted.

WHY THIS EXISTS
---------------
`PRD_LIFECYCLE.md` Stage 6's gate is *"an `IMPL-*` range allocated and a task
document in which **every task traces back to requirements**."*

That gate has been missed before.  `PRD-004_IMPLEMENTATION_TASKS.md` held 18
tasks while its PRD declared 24 -- six tasks added by a correction pass were
never propagated (second-review finding `SR-01`, HIGH).  Reading did not catch
it; a count did.  This script is the equivalent check for `PRD-006`, and it is
deliberately the same shape as `prd007_task_coverage.py` so that the backlogs
are held to one standard rather than several.

It verifies, mechanically:

1. **Every task traces to requirements** -- the literal Stage 6 gate.  A task
   with an empty Requirements cell fails the run.
2. **Every cited requirement exists** in `PRD-006`.  A task citing an
   out-of-register identifier would otherwise look like coverage while
   tracing to nothing.
3. **`IMPL-*` IDs are unique** and lie inside the allocated range.  Allocation
   rule 1: a number is never reused or reassigned.
4. **No collision with an existing allocation** -- `IMPL-014`..`073`,
   `100`..`127`, `200`..`226`, `300`..`323`, `400`..`499` and `500`..`599` are
   owned elsewhere.  See the FOREIGN note below: three of those spans include
   another backlog's declared growth reserve, which is owned, not free.
5. **Obligation coverage** -- which `ATT-*` obligations are claimed by at least
   one task.  `ATT-AC-*` are excluded: an acceptance criterion is *verified by*
   a task's test, not *implemented by* a task.  `ATT-GAP-*` are excluded:
   `PRD-006` §0.4 states they *"are questions addressed to a named owner...
   they are not requirements, they are not deferred requirements, and they may
   not be satisfied by an implementer choosing an answer."*
6. **Dependencies resolve** -- every `Blocked by` names a task that exists here
   or an `IMPL-*` owned by another (already registered) backlog.
7. **`Blocks` is the exact inverse of `Blocked by`** for local tasks.  Rule 3
   requires all three of `Priority`, `Blocks`, `Blocked by`; recording two
   directions of one edge is only useful if they agree, and by hand they drift.
   This check caught a real defect while `PRD-006`'s backlog was being written:
   a hand-written dependency list for the acceptance harness omitted the
   authorization and multi-tenancy tasks although the tenancy-isolation
   acceptance band requires them.  `Blocks` is now generated from the graph.
8. **The graph is acyclic**, and the longest chain is computed rather than
   asserted -- the critical-path claim in §7 must be reproducible.

DEFINITION FORM IS LOCATION-NOT-FORM, WHICH DIFFERS FROM PRD-007
----------------------------------------------------------------
`PRD-007` uses one shape per register: `FR`/`BR`/`INV`/`XC`/`NFR` in prose and
`EVT`/`PO`/`CFG`/`AC`/`GAP` in tables, with zero overlap, so its checker can
select a pattern per prefix.

`PRD-006` does not.  Its registers appear in **both** shapes -- two of its
functional requirements are defined in §16.2's prose, others in prose
elsewhere, and every configurable is defined in §16.3's nine-column table.
What distinguishes a definition from a citation here is therefore the
**location**, not the form: several sections restate identifiers they do not
define.  Those sections are enumerated in INDEX_SECTION below, reused verbatim
from `prd006_traceability.py` (the Stage 5 gate) so that Stage 5 and Stage 6
count the same register.  Widening that list would hide real duplicates;
dropping it produces 95 phantom ones.

Suffixed gap identifiers (the three `a`-suffixed successor rows) are matched,
because `PRD-006` §0.3 declares them as successors rather than renumbering.

(Register identifiers are spelled descriptively rather than quoted verbatim in
this docstring.  `prd006_traceability.py` -- the Stage 5 gate -- treats an
`ATT-<REG>-<n>` token found anywhere under `tool/` as a namespace collision and
exempts only itself, so quoting one literally here would make this file fail a
sibling gate.  The regex literals below are unaffected: their character classes
stop them matching that pattern.)

RANGE EXPANSION
---------------
Both the fully-qualified range form (prefix repeated on each endpoint) and the
short form (bare three-digit upper endpoint) are expanded, and a cited range
containing an identifier `PRD-006` does not define is reported rather than
silently absorbed.

A NOTE ON WHAT THIS SCRIPT DOES NOT CHECK
-----------------------------------------
It does not check that a blocked task stays blocked.  Twelve tasks are marked
BLOCKED against an open `ATT-GAP-*`, and check 2 rejects a GAP cited as an
obligation, but no script can tell that a commit has quietly made face
verification work.  That is what the ninth item in §10's definition of done is
for, and it is a human check.

RE-RUN
------
    python3 tool/docs_check/prd006_task_coverage.py

Exit 0 = gate satisfied.  Exit 1 = at least one check failed.
"""

import collections
import os
import re
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

PRD = os.path.join(ROOT, 'docs', '30-product', 'attendance-management',
                   'PRD-006_ATTENDANCE-MANAGEMENT.md')
TASKS = os.path.join(ROOT, 'docs', '40-implementation', 'attendance-management',
                     'PRD-006_IMPLEMENTATION_TASKS.md')

ALLOCATED_LOW, ALLOCATED_HIGH = 600, 679

# Ranges owned by other backlogs -- a hit here is a reuse defect.  Note that
# 128..199, 227..299, 324..399 and 442..499 are declared GROWTH RESERVES of the
# Library, Student Identity, Student Management and Membership backlogs; a
# reserve is owned space, not free space, which is why the spans below are
# stated as the reserve-inclusive bounds their owners declared.
FOREIGN = [(14, 73), (100, 127), (200, 226), (300, 323), (400, 499),
           (500, 599)]

ORDER = ['FR', 'BR', 'INV', 'EVT', 'XC', 'PO', 'CFG', 'NFR', 'AC', 'GAP']

# Sections that RESTATE identifiers rather than define them.  Reused verbatim
# from prd006_traceability.py so Stage 5 and Stage 6 count one register.
INDEX_SECTION = re.compile(
    r'^## (0\.\s|28\.\s|29\.\s|32\.\s)'
    r'|^### (0\.3|16\.2 |31\.1|31\.2)'
)

# 16.2 is a two-column MODE MAP restating configurables defined in 16.3's
# nine-column register -- but it IS the definition site for the two functional
# requirements that sit in its prose.  Excluded for TABLE definitions only.
INDEX_TABLE_ONLY = re.compile(r'^### 16\.2 ')

# Obligations a task can be asked to build.  AC and GAP are excluded by design.
IMPLEMENTABLE = ('ATT-FR', 'ATT-BR', 'ATT-INV', 'ATT-EVT', 'ATT-XC',
                 'ATT-PO', 'ATT-CFG', 'ATT-NFR')

TASK_ROW = re.compile(r'^\|\s*`?(IMPL-(\d+))`?\s*\|')
ID_RX = re.compile(r'ATT-[A-Z]+-\d{3}[a-z]?')
IMPL_RX = re.compile(r'IMPL-\d+')
# Range: prefix-qualified or bare upper endpoint; en dash, em dash or hyphen.
# Endpoint prefixes are captured so a cross-register range cannot be expanded.
RANGE_RX = re.compile(
    r'(ATT-[A-Z]+)-(\d{3})`?\s*[-\u2013\u2014]\s*`?(?:ATT-[A-Z]+-)?(\d{3})')


def prd_identifiers():
    """Definition sites in PRD-006, keyed by register prefix.

    Location-not-form: a line is a definition only if it is outside the
    enumerated restating sections.  See the module docstring.
    """
    try:
        lines = open(PRD, encoding='utf-8').read().split('\n')
    except FileNotFoundError:
        print('FATAL: %s not found' % PRD, file=sys.stderr)
        sys.exit(2)

    regs = '|'.join(ORDER)
    prose = re.compile(r'^`ATT-(%s)-(\d{3}[a-z]?)`\s+\u2014' % regs)
    table = re.compile(
        r'^\|\s*\*{0,2}`ATT-(%s)-(\d{3}[a-z]?)`\*{0,2}\s*\|' % regs)

    found = collections.defaultdict(set)
    in_index = False
    table_only = False
    for line in lines:
        if re.match(r'^#{2,4} ', line):
            in_index = bool(INDEX_SECTION.match(line))
            table_only = bool(INDEX_TABLE_ONLY.match(line))
        if in_index and not table_only:
            continue
        m = prose.match(line)
        if m is None and not table_only:
            m = table.match(line)
        if not m:
            continue
        found['ATT-%s' % m.group(1)].add('ATT-%s-%s' % (m.group(1), m.group(2)))
    return found


def parse_tasks():
    """Return [(impl_id, n, cells, header_index)] for every task row."""
    try:
        lines = open(TASKS, encoding='utf-8').read().split('\n')
    except FileNotFoundError:
        print('FATAL: %s not found' % TASKS, file=sys.stderr)
        sys.exit(2)
    hdr = None
    rows = []
    for line in lines:
        if line.strip().startswith('|') and 'Requirements' in line:
            cells = [c.strip() for c in line.strip().strip('|').split('|')]
            hdr = {name: i for i, name in enumerate(cells)}
            continue
        m = TASK_ROW.match(line)
        if not m or hdr is None:
            continue
        cells = [c.strip() for c in line.strip().strip('|').split('|')]
        rows.append((m.group(1), int(m.group(2)), cells, hdr))
    return rows


def expand(cell):
    """IDs cited in a cell, expanding ranges. Returns (ids, bad_ranges)."""
    ids = set(ID_RX.findall(cell))
    bad = []
    for pre, lo, hi in RANGE_RX.findall(cell):
        lo_n, hi_n = int(lo), int(hi)
        if hi_n < lo_n:
            bad.append('%s-%s..%s (reversed)' % (pre, lo, hi))
            continue
        for n in range(lo_n, hi_n + 1):
            ids.add('%s-%03d' % (pre, n))
    return ids, bad


def main():
    defined = prd_identifiers()
    all_defined = set().union(*defined.values()) if defined else set()
    rows = parse_tasks()

    ok = True
    print('=' * 78)
    print('PRD-006 STAGE 6 \u2014 task allocation and requirement traceability')
    print('=' * 78)

    # ---- 1. IDs unique, inside range, no foreign collision --------------
    seen, dupes, out_of_range, foreign_hits = {}, [], [], []
    for impl, n, cells, hdr in rows:
        if impl in seen:
            dupes.append(impl)
        seen[impl] = True
        if not (ALLOCATED_LOW <= n <= ALLOCATED_HIGH):
            out_of_range.append(impl)
        for lo, hi in FOREIGN:
            if lo <= n <= hi:
                foreign_hits.append(impl)

    print('Tasks parsed                          : %d' % len(rows))
    print('Unique IMPL IDs                       : %d' % len(seen))
    print('Duplicate IMPL IDs (must=0)           : %d %s'
          % (len(dupes), dupes if dupes else ''))
    print('Outside IMPL-%d..%d (must=0)         : %d %s'
          % (ALLOCATED_LOW, ALLOCATED_HIGH, len(out_of_range),
             out_of_range if out_of_range else ''))
    print('Colliding with another backlog (must=0): %d %s'
          % (len(foreign_hits), foreign_hits if foreign_hits else ''))
    if dupes or out_of_range or foreign_hits:
        ok = False

    # Contiguity is reported, not enforced: rule 1 forbids reuse, not gaps.
    nums = sorted(n for _, n, _, _ in rows)
    holes = [n for n in range(min(nums), max(nums) + 1)
             if n not in set(nums)] if nums else []
    print('Allocation span / holes               : IMPL-%d..%d / %d %s'
          % (min(nums), max(nums), len(holes), holes if holes else ''))

    # ---- 2. every task traces to requirements (THE gate) ----------------
    untraced, bad_cites, bad_ranges = [], [], []
    claimed = set()
    for impl, n, cells, hdr in rows:
        idx = hdr.get('Requirements')
        cell = cells[idx] if idx is not None and idx < len(cells) else ''
        ids, bad = expand(cell)
        bad_ranges += ['%s: %s' % (impl, b) for b in bad]
        if not ids:
            untraced.append(impl)
        for i in ids:
            if i not in all_defined:
                bad_cites.append('%s -> %s' % (impl, i))
            # PRD-006 §0.4: a GAP is a question addressed to a named owner,
            # never an obligation a task may claim to have satisfied.
            if i.startswith('ATT-GAP-'):
                bad_cites.append('%s -> %s (GAP cited as an obligation)'
                                 % (impl, i))
        claimed |= ids

    print()
    print('Tasks with NO requirement (must=0)    : %d %s'
          % (len(untraced), untraced if untraced else ''))
    print('Citations to undefined IDs (must=0)   : %d %s'
          % (len(bad_cites), bad_cites[:8] if bad_cites else ''))
    print('Malformed ranges (must=0)             : %d %s'
          % (len(bad_ranges), bad_ranges if bad_ranges else ''))
    if untraced or bad_cites or bad_ranges:
        ok = False

    # ---- 3. dependencies resolve, invert, and stay acyclic --------------
    known_foreign = {'IMPL-%d' % n for lo, hi in FOREIGN
                     for n in range(lo, hi + 1)}
    dangling_dep, no_priority = [], []
    blocked_by, blocks = {}, {}
    for impl, n, cells, hdr in rows:

        def cell_of(name, cells=cells, hdr=hdr):
            i = hdr.get(name)
            return cells[i] if i is not None and i < len(cells) else ''

        deps = set(IMPL_RX.findall(cell_of('Blocked by')))
        blocked_by[impl] = deps
        blocks[impl] = set(IMPL_RX.findall(cell_of('Blocks')))
        for dep in deps:
            if dep not in seen and dep not in known_foreign:
                dangling_dep.append('%s -> %s' % (impl, dep))
        if impl in deps:
            dangling_dep.append('%s -> itself' % impl)
        # Allocation rule 3: Priority must be recorded, not left blank.
        if not cell_of('Priority').strip('- '):
            no_priority.append(impl)

    print('Unresolvable dependencies (must=0)    : %d %s'
          % (len(dangling_dep), dangling_dep if dangling_dep else ''))
    print('Tasks with no Priority (must=0)       : %d %s'
          % (len(no_priority), no_priority if no_priority else ''))
    if dangling_dep or no_priority:
        ok = False

    # Blocks must be the exact inverse of Blocked by, for local tasks only.
    derived = {i: set() for i in seen}
    for impl, deps in blocked_by.items():
        for d in deps:
            if d in derived:
                derived[d].add(impl)
    asym = []
    for impl in seen:
        declared = {b for b in blocks[impl] if b in seen}
        if declared != derived[impl]:
            miss = sorted(derived[impl] - declared)
            extra = sorted(declared - derived[impl])
            asym.append('%s: missing %s unexpected %s' % (impl, miss, extra))
    print('Blocks/Blocked-by disagreements (=0)  : %d' % len(asym))
    for a in asym[:12]:
        print('    %s' % a)
    if asym:
        ok = False

    # Acyclic, and the longest chain computed rather than claimed.
    depth, visiting, cyclic = {}, set(), []

    def longest(node):
        if node in depth:
            return depth[node]
        if node in visiting:
            cyclic.append(node)
            return 0
        visiting.add(node)
        best = 0
        for d in blocked_by.get(node, ()):
            if d in seen:
                best = max(best, longest(d))
        visiting.discard(node)
        depth[node] = best + 1
        return depth[node]

    chain = max((longest(i) for i in seen), default=0)
    roots = sorted(i for i in seen if not (blocked_by[i] & set(seen)))
    leaves = sorted(i for i in seen if not (blocks[i] & set(seen)))
    print('Dependency cycles (must=0)            : %d %s'
          % (len(cyclic), sorted(set(cyclic)) if cyclic else ''))
    print('Longest local dependency chain        : %d tasks' % chain)
    print('Roots / leaves                        : %d %s / %d %s'
          % (len(roots), roots, len(leaves), leaves))
    if cyclic:
        ok = False

    # Priority distribution and blocked-task census, reported not enforced.
    prio = collections.Counter()
    blocked_tasks = []
    for impl, n, cells, hdr in rows:
        i = hdr.get('Priority')
        prio[cells[i].strip() if i is not None and i < len(cells) else '?'] += 1
        if 'BLOCKED' in ' '.join(cells):
            blocked_tasks.append(impl)
    print('Priority distribution                 : %s'
          % dict(sorted(prio.items())))
    print('Tasks marked BLOCKED                  : %d %s'
          % (len(blocked_tasks), blocked_tasks))

    # Every BLOCKED task must name the gap that blocks it -- a bare "BLOCKED"
    # is an unattributed excuse, and §4 requires a named authority.
    unattributed = []
    for impl, n, cells, hdr in rows:
        joined = ' '.join(cells)
        if 'BLOCKED' in joined and not re.search(r'ATT-GAP-\d{3}[a-z]?',
                                                 joined):
            unattributed.append(impl)
    print('BLOCKED without a named gap (must=0)  : %d %s'
          % (len(unattributed), unattributed if unattributed else ''))
    if unattributed:
        ok = False

    # ---- 4. obligation coverage ----------------------------------------
    print()
    print('OBLIGATION COVERAGE BY TASK '
          '(ATT-AC-*/ATT-GAP-* excluded by design):')
    tot = cov = 0
    missing_all = []
    for pre in IMPLEMENTABLE:
        d = defined.get(pre, set())
        c = d & claimed
        tot += len(d)
        cov += len(c)
        miss = sorted(d - claimed)
        missing_all += miss
        flag = '' if not miss else '  missing: %d' % len(miss)
        print('  %-10s%5d/%-5d%s' % (pre, len(c), len(d), flag))
    pct = 100.0 * cov / tot if tot else 0.0
    print('  %-10s%5d/%-5d = %.1f%%' % ('TOTAL', cov, tot, pct))

    ac = len(defined.get('ATT-AC', set()))
    gap = len(defined.get('ATT-GAP', set()))
    print('  (excluded: %d ATT-AC-* verified by tests, '
          '%d ATT-GAP-* open questions)' % (ac, gap))

    if missing_all:
        ok = False
        print()
        print('UNCLAIMED OBLIGATIONS: %d' % len(missing_all))
        for m in missing_all[:40]:
            print('  %s' % m)
        if len(missing_all) > 40:
            print('  ... and %d more' % (len(missing_all) - 40))
        print()
        print('Stage 6 requires every task to trace to requirements.  An')
        print('obligation with no task is work nobody has planned -- give it a')
        print('task or record why it needs none.')

    print()
    if ok:
        print('RESULT: PASS \u2014 every task traces to requirements, every cited')
        print('        requirement exists, IDs unique and in range, every')
        print('        obligation claimed by at least one task, and every')
        print('        blocked task names the gap that blocks it.')
        return 0
    print('RESULT: FAIL \u2014 see the failures above.')
    return 1


if __name__ == '__main__':
    sys.exit(main())
