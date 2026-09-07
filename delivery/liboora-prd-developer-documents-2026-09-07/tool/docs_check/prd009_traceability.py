#!/usr/bin/env python3
"""
PRD-009 Analytics & Reports (BC-26) — TRACEABILITY instrument.

WHAT THIS MEASURES
  The eight ANL-* registers in the PRD itself, and whether the
  TRACEABILITY_MATRIX.md registration AGREES with them.

WHY IT IS WRITTEN THIS WAY
  1. The regex is ANCHORED and PUBLISHED, per the §2K/§2L/§2S/§2T lesson.
     A bare `grep -c 'ANL-'` is UNSAFE here, because the token also occurs in:
       ANL-AL-A1 / -A2 / -B1 / -R1   Stage-3 alignment findings — NOT PRD ids
     Anchoring to the eight published registers excludes them by construction.

  2. Counting an identifier is not the same as counting a DEFINITION.
     PRD-009 mentions each id in up to three distinct roles:
       - the §0 register-declaration row     `| ANL-FR-001 … ANL-FR-058 |`
       - the authoritative definition        `**`ANL-FR-001`** Every analytic …`
       - the §46 traceability specimen       `| ANL-FR-001 | MP-GBR-36 | … |`
     A naive duplicate check reports the specimen rows as redefinitions. This
     was measured during authoring: the first probe reported 4 duplicate FR
     definitions, 3 CFG and 1 OBD — ALL FALSE, being the declaration row, the
     §25.2 cross-reference table and the §46 specimen. The classifier below
     excludes those three roles explicitly rather than tolerating the noise.

  3. It does NOT echo the PRD's own prose claims. Every number is derived from
     the bytes; where the PRD publishes a count, that count is COMPARED, not
     trusted.

EXIT
  0 = all checks pass.  1 = at least one problem (printed).

This instrument does NOT import prd009_stage5.py, and prd009_stage5.py does
not import this one. ADR-0082 requires two independent instruments; two files
that share a helper are one instrument with two names.
"""

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
PRD = ROOT / "docs/30-product/analytics/PRD-009_ANALYTICS_AND_REPORTS.md"
MATRIX = ROOT / "docs/40-implementation/TRACEABILITY_MATRIX.md"

REGISTERS = ["FR", "BR", "INV", "XC", "AC", "CFG", "GAP", "OBD"]

# Published, anchored. Excludes ANL-AL-* by construction.
ID_RE = r"ANL-(?:FR|BR|INV|XC|AC|CFG|GAP|OBD)-[0-9]{3}"

problems = []
notes = []


def fail(msg):
    problems.append(msg)


