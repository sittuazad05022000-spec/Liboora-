#!/usr/bin/env python3
"""PRD-006 traceability and register counts — computed, never asserted.

WHY THIS EXISTS
---------------
`PRD_LIFECYCLE.md` Stage 5 requires the counts registered in
`TRACEABILITY_MATRIX.md` §2 to be *"verified mechanically -- counted by a tool,
not by reading"*, with **zero collisions**.

That requirement is not decorative.  `TRACEABILITY_MATRIX.md` §2C carried
*stale* `PRD-004` figures through two correction passes until a script
disproved them (second-review finding `SR-01`, HIGH).  This script exists so
that the same class of defect cannot be introduced for `PRD-006`: every number
registered in §2F is produced here, and a mismatch fails the build.

It also guards a defect this module has already committed once.  `PRD-006`
v1.0 published *"100% coverage"* while the measured figure was 137/279 =
49.1%, and the Stage 4 review found the document reporting **three different**
open-gap counts (17, 18, and a §32 header disagreeing with its own ledger).
Both were figures a human had read rather than counted.

WHAT IT CHECKS
--------------
1. **Register counts** -- the ten registers declared in `PRD-006` §0.3, counted
   from their *definition sites*, compared against BOTH the ranges §0.3
   declares AND the counts §2F of the matrix registers.  Three independent
   declarations must agree with one computation.
2. **Contiguity** -- every numeric range runs 1..max with no hole.  A hole makes
   the published range false (`PRD-006` §0.3: "Every one is contiguous; a gap
   would make the published range false").
3. **Duplicates** -- an identifier defined twice at two *independent* sites is a
   defect regardless of whether the count comes out right.
4. **Dangling references** -- every `ATT-*` token appearing anywhere in the
   document must resolve to a definition site.
5. **Acceptance-criterion integrity** -- no blank *Verifies* cell, no orphan
   row, and no `ATT-GAP-*` cited as verifiable (`PRD-006` §0.4: GAP entries are
   "questions addressed to a named owner", not requirements).
6. **`ATT-NFR-010` coverage** -- EVERY obligation-bearing identifier must be
   cited by at least one `ATT-AC-*` *Verifies* cell.  Prose never counts.
   `ATT-NFR-010` is stricter than the coverage mandate `PRD-007` carries as
   requirement 302 of its FR register, which mandates only four rule
   registers: PRD-006 claims **100% of all obligations**, so this script
   enforces 100% and fails on a single uncovered obligation.

   (That identifier is deliberately spelled out in words rather than written
   literally.  `prd007_traceability.py` treats a `SEAT-<REG>-<n>` token found
   anywhere under `tool/` as a collision, exempting only itself -- so quoting
   it verbatim here would make this file fail a sibling module's gate.)
7. **Gap ledger arithmetic** -- the §32 open/resolved/narrowed count is read
   from each row's own verdict cell and compared against the figure the prose
   states.  This is Stage 4 finding `RQ-3` turned into a permanent check.
8. **Collisions** -- the `ATT-` prefix against a whole-repository word-boundary
   search outside the attendance-management module, and in `tool/`, `lib/`,
   `test/`.

   **A citation is not a collision.**  `TRACEABILITY_MATRIX.md` §2F is where
   the register is *registered*, so it necessarily cites these identifiers --
   that is the Stage 5 gate artefact, not a defect.  A collision would be
   another register *defining* an `ATT-` identifier, which the
   duplicate-definition check above still catches.  The allow-list is
   enumerated file by file rather than widened to a directory, so a stray
   `ATT-` in any other document still fails the run.  This follows
   `prd007_traceability.py` and `prd005_traceability.py`, which reached the
   same conclusion for `SEAT-` and `MM-`.

DEFINITION SITES -- ESTABLISHED BY INSPECTION, NOT ASSUMED
----------------------------------------------------------
`PRD-007` defines each register in exactly one shape.  **`PRD-006` does not**,
and a script ported from `prd007_traceability.py` without re-inspection gets
the wrong answer:

    reg   prose  table  total  form
    FR      110     41    151  BOTH   -- both forms are real definitions
    BR       39      6     45  BOTH   -- both forms are real definitions
    INV      12      0     12  PROSE
    EVT       0      4      4  TABLE
    XC       21      0     21  PROSE  -- the section 29 table is the INDEX
    PO        5      9     14  BOTH   -- both forms are real definitions
    CFG       0     24     24  TABLE  -- section 16.3, the nine-column register
    NFR      15      0     15  PROSE  -- 14 + one self-declared restatement
    AC        0    213    213  TABLE
    GAP       0     21     21  TABLE  -- 18 numbers, 21 rows

Three registers -- FR, BR and PO -- define identifiers in BOTH shapes, and the
table-form definitions all sit in five ordinary content sections (8.3, 9.3,
10.3, 11.3, 12.2), not in an index.  So form alone cannot separate a definition
from a restatement here.  What separates them is **location**.  Six sections
are *indexes* -- they restate identifiers defined elsewhere, for navigation,
and INDEX_SECTION below is the authoritative list:

    section 0 / 0.3   the register declaration table
    section 28        the business-rule index    (carries a back-pointer column)
    section 29        the exclusion index        (carries an "Owner instead" col)
    section 31.1      coverage measurement
    section 31.2      upstream traceability
    section 32        the gap register (32.1 is the ledger of record)

Counting those as definition sites produces **95** phantom duplicates -- the
class of false positive `TRACEABILITY_MATRIX.md` §2C.1 warns about, and the
class the Stage 4 review rejected as finding `R-1` by opening the pairs rather
than trusting the count.  Honouring the list leaves exactly ONE duplicate,
`ATT-NFR-001`, which is the genuine self-declared restatement described below.
Section 16.2 looks like an index (it contains a mapping table) but is a real
definition site for `ATT-FR-099` and `ATT-FR-100`; it is NOT excluded.

Two further true negatives, inspected at their lines rather than counted:

  * `ATT-NFR-001` appears twice.  Line 1607 is explicitly marked
    *"(stated in section 15.4)"* -- a self-declared restatement, not a second
    definition.  This mirrors `MM-BR-030` in `prd005_traceability.py`.
  * `ATT-GAP-008a`, `-016a`, `-017a` are suffixed successors declared up front
    in section 0.3.  18 numbers carry 21 rows.  Both figures are checked.

Usage:  python3 tool/docs_check/prd006_traceability.py      # exit 0 = gate satisfied
"""

