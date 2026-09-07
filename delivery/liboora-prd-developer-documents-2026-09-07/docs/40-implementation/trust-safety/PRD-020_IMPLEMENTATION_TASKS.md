# `PRD-020` Implementation Tasks — `IMPL-1400` … `IMPL-1449`

| Field | Value |
|---|---|
| **Module** | `domain/social` (Trust & Safety) — Bounded Context **`BC-13`** Trust & Safety, ⚠ marked **`[CORE]`** in `PRD_OWNERSHIP_MODEL.md` **L202** |
| **Aggregates** | `ModerationCase`, `AbuseReport`, `Evidence`, `EnforcementAction`, `StrikeRecord`, `SafetyPolicy`, `RiskAssessment`, `EffectiveRestriction` — as specified by the source PRD; **this document creates none of them** |
| **Source PRD** | [`../../30-product/trust-safety/PRD-020_TRUST_AND_SAFETY.md`](../../30-product/trust-safety/PRD-020_TRUST_AND_SAFETY.md) — v0.5 content under a v0.1 header, `DRAFT`, **Unranked** |
| **PRD hash** | `685fb65af95668df9bce8757bcd7d04ec9838a56f8dd108652e80d7e7579497b` — **unchanged** by this document |
| **Range allocated** | **`IMPL-1400` … `IMPL-1449`** — 50 tasks · `IMPL-1450`…`1499` is the source PRD's declared **V2 reserve**, not this document's growth reserve. ⚠ See §3.4 — **this module has no growth reserve, and that is a disclosed defect, not an oversight** |
| **Obligations claimed** | **75 of 400** identifiers cited by task rows; **28 of 187** normative requirements (`TSF-FR-*`/`TSF-BR-*`) = **15.0%**. ⛔ **Computed** by [`prd020_task_coverage.py`](../../../tool/docs_check/prd020_task_coverage.py), not asserted. See §5 — this is **the lowest task-level requirement coverage in the repository** and it is published at that figure |
| **Acceptance criteria named by a task** | **32 of 62.** The other 30 are reached only through `IMPL-1449`'s sweep |
| **Acceptance criteria proven** | ⛔ **0 of 62.** `IMPL-1410` is built and tested but discharges no criterion by name; see §6 |
| **Stage** | 6 of 9. **Stage 7 is not entered. Stage 8 is not started.** |
| **Status of this document** | **Unranked.** Not admitted to `DOCUMENTATION_BASELINE.md` |
| **Version** | v1.0 · 2026-08-23 |

---

## 1. The one thing this document is not

**It is not an implementation, and it is not a design.** It allocates numbers and
states what each numbered unit of work must satisfy. It contains **no** schema,
SQL, DDL, migration, storage-engine choice, index definition, estimate or sprint
assignment.

⛔ **It also does not close anything.** In particular it does **not** close the
implementation half of `TSF-GAP-003`, does not move `PRD-020` out of `PLANNED`,
and does not confer `READY`. §7 states each refusal with the owner who could
lawfully perform it.

---

## 2. Stage 6 prerequisites — verified, not assumed

| Prerequisite | Required by | State |
|---|---|---|
| Stage 2 draft exists, versioned header, registers declared up front | `PRD_LIFECYCLE.md` L79–86 | ✅ **9 registers**, ranges published in §0.2 at **L30–54**. ⚠ Header reads v0.1 while content is v0.5 — **disclosed, not corrected**; amending it is a document-owner act |
| Stage 3 Architecture alignment recorded | `PRD_LIFECYCLE.md` L90–106 | ✅ [`../../30-product/trust-safety/PRD-020_STAGE3_ARCHITECTURE_ALIGNMENT.md`](../../30-product/trust-safety/PRD-020_STAGE3_ARCHITECTURE_ALIGNMENT.md) — **PASS 6/6** |
| Stage 4 conflicts closed or deferred with reason **and** owner | `PRD_LIFECYCLE.md` L108–120 | ✅ [`../../30-product/trust-safety/PRD-020_STAGE4_REQUIREMENTS_REVIEW.md`](../../30-product/trust-safety/PRD-020_STAGE4_REQUIREMENTS_REVIEW.md) v1.2 — **PASS 6/6**; `RQ-1` closed, one finding **retracted** as false |
| Stage 5 prefixes registered, counts and ranges verified mechanically, zero collisions | `PRD_LIFECYCLE.md` L122–137 | ✅ [`../TRACEABILITY_MATRIX.md`](../TRACEABILITY_MATRIX.md) **v1.20 §2O** · conferred by [`../../30-product/trust-safety/PRD-020_STAGE5_CONFERRAL.md`](../../30-product/trust-safety/PRD-020_STAGE5_CONFERRAL.md) · two committed instruments, both exit 0, **mutation-tested 7/7** · inventory **400 across 9 registers** |

Stage 6 is therefore genuinely reachable. **Registered is not verified**, and the
Stage 5 conferral's §8 says so explicitly: *"What this does not confer: not Stage
6, not rank, not freeze, not `READY`, not verification, and not coverage."*

---

## 3. `IMPL-*` allocation

### 3.1 Why this range — computed, not chosen

