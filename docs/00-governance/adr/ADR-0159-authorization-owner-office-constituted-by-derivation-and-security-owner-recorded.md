# ADR-0159 — The `Authorization Owner` office is constituted by derivation, and the already-designated `Security Owner` office is recorded in `PRD_OWNERSHIP_MODEL` (discharging `ADR-0158` `O-1`)

| Field | Value |
|---|---|
| **Status** | **Accepted** — 2026-09-19 |
| **Rank** | 2 — Architecture Decision Record |
| **Deciders** | ⭐ **Two offices, two limbs, recorded separately rather than merged.** **Limb A** *(constitute the `Authorization Owner`)* — **Architecture Owner**, the role `PRD_OWNERSHIP_MODEL` **L85** records as deciding *"Boundaries, ranks, permitted edges, precedence"* and whose §5 **L284** holds *"**Only the Architecture Owner approves**"* a Rank 1–5 change, **together with** the **Governance Owner** (**L418** — *"Document **status** and **process**"*), on the `ADR-0077` / `ADR-0080` precedent. **Limb B** *(record the `Security Owner`)* — **Governance Owner** alone, because `ADR-0158` §7 **`O-1`** names that office and no other. Both exercised by **direct conferral from the human principal**, ⛔ **reverting on completion** (`ADR-0033` §7.1 — *"a conferral for one act is not a standing licence"*). ⚠️ **Both offices exercised by ONE principal**, so ⛔ **no independent review, ARB quorum or external Security audit is claimed** |
| **Supersedes** | ⛔ **NOTHING** |
| **Superseded by** | — |
| **Amends** | `docs/00-governance/prd-ecosystem/PRD_OWNERSHIP_MODEL.md` → **v1.7**, ⭐ **BY APPEND ONLY** — new **§16** (`Authorization Owner`) and new **§17** (`Security Owner`), both below **L854**. ⛔ **No row is inserted into §2.1, §2.2, §2.3, §5 or §8. No existing line moves.** §§9, 10, 11, 12, 13, 14, 15 are **not modified**. See §7 |
| **Closes** | ⭐ The **office-existence** defect for `Authorization Owner` — the state in which **three `Accepted` ADRs exercise an authority this document never defines** · ⭐⭐ **`ADR-0158` §7 `O-1`** *(record the `Security Owner` office)*, see §6 |
| **Does NOT close** | ⛔⛔ **NO `BC-25` parameter is authorized. Coverage stays at 79 / 104.** ⛔ `O-2`…`O-7` · ⛔ `DP-0001` Groups 1–5 *(no disposition changed; all 25 stay **HELD**)* · ⛔ `ATT-GAP-012`, `ATT-GAP-014`, `SM-GAP-2`, `SEAT-GAP-005`, `CNF-GAP-002`, `CNF-GAP-007` · ⛔ `ADR-0132` §7 prerequisites 1–7 *(**none** engaged)* · ⛔ §2's stale *"four roles"* arithmetic · ⛔ `ADR-0075` §8.5 Option B · ⛔ `PGA-08`. ⭐⭐ **Constituting an office is not exercising it** |
| **Related** | ⭐⭐ **`ADR-0077`** and ⭐⭐ **`ADR-0080`** *(the two constitution precedents — same file, same append-only method, same §2.1 derivation test)* · `ADR-0158` §2.1, §6, §7 `O-1` · `ADR-0132` §7 *(five prerequisites assigned to this office)* · `ADR-0150`, `ADR-0151`, `ADR-0153` *(**Accepted** — each records an Authorization Owner conferral)* · `ADR-0155` `S-3` · `ADR-0157` `SE-2` · `ADR-0060` *(SECURITY platform has no bounded context)* · `ARCHITECTURE_RULINGS.md` **L230** *(**Rank 5**)* · `PRD_OWNERSHIP_MODEL` §2.1, §2.2 **L85**, §2.3, §3 rule 1, §7 rule 4, **L284**, **L418** · `PAYMENT_GOVERNANCE_RESOLUTION.md` **L104** · `DP-0001` |