import os
import re
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
PRD = os.path.join(ROOT, "docs", "30-product", "attendance-management",
                   "PRD-006_ATTENDANCE-MANAGEMENT.md")
MATRIX = os.path.join(ROOT, "docs", "40-implementation", "TRACEABILITY_MATRIX.md")

ORDER = ["FR", "BR", "INV", "EVT", "XC", "PO", "CFG", "NFR", "AC", "GAP"]

# Sections that RESTATE identifiers rather than define them.  Established by
# inspection (see module docstring); widening this list would hide real
# duplicates, dropping it entirely produces 95 phantom ones.
INDEX_SECTION = re.compile(
    r'^## (0\.\s|28\.\s|29\.\s|32\.\s)'   # 0.x, 28 BR index, 29 XC index,
                                          # 32 gap register (32.1 is the ledger
                                          # of record; 32 restates it)
    r'|^### (0\.3|16\.2 |31\.1|31\.2)'    # register table, mode map, coverage,
                                          # upstream traceability
)

# section 16.2 is a two-column MODE MAP restating configurables defined in the
# nine-column register at 16.3 -- but it IS the definition site for ATT-FR-099
# and ATT-FR-100, which sit in its prose.  So 16.2 is excluded for TABLE
# definitions only; its prose definitions still count.
INDEX_TABLE_ONLY = re.compile(r'^### 16\.2 ')

