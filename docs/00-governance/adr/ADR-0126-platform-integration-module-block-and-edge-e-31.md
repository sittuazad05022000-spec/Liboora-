# ADR-0126 — `IMPL-020` **D2**: declare the `platform/integration` module block (Gap A) and edge **`E-31`** `BC-22 → BC-31` (Gap B)

| Field | Value |
|---|---|
| **ADR** | `ADR-0126` — ⭐ **next free number, measured**: 113 files, max identifier `ADR-0125`, `ADR-0126` referenced **0** times in `docs/` outside the blocker register's *"left free"* notes, **0** times in `tool/` |
| **Status** | ⭐ **Accepted IN PART** — 2026-09-09. ⚠⚠ **SPLIT ON REVIEW.** **`D2-A` (Gap A) is ACCEPTED and EXECUTED** (M1). ⛔ **`D2-B` (Gap B) is HELD — NOT accepted, NOT executed**, because review falsified this ADR's own `E-31` availability measurement (§1.2, corrected below) and re-allocating the number is a **new** decision. See **§10**. *(Prior status, correct until this review: "⚠⚠ **Proposed** — 2026-09-09. ⛔ **NOT Accepted. NOT executed.**")* |
| **Date** | 2026-09-09 |
| **Deciders** | **Architecture Owner**, under a **one-act** conferral from the human principal scoped to *"Gap A + Gap B"* and nothing else. Declaring a module boundary and admitting a context edge are **structural** determinations, which `PRD_OWNERSHIP_MODEL.md` **L85** assigns to this office (*"Boundaries, ranks, permitted edges, precedence … any Rank 1–5 document change"*) |
| **Supersedes** | — |
| **Amends** | ⭐ **`tool/module_dependencies.yaml` (Rank 4) — ONE absent block added, by APPEND at END OF FILE** (M1, executed 2026-09-09; **0** of **49** line-citations shifted). ⛔⛔ **`LIBOORA_BOUNDED_CONTEXT_MAP.md` is BYTE-UNCHANGED** — M2 is **HELD**: no §19, no edge, no `Version` bump, no changelog row. ⛔ No PRD, no frozen document, no Rank 1–3 artefact |
| **Amended by** | — |
| **Baseline** | ⛔ **No baseline re-issue on acceptance.** `DOCUMENTATION_BASELINE.md` §7 rule 4 moves the identifier only for a **Rank 1–3** document changing version; both targets are **Rank 4**. The `ADR-0016`/`ADR-0055`/`ADR-0095`/`ADR-0107` precedents are identical. **`BASELINE-2026-09-03-A` stands** |
| **Closes** | ⭐ **`IMPL-020` Gap A — for `platform/integration` ONLY**, the narrow act §5.4 scoped. ⛔ **Gap B is NOT closed** |
| **Does NOT close** | ⛔⛔ **`BLK-01` · `BLK-02` · `IMPL-020` · `TASK-D10` · `MP-DEP-03`** · ⛔ **the OTP-SMS transport-ownership question (§5.1) — the principal finding of this ADR** · ⛔ Gap A for the **other six** modules · ⛔ **`T-29`** · ⛔ **`NTF-AL-F2`** · ⛔ `FIL-GAP-010` · ⛔ no SMS provider, DLT registration or `AERR-*` |
| **Related** | `IMPL-020` §1.4 (Gaps A/B), §3 (**D2**) · `ADR-0055` (the executed one-cell edge precedent) · `ADR-0016`, `ADR-0095` (same defect class) · `ADR-0107` (the §18 **append** precedent) · `ADR-0096` (the §17 **new-edge-by-append** precedent) · `ADR-0124` (**D1**) · `MASTER_PRD.md` **L229** (Rank 1) · `PRD-010` **`NTF-FR-031`**, **N7**, **`NTF-INV-005`** · BC Map **L131**, **L140**, **L292**, **L334** · `tool/module_dependencies.yaml` **L40**, **L288**, **L343**, **L397**, **L416**, **L439** |

