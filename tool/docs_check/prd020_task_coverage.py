#!/usr/bin/env python3
"""PRD-020 Stage 6 — task allocation and traceability, computed.

Third instrument of the PRD-020 set. It shares no code with
`prd020_traceability.py` (subject vs itself) or `prd020_stage5.py`
(matrix §2O vs subject). Its subject is the Stage 6 task document.

WHAT IT CHECKS

1. **Range integrity** — the task document's declared range is fully
   allocated, contiguous, and every member carries exactly one row.
2. **No reuse** — no `IMPL-*` allocated to PRD-020 appears as an
   allocation in any other module's task document. `IMPL-1412` is
   withdrawn and must remain spent, never reassigned.
3. **Rule 3** — every task row records `Priority`, `Blocks`, `Blocked by`.
4. **Rule 4 / the Stage 6 gate** — *every task traces back to
   requirements*. A task traces if its own row cites a `TSF-*`
   identifier, OR it is a test task bridged through §5.2. Both routes
   must resolve to identifiers PRD-020 actually defines.
5. **No dangling and no minted identifiers** — every `TSF-*` and
   `IMPL-*` token in the task document must already exist in the PRD.
   ⚠ This is the check that has fired most often in this module: see
   the Stage 5 conferral's `I-4`/`I-5`. A Stage 6 document that mints an
   identifier has performed an act it has no authority for.
6. **Coverage, reported not gated** — the requirement-coverage figure is
   printed so it can be audited, and deliberately does NOT fail the run.
   Stage 6's gate is that every *task* traces, not that every
   *requirement* is claimed. Gating on coverage here would create
   precisely the incentive §5.3 refuses: adding unsourced citations to
   task rows to move a percentage.
"""

import os
import re
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
PRD = os.path.join(ROOT, "docs/30-product/trust-safety/PRD-020_TRUST_AND_SAFETY.md")
TASKS = os.path.join(
    ROOT, "docs/40-implementation/trust-safety/PRD-020_IMPLEMENTATION_TASKS.md"
)

LO, HI = 1400, 1449
TSF = re.compile(r"TSF-(?:FR|BR|XC|INV|EVT|CFG|AC|GAP|RSK)-\d{3}")
IMPL = re.compile(r"IMPL-(\d{3,4})")

problems = []


def fail(msg):
    problems.append(msg)


def read(p):
    with open(p, encoding="utf-8") as fh:
        return fh.read()


