<!--
  PROVENANCE
  ==========
  Document      : PRD-021A Part A5 — Official Library Communication
  Status        : DRAFT — v0.1
  Freeze status : NOT FROZEN. NOT FINAL. NOT APPROVED. NOT BASELINED.
  Lifecycle     : No stage advanced. Stage 3 is NOT CONFERRED. The 7-stage
                  PRD_LIFECYCLE.md ladder is untouched by this file's existence.
  Authored      : as a NEW part. This is not a recreation of any prior A5;
                  PRD-021A_A4_NON_EXISTENCE_FINDING.md L43 records that A5, A6,
                  A7 and A8 did not exist. A4 v0.1 now exists; A6, A7, A8 do not.

  WHAT THIS DOCUMENT DOES NOT DO
  ------------------------------
  This part does NOT:
    - allocate itself scope by its own authority (see 0.3)
    - take any Product Owner or Architecture Owner decision
    - invent a value, weight, threshold, priority number, permission,
      role name, retention period, rate limit or configuration default
    - register or ratify any identifier
    - modify, amend or supersede A1, A2, A3, A4, any ADR, the BC Map, the
      Enterprise Architecture, the Traceability Matrix or any FROZEN PRD
    - duplicate or reclaim ownership held by BC-01, BC-02, BC-06, BC-10,
      BC-11, BC-12, BC-13, BC-14, BC-18, BC-19, BC-22, BC-24, BC-25, BC-26,
      BC-29, or by A1, A2, A3 or A4
    - act as a placeholder for A6, A7 or A8
    - declare itself READY, FROZEN, CONFERRED or BASELINED
    - contain, imply or require application code

  FIVE CONFLICTS ARE DISCLOSED, NOT RESOLVED
  ------------------------------------------
  The scope request that produced this draft contains five statements that
  measured FALSE or UNPERMITTED against the repository. Each is recorded in
  3.3 with its measurement, and each is routed. None is silently corrected.
-->

# PRD-021A — Part A5

## Official Library Communication

### Specification v0.1 — DRAFT

> ⚠ **DRAFT — NOT FROZEN, NOT FINAL, NOT ALLOCATED.** Committed for review and
> traceability only. Publication of this file to `main` is a **filing act**. It
> confers no lifecycle stage, ratifies no identifier, and closes no gap.
>
> ✅ **This part's existence as Part A5 is DECIDED — Owner ruling **PO-7** (2026-08-31).** The
> ruling states, in its own words, that the official communication surface *"does exist"* and that *"it IS Part A5."* `LCO-GAP-001` and `LCO-DEC-001` are therefore **CLOSED**. ⭐ The allocation is reinforced from the other side by **PO-3**, which approved the measured `BC-15` residue as Part A4 and stated that *"A4 remains a part of PRD-021A, not a standalone PRD"* — the same reasoning applies to A5, and `PRD_REGISTRY.md` **L704** now records the allocation as **A1…A8**. ⚠ Closing this gate settles *which document owns the subject*; it confers **no lifecycle stage**. See §0.3.
>
> ✅ **This part's subject matter EXISTS — the Product Owner decision that gated it
> is now ANSWERED** — A3 v0.6 `LCR-DEC-006` is **CLOSED** by Owner ruling **PO-7** (2026-08-31) and has been marked closed in A3 at its **L1156**. ⛔⛔ **But the answer has two halves and only the first is permissive:** the surface exists *and* it **does NOT silently extend A2's closed event contract**. PO-7 clause 4 holds that A5 *"may publish via its own mechanism"* while *"A2's six-event contract remains authoritative unless A2 is separately amended"*, and clause 5 holds that A5 *"does NOT invent a seventh A2 event."* See §0.3.

---

## 0. Document control

| Field | Value |
|---|---|
| **Part** | `PRD-021A` A5 |
| **Title** | Official Library Communication |
| **Version** | v0.1 |
| **Status** | **DRAFT — not baselined, not approved, not frozen.** Scope allocation OPEN; subject-matter existence OPEN |
| **Predecessors read** | A1 v0.2, A2 v0.8, A3 v0.6, A4 v0.1 (all DRAFT) |
| **Identifier prefix** | `LCO-` — **PROPOSED, NOT REGISTERED.** Collision-measured: `LCO-` returns **0** occurrences across `docs/`, `lib/`, `test/`, `tool/`. Registration is a Governance Owner act under `PRD_LIFECYCLE.md` §5 rule 3, exercised for `LCF-` and `LCR-` by `ADR-0080` §5. **Not exercised here** |
| **Bounded context** | `BC-15` Community & Groups — `[SUPPORTING]`, **V2**, BC Map **L119** |
| **ADRs minted** | **Zero.** Next free number is `ADR-0083`; this part mints none |
| **Edges created** | **Zero** |
| **Aggregates created** | **Zero new roots.** See §19 |

### 0.1 Normative language

`SHALL` / `SHALL NOT` are binding on any implementation of *this part*, and take
effect **as of 2026-08-31**, because Owner ruling **PO-7** (2026-08-31) resolved BOTH `LCO-DEC-001` and `LCR-DEC-006` in this part's
favour. `MAY` is permissive. ✅ **§0.3's two gates are now CLOSED, so the conditionality that suspended every `SHALL` in this document is discharged.** ⚠⚠ **This is not the same as the requirements being approved.** They are now *unsuspended*, not *ratified*: this part has advanced no lifecycle stage, Stage 3 is **NOT CONFERRED**, the `LCO-` prefix registration is recorded in `PRD_OWNERSHIP_MODEL.md` §12 but **no `LCO-` identifier has been entered in `TRACEABILITY_MATRIX.md`**, and the decisions listed in §29.2 other than `LCO-DEC-001`/`002` remain **OPEN**. See the footer.

### 0.2 What this document is not

It is not an approval, not a baseline, not an architecture amendment, not an ADR,
and not a claim of scope. It is a **measured proposal**.

### 0.3 ⭐ The double existence gate — read this before reading anything else

This part is gated **twice**, on two independent open questions. Both are already
in the repository; neither is invented here.

`LCO-INV-001` | **Gate 1 — allocation.** No repository document allocates scope
to Part A5. Measured: `grep -rn "A1-A8\|A1–A8\|A4–A8" docs/` returns hits that
are all *freeze preconditions* or A3's `P0-5` correction; **none allocates
scope**. A4 v0.1 `LCG-DEC-001` asks the same question of itself and leaves it
open. → `LCO-GAP-001` / `LCO-DEC-001`. ✅ **GATE 1 IS NOW CLOSED — Owner ruling **PO-7** (2026-08-31).** ⭐ **The measurement above is left standing verbatim because it was accurate when taken.** It is not deleted and not softened: at the time of writing, no document did allocate scope to A5, and saying so was correct. What changed is not the measurement but the **authority** — the ruling supplied the allocation the repository lacked, and `PRD_REGISTRY.md` **L704** and §11.4 now carry it. ⭐ A4's `LCG-DEC-001`, which this line cites as asking the same question of itself, was closed by **PO-3** in the same ruling set, at A4 **L661**. ⚠ A gate closing is a **precondition** being met, not a stage being conferred.

`LCO-INV-002` | **Gate 2 — subject-matter existence.** A3 v0.6 `LCR-DEC-006`
asks, verbatim: *"Does an official announcement surface exist, and does it extend
A2's closed type set?"* — owner **Product Owner**, status **OPEN**. This part is
a specification *of that surface*. It therefore **presumes an answer the
repository has not given**, and says so rather than hiding it. →
`LCO-GAP-002` / `LCO-DEC-002`. ✅ **GATE 2 IS NOW CLOSED — Owner ruling **PO-7** (2026-08-31).** The ruling answers A3's verbatim question in both its parts. **Part 1 — does the surface exist?** Yes: *"an official communication surface does exist"* and *"it is Part A5."* **Part 2 — does it extend A2's closed type set?** ⛔ **NO.** PO-7 clauses 3–5 are explicit that A5 *"does not silently extend A2's closed contract"*, that A2's six-event contract *"remains authoritative unless A2 is separately amended"*, and that A5 *"does NOT invent a seventh A2 event."* ⭐⭐ **This part's own honesty is what made the gate closable.** §0.3 did not assume an answer and then build on it; it recorded that it *"presumes an answer the repository has not given, and says so rather than hiding it."* That disclosure is the reason the ruling could be applied as a **closure** rather than as a correction of a fabricated premise. ⚠ The six A2 events remain, by name: `community.PostPublished`, `community.PostUpdated`, `community.PostRemoved`, `community.CommentPublished`, `community.ReactionChanged`, `community.MembershipRevoked` — A5 adds none of them and renames none of them.

`LCO-INV-003` | **Every requirement in this document is conditional on BOTH
gates.** If the Product Owner allocates this subject elsewhere, or answers
`LCR-DEC-006` in the negative, this document is **withdrawn in full, not
amended**.

`LCO-INV-004` | This part SHALL NOT be read as the second answer to any question
A1, A2, A3, A4 or any FROZEN PRD already answers. Where a concern is owned
elsewhere, this part **routes** and does not restate.

`LCO-INV-005` | This part SHALL NOT act as a placeholder for A6, A7 or A8. Those
parts **do not exist** — measured at authoring time. Where this part needs a
concern they might one day hold, it names the **existing bounded context** that
holds it today, never the absent part.

---

## 1. Executive Summary

A library that operates a private community for its members has no authorised
way to speak to that community **as the institution**. Today the only writer A2
recognises is a member — `authorRef` is a `PersonId`-level reference (A2 §22) —
so a library's closing-time change, holiday notice or emergency instruction can
only be posted by a person, appearing under that person's identity.

A2 names this gap precisely and declines to fill it. `LCF-FR-002` (A2 **L422**):

> *"Library-relevant announcements have no durable home; `BC-22` Notification
> Delivery is a **push channel**, not a readable record."*

A3 names it a second time, reserves a vocabulary for it, and **forbids itself**
from creating it. `LCR-FR-045` (A3 **L730**):

> *"A3 SHALL NOT create an announcement type, a priority field, or a pinning
> mechanism."*

A5 is the part that would fill that gap. It specifies **official communication**
— a post written by a library, attributed to the library, optionally prioritised
for a bounded period, and auditable.

**What this part contributes that is genuinely new:** an *institutional author*.
Nothing else. It reuses A2's `CommunityPost` for storage, A2's feed for
retrieval, A3's ordering for placement, `BC-22` for push, `BC-24` for audit,
`BC-25` for values, `BC-18` for authorisation and `BC-13` for enforcement.

**What it cannot do, and does not pretend to.** Four of this part's central
requirements are **BLOCKED on decisions this part cannot take**:

| # | Blocked capability | Blocking authority | Owner |
|---|---|---|---|
| 1 | The official post **type** itself | A2 `LCF-FR-027` closes the type set at four; *"No fifth type SHALL be added without a PRD amendment"* | Product Owner + A2 author |
| 2 | **Library display identity** on a post | `BC-15` has **exactly one** edge in BC Map §7 (`E-14`, inbound). No edge reaches `BC-19`, `BC-06` or `BC-25`. BC Map **L292**: an edge not in the table *"does not exist"* | Architecture Owner |
| 3 | **PUBLIC** visibility | A2 `LCF-SEC-004` forbids *any* unauthenticated read path to community content; 14A §14A.5 (**FROZEN**) publishes a **closed** public-field list containing no announcement surface | Product Owner + Architecture Owner |
| 4 | **Attachments** | A2 `LCF-FR-043` already treats non-`TEXT` posts as blocked pending `LCF-ADR-002` | Architecture Owner (inherited) |

This part does **not** relax any of the four. It specifies against them and
records each as BLOCKED with a named owner.

---

## 2. Problem, Vision, Goals, Non-goals

### 2.1 Problem

`LCO-FR-001` | A library has no authorised institutional voice inside its own
community. Every writer A2 admits is a natural person.

`LCO-FR-002` | Operationally consequential information — a holiday, a closing
time change, a facility outage, an emergency instruction — is therefore either
not communicated in-product, or is communicated by a staff member **under that
staff member's personal identity**, which misattributes institutional authority
to an individual.

`LCO-FR-003` | `BC-22` Notification Delivery is a push channel. A member who was
offline, or who cleared a notification, has **no durable readable record**. This
is A2 `LCF-FR-002`, restated with its owner named rather than re-derived.

`LCO-FR-004` | Nothing in the repository distinguishes an urgent institutional
notice from an ordinary member post in ordering terms. A3 reserved the vocabulary
(`PRIO-URGENT`, `PRIO-IMPORTANT`, `PRIO-NORMAL`, `PRIO-INFO` — A3 **L732**) and
`LCR-BR-011` reserved the expiry rule, but A3 `LCR-FR-045` forbids A3 from
supplying the substrate.

### 2.2 Vision

`LCO-FR-005` | A5 **SHALL** serve exactly one relationship: *a library speaking
to the members of its own community, as the institution, on the record.*

Everything outside that sentence belongs to someone else (§3).

### 2.3 Goals

| ID | Goal |
|---|---|
`LCO-FR-006` | An **institutional author** attribution that is server-derived and never client-asserted |
`LCO-FR-007` | Official communication stored in **A2's existing `CommunityPost`** wherever the repository permits, adding no second content aggregate |
`LCO-FR-008` | Announcement categories that are **useful to a study library** and deliberately narrow (§6) |
`LCO-FR-009` | Authorisation drawn **entirely** from the existing `TR-1`/`TR-2`/`TR-3` role model, minting no role and no permission |
`LCO-FR-010` | A bounded priority mechanism that **cannot** permanently dominate a feed |
`LCO-FR-011` | Ordering **delegated entirely** to A3, supplying a field and never a weight |
`LCO-FR-012` | Notification **integration** with `BC-22`, defining no channel, template or quiet-hour policy |
`LCO-FR-013` | Audit **integration** with `BC-24`, defining no retention period |
`LCO-FR-014` | Cross-library isolation at least as strong as A2 `LCF-SEC-001`…`006`, never weaker |
`LCO-FR-015` | Zero silent amendment to any FROZEN or `ACCEPTED` artefact, with every amendment this part *does* require named as an explicit requirement in §29 |

