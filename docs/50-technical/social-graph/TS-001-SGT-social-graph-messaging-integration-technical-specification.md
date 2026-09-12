# `TS-001` — `PRD-021B` Social Graph, Discovery & Messaging: integration-level Technical Specification

| Field | Value |
|---|---|
| **Document** | `TS-001` |
| **Version** | **v0.1** |
| **Date** | 2026-09-11 |
| **Status** | ⛔ **`DRAFT`** — ⛔⛔ **NOT approved, NOT frozen, NOT authoritative.** ⭐ *"Becomes a **governed document** only when an **Accepted ADR** admits it"* (`PRD_LIFECYCLE.md` §7A.8). ⛔ **This document does NOT claim its own status** (`ADR-0131` §8.2 **`P-7`**) |
| **Class** | Technical Specification — constituted by `Accepted` [`ADR-0131`](../../00-governance/adr/ADR-0131-constitute-technical-specification-governance.md) |
| **Lifecycle stage** | **`6A`** — `PRD_LIFECYCLE.md` §7A. ⛔ The subject PRD's registry status remains **`APPROVED`** (§7A.2); ⛔ **no new status is created** |
| **Rank** | ⛔⛔ **UNRANKED.** `PRD_LIFECYCLE.md` §7A.7: *"An admitted Technical Specification is **governed but UNRANKED** … in any disagreement **the ranked document wins by default**"* (`TSG-GAP-004`, **OPEN**) |
| **Subject** | `PRD-021B` Social Graph, Discovery & Messaging — **Part B9**, Technical & Production Architecture |
| **Requirement identifier stem** | ⭐ **`SGT`** — declared here per `ADR-0131` §5.2; collision-measured **0** in four directions (§2.2) |
| **Requirement identifier form** | `TS-001-SGT-<nnn>` — `ADR-0131` §5.2 |
| **⭐⭐ Authorising conferral** | ⭐⭐ **`Accepted` [`ADR-0140`](../../00-governance/adr/ADR-0140-b9-nominated-single-stage-6a-subject-four-office-conferral-ts-001-authorised.md)** — see §1 |
| **⛔ Offices** | ⛔⛔ **NO OFFICE IS RECORDED AS OCCUPIED.** §1 records which office is **required** and by which **conferral** it was exercised — `PRD_LIFECYCLE.md` §7A.6 |

---

## 1. ⭐⭐ Authority — which office is required, and by which conferral it was exercised

`PRD_LIFECYCLE.md` §7A.6 is explicit and is obeyed literally here:

> ⛔⛔ **"All offices are VACANT as constituted, and `ADR-0131` fills none of them."** Every `6A` act proceeds under the **one-act-conferral** model, and the offices ⛔ **revert on completion** (`ADR-0033` §7.1). ⛔ A Technical Specification **MUST NOT record an office as occupied** — it records which office is **required** and by which **conferral** it was exercised.

| Office | Role at Stage `6A` (§7A.6) | Required | Conferral by which it was exercised |
|---|---|---|---|
| **Technical Owner** | *"Authors and attests"* | ⭐ **YES** | ⭐ **`ADR-0140`** `D-4` |
| **Architecture Owner** | *"Approves — boundaries, edges and Rank 4 conformance"* | ⭐ **YES** | ⭐ **`ADR-0140`** `D-4` |
| **Product Owner** | *"Attests that no product requirement was invented or altered"* | ⭐ **YES** | ⭐ **`ADR-0140`** `D-4` |
| **Domain Owner** | *"Reviews ubiquitous language and invariants"* | ⭐ **YES** | ⭐ **`ADR-0140`** `D-4` |

⛔⛔ **The conferral REVERTS on completion of this act.** `ADR-0140` `D-4`: *"all four **REVERT on completion**… **no standing authority** is created, **no office is constituted, filled, occupied or made permanent**."* ⛔ **No office is claimed to be occupied by anyone.** ⛔ **No personal name appears** (`PRD_OWNERSHIP_MODEL` §8.3 rule 4).

⭐ **`ADR-0140` `D-10` limits this authorisation to ONE document:** *"It authorises `TS-001` for B9 and nothing further — ⛔ no `TS-002`, ⛔ no second subject, ⛔ no downstream stage, ⛔ no implementation."*

---

## 2. Scope, and the identifier stem

### 2.1 ⛔ Scope — B9 integration only

⭐ **This specification covers the technical-integration scope of `PRD-021B` Part B9 and NOTHING ELSE.** It is **integration-level**: edges, ports, flows, isolation, idempotency, event and cache posture, and the refusals B9 records.

⛔ **Out of scope, expressly:** any other PRD, part or module · any other bounded context's internals · `PRD-021A` A8 and `PRD-021C` C8 (⛔ **not nominated** — `ADR-0140` `D-1`) · implementation code · database engines · deployment.

### 2.2 ⭐ The stem `SGT` — measured free in four directions

