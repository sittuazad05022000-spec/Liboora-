# ADR-0132 — The `AUTH-7.22` permission catalogue is audited: **zero enumerated permissions are RETAINED**, the derived-capability mechanism is recorded as the lawful route, and minting a permission identifier is reserved to a **separate authorized act**

| Field | Value |
|---|---|
| **ADR** | `ADR-0132` |
| **Status** | ⭐ **Accepted** — 2026-09-10, by direct, explicit conferral of the human principal of this engagement, jointly exercising **Authorization (`BC-18`/`PRD-001`) Owner**, **Product Owner** and **Governance Owner** authority, scoped to **this act and nothing else**. Same disclosure as `ADR-0033`, `ADR-0043`, `ADR-0129`, `ADR-0130` and `ADR-0131`: ⛔ **no ARB quorum, attendee list, sign-off date or Security review is asserted**, and *"a conferral for one act is not a standing licence"* (`ADR-0033` §7.1) — every office ⛔ **reverts on completion** |
| **Date** | 2026-09-10 |
| **Act performed** | ⭐ **Audit `AUTH-7.22` and `ADR-0043` §5.1 repository-wide, and formally record the disposition.** ⛔ **NOTHING ELSE.** |
| **⭐⭐ CENTRAL OUTCOME** | ⛔⛔ **ZERO permission identifiers are created by this act.** Active enumerated permissions remain **0** — ⭐ **retained deliberately, on measured evidence, not by omission or oversight** |
| **Supersedes** | **Nothing.** ⛔ No ADR is amended, restatused, rewritten or superseded |
| **Amends** | `ADR-INDEX.md` · `DOCUMENTATION_BASELINE.md` — each by the **smallest change** that records this audit. ⛔ **`AUTH-7.22` itself is NOT amended** (see §6.1) |

---

## 1. The four audit questions, and their measured answers

| # | Question | Measured answer |
|---|---|---|
| **1** | **Existing valid permission IDs** | ⭐⭐ **ZERO.** No permission identifier exists anywhere in the repository |
| **2** | **Withdrawn / retired permission IDs** | ⭐ **ONE token, `A1-PERM-PARTICIPATE`**, appearing **twice**, both times as a **withdrawal record** |
| **3** | **Does any governing authority explicitly authorize creating new permission IDs?** | ⛔⛔ **NO.** Measured **zero** authorizing statements and **multiple** explicit prohibitions |
| **4** | **Can current requirements be satisfied using existing role / action / scope mechanisms?** | ⭐ **YES — and they already are.** The **derived-capability** mechanism is in active use across **253** identifiers in three families |

---

## 2. Question 1 — existing valid permission IDs: **ZERO**

**Method, reproducible:**

```
grep -rhoE '\bPERM[-_][A-Za-z0-9_.:-]+' docs/ lib/ test/ tool/ | sort | uniq -c
```

**Result: 2 occurrences of exactly 1 token**, and that token is withdrawn (§3).

### 2.1 What `AUTH-7.22` actually closes, quoted

`prd-v2/07-Roles-Permissions-and-Access-Policies.md` **L124**:

> `AUTH-7.22` — The permission catalogue **MUST** be closed. A permission not declared in it cannot be granted,
> requested or evaluated.

⚠⚠ **The decisive structural finding, stated precisely: the catalogue enumerates CLASSES, not IDENTIFIERS.**

| Register | Location | Contents | Count |
|---|---|---|---|
| **Permission categories** | **L131**–**L138** | Identity · Operational · Member · Financial · Configuration · Platform | **6 categories** |
| **Action classes** | **L142**–**L149** | Read · Create · Update · Delete · Approve · Export | **6 actions** |
| **Scope classes** | **L164**–**L169** | Self · Linked · Tenant · Platform | **4 scopes** |
| ⭐⭐ **Enumerated permission IDENTIFIERS** | — | ⛔⛔ **NONE** | ⭐ **0** |

⭐ **The catalogue is therefore closed and empty at the same time.** It defines the *shape* a permission must have —
a category, an action class (`AUTH-7.24`, `AUTH-7.25`), and a mandatory scope (`AUTH-7.23`, `AUTH-7.26`,
`AUTH-7.27`) — but it names **not one permission**.

### 2.2 Three false leads, checked and eliminated