> ✅ **ACCEPTED 2026-09-19. The amendment in §7 has been executed by append.**
>
> ⭐⭐ **This ADR invents no office and decides no parameter.** It writes down an authority the
> repository has been **conferring and exercising** — in `Accepted` Rank 2 decisions — while the
> document whose entire purpose is to define roles recorded it **zero** times.
>
> ⛔⛔ **It authorizes NOTHING in `BC-25`.** Coverage is **79 / 104** before and after.

---

## 1. Context — the defect, as measured

### 1.1 `Authorization Owner`

| Measurement | Value |
|---|---|
| Occurrences of *"Authorization Owner"* across `docs/` | ⭐ **70** |
| Files containing it | ⭐ **25** |
| The anchored form *"Authorization (`BC-18`/`PRD-001`) Owner"* | **8**, across `ADR-0131`, `ADR-0132`, `ADR-INDEX`, `DOCUMENTATION_BASELINE`, `PRD-005` |
| ⭐⭐ Occurrences in `PRD_OWNERSHIP_MODEL.md` | ⛔⛔ **0** |
| Role-definition rows (`^\| **Authorization Owner**`) anywhere in the repository | ⛔ **0** |
| **`Accepted`** ADRs recording an **Authorization Owner conferral** | ⭐⭐ **3** — `ADR-0150`, `ADR-0151`, `ADR-0153` |
| **`Accepted`** ADRs routing open items **to** it | `ADR-0132` *(5 prerequisites)*, `ADR-0155` `S-3`, `ADR-0157` `SE-2`, `ADR-0158` `R-3`/`R-7`/`O-3`/`O-7` |

⭐⭐ **This is the `ADR-0080` condition exactly, and slightly worse.** The office is not missing from
practice — it is one of the most frequently invoked authorities in the `BC-25` chain, and it has
**already allocated authorization** for `BC-02` (`ADR-0150`) and `BC-25` (`ADR-0151`, `ADR-0153`).
What is missing is the **written definition**. A reader auditing `ADR-0151`'s authority is sent to
`PRD_OWNERSHIP_MODEL`, and finds the office **absent**.

### 1.2 `Security Owner` — a different defect, with a different remedy

`ADR-0158` `R-1` **already designated** SECURITY PLATFORM as the `Security Owner`, with an expressly
bounded authority. ⛔ But `ADR-0158` §6 states plainly:

> ⛔ *"**It does not amend `PRD_OWNERSHIP_MODEL`** — ⚠️ recording the designation **there** is `O-1`,
> a **Governance Owner** act."*

Measured at HEAD `0390c54`: `grep -ci "security owner"` over `PRD_OWNERSHIP_MODEL.md` returns
⛔ **0**, against **36** occurrences across **11** files elsewhere.

⭐ **So the two limbs are NOT the same act, and this ADR does not pretend they are:**

| Limb | Office | What is missing | Act required |
|---|---|---|---|
| **A** | `Authorization Owner` | ⛔ The **office itself** — never designated anywhere | ⭐ **Constitution** by derivation |
| **B** | `Security Owner` | ⭐ The office **exists** (`ADR-0158` `R-1`); only the **record** is missing | ⭐ **Recording** only — `O-1` |

⛔⛔ **Limb B creates no authority.** It transcribes `ADR-0158` §2.1b's boundary **verbatim**.

---

## 2. Decision

### 2.1 ⭐ Limb A — the `Authorization Owner` office is constituted

**The `Authorization Owner` office is constituted**, by the same §2.1 derivation method that produced
the original four and that `ADR-0077` and `ADR-0080` each applied, and is recorded in a new **§16**.

1. ⭐ **It is constituted VACANT.** §7 rule 4 — *"**Never** record a personal name"* — is observed.
2. ⭐ **One holder**, per §3 rule 1.
3. ⭐ **It is a STANDING office**, not a one-act conferral — unlike §13/§14/§15, because the rules it
   serves are continuing obligations, and three `Accepted` ADRs have already exercised it more than once.
