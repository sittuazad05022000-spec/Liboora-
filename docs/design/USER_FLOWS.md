<!-- LIBOORA Design Documentation Foundation | 2026-09-09 | v0.2 2026-10-26 — production-grade rewrite; no requirement, decision, permission, screen, component, token, or governance invented -->

> This document is design governance and documentation. It does not amend product requirements, architecture decisions, bounded-context ownership, permissions, or backend contracts. Where it disagrees with any ranked document, the ranked document wins.

# LIBOORA User Flows

| Field | Value |
|---|---|
| Status | **APPROVED (G1 experience architecture, 2026-10-01)** — pinned at the state [`G1_EXPERIENCE_ARCHITECTURE_APPROVAL_RECORD_2026-10-01.md`](G1_EXPERIENCE_ARCHITECTURE_APPROVAL_RECORD_2026-10-01.md) (gate G1 — Experience architecture, PASSED / CONFIRMED); this document is one of four in the approved artifact set |
| Owner | UX Architecture Owner |
| Related experience architecture | [`INFORMATION_ARCHITECTURE.md`](INFORMATION_ARCHITECTURE.md) · [`SCREEN_ARCHITECTURE.md`](SCREEN_ARCHITECTURE.md) · [`UX_ARCHITECTURE.md`](UX_ARCHITECTURE.md) · [`DESIGN_IMPLEMENTATION_TRACEABILITY.md`](DESIGN_IMPLEMENTATION_TRACEABILITY.md) — each cited traceably in §1 |
| Rule | **Flows describe experience sequencing, not new backend behaviour.** A flow repeats one product decision that already exists elsewhere; otherwise it is `UNRESOLVED`. |

---

## 1. Library discovery to booking

**V1 retained, source-bounded flow.** Public discovery/profile under frozen Library PRD §§14A–14B; authenticated booking/seat operations under frozen PRD-007. C2 is a draft, not the authority.

Search or Nearby → Results → Library Profile → Availability → Shift or Seat → Booking Initiation → Outcome.

| Stage | Required design evidence | Source / status |
|---|---|---|
| Search or Nearby | Public search by name/city/locality/PIN; nearby and distance sort when location permission is available | Frozen Library PRD §14A.4 `LIB-DISC-003`, `.013`; `14B` `LIB-14B.2`–`.6`. C2 is a draft, not the authority |
| Results | Show only public, approved library facts; private/unavailable records remain non-discoverable | Frozen Library PRD §§14A.5–.6; `14B` `LIB-14B.7`–`.10`, `.23`–`.25` |
| Library Profile | Public profile uses only §14A.5 allow-list and owner projections; protected actions remain gated | Frozen Library PRD §14A.5; `14B` `LIB-14B.7`–`.10`, `.26`–`.29` |
| Availability | Public view exposes aggregate capacity and a coarse qualitative availability indicator only; no live occupancy, precise free-seat count or per-seat state | Frozen `14B` `LIB-14B.11`–`.14`; authenticated student availability per frozen PRD-007 `SEAT-FR-076`, `.079` |
| Shift or Seat | Seat choice and eligibility follow the frozen BC-04 requirements; do not expose another student's allocation | Frozen PRD-007 `SEAT-FR-076`–`.084`; public restrictions in `LIB-14B.11`–`.14` |
| Booking Initiation | Booking is protected; PRD-007 controls self-booking, tenant mode and result semantics. Tenant default is disabled | Frozen PRD-007 `SEAT-FR-076`–`.086`; frozen Library `14B` `PO-4` / `LIB-14B.27` |
| Outcome | Render only the owning booking operation's actual result; do not add C4 draft-only outcome states | Frozen PRD-007 §12 and its closed booking/reservation rules; C4 remains Stage 2 draft |

*Items `LIB-DISC-003`, `LIB-DISC-013`, `LIB-14B.7`–`.29`, `SEAT-FR-076`…`086`, `PO-4` are the required design evidence citations; C2/C4 are draft, not authority.*

> **Preserved authoritative boundary (v0.1 §2, restored verbatim).** **V1 source-bounded operations:** Master PRD §8 modules 3–12 establishes Student Management, Parent Portal, Seat Management, Attendance, Revenue & Finance, and Owner/Manager/Reception dashboard compositions. Frozen PRD-004, PRD-006, PRD-007 and role/access sources govern their own behavior. **PRD-008 is still DRAFT; its requirements are not represented as frozen.** This flow does not approve any screen file or combine systems.

---

## 2. V1 current-students & occupancy view — retained, source-bounded

**Covers:** viewing the active student roster and its occupancy-linked display; it is not a screen name and not a permission decision.