Allocation rule 1: *"Take the next free range. **Never reuse or reassign a
number**."* Rule 2: *"Leave the previous group room to grow contiguously."*

`IMPL-1400` is the next free number, established by **three** independent routes:

1. **Declared upstream.** [`../security/PRD-012a_IMPLEMENTATION_TASKS.md`](../security/PRD-012a_IMPLEMENTATION_TASKS.md) **L140** reads `| IMPL-1400 + | Unallocated | — |`.
2. **Declared by the subject.** `PRD-020` **L14** and **L2433** both allocate `IMPL-1400`…`1449`.
3. **Measured.** `grep -rhoE 'IMPL-1[0-9]{3}' docs/ lib/ tool/ test/ | sort -u` returns **51** distinct tokens in the `14xx` band — the 50 allocated plus the `IMPL-1450` boundary label — and **zero** tokens at `IMPL-15xx` or above anywhere in the repository. **Only `PRD-020` and its own review artefacts cite `IMPL-14xx`.**

⚠ **Explicitly NOT taken from `PRD_LIFECYCLE.md` L147–153**, whose
`IMPL-014`…`IMPL-227+` table is **stale**. That staleness is disclosed in §3.3
and **not repaired here** — amending a Rank-2 governance document is not a Stage
6 act (`DOCUMENTATION_BASELINE.md` §7 rule 1).

### 3.2 The allocation table

| Range | Owner | Document |
|---|---|---|
| `IMPL-1100` … `IMPL-1129` | Configuration (`PRD-023`, `BC-25`) | [`../configuration/PRD-023_IMPLEMENTATION_TASKS.md`](../configuration/PRD-023_IMPLEMENTATION_TASKS.md) |
| `IMPL-1130` … `IMPL-1199` | Reserved — `PRD-023` growth. **Not touched here** | — |
| `IMPL-1200` … `IMPL-13xx` | File & Media / Security (`PRD-017`, `PRD-012a`) | those modules' task documents |
| **`IMPL-1400` … `IMPL-1409`** | **Wave 1 — Foundation: aggregate, state machine, intake, evidence, policy, enforcement, strikes, projection, events** | This document, §4.1 |
| **`IMPL-1410` … `IMPL-1412`** | **Wave 2 — Containment and the withdrawn band.** ⚠ 1 buildable, 2 **withdrawn from V1** | This document, §4.2 |
| **`IMPL-1413` … `IMPL-1427`** | **Wave 3 — Risk engine, appeals, privacy.** ⚠ includes 4 withdrawn | This document, §4.3 |
| **`IMPL-1428` … `IMPL-1441`** | **Wave 4 — Console, isolation, observability** | This document, §4.4 |
| **`IMPL-1442` … `IMPL-1449`** | **Wave 5 — Test build-out `T-1`…`T-14` and the traceability sweep** | This document, §4.5 |
| `IMPL-1450` … `IMPL-1499` | ⚠ **Reserved by `PRD-020` §30 for the V2 community work of §25** — *not* a V1 growth reserve. See §3.4 | The source PRD, unallocated |
| `IMPL-1500` + | Unallocated — **measured empty** | — |

**50 tasks, `IMPL-1400` … `IMPL-1449`, contiguous, no gaps inside the allocated
span.** Verified mechanically: all 50 tokens carry a row in `PRD-020` §30.

### 3.3 Two known stalenesses, disclosed rather than corrected

| Staleness | Why it is not fixed here |
|---|---|
| `PRD_LIFECYCLE.md` L147–153's `IMPL-*` table stops at `IMPL-227+` | Rank-2 governance document. Baseline §7 rule 1: *"A change to any Rank 1–5 document requires an ADR **before** the change."* Not a Stage 6 act. `PRD-014`, `PRD-017` and `PRD-012a` each recorded the same staleness and each declined to repair it |
| `PRD_OWNERSHIP_MODEL.md` **L202** does not register the `TSF-` prefix or the `IMPL-1400`…`1449` range | `PRD-020` §30.6 row 2 already names this as a **Governance Owner** act under `TSF-GAP-013`. Editing L202 here would be performing another owner's act |

### 3.4 ⚠ This module has **no growth reserve**, and that is a defect this document discloses rather than cures

Allocation rule 2 requires that the previous group be left *"room to grow
contiguously."* `PRD-020` honoured that for its **successor** — `IMPL-1450`…`1499`
is reserved for V2 — but it left **no reserve for itself**: all 50 numbers in
`1400`…`1449` are assigned, and the very next number is spoken for.

**Sixteen `TSF-GAP-*` are open.** Several could generate tasks once their owners
decide — `TSF-GAP-014` (age-band accessor), `TSF-GAP-009` (referral transport),
`TSF-GAP-005` (reported-file review) among them. When they do, there is **no
contiguous number available**.

⛔ **This document does not fix that**, because both available fixes are
unlawful here:

| Candidate fix | Why refused |
|---|---|
| Re-purpose part of `IMPL-1450`…`1499` as a V1 reserve | The source PRD reserved it for V2 at **L2434**. Re-purposing another document's declared reserve is an act for that document's owner |
| Allocate `IMPL-1500`…`1549` as a `PRD-020` growth reserve | Measured free, but claiming a second range for a module that already holds one is an **allocation act** and would pre-empt the next module to reach Stage 6 |

