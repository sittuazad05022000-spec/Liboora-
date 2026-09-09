# `IMPL-020` — ARCHITECTURE OWNER DECISION PREPARATION

| Field | Value |
|---|---|
| **Document** | `IMPL-020_ARCHITECTURE_OWNER_DECISION_PREPARATION.md` |
| **Version** | **v1.2** |
| **Date** | 2026-09-07 |
| **Subject** | `IMPL-020` — SMS provider + DLT template registration (`MP-DEP-03`) |
| **Written at** | `fc91ebbff36ad5750175fb6af3969ec54b73fdf3` (`github/main`) |
| **Type** | **Decision-preparation record.** It audits authority, identifies options and states trade-offs |
| **Act** | 🔍 **PREPARATION.** ⛔ **Not** a PRD · **not** an ADR · **not** an approval · **not** an ARB ruling · **not** a freeze · **not** a baseline · **not** a conferral |
| **Decision authority exercised** | ⛔ **NONE.** Every recommendation is a **recommendation**. **0** decisions are taken |
| **Approvals asserted** | ⛔ **None.** No Architecture Owner approval, ARB ruling, Security or Privacy review is claimed |
| **ADRs created** | ⛔ **Zero.** No ADR number is invented or reserved |
| **Provider selected** | ⛔ **None.** MSG91 appears **only** as a candidate — ⭐ **still true and unchanged.** ⚠⚠ **BUT THE BACKEND CLAUSE IS SUPERSEDED BY A LATER ACT:** the **backend runtime IS now selected** — `Accepted` **`ADR-0124`** (2026-09-08, **Architecture Owner**, one act) chose **§2.1 Option A — a managed BaaS, `Supabase`** — so this row's original *"Supabase is NOT selected"* is **no longer a true statement of repository state**. ⭐ It remains true **of this document**, which selected nothing then and selects nothing now — **§2.1 and §6 are BYTE-UNCHANGED**, and `ADR-0116` §2.2 plus `ADR-0124` §1.2 both cite **L185** and **L280** as evidence of that refusal, so neither line is edited. ⛔ **No SMS provider is selected and no DLT registration is performed.** *(Prior text, correct until `ADR-0124`: "⛔ **None.** MSG91 appears **only** as a candidate. **Supabase is NOT selected**".)* |
| **Convention followed** | `PRD-015_FINAL_ARCHITECTURE_DECISION_PREPARATION.md` (the existing decision-preparation precedent) and the **method** of `ACCEPTED` [`ADR-0045`](../00-governance/adr/ADR-0045-fee-gap-010-gateway-provider-authority-stop.md) |

> ⚠ **`ADR-0045` is the governing precedent, not merely a citation.** Asked to ratify a payment
> gateway, it **STOPPED**, returned the choice to the **Architecture Owner**, and recorded its
> candidate as *"RECOMMENDED DIRECTION and as a recommendation only — deliberately kept out of every
> register, gap field, PRD and requirement, **because writing it there is what would make it look
> accepted**."* This document copies that discipline exactly.

---

## 1. FACTS FROM REPOSITORY

Every claim below carries file + line. Nothing here is inferred from memory.

### 1.1 Backend / BaaS candidates — none is approved

`MASTER_PRD.md` **§L222** heads the column **"Approved in EA v2.1?"**. Measured:

| Capability | Candidate (V1) | Approved in EA v2.1? | Line |
|---|---|---|---|
| Persistence | Managed PostgreSQL | ⛔ **"Not named in EA — candidate only"** | **L226** |
| **Backend runtime** | **BaaS (e.g. Supabase) for V1** | ⛔ **"Not named in EA — candidate only"** | **L227** |
| File storage | BaaS storage | ⛔ **"Not named in EA — candidate only"** | **L228** |
| Push notifications | **Firebase Cloud Messaging** | ✅ **"Yes — FCM (V1)"** | **L229** |
| Crash reporting | **Firebase Crashlytics** | ✅ **"Yes — Crashlytics (V1)"** | **L230** |
| AI inference | LLM vendor | ⛔ candidate only | **L231** |
| Payments | Gateway | ⛔ candidate only | **L232** |