`PRD_LIFECYCLE.md` §5 rule 2 and exit gate **`X-2`** require the stem measured before use.

| Direction | Instrument | Result |
|---|---|---|
| Documentation | `grep -ro 'SGT' docs/` | ⭐ **0** |
| Code / tests / tooling | `grep -ro 'SGT' lib test tool` | ⭐ **0** |
| Git history (all branches) | `git log --all -S'SGT-'` | ⭐ **0** commits |
| Prefix register | `grep -c 'SGT' PRD_REGISTRY.md` | ⭐ **0** |
| Traceability matrix | `grep -c 'SGT' TRACEABILITY_MATRIX.md` | ⭐ **0** |

⭐ **Justification for `SGT`:** it reads as *Social-Graph Technical*, matching the subject; it is **three letters**, matching this repository's `TPA`/`MSG`/`SGR`/`SDS`/`LTS` convention; and it collides with **none** of the **54** existing prefixes measured (`AFIL ANL API ATT AUD CNF DRK ENT EVT FEE FIL GLS INV ITG LCF LCG LCM LCN LCO LCR LCS LCT LDR LIB LMP LMT LPP LRR LSB LSD LTS MM MSG NTF PYK RTM SAAS SDS SEAT SEC SECP SGR SID SM SRCH SRE SSF TEN TPA TSF TSG XCNF XFIL XPA XPB XPC`).

⚠ **`RTM` and `TSG` were CONSIDERED AND REFUSED on measurement** — `RTM` returns **358** occurrences and `TSG` **64**. ⛔ Neither was taken.

⛔⛔ **`TPA-*` and `MSG-*` ARE NOT REUSED, EXTENDED OR REINTERPRETED.** They are **B9's own** — measured in B9: **80** `TPA-BR`, **43** `TPA-FR`, **30** `TPA-XC`, **24** `TPA-AC`, **19** `TPA-INV`, **13** `TPA-PRIN`, **12** `TPA-GAP`, **4** `TPA-GOAL`, plus `MSG-BR`/`MSG-FR`/`MSG-INV`/`MSG-API`. `ADR-0131` §5.3: *"⛔⛔ **MUST NOT be reused.** B9's own identifiers stay B9's."* ⛔ `LTS-*`, `LCTS-*`, `LMT-*`, `IMPL-*` and `PERM-*` likewise not reused.

### 2.3 ⭐ B9 is PRECEDENT AND INPUT — not converted

⛔⛔ **B9 is NOT rewritten, renamed, converted, re-identified, restatused or moved by this document.** Per `ADR-0140` `D-2`, which disposed of `TSG-GAP-003` **for B9 only and in the negative**, B9 ⭐ **remains a Rank-3 document at its own identifier and version**, and this specification **cites** it.

| B9 fact | Value |
|---|---|
| Path | `docs/30-product/social-graph/PRD-021B_B9_TECHNICAL_PRODUCTION_ARCHITECTURE_DRAFT_v0.1.md` |
| Lines | **982** |
| **Blob** | ⭐ **`6b241eaf2834460ad41e105e4a07cb1255fc67bc`** |

⚠ **B9's own header reads *"DRAFT v0.1 — Stage 2"* and this document does NOT repair it.** Rank and freeze live in the `DOCUMENTATION_BASELINE.md` §3 row conferred by `Accepted` `ADR-0092`, ⛔ not in the subject's header — the disposition `ADR-0092`/`ADR-0098`/`ADR-0087`/`PRD-020` each recorded. ⭐ `PRD_LIFECYCLE.md` **L177**: *"never silently modified. **Not for an obvious correction, and not for one that is certainly right.**"*

---

## 3. ⛔⛔ `X-4` — the `ADR-0131` prohibitions, affirmed INDIVIDUALLY

### 3.1 §3.3 — the five prohibitions

| # | Prohibition | Affirmation |
|---|---|---|
| **1** | ⛔ does NOT override a PRD | ⭐ **AFFIRMED.** Where this document and any PRD disagree, ⛔ **the PRD wins** and the disagreement is recorded as a defect (§8), ⛔ **never silently reinterpreted** |
| **2** | ⛔ does NOT override an Accepted ADR | ⭐ **AFFIRMED.** ⛔ This document has **no supersession power** (`ADR-INDEX` **L206**) |
| **3** | ⛔ does NOT override Rank 4 architecture authority | ⭐ **AFFIRMED.** Boundaries, ownership and edges belong to the BC Map and Matrix; this document ⭐ **CONSUMES them** |
| **4** | ⛔ does NOT compete with the Rank 6 EA, and ⛔ may NOT cite it as overriding authority | ⭐ **AFFIRMED.** ⛔ **The EA is cited ZERO times in this document as technical authority** |
| **5** | ⛔ does not stand above the ranked documents | ⭐ **AFFIRMED.** This document is **UNRANKED** (`TSG-GAP-004`) |

