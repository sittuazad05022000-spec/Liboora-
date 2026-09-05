#!/usr/bin/env python3
"""PRD-015 Search Indexing (BC-23) - Stage 5 registration checker.

Stage 5 gate instrument #2 of 2.

DELIBERATELY INDEPENDENT of prd015_traceability.py. That script classifies
LINES by their own form. This one splits the document into SECTIONS at '## '
and '### ' headings and then reaches the same totals by a different route,
additionally verifying:

  * collision safety in three directions for the SRCH- prefix
  * that the matrix section 2S exists and publishes matching totals
  * that no numbered member exists in either register declared EMPTY
  * that the PRD's own self-published obligation total agrees

Section 2H.2 of the matrix names the failure this pair exists to avoid:
"a checker written in the same pass as the register it checks, by the same
author, verifies agreement with itself."  Two instruments reaching the same
number by different strategies is the evidence.

Exit 0 on success, 1 on any failure.
"""

import os
import re
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
PRD = os.path.join(ROOT, "docs", "30-product", "search", "PRD-015_SEARCH_INDEXING.md")
MATRIX = os.path.join(ROOT, "docs", "40-implementation", "TRACEABILITY_MATRIX.md")

KINDS = ["FR", "BR", "INV", "XC", "AC", "GAP"]
OBLIGATION_KINDS = ["FR", "BR", "INV", "XC"]
EMPTY_KINDS = ["EVT", "CFG"]

# Expected totals are NOT hardcoded as the source of truth; they are the
# PRD's own published figure, re-extracted below and compared.
failures = []


def fail(msg):
    failures.append(msg)


def load(path):
    if not os.path.exists(path):
        fail("missing file: %s" % path)
        return ""
    with open(path, encoding="utf-8") as fh:
        return fh.read()


def split_sections(text):
    """Split at both '## ' and '### ' so a subsection is its own scope."""
    sections = []
    current = ["(preamble)", []]
    for line in text.split("\n"):
        if line.startswith("## ") or line.startswith("### "):
            sections.append(current)
            current = [line.lstrip("#").strip(), []]
        else:
            current[1].append(line)
    sections.append(current)
    return sections


