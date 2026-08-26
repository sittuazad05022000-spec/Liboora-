# ADR-0080 — The `Governance Owner` role is constituted by derivation, closing the gap `ADR-0077` §9.4 disclosed but could not fix

| Field | Value |
|---|---|
| **Status** | **Accepted** — 2026-08-25 |
| **Date** | 2026-08-25 |
| **Deciders** | **Governance owner** — the role `PRD_LIFECYCLE.md` §6 **L282** assigns *"Stage 7; the baseline"* — exercised by **direct conferral** from the human principal of this engagement, in the identical form `ADR-0049`…`ADR-0054` and `ADR-0064` have each already exercised. ⭐ **The role is constituting its own written definition, not creating itself:** it is already named as `Deciders` in three **Accepted** ADRs, so the authority pre-exists this document and only its *definition* is missing |
| **Supersedes** | — |
| **Amends** | `docs/00-governance/prd-ecosystem/PRD_OWNERSHIP_MODEL.md` → **v1.3, BY APPEND ONLY** (new **§10**, appended below **L399**). ⛔ **No row is inserted into §2.1, §2.2, §2.3 or §5. No existing line moves.** §9 (Privacy Owner) is not modified. Executed, see §7 |
| **Amended by** | — |
| **Baseline** | **No baseline re-issue.** `PRD_OWNERSHIP_MODEL.md` is a governance model, not a Rank 1–3 document; `DOCUMENTATION_BASELINE.md` §7 rule 4 moves the identifier *"only when a Rank 1–3 document changes version"*. This is the identical exemption `ADR-0077` recorded for the identical file |
| **Closes** | ⭐ The **second defect disclosed in `PRD_OWNERSHIP_MODEL.md` §9.4** — *"`Governance Owner` occurs **0** times in this document"* — which `ADR-0077` deliberately left open as *"outside `ADR-0077`'s conferred authority"* · **`LCF-GAP-001`** and **`LCR-GAP-001`** (the `LCF-`/`LCR-` prefix registration), see §5 |
| **Does NOT close** | `LCF-GAP-004`, `LCF-GAP-006`…`LCF-GAP-011` · `LCR-GAP-002`, `LCR-GAP-004`, `LCR-GAP-006`, `LCR-GAP-007`, `LCR-GAP-008` · `LCR-DEC-001`, `003`, `004`, `006`, `007`, `009` · **`ADR-0075` §8.5 Option B** (the 281 bare EA line-citations) — *routed to this role, not resolved by constituting it* · §2's stale *"four roles"* arithmetic · `Q-A6` · `PGA-08` · **no lifecycle stage advances and no document is frozen** |
| **Related** | ⭐ **`ADR-0077`** (the direct precedent — same file, same append-only method, same derivation test; its §9.4 is this ADR's mandate) · `PRD_LIFECYCLE.md` §6 **L282**, §7 (*"Stage 7 is not skippable"*) · `ADR-0053` **L8**, `ADR-0054` **L8**/**L148**, `ADR-0064` **L7**/**L109**/**L134** (three Accepted ADRs already naming this role as `Deciders`) · `PRD_OWNERSHIP_MODEL.md` §2.1 (the minimality test), §2.2 **L85**, §3 rule 1, §7 rule 4, §9.3, §9.4 · `ADR-0033` §7.1 (the self-authorisation warning) · `ADR-0079` §3.2 |

> ✅ **ACCEPTED 2026-08-25. The amendment in §7 has been executed by append.**
>
> `PRD_OWNERSHIP_MODEL.md` §9.4 measured a defect and refused to fix it in the same pass, on the explicit
> ground that *"deriving a second undefined role in the same pass would be exactly the unbounded
> self-authorisation `ADR-0033` §7.1 warns against"*. **That restraint was correct, and this is the separate
> pass it demanded.** The defect is more serious than the one `ADR-0077` fixed: **three Accepted ADRs already
> record approval by a role the ownership model never defines.** Until now, the authority those ADRs exercised
> was traceable only to `PRD_LIFECYCLE.md` **L282** — a single table cell in a different document.

---

## 1. Context

### 1.1 The defect, as measured

| Measurement | Value |
|---|---|
| Occurrences of *"governance owner"* across `docs/` | **342** |
| Files containing it | **91** |
| Occurrences in `PRD_OWNERSHIP_MODEL.md` **before** this ADR | **5** — ⭐ **all five inside the §9 content `ADR-0077` added**, i.e. only as a *disclosure of its own absence*, never as a definition |
| **Accepted** ADRs naming it in their `Deciders` field | **`ADR-0053`** (L8), **`ADR-0054`** (L8), **`ADR-0064`** (L7) |
| Definition of the role in the ownership model | ⛔ **None** |

⭐ **This is the inverse of a normal gap.** The role is not missing from practice — it is one of the most
frequently invoked roles in the repository, and it has already approved baselines for `PRD-023`, `PRD-017` and
`PRD-012a`. What is missing is the *written definition* in the document whose entire purpose is to define
roles. A reader auditing `ADR-0054`'s authority is sent to `PRD_OWNERSHIP_MODEL.md`, and finds the role absent.

### 1.2 Why `ADR-0077` did not fix it

`ADR-0077` constituted the **Privacy Owner** and, in the same pass, *measured* this second gap and left it
open. `PRD_OWNERSHIP_MODEL.md` §9.4 records the reason verbatim:

> ⛔ **Disclosed, deliberately NOT fixed.** It is **more serious** than the privacy gap … and it is outside
> `ADR-0077`'s conferred authority. Deriving a *second* undefined role in the same pass would be exactly the
> unbounded self-authorisation `ADR-0033` §7.1 warns against.

⭐ **That disclosure is this ADR's mandate.** A defect that has been measured, named, and routed to a named
role is a defect awaiting an act — and `PRD_LIFECYCLE.md` §7 states that **"Stage 7 is not skippable"**, so
the role that owns Stage 7 cannot remain undefined indefinitely.

---

## 2. Decision

### 2.1 Derivation — the rules that already require this role

`PRD_OWNERSHIP_MODEL.md` §2.1 sets a **conditional** minimality test: *"A fifth would have no rule to serve"*.
`ADR-0077` satisfied that test for the fifth role by measuring five unserved rules. The same method is applied
here, and the evidence is **stronger** because it includes rules that have already been *exercised*.

| # | Rule | Where | What it demands | Rank / status |
|---|---|---|---|---|
| 1 | ⭐ **Stage 7 and the baseline** | `PRD_LIFECYCLE.md` §6 **L282** — `\| Governance owner \| Stage 7; the baseline \|` | Names the role **verbatim** and assigns it duties. The vocabulary is therefore **reused, not invented**, satisfying §2.3 | An existing governance rule |
| 2 | **Stage 7 is not skippable** | `PRD_LIFECYCLE.md` §7 | *"Urgent business need — **No fast path.** Stage 7 is not skippable"*. A non-skippable stage owned by an undefined role is unperformable as written | An existing governance rule |
| 3 | `ADR-0053` baselining `PRD-023` | `ADR-0053` **L8** | `Deciders: **Governance owner** (Stage 7 and the baseline, PRD_LIFECYCLE.md §6 L282)` | ⭐ **Accepted — already exercised** |
| 4 | `ADR-0054` freezing `PRD-017` | `ADR-0054` **L8**, and **L148** distinguishing it from the Architecture Owner (*"Those are different roles"*) | as above, plus an explicit separation-of-roles holding | ⭐ **Accepted — already exercised** |
| 5 | `ADR-0064` baselining `PRD-012a` | `ADR-0064` **L7**, **L109**, **L134** (*"The conferral here is **Governance Owner**"*) | as above, with an explicit statement of the conferral's limits | ⭐ **Accepted — already exercised** |
| 6 | The routing target of open gaps | `LCF-GAP-001`, `LCF-GAP-008`, `LCR-GAP-001`; `PRD_OWNERSHIP_MODEL.md` §9.4 (twice) | Items are already **routed to** this role. A routing target that does not exist is an item that can never be actioned | Open |

⭐ **Rules 3–5 are the ones that foreclose every alternative.** For the Privacy Owner, `ADR-0077` had to argue
from rules that *demanded* a role. Here, three **Accepted** ADRs have already **acted** through the role. The
question is not whether the role should exist — the repository's own accepted decisions presuppose it. The only
question is whether the ownership model should continue to omit it, and §9.4 has already answered.

### 2.2 The determination

1. ⭐ **The `Governance Owner` role is constituted**, as the **sixth** role of `PRD_OWNERSHIP_MODEL.md`, with
   the scope recorded in §7's new **§10.1**.
2. ⛔ **It is constituted VACANT.** `PRD_OWNERSHIP_MODEL.md` §7 rule 4 — *"**Never** record a personal name"* —
   is observed. Constituting an office does not fill it, and nothing here appoints anyone.
3. ⛔ **One holder**, per §3 rule 1.
4. ⭐ **The amendment is executed BY APPEND**, as a new **§10** below **L399**, for the reason `ADR-0077`
   established and this ADR re-verified: see §2.3.
5. ⛔ **`ADR-0075` §8.5 Option B is routed to this role, not resolved by it.** Constituting the role that owns
   a decision does not take the decision. The 281 bare EA line-citations remain **OPEN**.

### 2.3 Why append, and not a row in §2.2 — re-measured, not assumed

| Measurement | Value |
|---|---|
| `PRD_OWNERSHIP_MODEL.md` line count | **399** |
| Citations to it by line number across `docs/` | **74** |
| Highest line cited | ⭐ **L331** |
| Citations to **L85** (the Architecture Owner row) alone | **35** |
| Citations to L284 (*"Only the Architecture Owner approves"*) | **8** |
| Lines invalidated by appending at **L400+** | ⭐ **0** |
| Lines invalidated by inserting a row into §2.2 (at L85–86) | **every citation below it**, in **Accepted** ADRs and in `DOCUMENTATION_BASELINE.md` |

⛔ **Inserting a sixth row into the §2.2 table is the forbidden act,** for exactly the reason `ADR-0077` §9
records: it silently converts 35 citations to `L85` into misdirections. **The role is no less constituted for
being recorded in §10** — the document is the ownership model *in whole, not in part*, and §9 already
established this precedent for the Privacy Owner.

### 2.4 ⚠ The self-authorisation question, answered rather than avoided

`ADR-0033` §7.1 warns against unbounded self-authorisation, and §9.4 invoked it to defer this act. It must
therefore be answered directly, not stepped past.

| Objection | Answer |
|---|---|
| *"The Governance Owner is defining the Governance Owner — circular."* | ⛔ **Not circular, because the authority is not created here.** `PRD_LIFECYCLE.md` **L282** already assigns the role its duties, and `ADR-0053`/`0054`/`0064` have already exercised it under **direct conferral from the human principal**. This ADR writes down an authority that **pre-exists it**. Refusing to write it down would not remove the authority; it would only keep it undocumented. |
| *"Then why was it wrong to do this inside `ADR-0077`?"* | Because `ADR-0077`'s conferral was for the **Privacy Owner** question. Extending one conferral to cover a second, more serious role would be the unbounded move. A **separate ADR with its own conferral** is the bounded one — which is precisely what §9.4 prescribed by routing it rather than dropping it. |
| *"Does this let the role expand its own scope?"* | ⛔ **No.** §10.1's scope is copied from rules that already exist (§2.1 rows 1–5) and is expressly bounded in §10.3 by what the role may **never** decide. No duty appears in §10.1 that is not already assigned elsewhere. |

---

## 3. Consequences

### 3.1 What this closes

| Item | Before | After |
|---|---|---|
| `PRD_OWNERSHIP_MODEL.md` §9.4 defect 2 — *"`Governance Owner` occurs 0 times"* | ⛔ OPEN, disclosed | ✅ **CLOSED** — constituted in §10 |
| Traceability of `ADR-0053`/`0054`/`0064` authority | ⚠ Only to `PRD_LIFECYCLE.md` **L282** | ✅ Also to `PRD_OWNERSHIP_MODEL.md` **§10** |
| **`LCF-GAP-001`** — `LCF-` prefix not registered | ⛔ OPEN, *routed to the Governance Owner* | ✅ **CLOSED** — see §5 |
| **`LCR-GAP-001`** — `LCR-` prefix not registered | ⛔ OPEN, *routed to the Governance Owner* | ✅ **CLOSED** — see §5 |
| `PRD_OWNERSHIP_MODEL.md` version | `v1.2` | **`v1.3`** |
| Roles constituted | 5 | **6** |

### 3.2 What this does NOT close

⛔ **Constituting a role is not exercising it.** Every item routed *to* the Governance Owner other than the two
prefix registrations remains **OPEN**, and specifically:

| Item | Status after this ADR |
|---|---|
| **`ADR-0075` §8.5 Option B** — retire 281 bare EA line-citations in favour of section/node anchors | ⛔ **OPEN.** It touches **32 files including FROZEN `PRD-017` and the `PRD-012a` family**; `PRD_LIFECYCLE.md` **L177** forbids silent modification of a frozen PRD. Now *addressable*, not addressed |
| `LCF-GAP-008` — permission catalogue closed, zero `PERM-*` | ⛔ **OPEN** — requires the Auth owner as well |
| §2's *"Four distinct answers"* / *"a fifth would have no rule to serve"* arithmetic | ⚠ **Still stale, still disclosed, still not edited** — now understating by **two**. See §6 |
| `PGA-08` — *"Every PRD needs a named owner. None has one"* | ⛔ **OPEN.** §7 rule 4 forbids recording names; this ADR records an **office**, not an appointment |
| `Q-A6` | ⛔ **OPEN** |

⛔ **This ADR advances no lifecycle stage, freezes no document and confers no readiness.** `PRD-021A` remains
**NOT READY / NOT FROZEN**, and `PRD-021` remains gated behind `PRD-020`
(`PRODUCT_IMPLEMENTATION_ROADMAP.md` **L161–164**).

### 3.3 Verification performed

| Check | Result |
|---|---|
| `PRD_OWNERSHIP_MODEL.md` line count | 399 → **449** (all 50 new lines **at the end**) |
| Highest line cited anywhere | **L331** — below every new line ✅ |
| All 74 line-citations re-resolved | **0** invalidated, **0** whose cited content changed ✅ |
| **L85** (Architecture Owner row, 35 citations) | byte-identical ✅ |
| L64, L68, L69, L83, L102, L180, L202, L284, L329, L331 | byte-identical ✅ |
| §9 (Privacy Owner) | byte-identical ✅ |
| Diff hunk shape | one in-place header/changelog region + one append at EOF. ⛔ No hunk between L1 and L324 |
| Personal names recorded | **0** ✅ |
| FROZEN documents modified | **0** ✅ |

---

## 4. Alternatives rejected

| Alternative | Why rejected |
|---|---|
| Leave it open, as `ADR-0077` did | `ADR-0077` deferred it **to a separate pass**, not indefinitely. Three **Accepted** ADRs exercise an undefined role; leaving that unwritten is a live traceability defect, and `PRD_LIFECYCLE.md` §7 makes Stage 7 non-skippable |
| Insert a sixth row into §2.2 | Breaks **35** citations to **L85** in Accepted ADRs and in `DOCUMENTATION_BASELINE.md`. The identical objection `ADR-0077` §9 measured |
| Fold the duties into the **Architecture Owner** | ⛔ Refused by an existing holding: `ADR-0054` **L148** states of these two roles *"Those are different roles"*, and **L167** assigns a specific act to one and not the other. Merging them would overturn an Accepted ADR by side effect |
| Fold the duties into the **Product Owner** | §2.2 scopes that role to *"business intent: scope, priority, acceptance"*. Document status and freeze are neither |
| Amend `PRD_LIFECYCLE.md` **L282** instead | That cell is already correct. The defect is the ownership model's silence, not the lifecycle's |
| Record a holder's name to make the role actionable | ⛔ §7 rule 4: *"**Never** record a personal name"* |
| Also resolve `ADR-0075` Option B here, since the role now exists | ⛔ The role's *existence* is not its *exercise*, and Option B modifies **FROZEN** documents. Routed in §3.2 |

---

## 5. ⭐ `LCF-GAP-001` and `LCR-GAP-001` — closed, and why these two and no others

Both gaps say the same thing: the identifier prefixes `LCF-` and `LCR-` used throughout `PRD-021A` A2 and A3
are **not registered**, and both route the item to the **Governance Owner**.

**Why they close now:** `PRD_LIFECYCLE.md` §5 rule 3 states *"On collision, change the new prefix, never the
existing one"*, and rule 5 that *"Numbers are never reused, even after withdrawal"*. Registration of a prefix
is a **Stage 7 / baseline** act — precisely the duty `L282` assigns to this role. With the role constituted,
the act has an author.

| Prefix | Owning document | Collision check | Determination |
|---|---|---|---|
| **`LCF-`** | `PRD-021A` A2 — Library Community Feed & Content | Measured against every registered prefix: **no collision** | ✅ **REGISTERED** to `PRD-021A` A2 |
| **`LCR-`** | `PRD-021A` A3 — Community Feed Ranking | Measured: **no collision** | ✅ **REGISTERED** to `PRD-021A` A3 |

⛔ **What registration does NOT do.** It settles **only** the prefix. It creates no requirement, closes no
other gap, and confers no readiness on either annex. A registered prefix on a draft is still a draft — and A2
and A3 both remain **NOT READY / NOT FROZEN** with their remaining gaps open.

⛔ **No other routed gap is closed by this ADR**, because for every other one the Governance Owner is **not the
only** required authority: `LCF-GAP-008` needs the Auth owner, `LCF-GAP-004` the BC-14 author, `LCF-GAP-006`
the Product and Configuration Owners, `LCF-GAP-011` the Engineering Owner. Constituting one role does not
supply the others.

---

## 6. ⚠ Disclosed, not repaired

| # | Item | Why it is not repaired here |
|---|---|---|
| 1 | §2's arithmetic — *"Four distinct answers"*, *"Four roles is therefore the minimum"*, *"A fifth would have no rule to serve"* — now understates by **two** | The clause is a **conditional test**, and §2.1's method is *satisfied* by both derivations rather than overridden. Editing it in place is the insertion that breaks **35** citations to **L85**. Disclosed in the new **§10.4** and routed, exactly as `ADR-0077` did |
| 2 | §2.2's table still shows four rows | Same reason. §§9 and 10 are the two constituted additions, and the document is the model *in whole* |
| 3 | The **281 bare EA line-citations** (`ADR-0075` §8.5 Option B) | Now correctly routed to a role that exists — but it modifies **FROZEN** documents and needs the Architecture Owner too. **OPEN** |
| 4 | `PGA-08` — no PRD has a named owner | §7 rule 4 forbids names. Offices, not appointments |
| 5 | ⭐ **`SECP-DEP-007`** — `PRD-012a_PART8` **L358** requires `PRD_OWNERSHIP_MODEL.md` to *"reflect the executed split"*, owner **Governance Owner**. Its §4.2 **L179** still shows `PRD-012` live and *"Split"*; **L180**/**L181** still say *"(reserved)"* — though `ADR-0064` retired `PRD-012` and froze `PRD-012a`, discharging the dependency *"for the registry"* only and never touching this document | ⚠ **Now dischargeable for the first time, and deliberately not discharged.** **L180 is a cited line** and §4.2 cannot be corrected without changing cited content or shifting the 35 citations to **L85**. Performing it as a side effect of constituting its owning role is the §7 rule 1 act this ADR refuses elsewhere. Recorded as **live, owned and actionable** in the new §10.4 |
| 6 | ⛔ **A false finding, retracted.** Working notes for this pass carried *"`DOCUMENTATION_BASELINE.md` **L363** cites `PRD_OWNERSHIP_MODEL L358`"* as a known stale citation | ✅ **It was an instrument defect, not a document defect.** Read in full, **L363** cites **`PRD-012a_PART8` L358** — valid, in a 417-line file. The regex had captured `PRD_OWNERSHIP_MODEL.md` from earlier in the same sentence. ⭐ **Retracted rather than propagated** — and the real obligation it was masking is row 5 |

---

## 7. Execution

Applied to `docs/00-governance/prd-ecosystem/PRD_OWNERSHIP_MODEL.md`:

1. §8 changelog — a **`v1.3`** row appended to the table (inside §8, below **L331**, above §9).
2. A new **§10 — The `Governance Owner` role**, appended at end of file, with:
   - **§10.1** the role definition table (Decides / Attests / Never decides);
   - **§10.2** the derivation table — the six rules of §2.1 above;
   - **§10.3** why none of the other five roles can absorb it;
   - **§10.4** the disclosed-not-repaired items;
   - **§10.5** what constituting the role does **not** do.

⛔ **Not touched:** §§1–8 body, §2.1, §2.2 (including **L85**), §2.3, §3, §4.1–§4.4, §5, §7, §9.

---

## 8. What this ADR does not do

| Claim | Status |
|---|---|
| A holder is appointed | ⛔ **No.** Vacant. §7 rule 4 |
| Any document is frozen or baselined | ⛔ **No** |
| `ADR-0075` §8.5 Option B is resolved | ⛔ **No** — routed only |
| Any `LCF-`/`LCR-` requirement, register or acceptance criterion changes | ⛔ **No** |
| §2.2, §5 or any §4 PRD row is amended | ⛔ **No** — every cited line byte-identical |
| `PRD-021A` A2/A3 become ready or freezable | ⛔ **No** — **NOT READY, NOT FROZEN** |
| The `PRD-020` release gate is affected | ⛔ **No.** `PRODUCT_IMPLEMENTATION_ROADMAP.md` **L161–164** stands unchanged |
