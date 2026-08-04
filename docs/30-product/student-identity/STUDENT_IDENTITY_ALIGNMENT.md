# Student Identity Alignment Report

**Companion to:** `Student_Identity_PRD_v1.md` v1.0
**Governing decision:** `ADR-0011` — Global Person Identity is a platform identity, not a social profile
**Baseline:** `BASELINE-2026-08-04`
**Status:** Official

---

## 1. Purpose of this report

The Student Identity & Profile PRD v1.0 draft was reviewed against the full governing corpus:

| Authority | Version | Precedence |
|---|---|---|
| Product Vision | current | Rank 1 |
| Master PRD | v1.7 | Rank 2 |
| Authentication PRD | v2.0 | Rank 3 |
| Library PRD | v1.0 | Rank 3 |
| Bounded Context Map | v1.3 | Rank 4 |
| Module Dependency Matrix | current | Rank 4 |
| Architecture Rulings `AR-1`…`AR-7` | v1.2 | Rank 4 |
| ADRs `ADR-0001`…`ADR-0011` | — | Rank 5 |

Thirteen genuine conflicts were found. This report records each one, the decision taken, and — where a
review finding was **rejected** — the reason the draft's original intent was preserved instead.

**This report is not a list of accepted corrections.** Eleven findings were accepted, two were rejected.
The instruction governing this review was explicit: *evaluate each finding against the architecture, and
where a review recommendation conflicts with the intended product architecture, preserve the
architecture and explain why.* §6 documents the two rejections in full.

### 1.1 What was not changed

No user-facing capability was removed. Every item on the owner's preserve list survives:

Username · Public/Private Profile · Global Profile Photo · Library Identification Photo · Aggregated
Student Profile Screen · Study Statistics · Attendance Summary · Membership Summary · Seat Summary ·
Achievements · Parent Contact support · Future School / College / Coaching support.

The document was not simplified and the product was not redesigned. It grew from the supplied draft to
80 KB because subjective statements were replaced with measurable ones and because ownership boundaries
that were implied are now stated.

---

## 2. Conflict register — `SC-1` … `SC-13`

| ID | Conflict | Severity | Disposition |
|---|---|---|---|
| `SC-1` | Identity cardinality and placement | **Blocking** | Accepted, resolved by `ADR-0011` |
| `SC-2` | Who may edit the Global Profile | High | Accepted |
| `SC-3` | Mobile number ownership | **Blocking** | Accepted |
| `SC-4` | Parent / guardian contact ownership | High | Accepted |
| `SC-5` | Default privacy mode | **Blocking** | Accepted |
| `SC-6` | Subjective non-functional requirements | High | Accepted |
| `SC-7` | Mandatory gender field | Low | **Rejected** — draft intent preserved, see §6.1 |
| `SC-8` | Invented role names | High | Accepted |
| `SC-9` | Duplicated acceptance criteria | Medium | Accepted |
| `SC-10` | Configurable values inline in prose | Medium | Accepted |
| `SC-11` | Weak invariants | High | Accepted |
| `SC-12` | Identity holding a list of organisations | High | Accepted |
| `SC-13` | Social features as the justification for the identity | **Blocking** | **Rejected as scoped** — see §6.2 |

---

## 3. Blocking conflicts

### `SC-1` — Identity cardinality and placement

**Draft position.** The supplied draft's `SID-001` / `SID-INV-001` — *the draft's own numbering, which
this document does not adopt; see the register index in PRD §0* — stated that every account has exactly
one Global Student Identity, created automatically, and that it is the parent of all library student
records.

**Conflicting authority.** Bounded Context Map §4 — the section the map itself flags as *"the
highest-risk modelling decision in LIBOORA and the one most likely to be got wrong by a team moving
fast."* It defined three identities, placed `BC-10` in the Social cluster at rank 8, classified it
`[SUPPORTING]`, and made `PersonId` **optional** — created only on social opt-in, and permitted never to
exist. Master PRD line 310 said so in terms: *"Created **only if** the human opts into the social
product. **May never exist.**"*

**Why this was blocking.** The draft and the map could not both be right, and each implied a different
product. Resolving it either way changes what the document means, so no text was written until the
owner decided. Two options were presented with their trade-offs.