| Item | Evidence |
|---|---|
| **Actor** | Reception, Manager, Owner (operational roster audience) |
| **Goal** | Assess current occupancy and consultable student records without exposing another student's restricted allocation |
| **Entry** | From the Library/Student Management entry under PRD-006/007 §14B `LIB-14B.26`–`.29` |
| **Preconditions** | Authenticated tenant context; row-level eligibility follows BC-04/PRD-007 `SEAT-FR-076`–`.084` |
| **Main path** | V1-reconciled occupancy display → student roster (aggregate counts → per-record available only where the source authorises a projection) |
| **Branches** | ⭐ **Product Owner decision (2026-10):** V1 roster **SEARCH and supported FILTERS are authorized** within the existing occupancy/roster scope; no additional personal-data exposure implied; no new requirements/APIs/schemas/permissions invented. *(Prior state, correct until this decision: branch was `UNRESOLVED`.)* |
| **Success** | Reconciled view remains within the `LIB-14B.26`–`.29` authorization boundary |
| **Failure / Recovery** | `DENIED` — remain on the same roster surface with a generic permission-denied notice; `UNAVAILABLE` — read-only fallback; recovery is `Exit` below |
| **Exit** | Back to Library/Profile or staff dashboard — no cross-boundary student data follows |
| **Permissions** | Read-only in this flow; PRD-006/007 access rules govern row availability |
| **Accessibility** | Empty-state, loading, and error states per `DESIGN_QA.md` §3 S1/S9; list density inherits the responsive specification |
| **Traceability** | `LIB-14B.26`–`.29`, `SEAT-FR-076`–`.084`, PRD-006/007; Master PRD §8 modules 3–12 reconciliation note `DESIGN_DEBT.md` `DBT-006` |

⭐ **Product Owner decision (2026-10):** V1 roster remains a single operational roster surface; no additional desks are authorized. *(Prior state: PPD-DESK scope was `UNRESOLVED`.)*

---

## 3. V1 finance / revenue / analytics view — retained, source-bounded

**Covers:** consulting finance/revenue/analytics aggregates that already exist in the approved source; it does not approve any finance operation or reporting implementation.

| Item | Evidence |
|---|---|
| **Actor** | Owner, Manager (finance/analytics audience) |
| **Goal** | Consult revenue/usage aggregates scoped to observable library/seat events without implying new financial obligations |
| **Entry** | From the Owner/Manager dashboard compositions (approved V1 product modules) |
| **Preconditions** | Authenticated tenant Owner/Manager context; aggregates derive only from observable booking/attendance events |
| **Main path** | Aggregate summary → period-constrained view (source-cited metric) → detail projection where authorized |
| **Branches** | ⭐ **Product Owner decision (2026-10):** V1 **period selector**, **export** and **approval actions** are authorized within the existing finance/revenue/analytics scope; ⛔ no exact export format, fields, approval types/workflow, UI detail, API, schema or permission is invented or implied. *(Prior state, correct until this decision: branch was `UNRESOLVED`.)* |
| **Success** | Source-cited aggregate displayed; no unpublished metric implied |
| **Failure / Recovery** | `DENIED` — same-surface denial; `UNAVAILABLE` — read-only fallback with empty-state guidance; recovery `Exit` below |
| **Exit** | Back to Library/Module entry or dashboard |
| **Permissions** | Read-only consult; no finance write/approval is sequenced in V1 |
| **Accessibility** | Empty, loading, error; tabular numerals for money/counts follow `DIT-001` where applicable |
| **Traceability** | Master PRD §8 modules 7, 8, 10–12; `SECURITY_PRIVACY_UX.md` §5 `SPX-GAP-003` (PII display boundary); `DBT-006` |

---

## 4. V1 authentication & onboarding — source-bounded entry

**Covers:** the entry point into authenticated flows; authentication is a service boundary, not a screen behaviour defined by a "V1 authentication standard".

| Item | Evidence |
|---|---|
| **Actor** | Student, Parent, Reception, Manager, Owner |
| **Goal** | Enter the authenticated tenant context required for any protected Library/SEAT-family behavior |
| **Entry** | From the public Library discovery/profile availability surfaces |
| **Preconditions** | No pre-authenticated context required; post-auth tenant selection follows the Master PRD's tenant model |
| **Main path** | Request authentication → verify (per the governing PRD lifecycle thread) → enter the authenticated tenant context |
| **Branches** | ⭐ **Product Owner decision (2026-10):** V1 Google Sign-In `DENIED` remains **same-surface** with **non-enumerating, cause-agnostic retry/credential guidance**; public discovery is the unauthenticated fallback; ⛔ no retry counts, lockout durations, timeouts, error codes or cause disclosure invented. Number/OTP lifecycle remains **V2** (`MASTER_PRD` v1.13 `ADR-0129`). *(Prior state, correct until this decision: branch was `UNRESOLVED`.)* |
| **Success** | Authenticated context established; next surface is the tenant's authorized Library/booking surface (not a Community participation surface) |
| **Failure / Recovery** | `DENIED` — same-surface denial with retry/credential correction guidance; `UNAVAILABLE` — fallback to public discovery; no draft metric approval |
| **Exit** | Public discovery/profile remains the unauthenticated fallback (`MP-CON-11` no-demo/no-guest limb preserved) |
| **Permissions** | No new permission created; tenant-scoped roles follow PRD-007 ownership |
| **Accessibility** | Idle/timeout and keyboard/touch parity per `ACCESSIBILITY.md` (WCAG 2.1 AA, `DDR-0004`); reduced-motion variant where applicable |
| **Traceability** | PRD-007 session/device lifecycle; `MP-CON-11` no-demo guardrail; `ADR-0121/0128` guard |

