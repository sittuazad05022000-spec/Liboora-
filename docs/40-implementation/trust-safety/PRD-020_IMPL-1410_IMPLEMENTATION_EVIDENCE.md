# `PRD-020` Trust & Safety — `IMPL-1410` Implementation Evidence Record

| Field | Value |
|---|---|
| **Document type** | 📏 **Measurement record — implementation evidence.** This document **measures**; it does **not** confer, close, freeze, rank or advance anything |
| **Subject** | `IMPL-1410` — *"Synchronous send-time check, fail-closed, p99 ≤ 50 ms"*, the implementation half of **`TSF-GAP-003`** |
| **Authorising decision** | [`ADR-0065`](../../00-governance/adr/ADR-0065-synchronous-enforcement-check-transport.md) **v2.0 `ACCEPTED`** — Option B: `E-14` → local enforcement-state projection in `BC-12`, consulted at send time |
| **Subject PRD** | [`PRD-020_TRUST_AND_SAFETY.md`](../../30-product/trust-safety/PRD-020_TRUST_AND_SAFETY.md) — **v0.1 header / v0.5 content, `DRAFT`, Stage 2, Unranked** |
| **PRD sha256 (unchanged by this record)** | `4c719dbf7904a07a8619ab6459f0f8e39dd79a4d603d153b44b3e536b3bbd90b` |
| **ADR-0065 sha256 (unchanged by this record)** | `10e23764473cb901efb40c9f6c22915e7cc30402e472c3d1613d0937eac7da36` |
| **Implementation** | `lib/domain/social/messaging/enforcement_projection.dart` — sha256 `bbea043ab0bbb174252cd460d5abf98c882cd76182b8fcc430b5d0f0c2062474` |
| **Tests** | `test/domain/social/messaging_enforcement_test.dart` — sha256 `fc7caebd6ab88ba8f34dd31d742530a85326f67c7c63b23d9d08a0cc7777534f`, **26 tests** |
| **Implementation commit** | `d45f2cc` — *"feat(IMPL-1410): fix syntax + finalise ADR-0065 Option B send-time enforcement gate"* |
| **Measured at** | HEAD `05e18ad` |
| **Date** | 2026-08-22 |
| ⛔ **What this record does NOT do** | It does **not** close `TSF-GAP-003`, does **not** mark `IMPL-1410` complete, does **not** edit any status cell, register, baseline or matrix, and does **not** create an ADR. **See §7.** Each of those is an act reserved to a named owner, and none of those owners has conferred authority for it |
| **Verdict** | ✅ **The five mandatory items of `ADR-0065` §7.1 are each present and measured. The suspensive closure condition of `ADR-0065` §6.0 is now EVALUABLE and, on the measurements below, SATISFIED — but recording that satisfaction is an amendment act belonging to the Architecture Owner, not to this record.** ⛔ **Five disclosed limits in §5.** |

---

## 0. Why this document exists at all, and why it is not an edit to `PRD-020`

`ADR-0065` **§6.0** conferred authority for **one act** — the Rank 4 interpretation that
permits Option B — and attached a **suspensive** condition to the closure of the gap:

> `TSF-GAP-003` / `IMPL-1410` be closed / unblocked **only if the measured implementation
> satisfies** `TSF-FR-030` / `031` / `INV-007`.

At `ADR-0065` v2.0 that condition was **not evaluable**: zero lines of implementation
existed, so §6.1 answered *"no"* for the implementation half rather than rounding up. The
condition is **now evaluable**. This record supplies the measurement the condition needs.

It stops there, deliberately, and the reason is a **precedent in this repository, not a
preference of mine**. `PRD_REGISTRY.md` records what happened the last time an
implementation half of a gap was closed by landing code — `FIL-GAP-012`, closed in
architecture by `ADR-0055` and in implementation by `ADR-0059`:

> **The implementation half being closed does NOT move this row's status** … and
> `FIL-GAP-012`'s register row inside the frozen PRD **still reads `OPEN`**, because editing
> it is an amendment act requiring amendment authority, **not a side effect of the code
> landing**.

`TSF-GAP-003` has exactly the same shape. Two further facts decide the question:

| Fact | Measured | Consequence |
|---|---|---|
| `ADR-0059` header **Deciders** | **Architecture Owner** | Closing an *implementation* half was itself a separate Architecture-Owner ADR, not an implementer's edit |
| `ADR-0065` **L424** | *"⛔ **No.** `ADR-0033` **L169**: 'a conferral for one act is not a standing licence.' It covers **this** decision only."* | The Task-I conferral is **spent**. It authorised the Rank 4 interpretation, not a later closure act |

So: measurement here, closure elsewhere, by the owner who owns it.

---

## 1. The five mandatory items of `ADR-0065` §7.1

`ADR-0065` §7.1 binds the implementation to five items and warns, of item 2:

> ⛔ *"Item 2 is the belt-and-braces brace. An implementation shipping items 1, 3, 4 and 5
> without item 2 has built the design BC Map L468 explicitly refuses, and does not satisfy
> this ADR."*

Each item is measured against the shipped code, with the site named so the measurement can
be repeated.

| # | Item | Site | Measured | Verdict |
|---|---|---|---|---|
| 1 | Read model in `BC-12` keyed by `PersonId`, fed **only** by `E-14` `safety.EnforcementActionTaken` | `enforcement_projection.dart` L78 `kEnforcementActionTaken`; single feed `apply(DomainEvent)`; keyed by `PersonId` | The **only** event type accepted is `safety.EnforcementActionTaken`; the **only** compile-time import is `liboora_contracts` (L73) | ✅ |
| 2 | ⭐ **Fail-closed staleness gate** — lag > `TSF-CFG-030` **or** freshness unestablishable ⇒ **REFUSED** | `evaluateSend` L287–L306 | The staleness arm is evaluated **before** the restriction lookup: L289 `projectionDegraded` → L294 `freshnessUnestablished` → L297 `projectionStale` → L300 `isMessagingRestricted` → L306 allowed | ✅ |
| 3 | Rebuild-from-events equivalence; never hand-edited | `rebuildFrom(Iterable<DomainEvent>)` | No public mutator other than `apply`/`rebuildFrom`/`noteStreamLive`; 6 rebuild-equivalence tests | ✅ |
| 4 | ⛔ **No** `BC-12` → `BC-13` call | boundary checker + code-only grep | `dart run tool/check_module_boundaries.dart` → **`social` = 0 violations**; code-only occurrences of `BC-13` = **0** and of `TenantId` = **0** (both appear only in `///` doc comments) | ✅ |
| 5 | Observability of projection lag | `projectionLag` L256; telemetry L304/L339/L343/L356/L361 | Lag exposed as `Duration?` — **`null` when freshness was never established**, which is the state item 2 must refuse rather than treat as zero; counters and structured logs on both allow and refuse paths | ✅ |

⚠ **A deliberate design point worth stating, because getting it wrong is the classic
fail-open defect.** `projectionLag` is nullable and boot does **not** declare freshness. An
implementation that initialised lag to `Duration.zero` at construction would report a
perfectly fresh projection before a single event had been observed, and item 2 would pass
its own test while protecting nothing. Freshness is established only by observing the
stream live (`noteStreamLive`) or by applying an event, so the gate **refuses by default**
and becomes permissive only on evidence.

---

## 2. The three requirements the closure condition names

`ADR-0065` §6.0 conditions closure on `TSF-FR-030`, `TSF-FR-031` and `TSF-INV-007`.

### 2.1 `TSF-FR-030` — local enforcement-state read model

| Clause | Measured | Verdict |
|---|---|---|
| Read model local to `BC-12`, keyed by `PersonId` | `MessagingEnforcementProjection`, keyed by `PersonId` | ✅ |
| Synchronous | `evaluateSend` returns `SendDecision` synchronously; no `Future` on the read path | ✅ |
| Fed **only** by `E-14` | Sole accepted `eventType` is `kEnforcementActionTaken` | ✅ |
| Recomputable from the event stream alone | `rebuildFrom` proven equivalent to incremental `apply` by test | ✅ |
| Never hand-edited | No setter, no injection of restriction state | ✅ |
| `BC-13` MUST NOT expose / `BC-12` MUST NOT call a sync cross-boundary enforcement query | 0 `social` boundary violations; code-only `BC-13` = 0 | ✅ |