### 3.2 §8.2 — `P-1` … `P-8`, each individually

| # | Prohibition | Affirmation |
|---|---|---|
| **`P-1`** | ⛔ MUST NOT supersede an ADR | ⭐ **AFFIRMED — supersedes nothing.** |
| **`P-2`** | ⛔ MUST NOT supersede, amend or reinterpret a frozen PRD | ⭐ **AFFIRMED.** ⛔ **0** PRDs amended; B9 **byte-unchanged**. |
| **`P-3`** | ⛔⛔ MUST NOT invent a permission | ⭐ **AFFIRMED — see §6.** ⛔⛔ **ZERO permission identifiers minted.** |
| **`P-4`** | ⛔ MUST NOT create a new product boundary — no BC (count **31**), no edge (highest **`E-33`**; ⛔ `E-34` **NOT** allocated), no port, no aggregate name | ⭐ **AFFIRMED.** ⛔ **0** contexts, **0** edges, **0** ports, **0** aggregates created. ⛔ **`E-34` is NOT allocated**; ⛔ `E-27` **not referenced** |
| **`P-5`** | ⛔ MUST NOT silently resolve a conflict | ⭐ **AFFIRMED.** Every open item is recorded in §8 with source, status and required governance act |
| **`P-6`** | ⛔ MUST NOT cite the EA as overriding technical authority | ⭐ **AFFIRMED — 0 EA citations as authority** |
| **`P-7`** | ⛔ MUST NOT change its own status | ⭐ **AFFIRMED.** Status is **`DRAFT`**; ⛔ admission requires an **Accepted ADR** |
| **`P-8`** | ⛔ MUST NOT introduce product requirements, scope or acceptance criteria no PRD declares | ⭐ **AFFIRMED.** ⛔ **0** product requirements, **0** scope, **0** acceptance criteria introduced |

### 3.3 ⛔⛔ §7A.9's five mandatory boundary domains

| Domain | Affirmation |
|---|---|
| **PAYMENT** | ⭐ **AFFIRMED.** ⛔ **No payment mechanism or provider is specified, referenced or implied.** `ADR-0130` — V1 student payment is **CASH ONLY**; ⛔ UPI/card/online/gateway/settlement are **V2**; ⛔ **`PRD-008` §6.1 is NOT applied** — `ADR-0130` governs by rank. ⛔ **Payment is OUT OF SCOPE of B9 entirely** |
| **AUTHORIZATION** | ⭐ **AFFIRMED — see §6.** `AUTH-7.22` **CLOSED at 0**; ⛔ `ADR-0043` §5.1 binding; ⛔ `AP-9` **fail-closed** binding |
| **AUTHENTICATION** | ⭐ **AFFIRMED.** Auth **v3.0** / `ADR-0129` authoritative. ⛔ **No authentication rule is specified, altered or implied**; ⛔ no V1 mobile OTP, ⛔ no password, ⛔ no email-as-identity, ⛔ no email recovery, ⛔ **no v4.0**. ⛔ **Auth v3.0 internals are UNTOUCHED** |
| **ARCHITECTURE** | ⭐ **AFFIRMED.** ⛔ `MP-GBR-24` — `BC-05`/`BC-20` share no model, table or metric · ⛔ `MP-CON-01`/`02` + `MP-RSK-05` — **no direct BaaS/Supabase call from domain code** · ⛔ `ADR-0012` boundary checker **remains a merge gate** · ⛔ **modular monolith** in V1 (`MP-CON-09`) · ⛔ EA **Rank 6 descriptive only** |
| **API** | ⭐ **AFFIRMED — see §5.** `API-1`…`API-9` consumed as decided; ⚠ **`API-8` mechanism NOT selected**; ⛔⛔ **`API-GAP-001` OPEN and NOT invented** |

---

## 4. §4 — Integration boundaries *(traceability: PRD → Architecture/BC → ADR → TS)*

> **Chain for this section:** `PRD-021B` B9 §7 *(`TPA-FR-001`, `TPA-BR-001`)* → **BC Map L318/L319/L320/L328/L329/L330/L331/L332/L335** → `Accepted` `ADR-0092` (B0–B9 Rank 3), `ADR-0055` (`BC-12` on `E-22`), `ADR-0065` (Option B) → **this §4**

### 4.1 `TS-001-SGT-001` — The edge set is CONSUMED, not created

⭐ **`TS-001-SGT-001`** — The integration surface for `PRD-021B` **SHALL** consist of exactly the **eight** edges B9 §7 records as used, and ⛔ **no others**.