**Decision.** The owner chose neither option as drafted, and issued a third position: the identity is
**platform-wide and mandatory**, and social features are merely a consumer of it. That is now
`ADR-0011`.

**Resolution.** `BC-10` is renamed **Global Person Identity**, reclassified `[SUPPORTING]` → **`[CORE]`**,
moved out of the Social cluster to **rank 7.5**, and its cardinality changed from `0..1` opt-in to
**`1:1` mandatory**, created atomically with the account.

**Why rank 7.5 and not rank 8.** Dependency Law `L2` permits a module to depend only on a **strictly
lower** rank; same-rank dependencies are forbidden except within a declared cluster, and the Library and
Social clusters *"may not reference each other."* Had `BC-10` remained at rank 8, every library module
depending on it would have been a forbidden same-rank cross-cluster dependency — the exact shape of
`X-05`. Rank 7.5 places the identity below every domain and above every capability platform, so a rank-8
domain module may depend on it legally and without an exception.

**What was preserved.** Linkage rules `ID-1` … `ID-6` and prohibition `X-05` are unamended. `ADR-0011`
amends placement, name, classification and cardinality only. `ADR-0011` §2.3 states why each of the six
rules survives a change of this size; `ID-5` in particular is the load-bearing reason the
Person/StudentRecord split is kept at all.

Requirements: `SID-1.37`, `SID-2.1` … `SID-2.4`, `SID-4.1` … `SID-4.3`, `SID-INV-1`, `SID-INV-2`.

### `SC-3` — Mobile number ownership

**Draft position.** The Student Identity owns and verifies the mobile number as the primary business
identifier.

**Conflicting authority.** `ID-1` — no context outside `BC-18` may store a credential. `MP-GBR-25` — OTP
on a mobile number is the sole authentication factor in V1.

**Analysis.** In a system whose only authentication factor is a mobile number, that field is not profile
data; it is the credential. Storing it here would put a credential outside Identity & Access. This is
the same finding that produced `LIB-6.4` in the Library PRD, where a "business contact number" field was
found to be a credential field wearing different clothes.

**Resolution.** The mobile number is **not stored** by this module. It is resolved read-through from
`BC-18` under the caller's authorisation, and appears in no schema field, index, log or event payload.
The number remains the primary **business** identifier — the draft's intent — but `BC-18` holds it.

Requirements: `SID-1.31`, `SID-2.9`, `SID-4.13`, `SXC-1`, `SID-INV-5`, `SID-AC-14`.

### `SC-5` — Default privacy mode

**Draft position.** Profiles default to Public so that discovery works out of the box.

**Conflicting authority.** `AP-3` deny by default. The platform serves a minor-heavy user base;
`BC-13` Trust & Safety is classified `[CORE]` *"despite living in a Supporting platform"* precisely
because minor safety is existential legal risk.

**Analysis.** A default that publishes a minor's name and photo without an act of consent is not a
usability decision, it is a consent defect. Discovery that depends on non-consent is not discovery.

**Resolution.** **Private is the default** for every newly created identity. Public requires an explicit,
recorded act of consent carrying actor, timestamp and the exact setting consented to, revocable at any
time with immediate effect. No configuration value can change the default.

Requirements: `SID-1.26`, `SID-2.27`, `SID-5.15`, `SID-5.44`, `SID-INV-9`, `SID-AC-5`, `SID-AC-6`.

---

## 4. High-severity conflicts

### `SC-2` — Who may edit the Global Profile

**Draft position.** Library staff may update student profile information.

**Conflicting authority.** `ID-3` — social contexts key on `PersonId` and must not resolve organisation
membership. `AP-5` separation of duties.

**Analysis.** Two distinct things were being called "the profile": the person's self-expression, and the
organisation's record of a student. Staff have a legitimate need to correct the latter. They have no
basis for editing the former.

**Resolution.** Organisation roles `TR-1`, `TR-2` and `TR-3` **cannot** mutate any global profile field
through any path. They edit Student Records in `BC-01`, which is what they actually needed. A Platform
Administrator may act on identity **status** only — *"editing a person's self-expression is not an
administrative function."*

Requirements: `SID-3.31`, `SID-3.32`, `SID-4.20`, `SID-5.2`, `SPO-8`, `SID-AC-17`, `SID-AC-18`.