### 2.2 `TSF-FR-031` — consult on **every** send, before acceptance, with a non-optional gate

> *"The gate is not optional."*

| Clause | Measured | Verdict |
|---|---|---|
| The gate exists and is not bypassable | The only send-decision entry points are `evaluateSend` and `ensureSendAllowed`, and **both** run the staleness arm first | ✅ |
| Refuse on lag > `TSF-CFG-030` | `SendRefusalReason.projectionStale`, boundary-inclusive, tested | ✅ |
| Refuse on unestablishable freshness | `SendRefusalReason.freshnessUnestablished`, tested | ✅ |
| ⚠ *"on **every** send"* | **ENFORCED BY API SHAPE ONLY.** No message-send call site exists in `lib/` — see §5 limit 1 | ⚠ **Partial** |

### 2.3 `TSF-INV-007` — restriction effective; residual window bounded and disclosed

| Clause | Measured | Verdict |
|---|---|---|
| Fails from the moment the restriction is in the read model | `FRESH` group, clause (a) of `TSF-AC-025` | ✅ |
| Fails whenever the model cannot be shown fresher than `TSF-CFG-030` | `STALE` + `UNESTABLISHABLE` groups, clause (b) | ✅ |
| Residual window **disclosed, bounded, monitored, never open-ended** | Bounded by `kEnforcementStalenessBudget` = **5 s**; hard ceiling `kEnforcementStalenessCeiling` = **30 s** rejected at construction (`DomainError(validationFailed)`), as is a zero or negative budget; monitored via `projectionLag` + telemetry | ✅ |

⚠ The ceiling is enforced **at construction time**, not merely documented. A caller cannot
configure a 5-minute budget: `MessagingEnforcementProjection(clock, telemetry,
stalenessBudget: Duration(minutes: 5))` **throws**. `TSF-CFG-030` is one of the nine
`TSF-BR-036` ADR-required rows, so an unbounded override would have quietly relocated an
ADR-gated decision into a constructor argument.

### 2.4 `TSF-FR-001` — p99 ≤ 50 ms, fail closed

⭐ **This was the one clause of `IMPL-1410`'s own approved scope that had never been
measured**, and `SID-4.56` is explicit: *"a rule that cannot be checked SHALL be treated as
unmet."* So measuring it was genuinely necessary remaining implementation work, not scope
expansion. Two tests were added:

| Test | Load | Measured | Verdict |
|---|---|---|---|
| Allow path | 10,000 `evaluateSend` calls against **1,000 active restrictions** | p99 asserted `< 50,000 µs` | ✅ |
| Refuse path | 2,000 `evaluateSend` calls on the restricted path | p99 asserted `< 50,000 µs` | ✅ |

Both tests carry a **vacuity guard** (`expect(activeRestrictionCount, 1000)` and
`expect(reason, SendRefusalReason.messagingRestricted)`) so that a fixture that silently
stopped exercising the intended path would fail rather than pass trivially fast.

⚠ **The refuse path is measured deliberately, and this is not padding.** A fail-closed gate
that is slow *when it refuses* invites an upstream timeout, and a timeout upstream of a
fail-closed check fails **open** — which is precisely the outcome item 2 exists to prevent.

⛔ **Disclosed limit on this measurement:** it is an in-process unit-test latency figure on
sandbox hardware against an in-memory map. It is **not** a production p99, it exercises no
I/O, and it does **not** discharge `T-5`. It establishes that the algorithm is O(1) on the
read path and carries no accidental scan; it does not establish a service-level objective.

---

## 3. `TSF-AC-025` — both clauses

`TSF-AC-025` has two clauses and `PRD-020` states that *"Clause (b) is the assertion a
projection-only build cannot pass."* `TSF-FR-141` forbids recording `T-5` as passing unless
clause (b) passes.

| Clause | Requirement | Measured |
|---|---|---|
| **(a)** | Fresh projection carrying a restriction ⇒ the send fails | ✅ `FRESH` group, 4 tests |
| **(b)** | Withheld `E-14` past `TSF-CFG-030`, **or** unestablishable freshness ⇒ **any** send `REFUSED` | ✅ `STALE` group (4 tests, including the inclusive boundary and recovery) + `UNESTABLISHABLE` group (2 tests) |

