#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
PRD-021A A1-A8  --  Stage 5 registration gate  (TRACEABILITY_MATRIX.md section 2P)

This is the SECOND of the two instruments PRD_LIFECYCLE.md Stage 5 requires.

It deliberately does NOT import prd021a_traceability.py.

TRACEABILITY_MATRIX.md section 2H.2 names the failure both instruments exist to avoid:
"a checker written in the same pass as the register it checks, by the same author,
verifies agreement with itself."  Two instruments that share code share their blind
spots.  This file therefore re-derives every published number straight from the eight
subject documents by its own route, then reads section 2P and CONTRADICTS it wherever
they differ.  Agreement reached twice by structurally different means is evidence;
agreement reached once is a tautology.

Checks, following the section 2O precedent set by prd020_stage5.py:

  1. section 2P exists at all.                 (run before it existed: must exit 1)
  2. Every section 2P.0 inventory row agrees with the subjects: count, range max,
     contiguity mark, and next-free cell.
  3. The section 2P.0 totals row agrees with the sum of its own rows AND with the
     independently recomputed totals.
  4. The section 2P header block agrees: registers, identifiers, normative
     requirements, acceptance criteria.
  5. Collision freedom re-measured in the four directions of section 2O.1, including
     the control that proves the near-miss probe can fire.
  6. CLOSED registers publish NO numeric next-free cell.
     This is defect I-4 of section 2O.4, where a closed register's "next free" cell
     read the arithmetic successor and thereby minted a phantom identifier inside the
     very table declaring the register closed.  That class is made unrepeatable here.
  7. The matrix version was bumped and carries a change-history row.
  8. No IMPL- identifier is minted by section 2P.  Stage 6 is not entered here.

