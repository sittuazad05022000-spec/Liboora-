# `PRD-021B` B0–B3 — Stage 3 Blocker Resolution and Re-Review

| Field | Value |
|---|---|
| **Stage** | **Stage 3 — Architecture Review** (`PRD_LIFECYCLE.md` **L100–107**) — re-review after resolution |
| **Subject** | `PRD-021B` parts **B0, B1, B2, B3** |
| **Supersedes (in part)** | [`PRD-021B_STAGE3_ARCHITECTURE_ALIGNMENT.md`](PRD-021B_STAGE3_ARCHITECTURE_ALIGNMENT.md) — Check 2 **FAIL**. ⛔ **That record is NOT deleted, NOT edited and NOT overwritten.** Its finding was correct on the evidence it cited; this record supplies evidence it did not reach. `PRD_LIFECYCLE.md` **L104** — *"A rejected finding must be recorded as rejected, with its reason"* — and the `PRD-021A` A4/A6 precedent, where a resolution record retracted its predecessor's ground **in place** |
| **Gate** | *"a written alignment record naming every conflict and its disposition"* (**L102**) |
| **Measured at** | `b28d562`, working tree clean |
| **Reviewer role** | Architecture reviewer (`PRD_LIFECYCLE.md` §6 **L277**). ⚠ **No named holder exists** — `PGA-08` |
| **Authority claimed** | ⛔ **NONE beyond measurement and the application of an EXISTING ruling.** No ADR created. No edge created. No ruling issued |
| **Subject hashes** | ⛔ **All four byte-unchanged by this review** — verified before and after (§7) |
| **Verdict** | ✅ **PASS — 6 of 6 checks.** The Check 2 blocker is **DISSOLVED, not waived**: the required authority already exists and is **FROZEN**. **1 documentation correction required in B3, 1 in B0** — recorded, **not applied** (§5) |

---

## 0. The one-sentence resolution

**B3 does not need a new integration edge, because the edge it needs is `E-02`, which already exists — and the pattern by which a read composition consumes it was settled by `AR-1` and executed by `PRD-021A` Part A1, which is FROZEN at Rank 3.**

The prior record's Check 2 failure was **correctly measured and wrongly scoped**. It asked *"is there a `BC-02 → BC-11` edge?"* — there is not, and there must not be. It did not ask *"does B3 actually require one?"* The answer is **no**, and the repository had already answered it once.

---

## 1. What the prior record got right, and is retained

⭐ Three of its findings **survive intact** and are **not** retracted:

| Finding | Status |
|---|---|
| **No `MembershipValidity` edge terminates at `BC-11`.** §7 carries the projection on exactly two edges — `E-02` (**L299**, → `BC-04`) and `E-03` (**L300**, → `BC-03`) | ✅ **CONFIRMED, re-measured at `b28d562`.** Still true. Still correct |
| **B3's citation of `E-22` is unsound.** `E-22` (**L331**) is the `BC-29` File & Media edge and names `BC-11` a deliberate **non**-consumer per `ADR-0055` §3 | ✅ **CONFIRMED.** Correction still required — §5, `C-1` |
| **B3 relabels frozen `PRD-020` §8.3 step [1]** from *"not blocked either direction; graph rules"* to *"Eligibility (library membership)"* | ✅ **CONFIRMED.** Correction still required — §5, `C-2` |

⛔ **What is retracted is the *consequence* drawn from them** — that B3 therefore requires a non-existent edge and needs an ADR. That inference is **FALSIFIED** by §2.

---

## 2. The authority the prior record did not reach

### 2.1 `AR-1` — a read composition consumes published read models without an edge of its own

`ARCHITECTURE_RULINGS.md` **L23–52** is `Approved` and **authoritative** (its header: *"this file is the register of record for approved architecture decisions"*). It rules Library Discovery & Enrollment **not a bounded context** but an *"application / read composition capability"* that:

> owns **no aggregate** · owns **no invariant** · owns **no business state** · only orchestrates **public read models** · delegates **all** domain operations to their owning modules