⭐ **The table proves approval is expressible.** Two rows say **"Yes"**. The backend-runtime row does
not. Its silence is therefore a **measured non-approval**, not an omission to be read as assent.

⛔ **Supabase is explicitly NOT a layer.** `MASTER_PRD.md` **L271**: *"v1.0 terminated this stack with
`Supabase`. Naming a vendor as a layer contradicts the sentence immediately following it in v1.0 —
'The Data Layer must remain abstract so a dedicated backend can replace direct Supabase access
later' — **a layer you can swap is an adapter, not a layer.** The requirement is preserved as
`MP-CON-03`; only the diagram was corrected."*

⚠ **Measured in code:** `pubspec.yaml` declares **five** dependencies — `flutter`,
`cupertino_icons`, `liboora_contracts`, `provider`, and the local-storage trio
(`shared_preferences`, `hive`, `hive_flutter`). **No `supabase_flutter`, no HTTP client, no backend
SDK.** There is no Supabase project in this repository to build a hook against.

### 1.2 Constraints on SMS-provider integration

| # | Constraint | Source | Effect |
|---|---|---|---|
| 1 | *"The platform MUST be able to switch delivery providers **without any change to this specification**"* | **`AUTH-11.51`**, `Authentication_PRD_v2.md` **L4427** (FROZEN, Rank 3) | The provider **must** sit behind a port |
| 2 | *"Authentication **MUST NOT** implement message transport. It **MUST** request delivery from Notification"* | **`AUTH-3.5`**, **L910** (FROZEN, Rank 3) | ⚠⚠ **CORRECTED 2026-09-09 by `Accepted` [`ADR-0128`](../00-governance/adr/ADR-0128-r3-bc-18-to-bc-31-v1-otp-transport-edge-e-33.md) — the prior conclusion was an INFERENCE, and it was FALSE.** ⭐ `AUTH-3.5` forbids *implementing transport*; it does **not** forbid **calling a port**. `BC-18` requests delivery over the port `tool/module_dependencies.yaml` **L437–439** has declared since **`a2caa22`** — *"the single sanctioned bypass of `platform/communication`, **for possession challenge delivery only**"* — and **`BC-31` performs the transport** (BC Map **L140**). ⭐ The route is **`BC-18` → `BC-31`**, ratified as **`E-33`** (BC Map **§19.1**). ⛔ `AUTH-3.5` is **preserved unweakened**. *(Prior text, an inference that was FALSE from the outset: "⭐ **`BC-18` may not call an SMS provider at all**".)* |
| 3 | *"The code **MUST NOT** appear in any response, event, log, metric, error or analytics record"* | **`AUTH-3.12`**, **L923** | Constrains every adapter and every log line |
| 4 | *"The Data Layer must remain abstract so a dedicated backend can replace direct BaaS access later"* | **`MP-CON-03`**, `MASTER_PRD.md` **L239** (Rank 1) | No direct BaaS calls above the adapter |
| 5 | SMS provider + **DLT template registration** — **External**, *"V1 launch — authentication cannot function without it"* | **`MP-DEP-03`**, **L570** (Rank 1) | Classified **External**: outside engineering control |
| 6 | *"The domain must not know that Razorpay, Twilio or FCM exist. It emits facts and calls ports"* | Dependency Matrix **L167** (Rank 4) | Vendor names are forbidden in the domain |
| 7 | **`X-03`** `domain → INTEGRATION` — *"Vendor lock-in inside the core domain; untestable; breaks gateway abstraction"* | Dependency Matrix **L352** (Rank 4) | A forbidden edge, mechanically checked |
| 8 | *"Domain emits **facts** … never 'send an SMS'"* | BC Map **E-23**, **L332** (Rank 4) | Delivery intent is never an event payload |
| 9 | *"If an edge is not in this table, it **does not exist** and adding it requires an ADR"* | BC Map **L292** (Rank 4) | Governs every routing question below |
| 10 | Two `ACCEPTED` freeze ADRs list **"Name an SMS provider"** among acts they did **NOT** perform | `ADR-0086` **L171**, `ADR-0087` **L200** | Naming a provider has been **repeatedly deferred**, not overlooked |

