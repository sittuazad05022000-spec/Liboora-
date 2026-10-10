<!-- LIBOORA Design Documentation Foundation | 2026-09-09 | v0.2 2026-10-26 — production-quality rewrite; no requirement, decision, or rank invented -->

> This document is design governance and documentation. It does not amend product requirements, architecture decisions, bounded-context ownership, permissions, or backend contracts. Where it disagrees with any ranked document, the ranked document wins.

# LIBOORA UX Architecture

| Field | Value |
|---|---|
| Status | PROPOSED — experience architecture for review (criterion document; gate outcomes live separately at the G-records) |
| Owner | UX Architecture Owner |
| Product source | FROZEN / INHERITED PRDs and accepted ADRs — library §§14A–14B · PRD-007 · MASTER_PRD §5.2/§8 · `Accepted` ADRs |
| Rank | **UNRANKED.** Carries no precedence over any ranked PRD, ADR, BC Map, or [`DOCUMENTATION_BASELINE.md`](../00-governance/DOCUMENTATION_BASELINE.md) entry |
| Companion documents | [`INFORMATION_ARCHITECTURE.md`](INFORMATION_ARCHITECTURE.md) · [`USER_FLOWS.md`](USER_FLOWS.md) · [`SCREEN_ARCHITECTURE.md`](SCREEN_ARCHITECTURE.md) · [`DESIGN_QA.md`](DESIGN_QA.md) · [`DESIGN_DEBT.md`](DESIGN_DEBT.md) — this document sets structure and rules; those carry the details |

---

## 1. UX architecture rules

Unchanged from v0.1; each rule keeps its status label as recorded, and each new section below is **derived from** these rules, not a new requirement.

- **INHERITED:** the interface reflects existing actor and domain boundaries; it does not create new roles or permissions.
- **RECOMMENDED:** one primary task per surface, with the current status and next action visible before secondary detail.
- **RECOMMENDED:** compose information from the existing owning capability rather than reproducing it in another surface.
- **TO BE DECIDED:** exact product navigation labels and account-level entry points where the applicable PRD does not settle them — ⭐ **escalated to Founder/Product Authority 2026-10-01** via the route recorded in [`INFORMATION_ARCHITECTURE.md`](INFORMATION_ARCHITECTURE.md) §3 and [`G1_EXPERIENCE_ARCHITECTURE_APPROVAL_RECORD_2026-10-01.md`](G1_EXPERIENCE_ARCHITECTURE_APPROVAL_RECORD_2026-10-01.md); G1 was passed **with** this decision outstanding.

## 2. Information and navigation architecture

*Derived from rule 1 (INHERITED boundaries) and [`INFORMATION_ARCHITECTURE.md`](INFORMATION_ARCHITECTURE.md); the six product groups and their source guardrails are recorded there — this section states the UX rule and defers the group definitions to that document.*

- **Grouping follows intent, not implementation.** Navigation groups mirror the user's goal (find → trust → reserve → manage), not module or folder names. Group definitions, audience boundaries, and status labels are owned by [`INFORMATION_ARCHITECTURE.md`](INFORMATION_ARCHITECTURE.md) §2 (Discover · Library · Study access · My participation · Operations · Community = deferred).
- **One canonical place per concept** ([`INFORMATION_ARCHITECTURE.md`](INFORMATION_ARCHITECTURE.md) §2). When a surface needs a fact, it composes it from the owning capability; a second owning surface is a duplicate and is out of scope.
- **Navigation labels are not a UX decision this document can take.** The destination set is bounded by the source groups; the labels remain **TO BE DECIDED** (see §1 and the G1 escalation record).
- **Findability:** public discovery enters only through the source-bounded Search/Nearby path; seat information is aggregate/coarse publicly and follows PRD-007 when protected ([`INFORMATION_ARCHITECTURE.md`](INFORMATION_ARCHITECTURE.md) §4). A screen that creates a second discovery, seat, or booking authority is out of scope.

## 3. User flows

*Authoritative flow definitions live in [`USER_FLOWS.md`](USER_FLOWS.md) (APPROVED G1, 2026-10-01); this document states the flow rules and boundary, not the flows themselves.*

