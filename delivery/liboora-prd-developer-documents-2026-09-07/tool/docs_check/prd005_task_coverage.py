#!/usr/bin/env python3
"""PRD-005 Stage 6 gate — task/requirement coverage, computed not asserted.

WHY THIS EXISTS
---------------
`PRD_LIFECYCLE.md` Stage 6's gate is *"an `IMPL-*` range allocated and a task
document in which **every task traces back to requirements**."*

That gate has been missed before.  `PRD-004_IMPLEMENTATION_TASKS.md` held 18
tasks while its PRD declared 24 -- six tasks added by a correction pass were
never propagated, so the backlog under-scoped the work and disagreed with its
own declared source of truth (second-review finding `SR-01`, HIGH).  Reading did
not catch it; a count did.

This script is the check for `PRD-005`.  It verifies, mechanically:

1. **Every task traces to requirements** -- the literal Stage 6 gate.  A task
   with an empty Requirements cell fails the run.
2. **Every cited requirement exists** in `PRD-005`.  A task citing
   `MM-FR-999` would otherwise look like coverage while tracing to nothing.
3. **`IMPL-*` IDs are unique** and lie inside the allocated range.  Allocation
   rule 1: a number is never reused or reassigned.
4. **No collision with an existing allocation** -- `IMPL-014`..`073`,
   `100`..`127`, `200`..`226`, `300`..`323` are owned elsewhere.
5. **Obligation coverage** -- which `MM-*` obligations are claimed by at least
   one task, and which are not.  `MM-AC-*` are excluded: an acceptance criterion
   is *verified by* a task's test, not *implemented by* a task.  `MM-GAP-*` are
   excluded: a gap is an open question, not an obligation.
6. **Dependencies resolve** -- every `Blocked by` names a task that exists here
   or an `IMPL-*` owned by another (already registered) backlog.
7. **`Blocks` is the exact inverse of `Blocked by`** for local tasks.  Allocation
   rule 3 requires all three of `Priority`, `Blocks`, `Blocked by`; recording two
   directions of the same edge is only useful if they agree, and by hand they
   drift.  Foreign `IMPL-*` are exempt: another backlog's rows cannot be edited
   from here, so a forward edge into one is recorded in prose, not in `Blocks`.
8. **The graph is acyclic**, and the longest chain is computed rather than
   asserted -- the critical-path claim in the document must be reproducible.

RANGE EXPANSION
---------------
`MM-FR-012`-`MM-FR-018` style ranges are expanded, and a cited range that
contains an identifier `PRD-005` does not define is reported.  Expansion is
deliberately strict: `MM-FR-012`-`018` (short right-hand side) is also handled,
because that shorthand appears in the PRD-004 precedent.

RE-RUN
------
    python3 tool/docs_check/prd005_task_coverage.py

Exit 0 = gate satisfied.  Exit 1 = at least one check failed.
"""

import collections
import re
import sys

PRD = 'docs/30-product/membership-management/PRD-MEMBERSHIP-MANAGEMENT.md'
TASKS = ('docs/40-implementation/membership-management/'
         'PRD-005_IMPLEMENTATION_TASKS.md')

ALLOCATED_LOW, ALLOCATED_HIGH = 400, 499

# Ranges owned by other backlogs -- a hit here is a reuse defect.
FOREIGN = [(14, 73), (100, 127), (200, 226), (300, 323)]

TABLE_DEF = re.compile(r'^\|\s*`(MM-[A-Z]+-\d{3}[a-z]?)`\s*\|')
PROSE_DEF = re.compile(r'^`(MM-[A-Z]+-\d{3}[a-z]?)`\s+\u2014')
RESTATED = re.compile(r'Restated from|definition site', re.I)

TASK_ROW = re.compile(r'^\|\s*`?(IMPL-(\d+))`?\s*\|')
ID_RX = re.compile(r'MM-[A-Z]+-\d{3}[a-z]?')
IMPL_RX = re.compile(r'IMPL-\d+')
# `MM-FR-012`-`MM-FR-018`  or  `MM-FR-012`-`018`  (en/em dash or hyphen)
RANGE_RX = re.compile(
    r'(MM-[A-Z]+)-(\d{3})[a-z]?`?\s*[-\u2013\u2014]\s*`?(?:MM-[A-Z]+-)?(\d{3})')


def prd_identifiers():
    """Definition sites in PRD-005, keyed by register prefix."""
    lines = open(PRD, encoding='utf-8').read().split('\n')
    body = next((i for i, l in enumerate(lines) if l.startswith('## 1.')), 0)
    found, seen = collections.defaultdict(set), set()
    for line in lines[body:]:
        m = TABLE_DEF.match(line) or PROSE_DEF.match(line)
        if not m:
            continue
        ident = m.group(1)
        if ident in seen or RESTATED.search(line):
            continue
        seen.add(ident)
        found[ident.rsplit('-', 1)[0]].add(ident)
    # Closed-but-retained gap numbers (see prd005_traceability.py fact 1).
    found['MM-GAP'] |= {'MM-GAP-006', 'MM-GAP-007'}
    return found


def parse_tasks():
    """Return [(impl_id, n, cells)] for every task row."""
    try:
        lines = open(TASKS, encoding='utf-8').read().split('\n')
    except FileNotFoundError:
        print(f'FATAL: {TASKS} not found', file=sys.stderr)
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


def expand(cell, defined_by_prefix):
    """IDs cited in a cell, expanding ranges. Returns (ids, bad_ranges)."""
    ids = set(ID_RX.findall(cell))
    bad = []
    for pre, lo, hi in RANGE_RX.findall(cell):
        lo_n, hi_n = int(lo), int(hi)
        if hi_n < lo_n:
            bad.append(f'{pre}-{lo}..{hi} (reversed)')
            continue
        for n in range(lo_n, hi_n + 1):
            cand = f'{pre}-{n:03d}'
            ids.add(cand)
    return ids, bad


