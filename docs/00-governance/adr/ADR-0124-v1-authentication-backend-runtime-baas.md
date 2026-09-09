# `ADR-0124` — The V1 **authentication** backend runtime is a **managed BaaS (Supabase)**, per `IMPL-020` §2.1 **Option A**

| Field | Value |
|---|---|
| **ADR** | `ADR-0124` |
| **Title** | The V1 authentication backend runtime is a managed BaaS (Supabase) — `IMPL-020` §2.1 Option A |
| **Date** | 2026-09-08 |
| **Status** | **`ACCEPTED`** — by **direct conferral of Architecture Owner authority by the human principal**, **for this one act only**: *"to select and record the V1 authentication backend runtime specified by `IMPL-020`."* ⭐ This is the *"exact authority action"* that `IMPL-020` §2.1 routed upward — *"it is the **Architecture Owner's** to take"* — and the same disclosure `ADR-0046` and `ADR-0116` carry: ⛔ **no ARB quorum, attendee list, sign-off date, Security review or Privacy review is asserted** |
| **Decision by** | **Architecture Owner** — `PRD_OWNERSHIP_MODEL.md` **L85** (*"Boundaries, ranks, permitted edges, precedence … ADR approval; any Rank 1–5 document change"*), conferred **for this one act only** |
| **One-act conferral** | **One**, from the human principal, 2026-09-08 — Architecture Owner, to select and record the V1 authentication backend runtime. ⛔ **Not a standing licence** (`ADR-0033` §7.1: *"A conferral for one act is not a standing licence"*). Outside this act the office is **VACANT**. ⛔ **No holder appointed, no personal name recorded** (`PRD_OWNERSHIP_MODEL.md` §7 rule 4) |
| **Subject** | The V1 backend runtime that hosts the **authentication** OTP delivery adapter and challenge handling (`IMPL-020`, Rank 1 `MP-DEP-03`) |
| **Supersedes** | **Nothing** |
| **Amends** | ⛔ **Nothing.** No PRD, no BC Map, no Dependency Matrix, no manifest, no EA, no `MASTER_PRD.md`, no `CONFIGURATION_GUIDE.md`, no other ADR — the **`ADR-0046` / `ADR-0116` shape**: a selection recorded **in the ADR itself** |
| **Amended by** | — |
| **Does NOT amend** | **`MASTER_PRD.md`** (Rank 1, incl. **L227**, **L271**) · **`DOCUMENTATION_BASELINE.md`** · **BC Map** (Rank 4) · **Dependency Matrix** (Rank 4, incl. **L167**, `X-03`) · **the EA** (Rank 6) · **`PRD-001` `Authentication_PRD_v2.md`** (Rank 3, **FROZEN**) — ⛔ **no `AUTH-*`, `BR-*`, `AC-*` or `XC-*` identifier is minted, moved or altered** · **`PRD-006`** (Rank 3, **FROZEN**) · **`PRD-012a`** (Rank 3, **FROZEN**) · **any other frozen PRD** · **`ADR-0115`**, **`ADR-0116`** · ⛔ **`ADR-0119`, `ADR-0120`, `ADR-0121`, `ADR-0122`, `ADR-0123`** · `ADR-0045`, `ADR-0046` · `ADR-0002` · `ADR-0114` · **`TASK-D10`** · `tool/module_dependencies.yaml` |
| **Baseline** | Written against **`BASELINE-2026-09-03-A`**. ⛔ **Not admitted to it and no baseline identifier is re-issued** — `DOCUMENTATION_BASELINE.md` §7 rule 4 moves it only when a **Rank 1–3** document changes version, and this ADR changes none (§7.2) |
| **Closes** | ⭐ **The backend-runtime limb of `BLK-02` / `IMPL-020` only.** ⛔ **`BLK-02` itself is NOT closed** — see §6 |
| **Does NOT close** | ⛔⛔ **`BLK-02` / `IMPL-020` as a whole** · ⛔ **`MP-DEP-03` DLT template registration** (External, Rank 1) · ⛔ **SMS provider selection** · ⛔ **`BLK-01` / `TASK-D10`** · ⛔ **`BLK-03` / `IMPL-220`** · ⛔ **`BLK-04` / `GCP-02`** · ⛔ **Item 9b** (`ATT-GAP-006` OPEN) · ⛔ **Item 7a** (`Q-04` open) · ⛔ the `MASTER_PRD` **L227** follow-up · ⛔ `IMPL-020`'s Gap A (manifest block) and Gap B (edge) · ⛔ **no implementation authority** |
| **Relates to** | `IMPL-020` §1.2, §1.3 (the 11-obligation classification), **§2.1** (the options this ADR selects from), §6 · `ADR-0045` → `ADR-0046` (the STOP → conferral precedent) · `ADR-0115` §8 (deployment-locus and secret-custody offices) · `ADR-0116` (the **`BC-30`-scoped** runtime selection — ⚠ **expressly not read as this decision**) · `MASTER_PRD` `MP-CON-01`/`MP-CON-02`/`MP-CON-03`, `MP-DEP-03`, `MP-RSK-05`, **L227**, **L271** · `PRD-001` `AUTH-3.5`, `AUTH-3.12`, `AUTH-11.51` · Dependency Matrix **L167**, `X-03` |
| **Outcome** | ⭐ **The V1 authentication backend runtime is a managed BaaS — `Supabase` — hosting the OTP delivery adapter as an adapter behind a port.** ⛔ **No implementation, configuration, cloud resource, credential, dependency or value of any kind is authorised** |
| **Implementation authorised** | ⛔ **No** |

