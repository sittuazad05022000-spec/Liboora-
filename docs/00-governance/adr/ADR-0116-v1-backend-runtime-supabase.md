# `ADR-0116` — The V1 backend runtime for `BC-30` Offline Sync is **Supabase**

| Field | Value |
|---|---|
| **ADR** | `ADR-0116` |
| **Title** | The V1 backend runtime for `BC-30` Offline Sync is **Supabase** |
| **Date** | 2026-09-08 |
| **Status** | **`ACCEPTED`** — by **direct conferral of Architecture Owner authority by the human principal**, this being the *"exact authority action"* that [`ADR-0115`](./ADR-0115-bc-30-v1-backend-runtime-deployment-authority.md) §7 item 1 reported as the missing prerequisite. Same disclosure as `ADR-0046`, `ADR-0032` §5.2, `ADR-0035`, `ADR-0037`, `ADR-0039`, `ADR-0042`, `ADR-0043` and `ADR-0102`: ⛔ **no ARB quorum, attendee list, sign-off date or Security review is asserted**, ⛔ **no holder is appointed and no personal name is recorded** (`PRD_OWNERSHIP_MODEL.md` §7 rule 4), and ⛔ *a conferral for one act is not a standing licence* (`ADR-0033` §7.1) |
| **Decision by** | **Architecture Owner** — `PRD_OWNERSHIP_MODEL.md` **L85** (*"ADR approval; any Rank 1–5 document change"*), conferred **for this one act only** |
| **One-act conferrals** | **Two**, from the human principal, 2026-09-08 — (1) **Architecture Owner**, to select and record the V1 backend runtime for `BC-30`; (2) **Governance Owner**, to register this ADR in `ADR-INDEX.md` and mechanically re-derive the Count. ⛔ **Neither is a standing licence.** Outside these acts both offices are **VACANT** |
| **Supersedes** | **Nothing** |
| **Amends** | **Nothing.** ⛔ `ADR-0115` is **NOT** amended, rewritten, superseded or restatused — it remains `Accepted` and byte-unchanged; this ADR is the follow-up act its own §7 item 1 routed |
| **Does NOT amend** | **`MASTER_PRD.md`** (Rank 1, incl. **L227**) · **`DOCUMENTATION_BASELINE.md`** · **BC Map** (Rank 4, incl. **L139**, **L333** `E-24`) · **Dependency Matrix** (Rank 4) · **the EA** (Rank 6) · **`PRD-006`** · **`PRD-001`** · **`PRD-012a`** · **any frozen PRD** · **any other `Accepted` ADR** · **`ADR-0114`** · **`TASK-D10`** · **`IMPL-020`** · **`tool/module_dependencies.yaml`** · **any gate under `tool/`** |
| **Baseline** | Written against **`BASELINE-2026-09-03-A`**. ⛔ **Not admitted to it and no baseline identifier is re-issued** — `DOCUMENTATION_BASELINE.md` §7 rule 4 moves it only when a **Rank 1–3** document changes version, and this ADR changes none |
| **Relates to** | `ADR-0115` §7 item 1 (the act it discharges) · `ADR-0114` · `ADR-0045` / `ADR-0046` (the STOP→conferral precedent this ADR follows clause by clause) · `ADR-0033` §7.1 · `ADR-0102` · `MASTER_PRD` `MP-CON-01`/`MP-CON-02`/`MP-CON-03`, L227, L271 · `IMPL-020` |
| **Outcome** | ⭐ **The V1 backend runtime for `BC-30` Offline Sync is `Supabase`.** ⛔ **No implementation, configuration, cloud resource, dependency or value of any kind is authorised** — see §5 |
| **Implementation authorised** | ⛔ **No** |

> ⚠⚠ **READ THIS FIRST.** This ADR selects a **runtime**. It authorises **no** Supabase implementation, **no**
> Supabase configuration, **no** cloud account, project, region or resource, **no** schema, **no** dependency,
> **no** durable queue, **no** queue depth, **no** retry count, **no** backoff, **no** retention period, **no**
> encryption algorithm and **no** secret format. **Selecting a runtime is not permission to build on it.**

---

## §1 The decision

**The V1 backend runtime for `BC-30` Offline Sync is `Supabase`.**