> ⚠⚠ **READ §5.1 BEFORE §2.** This ADR repairs both gaps `IMPL-020` §3 named — **but not for the reason
> `IMPL-020` gave.** `IMPL-020` justified Gap B as the OTP delivery route `BC-18 → BC-22 → BC-31`.
> **That premise is contradicted by a Rank-3 baselined PRD.** The edge is nonetheless required, on an
> **independent and stronger** authority (Rank 1). The consequence is that **D2 does not unblock
> `BLK-01`**, and this ADR says so rather than letting the sequencing diagram imply otherwise.

---

## 1. Context — the two gaps, measured at `a9bc2f0`

### 1.1 Gap A — `platform/integration` is ranked but undeclared

| Measurement | Result |
|---|---|
| `platform/integration` in the `ranks:` map | ✅ **present** — `tool/module_dependencies.yaml` **L40**, rank **5** |
| A declaration block `platform/integration:` | ⛔ **ABSENT** — measured **0** |
| Modules ranked **with** a block | **13** of 20 |
| Modules ranked **without** a block | **7** — `infrastructure`, `data`, `security`, `configuration`, `observability`, `services`, `event`, and **`integration`** |
| Its ports consumed elsewhere | **4 distinct ports, 5 sites** — `connector` (**L343** `platform/workflow`, **L397** `platform/communication`), `payment_gateway` (**L416** `platform/business`), `model_provider` (**L288** `platform/ai`), `sso_provider` (**L439** `platform/identity`) |
| `lib/platform/integration/` on disk | ⛔ **ABSENT** |

⭐⭐ **What the gap actually does today — measured in the checker, not assumed.**
`tool/check_module_boundaries.dart` **L399–L417** builds a `Module` for **every** name in `ranks:`,
using `blockMap?['…']` with `blockMap` **null** when no block exists, and `path:` falling back to
`_defaultPath(name)` = `lib/platform/integration` (**L440–L444**). So the module resolves with
**rank 5 and every constraint list EMPTY**: no `banned_imports`, no `banned_symbols`, no `contexts`,
no `classification`.

⚠ **The defect is therefore LATENT, not currently firing** — and this is the honest statement of it.
Because `lib/platform/integration/` does not exist, **no file resolves to the module**, so the empty
constraint set governs nothing today. ⛔ **The moment the SMS or FCM adapter is written there, it
would be the only capability module in the repository free to `import 'domain/…'`**, because every
other capability block carries `banned_imports: ["domain/**", "app/**"]` and this one carries none.
⭐ `default_decision: deny` (**L21**) does **not** save it: deny governs **edges between declared
modules**, not the emptiness of a module's own ban list.

### 1.2 Gap B — the `BC-22 → BC-31` edge does not exist

| Measurement | Result |
|---|---|
| Rows matching `BC-22 … BC-31` in BC Map §7 | ⛔ **0** |
| Edges **into** `BC-31` | exactly **one** — **`E-25`** `BC-20 Billing → BC-31` (**L334**) |
| The governing rule | **L292** — *"If an edge is not in this table, it **does not exist** and adding it requires an ADR."* |
| Highest edge identifier | **`E-30`** (§17.1). `E-27` **permanently vacant** (`ADR-0033`; *"Numbers are never reused"*) |
| **`E-31`** occurrences anywhere | ⚠⚠ **CORRECTED ON REVIEW — THE ORIGINAL CLAIM WAS FALSE.** *(Original text, retained verbatim: "**0** — free".)* ⭐ **True measurement: 23 mentions across 7 documents** — `PRD-021C` **C0** (5), **C7** (3), **C8** (3), **Stage-3 alignment** (8), **Stage-4 review** (2); `PRD-008` alignment + V17 supplement (2). ⛔ **The original figure swept only the BC Map**, not *"anywhere"* as its own heading claimed. ⭐ **What survives:** `grep "^\| E-31"` across all `docs/` returns **0 rows**, so **`E-31` is genuinely NOT DECLARED**. ⚠⚠ **What does not:** all 23 assert the edge's non-existence **while reserving the number by intent** — *"`E-31` ⛔ unminted"*, *"`E-31` would be next"* — and `PRD-021C` **C8 §13** routes it to the **`BC-13` → `BC-19` referral transport** (`TSF-GAP-009`; Architecture Owner + `BC-19` owner; blocks `IMPL-1424`). ⭐⭐ **`E-31` is therefore UNMINTED BUT SPOKEN FOR** — see **§10** |

