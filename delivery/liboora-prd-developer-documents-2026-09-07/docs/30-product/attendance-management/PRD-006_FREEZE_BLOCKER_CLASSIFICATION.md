# `PRD-006` Attendance Management — Freeze-Blocker Classification of All 18 Open Gaps

| Field | Value |
|---|---|
| **Document** | Independent classification of **every** open gap against the freeze-blocking criteria the repository actually applies |
| **Type** | Analysis record. **Not a freeze, not a baseline row, not an ADR, not a decision.** Unranked; confers nothing |
| **Subject** | [`PRD-006_ATTENDANCE-MANAGEMENT.md`](./PRD-006_ATTENDANCE-MANAGEMENT.md) **v1.3 — DRAFT**, hash `93ab1c60d740c4e0…` — **unmodified** |
| **Question** | Prior records assert that `ATT-GAP-017` is the single substantive blocker. **That assertion had never been tested against the other seventeen.** This record tests it |
| **Method** | The `ADR-0020` admission test, applied gap by gap: *is `PRD-006`'s specified behaviour **deterministic under every candidate resolution** of this gap?* |
| **Result** | **17 of 18 are NOT freeze-blocking. 1 is.** The prior assertion survives the test — and now has evidence rather than assertion behind it |
| **Version** | v1.0 · 2026-08-04 |

---

## 1. Why this analysis was owed

Three prior records state that `ATT-GAP-017` is the only substantive blocker. None of them **demonstrated** it.
That is a meaningful omission, because the opposite claim is equally available from the same facts: *eighteen
gaps are open, therefore eighteen things are unresolved, therefore freeze is eighteen decisions away.*

If that second reading were right, the consolidated decision package would be incomplete — it addresses six
configurables and one release class, not eighteen gaps.

**This record settles which reading is correct**, using the test the repository has already applied twice.

### 1.1 The test, from the precedent that established it

`ADR-0020` admitted `PRD-007` Seat Management to **Rank 3 with fourteen open `SEAT-GAP-*`**. Measured:
`grep -c 'SEAT-GAP-'` in `ADR-0020` → **7 references**, and §3 states:

> All fourteen are **admitted OPEN**. Admission does not ratify, close or reinterpret any of them.

And the reasoning that made this sound (`ADR-0020` L129):

> Admission is sound because `PRD-007`'s specified behaviour is **deterministic under every candidate
> resolution** of the gap.

And the rejected alternative (`ADR-0020` L233):

> *Hold freeze until the fourteen gaps close* — rejected: *"Each gap belongs to a named owner outside `BC-04`;
> `PRD-007` is deterministic under every resolution. `ADR-0018` froze with 2 open and `ADR-0019` with 5 —
> resolving them here would be deciding another owner's question."*

**Established freeze precedent for open gaps: 2 (`ADR-0018`) · 5 (`ADR-0019`) · 14 (`ADR-0020`).**
The number of open gaps is **not** a freeze criterion in this repository, and never has been.

### 1.2 The test stated precisely

A gap is **freeze-blocking** only if at least one of the following holds:

| # | Criterion | Rationale |
|---|---|---|
| **T-A** | The specification's behaviour is **non-deterministic** under candidate resolutions — a reader could build two different correct systems | `ADR-0020` L129 |
| **T-B** | The gap constitutes a **live breach of a ranked (1–5) document's MUST** | Freeze would confer rank on the violation — `ADR-0021` §2.6 |
| **T-C** | The gap is owned **inside `BC-03`** and could therefore be resolved without asking another owner's question | `ADR-0020` L233 — resolving another owner's gap is out of scope, not a blocker |

**A gap that fails all three is disclosed at freeze, not resolved before it.** That is exactly what `ADR-0018`,
`ADR-0019` and `ADR-0020` each did.

---

## 2. The classification — all 18 open gaps

> Verdicts below are this record's own, reached by applying §1.2. They do **not** alter any gap's status in
> `PRD-006` §32.1, which remains 🔴 OPEN for all eighteen.