4. ⛔⛔ **Constituting it exercises NOTHING.** `O-3` and `O-7` remain **OPEN**.

### 2.2 ⭐⭐ The derivation — rules that already exist, none created here

Applying §2.1's own *"Existing rule | Question it forces | Role that answers it"* format.
⭐ **Every row below pre-dates this ADR:**

| # | Existing rule | Where | Rank / status | Question it forces |
|---|---|---|---|---|
| 1 | ⭐⭐ *"**Authorization** \| Tenant roles \| `BC-18` Identity & Access — **authorization concern**, evaluated with a tenant in scope"*, immediately followed by *"**Do not merge Authentication and Authorization responsibilities.**"* | `ARCHITECTURE_RULINGS.md` **L230**, **L232** | ⭐ **5** | Who decides an authorization concern, given it may **not** be merged into authentication? |
| 2 | ⭐ Five permission-minting prerequisites, each assigned to the **Authorization Owner** — the naming convention (2), the catalogue's lawful home (3), the `AP-4`/`AP-8` relationship (4), per-permission category/action/scope (5), and the no-derived-mechanism demonstration (6) | `ADR-0132` §7 | ⭐ **`Accepted`** | Who holds the authority those five rows name? |
| 3 | ⭐⭐ *"The **Authorization Owner** conferral is recorded **in this ADR**, the instrument that exercises it"* | `ADR-0150` **L8** | ⭐⭐ **`Accepted` — already exercised** | Whose conferral was that? |
| 4 | ⭐⭐ The same sentence, for the `BC-25` allocation of 22 parameters | `ADR-0151` **L8** | ⭐⭐ **`Accepted` — already exercised** | as above |
| 5 | ⭐⭐ The same sentence, for the 17 `ATT-CFG` allocations | `ADR-0153` **L8** | ⭐⭐ **`Accepted` — already exercised** | as above |
| 6 | *"**Authorization owner** (`BC-18`/`PRD-001`) + **Product Owner**"* as the named owner of `SAAS-GAP-004` — *"No enumerated permission for settlement, for any role"* | `PAYMENT_GOVERNANCE_RESOLUTION.md` **L104** | open | Who owns an unassigned-permission gap? |
| 7 | Routing target of open items — `ADR-0155` `S-3` *(`SCFG-2` reviewer)*, `ADR-0157` `SE-2`, `ADR-0158` `O-3` *(5 authorization-semantic)* and `O-7` *(`CFG-12`, `SCFG-2`)* | four `Accepted` ADRs | open | A routing target that does not exist is an item that can **never** be actioned |

⭐⭐ **Rows 3–5 foreclose every alternative.** For the Privacy Owner, `ADR-0077` had to argue from
rules that merely *demanded* a role. Here — as with the Governance Owner — **three `Accepted` Rank 2
decisions have already acted through the office.** ⛔ The question is not whether it should exist;
the repository's own accepted decisions **presuppose** it. The only question is whether the ownership
model should continue to omit it.

⭐ **§2.1's minimality test is a CONDITIONAL, and it is MET, not overridden.** The clause excludes a
further role *if and only if* **no rule serves it**. Seven rules serve this one, ⭐ **one of them at
Rank 5** and ⭐ **three of them already exercised**. The clause is **preserved, not deleted** — for the
reason `ADR-0077` §3 row 7 gives: it is the very discipline that makes the derivation lawful.

### 2.3 ⭐ §2.3's vocabulary-reuse constraint is satisfied

§2.3 requires *"**Every role name below already appears in the repository.** This document adopts the
existing vocabulary rather than introducing a parallel one."*