---

## 2. Decision

⚠ **Proposed, for Architecture Owner acceptance. Two limbs, decided on separate evidence.**

### 2.1 `D2-A` — declare the `platform/integration` module block

`platform/integration` **SHALL** carry an explicit declaration block at rank **5**, in the shape every
other capability module already uses, declaring at minimum:

- `rank: 5` — restating **L40**, not changing it;
- `imports: [{ target: contracts, mode: import }]` — the universal rank-0 downward import;
- `banned_imports: ["domain/**", "app/**"]` — ⭐ **identical** to `platform/audit`, `platform/search`,
  `platform/communication`, `platform/business` and `platform/workflow`;
- `provides_ports: [connector, payment_gateway, model_provider, sso_provider]` — ⭐ the **four ports
  already consumed** at L288/L343/L397/L416/L439, enumerated, **not invented**.

### 2.2 `D2-B` — admit edge **`E-31`** `BC-22 Notification Delivery → BC-31 Integration`

| # | Upstream (provider) | Downstream (consumer) | Pattern | Mechanism | Release | Basis |
|---|---|---|---|---|---|---|
| **`E-31`** | BC-22 Notification Delivery | BC-31 Integration | **`CF`** | **Sync port** | **V1** | Push/FCM egress. `MASTER_PRD` **L229** (**Rank 1**) and `PRD-010` **`NTF-FR-031`** |

⭐ **`CF` + Sync port is copied from `E-25`, the existing and only other edge into `BC-31`** (**L334**,
*"Gateway abstraction; Billing knows no vendor names"*). ⛔ **No new integration pattern is introduced.**

⛔ **`BC-22` gains no vendor knowledge.** `PRD-010` **`NTF-INV-005`** — *"`BC-22` **MUST NOT** hold
provider credentials; outbound third-party contracts are `BC-31`"* — and **`NTF-FR-031`** — *"`BC-22`
**MUST NOT** hold FCM credentials"* — both stand unweakened. The edge authorises a **call**, not a credential.

---

## 3. Why Gap B is a real defect and not a drafting nicety

⭐ **This is the `ADR-0016`/`ADR-0055`/`ADR-0095` defect class, in its sharpest form yet.** Those three
each found a **Rank 3** PRD depending on an edge the **Rank 4** register did not list. Here the
dependency is **Rank 1**:

| Rank | Artefact | Statement |
|---|---|---|
| **1** | `MASTER_PRD.md` **L229** | *"Push notifications \| **`BC-22` via `BC-31` Integration** \| Channel adapter \| **Firebase Cloud Messaging** \| **Yes — FCM (V1)**"* |
| **3** | `PRD-010` **`NTF-FR-031`** | *"Push **MUST** reach FCM through **`BC-31`**"* |
| **4** | BC Map §7 | ⛔ **silent** — and **L292** says silence means the edge *"does not exist"* |

⇒ **Two authoritative records disagree today**, and the lower-ranked one is the one denying the route.
`ADR-0055` ruled on precisely this shape that *"the map is the incomplete record"*. ⭐ **Push is V1 and
mandatory, so this contradiction is live now — it does not wait for OTP.**

---

## 4. Placement — append, never insert