| Edge | BC Map | From → To | Mechanism | Purpose *(as recorded)* |
|---|---|---|---|---|
| `E-14` | **L318** | `BC-13` → `BC-11`, `BC-12` | `PL` Event | `safety.EnforcementActionTaken`; each context **self-restricts** |
| `E-15` | **L319** | `BC-10` → `BC-11` | `SK` | Shared kernel (`PersonId`, privacy VOs) |
| `E-16` | **L320** | `BC-11` → `BC-12` | `C/S` sync port | `canMessage(a, b)` |
| `E-19` | **L328** | → `BC-25` | Config | `*-CFG-*` reads |
| `E-20` | **L329** | → `BC-24` | Audit | Audit facts |
| `E-21` | **L330** | `BC-01`, `BC-10` → `BC-23` | Index | Discovery projection |
| `E-22` | **L331** | `BC-01`, `BC-10`, `BC-12`, `BC-14` → `BC-29` | `CF` sync port | `FileRef`; `BC-12` admitted by `ADR-0055` |
| `E-23` | **L332** | All → `BC-22` | `PL` Event | Notification **facts** |

⭐ B9 §7 states it exactly: *"**8 edges used, 0 created.**"* ⛔ `E-26` (**L335**) is *"cited"* only and ⛔ **is not `PRD-021B`'s**. ⛔ `E-27` **is not referenced**; ⛔ **`E-34` is NOT allocated** (`ADR-0131` §8.2 `P-4`).

### 4.2 `TS-001-SGT-002` — Three absences are LOAD-BEARING and SHALL be honoured

⭐ **`TS-001-SGT-002`** — The following edges **do not exist**, and an implementation **SHALL NOT** behave as though they do. ⭐ BC Map **L292**: an edge not in the table *"**does not exist**."*

| Absent edge | Consequence, as B9 records it |
|---|---|
| No `BC-12` → `BC-13` | The send-time safety check is a **local `E-14`-fed read** (`ADR-0065` Option B) |
| No community → `BC-12` | ⛔ The Help → Message flow **cannot be built** (`XPB-CONF-011`) |
| No `BC-12` → `BC-23` | ⛔ Messages are **not indexed or searchable** in V1 |

⚠ **`E-16` runs `BC-11` → `BC-12`.** `BC-12` is the **client**; ⛔ there is **no** reverse edge. ⛔ **Creating any of these three edges requires an ADR before the change** (`DOCUMENTATION_BASELINE.md` §7 rule 1) — ⛔ **this document creates none.**

### 4.3 `TS-001-SGT-003` — Cross-context calls are in-process

⭐ **`TS-001-SGT-003`** — Cross-context calls **SHALL** be **in-process port calls** and ⛔ **SHALL NOT** be internal HTTP.

> **Chain:** Rank 1 `MP-CON-09` (modular monolith) → Rank 4 BC Map → `Accepted` `ADR-0135` **`API-3`** → this §4.3. ⭐ `ADR-0012`'s boundary checker is the merge gate.

---

## 5. §5 — API posture *(traceability: PRD → Architecture/BC → ADR → TS)*

> **Chain for this section:** Rank 1 `MASTER_PRD` **L407**/**L408**/**L410**, `MP-GBR-18`, `MP-GBR-26` → Rank 4 BC Map **L226**, Matrix **L220** → `Accepted` `ADR-0135` (`API-1`…`API-9`, `API-GAP-001`), `ADR-0010` **L151**, `ADR-0139` → **this §5**

### 5.1 `TS-001-SGT-004` — The API rules are CONSUMED as already decided

⭐ **`TS-001-SGT-004`** — The B9 surface **SHALL** conform to `API-1`…`API-9` as `ADR-0135` decided them. ⛔ **This document re-decides none of them.**

| Rule | As decided (cited, not restated as new) |
|---|---|
| **`API-1`** | V1 external style is **REST over HTTP** (Rank 1 **L407**, BC Map **L226**) |
| **`API-2`** | GraphQL **only** at the BFF/OHS edge where the BFF requires it — ⛔ not a general style |
| **`API-3`** | Cross-context calls are **in-process port calls** — ⛔ never internal HTTP |
| **`API-4`** | ⛔⛔ A denial **MUST NOT disclose existence** — *"exists but forbidden"* and *"does not exist"* **MUST be indistinguishable**; ⛔ distinct 404/403 is **PROHIBITED** (`ADR-0010` **L151**, *"enumeration oracle"*) |
| **`API-5`** | ⛔ A denial **MUST NOT disclose the reason** (`AUTH-10.33`, `LCM-API-003`) |
| **`API-6`** | Validation errors **MAY** be specific (**L410**); ⛔ authorization and existence outcomes **MUST NOT** be — ⭐ an `AP-9` fail-closed refusal **MUST look identical** to an entitlement refusal |
| **`API-7`** | The V1 surface **MUST carry an explicit version identifier** from first release |
| **`API-8`** | ⚠ **The versioning MECHANISM is NOT selected** — path, header, media-type and query **all open** |
| **`API-9`** | An idempotency key is **request METADATA, not domain payload** — caller-supplied, opaque to the domain, unique **per tenant**; ⛔ **no header name is specified** |