> ⚠⚠ **READ THIS FIRST.** This ADR selects a **runtime** for authentication. It authorises **no** Supabase
> implementation, **no** Supabase configuration, **no** cloud account, project, region or resource, **no**
> schema, **no** dependency, **no** SDK, **no** SMS provider, **no** DLT registration, **no** template, **no**
> sender ID, **no** credential or secret format, **no** endpoint, **no** rate limit and **no** price.
> **Selecting a runtime is not permission to build on it.** ⛔ It does **not** close `BLK-02`.

---

## §1 The act this discharges, and the five preconditions verified before it

⭐ **`IMPL-020` §2.1 ends by routing this decision upward and expressly declining to take it:**

> *"⭐ **Recommended direction: Option A**, as the L227 candidate and the smallest step — **but it is the
> Architecture Owner's to take.** ⛔ This document does **not** select Supabase."*

⭐ **`IMPL-020` §6 restates the refusal:** *"⛔ **Selects no backend.** Supabase is **not** chosen;
`MASTER_PRD.md` **L227** is untouched."* This ADR is the act that `IMPL-020` framed and withheld.

### 1.1 Preconditions — measured at `790ae21`, before anything was written

| # | Precondition | Measurement | Verdict |
|---|---|---|---|
| **1** | `BLK-02` / `IMPL-020` still **active** | Register §2 row: *"`BLK-02` \| `IMPL-020` — SMS provider integration + DLT registration \| **P0** \| … \| ⬜ **OPEN — not started**"* | ✅ **ACTIVE** |
| **2** | Authentication backend runtime still **unselected** | Swept **all 111** ADRs for `backend runtime\|BaaS\|serverless\|edge function`. **Five** files matched, **none** selects an authentication runtime (§1.2) | ✅ **UNSELECTED** |
| **3** | **No later ADR** has resolved it | Highest identifier is **`ADR-0123`**, whose §7.1 lists *"**4 — Backend runtime** ✅ RESOLVED (`ADR-0115` §8, `ADR-0116`)"* — ⭐ that is **Item 4**, the **`BC-30`** item, **not** `IMPL-020` | ✅ **UNRESOLVED** |
| **4** | `ADR-0124` still the next free identifier | **0** files named `ADR-0124`; **0** references anywhere in `docs/`; max existing identifier = `ADR-0123` | ✅ **FREE** |
| **5** | `IMPL-020` §2.1 options still current | §2.1 read at HEAD: Options **A** (BaaS), **B** (dedicated backend service), **C** (direct-from-client, *"NOT RECOMMENDED — refuse"*). `IMPL-020` is **v1.0**, byte-unchanged since `fc91ebb` | ✅ **CURRENT** |

⛔ **No precondition was assumed.** Had any failed, this act would have stopped read-only.

### 1.2 ⭐⭐ The five near-misses, and why not one of them is this decision

⚠ **This is the test most likely to be got wrong**, because a Supabase selection already exists in the
repository and it would be convenient to treat it as covering authentication. **It does not.**