| Gap | Question (abbreviated) | Owner | T-A non-deterministic? | T-B ranked breach? | T-C owned by `BC-03`? | **Freeze-blocking?** |
|---|---|---|---|---|---|---|
| `ATT-GAP-003` | Is `BC-26` a consumer of `attendance.*`? | Architecture owner | **No** — `ATT-FR-137` forbids depending on either consumer | No | No — systemic, ten contexts | **No** |
| `ATT-GAP-004` | Is `BC-13` a consumer of `FraudSignalDetected`? | Architecture owner | **No** — same `ATT-FR-137` | No | No | **No** |
| `ATT-GAP-005` | Attendance retention period after archival | Legal + architecture | **No** — BC Map `Q-04` is open *in the Rank 4 document itself* | No | No | **No** |
| `ATT-GAP-006` | Cryptographic construction for dynamic QR | Security Platform | **No** — `ATT-XC-013` forbids `PRD-006` specifying it | No | No | **No** |
| `ATT-GAP-007` | Wi-Fi identification / spoof detection | Architecture owner | **No** — `ATT-FR-039` build-blocks the anti-spoof claim | No | No | **No** |
| `ATT-GAP-008` | Is the GPS centre `LIB-6.5` Map Location? | Library PRD owner | **No** — affects what the radius measures *from*, not behaviour | No | No — Rank 3 field | **No** |
| `ATT-GAP-008a` | Is mock-location detection authorised? | Architecture owner | **No** — `ATT-FR-050` build-blocks the claim | No | No | **No** |
| `ATT-GAP-009` | Who owns attendance hardware lifecycle? | Architecture owner | **No** — Face is build-blocked by `ATT-FR-064` regardless | No | No | **No** |
| `ATT-GAP-010` | May `BC-03` hold a `FileRef` from `BC-29`? | Architecture owner — **needs an ADR** | **No** — `ATT-FR-080` build-blocks the whole workflow | No | No — BC Map is Rank 4 | **No** |
| `ATT-GAP-011` | Who owns OCR/Vision? *(NARROWED)* | Architecture owner — **needs an ADR** | **No** — same `ATT-FR-080`; direction already settled by `F-1`/`F-3`/`F-4` | No | No | **No** |
| `ATT-GAP-012` | Who owns/stores biometric templates? | Architecture + Security | **No** — `ATT-FR-064` build-blocks Face | No | No | **No** |
| `ATT-GAP-013` | What liveness capability exists? | Architecture owner | **No** — same build block | No | No | **No** |
| `ATT-GAP-014` | Biometric retention/erasure, incl. minors | Legal + Security | **No** — same build block | No | No | **No** |
| `ATT-GAP-015` | Is Face **V1** or **V3**? | Product **+** architecture owner | **No** — Face is build-blocked either way | No | 🟡 **Partly** — PO has decided; ARB has not | 🟡 **See §3** |
| `ATT-GAP-016` | Retention for register images | Legal + architecture | **No** — workflow build-blocked | No | No | **No** |
| `ATT-GAP-016a` | Offline Dynamic QR behaviour | Architecture owner | **No** — `ATT-NFR-012` forbids promising beyond `E-24` | No | No | **No** |
| **`ATT-GAP-017`** | **Defaults and ranges for 7 configurables** | **Product owner** | **No** — `ATT-FR-149`/`150` make it fail closed | 🔴 **YES — `LIB-16.2`, Rank 3** | 🟡 Partly | 🔴 **YES** |
| `ATT-GAP-017a` | Latency/throughput targets | Product + architecture | **No** — `ATT-NFR-003` states no figure | No | No | **No** |
| `ATT-GAP-018` | Is "at least one mode enabled" authorised? | Product owner | **No** — `ATT-FR-106` preserves permissive behaviour | No | 🟡 Partly | **No** |

**Result: 1 of 18 is freeze-blocking. 17 are not.**

### 2.1 The structural reason seventeen gaps are harmless

`PRD-006` contains **134 `MUST NOT` occurrences**, and the pattern is consistent: **every gap that could produce
divergent implementations is paired with a requirement that forbids building the affected capability at all.**

| Gap cluster | Build-block | Effect |
|---|---|---|
| `ATT-GAP-012`, `013`, `014`, `009` (Face) | `ATT-FR-064` — *"face verification **MUST NOT** be implemented. The mode is specified; it is **not** authorised to be built"* | Zero divergence — nobody may build it |
| `ATT-GAP-010`, `011` (OCR) | `ATT-FR-080` — *"the OCR/Vision workflow **MUST NOT** be implemented"* | Zero divergence |
| `ATT-GAP-003`, `004` (analytics/fraud edges) | `ATT-FR-137` — *"**MUST NOT** be built to depend on either consuming them"* | Zero divergence |
| `ATT-GAP-007` (Wi-Fi spoof) | `ATT-FR-039` — mode **MUST NOT** be presented as spoof-resistant | Zero divergence |
| `ATT-GAP-008a` (mock location) | `ATT-FR-050` — same shape | Zero divergence |
| `ATT-GAP-016a` (offline QR) | `ATT-NFR-012` — offline behaviour **MUST NOT** be promised beyond `E-24` | Zero divergence |
| `ATT-GAP-018` (mode constraint) | `ATT-FR-106` — this document **MUST NOT** enforce the rule | Zero divergence |
| `ATT-GAP-006` (crypto) | `ATT-XC-013` — this document **MUST NOT** specify a construction | Out of scope by design |