⭐ **`D2-B` is executed as a new appended §19, not as a row inserted into §7.3.** This is the method
`ADR-0079` §8.5 Option A established and that §15, §16, §17 (`E-30`) and §18 all reused. The BC Map
header records the measured cost of the alternative: inserting after `E-26` shifted **1,293** line
citations, *"several inside **FROZEN** Rank 3 documents"*, against **0** for an append.

⚠ **`ADR-0114`'s falsified assumption is not repeated.** BC Map v1.12 recorded that the changelog is
**not** the last section — §15–§18 follow it — so a changelog row insert shifts citations below it.
⚠⚠ **RE-MEASURED AT REVIEW, AND THE ORIGINAL FIGURE WAS WRONG.** *(Original text, retained verbatim:
"Measured for this act: **32** BC Map line-citations exist repo-wide; a §19 append below §18 (ends
L1070) shifts **0** of them; the one changelog row shifts those below its insertion point and **must be
re-verified at execution**, not assumed.")* ⭐ **The true count is 22 distinct cited lines**, spanning
**L100–L649**, and the **highest is L649**.

⭐⭐ **A PRE-EXISTING STALE CITATION WAS FOUND AND IS REPORTED, NOT REPAIRED AND NOT OVERWRITTEN.**
`PRD-021A_STAGE4_AC_REQUIREMENT_MAPPING_2026-09-01.md` **L524** cites BC Map **L649** for
*"`E-01`…`E-26`, `E-28`, `E-29` — **28 edges**, with `E-27` a deliberate gap"*. **Measured at HEAD:
BC Map L649 no longer contains that text** — it now reads *"⛔ **`E-27` IS NOT REUSED AND IS
PERMANENTLY VACANT.**"*. ⛔ **The citation was already broken before this ADR**, by the `v1.11`/`v1.12`
appends that moved the text, and the edge count it quotes (**28**) was itself superseded by `E-30`
(**29**). ⛔⛔ **It is NOT silently corrected here:** `PRD-021A` is a Stage-4 record of another PRD, its
repair is that document owner's act, and editing it under a conferral scoped to *"Gap A + Gap B"* would
be exactly the scope creep `ADR-0033` §7.1 forbids. ⭐ **Recorded as a traceable finding for its owner**
— see §10.3.

⭐ **Consequence for M2, when it is eventually taken:** a §19 append below §18 (ends **L1070**) shifts
**0** of the 22; the **changelog row at L613** would shift the citations below it, of which **L649 is
the only one** — and that one is **already stale**, so repairing it is a **precondition** of M2, not a
side-effect. ⛔ **M2 is HELD regardless** (§10).

⚠ **`D2-A`'s manifest insert is NOT free and this is disclosed.** **169** line-citations point into
`tool/module_dependencies.yaml`. A block placed before `app:` (**L514**) shifts the citations at
**L534**, **L535**, **L548** and **L631**. ⛔ **The cheapest lawful placement must be re-measured at
execution**; this ADR does **not** pre-authorise a placement that shifts a citation silently.