⚠ An audit that only searched for `PERM-*` would be incomplete. Three other candidate shapes were tested:

| Candidate | Measured | Verdict |
|---|---|---|
| **`identity.policy_decision`** — **42 occurrences**, the largest dotted-token family | Appears in `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` **L193** as *"`identity.policy_decision` **# authorisation check**"* and **L220** as *"**ask `BC-18`, never evaluate or cache**"* | ⛔ **NOT a permission.** It is a **module dependency port** — the declared channel through which a module *asks* `BC-18` for a decision. ⭐ `ADR-0035` **L243** calls it *"the authorisation **port** every module uses"* |
| **`configuration.settings`** — 3 occurrences | Module port | ⛔ **NOT a permission** |
| **Dotted permission convention** (`member.read`, `attendance:create`, etc.) | `grep -rhoE '\`(identity\|operational\|member\|financial\|configuration\|platform)[.:][a-z_]+\`' docs/` | ⛔ **No such convention exists.** Only the two ports above matched |

⭐ **Conclusion: there is no permission identifier in this repository under any naming shape**, and — critically —
⛔ **no naming convention exists that a new identifier could be formed according to.** Minting one would require
**inventing the convention first**, which is a strictly larger act than minting an identifier within one.

---

## 3. Question 2 — withdrawn / retired permission IDs: **ONE**

| Token | Occurrence | Text | Classification |
|---|---|---|---|
| **`A1-PERM-PARTICIPATE`** | `PRD-021A_A1_LIBRARY_COMMUNITY_FOUNDATION_DRAFT_v0.2.md` **L906** | *"**Removed** — replaced by derived capability `LCM-AUTH-001`"* | ⛔ **WITHDRAWN** |
| **`A1-PERM-PARTICIPATE`** | `PRD-021A_STAGE4_REQUIREMENTS_REVIEW_2026-08-31.md` **L271** | *"No `PERM-*` minted \| 1 token, A1 **L906** … ✅ **withdrawal record, not a mint**"* | ⛔ **WITHDRAWAL RECORD** |

⭐ **This is the single most useful finding in the audit**, because it is not merely a deletion — it is a **worked
precedent** showing what a drafter should do *instead* of minting.

**The A1 withdrawal table** (**L900**–**L912**) retired nine coined tokens in one pass, each *"replaced by"* an
existing mechanism: `A1-PERM-PARTICIPATE` → derived capability · `A1-ROLE-STAFF` → *"`TR-1` … `TR-5` is closed"* ·
`A1-EDGE-LIB-COMM` → *"`E-02` already exists"* · `A1-TERM-MEMBERSHIPHOLDER` / `A1-TERM-ACCESSROLE` → *"coined
term; §5 uses existing vocabulary"*.

⭐ **The pattern is consistent: the coined identifier was not needed, because an existing mechanism already reached
the requirement.** That is the answer to question 4, arrived at by precedent rather than by assertion.

⛔ **`A1-PERM-PARTICIPATE` is NOT revived, reinstated or reused by this ADR**, and per `ADR-INDEX` **L206** the
identifier is ⛔ **never reusable**.

---

## 4. Question 3 — is creating new permission IDs authorized? **NO**

### 4.1 Zero authorizing statements

**Method:**

```
grep -rniE "(may|can|shall|must|authorised|authorized|permitted) (now )?(mint|create|allocate|declare|add) (a |new )?permission" docs/
   | grep -viE "do not|must not|never|cannot|no |⛔"
```

**Result: ⭐ ZERO matches.** ⛔ **No document in this repository authorizes the creation of a permission
identifier** — not `MASTER_PRD`, not the Authentication PRD at v2.0 or v3.0, not any of the 81 Accepted ADRs, not
the BC Map, not the ownership model.

### 4.2 Multiple explicit prohibitions