⛔⛔ **This document specifies NO endpoint, path, verb, status code, header name, payload, schema or media type.** `ADR-0135` itself records that this *"remains §6A work"* — ⭐ and it remains **undone**, because `API-8` and `API-GAP-001` are unresolved and ⛔ **a specification MUST NOT invent them** (§7A.9 API row).

### 5.2 ⛔⛔ `TS-001-SGT-005` — `API-GAP-001` is carried OPEN

⭐ **`TS-001-SGT-005`** — The API deprecation / sunset / multi-version-support policy is ⛔⛔ **UNDECIDED**, and an implementation **SHALL NOT** infer, default or invent one.

> ⛔⛔ **`API-GAP-001` — OPEN.** *(`ADR-0135` **L194**)* — **Authority required: Product Owner + Architecture Owner** *(**L195**)*

⭐ **`API-GAP-001` is why `E-4` is satisfied rather than breached.** §7A.4 `E-4` accepts *"the dependency is **recorded as a gap with a named owning office**"* — ⭐ it requires the office **named**, ⛔ **not occupied** (`ADR-0139` §5.2; `ADR-0140` §5).

⛔ **`ADR-0139` re-affirmed it OPEN and did not resolve it.** ⛔ **No migration period, sunset period, deprecation window, support duration, notice period or numerical duration of any kind is stated here** — ⛔ **no number appears anywhere in this document as a policy value.**

### 5.3 `TS-001-SGT-006` — Session boundary

⭐ **`TS-001-SGT-006`** — The API edge **SHALL consume** authorization decisions via `identity.policy_decision` and ⛔ **SHALL NOT evaluate, cache or infer** one from a token.

> **Chain:** Rank 1 `MP-GBR-26` (*"no propagation window"*) → Rank 4 Matrix **L220** (*"ask `BC-18`, **never evaluate or cache**"*) → `ADR-0135` SESSION → this §5.3. ⛔ **A token is NOT an authorization store.**

---

## 6. §6 — Authorization *(traceability: PRD → Architecture/BC → ADR → TS)*

> **Chain:** FROZEN `AUTH-7.22` → Rank 4/5 `AP-9` → `Accepted` `ADR-0043` §5.1, `ADR-0132`, `ADR-0135` AUTHZ → **this §6**

### 6.1 ⛔⛔ `TS-001-SGT-007` — ZERO permission identifiers

⭐ **`TS-001-SGT-007`** — ⛔⛔ **This document mints, invents, proposes, reserves or implies NO permission identifier.**

| Measured fact | Value |
|---|---|
| `AUTH-7.22` enumerated permissions | ⭐ **CLOSED at 0** |
| `PERM-*` repository-wide | **2 — both withdrawal records** |
| Permission identifiers created by this document | ⭐⭐ **0** |

⛔ `ADR-0043` §5.1 — *"**Do not invent a new permission ID**"* — is **binding**. ⛔ `ADR-0132` is **NOT reopened**. ⛔ **No convention exists to extend** (§7A.9 AUTHORIZATION row).

### 6.2 `TS-001-SGT-008` — The sanctioned route, and two prohibitions

⭐ **`TS-001-SGT-008`** — Where B9 requires an authorization outcome, the implementation **SHALL** use **derived capability** (`LCM-AUTH-001`/`002`), the route `ADR-0135` names as sanctioned.

⛔⛔ **PROHIBITED:** **endpoint-keyed grants** and **route allow-lists** — ⭐ each would build a permission vocabulary **outside the closed catalogue** (`ADR-0135` AUTHZ).

### 6.3 `TS-001-SGT-009` — Fail-closed, indistinguishably

⭐ **`TS-001-SGT-009`** — An `AP-9` fail-closed refusal **SHALL** be **indistinguishable** from an entitlement refusal (`API-6`), and ⛔ **SHALL NOT** disclose existence (`API-4`) or reason (`API-5`).

---

## 7. §7 — Isolation, idempotency, events, search *(traceability: PRD → Architecture/BC → ADR → TS)*

> **Chain:** `PRD-021B` B9 §9/§16/§15/§19 *(`TPA-FR-011`, `TPA-BR-016`, `TPA-BR-017`, `TPA-XC-013`, `TPA-FR-014`)* + FROZEN `MSG-FR-011`, `MSG-BR-001`, `MSG-INV-004` → BC Map **L292**, **L330**, Matrix **L357** `X-08` → `ADR-0092`, `ADR-0135` **`API-9`**, `ADR-0055` → **this §7**

### 7.1 `TS-001-SGT-010` — Idempotency, as already required

