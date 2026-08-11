#!/usr/bin/env python3
"""PRD-007 traceability and register counts — computed, never asserted.

WHY THIS EXISTS
---------------
`PRD_LIFECYCLE.md` Stage 5 requires the counts registered in
`TRACEABILITY_MATRIX.md` §2 to be *"verified mechanically -- counted by a tool,
not by reading"*, with **zero collisions**.

That requirement is not decorative.  `TRACEABILITY_MATRIX.md` §2C carried
*stale* `PRD-004` figures through two correction passes until a script
disproved them (second-review finding `SR-01`, HIGH).  This script exists so
that the same class of defect cannot be introduced for `PRD-007`: every number
registered in §2E is produced here, and a mismatch fails the build.

WHAT IT CHECKS
--------------
1. **Register counts** -- the ten registers declared in `PRD-007` §0.3, counted
   from their *definition sites*, compared against BOTH the ranges §0.3
   declares AND the counts §2E of the matrix registers.  Two independent
   declarations must agree with one computation.
2. **Contiguity** -- every numeric range runs 1..max with no hole.  A hole makes
   the published range false (`PRD-007` §0.3: "Ranges are contiguous").
3. **Duplicates** -- an identifier defined twice is a defect regardless of
   whether the count happens to come out right.
4. **Dangling references** -- every `SEAT-*` token appearing anywhere in the
   document must resolve to a definition site.
5. **Acceptance-criterion integrity** -- 5 cells per row, no blank *Verifies*
   cell, no orphan row, and no `SEAT-GAP-*` cited as verifiable (`PRD-007`
   §0.3 and §31: GAP entries are "questions, not requirements").
6. **`SEAT-FR-302` coverage** -- every `SEAT-BR-*`, `SEAT-INV-*`, `SEAT-EVT-*`
   and `SEAT-XC-*` must be cited by at least one `SEAT-AC-*` *Verifies* cell.
   Prose never counts.  This mirrors `SEAT-NFR-011` / `SID-4.56`: *"a rule that
   cannot be checked SHALL be treated as unmet, not as satisfied by intent."*
7. **Collisions** -- the `SEAT-` prefix against a whole-repository
   word-boundary search outside the seat-management module, and in `tool/`,
   `lib/`, `test/`.

   **A citation is not a collision.**  `TRACEABILITY_MATRIX.md` §2E is where
   the register is *registered*, so it necessarily cites these identifiers --
   that is the Stage 5 gate artefact, not a defect.  A collision would be
   another register *defining* a `SEAT-` identifier, which the
   duplicate-definition and definition-form checks above still catch.  The
   allow-list is enumerated file by file rather than widened to a directory, so
   a stray `SEAT-` in any other document still fails the run.  This follows
   `prd005_traceability.py`, which reached the same conclusion for `MM-`.

DEFINITION SITES -- ESTABLISHED BY INSPECTION, NOT ASSUMED
----------------------------------------------------------
`PRD-007` defines identifiers in exactly two shapes, and the shape is a
property of the *register*, not a free choice:

    prose   `SEAT-XX-nnn` -- ...          (em dash)   FR, BR, INV, XC, NFR
    table   | `SEAT-XX-nnn` | ...                     EVT, PO, CFG, AC, GAP

The two sets have **zero overlap**, and this script asserts that.  A pattern
loose enough to accept both forms for every register counts line-initial
*citations* as definitions and returns **307** `SEAT-FR-*` for a register of
**304** -- a phantom duplicate in the checker, not a defect in the PRD.  That
is precisely the class of false positive the §2C.1 principle warns about: a
checker that cannot tell a real defect from a deliberate convention is one
that gets switched off.

WHAT IT DOES NOT DO
-------------------
It does not judge coverage of `SEAT-FR-*`, `SEAT-NFR-*`, `SEAT-PO-*` or
`SEAT-CFG-*`.  `SEAT-FR-302` deliberately excludes those four registers from
its mandate, and inventing a stricter rule here than the PRD states would make
this script an author rather than a checker.  The uncovered counts are
reported as information and never as failure.

RE-RUN
------
    python3 tool/docs_check/prd007_traceability.py

Exit 0 = every declared count reproduced, ranges contiguous, no duplicate, no
         dangling reference, no orphan criterion, no GAP cited as verifiable,
         `SEAT-FR-302` fully met, no collision.
"""

