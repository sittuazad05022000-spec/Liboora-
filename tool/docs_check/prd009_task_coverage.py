#!/usr/bin/env python3
"""
PRD-009 Analytics & Reports (BC-26) — STAGE-6 TASK-COVERAGE instrument.

WHAT THIS MEASURES
  The Stage-6 gate is BOTH halves of:
    "an IMPL-* range allocated AND a task document in which every task traces
     back to requirements"  (PRD_LIFECYCLE.md, Stage 6)
  plus the four allocation rules. It refuses to pass a task list whose rows do
  not carry a requirement trace.

WHY IT IS SEPARATE
  ADR-0082 requires the mechanical gate be backed by INDEPENDENT instruments.
  This file imports neither prd009_traceability.py nor prd009_stage5.py.

WHAT IT DELIBERATELY DOES *NOT* DO
  It does NOT demand 100% requirement coverage. PRD-009 is a DRAFT with 25 open
  gaps and 13 blocked tasks; a checker demanding full coverage would force
  either invented tasks or a permanent red. It asserts the direction the gate
  actually states: every TASK traces to a requirement.

  It also does NOT accept a BLOCKED task with no named blocker — that is the
  failure mode where "BLOCKED" becomes a way to avoid specifying anything.

EXIT
  0 = Stage-6 gate satisfied.  1 = at least one problem.
"""

import re
import sys
from pathlib import Path

HERE = Path(__file__).resolve()
REPO = HERE.parents[2]

TASKS = REPO / "docs/30-product/analytics/PRD-009_STAGE6_IMPLEMENTATION_TASKS.md"
SUBJECT = REPO / "docs/30-product/analytics/PRD-009_ANALYTICS_AND_REPORTS.md"

LO, HI = 2000, 2031
RESERVE_LO, RESERVE_HI = 2032, 2099

TRACE_RE = re.compile(
    r"ANL-(?:FR|BR|INV|XC|AC|CFG|GAP|OBD)-\d{3}"
    r"|MP-GBR-\d+|X-\d+|AN-\d+|E-\d+|\u00a7\d+"
)

faults = []
facts = []


def bad(m):
    faults.append(m)


def cells_of(line):
    return [c.strip() for c in line.strip().strip("|").split("|")]