That sentence is the whole decision. It is recorded here, under the authority named in the Status row, because
`ADR-0115` §7 item 1 measured that the repository did **not** contain sufficient authority to reach it — and named
the act required. **That act has now been performed**, in these words from the human principal:

> *"I explicitly confer and authorize the Architecture Owner office to select and record the V1 backend runtime
> for BC-30 Offline Sync. **DECISION: V1 backend runtime = Supabase.** This is ONE ACT ONLY and NOT a standing
> licence."*

Nothing else in this ADR adds to the decision. §2 records why it is lawful now when it was not before, §3 records
the authority test, §4 records the boundaries preserved unweakened, §5 records what is expressly **not** authorised,
and §6 records the one Rank-1 follow-up that is deliberately **not** performed here.

⭐ **This ADR follows the `ADR-0045` → `ADR-0046` precedent exactly.** `ADR-0045` measured that a vendor *"CANNOT
be ratified from the repository"* and **STOPPED**; `ADR-0046` then made the selection under *"direct conferral of
Architecture Owner authority by the human principal."* `ADR-0115` §7 item 1 is this engagement's `ADR-0045`, and
this ADR is its `ADR-0046`. The mechanism is reused, not invented.

---

## §2 Why the decision is lawful now, and was not before

| # | Reason | Evidence |
|---|---|---|
| 1 | **The sole missing element was authority, not information.** `ADR-0115` §7 item 1 named exactly one owed act: *"record the selected runtime/deployment locus."* That act is now supplied | `ADR-0115` §7 item 1; §9 *"runtime-selection limb — STILL BLOCKED"* |
| 2 | **`MP-CON-02` classifies this as a deployment decision, and a deployment decision is precisely what a conferred act may make.** It is not an architecture change, so it collapses nothing | `MASTER_PRD` **L238**: *"Choosing a BaaS for V1 is a **deployment decision, not an architecture decision**"* |
| 3 | **Rank 1 already sanctions this exact shape** — *"vendors recorded as candidate implementations behind ports"* — so naming one **populates** the Technology Stack table rather than contradicting it. This is `ADR-0046` §2 reason 5, applied to the adjacent row of the same table | `MASTER_PRD` **§10 preamble (L221)**; `ADR-0046` §2 reason 5 |
| 4 | **Supabase is the only backend runtime named anywhere in the repository.** No competing runtime is proposed at any rank | Measured: every occurrence of `Supabase` enumerated (§2.2); `grep` for `appwrite\|pocketbase\|nhost\|amplify\|cloud run` over `docs/` and `tool/` returned **0** V1 runtime candidates |
| 5 | **The deployment locus and secret custody are already owned, so the runtime lands inside an existing accountability boundary rather than creating one** | `ADR-0115` §8.2 (INFRASTRUCTURE / DEVOPS PLATFORM), §8.1 (SECURITY PLATFORM) |
| 6 | **The known cost is on the record and is accepted, not discovered.** Single-vendor dependence is a lock-in risk; `MP-CON-03`'s abstraction is the mitigation and is **required to remain** (§4) | `MASTER_PRD` `MP-CON-03`, **L271**; EA L79's analogous lock-in criticism of single-vendor choice |

### §2.1 The reason that is *not* offered

⛔ **Not offered:** *"`MASTER_PRD` L227 already says Supabase, therefore it was already decided."* That reading was
refused in my own prior audit and in `ADR-0115` §8.3, and it is **still refused**. L227 column 5 reads *"Not named
in EA — **candidate only**"*, and `ADR-0045` §2.1 refused the identical inference for Razorpay. **The authority for
this decision is the conferral in the Status row and nothing else.** L227 is corroboration of *direction*, never grounds.

⭐ **The strongest evidence against the lazy reading is Rank 1 itself.** `MASTER_PRD` **L271** does not merely
decline to select Supabase — it **actively corrects v1.0 for having named it** as a stack layer:

> *"v1.0 terminated this stack with `Supabase`. Naming a vendor as a layer contradicts the sentence immediately
> following it in v1.0 … a layer you can swap is an adapter, not a layer."*

So Rank 1 had already **demoted** the name. This ADR does not re-promote it to a layer; it records it as the
**selected implementation behind the adapter**, which is the only shape `MP-CON-01`, `MP-CON-03` and L271 permit.

### §2.2 Every `Supabase` site in the repository, measured before deciding

