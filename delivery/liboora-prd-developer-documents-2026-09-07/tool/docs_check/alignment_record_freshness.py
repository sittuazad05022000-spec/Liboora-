#!/usr/bin/env python3
"""Alignment-record freshness gate.

WHAT THIS EXISTS FOR
--------------------
A Stage 3 or Stage 4 review record measures a PRD *at a revision*. It records
that revision in a "PRD hash at review" row. When the PRD is then revised, the
record's measurement silently becomes a statement about a document that no
longer exists -- while still reading as a current verdict.

That is the single most frequently recorded defect class in this repository's
governance ledger:

    GCP-01  DOCUMENTATION_BASELINE SS3.2 fell behind two Rank 4 documents
    GCP-07  SS4 and the Rank 2 row fell behind two freezes
    GCP-08  PRD_REGISTRY SS4.1 prose contradicted its own table
    GCP-11  three derived statements in one declaration drifted at once

`GCP-11` states the conclusion this file acts on, verbatim:

    "every one of these is mechanically checkable ... which is evidence that
     the control is UNENFORCEABLE BY DILIGENCE ... Prevention is therefore
     recorded as a gate that does not yet exist rather than as a promise to be
     more careful."

This is that gate, for alignment records.

WHAT IT DOES **NOT** DO
-----------------------
It does not confer Stage 3 or Stage 4. It does not decide whether a stale
record's verdict is still correct -- only a reviewer can decide that. It
reports the drift and names the role that must act. A gate that quietly
"refreshed" a verdict would be the very self-certification the lifecycle
forbids: "A green gate signed by the author of the thing being gated is not
a gate."

FALSE-FAILURE CLASSES THIS IS BUILT TO AVOID
--------------------------------------------
1. A guard that matches nothing passes vacuously. Every record below must
   yield a subject path AND at least one 64-hex candidate, or the run FAILS
   with "anchor missing" rather than silently reporting clean.
2. Superseded hashes are evidence, not errors. These records deliberately
   retain prior hashes ("the v1.1 hash ... is superseded"). Finding an old
   hash in the text is therefore NORMAL; the test is whether the CURRENT PRD
   hash appears anywhere in the record, not whether old ones do.
3. A record's prose commit reference can disagree with its hash row. The
   PRD-008 record says "Reviewed at 36bd461" but PRD-008 at 36bd461 hashes to
   the value that record itself labels *superseded*. Hashes are resolved
   against content, never against a commit named in prose.
4. **A stale base record may be lawfully corrected by a SUPPLEMENT, not by an
   in-place edit.** This is not a courtesy -- it is the mechanism the baselined
   PRD-006 precedent mandates:

       "A stale review is corrected by a dated re-run beside it, not by
        editing what it concluded."
       -- PRD-006_ARCHITECTURE_ALIGNMENT_V19_SUPPLEMENT.md L8, admitted as a
          validation record by DOCUMENTATION_BASELINE.md SS3.3 L171

   A gate that inspected only the base file would therefore report drift that
   HAS been addressed, and the only way to satisfy it would be to overwrite the
   historical record -- i.e. the gate would punish the lawful act and reward
   the forbidden one. So the freshness question is asked of the RECORD CHAIN
   (base + any supplements), and the gate reports WHICH member is current.
   Note carefully what this does NOT do: a supplement makes a record *fresh*,
   never *conferred*. Freshness and conferral are different facts, and SS6 role
   acts are outside this gate entirely.
"""

import hashlib
import os
import re
import sys

REPO = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

# (alignment record, the PRD it measures, the role that must re-confer,
#  [supplements that lawfully extend the base record, newest last])
RECORDS = [
    ('docs/30-product/revenue-finance/PRD-008_ARCHITECTURE_ALIGNMENT.md',
     'docs/30-product/revenue-finance/PRD-008_REVENUE-AND-FINANCE.md',
     'Architecture Reviewer',
     ['docs/30-product/revenue-finance/'
      'PRD-008_ARCHITECTURE_ALIGNMENT_V17_SUPPLEMENT.md']),
    ('docs/30-product/integration/PRD-019_ARCHITECTURE_ALIGNMENT.md',
     'docs/30-product/integration/PRD-019_INTEGRATION.md',
     'Architecture Reviewer',
     []),
]

HEX64 = re.compile(r'\b[0-9a-f]{64}\b')
VERSION = re.compile(r'v(\d+\.\d+)')

problems = []
notes = []


def rel(p):
    return os.path.join(REPO, p)


def read(p):
    with open(rel(p), encoding='utf-8') as f:
        return f.read()


def prd_version(text):
    """The version a PRD declares for ITSELF, from its own Version row."""
    for line in text.splitlines():
        if line.startswith('| **Version**'):
            m = VERSION.search(line)
            return m.group(1) if m else None
    return None