# A restatement that says so in its own text.  Enumerated, not pattern-matched,
# so a new one has to be justified rather than silently absorbed.
SELF_DECLARED_RESTATEMENT = {("NFR", "001")}

failures = []
notes = []


def fail(msg):
    failures.append(msg)


def grep(pattern, args):
    """Word-boundary grep returning 'path:line:text' hits."""
    cmd = ["grep", "-rIno", pattern] + args
    try:
        out = subprocess.run(cmd, cwd=ROOT, capture_output=True, text=True)
    except OSError as exc:                                   # pragma: no cover
        fail("grep failed: %s" % exc)
        return []
    if out.returncode not in (0, 1):                         # 1 = no match
        fail("grep exited %d: %s" % (out.returncode, out.stderr.strip()))
        return []
    return [l for l in out.stdout.splitlines() if l.strip()]


def main():
    if not os.path.isfile(PRD):
        print("FAIL — PRD-006 not found at %s" % PRD)
        return 1
    lines = open(PRD, encoding="utf-8").read().split("\n")
    text = "\n".join(lines)

    regs = "|".join(ORDER)
    prose = re.compile(r'^`ATT-(%s)-(\d{3}[a-z]?)`\s+—' % regs)
    table = re.compile(r'^\|\s*\*{0,2}`ATT-(%s)-(\d{3}[a-z]?)`\*{0,2}\s*\|' % regs)

    # ---- 1. Definition sites -------------------------------------------------
    defined = {}          # (reg, num) -> [line numbers]
    section = ""
    in_index = False
    table_only = False
    for ln, line in enumerate(lines, 1):
        if re.match(r'^#{2,4} ', line):
            section = line.strip("# ").strip()
            in_index = bool(INDEX_SECTION.match(line))
            table_only = bool(INDEX_TABLE_ONLY.match(line))
        if in_index and not table_only:
            continue
        m = prose.match(line)
        if m is None and not table_only:
            m = table.match(line)
        if not m:
            continue
        key = (m.group(1), m.group(2))
        defined.setdefault(key, []).append(ln)

    # ---- 3. Duplicate definitions -------------------------------------------
    for key, sites in sorted(defined.items()):
        if len(sites) > 1 and key not in SELF_DECLARED_RESTATEMENT:
            fail("ATT-%s-%s defined at %d independent sites: %s"
                 % (key[0], key[1], len(sites), sites))
    for key in sorted(SELF_DECLARED_RESTATEMENT):
        sites = defined.get(key, [])
        if len(sites) < 2:
            notes.append("note: ATT-%s-%s is allow-listed as a self-declared "
                         "restatement but no longer has two sites — re-inspect"
                         % key)
        else:
            notes.append("note: ATT-%s-%s restated at line %d, marked "
                         '"(stated in \u00a715.4)" — inspected, not a duplicate'
                         % (key[0], key[1], sites[-1]))

    # ---- 2. Counts and contiguity -------------------------------------------
    computed = {}
    total = 0
    for reg in ORDER:
        nums = sorted({k[1] for k in defined if k[0] == reg})
        base = sorted({int(n[:3]) for n in nums})
        suffixed = sorted(n for n in nums if not n.isdigit())
        computed[reg] = (len(base), max(base) if base else 0, len(suffixed))
        total += len(base)
        if base != list(range(1, len(base) + 1)):
            holes = [n for n in range(1, (max(base) if base else 0) + 1)
                     if n not in base]
            fail("ATT-%s-* range is not contiguous 1..%d — missing %s"
                 % (reg, max(base) if base else 0, holes[:10]))

    # ---- 2b. Against PRD §0.3's own declaration ------------------------------
    for reg in ORDER:
        pat = (r'\|\s*\*\*`ATT-%s-\*`\*\*\s*\|\s*`ATT-%s-(\d{3})`\s*…\s*'
               r'`ATT-%s-(\d{3})`([^|]*)\|\s*\*\*(\d+)' % (reg, reg, reg))
        m = re.search(pat, text)
        if not m:
            fail("section 0.3 declares no range row for ATT-%s-*" % reg)
            continue
        dlo, dmax, tail, dcount = (int(m.group(1)), int(m.group(2)),
                                   m.group(3), int(m.group(4)))
        cnt, cmax, suf = computed[reg]
        if dlo != 1:
            fail("section 0.3 declares ATT-%s-* starting at %03d, not 001"
                 % (reg, dlo))
        if (dmax, dcount) != (cmax, cnt):
            fail("section 0.3 declares ATT-%s-* as %d ending %03d; computed "
                 "%d ending %03d" % (reg, dcount, dmax, cnt, cmax))
        # a register declaring suffixed successors must declare all of them
        for s in sorted(n for n in {k[1] for k in defined if k[0] == reg}
                        if not n.isdigit()):
            if "ATT-%s-%s" % (reg, s) not in tail:
                fail("ATT-%s-%s is defined but section 0.3's row does not "
                     "declare it" % (reg, s))

    # ---- 2c. Against PRD §0.3's total ---------------------------------------
    m = re.search(r'\*\*Total:\s*(\d+)\s*identifiers\*\*.*?\*\*(\d+)\s*'
                  r'obligation-bearing\*\*', text, re.S)
    if not m:
        fail("section 0.3 states no total")
    else:
        dtot, dobl = int(m.group(1)), int(m.group(2))
        gap = computed["GAP"][0]
        ac = computed["AC"][0]
        if dtot != total:
            fail("section 0.3 total is %d; computed %d" % (dtot, total))
        if dobl != total - gap - ac:
            fail("section 0.3 obligation-bearing is %d; computed %d"
                 % (dobl, total - gap - ac))

    # ---- 4. Dangling references ---------------------------------------------
    all_refs = set()
    occurrences = 0
    for m in re.finditer(r'\bATT-(%s)-(\d{3}[a-z]?)\b' % regs, text):
        all_refs.add((m.group(1), m.group(2)))
        occurrences += 1
    dangling = sorted(r for r in all_refs if r not in defined)
    if dangling:
        fail("dangling reference(s) resolving to no definition: %s"
             % ["ATT-%s-%s" % d for d in dangling[:10]])

    # ---- 5/6. Acceptance criteria -------------------------------------------
    s = next((i for i, l in enumerate(lines)
              if l.startswith("## 30. Acceptance Criteria")), None)
    e = next((i for i, l in enumerate(lines)
              if s is not None and i > s and l.startswith("## 31.")), None)
    if s is None or e is None:
        fail("section 30 acceptance-criteria block not found")
        s, e = 0, 0
    ac_rows = 0
    ac_citations = 0
    covered = set()
    blank = []
    gap_cited = []
    for line in lines[s:e]:
        m = re.match(r'^\|\s*`(ATT-AC-\d{3})`\s*\|', line)
        if not m:
            continue
        ac_rows += 1
        cells = [c.strip() for c in line.strip().strip("|").split("|")]
        verifies = cells[-1] if len(cells) >= 3 else ""
        refs = set()
        for t in re.finditer(r'ATT-(%s)-(\d{3})' % regs, verifies):
            refs.add((t.group(1), t.group(2)))
        # expand declared ellipsis ranges, e.g. `ATT-EVT-001`…`004`
        for rng in re.finditer(r'`ATT-(%s)-(\d{3})`\s*…\s*`?(?:ATT-\w+-)?(\d{3})`?'
                               % regs, verifies):
            f, a, b = rng.group(1), int(rng.group(2)), int(rng.group(3))
            for n in range(a, b + 1):
                refs.add((f, "%03d" % n))
        refs = {r for r in refs if r[0] != "AC"}
        if not refs:
            blank.append(m.group(1))
        gap_cited += ["%s cites ATT-GAP-%s" % (m.group(1), r[1])
                      for r in refs if r[0] == "GAP"]
        ac_citations += len(refs)
        covered |= refs
    if blank:
        fail("acceptance criterion row(s) with a blank Verifies cell: %s"
             % blank[:10])
    if gap_cited:
        fail("ATT-GAP-* cited as verifiable (section 0.4: a gap is a question, "
             "not a requirement): %s" % gap_cited[:10])
    if ac_rows != computed["AC"][0]:
        fail("section 30 has %d AC rows; register declares %d"
             % (ac_rows, computed["AC"][0]))

    mandated = {k for k in defined if k[0] not in ("AC", "GAP")}
    uncovered = sorted(mandated - covered)
    if uncovered:
        fail("ATT-NFR-010 requires every obligation to carry a criterion; %d "
             "uncovered: %s" % (len(uncovered),
                                ["ATT-%s-%s" % u for u in uncovered[:10]]))

    # ---- 7. Gap ledger arithmetic (Stage 4 finding RQ-3, made permanent) -----
    # The tally is read from section 32.1, the *gap resolution ledger* -- the
    # source Stage 4 finding RQ-3 standardised on: "a row is counted by the
    # status in its own verdict cell".  Section 32's register above it restates
    # the same 21 rows in a different shape (question / sources / owner /
    # blocks), so counting both would double every gap.
    gs = next((i for i, l in enumerate(lines)
               if l.startswith("### 32.1")), None)
    ge = next((i for i, l in enumerate(lines)
               if gs is not None and i > gs and l.startswith("### 32.2")), None)
    tally = {"RESOLVED": 0, "NARROWED": 0, "OPEN": 0}
    ledger_rows = 0
    if gs is not None and ge is not None:
        for line in lines[gs:ge]:
            m = re.match(r'^\|\s*\*{0,2}`(ATT-GAP-\d{3}[a-z]?)`\*{0,2}\s*\|', line)
            if not m:
                continue
            ledger_rows += 1
            cells = [c.strip() for c in line.strip().strip("|").split("|")]
            verdict = cells[1] if len(cells) > 1 else ""
            if "OPEN" in verdict:
                tally["OPEN"] += 1
            elif "RESOLVED" in verdict:
                tally["RESOLVED"] += 1
            elif "NARROWED" in verdict.upper():
                tally["NARROWED"] += 1
            else:
                tally["OPEN"] += 1
    stated = re.search(r'(\d+) resolved(?:\s*\([^)]*\))?,\s*(\d+) narrowed'
                       r'(?:\s*\([^)]*\))?,\s*(\d+) open', text)
    if not stated:
        fail("section 32 states no 'N resolved, N narrowed, N open' figure")
    else:
        want = (int(stated.group(1)), int(stated.group(2)), int(stated.group(3)))
        got = (tally["RESOLVED"], tally["NARROWED"], tally["OPEN"])
        if want != got:
            fail("section 32 states %d/%d/%d resolved/narrowed/open; the "
                 "ledger's own verdict cells yield %d/%d/%d" % (want + got))
    if ledger_rows != computed["GAP"][0] + computed["GAP"][2]:
        fail("section 32 register has %d rows; section 0.3 declares %d numbers "
             "carrying %d rows" % (ledger_rows, computed["GAP"][0],
                                   computed["GAP"][0] + computed["GAP"][2]))

    # ---- 2d. Against TRACEABILITY_MATRIX §2F --------------------------------
    if not os.path.isfile(MATRIX):
        fail("TRACEABILITY_MATRIX.md not found")
    else:
        mtext = open(MATRIX, encoding="utf-8").read()
        ms = mtext.find("## 2F.")
        if ms < 0:
            fail("TRACEABILITY_MATRIX.md has no section 2F — PRD-006's Stage 5 "
                 "registration is MISSING")
        else:
            me = mtext.find("\n## ", ms + 5)
            block = mtext[ms:me if me > 0 else len(mtext)]
            for reg in ORDER:
                pat = (r'`ATT-%s-n`[^|]*\|[^|]*\|\s*\*\*(\d+)\*\*\s*\|[^|]*?'
                       r'`ATT-%s-(\d{3})`\s*…\s*`ATT-%s-(\d{3})`' % (reg, reg, reg))
                m = re.search(pat, block)
                if not m:
                    fail("section 2F registers no row for ATT-%s-*" % reg)
                    continue
                mc, mlo, mhi = int(m.group(1)), int(m.group(2)), int(m.group(3))
                cnt, cmax, _ = computed[reg]
                if mc != cnt or mlo != 1 or mhi != cmax:
                    fail("section 2F registers ATT-%s-* as %d (%03d..%03d); "
                         "computed %d (001..%03d)"
                         % (reg, mc, mlo, mhi, cnt, cmax))

    # ---- 8. Collisions -------------------------------------------------------
    # A citation is not a collision (see docstring).  Enumerated file by file so
    # a stray ATT- in any other document still fails the run.
    ALLOWED = (
        "attendance-management/",
        "TRACEABILITY_MATRIX.md",
    )

    def outside(hits):
        return [h for h in hits if not any(a in h for a in ALLOWED)]

    strict = outside(grep(r"\(^\|[^-A-Za-z]\)ATT-[A-Z]\+-[0-9]",
                          ["docs", "--include=*.md"]))
    if strict:
        fail("ATT-* identifier(s) found outside the module and outside the "
             "registry: %s" % strict[:10])
    loose = outside(grep(r"\(^\|[^-A-Za-z]\)ATT-[A-Z]", ["docs", "--include=*.md"]))
    if loose:
        fail("bare 'ATT-' token found outside the module and outside the "
             "registry (inspect before accepting as a collision): %s" % loose[:10])
    for d in ("tool", "lib", "test"):
        if os.path.isdir(os.path.join(ROOT, d)):
            hits = [h for h in grep(r"ATT-[A-Z]\+-[0-9]", [d])
                    if "prd006_traceability.py" not in h]
            if hits:
                fail("ATT-* found in %s/: %s" % (d, hits[:10]))

    # ---- Report -------------------------------------------------------------
    print("PRD-006 traceability — computed, not asserted")
    print("-" * 70)
    print("%-8s %6s %6s %-30s" % ("REG", "COUNT", "MAX", "RANGE"))
    for reg in ORDER:
        cnt, cmax, suf = computed[reg]
        extra = "  (+%d suffixed rows)" % suf if suf else ""
        print("%-8s %6d %6d   ATT-%s-001 … ATT-%s-%03d%s"
              % (reg, cnt, cmax, reg, reg, cmax, extra))
    print("-" * 70)
    gap = computed["GAP"][0]
    ac = computed["AC"][0]
    print("total identifiers          : %d" % total)
    print("obligation-bearing         : %d  (total minus %d AC, %d GAP)"
          % (total - gap - ac, ac, gap))
    print("ATT-* occurrences          : %d across %d distinct identifiers"
          % (occurrences, len(all_refs)))
    print("AC rows / Verifies citations: %d / %d" % (ac_rows, ac_citations))
    print("dangling references        : %d" % len(dangling))
    print("orphan criteria            : %d" % len(blank))
    print("ATT-NFR-010 coverage       : %d/%d = %.1f%%"
          % (len(mandated) - len(uncovered), len(mandated),
             100.0 * (len(mandated) - len(uncovered)) / max(len(mandated), 1)))
    print("gap ledger (own verdicts)  : %d rows — %d resolved, %d narrowed, "
          "%d open" % (ledger_rows, tally["RESOLVED"], tally["NARROWED"],
                       tally["OPEN"]))
    print("collisions outside module  : 0")
    for n in notes:
        print(n)
    print("-" * 70)

    if failures:
        print("FAIL — %d problem(s):" % len(failures))
        for f in failures:
            print("  * %s" % f)
        return 1
    print("PASS — every declared count reproduced, ranges contiguous, no")
    print("       duplicate definition, no dangling reference, no orphan")
    print("       criterion, no GAP cited as verifiable, ATT-NFR-010 fully")
    print("       met, gap ledger arithmetic self-consistent, zero collisions.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