def go():
    if not TASKS.exists():
        bad(f"Stage-6 task document missing: {TASKS.name}")
        return done()

    text = TASKS.read_text(encoding="utf-8")
    lines = text.split("\n")

    # ---- gate half 1: a range is allocated ------------------------------
    rows = []
    for ln in lines:
        m = re.match(r"^\|\s*`(IMPL-(\d{4}))`\s*\|", ln)
        if m:
            rows.append((int(m.group(2)), ln))

    if not rows:
        bad("no IMPL-* task rows found — the gate requires a task document, "
            "not a narrative")
        return done()

    nums = sorted(n for n, _ in rows)
    if len(nums) != len(set(nums)):
        dup = sorted({n for n in nums if nums.count(n) > 1})
        bad(f"duplicate task rows: {['IMPL-%d' % d for d in dup]}")

    expected = list(range(LO, HI + 1))
    if nums != expected:
        missing = sorted(set(expected) - set(nums))
        extra = sorted(set(nums) - set(expected))
        if missing:
            bad(f"range not contiguous — missing "
                f"{['IMPL-%d' % m for m in missing]}")
        if extra:
            bad(f"tasks outside the declared range {LO}-{HI}: "
                f"{['IMPL-%d' % e for e in extra]}")
    else:
        facts.append(f"{len(nums)} task rows, IMPL-{LO}-{HI}, contiguous")

    # allocation rule 1 — never reuse a number ALLOCATED elsewhere.
    #
    # "Allocated" is not the same as "mentioned". PRD-009's own lifecycle
    # records legitimately CITE this range as evidence — the Stage-7 readiness
    # record's condition-5 row reads "IMPL-2000...2031, 32 contiguous", and
    # PRD-010's readiness record cites its own IMPL-1900...1929 identically.
    # Citation is the established precedent, not a collision.
    #
    # Measured case: an earlier build of this checker FAILED with
    # "REUSED identifiers: ['IMPL-2000']" the moment the readiness record was
    # written. That was MY instrument being too crude, not a real reuse. So
    # PRD-009's own artefacts are excluded here, while every OTHER document in
    # the repository is still checked for a genuine clash.
    OWN_ARTEFACTS = {
        "PRD-009_STAGE7_FREEZE_READINESS.md",
        "PRD-009_STAGE7_CONFERRAL.md",
        "PRD-009_STAGE5_CONFERRAL.md",
        "PRD-009_ANALYTICS_AND_REPORTS.md",
    }
    used_elsewhere = set()
    for p in list((REPO / "docs").rglob("*.md")) + list((REPO / "tool").rglob("*.py")):
        if p == TASKS or p == HERE or p.name in OWN_ARTEFACTS:
            continue
        try:
            t = p.read_text(encoding="utf-8", errors="replace")
        except OSError:
            continue
        for v in re.findall(r"IMPL-(\d{3,4})", t):
            used_elsewhere.add(int(v))
    clash = sorted(set(nums) & used_elsewhere)
    if clash:
        bad(f"REUSED identifiers — already referenced outside this document: "
            f"{['IMPL-%d' % c for c in clash]}")
    else:
        facts.append(f"0 reused identifiers (vs {len(used_elsewhere)} IMPL-* "
                     f"numbers in use elsewhere)")

    # allocation rule 2 — do not trespass the previous group's reserve
    if any(1930 <= n <= 1999 for n in nums):
        bad("allocation trespasses PRD-010's declared growth reserve "
            "IMPL-1930-1999 (Stage-6 allocation rule 2)")
    else:
        facts.append("PRD-010's IMPL-1930-1999 reserve untouched")

    # ---- gate half 2: every task traces back to requirements ------------
    untraced = []
    for n, ln in rows:
        c = cells_of(ln)
        if len(c) < 4:
            untraced.append(f"IMPL-{n} (row has {len(c)} cells)")
            continue
        if not TRACE_RE.search(c[3]):
            untraced.append(f"IMPL-{n}")
    if untraced:
        bad(f"tasks with no requirement trace: {untraced} — the Stage-6 gate "
            f"requires that EVERY task trace back to requirements")
    else:
        facts.append(f"{len(rows)}/{len(rows)} tasks carry a requirement trace")

    # ---- allocation rule 3 — Priority / Blocks / Blocked by present -----
    for col, name in ((2, "Priority"), (4, "Blocks"), (5, "Blocked by")):
        missing_col = [f"IMPL-{n}" for n, ln in rows
                       if len(cells_of(ln)) <= col or cells_of(ln)[col] == ""]
        if missing_col:
            bad(f"allocation rule 3 — '{name}' empty for {missing_col[:6]}"
                f"{'...' if len(missing_col) > 6 else ''}")
    if not faults:
        facts.append("allocation rule 3 satisfied: Priority / Blocks / "
                     "Blocked by present on every row")

    # ---- a BLOCKED task must name its blocker ---------------------------
    unnamed = []
    blocked = 0
    for n, ln in rows:
        c = cells_of(ln)
        if len(c) < 7:
            continue
        if "BLOCKED" in c[6].upper():
            blocked += 1
            if not re.search(r"ANL-(?:GAP|OBD|CFG)-\d{3}", c[5]):
                unnamed.append(f"IMPL-{n}")
    if unnamed:
        bad(f"BLOCKED tasks that do not name a GAP/OBD/CFG blocker: {unnamed} "
            f"— 'BLOCKED' must not become a way to avoid specifying anything")
    else:
        facts.append(f"{blocked} BLOCKED tasks, each naming a specific blocker")

    # ---- allocation rule 4 — a traceability table exists ----------------
    if not re.search(r"^\|\s*Task group\s*\|", text, re.M | re.I):
        bad("allocation rule 4 — no traceability table mapping task groups "
            "-> requirements -> invariants -> acceptance")
    else:
        facts.append("allocation rule 4 satisfied: task-group traceability "
                     "table present")

    # ---- the reserve must be declared, not implied ----------------------
    if not re.search(r"IMPL-%d" % RESERVE_LO, text) or \
       not re.search(r"%d" % RESERVE_HI, text):
        bad(f"growth reserve IMPL-{RESERVE_LO}-{RESERVE_HI} is not declared")
    else:
        facts.append(f"growth reserve IMPL-{RESERVE_LO}-{RESERVE_HI} declared")

    # ---- Stage 6 must not have silently entered Stage 7/8 ---------------
    if SUBJECT.exists():
        s = SUBJECT.read_text(encoding="utf-8", errors="replace")
        if re.search(r"IMPL-\d{3,4}", s):
            bad("the SUBJECT PRD now contains IMPL-* identifiers — Stage 6 "
                "must not write task ids into the specification")
        else:
            facts.append("subject carries no IMPL-* identifiers")

    return done()


def done():
    print("=" * 78)
    print("PRD-009 STAGE-6 TASK-COVERAGE INSTRUMENT")
    print("=" * 78)
    print(f"declared range   : IMPL-{LO}-{HI}")
    print(f"declared reserve : IMPL-{RESERVE_LO}-{RESERVE_HI}")
    for f in facts:
        print(f"  ok: {f}")
    if faults:
        print(f"\nPROBLEMS: {len(faults)}")
        for f in faults:
            print(f"  - {f}")
        print("\nFAIL")
        return 1
    print("\nStage-6 gate SATISFIED: a range is allocated and every task traces")
    print("back to requirements. This instrument does NOT assert the tasks are")
    print("implemented, nor that requirement coverage is total — several tasks")
    print("are blocked on named governance decisions (count reported above).")
    return 0


if __name__ == "__main__":
    sys.exit(go())