| Source | Status | Prohibition, quoted |
|---|---|---|
| **`ADR-0043` §5.1** | ⭐ **ACCEPTED** | *"Owner may explicitly grant approval access **using the existing permission/access-control mechanism**. **Do not invent a new permission ID.**"* |
| **`ADR-0036` §7.1** | ⭐ **ACCEPTED** | *"Permissions \| **None.** No `PERM-*`. `AUTH-7.22` closes the catalogue and **0** exist repository-wide"* |
| **`PRD-022` `SAAS-XC-005`** (**L153**) | `DRAFT` | Forbids *"Declaring, granting, evaluating or naming a **permission** or a **role**"* |
| **`X-13`** (`PRD-022` **L150**) | — | *"No authorisation decided outside `BC-18`"* — and names a permission minted elsewhere *"a security defect that passes its own tests"* |
| **`ADR-0130`** | ⭐ **ACCEPTED** | `SAAS-GAP-004` deferred **V2** precisely because no permission may be minted |
| **`ADR-0131`** §9.2 | ⭐ **ACCEPTED** | Binds every future Technical Specification: ⛔ no permission, ⛔ no `PERM-*` |

⭐ **`ADR-0043` §5.1 is the controlling instrument**, and it does two things at once that are easily conflated:

1. ⭐ It **affirms that a real requirement exists** — the Owner *may* grant approval access.
2. ⛔ It **forecloses the obvious implementation** — *"Do not invent a new permission ID."*

⚠ **`ADR-0043` §5.1 therefore does not merely prohibit; it prescribes.** It directs the requirement to *"the
**existing** permission/access-control mechanism"* — which §5 below identifies and measures.

### 4.3 ⚠ The apparent paradox, resolved honestly

`AP-4` (**L52**) states: *"Permissions are granted **by name**. No permission is derived from role naming,
hierarchy, seniority or similarity to another permission."* `AP-3` (**L51**) adds: *"Absence of an explicit grant
is refusal. **A newly introduced permission is unreachable by every role until explicitly granted.**"*

⚠ **Read literally against an empty catalogue, `AP-4` means no permission can be granted by name, because no name
exists.** That is a real and uncomfortable consequence, and ⭐ **it is recorded here rather than argued away.**

⭐ **The resolution is `AP-8`** (**L53**): *"**Policy-based** — decisions are produced by **evaluating policy**
against role, tenant, action and resource — never by conditional logic embedded in a feature."* ⭐ **`AP-8`
describes an authorization model that does not require a named permission to reach a decision**: role + tenant +
action + resource is sufficient input. ⛔ It does not repeal `AP-4`; it means a decision can be **derived** from
policy rather than **granted** by name — which is exactly the mechanism §5 measures already in use.

⛔ **This ADR does not decide which of `AP-4` and `AP-8` governs a future named-permission design.** That is
reserved to the separate act named in §7.

---

## 5. Question 4 — can current requirements be satisfied by existing mechanisms? **YES, and they already are**

### 5.1 ⭐⭐ The derived-capability mechanism, measured in active use

**Method:** `grep -rhoE '\b[A-Z]{2,5}-AUTH-[0-9]{3}\b' docs/ | sed -E 's/-[0-9]{3}$//' | sort | uniq -c`

| Family | Occurrences | Owning PRD |
|---|---|---|
| **`LCF-AUTH-*`** | **173** | `PRD-021A` Library Community Feed |
| **`LCM-AUTH-*`** | **58** (`LCM-AUTH-001`…`LCM-AUTH-018`) | `PRD-021A` Library Community |
| **`LCO-AUTH-*`** | **22** | `PRD-021A` Official Communication |
| **Total** | ⭐ **253 occurrences across 3 families** | all **baselined at Rank 3** by `Accepted` `ADR-0087` |

⛔ **Verified: NONE of the 253 claims to be a permission.** A search for *"is a permission"*, *"declares a
permission"* or *"grants"* within those identifiers' text returned **0 matches**.

### 5.2 The mechanism, in its own words

| Identifier | Text, quoted |
|---|---|
| **`LCM-AUTH-001`** | *"A1's capabilities **MUST** be **derived at evaluation time**. **Nothing is granted, assignable, delegable, inheritable, or stored.**"* |
| **`LCM-AUTH-002`** | ⭐⭐ *"A1 **MUST NOT** introduce a permission identifier. `AUTH-7.22` closes the catalogue; `ADR-0036` §7.1 records **zero** entries repository-wide."* |
| **`LCM-AUTH-004`** | *"Every conjunct **MUST** be evaluated. A1 **MUST NOT** short-circuit in a direction that produces a grant."* |
| **`LCM-AUTH-005`** | *"The composition **MUST NOT** confer authority."* |