| Site | What it actually says | Selects the **authentication** runtime? |
|---|---|---|
| **`ADR-0116`** | Title: *"The V1 backend runtime for **`BC-30` Offline Sync** is Supabase"* | ❌ **NO — and expressly so.** Its `Does NOT amend` row names **`IMPL-020`**, and its §2.2 cites *"`IMPL-020` L185, L280 — *'does not select Supabase'* / *'Supabase is not chosen'*"* as a **non-selection**. ⛔ Reading it as an authentication decision is precisely the inference `ADR-0045` §2.1 and `ATT-GAP-005` forbid |
| **`ADR-0115`** §8.3 | *"Selects no runtime, vendor, product, SDK, database, cloud account or region"* | ❌ **express negative** |
| **`ADR-0100`** L134 | Quotes `MP-CON-02` — *"Choosing a BaaS for V1 is a **deployment decision**"* | ❌ a constraint, not a choice |
| **`ADR-0119`** L124 | *"`MP-CON-03` — Data Layer abstract, dedicated backend can replace the BaaS later"* | ❌ a coherence test |
| **`ADR-0123`** §7.1 | *"4 — Backend runtime ✅ RESOLVED (`ADR-0115` §8, `ADR-0116`)"* | ❌ **that is `BC-30` Item 4**, a different blocker in a different register section |
| `MASTER_PRD` **L227** | *"BaaS (e.g. Supabase) for V1"* / *"**Not named in EA** — candidate only"* | ❌ **candidate** |
| `MASTER_PRD` **L271** | The Correction **demoting** Supabase from a layer to an adapter | ❌ the opposite of a selection |

⭐ **Not one was a selection for authentication.** That is why the conferral was required, and why **this
ADR — not any pre-existing line — is the thing that decides.**

---

## §2 ⭐⭐ The decision

> **The V1 authentication backend runtime is `IMPL-020` §2.1 **Option A** — a managed BaaS, namely
> `Supabase` — which hosts the OTP delivery adapter and challenge handling as an **adapter behind a port**,
> never as a layer.**

⭐ **Selected from `IMPL-020` §2.1 only.** ⛔ No fourth option was invented, and the option text is not
rewritten, widened or reinterpreted.

⚠ **The "adapter behind a port, never a layer" clause is not an addition — it is Rank 1 carried through.**
`MASTER_PRD` **L271** already records the Correction that *"a layer you can swap is an adapter, not a
layer"*, and `MP-CON-03` preserves the requirement verbatim. ⛔ **This ADR states no new architectural
rule**; it selects a runtime and records the constraint that already binds it.

### 2.1 What this selection fixes, and what it leaves open

| Fixed | Left open |
|---|---|
| **Which runtime class hosts the authentication adapter** — a managed BaaS | ⛔ **No** cloud account, project, region, tier, plan or resource |
| **Which product within that class** — `Supabase` | ⛔ **No** SDK, dependency, package version or client library |
| **Its architectural position** — an adapter behind a port | ⛔ **No** port name, interface signature, module, manifest block or edge (`IMPL-020` Gaps A and B stay **OPEN**) |
| — | ⛔ **No** schema, table, function, deployment pipeline or environment |
| — | ⛔ **No** SMS provider, DLT template, sender ID or `AERR-*` identifier |
| — | ⛔ **No** secret format, credential, rotation policy or vault configuration |

---

## §3 The authority test, performed rather than asserted

| Question | Answer |
|---|---|
| **Whose decision is this?** | ⭐ **Architecture Owner.** `IMPL-020` §2.1 says so in terms: *"it is the **Architecture Owner's** to take."* Corroborated by `PRD_OWNERSHIP_MODEL.md` **L85** (*"ADR approval; any Rank 1–5 document change"*) |
| **Is it Rank 1's already?** | ❌ **No.** `MASTER_PRD` **L227** column 2 assigns the *architectural ownership* of `Backend runtime` to **INFRASTRUCTURE (R1)**, and `MP-CON-02` classifies the BaaS choice as a **deployment decision, not an architecture decision** — but neither **makes** the choice. `ADR-0115` §8.2 already named **INFRASTRUCTURE** as deployment-locus owner for `BC-30`; ⛔ **this ADR does not extend that assignment to authentication**, which would be an ownership act outside the conferral |
| **Could it have been ratified from existing authority?** | ❌ **No** — and this was tested first. `MASTER_PRD` L227 is a **candidate**; L271 is a **demotion**; `ADR-0115` §8.3 is an **express negative**; `ADR-0116` is **`BC-30`-scoped**. ⭐ **A conferral was genuinely required**, exactly as `ADR-0045` found for the payment gateway |
| **Precedent for the shape** | ⭐⭐ **`ADR-0045` → `ADR-0046`**, clause by clause: a preparation record measured that the choice *"CANNOT be ratified from the repository"* and **STOPPED**; a later ADR then selected the vendor *"by direct conferral of Architecture Owner authority by the human principal."* `IMPL-020` is this decision's `ADR-0045`; **this ADR is its `ADR-0046`** |
| **Standing authority created?** | ⛔ **None.** One act; office VACANT afterwards |