And it publishes the read models that composition consumes — **`ARCHITECTURE_RULINGS.md` L44**:

> | Membership Plans & Pricing | **`BC-02` Membership** |

⭐ **Measured, decisive fact.** Library Discovery composes `BC-19`, `BC-25`, `BC-29`, `BC-06`, **`BC-02`** and `BC-04` (BC Map **L86**) — and **appears in ZERO rows of §7.** Instrument: `sed -n '292,345p' LIBOORA_BOUNDED_CONTEXT_MAP.md | grep -ci discovery` → **`0`**.

⇒ **A read composition consuming a published projection is not an integration edge, and the BC Map proves it by composing six contexts across zero §7 rows.** If composition required an edge, `AR-1` would be unbuildable — and `AR-1` is `Approved`.

### 2.2 `PRD-021A` Part A1 — the identical defect, already made and already corrected, now FROZEN

A1 is a `BC-15`-adjacent **`AR-1` read composition** that needs exactly what B3 needs: library membership eligibility from `BC-02`. **It made B3's mistake in v0.1 and fixed it in v0.2.** A1's changelog **L935**:

> *"the invented **integration edge** … removed; **`E-02` / `MembershipValidity` reuse made explicit** on the `LMD-16` and `MM-BR-011` authorities"*

Its disposition register **L908** records the deleted artefact by name:

> | `A1-EDGE-LIB-COMM` | **Removed** — `E-02` already exists |

And **L791** dissolves the conflict in the same words this review reaches independently:

> | `C-4` | No Library → Community integration edge exists, and `X-05` prohibits the import | ✅ **DISSOLVED** — no such edge is needed. `E-02` already exists in `MM-BR-006`'s allowlist and `MM-BR-011` already obliges the publication | **Zero** |

The operative requirements, **`LCM-FR-011`** and **`LCM-FR-013`** (A1 **L221**, **L225**):

> `LCM-FR-011` — A1 **MUST NOT** require, request, or assume any new integration edge. BC Map L292 holds that an edge absent from §7 does not exist; frozen `MM-BR-006` closes `BC-02`'s edge set at ten, with `MM-AC-065` enforcing. **`E-02` is already in that set.**
>
> `LCM-FR-013` — … A1 **MAY** compose the published `MembershipValidity` read model directly. **This is composition of a published read model, not a new edge** — `AR-1` describes such capabilities as ones that *"only orchestrate public read models."*

And **`LCM-ADR-002`** (A1 **L772**) answers the ADR question directly:

> An ADR **is not required** for consuming `E-02` … `E-02` is already in `MM-BR-006`'s allowlist and already obliged by `MM-BR-011`

⭐⭐ **A1 is FROZEN.** `DOCUMENTATION_BASELINE.md` **§3 L204** admits `PRD-021A` A1–A8 to **Rank 3** under **`BASELINE-2026-09-01-B`** by `Accepted` `ADR-0087`. This is not a draft's opinion — it is **baselined Rank 3 architecture**.

### 2.3 The publication obligation is frozen too

`MM-BR-011` (`PRD-MEMBERSHIP-MANAGEMENT.md` **L995**) **obliges** `BC-02` to publish plan, status, `validUntil` and seat quota through the `E-02` projection. `MM-BR-006` (**L962**) closes `BC-02`'s edge set at ten **with `E-02` inside it**. Consuming an already-obliged publication adds nothing to that set.

### 2.4 Why this does not breach `X-05` Separate Ways

`X-05` forbids **`BC-11`…`BC-17` reaching into Library Management**. It is not breached, because **`BC-11` never performs this read**. The composition does — on the **tenant side**, exactly where B3's own `SDS-XC-002` already places it, and where A1 sits (`LCM-RM-001`/`LCM-RM-017`). `BC-11` continues to answer **a boolean**. Nothing keyed on `studentRecordId` enters `domain/social`, so `ID-2` (**L488**) and the CI `banned_symbols` (`tool/module_dependencies.yaml` **L263-267**) hold unchanged.