### `SC-4` — Parent / guardian contact ownership

**Draft position.** Parent / guardian contact is a field of the Global Profile.

**Conflicting authority.** `ID-6` guardian consent; `ID-2` tenant data must not enter a global context;
Library PRD `LXC-4`, which assigns the student profile record to `BC-01`.

**Analysis.** The parent is not the account holder. They have not authenticated, they consented to one
organisation, and they may be a different parent at a different organisation. That is tenant-scoped
third-party PII, and a global context is the wrong home for it.

**Resolution.** Storage moves to `BC-01`. **Parent Contact support is fully preserved** — it appears on
the aggregated profile screen as a contribution from `BC-01`, fetched under the caller's authorisation.
The capability the owner asked to keep is intact; only the owning context changed.

Requirements: `SID-2.8`, `SXC-3`, `SID-5.8`, `SID-AC-16`.

### `SC-6` — Subjective non-functional requirements

**Draft position.** *"No noticeable delays"*, *"fast loading"*, *"smooth experience."*

**Analysis.** None of these can pass or fail a test, so none can gate a release. An unmeasurable target
is not a weak requirement; it is the absence of one.

**Resolution.** Replaced in full by §5.3: ten operations with p95 and p99 targets, an aggregated-screen
budget with a per-contributor degradation timeout, availability targets differentiated by consequence,
a scalability envelope with design headroom, and required observability signals. `SID-5.19` adds that
where a target cannot yet be measured, the measurement capability must be built before the target is
claimed as met.

`SID-5.20` closes the obvious loophole: no latency target may be met by caching an authorisation
decision, copying another context's data, or relaxing the allow-list.

Requirements: `SID-5.18` … `SID-5.40`, `SID-AC-26`.

### `SC-8` — Invented role names

**Draft position.** Referred to actors such as "Library Admin", "Staff" and "Student User".

**Conflicting authority.** `AUTH-7.21` defines a **closed** role set: `TR-1` Owner, `TR-2` Manager,
`TR-3` Reception, `TR-4` Student, `TR-5` Parent, plus Platform Administrator.

**Analysis.** A second vocabulary for the same concept guarantees divergence. Whichever document is read
second will be implemented wrongly.

**Resolution.** Every actor reference now uses the Authentication set. `SID-5.4` states that this
document introduces no role name, and `SID-AC-19` makes that testable against the implementation.

### `SC-11` — Weak invariants

**Draft position.** Invariants stated as intentions — *"should be unique"*, *"is normally private."*

**Resolution.** §5.4 states 14 invariants as conditions true at **every observable moment**, each with
its enforcement mechanism named. `SID-5.42` requires each to have an automated test that fails on
violation, and states that an invariant asserted only in prose is unenforced. `SID-5.43` additionally
requires `SID-INV-1`, `SID-INV-2` and `SID-INV-4` to be watched by continuous integrity counters,
because a constraint that holds in tests can still be violated by a migration.

Strengthened specifically around: one Global Identity (`SID-INV-1`, `SID-INV-2`), one immutable
never-reused UUID (`SID-INV-3`), organisation separation (`SID-INV-6`, `SID-INV-8`, `SID-INV-12`),
ownership boundaries (`SID-INV-5`, `SID-INV-7`), profile privacy (`SID-INV-9` … `SID-INV-11`), photo
separation (`SID-INV-13`) and auditability (`SID-INV-14`).

### `SC-12` — Identity holding a list of organisations

**Draft position.** The identity is *"the parent of all library student records"*, implying it holds
them.

**Conflicting authority.** `ID-2` — `StudentRecordId` never leaves its tenant and *"must not appear in
any Global Student context, event or index."* Enforced today by `banned_symbols` in
`tool/module_dependencies.yaml`.

**Analysis.** The parent–child relationship the draft wanted is real, but the reference must point
**upward** from the tenant-scoped record. If the global identity held the list, a global read would
disclose which libraries a person attends — a cross-tenant privacy leak reachable without any library
authorisation.

**Resolution.** Reference direction is downward only: a Student Record holds a non-nullable `PersonId`;
the identity holds no collection. `SID-4.19` goes further — this module must not be *capable* of
answering "which libraries does this person attend?"

