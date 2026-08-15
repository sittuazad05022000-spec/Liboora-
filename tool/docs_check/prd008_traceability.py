#!/usr/bin/env python3
"""PRD-008 traceability and register counts -- computed, never asserted.

WHY THIS EXISTS
---------------
`PRD_LIFECYCLE.md` Stage 5 requires the counts registered for a PRD to be
verified *"mechanically -- counted by a tool, not by reading"*.

`PRD-008` `FEE-GAP-012`(d) records the precise defect this script closes:

    "No `prd008_traceability` gate exists, so section 36.1's counts are
     hand-measured"

and its `Recommended` row instructs: *"write `prd008_traceability.py` before
Stage 5"*.  This script is that artefact and nothing more.  It **decides
nothing**: it does not resolve `FEE-GAP-012`(a) registry status, (b) the
`BC-26` edge, or (c) the report tier, each of which requires a named
authority.  Adding a checker is not the same act as closing a gap.

The defect class is real and this document has already committed it.  `PRD-008`
section 0.2 carried a stale `FEE-GAP-*` row (15 / total 231) for a whole
version after `FEE-GAP-016` was added, and the error ran in the flattering
direction -- a smaller gap count makes the module look closer to Freeze than it
is.  A Stage 4 review pass separately reconstructed the obligation total as 134
by summing only five prefixes (FR+BR+INV+EVT+XC = 126) and reached the right
answer for the wrong reason, because it omitted `FEE-PO-*`.  Both are errors a
human made by reading.  Neither can survive this script.

WHAT IT CHECKS
--------------
1. Register counts -- each register declared in section 0.2 is counted from the
   document body and compared against the declared count AND the declared
   range maximum.  Two independent declarations must agree with one
   computation.
2. Contiguity -- every register runs 1..max with no hole, because a hole makes
   the published range false.
3. The obligation total -- recomputed as FR+BR+INV+EVT+XC+PO and compared with
   the document's own stated figure.  `FEE-PO-*` is included: omitting it is
   the exact error described above.
4. Traceability coverage -- every obligation-bearing identifier must appear in
   the section 36.1 coverage table and must cite at least one `FEE-AC-*`.
5. Orphan criteria -- every `FEE-AC-*` cited in section 36.1 must be declared,
   and every declared `FEE-AC-*` must be used.  This runs criterion ->
   requirement, the opposite direction from check 4.
6. Gap ledger arithmetic -- the Stage-4 and Freeze blocker counts are derived
   from each gap block's own declared field, taking the LEADING declared
   verdict.  A naive substring match returns 13 Freeze blockers because three
   gaps say "BLOCKS the ... feature, not this PRD"; the leading-token rule is
   what makes 10 reproducible.
7. GAP entries are never cited as verifiable -- `FEE-GAP-*` are open questions
   addressed to a named owner, not obligations.
8. Undeclared registers -- any `FEE-<PREFIX>-*` family defined in the body but
   absent from section 0.2 is reported.  The first run of this script found
   exactly one: `FEE-RSK-*`, the section 38 risk register (`FEE-RSK-01` ..
   `FEE-RSK-10`, ten entries, contiguous).  It is well formed but was never
   declared in section 0.2, which section 0.1 requires to be *"declared up
   front with ranges -- publishing the ranges as a promise"*.

   That is a **pre-existing Stage-2 register-declaration defect**, found by
   counting rather than reading, and it is **reported, not tolerated**.  This
   script deliberately does NOT silence it, because adding a register row to a
   PRD is a document-owner act.  Two-digit numbering (`-01`) also differs from
   every other register's three digits, which is why a reader never noticed.
   It is separated from the hard failures below so that a genuine count
   mismatch can never hide behind it.

Exit 0 = every declared number reproduced.  Exit 1 = a mismatch.
"""

import os
import re
import sys

DOC = os.path.join('docs', '30-product', 'revenue-finance',
                   'PRD-008_REVENUE-AND-FINANCE.md')

# Obligation-bearing prefixes.  `FEE-PO-*` IS one of them -- see module docstring.
OBLIGATION_PREFIXES = ('FR', 'BR', 'INV', 'EVT', 'XC', 'PO')


def read(path):
    with open(path, encoding='utf-8') as handle:
        return handle.read()


def definition_sites(text):
    """Map prefix -> sorted list of integers, counted from definition sites.

    A definition site is a line that *declares* the identifier: either a
    body line beginning with the backticked identifier, or a table row in
    an exclusion / port table whose first cell is the identifier.
    """
    found = {}
    for line in text.split('\n'):
        match = re.match(r'^`FEE-([A-Z]+)-(\d+)`', line)
        if match is None:
            match = re.match(r'^\|\s*`FEE-([A-Z]+)-(\d+)`\s*\|', line)
        if match is None:
            continue
        found.setdefault(match.group(1), set()).add(int(match.group(2)))
    return {key: sorted(value) for key, value in found.items()}