⭐⭐ **`LCM-AUTH-002` is the single most important line in this audit.** A **baselined Rank 3 document** already
states the exact rule this act was asked to determine, cites the same two authorities, and reports the same
measurement of **zero**. ⭐ **This audit therefore CONFIRMS an existing governed finding rather than establishing a
new one** — which is a materially stronger position than a fresh assertion.

### 5.3 What the existing mechanism is composed of

⛔ **Every element already exists. This ADR creates none of them.**

| Element | Register | Count | Status |
|---|---|---|---|
| **Tenant roles** | `TR-1` Owner · `TR-2` Manager · `TR-3` Reception · `TR-4` Student · `TR-5` Parent | **5** | ⭐ **CLOSED** — *"`TR-1` … `TR-5` is closed"* |
| **Platform roles** | `PR-1` Platform Administrator · `PR-2` Platform Support | **2** | ⭐ **CLOSED** |
| **Action classes** | Read · Create · Update · Delete · Approve · Export | **6** | `AUTH-7.24`, `AUTH-7.25` — each granted independently |
| **Scope classes** | Self · Linked · Tenant · Platform | **4** | `AUTH-7.23`, `AUTH-7.26`, `AUTH-7.27` — scope mandatory |
| **Categories** | Identity · Operational · Member · Financial · Configuration · Platform | **6** | **L131**–**L138** |
| **Scope register** | `self` · `guardianOf` · `tenantWide` | **3** | `MP-GBR-21` — **closed scope register** |
| **Policy evaluation** | `AP-8` policy-based · `AP-9` fail-closed · `AP-3` deny-by-default · `AP-6` tenant isolation · `AP-7` no inheritance | **9 `AP-*`** | Rank 3 |
| **Authorization port** | `identity.policy_decision` | 1 | Rank 4 — *"ask `BC-18`, never evaluate or cache"* |
| **Derived-capability pattern** | `LCF-AUTH-*`, `LCM-AUTH-*`, `LCO-AUTH-*` | **253** | Rank 3, baselined |

### 5.4 ⚠ Honest limits of this answer

⭐ **The answer to question 4 is YES, but it is bounded, and the bound is stated rather than hidden:**

1. ⭐ **Proven for the requirements that have actually been drafted against it** — `PRD-021A`'s 253 derived
   capabilities demonstrate the mechanism works at scale in a baselined document.
2. ⚠ **NOT proven for every conceivable future requirement.** A requirement whose authority genuinely cannot be
   derived from role + tenant + action + resource + scope would need a **named** permission, and ⛔ **that case is
   not decided here**.
3. ⛔⛔ **Explicitly NOT satisfied: `SAAS-GAP-004`, the library → LIBOORA settlement authority.** `ADR-0130` §4
   deferred it to **V2** precisely because it could not be derived — `TR-1`'s declared authority is *"financial and
   revenue **visibility**"* (`prd-v2/02` **L159**), **not** outbound remittance execution, and `MP-GBR-21`'s closed
   scope register (`self`/`guardianOf`/`tenantWide`) does not obviously reach an act landing **outside** the tenant.
   ⭐ **That gap stays OPEN and V2-deferred; this ADR does not close it.**

⚠ **So the correct finding is not "no permission will ever be needed." It is: "no permission is needed *now*, by
any drafted V1 requirement, and the mechanism to avoid needing one is already governed and in use."**

---

## 6. Decision

1. ⭐⭐ **Active enumerated permissions remain ZERO**, and that state is ⭐ **formally RETAINED as the correct
   governed disposition** — not a defect, not an oversight, and not a gap awaiting quiet repair.
2. ⛔⛔ **ZERO permission identifiers are created by this act.** ⛔ No `PERM-*`, no dotted token, no category-action
   pair, no provisional name, no placeholder, no example.
3. ⭐ **The derived-capability mechanism is RECORDED as the lawful route** by which a V1 requirement obtains its
   authority without a named permission — composed of the closed role sets, the action and scope classes, the
   `MP-GBR-21` scope register, the `AP-*` policies and the `identity.policy_decision` port.
4. ⭐ **`ADR-0043` §5.1's instruction is CONFIRMED as still binding and still satisfiable**: the *"existing
   permission/access-control mechanism"* it points to is the mechanism enumerated in §5.3.