Requirements: `SID-1.38`, `SID-4.16`, `SID-4.17`, `SID-INV-8`, `SID-INT-12`, `SID-AC-15`.

---

## 5. Medium and low-severity conflicts

### `SC-9` — Duplicated acceptance criteria

Acceptance criteria appeared in several chapters, in overlapping and slightly divergent wording. Where
two copies of a criterion disagree, neither is authoritative and the module cannot be signed off.

**Resolution.** One register: `SID-AC-1` … `SID-AC-26` at §5.6. `SID-5.47` states it is the module's only
acceptance register and that any acceptance statement found elsewhere in the document is an editing
error. `SID-5.49` blocks completion by satisfying 25 of 26.

### `SC-10` — Configurable values inline in prose

Numbers such as username length, cooldowns and photo size limits were embedded in requirement text,
where changing one means editing the PRD and where no range or default is visible.

**Resolution.** All 11 moved to the `SCFG-1` … `SCFG-11` register at §5.5, each with default, permitted
range and notes, read through typed accessors owned by `BC-25`. §5.5 opens with the rule that makes the
register meaningful: *every other number in this document is a requirement, not a setting.* `SID-5.44`
prevents configuration from changing the privacy default, altering the allow-list, disabling an audit
event, or setting the released-username hold period to zero in production.

---

## 6. Rejected review findings

Two findings raised during review were **rejected**, and the draft's original intent was preserved. Both
rejections are architectural, not editorial.

### 6.1 `SC-7` — Rejected: "make gender a mandatory field for completeness"

**The finding.** Profile completeness should require gender, so that the aggregated screen and future
analytics have a complete dataset, and so that `Pending Profile → Active` has an unambiguous test.

**Why it was rejected.** Data minimisation (`SID-5.7`) says a field is collected because it is needed,
not because it makes a dataset tidy. Nothing in the platform requires gender: not authentication, not
membership, not attendance, not seating, not finance. It was wanted for analytics — which is not a
lawful basis for compelling disclosure, and analytics is `BC-26`'s concern, not a reason to change what
a person must reveal about themselves in order to use a library.

There is also a concrete harm. Making the field mandatory forces a person into a category that may be
wrong for them before they can use the product they have already paid for. "Complete dataset" is a
convenience for the platform; the cost is borne entirely by the user.

**What was preserved.** The draft's intent — gender **optional**, with "prefer not to say" — is kept, and
its absence does not block profile completion.

Requirements: `SID-2.7`, `SID-5.10`.

### 6.2 `SC-13` — Rejected as scoped: "Global Identity is a social profile; gate it behind social opt-in"

**The finding.** Since the visible benefits of a global identity are social — usernames, public profiles,
discovery — the identity should be created on social opt-in and treated as belonging to the social
product. This is the position the Bounded Context Map and Master PRD held before this review, so the
finding was well-supported by written authority.

**Why it was rejected.** The authority was correct about the *observable* benefits and wrong about the
*reason the identity exists*. Three consequences make the position untenable:

1. **It makes `ID-5` unsatisfiable.** Account erasure must delete the account, anonymise the person, and
   **retain** organisation financial and attendance history pseudonymised under legal basis. If the
   person may never exist, there is no stable anchor to anonymise, and either the history is destroyed —
   breaching retention obligations — or it is retained fully identified, breaching erasure.
2. **It couples the paying product to the unpaid one.** If the identity exists because of social
   features, then School, College and Coaching products (`MP-FUT-02` … `MP-FUT-04`) inherit a social
   dependency they have no use for, and a person who never opts into social has no permanent identity
   across them. That forces an identity migration later — the single outcome `ADR-0011` exists to
   prevent.
3. **It inverts the risk.** `X-05` warns that *"a social outage takes down the paying product."* Making
   the identity social-owned builds that coupling in by construction.

**What replaced it.** The owner's decision: the identity is the permanent identity for the entire
education ecosystem, and *"Student Network is only a consumer of Global Student Identity. Social features
must never become the reason Global Student Identity exists."*

**What was preserved from the finding.** Its factual observation — that the user-visible surface of the
identity is largely social in V1 — is accepted and reflected in the PRD. Username, public profile and
discovery all remain. Only the ownership claim was rejected.

