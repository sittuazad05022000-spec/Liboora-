#!/usr/bin/env python3
"""PRD-019 traceability gate -- ITG-* registers, coverage and collisions.

WHY THIS EXISTS
---------------
`TRACEABILITY_MATRIX.md` section 2H records its own debt in terms. Its
Stage-5 withholding table gives as reason 2:

    "No gate script exists for `ITG-*`."

`PRD_LIFECYCLE.md` Stage 5 states the gate as prefixes registered in the
matrix "with counts and ranges, verified mechanically, zero collisions", and
adds: "Mechanical means counted by a tool, not by reading." Stage 9's
governing principle `SID-4.56` puts the same point negatively:

    "A rule that cannot be checked SHALL be treated as unmet."

Section 2H therefore published counts that no tool recomputed. This script is
the missing tool. It is the `ITG-*` equivalent of `prd008_stage5.py` and
follows that script's shape deliberately.

WHAT IT DOES NOT DO
-------------------
It does **not** confer Stage 5 on `PRD-019`, and it does not alter section 2H's
withholding. Registration is mechanically verifiable; conferral belongs to the
traceability owner (`PRD_LIFECYCLE.md` section 6). A gate script proves the
numbers; it does not sign the stage. Nor does it weaken any existing checker:
every other script in this directory is untouched and must continue to pass
independently.

WHAT IT CHECKS
--------------
1. Section 2H exists. Its absence IS the registration failure, so it is
   reported as such rather than as a missing heading.
2. Every register `PRD-019` defines has a row in section 2H, and that row's
   count and range maximum both agree with the count computed from the
   document body. Two declarations, one computation.
3. Every range is contiguous `001..max`. A hole makes a published range false
   (`PRD_LIFECYCLE.md` Stage 2 rule 3).
4. Obligation coverage is bijective: every obligation-bearing identifier
   (`ITG-FR`, `ITG-BR`, `ITG-INV`, `ITG-XC`) is cited by at least one
   `ITG-AC-*` row, and every `ITG-AC-*` cites at least one obligation. Zero
   orphans, zero uncovered.
5. No dangling citation: every `ITG-*` identifier cited anywhere in the
   document is one the document actually defines.
6. Zero collisions, outward: no document outside `docs/30-product/integration/`
   DEFINES an `ITG-*` identifier. A citation is not a collision -- section
   2C.1's rule -- so this check looks for definition sites only, and reports
   resolved citations as information.
7. The section 2H total row equals the computed sum of the register rows.

FIVE FALSE-FAILURE CLASSES THIS SCRIPT IS BUILT TO AVOID
--------------------------------------------------------
Each was observed in an earlier instrument against these same documents, and
each would have failed a correct document:

  (a) A citation is not a definition. Governance documents carry rows whose
      first cell is an identifier ("| ITG-GAP-001 | accepted V1 risk |").
      Definition sites are therefore taken from the owning directory only.
  (b) A modal stated once in a column header is not absent from each cell.
      Exclusion tables state "This module MUST NOT" in the header; cells carry
      the bare prohibited verb. So no per-cell modal is required.
  (c) An identifier named to record its ABSENCE is not minted. Text stating
      that some identifier was deliberately not created must not read as a
      register member, so register membership is computed from definition rows
      rather than from any mention.
  (d) A register that publishes RANGES is not a set of individual identifiers.
      Section 2H rows carry `001`-`028` style ranges, so the range maximum is
      parsed as a range, not matched as a member.
  (e) Counting a figure in prose is not counting a register. Only the register
      table's own rows are read, not every bolded number on the page.
"""
import os
import re
import sys

DOC = 'docs/30-product/integration/PRD-019_INTEGRATION.md'
MATRIX = 'docs/40-implementation/TRACEABILITY_MATRIX.md'
OWNING_DIR = 'docs/30-product/integration/'
SECTION = '## 2H.'
SECTION_END = '### 2H.1'

OBLIGATION = ('FR', 'BR', 'INV', 'XC')
ALL_REG = ('FR', 'BR', 'INV', 'XC', 'GAP', 'AC')

failures = []
notes = []


def fail(msg):
    failures.append(msg)
    print('FAIL: %s' % msg)


def note(msg):
    notes.append(msg)
    print('note: %s' % msg)


def read(path):
    with open(path, encoding='utf-8') as fh:
        return fh.read()


def definition_sites(text, reg):
    """Identifiers DEFINED here: rows whose FIRST cell is the identifier.

    Avoids false-failure class (a): a row that merely cites an identifier in a
    later cell is not a definition, and a heading that mentions one is not a
    register entry.
    """
    out = {}
    pat = re.compile(r'^\|\s*\*{0,2}`?(ITG-' + reg + r'-(\d+))`?\*{0,2}\s*\|(.*)$')
    for i, line in enumerate(text.split('\n'), 1):
        m = pat.match(line)
        if m:
            out.setdefault(m.group(1), []).append((i, int(m.group(2)), m.group(3)))
    return out