| Site | Rank | What it is | Selected the runtime? |
|---|---|---|---|
| `MASTER_PRD` **L227** | 1 | Technology Stack row — *"BaaS (e.g. Supabase) for V1"* / *"candidate only"* | ❌ candidate |
| `MASTER_PRD` **L271** | 1 | **Correction** demoting Supabase from a layer to an adapter | ❌ the opposite |
| `MP-CON-03` | 1 | Data Layer must stay abstract so a dedicated backend *"can replace direct BaaS access later"* | ❌ a constraint |
| `ADR-0059` L58 | 2 | *"including the Supabase-backed one"* — a hypothetical future adapter | ❌ |
| `ADR-0115` §8.3 | 2 | *"Selects no runtime, vendor, product, SDK, database, cloud account or region"* | ❌ express negative |
| `PRD-017` `FIL-GAP-011` | 3 | *"`Supabase` appears in `docs/` twice, both 'candidate only'"* | ❌ |
| `IMPL-020` L185, L280 | — | *"does **not** select Supabase"* / *"Supabase is **not** chosen"* | ❌ |

**Not one was a selection.** That is why a conferral was required, and why this ADR — not any pre-existing line —
is the thing that decides.

---

## §3 The authority test

`ADR-0115` §8.3 records *"Selects no runtime, vendor, product, SDK, database, cloud account or region."* Read
carelessly that looks like a standing prohibition this ADR breaks. It is not, and the distinction is load-bearing:

| Measurement | Result |
|---|---|
| The heading that governs §8.3 | **"⛔ What §8 does NOT do"** — a statement about **`ADR-0115`'s own content** |
| `ADR-0115` §7 item 1 | *"record the selected runtime/deployment locus — ⛔ **STILL OWED**"* — i.e. **owed**, not forbidden |
| `ADR-0115` §9, runtime limb | *"§7 item 1 still requires a **follow-up act**"* | 
| `ADR-0033` §7.1 | *"A conferral for one act is not a standing licence"* — so a further decision **requires its own conferral**, which is what the Status row records |

⭐ So `ADR-0115` does not forbid the runtime decision; it **specifies the mechanism** by which it must be made — a
further, separate conferral. **This ADR is that conferral.** `ADR-0115` is therefore **honoured, not overridden**,
and its Status, text and bytes are **untouched**.

⛔ **Yesterday's conferrals were NOT reused.** The 2026-09-08 grants for secret custody, deployment locus and
`ADR-INDEX` re-derivation were each spent on their own act. Reusing any of them to select a runtime would be
exactly the standing-licence failure `ADR-0033` §7.1 exists to prevent. **Two fresh one-act conferrals** are
recorded in the header, and both expire with this ADR.

---

## §4 Boundaries preserved, and required to remain

The decision names a runtime. It changes no boundary, and every one of the following remains in force **unweakened**:

| Boundary | Authority | Still in force |
|---|---|---|
| **INFRASTRUCTURE owns the deployment locus** | `ADR-0115` §8.2; `MASTER_PRD` **L227** col. 2 *"Architectural owner = INFRASTRUCTURE (R1)"* | ✅ **Yes** — unchanged |
| **DEVOPS PLATFORM delivers onto that locus** | `ADR-0115` §8.2; `SECP-OWN-009` | ✅ **Yes** — unchanged |
| **SECURITY PLATFORM owns server-side secret custody** | `ADR-0115` §8.1; `SECP-OWN-001`; `MP-NFR-05` | ✅ **Yes** — ⛔ and this ADR defines **no** secret format, vault, rotation period or credential |
| **`BC-03` Attendance remains the business/domain authority** | `ADR-0114`; `ATT-PO-011` | ✅ **Yes** — conflict-resolution policy stays `BC-03`'s |
| **`BC-30` remains the execution mechanism only** | BC Map **L139**; `ADR-0114` | ✅ **Yes** — byte-unchanged |
| **`E-24` unchanged** | BC Map **L333** — *"Attendance defines the conflict-resolution policy; Sync executes it"* | ✅ **Yes** — byte-unchanged |
| **Future replacement by a dedicated backend must remain possible** | `MP-CON-03`; `MASTER_PRD` **L271** | ✅ **Yes** — ⭐ **this is a condition of the decision, not an aspiration.** The Data Layer stays abstract; Supabase is reached **only** through the persistence adapter |
| **No vendor name in domain code** | `MP-CON-01`; Dependency Matrix **L167** | ✅ **Yes** — ⛔ the domain must not know Supabase exists. Naming it in a governance record is precisely how it stays out of the places `MP-CON-01` forbids |
| **No distributed transaction is authorized** | — | ✅ **Yes** — ⛔ none is introduced, implied or permitted by this ADR |
| **The 25 approved platforms are not collapsed into a vendor feature list** | `MP-CON-02` | ✅ **Yes** — no platform, context, edge or capability is redefined in terms of Supabase features |
| **Context / edge counts** | `AR-1`; BC Map | ✅ **31 contexts (23 in V1), 29 edges** — none created |
| **`PRD-018` is not written** | `ADR-0114` | ✅ **Yes** — remains `PLANNED`; ⛔ **not created by this act** |