| Name | Prior use |
|---|---|
| ⭐ **Authorization Owner** | **70** occurrences across **25** files, including `Accepted` `ADR-0132` §7 *(×5 rows)*, `ADR-0150` **L8**, `ADR-0151` **L8**, `ADR-0153` **L8**, `ADR-0155` `S-3`, `ADR-0157` `SE-2`, `ADR-0158` `R-3`/`R-7`, `ADR-INDEX`, `DOCUMENTATION_BASELINE` **L392** |
| The anchored long form | ⭐ *"Authorization (`BC-18`/`PRD-001`) Owner"* — **8** occurrences. ⭐ **`BC-18` is the anchor `ARCHITECTURE_RULINGS` L230 assigns** and `PRD-001` is the Authentication PRD (`PRD_REGISTRY` §3.2) |

⛔ **No new vocabulary is introduced**, and ⛔ **the compound anchor is preserved, not renamed**.

### 2.4 ⭐ Limb B — the `Security Owner` office is RECORDED (discharging `O-1`)

**The `Security Owner` office, as already designated by `ADR-0158` `R-1`, is recorded in a new §17.**

⭐⭐ **The authority boundary is transcribed from `ADR-0158` §2.1b and is NOT restated, widened,
narrowed or paraphrased into new scope:**

| The office **HAS** | The office **does NOT have** |
|---|---|
| ⭐ Security **review** | ⛔ Product authority |
| ⭐ Security **decision** | ⛔ Architecture authority |
| | ⛔ Tenant authority |
| | ⛔ Implementation authority |
| | ⛔ **Permission authority** |
| | ⛔ **Permission-creation authority** |

⚠️⚠️ ⛔ **THE PERMISSION EXCLUSION IS LOAD-BEARING AND IS CARRIED ACROSS INTACT.** `ADR-0158` §2.1b
holds that it means the Security Owner ⛔ **cannot** resolve the authorization-semantic parameters of
`R-3` — *"those stay with the **Authorization Owner**"*. ⭐ **Constituting the Authorization Owner in
the same commit does not relax that boundary; it supplies the office the boundary points at.**

⭐ ⛔ **This is a governance office, ⛔ NOT a runtime role in `AUTH` ch.07.** The platform register
stays **closed at two** (`PR-1`, `PR-2`) and the library register **closed at five** (`TR-1`…`TR-5`).
⛔ **0** `PERM-*` minted. ⚠️ Consistent with `Accepted` `ADR-0060`: the SECURITY platform **has no
bounded context**, and this record does not give it one.

### 2.5 ⛔⛔ What is NOT decided — read this before citing this ADR

| Does not | Consequence |
|---|---|
| ⛔ Authorize any `BC-25` parameter | ⭐ Coverage **79 / 104**, unchanged. **D3 stays `PARTIAL`** |
| ⛔ Change any `DP-0001` disposition | ⭐ All **25** stay **HELD / `PROPOSED`**; `DP-0001` stays **OPEN** |
| ⛔ Change `DD-0007` counts, verdicts or design-readiness | ⭐ `DD-0007` stays **v0.9** and ⛔ **NOT design-ready** |
| ⛔ Mint a `PERM-*`, role, action class or scope class | `AUTH-7.22` **closed at zero**; `ADR-0132` **not reopened** |
| ⛔ Engage any `ADR-0132` §7 prerequisite | ⭐ Prerequisite **1** *(an explicit conferral naming permission-catalogue population as its subject)* is **absent**, and **7** *(supersede `ADR-0043` §5.1)* is **untouched** |
| ⛔ Exercise either office | `O-2`…`O-7` all **OPEN** |
| ⛔ Name a person | §7 rule 4. Both offices **VACANT** |
| ⛔ Touch a frozen PRD or an `Accepted` ADR | `ADR-0151`…`ADR-0158` byte-unchanged |

⭐⭐ **A constituted office with nothing yet decided is the honest state** — and it is strictly better
than the prior state, in which decisions were routed to an authority the model did not define.

---

## 3. ⭐ Why none of the existing offices can absorb the `Authorization Owner`

