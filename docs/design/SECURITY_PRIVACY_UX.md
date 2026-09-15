<!-- LIBOORA Design Documentation Foundation | security and privacy UX gap register -->

> This document is design governance and documentation. It does not amend product requirements, architecture decisions, bounded-context ownership, permissions, or backend contracts.
# LIBOORA Security & Privacy UX — Gap Register

| Field | Value |
|---|---|
| Status | ⚠️ **GAP REGISTER** — records what is missing. ⛔ It specifies **no** security or privacy UX behaviour |
| Owner | Design Governance Owner *(routing only)* |
| Deciding offices | **Privacy Owner** (`ADR-0077`) · **Security Platform** · Product Owner · Founder/Product Authority |
| Rank | **UNRANKED.** Carries no precedence over any ranked document |

## 1. What this document is — and emphatically is not

**It is a register of gaps.** Measured across the sixteen foundation
documents in this directory, the terms *privacy*, *consent*, *PII*,
*minor* and *DPDP* occur **0** times in any substantive sense, while the
repository's frozen and draft product documents contain substantial
security and privacy material. The design foundation was silent on a topic
its own sources treat at length.

⛔ **This document does not close that gap, and must not be read as doing
so.** It records each gap, cites the source that creates the obligation,
and names the office that owns the decision. Every entry is `OPEN`.

⛔ **No security or privacy UX requirement is invented here.** Security and
privacy obligations are set by product, legal and security authority — not
by design documentation. A design document asserting, for example, what a
consent screen must say would be manufacturing a requirement, and
[`DESIGN_GOVERNANCE.md`](DESIGN_GOVERNANCE.md) §3 rule 2 forbids exactly
that: a design artifact "cannot grant a permission, create a role, name a
backend, add a bounded context, or change BC ownership."

## 2. Why design cannot decide these

Three constraints, each from an existing source:

1. **The Privacy Owner office exists but its holder is VACANT.** The role
   was constituted by `Accepted` `ADR-0077`. `TS-002` records the holder as
   **VACANT** and, on that basis, leaves its own privacy-dependent decision
   `XPC-OD-005` open. ⚠️ **So a privacy question cannot presently be
   answered by anyone** — routing it is the complete and correct action.
2. **Security release authority is separate and conferred, not assumed.**
   The `SEC-1`/`A-9` release record sits in `docs/00-governance/`, outside
   this directory and outside design authority.
3. **Accessibility's target standard is itself `TO BE DECIDED`**
   ([`ACCESSIBILITY.md`](ACCESSIBILITY.md) header), and several
   privacy-surface questions — disclosure legibility, minor-facing
   comprehension — depend on it.

## 3. Sources that create these obligations

⛔ Cited, never restated as if owned here.

| Source | Path | Status |
|---|---|---|
| Authentication PRD — Security & Privacy | `docs/30-product/authentication/prd-v2/08-Security-and-Privacy.md` — §8.4 Privacy Principles, §8.5 Sensitive Data Protection, §8.6 Threat Scenarios (**9** scenarios), §8.8 Privacy Business Rules | ⚠️ **Version caveat:** the baseline records Authentication PRD **v3.0** as current, but `prd-v3/` contains only `00-Cover-and-Control.md`; the substantive chapter exists only under `prd-v2/`. ⛔ **Not resolved here** — see `SPX-GAP-008` |
| Privacy Owner role | `docs/00-governance/adr/ADR-0077-privacy-owner-role-derived-from-existing-rules.md` | `Accepted`; ⚠️ holder **VACANT** |
| Community safety & privacy | `docs/30-product/social-graph/PRD-021A_A6_COMMUNITY_SAFETY_PRIVACY_MODERATION_DRAFT_v0.1.md` | `DRAFT` — ⚠️ and `PRD-021A` carries the `C-001` conflict already recorded in [`PRD_DESIGN_TRACEABILITY.md`](PRD_DESIGN_TRACEABILITY.md) §4 |
| `ConsentRecord` | `LIBOORA_BOUNDED_CONTEXT_MAP.md` §8 — a declared `BC-18` value object | Rank 4 |
| Security/implementation release | `docs/00-governance/SEC-1_A-9_IMPLEMENTATION_RELEASE_BC-18.md` | Unranked record |

## 4. Gap register

