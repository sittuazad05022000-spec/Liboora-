# ADR-0129 — Google Sign-In is the V1 primary authentication method; Mobile OTP is re-scoped to V2

| Field | Value |
|---|---|
| **ADR** | `ADR-0129` — ⭐ **next free, measured immediately before creation**: 116 ADR files, highest allocated identifier `ADR-0128`, `ADR-0129` referenced **0** times across `docs/`, `tool/`, `lib/`, `test/` and `.github/`. ⚠ The identifier gaps at `ADR-0066`…`ADR-0074` and `ADR-0088`…`ADR-0090` are **allocated, not free** (measured: 21, 4, 14, 43 and 34 citing files respectively) and are **NOT reused** — `ADR-INDEX.md` **L206**: *"Number sequentially. **Never reuse a number.**"* |
| **Status** | ⭐ **Accepted** — 2026-09-10. Promoted `Proposed` → `Accepted` in a **separate governed acceptance act**, under the same one-act conferral, with **no substantive change**: the decisions, requirements, architecture, scope and wording recorded here are **byte-unchanged** from the drafted text and only this status cell moved. *(Prior text retained verbatim: "⚠ **PROPOSED** — 2026-09-10. ⛔ **NOT Accepted by this drafting act.** This document records decisions already taken under a one-act conferral; its promotion to `Accepted` is a **separate governance step**".)* ⛔ **Acceptance executes nothing** — every consequential amendment in §6 and every supersession in §7 remains **outstanding** and requires its own governed act |
| **Deciders** | ⭐⭐ **Architecture Owner + Product Owner, JOINTLY, with Privacy Owner sign-off.** Three offices because the act has three limbs: **scope/priority** is Product's (`PRD_OWNERSHIP_MODEL.md` **L83** — *"Business intent: scope, priority, acceptance"*), **boundaries/ranks/edges** are Architecture's (**L85** — *"ADR approval; any Rank 1–5 document change"*), and **minor-inclusive data flows** are Privacy's (**L353**). ⛔ **All three offices are recorded VACANT as constituted** (**L355–356**: *"No personal name is recorded, per §7 rule 4. The role is vacant as constituted"*); authority was conferred **for this one act only** by the human principal, and **expires when this act is recorded** — `ADR-0033` §7.1: *"A conferral for one act is not a standing licence"* |
| **Supersedes** | ⚠ **`ADR-0002`** (Mobile OTP as the sole V1 authentication factor) — **REQUIRED, NOT YET EXECUTED**, see §7. ⚠ **`ADR-0005`** (Account creation on first OTP) — **consequential supersession REQUIRED, NOT YET EXECUTED**, see §7 |
| **Amends** | ⛔ **NOTHING IN THIS ACT.** This drafting act creates exactly **one** file — this ADR — and modifies **zero** other repository files. The amendments this decision necessitates are recorded in §6 as **consequential successor-document work**, to be executed in **separate governed steps** |
| **Amended by** | — |
| **Baseline** | ⚠ **A NEW BASELINE IDENTIFIER WILL BE REQUIRED** when the §6 amendments execute — `DOCUMENTATION_BASELINE.md` §7 **rule 4**: *"The baseline identifier changes only when a Rank 1–3 document changes version."* Both `MASTER_PRD.md` (Rank 1) and `Authentication_PRD_v2.md` (Rank 3) change version. ⛔ **No baseline is created or re-issued by this drafting act — `BASELINE-2026-09-03-A` STANDS** |
| **Closes** | ⭐ `P-1` · `U-1` · `A-1`…`A-8`, `A-10`…`A-16` · Privacy Owner sign-off — **as recorded decisions**. ⛔ It closes no blocker and no implementation gate |
| **Does NOT close** | ⛔⛔ **`MP-DEP-03`** · **`BLK-01`** · **`BLK-02`** · **`TASK-D10`** · **Gate 3** · **H1**/**H2**/**H3**/**H4** · **D3** · ⛔ **`A-9` secret custody** (expressly outside the conferral) · ⛔ implementation, dependencies, schema, API, UI, tests, configuration, secrets |
| **Related** | `ADR-0002` (superseded — §7) · `ADR-0005` (consequential supersession — §7) · `ADR-0011` (`PersonId` atomicity — **PRESERVED**) · `ADR-0063` (privileged obligations are *layered on* the mechanism — §5) · `ADR-0079` §8.5 (append-not-insert doctrine, to govern the §6 PRD work) · `ADR-0127` (`E-32`, ⛔ **not reopened**) · `ADR-0128` (`E-33`, ⛔ **not reopened, not amended**) · `ADR-0124` (backend runtime) · `ADR-0126` (`platform/integration` module block) · `MASTER_PRD.md` **L309**, **L319**, **L379**, **L522**, **L535** · `Authentication_PRD_v2.md` (Rank 3, frozen) |

---

## 1. Context

Liboora's V1 authentication is currently **Mobile Number + OTP as the sole factor**, fixed at Rank 1 and elaborated across a frozen Rank-3 PRD:

- **`MP-GBR-25`** (`MASTER_PRD.md` **L379**) — *"**Mobile OTP is the sole authentication factor in V1.** There are no passwords."*
- **`MP-CON-11`** (**L522**) — *"Mobile OTP is the sole V1 authentication factor. No passwords, **no social login**, no demo or guest accounts in any release build."*
- **`ADR-0002`** (`Accepted`) — *"**Mobile number plus a one-time code is the sole authentication factor in V1.**"*

`ADR-0002` considered and rejected federated sign-in by name: *"**Social login in V1** — Rejected because: Adds third-party dependency and consent complexity for **a minor-heavy user base**."* The Authentication PRD §3.4 rejected **Google Sign-In** specifically: *"Adds an external identity provider dependency and a second account-linking model, for a population with **inconsistent Google account usage**."*

The Product Owner has now decided to change that direction. This ADR records the change and every architectural, privacy and governance consequence established during its evaluation.

⚠ **This ADR does not make the change. It records the decision and enumerates the work the change requires.**

---

## 2. Decisions recorded

### 2.1 `P-1` — Product Owner

⭐ **APPROVED: Google Sign-In becomes the primary V1 authentication method; Mobile OTP and mobile verification are re-scoped to V2.**

- **V1 MUST have:** Google Sign-In · Google OIDC · immutable Google `sub` as provider identity · Liboora `AccountId` as canonical internal identity.
- **V1 MUST NOT require:** mobile number · mobile-number verification · Mobile OTP · SMS OTP.
- ⭐ **Mobile OTP is NOT permanently removed.** Its V2 purpose, optionality, expansion or eventual removal is **UNDECIDED** and requires a **separate future Product + Architecture decision**.

### 2.2 `U-1 = B` — the `AUTH-3.22` identity anchor is removed

`AUTH-3.22` currently reads: *"Every account **MUST** retain a verified mobile number as its identity anchor, irrespective of any additional method added later."*

⭐ **DECIDED: REMOVE.** The verified mobile number is **not** the V1 identity anchor.

⚠ This is the load-bearing decision. It was taken **first and deliberately**, because a prior conferral attempted to approve Google-first V1 while deferring it — an **unsatisfiable** combination, since `AUTH-4.4`, `AUTH-4.16` and `AUTH-4.17` make a verified mobile number a **precondition of account creation**, and `AUTH-3.15` makes OTP the only V1 verification mechanism. That conflict was reported before any modification and resolved by this decision.

### 2.3 Identity model

```
Google Account → OIDC validation → immutable `sub`
    → BC-18 provider identity
    → Liboora AccountId    ⭐ CANONICAL, permanent, non-reusable
    → BC-10 PersonId       (atomic — ADR-0011)
    → Tenant / Role / Membership
    → Business & payment records
```

| ID | Decision | Status |
|---|---|---|
| `A-3` | `AccountId` remains the immutable canonical internal identity | ✅ **PRESERVE** — `AUTH-4.19`: *"MUST be permanent and MUST NOT be reused after deletion"* |
| `A-4` | Google OIDC **`sub`** is the provider identity key | ✅ **CHANGE REQUIRED** (new rule) |
| `A-5` | `PersonId` remains `BC-10`-owned, created atomically with the Account | ✅ **PRESERVE** — `ADR-0011`, `MASTER_PRD.md` **L310** |
| `A-6` | Credential and provider identity remain inside `BC-18` | ✅ **PRESERVE** — `MP-GBR-27`: *"No context outside `BC-18` may store a password, OTP, session or credential"* |
| `A-12` | Uniqueness keyed on immutable `sub`: one `sub` → **at most one** `AccountId` | ✅ **CHANGE REQUIRED** — replaces `AUTH-4.1` |

⛔⛔ **PROHIBITED ABSOLUTELY.** Google **email**, profile data or display name **MUST NOT** become: the canonical identity · `AccountId` · `PersonId` · the payment identity · a uniqueness key · an automatic matching key. `AccountId` **MUST NOT** be derived from Google `sub` **or** from email. A revoked or deleted `sub` **MUST NOT** be reused as an `AccountId`.

### 2.4 Boundaries — `A-7`, `A-8`

**`A-8` — the port.** ⛔ **`platform/integration:sso_provider` MUST NOT be widened or reused for Google federated identity.** Its own declaration scopes it narrowly — `tool/module_dependencies.yaml` **L437–439**: *"The single sanctioned bypass of `platform/communication`, **for possession challenge delivery only**. Matrix cell IAM -> INT."* `ADR-0128` §2.2 already recorded that *"the port carrying the OTP is named `sso_provider`, while its own comment scopes it to 'possession challenge delivery only' — **the name does not describe the function**"*, and its §7 records that the `sso_provider` **rename was refused** as outside that conferral.

⭐ **A sibling port — working name `platform/integration:identity_provider` — is the architectural direction.** Rationale: the two functions are **opposites**. `sso_provider` carries an **outbound** message the platform itself generated; federated identity validates an **inbound** assertion generated by an external issuer whose signature, `iss`, `aud` and `nonce` must be verified. Their failure modes differ in kind — *message undelivered* versus *identity forged*. Naming is convention-consistent with the four existing sibling ports (`connector`, `payment_gateway`, `model_provider`, `sso_provider`).

**`A-7` — the edge.** ⭐ **Google federated identity requires a NEW, distinct BC Map edge.** The context-pair `BC-18 → BC-31` exists, but only as **`E-33`**, whose register row (BC Map **L1108**) scopes it to *"**The V1 OTP / possession-challenge transport**"* and whose ratification (`ADR-0128` §2.1) is purpose-bound. BC Map **L292** is decisive: *"If an edge is not in this table, it **does not exist** and adding it requires an ADR."*

⚠ **A counter-argument was tested and recorded rather than suppressed:** the edge register is presently **pair-grained** — measured **31 edges across 31 distinct context-pairs**, i.e. no pair currently carries more than one edge. On that convention alone the pair could be said to be "covered". **Purpose-scoping overrides it**, on the repository's own precedent: BC Map **§20.2** records that `BC-31` already holds *"**two** inbound edges from platform contexts, and they are **deliberately distinct**"*, warning that *"**Collapsing them would breach four rules**."*

⛔ **NO EDGE IDENTIFIER IS ALLOCATED OR RESERVED BY THIS ADR.** The highest allocated edge is `E-33`; `E-34` measured **0** occurrences and is therefore an **unallocated candidate number only — not an existing edge and not reserved here**. Allocation must be re-measured immediately before minting. `E-27` remains permanently vacant; `E-31` remains reserved for `PRD-021C`/`TSF-GAP-009`.

### 2.5 Account loss and provider revocation — `A-10`, `A-11`

**`A-10` — no V1 recovery path.** ⭐ A user who permanently loses access to their Google account has **no V1 self-service authentication recovery path**, and may become **permanently unable to authenticate** to their existing `AccountId` during V1. This is an **explicitly accepted V1 product limitation, not an implementation defect**. Recovery is **deferred to V2** and requires a separate Product + Architecture decision.

⛔ **NOT reintroduced:** Mobile OTP · mobile verification · SMS OTP · verified-mobile recovery · any other V1 factor. ⛔ **NOT invented:** administrative account takeover · guardian recovery · email recovery · passkey recovery · alternate IdP · manual support recovery · identity-proofing workflow.

**`A-11` — successor account state.** A state-model check was mandated before accepting any existing state, and **it failed for every one of them**:

| State | Why it cannot be used |
|---|---|
| `Suspended` | *"a **deliberate**, reversible **administrative bar applied by a platform role**"*; `AUTH-9.10` makes it *"reversible **only by a platform role**"* — under `A-10` nothing would ever lift it, stranding accounts *"pending review"* indefinitely |
| `Active` / `Inactive` | `AUTH-9.8` **permits authentication** in both — false for this condition |
| `Locked` | *"principally exhaustion of the **OTP** request quota"*, self-clearing — ⛔ OTP-specific; reusing it would reimport OTP semantics into V1 |
| `Disabled` | Closest structural fit (permanent; *"records must be preserved"*) but *"a **deliberate**… administrative bar… where the platform has **concluded** the account must not be used again"* — imputes a judgement the user has not earned |
| `Deleted` / `Pending Deletion` | ⛔ Excluded — automatic deletion is prohibited |

⭐ **Root cause:** every non-authenticable state in the model is entered by **deliberate administrative act**, because the mandatory mobile anchor made blameless permanent credential loss impossible. `U-1 = B` created a condition the state machine was never designed for.

⭐ **DECIDED: a successor state is required.** Working name **`Unlinked`** — ⚠ *provisional; to be confirmed at the amendment step*.

> **`Unlinked`** — a **system-triggered, non-punitive** state entered when an account's **sole** authentication provider identity becomes **permanently invalid** through deletion or revocation of the external provider account. The account, its identifier, its person and all business records **continue to exist and are fully preserved**. The holder has **no currently valid provider through which to authenticate**. The state carries **no imputation of wrongdoing**, involves **no administrative judgement**, and is **not** subject to administrative review.

⚠ **The name "Orphaned" was proposed and REJECTED on repository evidence.** Measured **24** true occurrences of `orphan`/`orphaned`, including `ADR-0011` **L63** and `Student_Identity_PRD_v1.md` **L244**, both of which use it in the identity diagram: *"`AccountId` … **1 ──── 1** mandatory, created together, **never orphaned**."* In existing terminology *orphaned* denotes a **dangling record** — the very condition `ADR-0011` guarantees cannot occur. Naming an intact, fully-preserved account "Orphaned" would state something false about an Accepted ADR.

**Permanence:** ⭐ **permanent under V1** — `A-10` establishes no V1 exit exists. ⛔ **Not terminal like `Deleted`** (`AUTH-9.12`: *"MUST NOT be reversible by any means"*), because a **future** re-link decision is expressly contemplated. ⭐ This does **not** decide that future re-linking is permitted; it declines to make it impossible.

**Transitions.** *Allowed in:* `Active → Unlinked`, `Inactive → Unlinked`, on permanent invalidation of the sole provider identity. *Allowed out:* ⛔ **none in V1**. *Disallowed:* automatic `→ Deleted` · `→ Active` by platform-role action · `→ Active` by automatic re-link · self-clearing · `→ Suspended`.

**Preserved on provider loss:** `AccountId` **survives** (permanent, non-reusable — `AUTH-4.19`) · `PersonId` **survives** (`ADR-0011`) · business and payment history **survives** — `MP-GBR-04`: *"Account deletion… does **not** delete StudentRecord financial and attendance history, which is retained under legal basis and pseudonymised."* Sessions terminate **immediately and globally** — `AUTH-11.66`, `AUTH-6.26`.

⛔ **AUTOMATIC RE-LINKING IS PROHIBITED** — not on same email, display name, profile information, or any other mutable Google attribute. Any future re-link mechanism is a **separate Product + Architecture decision** requiring an explicitly approved identity-proofing/linkage rule. ⚠ Measured: **no existing repository rule governs provider re-linking** — a genuine gap, recorded not filled.

### 2.6 Roles — `A-13`, `A-15`

⭐ **Authentication method is universal. No role receives an exception.** `AUTH-3.18`: *"The method **MUST** behave identically for every account, in every library, **for every role**. No category, role, tenant, region or **device** may alter method behaviour."* `AUTH-3.19`: *"The method is a platform property, never a tenant setting."* ⭐ Both are **method-agnostic and require no amendment**.

**`A-13` — Reception (`TR-3`).** Google-only V1 authentication, identically to every other role. ⭐ `AUTH-3.18` already names **"device"** as a prohibited basis for method variation, so the shared-desk scenario is governed without amendment. Shared-device handling is a **session/device concern governed separately** — `AUTH-6.2` (*"Every session **MUST** be bound to exactly one account, one device and one active library"*), `AUTH-6.19` (staff sessions use shorter limits), `AUTH-6.30`–`6.33`. Sequential individual authentication on shared hardware is conceptually permitted; ⛔ no mechanism is specified here.

⛔⛔ **A shared or generic "Reception account" is PROHIBITED** on four independent grounds: `GP-11` (*"identifying **actor**"*) · `AUTH-6.2` (one account per session) · *"**One person, one identity, for life on the platform**"* · `TR-3` roles are assigned per person by an Owner or Manager. ⛔ Never: device identity as `AccountId` · a shared Google account across staff · email matching · recovery Gmail as authentication.

⚠ Residual risks **recorded, not resolved**: persistent sessions on shared hardware; per-account device records for shared hardware (`AUTH-6.32`: *"A device record belongs to **the account**"*).

**`A-15` — Platform Administrator (`PR-1`) and Platform Support (`PR-2`).** Google-only V1 authentication. ⛔ **No alternate or additional V1 factor.** All existing privileged controls **remain additionally required and enforced unchanged**: strictest `PR-1` session limits · `AUTH-6.19` · complete action attribution · separation of duties · ⛔ `PR-1` cannot approve its own elevation · `PR-2` time-bounded elevation recording requester, approver, tenant, purpose and expiry, auto-terminating at `CFG-12` (1 hour) · ⛔ `PR-2` *"cannot access authentication factors or session secrets"* — ⭐ this now extends to **Google tokens** · `AUTH-2.5` · `AUTH-6.34`.

⭐ **A second factor is REFUSED for V1**, on the repository's own authority. `ADR-0063` ruled that such an obligation is *"a SECURITY-platform obligation **layered on `BC-18`'s existing mechanism. It is not an authentication requirement.**"* and refused a second factor *"absolutely"*. The PRD records *"Single factor | Possession alone; **no second factor in V1**"*, and lists *"Second factor for elevated roles"* as a **roadmap** item. ⛔ **A privileged security control has not been converted into a second authentication factor.**

**Separation:** only the **authentication method** changes. Authorization, elevation, session security and device controls are method-agnostic and are **not** disturbed. Elevation is **approval-based**, not re-authentication-based.

### 2.7 Scope exclusions — `A-14`, `A-16`

**`A-14` — minors.** ⭐ **V1 scope exclusion ACCEPTED**: *"V1 scope exclusion accepted for minor users who cannot independently use an eligible Google account; no alternative authentication mechanism is introduced."*

Three options were tested against evidence. (1) *Google-first covers minors* — ❌ every student needs their own account (PRD §2.2.1: *"**Self-registers**… or **claims** a record"*), and `ADR-0002` records *"Students are frequently minors."* (2) *An existing guardian mechanism can be reused* — ❌ **measured**: `GuardianLink` (`SM-4.4`, mandatory under 18) is an **enrollment** mechanism with **0** authentication/login/session/credential co-occurrences; Parent *"Registers independently with their own mobile number"*; `ADR-0085` §5 mandates *"an explicit parent→student **relationship/link** model"* — a link, not delegated login; **0** guardian-login, delegated-identity or proxy-account models exist. (3) *Accept the exclusion* — ✅ **this is the position**.

**`A-16` — users without Google accounts.** ⭐ **Exclusion ACCEPTED**: *"Users without an eligible Google account are outside V1 authentication scope and deferred to V2; no V1 fallback is introduced."* ⛔ Establishing another V1 authentication path was **rejected** — it would have required re-deciding `P-1`.

⚠ **Recorded without softening:** the repository's own market evidence weighs against these exclusions — PRD §3.4 cites *"a population with **inconsistent** Google account usage"*; `ADR-0002` records *"**essentially every** user has a mobile number that they already treat as their identity"*; `MP-ASM-01` warns that *"a fallback factor becomes a V1 blocker."* **The decisions were taken with that evidence in view.**

⛔ Existing guardian/parent relationship, consent, enrollment and linkage records remain **unchanged** and **MUST NOT** be interpreted as delegated authentication or proxy login.

---

## 3. Privacy Owner sign-off

⭐ **APPROVE WITH CONDITIONS** — Google-first V1 is privacy-compatible with the minor-inclusive architecture and the `A-14` scope exclusion, subject to conditions **C-1**, **C-2**, **C-3**. **No condition is a blocking privacy conflict.**

⭐ **Central finding: enrollment and authentication are already separated, so the exclusion does not remove minors from the platform.** `XC-4.2`: *"**Student record exists without an account** — The record remains unclaimed and inert. It confers nothing until claimed. **Library staff may continue to operate on it**; the person simply has no access."* Attendance, seating and membership continue to function for an enrolled minor who cannot authenticate.

⭐ **Privacy-positive consequence:** such a minor holds **no Liboora account**, so Authentication stores **no personal data** for them. Their footprint stays within the library's enrollment record under existing governance. **The exclusion reduces minor personal-data processing rather than increasing it.**

**Identity boundaries confirmed — no cross-person substitution.** Authentication (`Google sub → BC-18 provider identity → AccountId → PersonId`) and relationship (`Student ←GuardianLink→ Parent`) are structurally separate: *"The parent–student link itself is established by **Enrollment**. Authentication **consumes** the link when evaluating access; **it does not create, modify or interpret it**."* ⛔ A parent's Google identity is **never** the student's identity. ⛔ No delegated or proxy login is introduced. ⭐ Guardian-assisted authentication remains **unresolved in the repository** and is **future governance, not a V1 feature**.

**Data minimisation.** `sub` — necessary and permitted (opaque, stable). Google **email** — ⛔ not an identity or matching key; ⚠ **recommended not to persist at all**; `email_verified` not trusted for identity. Display name — permitted. **Recovery Gmail** — ⛔ **Google-side recovery only; MUST NOT be collected or persisted** as a Liboora recovery identity, re-link key or authentication method. Mobile number — ⭐ **no longer required for V1 authentication**, so collecting it *for authentication* would now be excess. Guardian identity — unchanged; `MP-GBR-05` and `SM-INV-3` continue to apply.

⭐ Net effect: Google-first **removes** a mandatory personal attribute and **adds** one opaque identifier — **directionally data-minimising**.

**Preserved unamended:** `AUTH-11.24` (⭐ Google tokens and `sub` must not appear in observability data) · `AUTH-11.37` (jurisdiction) · `MP-GBR-34` · `MP-GBR-05` · `SM-INV-3`.

---

## 4. What this ADR does NOT authorise

| Category | Authorised here? |
|---|---|
| **Implementation** | ⛔ **NO.** 0 code, dependency, schema, API, UI, test or configuration files |
| **`A-9` secret custody** | ⛔ **NO — EXPRESSLY OUTSIDE THE CONFERRAL.** `ADR-0115` §8.1 is `BC-30`-scoped and `ADR-0124` did **not** widen it to authentication. ⚠ **Requires its own separate conferral**, and it blocks implementation |
| **OAuth client registration / secrets** | ⛔ **NO** credential, client secret, token, rotation policy or vault configuration |
| **BC Map / edge** | ⛔ **NO** edge created, allocated, minted or reserved; ⛔ **`E-34` NOT reserved** |
| **Manifest / port** | ⛔ **NO.** `identity_provider` is **not** created; `sso_provider` is **byte-unchanged** |
| **`ADR-0128` / `E-33`** | ⛔ **NOT reopened, NOT amended.** OTP/possession-challenge semantics **preserved** |
| **`ADR-0127` / `E-32`** | ⛔ **NOT reopened.** Push/FCM egress unaffected |
| **Any PRD amendment** | ⛔ **NO.** `MASTER_PRD` and `Authentication_PRD_v2` are **byte-unchanged** |
| **Baseline** | ⛔ **NO** baseline created or re-issued |
| **V2 OTP purpose** | ⛔ **NOT decided** — future Product + Architecture decision |
| **Future re-linking** | ⛔ **NOT permitted by this ADR** — future Product + Architecture decision |
| **`Unlinked` final name** | ⚠ **Provisional** — confirmable at the amendment step |
| **DLT/SMS blockers** | ⛔ **NONE closed or downgraded** — see §8 |

---

## 5. Preserved rules — each tested individually

| Rule | Status after this ADR |
|---|---|
| `AUTH-4.19` — `AccountId` permanent, never reused | ✅ **PRESERVED** |
| `AUTH-4.20` — not derivable from the mobile number | ✅ **PRESERVED**, ⚠ to be **extended** to `sub` and email (§6) |
| `AUTH-3.18` / `AUTH-3.19` — method uniform across role, tenant, device | ✅ **PRESERVED UNAMENDED** |
| `AUTH-11.66` — revocation immediate and global | ✅ **PRESERVED** |
| `AUTH-11.50` — provider failure must not affect existing sessions | ✅ **PRESERVED** |
| `AUTH-11.51` — providers must be swappable | ✅ **PRESERVED** |
| `AUTH-11.68` — no reusable secret anywhere | ✅ **PRESERVED** |
| `AUTH-6.2` / `6.19` / `6.30`–`6.34` — session and device model | ✅ **PRESERVED** |
| `AUTH-2.5` / `CFG-12` — elevation model | ✅ **PRESERVED** |
| `AUTH-11.24` / `AUTH-11.37` / `MP-GBR-34` | ✅ **PRESERVED** |
| `MP-GBR-04` — financial history survives account deletion | ✅ **PRESERVED** |
| `MP-GBR-05` / `SM-INV-3` — guardian consent, mandatory `GuardianLink` | ✅ **PRESERVED** |
| `MP-GBR-27` — credentials only inside `BC-18` | ✅ **PRESERVED** |
| `ADR-0011` — `PersonId` atomic with Account | ✅ **PRESERVED** |
| `ADR-0063` — privileged obligations layered on the mechanism | ✅ **PRESERVED**, ⚠ flagged for review (§6) |
| ⭐ `MP-CON-11`'s **no-demo / no-guest** limb | ✅ **PRESERVED** — only the *"no social login"* clause changes; `TASK-D10` and Gate 3 depend on the remainder |

---

## 6. Consequential successor-document work — ⛔ NOT PERFORMED HERE

⚠ **Each item below is required by this decision and is deliberately left unexecuted.** They belong to **separate governed execution steps**.

### 6.1 `MASTER_PRD.md` — Rank 1, v1.7 → successor version

| Target | Required change |
|---|---|
| **`MP-CON-11`** (L522) | Remove/re-scope *"no social login"*; ⛔ **RETAIN** the no-demo/no-guest limb |
| **`MP-GBR-25`** (L379) | Re-scope — OTP is no longer *"the sole authentication factor in V1"* |
| **`MP-ASM-01`** (L535) | Re-scope — *"Every user has a mobile number capable of receiving SMS"* is no longer a V1 authentication premise |
| **`AccountId` creation wording** (L309) | *"Created on first successful OTP"* → created on first successful Google authentication |

⚠⚠ **CITATION-COST AUDIT IS MANDATORY BEFORE ANY WRITE.** Measured: **`MP-CON-11` is cited in 40 documents**, **`MP-GBR-25` in 41**, and **106 documents cite `MASTER_PRD.md` by line number**. Edits must be made **strictly in place**, or appended below all live citations — the `ADR-0079` §8.5 append-not-insert doctrine.

### 6.2 `Authentication_PRD_v2.md` — Rank 3, **FROZEN**, v2.0 → v3.0 re-baseline

⚠ **A major version and re-baseline, not an additive amendment** — because `AUTH-3.21` (*"Introducing a method **MUST NOT** require any change to the account model, the role model, the session model or existing accounts"*) is **breached**: the account model changes. This therefore proceeds as **replacement**, not extension. Scale measured: **588 distinct `AUTH-*` requirements**, **152** occurrences of *"mobile number"*, **75** of *"OTP"*.

| Target | Required change |
|---|---|
| **`AUTH-3.22`** | ⭐ **REMOVE** — `U-1 = B` |
| `AUTH-3.13` / §3.4 Google row | **RE-SCOPE**; ⛔ **existing rejection text RETAINED** for traceability |
| `AUTH-3.15` / `3.16` / `3.17` | **Google-first successor wording**; ⛔ `AUTH-3.18`/`3.19` unamended |
| `AUTH-3.20` / `3.21` | **PRESERVE as history** — not applicable to a replacement |
| **`AUTH-4.1`** | Uniqueness re-keyed on immutable Google `sub` (⚠ **13** in-PRD references) |
| `AUTH-4.4` / `4.16` / `4.17` | Account-creation wording — mobile verification no longer a precondition |
| **`AUTH-4.19`** | ✅ **PRESERVE** |
| **`AUTH-4.20`** | **EXTEND** — prohibit derivation from `sub` **and** email |
| `AUTH-6.26` | Add provider revocation as a termination trigger; ⚠ *"mobile number change"* has no V1 subject under `U-1 = B` |
| **`AUTH-9.8`** | Enumerate **`Unlinked`** as non-authenticable; add the state, its summary-table row and a new `AUTH-9.x` governing its permanence |
| `AUTH-11.67` | Re-scope — *"Mobile OTP MUST be the sole authentication factor in the first version"* |
| **`AC-11.18`** | ⚠ **C-1** — *"no personal attribute beyond mobile number and display name"* must admit Google `sub`. **As written, storing `sub` would breach it** |
| **`AUTH-11.31`** | ⚠ **C-1 / C-2** — *"limited to the mobile number and display name"* must admit `sub` and remove the mobile number as a mandatory authentication attribute |
| **New wording** | ⚠ **C-3** — state explicitly that Google email/profile **MUST NOT** be persisted as identity or matching keys, `email_verified` is not trusted, and recovery Gmail is never collected |
| **L951** | *"Single factor \| **Possession alone**…"* — successor wording; ⭐ **retain** *"no second factor in V1"* |
| **L1068** | ✅ **PRESERVE** — *"Second factor for elevated roles"* stays a **roadmap** item |

⭐ **Historical traceability MUST be preserved** — the prior OTP-only V1 decision and §3.4's Google rejection are **retained verbatim**, per established convention.

### 6.3 Architecture

- **BC Map** (Rank 4) — register the new Google federated identity edge; ⛔ identifier re-measured at mint time; ⛔ `E-33` byte-unchanged; record the `§20.2`-style separation and the pair-grained-convention observation (§2.4)
- **`tool/module_dependencies.yaml`** — declare the sibling `identity_provider` port; ⛔ `sso_provider` byte-unchanged
- ⚠ **`ADR-0063` / `SECP-FR-018`** — flagged for review; its reasoning is method-agnostic and appears to survive; ⛔ **not reopened here**

### 6.4 Baseline and registries

- **New baseline identifier** — §7 rule 4 (Rank 1–3 version change); §7 rule 2 (version + changelog same commit) and rule 3 (declaration same commit) apply to each amended document
- `PRD_REGISTRY.md` freeze record · `ADR-INDEX.md` census · `IMPLEMENTATION_BLOCKER_REGISTER.md` — ⛔ **only once real state changes**

---

## 7. `ADR-0002` and `ADR-0005` — supersession required, NOT executed

⛔ **Neither ADR is edited by this act.** `ADR-INDEX.md` **L206**: *"**Never edit an Accepted ADR's decision text — supersede it with a new ADR.**"* **L207**: *"An ADR supersedes; it does not delete. **The superseded record stays readable.**"*

**`ADR-0002`** — *"Mobile number plus a one-time code is the sole authentication factor in V1"* — is **directly contradicted** by `P-1`. It **must be superseded** through the successor mechanism when this ADR is Accepted.

**`ADR-0005`** — *"An `Account` is created at the moment of the **first successful OTP verification** for a mobile number, and at no other moment"* — is **directly contradicted** by `P-1` + `U-1 = B`, under which V1 account creation occurs on **Google authentication, without OTP**.

⭐ **Determination: `ADR-0005` is a CONSEQUENTIAL SUPERSESSION.** It is not an unrelated ADR — it states the very fact `P-1` overturns. ⛔⛔ **Two contradictory Accepted ADR decisions MUST NOT be left simultaneously in an authoritative state.**

⚠⚠ **This would be the repository's FIRST supersession.** Measured: **116 ADRs, 0 superseded, 0 deprecated.** The mechanism is defined (L206–L207) but has never been exercised — the execution step should treat it as untested.

---

## 8. Blockers and dependencies — ⛔ NOTHING CLOSED

⛔⛔ **No blocker is closed, downgraded or re-classified by this ADR.** Re-evaluation may occur **only after** the §6 amendments have actually landed.

| Item | Status | Note |
|---|---|---|
| **`MP-DEP-03`** | 🔴 **OPEN** — Rank 1 | ⚠ *May* become V2-scoped once `MASTER_PRD` successor lands; ⛔ **not yet** |
| **H1 / H2 / H3** | ⬜ NOT STARTED | ⛔ **Not cancelled.** ⭐ H1 (TRAI DLT Principal Entity registration) has the longest external lead time in the programme |
| **H4 / D3** | ⬜ | ⛔ Not cancelled |
| **`BLK-01` / `TASK-D10`** | 🔴 OPEN | `D10-5`…`D10-10` still gated on a real delivery path. ⚠ `D10-4` was found **already complete** (commit `2970993`) though the register still lists it OPEN — **a separate correction, not part of this act** |
| **`BLK-02`** | 🔴 OPEN | DLT + provider limbs |
| **Gate 3** | 🔴 Deliberately red | `ADR-0012` §3.4 baseline unchanged |
| **`E-32` / `E-33`** | ✅ Preserved | ⛔ Neither reopened |

⭐ **Google Sign-In does not, by itself, remove the DLT/SMS dependency** — `MP-DEP-03` is Rank 1 and remains binding until lawfully amended.

---

## 9. Governance compliance

| Rule | Status |
|---|---|
| `DOCUMENTATION_BASELINE.md` §7 **rule 1** — *"A change to any Rank 1–5 document requires an ADR **before** the change"* | ✅ **This ADR is that instrument.** ⛔ No Rank 1–5 document is changed by this act |
| §7 **rule 2** — version + changelog in the same commit | ⬜ N/A here — applies to the §6 execution steps |
| §7 **rule 3** — declaration updated in the same commit | ⬜ N/A here — applies to the §6 execution steps |
| §7 **rule 4** — baseline identifier moves for a Rank 1–3 version change | ⚠ **Will apply** at §6; ⛔ **`BASELINE-2026-09-03-A` stands** now |
| `ADR-INDEX.md` **L206** — never edit an Accepted ADR | ✅ `ADR-0002`, `ADR-0005`, `ADR-0128` **byte-unchanged** |
| `ADR-INDEX.md` L206 — never reuse a number | ✅ `ADR-0129` measured free; gaps at 0066–0074, 0088–0090 **not reused** |
| BC Map **L292** — an absent edge requires an ADR | ✅ Recognised; ⛔ **no edge created here** |
| `ADR-0033` §7.1 — one act is not a standing licence | ✅ Scope is `P-1`, `U-1`, `A-1`…`A-8`, `A-10`…`A-16`, Privacy sign-off **only**; ⛔ `A-9`, implementation, edge mint, port creation and PRD amendment all **refused** |
| `ADR-0014` method — *"read the manifest that already existed"* | ✅ Every determination is evidenced from existing text; the `sso_provider` scope, the state-model failure and the `orphaned` collision were all **read, not designed** |

---

## 10. Changelog

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-10 | ⭐⭐ **Created as `Proposed`.** Records the Product Owner decision **`P-1`** (Google Sign-In becomes the primary V1 authentication method; Mobile OTP and mobile verification re-scoped to V2), the load-bearing architecture decision **`U-1 = B`** (`AUTH-3.22` mobile identity anchor **removed**), Architecture decisions **`A-1`…`A-8`** and **`A-10`…`A-16`**, and the **Privacy Owner `APPROVE WITH CONDITIONS`** sign-off (**C-1**, **C-2**, **C-3**). ⭐ Key determinations: Google OIDC **`sub`** is the provider identity key and ⛔ **email is never canonical identity, uniqueness key or matching key**; **`AccountId`** remains canonical, permanent and non-reusable and is ⛔ **never derived from `sub` or email**; **`BC-18`** retains the credential/provider boundary and **`BC-10`** retains `PersonId` atomicity; ⛔ **`sso_provider` MUST NOT be widened** — a sibling **`identity_provider`** port is the direction; ⭐ **a new, distinct BC Map edge is required** and ⛔ **`E-33` is neither reused nor collapsed**; a successor account state (**`Unlinked`**, name provisional) is required for permanent provider invalidation, preserving `AccountId`/`PersonId`/business history while refusing authentication, with ⛔ **automatic re-linking prohibited**; **Reception, `PR-1` and `PR-2` all use Google-only V1 authentication** with ⛔ no exception and ⛔ no second factor, existing elevation/session/audit controls remaining **layered** (`ADR-0063`); **V1 accepts the scope exclusion** of minors and others who cannot use an eligible Google account, with ⛔ **no alternative mechanism** and ⛔ **`GuardianLink` remaining an enrollment mechanism, never delegated authentication**; and ⛔ **no V1 recovery path** for permanent Google-account loss, deferred to V2. ⛔⛔ **THIS ACT CREATES EXACTLY ONE FILE — THIS ADR — AND MODIFIES NO OTHER REPOSITORY FILE.** ⛔ `MASTER_PRD`, `Authentication_PRD_v2`, BC Map, `tool/module_dependencies.yaml`, `ADR-0002`, `ADR-0005`, `ADR-0127`, `ADR-0128` and all code, schema, API, UI, test and configuration files are **byte-unchanged**; ⛔ **no edge allocated (`E-34` NOT reserved)**, no port created, no baseline issued, no dependency installed, no secret created. ⚠ **`A-9` secret custody is expressly OUTSIDE the conferral and requires its own authority.** ⛔ **No blocker closed:** `MP-DEP-03`, `BLK-01`, `BLK-02`, `TASK-D10`, Gate 3, H1–H4 and D3 all unchanged, and ⭐ **H1 remains the longest-lead external item**. ⚠ **Status is `Proposed`, not `Accepted`** — promotion is a separate governance step, as are every §6 amendment and the §7 supersessions of **`ADR-0002`** and **`ADR-0005`** (⚠ which would be the repository's **first** supersession: 116 ADRs, **0 superseded**). **`BASELINE-2026-09-03-A` stands.** |