### 2.4 Non-goals

`LCO-XC-001` | Any second content aggregate parallel to `CommunityPost` |
**A2** — `LCF-FR-016`, A2 **L510**. §19 reuses, never duplicates

`LCO-XC-002` | Feed retrieval, pagination, feed composition | **A2** §13, §14

`LCO-XC-003` | Ranking, signals, weights, renormalisation | **A3** —
`LCR-FR-013`; A2 `LCF-XC-021`

`LCO-XC-004` | Groups, group membership, `CommunityRole` values | **A4** v0.1 —
`LCG-XC-*`, BC Map **L119**, **L212**

`LCO-XC-005` | The derived community participant set and the derived access
predicate | **A1** — A1 §1, §2.1. A5 **consumes** A1's predicate and defines
none

`LCO-XC-006` | Library membership validity, plans, terms, renewals, grace
windows | **`BC-02`** — BC Map **L371**; `PRD-005` **FROZEN**

`LCO-XC-007` | The `TenantOrganisation` entity, its lifecycle, its business
data | **`BC-19`** — BC Map **L128**; `Library_PRD_v1.md` §5; `PRD-013`
**FROZEN**

`LCO-XC-008` | `Branch`, `OperatingHours`, `Holiday`, `BusinessPolicy` — the
operating rules an announcement may *describe* | **`BC-06`** —
`Library_PRD_v1.md` §5. ⭐ A5 posts **text about** a holiday; it never becomes
the holiday record

`LCO-XC-009` | `LibraryBranding` — logo, cover image, branding values |
**`BC-25`** values + **`BC-29`** binaries — `Library_PRD_v1.md` §5 (*"Split"*)

`LCO-XC-010` | The public library profile surface and its field list |
**`14A-Library-Discovery-And-Enrollment.md` §14A.5 (FROZEN)** + `14B`. A2
`LCF-SEC-005` keeps it *"entirely separate"* from community content

`LCO-XC-011` | Global person identity, username, profile photo, privacy mode |
**`BC-10`** — BC Map **L376**

`LCO-XC-012` | Moderation, enforcement, strikes, bans, appeals | **`BC-13`** —
BC Map **L379**, **L318** (`E-14`), **L433**. ⛔ **NOT "A6"** — see §3.3
conflict C-2

`LCO-XC-013` | Notification channel selection, templates, dedup, quiet hours,
consent, unsubscribe | **`BC-22`** — BC Map **L131**, reached by `E-23`.
⛔ **NOT "A7"** — see §3.3 conflict C-2

`LCO-XC-014` | Bytes, storage, virus scan, thumbnails, signed URLs |
**`BC-29`** via **`BC-14`** — `PRD-017` **FROZEN**; A2 `LCF-XC-020`

`LCO-XC-015` | Platform permissions, `AccessRole`, permission bundles |
**`BC-18`** — BC Map **L212**. ⛔ Catalogue **closed**: `AUTH-7.22`;
`ADR-0036` §7.1 records **zero** `PERM-*`

`LCO-XC-016` | Configuration values, bounds, defaults, feature flags |
**`BC-25`** — `E-19`; `PRD-023` **FROZEN**. This part declares **shapes**;
`BC-25` resolves **values**

`LCO-XC-017` | Audit storage, `AuditEntry`, retention | **`BC-24`** —
`E-20`; `PRD-016` **FROZEN**

`LCO-XC-018` | Analytics metric definitions, projections, reports, exports |
**`BC-26`** — BC Map **L135**. Community Analytics is **V3** — EA **L973**

`LCO-XC-019` | Rate-limit policy authorship and threshold values | **`BC-11`**
holds `RateLimitCounter` (BC Map **L377**); `TSF-CFG-009` bounds request limits

`LCO-XC-020` | Search index construction, relevance, query rewriting |
**`BC-23`** — BC Map **L132**

`LCO-XC-021` | Any new bounded context | Count stays **31 (23 in V1)** — BC Map
**L149**

`LCO-XC-022` | Any new event transport | The `PL` mechanism of BC Map §10 only
— A2 `LCF-XC-022`

`LCO-XC-023` | An `OfficialPerson`, `LibraryAccount`, `LibraryUser` or any
identity-bearing entity representing a library-as-actor | ⛔ **REFUSED.** `BC-18`
owns accounts; `BC-10` owns person identity; `BC-19` owns the organisation.
A library is **not a person** and A5 creates no third identity kind (§4)

`LCO-XC-024` | Complex approval workflows, multi-step sign-off, editorial queues
| ⏸ **OUT OF V1** by explicit scope instruction. No substrate exists — `BC-28`
Workflow Orchestration is **V2** (BC Map **L137**)

`LCO-XC-025` | Advanced targeting, segments, campaigns, CRM, A/B testing,
AI-generated content | ⏸ **OUT OF V1.** `BC-27` AI Assistance owns prompts and
guardrails (BC Map **L136**); A5 requests nothing from it

`LCO-XC-026` | Cross-library broadcasting — one library publishing into another
library's community | ⛔ **REFUSED, not deferred.** This would breach A2
`LCF-SEC-001` (*"readable only within the community that owns it"*) and BC Map
`ID-3`. It is not a V2 candidate; it is prohibited

`LCO-XC-027` | Any scope belonging to A6, A7 or A8 | ⛔ Those parts **do not
exist**. This part takes no custody of their concerns (`LCO-INV-005`)

---

## 3. Ownership boundaries

### 3.1 What A5 owns — conditional on §0.3

| # | Owned item | Basis |
|---|---|---|
| 1 | **Official communication** as a capability — the act of a library publishing on the record to its own community | The gap A2 `LCF-FR-002` names and does not fill |
| 2 | **Official announcement metadata** — category, and the official/non-official discriminator | A3 `LCR-RS-005` reserves the concept; A3 `LCR-FR-045` forbids A3 from creating it |
| 3 | **Official Library identity representation** — the *display contract* for institutional attribution, and its resolution rules (§4). ⛔ Not the underlying data, which is `BC-19`/`BC-25`-owned | `LCO-XC-007`, `LCO-XC-009` route the data |
| 4 | **Official publishing authorization** — the predicate *"may this caller publish as the library"*, composed from existing roles (§7) | `LIB-4.1` forbids new role names; A5 composes, never mints |
| 5 | **Priority and pin state** — the field, its closed value set, and its expiry rule | A3 **L732** reserves the level names; A3 `LCR-BR-011` reserves the expiry rule |
| 6 | **Official post lifecycle metadata** — the states an *official* post adds beyond A2's closed set (§8) | A2 `LCF-FR-027`/§11.1 close the *post* state set; §8 discloses the collision |
| 7 | **Publishing audit requirements** — *what* must be audited about official publication. ⛔ Not the audit store | `BC-24` owns storage (`LCO-XC-017`) |

### 3.2 Ownership register — no cell is reassigned

| Concern | Owner (unchanged) | A5's relation |
|---|---|---|
| Community, participation, access predicate | **A1** | Consumes |
| `CommunityPost`, feed, content, comments, reactions | **A2** | Extends by field, never by aggregate |
| Ranking, ordering, weights | **A3** | Supplies a field; asks for no weight |
| Groups, group membership, community roles | **A4** v0.1 | Disjoint |
| Enrollment, `StudentRecord` | `BC-01` | No reference — `ID-2` |
| Membership validity | `BC-02` | Consumes via A1 only |
| `Branch`, hours, holidays, policy | `BC-06` | Describes in text; never records |
| Person identity, username, photo | `BC-10` | Consumes for the *actor*, never the *author* |
| Social graph, blocks | `BC-11` | Consumes via A2's already-blocked path |
| Enforcement | `BC-13` | Consumes `E-14` |
| Attachments | `BC-14` → `BC-29` | Blocked, inherited |
| Roles, permissions, policy decisions | `BC-18` | Consumes; mints nothing |
| `TenantOrganisation` | `BC-19` | Consumes — **blocked, no edge** (§4) |
| Notification delivery | `BC-22` | Emits facts via `E-23` |
| Audit | `BC-24` | Emits via `E-20` |
| Configuration | `BC-25` | Declares shapes only |
| Analytics | `BC-26` | Emits; defines no metric |
| File storage | `BC-29` | No direct relation |

### 3.3 ⚠ Five conflicts between the scope request and the repository

Per instruction, these are **reported, not silently resolved**. Each carries the
measurement that falsified it and the smallest compatible resolution.

---

**C-1 — `BC-10` is not the Library Public Profile.**

*Requested:* inspect *"BC-10, Library Public Profile"* as though `BC-10` were the
library's public profile context.

*Measured:* BC Map **L114** — `BC-10` is **Global Person Identity**, `[CORE]`,
rank 7.5, owning *"`PersonId`, username, global profile, profile photo,
privacy"*, explicitly *"Organisation-neutral — holds no `tenantId`"*. It is a
**person**, not a library. Further: `grep -rn "Library Public Profile"` returns
**0** hits — **no such bounded context exists**.

*Smallest compatible resolution:* the public library profile is a **surface**,
not a context. Its field list is defined by `14A-Library-Discovery-And-Enrollment.md`
§14A.5 (**FROZEN**) and consumed by `14B-Public-Library-Preview.md` (**L37**:
*"Consumes; adds nothing"*). The underlying data is `BC-19` + `BC-06` + `BC-25`.
§5 integrates with that surface under that reading. **`BC-10` is used only for
the human actor** (§7).

---

**C-2 — "A6 → safety/moderation" and "A7 → notifications" do not exist.**

*Requested:* preserve ownership held by *"A6"* and *"A7"*.

*Measured:* `ls docs/30-product/social-graph/` — A6, A7 and A8 are **absent**.
`PRD-021A_A4_NON_EXISTENCE_FINDING.md` **L43** records *"A5, A6, A7, A8 →
none"*. A3 v0.6 **L413** records correction `P0-5`, whose finding is exactly this
class of error: *"The reviewed draft assigned ownership to 'A4 … A8' … those
parts do not exist. Worse, two of the concerns assigned to them are already owned
by V1 bounded contexts."*

*Smallest compatible resolution:* route to the **existing owners**. Safety and
moderation → **`BC-13` Trust & Safety** (`[CORE]`, V1, BC Map **L117**),
specified by `PRD-020_TRUST_AND_SAFETY.md`. Notifications → **`BC-22`
Notification Delivery** (`[GENERIC]`, V1, BC Map **L131**). §14 and §16 are
written against `BC-13` and `BC-22`. `LCO-XC-012` and `LCO-XC-013` carry the
correction.

---

**C-3 — There is no library role named "Staff".**

*Requested:* *"Owner/Manager/Staff authorization"*.

*Measured:* `Library_PRD_v1.md` **L151–154** binds exactly three library roles:
**`TR-1` Owner**, **`TR-2` Manager**, **`TR-3` Reception**. **L156** —
`LIB-4.1`: *"This module **MUST** use the role names `TR-1` Owner, `TR-2`
Manager, `TR-3` Reception and Platform Administrator. It **MUST NOT** introduce
a role name of its own."* `LIB-5.1` (**L193**) adds that *"`Staff` **MUST NOT**
be modelled as an independent identity."* The shipped enum
(`lib/platform/identity/identity.dart` **L14**) is
`{owner, manager, reception, student, parent}` — **no `staff` member**.

*Smallest compatible resolution:* read *"Staff"* as **`TR-3` Reception**. §7 uses
`TR-1`/`TR-2`/`TR-3` exclusively and mints no role name. Whether `TR-3` may
publish at all is **not decided here** — `LCO-DEC-004`.

---

**C-4 — ⭐ PUBLIC visibility is not permitted by existing frozen authority.**

*Requested:* *"PUBLIC vs COMMUNITY_ONLY visibility"*.

*Measured — three independent prohibitions:*

1. A2 `LCF-SEC-004`: *"There **SHALL** be no unauthenticated read path to any
   community post."*
2. A2 `LCF-SEC-005`: *"The public library profile surface (`PRD` 14A/14B)
   **SHALL** remain entirely separate from the private community surface. **No
   field defined in this part SHALL appear on a public profile.**"*
3. `14A` §14A.5 (**FROZEN**) publishes a **closed** list of 15 publicly
   accessible fields — Library Name, Logo, Cover Image, Gallery, Description,
   Business Address, Map Location, Operating Hours, Weekly Holidays, Facilities,
   Membership Plans & Pricing, Seat Capacity, Library Status, Business Contact —
   followed by a *"shall never be publicly accessible"* list. **No announcement,
   post, feed or communication surface appears in the public list.** `14B`
   **L81**: a consumer *"**MUST NOT** display any field outside it."*

*Assessment:* `PUBLIC` official posts are **not merely unspecified — they are
affirmatively excluded** by a FROZEN Rank 3 document and by A2's security
register.

*Smallest compatible resolution:* **V1 ships `COMMUNITY_ONLY` only.** The
`visibility` field is specified with a **two-value set whose second value is
BLOCKED and unimplementable** until *either* `14A` §14A.5's closed list is
amended by its owner, *or* an ADR admits an announcement surface to the public
profile. Neither act is performed here. See §11 — `LCO-GAP-005`,
`LCO-DEC-005`, `LCO-ADR-002`.

⭐ This part does **not** relabel the problem away by dropping the field. The
field is specified, and its second value is marked BLOCKED with an owner, so a
later reader sees the requirement and its obstruction together.

---

**C-5 — `BC-15` cannot currently read the library's identity.**

*Requested core invariant:* official communication must appear as
`🏛️ Sonvarsha Library ✓ / Official Library`.

*Measured:*

| Probe | Result |
|---|---|
| `BC-15` rows in BC Map §7 edge table | **exactly 1** — `E-14`, **inbound** from `BC-13` |
| `BC-15 → BC-19` edge | **absent** |
| `BC-15 → BC-06` edge | **absent** |
| `BC-15 → BC-25` edge | **absent** |
| BC Map **L292** | *"If an edge is not in this table, it does not exist and adding it requires an ADR."* |
| BC Map `ID-3` (**L180**) | Global and social contexts *"must not be able to resolve which library a person attends unless the person explicitly published it"* |
| `ACCEPTED` `ADR-0078` §2.1 | *"The community scope identifier carries **NO** `tenantId`."* |