def subject_versions(text):
    """Versions the record claims for its SUBJECT, from its Subject row."""
    for line in text.splitlines():
        if line.startswith('| **Subject**'):
            return VERSION.findall(line)
    return []


print('=' * 78)
print('ALIGNMENT-RECORD FRESHNESS GATE')
print('=' * 78)

for record_path, prd_path, role, supplements in RECORDS:
    print()
    print(f'--- {os.path.basename(record_path)}')

    missing = [p for p in (record_path, prd_path) + tuple(supplements)
               if not os.path.exists(rel(p))]
    if missing:
        for p in missing:
            problems.append(f'{p}: file does not exist')
            print(f'    MISSING: {p}')
        continue

    base = read(record_path)
    prd_bytes = open(rel(prd_path), 'rb').read()
    prd_text = prd_bytes.decode('utf-8')

    live_hash = hashlib.sha256(prd_bytes).hexdigest()
    live_lines = prd_text.count('\n') + (0 if prd_text.endswith('\n') else 1)
    live_ver = prd_version(prd_text)

    # Guard 4: the chain, not the base file alone. Each member is measured
    # SEPARATELY so the report can name which one is current -- concatenating
    # them would prove only "some file somewhere cites it", which is a weaker
    # claim than the one this gate makes.
    chain = [(record_path, base)] + [(s, read(s)) for s in supplements]

    cited_by = {p: HEX64.findall(txt) for p, txt in chain}
    all_cited = [h for hs in cited_by.values() for h in hs]
    claimed_vers = subject_versions(base)

    # Guard 1: refuse to pass vacuously -- applied to the WHOLE chain, so a
    # supplement with no anchor cannot rescue a base with none either.
    if not all_cited:
        problems.append(f'{os.path.basename(record_path)}: no 64-hex hash '
                        f'found in the record chain — the freshness anchor is '
                        f'missing, so this check cannot run (it must not pass '
                        f'silently)')
        print('    FAIL anchor missing: no sha256 in the record')
        continue

    print(f'    PRD live version : v{live_ver}   ({live_lines} lines)')
    print(f'    PRD live sha256  : {live_hash[:16]}')
    print(f'    chain members    : {len(chain)} '
          f'(base{", +" + str(len(supplements)) + " supplement(s)" if supplements else ""})')
    print(f'    hashes cited     : {len(all_cited)} across the chain '
          f'({", ".join(h[:8] for h in all_cited[:4])}'
          f'{" ..." if len(all_cited) > 4 else ""})')
    print(f'    base subject ver : {claimed_vers or "none stated"}')

    # Guard 2: superseded hashes are expected. The question is only whether
    # the CURRENT content is among those measured, anywhere in the chain.
    current_in = [p for p, hs in cited_by.items() if live_hash in hs]
    fresh = bool(current_in)
    ver_ok = (live_ver in claimed_vers) if (live_ver and claimed_vers) else None

    if fresh:
        who = ', '.join(os.path.basename(p) for p in current_in)
        print(f'    FRESH: the current PRD content hash is measured by -> {who}')
        if current_in != [record_path]:
            print('           (the BASE record is stale and is deliberately '
                  'left so: a stale')
            print('            review is corrected by a dated re-run beside '
                  'it, not by editing')
            print('            what it concluded — PRD-006 supplement L8, '
                  'baseline SS3.3 L171)')
        notes.append(
            f'{os.path.basename(record_path)}: FRESH via {who}. '
            f'Freshness is not conferral — Stage 3 remains the {role}\'s act.')
    else:
        problems.append(
            f'{os.path.basename(record_path)}: STALE — no member of the '
            f'{len(chain)}-file record chain measures the current PRD. '
            f'Current v{live_ver} ({live_hash[:16]}) is not among the '
            f'{len(all_cited)} hashes cited. Highest subject version named: '
            f'v{max(claimed_vers) if claimed_vers else "?"}. '
            f'Re-measurement and conferral are the {role}\'s act.')
        print(f'    STALE: current content hash is NOT cited anywhere in the chain.')
        if ver_ok is False:
            print(f'           base names v{claimed_vers}, PRD is v{live_ver}')
        print(f'           -> {role} must re-measure and confer.')

print()
print('=' * 78)
print(f'records checked : {len(RECORDS)}')
print(f'PROBLEMS        : {len(problems)}')
for p in problems:
    print(f'  - {p}')
for n in notes:
    print(f'  note: {n}')

print()
print('This gate reports drift. It does not confer, refresh or repair a')
print('stage verdict — those are role acts under PRD_LIFECYCLE.md SS6.')
print('=' * 78)

sys.exit(1 if problems else 0)