⭐ **B3 already got this right.** `SDS-XC-002` and `SDS-DM-001` refuse the social-side placement on two independent executable grounds. **The architecture B3 specifies was lawful; the authority it cited for it was wrong.**

---

## 3. The six Stage-3 checks — re-run in the lifecycle-defined order

Order and wording taken verbatim from `PRD_LIFECYCLE.md` **L100–107**.

| # | Check | Authority | Result | Evidence |
|---|---|---|---|---|
| **1** | Context ownership is exclusive | BC Map §3 | ✅ **PASS** | B1's aggregate set is identical to BC Map **L377** (`Friendship`, `BlockList`, `FriendRequest`, `RateLimitCounter`). B3 mints **no** aggregate — `SDS-DM-002`/`003` refuse a profile and a membership entity by name. **0** cross-part duplicate `FR`/`BR` statements (measured, §4.6). No two parts own one aggregate |
| **2** | Every integration edge exists in §7 | BC Map §7, **L292** | ✅ **PASS** | **RESOLVED — see §2.** B3 requires **no** new edge. Membership validity arrives on **`E-02`**, in §7 at **L299** and in `MM-BR-006`'s frozen allowlist. Composition of a published read model is not an edge — `AR-1`, and `LCM-FR-013` (**FROZEN**). `B0` **`XPA-DEP-006`** already declares *"**No new edge is created by `PRD-021B`**"* — ⭐ which is **true**, and was true when written. **0** new edges; `E-27` still vacant; edge set still `E-01`…`E-26`, `E-28`, `E-29` |
| **3** | Rank direction is downward | Dep. Matrix **L2** | ✅ **PASS** | No upward dependency. B3's placement refusal (`SDS-XC-002`) is verified against CI `banned_imports`/`banned_symbols` **L255-267** — composing in `domain/social` is *unbuildable*, and B3 says so. Social-cluster exception correctly invoked for `E-14`…`E-16`, `E-28`. `XPA-DEP-005` forbids the reverse dependency that would invert `AR-1` |
| **4** | No authorisation decided outside `BC-18` | **X-13** | ✅ **PASS** | **0** authorisation decisions in B0–B3. Graph predicates (`canMessage(a,b)` per `E-16` **L320**, block state) are **domain** predicates on a registered edge, not auth. **0** `PERM-*` minted — the `LCM-AUTH-002` posture |
| **5** | No credential, OTP or session outside `BC-18` | **ID-1** | ✅ **PASS** | **0** credential, OTP, token or session handling anywhere in B0–B3 |
| **6** | Tenant scoping correct | **MP-GBR-08**, **X-13** | ✅ **PASS** | `ID-2` (**L488**) holds: no `tenantId`/`StudentRecordId` reaches `BC-11`→`17`. `SDS-DM-001` forbids the projection shape crossing into any social structure; `SDS-API-002` keeps cursors free of both; `SDS-SEC-003` rejects a client-supplied `tenantId`. `SDS-BR-012` enforces cross-library isolation on `X-05`. Global person index reconciled with `MP-GBR-08` by **FROZEN** `SID-4.38` + `ADR-0011` + BC Map §11.1. **No cross-tenant leak — `MP-RSK-01` not triggered** |

### ✅ **Stage 3 — 6 of 6 PASS. Gate SATISFIED.**

**Gate artefact:** this record, plus the retained predecessor. Together they name every conflict and its disposition, including the ones **rejected** and the one **retracted**.

---

## 4. Findings recorded as REJECTED, with reasons

`PRD_LIFECYCLE.md` **L104**. Carried forward from the predecessor and **re-tested at `b28d562`**, plus two new.

