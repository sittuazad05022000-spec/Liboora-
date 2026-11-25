# AGENT TEAM RUNBOOK — Liboora hybrid agentic development system

**Status:** Process record — ⛔ **non-authoritative**. This file creates no Bounded
Context, no edge, no identifier, and confers no authority. It operates strictly
under the existing governance set (lower numbers govern higher ones); where this
file and any ranked document disagree, the ranked document wins and this file
must be corrected. Activated by Product Owner approval, 2026-11-25 (M0+M1 scope).

## 1. Roles

| Role | Realization | Charter |
|---|---|---|
| **Orchestrator** | The main session | Breaks requirements into dependency-ordered tasks; assigns disjoint file-lock sets; launches personas; maintains the evidence ledger; STOPs and routes any decision that belongs to a named owner. Never edits Rank 1–3 documents. Never re-decides frozen text. |
| **Architect** | Subagent | Reads authoritative PRD/ADR text only; produces implementation plans that cite existing identifiers; runs `tool/check_module_boundaries.dart` to detect violations; flags any frozen-text conflict as a STOP. |
| **Developer** | Subagent | Implements strictly inside the authorized task and file-lock set; follows existing conventions; never invents business rules, defaults, BC ids, edges, permissions, or IMPL numbers; no unrelated refactoring. |
| **QA** | Subagent | Adds or strengthens regression tests only; runs focused then full suites; audits test diffs for weakening; reports raw evidence (counts, exit codes). Never claims a result it did not run. |
| **Security** | Subagent | Audits X-13 tenant keys, ID-1 (credentials/OTP/session only in BC-18), X-10 audit-mutation rules, tenant partitioning, secrets, and sensitive-data flows (DOB, OTP, sessions, payments). |
| **Independent Reviewer** | Subagent, **fresh context, never the implementer** (`ADR-0048`) | Receives requirement + evidence only, never the implementer's narrative; re-runs gates; verifies requirement compliance; emits findings / critical issues / non-critical issues / remaining risks / verdict. |

## 2. Workflow — every arrow is a gate artifact

REQUIREMENT (human) → ARCHITECTURE REVIEW (plan + checker evidence) →
TASK BREAKDOWN (existing identifiers only + file-lock plan) → IMPLEMENTATION
(locked files only) → TESTING (QA evidence) → SECURITY AUDIT →
INDEPENDENT REVIEW → **HUMAN APPROVAL**.

No act proceeds past a gate without its artifact. Authority is **one act at a
time** (`ADR-0033` §7.1); nothing is self-authorized.

## 3. Orchestration constraints (mapping to platform reality)

- Subagents are `explore` (read-only research) or `general` (multi-step work).
  The Independent Reviewer always starts with fresh context.
- **No isolated workspaces exist.** Parallel *implementation* is permitted only
  with disjoint file-lock sets assigned by the Orchestrator. Hotspot files —
  `lib/bootstrap/di.dart`, `lib/domain/library/enrollment/enrollment.dart`,
  `tool/check_module_boundaries.dart`, `tool/module_dependencies.yaml` — are
  **single-writer at all times**. Parallelism is otherwise reserved for
  read-only audits.
- **No MCP servers are configured.** GitHub interaction is via REST (`curl`,
  token parsed from `git config --get remote.origin.url`); `gh` is unavailable.
- **Scaffolding skills are excluded by policy** (auth/database/payments/ui
  conventions would violate frozen `BC-18`/`BC-02` semantics).
- Flutter toolchain: `export PATH="/tmp/flutter/bin:$PATH"`.

## 4. Governance constraints (binding on every persona)

1. PRDs and ADRs are authoritative; frozen text is never edited by an agent.
2. No fabricated requirements, measurements, or test results. Evidence is
   quoted from actual command output.
3. No weakened or deleted tests; every test diff is audited before acceptance.
4. No unrelated refactoring.
5. Identifiers come from existing registers only; new numbers require Product
   Owner authority.
6. **Git:** no manual commit, push, merge, or deploy. The platform's
   between-turn auto-commits are a documented environment behavior, not an
   agent act; push/merge/deploy require explicit human approval.
7. A decision that belongs to a named owner (Product, Domain, Architecture,
   Governance) is **STOPped and routed**, never taken.

## 5. Baseline evidence at activation (measured 2026-11-25)

- HEAD `67e77f6`, branch `feature/task-d10-cleanup`, tree clean.
- `flutter test`: **933 passed** (incl. 4 ADR-0179 review-fix regression tests).
- `flutter analyze`: No issues. Boundary checker: **PASS**, 26 findings as dated
  ADR-0012 debt (Wave 2 expires 2026-12-31). `dart format`: clean.
  `flutter build web`: ✓ Built.
- Blocker register v1.16: `BLK-01` open (delivery-path-gated), `BLK-03` open
  (ADR-0178 act **verified unexecuted**), `BLK-02` V2/external, `BLK-04` infra.
- Known gap: `IMPLEMENTATION_STATUS.md` (v1.3) is measurably stale vs code —
  reconciliation is M1 of the approved roadmap.

## 6. Mission log (append-only)

- 2026-11-25 — M0: runbook created. M1: status reconciliation launched
  (read-only); report to be presented for approval before any status document
  is corrected. M2+ (code) await separate approval.
- 2026-11-25 — M1 complete: three parallel read-only audits reconciled
  `IMPLEMENTATION_STATUS.md`, the Phase 8/9 ledgers, and the landed-work record
  against measured code. Headline findings: gate 3's "9 blocking violations"
  row is now false (checker exits 0); `D10-4…D10-9` are executed in code but
  recorded open; `IMPL-214`'s "BC-01 absent" is false; SEC-1/A-9 authority was
  released while zero Google Sign-In code exists (V1 sign-in = phone/OTP only,
  which `ADR-0129` scopes to V2); `IMPL-678/679` identifiers were reallocated
  to pagination work with no recording document (register violation);
  `DEVELOPER_HANDOFF.md` is ~4 months / ~170 ADRs stale. No document was
  modified by M1; all corrections await Product Owner approval.