⭐ **`TS-001-SGT-010`** — Every state-changing `PRD-021B` operation **SHALL** be idempotent, either by a **client-supplied key** (`MSG-FR-011`) or naturally (`MSG-BR-001`'s open-or-resolve).

⭐ **`TS-001-SGT-011`** — A retry **SHALL NOT** produce a duplicate `Message` (`MSG-INV-004`) or a duplicate `Conversation` (`MSG-BR-001`).

⭐ **`TS-001-SGT-012`** — Event consumers **SHALL** be idempotent; `E-14` and `identity.Person*` **SHALL** be safe to re-apply — ⭐ because at-least-once delivery means re-application **will** happen.

⚠⚠ **A GAP IS CARRIED, NOT CLOSED — `TPA-GAP-004`:** B9 records *"**Measured: no Rank 1–4 idempotency standard exists.** §16 and B7 §B7.7 are `PRD-021B` **specifying**, not citing. ⛔ Disclosed as authored-not-derived. **Owner: Architecture Owner.**"* ⛔⛔ **This document does NOT supply the missing standard, does not ratify B9's, and specifies no header name** (`API-9`: *"no header name is specified"*). ⭐ It records the gap and its owner — `X-5`.

### 7.2 ⛔ `TS-001-SGT-013` — Messages are NOT searchable in V1

⭐ **`TS-001-SGT-013`** — Messages ⛔ **SHALL NOT** be indexed in `BC-23` and ⛔ **SHALL NOT** be searchable in V1.

⭐ **The reason is measured, not asserted:** `E-21` (BC Map **L330**) runs `BC-01, BC-10 → BC-23`, and **`BC-12` is absent from its producer cell**; BC Map **L292** — an edge not in the table *"does not exist"*; Matrix **L357** `X-08` additionally forbids a search component reaching into a domain repository. ⛔ **Message search would require a new edge and an ADR.**

⭐ **`TS-001-SGT-014`** — Person discovery **SHALL** use `BC-23`'s projection fed by `E-21` from `BC-10`. ⛔ That is discovery of **people**, ⛔ **not of messages**.

### 7.3 `TS-001-SGT-015` — Multi-tenancy is structural

⭐ **`TS-001-SGT-015`** — Tenant isolation **SHALL** be **structural**, per B9 §9, and an idempotency key's uniqueness **SHALL** be scoped **per tenant** (`ADR-0135` `API-9`; Rank 1 `MP-GBR-18`).

### 7.4 ⛔ `TS-001-SGT-016` — No data, schema or runtime decision is made here

⭐ **`TS-001-SGT-016`** — ⛔⛔ **This document specifies NO database schema, table, column, index, constraint, migration, SQL, engine choice, Supabase configuration, cache key, TTL, retention period, purge schedule or background-job schedule.**

⛔ `MP-CON-01`/`02` + `MP-RSK-05` — **no direct BaaS/Supabase call from domain code** — remain binding. ⚠ B9 §11 is titled *"Database design — **indexes only, no engine choice**"*; ⭐ **this document does not extend even that far.**

⚠⚠ **AND A RETENTION PROHIBITION IS CARRIED EXPRESSLY:** ⛔ **no TTL, purge, archival rule or deletion deadline is stated or implied.** `ADR-0137` **`RET-12`** prohibits computing **any** duration, age, deadline, expiry or eligibility from `purposeCeasedAt`, `retentionBasis` or record timestamps — ⭐ the **first** such computation would be an **ungoverned** retention rule needing a **new ADR before implementation**. ⛔ `Q-04` legal content stays **OPEN**; `LR-01` stays **PERMANENTLY OPEN** and ⛔ **is not a blocker**.

---

## 8. ⛔⛔ `X-5` — Gap register: every unresolved question, with its EXISTING owner

⛔⛔ **NOTHING IN THIS REGISTER IS CLOSED TO MAKE THIS DOCUMENT LOOK COMPLETE.** ⭐ **No new gap identifier is created** — every entry cites a gap that **already exists**.

| Existing gap | Question left open | Owning office *(as already recorded)* |
|---|---|---|
| **`API-GAP-001`** | API deprecation / sunset / multi-version-support policy | **Product Owner + Architecture Owner** (`ADR-0135` **L195**) |
| **`API-8`** *(deferred decision, not a gap id)* | Which versioning mechanism — path, header, media-type or query | **Architecture Owner** (`ADR-0135`) |
| **`TPA-GAP-004`** | No Rank 1–4 idempotency standard exists; B9 §16 is authored-not-derived | **Architecture Owner** (B9 §16; = B7's `MSG-GAP-001`) |
| **`TSG-GAP-003`** | Whether **A8** and **C8** should be re-expressed as `TS-*` | **Architecture + Product Owner** — ⭐ **disposed for B9 only** by `ADR-0140` `D-2`; ⚠ **OPEN for A8 and C8** |
| **`TSG-GAP-004`** | What precedence rank, if any, an admitted Technical Specification holds | **Architecture Owner** |
| **`TSG-GAP-005`** | `TRACEABILITY_MATRIX.md` must gain a `TS-*` inventory | **Technical Owner** — ⚠ **becomes due now that this document exists**; measured **0** entries |
| **`TSG-GAP-001`** | Whether Stage `6A` becomes mandatory before Stage 7 | **Governance + Product Owner** |
| **`TSG-GAP-002`** | Whether the downstream ordering becomes enforced gates | **Governance + Architecture Owner** |
| **`TSG-GAP-006`** | Whether a Technical Specification needs a new registry status | **Product + Governance Owner** |
| **`Q-04`** / **`LR-01`** | Retention legality; legal risk | ⛔ **UNCHANGED** — `LR-01` **PERMANENTLY OPEN**, ⛔ not a blocker (`ADR-0137`) |
| **Blocker `7a`** | No authoritative retention number | ⛔ **OPEN and UNAMENDED** |
| **`B-5`** | API governance | ⭐ **DISPOSED, not fully closed** (`ADR-0135` §8) |

⚠ **`P-5` honoured:** no conflict above is repaired in passing. ⛔ **Each requires its own governed act.**

---

## 9. ⭐ `X-6` — Section-level traceability chain

| Section | PRD requirement | Architecture / BC | ADR | This TS |
|---|---|---|---|---|
| **§4.1** | B9 §7 `TPA-FR-001` | BC Map **L318**/**L319**/**L320**/**L328**/**L329**/**L330**/**L331**/**L332** | `ADR-0092`, `ADR-0055` | `TS-001-SGT-001` |
| **§4.2** | B9 §7 `TPA-BR-001`, `XPB-CONF-011` | BC Map **L292** | `ADR-0065` (Option B) | `TS-001-SGT-002` |
| **§4.3** | Rank 1 `MP-CON-09` | BC Map | `ADR-0135` `API-3`, `ADR-0012` | `TS-001-SGT-003` |
| **§5.1** | Rank 1 **L407**/**L408**/**L410** | BC Map **L226** | `ADR-0135` `API-1`…`API-9`, `ADR-0010` **L151** | `TS-001-SGT-004` |
| **§5.2** | — *(no PRD decides it — that is the gap)* | — | `ADR-0135` **L194**/**L195**, `ADR-0139` | `TS-001-SGT-005` |
| **§5.3** | Rank 1 `MP-GBR-26` | Matrix **L220** | `ADR-0135` SESSION | `TS-001-SGT-006` |
| **§6.1** | FROZEN `AUTH-7.22` | `AP-9` | `ADR-0043` §5.1, `ADR-0132`, `ADR-0135` | `TS-001-SGT-007` |
| **§6.2** | `LCM-AUTH-001`/`002` | — | `ADR-0135` AUTHZ | `TS-001-SGT-008` |
| **§6.3** | Rank 1 **L410** | `AP-9` | `ADR-0135` `API-4`/`API-5`/`API-6` | `TS-001-SGT-009` |
| **§7.1** | FROZEN `MSG-FR-011`, `MSG-BR-001`, `MSG-INV-004`; B9 §16 | — | `ADR-0135` `API-9`, `ADR-0092` | `TS-001-SGT-010`…`012` |
| **§7.2** | B9 §19 `TPA-XC-013`, `TPA-FR-014` | BC Map **L292**/**L330**, Matrix **L357** `X-08` | `ADR-0092` | `TS-001-SGT-013`, `014` |
| **§7.3** | B9 §9; Rank 1 `MP-GBR-18` | — | `ADR-0135` `API-9` | `TS-001-SGT-015` |
| **§7.4** | Rank 1 `MP-CON-01`/`02`, `MP-RSK-05` | B9 §11 | `ADR-0137` `RET-12`, `ADR-0116`, `ADR-0124` | `TS-001-SGT-016` |

⭐ **16 requirements, `TS-001-SGT-001` … `TS-001-SGT-016`, contiguous from `001`.** ⛔ **No gap identifier, no acceptance criterion and no `IMPL-*` task is allocated.**

---

## 10. ⛔ What this document does NOT do

1. ⛔⛔ **Invents no API mechanism, header name, endpoint, path, verb, status code, payload, schema or media type.**
2. ⛔⛔ **Invents no authentication rule.** Auth v3.0 **untouched**; ⛔ no v4.0.
3. ⛔⛔ **Invents no payment mechanism or provider.** `ADR-0130` **CASH ONLY**; payment out of B9's scope.
4. ⛔⛔ **Invents no retention period, TTL, purge schedule, archival rule or deletion deadline.**
5. ⛔⛔ **Invents no database schema, table, column, index, constraint, migration, SQL, engine or Supabase configuration.**
6. ⛔⛔ **Mints ZERO permission identifiers.** `AUTH-7.22` **CLOSED at 0**.
7. ⛔⛔ **Creates no bounded context, edge, port or aggregate.** ⛔ `E-34` **NOT** allocated.
8. ⛔ **Writes no code or test.** ⛔ **0** files under `lib/`, `test/`, `tool/`, `packages/`, `android/`, `web/`.
9. ⛔ **Amends no PRD, no ADR, no Rank 1–5 document.** ⛔ B9 **byte-unchanged**.
10. ⛔ **Closes no gap, resolves no blocker, confers no status on itself, and claims no rank.**
11. ⛔ **Enters no downstream stage.** §7A.10: ⛔ *"**passing `6A` authorises no downstream act**."*
12. ⛔ **Authorises no second specification.** `ADR-0140` `D-10`.

---

## 11. ⚠ Honest assessment

1. ⚠ **This is an INTEGRATION-level specification, and deliberately thin where the governance is thin.** The places a reader might expect detail — endpoints, schemas, headers, cache keys — are ⛔ **empty because `API-8` and `API-GAP-001` are unresolved**, not because they were overlooked. ⭐ Filling them would be the invention `E-4` exists to prevent.
2. ⚠ **`TPA-GAP-004` is the most consequential carried gap.** B9 itself discloses its idempotency section as *"specifying, not citing"*. ⭐ This document **cites B9's requirements** and ⛔ **does not ratify them into a standard** — only the Architecture Owner can do that, by ADR.
3. ⚠ **`TSG-GAP-005` is now DUE.** This document's existence is precisely the trigger; the `TRACEABILITY_MATRIX` `TS-*` inventory measures **0**. ⛔ It is **not** discharged here — that is a Technical Owner act on a different document.
4. ⚠ **The stem `SGT` is newly coined.** It measured **0** in four directions, but ⭐ it is **new**, and a new identifier family is exactly what `ADR-0138` §6 mandates sweeping. ⛔ It is **not registered** in `PRD_REGISTRY` by this act — registration is a **Governance Owner** act.
5. ⚠ **Status is `DRAFT` and this document is NOT authoritative.** ⛔ It becomes governed only when an **Accepted ADR admits it** (§7A.8). ⛔ Nothing here may be relied on as decided.
6. ⚠ **B9's header remains false** (*"DRAFT v0.1 — Stage 2"*) and is deliberately unrepaired. A reader must take rank from the baseline row.

---

## 12. Changelog

| Version | Date | Change |
|---|---|---|
| **0.1** | 2026-09-11 | ⭐⭐ **Created as `DRAFT`** — the **first** Technical Specification in this repository, for `PRD-021B` **B9**, under the four-office one-act conferral of `Accepted` **`ADR-0140`** (Technical + Architecture + Product + Domain Owner, ⛔ **all reverting on completion**; ⛔ **no office recorded as occupied**). ⭐ **Stem `SGT` declared** after a four-direction sweep measuring **0** (docs, code, git history, prefix register, traceability matrix); ⚠ **`RTM` (358) and `TSG` (64) were considered and REFUSED on measurement**; ⛔ **`TPA-*`/`MSG-*` NOT reused** — B9's stay B9's (`ADR-0131` §5.3). ⭐ **16 requirements `TS-001-SGT-001`…`016`, contiguous from `001`.** ⭐ **8 edges CONSUMED, 0 created**; ⭐ **three load-bearing ABSENCES honoured** (no `BC-12`→`BC-13`, no community→`BC-12`, no `BC-12`→`BC-23`). ⛔⛔ **`API-GAP-001` CARRIED OPEN** and ⭐ **it is what satisfies `E-4`'s second limb**; ⛔ **`API-8` mechanism NOT selected**; ⛔ **no endpoint, path, verb, status code, header name, payload or schema specified** — ⭐ *no number appears anywhere as a policy value*. ⛔⛔ **ZERO permission identifiers** (`AUTH-7.22` **CLOSED at 0**; ⛔ endpoint-keyed grants and route allow-lists **PROHIBITED**). ⛔ **No authentication rule, payment mechanism, retention period/TTL/purge, database schema/migration/SQL, Supabase configuration, bounded context, edge, port or aggregate invented** (⛔ `E-34` **NOT** allocated). ⭐ **`ADR-0131` §3.3's five and §8.2's `P-1`…`P-8` affirmed INDIVIDUALLY**, plus §7A.9's five boundary domains. ⭐ **`X-5` gap register carries 12 existing gaps with their existing owners — ⛔ NONE closed, ⛔ NO new gap identifier created**; ⚠ **`TSG-GAP-005` now DUE**. ⭐ **`X-6` section-level traceability stated for all 13 sections.** ⛔ **B9 BYTE-UNCHANGED** (`6b241eaf2834460ad41e105e4a07cb1255fc67bc`, 982 lines) and ⛔ **NOT converted, rewritten, renamed or restatused** (`ADR-0140` `D-2`); ⚠ its *"Stage 2"* header **deliberately unrepaired** (`PRD_LIFECYCLE` **L177**). ⛔ **Status `DRAFT` — NOT approved, NOT frozen, NOT authoritative, UNRANKED** (`TSG-GAP-004`); ⛔ **no status self-claimed** (`P-7`). ⛔ **0** code/test/tool files; ⛔ **0** Rank 1–5 documents amended; ⛔ **no push**. |