*Assessment:* the display name, logo and verification mark all live in
`BC-19`/`BC-25`/`BC-29`. `BC-15` has **no authorised path** to any of them. The
core invariant is therefore **architecturally BLOCKED**, not merely
unimplemented.

*Smallest compatible resolution:* §4 specifies the display **contract** and the
`officialAuthority` discriminator — both of which `BC-15` can hold — and marks
**resolution of the display values** as BLOCKED pending an Architecture Owner
decision on the smallest sufficient read path. §4.4 states the requirement in
fail-closed form: **until that decision, official posts SHALL NOT be publishable**,
on the exact precedent of A2 `LCF-FR-043` and A2 §12.1's self-blocking clause.

⛔ **A5 does not propose the edge's shape.** Choosing between an ACL, a
projection, a `BC-25` typed accessor and a denormalised snapshot is an
Architecture Owner act. §29 `LCO-ADR-001` routes it with the options enumerated
and **none selected**.

---

## 4. Official Library identity

### 4.1 The three identity objects — kept distinct

BC Map **L199** and **L208** already warn that identity terms collide in this
domain. A fourth collision is possible here and is pre-empted:

| Object | Owner | Nature | A5's use |
|---|---|---|---|
| `GlobalPersonIdentity` | `BC-10` | The **person** | The human **actor** who performed the publish (§7, §17) |
| `TenantOrganisation` | `BC-19` | The **institution** | The **author** an official post is attributed to |
| `LibraryBranding` | `BC-25` + `BC-29` | Display **values** | Logo and display name — **unreachable**, §4.4 |
| `OfficialAuthority` | **A5** | A **discriminator**, not an identity | The field that says *"this post speaks for the institution"* |

`LCO-INV-006` | `OfficialAuthority` SHALL be a **discriminator and an
attribution reference**. It SHALL NOT be an account, a credential, a person, a
profile or a login. `LCO-XC-023` refuses all four.

`LCO-INV-007` | An official post's **author** SHALL be the institution. Its
**actor** SHALL be the natural person who performed the act. These SHALL be
recorded separately and SHALL NOT be conflated.

`LCO-INV-008` | ⭐ **The core invariant.** An official post SHALL be displayed
with the **institution's** display identity. The actor's personal display name,
username, or profile photo SHALL NOT appear as the post's author on any surface,
in any payload, or in any export.

`LCO-INV-009` | Conversely, a **non-official** post SHALL NOT be displayed with
institutional identity, regardless of the author's role. A `TR-1` Owner posting
a personal study question posts **as a person**.

`LCO-INV-010` | The official/non-official determination SHALL be made
**server-side from the stored discriminator**, never from a client assertion, a
role check performed at render time, or a display-layer heuristic.

### 4.2 The display contract

`LCO-FR-016` | An official post's rendered attribution SHALL comprise exactly
three elements: an **institutional mark**, the **institution's display name**,
and an **official designation label**.

`LCO-FR-017` | The institutional mark and the official designation label SHALL be
rendered from the **stored discriminator**, not from resolved branding. They are
therefore available even when §4.4's block is in force.

`LCO-FR-018` | The **institution's display name** SHALL be resolved from its
owning context. ⛔ **BLOCKED** — §4.4.

`LCO-FR-019` | A verification indication, if displayed, SHALL be derived from the
library's existing verification state. ⛔ **BLOCKED on two counts** — the read
path (§4.4), and the fact that no library-level verification *field* is measured:
`LIB-DISC-002` speaks of *"successful verification and activation"* as a
**discoverability precondition**, and `VerificationState` (BC Map **L376**) is a
`BC-10` **person** attribute, not a library one. → `LCO-GAP-004`.

`LCO-FR-020` | The exact glyph, wording, colour and typography of the three
elements SHALL NOT be specified by this part. Branding values are `BC-25`-owned
(`LCO-XC-009`) and copy is a design act. This part specifies **which three
elements exist and what each is derived from**, and no more.

⭐ **Why the illustration in the scope request is not reproduced as a
specification.** The requested form `🏛️ Sonvarsha Library ✓ / Official Library`
contains a specific glyph, a specific tenant's name and a specific check mark.
Writing it as a requirement would (a) mint branding values `BC-25` owns, and
(b) embed one tenant's name in a platform specification. `LCO-FR-016`…`020`
capture its **structure**; the values stay with their owners.

### 4.3 Attribution integrity

`LCO-SEC-001` | The institution an official post is attributed to SHALL be
derived **server-side** from the community's own scope. A client-supplied
library, tenant, organisation or community identifier SHALL NOT be trusted for
attribution.

`LCO-SEC-002` | A caller SHALL NOT be able to publish an official post
attributed to any institution other than the one whose community they hold
publishing authority in.

`LCO-SEC-003` | The official discriminator SHALL NOT be settable, clearable or
alterable by any client-supplied field on any endpoint. It SHALL be a
**server-side consequence** of the authorisation decision in §7.

`LCO-SEC-004` | An ordinary member SHALL NOT be able to cause a post to be
displayed as official by any route — field injection, type coercion, replay of a
privileged request, or editing a post that was official.

### 4.4 ⛔ BLOCKED — the identity read path

`LCO-FR-021` | Resolution of the institution's display name and branding
requires `BC-15` to read a context it has **no edge to** (§3.3 conflict C-5).
BC Map **L292** governs.

`LCO-FR-022` | ⛔ **Self-blocking clause.** **Until an `ACCEPTED` ADR
establishes an authorised read path, official post publication SHALL be treated
as blocked rather than served with a fabricated, client-supplied or
actor-derived institutional identity.**

⭐ The fail-closed direction is deliberate and is **not** a product choice.
Serving an official post whose institutional identity could not be authoritatively
resolved would invite exactly the misattribution `LCO-INV-008` exists to
prevent — and would risk falling back to the actor's personal identity, which is
the specific outcome the core invariant forbids. This mirrors A2 `LCF-FR-043`
(*"treated as blocked"*) and A2 §12.1's self-blocking clause verbatim in form.

`LCO-FR-023` | This part SHALL NOT select the read mechanism. Four shapes are
conceivable — an ACL on the `ADR-0011` `E-13` precedent; a published read
projection on the `ADR-0032`/`E-27` precedent; a `BC-25` typed accessor over the
existing `E-19` *"All contexts"* edge; or a denormalised snapshot written at
publish time. **None is selected.** → `LCO-ADR-001`, Architecture Owner.

`LCO-FR-024` | ⚠ **Disclosure.** The `E-19` option deserves particular scrutiny
by the Architecture Owner because `E-19` already lists *"All contexts"* as its
source (BC Map **L328**), so it may require **no new edge at all** — but
`LibraryBranding` is *"Split"* between `BC-25` values and `BC-29` binaries
(`Library_PRD_v1.md` §5), and `E-19`'s contract is *"typed config accessors"*,
which may not extend to an organisation's display name. **This part does not
rule on it.** Naming the possibility is not selecting it.

---

## 5. Public Library Profile integration

`LCO-FR-025` | A5 SHALL NOT add, remove or alter any field on the public library
profile. The field list is closed by `14A` §14A.5 (**FROZEN**) and `14B`
**L81** forbids displaying anything outside it.

`LCO-FR-026` | A5 SHALL NOT surface any official post, announcement, count,
excerpt, timestamp or existence signal on the public profile. A2 `LCF-SEC-005`
requires the two surfaces to remain *"entirely separate"*.

`LCO-FR-027` | The relationship is therefore **one-directional and read-only**:
official posts may *describe* facts the public profile also publishes — operating
hours, holidays, facilities — but SHALL NOT be the source of record for any of
them. `BC-06` and `BC-19` remain the sources (`LCO-XC-008`).

`LCO-FR-028` | An official post SHALL NOT mutate `OperatingHours`, `Holiday`,
`BusinessPolicy`, `Branch` or `TenantOrganisation` state, directly or by
inference. Announcing a holiday and recording a holiday are **different acts with
different owners**.

`LCO-INV-011` | ⚠ **A known and deliberate consequence:** a library may publish
an official post announcing a holiday without the `BC-06` `Holiday` record
existing, producing an inconsistency between the announcement and the operating
calendar. A5 **does not** resolve this by writing to `BC-06` — that would breach
`LCO-XC-008`. The inconsistency is **disclosed** and routed as a product question
→ `LCO-GAP-006`.

---

## 6. Official post types

### 6.1 ⛔ The type-set collision, stated before the types

A2 `LCF-FR-027` (**L717**): *"The post type set SHALL be exactly `TEXT`, `NOTE`,
`MEDIA`, `LINK`. **No fifth type SHALL be added without a PRD amendment.**"*
`LCF-FR-028`: *"A post's type SHALL be immutable after creation."*

`LCO-FR-029` | ⛔ An official post is **not** a fifth post type, and this part
SHALL NOT propose one. Instead, official status is carried by an **orthogonal
discriminator** on the existing four types, so A2's closed set is **not
extended**.

⭐ **Why orthogonal rather than a fifth type.** Three measurements drove this:
(a) `LCF-FR-027` closes the set and names PRD amendment as the only route;
(b) `LCF-FR-028` makes type immutable, which would make "official" immutable
too — but §9 needs official status to be *revocable* if authority is withdrawn;
(c) A3 `LCR-DEC-006` asks whether an announcement surface *"extends A2's closed
type set"*, which is a Product Owner question, **not one a new part may answer
for itself**. An orthogonal field answers *"no"* — the least invasive of the
available answers — while leaving the Product Owner free to answer *"yes"*.

`LCO-FR-030` | ⛔ **Disclosure, not a claim of costlessness.** Adding a field to
`CommunityPost` is still an **amendment to A2's §22 data model**, which A5 cannot
make. It is a *smaller* amendment than a fifth type, not a free one. →
`LCO-ADR-003`, owner **Product Owner + A2 author**.

### 6.2 Announcement categories

`LCO-FR-031` | Official posts SHALL carry an **announcement category** drawn from
a closed set. The category is metadata for the reader and for `BC-22`; it is
**not** a post type and SHALL NOT be conflated with one.

The category set, derived from the V1 scope instruction and **from nothing else**:

| Category | Meaning | Derived from |
|---|---|---|
| `GENERAL` | General announcement, no special handling | V1 scope: *"General announcements"* |
| `TIMING` | Operating-hours or holiday change | V1 scope: *"timing/holiday updates"*; describes `BC-06` facts (`LCO-XC-008`) |
| `RULES` | Library rules and conduct | V1 scope: *"rules"* |
| `FACILITY` | Facility availability or outage | V1 scope: *"facility updates"* |
| `EVENT` | An event at the library | V1 scope: *"events"* |
| `EMERGENCY` | Urgent safety or closure instruction | V1 scope: *"emergency notices"* |

`LCO-FR-032` | The category set SHALL be exactly these six. A seventh SHALL
require a PRD amendment, on the discipline `LCF-FR-027` establishes.

`LCO-FR-033` | The category SHALL be mutable by an authorised editor while a
post is editable (§9), because a category is a classification and not an
identity. This differs deliberately from A2's immutable `type`.

`LCO-FR-034` | ⛔ A category SHALL NOT by itself determine priority, notification
urgency, channel, or ordering. Any such mapping is **configuration**
(`LCO-XC-016`) and this part states **no** default mapping — not even for
`EMERGENCY`. → `LCO-GAP-007`.

⭐ **Why `EMERGENCY` gets no automatic escalation here.** It is the obvious
temptation and it is refused for a measured reason: an escalation is a
*value* — a channel, a quiet-hours override, a priority level — and every one of
those is owned by `BC-22` or `BC-25`. `PRD-023` `CNF-FR-052` and
`LCO-XC-016` place value resolution outside this part. Writing *"`EMERGENCY`
implies `PRIO-URGENT` and overrides quiet hours"* would invent two values and
overrule a `BC-22` policy. The mapping is declared **required and absent**.

`LCO-INV-012` | An `EMERGENCY` category SHALL NOT be treated as an authorisation
bypass. §7's predicate applies identically to all six categories.

---

## 7. Owner / Manager / Reception authorization

### 7.1 The role model — consumed, never extended

`LCO-AUTH-001` | Official publishing authority SHALL be composed **exclusively**
from the existing library roles `TR-1` Owner, `TR-2` Manager and `TR-3`
Reception. This part SHALL NOT introduce a role name — `LIB-4.1` forbids it.

`LCO-AUTH-002` | This part SHALL NOT mint a permission identifier. `AUTH-7.22`
closes the permission catalogue and `ADR-0036` §7.1 records **zero** `PERM-*`
identifiers repo-wide (re-measured at authoring time: **1** `PERM-` hit
repo-wide, and it is the disclosure recording the absence). → `LCO-GAP-008`,
inherited from A2 `LCF-GAP-008`.

`LCO-AUTH-003` | Authorisation SHALL be evaluated **server-side on every
request**. A cached authorisation decision SHALL NOT outlive the request — A2
`LCF-AUTH-010`, restated because the consequence is identical here.

`LCO-AUTH-004` | The caller's role SHALL be resolved from `BC-18` at decision
time. A client-supplied role, role claim, or role hint SHALL NOT be trusted.

`LCO-AUTH-005` | The caller's authority SHALL be scoped to **exactly one**
library. `Library_PRD_v1.md` **L152**–**L154** scopes all three roles to
*"Exactly one library"*.

`LCO-AUTH-006` | A Platform Administrator SHALL NOT acquire official publishing
authority by virtue of that role. `LIB-4.2` states a Platform Administrator
*"**MUST NOT** be granted any permission over tenant business data by virtue of
that role"*, requiring *"explicit, audited, time-bounded elevation"*.

`LCO-AUTH-007` | `TR-4` Student and `TR-5` Parent SHALL hold **no** official
publishing authority. `Library_PRD_v1.md` **L172** records that they *"hold no
permission in this module"*.

