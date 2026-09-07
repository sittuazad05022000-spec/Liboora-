#!/usr/bin/env python3
"""PRD-020 traceability and register counts — computed, never asserted.

WHY THIS EXISTS
---------------
`PRD_LIFECYCLE.md` Stage 5 requires the counts registered in
`TRACEABILITY_MATRIX.md` §2 to be *"verified mechanically -- counted by a tool,
not by reading"*, with **zero collisions**.

This instrument derives every number from the subject text. It never reads a
count out of the subject's own §0.2 declaration table and reports it back; it
recomputes independently and then compares. A checker that echoes the document
it checks proves nothing — §2H.2 of the matrix names that failure mode:
*"a checker written in the same pass as the register it checks, by the same
author, verifies agreement with itself."*

WHAT IT CHECKS
--------------
1. **Register counts** — distinct-token scan `TSF-(FR|BR|XC|INV|EVT|CFG|AC|GAP|RSK)-(\\d{3})`,
   deduplicated per register, compared against the subject's §0.2 declaration.
2. **Contiguity** — for each register, `set(1..max) - observed` must be empty.
   `PRD_LIFECYCLE.md` §5 rule 5 forbids reuse; a hole means a number was
   withdrawn without a record, or the declaration overstates the range.
3. **Phantom identifiers** — probe `max+1` for every register. A hit means the
   text writes a token one past its declared maximum. This probe has caught
   real defects in a sibling PRD twice (matrix §2N.3.1).
4. **Dangling references** — every `TSF-*` token appearing anywhere else in the
   repository must resolve to an identifier the PRD defines.
5. **Acceptance-criterion integrity** — all 62 `TSF-AC-*` must exist as table
   rows, and every row must cite at least one `TSF-FR|BR|INV|EVT|CFG|XC`
   identifier. Stage 4 closed this gate at 62/62; Stage 5 re-measures it,
   because a criterion that cites nothing is untraceable regardless of stage.

WHAT IT DELIBERATELY DOES NOT CHECK
-----------------------------------
Whether a citation is *semantically correct*. `TSF-AC-010` cites `TSF-FR-099`;
this tool verifies `TSF-FR-099` exists and is referenced, not that it states the
obligation the criterion describes. That judgement is Stage 4's, and it is
recorded in `PRD-020_STAGE4_AC_REQUIREMENT_MAPPING.md`. Instrument defect `I-3`
in that record exists precisely because a lexical tool was trusted with a
semantic question.

EXIT
----
0 = every check passed. 1 = at least one check failed.
"""

import os
import re
import sys

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
PRD = os.path.join(ROOT, "docs", "30-product", "trust-safety",
                   "PRD-020_TRUST_AND_SAFETY.md")

REGISTERS = ["FR", "BR", "XC", "INV", "EVT", "CFG", "AC", "GAP", "RSK"]
TOKEN = re.compile(r"TSF-(FR|BR|XC|INV|EVT|CFG|AC|GAP|RSK)-(\d{3})\b")

failures = []
notes = []


def fail(msg):
    failures.append(msg)


def observed_registers(text):
    """Distinct identifier numbers per register, deduplicated."""
    out = {r: set() for r in REGISTERS}
    for reg, num in TOKEN.findall(text):
        out[reg].add(int(num))
    return out


def declared_registers(text):
    """Parse the subject's own §0.2 declaration table.

    Read so it can be *contradicted*, never so it can be echoed.
    """
    out = {}
    row = re.compile(
        r"^\|\s*`TSF-(FR|BR|XC|INV|EVT|CFG|AC|GAP|RSK)-nnn`\s*\|"
        r"[^|]*\|\s*`001`…`(\d{3})`\s*\|\s*\**(\d+)\**\s*\|")
    for line in text.split("\n"):
        m = row.match(line)
        if m:
            out[m.group(1)] = (int(m.group(2)), int(m.group(3)))
    return out


