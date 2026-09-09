# ADR-0128 — R3: `BC-18 Identity & Access` → `BC-31 Integration` is the V1 OTP transport, edge **`E-33`**

| Field | Value |
|---|---|
| **ADR** | `ADR-0128` — ⭐ **next free, measured immediately before creation**: 115 files, max identifier `ADR-0127`, `ADR-0128` referenced **0** times in `docs/` or `tool/` |
| **Status** | ⭐ **Accepted** — 2026-09-09 |
| **Deciders** | ⭐⭐ **Architecture Owner + Product Owner, JOINTLY, as ONE act.** Two offices because the act has two limbs: the **route** is Architecture's (`PRD_OWNERSHIP_MODEL.md` **L85** — *"Boundaries, ranks, permitted edges … any Rank 1–5 document change"*) and the **classification** of OTP SMS is Product's (**L83**) — the `ADR-0011` precedent. Conferred first-person and affirmatively as **AO-1, AO-2, AO-3, AO-4** and **PO-1** |
| **Supersedes** | — |
| **Amends** | ⭐ **`LIBOORA_BOUNDED_CONTEXT_MAP.md` (Rank 4) — EXECUTED, see §7.** New **§19** appended declaring **`E-33`**; header `Version` and `Context Count` cells updated in place; one changelog row inserted newest-first. ⛔ **§1–§18 byte-unchanged.** ⚠ **`IMPL-020_ARCHITECTURE_OWNER_DECISION_PREPARATION.md` (Unranked) — EXECUTED, see §7** (L63 and §1.3). ⚠ **`PRD-021A_STAGE4_AC_REQUIREMENT_MAPPING_2026-09-01.md` — EXECUTED, see §7**: the **R2 citation repair necessitated by this amendment**, `L652 → L653`, under **Ruling 2 option (i)** |
| **Amended by** | — |
| **Baseline** | ⛔ **No baseline re-issue.** `DOCUMENTATION_BASELINE.md` §7 rule 4 moves the identifier only when a **Rank 1–3** document changes version. The BC Map is **Rank 4**; `IMPL-020` and the `PRD-021A` mapping are **Unranked records**. **`BASELINE-2026-09-03-A` STANDS** |
| **Closes** | ⭐ **R3** — the OTP-SMS transport-ownership question opened by `ADR-0126` §5.1 · the `BC-18 → BC-31` **edge gap** |
| **Does NOT close** | ⛔⛔ **`BLK-01` · `BLK-02` · `IMPL-020` · `TASK-D10` · `MP-DEP-03`** · ⛔ D3/SMS provider · ⛔ DLT/H1–H3 · ⛔ Gate 3 · ⛔ `T-29` · ⛔ `NTF-AL-F2` · ⛔ `TSF-GAP-009` |
| **Related** | `ADR-0126` (D2 split; §5.1 opened R3) · `ADR-0127` (`E-32`, ⛔ **not reopened**) · `ADR-0035` (the `Amends: Nothing` ratification precedent, **tested and found not to apply** — §3.3) · `ADR-0055`, `ADR-0016`, `ADR-0095` (the executed one-cell edge precedents) · `ADR-0107`, `ADR-0096` (the **append** precedents) · `ADR-0014` (the *read-the-manifest* method) · `MASTER_PRD.md` **L229** · FROZEN `PRD-001` **`AUTH-3.5`**, **`AUTH-3.8`**, **`AUTH-3.12`**, **`AUTH-10.37`** · `PRD-010` **N7**, **`NTF-FR-030`**, **`NTF-FR-031`**, **`NTF-FR-039`** · BC Map **L127**, **L131**, **L140**, **L292** · `tool/module_dependencies.yaml` **L437–439** |

> ⭐⭐⭐ **THE METHOD WAS `ADR-0014`'S: read the manifest that already existed.** The lawful OTP route was
> **not designed here**. It has been declared in `tool/module_dependencies.yaml` since **`a2caa22`** — the
> commit that created the BC Map and the Dependency Matrix — as *"the single sanctioned bypass of
> `platform/communication`, **for possession challenge delivery only**."* `IMPL-020` §1.3 never read it.