**The runtime is a fact about the adapter, not about the domain.**

---

## §5 ⛔ What this ADR does NOT authorise

Recorded as an explicit closed list, because a runtime selection is the point at which implementation pressure is
highest:

| Not authorised | Status |
|---|---|
| Supabase **implementation** | ⛔ **No.** 0 application-code files changed by this act |
| Supabase **configuration** | ⛔ **No.** No project, client, key, URL, policy or setting |
| **Cloud account, project, region or resource creation** | ⛔ **No.** None created, named or selected |
| **Database / schema creation**, tables, migrations, RLS policies | ⛔ **No** |
| **Dependencies** | ⛔ **No.** `pubspec.yaml` byte-unchanged; no `supabase_flutter` or any package added |
| **Durable queue implementation** (Item 3) | ⛔ **No.** Remains OPEN — eligible, not resolved |
| **Queue depth** (Item 7b) | ⛔ **No value.** `MP-NFR-04` backpressure authority unexercised |
| **Retry count, backoff, cooldown** (Item 5) | ⛔ **No value.** `PRD-006` **L2332**: *"none may be invented"* |
| **Retention period** (7a) | ⛔ **No value.** `Q-04` open; `ATT-GAP-005` bars promoting the unratified note |
| **Encryption algorithm / at-rest mechanism** (Item 9b) | ⛔ **No.** SECURITY PLATFORM's, and still behind Item 3 |
| **Secret format** | ⛔ **No** |
| **Changes to `PRD-006`** | ⛔ **No.** Byte-unchanged |
| **Creation of `PRD-018`** | ⛔ **No.** Must not be created |
| **New `IMPL-*` or `SYNC-*` identifiers** | ⛔ **None.** 0 created |
| **Standing authority for any office** | ⛔ **None.** Both conferrals are one-act |

⭐ **Selecting the runtime does not itself authorize implementation.** Implementation requires its own separately
authorised work, and — per §4 — must reach Supabase only through the abstract Data Layer.

---

## §6 The one Rank-1 follow-up deliberately NOT performed

⚠ `MASTER_PRD.md` **L227** column 5 still reads *"**Not named in EA** — candidate only."* This ADR **does not touch
it.** Two reasons, and the second is the stronger:

1. **Baseline §7 rule 1** requires *"an ADR **before** the change"* for any Rank 1–5 document. Amending Rank 1
   inside this act would be a Rank-1 edit riding on a conferral that was scoped to a runtime *selection*.
2. ⭐ **The precedent indicates the amendment may not be required at all.** `ADR-0046` selected Razorpay while
   `MASTER_PRD` **L232** said *"candidate only"*, and its `Does NOT amend` row lists **`MASTER_PRD.md` (Rank 1)**
   explicitly. Its §2 reason 5 explains why: Rank 1's §10 preamble already sanctions *"vendors recorded as
   candidate implementations behind ports"*, so naming one **populates** the table rather than contradicting it.
   `ADR-0046` is `Accepted` and the L232 cell was never amended — so an unamended *"candidate only"* cell alongside
   an accepted vendor selection is an **already-ratified state** in this repository, not a defect this ADR creates.

⛔ **I therefore neither amend L227 nor assert that it must be amended.** It is reported as a **separate follow-up
governance action requiring its own ADR/process**, exactly as `ADR-0115` §7 item 4 framed it — *"only if the final
accepted authority requires it."* **Owner: Architecture Owner / Governance Owner. Requires its own conferral.**