| Candidate | Why not |
|---|---|
| **Architecture Owner** | ⛔ Foreclosed by measured practice: `ADR-0155` records `S-3` *(**Authorization Owner**)* and `S-4` *(**Architecture Owner**)* as **two distinct decisions in one ADR**, as does `ADR-0157` with `SE-2` and `SE-4`. ⭐ The repository has **already distinguished them**; merging would overturn two `Accepted` ADRs by side effect |
| **Product Owner** | ⛔ Same objection, sharper: `ADR-0150`/`0151`/`0153` each record a **joint Product Owner + Authorization Owner** conferral. ⭐ A joint conferral is only meaningful if the offices differ. §2.2 also scopes the Product Owner to *"business intent: scope, priority, acceptance"* — **not** which role may exercise a protected operation |
| ⭐⭐ **Security Owner** | ⛔⛔ **Expressly excluded by `ADR-0158` §2.1b** — *"no **permission authority**"*, and *"`R-3` stays with the **Authorization Owner**"*. ⭐ **A security office is not an authorization office**, and `ADR-0158` refused to merge them |
| **Governance Owner** | §10.1 scopes it to *"document **status** and **process**"*. ⛔ Whether `TR-2` may WRITE a parameter is neither |
| **Domain Owner** | §3 makes it **per-PRD** and derived from bounded contexts. ⛔ Authorization spans contexts — `ADR-0151` alone reaches `BC-25`, `BC-02`, `BC-06`, `BC-13`, `BC-18` |
| **Technical Owner** | §2.2 scopes it to implementation and sequencing, explicitly **not** *"whether a requirement is right"* |
| **Privacy Owner** | §9.1 decides whether processing personal data is **permissible** — a lawfulness question. ⛔ `ADR-0158` `O-5` routes the retention pair to it **separately** from `O-3`/`O-7` |

⇒ ⭐ **Seven rules, one distinct answer, and no existing office can supply it.**

---

## 4. Alternatives considered and rejected

| # | Option | Rejected because |
|---|---|---|
| 1 | ⛔ **Leave it undefined and keep routing to it** | This is the status quo, and it is a **live traceability defect**: three `Accepted` ADRs exercise an office the model never defines, and **7 `DP-0001` items** are blocked on an authority that formally does not exist |
| 2 | ⛔ **Fold it into the Security Owner** | ⛔⛔ Refused by `ADR-0158` §2.1b in terms — *"no permission authority"*. Doing it here would **silently overturn** an `Accepted` ADR accepted **in the same chain** |
| 3 | ⛔ **Insert a row into §2.2** | Breaks **72** citations to **L85** plus **35** to L197, **30** to L418 and **20** to L509, in `Accepted` ADRs and `DOCUMENTATION_BASELINE`. The identical objection §9, §10, §12, §13, §14 and §15 each measured |
| 4 | ⛔ **Constitute it as a one-act conferral** (the §13/§14/§15 pattern) | ⛔ Wrong instrument. Those offices were conferred for **one named act** and are **VACANT** outside it. This office has **already acted three times** and has **four** further open obligations (`O-3`, `O-7`, `ADR-0132` §7, `SAAS-GAP-004`). ⭐ A one-act conferral would mis-describe an authority already exercised repeatedly |
| 5 | ⛔ **Also decide `O-3` / `O-7` while the office is being constituted** | ⛔⛔ **Refused — this is the whole discipline.** *"Constituting an office is not exercising it"* (`ADR-0077` §2.4, `ADR-0080` §3.2, `ADR-0158` §6). ⭐ Deciding a parameter in the act that creates its decider is exactly the unbounded self-authorisation `ADR-0033` §7.1 warns against |
| 6 | ⛔ **Do Limb B only, and defer Limb A** | `O-1` would close while **7** `DP-0001` items stayed blocked on a non-existent office. ⚠️ The two limbs are **separable and are separated** — different authorities, different sections, both disclosed |
| 7 | ⛔ **Write two ADRs** | ⚠️ Considered seriously, on the `ADR-0117`/`ADR-0118` two-office/two-conferral reasoning. ⭐ Rejected because Limb B is **not a conferral of new authority** — it is a **transcription** of an act `ADR-0158` already performed, explicitly routed by `O-1` to the Governance Owner, who is **also** a decider of Limb A. ⭐ Both limbs are recorded with their **own** authority line in §7 so neither borrows the other's |
| 8 | ⛔ **Rewrite §2.1 to drop the minimality clause** | Unnecessary and destructive. The clause is a **test**, and the test is **met** |