---

## 5. V1 library joining / setup — source-bounded, enrolment-owned

**Covers:** entering a library's enrolment surface; it is enrollment-owned, not a design-defined "setup wizard".

| Item | Evidence |
|---|---|
| **Actor** | Prospective/approved student; Reception where the enrolment surface authorises assistance |
| **Goal** | Enter the library's enrollment surface and reach the next authorized availability/seat step |
| **Entry** | From library discovery Results → Library Profile §14A.5 allow-list path |
| **Preconditions** | Library discovery/profile view already authorized (`LIB-14B.7`–`.29`) |
| **Main path** | Discovery profile → enrolment projection (frozen Library enrolment surface) → next authorized Library-owned step |
| **Branches** | ⭐ **Product Owner decision (2026-10):** an **enrolment-request path** exists for an **unenrolled student** within the §5 library-joining scope; ⛔ no approval workflow, status, UI detail, API, schema, permission or notification is invented or implied. *(Prior state, correct until this decision: branch was `UNRESOLVED`.)* |
| **Success** | Enrolled/enroled-candidate state recorded; next step shown is the `LIB-DISC-003` boundary path |
| **Failure / Recovery** | `DENIED` — remain on Library Profile with permission-denied recovery; `UNAVAILABLE` — same-surface fallback |
| **Exit** | Back to Discovery/Profile or departure without enrolment state change |
| **Permissions** | `LIB-14B.27` / `PO-4` — enrollment boundary; no additional Library setup state created |
| **Accessibility** | Same pattern as §1: empty/loading/error states per `DESIGN_QA.md` §3; list/collection density responsive per `RESPONSIVE_DESIGN.md` |
| **Traceability** | §14A.5 allow-list, `LIB-14B.26`–`.29`, `PO-4` |

---

## 6. V1 membership-derived participation — DEFERRED (V2)

**DEFERRED — V2.** Master PRD §5.2 `MP-SCOPE-04` and §8 V2 roadmap place Community & Groups in V2. The PRD-021A status conflict does not alter that explicit V1 exclusion. No community participation flow is included in V1. This item is not an approved V1 behaviour and is not named as a V1 acceptance subject.

## 7. V1 seat assignment/lifecycle — source-bounded ledger, not a design-defined flow

**Covers:** the booking outcome as the canonical shared reference point for seat occupation; the assignment lifecycle itself is a backend ownership question, not a UX behaviour invented here.

**Reference purpose:** to list the source-cited facts this journey must preserve, so that any future behavioural description does not contradict them.

- Booking outcome is rendered per the owning operation's actual result (frozen PRD-007 §12).
- Public discovery is non-leaky: `LIB-14B.23`–`.25` private/unavailable non-discoverability holds.
- Availability remains aggregate (`LIB-14B.11`–`.14`) and authenticated availability follows PRD-007 `SEAT-FR` without exposing another allocation.

⭐ **Product Owner decision (2026-10):** V1 seat assignment/lifecycle is authorized within the existing seat-management and booking scope; ⛔ no assignment method, transfer rule, approval workflow, status, UI detail, API/schema, permission or notification is invented or implied. *(Prior state, correct until this decision: detailed assignment-lifecycle choreography beyond the Outcome stage in §1 was unresolved.)*

## 8. V1 attendance entry/exit & occupancy signals — source-bounded observation

**Covers:** observable occupancy signals that are already constrained (privacy review → `SPX-GAP`); marking attendance is not itself designed here.

**Reference purpose:** occupancy is displayed under the aggregate boundary already set (`LIB-14B.11`–`.14`).

⭐ **Product Owner decision (2026-10):** V1 attendance is authorized as the PRD-006 V1 modes — Fixed QR, Dynamic QR, Fixed QR + Wi-Fi, Fixed QR + GPS, Manual (staff-attested), and additive Wi-Fi Presence — as independent alternatives within the existing attendance/roster scope; Face remains V3 per `ATT-GAP-015` and RFID remains out of V1. No additional mode, QR-content, hardware, timer, schema or permission is decided by this document. *(Prior state: attendance-entry UX was `UNRESOLVED`.)*