def main():
    text = load(PRD)
    if not text:
        print("PRD-015 stage5: FAIL - subject unreadable")
        return 1

    sections = split_sections(text)

    # ------------------------------------------------------------------
    # Route B: gather every identifier per section, then take the union.
    # A definition is recognised by the identifier being followed by an
    # em-dash anywhere on its line, which is the document's own form.
    # ------------------------------------------------------------------
    per_kind = {k: {} for k in KINDS}
    for name, body in sections:
        for line in body:
            for k in KINDS:
                m = re.match(
                    r"^(?:\*\*)?`SRCH-%s-(\d+)`(?:\*\*)?" % k, line.strip()
                )
                if not m:
                    continue
                # Require the separator, else it is a prose citation.
                if "\u2014" not in line:
                    continue
                per_kind[k].setdefault(int(m.group(1)), set()).add(name)

    # AC is defined with a Verifies parenthetical; recognise it explicitly so
    # this route does not silently under-count.
    for name, body in sections:
        for line in body:
            m = re.match(r"^\*\*`SRCH-AC-(\d+)`\*\*\s*\*\(", line.strip())
            if m:
                per_kind["AC"].setdefault(int(m.group(1)), set()).add(name)

    counts = {k: len(per_kind[k]) for k in KINDS}

    # GAP identifiers are raised inline, mid-sentence, not at line start.
    gaps = sorted({int(m) for m in re.findall(r"\bSRCH-GAP-0*(\d+)\b", text)})
    counts["GAP"] = len(gaps)

    # A restatement (same id, em-dash form, different section) is lawful and
    # is reported rather than failed - see prd015_traceability.check_register.
    restated = {
        "SRCH-%s-%03d" % (k, n): sorted(v)
        for k in KINDS for n, v in per_kind[k].items() if len(v) > 1
    }

    for k in KINDS:
        nums = sorted(per_kind[k]) if k != "GAP" else gaps
        if not nums:
            continue
        if nums != list(range(1, nums[-1] + 1)):
            missing = [n for n in range(1, nums[-1] + 1) if n not in nums]
            fail("SRCH-%s-* not contiguous from 001; missing %s" % (k, missing))

    obligation_total = sum(counts[k] for k in OBLIGATION_KINDS)

    # ------------------------------------------------------------------
    # Registers declared EMPTY must really be empty.
    # ------------------------------------------------------------------
    for k in EMPTY_KINDS:
        hits = re.findall(r"\bSRCH-%s-\d+\b" % k, text)
        if hits:
            fail("SRCH-%s-* declared EMPTY but %d member(s) found" % (k, len(hits)))

    # ------------------------------------------------------------------
    # The PRD publishes its own obligation total in prose. Extract and
    # compare rather than trusting either side.
    # ------------------------------------------------------------------
    self_claim = re.search(
        r"Every one of the (\d+) obligation-bearing identifiers", text
    )
    if not self_claim:
        fail("the PRD no longer publishes its own obligation total in prose")
    else:
        claimed = int(self_claim.group(1))
        if claimed != obligation_total:
            fail(
                "the PRD claims %d obligation-bearing identifiers; this script "
                "measures %d" % (claimed, obligation_total)
            )
        if claimed != counts["AC"]:
            fail(
                "the PRD claims one criterion per obligation (%d) but %d "
                "SRCH-AC-* are defined" % (claimed, counts["AC"])
            )

    # ------------------------------------------------------------------
    # Collision safety, three directions.
    # ------------------------------------------------------------------
    # (1) inward: does another register's prefix collide with SRCH-?
    #     Measured by looking for any X-SRCH- form.
    inward = re.findall(r"[A-Za-z0-9]-SRCH-", text)
    if inward:
        fail("inward prefix collision: %d occurrence(s) of X-SRCH-" % len(inward))
    # (2) reverse: is SRCH- embedded in an ordinary word?
    reverse = [m for m in re.findall(r"(?<=[A-Za-z0-9])SRCH-", text)]
    if reverse:
        fail("reverse hazard: SRCH- embedded in a longer token %d time(s)"
             % len(reverse))
    # (3) bare-number form: SRCH-n without a sub-register would be ambiguous.
    bare = re.findall(r"\bSRCH-\d+\b", text)
    if bare:
        fail("ambiguous bare form SRCH-n found %d time(s)" % len(bare))

    # ------------------------------------------------------------------
    # Matrix registration - the Stage 5 gate itself.
    # ------------------------------------------------------------------
    matrix = load(MATRIX)
    # Anchored heading probe - see the note in prd015_traceability.py. The
    # bare substring "2S." also occurs in the changelog row's own citations,
    # so it survives deletion of the section it is meant to detect.
    if not re.search(r"^## 2S\.", matrix, re.M):
        fail("TRACEABILITY_MATRIX.md has no section 2S heading - the gate is "
             "the registration, not the intention to register")
    else:
        # Scope to the 2S section body - see the note in
        # prd015_traceability.py. A whole-file probe is masked by the
        # changelog row, which names every register in prose.
        m2s = re.search(r"^## 2S\.(.*?)^## ", matrix, re.M | re.S)
        section = m2s.group(1) if m2s else ""
        if not section.strip():
            fail("section 2S is present but empty")
        for k in OBLIGATION_KINDS + ["AC", "GAP"]:
            if "SRCH-%s-*" % k not in section:
                fail("matrix section 2S does not register SRCH-%s-*" % k)
        for k in EMPTY_KINDS:
            if "SRCH-%s-*" % k not in section:
                fail("matrix section 2S does not register SRCH-%s-* as EMPTY" % k)
        if str(obligation_total) not in section:
            fail("matrix section 2S does not publish obligation total %d"
                 % obligation_total)

    # ------------------------------------------------------------------
    print("PRD-015 Search Indexing - Stage 5 registration check (route B)")
    print("  instrument: section-scoped, %d sections parsed" % len(sections))
    for k in OBLIGATION_KINDS:
        print("  SRCH-%-3s : %3d" % (k, counts[k]))
    print("  " + "-" * 22)
    print("  obligation-bearing : %3d" % obligation_total)
    print("  SRCH-AC  : %3d" % counts["AC"])
    print("  SRCH-GAP : %3d" % counts["GAP"])
    for k in EMPTY_KINDS:
        print("  SRCH-%-3s : %3d  (declared EMPTY, verified)" % (k, 0))
    print("  collisions (inward / reverse / bare) : 0 / 0 / 0"
          if not failures else "  collisions: see failures")
    if restated:
        for ident, secs in sorted(restated.items()):
            print("  restated (lawful, disclosed): %s in %s" % (ident, secs))

    if failures:
        print("\nFAIL - %d problem(s):" % len(failures))
        for f in failures:
            print("  * %s" % f)
        return 1

    print("\nPASS - registration complete, zero collisions in three "
          "directions, self-published total agrees, matrix section 2S "
          "registers every register including the two declared EMPTY.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