### 1.3 OTP delivery — owning context, module and rank

| Question | Measured answer | Source |
|---|---|---|
| Who owns **OTP** as a concept? | **`BC-18` Identity & Access** — *"Owns credentials, sessions, devices, **OTP**, roles, permissions, policy decisions, consent"* | BC Map **L127** |
| May `BC-18` transport the message? | ⛔ **No.** *"Authentication MUST NOT implement message transport"* | `AUTH-3.5`, **L910** |
| Who owns **delivery**? | **`BC-22` Notification Delivery** — *"Owns channel selection, templates, deduplication, quiet hours, delivery guarantees, consent/unsubscribe"* | BC Map **L131** |
| Who owns the **vendor contract**? | **`BC-31` Integration** — *"Owns outbound third-party contracts, credentials, retries, idempotent delivery"* | BC Map **L140** |
| `BC-18` module / rank | `platform/identity`, **rank 4** | `module_dependencies.yaml` **L36**, **L431** |
| `BC-22` module / rank | `platform/communication`, **rank 5** | **L38**, **L392** |
| `BC-31` module / rank | `platform/integration`, **rank 5** | **L40** |
| Does `platform/communication` already hold the connector port? | ✅ **Yes** — `platform/integration:connector` | **L397** |

⚠⚠ **THE ROUTE BELOW IS SUPERSEDED. CORRECTED 2026-09-09 by `Accepted` [`ADR-0128`](../00-governance/adr/ADR-0128-r3-bc-18-to-bc-31-v1-otp-transport-edge-e-33.md).**
⭐ **The ratified V1 OTP route does NOT pass through `BC-22`:**

```
BC-18 Identity  ──sso_provider port (yaml L437-439)──▶  BC-31 Integration  ──▶  SMS vendor
   (owns OTP)        E-33 · CF · Sync port                 (owns contract)
```

