# DP-0012 — IMPL-433: `MM-FR-116` renewal-due "recently expired and not yet renewed" window (BC-02)

> **⚠ STATUS: PROPOSED — NOT DECIDED.**
> This record is a **decision request** prepared by the IMPL-433 implementer, convened by the Product
> Owner at operator direction, on 2026-11-01.
> **No selection below is an approved decision for M-1, M-2, M-3 or M-4.** Each becomes authoritative
> only when the **BC-02 Domain Owner (Library Domain)** selects an option and signs the ratification block
> at the end of this document.
>
> **The "recently expired and not yet renewed" half of `MM-FR-116` is currently NOT served and is NOT
> blocked by any missing machinery**: the sole blocker is that no frozen requirement defines the window,
> and this record must not invent one on the owner's behalf. The expiring half, the today's-renewals list,
> the expired list and all of `MM-FR-115`, `MM-FR-117` and `MM-FR-118` are implemented and tested.
>
> No PRD, ADR, code, test or schema has been modified to reflect any matter, and none may be until the
> Domain Owner decides. This record has not been committed or pushed.

| Field | Value |
|---|---|
| **Type** | Decision request — four matters (M-1, M-2, M-3, M-4) |
| **Status** | PROPOSED · 0 decisions received |
| **Supersedes** | none |
| **Authorizes** | IMPL-433 renewal-due half (upon decision + any required ratification only) |
| **Sponsor / Owner** | **BC-02 Domain Owner (Library Domain)** — sole deciding authority for all four matters (`PRD_OWNERSHIP_MODEL.md:162`) |
| **Convenor** | Product Owner (record prepared by the IMPL-433 implementer, 2026-11-01) |
| **Parties affected** | Library Domain (BC-02); Configuration (`BC-25`, `E-19`) if M-3 selects a new or re-scoped configurable |
| **Prepared** | 2026-11-01 · HEAD `efefcddb125c53e6ed6bc14464e1ced189ed706a`, branch `fix/opaque-cursor-pagination-h3` |
| **Updated** | — |
| **Next review** | On receipt of the first Domain Owner decision |
| **Links** | `PRD-MEMBERSHIP-MANAGEMENT.md` (frozen, `PRD-005` v1.6) · `PRD_OWNERSHIP_MODEL.md` · `HUMAN_AUTHORITY_AUDIT-001.md` · `PRD_LIFECYCLE.md` · `DOCUMENTATION_BASELINE.md` · `ADR-0019` · `ADR-0149` · `ADR-0150` · `TRACEABILITY_MATRIX.md` · `PRD-005_IMPLEMENTATION_TASKS.md` · `DP-0011` (adjacent PROPOSED record, no overlap) · `lib/bootstrap/di.dart` · `lib/bootstrap/codecs.dart` · `lib/app/shared/library_boundary.dart` · `lib/domain/library/membership/membership.dart` · `test/membership_operational_views_test.dart` |

---

## Background — the unserved half of `MM-FR-116`

`IMPL-433` (`PRD-005_IMPLEMENTATION_TASKS.md:246`) requires the four operational views per `MM-FR-115`,
`MM-FR-116`, `MM-FR-117`, `MM-FR-118`. Current verified state:

| `MM-FR-116` surface | Frozen requirement | Implementation | Status |
|---|---|---|---|
| Renewal-due — **expiring** half | "Expiring" (`PRD-MEMBERSHIP-MANAGEMENT.md:981`) — driven by `MM-CFG-008` threshold (default 7, `:1350`) via `MM-BR-026` (`:1353-1354`) | Expiring-memberships view in `membershipListPage` (`lib/bootstrap/di.dart:349-438`) | ✅ Implemented + tested |
| Renewal-due — **recently expired and not yet renewed** half | "recently expired and not yet renewed" (`:981`) — **window not defined anywhere in the frozen PRD** | **No `renewalDue` method exists in the repository** (verified: 0 hits) | ⛔ **NOT SERVED — this record** |
| Today's renewals | "Renewals created today" (`:982`) | `todaysRenewals()` (`lib/bootstrap/di.dart:467-483`), interface `lib/app/shared/library_boundary.dart:267-271` | ✅ Implemented + tested |

The implementation note in the code (`lib/bootstrap/di.dart:485-490`) records the reason:

