#!/usr/bin/env python3
"""PRD-020 Stage 5 — does `TRACEABILITY_MATRIX.md` §2O tell the truth?

WHY THIS EXISTS
---------------
`prd020_traceability.py` measures the **subject**. This instrument measures the
**registration**. They are deliberately separate programs with separate parsers,
because Stage 5's gate is not "the PRD is internally consistent" — it is "the
matrix records counts that are *verified mechanically*, with zero collisions".

A single tool that both computed the counts and wrote them into the matrix would
be checking its own output. Matrix §2H.2: *"a checker written in the same pass as
the register it checks, by the same author, verifies agreement with itself."*
So this program re-derives every number from the PRD **from scratch**, parses
what §2O actually claims, and fails on any disagreement. The two instruments can
disagree with each other; when they do, the disagreement is the finding.

WHAT IT CHECKS
--------------
1. **§2O exists** in `TRACEABILITY_MATRIX.md` and is the section registering
   `PRD-020` / the `TSF-` prefix stem.
2. **Inventory table agreement** — every per-register count, range maximum and
   "next free" cell in §2O.0 matches an independent recomputation from the PRD.
3. **Total agreement** — the §2O total equals the sum of the recomputed
   registers.
4. **Header-field agreement** — the `Registers`, `Identifiers` and
   `Acceptance criteria` cells in the §2O header table match measurement.
5. **Collision freedom, four directions**:
   a. `TSF-` appears in no §2 section of the matrix other than §2O;
   b. no other prefix stem in the repository collides with `TSF-`;
   c. no near-miss stem (`TS-`, `TSA-`, `TFS-`, `TNS-`) is in use;
   d. no identifier defined by PRD-020 is also defined by another PRD.
6. **Matrix version bumped** — §2O's introduction must be accompanied by a
   changelog row, so the registration is dated and attributable.

EXIT
----
0 = the registration is truthful. 1 = the matrix and the subject disagree.
"""

import os
import re
import sys

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
PRD = os.path.join(ROOT, "docs", "30-product", "trust-safety",
                   "PRD-020_TRUST_AND_SAFETY.md")
MATRIX = os.path.join(ROOT, "docs", "40-implementation",
                      "TRACEABILITY_MATRIX.md")

REGISTERS = ["FR", "BR", "XC", "INV", "EVT", "CFG", "AC", "GAP", "RSK"]
TOKEN = re.compile(r"TSF-(FR|BR|XC|INV|EVT|CFG|AC|GAP|RSK)-(\d{3})\b")

failures = []


def fail(msg):
    failures.append(msg)


def recompute():
    """Independent recomputation from the PRD. Shares no code with §2O."""
    text = open(PRD, encoding="utf-8").read()
    out = {r: set() for r in REGISTERS}
    for reg, num in TOKEN.findall(text):
        out[reg].add(int(num))
    ac_row = re.compile(r"^\|\s*`TSF-AC-(\d{3})`\s*\|")
    ac_rows = sum(1 for line in text.split("\n") if ac_row.match(line))
    return out, ac_rows


def extract_section(text, heading_re, stop_re):
    lines = text.split("\n")
    start = None
    for i, line in enumerate(lines):
        if re.match(heading_re, line):
            start = i
            break
    if start is None:
        return None, None
    for j in range(start + 1, len(lines)):
        if re.match(stop_re, lines[j]):
            return "\n".join(lines[start:j]), start + 1
    return "\n".join(lines[start:]), start + 1