---

## 1. Context — the conflict this resolves

`ADR-0126` §5.1 recorded that `IMPL-020` §1.3's assumed OTP route `BC-18 → BC-22 → BC-31` is
**contradicted** by authorities that outrank it, and left the true owner **UNDECIDED**. That is R3.

### 1.1 Why the assumed route is unlawful — four authorities

| Authority | Rank / status | Verbatim |
|---|---|---|
| **`AUTH-10.37`** | 3, **FROZEN** | *"The OTP itself MUST NOT be treated as a notification and **MUST NOT pass through any general notification path**"* |
| **`PRD-010` §5 N7** | 3, **baselined** (`ADR-0111`) | *"OTP generation **and OTP SMS delivery**"* — **excluded** from `BC-22` |
| **`NTF-FR-030`** | 3, baselined | *"V1 integrated channels are **exactly** In-App and Push"* |
| **`MP-GBR-35`** + **`NTF-FR-039`** | 1 + 3 | Quiet hours apply to *"every channel"* and *"**MUST defer, never drop**"* |

⭐⭐ **The fourth is the functional reason, not a formality.** A deferred OTP **expires**: `AUTH-3.8`
fixes challenge validity at **5 minutes**. Routing OTP through the general notification path would
**break** the authentication factor. `AUTH-10.37` is protective.

### 1.2 Why `AUTH-3.5` does not require the `BC-22` route

`AUTH-3.5` reads: *"Authentication **MUST NOT** implement message transport. It **MUST** request
delivery from Notification…"*. ⭐ **Its prohibition is on *implementing transport*, and that
prohibition is fully honoured here**: `BC-18` calls a **port**; `BC-31` owns *"outbound third-party
contracts, credentials, retries, idempotent delivery"* (BC Map **L140**) and performs the transport.
⚠ **Calling a port is not implementing transport** — that is the same distinction `MP-CON-03` and the
whole port doctrine rest on.

---

## 2. Decision

### 2.1 `AO-1` — the V1 OTP transport is `BC-18` → `BC-31`

**`BC-18 Identity & Access` → `BC-31 Integration` is RATIFIED as the V1 OTP / possession-challenge
transport**, over the **already-existing** `platform/identity → platform/integration:sso_provider`
grant. ⛔ **OTP MUST NOT enter the `BC-22` general notification path.**

Preserved **without weakening**, each tested individually:

| Rule | Status after this ADR |
|---|---|
| **`AUTH-3.5`** | ✅ **Satisfied** — Authentication calls a port; `BC-31` implements transport (§1.2) |
| **`AUTH-10.37`** | ✅ **Preserved** — OTP never enters the general notification path |
| **`PRD-010` N7** | ✅ **Preserved and CONFIRMED** — `BC-22` gains nothing |
| **`NTF-FR-030`** | ✅ **Preserved** — V1 channels remain exactly In-App and Push |

### 2.2 `AO-2` — `sso_provider` is accepted AS-IS for V1

⭐ The existing port name is **accepted as-is**. ⛔ **NOT renamed. NO sibling port added. The manifest
is BYTE-UNCHANGED by this ADR.**

⚠ **The naming concern is recorded as a documented future architecture consideration**, not resolved:
the port carrying the OTP is named `sso_provider`, while its own comment scopes it to *"possession
challenge delivery only"* — the name does not describe the function. ⛔ No owner, no date and no
obligation is attached, because none was conferred.

### 2.3 `AO-3` — `E-33` is allocated and minted

| Identifier | Upstream | Downstream | Pattern | Mechanism | Release |
|---|---|---|---|---|---|
| **`E-33`** | **BC-18 Identity & Access** | **BC-31 Integration** | **`CF`** | **Sync port** | **V1** |

⭐ `CF` + Sync port is **copied from `E-25`** (`BC-20 Billing → BC-31`, **L334**), the existing
capability→integration edge. ⛔ **No new integration pattern is introduced.**