def main():
    defined = prd_identifiers()
    all_defined = set().union(*defined.values())
    rows = parse_tasks()

    ok = True
    print('=' * 78)
    print('PRD-005 STAGE 6 — task allocation and requirement traceability')
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

    print(f'Tasks parsed                          : {len(rows)}')
    print(f'Unique IMPL IDs                       : {len(seen)}')
    print(f'Duplicate IMPL IDs (must=0)           : {len(dupes)} '
          f'{dupes if dupes else ""}')
    print(f'Outside IMPL-{ALLOCATED_LOW}..{ALLOCATED_HIGH} (must=0)       '
          f'    : {len(out_of_range)} {out_of_range if out_of_range else ""}')
    print(f'Colliding with another backlog (must=0): {len(foreign_hits)} '
          f'{foreign_hits if foreign_hits else ""}')
    if dupes or out_of_range or foreign_hits:
        ok = False

    # ---- 2. every task traces to requirements (THE gate) ----------------
    untraced, bad_cites, bad_ranges = [], [], []
    claimed = set()
    for impl, n, cells, hdr in rows:
        idx = hdr.get('Requirements')
        cell = cells[idx] if idx is not None and idx < len(cells) else ''
        ids, bad = expand(cell, defined)
        bad_ranges += [f'{impl}: {b}' for b in bad]
        if not ids:
            untraced.append(impl)
        for i in ids:
            if i not in all_defined:
                bad_cites.append(f'{impl} -> {i}')
        claimed |= ids

    print()
    print(f'Tasks with NO requirement (must=0)    : {len(untraced)} '
          f'{untraced if untraced else ""}')
    print(f'Citations to undefined IDs (must=0)   : {len(bad_cites)} '
          f'{bad_cites[:8] if bad_cites else ""}')
    print(f'Malformed ranges (must=0)             : {len(bad_ranges)} '
          f'{bad_ranges if bad_ranges else ""}')
    if untraced or bad_cites or bad_ranges:
        ok = False

    # ---- 3. dependencies resolve, invert, and stay acyclic --------------
    known_foreign = {f'IMPL-{n}' for lo, hi in FOREIGN
                     for n in range(lo, hi + 1)}
    dangling_dep, no_priority = [], []
    blocked_by, blocks = {}, {}
    for impl, n, cells, hdr in rows:

        def cell_of(name):
            i = hdr.get(name)
            return cells[i] if i is not None and i < len(cells) else ''

        deps = set(IMPL_RX.findall(cell_of('Blocked by')))
        blocked_by[impl] = deps
        blocks[impl] = set(IMPL_RX.findall(cell_of('Blocks')))
        for dep in deps:
            if dep not in seen and dep not in known_foreign:
                dangling_dep.append(f'{impl} -> {dep}')
        # Allocation rule 3: Priority must be recorded, not left blank.
        if not cell_of('Priority').strip('- '):
            no_priority.append(impl)

    print(f'Unresolvable dependencies (must=0)    : {len(dangling_dep)} '
          f'{dangling_dep if dangling_dep else ""}')
    print(f'Tasks with no Priority (must=0)       : {len(no_priority)} '
          f'{no_priority if no_priority else ""}')
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
            asym.append(f'{impl}: missing {miss} unexpected {extra}')
    print(f'Blocks/Blocked-by disagreements (=0)  : {len(asym)}')
    for a in asym[:12]:
        print(f'    {a}')
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
    print(f'Dependency cycles (must=0)            : {len(cyclic)} '
          f'{sorted(set(cyclic)) if cyclic else ""}')
    print(f'Longest local dependency chain        : {chain} tasks')
    if cyclic:
        ok = False

    # ---- 4. obligation coverage ----------------------------------------
    # MM-AC-* are verified by tests, not implemented by tasks.
    # MM-GAP-* are open questions, not obligations.
    IMPLEMENTABLE = ['MM-FR', 'MM-BR', 'MM-INV', 'MM-EVT', 'MM-XC',
                     'MM-NFR', 'MM-PO', 'MM-CFG']
    print()
    print('OBLIGATION COVERAGE BY TASK (MM-AC-*/MM-GAP-* excluded by design):')
    tot = cov = 0
    missing_all = []
    for pre in IMPLEMENTABLE:
        d = defined.get(pre, set())
        c = d & claimed
        tot += len(d)
        cov += len(c)
        miss = sorted(d - claimed)
        missing_all += miss
        flag = '' if not miss else f'  missing: {len(miss)}'
        print(f'  {pre:<8}{len(c):>5}/{len(d):<5}{flag}')
    pct = 100.0 * cov / tot if tot else 0.0
    print(f'  {"TOTAL":<8}{cov:>5}/{tot:<5} = {pct:.1f}%')

    if missing_all:
        ok = False
        print()
        print(f'UNCLAIMED OBLIGATIONS: {len(missing_all)}')
        for m in missing_all[:40]:
            print(f'  {m}')
        if len(missing_all) > 40:
            print(f'  ... and {len(missing_all) - 40} more')
        print()
        print('Stage 6 requires every task to trace to requirements.  An')
        print('obligation with no task is work nobody has planned -- give it a')
        print('task or record why it needs none.')

    print()
    if ok:
        print('RESULT: PASS — every task traces to requirements, every cited')
        print('        requirement exists, IDs unique and in range, every')
        print('        obligation claimed by at least one task.')
        return 0
    print('RESULT: FAIL — see the failures above.')
    return 1


if __name__ == '__main__':
    sys.exit(main())
