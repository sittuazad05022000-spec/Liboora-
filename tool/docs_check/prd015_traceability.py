#!/usr/bin/env python3
"""PRD-015 Search Indexing (BC-23) - traceability checker.

Stage 5 gate instrument #1 of 2.

Counts the SRCH-* identifier registers in the PRD by classifying LINES by their
own form, and verifies:

  * every register is contiguous from 001 to its stated maximum
  * zero duplicate definitions
  * every acceptance criterion cites at least one obligation that EXISTS
  * every obligation is cited by at least one acceptance criterion
  * the two registers declared EMPTY really are empty
  * the TRACEABILITY_MATRIX registration agrees with the PRD

Exit 0 on success, 1 on any failure.

DELIBERATELY INDEPENDENT of prd015_stage5.py: this script classifies *lines*
by form. The other splits the document into *sections* and authorises each
identifier against the scope that may define it. Two instruments reaching the
same totals by different routes is the evidence; one instrument agreeing with
itself is not.
"""

import re
import sys
import os

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
PRD = os.path.join(ROOT, "docs", "30-product", "search", "PRD-015_SEARCH_INDEXING.md")
MATRIX = os.path.join(ROOT, "docs", "40-implementation", "TRACEABILITY_MATRIX.md")

# Registers that carry an obligation (a MUST/MUST NOT).
OBLIGATION_KINDS = ["FR", "BR", "INV", "XC"]
# Registers declared EMPTY, verified as such rather than assumed.
EMPTY_KINDS = ["EVT", "CFG"]
# Non-obligation populated registers.
OTHER_KINDS = ["AC", "GAP"]

failures = []
notes = []


def fail(msg):
    failures.append(msg)


def note(msg):
    notes.append(msg)


def read(path):
    if not os.path.exists(path):
        fail("missing file: %s" % path)
        return []
    with open(path, encoding="utf-8") as fh:
        return fh.read().split("\n")


# ---------------------------------------------------------------------------
# Definition detection.
#
# A DEFINITION line opens with the identifier and separates with an em-dash:
#     `SRCH-FR-004` - BC-23 MUST populate ...
# A CITATION opens with the identifier and continues as prose:
#     `SRCH-FR-004` (events only) and `SRCH-INV-005` ... are operative.
# The em-dash requirement is what separates them. Without it this script
# would count cross-references as definitions - a real defect found during
# the Stage 4 review and recorded in its section 2.2.
# ---------------------------------------------------------------------------
def def_pattern(kind):
    return re.compile(r"^(?:\*\*)?`SRCH-%s-(\d+)`(?:\*\*)?\s+\u2014" % kind)


# Acceptance criteria carry a Verifies parenthetical:
#     **`SRCH-AC-016`** *(`SRCH-FR-016`)* - Given ...
AC_PATTERN = re.compile(r"^\*\*`SRCH-AC-(\d+)`\*\*\s*\*\(([^)]*)\)\*")


def collect_definitions(lines, kind):
    """Return {number: [line_no, ...]} for definitions of one register."""
    pat = def_pattern(kind)
    found = {}
    for idx, line in enumerate(lines, 1):
        m = pat.match(line)
        if m:
            found.setdefault(int(m.group(1)), []).append(idx)
    return found


def check_register(found, label, expect_contiguous=True):
    """Contiguity and duplicate checks for one register.

    An identifier may legitimately appear in em-dash form more than once: the
    canonical DEFINITION, plus a RESTATEMENT in a later topical section. The
    repository already contains that pattern (SRCH-INV-005 is defined in
    section 11 'Index lifecycle' and restated in section 34 'Rebuild and
    recovery'), and PRD-023 does the same with CNF-INV-001..004.

    A restatement is not a register collision, so it does not fail the gate.
    It IS reported by line number, because an undisclosed restatement is
    indistinguishable from an accidental second definition - and because a
    restatement that later DRIFTS from its definition is a real defect this
    output makes visible.
    """
    if not found:
        return 0
    for n, ls in sorted(found.items()):
        if len(ls) > 1:
            note(
                "%s-%03d: 1 definition at line %d, %d restatement(s) at %s"
                % (label, n, ls[0], len(ls) - 1, ls[1:])
            )
    nums = sorted(found)
    top = nums[-1]
    if expect_contiguous and nums != list(range(1, top + 1)):
        missing = [n for n in range(1, top + 1) if n not in found]
        fail("%s is not contiguous from 001 to %03d; missing %s" % (label, top, missing))
    return len(found)