Test-group inventory of `messaging_enforcement_test.dart` (26 tests, all passing):

| Group | Tests | Proves |
|---|---|---|
| `FRESH` | 4 | `TSF-AC-025` (a) |
| `STALE` | 4 | `TSF-AC-025` (b), staleness arm |
| `UNESTABLISHABLE` | 2 | `TSF-AC-025` (b), null-lag arm |
| `FAIL-CLOSED` | 5 | Degradation latch, ceiling/zero-budget rejection, error retriability |
| item 3 rebuild | 6 | Rebuild ≡ incremental apply; last-write-wins by `occurredAt` |
| item 4 / item 5 | 2 | No forbidden edge; lag observability |
| rule `ID-2` | 1 | `TenantId` never read by the projection |
| `TSF-FR-001` latency | 2 | §2.4 |

---

## 4. A defect these tests found, in the tests themselves

Recorded because a suite that was green on the first attempt tells a reader less than one
that caught something.

The first version of the latency fixture built a `permanentTermination` with `until: null`
and asserted the send would be refused. It **failed**: `Expected: true Actual: <false>`.

The implementation was right and the fixture was wrong. `TSF-FR-124` makes a past-dated or
**nulled** `until` on the same event the **reversal** signal, and `TSF-FR-070` forbids
open-ended suspension — so `enforcement_projection.dart` L193
`isActiveAt(now) => until != null && until!.isAfter(now)` correctly treats a null `until`
as *not restricting*. A fixture asserting otherwise was asserting that a reversal restricts.

**Resolution: the test fixture was corrected** (a dated `until`, plus an inline comment
recording why `null` is wrong here). ⛔ **The implementation was not touched**, because
changing it to satisfy the fixture would have silently repealed `TSF-FR-124`.

---

## 5. ⛔ Disclosed limits — what is *not* established

| # | Limit | Why it matters |
|---|---|---|
| 1 | ⚠⚠ **No message-send call site exists in `lib/`.** `TSF-FR-031`'s *"on every send"* is enforced by **API shape only** — the gate cannot be bypassed by any *existing* caller because there are none | The projection is a correct, tested, unbypassable gate that **nothing currently calls**. Writing a send path would expand V1 scope and would author into `BC-12`, whose owning PRD is `PRD-021` (**`PLANNED`**) |
| 2 | `T-5` (*"Integration + fault injection"*) is **NOT discharged** | `T-5` requires a send path. Per `TSF-FR-141`, `T-5` must not be recorded as passing until clause (b) passes *in integration* — these are unit tests |
| 3 | **~126 of ~128 `TSF-AC-*`** remain unasserted | Only `TSF-AC-025` (a) and (b) are proven. This is one requirement of a 30-section PRD |
| 4 | `MP-RSK-02`, `TSF-RSK-002` and `D-16` are **NOT retired** | A Critical risk retires on a working end-to-end mitigation, not on a projection with no caller |
| 5 | `PRD-020` is at **Stage 2 of 9** | The code landed **ahead of** Stages 3–7. See §6 |

---

## 6. Where `PRD-020` actually is in its lifecycle, measured

`PRD_LIFECYCLE.md` §2 defines **nine** stages, each with a named exit-gate artefact. Every
cell below is measured at HEAD `05e18ad`, not inferred.