> `MM-FR-116` note — the renewal-due list's "recently expired" half is NOT served here: its window is not
> defined by any frozen requirement. `MM-CFG-008` is bound, by `MM-BR-026`, to exactly two consumers —
> `MM-EVT-006` and the expiring-memberships view — and extending it to "recently expired" would invent a
> meaning the rule did not grant. See the IMPL-433 report; this half waits on a BC-02 domain-owner ruling.

`test/membership_operational_views_test.dart` runs **19 tests, all passing**, covering the expiring view,
today's renewals, cursor traversal and the timezone normalization; there is deliberately **no** renewal-due
test for the unserved half.

**Why no default is proposed here.** Every one of the four matters lands on a frozen Rank 3 requirement or
a business rule; the deciding authority is the **BC-02 Domain Owner (Library Domain)**, derived, never
chosen (`PRD_OWNERSHIP_MODEL.md:121-124, :162`). A change to `MM-BR-026` or to the `MM-CFG-*` register
(currently held at 9 through v1.5 and v1.6 — `TRACEABILITY_MATRIX.md:230, :3611-3612`) is a business-rule
change on a frozen PRD and cannot be made by the implementer. **The operator-convened panel declined to
recommend an option** so the owner's latitude is not narrowed by the preparer's preference.

---

## Matter 1 (M-1) — What window defines "recently expired"?

### Question

`MM-FR-116`'s renewal-due row (`PRD-MEMBERSHIP-MANAGEMENT.md:981`) reads *"Expiring **plus** recently
expired and not yet renewed."* What exact window makes a membership "recently expired" — i.e. which
`Expired` memberships belong on the renewal-due list?

### Evidence (verified)

- The word **"recently"** is quantified nowhere in `PRD-MEMBERSHIP-MANAGEMENT.md` (full-document search):
  the `MM-CFG-*` register (`:1341-1351`) holds nine configurables and none is a recently-expired window;
  no `MM-AC-*` criterion names one (`MM-AC-032`…`MM-AC-040` are term/successor criteria, `:1824-1832`).
- The expired **view** uses a **user-selected** date range — *"`Expired`, `endDate` within a **selected
  window**"* (`:980`), filterable under `MM-FR-115` (`:986-987`) — distinct from the renewal-due list's
  implicit "recently" window.
- `MM-FR-081` (`:816-817`): *"Renewal MUST be permitted from `Expired` **without limit of elapsed time** in
  V1"* — so the window is **not** a renewal-eligibility bound; it is purely a **staff task-list scoping**
  decision. A two-year-old `Expired` membership is renewable but arguably not "due" today.
- `MM-GAP-001` (`:2050`) — the `Q-01` grace-period question — concerns **entitlement extension / seat
  release**, **not** the renewal-due list's window. It is a different fact and is not reopened here.

### Options considered (NOT DECIDED — selection required)

| Option | Description | Consequences | Disposition |
|---|---|---|---|
| **A** | **Named calendar window after `endDate`** (e.g. expired within N days) | Needs its numeric value defined (→ M-3 decides configurability); depends on M-3/M-4 for whether `MM-CFG-*` moves off 9 and whether `MM-BR-026` text changes | **NOT DECIDED** |
| **B** | **"Renewal permitted" semantics** — any `Expired` membership eligible under `MM-FR-081` appears regardless of elapsed time | Conflates the task list with the unbounded renewal-eligibility rule; the list grows without bound — against the operational-views intent (`MM-FR-113`, `:969-970`: *"what must staff do today?"*) | **NOT DECIDED** |
| **C** | **Compose from the expired view's selected window** — "recently expired" := the same `endDate` range the user selected in the expired view | No new constant; reuses `MM-FR-115`'s filter machinery; but `renewalDue()` has no "selected window" parameter today, so it would need one or a value the view does not otherwise carry | **NOT DECIDED** |
| **D** | **No window — interpretation only** — "recently" is ordinary screen-on-renewability wording, not a named constant | If the owner reads it this way, option D needs **no** PRD text change; the risk is that "recently" then binds to nothing and the list inherits option B's unbounded semantics | **NOT DECIDED** |

### Impact
- **If the window is a named constant** (A, or C-with-value): the value must live somewhere — the `MM-CFG-*`
  register currently ends at `MM-CFG-009` (9 — `TRACEABILITY_MATRIX.md:230`, preserved at 9 by the v1.5/v1.6
  amendments, `:3611-3612`). A tenth member or a re-scope of `MM-CFG-008` is a PRD content change on a
  frozen document (→ M-3, M-4).