**Routed to the Governance Owner** alongside `TSF-GAP-013`. Recorded here so that
the first person who needs `IMPL-1450` finds the reasoning rather than the
surprise. ⚠ Note that **`IMPL-1412` is withdrawn from V1 but its number is
permanently spent** — rule 1 forbids reassignment, so the shortfall cannot be
recovered by recycling withdrawn numbers, and this document does not attempt it.

---

## 4. The tasks

Every row states `Priority`, `Blocks` and `Blocked by`, as `PRD_LIFECYCLE.md`
L139–153 rule 3 requires. `Verifies` is copied **verbatim** from `PRD-020` §30 —
this document adds no citation the source PRD did not already make.

Priority scale: **P0** foundation, nothing works without it · **P1** required for
V1 · **P2** required for V1 but not on the critical path · **⚪ W** withdrawn from
V1 scope.

### 4.1 Wave 1 — Foundation (`IMPL-1400`…`1409`), all buildable today

| Task | Work | Verifies | Pri | Blocks | Blocked by |
|---|---|---|---|---|---|
| `IMPL-1400` | `ModerationCase` aggregate + `CaseTransition`, one transaction | `TSF-INV-012`, `TSF-AC-021` | **P0** | 1401, 1402, 1403, 1406 | — |
| `IMPL-1401` | The 7-state machine with rejection of every illegal pair | `TSF-FR-138`, `TSF-AC-011`/`012`/`013` | **P0** | 1404, 1429, 1434 | 1400 |
| `IMPL-1402` | `AbuseReport` intake, idempotent, uniform responses | `TSF-AC-006`, `TSF-FR-126` | **P0** | 1404, 1436 | 1400 |
| `IMPL-1403` | `Evidence` append-only + provenance | `TSF-INV-010`, `TSF-AC-002` | **P0** | 1431, 1425 | 1400 |
| `IMPL-1404` | Severity table + dedup + routing + escalation queue | `TSF-AC-007`/`008`/`014` | **P1** | 1428 | 1401, 1402 |
| `IMPL-1405` | `SafetyPolicy` versioning; citation required on action | `TSF-FR-111`, `TSF-AC-020` | **P0** | 1406 | — |
| `IMPL-1406` | `EnforcementAction` with scope/expiry validation; two-actor gate on row 9 | `TSF-FR-069`/`070`, `TSF-AC-022`/`023` | **P0** | 1407, 1408, 1409, 1420 | 1400, 1405 |
| `IMPL-1407` | `StrikeRecord` + decay + upheld-only rule | `TSF-AC-030`/`031`/`032` | **P1** | 1423 | 1406 |
| `IMPL-1408` | `EffectiveRestriction` single-row projection, rebuildable | `TSF-FR-120`, `TSF-AC-029` | **P0** | 1410, 1422 | 1406 |
| `IMPL-1409` | The two events through the transactional outbox, idempotent | `TSF-EVT-001`/`002`, `TSF-AC-028` | **P0** | 1410, 1422 | 1406 |

### 4.2 Wave 2 — Containment (`IMPL-1410`…`1412`)

| Task | Work | Verifies | Pri | Blocks | Blocked by |
|---|---|---|---|---|---|
| `IMPL-1410` | **Synchronous send-time check**, fail-closed, p99 ≤ 50 ms, incl. the **fail-closed staleness gate** bounded by `TSF-CFG-030` | `TSF-GAP-003` *(impl. half)*; all five items of `ADR-0065` **§7.1**; verified by **T-5** incl. `TSF-AC-025` clause **(b)** | **P0** | 1443, and **`READY` itself** (`TSF-BR-033`) | ⚠ **Unblocked** — `ADR-0065` is `Accepted`. **Not complete.** See §6 |
| `IMPL-1411` | Graph/messaging risk signals | *(withdrawn)* | ⚪ **W** | — | ⚪ Withdrawn — §14.3.2. `TSF-GAP-015`. `ADR-0066` **not opened** |
| `IMPL-1412` | `Friction` band rate-limit recommendation | *(withdrawn)* | ⚪ **W** | — | ⚪ Withdrawn — §14.4. `TSF-GAP-012`. `ADR-0067` **not opened**. ⛔ **Number permanently spent; never reassign** |

⛔ **`TSF-BR-041` compliance.** The source PRD's v0.2 listed **seven** blocked
tasks when the true count was **one**; v0.3 and v0.5 corrected it. This table
carries **zero ⛔ blocked tasks** and **six ⚪ withdrawn** ones across all waves,
so that *"the count of blocked tasks equals the number of decisions the release
is actually waiting on."* That count is now **0** — `IMPL-1410` waits on
**construction**, not on a decision.

### 4.3 Wave 3 — Risk engine, appeals, privacy (`IMPL-1413`…`1427`)

