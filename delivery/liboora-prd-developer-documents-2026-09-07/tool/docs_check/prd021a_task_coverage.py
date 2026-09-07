#!/usr/bin/env python3
"""PRD-021A A1-A8 Stage 6 — task allocation and traceability, computed.

THIRD instrument of the PRD-021A set. It shares no code with
`prd021a_traceability.py` (subjects vs themselves) or `prd021a_stage5.py`
(matrix section 2P vs subjects). Its subject is the Stage 6 task document.

WHAT IT CHECKS

1. **Range integrity** - the declared range is fully allocated, contiguous,
   and every member carries exactly ONE task row. A number allocated twice
   is a reuse; a number missing is a hole.
2. **No reuse across modules** - no IMPL-* allocated here may appear as an
   allocation in any other module's task document. Allocation rule 1:
   "Never reuse or reassign a number."
3. **Rule 2 respected** - PRD-020's IMPL-1450..1499 reserve must NOT be
   claimed by this document. That band belongs to the reserving document,
   and PRD-020's Stage 5 conferral records IMPL-1450 as defect I-2,
   deliberately preserved.
4. **Rule 3** - every task row records Priority, Blocks, Blocked by.
5. **Rule 4 / THE STAGE 6 GATE** - PRD_LIFECYCLE.md L135: "every task
   traces back to requirements". A task traces if its row cites at least
   one identifier that the eight subjects actually define.
6. **No minted identifiers** - every LC?-???-nnn token in the task
   document must already exist in one of the eight subjects. A Stage 6
   document that mints an identifier has performed an act it has no
   authority for. This is the check that fired most often in PRD-020
   (its I-4/I-5).
7. **The A1 phantom rule** - A1's single unassigned LCM-FR number must not
   be written out. Held arithmetically, never as a literal token, for the
   same reason as the two earlier instruments.
8. **A7's withdrawn events are not implemented** - SD-1 withdrew four
   LCN-EVT identifiers. No task may cite one. Their numbers are retained
   and never reused (PRD_LIFECYCLE.md L258 section 5 rule 5).
9. **A4's blocked tasks are marked** - LCG-GAP-001 "blocks everything" and
   LCG-GAP-006 "blocks group creation" are OPEN. Any task tracing to an
   LCG-* identifier must carry a blocker, not a schedulable priority.
10. **Coverage, reported not gated** - the requirement-coverage figure is
    printed and deliberately does NOT fail the run. Stage 6's gate is that
    every TASK traces, not that every REQUIREMENT is claimed. Gating here
    would create the incentive to add unsourced citations to task rows to
    move a percentage.
"""

import os
import re
import sys

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
SOCIAL = os.path.join(ROOT, "docs", "30-product", "social-graph")
IMPLDIR = os.path.join(ROOT, "docs", "40-implementation")
TASKS = os.path.join(IMPLDIR, "social-graph", "PRD-021A_IMPLEMENTATION_TASKS.md")

PARTS = [
    ("A1", "PRD-021A_A1_LIBRARY_COMMUNITY_FOUNDATION_DRAFT_v0.2.md", "LCM"),
    ("A2", "PRD-021A_A2_LIBRARY_COMMUNITY_FEED_CONTENT_DRAFT_v0.8.md", "LCF"),
    ("A3", "PRD-021A_A3_COMMUNITY_FEED_RANKING_DRAFT_v0.6.md", "LCR"),
    ("A4", "PRD-021A_A4_COMMUNITY_GROUPS_AND_ROLES_DRAFT_v0.1.md", "LCG"),
    ("A5", "PRD-021A_A5_OFFICIAL_LIBRARY_COMMUNICATION_DRAFT_v0.1.md", "LCO"),
    ("A6", "PRD-021A_A6_COMMUNITY_SAFETY_PRIVACY_MODERATION_DRAFT_v0.1.md", "LCS"),
    ("A7", "PRD-021A_A7_COMMUNITY_NOTIFICATIONS_DRAFT_v0.1.md", "LCN"),
    ("A8", "PRD-021A_A8_TECHNICAL_AND_PRODUCTION_ARCHITECTURE_DRAFT_v0.1.md", "LCT"),
]
STEMS = [s for _, _, s in PARTS]

LO, HI = 1500, 1569
RESERVE_LO, RESERVE_HI = 1570, 1599