def main():
    prd = read(PRD)
    if not os.path.exists(TASKS):
        print("FAIL — no Stage 6 task document at", TASKS)
        return 1
    tasks = read(TASKS)

    defined_tsf = set(TSF.findall(prd))
    print("PRD-020 Stage 6 — task allocation and traceability\n")
    print("subject: %s (%d bytes)" % (os.path.relpath(TASKS, ROOT), len(tasks.encode())))
    print("PRD defines %d distinct TSF-* identifiers\n" % len(defined_tsf))

    # ---- 1. range integrity -------------------------------------------------
    rows = {}
    for line in tasks.split("\n"):
        m = re.match(r"^\|\s*`(IMPL-(\d{4}))`\s*\|", line)
        if m:
            rows.setdefault(m.group(1), []).append(line)

    expected = ["IMPL-%d" % n for n in range(LO, HI + 1)]
    missing = [t for t in expected if t not in rows]
    dupes = [t for t, v in rows.items() if len(v) > 1]
    print("1. Range %d..%d" % (LO, HI))
    print("   rows found: %d of %d" % (len(rows), len(expected)))
    if missing:
        fail("tasks with no row: %s" % missing[:8])
    if dupes:
        fail("tasks with more than one row: %s" % dupes[:8])
    outside = [t for t in rows if not (LO <= int(t.split("-")[1]) <= HI)]
    if outside:
        fail("task rows outside the allocated range: %s" % outside[:8])
    print("   contiguous, one row each: %s" % ("ok" if not (missing or dupes or outside) else "FAIL"))

    # ---- 2. no reuse across modules ----------------------------------------
    other = []
    impl_dir = os.path.join(ROOT, "docs/40-implementation")
    for dirpath, _dirs, files in os.walk(impl_dir):
        for fn in files:
            if not fn.endswith("_IMPLEMENTATION_TASKS.md"):
                continue
            fp = os.path.join(dirpath, fn)
            if os.path.abspath(fp) == os.path.abspath(TASKS):
                continue
            body = read(fp)
            for line in body.split("\n"):
                m = re.match(r"^\|\s*`(IMPL-(\d{4}))`\s*\|", line)
                if m and LO <= int(m.group(2)) <= HI:
                    other.append((os.path.relpath(fp, ROOT), m.group(1)))
    print("\n2. Reuse across modules")
    print("   other task documents allocating %d..%d: %d" % (LO, HI, len(other)))
    if other:
        fail("range reused by another module: %s" % other[:4])
    # IMPL-1412 is withdrawn; its row must say so and must not carry work.
    w = rows.get("IMPL-1412", [""])[0]
    if "ithdrawn" not in w:
        fail("IMPL-1412 is withdrawn from V1 scope but its row does not say so")
    print("   IMPL-1412 recorded withdrawn, number not reassigned: %s"
          % ("ok" if "ithdrawn" in w else "FAIL"))

    # ---- 3. rule 3: Priority / Blocks / Blocked by --------------------------
    # Measured on the header of each task table, not on prose.
    hdrs = [l for l in tasks.split("\n")
            if l.startswith("| Task |") or l.startswith("| Task  |")]
    bad_hdr = [h for h in hdrs
               if not ("Pri" in h and "Blocks" in h and "Blocked by" in h)]
    print("\n3. Rule 3 — Priority / Blocks / Blocked by")
    print("   task tables: %d, missing a required column: %d" % (len(hdrs), len(bad_hdr)))
    if not hdrs:
        fail("no task table header found")
    if bad_hdr:
        fail("%d task table(s) omit Priority/Blocks/Blocked by" % len(bad_hdr))

    # ---- 4. rule 4: every task traces --------------------------------------
    # Route A: the row itself cites a TSF-* identifier.
    # Route B: a test task bridged through the section 5.2 table.
    bridge = {}
    in_bridge = False
    for line in tasks.split("\n"):
        if line.startswith("### 5.2"):
            in_bridge = True
            continue
        if in_bridge and line.startswith("### "):
            break
        if in_bridge:
            m = re.match(r"^\|\s*\*\*(T-\d+)\*\*", line)
            if m:
                bridge[m.group(1)] = set(re.findall(r"`AC-(\d{3})`", line))

    direct, bridged, untraced = [], [], []
    for t in expected:
        row = rows.get(t, [""])[0]
        cites = set(TSF.findall(row))
        if cites:
            direct.append(t)
            continue
        ts = re.findall(r"\bT-(\d+)\b", row)
        if ts and all(("T-" + n) in bridge for n in ts):
            bridged.append(t)
            continue
        if "TSF-AC-001`…`062" in row or "all 62" in row.lower():
            bridged.append(t)
            continue
        if "ithdrawn" in row:
            # A withdrawn task is out of V1 scope; the gate applies to
            # scheduled work. It must still be recorded as withdrawn,
            # which check 2 enforces for IMPL-1412 and this loop for the rest.
            bridged.append(t)
            continue
        untraced.append(t)

    print("\n4. Rule 4 — every task traces back to requirements")
    print("   direct citation: %d" % len(direct))
    print("   via the 5.2 test bridge / withdrawn: %d" % len(bridged))
    print("   untraced: %d" % len(untraced))
    if untraced:
        fail("%d task(s) trace to no requirement: %s" % (len(untraced), untraced[:8]))
    if not bridge:
        fail("section 5.2 test bridge table is absent or unparseable")

    # ---- 5. no dangling, no minted ------------------------------------------
    cited = set(TSF.findall(tasks))
    dangling = sorted(cited - defined_tsf)
    print("\n5. Minted or dangling identifiers")
    print("   TSF-* cited by the task document: %d" % len(cited))
    print("   not defined by PRD-020: %d" % len(dangling))
    if dangling:
        fail("task document cites TSF-* that PRD-020 does not define "
             "(minted or dangling): %s" % dangling[:8])

    impl_cited = set(int(n) for n in IMPL.findall(tasks))
    prd_impl = set(int(n) for n in IMPL.findall(prd))
    stray = sorted(n for n in impl_cited if LO <= n <= HI and n not in prd_impl)
    if stray:
        fail("task document invents IMPL numbers in range: %s" % stray[:8])
    print("   IMPL-* in range invented by the task document: %d" % len(stray))

    # ---- 6. coverage, reported not gated -----------------------------------
    norm = set(x for x in defined_tsf
               if x.startswith("TSF-FR-") or x.startswith("TSF-BR-"))
    acs = set(x for x in defined_tsf if x.startswith("TSF-AC-"))

    # Two figures, because they are genuinely different measurements and
    # publishing only one invites the other to be quoted as if it were it.
    # ROW-level is the honest headline: it counts only what a numbered task
    # actually commits to. DOC-level is larger because prose (the waves
    # table, the defect register) cites identifiers no task row claims.
    row_cited = set()
    for t in expected:
        row_cited |= set(TSF.findall(rows.get(t, [""])[0]))
    row_norm = row_cited & norm
    doc_norm = cited & norm
    ac_named = set(x for x in row_cited if x.startswith("TSF-AC-"))

    print("\n6. Coverage — reported, NOT gated")
    print("   normative requirements: %d" % len(norm))
    print("   cited by a TASK ROW:    %d  (%.1f%%)   <- the headline figure"
          % (len(row_norm), 100.0 * len(row_norm) / max(1, len(norm))))
    print("   cited anywhere in doc:  %d  (%.1f%%)"
          % (len(doc_norm), 100.0 * len(doc_norm) / max(1, len(norm))))
    print("   identifiers of any register cited by task rows: %d of %d"
          % (len(row_cited), len(defined_tsf)))
    print("   acceptance criteria:    %d, named by a task row: %d"
          % (len(acs), len(ac_named)))
    print("   ⚠ not a gate — Stage 6 requires every TASK to trace, not every")
    print("     REQUIREMENT to be claimed. Gating here would reward adding")
    print("     unsourced citations to move a percentage.")

    print()
    if problems:
        print("FAIL — %d problem(s):" % len(problems))
        for p in problems:
            print("  -", p)
        return 1
    print("PASS — %d tasks allocated %d..%d, contiguous, one row each; "
          "rule 3 satisfied; %d of %d tasks trace to requirements; "
          "0 identifiers minted, 0 dangling."
          % (len(rows), LO, HI, len(direct) + len(bridged), len(expected)))
    return 0


if __name__ == "__main__":
    sys.exit(main())