⛔⛔ **`E-27`, `E-31` and `E-32` were PROHIBITED and are untouched** — see §4.

### 2.4 `AO-4` — executed through this ADR, bundled

The BC Map amendment is **executed here**, bundling the three pending matters into one controlled act:
**R1** (`E-32`, `ADR-0127`), **R2** (the `PRD-021A` citation), **R3** (`E-33`). See §5 for what
bundling did and did **not** mean.

### 2.5 `PO-1` — OTP SMS is transactional authentication delivery

**OTP SMS is transactional authentication delivery, NOT general notification.** ⭐ This **confirms**
`PRD-010` **N7**, `AUTH-10.37` and `NTF-FR-030`; it ⛔ **does not override any of them**, and **no
amendment to any of the three is required or made**.

---

## 3. Evidence

### 3.1 The grant already existed — and is original

`tool/module_dependencies.yaml` **L437–439**, verbatim:

```yaml
    # The single sanctioned bypass of platform/communication, for possession
    # challenge delivery only. Matrix cell IAM -> INT.
    - platform/integration:sso_provider
```

⭐⭐ **Traced to origin, not assumed:** `git log -S "sso_provider" -- tool/module_dependencies.yaml`
returns **`a2caa22`** — *"add Bounded Context Map v1.0 + Module Dependency Matrix v1.0"* — plus
`7a0bb0d`, which merely **enumerated** it in the `platform/integration` block created by `ADR-0126`
D2-A. The grant is **as old as the architecture itself** and predates `IMPL-020` by months.

### 3.2 Rank-4 corroboration — the Matrix already permits IAM → INT

| Measurement | Result |
|---|---|
| Matrix grid **L137**, row `R4 IDENTITY & ACCESS`, column `INT` | **`◇`** — **port allowed** |
| Matrix grid **L145**, row `R8 LIBRARY MANAGEMENT`, column `INT` | **`✖`** — forbidden |
| Matrix **L167** narrative | *"`LIBRARY MANAGEMENT` → `INTEGRATION` \| `✖`"* |
| **`X-03`** (**L352**) | forbids **`domain → INTEGRATION`** |

⭐⭐ **`X-03` is not engaged.** It bans the **rank-8 domain** from reaching Integration. `BC-18` is
`platform/identity`, **rank 4** — a platform, not a domain — and its cell is `◇`. ⚠ This ADR
**neither weakens nor reinterprets `X-03`**; it observes that `X-03` never applied.

### 3.3 ⚠⚠ The `Amends: Nothing` question was TESTED, and the answer is NO

⭐ **This was checked rather than assumed, and the intuitive answer was wrong.** `ADR-0035` is the
nearest precedent — `Supersedes / amends: **Nothing**` — ratifying the payment chain to a vendor. Its
own reasoning is why it **does not transfer**:

> *"the chain is complete at module level … `domain/library` → `platform/business` (L119) →
> `platform/integration` (L409) → vendor. Every hop is authorised. **No edge is missing anywhere
> along it.**"*

⛔ **That last clause fails here.** For payments the context-level edge **`E-25` exists**. For OTP,
`grep "BC-18.*BC-31"` in the BC Map returned **0 rows**, and **L292** rules: *"If an edge is not in
this table, it **does not exist** and adding it requires an ADR."*

⇒ ⭐ **This is the `ADR-0016` / `ADR-0055` / `ADR-0095` defect class** — a module-grained grant beside
a silent context-grained register — and **all three of those precedents amended the BC Map.** So does
this one. **`Amends: Nothing` would have been false.**

---

## 4. Identifier hygiene — three numbers prohibited, and why