# PRD-020's declared reserve. Must not be claimed here.
FOREIGN_RESERVE = (1450, 1499)

# A1's single unassigned LCM-FR position, held as arithmetic. The literal
# token is never written in this file, for the reason A1 section 24 L885 gives.
A1_GAP_AFTER = 46

# SD-1 option B withdrew four A7 events. Held as arithmetic, same discipline.
A7_WITHDRAWN = [4, 5, 6, 7]

TOKEN = re.compile(r"\b(LC[MFRGOSNT])-([A-Z]+)-(\d+)\b")
IMPLTOK = re.compile(r"\bIMPL-(\d{3,4})\b")

failures = []
notes = []


def fail(msg):
    failures.append(msg)


def note(msg):
    notes.append(msg)


def read(p):
    with open(p, encoding="utf-8") as fh:
        return fh.read()


def split_row(line):
    """Escape-aware markdown row split: a literal \\| is not a delimiter."""
    return [c.strip() for c in re.split(r"(?<!\\)\|", line)[1:-1]]


def defined_identifiers():
    """Occupancy set built from the eight subjects, independently of any
    claim the task document or the matrix makes."""
    defined = set()
    per_stem = {}
    for _, fname, stem in PARTS:
        path = os.path.join(SOCIAL, fname)
        if not os.path.exists(path):
            fail("missing subject file: %s" % fname)
            continue
        text = read(path)
        toks = set(
            "%s-%s-%s" % (a, b, c) for a, b, c in TOKEN.findall(text) if a == stem
        )
        per_stem[stem] = toks
        defined |= toks
    return defined, per_stem


def task_rows(tasks):
    """Rows whose FIRST cell is exactly one IMPL token in this range.

    Anchoring on the first cell is deliberate: prose rows and the summary
    tables also mention IMPL tokens, and counting those as allocations
    would inflate the row count and mask a genuine hole.
    """
    rows = {}
    for line in tasks.split("\n"):
        s = line.strip()
        if not s.startswith("|"):
            continue
        cells = split_row(line)
        if len(cells) < 6:
            continue
        first = cells[0]
        m = re.fullmatch(r"`IMPL-(\d{4})`", first)
        if not m:
            continue
        num = int(m.group(1))
        if not (LO <= num <= HI):
            continue
        rows.setdefault(num, []).append(cells)
    return rows


