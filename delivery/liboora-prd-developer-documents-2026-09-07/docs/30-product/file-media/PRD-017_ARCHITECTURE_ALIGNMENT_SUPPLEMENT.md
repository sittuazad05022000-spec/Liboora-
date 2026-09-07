# PRD-017 File & Media — Stage 3 Architecture Alignment Supplement

| Field | Value |
|---|---|
| **Subject** | [`PRD-017_FILE_AND_MEDIA.md`](./PRD-017_FILE_AND_MEDIA.md) **v0.1** |
| **Subject hash re-measured** | ``4ebf5d07ecbbdf43f57fa5a63676995f34faa81931fdba5b7bdb42bcfc03d4e8`` — 135,999 bytes, 1,690 lines. **The current bytes** |
| **Base record** | [`PRD-017_ARCHITECTURE_ALIGNMENT.md`](./PRD-017_ARCHITECTURE_ALIGNMENT.md), which measured ``85adb6fa85fa687743992fe377ffa7652af5b4a625107efb2c2e9031dd1cb44e`` |
| **Why this record exists** | The base record's verdict was measured against **superseded bytes**. Stage 4 then edited the subject, twice. A Stage 7 freeze that cited a stale alignment verdict would be citing a review of a document that no longer exists |
| **Stage** | **3 of 9 — Architecture Review, re-run.** This record runs the same six checks against the current bytes. It runs **no other stage** |
| **Authority** | [`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md) §3 Stage 3 — six checks against Ranks 1–5 |
| **Precedent** | [`PRD-008_ARCHITECTURE_ALIGNMENT_V17_SUPPLEMENT.md`](../revenue-finance/PRD-008_ARCHITECTURE_ALIGNMENT_V17_SUPPLEMENT.md) and [`PRD-013_ARCHITECTURE_ALIGNMENT_SUPPLEMENT.md`](../tenancy/PRD-013_ARCHITECTURE_ALIGNMENT_SUPPLEMENT.md) — the two prior cases where a base record's hash went stale and the response was a supplement rather than a rewrite |
| **Status of this record** | **Unranked.** It confers nothing. Read **jointly** with the base record |
| **Version** | v1.0 · 2026-08-20 |

> ⚠ **The base record is NOT rewritten, and its stale hash is NOT repaired.** `ADR-0018` §3.4 and `ADR-0019` §3.6
> hold that independently verified bytes are preserved rather than tidied; `PRD-013`'s supplement states the reason
> most directly — *"rewriting its hash would make it claim a review that did not happen."* The base record
> correctly describes a review of `85adb6fa…`. This record describes a review of `4ebf5d07…`. Both are true.

> ⚠ **This supplement was written because a measurement contradicted an assumption, not because a rule demanded it.**
> The Stage 5 conferral record states that all gate records were reviewed at `ac65fc6`, and it was tempting to infer
> from `PRD-016`'s and `PRD-023`'s precedent — *"all five gate records measured the identical hash, so no supplement
> was required and none was written"* — that the same held here. It does not. The hashes were **extracted and
> compared** (§1.1) and they differ. Inheriting the convenient half of a precedent is the failure mode the
> `PRD-008` supplement's own existence records.

---

## 1. The staleness, measured

### 1.1 Every hash citation in every PRD-017 gate record, extracted

| Record | Hash cited | Against current `4ebf5d07…` |
|---|---|---|
| `PRD-017_ARCHITECTURE_ALIGNMENT.md` L6 | `85adb6fa…cb44e` | ⛔ **STALE** |
| `PRD-017_STAGE4_REQUIREMENTS_REVIEW.md` L10 *(before review)* | `880de96e…ac2d6` | ⛔ **STALE** |
| `PRD-017_STAGE4_REQUIREMENTS_REVIEW.md` L11 *(after review)* | `202ccf5e…9705e` | ⛔ **STALE** |
| `PRD-017_STAGE5_CONFERRAL.md` L13 | `4ebf5d07…d4e8` | ✅ **CURRENT** |
| `PRD-017_IMPLEMENTATION_TASKS.md` | *no hash cited* | — (nothing to be stale) |

**So this is the `PRD-008` / `PRD-013` case, not the `PRD-016` / `PRD-023` case.** Three of four cited hashes are
superseded. The Stage 4 record's staleness is **self-disclosed** — it says in its own §2 that it edited its subject
— and needs no supplement, because a review that reports its own before-and-after hashes is not claiming to have
reviewed the after-bytes. **The base Stage 3 record is different**: it asserts a verdict over bytes that have since
changed, and says nothing about the change, because the change had not happened yet.

### 1.2 The full lineage of the subject, reconstructed from git

| Commit | Subject hash | Stage that produced it |
|---|---|---|
| `5bfa17b` | `f0fe329d…` | Stage 2 drafting |
| `a573c45` | `acda171c…` | Stage 2 drafting |
| `d54dc02` | `af1560e8…` | Stage 2 drafting |
| `3b19717` | `09b37cb9…` | Stage 2 drafting |
| `b3516bf` | **`85adb6fa…`** | ⭐ **the bytes the base Stage 3 record reviewed** |
| `d66fb75` | `880de96e…` | Stage 4 entry |
| `60a49b7` | `97665dc3…` | Stage 4 repairs in progress |
| `ac65fc6` | **`4ebf5d07…`** | ⭐ **current — Stage 4 complete + `S5-D-01`** |

Eight distinct states, all captured by platform auto-backup commits (§5). The gap this supplement closes is
`b3516bf` → `ac65fc6`.

### 1.3 What actually changed between the two, measured rather than characterised

```
git diff --stat b3516bf HEAD -- docs/30-product/file-media/PRD-017_FILE_AND_MEDIA.md
  1 file changed, 89 insertions(+), 23 deletions(-)
```

Identifier-level diff, computed by extracting every `FIL-<REG>-<n>` from both revisions:

| Register | At `85adb6fa…` | At `4ebf5d07…` | Verdict |
|---|---|---|---|
| `FIL-FR-*` | 82 | 82 | **unchanged** |
| `FIL-BR-*` | 17 | 17 | **unchanged** |
| `FIL-INV-*` | 11 | 11 | **unchanged** |
| `FIL-EVT-*` | 0 | 0 | **unchanged — still empty** |
| `FIL-XC-*` | 22 | 22 | **unchanged** |
| `FIL-AC-*` | 76 | **78** | ⭐ **+2** |
| `FIL-CFG-*` | 9 | 9 | **unchanged** |
| `FIL-GAP-*` | 13 | 13 | **unchanged — all still OPEN** |
| **Distinct total** | **230** | **232** | **+2** |

**ADDED:** `FIL-AC-077`, `FIL-AC-078`. **REMOVED:** *nothing.*

> ⭐ **This is the finding that decides the supplement's verdict, and it is a narrow one.**
> **Every Class A register — `FR`, `BR`, `INV`, `EVT`, `XC` — is byte-for-byte identical in membership.** Stage 3
> tests *architecture*: ownership, edges, rank direction, authorisation, credentials, tenant scoping. Those are
> properties of the **obligation** registers and of the prose that bounds them. The drift is **two acceptance
> criteria**, which are *observations of* obligations, not obligations. So the base record's six verdicts are
> re-testable against the current bytes without re-deriving them from scratch — but they still have to be
> **re-tested**, not assumed, and §2 does that.

---

## 2. The six checks, re-run against `4ebf5d07…`

### 2.1 Check 1 — Context ownership is exclusive

| Test | Measured at `4ebf5d07…` |
|---|---|
| Aggregates claimed by `PRD-017` | **0.** The header's *"Owned aggregate"* cell still reads **NONE ASSERTED**; `FIL-GAP-001` still OPEN. BC Map §8 still lists 17 aggregate rows, `BC-29` among none of them |
| Aggregates claimed twice across PRDs | **0** |
| Ownership exclusions | **4**, still mapping 1:1 onto BC Map §8 rows |
| `FIL-FR-076`, the load-bearing ownership clause | **Present and textually unchanged.** Verified by locating it in both revisions |
| `PRD-021` requirement moved in or out | **0** |

✅ **PASS.** Unchanged from the base record, and re-measured rather than carried.

### 2.2 Check 2 — Every integration edge exists in BC Map §7

| Test | Measured at `4ebf5d07…` |
|---|---|
| Edges the PRD relies on | **7 verified present** in BC Map §7 |
| `E-22` consumer cell (BC Map **L331**) | Still `BC-01, BC-10, BC-14`. **`BC-12` still absent** |
| Edges added by the drift | **0.** No new `E-*` token appears in the +89 lines |
| Events minted by the drift | **0.** `FIL-EVT-*` is still empty in registration **and in fact** — enforced as check 7 of `prd017_stage5.py` |

⚠ **PASS WITH A RECORDED BLOCKING GAP — the identical gap, unchanged in scope.** `FIL-GAP-012` / blocker `B-11`
remain **OPEN**. The two new criteria `FIL-AC-077`/`FIL-AC-078` are observations of `FIL-FR-075`/`FIL-FR-076`/
`FIL-FR-080`/`FIL-BR-008`/`FIL-INV-010` — all of which existed at `85adb6fa…`. **Adding a criterion to an existing
obligation cannot create an edge**, and none was created.

### 2.3 Check 3 — Rank direction is downward

| Test | Measured at `4ebf5d07…` |
|---|---|
| Module path | `platform/services`, **rank 3** (`tool/module_dependencies.yaml` **L33**) |
| Declared consumer of `platform/services:files` | `domain/social` at **L242**, rank 8 → rank 3 |
| Direction | **downward.** `L2`, `L3` satisfied |
| `check_module_boundaries.dart` baseline | **byte-identical** to the pre-`PRD-017` baseline: `FAIL — 9 violation(s) in 1 category(ies)`, `■ cross-context (9)`, `□ ACKNOWLEDGED DEBT — 28 finding(s) across 12 edge(s)`. **`PRD-017` introduced 0 new findings** |
| Manifest lines changed by this module, in any span | **0** |

✅ **PASS.**

### 2.4 Checks 4 and 5 — Authorisation, credentials, OTP, session

| Test | Measured at `4ebf5d07…` |
|---|---|
| Authorisation decisions taken inside `BC-29` | **0.** Every access path delegates; the decision is per-request, never cached, never inferred |
| Requirements holding a credential, OTP or session | **0** |
| Does the drift weaken this? | **No — it strengthens it.** `FIL-AC-077` is precisely an observability criterion **for** the delegation rule: *"A stored grant carries the eligibility-decision reference it was given, byte-for-byte as supplied, and the module derives, recomputes or substitutes no reference of its own."* That is `X-13` made testable |

✅ **PASS both.** ⭐ Worth recording plainly: the drift's net architectural effect on the checks Stage 3 cares
most about is **positive**. `FIL-AC-077` converts an `X-13` prohibition from a stated rule into an observable one.

### 2.5 Check 6 — Tenant scoping, against frozen `PRD-013`

| Test | Measured at `4ebf5d07…` |
|---|---|
| `TEN-FR-018` (`PRD-013` **L204**) — no `tenant_id` in a global context | **upheld.** `S3-A-02`'s resolution stands: `BC-29` **propagates** an owner's key rather than originating one |
| `TEN-AC-014` (`PRD-013` **L343**) — a global-context row carries no `tenant_id` column at all | **upheld** |
| BC Map L488 / L490 reconciliation | **unchanged.** `BC-10`, a global context with no `tenantId`, is an accepted `E-22` consumer via `ADR-0016`; a global-class shared study document is that existing case with a different owning context, not a new isolation model |
| Frozen `PRD-013` bytes touched | **0** |

✅ **PASS.**

---

## 3. Verdict

| Check | Base record at `85adb6fa…` | This supplement at `4ebf5d07…` |
|---|---|---|
| 1 — Context ownership exclusive | ✅ PASS | ✅ **PASS** |
| 2 — Every edge exists in §7 | ⚠ PASS WITH RECORDED BLOCKING GAP | ⚠ **PASS WITH RECORDED BLOCKING GAP** — identical gap, identical scope |
| 3 — Rank direction downward | ✅ PASS | ✅ **PASS** |
| 4 — No authorisation outside `BC-18` | ✅ PASS | ✅ **PASS** — and now observable, `FIL-AC-077` |
| 5 — No credential/OTP/session | ✅ PASS | ✅ **PASS** |
| 6 — Tenant scoping correct | ✅ PASS | ✅ **PASS** |

### **STAGE 3 VERDICT AT `4ebf5d07…`: PASS — CONDITIONAL**

**6 of 6 checks pass. The condition is unchanged, and is restated in full rather than cross-referenced:**

> ⛔ **The V1 student-to-student sharing capability is architecturally sound, correctly bounded, and NOT SERVABLE.**
> It cannot be implemented until `E-22`'s consumer cell (BC Map **L331**) admits **`BC-12`** by an ADR authored by
> the **Architecture Owner**. Every other capability in `PRD-017` is unaffected and fully aligned.

**The verdict did not move, and that is a measured result rather than a convenience.** Had the drift touched a
Class A register, an edge token, an aggregate claim or a tenant-scoping clause, this record would say so and the
verdict would be re-derived from scratch. It touched **two acceptance criteria and nothing else**.

> ⚠ **`FIL-GAP-012` / `B-11` is NOT closed by this supplement, and no supplement could close it.** Re-measuring an
> alignment does not amend a BC Map cell. Whether the freeze may proceed while it is OPEN is a **Stage 7** question,
> answered against the `ATT-GAP-010` precedent (`PRD-006` **L1564**, **L2973** — a PRD reached FROZEN carrying an
> OPEN `E-22` consumer gap), not by this record.

---

## 4. What this supplement deliberately does not do

- **Does not rewrite, correct or delete the base record**, or repair its stale hash. It is preserved verbatim as
  evidence of a review that genuinely happened against genuinely different bytes.
- **Does not amend `E-22`**, any BC Map cell, any port, or the manifest. **0 edges, 0 cells, 0 ports, 0 ADRs.**
- **Does not edit the subject.** `4ebf5d07…` is unchanged by this record — re-verified at close.
- **Does not close a single `FIL-GAP-*`.** All **13** remain **OPEN**.
- **Does not confer rank, status or freeze.** Unranked; freeze is conferred by a `DOCUMENTATION_BASELINE.md` §3 row.
- **Does not upgrade the verdict from CONDITIONAL to unconditional.** The condition is external to the subject and
  cannot be discharged by re-reading the subject.
- **Does not re-run Stage 4, 5 or 6.** Their records stand on their own hashes.
- **Contains no code, no SQL, no schema.**

---

## 5. Disclosure — platform auto-backup commits

Ten commits authored **"Sittu Azad <sittuazad05022000@gmail.com>"** with the message **"genspark auto-backup"**
were created by the platform, not by this work, during the `PRD-017` lifecycle:

`5bfa17b` · `a573c45` · `d54dc02` · `3b19717` · `b3516bf` · `d66fb75` · `60a49b7` · `5def4a9` · `ac65fc6` · `8a05f35`

**No commit and no push was issued by this pass.** `github/main` remains at `a7f5fc8`. Five of these commits are
what made §1.2's lineage reconstructible, so they are disclosed as evidence as well as for honesty.

---

## 6. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-20 | Created. Six Stage 3 checks re-run against `4ebf5d07…` after §1.1 measured that **three of four** cited gate-record hashes were stale — a fact assumed away until it was extracted and compared. Verdict **PASS — CONDITIONAL, 6 of 6**, unchanged, with the drift measured as **+2 `FIL-AC-*` and nothing else** and every Class A register proven identical in membership. Base record preserved verbatim, stale hash **deliberately unrepaired** on the `PRD-008`/`PRD-013` precedent. **0 edges, 0 cells, 0 ports, 0 ADRs, 0 gaps closed, 0 subject bytes changed.** Ten platform auto-backup commits disclosed |