- **V1 flows are source-bounded.** Only the flows named in [`USER_FLOWS.md`](USER_FLOWS.md) §1 (Library discovery → booking) and §2–§5 (staff operational boundary, current-students & occupancy, finance, authentication, and library joining — staff operational boundary from the preserved §1 note) are V1 flow subjects. Each stage in that document carries its required design evidence and frozen-source citation; this document adds none.
- **A flow is sequencing, not a new backend behaviour.** Flows describe experience order and states; the owning BC performs every transition. No flow step may assert a data write, a permission check it does not own, or a second sign-in path.
- **V1 = Google Sign-In only** (`Accepted` `ADR-0129`; Authentication PRD v3.0). No flow in this document may assume a mobile-number OTP step; Mobile OTP is V2 and its flow is not designed here.

## 4. Library Search First

**CONFIRMED:** Search or Nearby → Library Profile → Availability → Shift or Seat → Booking.

| Step | UX purpose | Ownership guardrail |
|---|---|---|
| Search or Nearby | Help a prospective student find a library using the existing discovery contract | C2 consumes BC-23; it does not create search, indexing, ranking, or a second marketplace. |
| Library Profile | Establish trust and show the library facts available to the public surface | C3 composes facts owned by existing contexts; it owns no field. |
| Availability | Make freshness and the available selection legible | Availability is displayed from source-owned data; design does not invent a real-time guarantee. |
| Shift or Seat | Make the existing choice understandable before initiation | Seat and booking ownership remain with the applicable frozen library/seat authority. |
| Booking | Present a clear initiation, confirmation, or failure state | No duplicate booking system, lock, quota, or reservation authority is introduced. |

*Stage-to-stage evidence and frozen-source citations are the [`USER_FLOWS.md`](USER_FLOWS.md) §1 table; the step table above is preserved verbatim as the v0.1 authority statement.*

## 5. Screen and state model

*Screen families and their required states are defined at [`SCREEN_ARCHITECTURE.md`](SCREEN_ARCHITECTURE.md) §1 (APPROVED G1); the per-surface state review is specified at [`DESIGN_QA.md`](DESIGN_QA.md) §3–§5. This section states the model rules, not new states.*

- **Composition surface, not system.** A screen composes owned capabilities; it owns no domain record, permission, or backend contract ([`SCREEN_ARCHITECTURE.md`](SCREEN_ARCHITECTURE.md) "screen rule").
- **State model is mandatory, not illustrative.** Every reviewed surface shows the applicable rows of the [`DESIGN_QA.md`](DESIGN_QA.md) §3 matrix — empty (S1), loading (S2), populated (S3), at-limit (S4), named error (S5), not-found/unavailable (S6), not-eligible (S7), permission/session (S8), stale/offline (S9), filtered (S10), confirmation (S11), success-with-side-effects (S12). An omitted applicable state without a written N/A reason is a QA `RETURNED`, not a scope reduction.
- **Required state families per flow:** each step in §2/§4 has at minimum an empty, a named-error with retry, a stale-data variant where source data is time-sensitive, and a completion with next action. The owning source's rejection vocabulary (§4) is the only permitted error copy; no invented policy wording.

## 6. Loading, empty, error and recovery

*Values and budgets are owned by [`PERFORMANCE.md`](PERFORMANCE.md) + [`NFR_BUDGETS_V1.md`](NFR_BUDGETS_V1.md); this section states the behaviour rules that keep those budgets meaningful.*

- **Loading:** skeleton or progress preserves layout and does not move the primary action out of reach; the primary task never waits on a large illustration, animation, blur layer, or high-bandwidth asset ([`PERFORMANCE.md`](PERFORMANCE.md) §1, measured against the `DDR-0034` target class).
- **Empty:** named content, restrained illustration within the 70/25/5 ratio ([`DESIGN_FOUNDATION.md`](DESIGN_FOUNDATION.md) via `DDR-0013`), and one primary CTA. "No data" is a designed state, not a white frame.
- **Error:** every error is **named** (network · service · timeout · not-found · unavailable · not-eligible · session) with a retry that actually retries the owning operation, plus an exit path. Errors do not duplicate or pre-announce the owning system's result.
- **Recovery and return:** from any S5–S9 the user can (a) retry the owning operation, (b) cancel, and (c) return to the last stable context without data loss — the three recovery routes stated in [`DESIGN_QA.md`](DESIGN_QA.md) §6.
- **Trust rule (§4, v0.1, preserved):** where source data can change between read and action, the UI says the action is checked against current state; the final outcome is the owning system's result, not a client-side promise. A UI that shows a booking as "confirmed" before the operation returns violates this and is out of scope.