| Identifier | Disposition |
|---|---|
| **`E-27`** | ⛔ **Permanently vacant.** Minted by `ADR-0032`, withdrawn by `ADR-0033`; `PRD_LIFECYCLE.md` §5 rule 5 — *"Numbers are never reused, even after withdrawal."* **Untouched** |
| **`E-31`** | ⛔ **RESERVED and untouched.** `PRD-021C` **C8 §13** routes it to the `BC-13 → BC-19` referral transport (`TSF-GAP-009`, blocking `IMPL-1424`). ⛔ **Not reassigned, not consumed, not minted** |
| **`E-32`** | ⛔ **ALLOCATED to `BC-22 → BC-31` (Push/FCM) by `Accepted` `ADR-0127`.** ⛔ **`ADR-0127` is NOT reopened, NOT superseded, NOT amended** |
| **`E-33`** | ⭐ **ALLOCATED HERE.** Occupancy verified **twice** — at conferral preparation and **again immediately before minting**: **0** references across `docs/`, `tool/`, `test/`, `lib/`, `.github/` and **0** BC Map rows. AO-3's stop-condition was **not** triggered |

⚠ **A false positive was caught during the occupancy sweep and is recorded rather than hidden.** An
early scan reported `E-31` with *"declared_rows=1"*, apparently contradicting its reserved status. On
inspection it is `ADR-INDEX.md` **L890**, a **prose cell stating that `E-31` is reserved** — the
pattern `^| E-` matches any table row, not only edge-register rows. ⭐ **The BC Map count for `E-31`
is and remains 0.** No contradiction existed; the instrument was imprecise.

---

## 5. ⚠ What "bundling" did — and the one thing it did NOT do

`AO-4` authorised bundling R1, R2 and R3 into one controlled execution. **Executed faithfully, with one
limit disclosed:**

| Matter | Action taken here |
|---|---|
| **R3** — `E-33` `BC-18 → BC-31` | ✅ **Minted** in the new §19 |
| **R2** — the `PRD-021A` citation | ✅ **Repaired `L652 → L653`**, in this same commit, per **Ruling 2 option (i)** |
| **R1** — `E-32` `BC-22 → BC-31` | ⛔ **NOT minted.** See below |

⭐⭐ **`E-32` was deliberately NOT written into the BC Map, and this is a narrowing, not an omission.**
`ADR-0127` §1 states its own execution condition: *"the allocation is approved now, but **BC Map
registration/mint is deliberately deferred to M2**."* Minting `E-32` here would **execute `ADR-0127`'s
deferred M2 step** — an act this conferral did not confer and which `ADR-0127` expressly reserved.
⛔ **Widening scope to mint it would be exactly the silent scope-widening the instruction forbids.**

⚠ **Consequence, stated plainly:** the bundle achieved **one controlled append and one changelog row**
covering R2 and R3. **M2 for `E-32` remains HELD**, and a later act must still mint it.

### 5.1 The citation shift, measured before the write

| Measurement | Value |
|---|---|
| BC Map line-citations repo-wide | **22 distinct lines**, L100 → **L652** |
| Changelog header | **L609** |
| Citations **below** L609 | exactly **one** — **L652** |
| Who cites L652 | `PRD-021A_STAGE4_AC_REQUIREMENT_MAPPING_2026-09-01.md` **L524**, for *"28 edges"* |
| Was L652 correct before this act? | ✅ **YES** — verified live; R2's earlier `L649 → L652` repair was accurate |

⭐ Inserting the changelog row newest-first at L611 shifts **L652 → L653** — and **only** that one
citation. It is repaired in the **same commit** per Ruling 2 (i). ⛔ The alternative — appending the
changelog row out of order — was **refused** by Ruling 2, and the established **newest-first** ordering
is preserved.

⭐ **The §19 append itself shifts 0 citations**: it lands below §18, which ends at the former L1070.

---

## 6. What this ADR does NOT do

