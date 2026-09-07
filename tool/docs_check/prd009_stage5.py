#!/usr/bin/env python3
"""
PRD-009 Analytics & Reports (BC-26) — STAGE-5 ENTRY-CONDITION instrument.

THIS IS NOT THE TRACEABILITY CHECKER.
  prd009_traceability.py measures the REGISTERS (counts, ranges, contiguity,
  matrix agreement). This file measures whether Stage 5 was lawfully ENTERABLE
  and whether forbidden later-stage work was silently performed.

  The two share NO code and NO imports, per ADR-0082's requirement that the
  mechanical gate be backed by *independent* instruments. Two files importing
  one helper are one instrument with two names.

WHAT IT ASSERTS
  1. Stage-3 conferral artefact exists and records a PASS.
  2. Stage-4 conferral artefact exists and records a PASS.
     ADR-0082 L324: registering a later stage over an unmet prior stage
     "would advance the chain from its middle". THIS CHECK IS DESIGNED TO FAIL
     while Stage 3 or Stage 4 is unconferred — that is its purpose, not a bug.
  3. The Stage-3 designation ADR (ADR-0112) exists and is Accepted.
  4. The blockers are still represented as blockers. A Stage-5 pass must not
     be obtainable by quietly deleting F-1/F-2/F-3 or an open decision.
  5. No forbidden Stage-6/Stage-7 work has been performed:
       - no IMPL-* range allocated to PRD-009
       - PRD-009 holds no DOCUMENTATION_BASELINE.md row (that is Stage 7)
       - PRD_REGISTRY.md has not been advanced past its lawful status
  6. The PRD does not claim a stage it has not been conferred.

EXIT
  0 = Stage-5 entry conditions satisfied.  1 = at least one problem.
"""

import re
import sys
from pathlib import Path

BASE = Path(__file__).resolve().parents[2]

SUBJECT = BASE / "docs/30-product/analytics/PRD-009_ANALYTICS_AND_REPORTS.md"
S3_ALIGN = BASE / "docs/30-product/analytics/PRD-009_STAGE3_ARCHITECTURE_ALIGNMENT.md"
S3_CONF = BASE / "docs/30-product/analytics/PRD-009_STAGE3_CONFERRAL.md"
S4_CONF = BASE / "docs/30-product/analytics/PRD-009_STAGE4_CONFERRAL.md"
ADR_DIR = BASE / "docs/00-governance/adr"
BASELINE = BASE / "docs/00-governance/DOCUMENTATION_BASELINE.md"
REGISTRY = BASE / "docs/00-governance/prd-ecosystem/PRD_REGISTRY.md"

# Blockers that MUST remain represented. Deleting one must not yield a pass.
REQUIRED_BLOCKERS = [
    "F-1", "F-2", "F-3",
    "AttendanceCorrected",
    "ANL-AL-B1",
    "ANL-OBD-002", "ANL-OBD-004", "ANL-OBD-008", "ANL-OBD-009",
    "ANL-CFG-003", "ANL-CFG-005", "ANL-CFG-006",
]

# Rank-1 / Rank-4 constraints that make those blockers real rather than stylistic
REQUIRED_AUTHORITIES = ["MP-GBR-36", "MP-GBR-37", "MP-GBR-21", "AN-2", "AN-3"]

issues = []
observed = []


def bad(m):
    issues.append(m)


def read(p):
    return p.read_text(encoding="utf-8", errors="replace") if p.exists() else None