| Task | Work | Verifies | Pri | Blocks | Blocked by |
|---|---|---|---|---|---|
| `IMPL-1413` | Own-case signals (velocity, repeat enforcement, coordination) | `TSF-AC-051` | **P2** | 1414 | — |
| `IMPL-1414` | `RiskAssessment` with pinned rule version, replayable | `TSF-FR-059`, `TSF-AC-052` | **P2** | 1416, 1430 | 1413 |
| `IMPL-1415` | **Circuit breaker** — hourly cap, stop and page; auto-expiry on silence | `TSF-FR-061`/`062`, `TSF-AC-040` | **P1** | 1438 | 1406 |
| `IMPL-1416` | FP-rate computation + auto-demotion | `TSF-FR-064`/`065`, `TSF-AC-055` | **P2** | — | 1414 |
| `IMPL-1417` | Minor-safety severity floor from an age band | *(withdrawn)* | ⚪ **W** | — | ⚪ Withdrawn — §24.3. `TSF-GAP-014`. `ADR-0068` **not opened** |
| `IMPL-1418` | Reported-file review path | *(withdrawn)* | ⚪ **W** | — | ⚪ **Already decided against** by `ADR-0055`/`ADR-0059` — §29.1. `TSF-GAP-005`. `ADR-0069` **withdrawn** |
| `IMPL-1419` | Appeal intake **reachable while suspended** | `TSF-FR-078`, `TSF-AC-043` | **P1** | 1420 | — |
| `IMPL-1420` | Independent-decider enforcement incl. approval chain; queue-on-timeout | `TSF-INV-013`/`016`, `TSF-AC-041`/`042`/`044` | **P1** | 1422, 1423 | 1406, 1419 |
| `IMPL-1421` | Verified library-affiliation enforcement | *(withdrawn)* | ⚪ **W** | — | ⚪ Withdrawn — no attestation needed for V1. `TSF-GAP-008`. `ADR-0073` **not opened** |
| `IMPL-1422` | Reversal propagation + content restore | `TSF-FR-082`/`083`, `TSF-AC-046`/`050` | **P1** | — | 1408, 1409, 1420 |
| `IMPL-1423` | Strike removal on overturn, no residual mark | `TSF-FR-073`, `TSF-AC-047` | **P1** | — | 1407, 1420 |
| `IMPL-1424` | `BC-13` → `BC-19` referral transport | *(withdrawn)* | ⚪ **W** | — | ⚪ Withdrawn — V1 moderates Global Student surfaces only. `TSF-GAP-009` |
| `IMPL-1425` | Retention clocks + automatic purge + legal hold | `TSF-FR-087`/`088` | **P2** | — | 1403 |
| `IMPL-1426` | `PersonAnonymised` handling; block escape-by-deletion | `TSF-FR-089`/`091`, `TSF-AC-062` | **P1** | — | 1400 |
| `IMPL-1427` | Guardian disclosure limited to `guardianOf` scope | `TSF-FR-095` | **P2** | — | — |

### 4.4 Wave 4 — Console, isolation, observability (`IMPL-1428`…`1441`)

| Task | Work | Verifies | Pri | Blocks | Blocked by |
|---|---|---|---|---|---|
| `IMPL-1428` | Queue: severity-then-age, no count sort, 10,000-case performance | `TSF-FR-105`/`106`, `TSF-AC-019` | **P1** | 1429 | 1404 |
| `IMPL-1429` | Claim / reassign / SLA display, breach not clearable | `TSF-FR-107`/`108`, `TSF-AC-016`/`017` | **P1** | 1432 | 1401, 1428 |
| `IMPL-1430` | Case view with **advisory-labelled** risk + recommendation | `TSF-FR-110`, `TSF-AC-053` | **P2** | — | 1414 |
| `IMPL-1431` | Audited evidence reads; **case-bound access; no free-text search** | `TSF-FR-114`/`115`/`116`, `TSF-AC-061` | **P1** | — | 1403, 1440 |
| `IMPL-1432` | Recusal enforcement | `TSF-INV-019`, `TSF-AC-024` | **P1** | — | 1429 |
| `IMPL-1433` | Separate console surface, platform-role auth only | `TSF-XC-052`, `TSF-AC-058` | **P0** | 1428, 1436 | — |
| `IMPL-1434` | `UNRESOLVABLE_PENDING_ACCESS` closure + counter | `TSF-FR-129`, `TSF-AC-060` | **P2** | — | 1401 |
| `IMPL-1435` | **CI check: no `tenantId` / `StudentRecordId` anywhere in `BC-13`** | `TSF-INV-017`/`020`, `TSF-FR-140`, `TSF-AC-057` | **P0** | — | — |
| `IMPL-1436` | Denial ≡ not-found across all endpoints, **incl. timing** | `TSF-FR-126`/`139`, `TSF-AC-010`/`058` | **P0** | — | 1402, 1433 |
| `IMPL-1437` | Aggregate-only metrics with cell suppression; **no tenant dimension** | `TSF-FR-133`/`134`, `TSF-AC-059` | **P1** | — | 1435 |
| `IMPL-1438` | Alerting: fail-open, SLA breach, cap breach, moderator read volume | `TSF-FR-130`, `TSF-FR-118` | **P2** | — | 1415, 1429 |
| `IMPL-1439` | Config accessors via `E-19` for all 21 `TSF-CFG-*` | `TSF-FR-063` | **P1** | — | — |
| `IMPL-1440` | Audit emission via `E-20` on every decision and config change | `TSF-FR-136`/`137` | **P1** | 1431 | — |
| `IMPL-1441` | Notification facts via `E-23`; unsubscribe cannot suppress a notice | `TSF-BR-030`, `TSF-AC-037` | **P1** | — | 1406 |