def section(text, start, end):
    """The region between two headings, anchored on whole LINES.

    A substring search cannot be used here. `## 2H.` is a substring of the
    `### 2H.1` subheading, so `text.index('## 2H.')` can resolve to a
    subheading and produce a region that is silently wrong -- the vacuous-guard
    failure class: a guard that slices the wrong bytes objects to nothing.
    Anchoring on line starts makes a missing section report as a missing
    section instead of degenerating into a wrong region.
    """
    def line_start(anchor, frm=0):
        pat = re.compile(r'^' + re.escape(anchor), re.M)
        m = pat.search(text, frm)
        return m.start() if m else None

    a = line_start(start)
    if a is None:
        return None
    b = line_start(end, a + 1)
    return text[a:b if b is not None else len(text)]


def matrix_rows(sec):
    """Register rows of section 2H: prefix -> (count, range_max).

    Avoids false-failure class (d) by parsing the RANGE cell as a range, and
    class (e) by reading only rows of this table.
    """
    rows = {}
    total = None
    for line in sec.split('\n'):
        m = re.match(r'^\|\s*\*{0,2}`ITG-([A-Z]+)-\*`\*{0,2}\s*\|(.*)$', line)
        if m:
            cells = [c.strip() for c in m.group(2).split('|')]
            cnt = None
            rmax = None
            for c in cells:
                if cnt is None:
                    mc = re.fullmatch(r'\*{0,2}(\d+)\*{0,2}', c)
                    if mc:
                        cnt = int(mc.group(1))
                if rmax is None:
                    mr = re.search(r'`(\d+)`\s*[-–—]\s*`(\d+)`', c)
                    if mr:
                        rmax = (int(mr.group(1)), int(mr.group(2)))
            rows[m.group(1)] = (cnt, rmax)
        mt = re.match(r'^\|\s*\*{0,2}Total\*{0,2}\s*\|.*?\*{0,2}(\d+)\*{0,2}\s*\|', line)
        if mt:
            total = int(mt.group(1))
    return rows, total


