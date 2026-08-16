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
"""

import hashlib
import os
import re
import sys

REPO = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

# (alignment record, the PRD it measures, the role that must re-confer)
RECORDS = [
    ('docs/30-product/revenue-finance/PRD-008_ARCHITECTURE_ALIGNMENT.md',
     'docs/30-product/revenue-finance/PRD-008_REVENUE-AND-FINANCE.md',
     'Architecture Reviewer'),
    ('docs/30-product/integration/PRD-019_ARCHITECTURE_ALIGNMENT.md',
     'docs/30-product/integration/PRD-019_INTEGRATION.md',
     'Architecture Reviewer'),
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

for record_path, prd_path, role in RECORDS:
    print()
    print(f'--- {os.path.basename(record_path)}')

    for p in (record_path, prd_path):
        if not os.path.exists(rel(p)):
            problems.append(f'{p}: file does not exist')
            print(f'    MISSING: {p}')

    if problems and problems[-1].endswith('does not exist'):
        continue

    record = read(record_path)
    prd_bytes = open(rel(prd_path), 'rb').read()
    prd_text = prd_bytes.decode('utf-8')

    live_hash = hashlib.sha256(prd_bytes).hexdigest()
    live_lines = prd_text.count('\n') + (0 if prd_text.endswith('\n') else 1)
    live_ver = prd_version(prd_text)

    cited = HEX64.findall(record)
    claimed_vers = subject_versions(record)

    # Guard 1: refuse to pass vacuously.
    if not cited:
        problems.append(f'{os.path.basename(record_path)}: no 64-hex hash '
                        f'found — the freshness anchor is missing, so this '
                        f'check cannot run (it must not pass silently)')
        print('    FAIL anchor missing: no sha256 in the record')
        continue

    print(f'    PRD live version : v{live_ver}   ({live_lines} lines)')
    print(f'    PRD live sha256  : {live_hash[:16]}')
    print(f'    hashes cited     : {len(cited)} '
          f'({", ".join(h[:8] for h in cited[:4])}'
          f'{" ..." if len(cited) > 4 else ""})')
    print(f'    subject versions : {claimed_vers or "none stated"}')

    # Guard 2: superseded hashes are expected. The question is only whether
    # the CURRENT content is among those measured.
    fresh = live_hash in cited
    ver_ok = (live_ver in claimed_vers) if (live_ver and claimed_vers) else None

    if fresh:
        print('    FRESH: the record cites the PRD\'s current content hash.')
    else:
        problems.append(
            f'{os.path.basename(record_path)}: STALE — measures a revision '
            f'that is not the current PRD. Current v{live_ver} '
            f'({live_hash[:16]}) is not among the {len(cited)} hashes cited. '
            f'Highest subject version named: '
            f'v{max(claimed_vers) if claimed_vers else "?"}. '
            f'Re-measurement and conferral are the {role}\'s act.')
        print(f'    STALE: current content hash is NOT cited.')
        if ver_ok is False:
            print(f'           record names v{claimed_vers}, PRD is v{live_ver}')
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