⚠ **`IMPL-1439` reads *"all 21 `TSF-CFG-*`"* while the register holds 30.** This
document copies the source verbatim rather than "correcting" it, because the
discrepancy may be deliberate (nine configurables may be owned elsewhere) and
resolving it is the **document owner's** act. Recorded as `D-020-01` in §8.

### 4.5 Wave 5 — Test build-out (`IMPL-1442`…`1449`)

⚠ **`PRD-020` §30.5 gives these eight rows `T-n` test classes and no `TSF-*`
identifier.** Stage 6's gate is *"every task traces back to requirements"*, so the
`Traces via` column below carries the acceptance criteria that **§5.2 derives from
each test class's own stated subject matter** — a labelled reconstruction, **not**
an invented citation. The distinction matters: §5.2 shows its working.

| Task | Work | Traces via | Pri | Blocks | Blocked by |
|---|---|---|---|---|---|
| `IMPL-1442` | T-1, T-2 (exhaustive), T-3 | §5.2 → `TSF-AC-001`…`006`, `011`…`013`, `020`/`021` | **P0** | — | 1400, 1401, 1402 |
| `IMPL-1443` | T-4, **T-5 as a loud blocked failure** (`TSF-FR-141`) | §5.2 → `TSF-AC-025`/`026`/`027`/`028` | **P0** | **`READY`** | 1409, **1410** |
| `IMPL-1444` | T-6, T-7 | §5.2 → `TSF-AC-030`…`032`, `041`/`042`/`044` | **P1** | — | 1407, 1420 |
| `IMPL-1445` | T-8, T-9 | §5.2 → `TSF-AC-051`/`052`, `040` | **P2** | — | 1414, 1415 |
| `IMPL-1446` | T-10, T-11 | §5.2 → `TSF-AC-057`/`058`/`059` | **P0** | — | 1433, 1435 |
| `IMPL-1447` | T-12, T-13 | §5.2 → `TSF-AC-010`, `038`, `061`, `062` | **P1** | — | 1425, 1436 |
| `IMPL-1448` | T-14 | §5.2 → `TSF-AC-024`, `061` | **P1** | — | 1431, 1432 |
| `IMPL-1449` | Full `TSF-AC-001`…`062` traceability sweep | **All 62** `TSF-AC-*`; the 111 uncovered obligations of §2O.2 | **P0** | **`READY`** | all of the above |

---

## 5. Traceability — task groups → requirements → invariants → acceptance

Rule 4 of `PRD_LIFECYCLE.md` L139–153.

### 5.1 By wave

| Wave | Tasks | Requirements (`FR`/`BR`) | Invariants (`INV`) | Acceptance (`AC`) | Events / Config |
|---|---|---|---|---|---|
| **1 Foundation** | `1400`–`1409` | `FR-138`, `FR-126`, `FR-111`, `FR-069`, `FR-070`, `FR-120` | `INV-010`, `INV-012` | `AC-002`, `006`, `007`, `008`, `011`, `012`, `013`, `014`, `020`, `021`, `022`, `023`, `028`, `029`, `030`, `031`, `032` | `EVT-001`, `EVT-002` |
| **2 Containment** | `1410`–`1412` | `ADR-0065` §7.1 (5 items) | — | `AC-025` **(a)+(b)** | `CFG-030` |
| **3 Risk / appeals / privacy** | `1413`–`1427` | `FR-059`, `061`, `062`, `064`, `065`, `073`, `078`, `082`, `083`, `087`, `088`, `089`, `091`, `095` | `INV-013`, `INV-016` | `AC-040`, `041`, `042`, `043`, `044`, `046`, `047`, `050`, `051`, `052`, `055`, `062` | — |
| **4 Console / isolation** | `1428`–`1441` | `FR-063`, `105`, `106`, `107`, `108`, `110`, `114`, `115`, `116`, `118`, `126`, `129`, `130`, `133`, `134`, `136`, `137`, `139`, `140`; `BR-030` | `INV-017`, `INV-019`, `INV-020` | `AC-010`, `016`, `017`, `019`, `024`, `037`, `053`, `057`, `058`, `059`, `060`, `061` | `XC-052` |
| **5 Tests** | `1442`–`1449` | `FR-141` | — | **all 62**, via §5.2 and `IMPL-1449` | — |

### 5.2 The `T-n` bridge — derived from §26, not invented

`PRD-020` §26 states *"Each maps to an acceptance criterion in §27."* ⚠ **That
map is asserted but not recorded**: measured mechanically, **0 of the 62 AC rows
names a `T-n`, and 0 of the 14 `T-n` rows names a `TSF-AC-*`.** The bridge below
is therefore reconstructed **from each test class's own stated subject matter**,
and is labelled as a reconstruction. Recorded as `D-020-02` in §8.