| Stage | Exit gate | Owner (§6) | Measured state |
|---|---|---|---|
| 1–2 | Discovery / drafting | Product owner | ✅ Content drafted to v0.5, 30 sections |
| 3 Architecture Review | Boundary / edge / rank validated against the BC Map | Architecture reviewer | ⛔ **Not started** — no gate artefact exists |
| 4 Requirements Review | Every requirement uniquely identified, testable, **non-duplicating** | Requirements reviewer | ⛔ **Not started.** **6 duplicate definition rows** measured: `TSF-FR-001`, `TSF-FR-083`, `TSF-XC-016`, `TSF-CFG-002`, `TSF-CFG-003`, `TSF-CFG-004` |
| 5 Traceability | `TSF-` prefix registered in `TRACEABILITY_MATRIX.md`, zero collisions | **Traceability owner** | ⛔ **Not started** — `grep -c 'TSF-' TRACEABILITY_MATRIX.md` = **0** |
| 6 Implementation Tasks | `IMPL-*` range allocated in a task document | Implementation lead | 🟡 `IMPL-1400`…`1449` declared **inside** `PRD-020`; no `PRD-020_IMPLEMENTATION_TASKS.md` exists |
| 7 **Freeze** | Row in `DOCUMENTATION_BASELINE.md` §3 | **Governance owner** | ⛔ **Not started** — `grep -c 'PRD-020' DOCUMENTATION_BASELINE.md` = **0** |
| 8 Implementation | All tasks closed | Implementation lead | 🟡 `IMPL-1410` built and passing (**this record**); other `IMPL-14xx` untouched |
| 9 Verification | Every AC proven | — | ⛔ ~2 of ~128 `TSF-AC-*` asserted |

⭐ **The consequence, stated plainly because it inverts the intuitive reading.** `IMPL-1410`
is Stage 8 work that landed while the document sits at Stage 2. **Landing code therefore
cannot advance the document's lifecycle status.** Stages 3, 4, 5 and 7 are gates owned by
four *different* owners, and `PRD_LIFECYCLE.md` §7 forecloses the shortcut:

> | Urgent business need | **No fast path.** Stage 7 is not skippable |

In particular a Stage 5 traceability entry **cannot lawfully precede** Stages 3 and 4 — so
registering `TSF-` in the matrix now is blocked by **sequence**, not by unwillingness.

Consistently, `PRD_REGISTRY.md` L320 still reads `PLANNED` and this record leaves it alone.

---

## 7. What this record deliberately does NOT do, and who owns each

| # | Act not performed | Class | Owner | Why not performed here |
|---|---|---|---|---|
| 1 | Close the implementation half of `TSF-GAP-003`; mark `IMPL-1410` complete | **governance** | **Architecture Owner** | The [`ADR-0055`](../../00-governance/adr/ADR-0055-e22-consumer-list-includes-bc-12.md) → [`ADR-0059`](../../00-governance/adr/ADR-0059-e22-consumer-list-enforced-in-code.md) precedent made closing an implementation half a **separate Architecture-Owner ADR**. The `ADR-0065` conferral is spent (`ADR-0033` L169, quoted three times inside `ADR-0065` itself) |
| 2 | Edit `PRD-020` §24.2 / §28 / §30.2 status cells | **documentation / governance** | **Product Owner** + amendment authority | `PRD_REGISTRY.md` L317: closing an implementation half *"does NOT move this row's status"*; editing is *"an amendment act … not a side effect of the code landing"* |
| 3 | Perform Stage 3 Architecture Review | **governance** | Architecture reviewer | Would be performing a review nobody ran |
| 4 | Repair the **6 duplicate definition rows** | **documentation** | Requirements reviewer | Same reason as 3. Repairing silently would consume a Stage 4 finding before Stage 4 exists |
| 5 | Register `TSF-` in `TRACEABILITY_MATRIX.md` | **documentation** | **Traceability owner** | Cannot lawfully precede Stages 3–4 |
| 6 | Add a `DOCUMENTATION_BASELINE.md` row / freeze / rank | **governance** | **Governance owner** | *"No fast path. Stage 7 is not skippable"* |
| 7 | Create an ADR | **governance** | **Architecture Owner** | ⚠ **And the number matters.** `ADR-0066`…`ADR-0073` are **all earmarked** by `PRD-020` §29.2 (with `ADR-0069` marked **DO NOT OPEN**), and `PRD_LIFECYCLE.md` §5 rule 5 states numbers *"are never reused, even after withdrawal."* Measured: `ADR-0074` has **0** references and is the only lawful next number |
| 8 | Write a message-send path | **product-scope** | `PRD-021` owner / Product Owner | Would expand V1 scope and author into `BC-12`, owned by `PRD-021` (`PLANNED`) |
| 9 | Produce a delivery ZIP | **process** | — | Measured: **all 8** entries in `delivery/` correspond to **`FROZEN`** PRDs. `PRD-020` is `DRAFT`/Stage 2, so the repository workflow does not call for a package |
| 10 | Touch `PRD_REGISTRY.md`, `DOCUMENTATION_BASELINE.md`, `TRACEABILITY_MATRIX.md`, `ADR-INDEX.md`, the BC Map, the Module Dependency Matrix or `module_dependencies.yaml` | **governance** | Respective owners | Verified byte-unchanged: `git diff --stat d45f2cc -- docs/ tool/` is **empty** |

