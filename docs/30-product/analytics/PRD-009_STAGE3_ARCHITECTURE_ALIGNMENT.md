# `PRD-009` Analytics & Reports — Stage 3 Architecture Alignment Record

| Field | Value |
|---|---|
| **Stage** | **Stage 3 — Architecture Review** ([`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md) **L88–105**) |
| **Subject** | [`PRD-009_ANALYTICS_AND_REPORTS.md`](PRD-009_ANALYTICS_AND_REPORTS.md) — `PRD-009`, **`BC-26` Analytics Read Model** `[GENERIC]`, **v0.5 `DRAFT`, Unranked** |
| **Gate addressed by** | ⭐ **This document** — *"a written alignment record naming every conflict and its disposition"* (**L100–101**) |
| **Subject sha256** | `30b8fcd7a8f71cd763c79755862a7f66608978b624d672af51da7734468db786` — **1,179 lines, 97,970 bytes**. ⛔ **Unchanged by this record** |
| **Measured at** | `a6172d2cb9e8136f755afef1a7b8c8023e10508d` |
| **Worked examples followed** | [`PRD-020_STAGE3_ARCHITECTURE_ALIGNMENT.md`](../trust-safety/PRD-020_STAGE3_ARCHITECTURE_ALIGNMENT.md) (header shape, *"this document is that artefact"*) and [`PRD-019_ARCHITECTURE_ALIGNMENT.md`](../integration/PRD-019_ARCHITECTURE_ALIGNMENT.md) §0 (the measure-versus-confer distinction) |
| **Reviewer role** | Architecture reviewer (`PRD_LIFECYCLE.md` §6 **L277**). ⚠ **No named holder exists**, and ⛔ **no personal name is recorded** — `PRD_OWNERSHIP_MODEL.md` §7 rule 4: *"**Never** record a personal name"* |
| **Mandate** | **Stage 3 measurement only.** ⛔ No requirement added or changed · no identifier registered in any matrix · **no Rank 1–5 document touched** · no ADR created · no registry or baseline update · no rank assigned · no freeze · **0** `.dart` files |
| **Verdict** | ⚠ **6 of 6 mandated checks MEASURED as ALIGNED** — with **1 conflict ACCEPTED and OPEN** (`ANL-AL-B1`) and **1 finding REJECTED with its reason** (`ANL-AL-R1`). ⛔⛔ **The Stage-3 stage verdict is NOT CONFERRED by this record.** See §0 |
| **Status of this record** | **Unranked.** A gate record, not a requirement source — **not part of the specification** |

---

## 0. ⛔⛔ The one thing this record does not do, stated first because it is the most important limit on it

⭐ **`PRD_LIFECYCLE.md` §6 L277 assigns Stage 3 to the Architecture reviewer** — *"Architecture reviewer |
Stage 3; authority to require an ADR"*. This record was authored by the agent, which holds **no such
designation for `PRD-009`**.

| Act | Performed here? |
|---|---|
| **Run** the six Stage-3 checks against the ranked documents, by measurement, citing path and line | ✅ **Yes** — §1–§6 |
| **Record** every conflict with its disposition, and every rejected finding with its reason | ✅ **Yes** — §7, §8 |
| **Satisfy** the Stage-3 **gate artefact** requirement (*"a written alignment record…"*) | ✅ **Yes** — that is what this document *is* |
| **Confer** the Stage-3 stage verdict | ⛔ **No** — that is the Architecture reviewer's act |

⚠ **Why this distinction is not pedantry.** `PRD-019_ARCHITECTURE_ALIGNMENT.md` §0 states the rule this
record obeys: *"a record must not confer the stage it measures… **A green gate signed by the author of the
thing being gated is not a gate.**"* The same file quotes `PRD-008`'s amendment for this error class: *"A
Stage 3 record must not accept the ADR it depends on; it may only observe that someone with authority
did."*

⛔ **Two routes were considered and refused as unlawful:**

| Refused route | Why refused |
|---|---|
| ⛔ Author `PRD-009_STAGE3_CONFERRAL.md` | Both existing Stage-3 conferrals (`PRD-008`, `PRD-015`) rest on an **explicit human-principal instruction**. `ADR-0104` §2.2 is express: *"**the agent is not the reviewer and does not act as one**"*. **No designation exists for `PRD-009`** |
| ⛔ Borrow `ADR-0104`'s designation | It is scoped verbatim to *"`PRD-015` Stage-3 review and conferral act, **and nothing else**"*, and `ADR-0033` §7.1 says independently: *"A conferral for one act is not a standing licence"* |

⭐ **And the mechanical instrument agrees.** `tool/docs_check/alignment_record_freshness.py` prints, in its
own output: *"**Freshness is not conferral — Stage 3 remains the Architecture Reviewer's act.**"*

---

## 0.1 ⭐⭐⭐ Why this record can lawfully be created **now**, without a conferral

⚠ **This was tested rather than assumed, because the previous pass reported the opposite.** The prior
Stage-4 report stated that the blocker was a missing *Stage-3 **conferral***. ⛔ **That framing was too
strict, and the measurements below correct it.**

| # | Measurement | Result |
|---|---|---|
| **1** | Occurrences of *"confer"* in the Stage-3 gate definition (`PRD_LIFECYCLE.md` **L88–105**) | ⭐ **0** — the gate names *"a written alignment record"*, **never** a conferral |
| **2** | Alignment records on disk vs Stage-3 conferrals on disk | ⭐ **27 alignment records** (pre-existing, excluding this one) across ~20 PRDs, but only **2** Stage-3 conferrals (`PRD-008`, `PRD-015`) |
| **3** | Does `ADR-0082` **L324** demand a Stage-3 *conferral*? | ⛔ **No.** It requires *"a Stage 3 **record**"*, and **L331** says the next stage is executable *"as soon as a Stage 3 **alignment record** exists"* |
| **4** | How `PRD-020` — the precedent `ADR-0082` L324 cites as *"Stage 3 PASSED 6/6"* — satisfied Stage 3 | ⭐ With **`PRD-020_STAGE3_ARCHITECTURE_ALIGNMENT.md` only**. ⛔ **It has no Stage-3 conferral**, and its header says *"**This document is that artefact for Stage 3**"* while recording *"No named holder exists"* |
| **5** | What `PRD-020`'s **conferred** Stage 5 required of Stage 3 | ⭐ `PRD-020_STAGE5_CONFERRAL.md` **L207**: *"Stage 3 and Stage 4 verdicts \| Both **PASS 6/6**, recorded in **their own artefacts**"* — **records, not conferrals** |
| **6** | How the FROZEN PRDs named Stage 3 in their freeze records | ⭐ `PRD-016_STAGE7_FREEZE.md` L63 names **`PRD-016_ARCHITECTURE_ALIGNMENT.md`**; `PRD-013` L66 names its alignment record + supplement. ⛔ **Neither is a conferral, and both froze at Rank 3** |
| **7** | Is an alignment record a Rank 1–5 document (so §7 rule 1 would need an ADR first)? | ⛔ **No.** Where baseline §3 lists them at all they read *"Validation record — **not part of the specification**"*, and **`PRD-019`'s and `PRD-015`'s are not listed at all** — so creation needs **no ADR and no baseline edit** |

⭐⭐ **Conclusion, stated precisely.** The Stage-3 **gate artefact** is an alignment record, and authoring
one is a **measurement act** available now. The Stage-3 **stage conferral** is a separate, role-reserved
act that remains `[OWED]`. ⛔ **This record performs the first and refuses the second** — and it does not
claim the first is the second.

⚠ **What this does and does not unblock.** `PRD-009` previously had **no standalone Stage-3 gate
artefact** — its alignment lived only inside §8.6 of the PRD, which is the *subject* of the review. ⭐
This record supplies the artefact as an independent document, matching the convention every other PRD
follows. ⛔ **It does not make Stage 4 conferrable**, because Stage 4's own blocker is a missing
Requirements-Reviewer role exercise (§9).

---

## 1. Check 1 — Context ownership is exclusive (BC Map §3)

| Field | Value |
|---|---|
| **Authority** | `LIBOORA_BOUNDED_CONTEXT_MAP.md` §3 |
| **Failure mode** | Two PRDs own one aggregate |
| **Measured** | `BC-26` Analytics Read Model is claimed by **`PRD-009` only**. Every other file mentioning `BC-26` does so as a **consumer or a citation**, never as owner. BC Map §8 **L385** gives `BC-26` exactly **one** aggregate row: *"BC-26 Analytics Read Model \| `Projection` \| `CertifiedMetric`, `ReadModel`"* |
| **Result** | ✅ **PASS · NON-CONFLICT** |

⚠ **One adjacent item measured and deliberately not treated as a failure.** BC Map §5 **L206** records a
name collision — *"`AnalyticalReport` (BC-26) vs `AbuseReport` (BC-13)"*. §5's governing text binds
**names in code and APIs**, not aggregate structure, so it is **not** a context-ownership defect. Recorded
here so the reader is not left to wonder whether it was missed.

---

## 2. Check 2 — Every integration edge exists in §7 (BC Map §7)

| Field | Value |
|---|---|
| **Authority** | BC Map §7 — **L292**: *"If an edge is not in this table, it does not exist"* |
| **Failure mode** | An undeclared edge — needs an ADR |
| **Measured** | `PRD-009` invokes **two** edges: **`E-26`** (§7, *"AI retrieves through permission-aware ports only — never direct index or table access"*) and **`E-30`** |
| **`E-30` disposition** | ⭐ `E-30` is **not** in the §7 table but is lawfully declared in **§17** (**L852–882**, **L899**), an express *"**NORMATIVE EXTENSION OF §7 AND §9**"* admitted by `Accepted` **`ADR-0096`**. **L292 is satisfied by the ADR existing** — this record only **observes** that an authorised act occurred; it does not ratify it |
| **Result** | ✅ **PASS · 2 / 2 edges exist.** ⛔ **0 edges invented** |

⛔ **A missing edge is recorded as missing, not quietly supplied.** A `BC-26`→`BC-22` edge for
analytics-triggered notifications **does not exist**, so scheduled report subscriptions cannot be
specified. That is carried as `ANL-OBD-005` / `ANL-GAP-018` and as `ANL-XC-009`, which makes a `BC-26`
send **unconstructable**. ⛔ This record does **not** request that edge (see §8, `ANL-AL-R1`).

---

## 3. Check 3 — Rank direction is downward (Dependency Matrix `L2`)

| Field | Value |
|---|---|
| **Authority** | `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` **L49** (`L2`) |
| **Failure mode** | Illegal import |
| **Measured** | `tool/module_dependencies.yaml` **L303–329**: `platform/analytics` declares `rank: 7`; `imports:` **`contracts`** only (rank 0); **5 / 5** `ports:` address lower-rank capability platforms — `platform/data:analytics_store`, `platform/configuration:settings`, `platform/observability:telemetry`, `platform/tenancy:tenant_context`, `platform/identity:policy_decision` |
| **`consumes_events`** | ⭐ `consumes_events: ["*"]` is **not an import** and does not create a rank edge (subject §8.4.1) |
| **`banned_imports`** | Declared: `domain/**` (`X-01`), `app/**`, **`platform/data:oltp_repository`** — consistent with Matrix **R7** (`ANALYTICS → LIBRARY MANAGEMENT` = **`✖`**) and `X-01` (*"Consume events, build a projection"*) |
| **Result** | ✅ **PASS** |

---

## 4. Check 4 — No authorisation decided outside `BC-18` (`X-13`)

| Field | Value |
|---|---|
| **Authority** | Matrix **L362** (`X-13`) |
| **Failure mode** | ⛔ **A security defect that passes its own tests** |
| **Measured** | `ANL-BR-004` makes role-alone visibility insufficient; `ANL-FR-038` requires actor permissions on every query; the manifest grants **`platform/identity:policy_decision`** — a **decision port**, i.e. `BC-26` *asks* and never decides. `ANL-OBD-003` / `ANL-OBD-004` are **routed to `BC-18`, not answered** |
| **Result** | ✅ **PASS · NON-CONFLICT** |

---

## 5. Check 5 — No credential, OTP or session outside `BC-18` (`ID-1`)

| Field | Value |
|---|---|
| **Authority** | `ID-1` |
| **Failure mode** | Prohibited |
| **Measured** | `PRD-009` declares **no** credential, OTP or session concept. ⭐ Strengthened by `ANL-XC-012`: the `iam.*` family — which carries `SessionRevoked` — is **expressly excluded**, matching the manifest's `excluded_events: ["iam.*"]` (**L317**, comment L314–316) and assertion **`AN-3`** |
| **Result** | ✅ **PASS · NON-CONFLICT** |

---

## 6. Check 6 — Tenant scoping correct (`MP-GBR-08`, `X-13`)

| Field | Value |
|---|---|
| **Authority** | `MASTER_PRD.md` `MP-GBR-08`; Matrix `X-13` |
| **Failure mode** | Cross-tenant leak — `MP-RSK-01`, **Critical** |
| **Measured** | `ANL-INV-006` (cross-tenant read **impossible**), `ANL-FR-004` (fail loudly, never default), `ANL-FR-038` (`tenantId` on every query), `ANL-FR-014` (per-tenant rebuild isolation). Manifest holds **`platform/tenancy:tenant_context`**; `test/architecture/tenant_isolation_test.dart` exists |
| **Result** | ✅ **PASS · NON-CONFLICT** |

---

## 7. ⭐⭐ Conflicts and dispositions — **every conflict named**, as the gate requires

⚠ **The gate is *"naming every conflict and its disposition"*, not *"reporting no conflicts"*.**

| ID | Conflict | Class | Disposition |
|---|---|---|---|
| **`ANL-AL-B1`** | ⛔⛔ **Rank-4 vs Rank-4 conflict over `iam.*`.** BC Map **§7 L434** routes `iam.*` events to `BC-26`, while `tool/module_dependencies.yaml` **L317** declares `excluded_events: ["iam.*"]` with assertion **`AN-3`** (*"no projection, metric or dimension is derived from any `iam.*` fact"*, amendment **`A-6`**, closing `CFL-28`) | **BLOCKER** for any `iam.*`-derived metric | ⭐ **ACCEPTED · OPEN.** ⛔ **Both instruments are Rank 4, so precedence cannot break the tie** — routed to the **Architecture Owner** as `ANL-OBD-008`. Safe default fixed by `ANL-XC-012` (exclude), made testable by `ANL-AC-017`. ⛔ **Not resolved here: resolving it would be a Rank-4 amendment, which is the Architecture Owner's act** (`ADR-0054` **L148**) |
| **`ANL-AL-A1`** | §8.1 of the subject listed `iam.*` as a legitimate input without measuring the manifest | **MEDIUM** — the agent's own v0.2 defect | ⭐ **ACCEPTED · FIXED at v0.3** — row marked CONTESTED |
| **`ANL-AL-A2`** | `platform/analytics`'s declared surface and assertions `AN-1`/`AN-2`/`AN-3` were never recorded | **MEDIUM** | ⭐ **ACCEPTED · FIXED at v0.3** — subject §8.4.1; **`AN-2`** upgrades `ANL-AC-001` and `ANL-GAP-001` from prose to a breach of a declared, assertable manifest rule |

### 7.1 Governance dependencies that remain OPEN

⛔ **Named so none is lost. This record closes none of them.**

| Item | Owner |
|---|---|
| `ANL-OBD-002` — cohort-band scope (`MP-GBR-21` closes the scope register at `self`, `guardianOf`, `tenantWide`) | Privacy + Architecture Owner |
| `ANL-OBD-004` — `guardianOf` analytical reach (`MASTER_PRD.md` **L111**) | `BC-18` owner |
| `ANL-OBD-008` — the `ANL-AL-B1` Rank-4 conflict | Architecture Owner |
| `ANL-OBD-009` — enterprise customization boundary | Product Owner |
| **F-1** — no semantic layer exists (`MP-GBR-36`, `AN-2`) | Architecture + Implementation |
| **F-2** — learning-outcome data source | **BLOCKER** — Product Owner |
| **F-3** / `AttendanceCorrected` | Carried unchanged |

---

## 8. ⭐ Findings raised and **REJECTED**, with reasons

> `PRD_LIFECYCLE.md` **L104–105**: *"**A rejected finding must be recorded as rejected, with its reason.**
> … A review that records only accepted findings is indistinguishable from a review that found nothing."*

| ID | Finding considered | ⛔ Disposition and reason |
|---|---|---|
| **`ANL-AL-R1`** | Request a Rank-4 manifest amendment adding an explicit `semantic_layer` port, or a `BC-26`→`BC-22` edge for analytics-triggered notices | ⛔ **REJECTED.** The declared `ports` already cover the certified chain (`analytics_store`, `policy_decision`), so **no amendment is needed**; and the `BC-22` edge question is already routed as `ANL-OBD-005` / `ANL-GAP-018`. ⭐ **A Stage-3 review that requests a Rank-4 amendment it does not need is widening its own authority** — `ADR-0060` **L132**: doing so *"is a broader act than the one conferred"* |
| **`ANL-AL-R2`** | Treat BC Map §5 **L206**'s `AnalyticalReport` / `AbuseReport` name collision as a check-1 ownership failure | ⛔ **REJECTED.** §5's governing text binds **names in code and APIs**, not aggregate structure. `BC-26` still holds exactly **one** §8 aggregate row (L385), so ownership remains exclusive. ⚠ Recorded rather than dropped, so a later reader sees it was examined |
| **`ANL-AL-R3`** | Treat `E-30`'s absence from the §7 table as a check-2 edge violation | ⛔ **REJECTED.** BC Map **§17** is an express *"NORMATIVE EXTENSION OF §7 AND §9"* admitted by `Accepted` **`ADR-0096`**, so **L292 is satisfied by the ADR existing**. ⚠ Raising it would have been a **false positive against an authorised act** |

---

## 9. ⛔ What remains before Stage 4 can be conferred

| # | Dependency | Required authority | Status |
|---|---|---|---|
| **1** | **Stage-3 stage conferral** — an Architecture-reviewer designation in the `ADR-0104` form, then a conferral record | **Human principal → Architecture reviewer** | ⛔ **`[OWED]`** — cannot be self-supplied |
| **2** | **Stage-4 conferral** — a first-person Requirements-Reviewer role exercise for `PRD-009` (the `PRD-010_STAGE4_CONFERRAL.md` **L7–8** form) | **Human principal → Requirements reviewer** | ⛔ **`[OWED]`** — independent of dependency 1 |

⚠ **Stage 4's own evidence is already complete**: the subject records **6 of 6 Stage-4 checks PASS** at
v0.5 (§44.1), with check 3 closed by ownership classification. ⛔ **Only the two authority acts above are
missing** — and neither is a measurement this record could perform.

---

## 10. ⛔ Scope limits of this record

| ⛔ Not done |
|---|
| ⛔ **Stage 3 is NOT conferred** — the stage verdict remains the Architecture reviewer's act |
| ⛔ **No Rank 1–5 document touched** — `MASTER_PRD.md`, BC Map, Dependency Matrix, `module_dependencies.yaml`, `PRD_LIFECYCLE.md`, `DOCUMENTATION_BASELINE.md` all byte-unchanged |
| ⛔ **No ADR created**, no ADR accepted, promoted or superseded |
| ⛔ **No registry or baseline update** — `BASELINE-2026-09-03-A` stands; `PRD-009` stays **`PLANNED`** / `DRAFT`, unranked, unfrozen |
| ⛔ **No identifier registered** in `TRACEABILITY_MATRIX.md` — that is **Stage 5**, and `ADR-0082` **L324** bars advancing the chain from its middle |
| ⛔ **The subject PRD is byte-unchanged** — sha256 `30b8fcd7a8f71cd7` before and after |
| ⛔ **No requirement, exclusion, gap, obligation or configurable created, weakened or closed** |
| ⛔ **0** `.dart` files · **0** `tool/` files · no test authored or altered |
| ⛔ **No personal name, initials, handle or identity recorded** (`PRD_OWNERSHIP_MODEL.md` §7 rule 4) |
| ⛔ **No ARB meeting, quorum, attendee list or sign-off date asserted**; no Security or Privacy review asserted, performed or waived |

---

## 11. Changelog

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-05 | ⭐⭐⭐ **Created — the standalone Stage-3 gate artefact `PRD-009` did not previously have.** Its alignment evidence existed only inside §8.6 of the PRD, which is the **subject** of the review; every other PRD in the repository carries the record as an **independent document**, and this closes that structural gap. ⭐⭐ **All six mandated checks measured ALIGNED**, each citing path and line: exclusive `BC-26` ownership (BC Map §8 **L385**); **2 / 2** edges exist, `E-30` lawful via §17 + `Accepted` **`ADR-0096`**; rank downward (`rank: 7`, `imports: contracts`, 5/5 ports, manifest **L303–329**); no authorisation outside `BC-18` (`policy_decision` is a *decision port*); no credential/OTP/session (`iam.*` excluded, **`AN-3`**); tenant scoping (`ANL-INV-006`, `ANL-FR-004`/`-014`/`-038`). ⭐ **One conflict ACCEPTED and OPEN** — **`ANL-AL-B1`**, a genuine **Rank-4 vs Rank-4** contradiction over `iam.*` (BC Map **L434** vs manifest **L317**/`AN-3`) where **precedence cannot break the tie**; routed to the Architecture Owner as `ANL-OBD-008` with `ANL-XC-012` as the safe default. ⭐ **Three findings REJECTED with reasons** (§8) so the review is distinguishable from one that found nothing — including **two that would have been false positives** (§5's name collision binds *names*, not structure; `E-30` is admitted by an `Accepted` ADR). ⛔⛔ **Stage 3 is NOT CONFERRED by this record**, stated in §0 before anything else: *"a record must not confer the stage it measures"*, and `ADR-0104` §2.2 is express that *"the agent is not the reviewer and does not act as one"*. ⭐⭐ **§0.1 records why creation was nonetheless lawful NOW, on seven measurements that corrected the previous pass's own framing** — the prior report called the blocker a missing Stage-3 *conferral*, but *"confer"* occurs **0** times in the Stage-3 gate definition; the gate names *"a written alignment record"*; **27** pre-existing alignment records exist against only **2** Stage-3 conferrals; `ADR-0082` **L324**/**L331** require a *record*; **`PRD-020`** — the very precedent `ADR-0082` cites as *"Stage 3 PASSED 6/6"* — has **no** Stage-3 conferral and reached a **conferred Stage 5** on records (`PRD-020_STAGE5_CONFERRAL.md` **L207**); frozen `PRD-016`/`PRD-013` name their **alignment records** as the Stage-3 gate artefact; and alignment records are **not Rank 1–5**, so no ADR and no baseline edit was required. ⛔ Nothing ranked, baselined, registered or frozen; **0** `.dart` and **0** `tool/` files; subject byte-unchanged; `PRD-010` untouched and still **FROZEN** at Rank 3. |