- ⛔ **Does not rename `sso_provider` or add a sibling port.** `tool/module_dependencies.yaml` is **BYTE-UNCHANGED**
- ⛔ **Does not mint `E-32`**, and ⛔ **does not reopen, supersede or amend `ADR-0127`**
- ⛔ **Does not touch `E-27` or `E-31`**
- ⛔ **Selects no SMS provider (D3)**, performs **no DLT registration (H1–H3)**, mints no `AERR-*`
- ⛔ **Writes no code.** `lib/`, `test/`, `tool/` untouched — a route is **not** a delivery path
- ⛔ **Does not touch `TASK-D10`, `BLK-01` or Gate-3 remediation**
- ⛔ **Amends no frozen PRD and no Rank 1–3 artefact.** `MASTER_PRD.md`, `PRD-001`, `PRD-006`, `PRD-010`, `PRD-012a`, `Student_Identity_PRD_v1.md` are **byte-unchanged**. ⚠ The **only** Rank-adjacent edit is the **expressly authorised** `PRD-021A` **citation repair**, which changes a line **number**, not a requirement
- ⛔ **Confers no lifecycle stage** and closes no acceptance criterion
- ⛔ **Grants no standing authority** — both offices revert on acceptance (`ADR-0033` §7.1); no person is named

---

## 7. Migration requirements — ⭐ **EXECUTED 2026-09-09**

| # | Change | Document | Rank | State |
|---|---|---|---|---|
| **M1** | Append **§19** declaring **`E-33`** `BC-18 → BC-31` (`CF`, Sync port, V1) | `LIBOORA_BOUNDED_CONTEXT_MAP.md` | **4** | ✅ **DONE** — append below §18; **0** citations shifted by the append |
| **M2** | Header `Version` **v1.12 → v1.13**; `Context Count` cell updated **in place** (edges **29 → 30**) | same | **4** | ✅ **DONE** — L6 and L9 edited in place |
| **M3** | One changelog row, **newest-first**, at the head of the changelog table | same | **4** | ✅ **DONE** — shifts exactly **one** citation, L652 → L653 |
| **M4** | **R2 citation repair** `L652 → L653`, necessitated by M3 | `PRD-021A_STAGE4_AC_REQUIREMENT_MAPPING_2026-09-01.md` | record | ✅ **DONE** — same commit, Ruling 2 (i) |
| **M5** | Correct **L63** (the false *"`BC-18` may not call an SMS provider at all"*) and **§1.3** (the `BC-18 → BC-22 → BC-31` route) | `IMPL-020_ARCHITECTURE_OWNER_DECISION_PREPARATION.md` | Unranked | ✅ **DONE** — prior text retained verbatim |
| **M6** | Register this ADR | `ADR-INDEX.md` | — | ✅ **DONE** |
| **M7** | `IMPL-020` version **v1.1 → v1.2** + changelog row (§7 rule 2) | same | Unranked | ✅ **DONE** |

### 7.1 ⚠⚠ A citation cost was incurred in `IMPL-020`, and a false claim about it was caught and corrected

⛔ **M5 did NOT achieve zero citation shift, and a draft of `IMPL-020`'s own changelog row wrongly said it did.**
Post-write verification falsified that claim, and **the claim was rewritten rather than left standing**.

| Citation | Before | After | Cited by |
|---|---|---|---|
| *"MSG91 unblocks **nothing**"* | **L159** | **L176** | `IMPLEMENTATION_BLOCKER_REGISTER.md` |
| *"does **not** select Supabase"* | **L185** | **L202** | `ADR-0116` §2.2 · `ADR-0124` §1.2 |
| *"Supabase is **not** chosen"* | **L280** | **L297** | `ADR-0116` §2.2 · `ADR-0124` §1.2 |

⭐ **L63 itself shifted 0 lines** — it was edited strictly in place. The **+17** shift comes from §1.3, where
superseding a six-line diagram *while retaining the original verbatim* necessarily adds lines. ⭐ **The cited
SENTENCES are byte-unchanged and remain true of the document**; only their line numbers moved, so
`ADR-0116` and `ADR-0124` remain substantively correct.

⛔ **The three stale line numbers are NOT patched here.** `ADR-0116` and `ADR-0124` are `Accepted` ADRs
outside this conferral, and editing them would be exactly the silent scope-widening the conferral forbids.
⚠ **Recorded as a follow-up for the Architecture Owner**, in the same shape as the R2 repair — a named hole,
not an improvised fix (`ADR-0045` §3).
| — | ⛔ Mint `E-32` | `LIBOORA_BOUNDED_CONTEXT_MAP.md` | 4 | ⛔ **NOT DONE** — `ADR-0127` defers it to M2 (§5) |

