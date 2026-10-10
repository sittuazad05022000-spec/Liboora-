<!-- LIBOORA Design Documentation Foundation | 2026-09-09 | v0.2 2026-10-26 — production-grade rewrite; no requirement, decision, or rank invented -->

> This document is design governance and documentation. It does not amend product requirements, architecture decisions, bounded-context ownership, permissions, or backend contracts. Where it disagrees with any ranked document, the ranked document wins.

# LIBOORA Design to Engineering Handoff

| Field | Value |
|---|---|
| Status | PROPOSED — handoff contract (the per-surface traceability row is the enforceable contract; gate outcomes live separately at the G-records) |
| Owner | Design–Engineering Handoff Owner |
| Rank | **UNRANKED.** Carries no precedence over any ranked PRD, ADR, BC Map or [`DOCUMENTATION_BASELINE.md`](../00-governance/DOCUMENTATION_BASELINE.md) entry |
| Sources | [`DESIGN_SYSTEM.md`](DESIGN_SYSTEM.md) (APPROVED G2 — foundations §2: colour `DDR-0001` · type `DDR-0002`/`DDR-0029`/`DDR-0031`/`DDR-0032` · spacing `DDR-0027` · radius `DDR-0003`/`DDR-0028` · elevation `DDR-0028` · illustration `DDR-0013`) · [`FIGMA_FOUNDATION.md`](FIGMA_FOUNDATION.md) · [`DESIGN_QA.md`](DESIGN_QA.md) §3 states S1–S12 + §5.4/§5.5/§6/§8 · [`ACCESSIBILITY.md`](ACCESSIBILITY.md) (`DDR-0004` WCAG 2.1 AA) · Library §§14A–14B · BC Map §8 `BC-18`/`BC-19` |
| V1 scope | Library discovery (public, §§14A–14B) · student seat booking (`BC-04` / PRD-007) · account/session shell. `MP-CON-11` no-demo · Community is V2 (`C-001`) |
| Downstream row | [`DESIGN_IMPLEMENTATION_TRACEABILITY.md`](DESIGN_IMPLEMENTATION_TRACEABILITY.md) — one DIT row per handoff; reusable form [`templates/`](templates/) |

---

## 1. What this document is and is not

* **Is:** the contract that states when a designed surface is ready to be built, what engineering must treat as authoritative, and what happens when the build and the design disagree. Every requirement below defers to the ranked source that owns it; this document contributes no new number.
* **Is not:** an API spec, a database or BC Map amendment, a permission grant, a rate-limit change, a retention decision, or a `SPX`-row closure. Engineering's authority over API shape, `BC-*` ownership, event contracts, permissions and quotas is separate and survives this document.

## 2. Handoff package — every surface handoffs these items together

A surface is not handed off as a screenshot with a link. It handoffs a **package** — the twelve items below travel together, and the package is not accepted if any required item is missing or unreasoned.

| # | Package item | What the package must contain (verbatim field name where relevant) | Governing reference |
|---|---|---|---|
| 1 | Canonical Figma link / artifact ref | The versioned frame that is the subject of this row (frame URL or committed export) — not a second draft of the same surface | §4 readiness; Figma is the implementation mechanism, not the authority |
| 2 | Screen & component inventory | The `SCREEN_ARCHITECTURE.md` §1 family the surface belongs to, and the component inventory that composes it | `SCREEN_ARCHITECTURE.md` §1; `DESIGN_SYSTEM.md` §3 |
| 3 | Responsive variants | The breakpoint frames that actually change (`compact`/`medium`/`expanded` per `DDR-0005` D-1…D-4, density per `DDR-0004`) or `N/A` with the `RESPONSIVE_DESIGN.md` D-rule that exempts the surface | [`RESPONSIVE_DESIGN.md`](RESPONSIVE_DESIGN.md) v0.1; `DDR-0027` (no new spacing value) |
| 4 | Content & tail notes | The long/short-text consequences (incl. the Devanagari fallback `Noto Sans Devanagari` `DDR-0029`; `CP-B1`/`FA-GAP-003` remain `BLOCKED / UNVERIFIED`), overflow/truncation with readable fallback | `DDR-0029` + `DEVANAGARI_RENDERING_PROBE.md` |
| 5 | Interaction states | Default → hover/focus (where applicable) → active/pressed → disabled/unavailable → selected → validation-state, plus the S-state IDs that are actually framed | `DESIGN_QA.md` §3 S1–S12; §5.3 |
| 6 | Loading, empty, error, offline, stale | Each applicable `DESIGN_QA` state is framed or marked `N/A with reason` on the Figma frame; an omitted applicable state without that tag is `DESIGN_QA` §8 `RETURNED` | `DESIGN_QA.md` §3/§8 |
| 7 | Accessibility annotations | Target size ≥ 48 dp / separation ≥ 8 dp (`DDR-0004`), focus order + ring, accessible name/role/state, non-colour cue, 200% text-growth frame, and the `reduced-motion` variant — never an unreviewed pass | `ACCESSIBILITY.md` (APPROVED G2); `DDR-0004` |
| 8 | Asset exports & usage rules | The exports the surface actually uses, at ≤5% premium 3D-style illustration (`DDR-0013` `70/25/5`); no heavy-illustration gate on the primary task | `DESIGN_SYSTEM.md` §2 illustration (RECOMMENDED; reconciled `DDR-0013`) |
| 9 | Performance notes | The surface's performance posture per `PERFORMANCE.md` §1 (the primary task is not gated on a heavy illustration/bulk payload/font load) — measured against no `NFR_BUDGETS_V1` budget identifiers; those are not claimed here | `PERFORMANCE.md` §1 |
| 10 | Tokens consumed | The §4 variable collection or class those colours/type/spacing/radius/elevation resolve against (see §4), with `theme.dart` delta called out where `DBT-001`/`DBT-005`/`DIT-001` still divergence-spans it | `DESIGN_SYSTEM.md` §2 + `FIGMA_FOUNDATION.md` §3 |
| 11 | PRD traceability | The frozen/Library/BC section that authorises every claimed behaviour (e.g., `LIB-DISC-003`, `14B` `LIB-14B.07–.10`, `BC-18` `ConsentRecord`) — any behaviour without a section is `TO BE DECIDED` with its `SPX-GAP-*`/`DD7-GAP-*`/`DBT-*` | `SECURITY_PRIVACY_UX.md` §5; `DESIGN_DEBT.md` §2 |
| 12 | Unresolved questions & approval evidence | Each `TO BE DECIDED` **on the frame** (not hidden in a comment) with its gap identifier + owning office (Privacy Owner, Security Platform, Founder/Product Authority…), plus the `DESIGN_QA.md` review record the handoff builds on | `DESIGN_QA.md` §8; G-records per §4 |