`SID-4.31` makes the rejection falsifiable rather than rhetorical: **deactivating, disabling or never
launching the social product must not affect the existence, validity or usability of any identity.** If
switching off the social product breaks identities, this boundary has been violated and the code is
wrong, not the document.

Requirements: `SID-1.4`, `SID-4.28` … `SID-4.34`, `SID-5.50`, `SID-5.51`.

---

## 7. Findings raised and closed without conflict

These were review observations that the draft had simply not addressed. They are recorded so that
nobody re-raises them as gaps.

| Observation | Where addressed |
|---|---|
| Photo independence was asserted but not enforced | `SID-4.37`, `SID-INV-13`, `SID-AC-12`, `SID-AC-13` |
| Public visibility had no closed field list | Allow-list `SID-2.28`; never-public list `SID-2.29` |
| Trust & Safety enforcement scope was undefined | `SID-4.32`, `SID-4.33` — projection only, never lifecycle |
| Composition failure behaviour was undefined | `SID-2.40`, `SID-5.24`, `SID-5.40`, `SCFG-9`, `SID-AC-25` |
| Duplicate feedback could enumerate registered numbers | `SID-2.37`, `SID-4.41` |
| Username reuse could enable impersonation | `SID-2.24`, `SCFG-5`, `SEV-6`, `SID-AC-11` |
| Domain events were not enumerated | `SEV-1` … `SEV-16`, closed by `SID-4.51` |
| Forbidden integrations were implied, not listed | `SID-INT-1` … `SID-INT-12`, each with a detection method |
| Backup restore could silently un-publish or re-publish | `SID-5.29` |
| Degraded sections could render as "0" rather than "unavailable" | `SID-5.40` |

---

## 8. Downstream changes required by this reconciliation

| Document | Change | Reason |
|---|---|---|
| `LIBOORA_BOUNDED_CONTEXT_MAP.md` → v1.3 | `BC-10` row, §4 Identity Triad, `ID-4` nullable → non-nullable, §5 collisions, `E-13`, `Q-05` closed | `SC-1` |
| `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` | Rank 7.5 tier; Social cluster shrinks to `BC-11` … `BC-13`; `X-05` note | `SC-1` |
| `tool/module_dependencies.yaml` | Add `domain/person: 7.5`; remove `identity` from `domain/social`; banned symbols; permit `domain/library` → `domain/person` | `SC-1`, `SC-12` |
| `MASTER_PRD.md` → v1.7 | Module registry row 2; `PersonId` row *(line 310 — stale)*; `BC-10` tenancy row; `Q-05` closed | `SC-1` |
| `DOCUMENTATION_BASELINE.md` | `BASELINE-2026-08-04`; third Rank-3 module baseline; ADR range → `ADR-0011` | New baseline |
| `ADR-INDEX.md` | 10 → 11 ADRs | `ADR-0011` |
| `TRACEABILITY_MATRIX.md` → v1.2 | Student Identity register prefixes (§2B), chapter map (§3B), configurables (§6B), events (§7B), **existing-code divergence (§8A)** | Deliverable 4, `SC-14` |
| `DEFINITION_OF_DONE.md` | Student Identity gate checks and closed registers | Deliverable 4 |
| `STUDENT_IDENTITY_IMPLEMENTATION_TASKS.md` | **`IMPL-207`, `IMPL-208` added** — migrate `GlobalStudentProfile`, make both `personId` fields non-nullable | `SC-14` |

`Q-05` — *"Is Global Student available to a person with no library enrollment?"* — is **closed: yes,
necessarily.** The identity exists from account creation, so the question can no longer arise. The
recommendation recorded against `Q-05` (*"yes, but with a reduced trust tier until enrolled"*) is
**not** adopted: a trust tier is an authorisation concern owned by `BC-18`, and implementing it here
would mean this module evaluating authorisation, which `SXC-7` and `X-13` forbid.

---

## 8A. `SC-14` — Existing code implements the superseded model

**This finding was not in the review panel's report.** It was found by verifying the traceability matrix
against the codebase rather than against the documents, and it is recorded separately from `SC-1` … `SC-13`
because it is not a defect in the PRD — the PRD is correct. The **code** predates the decision.