| Test | §26 states it proves | Acceptance criteria on the same subject |
|---|---|---|
| **T-1** Reporting | Every surface reportable; intake idempotent | `AC-001`…`006` |
| **T-2** Lifecycle | Only §13.2 transitions reachable; `CLOSED` terminal | `AC-011`, `012`, `013` |
| **T-3** Attribution | No action without case, actor, policy citation | `AC-020`, `021` |
| **T-4** Enforcement propagation | `TSF-EVT-002` reaches consumers, idempotent | `AC-028` |
| **T-5** Synchronous containment | Suspended cannot send; p99 ≤ 50 ms; fails closed on unreachability **and staleness** | `AC-025` **(a)+(b)**, `026`, `027` |
| **T-6** Strike determinism | Same history ⇒ same action; decay; overturn removes | `AC-030`, `031`, `032` |
| **T-7** Appeal independence | Enforcer cannot decide own appeal; timeout **queues** | `AC-041`, `042`, `044` |
| **T-8** Risk transparency | Every signal explainable, reproducible at pinned version | `AC-051`, `052` |
| **T-9** Circuit breaker | Automatic actions stop at cap and page | `AC-040` |
| **T-10** Tenant isolation | No `tenantId`/`StudentRecordId` in any `BC-13` surface | `AC-057` |
| **T-11** Admin containment | No tenant-session path reaches `BC-13`; no per-library statistic | `AC-058`, `059` |
| **T-12** Privacy & minimisation | No content retained outside evidence; purge on the clock | `AC-038`, `062` |
| **T-13** Indistinguishability | Denial ≡ not-found, uniform latency and shape | `AC-010` |
| **T-14** Moderator accountability | Reads audited, case-bound, no free-text search, recusal | `AC-024`, `061` |

**Union: 32 distinct `TSF-AC-*`.** The remaining **30** are reached only by
`IMPL-1449`'s sweep. ⚠ §26's claim that *each* class maps to a criterion is
satisfied; the converse — that each criterion has a class — **is not true**, and
is not made true here by assertion.

### 5.3 ⚠⚠ Task-level requirement coverage is **15.0%**, and it is published at that figure

| Measure | Value |
|---|---|
| Normative requirements (`TSF-FR-*` + `TSF-BR-*`) | **187** |
| Cited by at least one task row | **28** |
| **Coverage** | **28 / 187 = 15.0%** |
| Same figure measured over the whole document rather than the rows | 29 / 187 = 15.5% |
| Identifiers of any register cited by task rows | **75 of 400** |

⚠ **The first draft of this section published 14.4% and 74, both typed by hand; `prd020_task_coverage.py` recomputed 15.0% and 75 and the figures were corrected to the measurement.** Recorded as `D-020-05`.

This is **lower than the 40.6% acceptance coverage** the Stage 5 conferral
registered, and lower than any figure in the repository. The cause is structural
and is stated plainly: **`PRD-020` §30 allocated 50 tasks against 187 normative
requirements**, so most requirements are discharged transitively by a task that
does not name them.

⛔ **The obvious fix is refused, for the reason Stage 5 gave.** Adding citations
to task rows to lift a percentage would mean **this document asserting a trace
the source PRD did not make** — inventing traceability is precisely the defect
the trace is meant to detect. `IMPL-1449` exists to close the sweep with
measurement, and the 111 obligations uncovered at acceptance level are already
named by register in `TRACEABILITY_MATRIX.md` **§2O.2**.

**Stage 6's gate is that every *task* traces back to requirements — not that
every requirement is claimed by a task.** Measured against the gate as written:
**50 of 50 tasks trace**, 44 directly and 6 through §5.2. ✅

---

## 6. `IMPL-1410` — built, tested, and **not closed**

| Fact | Evidence |
|---|---|
| `ADR-0065` is **`Accepted`** — Option B, an `E-14`-fed projection local to `BC-12`, **no new edge** | `ADR-0065` §7.1; `PRD-020` §30.6 row 6 |
| Code exists | `lib/domain/social/messaging/enforcement_projection.dart`, wired in `lib/bootstrap/di.dart` |
| Tests exist and pass, including p99 | `test/domain/social/messaging_enforcement_test.dart` |
| An evidence record exists | [`PRD-020_IMPL-1410_IMPLEMENTATION_EVIDENCE.md`](PRD-020_IMPL-1410_IMPLEMENTATION_EVIDENCE.md) |
| ⛔ **`TSF-GAP-003`'s implementation half is still OPEN** | `PRD-020` **L693** |
| ⛔ **`READY` is therefore barred** | `TSF-BR-033`; §24.2 **L2046** |

⚠ **Built is not closed.** `PRD-020` §30.6 row 7 assigns the closure to the
**`BC-12` owner**, and moving the gap row is an **Architecture Owner** act
requiring an ADR that does not exist. See §7 row 2. This document records the
distinction rather than eliding it.

---

## 7. Governance actions this document does **not** perform