---

## §4 ⭐⭐ Options considered, and why the two rejected options were rejected

⭐ **All three options are taken verbatim from `IMPL-020` §2.1.** Each is tested against **existing**
repository authority only.

### 4.1 ⛔ Option C — provider called direct from the Flutter client: **REFUSED**

| Authority | Text | Effect on C |
|---|---|---|
| **`AUTH-3.12`** (FROZEN `PRD-001` **L923**) | *"The code **MUST NOT** appear in any response, event, log, metric, error or analytics record. It exists only in the challenge record and the delivered message"* | ⛔ **Fatal.** A client that calls the provider holds the challenge surface |
| **Dependency Matrix `X-03`** (**L352**) | `domain → INTEGRATION` is a **forbidden edge**: *"Vendor lock-in inside the core domain; untestable; breaks gateway abstraction"* | ⛔ **Fatal.** Vendor knowledge crossing inward |
| **Dependency Matrix L167** | *"The domain must not know that Razorpay, Twilio or FCM exist. It emits facts and calls ports"* | ⛔ **Fatal** |
| **`MP-CON-01`** (Rank 1, L237) | *"No vendor name may appear in domain code. Vendors live behind ports"* | ⛔ **Fatal** |
| **`IMPL-020` §2.1 itself** | *"⛔ **NOT RECOMMENDED — refuse.** Ships the provider API key to every device"* | ⛔ Already refused in the preparation record |
| **`AUTHENTICATION_IMPLEMENTATION_CHECKLIST` L58–L60** (quoted at `IMPL-020` §1.3) | *"**The single most important line in this document.** If the code reaches the client in any environment, the authentication factor does not exist. `D-10` happened exactly this way"* | ⛔ **Decisive.** Option C reconstructs the `D-10` defect by design |

⭐ **Option C is refused on five independent authorities, four of them FROZEN or Rank 1.** ⛔ It is recorded
as **refused**, not silently skipped — the discipline `IMPL-020` §2.1 established by listing it at all.

### 4.2 ⛔ Option B — dedicated backend service: **NOT SELECTED** (lawful, but unsupported and slower)

⭐ **Option B is lawful.** It breaches nothing, and it satisfies checklist item 9's *"server logs"*
literally. It is **not selected** for reasons measured in the repository, not preferred:

| Ground | Evidence |
|---|---|
| **Nothing in the repository specifies its deployment** | `IMPL-020` §2.1, Option B trade-off column: *"Largest effort; **nothing in the repo specifies deployment**"*. Selecting B would immediately require deployment decisions **this conferral does not cover** |
| **Rank 1 points at the BaaS class for V1, not at a bespoke service** | `MASTER_PRD` **L227**: *"BaaS (e.g. Supabase) **for V1**"* |
| **`MP-DEP-03` makes authentication launch-critical** | Rank 1 **L570**: SMS provider + DLT registration is *"**V1 launch — authentication cannot function without it**"*. ⭐ The runtime choice sits on the critical path of the **only** sign-in route, so the larger-effort option carries a launch cost the repository already flags |
| ⚠ **Not rejected on architecture** | ⭐ **B remains available for V2 and beyond by design** — `MP-CON-03` exists precisely so *"a dedicated backend can replace direct BaaS access later without affecting upper layers."* Selecting A **preserves** B rather than foreclosing it |

⚠ **This is a "not selected", not a "refused".** The distinction is recorded because a later reader must not
believe a dedicated backend was ruled out.

### 4.3 ⭐ Option A — managed BaaS (Supabase): **SELECTED**