## 9. V1 QR / GPS / optional Wi-Fi validation — DEFERRED, source-gated

These physical-layer signals are not display-level design. Where a physical check is required by the source, the flow treats it as an externally validated signal, not a screen state invented here. **Source:** attendance validation family — `docs/30-product/attendance-management/PRD-006_ATT-GAP-*` (ATT-GAP-015/017 Wi-Fi/GPS/QR decision records); physical-layer signals are not authorized as display states in this document.

⭐ **Product Owner decision (2026-10):** QR/GPS/Wi-Fi verifications are authorized V1 signals gating the §8 modes; ⛔ no validation display state beyond same-surface DENIED/UNAVAILABLE with generic guidance is invented. *(Prior state, correct until this decision: QR/GPS/Wi-Fi validation as product behaviour was unresolved.)*

## 10. V1 student management — retained service composition, source-bounded

This section is a reconciliation-level roster of **retained V1 compositions** and their governing PRD citations, per `DESIGN_IMPLEMENTATION_TRACEABILITY.md` §8.1. It does not approve any screen file or combine systems.

- **Membership lifecycle** — PRD-006/007: enrolled → active occupancy → archived.
- **Parent linkage** — Source-cited: `BC-18 ConsentRecord` and `PRD-006` parent linkage where authorised.
- **Seat occupant history** — Source-cited: `SEAT-FR-076`–`.086` row-level eligibility; audit-trail visibility follows `AUD-GAP-001` boundary.

⭐ **Product Owner decision (2026-10):** V1 student management remains roster-derived detail; no dedicated form/picker/approval family is invented beyond the existing roster surface. *(Prior state: detailed form/picker/approval steps within each retained composition were `UNRESOLVED`.)*

## 11. Flow quality, states, and cross-flow navigation

Every retained flow stage cites its source and marks boundaries where the source does not authorize a behavior. Candidate states from draft PRD-021C are not inherited as requirements. Exact screen implementations and QA remain outside this scope reconciliation.

**Cross-flow navigation:** Library discovery (§1) is the entry; §4 (auth) gates entry to authenticated occupancy/revenue journeys (§2/§3). §5 (library joining) ties back to Discovery → Profile. Staff operational traces (receipted in §1–§2) return to Library/Profile where available. No candidate `UNRESOLVED` branch is navigated — each `UNRESOLVED` is a deliberate boundary that *prevents* a transition until the owning office confers.

**State coverage:** loading / empty / error / denied / unavailable / recovery / exit map are the same requirement pattern recorded in `DESIGN_QA.md` §3 S1–S12 and `DESIGN_ENGINEERING_HANDOFF.md` §5. A stage not listed in §1's citation table is not a handoff subject until it is added there.

## 12. V1 scope reconciliation — Founder/Product Authority decision

**PRODUCT SCOPE DECISION — OPTION C (2026-09-30), RECONCILED:** Neither the seven proposed screen families nor the observed implementation inventory independently defines V1. The retained and deferred surface mapping is recorded in `DESIGN_IMPLEMENTATION_TRACEABILITY.md` §8.1 using approved/frozen V1 PRDs and the established product role structure.

This is a product-scope reconciliation only. It does not approve implementation, backend behavior, permissions, undocumented features, QA, or constitute a separate G1 gate-owner act. Relationship: `DBT-006` (`DESIGN_DEBT.md`) records the surface-mapping question as **RECONCILED**; this §12 is the reconciliation's prose representation.

The reconciliation must cover both (a) core Student/Parent journeys — discovery, library selection, availability, seat/shift selection, and booking/outcome — and (b) core Reception, Manager, and Owner operational journeys already defined by V1 PRDs. Existing implementation is not automatically approved scope; proposed surfaces are not automatically approved scope. Retained source-bounded flows are bounded by their cited requirements; Community and unsupported screens are deferred from V1. No behavior from draft-only requirements is promoted to approved scope.

---

*Reviewed against: `INFORMATION_ARCHITECTURE.md` (APPROVED G1) · `SCREEN_ARCHITECTURE.md` (APPROVED G1) · `G1_EXPERIENCE_ARCHITECTURE_APPROVAL_RECORD_2026-10-01.md` (2026-10-01 PASSED/CONFIRMED, UX Architecture Owner + Information Architecture Owner, navigation labels escalated to Founder/Product Authority, DBT-006 RECONCILED) · `DESIGN_DEBT.md` `DBT-006` · library §§14A–14B · PRD-007 · Master PRD §8/§5.2 `MP-SCOPE-04` · `ACCESSIBILITY.md` (APPROVED G2 `DDR-0004`) · `RESPONSIVE_DESIGN.md` · `SECURITY_PRIVACY_UX.md` §5 · `PERFORMANCE.md` — no invented requirement, decision, permission, screen, component, token, or governance. Exactly one file modified.*