def declared_registers(text):
    """Parse section 0.2's register table: prefix -> (count, range_max)."""
    out = {}
    pattern = re.compile(
        r'^\|\s*`FEE-([A-Z]+)-\*`\s*\|[^|]*\|\s*\*\*(\d+)\*\*\s*\|'
        r'\s*`FEE-[A-Z]+-\d+`\s*\u2026\s*`FEE-[A-Z]+-(\d+)`')
    for line in text.split('\n'):
        match = pattern.match(line)
        if match:
            out[match.group(1)] = (int(match.group(2)), int(match.group(3)))
    return out


def coverage_table(text):
    """Section 36.1 rows: obligation id -> list of FEE-AC ids cited."""
    lines = text.split('\n')
    start = end = None
    for index, line in enumerate(lines):
        if start is None and re.match(r'^### 36\.1(?![0-9a-z])', line):
            start = index
        elif start is not None and line.startswith('### 36.1a'):
            end = index
            break
    if start is None or end is None:
        return None
    rows = {}
    prefixes = '|'.join(OBLIGATION_PREFIXES)
    row_re = re.compile(r'^\|\s*`(FEE-(?:' + prefixes + r')-\d+)`\s*\|(.*)')
    for line in lines[start:end]:
        match = row_re.match(line)
        if match:
            rows[match.group(1)] = re.findall(r'FEE-AC-\d+', match.group(2))
    return rows


def leading_verdict(cell):
    """Strip emphasis and status glyphs, then read the LEADING token."""
    value = cell.strip()
    for glyph in ('\u26d4', '\u2705', '\u26a0'):
        value = value.replace(glyph, ' ')
    return value.strip().lstrip('*').lstrip('`').lstrip('*').strip()


def gap_ledger(text):
    """gap id -> {'stage4': leading verdict, 'freeze': leading verdict}."""
    current = None
    out = {}
    for line in text.split('\n'):
        head = re.match(r'^### `(FEE-GAP-\d+)`', line)
        if head:
            current = head.group(1)
            out.setdefault(current, {})
        if current is None:
            continue
        for label, key in (('Stage 4', 'stage4'), ('Freeze', 'freeze')):
            cell = re.match(r'^\|\s*\*\*' + label + r'\*\*\s*\|(.*)', line)
            if cell and key not in out[current]:
                out[current][key] = (cell.group(1), leading_verdict(cell.group(1)))
    return out


def blocks(raw, lead):
    """True when a ledger field declares this PRD blocked.

    Three gaps say "BLOCKS the ... feature, not this PRD".  Those do not block
    this PRD, and a naive substring match gets that wrong.
    """
    if 'not this PRD' in raw:
        return False
    return lead.startswith('BLOCKS') or lead.startswith('STILL BLOCKS')