---

## 5. ⚠️ The circularity objection, answered rather than avoided

| Objection | Answer |
|---|---|
| *"An office is being defined so that it can decide items in `DP-0001` — that is authority manufactured to order."* | ⛔ **The authority is not created here.** `ARCHITECTURE_RULINGS` **L230** (**Rank 5**) already assigns the authorization concern, and `ADR-0150`/`0151`/`0153` already **exercised** the office under direct conferral. ⭐ This ADR **writes down an authority that pre-exists it**. Refusing to write it down would not remove the authority — it would only keep it undocumented |
| *"Then why not also take the decisions, since the office now exists?"* | ⛔⛔ Because **existence is not exercise**. §2.5 and §4 row 5. ⭐ `DP-0001` stays **OPEN with 0 authority responses**, and all 25 stay **HELD** |
| *"Does this let the office expand its own scope?"* | ⛔ **No.** §16.1's scope is copied from rules that already exist (§2.2 rows 1–7) and is expressly bounded in §16.3 and §16.4. ⭐ **No duty appears that is not already assigned elsewhere**, and the office ⛔ **does not decide its own conferral or its own scope** |
| *"Does constituting the Authorization Owner weaken `ADR-0158`'s permission exclusion?"* | ⛔ **No — it strengthens it.** The exclusion pointed at an office that did not exist, making it unfalsifiable. ⭐ It now points at a **defined** office |

---

## 6. ⭐⭐ `ADR-0158` `O-1` — discharged, and the one deviation disclosed

`O-1` reads: *"Record the **Security Owner** office in `PRD_OWNERSHIP_MODEL` **§2.2**"*, owner
**Governance Owner**.

✅ **The obligation is discharged.** ⚠️⚠️ **But NOT at §2.2, and that deviation is disclosed rather
than glossed:**

| `O-1` says | ⭐ Actual | Why |
|---|---|---|
| Record it in **§2.2** | ⛔ Recorded in **§17**, by append | ⛔⛔ **Writing into §2.2 is the forbidden act.** §2.2's role table spans **L81–L86**; **72** citations point at **L85** alone. An inserted row shifts every citation beneath it — in `Accepted` ADRs and in `DOCUMENTATION_BASELINE` — including the citations to **L284** that are the evidence for the authority under which this very ADR was conferred |

⭐ **This is not a new exception; it is the sixth application of a rule this document has applied to
every office since `ADR-0077`.** §9 (Privacy), §10 (Governance), §13 (SRE), §14 (EVENT platform) and
§15 (DATA / EVENT) are **all** recorded outside §2.2 for exactly this reason, and §9 states the
principle: ⭐ *"**The role is no less constituted for being recorded here:** this document is the
ownership model **in whole, not in part**."*

⭐ **`O-1`'s substance — that the office be recorded in `PRD_OWNERSHIP_MODEL` — is satisfied in full.**
⛔ Only its **section number** is departed from, and ⛔ **`ADR-0158` is NOT edited** to match.

---

## 7. Execution — by append

Applied to `docs/00-governance/prd-ecosystem/PRD_OWNERSHIP_MODEL.md` (**854** lines before):