def main():
    if not PRD.exists():
        fail(f"subject not found: {PRD}")
        return report()
    if not MATRIX.exists():
        fail(f"matrix not found: {MATRIX}")
        return report()

    text = PRD.read_text(encoding="utf-8")
    lines = text.split("\n")

    # ---- locate the roles that are NOT definitions -----------------------
    def section_bounds(start_prefix, end_prefix):
        s = e = None
        for i, l in enumerate(lines, 1):
            if s is None and l.startswith(start_prefix):
                s = i
            elif s is not None and l.startswith(end_prefix):
                e = i
                break
        return s, e

    spec_s, spec_e = section_bounds("## 46.", "## 47.")
    if spec_s is None:
        fail("§46 traceability specimen table not found — cannot classify "
             "definition rows safely, so this check must not pass silently")
        return report()

    # ---- per-register measurement ---------------------------------------
    measured = {}
    for reg in REGISTERS:
        ids = sorted(set(re.findall(r"ANL-%s-[0-9]{3}" % reg, text)))
        n = len(ids)
        if n == 0:
            fail(f"ANL-{reg}-*: zero identifiers found — a declared register "
                 f"must have members or be registered as EMPTY with a reason")
            continue
        nums = [int(i.rsplit("-", 1)[1]) for i in ids]
        lo, hi = min(nums), max(nums)

        if lo != 1:
            fail(f"ANL-{reg}-*: range starts at {lo:03d}, not 001")
        if hi != n:
            missing = sorted(set(range(1, hi + 1)) - set(nums))
            fail(f"ANL-{reg}-*: NOT contiguous — {n} unique ids but max is "
                 f"{hi:03d}; missing {['%03d' % m for m in missing]}. "
                 f"A gap makes the published range false")

        # duplicate DEFINITIONS (not mentions)
        defs = {}
        for i, l in enumerate(lines, 1):
            m = re.match(r"^(?:\*\*`|\| `)(ANL-%s-[0-9]{3})`" % reg, l)
            if not m:
                continue
            if "\u2026" in l:                      # register-declaration row
                continue
            if spec_s <= i <= spec_e:              # §46 specimen = a LINK
                continue
            if re.match(r"^\| `ANL-%s-[0-9]{3}` \| `ANL-" % reg, l):
                continue                           # §25.2 cross-reference row
            # A DEFINITION states an obligation or a description. A sentence
            # that merely ROUTES to an id — e.g. "routed to the Architecture
            # Owner as **`ANL-OBD-008`**. Pending resolution:" — continues a
            # prior sentence and is a CITATION, not a second definition.
            # Measured case: ANL-OBD-008 at L290 (citation, sentence-final)
            # vs L1116 (the §48 authoritative definition row).
            tail = l[m.end():].lstrip("*` ")
            if tail[:1] in (".", ",", ";", ")"):
                continue
            defs.setdefault(m.group(1), []).append(i)
        dups = {k: v for k, v in defs.items() if len(v) > 1}
        if dups:
            fail(f"ANL-{reg}-*: duplicate definitions {dups}")

        measured[reg] = (n, lo, hi)

    if problems:
        return report()

    # ---- structural validity: no malformed ids --------------------------
    malformed = set(re.findall(r"ANL-(?:FR|BR|INV|XC|AC|CFG|GAP|OBD)-[0-9]{1,2}(?![0-9])", text))
    if malformed:
        fail(f"malformed identifiers (not 3-digit): {sorted(malformed)}")

    # ---- ANL-AL-* must NOT be counted as a PRD register -----------------
    al = sorted(set(re.findall(r"ANL-AL-[A-Z][0-9]+", text)))
    if al:
        notes.append(f"ANL-AL-* present and correctly EXCLUDED from the "
                     f"registers by anchoring: {al}")

    # ---- matrix registration must EXIST and AGREE -----------------------
    mtext = MATRIX.read_text(encoding="utf-8")
    if not re.search(r"^## 2[A-Z]\..*`PRD-009`", mtext, re.M):
        fail("TRACEABILITY_MATRIX.md has no §2x section registering PRD-009 — "
             "the Stage-5 gate is prefix registration, so this is the gate")
        return report()

    # the matrix must publish each register's count, and it must match
    for reg, (n, lo, hi) in measured.items():
        row = re.search(
            r"^\|\s*`ANL-%s-\*`\s*\|\s*\*\*(\d+)\*\*\s*\|\s*`(\d{3})`[^`]*`(\d{3})`" % reg,
            mtext, re.M)
        if not row:
            fail(f"matrix: no register row found for ANL-{reg}-* "
                 f"(expected `ANL-{reg}-*` | **N** | `001`–`{hi:03d}`)")
            continue
        m_n, m_lo, m_hi = int(row.group(1)), int(row.group(2)), int(row.group(3))
        if (m_n, m_lo, m_hi) != (n, lo, hi):
            fail(f"matrix DISAGREES with the PRD for ANL-{reg}-*: "
                 f"matrix says {m_n} / {m_lo:03d}-{m_hi:03d}, "
                 f"PRD measures {n} / {lo:03d}-{hi:03d}")

    # ---- collision safety, measured in three directions -----------------
    # 1: does any OTHER product doc declare ANL-* as its own register?
    foreign = []
    for p in (ROOT / "docs/30-product").rglob("*.md"):
        if "PRD-009" in p.name:
            continue
        t = p.read_text(encoding="utf-8", errors="replace")
        if re.search(r"^\|\s*\*\*Identifier prefix\*\*.*ANL-", t, re.M):
            foreign.append(str(p.relative_to(ROOT)))
    if foreign:
        fail(f"ANL-* is declared as an identifier prefix by non-PRD-009 "
             f"documents: {foreign}")

    # 2: cross-register overlap is impossible by construction, but assert it
    allids = {}
    for reg in REGISTERS:
        for i in set(re.findall(r"ANL-%s-[0-9]{3}" % reg, text)):
            if i in allids and allids[i] != reg:
                fail(f"identifier {i} claimed by two registers")
            allids[i] = reg

    # 3: the matrix total must equal the sum of its own published rows
    total = sum(v[0] for v in measured.values())
    mtot = re.search(r"\*\*Total identifiers:\s*(\d+)\.?\*\*", mtext)
    if mtot and int(mtot.group(1)) != total:
        # only compare when the PRD-009 section is the one publishing it
        seg = mtext[mtext.find("`PRD-009`"):]
        m2 = re.search(r"\*\*Total identifiers:\s*(\d+)\.?\*\*", seg)
        if m2 and int(m2.group(1)) != total:
            fail(f"matrix publishes total {m2.group(1)} but registers sum to {total}")

    notes.append("registers: " + " · ".join(
        f"{r} {measured[r][0]} ({measured[r][1]:03d}-{measured[r][2]:03d})"
        for r in REGISTERS))
    notes.append(f"total identifiers = {total}")
    return report()


def report():
    print("=" * 78)
    print("PRD-009 TRACEABILITY INSTRUMENT")
    print("=" * 78)
    print(f"anchored id regex : {ID_RE}")
    for n in notes:
        print(f"  note: {n}")
    if problems:
        print(f"\nPROBLEMS: {len(problems)}")
        for p in problems:
            print(f"  - {p}")
        print("\nFAIL")
        return 1
    print("\nAll traceability checks PASS.")
    print("Registration measured, not trusted: every matrix count was compared")
    print("against the PRD's own bytes. Registration is not resolution — open")
    print("gaps and blockers are unaffected by this instrument.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