5. ⛔⛔ **Minting any permission identifier is RESERVED TO A SEPARATE AUTHORIZED GOVERNANCE ACT**, whose minimum
   contents are specified in §7.
6. ⛔ **`AUTH-7.22` is NOT amended, narrowed, widened or reinterpreted.** It remains closed, and it remains empty.

### 6.1 ⚠ Why `AUTH-7.22` itself is NOT edited

⛔ **`prd-v2/07-Roles-Permissions-and-Access-Policies.md` is byte-frozen** — the Authentication PRD v2.0 corpus is
recorded in `DOCUMENTATION_BASELINE.md` §3.3 as *"**HISTORICAL / FROZEN** — superseded by v3.0, byte-unchanged and
**NOT modified**"*, under tree `689070971e67d8621bd7eef22c7bdf4496eccd48`.

⭐ Three further reasons, each independent:

1. ⛔ **Nothing needs to change.** The audit's conclusion is that `AUTH-7.22` is **correct as written**. A closed,
   empty catalogue combined with `AP-3` deny-by-default and `AP-9` fail-closed is a **safe** configuration: it
   refuses rather than over-grants.
2. ⛔ **36 documents cite `AUTH-7.22`.** Amending it would ripple through every one, including baselined Rank 3
   documents whose conclusions depend on its current wording.
3. ⛔ **Authentication PRD v3.0 deliberately leaves it untouched** — measured: **zero** `AUTH-7.2x` references in
   v3.0, so the delta successor carried Chapter 7 forward **by reference with identifiers intact**. Amending
   `AUTH-7.22` now would require an **Authentication PRD v4.0**, which ⛔ **every conferral in this series
   forbids**.

⭐ **The audit's disposition is therefore recorded in an ADR and in the governance registers — never by editing the
frozen requirement it audits.**

---

## 7. ⛔ What a future permission-minting act would require

⚠ **Recorded so the next act is not improvised. ⛔ NONE of this is decided, begun or pre-approved here.**

| # | Prerequisite | Authority |
|---|---|---|
| **1** | An **explicit conferral** naming permission-catalogue population as its subject | Human principal |
| **2** | A **naming convention**, decided before any identifier is formed — ⚠ because **none exists** (§2.2), the convention is the larger decision and must come first | **Authorization (`BC-18`/`PRD-001`) Owner** + **Architecture Owner** |
| **3** | A **lawful home** for the catalogue. ⚠ `AUTH-7.22` lives in **byte-frozen** `prd-v2/07`, so population requires either an **Authentication PRD v4.0** or a **successor chapter** — ⛔ and v4.0 is currently forbidden | **Authorization Owner** + **Governance Owner** |
| **4** | A decision on the **`AP-4` / `AP-8` relationship** (§4.3) — whether authority is *granted by name* or *derived from policy*, or both | **Authorization Owner** |
| **5** | Per permission: its **category**, **action class** and **mandatory scope** (`AUTH-7.23`, `AUTH-7.26`) | **Authorization Owner** |
| **6** | A demonstration, **per permission**, that the requirement **cannot** be met by the §5.3 derived mechanism — ⭐ the `A1-PERM-PARTICIPATE` precedent puts this burden on the minter | **Product Owner** + **Authorization Owner** |
| **7** | Explicit supersession of **`ADR-0043` §5.1**'s *"Do not invent a new permission ID"*, by a **new ADR** — ⛔ `ADR-0043` is `ACCEPTED` and may **never** be edited in place (`ADR-INDEX` **L206**) | **Architecture Owner** |

⭐ **Prerequisite 7 is the hard gate.** `ADR-0043` §5.1 is an `ACCEPTED` Rank 2 decision. Until it is **lawfully
superseded**, ⛔ **no act may mint a permission identifier**, however well-intentioned.

---

## 8. Disposition of the `B-2` blocker