`LCO-AUTH-008` | Official publishing authority SHALL additionally require that
the target community be the one belonging to the caller's library. Authority in
library L SHALL NOT publish into library M's community —
`LCO-XC-026`, A2 `LCF-SEC-001`.

`LCO-AUTH-009` | Reading an official post SHALL require exactly the predicate A2
`LCF-AUTH-001` requires for reading the feed it appears in. Official status SHALL
NOT widen readership. ⛔ This is what makes `PUBLIC` visibility a **conflict**
and not a feature — §11.

`LCO-AUTH-010` | Authorisation SHALL be applied in addition to authentication —
`14B` **L231**, via A2 `LCF-AUTH-011`.

`LCO-AUTH-011` | A rate-limit refusal SHALL NOT be substituted for an
authorisation refusal, and authorisation SHALL be evaluated first — A2
`LCF-INV-016`.

### 7.2 ⛔ Which roles may publish — NOT DECIDED

`LCO-FR-035` | ⛔ **Whether `TR-2` Manager and `TR-3` Reception may publish
official communication, and whether their authority differs from `TR-1` Owner's,
is a Product Owner decision and is NOT taken here.** → `LCO-DEC-004`.

*Why it cannot be derived.* Six probes were run:

| Probe | Result |
|---|---|
| A Rank 1–5 document assigning announcement authority to a role | **none** |
| `Library_PRD_v1.md` §15 *Staff Management* function list | Grants staff functions; **no publishing function** |
| `Library_PRD_v1.md` §15.1 *"only the Owner may perform critical operations"* | Discusses **critical operations**; does not classify announcements |
| `LIB-14.3` (visibility change is `TR-1`-only) | A **precedent** for Owner-only acts — but about *visibility*, not publication |
| `LIB-15.4` | Constrains which roles *may be assigned*, not what they may do here |
| A `PERM-*` identifier for publication | **0** — catalogue closed |

⇒ The repository establishes *that* the three roles exist and *that* some acts
are Owner-only. It does **not** determine this act. Publishing a role assignment
here would be inventing an owner decision — prohibited.

`LCO-FR-036` | ⛔ **Fail-closed default pending `LCO-DEC-004`.** Until the
decision is taken, official publishing authority SHALL be treated as held by
**`TR-1` Owner only**, because `LIB-14.3` is the nearest measured precedent for a
consequential library-wide act and it is Owner-only. ⚠ **This is an explicitly
labelled provisional narrowing to the smallest defensible set, not a decision.**
Widening it is `LCO-DEC-004`'s business, and this clause SHALL be deleted, not
amended, when that decision lands.

### 7.3 Stale-role and revocation safety

`LCO-SEC-005` | Loss of a library role SHALL take effect on the **next**
authorisation decision. A caller whose role was revoked SHALL NOT publish,
edit, delete, pin or unpin an official post thereafter.

`LCO-SEC-006` | An in-flight request SHALL NOT complete on the strength of a
role held when the request began. `LCO-AUTH-003` is the mechanism.

`LCO-SEC-007` | Already-published official posts SHALL NOT be retroactively
de-officialised by the publishing actor's later role loss. The post was published
by the **institution**, not by the person (`LCO-INV-007`). §18 governs.

`LCO-SEC-008` | A session, token or device that predates a role grant SHALL NOT
carry official publishing authority forward from a cached claim. Sessions are
`BC-18`-owned; A5 states the requirement and defines no session mechanic.

---

## 8. Lifecycle — Draft → Published → Expired/Archived → Deleted

### 8.1 ⛔ The state-set collision, stated first

A2 §11.1 closes `CommunityPost`'s state set at **`DRAFT`, `PUBLISHED`,
`DELETED`, `REMOVED`** (A2 §22). The requested lifecycle adds
`EXPIRED`/`ARCHIVED`.

`LCO-FR-037` | ⛔ A5 SHALL NOT extend A2's closed post-state set. Adding
`EXPIRED` or `ARCHIVED` to `CommunityPost.state` is an **A2 amendment** A5 cannot
make. → `LCO-ADR-003`.

`LCO-FR-038` | Instead, expiry SHALL be expressed as **official metadata
alongside** A2's state, not as a value inside it. A post whose official priority
has expired remains `PUBLISHED` in A2's terms; only its **official priority
effect** ends (§10).

⭐ **Why this is the smallest compatible resolution.** It preserves `LCF-FR-104`
(the event set stays closed), preserves A2 §11.1 byte-for-byte, and matches what
A3 `LCR-BR-011` already reserved: *"every priority level SHALL carry an expiry.
On expiry the post SHALL return to ordinary ordering."* A3 reserved **expiry of
the priority**, not expiry of the post. This part follows A3's reservation
exactly rather than inventing a wider notion.

### 8.2 The official lifecycle

| Phase | A2 `state` | Official metadata | Effect |
|---|---|---|---|
| Draft | `DRAFT` | official discriminator set; not yet visible | Not readable by members; not notified; not ranked |
| Published | `PUBLISHED` | official; priority active if set | Readable, notified, priority-ordered |
| Priority expired | `PUBLISHED` | official; priority lapsed | Readable; **ordinary ordering** (A3 `LCR-BR-011`) |
| Archived | `PUBLISHED` | official; archived flag | Readable only via explicit retrieval, not in the default feed |
| Deleted | `DELETED` | official; deletion recorded | Not readable; audit retained (§17) |
| Removed | `REMOVED` | official; enforcement applied | `BC-13` act — §16 |

`LCO-FR-039` | A `DRAFT` official post SHALL NOT be readable by any member, SHALL
NOT emit a notification fact, and SHALL NOT be supplied to A3.

`LCO-FR-040` | Transition `DRAFT` → `PUBLISHED` SHALL be the **only** point at
which notification facts are emitted for the post (§14).

`LCO-FR-041` | Priority expiry SHALL be **automatic and time-based**, requiring
no actor. Its effect SHALL be confined to ordering (§10).

`LCO-FR-042` | Archiving SHALL remove a post from default feed retrieval without
deleting it. ⛔ Whether archiving is manual, automatic, or both is **not decided
here** → `LCO-GAP-009`.

`LCO-FR-043` | ⛔ No retention period, expiry default, or archival window is
stated. All three are `BC-25` configuration (`LCO-XC-016`) and `BC-24` retention
(`LCO-XC-017`). This part mints **no** `LCO-CFG-*` and states **no** default.

`LCO-INV-013` | An official post SHALL NOT re-enter `DRAFT` after `PUBLISHED`.
Unpublishing by reversion would make the audit trail ambiguous about whether
members saw it.

`LCO-INV-014` | Deletion SHALL be terminal. A `DELETED` official post SHALL NOT
be restored — A2 §11.1's closed set contains no restoration path.

---

## 9. Edit and delete

`LCO-FR-044` | An authorised editor SHALL be able to edit an official post's
body and category while it is `DRAFT` or `PUBLISHED`.

`LCO-FR-045` | An edit SHALL be marked as such. A2 `LCF-BR-011` already drives an
edit marker from `editedAt`; A5 **reuses** it and defines no second marker.

`LCO-FR-046` | ⛔ Editing authority SHALL NOT be author-identity-based. A2
`LCF-AUTH-004` requires the caller to *be the author* — but an official post's
author is the **institution**, which cannot be a caller. Official edit authority
is therefore **role-based** (§7), not authorship-based.

⭐ **This is a genuine divergence from A2 and is disclosed as one.** It is not a
contradiction: `LCF-AUTH-004` governs posts whose author is a person, and the
whole point of A5 is that an official post's author is not a person. But it is a
**second edit-authority rule in the same aggregate**, which the A2 author must
accept. → `LCO-ADR-003`, `LCO-RSK-004`.

`LCO-FR-047` | An edit SHALL NOT change a post's official discriminator, its
attributed institution, or its community. `LCO-SEC-003`, `LCO-SEC-004`.

`LCO-FR-048` | An edit SHALL NOT change A2's immutable `type` — `LCF-FR-028`.

`LCO-FR-049` | An edit that materially changes an `EMERGENCY` or `TIMING`
announcement SHALL be capable of re-notification. ⛔ Whether it *does*
re-notify is a `BC-22` dedup and policy question (`LCO-XC-013`) →
`LCO-GAP-010`.

`LCO-FR-050` | An authorised actor SHALL be able to delete an official post.
Deletion SHALL be terminal (`LCO-INV-014`).

`LCO-FR-051` | Deletion SHALL emit the audit facts §17 requires, including the
actor, even though the post's author was the institution.

`LCO-FR-052` | ⛔ Whether deletion is soft or hard at the storage layer is **not
specified here**. A2 §11.1 owns `CommunityPost` state; storage form is an
implementation and `BC-24`/privacy concern.

`LCO-INV-015` | An official post's edit and delete history SHALL be attributable
to a **natural person** in audit, even though the post is displayed as
institutional. Institutional attribution is a **display** rule
(`LCO-INV-008`); accountability is an **audit** rule (§17). Conflating them
would make official communication unaccountable.

---

## 10. Pin and priority

### 10.1 Reusing A3's reserved vocabulary

A3 v0.6 **L732** reserves the level names and **L734** reserves the expiry rule.
A3 `LCR-FR-045` forbids A3 from creating the substrate. A5 supplies it.

`LCO-FR-053` | The priority level set SHALL be exactly **`PRIO-URGENT`**,
**`PRIO-IMPORTANT`**, **`PRIO-NORMAL`**, **`PRIO-INFO`** — the four names A3
**L732** reserved. A5 SHALL NOT rename, extend or reorder them.

⭐ **Why A3's names are adopted verbatim.** A3 corrected these names under `P3-2`
precisely because an earlier draft used `P0`–`P3` and collided with review
severity notation. Re-inventing names here would re-create the defect A3
corrected.

`LCO-FR-054` | ⛔ **No numeric weight, multiplier, boost or score is stated for
any level.** A3 owns weights (`LCO-XC-003`), and A3 `LCR-DEC-009` records that
even a *helpfulness* weight remains **formally REFUSED as undecidable** for want
of an authority. A5 supplies the **field**; A3's owner supplies any weight. →
`LCO-GAP-011`, `LCO-DEC-006`.

`LCO-FR-055` | Every priority assignment SHALL carry an **expiry**. On expiry the
post SHALL return to ordinary ordering — A3 `LCR-BR-011`, adopted as binding here.

`LCO-INV-016` | **Permanent feed domination SHALL NOT be expressible.** A
priority without an expiry SHALL be rejected. This is A3 `LCR-BR-011`'s explicit
requirement and A5 SHALL NOT provide a bypass.

`LCO-FR-056` | ⛔ No default, minimum or maximum expiry duration is stated.
Durations are `BC-25` configuration (`LCO-XC-016`). → `LCO-GAP-007`.

`LCO-FR-057` | Priority SHALL be settable, changeable and clearable by an
authorised actor while the post is `PUBLISHED`, subject to `LCO-INV-016`.

### 10.2 Pin

`LCO-FR-058` | A **pin** SHALL be a bounded-duration placement of an official
post at the head of its community's default feed ordering.

`LCO-FR-059` | Pinning SHALL be expressed **through** the priority mechanism, not
as a second independent mechanism. A pin is the strongest priority with an
expiry; it is not a separate boolean with separate semantics.

⭐ **Why pin is not a separate field.** Two mechanisms that both reorder a feed
would give A3 two inputs with an undefined interaction, and A3's ordering is
**ruled** at Recency 70 / Engagement 30 (`LCR-DEC-008`). One input with a closed
level set is the smaller ask.

`LCO-FR-060` | ⛔ **The maximum number of concurrently pinned posts per community
is NOT specified.** It is configuration (`LCO-XC-016`), and no authority bounds
it. → `LCO-GAP-007`.

`LCO-INV-017` | A pin SHALL NOT suppress, hide or displace non-official content
from the feed. It SHALL affect **order only**. A2 owns feed composition
(`LCO-XC-002`); reducing what a member can see would be a visibility change A5
has no authority to make.

`LCO-FR-061` | Only official posts SHALL be pinnable in V1. Pinning member
content would require an authority model over another member's content, which no
measured document supplies. → out of scope, `LCO-XC-004` routes group-level
moderation to A4/`BC-13`.

---

## 11. Visibility — `PUBLIC` vs `COMMUNITY_ONLY`

### 11.1 ⛔ The conflict, restated normatively

§3.3 conflict **C-4** measured three independent prohibitions on public
community content. This section states the consequence as requirements.

`LCO-FR-062` | An official post SHALL carry a **visibility** value from the
closed set **`COMMUNITY_ONLY`**, **`PUBLIC`**.

`LCO-FR-063` | ✅ **`COMMUNITY_ONLY` SHALL be the only value implementable in
V1**, and SHALL be the default. Its semantics are exactly A2's: readable by
principals satisfying A1's participant predicate, and by no one else
(`LCO-AUTH-009`).

`LCO-FR-064` | ⛔ **`PUBLIC` SHALL be treated as BLOCKED and SHALL NOT be
implemented, offered in any interface, or accepted by any endpoint**, until
**both** of the following exist:

1. an amendment to `14A-Library-Discovery-And-Enrollment.md` §14A.5's closed
   public-field list admitting an announcement surface — an act by that
   **FROZEN** document's owner; **and**