| Step | Action | Authority |
|---|---|---|
| 1 | This ADR authored and accepted **BEFORE** the change (`DOCUMENTATION_BASELINE` §7 step 1) | — |
| 2 | ⭐ New **§16 — The `Authorization Owner` office**, appended at end of file: §16.1 role table · §16.2 derivation · §16.3 why no other office absorbs it · §16.4 what constituting it does **not** do · §16.5 change-history row | **Architecture Owner** + **Governance Owner** |
| 3 | ⭐ New **§17 — The `Security Owner` office**, appended below §16: §17.1 role table *(boundary transcribed from `ADR-0158` §2.1b)* · §17.2 authority basis · §17.3 what recording it does **not** do · §17.4 `O-1` disposition · §17.5 change-history row | **Governance Owner** *(`O-1`)* |
| 4 | ⛔ **Baseline identifier NOT advanced** — `PRD_OWNERSHIP_MODEL` is a governance model, not a **Rank 1–3** document; `DOCUMENTATION_BASELINE` §7 rule 4 moves the identifier *"only when a Rank 1–3 document changes version"*. The identical exemption `ADR-0077` and `ADR-0080` each recorded for this same file | — |

⛔ **NOT touched:** §§1–8 body, §2.1, §2.2 (including **L85**), §2.3, §3, §4, §5 (including **L284**),
§6, §7, §8 changelog table, §9, §10, §11, §12, §13, §14, §15.

### 7.1 ⭐ Append safety — measured, not assumed

| Measurement | Value |
|---|---|
| Line count before | **854** |
| Line-citations into this document across `docs/` | ⭐ **380**, across **77** distinct lines |
| Most-cited lines | **L85** ×72 · **L197** ×35 · **L418** ×30 · **L509** ×20 · **L83** ×17 · **L284** ×16 |
| ⭐⭐ Highest **genuine** line cited | ⭐ **L509** |
| Apparent citations above **L854** | **3** — ⭐ **all inspected individually**: `PRD-015_FINAL_ARCHITECTURE_DECISION_PREPARATION.md` **L731** cites *"EA **L1527**, **L1536**"* — ⛔ **EA line numbers, not this document's**, captured by regex proximity; and `PRD-015_CONSOLIDATED_ARCHITECTURE_COMPLETION.md` **L421** cites §12.1 with a *"corroborated subject **L980**"* — ⚠️ **pre-existing and already out of range before this pass** |
| ⭐⭐ Citations invalidated by appending at **L855+** | ⭐⭐ **0** |

⚠️ **The two EA citations are a defect of the measuring instrument, not of the documents — recorded
so a later pass does not rediscover them as real.** ⚠️ The third (**L980**) is **pre-existing drift**,
⛔ **disclosed, not repaired**, and ⛔ **not made wrong by this pass** — the file was 854 lines before
and the citation was already out of range.

---

## 8. Compliance record

| Check | Result |
|---|---|
| Office **invented**, or **derived**? | ✅ **Derived** — §2.2, seven pre-existing rules, by §2.1's own method |
| §2.1's minimality test respected? | ✅ It is a **conditional**, and it is **MET**. Clause **preserved, not deleted** |
| §2.3 *"vocabulary reused, not invented"*? | ✅ **70** prior occurrences; anchored form preserved |
| Any `BC-25` parameter authorized? | ⛔⛔ **NO** — ⭐ **79 / 104 unchanged** |
| Any `DP-0001` disposition changed? | ⛔ **NO** — 25 **HELD**, pack stays **OPEN**, **0** authority responses |
| `DD-0007` counts / verdicts / readiness changed? | ⛔ **NO** — **v0.9**, D3 **`PARTIAL`**, ⛔ **not design-ready** |
| Any `PERM-*` created? | ⛔ **NO** — `AUTH-7.22` **closed at zero**; `ADR-0132` **not reopened** |
| Any role, action class or scope class created in `AUTH` ch.07? | ⛔ **NO** — `PR-1`/`PR-2` closed at two; `TR-1`…`TR-5` closed at five |
| `ADR-0158`'s Security Owner boundary altered? | ⛔ **NO** — transcribed **verbatim**, incl. the permission exclusion |
| Existing office altered? | ⛔ **NO** — every §2.2 row and §9/§10/§13/§14/§15 table byte-unchanged |
| Approval authority redistributed? | ⛔ **NO** — **L284**'s *"Only the Architecture Owner approves"* untouched |
| Personal name recorded? | ⛔ **NO** — both offices **VACANT** (§7 rule 4) |
| Frozen PRD or `Accepted` ADR modified? | ⛔ **NO** |
| Baseline identifier advanced? | ⛔ **NO** — §7 rule 4 limb **UNMET** |
| Citations invalidated? | ⭐⭐ **0** — §7.1 |
| Pre-existing defect search performed? | ✅ Performed, ⛔ **did NOT return empty** — the **L980** citation drift and the §2 *"four roles"* arithmetic (now understating by **more**). ⚠️ **Disclosed, not repaired** |
| Runtime code touched? | ⛔ **NO** — **0** files under `lib/`, `test/`, `tool/` |

