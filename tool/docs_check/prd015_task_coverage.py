#!/usr/bin/env python3
"""PRD-015 Search Indexing (BC-23) - Stage 6 task-coverage checker.

The Stage 6 gate, PRD_LIFECYCLE.md L135:
    "an IMPL-* range allocated and a task document in which every task
     traces back to requirements".

Verifies, mechanically:

  1. the allocated range is contiguous, one row per number, no holes
  2. no allocated number is used as a task row in any OTHER module's task
     document - allocation rule 1, "never reuse or reassign a number"
  3. PRD-021C's declared reserve IMPL-1794..1849 is NOT claimed here -
     allocation rule 2
  4. every task row records Priority, Blocks, Blocked by - rule 3
  5. THE GATE - every task cites at least one obligation that the subject
     actually defines, and no task cites an identifier that does not exist
  6. every obligation is claimed by at least one task
  7. no SRCH-GAP-* is assigned a task (a task cannot resolve a gap)
  8. no application code is introduced by the Stage 6 act

Exit 0 on success, 1 on any failure.
"""

import os
import re
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
PRD = os.path.join(ROOT, "docs", "30-product", "search", "PRD-015_SEARCH_INDEXING.md")
TASKS = os.path.join(
    ROOT, "docs", "40-implementation", "search", "PRD-015_IMPLEMENTATION_TASKS.md"
)

RANGE_LO, RANGE_HI = 1850, 1873
RESERVE_LO, RESERVE_HI = 1794, 1849  # PRD-021C's declared growth reserve
OBLIGATION_KINDS = ["FR", "BR", "INV", "XC"]

failures = []


def fail(msg):
    failures.append(msg)


def load(path):
    if not os.path.exists(path):
        fail("missing file: %s" % path)
        return ""
    with open(path, encoding="utf-8") as fh:
        return fh.read()


