#!/usr/bin/env python3
"""PRD-010 Stage-5 entry checker — is the traceability gate actually satisfiable?

Stage 5's gate (`PRD_LIFECYCLE.md` L123-126) is: "the PRD's prefixes registered
in TRACEABILITY_MATRIX.md §2 with counts and ranges, verified mechanically,
**zero collisions**."

`PRD_LIFECYCLE.md` L35-41 makes the lifecycle a sequential chain, and `ADR-0082`
holds that registering Stage 5 over an unmet prior stage "would advance the chain
from its middle". So this checker asserts BOTH:

  A. Stage-4 conferral exists as a committed artefact — not a measurement, an
     actual conferral record (the `PRD-008_STAGE4_CONFERRAL.md` form);
  B. the `NTF-` prefixes are registered in the traceability matrix.

It is EXPECTED TO FAIL while Stage 4 is unconferred. That is the point: a green
Stage-5 instrument over an unconferred Stage 4 would imply a review that does not
exist.

DELIBERATELY INDEPENDENT of `prd010_traceability.py`: this file imports nothing
from it. `ADR-0082` requires "two committed, independent checkers ... neither
imports the other".

Exit 0 = Stage 5 gate satisfiable. Exit 1 = not satisfiable. Nothing is written.
"""

from __future__ import annotations

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
PRD_DIR = ROOT / "docs/30-product/notifications"
MATRIX = ROOT / "docs/40-implementation/TRACEABILITY_MATRIX.md"
LIFECYCLE = ROOT / "docs/00-governance/prd-ecosystem/PRD_LIFECYCLE.md"


def read(path: Path) -> str:
    return path.read_text(encoding="utf-8", errors="replace") if path.exists() else ""


def main() -> int:
    blockers: list[str] = []
    notes: list[str] = []

    # --- A. Stage-4 conferral must exist as an artefact ---------------------
    # A conferral is a governance ACT recorded in its own file, in the form
    # PRD-008 used. A gate matrix inside a review record is a MEASUREMENT and
    # is explicitly not a conferral.
    conferral_files = sorted(PRD_DIR.glob("*STAGE4_CONFERRAL*.md"))
    if not conferral_files:
        blockers.append(
            "Stage-4 CONFERRAL artefact absent: no *STAGE4_CONFERRAL*.md in "
            f"{PRD_DIR.relative_to(ROOT).as_posix()} "
            "(PRD_LIFECYCLE.md L278 assigns Stage 4 to the Requirements Reviewer; "
            "a measured gate matrix is not a conferral)"
        )
    else:
        body = read(conferral_files[0])
        if not re.search(r"CONFERRED", body):
            blockers.append(
                f"{conferral_files[0].name} exists but does not record a CONFERRED verdict"
            )
        else:
            notes.append(f"Stage-4 conferral artefact found: {conferral_files[0].name}")

    # --- B. NTF- prefixes registered in the matrix -------------------------
    matrix = read(MATRIX)
    if not matrix:
        blockers.append(f"{MATRIX.relative_to(ROOT).as_posix()} not found")
    else:
        ntf_rows = re.findall(r"^\|\s*\**`?NTF-[A-Z]+-", matrix, re.M)
        if not ntf_rows:
            blockers.append(
                "TRACEABILITY_MATRIX.md contains NO NTF-* register rows "
                "(Stage 5 gate: prefixes registered in §2 with counts and ranges)"
            )
        else:
            notes.append(f"matrix NTF-* register rows: {len(ntf_rows)}")

    # --- C. the gate text must still say what we think it says -------------
    life = read(LIFECYCLE)
    if "verified mechanically" not in life:
        blockers.append(
            "PRD_LIFECYCLE.md no longer contains the Stage-5 phrase "
            "'verified mechanically' — this checker's premise must be re-read"
        )

    # --- report ------------------------------------------------------------
    print("PRD-010 Stage-5 entry check")
    print("-" * 60)
    for n in notes:
        print(f"  ok   {n}")
    for b in blockers:
        print(f"  BLOCK {b}")
    print("-" * 60)

    if blockers:
        print(f"NOT SATISFIABLE — {len(blockers)} blocker(s). Stage 5 must NOT be entered.")
        return 1

    print("SATISFIABLE — Stage-4 conferred and NTF-* registered; Stage 5 gate met.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