⭐⭐ **RE-MEASURED IMMEDIATELY BEFORE THE M1 WRITE, AND A ZERO-COST PLACEMENT WAS FOUND.** The 169
references resolve to **49 distinct cited lines**, the highest being **L631** — verified **live and
still accurate** (`PRD-016_ARCHITECTURE_ALIGNMENT.md` **L263** cites *"L631–636 declares an
acknowledged-debt edge in the **opposite** direction"*, and L631 does still hold that text). ⭐ The
block was therefore appended at **END OF FILE** rather than beside the other `platform/*` blocks, so
the diff is a pure append — `724a725,759` — and **0 of the 49 citations shifted**. ⚠ The block's own
comment header records this reasoning in the manifest, so a later reader finds the placement explained
where the placement is.

---

## 5. ⚠⚠ Conflicts found — disclosed, and two of them NOT resolved here

### 5.1 ⭐⭐⭐ THE PRINCIPAL FINDING — `IMPL-020`'s stated reason for Gap B is contradicted by Rank 3

`IMPL-020` §1.3 determined the OTP route to be **`BC-18` → `BC-22` → `BC-31`**, reasoning from
`AUTH-3.5`. **That route is denied by a Rank-3 baselined PRD:**

| Authority | Rank | Statement |
|---|---|---|
| `PRD-001` **`AUTH-3.5`** (FROZEN) | 3 | *"Authentication **MUST NOT** implement message transport. It **MUST** request delivery from Notification"* |
| `PRD-001` **`AUTH-10.37`** (FROZEN) | 3 | *"**The OTP itself MUST NOT be treated as a notification and MUST NOT pass through any general notification path**"* |
| `PRD-010` **§5 N7** | **3** (baselined by `ADR-0111`) | *"OTP generation **and OTP SMS delivery**"* — **excluded from `BC-22`**; owner *"`BC-18` / Auth PRD — `AUTH-10.3`; `MASTER_PRD` §22 assigns OTP SMS to authentication, **not to `BC-22` as a general channel**"* |
| `PRD-010` §2.2 | 3 | *"⚠ **And OTP SMS is NOT `BC-22`'s** — see §5 N7"* |

⚠ **These are reconcilable in principle** — `AUTH-3.5` bars Authentication from *implementing*
transport, `AUTH-10.37` bars the OTP from the *general* notification path, and N7 says `BC-22` does not
own OTP SMS. A route exists that satisfies all three only if some context **other than `BC-22`**
carries OTP SMS to `BC-31`, or if `BC-22` carries it on a **non-general** path. ⛔⛔ **Which of those is
correct is NOT decided here.** Deciding it would:

1. exceed a conferral scoped to *"Gap A + Gap B"*;
2. require reading a **FROZEN** Rank-3 PRD against a **baselined** Rank-3 PRD — a precedence act; and
3. be exactly the inference `ATT-GAP-005` and `ADR-0045` §2.1 forbid.

⭐⭐ **Consequence, stated plainly: `E-31` does NOT create an OTP delivery route, and `D2` does NOT
unblock `BLK-01`.** `IMPL-020` §2.3's diagram implies `D2 → D3 → CODE → TASK-D10`; **that chain has an
undeclared link.** Owner: **Architecture Owner + Product Owner**, requiring its own conferral and ADR.

### 5.2 ⚠ `NTF-AL-F2` — a same-rank port that predates this ADR

`platform/communication` (rank 5) declares a port to `platform/integration` (rank 5) at **L397**.
Dependency Matrix §3.2 declares only **two** same-rank clusters, **both within R8**, so no cluster
covers this pair. `PRD-010_ARCHITECTURE_ALIGNMENT.md` §4.4 records it as **`NTF-AL-F2`**, owner
Architecture Owner.

⭐ **Measured, so it is neither overstated nor dismissed:** the checker's same-rank rule
(**L711–L724**) fires on **`import` statements**, not on declared ports — and `lib/platform/communication/`
and `lib/platform/integration/` **both do not exist**, so it fires **0 times today**. ⛔ **`D2-A` neither
creates nor cures this**: L397 already exists and is not edited. ⚠ It **will** fire the moment both
modules hold code. **Left OPEN under its existing identifier.**

### 5.3 ⚠ `T-29` — adjacent, and expressly not performed

`ADR-0111` carries **`T-29`** — `platform/communication` lacks the `platform/services:job_runtime`
port — as `[OWED — AO, ADR first]`. ⭐ Same file, same office, same rank. ⛔ **Deliberately excluded**:
the conferral names Gap A and Gap B, and `T-29` is neither. Bundling it would convert a one-act
conferral into a standing licence — `ADR-0033` §7.1.

### 5.4 Gap A's other six modules

`infrastructure`, `data`, `security`, `configuration`, `observability`, `services`, `event` are equally
undeclared. ⛔ **Not repaired.** `IMPL-020` §3 records that whether to repair all seven *"is itself the
Architecture Owner's call; the narrow repair is sufficient for `IMPL-020` and is the smaller act."*
⭐ This ADR takes the **smaller act** and says so.

---

## 6. What this ADR does NOT do

- ⛔ **Decides no OTP transport route** and reconciles no PRD — §5.1
- ⛔ **Closes no blocker.** `BLK-01`, `BLK-02`, `IMPL-020`, `TASK-D10`, `MP-DEP-03` all remain **P0/OPEN**
- ⛔ **Selects no SMS provider**, performs no DLT registration, mints no `AERR-*`
- ⛔ **Amends no frozen PRD, no Rank 1–3 artefact.** `MASTER_PRD.md`, `PRD-001`, `PRD-006`, `PRD-010`,
  `PRD-012a`, `Student_Identity_PRD_v1.md` are **byte-unchanged**
- ⛔ **Writes no code.** `lib/` is untouched — **0** files. No adapter, no port class, no SDK, no dependency
- ⛔ **Edits no checker.** `tool/check_module_boundaries.dart` is byte-unchanged
- ⛔ **Widens no existing edge.** `E-23` and `E-25` are untouched; `E-27` stays permanently vacant
- ⛔ **Confers no lifecycle stage** and closes no acceptance criterion
- ⛔ **Grants no standing authority.** The office reverts on acceptance (`ADR-0033` §7.1); no person is named

---

## 7. Migration requirements — ⭐ **M1 EXECUTED · ⛔ M2 HELD**

⚠⚠ **The two limbs were SPLIT on review (§10). M1 is done; M2 has not been performed and its target is
byte-unchanged.**

| # | Change | Document | Rank | State |
|---|---|---|---|---|
| **M1** | Add the `platform/integration:` block of §2.1, at a placement whose citation cost is **re-measured immediately before the write** | `tool/module_dependencies.yaml` | **4** | ⭐ **DONE 2026-09-09** — appended at **end of file**; diff `724a725,759`; **0 of 49** citations shifted; YAML re-parsed; `rank: 5` verified equal to the `ranks:` entry at **L40** |
| **M2** | ~~Append **§19** declaring `E-31`~~; header `Context Count` (edges 29 → 30); `Version` cell; one changelog row | `LIBOORA_BOUNDED_CONTEXT_MAP.md` | **4** | ⛔⛔ **HELD — NOT DONE.** The file is **byte-unchanged**: **0** new sections, **0** edges, **0** version change, **0** changelog rows. Blocked on the `E-31`/`E-32` allocation decision (§10) **and** on the pre-existing stale **L649** citation (§4) |
| **M3** | Register this ADR | `ADR-INDEX.md` | — | ✅ done; updated at review to `Accepted in part` |
| **M4** | Record `IMPL-020` Gap A (narrow) closed; record §5.1 and §10 as **new** OPEN items | `IMPL-020`, `IMPLEMENTATION_BLOCKER_REGISTER.md` | Unranked | ⛔ **NOT DONE** — routed, see §10.3 |

**Not required:** no baseline re-issue (Rank 4, §7 rule 4); no `lib/` file; no checker change; no test change.

⭐ **Verified after M1:** boundary checker **`FAIL — 9 violation(s)` + 28 acknowledged-debt findings** —
**bit-identical to the pre-M1 baseline**, confirming the new block **changes no verdict**. That is the
expected result and the point of §1.1: the defect was **latent**, so closing it must move nothing today.

---

## 8. Compliance

| Rule | Status |
|---|---|
| `DOCUMENTATION_BASELINE.md` §7 **rule 1** — ADR **before** a Rank 1–5 change | ✅ Satisfied by construction: this ADR exists and **precedes** M1/M2, which are unexecuted |
| §7 **rule 2** — version + changelog same commit | ⏳ Applies at execution (M2) |
| §7 **rule 3** — declaration updated same commit | ⏳ Applies at execution |
| §7 **rule 4** — baseline identifier moves only for Rank 1–3 | ✅ **Unmet limb** — both targets Rank 4. **`BASELINE-2026-09-03-A` stands** |
| BC Map **L292** — an unlisted edge requires an ADR | ✅ This is that ADR |
| `ADR-0033` §7.1 — one act is not a standing licence | ✅ Scope is `D2-A` + `D2-B` only; §5.2/§5.3/§5.4 expressly refused |
| `SID-4.56` — an unverifiable rule is unmet, not satisfied | ✅ No rule is claimed satisfied; the latent Gap-A risk is stated as latent |

---

## 9. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-09 | Created as **`Proposed`**. Decides `IMPL-020` **D2** in two limbs: **`D2-A`** declares the absent `platform/integration` block (rank 5, `banned_imports: ["domain/**","app/**"]`, four already-consumed ports enumerated), and **`D2-B`** admits **`E-31`** `BC-22 → BC-31` (`CF`, Sync port, V1) by **append as §19**. ⭐⭐ **The principal finding is a conflict, not a repair:** `IMPL-020` justified Gap B as the OTP route `BC-18 → BC-22 → BC-31`, but **Rank-3 baselined `PRD-010` §5 N7** excludes OTP SMS delivery from `BC-22`, corroborated by FROZEN **`AUTH-10.37`**. ⭐ **The edge survives on stronger, independent authority** — **Rank-1 `MASTER_PRD` L229** and `NTF-FR-031` require Push/FCM egress through `BC-31` — so this is the `ADR-0016`/`ADR-0055`/`ADR-0095` defect class with a **Rank-1** dependant. ⛔⛔ **But `D2` therefore does NOT unblock `BLK-01`**, and the OTP-transport owner is **left UNDECIDED** and routed. ⚠ Gap A measured **latent, not firing** (`lib/platform/integration/` absent; the checker builds the module from a null block with **empty** ban lists). ⚠ `NTF-AL-F2`, `T-29` and the other six missing blocks disclosed and **refused**. ⛔ **0** files amended, **0** code, **0** frozen PRDs, **0** blockers closed; migration **recorded, NOT executed**; `BASELINE-2026-09-03-A` stands. |

---

## 10. ⭐⭐ Review outcome — the act is SPLIT, and why

Added 2026-09-09 on Architecture Owner review. ⚠ **The review falsified one of this ADR's own
measurements**, and the split is the consequence.

### 10.1 ✅ `D2-A` — ACCEPTED and EXECUTED

Every element of §1.1 was re-verified at HEAD before the write and **all held**:

| Re-verification | Result |
|---|---|
| `platform/integration:` declaration block | ⛔ still **absent** (0) |
| Ports consumed elsewhere | ✅ still **4 ports at 5 sites** — L288, L343, L397, L416, L439 |
| `lib/platform/integration/` | ⛔ still absent ⇒ the gap is still **latent, not firing** |
| YAML validity after the write | ✅ parses; `rank: 5` equals the `ranks:` entry at **L40** |
| Checker verdict | ✅ **unchanged** — 9 violations / 28 debt findings, identical to baseline |

⭐ **`D2-A` was untouched by the `E-31` defect** — it declares a module, not an edge — which is exactly
why it is separable and why executing it alone is lawful.

### 10.2 ⛔⛔ `D2-B` — HELD. `E-31` is PRESERVED for `PRD-021C`

⛔ **`E-31` is NOT allocated by this ADR, and this ADR now expressly disclaims it.** §1.2's original
*"0 — free"* was **false**: **23 mentions across 7 documents** reserve the number by intent for the
**`BC-13` → `BC-19` referral transport** (`TSF-GAP-009`), routed by `PRD-021C` **C8 §13** to the
**Architecture Owner with the `BC-19` owner**, blocking **`IMPL-1424`**.

⚠ **The nuance is stated rather than resolved in my favour.** `PRD-021C` is **Stage-2 `DRAFT`** and
holds **no rank**, so this is ⛔ **not** a rank conflict, and its forecasts bind nobody. But taking
`E-31` for `BC-22 → BC-31` would falsify seven documents' explicit statements and consume a number
another open gap has publicly relied on — and `PRD_LIFECYCLE.md` §5 rule 5 (*"Numbers are never
reused, even after withdrawal"*) makes edge-number hygiene load-bearing in this repository.

⛔ **Choosing between the two claimants is a NEW allocation decision across two unrelated edges. It is
outside a conferral scoped to *"Gap A + Gap B"*, and it is NOT taken here.**

### 10.3 ⚠ Three items routed — ⛔ none decided, none invented

| # | Item | Statement | Owner | Status |
|---|---|---|---|---|
| **R1** | **`E-32` → `BC-22 → BC-31`** | The Push/FCM egress edge of §2.2 — pattern `CF` + Sync port, **V1**, on Rank-1 `MASTER_PRD` **L229** and `PRD-010` **`NTF-FR-031`** — allocated to **`E-32`** instead of `E-31`, leaving `E-31` with `PRD-021C`. ⛔ **`E-32` is NOT minted here**: it is measured **0** times repo-wide and is left **free**. ⭐ The *edge's justification* is unchanged and remains sound (§3); only its *number* is undecided | **Architecture Owner** | ⛔ **OPEN — needs its own one-act conferral and ADR** |
| **R2** | **BC Map L649 stale citation** | `PRD-021A_STAGE4_AC_REQUIREMENT_MAPPING_2026-09-01.md` **L524** cites BC Map **L649** for *"28 edges"*; **L649 no longer holds that text** and the count is superseded (**29** since `E-30`). ⛔ **Pre-existing** — broken by `v1.11`/`v1.12`, **not** by this ADR. ⛔ **NOT silently overwritten**; reported for its owner | **`PRD-021A` document owner** (with Architecture Owner) | ⛔ **OPEN — a precondition of M2** |
| **R3** | **OTP-SMS transport owner** | §5.1's conflict: `IMPL-020` assumed `BC-18 → BC-22 → BC-31`, but Rank-3 baselined `PRD-010` **§5 N7** excludes OTP SMS from `BC-22` and FROZEN **`AUTH-10.37`** bars the OTP from *"any general notification path"* | **Architecture Owner + Product Owner** | ⛔ **OPEN — unchanged by this act** |

### 10.4 What is closed, and what emphatically is not

✅ **CLOSED:** `IMPL-020` **Gap A**, for `platform/integration` only.

⛔⛔ **NOT CLOSED, and none of them moved:** **Gap B** · **`BLK-01`** · **`BLK-02`** · **`IMPL-020`** ·
**`TASK-D10`** · **`MP-DEP-03`** · `T-29` · `NTF-AL-F2` · `TSF-GAP-009` · Gap A's **other six** modules.

⭐⭐ **`D2-A` unblocks no delivery path.** It removes a latent boundary hole so that *when* an adapter is
eventually written it lands in a governed module. ⛔ **It writes no adapter, and `IMPL-020` §5's rule
still binds: no code until D1 and D2 are both accepted — and `D2-B` is HELD.**

### 10.5 Compliance of the split itself

| Rule | Status |
|---|---|
| §7 rule 1 — ADR **before** the Rank 1–5 change | ✅ `ADR-0126` was committed as `Proposed` at **`f6dd776`**, **before** M1 |
| §7 rule 4 — baseline moves only for Rank 1–3 | ✅ **Unmet limb** — the manifest is **Rank 4**. **`BASELINE-2026-09-03-A` STANDS** |
| `ADR-0033` §7.1 — one act is not a standing licence | ✅ Scope **narrowed**, never widened: R1/R2/R3 all refused |
| `ADR-0045` §3 — *"a named hole is honest; an invented contract is not"* | ✅ `E-32` **named, not minted**; the stale citation **named, not patched** |
| `SID-4.56` — an unverifiable claim is unmet, not satisfied | ✅ The false `E-31` figure is **corrected in place with the original retained**, not deleted |