def run():
    subj = read(SUBJECT)
    if subj is None:
        bad(f"subject missing: {SUBJECT}")
        return out()

    # ---- 1 / 2 / 3 : prior-stage chain ---------------------------------
    for label, path in (("Stage-3 alignment record", S3_ALIGN),
                        ("Stage-3 conferral", S3_CONF),
                        ("Stage-4 conferral", S4_CONF)):
        if not path.exists():
            bad(f"{label} does not exist ({path.name}) — Stage 5 may not be "
                f"entered over an unmet prior stage (ADR-0082 L324)")

    if issues:
        return out()

    s3 = read(S3_CONF)
    if not re.search(r"STAGE 3 (?:IS )?CONFERRED|PASS \u2014 STAGE 3 CONFERRED", s3):
        bad("Stage-3 conferral does not record a CONFERRED verdict")
    else:
        observed.append("Stage 3: CONFERRED")

    s4 = read(S4_CONF)
    if not re.search(r"STAGE 4 CONFERRED|PASS \u2014 STAGE 4 CONFERRED", s4):
        bad("Stage-4 conferral does not record a CONFERRED verdict")
    else:
        observed.append("Stage 4: CONFERRED")

    # the Stage-4 conferral must be scoped to PRD-009, not borrowed
    if "PRD-009" not in (s4 or ""):
        bad("Stage-4 conferral does not name PRD-009 as its subject")
    if re.search(r"ADR-0112", s4 or "") and "NOT reused" not in (s4 or ""):
        bad("Stage-4 conferral appears to lean on ADR-0112, which is "
            "Stage-3-only (ADR-0033 §7.1: a conferral for one act is not a "
            "standing licence)")

    # ---- 3 : the designation ADR ---------------------------------------
    adr = list(ADR_DIR.glob("ADR-0112-*.md"))
    if not adr:
        bad("ADR-0112 (Architecture-reviewer designation) not found")
    else:
        t = read(adr[0])
        if not re.search(r"^\|\s*\*\*Status\*\*\s*\|\s*\*\*Accepted\*\*", t, re.M):
            bad("ADR-0112 is not Accepted")
        else:
            observed.append("ADR-0112: Accepted")

    # ---- 4 : blockers must still be represented -------------------------
    missing = [b for b in REQUIRED_BLOCKERS if b not in subj]
    if missing:
        bad(f"blockers no longer represented in the subject: {missing} — a "
            f"Stage-5 pass must not be obtainable by deleting a blocker")
    else:
        observed.append(f"all {len(REQUIRED_BLOCKERS)} required blockers present")

    absent_auth = [a for a in REQUIRED_AUTHORITIES if a not in subj]
    if absent_auth:
        bad(f"governing authorities no longer cited: {absent_auth}")

    # the OPEN decisions register must still say 9 and still be open
    if not re.search(r"##\s*48\.\s*Open Decisions\s*\u2014\s*\*\*9\*\*", subj):
        bad("§48 Open Decisions no longer publishes 9 — count changed without "
            "this instrument being updated")

    # ---- 5 : forbidden later-stage work --------------------------------
    if re.search(r"IMPL-[0-9]{3,4}", subj):
        bad("subject allocates IMPL-* identifiers — that is Stage 6, which is "
            "not conferred")

    bl = read(BASELINE)
    if bl and re.search(r"PRD-009_ANALYTICS_AND_REPORTS\.md", bl):
        bad("DOCUMENTATION_BASELINE.md contains a PRD-009 row — baseline "
            "admission is Stage 7, the Governance Owner's act")
    else:
        observed.append("baseline: 0 PRD-009 rows (Stage 7 not performed)")

    reg = read(REGISTRY)
    if reg:
        row = re.search(r"^\|\s*`PRD-009`\s*\|.*$", reg, re.M)
        if row and re.search(r"\bFROZEN\b|\bAPPROVED\b", row.group(0)):
            bad("PRD_REGISTRY.md advances PRD-009 beyond its lawful status "
                "(found FROZEN/APPROVED); Stage 5 confers neither")
        elif row:
            st = re.findall(r"`([A-Z_]+)`", row.group(0))
            observed.append(f"registry status tokens: {st}")

    # ---- 6 : no over-claiming ------------------------------------------
    if re.search(r"Stage\s*7\s*(?:is\s*)?CONFERRED", subj):
        bad("subject claims Stage 7 conferral")
    if re.search(r"Stage\s*6\s*(?:is\s*)?CONFERRED", subj):
        bad("subject claims Stage 6 conferral")
    if re.search(r"\*\*Status\*\*\s*\|\s*\*\*`FROZEN`", subj):
        bad("subject declares itself FROZEN — freeze is conferred, not claimed")

    return out()


def out():
    print("=" * 78)
    print("PRD-009 STAGE-5 ENTRY-CONDITION INSTRUMENT")
    print("=" * 78)
    print("This instrument is DESIGNED TO FAIL while Stage 3 or Stage 4 is")
    print("unconferred, or while a required blocker has been deleted.")
    print()
    for o in observed:
        print(f"  ok: {o}")
    if issues:
        print(f"\nPROBLEMS: {len(issues)}")
        for i in issues:
            print(f"  - {i}")
        print("\nFAIL")
        return 1
    print("\nStage-5 entry conditions SATISFIED.")
    print("Chain order intact; blockers intact; no Stage-6/7 work performed.")
    return 0


if __name__ == "__main__":
    sys.exit(run())