| ID | Candidate finding | Disposition |
|---|---|---|
| **R-1** | `MP-GBR-08` tenant-partitioning conflicts with a global person index | ❌ **REJECTED** — `SID-4.38` (**FROZEN**), `ADR-0011` organisation-neutrality, BC Map §11.1. Not a conflict |
| **R-2** | `RateLimitCounter` named in both B1 and B2 = duplicate ownership | ❌ **REJECTED** — one **`BC-11`** structure (**L377**) cited twice. Check 1 tests **contexts**, not parts |
| **R-3** | B2 "defines" `TSF-*` identifiers | ❌ **REJECTED** — instrument artefact. `prd020_stage5.py` uses a row heuristic that cannot distinguish citation from definition; B2's three lines are verbatim quotes with `L201`–`L203` refs. **Pre-existing** at baseline `88f9562` |
| **R-4** | `E-28` V1/V2 mixing | ❌ **REJECTED** — B2 **L343**, `SSF-SCOPE-006`, `SSF-XC-007`, B1 `SGR-EVT-008` all mark `E-28` **V2**, matching **L655** |
| **R-5** ⭐ | **The predecessor's own Check 2 FAIL** | ❌ **RETRACTED — ground falsified, not waived.** Its two premises stand (§1); its conclusion does not. It reasoned *"no `BC-02 → BC-11` edge ⇒ B3 is unlawful"*, which requires the unstated premise *"composition needs an edge"* — falsified by `AR-1` composing six contexts across **0** §7 rows, and by **FROZEN** `LCM-FR-013`. ⚠ **The predecessor is retained unedited**, per the `PRD-021A` A4/A6 precedent |
| **R-6** | 11 acceptance criteria "cite no requirement"; B2 "has 27 ACs, not 28" | ❌ **REJECTED — three defects in MY instrument, disclosed in §6.** All 90 ACs cite a requirement; B2 has 28 rows |

---

## 5. Required documentation corrections — recorded, NOT applied

⛔ **This record changes no subject byte.** Both corrections are **non-blocking**: they are *citation* defects, not architecture defects. The architecture B3 specifies is lawful as written.