| Field | Value |
|---|---|
| **Before this act** | ⛔ **`B-2` OPEN** — *"`AUTH-7.22` permission catalogue — still ZERO enumerated permissions"*, recorded in `ADR-0131` §12 |
| **After this act** | ⭐ **`B-2` AUDITED AND DISPOSED — NOT "closed by population".** Active enumerated permissions **remain 0**, ⭐ **retained on evidence**; the lawful alternative mechanism is **recorded**; and minting is **reserved** to the §7 act |
| ⚠ **What is NOT claimed** | ⛔ **This act does NOT claim the catalogue is now populated.** ⛔ It does **NOT** unblock work that genuinely requires a named permission. ⛔ **`SAAS-GAP-004` remains OPEN and V2-deferred** |
| ⭐ **What IS now unblocked** | ⭐ A future Technical Specification may state authorization **by the derived-capability mechanism** with a **governed citation** (`ADR-0043` §5.1, `LCM-AUTH-001`/`002`, `AP-3`/`AP-8`/`AP-9`, `MP-GBR-20`/`21`/`23`) instead of ⛔ stalling on an empty catalogue **or** ⛔ inventing an identifier |

⚠ **The honest framing: `B-2` was never "populate the catalogue." It was "determine whether a specification author
may proceed, and how."** ⭐ That question is now answered with evidence: **proceed by derivation, cite the
mechanism, and mint nothing.**

---

## 9. ⛔ What this ADR does NOT do

⛔⛔ **ZERO permission identifiers created.** ⛔ `AUTH-7.22` **not amended** · ⛔ **no Authentication PRD v4.0** ·
⛔ Authentication **v2.0/v3.0** and `prd-v2/`/`prd-v3/` **byte-unchanged** · ⛔ `ADR-0043` **not amended, not
superseded, byte-unchanged** · ⛔ `ADR-0036` **byte-unchanged** · ⛔ `A1-PERM-PARTICIPATE` **not revived** · ⛔ no
role created (`TR-1`…`TR-5` and `PR-1`/`PR-2` remain **closed**) · ⛔ no action class, scope class or category
added · ⛔ `MP-GBR-20`/`21`/`23` **unchanged** · ⛔ no `AP-*` policy amended.

⛔ **`ADR-0130` and `ADR-0131` are byte-unchanged** and their boundary clauses remain fully in force. ⛔
**`PRD-008`, `PRD-019`, `PRD-022` not modified.** ⛔ **`SAAS-GAP-003`/`004` remain OPEN and V2-deferred.**

⛔ **No Technical Specification drafted** · ⛔ **`TS-001` NOT allocated** · ⛔ **`docs/50-technical/` NOT created** ·
⛔ **no API, endpoint, OpenAPI or contract** · ⛔ **no database, schema, SQL, migration or Supabase artefact** · ⛔
**no code, no test, no CI change**.

⛔ **Blockers `B-3`, `B-4`, `B-5`, `B-6` are NOT resolved** and remain exactly as `ADR-0131` §12 recorded them:

| Blocker | State after this act | Authority |
|---|---|---|
| **B-3** | ⛔ **OPEN** — `Q-01`, `Q-03`, `Q-04`, `Q-06` undecided; **`MP-DEP-07` still blocks schema freeze** | Architecture + Product (+ counsel for `Q-04`) |
| **B-4** | ⛔ **OPEN** — `PRD-008` **FROZEN v1.7 §6.1 L209/L210/L211/L213/L214** still say V1; superseded **in effect by rank**, **recorded not repaired** | Product + Architecture + Governance |
| **B-5** | ⛔ **OPEN** — no API style, error taxonomy, versioning or idempotency transport | Architecture Owner |
| **B-6** | ⛔ **OPEN** — `DEVELOPER_HANDOFF.md` (**8** stale auth refs, **0** Google) + **6** implementation documents stale | Governance + Technical Owner |

⛔ **No `GCP-*` closed** · ⛔ **`ADR-0129`'s register row still MISSING** (disclosed, routed, ⛔ not authored here) ·
⛔ **`A-9` not executed** · ⛔ **NOT pushed**.

---

## 10. Consequences

### 10.1 Positive

⭐ A specification author now has a **governed, citable answer** to *"how do I express authorization when the
catalogue is empty?"* — derive it, cite the mechanism, mint nothing. ⭐ The **`A1-PERM-PARTICIPATE` precedent** and
**`LCM-AUTH-002`** are surfaced as the canonical worked examples, so the next author follows a path already walked
in a **baselined** document. ⭐ The **§7 prerequisite list** means a future minting act starts from a specification
rather than an improvisation.

### 10.2 Negative and honest

⚠ **The catalogue is still empty, and this act does not make that comfortable.** ⛔ Any requirement that genuinely
needs a **named** permission is still blocked, and `SAAS-GAP-004` is the proof that such requirements exist.