⛔ **Why the superseded route was unlawful**, on four authorities that outrank this document:
**FROZEN `AUTH-10.37`** (*"the OTP … **MUST NOT** pass through any general notification path"*) ·
**`PRD-010` §5 N7** (OTP SMS **excluded** from `BC-22`) · **`NTF-FR-030`** (*"V1 integrated channels
are **exactly** In-App and Push"*) · and ⭐ the **functional** reason — `MP-GBR-35` + `NTF-FR-039`
make quiet hours *"defer, never drop"*, while `AUTH-3.8` expires the challenge in **5 minutes**, so
the general path would **break the authentication factor**.

*(Prior text, retained verbatim for audit — correct until `ADR-0128`:)*

> ⭐ **The lawful route is therefore already three-quarters built and needs no invention:**
>
> ```
> BC-18 Identity  ──requests delivery──▶  BC-22 Notification  ──connector port──▶  BC-31 Integration  ──▶  SMS vendor
>    (owns OTP)        AUTH-3.5              (owns channel)        L397 (exists)        (owns contract)
> ```

### 1.4 ⚠ THREE STRUCTURAL GAPS, measured — the real blockers

**Gap A — `platform/services` has no module block (`FIL-GAP-010`).**
`platform/services` is **ranked 3** (**L33**) and five of its ports are consumed (`files`, `qr`,
`idempotency`, `offline_sync`, `clock` — **L110**–**L114**), but it has **no module block**, so its
imports, banned imports and assertions are undeclared and unenforced. `PRD-017` records the same
finding: *"`platform/services` has no module block in the manifest, so the boundary is unenforced —
the identical defect `PRD-023` carried as `B-1`"* (`FIL-GAP-010`, **OPEN**).

⚠ **This audit measured the gap to be WIDER than `FIL-GAP-010` states.** **7 of 22** ranked modules
have no block:

| Missing block | Rank |
|---|---|
| `platform/infrastructure` | 1 |
| `platform/data` | 2 |
| `platform/security` | 2 |
| `platform/configuration` | 3 |
| `platform/observability` | 3 |
| **`platform/services`** | **3** |
| `platform/event` | 3 |
| **`platform/integration`** | **5** |

⛔ **`platform/integration` — the module that would hold the SMS vendor adapter — is among them.**
It is ranked and its `connector` port is consumed at **L288**, **L343** and **L397**, but the module
itself declares nothing. That is a **Rank-4 manifest gap directly on `IMPL-020`'s path.**

*(Recorded as a measurement. This document opens no identifier and amends no register — `FIL-GAP-010`
belongs to FROZEN `PRD-017` and only its owner may widen it.)*

**Gap B — no `BC-22 → BC-31` edge exists in BC Map §7.**
Measured: **0** rows match `BC-22 … BC-31`. The only edge into `BC-31` is **`E-25`**
`BC-20 Billing → BC-31` (**L334**). So while `platform/communication` **declares** the
`platform/integration:connector` port at **L397**, the **context-level edge that would authorise
Notification to reach Integration is absent from the Rank-4 register** — and **L292** rules that an
edge not in the table *"does not exist and adding it requires an ADR."*

⚠ This is the **same shape** as `ADR-0016` / `ADR-0055` / `ADR-0095`: a module-grained grant existing
where the context-grained register is silent. `ADR-0055` ruled that in such a conflict **the map is
the incomplete record** — but repairing it is an **Architecture Owner** act, not an implementer's.

**Gap C — no backend runtime is approved.**
Per §1.1. Until decided, *where* an adapter executes is undetermined: an OTP provider call carries a
secret API credential, which cannot live in a distributed Flutter client under any provider.

### 1.5 `IMPL-020` Block-1 obligations, classified

All **11** checkboxes, verbatim from `AUTHENTICATION_IMPLEMENTATION_CHECKLIST.md` **L41–L57**:

| # | Obligation (verbatim) | Classification |
|---|---|---|
| 1 | *"Provider behind an interface — swappable per `AUTH-11.51`"* | ⚠ **BACKEND DECISION** — the interface is codeable, but its **module has no manifest block** (Gap A) and its **edge does not exist** (Gap B). Writing it first would settle a Rank-4 question by implementation |
| 2 | *"DLT-registered transactional template (TRAI)"* | 🔴 **DLT-HUMAN BLOCKER** |
| 3 | *"Code is **6 numeric digits** — structural, not configurable"* | 🟢 **CODE NOW** |
| 4 | *"Validity **5 minutes** — structural"* | 🟢 **CODE NOW** |
| 5 | *"**Single-use** — a verified code cannot be reused"* | 🟢 **CODE NOW** |
| 6 | *"**One concurrent challenge per number** — requesting again replaces, never accumulates"* | 🟢 **CODE NOW** |
| 7 | *"**5 verification attempts** per challenge, then the challenge dies"* | 🟢 **CODE NOW** |
| 8 | *"Delivery failure maps to its own `AERR-*`, distinct from a wrong code"* | ⚠ **BACKEND DECISION** — the error identifier is codeable; *which* failures exist depends on the transport |
| 9 | *"Development sink writes the code to **server logs only**"* | ⚠ **BACKEND DECISION** — *"server logs"* presumes a server; none is approved |
| 10 | *"**The code never appears in any client response, header, or field** ⚠"* | 🟢 **CODE NOW** — and it is already **violated** by `D-10`/`TASK-D10` |
| 11 | *"Test sink is a fake gateway in `test/` — not in `lib/`"* | 🟢 **CODE NOW** |

**Totals: 🟢 CODE NOW 6 · ⚠ BACKEND DECISION 4 · 🔴 DLT-HUMAN 1 · PROVIDER DECISION 0.**

⭐ **No obligation requires the provider's identity.** That is the most useful finding here: naming
MSG91 unblocks **nothing** on this list. What blocks it is the **backend runtime** and **DLT**.

⚠ **Checklist L58–L60 states the load-bearing rule:** *"**The single most important line in this
document.** If the code reaches the client in any environment, the authentication factor does not
exist. `D-10` happened exactly this way."*

⚠ **Current code:** `lib/platform/identity/identity.dart` **L363** `requestOtp`, **L379**
`debugPeekChallenge`, **L401** `verifyOtp` — an in-memory challenge with a debug peek. That peek is
the `D-10` surface (`TASK-D10`, **P0** under `MP-CON-11`), and it **cannot be removed until a real
delivery path exists**, or the app loses its only sign-in route.

---

## 2. RECOMMENDATIONS

⛔ **Recommendations only. Deliberately kept out of every register, gap field, PRD and requirement.**

### 2.1 Backend runtime — options and measured trade-offs

| Option | What it means | Trade-offs (measured) |
|---|---|---|
| **A — BaaS (Supabase or equivalent)** | Serverless functions host the adapter | ⭐ Fastest to a working OTP; matches the `MASTER_PRD.md` **L227** *candidate*. ⚠ **Not approved**; needs an ADR to move L227 from *"candidate only"*. ⚠ `MP-CON-03` still requires the port, so **BaaS is an adapter, never a layer** (**L271**) |
| **B — Dedicated backend service** | A service the team owns and deploys | ⭐ Full control of secrets, logging and retries; satisfies checklist item 9's *"server logs"* literally. ⚠ Largest effort; nothing in the repo specifies deployment |
| **C — Provider called direct from the Flutter client** | No backend | ⛔ **NOT RECOMMENDED — refuse.** Ships the provider API key to every device; `AUTH-3.12` forbids the code appearing in any client surface, and `X-03`/L167 forbid vendor knowledge crossing inward. Listed so the option is visibly refused rather than silently skipped |

⭐ **Recommended direction: Option A**, as the L227 candidate and the smallest step — **but it is the
Architecture Owner's to take.** ⛔ This document does **not** select Supabase.

### 2.2 SMS provider — candidates

⚠ **`MSG91` is listed as a RECOMMENDED CANDIDATE ONLY. It is NOT selected.** No other Indian
transactional-SMS vendor is excluded by this listing.

⛔ **No pricing, minimum recharge, API endpoint, header name, rate limit, credential format, sender
ID or DLT identifier is stated anywhere in this document**, because none is in the repository and
inventing one is precisely what `ADR-0045` §3 refused: *"A named hole is honest; an invented contract
is not."* Those are **commercial facts** to be obtained from the provider and the DLT operator
against your legal entity, and they are **out of scope for this preparation**.

⭐ **Provider selection is genuinely low-urgency**, and the evidence says so: **0 of 11** Block-1
obligations depend on the provider's identity, and `AUTH-11.51` requires the platform to switch
providers *"without any change to this specification"*. **A provider chosen late costs almost
nothing; DLT started late costs weeks.**

### 2.3 Sequencing

```
NOW  (parallel, no dependency between them)
  ├── EXTERNAL: begin DLT registration            ← the only multi-week item
  └── DECISION 1: backend runtime (ADR)
            ↓
      DECISION 2: manifest + edge repair (ADR)     ← Gaps A and B
            ↓
      DECISION 3: SMS provider (ADR)               ← may be taken any time before build
            ↓
      CODE: swappable port · fake gateway in test/ · the 6 CODE-NOW obligations
            ↓
      TASK-D10 (remove demo surfaces) — unblocked only once real delivery exists
```

---

## 3. DECISIONS REQUIRED FROM THE ARCHITECTURE OWNER

Each needs its **own** `ACCEPTED` ADR. `ADR-0033` §7.1: *"A conferral for one act is not a standing
licence."* ⛔ **None is taken here, and no ADR number is reserved.**

| # | Decision | Authority | Why an ADR is required |
|---|---|---|---|
| **D1** | **Backend runtime for V1** | **Architecture Owner** | Moves `MASTER_PRD.md` **L227** off *"candidate only"*. `MASTER_PRD.md` is **Rank 1**; `DOCUMENTATION_BASELINE.md` §7 rule 1 requires *"an ADR **before** the change"* |
| **D2** | **Manifest module blocks** — at minimum `platform/integration` and `platform/services` (Gap A), **and** the `BC-22 → BC-31` edge (Gap B) | **Architecture Owner** — *"boundaries, ownership, permitted edges"* (`PRD_OWNERSHIP_MODEL.md` §2.2/§2.3) | Both are **Rank 4**. BC Map **L292**: an absent edge *"does not exist and adding it requires an ADR"*. Same shape as `ADR-0016`/`ADR-0055`/`ADR-0095` |
| **D3** | **SMS provider** | **Architecture Owner** | The `ADR-0045` precedent exactly: a provider is not ratifiable from repository authority. `ADR-0086` **L171** and `ADR-0087` **L200** each declined to name one |

⚠ **D2 is the most easily overlooked and the most structural.** Without it, an OTP port would be
written into a module the boundary checker cannot govern, across a context edge the Rank-4 register
says does not exist. That would resolve an architecture question **by implementation** — the failure
mode `ADR-0055` and `ADR-0095` were each written to correct.

⚠ **Scope note on D2:** the block gap affects **7** modules, not 2. Whether to repair all seven or
only `IMPL-020`'s path is itself the Architecture Owner's call; the narrow repair is sufficient for
`IMPL-020` and is the smaller act.

---

## 4. EXTERNAL / HUMAN & DLT ACTIONS

⭐ **These are true regardless of which provider is chosen** and are the **only multi-week items**.
`MP-DEP-03` (**L570**) classifies this dependency **External** — outside engineering control.

| # | Action | Who | Provider-independent? |
|---|---|---|---|
| **H1** | **Entity registration** on a TRAI DLT platform, using the legal entity's registration documents | Human principal / business owner | ✅ Yes |
| **H2** | **Header (Sender ID) registration** and approval | Human principal | ✅ Yes |
| **H3** | **Transactional OTP template registration** and approval. The template must accommodate a **6-digit numeric** code (checklist item 3: *"Digits are required by DLT"*) | Human principal, with engineering input on the placeholder | ✅ Yes |
| **H4** | Commercial account with a transactional SMS provider, and its **linkage to the DLT entity/header/template** | Human principal | ⚠ Provider-specific once D3 is taken |

⛔ **No fee, turnaround time, document list, portal name or provider-specific step is stated**, as
none is in the repository. Obtain them from the DLT operator and provider directly.

⚠ **`TASK-D10` cannot complete until H1–H4 and D1 land.** `ADR-0085` **L245** records exactly this:
the task *"cannot complete before a real OTP delivery path exists"*.

---

## 5. NEXT SAFE STEP

⭐ **Start H1–H3 today.** They are external, multi-week, on the critical path, and depend on **none**
of D1/D2/D3. `PRODUCT_IMPLEMENTATION_ROADMAP.md` Wave 0 item 0.1 says the same: *"Start 0.1 today
even though it is not the most interesting work. It is the only item whose duration is set by an
external party, and every day it is not started is a day added to the launch date directly."*

**In parallel, the Architecture Owner takes D1, then D2.** D3 may follow at any point before build.

⛔ **No code should be written until D1 and D2 are `ACCEPTED`.** The six 🟢 CODE-NOW obligations are
real, but they live inside a port whose module and edge are exactly what D2 decides — so writing
them first would prejudge D2.

---

## 6. What this document does NOT do

- ⛔ **Selects no backend.** Supabase is **not** chosen; `MASTER_PRD.md` **L227** is untouched
- ⛔ **Selects no SMS provider.** MSG91 is a **candidate**, named nowhere but §2.2
- ⛔ **Creates no ADR** and reserves no ADR number
- ⛔ **Amends no PRD**, frozen or otherwise; opens, closes and widens **no** identifier —
  `FIL-GAP-010` is cited as measured, not edited
- ⛔ **Changes no manifest, no test, no tool, no code, no configuration** — 0 files besides itself
- ⛔ **Invents no** price, fee, rate limit, endpoint, credential, sender ID, template ID, DLT
  identifier or turnaround time
- ⛔ **Confers no lifecycle stage** and closes no acceptance criterion
- ⚠ **Resolves no blocker.** `IMPL-020` and `TASK-D10` both remain **P0 and OPEN**

---

## 7. Changelog

| Version | Date | Change |
|---|---|---|
| **v1.2** | 2026-09-09 | ⭐⭐ **TWO SUBSTANTIVE CORRECTIONS — THIS DOCUMENT'S OTP ROUTE WAS WRONG, AND `Accepted` [`ADR-0128`](../00-governance/adr/ADR-0128-r3-bc-18-to-bc-31-v1-otp-transport-edge-e-33.md) SUPERSEDES IT.** ⛔ **This is the first change to this document's SUBSTANCE**, not merely its header. **(1) L63** asserted *"⭐ **`BC-18` may not call an SMS provider at all**"* — an **inference** from `AUTH-3.5`, and **FALSE from the outset**: `AUTH-3.5` forbids *implementing transport*, not *calling a port*. **(2) §1.3's route diagram** showed `BC-18 → BC-22 → BC-31`, which is unlawful on four authorities that outrank this document — **FROZEN `AUTH-10.37`**, **`PRD-010` §5 N7**, **`NTF-FR-030`**, and ⭐ the **functional** bar (`MP-GBR-35` + `NTF-FR-039` defer, `AUTH-3.8` expires in 5 minutes, so the general path would **break the authentication factor**). ⭐⭐ **THE RATIFIED ROUTE IS `BC-18` → `BC-31`**, minted as **`E-33`** in BC Map **§19.1**, over the port `tool/module_dependencies.yaml` **L437–439** has declared since **`a2caa22`** — *"the single sanctioned bypass of `platform/communication`, **for possession challenge delivery only**"*. ⭐ **The answer was in the manifest all along; §1.3 never read it** — the `ADR-0014` method. ⚠ **BOTH PRIOR TEXTS ARE RETAINED VERBATIM** (L63 parenthetically, §1.3 as a block quote), so the audit trail is intact. ⚠⚠ **CITATION COST: NOT ZERO, AND THE FIRST DRAFT OF THIS ROW CLAIMED OTHERWISE — THE ERROR IS CORRECTED HERE RATHER THAN LEFT STANDING.** A draft of this changelog asserted *"CITATION COST: ZERO SHIFTED … L159 and L185 are re-verified unmoved"*. ⛔ **That was FALSE, and post-write verification caught it.** **L63 is edited strictly in place (0 shift)**, but the §1.3 correction **adds 17 lines**, so every citation below it moved by **+17**: **L159 → L176** (`IMPL-020` §1.3's *"MSG91 unblocks nothing"*, cited in the blocker register), **L185 → L202** and **L280 → L297** (both cited by **`ADR-0116` §2.2** and **`ADR-0124` §1.2** as the measured evidence that this document *"does **not** select Supabase"*). ⭐ **The cited SENTENCES are byte-unchanged and still true of this document** — only their line numbers moved — so the three citing ADRs remain substantively correct and are ⛔ **NOT edited here**: `ADR-0116` and `ADR-0124` are `Accepted` and outside this conferral. ⚠ **The stale line numbers are RECORDED as a follow-up for the Architecture Owner**, in the same shape as the R2 repair, and ⛔ **not silently patched**. ⭐ An in-place-only correction was not available: superseding a six-line code block while retaining it verbatim necessarily adds lines. ⛔ **`sso_provider` is NOT renamed** (AO-2 accepted it as-is) and the manifest is **byte-unchanged**. ⛔ **NOTHING ELSE CHANGES:** §2 recommendations, §3 decisions, §4 external actions, §5 next step and §6 boundaries are **byte-unchanged**; **Gap A** stays closed by `ADR-0126` D2-A and **Gap B** stays open for `E-32`/M2. ⛔ **NO delivery path is created** — no SMS provider (**D3**), no DLT registration (**H1–H3**); **`IMPL-020`, `BLK-01`, `BLK-02`, `TASK-D10`, `MP-DEP-03` and Gate 3 all remain OPEN/red**, because ⭐ **a route is not a delivery path**. |
| **v1.1** | 2026-09-08 | ⭐⭐ **RECORDS THAT THE DECISION THIS DOCUMENT PREPARED HAS BEEN TAKEN.** `Accepted` **`ADR-0124`** (Architecture Owner, one-act conferral from the human principal) selects **§2.1 Option A — a managed BaaS, `Supabase`** as the **V1 authentication backend runtime**, hosting the OTP delivery adapter as an **adapter behind a port, never as a layer**. ⭐ This is exactly the act §2.1 routed upward (*"it is the **Architecture Owner's** to take"*). ⛔⛔ **NOTHING IN THIS DOCUMENT'S SUBSTANCE CHANGES — §1, §2, §3, §4, §5, §6 are BYTE-UNCHANGED**, and **only TWO header lines were edited, strictly in place**: **L6** `Version` v1.0 → v1.1 and **L15** `Provider selected`. ⭐⭐ **L15's original text was retained verbatim in parentheses**, because it was **true when written** and remains true *of this document*; what changed is the **repository state** it described. ⚠⚠ **L185 and L280 were deliberately NOT edited** — `ADR-0116` §2.2 and `ADR-0124` §1.2 both cite them **by line number** as the measured evidence that this preparation *"does not select Supabase"*, and that statement about the document is **still accurate**; editing them would have destroyed two live citations and falsified nothing. ⚠ **CITATION COST: ZERO** — the file is 298 lines and both edits are in-place substitutions above every cited line, so **0** citations shifted. ⛔ **NO SMS PROVIDER IS SELECTED** — MSG91 remains a **candidate only** (§2.2 unchanged), and `IMPL-020` §1.3's measurement stands: **PROVIDER DECISION 0** of 11 obligations depend on the provider's identity. ⛔ **NO DLT REGISTRATION IS PERFORMED** — Rank 1 `MP-DEP-03` classifies it **External**, *"outside engineering control"*. ⛔ **`IMPL-020` AND `BLK-02` REMAIN P0 AND OPEN** on their two remaining limbs; ⚠ **`TASK-D10` is NOT unblocked**, because the debug peek *"cannot be removed until a real delivery path exists"* and ⭐ **a runtime is not a delivery path**. ⛔ **Gap A** (no manifest block) and **Gap B** (no edge) remain **OPEN**. ⛔ **No implementation, configuration, cloud resource, dependency, SDK, schema, credential or code** is authorised or performed — **0** files besides this one and the two registers; `MASTER_PRD` **L227** untouched; all frozen PRDs byte-unchanged. |
| **v1.0** | 2026-09-07 | **Created as decision preparation for `IMPL-020`.** Follows the `PRD-015_FINAL_ARCHITECTURE_DECISION_PREPARATION.md` convention and the `ADR-0045` STOP method. ⭐ **Central finding: the provider is NOT the blocker.** All **11** Block-1 obligations were classified and **0** depend on the provider's identity — **6** are codeable now, **4** await the backend decision, **1** is external DLT. ⭐ **The lawful route was determined, not assumed:** `AUTH-3.5` (**L910**) forbids `BC-18` from implementing transport, so OTP delivery is `BC-18` → `BC-22` → `BC-31`, and `platform/communication` **already declares** the `platform/integration:connector` port (**L397**). ⚠ **Three structural gaps measured, two of them previously unrecorded in this context:** (A) **7 of 22** ranked modules have no manifest block — wider than `FIL-GAP-010` states — and the missing set **includes `platform/integration`**, the module that would hold the SMS adapter; (B) **no `BC-22 → BC-31` edge exists** in BC Map §7 (measured **0** rows; the only edge into `BC-31` is `E-25` from `BC-20`), which **L292** rules *"does not exist"*; (C) no backend runtime is approved. ⛔ **Nothing decided:** 0 ADRs, 0 providers, **Supabase NOT selected**, MSG91 recorded as candidate only, and **no pricing, endpoint, credential, sender ID or DLT identifier invented** — the `ADR-0045` §3 rule that *"a named hole is honest; an invented contract is not"*. |