- **If it is interpretation-only** (D): implementable with **no** PRD/ADR change, but only if the owner's
  reading is recorded, and the unbounded-growth consequence must be accepted or excluded by M-2.
- Compatibility: none of A–D changes any persisted representation (`endDate` and `renewedFromMembershipId`
  are already stored per `MM-FR-084`, `:827-828`).

### Conflicts evaluated
- vs `MM-FR-081`'s unbounded elapsed time (`:816-817`): a named window (A/C) does **not** conflict — it
  scopes a task list, it does not restrict eligibility. Option D inherits the tension and must be chosen
  only if the owner accepts it.
- vs `MM-BR-026` (`:1353-1354`): only an option reusing `MM-CFG-008` touches the threshold that `MM-BR-026`
  binds to exactly two consumers. All such reads are M-3/M-4 material.
- vs `MM-GAP-001` (`:2050`): no overlap — grace/seat-release, not the view window. Recorded to prevent the
  two being conflated during implementation.

### Review conditions
- **Domain Owner signs** for the window definition (a domain-semantics act on a frozen requirement).
- If A or C is selected, M-3 (configurability) and M-4 (instrument) are prerequisites to any code; if D is
  selected, the owner's reading must be recorded in the implementation task and the bounded/windowless
  consequence accepted **in writing**.

---

## Matter 2 (M-2) — How is "not yet renewed" determined?

### Question

The renewal-due list must contain memberships that are *"recently expired **and not yet renewed**"*. What
membership state marks a membership as "already renewed" so it can be excluded?

### Evidence (verified)

- **Renewal does not mutate the previous membership's term** — `MM-FR-084` (`:827-828`) creates a **new**
  `Membership` with a new `membershipId` and records `renewedFromMembershipId` on the successor.
- **At most one successor** — `MM-INV-005` (`:1388`): *"A membership has at most one successor by renewal
  and at most one by upgrade."* Renewal is **rejected** if a successor already exists (`MM-FR-090`'s
  *"existing successor"* error, `:858-859`; `MM-AC-037`, `:1829`).
- **The lineage already exists in the model** — `membership.dart:742` finds successors by
  `renewedFromMembershipId == source.id`; the field is persisted (`codecs.dart:202`, `:254`) and populated
  on renewal (`domain/membership.dart:408,457,475`).