The form of record is the per-surface template at [`templates/`](templates/) (use the template's exact field names); the register of rows lives at [`DESIGN_IMPLEMENTATION_TRACEABILITY.md`](DESIGN_IMPLEMENTATION_TRACEABILITY.md).

## 3. Design → engineering behaviour contract — the authoritative reserves (preserved verbatim)

- Design **does not** define API shape, database structure, bounded contexts, event contracts, permissions, quotas, locks, ranking, or booking authority.
- Engineering **does not** silently reinterpret a frozen requirement through a visual implementation.
- A product question is escalated to **Founder/Product Authority**.
- An architecture or ownership question is escalated to the applicable **Architecture Owner**.
- A design-system question is escalated to **Design System Owner**.
- Community privacy/safety behaviour is `DRAFT` + conflict `C-001` (`SECURITY_PRIVACY_UX.md` `SPX-GAP-009`) — handoff does not spec it.

## 4. Tokens and foundations — what engineering must bind to (no invented value)

Every colour/type/spacing/radius/elevation/motion value resolves to the decided or ratified scale at the named DDR — the same scales recorded verbatim in [`DESIGN_SYSTEM.md`](DESIGN_SYSTEM.md) §2 and translated to Figma variables at [`FIGMA_FOUNDATION.md`](FIGMA_FOUNDATION.md) §3. Two facts about implementation status are already decided there and are repeated here because they determine the engineering step:

- **Decided but ⛔ NOT claimed implemented in `theme.dart`.** `accent-ink #92400E` · `text-muted #5F6585` (replacing `#6B7194`) · `border/control #7F87A6`; retired radii `14`/`18` (scale is `8`·`12`·`16` only, pill = chips); `LiblRadius` missing; typeface `Noto Sans` + `Noto Sans Devanagari` (SIL OFL) still reads `fontFamily: 'Roboto'` at `theme.dart` L49. `Noto` bundle/fallback (`fontFamilyFallback`), `LiblText` (`400/500/600/700`; `800+` excluded), and `LiblRadius` are **separate implementation-conformance work** — no new design decision authorizes or defers them.
- **The gap is a CONFLICT, not a blocker.** The divergence is recorded as `DBT-001`/`DBT-005` (Design Debt, now RESOLVED — five limbs decided) and as [`DESIGN_IMPLEMENTATION_TRACEABILITY.md`](DESIGN_IMPLEMENTATION_TRACEABILITY.md) `DIT-001`, whose status is `CONFLICT` (`DESIGN_SYSTEM.md` §2.1) — handoff accepts this fact, it does not hide it.

Engineering binds to the **decided** values; the above are tracked once (`DBT-001`/`005`, `DIT-001`), not reargued per surface.

## 5. Required states, edge cases, and acceptance — the contract's "ready" bar

A surface is reviewable when the happy path alone is designed; it is **hand-off-ready** only when the five confirmations below plus the traceability row (§2 #11) are complete. "Designed" is a visual fact; "ready" is a **reviewed** fact.

| # | Confirmation | Confirmed by | What "ready" means (verbatim check, not paraphrase) |
|---|---|---|---|
| 1 | State coverage | **Design QA Owner** | Every applicable `DESIGN_QA.md` §3 state (S1 empty · S2 loading · S3 populated · S4 at-limit incl. Devanagari tails & 200% text growth · S5 network/service error · S6 not-found/unavailable · S7 not-eligible/rejected — `MP-CON-11` no-demo · S8 permission/session · S9 stale/offline — `CP-B1`/`FA-GAP-003` `BLOCKED / UNVERIFIED` where staleness touches Devanagari · S10 filtered · S11 confirmation · S12 success-with-side-effects) is framed or is `N/A with reason` on the Figma frame (`DESIGN_QA.md` §8). |
| 2 | Accessibility | **Accessibility Owner** | The accessibility annotations in §2 #7 are present and reviewed; WCAG 2.1 AA at `DDR-0004` ratios (4.5:1 text / 3:1 large) is used; text growth and reduced-motion are evidenced, not asserted. |
| 3 | Performance posture | **Design Performance Owner** | The frame's asset/effect posture per `PERFORMANCE.md` §1 is confirmed; the primary task is not gated on heavy media — a per-surface budget-identifier claim is not asserted here. |
| 4 | Traceability row | **Design–Engineering Handoff Owner** | The §2 #11 row names one frozen section per claimed behaviour; every `TO BE DECIDED` cites one `SPX-GAP-*`/`DD7-GAP-*`/`DBT-*` with its owning office, on the frame (never comment-only). |
| 5 | V1 scope | **Handoff Owner (scope gate)** | The surface's products are the retained V1 families in `INFORMATION_ARCHITECTURE.md` §2 (Discover · Library · Study access · Participation · Operations) or the approve-and-registered flows in `USER_FLOWS.md` §1–§4; Community/group/OTP/gateway surfaces are V2-`TO BE DECIDED`, not V1 handoff subjects. |

Where a downstream row has been filed at [`DESIGN_IMPLEMENTATION_TRACEABILITY.md`](DESIGN_IMPLEMENTATION_TRACEABILITY.md): the row number is the per-surface handoff's link.

## 6. How handoff resolves a build-vs-design mismatch (no silent reinterpretation)

If implementation reveals a mismatch between the handoff package and the governing frozen/PRD/BC source or the decided token — including a `DIT-001` conformance gap where the as-built value still reads the shipped one:

1. **Do not patch** the frozen PRD, the baseline, the BC Map, or a `G2`-approved design-system value from inside the handoff.
2. Record the impact in the handoff package's downstream row (state, traceability, and token fields) and link the source that is in conflict — a code file alone is not a source.
3. Route via [`DESIGN_CHANGE_MANAGEMENT.md`](DESIGN_CHANGE_MANAGEMENT.md) §3: if design direction must change, a **decision record** (`DDR-*`) is created by the owning office; if the ranked document must change, governance follows `DDR-0003`'s precedent (no silent side-effect fix).
4. No work resumes on the affected surface until the decision record or ranked-document amendment lands — a comment-level "we'll address it" does not move the package past `RETURNED`.

## 7. What this handoff does with open-but-ranked decisions

- **Consent & privacy:** no consent string, `BC-18` `ConsentRecord` wording, or PII-display vocabulary beyond the allow-list is decided here — rows remain `OPEN` with `SPX-GAP-001…003` until Privacy Owner decides.
- **Devanagari rendering guarantee:** the guarantee is `CP-B1`/`FA-GAP-003` `BLOCKED / UNVERIFIED` (no PASS exists) — the handoff frames the fallback (`Noto` pair + `fontFamilyFallback` + readable tail handling) but asserts no rendering pass.
- **Community privacy:** A6 privacy/safety remains `DRAFT` + `C-001`; `SPX-GAP-009` blocks a community handoff until the baseline conflict is resolved.

---

*Reviewed against: `DESIGN_SYSTEM.md` (APPROVED G2; colour `DDR-0001` — `accent-ink`/`accent-fill`/`text-muted`/`border/*`; type requirement `DDR-0002` + family `DDR-0029`/sizes `DDR-0031`/weights `DDR-0032`; spacing ratified `DDR-0027` · radius `DDR-0003`/`DDR-0028` · elevation `DDR-0028` · illustration `DDR-0013`; responsive classes `DDR-0005`/`DDR-0004`/`DDR-0034`; debt `DIT-001 CONFLICT`) · `DESIGN_GOVERNANCE.md` §2 (rank + `APPROVED`/`RETURNED`/`CONFLICT`/`TO BE DECIDED`/escalation), §3 rule 2 · `ACCESSIBILITY.md` (APPROVED G2, `DDR-0004`) · `DESIGN_QA.md` §3/§6/§8/§9 · `FIGMA_FOUNDATION.md` §1–§8 · `UX_ARCHITECTURE.md` §9 (V1/V2) · `SCREEN_ARCHITECTURE.md` §1 · `USER_FLOWS.md` §1 · `INFORMATION_ARCHITECTURE.md` §2 · `SECURITY_PRIVACY_UX.md` §5 · `PERFORMANCE.md` §1 · `PRD-021A A6 + C-001` · `ADR-0077`; no invented requirement, decision, token, component, governance, or implementation fact — exactly one file modified.*