| # | Action | Owner | Authority required | State |
|---|---|---|---|---|
| 1 | `PRD_REGISTRY.md` **L320** `PLANNED` → `DRAFT` | **Governance Owner** | Amendment authority — **L317**: *"editing it is an amendment act … not a side effect"* | ⛔ Not performed. `TSF-GAP-013` |
| 2 | Close the implementation half of `TSF-GAP-003` (`PRD-020` **L693**) | **Architecture Owner** | A new ADR — the only lawful next number is **`ADR-0074`** | ⛔ **Not performed. Authority not available.** See §7.1 |
| 3 | `PRD_OWNERSHIP_MODEL.md` **L202** register `TSF-` and `IMPL-1400`…`1449` | **Governance Owner** | Rank 1–5 amendment ⇒ ADR first (Baseline §7 rule 1) | ⛔ Not performed. `TSF-GAP-013` |
| 4 | Rank this document; admit it to `DOCUMENTATION_BASELINE.md` | **Governance Owner** | ADR of the `ADR-0053`/`0054`/`0064` form | ⛔ Not performed |
| 5 | Allocate a V1 growth reserve for `PRD-020` | **Governance Owner** | Range-allocation authority | ⛔ Not performed. §3.4 |
| 6 | Resolve `TSF-GAP-014` (age-band accessor) | **`BC-18` + `BC-13` owners** | Cross-context accessor decision | ⛔ Not performed |
| 7 | Confer `READY` / freeze | **Governance Owner** | Every Stage 7 gate satisfied — they are not | ⛔ Not performed. §24.2 **L2046** |

### 7.1 ⛔ The one act that was attempted and lawfully stopped

Closing `TSF-GAP-003`'s implementation half is the **single blocker between
`PRD-020` and Stage 7**. It was assessed, not assumed:

- **What exists.** `ADR-0065` `Accepted`; the projection built, wired and tested; an evidence record; `TSF-AC-025` clause (b)'s staleness gate implemented.
- **What is missing.** A decision, by the **Architecture Owner**, that the built artefact **satisfies** `ADR-0065` §7.1 in full and that the gap may therefore be marked closed.
- **Why I may not make it.** `ADR-0033` **L169**: *"A conferral for one act is not a standing licence."* The Task I conferral was spent on `ADR-0065` itself. No conferral for this act exists in the engagement record.
- **The shape the ADR would take**, offered as preparation and **not** as a decision: `ADR-0074`, *"Closure of `TSF-GAP-003` implementation half"*, status **`Proposed`**, citing `ADR-0065` §7.1 items 1–5 against the evidence record, and — if accepted — amending `PRD-020` **L693** only.

**`ADR-0074` is not written here.** Writing a `Proposed` ADR would itself
consume the only lawful next ADR number on an act whose owner has not been
consulted.

---

## 8. Defects disclosed, not repaired

| # | Defect | Why not repaired here |
|---|---|---|
| `D-020-01` | `IMPL-1439` says *"all 21 `TSF-CFG-*`"*; the register holds **30** | The nine may be owned elsewhere. Reconciling is a **document-owner** act; guessing would either invent nine obligations or silently drop them |
| `D-020-02` | §26 asserts each `T-n` maps to a `§27` criterion, but **0 of 62 AC rows names a `T-n`** and **0 of 14 `T-n` rows names an AC** | §5.2 reconstructs the bridge from stated subject matter and **labels it a reconstruction**. Writing the map into `PRD-020` §26/§27 is a document-owner act |
| `D-020-03` | No V1 growth reserve; `IMPL-1450` is spoken for | §3.4. Both fixes are another owner's act |
| `D-020-04` | Source PRD header reads v0.1, content is v0.5 | Carried forward from Stage 5. Document-owner act |
| `D-020-05` | ⛔ **This document's own §5.3 published hand-typed coverage figures — 14.4% and 74 — that were wrong.** `prd020_task_coverage.py` recomputed **15.0%** and **75** and failed the discrepancy into view | **Repaired**, not deferred: the figures now match the instrument. ⚠ Recorded because this is the **`I-3` class recurring for the second time in this module** — a count typed beside evidence that contradicts it. It is the reason coverage is printed by a script on every run rather than written into prose |

### 8.1 Mutation testing, and a tooling incident recorded rather than hidden

`prd020_task_coverage.py` was mutation-tested. All four injected defects were
caught; each row names the check that owns it.

| # | Mutation | Result | Correct? |
|---|---|---|---|
| **N1** | `IMPL-1425`'s row deleted, leaving a hole in the range | **fail** — *"tasks with no row"* + *"1 task traces to no requirement"* | ✅ check 1 |
| **N2** | A `TSF-FR-*` citation changed to a number above the register's maximum. ⚠ **The token is deliberately not reproduced** — see the note below | **fail** — *"cites TSF-* that PRD-020 does not define (minted or dangling)"* | ✅ check 5 |
| **N3** | `Blocked by` column stripped from a task-table header | **fail** — *"1 task table omits Priority/Blocks/Blocked by"* | ✅ check 3 |
| **N4** | Withdrawn `IMPL-1412` reassigned to new work | **fail** — *"IMPL-1412 is withdrawn … but its row does not say so"* | ✅ check 2, the rule-1 guard |