def main():
    lines = read(PRD)
    if not lines:
        print("PRD-015 traceability: FAIL - subject unreadable")
        return 1

    counts = {}

    # --- populated obligation registers ---------------------------------
    definitions = {}
    for kind in OBLIGATION_KINDS:
        found = collect_definitions(lines, kind)
        definitions[kind] = found
        counts[kind] = check_register(found, "SRCH-" + kind)

    obligation_total = sum(counts[k] for k in OBLIGATION_KINDS)

    # --- registers declared EMPTY ---------------------------------------
    # Emptiness is verified against the whole document, not just definition
    # lines: a numbered member appearing anywhere would contradict the claim.
    body = "\n".join(lines)
    for kind in EMPTY_KINDS:
        hits = re.findall(r"\bSRCH-%s-\d+\b" % kind, body)
        counts[kind] = 0
        if hits:
            fail(
                "SRCH-%s-* is declared EMPTY but %d numbered member(s) appear: %s"
                % (kind, len(hits), sorted(set(hits))[:5])
            )
        else:
            note("SRCH-%s-* verified EMPTY (0 numbered members)" % kind)

    # --- GAP register ----------------------------------------------------
    gap_hits = sorted({int(m) for m in re.findall(r"\bSRCH-GAP-0*(\d+)\b", body)})
    counts["GAP"] = len(gap_hits)
    if gap_hits and gap_hits != list(range(1, gap_hits[-1] + 1)):
        fail("SRCH-GAP-* is not contiguous from 001: %s" % gap_hits)

    # --- acceptance criteria and the mapping -----------------------------
    ac = {}
    for idx, line in enumerate(lines, 1):
        m = AC_PATTERN.match(line)
        if m:
            ac.setdefault(int(m.group(1)), []).append((idx, m.group(2)))
    counts["AC"] = check_register(
        {n: [i for i, _ in v] for n, v in ac.items()}, "SRCH-AC"
    )

    cited = set()
    for num, entries in ac.items():
        found_any = False
        for line_no, verifies in entries:
            for m in re.finditer(r"SRCH-(FR|BR|INV|XC)-(\d+)", verifies):
                kind, n = m.group(1), int(m.group(2))
                found_any = True
                if n not in definitions[kind]:
                    fail(
                        "orphan criterion: SRCH-AC-%03d (line %d) cites "
                        "SRCH-%s-%03d, which is not defined"
                        % (num, line_no, kind, n)
                    )
                else:
                    cited.add((kind, n))
        if not found_any:
            fail("SRCH-AC-%03d cites no obligation in its Verifies cell" % num)

    uncovered = []
    for kind in OBLIGATION_KINDS:
        for n in sorted(definitions[kind]):
            if (kind, n) not in cited:
                uncovered.append("SRCH-%s-%03d" % (kind, n))
    if uncovered:
        fail(
            "%d obligation(s) have no acceptance criterion: %s"
            % (len(uncovered), uncovered)
        )

    # --- matrix registration --------------------------------------------
    matrix = "\n".join(read(MATRIX))
    # The existence probe must match the SECTION HEADING, anchored at line
    # start - not the bare substring "2S.". Mutation test M1 deleted the whole
    # section and this check still passed, because the changelog row cites
    # "section 2S.4" and the substring survived. A probe that cannot fail is
    # not a probe; disclosed in matrix section 2S.6.
    if not re.search(r"^## 2S\.", matrix, re.M):
        fail("TRACEABILITY_MATRIX.md has no section 2S heading - "
             "the Stage 5 gate is the registration, not the intention to register")
    else:
        # Scope the register checks to the 2S SECTION BODY. Checking the whole
        # file is unsafe: the changelog row names every register in prose, so a
        # whole-file probe survives deletion of the registration row it is
        # meant to detect. Mutation tests M2/M3 were missed for exactly that
        # reason; disclosed in matrix section 2S.6.
        m = re.search(r"^## 2S\.(.*?)^## ", matrix, re.M | re.S)
        section = m.group(1) if m else ""
        if not section.strip():
            fail("section 2S is present but empty")
        for kind in OBLIGATION_KINDS + ["AC", "GAP"] + EMPTY_KINDS:
            token = "SRCH-%s-*" % kind
            if token not in section:
                fail("matrix section 2S does not register %s" % token)
        expect = str(obligation_total)
        if expect not in section:
            fail(
                "matrix section 2S does not publish the obligation total %s"
                % expect
            )

    # --- report ----------------------------------------------------------
    print("PRD-015 Search Indexing - traceability census")
    print("  subject: %s" % os.path.relpath(PRD, ROOT))
    for kind in OBLIGATION_KINDS:
        print("  SRCH-%-3s : %3d" % (kind, counts[kind]))
    print("  " + "-" * 22)
    print("  obligation-bearing : %3d" % obligation_total)
    print("  SRCH-AC  : %3d" % counts["AC"])
    print("  SRCH-GAP : %3d" % counts["GAP"])
    for kind in EMPTY_KINDS:
        print("  SRCH-%-3s : %3d  (declared EMPTY, verified)" % (kind, counts[kind]))
    print("  obligations covered by a criterion : %d / %d"
          % (obligation_total - len(uncovered), obligation_total))
    print("  orphan criteria : %d" % sum(
        1 for f in failures if f.startswith("orphan criterion")))
    for n in notes:
        print("  note: %s" % n)

    if failures:
        print("\nFAIL - %d problem(s):" % len(failures))
        for f in failures:
            print("  * %s" % f)
        return 1

    print("\nPASS - registers contiguous, 0 duplicates, 0 orphan criteria, "
          "0 uncovered obligations, empty registers verified empty, "
          "matrix section 2S agrees.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