| ID | Gap | Source obligation | Owning office | Status |
|---|---|---|---|---|
| `SPX-GAP-001` | **No consent UX is specified.** `ConsentRecord` is a declared `BC-18` value object and the BC Map states minor guardian consent precedes social activation, but ⛔ **no design artifact describes how consent is requested, shown, withdrawn or evidenced** | BC Map §8 `BC-18` invariants | **Privacy Owner** *(⚠️ VACANT)* + Product Owner | ⛔ OPEN |
| `SPX-GAP-002` | **No minor-facing UX posture.** The product contemplates minors (guardian consent; a `parent_dashboard.dart` surface exists in code), yet ⛔ **no design rule addresses comprehension, data minimisation or guardian visibility** for a minor | BC Map `BC-18`; `ADR-0077` derivation naming "minor-inclusive data flows" | **Privacy Owner** *(⚠️ VACANT)* | ⛔ OPEN |
| `SPX-GAP-003` | **No PII display or redaction rule.** Authentication PRD §8.5 classifies sensitive data, but ⛔ **design does not say which fields may appear on which surface, to which role, or how they are masked**. ⚠️ Adjacent-but-insufficient: [`ACCESSIBILITY.md`](ACCESSIBILITY.md) §2 says errors must not expose "internal identifiers" — that is an error-message rule, ⛔ not a PII display model | Authentication PRD `prd-v2` §8.5 | **Privacy Owner** *(⚠️ VACANT)* + Security Platform | ⛔ OPEN |
| `SPX-GAP-004` | **No authentication-failure UX model.** §8.6 enumerates **9** threat scenarios (SIM swap, lost/stolen device, OTP interception, session hijacking, replay, insider misuse, unauthorised access, cross-tenant attempts). ⛔ **No design artifact specifies what a user is told in each** — and disclosure wording is a security decision, since an over-informative message is itself an attack surface | Authentication PRD `prd-v2` §8.6 | **Security Platform** + Product Owner | ⛔ OPEN |
| `SPX-GAP-005` | **No session/device management UX.** §8.3 defines session protection, device verification and secure logout; ⛔ **design describes no surface** for viewing sessions, revoking a device, or communicating forced logout | Authentication PRD `prd-v2` §8.3 | UX Architecture Owner, **conditional on** Security Platform | ⛔ OPEN |
| `SPX-GAP-006` | **No permission-denied UX model.** [`SCREEN_ARCHITECTURE.md`](SCREEN_ARCHITECTURE.md) §1 lists a `permission-denied` state "where source defines it", but ⛔ **no artifact defines what it shows** — whether a denied capability is hidden or visible-and-disabled is a **security-relevant** choice, since hiding versus disabling discloses different information | `SCREEN_ARCHITECTURE.md` §1; role model in code (`PolicyDecisionPoint`) | Security Platform + UX Architecture Owner | ⛔ OPEN |
| `SPX-GAP-007` | **No tenant-isolation UX.** Tenant partitioning is enforced in code and tested, and a branch/tenant switcher exists (`account_sheet.dart`). ⛔ **No design artifact states how the active tenant is made unambiguous** — a user acting in the wrong tenant is a cross-tenant data event, so this is a **security** concern, not merely a labelling one | BC Map `BC-19` invariants; `test/widget_test.dart` tenant-isolation group | Security Platform + UX Architecture Owner | ⛔ OPEN |
| `SPX-GAP-008` | **Source-version ambiguity.** The security/privacy chapter this register depends on exists only under `prd-v2/` while the baseline names **v3.0** as current. ⛔ **Not repaired here**: reconciling a frozen PRD's version is a Governance Owner act | `DOCUMENTATION_BASELINE.md`; `prd-v3/` contents | **Governance Owner** | ⛔ OPEN |
| `SPX-GAP-009` | **Community privacy is blocked upstream.** `PRD-021A` A6 covers safety/privacy/moderation but is `DRAFT`, and its status is the subject of conflict `C-001`. ⛔ **No community privacy UX may be designed** until governance reconciles that record | `PRD_DESIGN_TRACEABILITY.md` §4 `C-001` | Governance Owner, then Founder/Product Authority | ⛔ OPEN — ⚠️ **blocked, not merely unassigned** |

### 4.1 Register measures

| Measure | Value |
|---|---|
| Gaps recorded | **9** |
| Resolved | **0** |
| Blocked on the **VACANT** Privacy Owner | **3** (`001`, `002`, `003`) |
| Requiring Security Platform | **4** (`003`, `004`, `006`, `007`) |
| Blocked upstream by `C-001` | **1** (`009`) |
| Governance-owned | **1** (`008`) |

## 5. Interim design rule

Until these are resolved, one rule applies, and it is a **restraint**, not a
specification:

⛔ **A design artifact must not depict a security or privacy behaviour that
no source defines.** Drawing a consent dialog, a masked field or a
failure message creates the appearance of a settled requirement. Where a
surface needs such behaviour, the artifact marks it `TO BE DECIDED`, cites
the `SPX-GAP-*` row, and proceeds no further.

This follows [`DESIGN_QA.md`](DESIGN_QA.md) §3, which already returns work
for an "unsupported capability claim", and
[`DESIGN_FOUNDATION.md`](DESIGN_FOUNDATION.md) §4 *Source fidelity*: design
"may not create a new capability or ownership boundary."

## 6. Filing rules

1. **One gap per row**, each citing a source path.
2. **Never close a row by designing the answer** — closure requires a
   decision from the named office, recorded as a `DDR-*` or an upstream
   amendment.
3. **A vacant office is recorded as vacant**, never silently reassigned to
   a reachable one. Overstating who can decide is the fabrication that
   `TS-002` §4 note deliberately avoids.
4. **`SPX-GAP-*` identifiers are never reused or reassigned.**
5. **If a source changes**, restatus the row; ⛔ do not edit the frozen or
   draft source (`DESIGN_CHANGE_MANAGEMENT.md` §3).