| Authority | Text | Effect on A |
|---|---|---|
| **`MASTER_PRD` L227** (Rank 1) | *"BaaS (e.g. Supabase) for V1"* | ✅ **A is the Rank-1-indicated class.** ⚠ *"candidate only"* — which is why a conferral, not an inference, decides it |
| **`MP-CON-02`** (Rank 1, L238) | *"Choosing a BaaS for V1 is a **deployment decision, not an architecture decision**. It must not collapse the 25 approved platforms into a vendor's feature list"* | ✅ **Satisfied.** ⛔ **No platform is collapsed, merged, renamed or removed by this act** — the 25 approved platforms are untouched |
| **`MP-CON-03`** (Rank 1, L239) | *"The Data Layer must remain abstract so a dedicated backend can replace direct BaaS access later"* | ✅ **Satisfied** — §2's *"adapter behind a port, never a layer"* is this constraint carried through, and Option B stays reachable |
| **`MP-CON-01`** (Rank 1, L237) | *"No vendor name may appear in domain code"* | ✅ **Satisfied** — the vendor sits at the composition root, behind a port. ⛔ This ADR authorises **no** code, so no vendor name is written anywhere |
| **`AUTH-11.51`** (FROZEN, **L4427**) | *"The platform MUST be able to switch delivery providers **without any change to this specification**"* | ✅ **Satisfied and untouched.** ⭐ Switchability is about the **delivery provider**, which this ADR does **not** select — so the requirement is preserved in full |
| **`AUTH-3.5`** (FROZEN, **L910**) | *"Authentication **MUST NOT** implement message transport. It **MUST** request delivery from Notification"* | ✅ **Not breached.** ⭐ A runtime **hosts** an adapter; it does not relocate transport ownership. ⛔ **This ADR does not place SMS transport inside `BC-18`**, and `AUTH-3.5`'s Notification routing is unchanged |
| **`AUTH-3.12`** (FROZEN, **L923**) | The code exists *"only in the challenge record and the delivered message"* | ✅ **Supported, not merely permitted.** A server-side runtime is what makes non-disclosure achievable; Option C makes it impossible |
| **`PRD-001` L952** | *"No offline authentication — interactive authentication requires connectivity"* | ✅ **Consistent** — a server-side runtime matches a connectivity-requiring flow |
| **`IMPL-020` §1.3 items 8, 9** | Classified *"⚠ **BACKEND DECISION**"*, with item 9 noting *"'server logs' **presumes a server; none is approved**"* | ⭐⭐ **This act supplies exactly that missing premise** — a server now exists in authority, so items 8 and 9 become answerable. ⛔ It does **not** answer them |

### 4.4 ⚠ `MP-RSK-05` is acknowledged, not dismissed

Rank 1 **L555**: *"**BaaS lock-in silently absorbs platform responsibilities**, making the future backend
migration a rewrite. \| **High** \| `MP-CON-01`/`02`; the Data Layer abstraction is load-bearing, not
decorative."*

⭐ **This is the strongest repository argument against Option A, and it is recorded rather than omitted.**
Rank 1 states its **own** mitigation — `MP-CON-01`/`MP-CON-02` plus the load-bearing abstraction — and §2's
adapter-not-layer clause is that mitigation restated. ⛔ **The risk is not closed by this ADR**; it remains
`High` and owned where Rank 1 places it.

---

## §5 What this act explicitly does NOT do

⛔ **Tested item by item, as the conferral required.**

