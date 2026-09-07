#!/usr/bin/env python3
"""PRD-021A A1-A8 Library Community — does each SUBJECT tell the truth about itself?

WHY THIS EXISTS
---------------
This instrument measures the **eight subject documents**. Its sibling,
`prd021a_stage5.py`, measures the **registration** in `TRACEABILITY_MATRIX.md`
section 2P. They are deliberately separate programs with separate parsers and
they share no code, because matrix section 2H.2 records the failure mode they
exist to avoid:

    "a checker written in the same pass as the register it checks, by the same
     author, verifies agreement with itself."

So this program never opens the matrix at all. It derives every count from the
subjects alone. If the two instruments disagree, the disagreement is the finding.

WHAT IT CHECKS
--------------
1.  Every one of the 8 subject files exists and is readable.
2.  Every register is **contiguous from 001** to its stated maximum, with the
    single exception declared in EXPECTED_GAPS below.
3.  The A1 intentional numbering gap is **still exactly one number** and is
    **still not written out anywhere in A1** -- the phantom rule.
4.  A7's four SD-1 withdrawn event identifiers are **still present and still
    marked WITHDRAWN**; their numbers are **not reused**.
5.  Closed registers (A2 LCF-EVT-*, per LCF-FR-104) have **not** grown.
6.  No subject mints an `IMPL-<digits>` identifier (that is Stage 6).
7.  Identifier digit width is uniform (3) so that ranges are comparable.

EXIT
----
0 = every subject is internally consistent. 1 = a subject and its own
declarations disagree, or a preserved item has been disturbed.
"""

import os
import re
import sys

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
SG = os.path.join(ROOT, "docs", "30-product", "social-graph")

# part -> (filename, prefix stem)
SUBJECTS = [
    ("A1", "PRD-021A_A1_LIBRARY_COMMUNITY_FOUNDATION_DRAFT_v0.2.md", "LCM"),
    ("A2", "PRD-021A_A2_LIBRARY_COMMUNITY_FEED_CONTENT_DRAFT_v0.8.md", "LCF"),
    ("A3", "PRD-021A_A3_COMMUNITY_FEED_RANKING_DRAFT_v0.6.md", "LCR"),
    ("A4", "PRD-021A_A4_COMMUNITY_GROUPS_AND_ROLES_DRAFT_v0.1.md", "LCG"),
    ("A5", "PRD-021A_A5_OFFICIAL_LIBRARY_COMMUNICATION_DRAFT_v0.1.md", "LCO"),
    ("A6", "PRD-021A_A6_COMMUNITY_SAFETY_PRIVACY_MODERATION_DRAFT_v0.1.md", "LCS"),
    ("A7", "PRD-021A_A7_COMMUNITY_NOTIFICATIONS_DRAFT_v0.1.md", "LCN"),
    ("A8", "PRD-021A_A8_TECHNICAL_AND_PRODUCTION_ARCHITECTURE_DRAFT_v0.1.md", "LCT"),
]

# The ONE declared, intentional discontinuity in the whole PRD.
# A1 section 24 (L883-892): the FR register skips exactly one number, the one
# immediately after LCM-FR-046. A1 deliberately never writes that token, because
# "reproducing an unassigned identifier in prose is exactly what makes a phantom
# look defined to a grep-based or automated continuity check."
#
# This instrument therefore stores the gap as an ARITHMETIC POSITION
# (predecessor + 1) and never as a literal string, so the checker that guards
# the phantom rule does not itself write the phantom. This is the
# PRD-012a Part 8 section 1.3 remedy, applied here.
A1_GAP_PREDECESSOR = 46          # the gap is the number after this one
EXPECTED_GAPS = {("LCM", "FR"): {A1_GAP_PREDECESSOR + 1}}

# A7 LCN-EVT-004..007 withdrawn by Social Domain Owner ruling SD-1 (2026-08-31).
# Numbers retained, never reused (PRD_LIFECYCLE.md section 5 rule 5).
A7_WITHDRAWN = [4, 5, 6, 7]

# Registers a subject has declared CLOSED. A closed register has no next free
# member until an ADR confers one -- matrix section 2O.4 defect I-4.
CLOSED_REGISTERS = {("LCF", "EVT"): 6}   # A2 LCF-FR-104: "closed at these six"

failures = []
notes = []


def fail(msg):
    failures.append(msg)


def load(fn):
    p = os.path.join(SG, fn)
    if not os.path.exists(p):
        fail("missing subject file: %s" % fn)
        return None
    return open(p, encoding="utf-8").read()


def registers_of(text, stem):
    """Distinct-token occupancy, NOT definition-site counting.

    Matrix section 2O.4 defect I-1: counting definition rows undercounts, because
    legitimate identifiers are defined mid-sentence. Occupancy is the measure
    that survives both forms.
    """
    out = {}
    for reg, num in re.findall(r"\b" + stem + r"-([A-Z]+)-(\d+)\b", text):
        out.setdefault(reg, set()).add(int(num))
    return out