## 7. Accessibility

*Authority: [`ACCESSIBILITY.md`](ACCESSIBILITY.md) (APPROVED G2) + `DDR-0004` (WCAG 2.1 AA). This section states UX-level obligations only; numeric checks are [`DESIGN_QA.md`](DESIGN_QA.md) §5.4.*

- **Essential actions are reachable by keyboard, switch, screen reader, and touch** — accessibility is a flow property, not a visual pass: a flow that cannot be completed without a pointer fails this rule at the flow level.
- **Focus survives state change:** transitions between S1…S12 keep focus visible, ordered, and persistent; an error or empty state that drops focus to an unreadable place is a `CONFLICT` with `DDR-0004`.
- **State and meaning are never colour-only** (paired icon/label per [`DESIGN_SYSTEM.md`](DESIGN_SYSTEM.md) §2 semantic roles) and **essential information never depends on motion** (reduced-motion alternative).
- **Text growth is a designed case:** compact/medium layouts remain usable at 200% text scale and narrow width; Devanagari rendering claims cite [`DEVANAGARI_RENDERING_PROBE.md`](DEVANAGARI_RENDERING_PROBE.md) · open item **`CP-B1` / `FA-GAP-003` — `BLOCKED / UNVERIFIED`** per [`CP-B1_EQUIVALENT_TARGET_PROPOSED_ACCEPTANCE.md`](CP-B1_EQUIVALENT_TARGET_PROPOSED_ACCEPTANCE.md) · ⛔ no rendering PASS is established, so no rendering claim may ship.
- Exceptions follow [`ACCESSIBILITY.md`](ACCESSIBILITY.md) §2 (owner + expiry/review); an undocumented exception is not a flow state and cannot ship.

## 8. Responsive behaviour

*Authority: [`RESPONSIVE_DESIGN.md`](RESPONSIVE_DESIGN.md) (APPROVED v0.1, `DDR-0004`/`DDR-0005`) + [`DDR-0034`](design-decisions/DDR-0034-cp-a-v1-device-profile-confirmed-by-technical-owner.md). This section states UX rules, not breakpoint values.*

- **The compact class is the design reference.** UX structure (task ordering, primary action position, disclosure) is decided at `< 600dp`; medium `600–904dp` stays single-column; two-pane only at `≥ 905dp` (rule `D-1`, `RESPONSIVE_DESIGN.md`).
- **Density rules scale content, not trust:** `DDR-0004` density (padding/motion/text-density tolerances) keeps the primary task reachable on the `DDR-0034` target class (API 26 · ~2 GB · 720×1600 · degraded 4G). A layout that reaches the second fold on that class before the primary action violates the `NFR_BUDGETS_V1` posture and is out of scope.
- **View reality is a UX case, not an edge case:** offline/stale is designed (§6) and long-content overflow is measured at medium width, not only compact.

## 9. V1 / V2 boundary

*Derived from [`DESIGN_DEBT.md`](DESIGN_DEBT.md) `DBT-006` (Founder/Product Authority OPTION C scope decision, 2026-09-30), MASTER_PRD §5.2 `MP-SCOPE-04`, `Accepted` `ADR-0129` (auth) and `Accepted` `ADR-0130` (payment).*