| Category | Authorised here? |
|---|---|
| **SMS provider selection** | ⛔ **NO.** ⭐ And it is not needed for this: `IMPL-020` §1.3 measures *"**Totals: 🟢 CODE NOW 6 · ⚠ BACKEND DECISION 4 · 🔴 DLT-HUMAN 1 · PROVIDER DECISION 0**"* and states *"**No obligation requires the provider's identity**"*. **MSG91 remains a candidate only** (`IMPL-020` §2.2) |
| **DLT template registration** | ⛔ **NO, and it cannot be.** Rank 1 `MP-DEP-03` classifies it **External** — *"outside engineering control"*. It is a commercial/regulatory act against a legal entity, not a governance decision |
| **Implementation** | ⛔ **NO.** 0 code, config, dependency, manifest, test or tool files |
| **Cloud resources** | ⛔ **NO** account, project, region, tier, plan, database, function or bucket |
| **Schema / dependency / SDK** | ⛔ **NO** |
| **Secrets** | ⛔ **NO** credential, format, rotation policy or vault configuration. ⚠ `ADR-0115` §8.1 named **SECURITY PLATFORM** for `BC-30` secret custody; ⛔ **this ADR does not extend that to authentication** — that is a separate conferral |
| **Deployment locus for authentication** | ⛔ **NOT assigned.** `ADR-0115` §8.2's INFRASTRUCTURE/DEVOPS assignment is **`BC-30`-scoped** and is **not** widened here |
| **Port / module / edge** | ⛔ **NO.** `IMPL-020`'s **Gap A** (no manifest block) and **Gap B** (edge does not exist) remain **OPEN** |
| **Frozen PRDs** | ⛔ **NONE touched.** `PRD-001`, `PRD-006`, `PRD-012a` and every other frozen PRD are **byte-unchanged** |
| **`ADR-0119` … `ADR-0123`** | ⛔ **NOT amended, superseded or restatused** — byte-unchanged. This ADR concerns **authentication**; those concern **`BC-30` Offline Sync** |
| **`MASTER_PRD` L227 amendment** | ⛔ **NOT performed** — §7.1 |
| **`BLK-01`, `BLK-03`, `BLK-04`, Items 7a / 9b** | ⛔ **Untouched** |
| **Standing authority** | ⛔ **None** |

---

## §6 ⚠⚠ `BLK-02` is NOT closed — and this is the honest limit of the act

⭐ **`BLK-02` has three limbs. This act discharges one.**

| Limb | Status after this ADR |
|---|---|
| **Backend runtime** | ✅ **SELECTED — this ADR** |
| **DLT template registration** | ⛔ **OPEN.** Rank 1 `MP-DEP-03`, **External**. Multi-week; the register §9 records it as *"the only item whose duration the team cannot compress"* |
| **SMS provider selection** | ⛔ **OPEN.** Architecture Owner, separate act. ⭐ **Low urgency** — 0 of 11 obligations depend on provider identity |

⛔ **`BLK-02` therefore remains P0 and OPEN**, and its register row must say so. ⚠ **A reader who sees a
runtime selected and concludes authentication can now be built would be wrong**: `MP-DEP-03` states
*"authentication cannot function without"* the DLT registration, and that is external.

### 6.1 What this unblocks, stated narrowly

⭐ **`IMPL-020` §1.3's four *"⚠ BACKEND DECISION"* items now have the premise they lacked** — item 9's
objection was *"'server logs' presumes a server; **none is approved**"*, and a server is now approved in
authority. ⛔ **The four items are not answered here**, and answering them is implementation work for which
**no authority exists**.

⚠ **`BLK-01` / `TASK-D10` is NOT unblocked.** `IMPL-020` §1.3 measures that the debug peek *"**cannot be
removed until a real delivery path exists**, or the app loses its only sign-in route"* — and a **runtime is
not a delivery path**. The delivery path additionally needs the DLT registration and an implemented
adapter. ⛔ **`TASK-D10` remains P0 and OPEN, and `TASK-D10` is byte-unchanged.**

---

## §7 Follow-ups deliberately NOT performed

### 7.1 ⚠ The Rank-1 `MASTER_PRD` **L227** cell is NOT amended

**L227** column 5 still reads *"**Not named in EA** — candidate only."* ⛔ **This ADR does not touch it**, on
two grounds, the second stronger:

1. **Baseline §7 rule 1** requires *"an ADR **before** the change"* for any Rank 1–5 document. Amending
   Rank 1 inside this act would be a Rank-1 edit riding on a conferral scoped to a runtime **selection**.
2. ⭐ **The precedent indicates the amendment may not be required at all.** `ADR-0046` selected Razorpay
   while `MASTER_PRD` **L232** read *"**Not named in EA** — candidate only"*, and its `Does NOT amend` row
   lists **`MASTER_PRD.md` (Rank 1)** explicitly. **L232 is still unamended today.** So an unamended
   *"candidate only"* cell beside an accepted vendor selection is an **already-ratified state** in this
   repository, not a defect this ADR creates. ⭐ `ADR-0116` §6 reached the same conclusion for the same cell.

⛔ **I therefore neither amend L227 nor assert that it must be amended.** Owner: **Architecture Owner /
Governance Owner**, requiring its own conferral.

### 7.2 Baseline test, performed rather than asserted

`DOCUMENTATION_BASELINE.md` **§7** (L377–383):