---

## §7 Dependency effect

| Item | Before | After this ADR | Reason |
|---|---|---|---|
| **Item 4 — authority limb** | ✅ RESOLVED | ✅ **RESOLVED** | `ADR-0115` §8 — unchanged |
| **Item 4 — runtime limb** | 🔒 BLOCKED | ✅ **RESOLVED** | **This ADR.** `Supabase` selected under conferred Architecture Owner authority |
| **⭐ Item 4 — overall** | 🔒 BLOCKED | ✅ **RESOLVED (authority + runtime)** | ⛔ **Resolved ≠ implementable.** No implementation is authorised; §5 |
| **Item 3 — durable queue** | ⛔ OPEN — eligible | ⛔ **OPEN — eligible, not resolved** | Runtime and owner both now exist to decide it. ⛔ No durability mechanism, guarantee or value authorised |
| **Item 5 — retry/backoff** | ⛔ OPEN — eligible | ⛔ **OPEN — eligible, not resolved** | `PRD-006` **L2332**: *"none may be invented"* |
| **Item 9b — at-rest** | 🔒 BLOCKED behind 3 | 🔒 **BLOCKED behind Item 3** | Unchanged; owner SECURITY PLATFORM |
| **Item 7b — queue depth** | 🔒 BLOCKED behind 3 | 🔒 **BLOCKED behind Item 3** | Unchanged; `MP-NFR-04` |
| **7a — retention** | ⛔ OPEN | ⛔ **OPEN — untouched** | Independent |
| **8b-residual** | ⚠ owner decision | ⚠ **REQUIRES OWNER DECISION — untouched** | Independent |

⛔ **Items 3 and 5 do NOT become resolved by this act**, and are recorded as resolved nowhere.

---

## §8 Changelog

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-08 | ⭐⭐ **Created and ACCEPTED. The V1 backend runtime for `BC-30` Offline Sync is `Supabase`**, by direct conferral of **Architecture Owner** authority from the human principal — the exact act `ADR-0115` §7 item 1 reported as the missing prerequisite. Follows the **`ADR-0045` STOP → `ADR-0046` conferral** precedent clause by clause. ⭐ A second one-act **Governance Owner** conferral registers this ADR in `ADR-INDEX.md` and re-derives the Count. ⛔ **Neither conferral is a standing licence** (`ADR-0033` §7.1); both expire with this act; no holder appointed and no personal name recorded. ⛔ **`ADR-0115` is NOT amended, rewritten, superseded or restatused** — this is a **new** ADR discharging the act `ADR-0115` routed. ⭐ **The lazy inference was refused explicitly (§2.1):** authority is the conferral and nothing else — `MASTER_PRD` **L227** reads *"candidate only"* and **L271** actively **demotes** Supabase from a layer to an adapter, so all seven repository sites were measured (§2.2) and **not one was a selection**. ⭐ **Boundaries preserved unweakened (§4):** INFRASTRUCTURE owns the locus, DEVOPS PLATFORM delivers, SECURITY PLATFORM owns secret custody, `BC-03` keeps business/domain authority, `BC-30` stays execution-only, `E-24` unchanged, dedicated-backend replacement **remains a condition** (`MP-CON-03`), no vendor name in domain code (`MP-CON-01`), **no distributed transaction**, 25 platforms not collapsed (`MP-CON-02`), 31 contexts / 29 edges. ⛔ **NOTHING AUTHORISED BEYOND THE SELECTION (§5):** no Supabase implementation or configuration, no cloud account/project/region/resource, no schema, no dependency, no durable queue, no queue depth, no retry count, no backoff, no retention, no encryption algorithm, no secret format, no `PRD-006` change, no `PRD-018`, **0** new `IMPL-*`/`SYNC-*` identifiers. ⚠ **`MASTER_PRD` L227 is deliberately NOT amended (§6)** and reported as a separate follow-up requiring its own ADR — with the honest disclosure that `ADR-0046`'s precedent suggests the amendment may not be required at all, since it selected Razorpay while L232 said *"candidate only"* and never amended Rank 1. ⛔ **Item 4 is now RESOLVED on both limbs, and resolved is NOT implementable.** Items 3 and 5 remain **eligible, not resolved**; 9b and 7b stay blocked behind Item 3; 7a and 8b-residual untouched. |