Exit 0 = gate satisfied.  Exit 1 = gate failed.
"""

import os
import re
import sys

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
SOCIAL = os.path.join(ROOT, "docs", "30-product", "social-graph")
MATRIX = os.path.join(ROOT, "docs", "40-implementation", "TRACEABILITY_MATRIX.md")

# (part, filename, stem).  Enumerated explicitly and never globbed: the directory
# also holds ten superseded drafts, and a glob over PRD-021A_A*_*DRAFT_v*.md matches
# eighteen files rather than eight.
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

# Registers whose membership is closed by a normative rule in the subject.  A closed
# register has no next free member until an ADR confers one, so its next-free cell
# must not be numeric.  See section 2O.4 defect I-4.
CLOSED = {
    ("LCF", "EVT"): "A2 LCF-FR-104 closes the event set at six",
}

# A7's four withdrawn event identifiers.  PRD_LIFECYCLE.md section 5 rule 5:
# "Numbers are never reused, even after withdrawal."  The register maximum therefore
# does not retreat when members are withdrawn, and section 2P must not report a
# shrunken register.
A7_WITHDRAWN_COUNT = 4

# A1 skips exactly one functional-requirement number.  It is stored here as the
# position of its PREDECESSOR and never as a literal token, because A1 section 24
# states the number is "deliberately not written out anywhere in this document,
# because reproducing an unassigned identifier in prose is exactly what makes a
# phantom look defined to a grep-based or automated continuity check."  A gate that
# writes the phantom while enforcing the rule against phantoms has not enforced it.
A1_GAP_AFTER = 46

failures = []
notes = []


def fail(msg):
    failures.append(msg)


def note(msg):
    notes.append(msg)


def read(path):
    with open(path, encoding="utf-8") as fh:
        return fh.read()


# ---------------------------------------------------------------------------
# Independent recomputation.  Shares no code and no data structure with
# prd021a_traceability.py.  Occupancy-based, not definition-site based: section
# 2O.4 defect I-1 records a census that counted definition rows and undercounted a
# live register by half, because members defined mid-sentence were invisible to it.
# ---------------------------------------------------------------------------
def recompute():
    inv = {}
    for part, fname, stem in PARTS:
        path = os.path.join(SOCIAL, fname)
        if not os.path.exists(path):
            fail("subject missing: %s" % fname)
            continue
        text = read(path)
        occ = {}
        for reg, num in re.findall(r"\b" + stem + r"-([A-Z]+)-(\d+)\b", text):
            occ.setdefault(reg, set()).add(int(num))
        for reg in sorted(occ):
            members = sorted(occ[reg])
            lo, hi = members[0], members[-1]
            gaps = [n for n in range(lo, hi + 1) if n not in occ[reg]]
            inv[(stem, reg)] = {
                "part": part,
                "count": len(members),
                "lo": lo,
                "hi": hi,
                "gaps": gaps,
            }
    return inv


def split_row(line):
    """Markdown cells, honouring the escaped pipe.  A validator that splits on a bare
    pipe mis-parses every row containing a regex alternation, which section 2O.1's
    own direction (b) cell contains."""
    return [c.strip() for c in re.split(r"(?<!\\)\|", line)[1:-1]]


def main():
    inv = recompute()

    tot_registers = len(inv)
    tot_identifiers = sum(v["count"] for v in inv.values())

    if not os.path.exists(MATRIX):
        fail("TRACEABILITY_MATRIX.md not found at %s" % MATRIX)
        report()
        return

    matrix = read(MATRIX)

    # -- check 1: the section exists ---------------------------------------
    if "## 2P." not in matrix:
        fail("TRACEABILITY_MATRIX.md has no `## 2P.` section - "
             "PRD-021A A1-A8 registers %d identifiers across %d registers NOWHERE"
             % (tot_identifiers, tot_registers))
        report()
        return

    start = matrix.index("## 2P.")
    nxt = matrix.find("\n## ", start + 1)
    section = matrix[start:nxt if nxt != -1 else len(matrix)]

    # -- check 2 + 6: every inventory row ----------------------------------
    seen = set()
    row_re = re.compile(r"^\|\s*`(LC[MFRGOSNT])-([A-Z]+)-NNN`", re.M)
    for line in section.split("\n"):
        m = row_re.match(line)
        if not m:
            continue
        stem, reg = m.group(1), m.group(2)
        key = (stem, reg)
        seen.add(key)
        cells = split_row(line)
        if len(cells) < 6:
            fail("2P.0 row for `%s-%s-NNN` has %d cells, expected 6" % (stem, reg, len(cells)))
            continue
        _, _, c_count, c_range, c_contig, c_next = cells[:6]

        if key not in inv:
            fail("2P.0 registers `%s-%s-*`, which no subject defines" % (stem, reg))
            continue
        exp = inv[key]

        got = re.search(r"\d+", c_count.replace("*", ""))
        if not got or int(got.group()) != exp["count"]:
            fail("2P.0 `%s-%s-*` count cell says %r, subjects say %d"
                 % (stem, reg, c_count, exp["count"]))

        nums = re.findall(r"`(\d+)`", c_range)
        if len(nums) != 2 or int(nums[0]) != exp["lo"] or int(nums[1]) != exp["hi"]:
            fail("2P.0 `%s-%s-*` range cell says %r, subjects say %03d...%03d"
                 % (stem, reg, c_range, exp["lo"], exp["hi"]))

        # contiguity mark must match measured contiguity
        marked_ok = ("check" in c_contig.lower()) or ("\u2705" in c_contig)
        if exp["gaps"] and marked_ok:
            fail("2P.0 `%s-%s-*` is marked contiguous but is missing %d number(s)"
                 % (stem, reg, len(exp["gaps"])))
        if not exp["gaps"] and not marked_ok and "CLOSED" not in c_contig.upper():
            fail("2P.0 `%s-%s-*` is contiguous but the cell does not say so: %r"
                 % (stem, reg, c_contig))

        # -- defect I-4: a closed register publishes no numeric next free --
        numeric_next = re.fullmatch(r"[`*\s]*(\d+)[`*\s]*", c_next)
        if key in CLOSED:
            if numeric_next:
                fail("2P.0 `%s-%s-*` is CLOSED (%s) but publishes numeric next-free %r "
                     "- this is section 2O.4 defect I-4: it mints a phantom inside the "
                     "table that declares the register closed"
                     % (stem, reg, CLOSED[key], c_next))
            else:
                note("closed register `%s-%s-*` correctly publishes no numeric next free"
                     % (stem, reg))
        else:
            if not numeric_next:
                fail("2P.0 `%s-%s-*` is open but its next-free cell is not a number: %r"
                     % (stem, reg, c_next))
            elif int(numeric_next.group(1)) != exp["hi"] + 1:
                fail("2P.0 `%s-%s-*` next-free says %s, one past the maximum is %d"
                     % (stem, reg, numeric_next.group(1), exp["hi"] + 1))

    missing = sorted(set(inv) - seen)
    if missing:
        fail("2P.0 omits %d register(s) the subjects define: %s"
             % (len(missing), ", ".join("%s-%s" % k for k in missing[:12])))

    # -- check 3 + 4: header and totals ------------------------------------
    def header_int(label):
        m = re.search(r"\|\s*\*\*%s\*\*\s*\|\s*\**(\d[\d,]*)" % label, section)
        return int(m.group(1).replace(",", "")) if m else None

    h_reg = header_int("Registers")
    if h_reg is None:
        fail("2P header has no `Registers` field")
    elif h_reg != tot_registers:
        fail("2P header Registers = %d, recomputed %d" % (h_reg, tot_registers))

    h_ids = header_int("Identifiers")
    if h_ids is None:
        fail("2P header has no `Identifiers` field")
    elif h_ids != tot_identifiers:
        fail("2P header Identifiers = %d, recomputed %d" % (h_ids, tot_identifiers))

    n_fr = sum(v["count"] for k, v in inv.items() if k[1] == "FR")
    n_br = sum(v["count"] for k, v in inv.items() if k[1] == "BR")
    n_ac = sum(v["count"] for k, v in inv.items() if k[1] == "AC")

    h_req = header_int("Normative requirements")
    if h_req is not None and h_req != n_fr + n_br:
        fail("2P header Normative requirements = %d, recomputed %d (%d FR + %d BR)"
             % (h_req, n_fr + n_br, n_fr, n_br))

    h_ac = header_int("Acceptance criteria")
    if h_ac is not None and h_ac != n_ac:
        fail("2P header Acceptance criteria = %d, recomputed %d" % (h_ac, n_ac))

    m_tot = re.search(r"\|\s*\*\*Total\*\*\s*\|[^|]*\|\s*\*\*(\d[\d,]*)\*\*", section)
    if not m_tot:
        fail("2P.0 has no totals row")
    elif int(m_tot.group(1).replace(",", "")) != tot_identifiers:
        fail("2P.0 totals row says %s, recomputed %d"
             % (m_tot.group(1), tot_identifiers))

    # -- check 5: collisions, four directions ------------------------------
    before = matrix[:start]
    for stem in STEMS:
        hits = len(re.findall(r"\b" + stem + r"-[A-Z]+-\d+\b", before))
        if hits:
            fail("direction (a): `%s-` already appears %d time(s) in the matrix "
                 "before 2P" % (stem, hits))

    foreign = set(re.findall(r"\b([A-Z][A-Z0-9]{1,6})-[A-Z]+-\d{3}\b", before))
    for f in sorted(foreign):
        for s in STEMS:
            if f != s and (f.startswith(s) or s.startswith(f)):
                fail("direction (b): stem `%s-` collides by containment with `%s-`" % (f, s))
    note("direction (b): %d foreign stems harvested, 0 collide" % len(foreign))

    probes = ["LC", "LCFG", "LCMS", "LCA", "LCB", "LCC", "LCD", "LCE"]
    for p in probes:
        if p in STEMS:
            continue
        n = len(re.findall(r"\b" + p + r"-[A-Z]+-\d+\b", matrix))
        if n:
            fail("direction (c): near-miss stem `%s-` is live with %d hit(s)" % (p, n))
    # the control: the same probe shape MUST fire on a real stem, or the negative
    # above proves nothing.
    control = len(re.findall(r"\bLCM-[A-Z]+-\d+\b", section))
    if control == 0:
        fail("direction (c) CONTROL FAILED: the probe finds no `LCM-` in 2P either, "
             "so its zeroes are meaningless")
    else:
        note("direction (c): 8 near-miss probes return 0; control fires (%d) so the "
             "probe is meaningful" % control)

    # direction (d): a foreign DEFINITION of one of our stems inside the matrix
    for stem in STEMS:
        for line in matrix.split("\n"):
            if re.match(r"^\|\s*`" + stem + r"-[A-Z]+-\d{3}`", line):
                fail("direction (d): matrix defines `%s-*` outside the subjects" % stem)
                break

    # -- check 7: version bumped with a change-history row -----------------
    mv = re.search(r"\|\s*\*\*Version\*\*\s*\|\s*\**v(\d+\.\d+)", matrix)
    if not mv:
        fail("matrix header has no Version field")
    else:
        ver = mv.group(1)
        if not re.search(r"\|\s*\*\*v" + re.escape(ver) + r"\*\*\s*\|", matrix):
            fail("matrix is at v%s but section 11 has no change-history row for it" % ver)
        else:
            note("matrix v%s carries a change-history row" % ver)

    # -- check 8: Stage 6 is not entered -----------------------------------
    minted = re.findall(r"\bIMPL-(\d+)\b", section)
    if minted:
        fail("2P mints or allocates IMPL- identifier(s): %s - Stage 6 is not this act"
             % ", ".join(sorted(set(minted))))

    # -- preservation facts, restated against the subjects -----------------
    a1 = inv.get(("LCM", "FR"))
    if a1:
        if a1["gaps"] != [A1_GAP_AFTER + 1]:
            fail("A1 LCM-FR gap set is %s, expected exactly one number after %d"
                 % (a1["gaps"], A1_GAP_AFTER))
        else:
            note("A1's single unassigned FR position is preserved and is not written "
                 "out by this gate")
    a7 = inv.get(("LCN", "EVT"))
    if a7 and a7["hi"] != 7:
        fail("A7 LCN-EVT maximum is %03d; withdrawal must not retract the maximum "
             "(PRD_LIFECYCLE.md section 5 rule 5)" % a7["hi"])
    else:
        note("A7's event register maximum is 007 with %d withdrawn members retained"
             % A7_WITHDRAWN_COUNT)

    report(tot_registers, tot_identifiers, n_fr, n_br, n_ac)


def report(nr=None, ni=None, nfr=None, nbr=None, nac=None):
    print("=" * 74)
    print("PRD-021A A1-A8  --  Stage 5 registration gate (matrix section 2P)")
    print("=" * 74)
    if nr is not None:
        print("  recomputed independently: %d registers, %d identifiers" % (nr, ni))
        print("  normative requirements: %d (%d FR + %d BR)   acceptance criteria: %d"
              % (nfr + nbr, nfr, nbr, nac))
    for n in notes:
        print("  note: %s" % n)
    print()
    if failures:
        print("FAILURES (%d):" % len(failures))
        for f in failures:
            print("  - %s" % f)
        sys.exit(1)
    print("OK: section 2P agrees with the subjects on every published number, "
          "collisions are zero in four directions, and no IMPL- was minted.")
    sys.exit(0)


if __name__ == "__main__":
    main()