- **Only an upgrade transitions the source to `Superseded`** — `MM-FR-096` (`:881-882`) sets the source
  `Superseded` on upgrade; the `Superseded` meaning and its only transition are both upgrade-specific
  (`:712`, `:771`). **A renewal does NOT change the source's status**: `MM-FR-084` (`:827-828`) creates a
  new successor via `renewedFromMembershipId` and *"MUST NOT mutate the previous membership's term"`, so a
  renewed-from membership remains `Active`/`Expired` per its own lifecycle (`MM-FR-087`, `:848-849`).
  "Already renewed" is therefore identified **only** by a successor existing, not by a status change.

### Options considered (NOT DECIDED — selection required)

| Option | Description | Consequences | Disposition |
|---|---|---|---|
| **A** | **Derived from lineage** — "not yet renewed" := no successor exists (`renewedFromMembershipId == its id`); a new membership is created on renewal (`MM-FR-084`), with no status change to the source | Least new machinery; reuses the finder at `membership.dart:742`; no persisted change; deterministic | **NOT DECIDED** |
| **B** | **Renewed-window filter** — a membership is "renewed" only if its successor's `createdAt` falls inside the same "recently expired" window (M-1); outside it, the old membership reappears as not-yet-renewed | Bounds the list per window, but reintroduces the old membership even though a successor exists — semantically odd and requires a second rule to explain | **NOT DECIDED** |
| **C** | **State/flag** — add a persisted "renewed" marker on the source membership at renewal time | Contradicts `MM-FR-084`'s *"MUST NOT mutate the previous membership's term"* in spirit and adds a field the derived reading makes unnecessary | **NOT DECIDED** |

### Impact
- **Derived reading (A)** needs **no** PRD text change if paired with a M-1 window and no `MM-CFG-*`
  extension; implementation is a composition over existing state.
- None of A–C changes the event surface: `MM-EVT-003` (`:1163`) already carries `renewedFromMembershipId`.
- `MM-FR-090`'s at-most-one-successor rule (`:858-859`) is what keeps the lineage test sound — no new
  invariant needed.

### Conflicts evaluated
- vs `MM-FR-084` ("MUST NOT mutate the previous membership's term", `:827-828`): option C is in tension;
  A and B are not.
- vs `MM-INV-005` (`:1388`): A relies on it; it is not weakened.
- vs `MM-FR-096`/upgrade lineage (upgrade records `upgradedFromMembershipId`) — an upgraded source is also
  not "renewal-due"; the owner must specify whether the renewal-due list excludes upgrade-successors too.
  The model already treats both successors symmetrically (`membership.dart:742` covers renewal; the same
  pattern covers upgrade). Recorded as an open sub-point for the owner.

### Review conditions
- **Domain Owner signs** for the "not yet renewed" semantics (what counts as renewed, and whether an
  upgrade-successor also excludes the source).
- If A is selected, no dependency on M-3/M-4 for this matter; if C is selected, it is a persisted-format
  change on a frozen schema surface and must not be implemented without a successor amendment.

---

## Matter 3 (M-3) — Can `MM-CFG-008` be reused, or is a separate configurable required?

### Question

If M-1 selects a **named constant window**, where does that value live? Specifically: may the recently-
expired window reuse `MM-CFG-008`, or must it be a separate configurable (a tenth `MM-CFG-*` member)?

### Evidence (verified)

- `MM-CFG-008` (`:1350`): *"Expiring-soon threshold (days) | 7 | Drives `MM-EVT-006` and the expiring
  view."* Its name, note and default are all scoped to **expiring-soon**, not to recently-expired.
- `MM-BR-026` (`:1353-1354`): *"`MM-CFG-008` **MUST** be the single threshold used by both `MM-EVT-006` and
  the expiring-memberships view, so the reminder and the list can never disagree."* — it binds `MM-CFG-008`
  to **exactly two consumers**.
- `IMPL-407` (`PRD-005_IMPLEMENTATION_TASKS.md:164`) implements the nine `MM-CFG-*` through `E-19` with
  typed accessors; `MM-CFG-008` resolves to one value shared by `MM-EVT-006` and the expiring view.
- The `MM-CFG-*` register holds **9 members** and was deliberately **preserved at 9** through the v1.5 and
  v1.6 successor amendments (`TRACEABILITY_MATRIX.md:230, :3611-3612`) — the amendments explicitly did not
  extend it.
- The code's note (`di.dart:485-490`) explicitly declined to bind `MM-CFG-008` to a third consumer.

### Options considered (NOT DECIDED — selection required)

| Option | Description | Consequences | Disposition |
|---|---|---|---|
| **A** | **New configurable `MM-CFG-010`** "recently-expired window (days)" — a tenth register member | Clean separation from `MM-EVT-006`; but adds a member to a register preserved at 9 and changes the count → requires a successor amendment (M-4) and a matrix re-measure; a new `MM-CFG-*` id must be minted through the governed route | **NOT DECIDED** |
| **B** | **Reuse `MM-CFG-008`** for both sides of `endDate` (expiring-soon *and* recently-expired) | No register growth; but `MM-CFG-008`'s name/note/default ("expiring-soon") and `MM-BR-026`'s "two consumers" wording must change, and the reminder (`MM-EVT-006`) plus a third list would share one value, losing independent control | **NOT DECIDED** |
| **C** | **Reuse the value without a third binding** — the recently-expired window uses `MM-CFG-008`'s numeric value but `MM-BR-026` is extended to name the renewal-due list as a third consumer | Stays at 9 members; but still a text change to frozen `MM-BR-026` and to `MM-CFG-008`'s note → M-4 instrument is required regardless | **NOT DECIDED** |
| **D** | **No configurable** — hard-code the M-1 window in the view (or compose from M-1 D) | Simplest; but a hard-coded operational threshold contradicts the module's own driving principle (`MM-CFG-008`'s rationale note `:1356-1357` — thresholds should be configurable, not hard-coded) | **NOT DECIDED** |

### Impact
- A adds one `MM-CFG-*` and one `E-19` accessor and a traceability re-measure; B/C require a frozen-text
  change to `MM-BR-026` and `MM-CFG-008`; D requires a recorded decision to depart from the module's
  configurable-threshold convention.
- All four are **PRD-content or register changes** on a frozen document and therefore require the M-4
  instrument; none may be implemented by the implementer directly.

### Conflicts evaluated
- vs `MM-BR-026` (`:1353-1354`): B and C edit it; A and D leave it byte-unchanged.
- vs the configurable-threshold rationale (`:1356-1357`): A is most consistent; D least.
- vs the "one configurable for one meaning" precedent of `MM-CFG-008`/`MM-CFG-007`: B overloads one
  configurable with two meanings — a consequence the Domain Owner weighs against the alternative of a
  separate configurable.

### Review conditions
- **Domain Owner signs** for configurability choice; if B or C is selected the owner must also accept the
  loss of separation between the reminder and the renewal-due list (or accept that the reminder and the
  list now share semantics).
- Any register change (A, or the `MM-CFG-008` note/text changes in B/C) is a M-4 successor-amendment act.

---

## Matter 4 (M-4) — What amendment to `MM-BR-026` / the config register is required?

### Question

Every option except M-1-D / M-2-A / M-3-D touches frozen text or a register count. What governed instrument
records the owner's decision and any required text change?

### Evidence (verified)

- `PRD-005` is **FROZEN** at **v1.6** (`PRD-MEMBERSHIP-MANAGEMENT.md:7-8`), admitted to the baseline by
  `ADR-0019`, and **never silently modified** (`PRD_LIFECYCLE.md:177`).
- `PRD_LIFECYCLE.md:171-175` classifies changes: *"Any business-rule change → ADR → version increment →
  changelog → baseline update, in that order."* A new requirement (a configurable, or a new reading of
  `MM-BR-026`) is the same as a business-rule change (`:173`).
- **`MM-BR-026` is NOT among the four clarifying-pass rules.** `ADR-0019:315` scopes the post-freeze
  clarifying pass to `MM-BR-012/022/027/028` (changelog entry, no ADR). `MM-BR-026` is not one of them, so
  the clarifying-pass route does **not** cover a change to it.
- The **successor-amendment precedent** exists and is the established route for frozen `PRD` content:
  `ADR-0149` (v1.4 → v1.5) is recorded at `DOCUMENTATION_BASELINE.md:162` and `ADR-0150` (v1.5 → v1.6) at
  `DOCUMENTATION_BASELINE.md:393`, both as `PRD_LIFECYCLE.md` §4 successor amendments.
  `PRD_LIFECYCLE.md:67` bars a separate successor PRD (*"It is an amendment to
  that PRD, not a new one"*).
- **Amendment authority** for `PRD-005` is the **Domain Owner (Library Domain)**, by direct explicit
  conferral scoped to a **single act**, reverting on completion (`PRD-MEMBERSHIP-MANAGEMENT.md:10`,
  `ADR-0033` §7.1). The v1.5 conferral has **reverted**; any new amendment act requires a **new** conferral.
- The `MM-CFG-*` register count changed by a predecessor amendment is re-measured in
  `TRACEABILITY_MATRIX.md` §step 6 (condition: "if identifiers changed", `:3611-3612`).

### Options considered (NOT DECIDED — selection required)

| Option | Description | Consequences | Disposition |
|---|---|---|---|
| **A** | **Successor amendment (v1.6 → v1.7)** — a new accepted ADR as the instrument, carrying the owner's decision, with the version increment, changelog row and baseline update | The established, unambiguous route for any text/register change; requires a new single-act Domain Owner conferral; heavier than needed if the decision is pure interpretation (M-1-D / M-2-A / M-3-D) | **NOT DECIDED** |
| **B** | **Clarifying-pass changelog entry only** — treat the decision as clarifying `MM-FR-116`'s wording (e.g. reading "recently" as non-constant) | Lightest instrument; **only lawful if NO business rule or register count changes** (M-1-D / M-2-A / M-3-D combination) and stays within `ADR-0019:315`'s clarifying-pass scope; would not cover any `MM-BR-026`/`MM-CFG-*` text change | **NOT DECIDED** |
| **C** | **Interpretation-record only, no PRD text change** — record the decision in a governance record (this DP, once decided) and implement from the recorded reading | Zero PRD/ADR surface change; lowest ceremony; valid only for the no-text-change combination (M-1-D / M-2-A / M-3-D); consistent with `PRD_LIFECYCLE.md:200`'s bar on silently reinterpreting a requirement — a recorded reading must not be treated as an amendment | **NOT DECIDED** |

### Impact
- A is mandatory for any option that edits `MM-BR-026`, `MM-CFG-008`'s note, or mints `MM-CFG-010`.
- B/C are only lawful when the decision leaves frozen text byte-unchanged — i.e. the pure-interpretation
  combination. The owner must state which combination is selected so the instrument matches.
- No instrument is an authorization for code; code follows the recorded decision via the IMPL-433 task.

### Conflicts evaluated
- vs `PRD_LIFECYCLE.md:172` (*"Any business-rule change → ADR…"*): any textual change to `MM-BR-026` is a
  business-rule change and **must** use A.
- vs `ADR-0019:315` (clarifying-pass scope = `MM-BR-012/022/027/028` only): B may not be stretched to
  `MM-BR-026`.
- vs the reverted v1.5 conferral (`PRD-MEMBERSHIP-MANAGEMENT.md:10`): A requires a new single-act conferral
  from the human principal or the competent domain authority; the agent cannot self-confer.

### Review conditions
- **Domain Owner signs** selecting the instrument; if A is chosen, the successor amendment and its
  conferral are separate named acts this record does not perform.
- If the owner selects B or C, the record must assert the "no frozen text changed" condition explicitly.

---

## Consolidated summary — ALL PROPOSED · NOT DECIDED

| Matter | Question | Disposition |
|---|---|---|
| M-1 | What window defines "recently expired"? | **NOT DECIDED** — options A–D presented; no default |
| M-2 | How is "not yet renewed" determined? | **NOT DECIDED** — options A–C presented, A (derived) is the no-new-field reading |
| M-3 | Reuse `MM-CFG-008` or new `MM-CFG-010`? | **NOT DECIDED** — options A–D presented; no default |
| M-4 | What instrument records the decision / any frozen-text change? | **NOT DECIDED** — successor amendment (A) vs clarifying-pass (B) vs interpretation-record (C) |

**The record remains `PROPOSED — NOT DECIDED` until the BC-02 Domain Owner (Library Domain) selects
options and signs the ratification block below.**

---

## RATIFICATION BLOCK — explicit human decision and signature required

> This record must not be marked DECIDED, and no implementation may proceed from it, until the Domain Owner
> below signs. Signatures must not be fabricated, assumed, or entered by any agent — `DP-0011:314-324`,
> `HUMAN_AUTHORITY_AUDIT-001:18,23,30,33`, and `PRD_OWNERSHIP_MODEL.md:318-319` (no personal name recorded
> in-repository; incumbency lives in an external team directory).

| Role | Name | Decision (Approve / Amend / Reject per matter) | Date | Signature |
|---|---|---|---|---|
| **BC-02 Domain Owner** (Library Domain) — all four matters | ______________ | M-1: ☐ Approve ☐ Amend ☐ Reject · M-2: ☐ ☐ ☐ · M-3: ☐ ☐ ☐ · M-4: ☐ ☐ ☐ | ______ | ______________ |

> **Authority disclosure consistent with `HUMAN_AUTHORITY_AUDIT-001`:** the Domain Owner office is
> **assigned** (`PRD_OWNERSHIP_MODEL.md:162`) but its **personal incumbent is NOT recorded** in-repository
> (`HUMAN_AUTHORITY_AUDIT-001:23`), and the Human Principal identity is **UNVERIFIABLE** from repository
> evidence (`HUMAN_AUTHORITY_AUDIT-001:18`). A signature is therefore a **human-executed act** entered in
> the block above; no agent may auto-ratify on the office's behalf.

---

## Decision history

| Date | Change |
|---|---|
| 2026-11-01 | Opened as **PROPOSED**: four matters (M-1 window, M-2 "not yet renewed", M-3 configurability, M-4 instrument) presented with verified evidence and options; **zero decisions, zero signatures**; verdict **AWAITING DOMAIN OWNER DECISION**; no implementation, no commit, no push |

---

*End of `DP-0012`. ⛔ **PROPOSED — NOT DECIDED.** No option in M-1…M-4 is an approved decision; each is
authoritative only after the BC-02 Domain Owner (Library Domain) selects it and signs the ratification
block. **No PRD, ADR, code, test or schema was modified** to reflect any matter; the renewal-due
"recently expired" half of `MM-FR-116` remains **NOT SERVED** (`lib/bootstrap/di.dart:485-490`) pending the
decision. **No commit, no push performed by this record.***