**Not required:** no baseline re-issue (Rank 4 / Unranked, §7 rule 4); no `lib/` file; no checker
change; no test change; no manifest change.

---

## 8. Compliance

| Rule | Status |
|---|---|
| `DOCUMENTATION_BASELINE.md` §7 **rule 1** — ADR **before** a Rank 1–5 change | ✅ This ADR was written and accepted **before** M1–M3 were applied |
| §7 **rule 2** — version + changelog in the same commit | ✅ **v1.13** and its changelog row are in this commit |
| §7 **rule 3** — declaration updated in the same commit | ✅ `Context Count` cell updated with the edge |
| §7 **rule 4** — baseline moves only for Rank 1–3 | ✅ **Unmet limb** — BC Map is Rank 4. **`BASELINE-2026-09-03-A` STANDS** |
| BC Map **L292** — an unlisted edge requires an ADR | ✅ This is that ADR |
| `ADR-0033` §7.1 — one act is not a standing licence | ✅ Scope is AO-1…AO-4 + PO-1 **only**; `E-32` mint, `sso_provider` rename, D3, DLT and `TASK-D10` all refused |
| `ADR-0045` §3 — *"a named hole is honest; an invented contract is not"* | ✅ No provider, credential, endpoint or DLT identifier invented |
| `SID-4.56` — an unverifiable claim is unmet, not satisfied | ✅ `E-33` occupancy verified **twice**; the `E-31` false positive disclosed |

---

## 9. Consequences

⭐ **R3 removes the last architectural unknown on the OTP path.** Everything remaining is **external**
(DLT/H1–H3) or **implementation**.

⛔⛔ **It creates NO actual SMS delivery path**, and nothing downstream moves:

| Item | State |
|---|---|
| `BLK-01` | **P0 / OPEN** — unchanged |
| `TASK-D10` | **blocked** — a route is not a delivery path |
| Gate 3 | **red** — 9 unwaived `app → domain/library`, `ADR-0012` §3.4 |
| `BLK-02` | **OPEN** — D3 provider and DLT both outstanding |
| `MP-DEP-03` | **External**, unstarted |
| M2 for `E-32` | **HELD** (§5) |

---

## 10. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-09 | Created and **Accepted** under a joint one-act **Architecture Owner + Product Owner** conferral (**AO-1**…**AO-4**, **PO-1**). ⭐⭐ Ratifies **`BC-18` → `BC-31`** as the V1 OTP transport over the **pre-existing** `sso_provider` grant (`tool/module_dependencies.yaml` **L437–439**, traced to origin commit **`a2caa22`**), preserving **`AUTH-3.5`**, **`AUTH-10.37`**, **`PRD-010` N7** and **`NTF-FR-030`** unweakened. ⭐ Mints **`E-33`** (`CF`, Sync port, V1) by **append as §19**; **`E-27`/`E-31`/`E-32` prohibited and untouched**; `ADR-0127` **not reopened**. ⚠ **`Amends: Nothing` was tested against `ADR-0035` and REJECTED** — the BC Map edge was genuinely absent (**L292**), making this the `ADR-0016`/`ADR-0055`/`ADR-0095` class. ⚠ **`sso_provider` accepted AS-IS**; naming recorded as a future consideration; **manifest byte-unchanged**. ⚠ Changelog row shifts exactly **one** citation, **L652 → L653**, repaired in the **same commit** per Ruling 2 (i). ⛔ **`E-32` deliberately NOT minted** — `ADR-0127` defers it to M2, and minting it would widen scope. ⛔ **0** code/test/checker/manifest files; **0** frozen PRDs; **0** Rank 1–3 requirement changes; `TASK-D10`, D3, DLT/H1–H3 and Gate-3 untouched; **`BASELINE-2026-09-03-A` stands**. |