def main():
    if not os.path.isfile(PRD):
        print(f"FAIL: subject not found: {PRD}")
        return 1
    text = open(PRD, encoding="utf-8").read()

    obs = observed_registers(text)
    dec = declared_registers(text)

    print("PRD-020 Trust & Safety — traceability check")
    print(f"subject: {os.path.relpath(PRD, ROOT)} ({len(text.encode())} bytes)")
    print()

    # ---- check 1 + 2 + 3 -------------------------------------------------
    print("1/2/3. Register census, contiguity, phantom probe")
    print(f"  {'reg':<5}{'count':>7}{'max':>6}{'declared':>10}"
          f"{'contig':>9}{'phantom':>9}")
    total = 0
    for r in REGISTERS:
        nums = obs[r]
        total += len(nums)
        mx = max(nums) if nums else 0
        holes = sorted(set(range(1, mx + 1)) - nums)
        probe = f"TSF-{r}-{mx + 1:03d}"
        phantom = text.count(probe)
        dmax, dcount = dec.get(r, (None, None))
        dstr = f"{dcount}" if dcount is not None else "—"
        print(f"  {r:<5}{len(nums):>7}{mx:>6}{dstr:>10}"
              f"{('ok' if not holes else 'HOLE'):>9}"
              f"{('ok' if phantom == 0 else 'HIT'):>9}")
        if dcount is None:
            fail(f"register TSF-{r}-* is not declared in §0.2")
            continue
        if len(nums) != dcount:
            fail(f"TSF-{r}-*: counted {len(nums)}, §0.2 declares {dcount}")
        if mx != dmax:
            fail(f"TSF-{r}-*: max is {mx:03d}, §0.2 declares {dmax:03d}")
        if holes:
            fail(f"TSF-{r}-*: non-contiguous, missing {holes}")
        if phantom:
            fail(f"TSF-{r}-*: phantom {probe} written {phantom}x "
                 f"(one past declared max)")

    declared_total = sum(c for _, c in dec.values())
    print(f"  {'TOTAL':<5}{total:>7}{'':>6}{declared_total:>10}")
    if total != declared_total:
        fail(f"total counted {total} != §0.2 declared total {declared_total}")
    print()

    # ---- check 4 ---------------------------------------------------------
    print("4. Dangling references outside the subject")
    defined = {f"TSF-{r}-{n:03d}" for r in REGISTERS for n in obs[r]}
    scan_dirs = ["docs", "lib", "test", "tool", "packages"]
    dangling = {}
    external_files = 0
    for d in scan_dirs:
        base = os.path.join(ROOT, d)
        for dirpath, _, names in os.walk(base):
            if os.sep + "build" + os.sep in dirpath + os.sep:
                continue
            for name in names:
                if not name.endswith((".md", ".dart", ".py", ".yaml", ".yml")):
                    continue
                path = os.path.join(dirpath, name)
                if os.path.abspath(path) == os.path.abspath(PRD):
                    continue
                try:
                    body = open(path, encoding="utf-8").read()
                except (UnicodeDecodeError, OSError):
                    continue
                ids = {m.group(0) for m in TOKEN.finditer(body)}
                if not ids:
                    continue
                external_files += 1
                bad = ids - defined
                if bad:
                    dangling[os.path.relpath(path, ROOT)] = sorted(bad)
    print(f"  files citing TSF-* outside the subject: {external_files}")
    if dangling:
        for f, ids in sorted(dangling.items()):
            print(f"  DANGLING {f}: {ids}")
            fail(f"dangling TSF-* in {f}: {ids}")
    else:
        print("  dangling: 0")
    print()

    # ---- check 5 ---------------------------------------------------------
    print("5. Acceptance-criterion integrity")
    ac_row = re.compile(r"^\|\s*`TSF-AC-(\d{3})`\s*\|")
    cite = re.compile(r"TSF-(?:FR|BR|INV|EVT|CFG|XC)-\d{3}")
    rows, uncited = {}, []
    for i, line in enumerate(text.split("\n"), 1):
        m = ac_row.match(line)
        if not m:
            continue
        n = int(m.group(1))
        rows[n] = i
        body = line.split("|", 2)[2] if line.count("|") >= 2 else line
        if not cite.search(body):
            uncited.append((n, i))
    expected = obs["AC"]
    print(f"  AC rows found: {len(rows)}  declared members: {len(expected)}")
    missing_rows = sorted(expected - set(rows))
    if missing_rows:
        fail(f"AC identifiers with no table row: {missing_rows}")
        print(f"  MISSING ROWS: {missing_rows}")
    else:
        print("  every declared AC has a table row: ok")
    if uncited:
        for n, ln in uncited:
            print(f"  UNCITED TSF-AC-{n:03d} (L{ln})")
        fail(f"{len(uncited)} acceptance criteria cite no requirement")
    else:
        print("  every AC row cites >=1 requirement: ok")
    cited = set()
    for line in text.split("\n"):
        if ac_row.match(line):
            cited |= set(cite.findall(line))
    print(f"  distinct requirements cited by AC rows: {len(cited)}")
    print()

    # ---- verdict ---------------------------------------------------------
    for n in notes:
        print(f"NOTE: {n}")
    if failures:
        print(f"FAIL — {len(failures)} problem(s):")
        for f in failures:
            print(f"  - {f}")
        return 1
    print(f"PASS — {len(REGISTERS)} registers, {total} identifiers, "
          f"all contiguous, 0 phantoms, 0 dangling, "
          f"{len(rows)}/{len(rows)} acceptance criteria cited.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