⚠ **The `AP-4` / `AP-8` tension (§4.3) is recorded, not resolved.** A reviewer may reasonably hold that `AP-4`'s
*"granted by name"* cannot be satisfied by derivation at all. ⛔ **This ADR does not overrule that reading**; it
routes it to §7 prerequisite 4.

⚠ **`AUTH-7.22`'s lawful home is frozen**, so even a fully authorized future minting act faces the v4.0 problem
(§7 prerequisite 3) before it can write a single identifier.

---

## 11. Changelog

| Version | Date | Change |
|---|---|---|
| **1.0** | 2026-09-10 | ⭐⭐ **Created and `Accepted`. `AUTH-7.22` audited repository-wide; ZERO enumerated permissions RETAINED as the correct governed disposition** — by a one-act joint conferral of **Authorization (`BC-18`/`PRD-001`) Owner**, **Product Owner** and **Governance Owner** authority; ⛔ every office **reverts on completion** (`ADR-0033` §7.1). ⭐ **Four audit questions answered with reproducible measurements:** **(1)** existing valid permission IDs = ⭐⭐ **ZERO**; **(2)** withdrawn = ⭐ **ONE token, `A1-PERM-PARTICIPATE`**, 2 occurrences, **both withdrawal records**; **(3)** authority to mint = ⛔⛔ **NONE** — measured **0** authorizing statements against **6** explicit prohibitions (`ADR-0043` §5.1, `ADR-0036` §7.1, `SAAS-XC-005`, `X-13`, `ADR-0130`, `ADR-0131` §9.2); **(4)** can existing mechanisms satisfy requirements = ⭐ **YES, and they already do** — the **derived-capability** mechanism is in active use across ⭐ **253 identifiers in 3 families** (`LCF-AUTH-*` **173**, `LCM-AUTH-*` **58**, `LCO-AUTH-*` **22**), all **baselined at Rank 3** by `Accepted` `ADR-0087`, and ⛔ **none of the 253 claims to be a permission** (measured 0). ⚠⚠ **THE DECISIVE STRUCTURAL FINDING: `AUTH-7.22`'s catalogue enumerates CLASSES, NOT IDENTIFIERS** — **6** categories (**L131**–**L138**), **6** action classes (**L142**–**L149**), **4** scope classes (**L164**–**L169**), and ⭐ **0 permission identifiers**. It is therefore **closed and empty simultaneously**, and ⛔ **no naming convention exists that a new identifier could be formed according to** — so minting one would require **inventing the convention first**, a strictly larger act. ⭐ **Three false leads eliminated by measurement:** `identity.policy_decision` (**42** occurrences) is the Rank 4 **authorisation PORT** (*\"ask `BC-18`, never evaluate or cache\"*, Matrix **L193**/**L220**), `configuration.settings` is likewise a port, and ⛔ **no dotted/colon permission convention exists**. ⭐⭐ **THIS AUDIT CONFIRMS AN EXISTING GOVERNED FINDING RATHER THAN ASSERTING A NEW ONE:** **`LCM-AUTH-002`** — in a **baselined Rank 3** document — already states *\"A1 **MUST NOT** introduce a permission identifier. `AUTH-7.22` closes the catalogue; `ADR-0036` §7.1 records **zero** entries repository-wide\"*, citing the same two authorities and reporting the same measurement. ⭐ **`ADR-0043` §5.1 is the controlling instrument and it both affirms and forecloses:** the Owner *may* grant approval access, but *\"**Do not invent a new permission ID**\"* — it **prescribes** the *\"existing permission/access-control mechanism\"*, enumerated here as the **5 closed tenant roles** `TR-1`…`TR-5`, **2 closed platform roles** `PR-1`/`PR-2`, **6 action classes**, **4 scope classes**, **6 categories**, `MP-GBR-21`'s **closed 3-value scope register**, the **9 `AP-*` policies** and the `identity.policy_decision` port. ⭐ **The `A1-PERM-PARTICIPATE` withdrawal is recorded as a WORKED PRECEDENT, not a deletion** — A1's **L900**–**L912** table retired **nine** coined tokens in one pass, each *\"replaced by\"* an existing mechanism (`A1-ROLE-STAFF` → *\"`TR-1` … `TR-5` is closed\"*; `A1-EDGE-LIB-COMM` → *\"`E-02` already exists\"*), and ⛔ the identifier is **never reusable** (`ADR-INDEX` **L206**). ⚠ **AN UNCOMFORTABLE TENSION IS RECORDED, NOT ARGUED AWAY:** `AP-4` requires permissions be *\"granted **by name**\"* while the catalogue holds **no names** — resolved *for now* by `AP-8`'s **policy-based** model (role + tenant + action + resource), but ⛔ **the `AP-4`/`AP-8` relationship is NOT decided here** and is routed to §7. ⚠ **THE YES IS BOUNDED, AND THE BOUND IS STATED:** proven for the **253** drafted derived capabilities, ⛔ **NOT proven for every future requirement**, and ⛔⛔ **explicitly NOT satisfied for `SAAS-GAP-004`** — library → LIBOORA settlement authority, which `ADR-0130` §4 deferred to **V2** precisely because it **cannot** be derived (`TR-1` holds *\"financial and revenue **visibility**\"*, `prd-v2/02` **L159**, **not** outbound remittance execution; `MP-GBR-21`'s closed register does not reach an act landing **outside** the tenant) — ⛔ **that gap stays OPEN and V2-deferred**. ⛔ **`AUTH-7.22` IS NOT AMENDED**, for four independent reasons: it is **byte-frozen** (`prd-v2/` tree `689070971e67d8621bd7eef22c7bdf4496eccd48`, baseline §3.3 *\"byte-unchanged and NOT modified\"*); ⭐ **nothing needs to change** — a closed empty catalogue plus `AP-3` deny-by-default and `AP-9` fail-closed **refuses rather than over-grants**; **36 documents cite it**; and Authentication **v3.0 deliberately leaves it untouched** (measured **0** `AUTH-7.2x` references), so amending it would demand an ⛔ **Authentication PRD v4.0** that every conferral forbids. ⭐ **Seven prerequisites recorded for a future minting act** (§7), of which ⭐ **#7 is the hard gate**: `ADR-0043` §5.1 must be **lawfully superseded by a new ADR**, never edited in place. ⭐ **`B-2` DISPOSITION: AUDITED AND DISPOSED — NOT \"closed by population\".** Active enumerated permissions **remain 0**, ⭐ **retained on evidence**; ⛔ **this act does NOT claim the catalogue is populated** and ⛔ does **NOT** unblock work genuinely requiring a named permission; ⭐ what **is** unblocked is that a future specification may state authorization **by the derived mechanism with a governed citation** instead of stalling **or** inventing. ⛔⛔ **NOTHING ELSE EXECUTED:** ⛔ **ZERO permission identifiers created** — no `PERM-*`, no dotted token, no category-action pair, no provisional name, no placeholder, no example · ⛔ **no role created** (`TR-1`…`TR-5`, `PR-1`/`PR-2` remain closed), no action class, scope class or category added · ⛔ `MP-GBR-20`/`21`/`23` and all **9 `AP-*`** unchanged · ⛔ `ADR-0043`, `ADR-0036`, `ADR-0130`, `ADR-0131` **byte-unchanged** · ⛔ Authentication **v2.0/v3.0** byte-unchanged, **no v4.0** · ⛔ `PRD-008`/`PRD-019`/`PRD-022` **not modified** · ⛔ **`SAAS-GAP-003`/`004` remain OPEN** · ⛔ **`B-3`, `B-4`, `B-5`, `B-6` ALL REMAIN OPEN** — `MP-DEP-07` still blocks **schema freeze** · ⛔ **no Technical Specification drafted**, **`TS-001` NOT allocated**, **`docs/50-technical/` NOT created** · ⛔ **no API, endpoint, OpenAPI, SQL, schema, migration, Supabase artefact, code or test** · ⛔ **no blocker closed, no `GCP-*` closed** · ⛔ **`ADR-0129`'s register row still MISSING** · ⛔ **`A-9` not executed** · ⛔ **NOT pushed** — `github/main` remains `267f46e5c9b191da874553ffdfaf70dbfd3720cb`. |

---

*End of `ADR-0132`. ⭐ **Accepted** — audits the permission catalogue and **retains zero enumerated permissions**. ⛔ **Mints nothing.***