def main():
    for p in (PRD, MATRIX):
        if not os.path.isfile(p):
            print(f"FAIL: not found: {p}")
            return 1

    obs, ac_rows = recompute()
    mtext = open(MATRIX, encoding="utf-8").read()

    print("PRD-020 Stage 5 — matrix §2O vs independent recomputation")
    print()

    # ---- check 1 ---------------------------------------------------------
    print("1. §2O present")
    sec, secline = extract_section(mtext, r"^## 2O\.", r"^## (?!2O)")
    if sec is None:
        fail("TRACEABILITY_MATRIX.md has no `## 2O.` section — "
             "PRD-020 is not registered")
        print("  ABSENT")
        print()
        print(f"FAIL — {len(failures)} problem(s):")
        for f in failures:
            print(f"  - {f}")
        return 1
    print(f"  found at L{secline} ({len(sec.split(chr(10)))} lines)")
    if "PRD-020" not in sec:
        fail("§2O does not name PRD-020")
    if "TSF-" not in sec:
        fail("§2O does not name the TSF- prefix stem")
    print()

    # ---- check 2 + 3 -----------------------------------------------------
    print("2/3. Inventory table agreement")
    # The "next free" cell is either a three-digit number or an explicit
    # refusal. A CLOSED register has no next free member — writing `max+1`
    # there creates the very phantom the register's closure forbids, which is
    # exactly how this check earned its keep (see §2O.4 `I-4`).
    row = re.compile(
        r"^\|\s*`TSF-(FR|BR|XC|INV|EVT|CFG|AC|GAP|RSK)-NNN`\s*\|"
        r"[^|]*\|\s*\**(\d+)\**\s*\|\s*`001`…`(\d{3})`\s*\|"
        r"([^|]*)\|\s*([^|]*?)\s*\|")
    claimed = {}
    closed = set()
    for line in sec.split("\n"):
        m = row.match(line)
        if not m:
            continue
        reg = m.group(1)
        if "CLOSED" in m.group(4):
            closed.add(reg)
        nxt = re.search(r"`?(\d{3})`?", m.group(5))
        claimed[reg] = (int(m.group(2)), int(m.group(3)),
                        int(nxt.group(1)) if nxt else None)
    print(f"  {'reg':<5}{'claimed':>9}{'measured':>10}{'max':>6}{'next':>6}")
    total_claimed = 0
    total_measured = 0
    for r in REGISTERS:
        measured = len(obs[r])
        mx = max(obs[r]) if obs[r] else 0
        total_measured += measured
        if r not in claimed:
            fail(f"§2O.0 has no inventory row for TSF-{r}-*")
            print(f"  {r:<5}{'MISSING':>9}{measured:>10}{mx:>6}{'':>6}")
            continue
        c_count, c_max, c_next = claimed[r]
        total_claimed += c_count
        shown = "CLOSED" if r in closed else (
            f"{c_next:03d}" if c_next is not None else "—")
        print(f"  {r:<5}{c_count:>9}{measured:>10}{mx:>6}{shown:>8}")
        if c_count != measured:
            fail(f"§2O.0 TSF-{r}-*: claims {c_count}, measured {measured}")
        if c_max != mx:
            fail(f"§2O.0 TSF-{r}-*: claims max {c_max:03d}, "
                 f"measured {mx:03d}")
        if r in closed:
            # A closed register must NOT publish a numeric next-free cell.
            if c_next is not None:
                fail(f"§2O.0 TSF-{r}-* is CLOSED but publishes next free "
                     f"{c_next:03d} — a closed register has no next member "
                     f"until an ADR says so, and writing the token creates "
                     f"a phantom")
        elif c_next != mx + 1:
            fail(f"§2O.0 TSF-{r}-*: claims next free {c_next}, "
                 f"measured {mx + 1:03d}")
    print(f"  {'TOT':<5}{total_claimed:>9}{total_measured:>10}")
    if total_claimed != total_measured:
        fail(f"§2O.0 total {total_claimed} != measured {total_measured}")
    mt = re.search(r"^\|\s*\*\*Total\*\*\s*\|[^|]*\|\s*\*\*(\d+)\*\*\s*\|",
                   sec, re.M)
    if mt:
        if int(mt.group(1)) != total_measured:
            fail(f"§2O.0 Total row says {mt.group(1)}, "
                 f"measured {total_measured}")
        else:
            print(f"  Total row: {mt.group(1)} ok")
    else:
        fail("§2O.0 has no **Total** row")
    print()

    # ---- check 4 ---------------------------------------------------------
    print("4. Header-field agreement")

    def header(field):
        m = re.search(r"^\|\s*\*\*" + field + r"\*\*\s*\|(.*)$", sec, re.M)
        return m.group(1) if m else None

    hregs = header("Registers")
    if hregs is None:
        fail("§2O header has no **Registers** row")
    else:
        n = re.search(r"\*\*(\d+)\*\*", hregs)
        got = int(n.group(1)) if n else None
        print(f"  Registers: claims {got}, measured {len(REGISTERS)}")
        if got != len(REGISTERS):
            fail(f"§2O Registers claims {got}, measured {len(REGISTERS)}")

    hids = header("Identifiers")
    if hids is None:
        fail("§2O header has no **Identifiers** row")
    else:
        n = re.search(r"\*\*(\d+)\*\*", hids)
        got = int(n.group(1)) if n else None
        print(f"  Identifiers: claims {got}, measured {total_measured}")
        if got != total_measured:
            fail(f"§2O Identifiers claims {got}, measured {total_measured}")

    hac = header("Acceptance criteria")
    if hac is None:
        fail("§2O header has no **Acceptance criteria** row")
    else:
        n = re.search(r"\*\*(\d+)\*\*", hac)
        got = int(n.group(1)) if n else None
        print(f"  Acceptance criteria: claims {got}, measured {ac_rows}")
        if got != ac_rows:
            fail(f"§2O Acceptance criteria claims {got}, measured {ac_rows}")
    print()

    # ---- check 5 ---------------------------------------------------------
    print("5. Collision freedom, four directions")

    # (a) TSF- confined to §2O among the §2* inventory sections.
    #
    # Scoped to §2* deliberately. An earlier revision of this check failed the
    # run because §11 (change history) cites `TSF-` in the v1.20 changelog row
    # — which is required, not a defect. The §2C.1 principle governs: *a
    # citation is not a collision*. What Stage 5 actually forbids is a second
    # inventory section registering the same stem, so the test is confined to
    # the sections that register inventories, and the changelog is exempt
    # because a registration that could not be described in the changelog
    # could not be dated or attributed either.
    outside = []
    cur = None
    for i, line in enumerate(mtext.split("\n"), 1):
        h = re.match(r"^## (\S+)", line)
        if h:
            cur = h.group(1).rstrip(".")
        if "TSF-" in line and cur != "2O" and cur and cur.startswith("2"):
            outside.append((i, cur))
    print(f"  (a) TSF- in a §2* section other than §2O: {len(outside)}")
    if outside:
        for i, s in outside[:5]:
            print(f"      L{i} in §{s}")
        fail(f"TSF- appears in {len(outside)} §2* line(s) outside §2O")

    # (b) prefix-stem collision
    stem = re.compile(r"\b([A-Z][A-Z0-9]{1,6})-"
                      r"(?:FR|BR|XC|INV|EVT|CFG|AC|GAP|RSK)-\d{3}\b")
    stems = set()
    for dirpath, _, names in os.walk(os.path.join(ROOT, "docs")):
        for name in names:
            if not name.endswith(".md"):
                continue
            try:
                body = open(os.path.join(dirpath, name),
                            encoding="utf-8").read()
            except (UnicodeDecodeError, OSError):
                continue
            stems |= {m.group(1) for m in stem.finditer(body)}
    print(f"  (b) distinct prefix stems in docs/: {len(stems)}")
    if "TSF" not in stems:
        fail("TSF stem not observed in docs/ — measurement is broken")
    conflict = {s for s in stems if s != "TSF" and
                (s.startswith("TSF") or "TSF".startswith(s))}
    if conflict:
        fail(f"prefix stems collide with TSF: {sorted(conflict)}")
    print(f"      colliding with TSF: {sorted(conflict) if conflict else 0}")

    # (c) near-miss stems
    near = re.compile(r"\b(TS|TSA|TFS|TNS|TSFY)-"
                      r"(?:FR|BR|XC|INV|EVT|CFG|AC|GAP|RSK)-\d{3}\b")
    nearhits = set()
    for dirpath, _, names in os.walk(os.path.join(ROOT, "docs")):
        for name in names:
            if not name.endswith(".md"):
                continue
            try:
                body = open(os.path.join(dirpath, name),
                            encoding="utf-8").read()
            except (UnicodeDecodeError, OSError):
                continue
            nearhits |= {m.group(0) for m in near.finditer(body)}
    print(f"  (c) near-miss stems (TS/TSA/TFS/TNS): {len(nearhits)}")
    if nearhits:
        fail(f"near-miss identifiers in use: {sorted(nearhits)[:8]}")

    # (d) TSF-* defined by any other PRD
    others = []
    pdir = os.path.join(ROOT, "docs", "30-product")
    for dirpath, _, names in os.walk(pdir):
        for name in names:
            if not name.endswith(".md"):
                continue
            path = os.path.join(dirpath, name)
            if os.path.abspath(path) == os.path.abspath(PRD):
                continue
            if os.sep + "trust-safety" + os.sep in path:
                continue
            try:
                body = open(path, encoding="utf-8").read()
            except (UnicodeDecodeError, OSError):
                continue
            if re.search(r"^\|\s*`TSF-", body, re.M):
                others.append(os.path.relpath(path, ROOT))
    print(f"  (d) other PRDs defining TSF-* rows: {len(others)}")
    if others:
        fail(f"TSF-* defined outside PRD-020: {others}")
    print()

    # ---- check 6 ---------------------------------------------------------
    print("6. Changelog row for the §2O registration")
    ver = re.search(r"^\|\s*\*\*Version\*\*\s*\|\s*\*\*(v[\d.]+)\*\*",
                    mtext, re.M)
    version = ver.group(1) if ver else None
    print(f"  matrix version: {version}")
    if version is None:
        fail("matrix has no **Version** header row")
    else:
        chg = [l for l in mtext.split("\n")
               if l.startswith("|") and version in l and "2O" in l]
        if not chg:
            fail(f"no changelog row mentions §2O at {version}")
        else:
            print(f"  changelog row for {version} mentioning §2O: found")
    print()

    if failures:
        print(f"FAIL — {len(failures)} problem(s):")
        for f in failures:
            print(f"  - {f}")
        return 1
    print(f"PASS — §2O registers {total_measured} identifiers across "
          f"{len(REGISTERS)} registers; every count, range and next-free cell "
          f"agrees with independent recomputation; zero collisions in four "
          f"directions.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