---

## 9. ⚠️ Disclosed, not repaired

| # | Item | Why not repaired here |
|---|---|---|
| 1 | §2's arithmetic — *"Four distinct answers"*, *"Four roles is therefore the minimum"*, *"A fifth would have no rule to serve"* | ⭐ The clause is a **conditional test** that §16.2 *satisfies* rather than overrides, so the **reasoning survives** and only the **count** is stale. ⛔ Editing it in place is the insertion that breaks **72** citations to **L85**. Disclosed for the **sixth** time and routed |
| 2 | §2.2's table still shows four rows; **L509** still says *"the six that exist"* | ⚠️ Same reason. ⛔ **L509 carries 20 citations and is NOT edited.** ⭐ The document is the model *in whole, not in part* |
| 3 | The `Version` field at **L6** still reads `v1.1` | ⚠️ **Pre-existing since v1.2**, disclosed by `ADR-0077` §8 and carried by `ADR-0080`, `ADR-0102`, `ADR-0117`, `ADR-0118`. ⛔ **Not introduced by this pass** |
| 4 | `PRD-015_CONSOLIDATED_ARCHITECTURE_COMPLETION.md` **L421** cites a *"subject **L980**"* in an 854-line file | ⚠️ **Pre-existing drift**, ⛔ not caused by and ⛔ not worsened by this append |
| 5 | ⭐ `SECP-DEP-007` — §4.2's stale `PRD-012` rows (`ADR-0080` §6 row 5) | ⛔ Still **OPEN**. **L180** is a cited line |
| 6 | `PGA-08` — *"Every PRD needs a named owner. None has one"* | ⛔ §7 rule 4 forbids names. This records **offices**, not appointments |

---

## 10. ⛔⛔ What this ADR does not do

| Claim | Status |
|---|---|
| A holder is appointed to either office | ⛔ **NO.** Both **VACANT** |
| Any `BC-25` parameter is authorized | ⛔⛔ **NO.** ⭐ **79 / 104**, unchanged |
| `DP-0001` Group 1 / 2 / 3 / 4 / 5 is decided | ⛔ **NO.** All **25 HELD**; the pack stays **OPEN** |
| `O-2`…`O-7` are discharged | ⛔ **NO** — ✅ **only `O-1`** |
| `ADR-0132` §7 is engaged, or a permission may now be minted | ⛔⛔ **NO.** Prerequisite **1** absent, prerequisite **7** *(supersede `ADR-0043` §5.1)* **untouched** |
| `ATT-GAP-012`, `ATT-GAP-014`, `SM-GAP-2`, `SEAT-GAP-005`, `CNF-GAP-002`, `CNF-GAP-007` close | ⛔ **NO** — all **OPEN** |
| `DD-0007` becomes design-ready, or any count/verdict moves | ⛔⛔ **NO** — **v0.9**, D3 **`PARTIAL`** |
| The 104-parameter inventory changes | ⛔ **NO** — ⭐ **104**, and **79 + 25 = 104** still reconciles exactly |
| A bounded context, edge, aggregate or port is created | ⛔ **NO** — ⚠️ `ADR-0060` stands: the SECURITY platform still has **no** bounded context |
| Any lifecycle stage advances, or any document is frozen or baselined | ⛔ **NO** |
| Any runtime code, test or build artefact changes | ⛔ **NO** — **0** files |
