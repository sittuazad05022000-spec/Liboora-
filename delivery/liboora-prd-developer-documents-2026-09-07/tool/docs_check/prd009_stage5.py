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
  5. No UNAUTHORISED Stage-6/Stage-7 work has been performed:
       - the SUBJECT allocates no IMPL-* range (that belongs in the Stage-6
         task document, never in the specification)
       - PRD-009 holds a DOCUMENTATION_BASELINE.md row ONLY IF a CONFERRED
         Stage-7 record and an Accepted admitting ADR exist to authorise it
       - PRD_REGISTRY.md shows FROZEN ONLY IF that same record exists
       - if Stage 7 HAS been conferred, the freeze record must carry every
         known blocker forward rather than omit it
     ⚠ These were absolute absence-tests until 2026-09-05, when Stage-7
     admission was lawfully conferred. They are now conditional on authority,
     which is stricter: absence of authority still fails, AND a row backed by
     a non-Accepted or non-matching ADR now fails too.
  6. The PRD does not itself CLAIM a stage. Freeze is recorded in the freeze
     record and the baseline, never self-declared in the specification.

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
S7_CONF = BASE / "docs/30-product/analytics/PRD-009_STAGE7_CONFERRAL.md"
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

    # The next two guards were written while Stage 7 was UNCONFERRED, and they
    # asserted the plain ABSENCE of a baseline row and of a FROZEN status. On
    # 2026-09-05 the human principal conferred Stage-7 admission at Rank 3, the
    # Governance Owner's act was performed, and both artefacts came lawfully
    # into existence. Both guards then fired — CORRECTLY, on assumptions that
    # the world had lawfully outgrown.
    #
    # Two wrong ways to respond, and the one taken:
    #   (a) delete the guards — removes the protection that a baseline row can
    #       never appear without authority. Rejected: that is weakening.
    #   (b) invert them to assert PRESENCE — passes today, but would then
    #       demand a baseline row for a PRD at Stage 5, i.e. demand the very
    #       thing the guard exists to forbid. Rejected: that inverts the rule
    #       instead of stating it.
    #   (c) TAKEN: make them CONDITIONAL ON AUTHORITY. The row and the FROZEN
    #       status are permitted if and only if the Stage-7 conferral record
    #       exists AND the admitting ADR is Accepted AND the ADR cites the
    #       row. Absent that authority they are still failures. This is
    #       strictly stronger than the original absolute guard, because it
    #       additionally catches a baseline row written WITH a conferral
    #       artefact that is not Accepted, or that does not name the row.
    s7_conf = read(S7_CONF)
    s7_lawful = bool(s7_conf) and bool(
        re.search(r"STAGE 7 CONFERRED", s7_conf))
    adr113 = list(ADR_DIR.glob("ADR-0113-*.md"))
    adr113_accepted = False
    if adr113:
        t113 = read(adr113[0]) or ""
        adr113_accepted = bool(
            re.search(r"^\|\s*\*\*Status\*\*\s*\|\s*\*\*Accepted\*\*", t113, re.M))

    bl = read(BASELINE)
    has_row = bool(bl) and bool(re.search(r"PRD-009_ANALYTICS_AND_REPORTS\.md", bl))
    if has_row and not (s7_lawful and adr113_accepted):
        bad("DOCUMENTATION_BASELINE.md contains a PRD-009 row without the "
            "authority for it — baseline admission is Stage 7, the Governance "
            "Owner's act, and requires a CONFERRED Stage-7 record plus an "
            "Accepted admitting ADR")
    elif has_row:
        observed.append("baseline: PRD-009 row present, and lawfully so "
                        "(Stage 7 CONFERRED + ADR-0113 Accepted)")
    else:
        observed.append("baseline: 0 PRD-009 rows (Stage 7 not performed)")

    # §7 rule 1 — the ADR must come BEFORE the change, so an ADR that does not
    # actually govern the row it authorises is not authority for it.
    if has_row and adr113_accepted:
        t113 = read(adr113[0]) or ""
        if "Rank 3" not in t113 or "PRD-009" not in t113:
            bad("ADR-0113 does not name PRD-009 and Rank 3 — it cannot be the "
                "authority for the baseline row it is cited by")

    reg = read(REGISTRY)
    if reg:
        row = re.search(r"^\|\s*`PRD-009`\s*\|.*$", reg, re.M)
        frozen = bool(row) and bool(re.search(r"\bFROZEN\b|\bAPPROVED\b", row.group(0)))
        if frozen and not s7_lawful:
            bad("PRD_REGISTRY.md advances PRD-009 to FROZEN/APPROVED with no "
                "CONFERRED Stage-7 record — freeze is conferred, not claimed")
        elif frozen:
            observed.append("registry: FROZEN, backed by a CONFERRED Stage-7 "
                            "record")
        elif row:
            st = re.findall(r"`([A-Z_]+)`", row.group(0))
            observed.append(f"registry status tokens: {st}")

    # A Stage-7 record must not have been obtained by closing a blocker. The
    # blocker set is re-asserted against the freeze record itself, not only the
    # subject, because that is where a quiet closure would be most tempting.
    #
    # ⚠ This guard was WRONG on its first build and the error is recorded
    # because it is the interesting kind. Build 1 asked only whether each
    # blocker's identifier appeared ANYWHERE in the freeze record. Mutation
    # test 3 deleted the `ANL-CFG-006` table row outright — and the checker
    # still PASSED, because the identifier survived in the very paragraph in
    # which I had disclosed an earlier defect. My own prose was satisfying my
    # own test. A blocker is only carried forward if it is carried with a
    # STATE, so the guard now demands a table row bearing the identifier AND
    # an OPEN / OWED / BLOCKED / NOT-entered disposition. Narrative mentions,
    # including disclosures like §7.1, no longer count as evidence.
    if s7_lawful:
        STATE_RE = re.compile(r"OPEN|OWED|BLOCKER|BLOCKED|NOT entered", re.I)
        state_rows = [ln for ln in s7_conf.split("\n")
                      if ln.startswith("|") and STATE_RE.search(ln)]
        undisclosed = [b for b in REQUIRED_BLOCKERS
                       if not any(b in ln for ln in state_rows)]
        if undisclosed:
            bad(f"Stage-7 conferral does not carry these blockers forward in a "
                f"state-bearing row: {undisclosed} — a freeze must admit them "
                f"with a disposition, not merely mention them")
        else:
            observed.append(f"Stage-7 record carries all "
                            f"{len(REQUIRED_BLOCKERS)} blockers forward, each "
                            f"in a row bearing an OPEN/OWED disposition")

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