**This is the same property `ADR-0020` found in `PRD-007` and relied on.** `PRD-006` did not achieve it by
accident: `ATT-NFR-010` requires that *"a rule that cannot be checked MUST be treated as unmet"*, and §0.4 holds
that *"a gap resolved by implementation choice is not resolved."* The document's answer to an unresolved question
is consistently **refuse to build**, not **guess**.

> **A specification hole that is specified as a hole is still a hole — but it is no longer a trap.**
> — `PRD-006` L1233, about `ATT-GAP-017` specifically; the principle holds across all seventeen.

---

## 3. `ATT-GAP-015` — not freeze-blocking on its own merits, and why that matters

`ATT-GAP-015` asks whether Face is V1 or V3. **Face is build-blocked by `ATT-FR-064` under either answer**, so
the specification is deterministic and the gap fails T-A and T-B.

**But it is not therefore irrelevant to freeze**, for one reason only:

| If `ATT-GAP-015` resolves to | Effect on `ATT-CFG-014` | Effect on the `LIB-16.2` breach |
|---|---|---|
| **V3** (PO's decision, ARB pending) | Leaves the V1 configuration surface | **7 → 6** settings breaching |
| **V1** | Stays in the V1 surface | Remains **7** |
| Undecided *(today)* | Stays | Remains **7** |

**`ATT-GAP-015` is a *dependency of* the one real blocker, not a second blocker.** It changes the size of the
`ATT-GAP-017` breach by one setting. That is why Block D of the consolidated package exists, and why it is the
highest-leverage signature outstanding: it is the only pending item that reduces the blocker without requiring
anyone to supply a value.

---

## 4. Why `ATT-GAP-017` alone survives the test

It fails **T-B**, and T-B is the criterion no precedent has ever waived.

`PRD-006` L1188, the document's own words about itself:

> Seven rows carry `ATT-GAP-017` instead of a value … **This is a live breach of `LIB-16.2`** (Rank 3, Library
> PRD: *"Every setting **MUST** have a documented default"*).

**Measured across every frozen PRD** — `grep -ci 'live breach'`:

| Document | Rank | Occurrences |
|---|---|---|
| `PRD-SEAT-MANAGEMENT.md` | 3, frozen | **0** |
| `PRD-MEMBERSHIP-MANAGEMENT.md` | 3, frozen | **0** |
| `Student_Management_PRD_v1.md` | 3, frozen | **0** |
| `Library_PRD_v1.md` | 3, frozen | **0** |
| **`PRD-006_ATTENDANCE-MANAGEMENT.md`** | unranked, DRAFT | **1** |

### 4.1 The distinction that decides it

`DOCUMENTATION_BASELINE.md` §6 carries open defects **inside frozen Rank 3 and Rank 4 documents** — `GCP-05` (a
`PRD-003` internal contradiction about DOB) and `GCP-06` (a BC Map §8-versus-§7 contradiction). Documents at
Rank 3 and Rank 4 are frozen **while containing unresolved internal contradictions**.

So contradictions do not bar freeze either. The difference:

| | `GCP-05` / `GCP-06` | `ATT-GAP-017` |
|---|---|---|
| Nature | Contradiction **internal** to the document | Violation of a **different** Rank 3 document's MUST |
| Effect of freeze | Ranks a document that disagrees with itself | **Confers Rank 3 authority on a violation of a peer** |

`ADR-0021` §2.6 states it directly:

> `ATT-GAP-017` differs **in kind**, not in degree. It is not merely an absent decision: it is an **active breach
> of a MUST in a different Rank 3 document**. Freeze would confer Rank 3 authority on the violation.

**No frozen PRD in this repository carries a self-declared live breach of a ranked document. There is no
precedent to rely on and none to distinguish.**

### 4.2 What the mitigations do and do not achieve

`ATT-FR-149`, `ATT-FR-150`, `ATT-FR-151`, `ATT-BR-043` and `ATT-BR-044` make the absence **fail closed** and
demonstrate that `LIB-16.2`'s **second** sentence is satisfied in fact. They defeat **T-A** — which is why
`ATT-GAP-017` is *not* non-deterministic.

**They cannot defeat T-B.** *"Every setting MUST have a documented default"* is unqualified. Seven do not have
one. Specifying the behaviour of an absence is not the same as removing it, and `PRD-006` says so itself:

> Every rule above is about *the absence of a value*. Not one of them supplies a value, narrows a range, or makes
> any of the seven settings usable.

---

## 5. What this classification changes, and what it does not

| Changes | Does not change |
|---|---|
| The claim *"one blocker, not eighteen"* now has evidence, tested gap by gap against a named precedent | No gap's status. All 18 remain 🔴 **OPEN** in §32.1 |
| Confirms the consolidated decision package is **complete** — it addresses the only blocking gap plus its one dependency | No count. 516 identifiers, 285 obligations, 18 open gaps, 7 valueless settings — all unchanged |
| Establishes that 17 gaps are **disclosure items at freeze**, following `ADR-0018` (2), `ADR-0019` (5) and `ADR-0020` (14) | Nothing about whether freeze is *permitted* — that still needs the breach cleared and an admitting ADR |
| Identifies `ATT-GAP-015` as a **dependency of** the blocker, not a peer of it | `PRD-006`, which is byte-identical |

**This is not a reduction of the problem. It is a correct measurement of its shape.** The remaining work is
smaller than eighteen decisions and larger than zero: it is **one breach**, clearable by **four signatures**.

---

## 6. Verification

| # | Claim | Method | Result |
|---|---|---|---|
| 1 | 18 gaps open | `prd006_traceability.py` ledger scan | ✅ 21 rows — 2 resolved, 1 narrowed, **18 open** |
| 2 | `PRD-007` froze with 14 open gaps | Read `ADR-0020` §3 | ✅ *"All fourteen are admitted OPEN"* |
| 3 | `ADR-0018` froze with 2, `ADR-0019` with 5 | Read `ADR-0020` L233 | ✅ Verbatim |
| 4 | The determinism test is the repository's own | Read `ADR-0020` L129 | ✅ Verbatim |
| 5 | `live breach` unique to `PRD-006` | `grep -ci` across 5 PRDs | ✅ 0 · 0 · 0 · 0 · **1** |
| 6 | 134 `MUST NOT` occurrences | `grep -c 'MUST NOT'` | ✅ **134** |
| 7 | `ATT-FR-064` build-blocks Face | Read L851–852 | ✅ *"not authorised to be built"* |
| 8 | `ATT-FR-080` build-blocks OCR | Read L975–976 | ✅ Verbatim |
| 9 | `ATT-FR-137` forbids depending on `BC-26`/`BC-13` | Read L1467 | ✅ Verbatim |
| 10 | `PRD-006` unmodified | `sha256sum` | ✅ `93ab1c60d740c4e0…` |
| 11 | Stage 5 gate passes | `prd006_traceability.py` | ✅ exit 0 |
| 12 | Stage 6 gate passes | `prd006_task_coverage.py` | ✅ exit 0, 285/285 |

---

## 7. What this record deliberately did not do

| Not done | Why |
|---|---|
| Close, narrow or downgrade any gap | A classification is not a resolution. All 18 remain OPEN, owned by the people `PRD-006` §32 names |
| Recommend freezing with 17 gaps open | It establishes that 17 do not **block**. Whether to admit them is the governance owner's decision, in an admitting ADR that does not yet exist |
| Modify `PRD-006` §32 or §32.1 | The ledger's verdicts are the document's own. This record sits beside them |
| Invent a value, an option or an approval | Zero values appear in this document |
| Accept any ADR | `ADR-0021`, `0022`, `0023` remain **Proposed** |

---

## 8. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-04 | Created. Tests, for the first time, the standing claim that `ATT-GAP-017` is `PRD-006`'s only substantive freeze blocker — a claim asserted in three prior records and demonstrated in none. Applies the repository's own admission test from `ADR-0020` L129 (*"deterministic under every candidate resolution"*) to **all eighteen** open gaps, plus two further criteria: whether the gap is a live breach of a ranked document, and whether it is owned inside `BC-03`. **Result: 17 of 18 are not freeze-blocking; 1 is.** The structural reason is measured rather than asserted — `PRD-006` contains **134** `MUST NOT` occurrences, and every gap capable of producing divergent implementations is paired with a requirement forbidding the affected capability from being built (`ATT-FR-064` Face, `ATT-FR-080` OCR, `ATT-FR-137` analytics/fraud edges, `ATT-FR-039` Wi-Fi, `ATT-FR-050` mock location, `ATT-NFR-012` offline, `ATT-FR-106` mode constraint, `ATT-XC-013` cryptography). Establishes the freeze precedent for open gaps at **2** (`ADR-0018`), **5** (`ADR-0019`) and **14** (`ADR-0020`), so the count of open gaps is not and has never been a freeze criterion here. Distinguishes `ATT-GAP-015` as a **dependency of** the blocker rather than a peer — Face is build-blocked under either answer, but a V3 ruling removes `ATT-CFG-014` from the V1 surface and narrows the breach from 7 to 6. Confirms `ATT-GAP-017` survives on criterion T-B alone: `grep -ci 'live breach'` returns **0** for all four frozen Rank 3 PRDs and **1** for `PRD-006`, and `DOCUMENTATION_BASELINE.md` §6's tolerance of `GCP-05`/`GCP-06` does not extend to it, because those are contradictions *internal* to their documents while this is a violation of a *different* Rank 3 document's MUST. Records that the v1.3 mitigations defeat the determinism criterion but cannot defeat the breach criterion. **No gap was closed, narrowed or downgraded; no value, option or approval was invented; no ADR was accepted; `PRD-006` and every ranked document are byte-identical.** |