⚠⚠ **The incident.** The mutation harness reverted each change with
`git checkout --`, which **silently does nothing to an untracked file**. This
document was untracked at the time, so the four mutations **accumulated** instead
of being reverted, and the run log shows the failure counts climbing 2 → 3 → 4 → 5
rather than returning to zero between mutations.

The damage was then **enumerated by measurement** — each mutation had a unique
signature (`grep -c 'IMPL-1425'` = 0; the out-of-register `TSF-FR-*` token at
L134; the reassigned row at L150; the short header at L131) — and reversed exactly. **The file re-hashes to
`2779e5654181c42925e8c3eb0237397a0cd7588dd2f2e41530d4aeecc8e75e1d`, byte-identical
to its pre-mutation state**, and the instrument returns to PASS.

**Recorded because the near-miss is the lesson**: had the mutations been subtler
than a deleted row and an invented identifier, the accumulated damage might have
been committed. The rule this establishes for later modules: **mutation-test only
tracked files, or snapshot the bytes before injecting**. The climbing failure
count is also, in its way, evidence the instrument works — it kept reporting every
outstanding defect rather than only the newest one.

⛔⛔ **And it happened once more, in this very subsection.** The N2 row above
originally named the invented token it had injected — writing a live phantom
`TSF-FR-*` into the repository inside the paragraph explaining that phantoms must
not be written. **Both** `prd020_task_coverage.py` (check 5) and
`prd020_traceability.py` (dangling references) failed this document immediately.
This is the **`I-5` class from the Stage 5 conferral recurring at Stage 6, by the
same author, who had written that disclosure hours earlier and had also written
the check that caught it.** The remedy is the same and it is now used three times
in this module: describe the token's *position*, never reproduce it. ⚠ The
conclusion is not that more care is needed — it is that **this defect is not
preventable by intention, only by a gate**, and the gate held on every occasion.

---

## 9. Containment audit

| Question | Answer |
|---|---|
| Implementation code modified? | **No** — `git status --short lib/ packages/ test/` returns **0 lines** |
| `PRD-020_TRUST_AND_SAFETY.md` modified? | **No** — `685fb65a…497b`, byte-unchanged |
| `TRACEABILITY_MATRIX.md` modified by this document? | **No** — §2O was written at Stage 5 and is untouched here |
| Any ADR written, amended or opened? | **No** — all **65** byte-unchanged; `ADR-0074` **not** created |
| `PRD_REGISTRY.md`, `DOCUMENTATION_BASELINE.md`, `PRD_OWNERSHIP_MODEL.md` modified? | **No** |
| BC Map, Module Dependency Matrix, `module_dependencies.yaml` modified? | **No** |
| Any identifier minted? | **No** — **0**. Every `IMPL-*` and `TSF-*` token here was already defined by `PRD-020` |
| Any number reused or reassigned? | **No** — `IMPL-1412` is withdrawn and its number left permanently spent |
| Any gap closed? | **No** — all **16** `TSF-GAP-*` remain OPEN |
| `READY` or freeze claimed? | **No** |

---

## 10. Verdict

✅ **STAGE 6 SATISFIED ON ITS GATE AS WRITTEN.** An `IMPL-*` range is allocated —
`IMPL-1400`…`1449`, verified next-free by three independent routes — and this
task document records `Priority`, `Blocks` and `Blocked by` for all 50 tasks with
a traceability table mapping task groups → requirements → invariants →
acceptance. **50 of 50 tasks trace back to requirements — all 50 by direct
citation in their own row**, the eight test tasks of Wave 5 citing acceptance
criteria that the §5.2 bridge derives and labels as a reconstruction.

**What this does not confer:** not Stage 7, not rank, not freeze, not `READY`,
not verification. Task-level requirement coverage is **15.0%** and is published
at that figure. **16** gaps remain open, **0 of 62** acceptance criteria are
discharged by a test that names them, and the implementation half of
`TSF-GAP-003` — the sole remaining bar to `READY` — awaits an **Architecture
Owner** decision that this document lawfully declines to make.

**Stage 6 of 9. Stage 7 is NOT entered.**

---

## 11. Change history

| Version | Date | Change |
|---|---|---|
| 1.0 | 2026-08-23 | Created. Stage 6: `IMPL-1400`…`1449` allocated (next-free verified three ways), 50 tasks with `Priority`/`Blocks`/`Blocked by`, traceability table by wave, and a **labelled reconstruction** of the `T-n` → acceptance bridge that §26 asserts but does not record. ⚠⚠ Task-level requirement coverage published at its true **14.4%**; the fix of adding unsourced citations is **refused** as invented traceability. Five defects disclosed (`D-020-01`…`05`); four deferred with a named owner, one (`D-020-05`) repaired — this document's own hand-typed coverage figures, caught and corrected by its own instrument. ⛔ **`ADR-0074` deliberately NOT written** — closing `TSF-GAP-003`'s implementation half is an **Architecture Owner** act and no conferral for it exists. **0 identifiers minted; subject byte-unchanged.** |