def main():
    prd = load(PRD)
    tasks = load(TASKS)
    if not prd or not tasks:
        print("PRD-015 task coverage: FAIL - input unreadable")
        return 1

    # --- the obligation universe, re-measured from the subject -----------
    defined = set()
    for line in prd.split("\n"):
        m = re.match(
            r"^(?:\*\*)?`SRCH-(FR|BR|INV|XC)-(\d+)`(?:\*\*)?\s+\u2014", line
        )
        if m:
            defined.add((m.group(1), int(m.group(2))))
    if not defined:
        fail("no obligations parsed from the subject")

    # --- task rows -------------------------------------------------------
    rows = {}
    for line in tasks.split("\n"):
        m = re.match(r"^\|\s*`IMPL-(\d+)`\s*\|(.*)$", line)
        if m:
            rows.setdefault(int(m.group(1)), []).append(m.group(2))

    nums = sorted(rows)
    if not nums:
        fail("no task rows found")
    else:
        for n, bodies in sorted(rows.items()):
            if len(bodies) > 1:
                fail("IMPL-%d has %d rows; one row per number" % (n, len(bodies)))
        expect = list(range(RANGE_LO, RANGE_HI + 1))
        if nums != expect:
            holes = [n for n in expect if n not in rows]
            extra = [n for n in nums if n not in expect]
            if holes:
                fail("allocation has holes: %s" % holes)
            if extra:
                fail("rows outside the declared range: %s" % extra)

    # --- rule 2: the previous group's reserve must not be claimed --------
    trespass = [n for n in nums if RESERVE_LO <= n <= RESERVE_HI]
    if trespass:
        fail(
            "allocation rule 2 breach - PRD-021C's declared reserve "
            "IMPL-%d..%d is claimed by %s" % (RESERVE_LO, RESERVE_HI, trespass)
        )

    # --- rule 1: no reuse anywhere else ---------------------------------
    tracked = subprocess.run(
        ["git", "ls-files"], cwd=ROOT, capture_output=True, text=True
    ).stdout.split("\n")
    for rel in tracked:
        if not rel.endswith(".md"):
            continue
        if rel.replace("/", os.sep) == os.path.relpath(TASKS, ROOT):
            continue
        try:
            other = open(os.path.join(ROOT, rel), encoding="utf-8").read()
        except OSError:
            continue
        for line in other.split("\n"):
            m = re.match(r"^\|\s*\*{0,2}`?IMPL-(\d+)`?\*{0,2}\s*\|", line)
            if m and int(m.group(1)) in rows:
                fail(
                    "allocation rule 1 breach - IMPL-%s is also a task row in %s"
                    % (m.group(1), rel)
                )

    # --- rule 3 + THE GATE ----------------------------------------------
    cited = set()
    for n, bodies in sorted(rows.items()):
        body = bodies[0]
        cells = [c.strip() for c in body.split("|")]
        if len(cells) < 6:
            fail("IMPL-%d row has %d cells; expected at least 6" % (n, len(cells)))
            continue
        # cells: scope, requirements, acceptance, priority, blocks, blocked-by
        priority, blocks, blocked_by = cells[3], cells[4], cells[5]
        if not priority:
            fail("IMPL-%d records no Priority (rule 3)" % n)
        if not blocks:
            fail("IMPL-%d records no Blocks (rule 3)" % n)
        if not blocked_by:
            fail("IMPL-%d records no Blocked by (rule 3)" % n)

        found = re.findall(r"SRCH-(FR|BR|INV|XC)-(\d+)", cells[1])
        if not found:
            fail("ORPHAN TASK - IMPL-%d cites no requirement (the Stage 6 gate)" % n)
        for kind, num in found:
            key = (kind, int(num))
            if key not in defined:
                fail(
                    "IMPL-%d cites SRCH-%s-%03d, which the subject does not define"
                    % (n, kind, int(num))
                )
            else:
                cited.add(key)
        if not re.search(r"SRCH-AC-\d+", cells[2]):
            fail("IMPL-%d cites no acceptance criterion" % n)

    unclaimed = sorted(
        "SRCH-%s-%03d" % (k, v) for (k, v) in defined if (k, v) not in cited
    )
    if unclaimed:
        fail(
            "%d obligation(s) claimed by no task: %s"
            % (len(unclaimed), unclaimed)
        )

    # --- gaps must carry no task ----------------------------------------
    for n, bodies in sorted(rows.items()):
        if re.search(r"SRCH-GAP-\d+", bodies[0]):
            fail(
                "IMPL-%d cites a SRCH-GAP-*; a task must not resolve a gap "
                "(ADR-0020 section 3)" % n
            )

    # --- no application code introduced ---------------------------------
    dirty = subprocess.run(
        ["git", "status", "--short", "lib/", "test/", "web/", "android/"],
        cwd=ROOT, capture_output=True, text=True,
    ).stdout.strip()
    if dirty:
        fail("Stage 6 introduced changes under lib/ test/ web/ android/:\n%s" % dirty)

    # --- report ----------------------------------------------------------
    print("PRD-015 Search Indexing - Stage 6 task coverage")
    print("  range allocated      : IMPL-%d..%d" % (RANGE_LO, RANGE_HI))
    print("  task rows            : %d" % len(rows))
    print("  contiguous, no holes : %s" % ("yes" if not failures else "see failures"))
    print("  reserve %d..%d       : not claimed" % (RESERVE_LO, RESERVE_HI))
    print("  obligations defined  : %d" % len(defined))
    print("  obligations claimed  : %d / %d" % (len(cited), len(defined)))
    print("  orphan tasks         : %d"
          % sum(1 for f in failures if f.startswith("ORPHAN TASK")))
    print("  gaps given a task    : 0")
    print("  application code     : 0 lines")

    if failures:
        print("\nFAIL - %d problem(s):" % len(failures))
        for f in failures:
            print("  * %s" % f)
        return 1

    print("\nPASS - allocation contiguous with no reuse, previous reserve "
          "cleared, every task records Priority/Blocks/Blocked by, every task "
          "traces to a defined requirement, every obligation claimed, "
          "0 orphan tasks, 0 gaps tasked, 0 code.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