---

## 8. Validation performed

All measured at HEAD `05e18ad` with the evidence record present.

| Check | Command | Result |
|---|---|---|
| Static analysis | `flutter analyze lib/ test/ packages/` | ✅ `No issues found!` |
| Full suite | `flutter test` | ✅ **`+313: All tests passed!`** |
| This feature | `flutter test test/domain/social/messaging_enforcement_test.dart` | ✅ **`+26: All tests passed!`** |
| Architecture suite | `flutter test test/architecture/` | ✅ `+230: All tests passed!` |
| Module boundaries | `dart run tool/check_module_boundaries.dart` | ✅ Exact baseline — `9 violation(s) in 1 category`, **`social` = 0** (the 9 are the pre-existing `app → domain/library` set, dated `ADR-0012` debt) |
| Web build | `flutter build web --release` | ✅ `✓ Built build/web` |
| Documentation checks | `tool/docs_check/*.py` | ✅ `TOTAL_NONZERO=5` — the five known baseline failures, unchanged |
| Rank 1–5 integrity | `git diff --stat d45f2cc -- docs/ tool/` before this record | ✅ Empty — 0 lines |
| Formatting | `dart format` on the four touched files | ✅ 0 changed |

---

## 9. References

- [`ADR-0065`](../../00-governance/adr/ADR-0065-synchronous-enforcement-check-transport.md) — §6.0 conferral and its limits, §6.1 closure condition, §7.1 the five mandatory items
- [`ADR-0055`](../../00-governance/adr/ADR-0055-e22-consumer-list-includes-bc-12.md) — closed the **architecture** half of `FIL-GAP-012`
- [`ADR-0059`](../../00-governance/adr/ADR-0059-e22-consumer-list-enforced-in-code.md) — closed the **implementation** half; the two-half precedent; Deciders: **Architecture Owner**
- [`ADR-0033`](../../00-governance/adr/ADR-0033-e27-core-cluster-edge-allowlist.md) — L169 *"a conferral for one act is not a standing licence"*
- [`PRD-020_TRUST_AND_SAFETY.md`](../../30-product/trust-safety/PRD-020_TRUST_AND_SAFETY.md) — `TSF-FR-001`, `TSF-FR-030`, `TSF-FR-031`, `TSF-FR-124`, `TSF-FR-141`, `TSF-INV-007`, `TSF-CFG-030`, `TSF-AC-025`, `T-5`, §15.1, §29.2
- [`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md) — §2 nine stages, §5 identifier rules, §6 roles, §7 no fast path
- [`PRD_REGISTRY.md`](../../00-governance/prd-ecosystem/PRD_REGISTRY.md) — §2 status vocabulary, L317 the `FIL-GAP-012` precedent, L320 `PRD-020` = `PLANNED`
- [`PRD_OWNERSHIP_MODEL.md`](../../00-governance/prd-ecosystem/PRD_OWNERSHIP_MODEL.md) — §2.2 the four roles
- [`DEFINITION_OF_DONE.md`](../DEFINITION_OF_DONE.md) — Gate 1 Merge, Gate 2 Requirement complete, Gate 3 Release

---

## 10. Change history

| Version | Date | Change |
|---|---|---|
| 1.0 | 2026-08-22 | Created. Measures `IMPL-1410` against the five mandatory items of `ADR-0065` §7.1, the three requirements named by the §6.0 closure condition, `TSF-FR-001` (measured for the first time) and both clauses of `TSF-AC-025`. Records five disclosed limits, the measured Stage 2-of-9 lifecycle position, and ten reserved acts with their owners. **Confers nothing; closes nothing; amends nothing.** |