| ID | Part | Defect | Smallest compatible correction | Owner |
|---|---|---|---|---|
| **`C-1`** | **B3** L177-179 | `SDS-FR-003` cites **`E-22`** as authority for boolean eligibility. `E-22` is the `BC-29` File & Media edge and names `BC-11` a **non**-consumer | Replace the authority with the one that actually grants it: **`AR-1`** + **`LCM-FR-013`** (FROZEN) for the composition, **`E-02`** + **`MM-BR-011`**/**`MM-BR-006`** (FROZEN) for the projection. ⭐ The *sentence quoted* from `E-22` stays true — `BC-11` does answer as a boolean — but it is `ADR-0055` §3's **reason for exclusion**, not a grant. Cite it as **corroboration**, never as authority | Document owner |
| **`C-2`** | **B3** L154-162 | `SDS-FR-002` relabels frozen `PRD-020` §8.3 step [1] *"not blocked either direction; graph rules"* → *"Eligibility (library membership)"* while asserting the step is unchanged. Grep for the frozen phrasing in B0/B3 = **0** | Restore the frozen wording for step [1], and record library-membership eligibility as an **additional B3-side constraint (`SDS-FR-001`) applied at step [1]** — which is what B3 actually means. ⛔ **`PRD-020` MUST NOT be edited** (FROZEN; `PRD_LIFECYCLE.md` **L177**) | Document owner |
| **`C-3`** | **B0** L240 | §6 chain link 2 self-asserts ✅ citing `MM-FR-002`/`066` — correct in conclusion, incomplete in authority | Add `AR-1` + `E-02` + `LCM-FR-013`. ⚠ **The ✅ is CORRECT and stays ✅** — the predecessor required it flipped to ❌; that requirement is **withdrawn** with `R-5` | Document owner |
| **`C-4`** | **B1** L564, **B2** L373 | Both cite `E-22` for the boolean-answer principle | ⚠ **NO correction required.** Both cite it for what it *does* say — that `BC-11` answers as a boolean and is not a `BC-29` consumer. Neither claims it grants a read. **Sound as written** |

⭐ **Why these are corrections and not blockers.** Stage 3 asks whether the PRD is *lawful against Ranks 1–5*. B3's architecture is lawful — it composes a published projection on the tenant side, exactly as a **FROZEN** precedent does. A wrong citation for a right architecture is a **documentation defect**, closed under the Stage-4 gate (*"conflicts closed or explicitly deferred with a reason and an owner"*), which is where they are carried.

---

## 6. Instrument defects in THIS review — disclosed

Three, all mine, all found by checking a mechanical result against the text before believing it.

| ID | Defect | Effect if trusted |
|---|---|---|
| **`I-1`** | Register scan matched **any** `` `XXX-YYY-nnn` `` token, counting *cited foreign* identifiers (`LCM-RM-023`, `TSF-INV-005`) as **declarations of the host document** | Reported `SGR-RM` "gaps `[1,2,3,4,5,7,…]`" and 12 false non-contiguous registers. **Re-run own-stem-only: all 56 registers contiguous `001..max`** |
| **`I-2`** | AC-row anchor required `` `ID` `` as the first cell token, and citation parsing did not expand the `X/Y` shorthand | Reported **11 unmapped ACs** and **B2 = 27 rows**. Truth: `SSF-AC-028` carries a leading `⛔`; the 11 rows cite `SGR-FR-004/005`-style pairs. **Corrected: 90/90 ACs cite a requirement; B2 has 28** |
| **`I-3`** | Exclusion-prohibition scan read only the identifier's own line | Flagged 7 `XC` lines as lacking a prohibition. All 7 carry **`⛔ MUST NOT`** on the same or next line. **0 real** |

> Recorded because a review that reports only what its first instrument returned is a review of its instrument. `PRD-021A`'s Stage 4 disclosed six such defects; this is the same discipline.

---

## 7. Verification

| Item | Method | Result |
|---|---|---|
| Subjects unedited | `sha256sum` before and after | ✅ `69dae44e5c8f99fa` · `503c804504f2d04e` · `7339862f8cf9fc11` · `a3ccec3de060144e` — **byte-identical** |
| Predecessor unedited | `sha256sum` vs `HEAD` | ✅ **UNCHANGED** — retained in place |
| Rank 1–5 unchanged | `sha256sum` vs `HEAD` blob, 12 files | ✅ BC Map · Dep. Matrix · EA · `MASTER_PRD` · `PRD-020` · `Student_Identity_PRD_v1` · baseline · lifecycle · registry · matrix · ADR-INDEX · `module_dependencies.yaml` |
| No ADR created | `ls docs/00-governance/adr/` | ✅ highest is **`ADR-0087`**; `ADR-0088`…`0092` **do not exist** |
| No edge created | BC Map §7 diff | ✅ `E-01`…`E-26`, `E-28`, `E-29`; `E-27` vacant. **0 added** |
| No `BC-` minted | context count | ✅ **31 (23 in V1)** unchanged |
| Repository checks | `tool/docs_check/*.py` | ✅ **25 PASS / 6 FAIL** — identical to baseline `88f9562`; no regression |

---

## 8. Verdict

✅ **STAGE 3 — PASS. 6 of 6 checks. Gate SATISFIED and CONFERRED across B0, B1, B2, B3.**

| Part | Stage 3 |
|---|---|
| **B0** | ✅ **PASS** — `C-3` is an authority addition, not a defect; its ✅ was right |
| **B1** | ✅ **PASS** |
| **B2** | ✅ **PASS** |
| **B3** | ✅ **PASS** — blocker **DISSOLVED**; `C-1`/`C-2` carried to Stage 4 as citation corrections |

**`FOD-1`** ⛔ OPEN (ARB) · **`FOD-2`** ⛔ OPEN (ARB) · **`FOD-3`** ⛔ OPEN (ARB) · **`FOD-4`** ⛔ OPEN (ARB). None blocks Stage 3: `SGR-DM-010` defers `FOD-1`; `SSF-DM-009` gates `FOD-2` with a declared degraded ship mode.

⛔ **This record confers Stage 3 only.** It does not approve, freeze, baseline, register, allocate `IMPL-*`, or authorise Stage 5. **0 identifiers minted · 0 requirements written · 0 subject bytes changed · 0 files under `lib/`, `test/`, `tool/`, `web/`.**

---

**END — `PRD-021B` Stage 3 Resolution and Re-Review.**