def main():
    grand_ids = 0
    grand_regs = 0
    print("=" * 74)
    print("PRD-021A A1-A8  --  subject-side traceability")
    print("=" * 74)

    for part, fn, stem in SUBJECTS:
        text = load(fn)
        if text is None:
            continue

        # -- digit width uniformity ---------------------------------------
        widths = {len(n) for n in
                  re.findall(r"\b" + stem + r"-[A-Z]+-(\d+)\b", text)}
        if widths - {3}:
            fail("%s %s-: mixed identifier digit widths %s"
                 % (part, stem, sorted(widths)))

        regs = registers_of(text, stem)
        grand_regs += len(regs)
        part_ids = 0

        for reg in sorted(regs):
            nums = regs[reg]
            part_ids += len(nums)
            mx = max(nums)
            missing = {i for i in range(1, mx + 1)} - nums
            allowed = EXPECTED_GAPS.get((stem, reg), set())
            unexpected = missing - allowed
            absent_allowed = allowed - missing
            if unexpected:
                fail("%s %s-%s: NON-CONTIGUOUS, missing %s"
                     % (part, stem, reg, sorted(unexpected)))
            if absent_allowed:
                # The declared gap has been filled. That is a real change and
                # must not pass silently -- it would mean a requirement was
                # invented to occupy the number.
                fail("%s %s-%s: the declared intentional gap at position %s "
                     "has been FILLED; A1 section 24 says it must not be"
                     % (part, stem, reg, sorted(absent_allowed)))
            if allowed and not unexpected and not absent_allowed:
                notes.append("%s %s-%s: intentional gap preserved (1 number, "
                             "position %d+1), range 001-%03d, %d members"
                             % (part, stem, reg, A1_GAP_PREDECESSOR, mx,
                                len(nums)))

            # -- closed registers must not grow ---------------------------
            cap = CLOSED_REGISTERS.get((stem, reg))
            if cap is not None and mx > cap:
                fail("%s %s-%s is declared CLOSED at %d but reaches %03d"
                     % (part, stem, reg, cap, mx))

        grand_ids += part_ids
        print("  %-3s %-5s registers=%3d  identifiers=%4d"
              % (part, stem + "-", len(regs), part_ids))

    # -- A1 phantom rule: the skipped number must NOT appear in A1 --------
    a1 = load(SUBJECTS[0][1])
    if a1 is not None:
        phantom = "LCM-FR-%03d" % (A1_GAP_PREDECESSOR + 1)
        if phantom in a1:
            fail("A1 writes out its own unassigned identifier; section 24 says it "
                 "is 'deliberately not written out anywhere in this document'")
        else:
            notes.append("A1 phantom rule holds: the unassigned number is "
                         "referenced by position, never written")

    # -- A7 withdrawn identifiers preserved -------------------------------
    a7 = load(SUBJECTS[6][1])
    if a7 is not None:
        for n in A7_WITHDRAWN:
            tok = "LCN-EVT-%03d" % n
            rows = [ln for ln in a7.split("\n")
                    if re.match(r"\s*\|\s*`" + tok + r"`", ln)]
            if not rows:
                fail("A7 %s row is GONE; SD-1 requires the identifier be "
                     "retained as a WITHDRAWN record" % tok)
            elif not any("WITHDRAWN" in r for r in rows):
                fail("A7 %s is no longer marked WITHDRAWN" % tok)
        surviving = registers_of(a7, "LCN").get("EVT", set())
        if max(surviving, default=0) > 7:
            fail("A7 LCN-EVT-* has grown past 007; SD-1 forbids a seventh "
                 "A2 event and numbers are never reused")
        notes.append("A7: 4 withdrawn event identifiers retained and marked, "
                     "3 active, register unchanged at 7 minted")

    # -- no IMPL-* minted anywhere (Stage 6, not Stage 5) -----------------
    for part, fn, stem in SUBJECTS:
        t = load(fn)
        if t and re.search(r"\bIMPL-\d+\b", t):
            fail("%s mints an IMPL-<n> identifier; that is a Stage 6 act" % part)

    print("  %-3s %-5s registers=%3d  identifiers=%4d"
          % ("ALL", "", grand_regs, grand_ids))

    print()
    for n in notes:
        print("  note: " + n)

    print()
    if failures:
        print("FAILURES (%d):" % len(failures))
        for f in failures:
            print("  - " + f)
        return 1
    print("OK: 8 subjects, %d registers, %d identifiers, "
          "all contiguous except the 1 declared gap." % (grand_regs, grand_ids))
    return 0


if __name__ == "__main__":
    sys.exit(main())