- **V1 flow and screen subjects:** public library discovery/profile (library §§14A–14B), authenticated student seat booking (BC-04 / PRD-007), account/session surface, and the shell compositions the frozen sources bound. QA scope mirrors this ([`DESIGN_QA.md`](DESIGN_QA.md) §1).
- **V2 — not designed, not sketched, not tokened:** Community (PRD-021A; `MP-SCOPE-04`), Staff & Shift operational module, mobile/OTP sign-in (re-scoped by `ADR-0129`), and any gateway/fee surface (`ADR-0130`). Absence is deliberate out-of-scope, not "coming soon".
- **Operations group:** V1 compositions only — owner/manager/reception dashboards are source-owned workflows; this document infers no widget set ([`INFORMATION_ARCHITECTURE.md`](INFORMATION_ARCHITECTURE.md) §2 row 5, `DBT-006`).
- **Boundary rule:** any V2 concept that appears in a V1 screen (community post, shift roster, OTP field, gateway button) is out of scope at the source level — not a QA note, and not a `TO BE DECIDED` inside the V1 surface.

## 10. Community boundary

**CONFLICT (preserved verbatim from v0.1):** the repository baseline and ADR records mention PRD-021A baseline authority, while the A1 continuity artifact and Stage 7 blocker state that A1 remains draft/not frozen. Until governance reconciles that record, design treats community concepts as source-traceable exploration only and does not invent public visibility, participation, moderation, or permission behavior.

*(Consequence under §9: Community is a V2 surface. This CONFLICT record is routing, not a community requirement.)*

## 11. Task and trust architecture (v0.1 rules, preserved)

- **Task architecture:** the default surface hierarchy is context → current state → primary action → supporting facts → recovery or secondary actions; operational detail uses progressive disclosure; a failure condition is never hidden behind a decorative interaction.
- **Trust architecture:** where source data can change between read and action, the UI says the action is checked against current state; the final outcome comes from the owning system, not a client-side promise.
- **No demo, no guest:** every recovery route in §6 and session state in S8 follows `MP-CON-11` / `TASK-D10` (no seeded or demo sign-in paths); the recovery CTA is sign-in or contact, never a bypass.

## 12. Traceability

| Topic here | Authoritative source |
|---|---|
| Navigation groups + labels status | [`INFORMATION_ARCHITECTURE.md`](INFORMATION_ARCHITECTURE.md) §2–§4 (APPROVED G1; labels escalated 2026-10-01) |
| V1 flow stages + evidence | [`USER_FLOWS.md`](USER_FLOWS.md) §1–§5 (APPROVED G1 — §1 citation table; staff operational boundary from the preserved §1 note) |
| Screen families + required states | [`SCREEN_ARCHITECTURE.md`](SCREEN_ARCHITECTURE.md) §1 (APPROVED G1) |
| State matrix S1–S12 + QA rule | [`DESIGN_QA.md`](DESIGN_QA.md) §3, §5, §6 |
| Token/ratio decisions | [`DESIGN_SYSTEM.md`](DESIGN_SYSTEM.md) + `DDR-0001/0027–0032` · layer ratio `DDR-0013` |
| Accessibility values | `DDR-0004` · [`ACCESSIBILITY.md`](ACCESSIBILITY.md) · [`DEVANAGARI_RENDERING_PROBE.md`](DEVANAGARI_RENDERING_PROBE.md) |
| Responsive classes + device target | `DDR-0005` · [`RESPONSIVE_DESIGN.md`](RESPONSIVE_DESIGN.md) · [`DDR-0034`](design-decisions/DDR-0034-cp-a-v1-device-profile-confirmed-by-technical-owner.md) |
| Performance posture + budgets | [`PERFORMANCE.md`](PERFORMANCE.md) · [`NFR_BUDGETS_V1.md`](NFR_BUDGETS_V1.md) |
| V1/V2 scope decision | `DBT-006` OPTION C · MASTER_PRD §5.2 · `ADR-0129` · `ADR-0130` |
| Status vocabulary | [`DESIGN_GOVERNANCE.md`](DESIGN_GOVERNANCE.md) §2 |
| Gate outcomes (G1…G4 recorded; G5 open) | G-records + [`DESIGN_DEBT.md`](DESIGN_DEBT.md) `DBT-008` |

*No requirement, decision, DDR, ADR, or gate outcome is created by this document; every section above cites the record that owns it. No file besides this one was modified.*
