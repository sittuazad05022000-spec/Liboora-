#!/usr/bin/env python3
"""PRD-010 register checker — counts and contiguity, measured not asserted.

Stage 5 (`PRD_LIFECYCLE.md` L124-126) requires counts "verified mechanically,
**zero collisions**" and states that "Mechanical means counted by a tool, not by
reading."

This checker measures the `NTF-*` registers in
`docs/30-product/notifications/PRD-010_NOTIFICATIONS_AND_COMMUNICATION.md`:

  1. every register is contiguous from 1 to its maximum (a gap makes a
     published range false — Stage 2 rule 3);
  2. the counts stated in the PRD's own register paragraph match the measured
     counts (a document that miscounts itself is the `GCP-13` defect class);
  3. no identifier collides with another PRD's prefix.

DELIBERATELY INDEPENDENT of `prd010_stage5.py`: this file imports nothing from
it, and neither is a helper for the other. `ADR-0082` requires "two committed,
independent checkers ... neither imports the other".

Exit 0 = PASS. Exit 1 = FAIL. Nothing is written.
"""

from __future__ import annotations

import re
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parents[2]
PRD = REPO / "docs/30-product/notifications/PRD-010_NOTIFICATIONS_AND_COMMUNICATION.md"

# Registers this PRD publishes. `CFG` is included but its contiguity is what
# matters, not its "configurable" count: ADR-0108 withdrew two slots as NOT
# configurable, and a withdrawn slot keeps its identifier (append-only doctrine).
REGISTERS = ("FR", "BR", "INV", "XC", "AC", "GAP", "CFG")


def measure(text: str) -> dict[str, list[int]]:
    out: dict[str, list[int]] = {}
    for reg in REGISTERS:
        found = {int(m) for m in re.findall(rf"NTF-{reg}-(\d{{3}})\b", text)}
        out[reg] = sorted(found)
    return out


def main() -> int:
    if not PRD.exists():
        print(f"FAIL: subject not found: {PRD}")
        return 1

    text = PRD.read_text(encoding="utf-8")
    measured = measure(text)
    failures: list[str] = []

    # --- check 1: contiguity from 1..max -------------------------------------
    for reg, ids in measured.items():
        if not ids:
            failures.append(f"register NTF-{reg}-* is EMPTY")
            continue
        expected = list(range(1, max(ids) + 1))
        if ids != expected:
            missing = sorted(set(expected) - set(ids))
            failures.append(
                f"register NTF-{reg}-* is NOT contiguous: "
                f"{len(ids)} ids, max {max(ids)}, missing {missing}"
            )

    # --- check 2: the PRD's self-stated counts must match measurement --------
    # The register paragraph states each count in bold, e.g. "`NTF-FR-*` (**66**)".
    for reg, ids in measured.items():
        stated = re.search(rf"`NTF-{reg}-\*`\s*\(\*\*(\d+)\**", text)
        if stated is None:
            failures.append(f"NTF-{reg}-* count is not stated in the PRD register paragraph")
            continue
        if int(stated.group(1)) != len(ids):
            failures.append(
                f"NTF-{reg}-* count MISMATCH: PRD states {stated.group(1)}, "
                f"measured {len(ids)}"
            )

    # --- check 3: no cross-PRD prefix collision -----------------------------
    # `NTF-` must not be claimed by any other PRD in docs/30-product/.
    others = []
    for path in (REPO / "docs/30-product").rglob("*.md"):
        if path.resolve() == PRD.resolve():
            continue
        if "notifications" in path.parts:
            continue  # PRD-010's own companion records legitimately cite NTF-*
        body = path.read_text(encoding="utf-8", errors="replace")
        # A collision is a DECLARATION elsewhere, not a citation. Declarations
        # appear as a table row opening with the identifier.
        if re.search(r"^\|\s*\**`?NTF-(?:FR|BR|INV|XC|AC|GAP|CFG)-\d{3}", body, re.M):
            others.append(path.relative_to(REPO).as_posix())
    if others:
        failures.append(f"prefix collision: NTF-* declared outside PRD-010 in {others}")

    # --- report -------------------------------------------------------------
    print("PRD-010 register measurement")
    print("-" * 60)
    for reg, ids in measured.items():
        rng = f"NTF-{reg}-001 … NTF-{reg}-{max(ids):03d}" if ids else "(empty)"
        print(f"  NTF-{reg}-*  count={len(ids):>3}  range={rng}")
    print("-" * 60)

    if failures:
        print(f"FAIL — {len(failures)} problem(s):")
        for f in failures:
            print(f"  - {f}")
        return 1

    print("PASS — all registers contiguous, self-stated counts match, no collisions.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