2. an `ACCEPTED` ADR reconciling A2 `LCF-SEC-004` (*"no unauthenticated read
   path to any community post"*) and `LCF-SEC-005` (*"No field defined in this
   part SHALL appear on a public profile"*) with a public official post.

→ `LCO-GAP-005`, `LCO-DEC-005`, `LCO-ADR-002`.

`LCO-FR-065` | ⛔ A5 SHALL NOT implement `PUBLIC` by any indirect route —
mirroring official content onto the public profile, exposing an unauthenticated
official-post endpoint, publishing an official post excerpt in a share preview,
embedding official content in a public-facing search index, or including it in an
open feed. Each would breach `LCF-SEC-004` while leaving the field nominally
unimplemented.

`LCO-FR-066` | ⛔ A5 SHALL NOT resolve this conflict by silently narrowing the
field to one value. The two-value set is **specified**, with the second value
**BLOCKED and owner-routed**, so that a later reader sees both the requirement
and its obstruction. ⚠ Deleting `PUBLIC` from the set would hide a live product
requirement behind an editorial choice — the precise failure mode the
instruction to *"report the conflict"* exists to prevent.

`LCO-SEC-009` | Regardless of any future `PUBLIC` decision, an official post
SHALL NOT expose member identity, member content, comment authorship, reaction
actors, or any element of the member directory. `14A` §14A.5's never-public list
begins with **Student Information** and **Member Directory**.

`LCO-INV-018` | Visibility SHALL be evaluated server-side per request. A
`PUBLIC` value present in stored data — from a future migration, an import, or a
defect — SHALL NOT by itself cause unauthenticated exposure while
`LCO-FR-064`'s conditions are unmet. **Fail closed.**

---

## 12. A2 feed integration

`LCO-FR-067` | An official post SHALL be retrieved through **A2's existing feed
contracts**. A5 SHALL NOT define a second feed, a parallel retrieval path, or a
separate official timeline.

`LCO-FR-068` | A5 SHALL NOT define pagination. A2 §14 owns it, and A2 §14.1
records that the repository lacks a pagination convention.

`LCO-FR-069` | Official posts SHALL be subject to A2's read predicate without
exception — `LCO-AUTH-009`.

`LCO-FR-070` | A5 SHALL NOT introduce a feed filter, sort parameter or query
capability. A2 §15 owns filtering.

`LCO-FR-071` | An official post SHALL be distinguishable in a feed response by
its **discriminator**, so a client can render §4.2's contract without a second
request.

`LCO-FR-072` | ⛔ A5 SHALL NOT require A2 to change any existing contract's
shape beyond carrying the fields §19 defines. That carrying is itself an A2
amendment → `LCO-ADR-003`.

`LCO-INV-019` | Official posts SHALL NOT be exempt from any A2 invariant. In
particular `LCF-INV-005` (a `TEXT` post holds zero attachments; a non-`TEXT`
post holds at least one) applies unchanged.

---

## 13. A3 ranking integration

`LCO-FR-073` | A5 SHALL supply the **priority field** to A3 as a ranking input
and SHALL NOT compute, apply or influence any ordering itself.

`LCO-FR-074` | ⛔ A5 SHALL NOT state a weight, boost, cap or renormalisation.
A3 `LCR-FR-035` owns renormalisation to exactly 100, and `LCR-DEC-008` ruled
Recency 70 / Engagement 30. **Introducing a third signal requires
renormalisation, which is A3's act and the Product Owner's value.** →
`LCO-DEC-006`.

⭐ **The renormalisation consequence is disclosed rather than assumed away.**
A3's active weights already total exactly 100. Any priority weight must come from
somewhere. A3 `LCR-DEC-009` records that the Product Owner *did* rule 70/30 and
that A3 **SHALL NOT** carve a further weight out of that split. So this part
cannot supply the number, and cannot pretend the number is free.

`LCO-FR-075` | Priority's ranking effect SHALL cease at expiry, returning the
post to ordinary ordering — A3 `LCR-BR-011`, `LCO-FR-055`.

`LCO-FR-076` | A5 SHALL NOT read A3's ranking state, algorithm version, or
computed scores.

`LCO-FR-077` | ⛔ Until `LCO-DEC-006` assigns a weight, priority SHALL have **no
ranking effect**, and official posts SHALL be ordered exactly as A2's default
ordering orders them. ⚠ **This means pin and priority are specified but inert.**
Stated plainly rather than implied.

`LCO-INV-020` | Priority SHALL NOT override authorisation, visibility, block
enforcement or community isolation. A3 `LCR-BR-012` states the equivalent for
social relevance; the same limit binds here.

---

## 14. `BC-22` notification integration

`LCO-FR-078` | On transition to `PUBLISHED`, an official post SHALL emit a
**fact** for `BC-22` to consume. BC Map **L332** (`E-23`): *"Domain emits facts
… never 'send an SMS'."*

`LCO-FR-079` | ⭐ `E-23`'s source cell is **"All contexts"** (BC Map **L332**).
`BC-15` is therefore **already** an authorised emitter and **no new edge is
required**. This is one of the few integrations in this part that is *not*
blocked.

`LCO-FR-080` | A5 SHALL NOT select a channel, compose a template, set a
priority, override quiet hours, define dedup, or manage consent and
unsubscribe. All are `BC-22`-owned — `LCO-XC-013`.

`LCO-FR-081` | The notification fact SHALL NOT carry the post body. A2
`LCF-FR-105` forbids event payloads carrying a post body, and A2
`LCF-INV-013` requires realtime signals to be content-free at delivery.

`LCO-FR-082` | The fact SHALL carry the **category**, so `BC-22` can apply its
own policy without reading post content.

`LCO-FR-083` | ⛔ No quiet-hours exception is requested for any category,
including `EMERGENCY`. Quiet hours are `BC-22` policy. A5 emits the category and
**asks for nothing**. → `LCO-GAP-007`.

`LCO-FR-084` | Editing a published official post SHALL NOT automatically
re-notify. Whether a material edit re-notifies is `BC-22` dedup policy —
`LCO-FR-049`, `LCO-GAP-010`.

`LCO-FR-085` | Notification emission SHALL be idempotent keyed on `eventId` — BC
Map **L447**, A2 `LCF-FR-106`.

`LCO-FR-086` | ⛔ A5 SHALL NOT create a notification system, a delivery
guarantee, a retry policy, or an in-app inbox. `BC-22` owns all four.

`LCO-INV-021` | Notification failure SHALL NOT block publication, and publication
success SHALL NOT be inferred from notification success. `E-23` is
fire-and-forget `PL`.

---

## 15. Files & Media attachment integration

`LCO-FR-087` | An official post's attachments SHALL be handled by **exactly**
A2's mechanism — an opaque `BC-14`-owned reference. A5 SHALL NOT hold bytes, a
storage path, a MIME type, a size, or a signed URL.

`LCO-FR-088` | ⛔ **Attachments are BLOCKED, inherited.** A2 `LCF-FR-043`:
*"Until `LCF-ADR-002` is accepted, `NOTE`, `MEDIA` and `LINK` posts SHALL be
treated as blocked."* No `BC-15 → BC-14` edge exists (BC Map **L292**). Official
posts inherit this block **unchanged**.

`LCO-FR-089` | ⛔ A5 SHALL NOT seek an exemption from `LCF-ADR-002` on the
grounds that official posts are institutional. The edge is missing for `BC-15`
as a whole; the author's nature does not bear on it.

`LCO-FR-090` | Official posts of type `TEXT` are therefore the **only** official
posts publishable in V1 on the attachment axis — subject to §4.4's separate and
independent block.

`LCO-FR-091` | A5 SHALL NOT become a consumer of `E-22`. `ADR-0055` §3 sets a
**per-context necessity test**; `BC-15` is not on `E-22`'s consumer list and A5
does not ask to be added. Its route to storage is `BC-14`, exactly as A2 §10.1
establishes.

`LCO-INV-022` | An official post SHALL NOT gain an attachment capability A2 does
not grant to an ordinary post.

---

## 16. Security, authorization and cross-library isolation

`LCO-SEC-010` | An official post SHALL be readable only within the community that
owns it — A2 `LCF-SEC-001`, restated because official status must not weaken it.

`LCO-SEC-011` | No endpoint SHALL return an official post from a community the
caller is not entitled to read — A2 `LCF-SEC-002`.

`LCO-SEC-012` | Cross-community and cross-library leakage SHALL be asserted **by
test**, not assumed by convention — BC Map **L490**; A2 `LCF-SEC-003`.

`LCO-SEC-013` | *"Not entitled"* and *"does not exist"* SHALL be
indistinguishable in every response — A2 `LCF-SEC-006`.

`LCO-SEC-014` | **IDOR.** Object-level authorisation SHALL be evaluated for every
official post accessed by identifier. A post identifier SHALL NOT be a
capability. Enumerable, sequential or guessable official post identifiers SHALL
NOT grant access.

`LCO-SEC-015` | **Server-side trust boundary.** The server SHALL NOT trust a
client-supplied library identifier, tenant identifier, community identifier,
role, author identity, official discriminator, institution reference, priority
level or visibility value. Each SHALL be derived or validated server-side.

`LCO-SEC-016` | **Replay and retry.** Publication SHALL be idempotent under
retry. A repeated publish request SHALL NOT produce a duplicate official post or
a duplicate notification fact. Idempotency SHALL key on a caller-supplied
idempotency token **validated server-side**, and on `eventId` for events
(`LCO-FR-085`).

`LCO-SEC-017` | A replayed privileged request SHALL NOT confer authority the
caller no longer holds — `LCO-SEC-005`, `LCO-SEC-006`.

`LCO-SEC-018` | An official post SHALL NOT carry a `StudentRecordId`, in storage,
in any payload, in any event, or in any index. BC Map `ID-2` (**L179**):
*"`StudentRecordId` **never** leaves its tenant."*

`LCO-SEC-019` | ⛔ **`ID-3` disclosure.** BC Map **L180** requires that social
contexts *"must not be able to resolve which library a person attends unless the
person explicitly published it."* An official post attributed to a named
institution, read by a member, **discloses that the reader is affiliated with
that library — to the reader themselves**. This is not a leak of a *third
party's* affiliation, and A2's `communityId` model already carries the same
property. ⚠ **It is disclosed rather than dismissed**, because A2 §20.5 records
a closely-related unresolved semantic objection which *"survives"* `ADR-0078`
and is **assigned to no one**. → `LCO-GAP-012`.

`LCO-SEC-020` | Enforcement from `BC-13` SHALL apply to official posts. `E-14`
(BC Map **L318**) already names `BC-15` as a consumer of
`EnforcementActionTaken`; no new edge is required.

`LCO-SEC-021` | An official post removed by enforcement SHALL NOT reveal the
enforcement reason — A2 `LCF-SEC-007`, A2 `LCF-EVT-004`.

`LCO-SEC-022` | ⛔ A5 SHALL NOT define moderation policy, an appeal path, or an
exemption for institutional content. `BC-13` owns all three (`LCO-XC-012`).
⚠ Whether a library's own official post may be moderated by `BC-13` against the
library's wishes is a **genuine open question** no measured document answers →
`LCO-GAP-013`.

`LCO-SEC-023` | Block relationships SHALL be honoured as A2 honours them. A2
`LCF-AUTH-012` consumes `BC-11`'s `BlockList` across an **unregistered** edge
and is therefore **self-blocked** pending `LCF-ADR-007`. A5 inherits that
position and SHALL NOT bypass it. ⚠ **Disclosure:** whether a member may block a
*library's* official communication is unanswered → `LCO-GAP-014`.

`LCO-SEC-024` | Authorisation decisions, publication attempts and refusals SHALL
be auditable (§17). A refusal SHALL NOT be silent.

---

## 17. Audit logging

`LCO-FR-092` | Official publication, edit, deletion, priority change, pin,
unpin, archive and visibility change SHALL each emit an audit fact to `BC-24` via
`E-20`.

`LCO-FR-093` | ⭐ `E-20`'s source cell is **"All contexts"** (BC Map **L329**),
so `BC-15` is **already** an authorised emitter and **no new edge is required**.
Its mechanism is *"Event (fire-and-forget, outbox-backed)"* and *"Domain never
calls audit synchronously"* — A5 SHALL respect both.

`LCO-FR-094` | Every audit fact SHALL identify the **natural person** who
performed the act, in addition to the institution the post is attributed to —
`LCO-INV-015`.

`LCO-FR-095` | An audit fact SHALL record the authorisation basis — the role
relied upon — so a later reviewer can evaluate whether the act was authorised at
the time.

`LCO-FR-096` | A failed or refused official publication attempt SHALL be
auditable, not only a successful one. Refusals are the security-relevant events.

`LCO-FR-097` | ⛔ A5 SHALL NOT define the audit record's storage shape,
retention period, export format or immutability mechanism. `BC-24` owns them;
`PRD-016` is **FROZEN**. ⚠ `PRD-016`'s `AUD-CFG-*` register is **deliberately
empty** because *"no Rank 1–7 document bounds any audit parameter"* — so A5
cannot inherit a retention value either. → `LCO-GAP-015`.

`LCO-FR-098` | An audit fact SHALL NOT carry the post body. Audit records the
**act**, not the content.

`LCO-INV-023` | Audit emission SHALL NOT be conditional on the actor's later role
status. A revoked role does not erase the record of what its holder did.

`LCO-INV-024` | Audit failure SHALL NOT block publication, and publication SHALL
NOT be reported as audited merely because the fact was emitted. `E-20` is
fire-and-forget; the outbox is the durability mechanism.

---

## 18. Owner/Manager removal and library closure

`LCO-FR-099` | Loss of a library role SHALL immediately end that person's
official publishing authority — `LCO-SEC-005`.

`LCO-FR-100` | Loss of a role SHALL NOT alter, retract, de-officialise or delete
any already-published official post. The institution published it
(`LCO-SEC-007`).

`LCO-FR-101` | Where a library has multiple `TR-1` Owner holders — a model
`Library_PRD_v1.md` §15 explicitly supports — removal of one SHALL NOT affect
another's authority.

`LCO-FR-102` | ⛔ **Removal of the last authorised publisher.** A community may
be left with official posts and no one authorised to edit or delete them. A5
SHALL NOT resolve this by escalating authority to a Platform Administrator —
`LIB-4.2` forbids exactly that. → `LCO-GAP-016`, `LCO-EC-008`.

`LCO-FR-103` | **Library closure.** `Library_PRD_v1.md` §8 owns the library
lifecycle and §8.2 owns *"Deletion — scope boundary"*. A5 SHALL NOT define a
closure procedure, a cascade, or a retention rule for a closed library's official
posts.

`LCO-FR-104` | On library closure, official posts SHALL become unreadable no
later than the point at which the community itself becomes unreadable. A5 defers
to **A1** for community access and to `BC-19`/`Library_PRD_v1.md` §8 for closure.

`LCO-FR-105` | ⛔ Whether a closed library's official posts are deleted,
retained, anonymised or archived is **NOT decided here**. It engages `BC-19`
lifecycle, `BC-24` retention, and data-protection obligations no measured
document resolves for this object. → `LCO-GAP-017`, `LCO-DEC-007`.

`LCO-INV-025` | A closed or suspended library SHALL NOT publish official
communication. Publication authority SHALL require the library to be in an
active state, as `BC-19` determines it.

---

## 19. Data model — reusing `CommunityPost`

### 19.1 The reuse determination

`LCO-FR-106` | A5 SHALL NOT create a second content aggregate. Official
communication SHALL be carried by **A2's existing `CommunityPost`**, extended by
field.

⭐ **Why reuse and not a new aggregate.** Four measurements: (a) A2
`LCF-FR-016` gives `CommunityPost` to `BC-15`, and A5 is in the same context, so
a second root would be an intra-context duplication; (b) BC Map §8 (**L370–386**)
has **no row for `BC-15` at all** (A2 `LCF-FR-100`), so a new root would need a
registration that even the existing roots lack; (c) the feed, pagination,
comment, reaction and enforcement machinery is all keyed to `CommunityPost`;
(d) the explicit instruction is to use the existing aggregate wherever possible.

`LCO-FR-107` | ⛔ **Every field below is an A2 amendment, not an A5 creation.**
A5 has no authority over `CommunityPost`'s shape. → `LCO-ADR-003`, owner
**Product Owner + A2 author**.

### 19.2 Proposed fields on `CommunityPost`

| Field | Shape | Notes |
|---|---|---|
| `officialAuthority` | Absent, or an attribution reference | **The discriminator.** Absent ⇒ ordinary member post. Present ⇒ official. Server-set only (`LCO-SEC-003`) |
| `announcementCategory` | One of the six (§6.2), or absent | Present **iff** `officialAuthority` is present. Mutable (`LCO-FR-033`) |
| `priorityLevel` | One of the four (§10), or absent | A3's reserved names. Requires `priorityExpiresAt` (`LCO-INV-016`) |
| `priorityExpiresAt` | Timestamp | Mandatory whenever `priorityLevel` is present |
| `visibility` | `COMMUNITY_ONLY` \| `PUBLIC` | `PUBLIC` **BLOCKED** (`LCO-FR-064`). Default `COMMUNITY_ONLY` |
| `archivedAt` | Timestamp or absent | Archive flag (§8.2). Not an A2 `state` value (`LCO-FR-037`) |
| `publishedByActorRef` | `PersonId`-level reference | ⚠ **The actor, not the author.** For audit (`LCO-INV-015`), **never** for display (`LCO-INV-008`) |

`LCO-INV-026` | `officialAuthority` SHALL be the **single** discriminator. No
second field, flag, role check or type value SHALL independently make a post
official.

`LCO-INV-027` | `announcementCategory`, `priorityLevel`, `priorityExpiresAt` and
`archivedAt` SHALL be absent whenever `officialAuthority` is absent. An ordinary
member post SHALL NOT carry official metadata.

`LCO-INV-028` | ⛔ `publishedByActorRef` SHALL NOT be exposed on any read path
that renders post authorship. It is an **audit** field. Exposing it would defeat
`LCO-INV-008` and is the most likely implementation route to breaching the core
invariant.

`LCO-INV-029` | No field in §19.2 SHALL carry a `tenantId`. `ACCEPTED`
`ADR-0078` §2.1: *"The community scope identifier carries **NO** `tenantId`."*
`officialAuthority` is therefore an **opaque attribution reference**, not a
tenant identifier. ⛔ Its exact shape is **BLOCKED** with §4.4 —
`LCO-ADR-001`.

`LCO-INV-030` | ⚠ **Disclosure.** `LCO-INV-029` leaves `officialAuthority`
specified in role but **not in shape**. This is the same class of residue A2
§20.5 discloses about `communityId` — *"a `communityId` that maps one-to-one onto
a library may simply be a `tenantId` wearing a different name"* — an objection
A2 records as surviving `ADR-0078` and **assigned to no one**. A5 inherits it,
does not resolve it, and does not pretend `ADR-0078` settled it. →
`LCO-GAP-012`.

`LCO-FR-108` | A5 SHALL NOT add a field to `CommunityComment` or
`CommunityReaction`. Whether members may comment on or react to official posts is
governed by A2 unchanged. ⚠ Whether they *should* be able to is a product
question → `LCO-GAP-018`.

`LCO-FR-109` | A5 registers **no aggregate** in BC Map §8. A2 `LCF-FR-100`
records that `BC-15` has no §8 row at all, and `LCF-ADR-001` routes that to the
Architecture Owner. A5 inherits the gap → `LCO-GAP-019`.

---

## 20. API contracts — documentation only

`LCO-FR-110` | The contracts below are **documentation**. No endpoint path, HTTP
verb, status code, header, payload schema or error code is specified, because A2
§23 declares five of its own fourteen contracts **NOT PROVIDED** rather than
invent a convention the repository lacks, and A2 §14.1 records that **no
pagination convention exists**.

| # | Capability | Status |
|---|---|---|
| `LCO-API-001` | Create an official post as `DRAFT` | ⛔ **BLOCKED** — §4.4 identity path |
| `LCO-API-002` | Publish a `DRAFT` official post | ⛔ **BLOCKED** — §4.4 |
| `LCO-API-003` | Edit an official post's body/category | ⛔ **BLOCKED** — §4.4 |
| `LCO-API-004` | Delete an official post | ⛔ **BLOCKED** — §4.4 |
| `LCO-API-005` | Set / change / clear priority | ⛔ **BLOCKED** — §4.4; inert until `LCO-DEC-006` |
| `LCO-API-006` | Pin / unpin | ⛔ **BLOCKED** — as `LCO-API-005` |
| `LCO-API-007` | Archive an official post | ⛔ **BLOCKED** — §4.4; scope open (`LCO-GAP-009`) |
| `LCO-API-008` | Read official posts in a feed | ⏸ **VIA A2 ONLY** — A5 provides no endpoint (`LCO-FR-067`) |
| `LCO-API-009` | Read an official post's detail | ⏸ **VIA A2 ONLY** |
| `LCO-API-010` | Set visibility | ⛔ **NOT PROVIDED** — the only settable value is the default (`LCO-FR-063`) |
| `LCO-API-011` | Any public / unauthenticated official-post read | ⛔ **REFUSED** — `LCO-FR-064`, `LCO-FR-065` |

`LCO-FR-111` | A **BLOCKED** or **NOT PROVIDED** contract SHALL NOT be partially
implemented. A2 `LCF-FR-103` states the equivalent discipline.

`LCO-FR-112` | Every contract SHALL enforce §7 authorisation server-side and
§16's trust boundary. No contract SHALL accept the official discriminator, the
attributed institution, or a role from the client.

---

## 21. Required events

`LCO-FR-113` | ⛔ **A2's event set is CLOSED at six.** `LCF-FR-104`: *"The event
set SHALL be closed at these six. A seventh SHALL require a PRD amendment."*
A5 therefore proposes **no seventh event** by its own authority.

`LCO-FR-114` | Official publication SHALL be observable through A2's **existing**
`community.PostPublished` (`LCF-EVT-001`), whose payload already carries
`postId`, `communityId`, `authorRef`, `type` and `createdAt`.

`LCO-FR-115` | ⛔ **Disclosure — `LCF-EVT-001` is not sufficient as it stands.**
Its payload carries no official discriminator and no category, so a `BC-22` or
`BC-26` consumer cannot distinguish an official post from a member post without
reading post state — which crosses a boundary. Two resolutions exist: extend
`LCF-EVT-001`'s payload, or add a seventh event. **Both are A2 amendments.**
A5 selects neither. → `LCO-ADR-003`, `LCO-GAP-020`.

`LCO-FR-116` | Whichever resolution is chosen, the payload SHALL NOT carry the
post body (`LCF-FR-105`), SHALL NOT carry a `StudentRecordId` (`LCF-FR-105`,
`ID-2`), SHALL NOT carry a `tenantId` (`ADR-0078`), and SHALL carry an `eventId`
for idempotency (BC Map **L447**).

`LCO-FR-117` | Priority change, pin, unpin, archive and visibility change SHALL
be **auditable** (§17) but SHALL NOT each require a domain event. Audit is
`E-20`; a domain event is a published contract with consumers. A5 requests **no**
new published contract.

`LCO-FR-118` | A5 SHALL NOT introduce an event transport. The `PL` mechanism of
BC Map §10 is the only one — A2 `LCF-XC-022`.

---

## 22. Rate limiting

`LCO-FR-119` | Official publication, edit, priority change and pin SHALL be rate
limited.

`LCO-FR-120` | The counter SHALL be the `BC-11`-owned `RateLimitCounter` (BC Map
**L377**). A5 SHALL NOT introduce a second counter aggregate — A2
`LCF-FR-096`.

`LCO-FR-121` | ⛔ **BLOCKED, inherited.** The `BC-15 → BC-11` edge required to
read that counter is **not** in BC Map §7 (**L292**). A2 §21's self-blocking
clause already treats rate-limited operations as blocked pending `LCF-ADR-007`.
A5 inherits this **unchanged** and SHALL NOT bypass it.

`LCO-FR-122` | ⛔ A5 SHALL NOT specify a limit value, window, quota or burst
allowance, and mints **no** `LCO-CFG-*`. Values are `BC-25` configuration
(`LCO-XC-016`); policy authorship is `BC-11`'s (`LCO-XC-019`).

`LCO-FR-123` | A rate-limit refusal SHALL be distinguishable from an
authorisation refusal — the remedies differ — but SHALL NOT reveal the limit
value. A2 `LCF-FR-098`.

`LCO-INV-031` | Rate limiting SHALL NOT substitute for authorisation, and §7
SHALL be evaluated first — A2 `LCF-INV-016`.

`LCO-INV-032` | ⚠ **Disclosure.** An institutional publisher plausibly warrants
a different limit from a member. A5 states **no** such differentiation, because
that would be a value. → `LCO-GAP-007`.

---

## 23. Privacy-conscious analytics

`LCO-FR-124` | A5 SHALL NOT define a metric, projection, report or export.
`BC-26` owns the metric and semantic layer (`LCO-XC-018`).

`LCO-FR-125` | ⛔ Community Analytics is **V3** — EA **L973**. A5 SHALL NOT
advance it and SHALL NOT create an interim analytics surface.

`LCO-FR-126` | Any analytics SHALL be **aggregate-only**. A5 SHALL NOT create,
require or enable a per-viewer read record for official posts.

⭐ **Why per-viewer read tracking is refused rather than deferred.** A3
`LCR-GAP-006` records that per-viewer impression tracking *"would create a new
personal-data store over a minor-inclusive population"* and routes it to
**Privacy Owner + Product Owner** — and A3 `LCR-DEC-003` is still **OPEN**.
"Who has read the library's announcement" is the same object under a different
name. A5 does not open a second route to a decision that is already open.

`LCO-FR-127` | ⛔ A5 SHALL NOT provide a read receipt, seen-by list,
acknowledgement, or delivery confirmation for official posts, including for
`EMERGENCY`. → `LCO-GAP-021`, `LCO-DEC-008`.

`LCO-FR-128` | Aggregate counts SHALL NOT be derivable to a small enough
population to identify an individual reader. A5 states **no** k-anonymity
threshold — that is a Privacy Owner value → `LCO-GAP-021`.

`LCO-INV-033` | No analytics surface SHALL expose member identity in connection
with an official post. `14A` §14A.5's never-public list begins with **Student
Information** and **Member Directory**.

---

## 24. Performance expectations

`LCO-FR-129` | Official post retrieval SHALL be bounded by A2's pagination
(`LCO-FR-068`); A5 introduces no unbounded read.

`LCO-FR-130` | Resolution of institutional display identity SHALL NOT require a
per-post synchronous cross-context call. ⛔ The mechanism is `LCO-ADR-001`'s
subject; this requirement **constrains** the choice without making it.

`LCO-FR-131` | Priority expiry SHALL NOT require a per-request scan of all posts.
Expiry is a comparison against a stored timestamp.

`LCO-FR-132` | Notification and audit emission SHALL NOT be on the publication
critical path. Both are fire-and-forget `PL` (`LCO-INV-021`,
`LCO-INV-024`).

`LCO-FR-133` | ⛔ **No latency, throughput, availability or volume budget is
stated.** A2 `LCF-GAP-010` and A3 `LCR-GAP-010` both record that **no binding
budget exists** in the repository, routed to Product Owner + Architecture Owner.
A5 inherits rather than invents. → `LCO-GAP-022`.

`LCO-NFR-001` | Adding official metadata to `CommunityPost` SHALL NOT degrade
ordinary feed retrieval performance.

`LCO-NFR-002` | An unresolvable institutional identity SHALL fail closed
(`LCO-FR-022`) and SHALL NOT hang, retry indefinitely, or degrade the feed for
non-official content.

`LCO-NFR-003` | Priority ordering SHALL remain deterministic for equal levels and
equal timestamps, so pagination does not duplicate or skip — A2 §14.2's concern.

`LCO-NFR-004` | Enforcement application (`E-14`) SHALL take effect on official
posts without a full reindex.

---

## 25. Edge cases

`LCO-EC-001` | **Actor loses role between draft and publish.** Publication is
refused at the publish decision (`LCO-AUTH-003`, `LCO-SEC-005`). The `DRAFT`
remains; another authorised actor may publish it.

`LCO-EC-002` | **Actor loses role after publish.** The post stands
(`LCO-FR-100`). Audit retains the actor (`LCO-INV-023`).

`LCO-EC-003` | **Priority expires while a member is paginating.** Ordering
changes mid-scroll. A5 defines no pagination and cannot fix this; A2 §14 owns it.
Disclosed → `LCO-GAP-023`.

`LCO-EC-004` | **Two authorised actors edit concurrently.** A5 states no
concurrency-resolution policy. `CommunityPost` is A2-owned; `BC-30` Offline Sync
owns conflict resolution (BC Map **L139**) and `BC-15` is not an `E-24`
participant. Disclosed → `LCO-GAP-024`.

`LCO-EC-005` | **Priority set with an expiry already in the past.** Rejected —
`LCO-INV-016` requires an expiry, and an expired priority has no effect;
accepting it would create a silently inert state.

`LCO-EC-006` | **Post pinned, then enforcement removes it.** `REMOVED` wins.
Enforcement is `BC-13`'s (`LCO-SEC-020`) and priority SHALL NOT override it
(`LCO-INV-020`).

`LCO-EC-007` | **Member's participation lapses while an official post is
pinned.** A1's predicate governs; the post becomes unreadable to them. A5 adds no
exception — official status does not widen readership (`LCO-AUTH-009`).

`LCO-EC-008` | **Last authorised publisher removed.** Official posts persist with
no one able to edit or delete them. **Unresolved by design** —
`LCO-FR-102`, `LCO-GAP-016`.

`LCO-EC-009` | **Library suspended, then reactivated.** Publication is refused
while inactive (`LCO-INV-025`). Existing posts' readability follows the
community's, not A5's rules (`LCO-FR-104`).

`LCO-EC-010` | **`EMERGENCY` published during quiet hours.** The fact is emitted;
`BC-22` decides delivery (`LCO-FR-083`). A5 requests **no** override. ⚠ This is
a real product risk, disclosed: `LCO-RSK-007`.

`LCO-EC-011` | **Notification emitted, publication then fails.** `E-23` is
fire-and-forget, so a fact may precede a failed commit. A5 requires emission on
transition to `PUBLISHED` (`LCO-FR-040`); transactional coupling of a
fire-and-forget event to a commit is an outbox concern A5 does not specify.
Disclosed → `LCO-GAP-025`.

`LCO-EC-012` | **Duplicate publish under retry.** One post, one fact —
`LCO-SEC-016`.

`LCO-EC-013` | **Official post referencing a holiday that `BC-06` does not
record.** Permitted, and inconsistent. A5 does not write to `BC-06`
(`LCO-FR-028`) → `LCO-GAP-006`.

`LCO-EC-014` | **A member blocks the library.** Undefined — `BC-11`'s
`BlockList` models person-to-person blocks; a library is not a person.
Disclosed → `LCO-GAP-014`.

`LCO-EC-015` | **`officialAuthority` present but the institution is unresolvable.**
Fail closed — `LCO-FR-022`, `LCO-NFR-002`. The actor's identity SHALL NOT be
substituted.

`LCO-EC-016` | **Stored `visibility` reads `PUBLIC`.** Treated as
`COMMUNITY_ONLY` — `LCO-INV-018`.

---

## 26. Scope

### 26.1 V1 — lean, as instructed

| # | Item | Status |
|---|---|---|
| 1 | Six announcement categories (§6.2) | Specified |
| 2 | Institutional attribution discriminator (§4) | Specified; **BLOCKED** on §4.4 |
| 3 | Owner/Manager/Reception authorisation model (§7) | Specified; role set **OPEN** (`LCO-DEC-004`) |
| 4 | Draft → Published → Archived → Deleted (§8) | Specified |
| 5 | Edit and delete (§9) | Specified; requires A2 amendment |
| 6 | Priority and pin with mandatory expiry (§10) | Specified; **inert** until `LCO-DEC-006` |
| 7 | `COMMUNITY_ONLY` visibility (§11) | Specified and implementable |
| 8 | `PUBLIC` visibility (§11) | ⛔ **BLOCKED** — `LCO-FR-064` |
| 9 | A2 feed integration (§12) | Specified |
| 10 | A3 ranking integration (§13) | Specified; no weight |
| 11 | `BC-22` notification integration (§14) | Specified; ✅ **no new edge** |
| 12 | `BC-24` audit integration (§17) | Specified; ✅ **no new edge** |
| 13 | Attachments (§15) | ⛔ **BLOCKED**, inherited |
| 14 | Rate limiting (§22) | ⛔ **BLOCKED**, inherited |
| 15 | Aggregate-only analytics posture (§23) | Specified as a **refusal** |

### 26.2 Out of V1

Complex approval workflows (`LCO-XC-024`) · advanced targeting, campaigns, CRM,
A/B testing, AI generation (`LCO-XC-025`) · read receipts and
acknowledgement (`LCO-FR-127`) · per-viewer analytics (`LCO-FR-126`) · comment
and reaction policy for official posts (`LCO-FR-108`) · scheduled or
future-dated publication (**not requested; no scheduler — `BC-28` is V2**).

### 26.3 Refused, not deferred

`LCO-XC-023` `OfficialPerson` and every library-as-account model ·
`LCO-XC-026` cross-library broadcasting · `LCO-API-011` unauthenticated
official-post reads.

---

## 27. Acceptance criteria — Given / When / Then

⛔ **0 of 21 are currently passing**, and 0 can be evaluated while §0.3's gates
and §4.4's block stand. They are written to be verifiable **if** the blocks
clear.

`LCO-AC-001` | **Given** an authorised publisher, **when** an official post is
published, **then** it is attributed to the institution and the actor's personal
display name, username and photo appear nowhere in the rendered authorship. (`LCO-INV-008`, `LCO-INV-007`)

`LCO-AC-002` | **Given** a `TR-1` Owner, **when** they publish a personal
non-official post, **then** it is attributed to them as a person and carries no
institutional mark. (`LCO-INV-009`)

`LCO-AC-003` | **Given** any client request, **when** it supplies an official
discriminator, institution reference, role or library identifier, **then** the
supplied value is ignored and the server-derived value is used. (`LCO-SEC-015`, `LCO-SEC-003`, `LCO-SEC-001`)

`LCO-AC-004` | **Given** a member with no publishing authority, **when** they
attempt to publish officially by any route including field injection, **then**
the attempt is refused and audited. (`LCO-SEC-004`, `LCO-AUTH-001`, `LCO-SEC-024`)

`LCO-AC-005` | **Given** an actor whose role was revoked, **when** they attempt
any official operation, **then** it is refused on the next authorisation
decision. (`LCO-SEC-005`, `LCO-AUTH-003`)

`LCO-AC-006` | **Given** an actor authorised in library L, **when** they attempt
to publish into library M's community, **then** it is refused. (`LCO-AUTH-008`, `LCO-SEC-002`)

`LCO-AC-007` | **Given** an official post in library L, **when** a member of
library M requests it by identifier, **then** the response is
indistinguishable from *"does not exist"*. (`LCO-SEC-013`, `LCO-SEC-011`)

`LCO-AC-008` | **Given** a priority assignment without an expiry, **when**
submitted, **then** it is rejected. (`LCO-INV-016`, `LCO-FR-055`)

`LCO-AC-009` | **Given** a priority whose expiry has passed, **when** the feed is
retrieved, **then** the post appears in ordinary ordering. (`LCO-FR-055`, `LCO-FR-075`)

`LCO-AC-010` | **Given** a pinned official post, **when** the feed is retrieved,
**then** no non-official post is hidden, suppressed or omitted. (`LCO-INV-017`)

`LCO-AC-011` | **Given** an official post, **when** any unauthenticated request
targets it by any path, **then** it is not served. (`LCO-FR-064`, `LCO-FR-065`, `LCO-AUTH-009`)

`LCO-AC-012` | **Given** an official post, **when** the public library profile is
rendered, **then** no field, count, excerpt or existence signal from the post
appears. (`LCO-FR-026`, `LCO-FR-025`)

`LCO-AC-013` | **Given** stored `visibility` = `PUBLIC`, **when** an
unauthenticated request targets the post, **then** it is not served. (`LCO-INV-018`, `LCO-FR-063`)

`LCO-AC-014` | **Given** a published official post, **when** the notification
fact is emitted, **then** it carries the category and does **not** carry the post
body. (`LCO-FR-082`, `LCO-FR-081`)

`LCO-AC-015` | **Given** a repeated publish request with the same idempotency
token, **when** processed, **then** exactly one post and one notification fact
exist. (`LCO-SEC-016`)

`LCO-AC-016` | **Given** any official operation, **when** it completes or is
refused, **then** an audit fact identifies the natural person, the institution
and the authorisation basis. (`LCO-FR-094`, `LCO-FR-095`)

`LCO-AC-017` | **Given** an official post, **when** its audit record is
inspected, **then** it does not contain the post body. (`LCO-FR-098`)

`LCO-AC-018` | **Given** enforcement from `BC-13`, **when** applied to an
official post, **then** the post becomes `REMOVED` and the response reveals no
enforcement reason. (`LCO-SEC-020`, `LCO-SEC-021`)

`LCO-AC-019` | **Given** a suspended or closed library, **when** official
publication is attempted, **then** it is refused. (`LCO-INV-025`)

`LCO-AC-020` | **Given** an institution whose display identity cannot be
authoritatively resolved, **when** publication is attempted, **then** it is
refused and the actor's identity is **not** substituted. (`LCO-FR-022`, `LCO-NFR-002`)

`LCO-AC-021` | **Given** an official post, **when** any event payload is
inspected, **then** it contains no `StudentRecordId`, no `tenantId` and no post
body. (`LCO-FR-116`, `LCO-SEC-018`)

---

## 28. Risks

`LCO-RSK-001` | ⭐ **The core invariant is breached by the easiest implementation
path** — rendering `publishedByActorRef` as the author. | **High** |
`LCO-INV-008`, `LCO-INV-028`, `LCO-AC-001`, `LCO-AC-020`

`LCO-RSK-002` | This draft is mistaken for an allocated, approved part. | High |
§0.3, `LCO-INV-001`…`003`, the v0.1 banner

`LCO-RSK-003` | `PUBLIC` visibility is implemented because the field exists in
§19.2. | **High** | `LCO-FR-064`, `LCO-FR-065`, `LCO-INV-018`, `LCO-AC-013`

`LCO-RSK-004` | A2's `CommunityPost` acquires a second edit-authority rule
without the A2 author's consent. | High | `LCO-FR-046`, `LCO-FR-107`,
`LCO-ADR-003`

`LCO-RSK-005` | `officialAuthority` becomes a `tenantId` in disguise, reviving
A2 §20.5's unresolved objection. | Medium | `LCO-INV-029`, `LCO-INV-030`,
`LCO-GAP-012`

`LCO-RSK-006` | Priority is implemented with an invented weight, overwriting the
Product Owner's ruled 70/30 split. | Medium | `LCO-FR-054`, `LCO-FR-077`,
`LCO-DEC-006`

`LCO-RSK-007` | `EMERGENCY` announcements are silently suppressed by quiet hours
because A5 requested no override. | **Medium–High** | `LCO-EC-010`,
`LCO-FR-083`, `LCO-GAP-007`. ⚠ Disclosed as a **product** risk, not resolved

`LCO-RSK-008` | A library publishes an announcement that contradicts its `BC-06`
operating calendar. | Medium | `LCO-INV-011`, `LCO-EC-013`, `LCO-GAP-006`

`LCO-RSK-009` | Official communication becomes unaccountable because attribution
is institutional. | Medium | `LCO-INV-015`, `LCO-FR-094`, `LCO-AC-016`

`LCO-RSK-010` | A community is stranded with unmanageable official posts after
its last publisher is removed. | Medium | `LCO-FR-102`, `LCO-EC-008`,
`LCO-GAP-016`

`LCO-RSK-011` | This part is treated as ratified because it is committed to
`main`. | Medium | §0 and the provenance block state DRAFT explicitly; no
governance register references it

`LCO-RSK-012` | A seventh event or a fifth post type is added silently to make
the feature work. | Medium | `LCO-FR-029`, `LCO-FR-113`, `LCO-FR-115`,
`LCO-ADR-003`

---

## 29. ADR and decision requirements

### 29.1 ADRs required — A5 mints none

`LCO-ADR-001` | ⭐ Establish an authorised read path from `BC-15` to the
library's display identity, or determine that official communication cannot
carry institutional identity. **Four shapes enumerated, none selected**
(`LCO-FR-023`, `LCO-FR-024`). | **Architecture Owner** | §4.4 — blocks
`LCO-API-001`…`007`, `LCO-AC-020`

`LCO-ADR-002` | Reconcile `PUBLIC` official visibility with A2 `LCF-SEC-004`,
`LCF-SEC-005` and the closed `14A` §14A.5 public-field list — or refuse it. |
**Architecture Owner + the `14A` owner** | §11 — blocks `LCO-FR-064`

`LCO-ADR-003` | Amend A2 v0.8 to carry §19.2's fields, §9's official edit
authority, and §21's discriminator-bearing event payload. | **Product Owner +
A2 author** | §6.1, §8.1, §9, §19, §21

`LCO-ADR-004` | Register `BC-15`'s aggregates in BC Map §8 — **inherited**, not
new. A2 `LCF-ADR-001`; A3 `LCR-GAP-008`. | **Architecture Owner** | §19.2

⛔ **Inherited blocks A5 does not re-mint:** `LCF-ADR-002` (`BC-15 → BC-14`,
attachments) and `LCF-ADR-007` (`BC-15 → BC-11`, blocks and rate limits). Both
belong to A2 and remain A2's. A5 records that it is blocked by them and creates
**no** parallel identifier.

### 29.2 Decisions required

`LCO-DEC-001` | ✅ **CLOSED — Owner ruling **PO-7** (2026-08-31).** Is this subject Part A5, or another part, or a separate PRD? → **It is Part A5.** The ruling states the surface *"does exist"* and *"it IS Part A5"*; the allocation is recorded in `PRD_REGISTRY.md` **L704** (**A1…A8**) and §11.4. ⛔ **Not a separate PRD** — the same Stage-3 check-1 reasoning that PO-3 applied to A4 (*"a part of PRD-021A, not a standalone PRD"*) applies here, and splitting A5 out would fragment `BC-15`'s exclusive context ownership across two PRDs. |
**Product Owner** | Gate 1 — the whole document. ⚠ **Closing Gate 1 unsuspends this document's requirements; it does not approve them.**

`LCO-DEC-002` | ⭐ Resolve A3 `LCR-DEC-006`: does an official announcement
surface exist, and does it extend A2's closed type set? | **Product Owner** |
Gate 2 — the whole document. ✅ **CLOSED — Owner ruling **PO-7** (2026-08-31), in two halves.** **(a)** The surface **exists** and is A5. **(b)** ⛔ It **does NOT** extend A2's closed type set — A2's six-event contract stays authoritative *"unless A2 is separately amended"*, and A5 *"does NOT invent a seventh A2 event."* ⭐ A5 may publish through **its own** mechanism (PO-7 clause 4); what it may not do is reach into A2's contract to do it. ⚠⚠ **`LCO-DEC-003` and `LCO-ADR-003` are NOT closed by this.** Those ask whether an *orthogonal discriminator* may be approved over a fifth post type — an A2 amendment. PO-7 grants no A2 amendment, and Execution Rule 5 forbids inventing one. They remain **OPEN**.

`LCO-DEC-003` | Approve the orthogonal-discriminator approach over a fifth post
type (§6.1). | **Product Owner + A2 author** | §6.1, §19.2

`LCO-DEC-004` | Which of `TR-1`, `TR-2`, `TR-3` may publish, edit, delete, pin
and archive official communication? | **Product Owner** | §7.2 — currently
narrowed to `TR-1` only, provisionally

`LCO-DEC-005` | Is `PUBLIC` official visibility a product requirement at all? |
**Product Owner** | §11 — precedes `LCO-ADR-002`

`LCO-DEC-006` | Assign a ranking weight to `priorityLevel` and renormalise A3's
active set to exactly 100 under `LCR-FR-035`. ⚠ A3 `LCR-DEC-009` records that
A3 **SHALL NOT** carve a weight out of the ruled 70/30. | **Product Owner** |
§13 — priority is inert without it

`LCO-DEC-007` | What becomes of a closed library's official posts? |
**Product Owner + Privacy Owner** | §18, `LCO-GAP-017`

`LCO-DEC-008` | Are read receipts or acknowledgement permissible for
`EMERGENCY` over a minor-inclusive population? | **Privacy Owner + Product
Owner** | §23 — parallels A3 `LCR-DEC-003`, which is **OPEN**

### 29.3 Gap register

`LCO-GAP-001` | No document allocates scope to Part A5 | **Product Owner** | §0.3
`LCO-GAP-002` | A3 `LCR-DEC-006` is OPEN — the surface's existence is undecided | **Product Owner** | §0.3
`LCO-GAP-003` | ⛔ `BC-15` has no edge to `BC-19`/`BC-06`/`BC-25`; institutional identity is unreadable | **Architecture Owner** | §4.4
`LCO-GAP-004` | No library-level verification field is measured; `VerificationState` is a `BC-10` person attribute | **Architecture Owner + Product Owner** | §4.2
`LCO-GAP-005` | `PUBLIC` visibility contradicts `LCF-SEC-004`/`005` and the closed `14A` §14A.5 list | **Architecture Owner + `14A` owner** | §11
`LCO-GAP-006` | An announcement may contradict `BC-06`'s operating calendar | **Product Owner** | §5, `LCO-EC-013`
`LCO-GAP-007` | No configuration values exist: expiry bounds, pin caps, category→priority mapping, quiet-hours posture, rate limits | **`BC-25` owner + Product Owner** | §6.2, §10, §14, §22
`LCO-GAP-008` | No permission identifier may be minted; catalogue closed by `AUTH-7.22` | **`BC-18` owner** | §7.1 — inherited from A2 `LCF-GAP-008`
`LCO-GAP-009` | Is archiving manual, automatic, or both? | **Product Owner** | §8.2
`LCO-GAP-010` | Does a material edit re-notify? | **`BC-22` owner** | §9, §14
`LCO-GAP-011` | No ranking weight exists for priority | **Product Owner** | §10, §13
`LCO-GAP-012` | ⚠ `officialAuthority`'s shape inherits A2 §20.5's unresolved *"`tenantId` wearing a different name"* objection, which A2 assigns to **no one** | **Product Owner** — ⭐ assigned 2026-09-01 by explicit Product Owner ruling. ⚠ The ruling supplies the **owner** this row previously lacked and **nothing else**: the objection stated in the reason cell is **still OPEN, still unresolved and still disclosed**, and no requirement, ADR or identifier was created to reach this state | §19.2, §16
`LCO-GAP-013` | May `BC-13` moderate a library's own official post? | **`BC-13` owner + Product Owner** | §16
`LCO-GAP-014` | May a member block a library's official communication? | **Product Owner + `BC-11` owner** | §16, `LCO-EC-014`
`LCO-GAP-015` | No audit retention value exists; `PRD-016`'s `AUD-CFG-*` is deliberately empty | **`BC-24` owner** | §17
`LCO-GAP-016` | A community may be stranded with no authorised publisher | **Product Owner** | §18, `LCO-EC-008`
`LCO-GAP-017` | Closed-library official post disposition undecided | **Product Owner + Privacy Owner** | §18
`LCO-GAP-018` | May members comment on or react to official posts? | **Product Owner** | §19.2
`LCO-GAP-019` | BC Map §8 has no `BC-15` row | **Architecture Owner** | §19.2 — inherited from A2 `LCF-GAP-009`
`LCO-GAP-020` | `LCF-EVT-001`'s payload cannot distinguish official posts | **Product Owner + A2 author** | §21
`LCO-GAP-021` | No k-anonymity threshold and no read-receipt decision | **Privacy Owner** | §23
`LCO-GAP-022` | No latency, throughput or availability budget | **Product Owner + Architecture Owner** | §24 — inherited from A2 `LCF-GAP-010`
`LCO-GAP-023` | Priority expiry can reorder a feed mid-pagination | **A2 author** | `LCO-EC-003`
`LCO-GAP-024` | No concurrent-edit resolution policy; `BC-15` is not an `E-24` participant | **A2 author + Architecture Owner** | `LCO-EC-004`
`LCO-GAP-025` | Fire-and-forget notification may precede a failed commit | **Architecture Owner** | `LCO-EC-011`
`LCO-GAP-026` | ⛔ `integration_test/` does not exist, so no acceptance criterion is mechanically verifiable | **Quality Owner** | §27 — inherited from A2 `LCF-GAP-011`

---

## 30. Implementation checklist

⛔ **Not a work order.** No item may begin while §0.3's gates stand.

| # | Item | Precondition |
|---|---|---|
| 1 | ✅ **DONE — 2026-08-31.** Both resolved by Owner ruling **PO-7** (2026-08-31): the subject exists, it is Part A5, and it does not extend A2's closed event set. Items 2–7 below had item 1 as their precondition, so that precondition is now met — ⛔ **but every one of them remains OPEN on its own merits, and §0.3's closure is not a work order.** | — |
| 2 | Resolve `LCO-DEC-003`, then `LCO-ADR-003` (A2 amendment) | 1 |
| 3 | Resolve `LCO-ADR-001` (identity read path) | 1 |
| 4 | Resolve `LCO-DEC-004` (role set) | 1 |
| 5 | Resolve `LCO-DEC-005`, then `LCO-ADR-002` or refuse `PUBLIC` | 1 |
| 6 | Resolve `LCO-DEC-006` (priority weight, with A3's author) | 1 |
| 7 | `LCO-ADR-004` — register `BC-15` aggregates in BC Map §8 | 3 |
| 8 | Clear `LCF-ADR-002` (attachments) — **A2's act** | — |
| 9 | Clear `LCF-ADR-007` (blocks, rate limits) — **A2's act** | — |
| 10 | Resolve `LCO-GAP-007` — `BC-25` configuration shapes | 1 |
| 11 | Register the `LCO-` prefix — **Governance Owner** | 1 |
| 12 | Create `integration_test/` and prove `LCO-AC-001`…`021` | 2–7 |

---

## 31. Architecture consistency audit

| # | Check | Result |
|---|---|---|
| 1 | New bounded context created | ✅ **0** — count stays 31 (23 in V1) |
| 2 | New BC Map edge created | ✅ **0** |
| 3 | New aggregate root created | ✅ **0** — reuses `CommunityPost` (§19) |
| 4 | New event created | ✅ **0** — A2's set stays closed at six |
| 5 | New post type created | ✅ **0** — orthogonal discriminator (§6.1) |
| 6 | A2 post-state set extended | ✅ **No** — expiry is metadata (§8.1) |
| 7 | Permission identifier minted | ✅ **0** — `AUTH-7.22` |
| 8 | Role name minted | ✅ **0** — `LIB-4.1`; `TR-1`/`TR-2`/`TR-3` only |
| 9 | Configuration value / default stated | ✅ **0** — no `LCO-CFG-*` register exists |
| 10 | Ranking weight stated | ✅ **0** — `LCO-FR-054` |
| 11 | Owner decision taken | ✅ **0** — 8 routed in §29.2 |
| 12 | ADR minted | ✅ **0** — 4 *required*, next free is `ADR-0083` |
| 13 | `tenantId` introduced into `BC-15` | ✅ **No** — `ADR-0078`, `LCO-INV-029` |
| 14 | `StudentRecordId` referenced | ✅ **No** — `ID-2`, `LCO-SEC-018` |
| 15 | FROZEN document modified | ✅ **No** — 0 files modified |
| 16 | A1/A2/A3/A4 modified | ✅ **No** — 0 files modified |
| 17 | Ownership duplicated or overridden | ✅ **No** — 27 exclusions, §3.2 register |
| 18 | Placeholder for A6/A7/A8 | ✅ **No** — `LCO-INV-005`, `LCO-XC-027` |
| 19 | Existing owner reassigned | ✅ **No** — 3 misattributions corrected in §3.3 |
| 20 | Application code written | ✅ **0 lines** |
| 21 | Identifier prefix collision | ✅ **0** — `LCO-` measured 0 across `docs/`, `lib/`, `test/`, `tool/` |
| 22 | Conflicts silently resolved | ✅ **No** — 5 disclosed in §3.3 with measurements |
| 23 | Lifecycle stage conferred | ✅ **No** — Stage 3 NOT CONFERRED |

### 31.1 Positive findings — integrations that are **not** blocked

Three integrations were tested and found **already authorised**, requiring no new
edge. Recorded because a reader might otherwise assume everything is blocked:

| Integration | Edge | Source cell | Consequence |
|---|---|---|---|
| Audit → `BC-24` | `E-20` | **"All contexts"** (BC Map **L329**) | ✅ No new edge |
| Notification → `BC-22` | `E-23` | **"All contexts"** (BC Map **L332**) | ✅ No new edge |
| Enforcement ← `BC-13` | `E-14` | `BC-15` **already** a consumer (BC Map **L318**) | ✅ No new edge |

---

## 32. Register state and final determination

| Register | Count | Range |
|---|---|---|
| `LCO-FR-*` | 133 | `001`…`133`, contiguous |
| `LCO-INV-*` | 33 | `001`…`033`, contiguous |
| `LCO-XC-*` | 27 | `001`…`027`, contiguous |
| `LCO-AUTH-*` | 11 | `001`…`011`, contiguous |
| `LCO-SEC-*` | 24 | `001`…`024`, contiguous |
| `LCO-EC-*` | 16 | `001`…`016`, contiguous |
| `LCO-API-*` | 11 | `001`…`011`, contiguous |
| `LCO-NFR-*` | 4 | `001`…`004`, contiguous |
| `LCO-AC-*` | 21 | `001`…`021`, contiguous |
| `LCO-GAP-*` | 26 | `001`…`026`, contiguous |
| `LCO-DEC-*` | 8 | `001`…`008`, contiguous |
| `LCO-ADR-*` | 4 | `001`…`004`, contiguous |
| `LCO-RSK-*` | 12 | `001`…`012`, contiguous |
| **Total** | **330** | **13 registers** |

⛔ **No `LCO-CFG-*` register exists.** Deliberate: every configurable this part
touches is bounded by no authority, so shapes are declared in prose and routed to
`BC-25` rather than given identifiers that imply values.

⛔ **Lifecycle status:** No stage advanced. Stage 3 **NOT CONFERRED**. **NOT
READY. NOT FROZEN. NOT APPROVED. NOT BASELINED.** ✅ `LCO-DEC-001` and
`LCO-DEC-002` are now **both CLOSED** by Owner ruling **PO-7** (2026-08-31), so this part's *existence as Part A5, and the
existence of its subject at all,* are **no longer undetermined.** ⚠⚠ **That is the only thing that changed.** Stage 3 is still **NOT CONFERRED** for A5, no stage has advanced, and the remaining §29.2 decisions — `LCO-DEC-003`, `LCO-DEC-004`, `LCO-DEC-005`, `LCO-DEC-006` — together with `LCO-ADR-001`, `LCO-ADR-002`, `LCO-ADR-003` and `LCO-ADR-004` are **all still OPEN**. ⭐ Two gates closing turned this document from *"a specification of something that may not exist"* into *"an unratified specification of something that does"*. ⛔ It does **not** make it ready, and this footer is not being softened to imply otherwise.

⛔ **Identifiers are PROPOSED and UNRATIFIED.** The `LCO-` prefix is not
registered; `TRACEABILITY_MATRIX.md` carries zero `LCO-` entries.

| Field | Value |
|---|---|
| Acceptance criteria passing | **0 of 21** |
| Gaps open | **26 of 26** |
| Decisions required | **8** |
| ADRs required | **4** (plus 2 inherited A2 blocks) |
| Conflicts disclosed | **5** |
| Blocked capabilities | **4** — identity path, `PUBLIC`, attachments, rate limits |
| Files modified | **0** |
| **Determination** | **DRAFT — candidate scope, doubly gated, not allocated.** 5 conflicts disclosed, 26 gaps open, 8 decisions required, 4 ADRs required, 0 acceptance criteria passing |