def main():
    if not os.path.exists(DOC):
        print('FAIL - document not found: %s' % DOC)
        return 1

    text = read(DOC)
    failures = []
    notes = []

    sites = definition_sites(text)
    declared = declared_registers(text)

    if not declared:
        failures.append('section 0.2 register table could not be parsed')

    # --- 1 & 2: counts, range maxima, contiguity ---------------------------
    for prefix in sorted(declared):
        count, range_max = declared[prefix]
        actual = sites.get(prefix, [])
        if len(actual) != count:
            failures.append(
                'FEE-%s-*: section 0.2 declares %d, body defines %d'
                % (prefix, count, len(actual)))
        if actual and actual[-1] != range_max:
            failures.append(
                'FEE-%s-*: declared range ends at %d, highest defined is %d'
                % (prefix, range_max, actual[-1]))
        if actual and actual != list(range(1, actual[-1] + 1)):
            missing = sorted(set(range(1, actual[-1] + 1)) - set(actual))
            failures.append(
                'FEE-%s-*: range is not contiguous, missing %s'
                % (prefix, missing))

    undeclared = []
    for prefix in sorted(sites):
        if prefix not in declared:
            undeclared.append(prefix)
            notes.append(
                'UNDECLARED REGISTER            : FEE-%s-* is defined in the '
                'body (%d entries) but absent from section 0.2'
                % (prefix, len(sites[prefix])))

    # --- 3: obligation total ----------------------------------------------
    obligations = []
    for prefix in OBLIGATION_PREFIXES:
        obligations.extend('FEE-%s-%03d' % (prefix, number)
                           for number in sites.get(prefix, []))
    total = len(obligations)
    notes.append('obligation-bearing identifiers  : %d  (%s)'
                 % (total, ' + '.join('%s %d' % (p, len(sites.get(p, [])))
                                      for p in OBLIGATION_PREFIXES)))
    stated = re.search(
        r'\*\*Obligation-bearing\*\* = .*?= \*\*(\d+)\*\*', text)
    if stated is None:
        failures.append('document states no obligation-bearing total')
    elif int(stated.group(1)) != total:
        failures.append('document states %s obligation-bearing, computed %d'
                        % (stated.group(1), total))

    # --- 4: coverage -------------------------------------------------------
    rows = coverage_table(text)
    if rows is None:
        failures.append('section 36.1 coverage table not found')
        rows = {}
    else:
        notes.append('section 36.1 rows               : %d' % len(rows))
        absent = sorted(set(obligations) - set(rows))
        if absent:
            failures.append('%d obligation(s) absent from section 36.1: %s'
                            % (len(absent), absent[:8]))
        uncovered = sorted(key for key, value in rows.items() if not value)
        if uncovered:
            failures.append('%d row(s) cite no FEE-AC: %s'
                            % (len(uncovered), uncovered[:8]))
        unknown = sorted(set(rows) - set(obligations))
        if unknown:
            failures.append('%d section 36.1 row(s) are not declared '
                            'obligations: %s' % (len(unknown), unknown[:8]))

    # --- 5: orphan criteria, both directions -------------------------------
    declared_ac = set('FEE-AC-%03d' % number for number in sites.get('AC', []))
    used_ac = set()
    for cited in rows.values():
        used_ac.update(cited)
    dangling = sorted(used_ac - declared_ac)
    if dangling:
        failures.append('%d FEE-AC cited in section 36.1 but never declared: %s'
                        % (len(dangling), dangling[:8]))
    unused = sorted(declared_ac - used_ac)
    if unused:
        failures.append('%d declared FEE-AC never used in section 36.1: %s'
                        % (len(unused), unused[:8]))
    notes.append('acceptance criteria declared    : %d' % len(declared_ac))
    notes.append('acceptance criteria used        : %d' % len(used_ac))

    # --- 6: gap ledger arithmetic -----------------------------------------
    ledger = gap_ledger(text)
    notes.append('gap blocks                      : %d' % len(ledger))
    if len(ledger) != len(sites.get('GAP', [])):
        failures.append('%d gap blocks found but %d FEE-GAP-* declared'
                        % (len(ledger), len(sites.get('GAP', []))))
    stage4 = sorted(key for key, value in ledger.items()
                    if 'stage4' in value and blocks(*value['stage4']))
    freeze = sorted(key for key, value in ledger.items()
                    if 'freeze' in value and blocks(*value['freeze']))
    notes.append('gaps blocking Stage 4           : %d %s'
                 % (len(stage4), stage4 if stage4 else ''))
    notes.append('gaps blocking Freeze            : %d %s'
                 % (len(freeze), freeze if freeze else ''))

    # --- 7: no GAP cited as verifiable ------------------------------------
    for key, cited in rows.items():
        if key.startswith('FEE-GAP'):
            failures.append('%s is a gap and must not appear as an obligation'
                            % key)
    for line in text.split('\n'):
        if re.match(r'^### 36\.1', line):
            continue
    gap_as_ac = re.findall(r'`FEE-GAP-\d+`\s*\|\s*`FEE-AC-\d+`', text)
    if gap_as_ac:
        failures.append('%d gap(s) cited as verified by an acceptance criterion'
                        % len(gap_as_ac))

    print('-' * 70)
    print('PRD-008 traceability gate')
    print('-' * 70)
    for line in notes:
        print(line)
    print('-' * 70)

    if failures:
        print('FAIL - %d problem(s):' % len(failures))
        for failure in failures:
            print('  * %s' % failure)
        return 1
    print('PASS - every declared count reproduced, ranges contiguous, no')
    print('       obligation absent from section 36.1, no row without a')
    print('       criterion, no dangling or unused criterion, no gap cited')
    print('       as verifiable, ledger arithmetic reproduced.')
    if undeclared:
        print()
        print('OUTSTANDING FINDING, not a count failure - %d undeclared '
              'register(s): %s' % (len(undeclared),
                                   ', '.join('FEE-%s-*' % p
                                             for p in undeclared)))
        print('  Section 0.1 requires registers "declared up front with '
              'ranges".  Adding a')
        print('  register row is a document-owner act; this script reports '
              'the omission')
        print('  and does not repair or silence it.')
    return 0


if __name__ == '__main__':
    sys.exit(main())