| Artefact | Location | State | Contradicts |
|---|---|---|---|
| `PersonId` doc comment | `packages/liboora_contracts/…/identifiers.dart:61` | *"the cross-library **social persona**… **May legitimately not exist**"* | `ADR-0011`, `SID-2.1` |
| `Account.personId` | `lib/platform/identity/identity.dart:43` | **Nullable**, *"an account may never opt into the social product"* | `SID-INV-1` |
| `StudentRecord.personId` | `lib/domain/library/enrollment/…/student_record.dart:53` | **Nullable**, *"the consented social bridge"* | amended `ID-4`, `SID-4.17` |
| `GlobalStudentProfile` | `lib/domain/social/social.dart` | Global identity aggregate living **inside `domain/social`** at rank 8 | `SID-4.1`–`SID-4.3` |
| Seed accounts | `lib/bootstrap/seed.dart` | **1 of 5** accounts has a `personId` | `SID-INV-1` |

**Disposition: accepted as a migration task, not resolved here.**

The code is a faithful implementation of the architecture as it stood before `ADR-0011` — nullable,
opt-in, social-owned. It was correct when written. `ADR-0011` made it wrong. That is the normal
consequence of an architecture decision landing after a scaffold, and the honest response is to record
the divergence and schedule it, not to quietly patch a domain aggregate during a specification review.

Three reasons for not changing the code in this pass:

1. **Authority.** The instruction governing this work was to reconcile the specification. Relocating
   `GlobalStudentProfile` from `domain/social` to `domain/person` and changing two field types from
   nullable to non-nullable is an implementation change with test consequences across
   `lib/bootstrap/di.dart`, `lib/bootstrap/seed.dart` and every null branch downstream.
2. **The seed data cannot be fixed by fixing the seed data.** Four of five demo accounts have no
   identity. Editing them to add one would make the integrity counter pass while leaving a
   release-blocking demo surface in place (`MP-CON-11`, `TASK-D10`). The correct fix is deleting the demo
   accounts and creating identity on the real account path — a different task with a different owner.
3. **A half-done migration is worse than an undone one.** Building `domain/person` while
   `GlobalStudentProfile` still lives in `domain/social` would leave **two** global identity aggregates
   in the codebase, which is exactly what `SID-5.51` says must be rejected. `IMPL-207` is therefore
   sequenced *before* `IMPL-202`.

**The manifest was updated and the code was not, and that asymmetry is deliberate.**
`tool/module_dependencies.yaml` now declares `domain/person: 7.5` and has removed `identity` from
`domain/social`'s context list. So the manifest currently describes an architecture the code does not
implement. That is uncomfortable and it is the right way round: the manifest is the statement of intent
that the boundary checker will eventually enforce, and reverting it to match the code would mean encoding
the superseded model as the target. The divergence is recorded in `TRACEABILITY_MATRIX.md` §8A so it
cannot be mistaken for an oversight.

**It is currently unenforced in both directions.** `tool/check_module_boundaries.dart` does not exist
(`IMPL-014`), so nothing fails the build either for the code's non-conformance or for any future
violation of the new rules. Per `SID-4.56`, an unenforceable rule is counted as unmet.

---

## 9. Verdict

| Question | Answer |
|---|---|
| Functionality removed? | None |
| Document simplified? | No — expanded, with subjective statements replaced by measurable ones |
| Product redesigned? | No — one ownership boundary corrected, capability set unchanged |
| Conflicts found | 13 from the review panel, **+1 found by code verification** (`SC-14`, §8A) |
| Accepted | 11 of 13, plus `SC-14` accepted as a migration task |
| Rejected, architecture preserved | 2 — `SC-7` §6.1, `SC-13` §6.2 |
| Code changed | **None.** `SC-14` is scheduled as `IMPL-207` and `IMPL-208`, not patched |
| Blocking conflicts remaining | 0 |
| Open questions closed | `Q-05` |
| Linkage rules `ID-1` … `ID-6` | Preserved unamended |
| Prohibition `X-05` | Preserved unamended |
| Dependency laws `L1` … `L5` | No exception created; rank 7.5 keeps `L2` intact |
| Role names invented | 0 |
| Context count | Unchanged — 31 total, 23 in V1 |

The module is specified. It is **not** implemented: no Student Identity code exists, and
`STUDENT_IDENTITY_IMPLEMENTATION_TASKS.md` (`IMPL-200`+) states what remains.