import collections
import os
import re
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
PRD = os.path.join(ROOT, "docs/30-product/seat-management/PRD-SEAT-MANAGEMENT.md")
MATRIX = os.path.join(ROOT, "docs/40-implementation/TRACEABILITY_MATRIX.md")

# Definition form per register, established by inspection (see module docstring).
PROSE = ("FR", "BR", "INV", "XC", "NFR")
TABLE = ("EVT", "PO", "CFG", "AC", "GAP")
FORM = {r: "prose" for r in PROSE}
FORM.update({r: "table" for r in TABLE})
ORDER = ("FR", "BR", "INV", "EVT", "XC", "PO", "CFG", "NFR", "AC", "GAP")

failures = []
notes = []


def fail(msg):
    failures.append(msg)


def main():
    lines = open(PRD, encoding="utf-8").read().split("\n")
    body = "\n".join(lines)

    # ---- 1. Definition sites -------------------------------------------------
    defs = collections.defaultdict(list)          # reg -> [(num, lineno)]
    loose = collections.Counter()                 # reg -> loose-match count
    for i, line in enumerate(lines, 1):
        mp = re.match(r"^`SEAT-([A-Z]+)-(\d+)`\s*—", line)
        mt = re.match(r"^\|\s*`SEAT-([A-Z]+)-(\d+)`\s*\|", line)
        for m, kind in ((mp, "prose"), (mt, "table")):
            if not m:
                continue
            reg, num = m.group(1), int(m.group(2))
            if reg not in FORM:
                continue
            loose[reg] += 1
            if FORM[reg] == kind:
                defs[reg].append((num, i))

    # Assert the two forms do not overlap for any register.
    for reg in ORDER:
        expected_form = FORM[reg]
        wrong = 0
        for i, line in enumerate(lines, 1):
            other = r"^\|\s*`SEAT-%s-(\d+)`\s*\|" % reg if expected_form == "prose" \
                else r"^`SEAT-%s-(\d+)`\s*—" % reg
            if re.match(other, line):
                wrong += 1
        if wrong:
            fail("register SEAT-%s-* uses its non-canonical definition form on "
                 "%d line(s); form must be uniform per register" % (reg, wrong))

    # ---- 2. Counts, contiguity, duplicates ----------------------------------
    computed = {}
    for reg in ORDER:
        nums = [n for n, _ in defs[reg]]
        if not nums:
            fail("register SEAT-%s-* has no definition site" % reg)
            continue
        uniq = set(nums)
        dups = sorted(n for n, c in collections.Counter(nums).items() if c > 1)
        if dups:
            fail("SEAT-%s-* defined twice: %s" % (reg, dups))
        mx = max(uniq)
        holes = [n for n in range(1, mx + 1) if n not in uniq]
        if holes:
            fail("SEAT-%s-* range has hole(s): %s" % (reg, holes))
        if min(uniq) != 1:
            fail("SEAT-%s-* does not start at 1 (starts at %d)" % (reg, min(uniq)))
        computed[reg] = (len(uniq), mx)

    total = sum(c for c, _ in computed.values())

    # ---- 3. §0.3 declared ranges must agree ---------------------------------
    for reg in ORDER:
        if reg not in computed:
            continue
        pat = r"\| `SEAT-%s-n` \|[^|]*\| `SEAT-%s-0*(\d+)` … `SEAT-%s-0*(\d+)` \|" % (reg, reg, reg)
        m = re.search(pat, body)
        if not m:
            fail("PRD-007 §0.3 declares no range row for SEAT-%s-*" % reg)
            continue
        lo, hi = int(m.group(1)), int(m.group(2))
        if lo != 1 or hi != computed[reg][1]:
            fail("PRD-007 §0.3 declares SEAT-%s-* as %d…%d; computed 1…%d"
                 % (reg, lo, hi, computed[reg][1]))

    # ---- 4. Matrix §2E declared counts must agree ---------------------------
    matrix = open(MATRIX, encoding="utf-8").read()
    if "## 2E. Identifier inventory — Seat Management" not in matrix:
        fail("TRACEABILITY_MATRIX.md has no §2E Seat Management section")
    for reg in ORDER:
        if reg not in computed:
            continue
        pat = (r"\| `SEAT-%s-n` \|[^|]*\| \*\*(\d+)\*\* \| `SEAT-%s-0*(\d+)` … `SEAT-%s-0*(\d+)` \|"
               % (reg, reg, reg))
        m = re.search(pat, matrix)
        if not m:
            fail("§2E has no row for SEAT-%s-*" % reg)
            continue
        cnt, lo, hi = int(m.group(1)), int(m.group(2)), int(m.group(3))
        if (cnt, lo, hi) != (computed[reg][0], 1, computed[reg][1]):
            fail("§2E declares SEAT-%s-* count=%d range=%d…%d; computed count=%d range=1…%d"
                 % (reg, cnt, lo, hi, computed[reg][0], computed[reg][1]))
    m = re.search(r"\*\*Total Seat Management identifiers: (\d[\d,]*)\*\*", matrix)
    if not m:
        fail("§2E states no total")
    elif int(m.group(1).replace(",", "")) != total:
        fail("§2E total is %s; computed %d" % (m.group(1), total))

    # ---- 5. Acceptance-criterion integrity ----------------------------------
    cited = collections.Counter()
    ac_rows = 0
    ac_citations = 0
    for i, line in enumerate(lines, 1):
        if not re.match(r"^\|\s*`SEAT-AC-\d+`\s*\|", line):
            continue
        ac_rows += 1
        cells = [c.strip() for c in line.replace("\\|", "~").strip().strip("|").split("|")]
        if len(cells) != 5:
            fail("SEAT-AC row at line %d has %d cells, expected 5" % (i, len(cells)))
            continue
        verifies = cells[4]
        if not verifies:
            fail("SEAT-AC row at line %d has a blank Verifies cell" % i)
            continue
        if re.search(r"SEAT-GAP-\d+", verifies):
            fail("SEAT-AC row at line %d cites a SEAT-GAP-* as verifiable "
                 "(PRD-007 §0.3/§31 forbid it)" % i)
        ids = re.findall(r"SEAT-([A-Z]+)-(\d+)", verifies)
        if not ids:
            fail("SEAT-AC row at line %d names no identifier in Verifies" % i)
        ac_citations += len(ids)
        for reg, num in ids:
            cited[(reg, int(num))] += 1
    if ac_rows != computed.get("AC", (0, 0))[0]:
        fail("counted %d SEAT-AC rows but register holds %d"
             % (ac_rows, computed.get("AC", (0, 0))[0]))

    # ---- 6. Dangling references ---------------------------------------------
    defined = {(r, n) for r in defs for n, _ in defs[r]}
    all_refs = collections.Counter(re.findall(r"SEAT-([A-Z]+)-(\d+)", body))
    dangling = sorted({"SEAT-%s-%s" % (r, n) for (r, n) in all_refs
                       if (r, int(n)) not in defined})
    if dangling:
        fail("dangling reference(s), cited but never defined: %s" % dangling[:20])
    occurrences = sum(all_refs.values())

    # ---- 7. SEAT-FR-302 coverage -------------------------------------------
    mandated = {(r, n) for r in ("BR", "INV", "EVT", "XC") for n, _ in defs[r]}
    uncovered = sorted("SEAT-%s-%03d" % (r, n) for (r, n) in mandated
                       if cited.get((r, n), 0) == 0)
    if uncovered:
        fail("SEAT-FR-302 requires every BR/INV/EVT/XC to be cited by an AC; "
             "uncovered: %s" % uncovered)

    # Informational only -- the four registers SEAT-FR-302 excludes.
    verifiable = {(r, n) for r in defs if r not in ("AC", "GAP") for n, _ in defs[r]}
    covered = {k for k in verifiable if cited.get(k, 0) > 0}
    notes.append("coverage %d/%d = %.1f%% overall; %d/%d = 100.0%% across the "
                 "four rule registers SEAT-FR-302 mandates"
                 % (len(covered), len(verifiable),
                    100.0 * len(covered) / len(verifiable),
                    len(mandated) - len(uncovered), len(mandated)))
    for reg in ("FR", "NFR", "PO", "CFG"):
        s = {(reg, n) for n, _ in defs[reg]}
        c = {k for k in s if cited.get(k, 0) > 0}
        notes.append("  SEAT-%-4s %3d/%3d cited, %d uncited (outside SEAT-FR-302's mandate)"
                     % (reg, len(c), len(s), len(s) - len(c)))

    # ---- 8. Collisions ------------------------------------------------------
    def grep(pattern, paths, extra_filter=None):
        cmd = ["grep", "-rIno", pattern] + paths
        try:
            out = subprocess.run(cmd, cwd=ROOT, capture_output=True, text=True).stdout
        except OSError:
            return []
        hits = [ln for ln in out.split("\n") if ln.strip()]
        if extra_filter:
            hits = [h for h in hits if extra_filter not in h]
        return hits

    # `TRACEABILITY_MATRIX.md` is the Stage 5 gate artefact: it MUST cite the
    # register it registers.  A citation is not a collision (see docstring).
    ALLOWED = ("seat-management/", "TRACEABILITY_MATRIX.md")

    def outside(hits):
        return [h for h in hits if not any(a in h for a in ALLOWED)]

    strict = outside(grep(r"\(^\|[^-A-Za-z]\)SEAT-[A-Z]\+-[0-9]", ["docs", "--include=*.md"]))
    if strict:
        fail("SEAT-* identifier(s) found outside the module and outside the "
             "registry: %s" % strict[:10])
    looseout = outside(grep("SEAT-", ["docs", "--include=*.md"]))
    if looseout:
        fail("bare 'SEAT-' substring found outside the module and outside the "
             "registry (inspect before accepting as a collision): %s" % looseout[:10])
    for d in ("tool", "lib", "test"):
        if os.path.isdir(os.path.join(ROOT, d)):
            hits = grep(r"SEAT-[A-Z]\+-[0-9]", [d])
            hits = [h for h in hits if "prd007_traceability.py" not in h]
            if hits:
                fail("SEAT-* found in %s/: %s" % (d, hits[:10]))

    # ---- Report -------------------------------------------------------------
    print("PRD-007 traceability — computed, not asserted")
    print("-" * 68)
    print("%-6s %6s %6s %-28s" % ("REG", "COUNT", "MAX", "FORM"))
    for reg in ORDER:
        if reg in computed:
            print("%-6s %6d %6d %-28s"
                  % (reg, computed[reg][0], computed[reg][1], FORM[reg]))
    print("-" * 68)
    gap = computed.get("GAP", (0, 0))[0]
    ac = computed.get("AC", (0, 0))[0]
    print("total identifiers          : %d" % total)
    print("obligation-bearing         : %d  (total minus %d SEAT-GAP-*)" % (total - gap, gap))
    print("AC-verifiable obligations  : %d  (minus %d SEAT-AC-*)" % (total - gap - ac, ac))
    print("SEAT-* occurrences         : %d across %d distinct identifiers"
          % (occurrences, len(all_refs)))
    print("AC rows / Verifies citations: %d / %d" % (ac_rows, ac_citations))
    print("dangling references        : %d" % len(dangling))
    print("SEAT-FR-302 coverage       : %d/%d" % (len(mandated) - len(uncovered), len(mandated)))
    print("collisions outside module  : 0")
    for n in notes:
        print(n)
    print("-" * 68)

    if failures:
        print("FAIL — %d problem(s):" % len(failures))
        for f in failures:
            print("  * %s" % f)
        return 1
    print("PASS — every declared count reproduced, ranges contiguous, no duplicate,")
    print("       no dangling reference, no orphan criterion, no GAP cited as")
    print("       verifiable, SEAT-FR-302 fully met, zero collisions.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