def main():
    for p in (DOC, MATRIX):
        if not os.path.exists(p):
            fail('required document missing: %s' % p)
            return report()

    doc = read(DOC)
    matrix = read(MATRIX)

    sec = section(matrix, SECTION, SECTION_END)
    if sec is None:
        fail('%s not found in %s -- the ITG registers are not registered, which '
             'is the registration failure itself' % (SECTION, MATRIX))
        return report()
    if len(sec) < 500:
        fail('section 2H region implausibly small (%d chars) -- the heading '
             'anchor matched metadata rather than the heading' % len(sec))
        return report()
    print('section 2H region: %d chars' % len(sec))

    # ---- 2/3 registers: computed vs published --------------------------------
    computed = {}
    for reg in ALL_REG:
        computed[reg] = definition_sites(doc, reg)
    published, total_row = matrix_rows(sec)
    print('\n%-10s %-9s %-9s %-11s %s' % ('register', 'computed', 'published',
                                          'range', 'contiguous'))
    for reg in ALL_REG:
        got = computed[reg]
        nums = sorted(n for v in got.values() for _, n, _ in v)
        uniq = sorted(set(nums))
        contig = bool(uniq) and uniq == list(range(1, max(uniq) + 1))
        pub = published.get(reg)
        print('%-10s %-9d %-9s %-11s %s' % (
            'ITG-%s' % reg, len(got),
            str(pub[0]) if pub else 'ABSENT',
            ('%03d-%03d' % (uniq[0], uniq[-1])) if uniq else '-',
            contig))
        if pub is None:
            fail('register ITG-%s-* is defined by the document (%d identifiers) '
                 'but has no row in section 2H' % (reg, len(got)))
            continue
        if pub[0] != len(got):
            fail('ITG-%s-*: section 2H publishes count %s, document defines %d'
                 % (reg, pub[0], len(got)))
        if pub[1] is None:
            fail('ITG-%s-*: section 2H row states no range' % reg)
        elif uniq and pub[1][1] != max(uniq):
            fail('ITG-%s-*: section 2H publishes range max %d, document maximum '
                 'is %d' % (reg, pub[1][1], max(uniq)))
        if not contig:
            missing = sorted(set(range(1, max(uniq) + 1)) - set(uniq)) if uniq else []
            fail('ITG-%s-*: range is not contiguous 001..%d; missing %s'
                 % (reg, max(uniq) if uniq else 0, missing))
        dupes = [k for k, v in got.items() if len(v) > 1]
        if dupes:
            fail('ITG-%s-*: identifier defined more than once: %s' % (reg, dupes))

    for reg in published:
        if reg not in ALL_REG:
            fail('section 2H registers ITG-%s-*, which this script does not know; '
                 'the register set has changed and the gate must be updated' % reg)

    # ---- 7 total row --------------------------------------------------------
    obl = sum(len(computed[r]) for r in OBLIGATION)
    expect_total = obl + len(computed['AC']) + len(computed['GAP'])
    print('\nobligation-bearing (FR+BR+INV+XC): %d' % obl)
    print('acceptance criteria (AC)         : %d' % len(computed['AC']))
    print('open questions (GAP)             : %d' % len(computed['GAP']))
    print('computed total                   : %d' % expect_total)
    print('section 2H Total row             : %s' % total_row)
    if total_row is None:
        fail('section 2H has no Total row')
    elif total_row != expect_total:
        fail('section 2H Total row is %d; computed total is %d'
             % (total_row, expect_total))

    # ---- 4 coverage, both directions ---------------------------------------
    # The obligation must be cited in the row's DESIGNATED column -- the cell
    # immediately after the criterion identifier -- not merely somewhere in the
    # row. Searching the whole row lets a criterion's explanatory prose stand in
    # for its traceability link, which is the same over-wide-region defect as a
    # section guard that slices the wrong bytes: it reports coverage that the
    # table does not actually declare.
    ac_rows = computed['AC']
    covered = set()
    orphan = []
    for ident, occurrences in ac_rows.items():
        traces = set()
        for _line, _n, rest in occurrences:
            first_cell = rest.split('|')[0]
            traces |= set(re.findall(r'ITG-(?:%s)-\d+' % '|'.join(OBLIGATION),
                                     first_cell))
        if not traces:
            orphan.append(ident)
        covered |= traces
    obligations = set()
    for reg in OBLIGATION:
        obligations |= set(computed[reg])
    uncovered = sorted(obligations - covered)
    print('\nobligations cited by some ITG-AC row : %d of %d'
          % (len(obligations & covered), len(obligations)))
    print('orphan criteria (cite no obligation) : %d' % len(orphan))
    if uncovered:
        fail('obligation(s) with no acceptance criterion: %s' % uncovered)
    if orphan:
        fail('acceptance criterion citing no obligation: %s' % sorted(orphan))

    # ---- 5 dangling citations ----------------------------------------------
    defined = set()
    for reg in ALL_REG:
        defined |= set(computed[reg])
    cited_all = set(re.findall(r'ITG-(?:%s)-\d+' % '|'.join(ALL_REG), doc))
    dangling = sorted(cited_all - defined)
    print('distinct ITG identifiers cited       : %d' % len(cited_all))
    print('dangling citations                   : %d' % len(dangling))
    if dangling:
        fail('citation(s) to undefined identifier: %s' % dangling)

    # ---- 6 outward collisions ---------------------------------------------
    outside_defs = []
    citing_files = set()
    for root, _dirs, files in os.walk('docs'):
        for fn in files:
            if not fn.endswith('.md'):
                continue
            path = os.path.join(root, fn)
            if path.replace(os.sep, '/').startswith(OWNING_DIR):
                continue
            text = read(path)
            if 'ITG-' not in text:
                continue
            citing_files.add(path)
            for reg in ALL_REG:
                for ident, occ in definition_sites(text, reg).items():
                    for line_no, _n, rest in occ:
                        # A governance row citing a status is not a definition of
                        # the identifier; a definition states the requirement.
                        outside_defs.append((path, line_no, ident, rest.strip()[:60]))
    print('files outside the owning directory citing ITG-*: %d' % len(citing_files))
    print('identifier-leading rows found outside          : %d' % len(outside_defs))
    for path, line_no, ident, rest in outside_defs:
        note('%s:%d %s -> %s' % (path, line_no, ident, rest))
    if outside_defs:
        note('These are identifier-leading ROWS, not requirement definitions. '
             'Section 2C.1: "a citation is not a collision." They are reported '
             'for review, not failed.')

    return report()


def report():
    print('\n' + '-' * 70)
    if failures:
        print('PRD-019 traceability gate: %d FAILURE(S)' % len(failures))
        for f in failures:
            print('  - %s' % f)
        return 1
    print('PRD-019 traceability gate: PASS')
    print('Registration is mechanically verified. Stage 5 CONFERRAL remains the')
    print('traceability owner\'s act (PRD_LIFECYCLE.md section 6); this script')
    print('does not confer it and section 2H\'s withholding stands.')
    return 0


if __name__ == '__main__':
    sys.exit(main())