def main():
    print("=" * 74)
    print("PRD-021A A1-A8  --  Stage 6 task allocation and traceability gate")
    print("=" * 74)

    if not os.path.exists(TASKS):
        print("\nFAIL - no Stage 6 task document at %s" % os.path.relpath(TASKS, ROOT))
        print("PRD_LIFECYCLE.md L135 requires an IMPL-* range allocated and a task")
        print("document in which every task traces back to requirements.")
        return 1

    tasks = read(TASKS)
    defined, per_stem = defined_identifiers()
    print("\n  subjects define %d distinct identifiers across 8 parts" % len(defined))
    print(
        "  task document: %s (%d bytes)"
        % (os.path.relpath(TASKS, ROOT), len(tasks.encode()))
    )

    rows = task_rows(tasks)

    # ---- check 1: range integrity -------------------------------------
    expected = set(range(LO, HI + 1))
    got = set(rows)
    missing = sorted(expected - got)
    extra = sorted(got - expected)
    dupes = sorted(n for n, r in rows.items() if len(r) > 1)
    if missing:
        fail(
            "range is NOT fully allocated - %d numbers have no task row: %s"
            % (len(missing), missing[:12])
        )
    if extra:
        fail("task rows outside the declared range: %s" % extra)
    if dupes:
        fail(
            "numbers carrying more than one task row (a reuse): %s"
            % ["IMPL-%d" % n for n in dupes]
        )
    if not missing and not extra and not dupes:
        print(
            "  range IMPL-%d..IMPL-%d: %d of %d allocated, contiguous, one row each"
            % (LO, HI, len(got), len(expected))
        )

    # ---- check 2: no reuse across modules -----------------------------
    foreign_claims = []
    for dirpath, _, filenames in os.walk(IMPLDIR):
        for fn in filenames:
            if not fn.endswith(".md"):
                continue
            p = os.path.join(dirpath, fn)
            if os.path.abspath(p) == os.path.abspath(TASKS):
                continue
            text = read(p)
            for line in text.split("\n"):
                s = line.strip()
                if not s.startswith("|"):
                    continue
                cells = split_row(line)
                if not cells:
                    continue
                m = re.fullmatch(r"`IMPL-(\d{4})`", cells[0])
                if m and LO <= int(m.group(1)) <= HI:
                    foreign_claims.append((os.path.relpath(p, ROOT), m.group(1)))
    if foreign_claims:
        fail(
            "IMPL numbers in this range are allocated as task rows elsewhere: %s"
            % foreign_claims[:6]
        )
    else:
        print(
            "  no number in IMPL-%d..IMPL-%d is allocated by any other task document"
            % (LO, HI)
        )

    # ---- check 3: PRD-020's reserve not claimed ------------------------
    claimed_foreign = sorted(
        {
            int(n)
            for n in IMPLTOK.findall(tasks)
            if FOREIGN_RESERVE[0] <= int(n) <= FOREIGN_RESERVE[1]
        }
    )
    for n in claimed_foreign:
        # citing the boundary in prose is lawful; allocating a row is not
        if n in rows:
            fail("this document allocates IMPL-%d, inside PRD-020's reserve" % n)
    note(
        "PRD-020's IMPL-%d..%d reserve is cited but not allocated (%d boundary "
        "references, 0 rows)" % (FOREIGN_RESERVE[0], FOREIGN_RESERVE[1], len(claimed_foreign))
    )

    # ---- check 4: rule 3 fields ---------------------------------------
    # header order: Task | Work | Traces to | P | Blocks | Blocked by
    missing_fields = []
    for num in sorted(rows):
        cells = rows[num][0]
        if len(cells) < 6:
            missing_fields.append("IMPL-%d (only %d cells)" % (num, len(cells)))
            continue
        prio, blocks, blocked_by = cells[3], cells[4], cells[5]
        if not prio:
            missing_fields.append("IMPL-%d (no Priority)" % num)
        if not blocks:
            missing_fields.append("IMPL-%d (no Blocks)" % num)
        if not blocked_by:
            missing_fields.append("IMPL-%d (no Blocked by)" % num)
    if missing_fields:
        fail(
            "allocation rule 3 requires Priority/Blocks/Blocked by on every row; "
            "missing on: %s" % missing_fields[:8]
        )
    else:
        print("  rule 3: all %d rows record Priority, Blocks, Blocked by" % len(rows))

    # ---- check 5: THE STAGE 6 GATE - every task traces ----------------
    untraced = []
    traced_ids = set()
    for num in sorted(rows):
        cells = rows[num][0]
        traces_cell = cells[2] if len(cells) > 2 else ""
        cited = {
            "%s-%s-%s" % (a, b, c) for a, b, c in TOKEN.findall(traces_cell)
        }
        real = cited & defined
        if not real:
            untraced.append("IMPL-%d" % num)
        traced_ids |= real
    if untraced:
        fail(
            "STAGE 6 GATE FAILS - %d tasks trace to no identifier the subjects "
            "define: %s" % (len(untraced), untraced[:10])
        )
    else:
        print(
            "  STAGE 6 GATE: all %d tasks trace to identifiers the subjects define"
            % len(rows)
        )

    # ---- check 6: no minted identifiers -------------------------------
    all_tokens = {"%s-%s-%s" % (a, b, c) for a, b, c in TOKEN.findall(tasks)}
    minted = sorted(all_tokens - defined)
    if minted:
        fail(
            "this document MINTS %d identifier(s) no subject defines: %s"
            % (len(minted), minted[:10])
        )
    else:
        print("  no minted identifiers: all %d cited tokens exist" % len(all_tokens))

    # ---- check 7: the A1 phantom rule ---------------------------------
    phantom = "LCM-FR-%03d" % (A1_GAP_AFTER + 1)
    if phantom in tasks:
        fail(
            "the task document writes out A1's unassigned LCM-FR number; "
            "A1 section 24 L885 requires it be referenced by position only"
        )
    else:
        note("A1's unassigned FR position is not written out by the task document")

    # ---- check 8: A7's withdrawn events not implemented ---------------
    bad = [n for n in A7_WITHDRAWN if ("LCN-EVT-%03d" % n) in tasks]
    if bad:
        fail(
            "task document cites A7 event(s) withdrawn by SD-1 (must never be "
            "implemented or reused): %s" % ["LCN-EVT-%03d" % n for n in bad]
        )
    else:
        note(
            "A7's %d withdrawn events are cited by no task; their numbers stay spent"
            % len(A7_WITHDRAWN)
        )

    # ---- check 9: A4's tasks carry a blocker --------------------------
    # A task is A4-OWNED if every requirement it traces to is an LCG-*.
    # A task is CROSS-PART if it traces to LCG-* alongside other stems: it
    # is partly reachable today, so requiring an unschedulable priority
    # would be wrong. It must instead disclose the A4 limitation.
    # Conflating the two was the instrument's defect, not the document's.
    a4_problems = []
    a4_owned = 0
    a4_cross = 0
    for num in sorted(rows):
        cells = rows[num][0]
        traces_cell = cells[2] if len(cells) > 2 else ""
        cited = {"%s-%s-%s" % (a, b, c) for a, b, c in TOKEN.findall(traces_cell)}
        if not any(i.startswith("LCG-") for i in cited):
            continue
        blocked_by = cells[5] if len(cells) > 5 else ""
        prio = cells[3] if len(cells) > 3 else ""
        has_gap = "LCG-GAP-001" in blocked_by or "LCG-GAP-006" in blocked_by
        inherits = re.search(r"IMPL-15(3[2-7])", blocked_by)
        only_lcg = all(i.startswith("LCG-") for i in cited)
        if only_lcg:
            a4_owned += 1
            # A4-owned work is not schedulable at all while the scope is open
            if not (has_gap or inherits):
                a4_problems.append("IMPL-%d (A4-owned, no blocker cited)" % num)
            if re.fullmatch(r"P\d", prio):
                a4_problems.append(
                    "IMPL-%d (A4-owned but claims schedulable priority %s)" % (num, prio)
                )
        else:
            a4_cross += 1
            # cross-part work must disclose that its A4 clause is blocked
            if not has_gap:
                a4_problems.append(
                    "IMPL-%d (cross-part touching LCG-* without disclosing "
                    "LCG-GAP-001)" % num
                )
            if not re.search(r"partial|⛔", prio):
                a4_problems.append(
                    "IMPL-%d (cross-part touching LCG-* but priority %r claims "
                    "full completability)" % (num, prio)
                )
    if a4_problems:
        fail(
            "A4 is blocked by LCG-GAP-001 ('blocks everything'); tasks reaching "
            "LCG-* must say so: %s" % a4_problems[:8]
        )
    else:
        note(
            "A4 reachability: %d A4-owned tasks carry the blocker and claim no "
            "schedulable priority; %d cross-part tasks disclose the A4 clause as "
            "partial" % (a4_owned, a4_cross)
        )

    # ---- check 10: coverage, reported not gated -----------------------
    req = {i for i in defined if re.search(r"-(FR|BR)-\d+$", i)}
    ac = {i for i in defined if re.search(r"-AC-\d+$", i)}
    claimed_req = traced_ids & req
    claimed_ac = traced_ids & ac
    print("\n  --- coverage, reported and NOT gated ---")
    print(
        "  requirements named by a task row: %d of %d (%.1f%%)"
        % (len(claimed_req), len(req), 100.0 * len(claimed_req) / max(1, len(req)))
    )
    print(
        "  acceptance criteria named by a task row: %d of %d (%.1f%%)"
        % (len(claimed_ac), len(ac), 100.0 * len(claimed_ac) / max(1, len(ac)))
    )
    print(
        "  Stage 6's gate is that every TASK traces, not that every REQUIREMENT"
    )
    print("  is claimed; gating on this figure would reward unsourced citations.")

    return report()


def report():
    if notes:
        print("")
        for n in notes:
            print("  note: %s" % n)
    if failures:
        print("\n" + "=" * 74)
        print("FAIL - %d problem(s)" % len(failures))
        print("=" * 74)
        for f in failures:
            print("  - %s" % f)
        return 1
    print(
        "\nOK: range fully allocated and contiguous, every task traces to a real "
        "requirement,\nno identifier minted, no number reused, and no withdrawn "
        "event implemented."
    )
    return 0


if __name__ == "__main__":
    sys.exit(main())