| Rule | Met? |
|---|---|
| 1 — A Rank 1–5 change needs an ADR **before** the change | ⛔ **Unmet** — **no Rank 1–5 document changes** |
| 2 — Version + changelog in the same commit | ⛔ **Unmet** — no ranked document is versioned |
| 3 — Declaration updated in the same commit | ⛔ **Unmet** — no declaration changes |
| 4 — Baseline identifier moves **only** for a Rank 1–3 version change | ⛔ **Unmet** |

⭐ **All four unmet ⇒ no version bump anywhere and `BASELINE-2026-09-03-A` STANDS.**

### 7.3 Cost disclosed, not hidden

⚠ A reader consulting only `MASTER_PRD` or only `PRD-001` will **not** find this selection — the same
condition `ADR-0046`, `ADR-0058`, `ADR-0116` and `ADR-0119`…`ADR-0123` created. A future Architecture-Owner
act **may** mirror it into Rank 1; ⛔ this ADR **neither performs nor requires** that, and mirroring into
**FROZEN** `PRD-001` is forbidden outright.

---

## §8 Changelog

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-08 | ⭐⭐⭐ **Created and ACCEPTED. The V1 AUTHENTICATION backend runtime is selected: `IMPL-020` §2.1 Option A — a managed BaaS, `Supabase`, hosting the OTP delivery adapter as an ADAPTER BEHIND A PORT, never as a layer.** Decided by the **Architecture Owner** under a **new one-act conferral** from the human principal — the *"exact authority action"* `IMPL-020` §2.1 routed upward (*"it is the Architecture Owner's to take"*) and §6 refused to take (*"Selects no backend. Supabase is not chosen"*). ⛔ **No prior conferral reused.** ⭐⭐ **FIVE PRECONDITIONS MEASURED BEFORE WRITING (§1.1):** `BLK-02` still **OPEN — not started**; the authentication runtime still **unselected**; **no** later ADR had resolved it; **`ADR-0124` free** (0 files, 0 references, max existing = `ADR-0123`); `IMPL-020` §2.1's three options still **current** at v1.0. ⭐⭐ **THE CENTRAL TRAP WAS TESTED AND REFUSED (§1.2):** a Supabase selection already exists — **`ADR-0116`** — but it is titled *"the V1 backend runtime for **`BC-30` Offline Sync**"*, lists **`IMPL-020`** under `Does NOT amend`, and its own §2.2 cites `IMPL-020` **L185/L280** as **non-selections**; and **`ADR-0123` §7.1's** *"Backend runtime ✅ RESOLVED"* refers to **Item 4 (`BC-30`)**, a different blocker in a different register section. ⛔ **Treating either as an authentication decision would be exactly the inference `ADR-0045` §2.1 / `ATT-GAP-005` forbid.** All five near-misses enumerated: `ADR-0116`, `ADR-0115` §8.3 (*"Selects no runtime, vendor, product, SDK…"*), `ADR-0100` L134, `ADR-0119` L124, `ADR-0123` §7.1 — plus Rank-1 **L227** (*candidate*) and **L271** (the Correction **demoting** Supabase from layer to adapter). **Not one was a selection**, which is why a conferral was genuinely required. ⭐⭐ **OPTIONS TESTED AGAINST EXISTING AUTHORITY ONLY, and the two rejections are asymmetric on purpose:** **Option C** (direct-from-client) is ⛔ **REFUSED on FIVE independent authorities**, four of them FROZEN or Rank 1 — `AUTH-3.12` (the code *"MUST NOT appear in any response, event, log, metric, error or analytics record"*), `X-03` (**forbidden edge** `domain → INTEGRATION`), Dependency Matrix **L167**, `MP-CON-01`, and the checklist's own **L58–L60** (*"If the code reaches the client in any environment, the authentication factor does not exist. **`D-10` happened exactly this way**"*) — ⭐ so Option C would **reconstruct the `D-10` defect by design**; **Option B** (dedicated backend service) is ⚠ **NOT SELECTED but expressly NOT REFUSED** — it is **lawful**, breaches nothing, and ⭐ **`MP-CON-03` exists precisely so it remains reachable later** (*"a dedicated backend can replace direct BaaS access later"*), so selecting A **preserves B rather than foreclosing it**; it loses on measured grounds — `IMPL-020` §2.1's *"**nothing in the repo specifies deployment**"*, Rank-1 **L227**'s *"BaaS … **for V1**"*, and `MP-DEP-03`'s *"**V1 launch — authentication cannot function without it**"* placing the runtime on the critical path of the only sign-in route. **Option A** satisfies `MP-CON-01`, `MP-CON-02` (⛔ **0** of the 25 approved platforms collapsed, merged, renamed or removed), `MP-CON-03`, and is **consistent with** FROZEN `AUTH-3.5` (⭐ a runtime **hosts** an adapter — it does **not** relocate transport ownership, and Notification routing is unchanged), `AUTH-3.12`, `AUTH-11.51` (⭐ preserved **in full**, since the *delivery provider* is **not** selected here) and `PRD-001` **L952**. ⚠⚠ **`MP-RSK-05` IS ACKNOWLEDGED, NOT DISMISSED (§4.4)** — Rank 1 rates BaaS lock-in **High**; its own stated mitigation is `MP-CON-01`/`02` plus the load-bearing abstraction, which §2's *adapter-not-layer* clause restates; ⛔ **the risk is not closed here.** ⚠⚠ **`BLK-02` IS NOT CLOSED (§6)** — it has **three** limbs and this act discharges **one**: **DLT registration** stays OPEN (Rank 1 `MP-DEP-03`, **External**, *"the only item whose duration the team cannot compress"*) and **SMS provider** stays OPEN (⭐ low urgency: `IMPL-020` §1.3 measures **PROVIDER DECISION 0** of 11 obligations and states *"No obligation requires the provider's identity"*). ⭐ **What IS unblocked, narrowly (§6.1):** `IMPL-020`'s four *"⚠ BACKEND DECISION"* items now have the premise item 9 said they lacked (*"'server logs' presumes a server; **none is approved**"*) — ⛔ but they are **not answered**. ⚠ **`BLK-01`/`TASK-D10` is NOT unblocked** — *"the peek **cannot be removed until a real delivery path exists**"*, and ⭐ **a runtime is not a delivery path**; `TASK-D10` is byte-unchanged and stays **P0/OPEN**. ⛔⛔ **NOTHING ELSE AUTHORISED (§5):** no SMS provider, DLT registration, template, sender ID, `AERR-*`, cloud account/project/region/tier, schema, function, dependency, SDK, port, module, manifest block, edge, secret format, credential, rotation policy, vault configuration, deployment locus for authentication (⚠ `ADR-0115` §8.1/§8.2's SECURITY-PLATFORM and INFRASTRUCTURE/DEVOPS assignments are **`BC-30`-scoped** and are **NOT widened**), price, endpoint or rate limit; `IMPL-020` **Gaps A and B stay OPEN**. ⛔⛔ **AMENDS NOTHING** — `MASTER_PRD` (incl. **L227**, **L271**), **FROZEN `PRD-001`** (⛔ **0** `AUTH-*`/`BR-*`/`AC-*`/`XC-*` identifiers minted, moved or altered), **FROZEN `PRD-006`**, **FROZEN `PRD-012a`**, every other frozen PRD, the BC Map, the Dependency Matrix, the EA, `DOCUMENTATION_BASELINE`, `PRD_OWNERSHIP_MODEL`, `ADR-0045`, `ADR-0046`, `ADR-0002`, `ADR-0114`, `ADR-0115`, `ADR-0116`, ⛔ **`ADR-0119`, `ADR-0120`, `ADR-0121`, `ADR-0122`, `ADR-0123`**, `TASK-D10` and `tool/module_dependencies.yaml` are all **byte-unchanged**; **§7 rules 1–4 each tested and ALL UNMET**, so **no version bump anywhere** and **`BASELINE-2026-09-03-A` STANDS**. ⚠ **Rank-1 L227 NOT amended (§7.1)** — on the measured `ADR-0046`/**L232** precedent, where an accepted vendor selection has coexisted with an unamended *"candidate only"* cell since 2026-08-16; routed as a separate act, and ⛔ **not asserted to be required**. ⚠ Cost disclosed (§7.3): a `MASTER_PRD`-or-`PRD-001`-only reader will not find this selection; mirroring is **neither performed nor required**. ⛔ **No standing authority**; the office is **VACANT** after this act; **no person appointed** (§7 rule 4). ⛔ **Implementation authorised: No** — ⭐ **selecting a runtime is not permission to build on it**; **0** `IMPL-*`, **0** code/config/dependency/infrastructure files. |
