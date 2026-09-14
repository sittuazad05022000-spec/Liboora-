# `ADR-0146` — V1 **Google Sign-In implementation is AUTHORISED**; the `IdentityProvider` port, the OIDC validation locus, the provider-identity account model, the `Unlinked` state and secret custody are **DECIDED**

| Field | Value |
|---|---|
| **ADR** | `ADR-0146` |
| **Status** | ⭐⭐ **`Accepted`** — 2026-09-11. Promoted `PROPOSED` → `Accepted` by the **separate governed acceptance act** recorded in §14, on a one-act conferral of **Product Owner + Architecture Owner + SECURITY PLATFORM** authority by the human principal — ⛔ **all three offices revert on completion** (`ADR-0033` §7.1); ⚠ **all three exercised by one principal**, so ⛔ **no independent review, ARB quorum or external Security audit is claimed**. ⭐ Registered in `ADR-INDEX` and declared in `DOCUMENTATION_BASELINE` **in the same commit** (baseline §7 rule 3). ⚠ **`P-7` is satisfied, not evaded:** the promotion is made **by the acceptance act and its two registry entries**, ⛔ not by this cell asserting it — this cell **records** a conferral that happened elsewhere. *(Prior text retained verbatim: "⛔ **`PROPOSED`** — ⛔⛔ **NOT Accepted, NOT authoritative, and it authorises NO code.** ⭐ *"Status is **conferred** by admission to the baseline, **never claimed by a document about itself**"* (`ADR-0131` §8.2 **`P-7`**). ⛔ **This document does NOT claim its own status**".)* ⛔⛔ **Acceptance authorises the DESIGN and the two architecture registrations; it does NOT release implementation — see §14.3** |
| **Date drafted** | 2026-09-11 |
| **Drafted at** | `580c7f5676e63c67614f36eae9862f81f705ed5b` |
| **Subject** | V1 authentication implementation — Google Sign-In (Google OIDC), `BC-18` Identity & Access |
| **Deciders required** | **Product Owner** (scope, acceptance) · **Architecture Owner** (ranks, boundaries, ports, edges) · **SECURITY PLATFORM** (secret custody, `A-9`) |
| **Decisions recorded** | ⭐ **10 of 10** — `PO-1`…`PO-4`, `AO-1`…`AO-5`, `SEC-1`. ⛔ **Recording a decision is not accepting the ADR** |
| **Supersedes** | ⛔ **NOTHING.** `ADR-0129`, `ADR-0124`, `ADR-0128`, `ADR-0115` and `ADR-0011` are **EXERCISED, not superseded, narrowed or reinterpreted** |
| **Amends** | ⭐ **`LIBOORA_BOUNDED_CONTEXT_MAP.md` v1.17 → v1.18** (Rank 4) — appends **§24**, registering edge **`E-34`**; ⭐ **`tool/module_dependencies.yaml`** — declares the rank-0 `identity_provider` port and its `platform/integration` adapter; ⭐ **`ADR-INDEX`** (registration + `Count`); ⭐ **`DOCUMENTATION_BASELINE`** (Authority + §3.2 version cell + §8). ⛔ **No Rank 1–3 document is amended** · ⛔ **no frozen PRD** · ⛔ **`E-33`/`ADR-0128` byte-unchanged** · ⛔ **`sso_provider` byte-unchanged** |
| **Requires separate acts** | ⚠ `ADR-0002` + `ADR-0005` supersession · `MASTER_PRD` `MP-DEP-03` disposition · ⚠ the `AUTH-3.21` re-baseline (§9) |
| **Baseline** | ⚠ **`BASELINE-2026-09-11-B` STANDS — the identifier does NOT advance.** §7 **rule 4** moves it only for a **Rank 1–3** version change; the only versioned document amended here is the **Rank 4** BC Map. ⭐ §7 **rule 1** (ADR before the change), **rule 2** (version + changelog same commit) and **rule 3** (declaration same commit) are **all discharged in this commit** |

---

## 1. Context — the measured gap this ADR closes

`Accepted` [`ADR-0129`](./ADR-0129-google-sign-in-v1-primary-authentication-mobile-otp-v2.md) (2026-09-10) made
Google Sign-In the sole required V1 authentication method, and **AUTHORITATIVE** Authentication PRD **v3.0**
(Rank 3) specifies it in full — `AUTH-3.40`…`AUTH-3.55`, `AUTH-4.1`…`AUTH-4.20`, §6 `Unlinked`, §8 sessions.

⛔ **But `ADR-0129` withheld every implementation power.** Its header **L13** records that it
*"Does NOT close … ⛔ implementation, dependencies, schema, API, UI, tests, configuration, secrets"* and
⛔ *"`A-9` secret custody (**expressly outside the conferral**)"*. **L170** states the consequence in terms:
*"⚠ **Requires its own separate conferral**, and **it blocks implementation**."*

**Measured at `580c7f5` by the Google Sign-In V1 readiness audit:**

| # | Measurement | Method | Result |
|---|---|---|---|
| 1 | **Google Sign-In is 0% implemented** | `grep -rniE "GoogleSignIn\|google_sign_in\|OidcAssertion\|idToken\|providerIdentity" lib/ packages/` | ⭐ **0 hits** |
| 2 | **No Google/OIDC dependency exists** | `pubspec.yaml` | ⭐ **0** — no `google_sign_in`, `firebase_auth`, `oauth`, `oidc`, `jwt`, `jose` |
| 3 | **No `IdentityProvider` port exists** | `grep -rn "sso_provider\|SsoProvider" lib/ packages/` | ⭐ **0 in code** — declared in `tool/module_dependencies.yaml` **L439** only |
| 4 | **Supabase is selected but unwired** | `grep -rniE "supabase" lib/ pubspec.yaml packages/` | ⭐ **0** — `ADR-0124` selected it; no SDK, project, config or credential |
| 5 | **The V1-forbidden method is still the live one** | `lib/app/shared/login_screen.dart` **L46/L60** | ⛔ collects a **phone**, calls `requestOtp` / `verifyOtp` |
| 6 | **`phone` is the authentication uniqueness key** | `lib/platform/identity/identity.dart` **L480–L482** | ⛔ `_accountForPhone` — contradicts `AUTH-4.1` |
| 7 | **Both structural gaps `IMPL-020` recorded are now CLOSED** | manifest **L750**; BC Map §19 **L1108** | ⭐ `platform/integration` has a manifest block (rank 5, 4 ports); **`E-33`** exists |

⭐ **The finding is not "authentication is unbuilt" but "authentication is built to the wrong specification, and
nobody is authorised to fix it."** This ADR exists to supply that authority and to decide the five design
questions the audit measured as open.

### 1.1 What this ADR is NOT

⛔ **It is not an implementation.** ⛔ No code, no dependency, no Google Cloud or Supabase configuration, no
secret, no schema, no test is created, added or changed by it. ⛔ It does not close `BLK-02`, `MP-DEP-03`,
`TASK-D10`, Gate 3 or `ADR-0012` §3.4. ⛔ It does not confer `A-9` — **that is `SEC-1`'s own act** — and it does
not supersede `ADR-0002` or `ADR-0005`.

---

## 2. Decision `D-1` / `AO-1` — the `IdentityProvider` port

> ⭐ **APPROVED: introduce a new `platform/integration:identity_provider` port.**
> ⛔ **Do NOT reuse `sso_provider` for Google Sign-In** unless an explicit existing contract is proven
> compatible **without weakening** the new Google/OIDC requirements.

**Rationale — measured, not asserted:**

| Evidence | Text / measurement |
|---|---|
| `tool/module_dependencies.yaml` **L437–L439** | `sso_provider` is scoped by its own comment to *"The single sanctioned bypass of `platform/communication`, **for possession challenge delivery only**"* |
| BC Map §19 **L1108** | **`E-33`** is declared *"**The V1 OTP / possession-challenge transport**"* |
| `ADR-0128` §2.2 | Accepted the `sso_provider` name **as-is for V1** and recorded the naming concern as *"a documented future architecture consideration, **not resolved**"* |

⭐ Google OIDC is **not** a possession challenge. Reusing `sso_provider` would silently resolve `ADR-0128`'s
expressly deferred question and overload one port with two unrelated protocols.

**Port shape (Rank 0, `packages/liboora_contracts`), for review:**

```dart
abstract interface class IdentityProvider {
  /// Uniform across subjects by contract — never a per-subject probe (`F-02`).
  bool get isConfigured;

  /// Diagnostics only. Never evidence that a particular person authenticated.
  String get providerName;

  /// `null` means the user cancelled — not a failure, and not an oracle.
  Future<ProviderAssertion?> authenticate();
}

final class ProviderAssertion {
  /// `AUTH-3.49` — the immutable Google `sub`, treated as opaque.
  final String subject;

  /// `AUTH-4.16`(ii) — may be absent; ⛔ MUST NOT block account creation.
  final String? displayName;

  // ⛔ NO email field      — `AUTH-3.52`/`AUTH-3.53` forbid email as identity,
  //                          uniqueness, matching or re-link key.
  // ⛔ NO raw token field  — `AUTH-3.55`/`MP-GBR-27` confine tokens to `BC-18`.
}
```

⭐ **`ProviderAssertion` carries no email and no raw token deliberately.** A field that cannot be named cannot be
misused — the same discipline `MembershipPlan.withEdits` applies to immutable fields.

---

## 3. Decision `D-2` / `AO-2` — the boundary relationship

> ⭐ **APPROVED: the governed edge/relationship for the Google identity-provider integration is established
> through the EXISTING architecture governance mechanism.**
> ⛔ **Do NOT widen unrelated dependency boundaries.**
> ⭐ The implementation **MUST** preserve the existing **downward-only** architecture and **MUST NOT** introduce
> a new **domain → capability** dependency.

**How this is satisfied without inventing anything — measured:**

| Constraint | Mechanism | Evidence |
|---|---|---|
| `platform/identity` is **rank 4**; `platform/integration` is **rank 5** | The reference is **upward**, so it **MUST NOT** be a compile-time import | manifest **L36**, **L40** |
| Law **L2** — *"downward only"* | Declared under **`ports:`**, never `imports:`. A port is DI-wired at the composition root, so no upward import exists | manifest **L9**; precedent at **L440–L444** (`contracts:person_identity_factory`: *"Declared as a **PORT, never an import** … so this platform never points upward"*) |
| Law **L4** — no capability imports a domain | `banned_imports: ["domain/**", "app/**"]` already holds on both modules | manifest **L445**, **L759** |
| No new domain → capability dependency | ⛔ `domain/**` is untouched by this design | — |

### 3.1 ⭐⭐ `AO-2` RESOLVED — the limb is closed, and limb **(b)** is the answer

⚠ **The draft left one limb open.** It recorded that whether Google OIDC **(a)** rides `E-33` under a purpose-widening
amendment, **(b)** requires a **new governed edge**, or **(c)** is already covered by the existing `IAM → INT`
Matrix relationship (Matrix **L137**, cell `◇`) was *"NOT decided by this draft"*. ⭐⭐ **It is decided here, and
each limb was tested against existing governance rather than chosen by preference:**

| Limb | Disposition | Governing authority — measured |
|---|---|---|
| **(a)** widen `E-33` | ⛔ **REJECTED — forbidden** | `ADR-0129` **L174**: *"`ADR-0128` / `E-33` — **NOT reopened, NOT amended.** OTP/possession-challenge semantics **preserved**"*. Independently, BC Map **L1234**/**L1311**/**L1350** record that **L1108 is citation-locked** by `Accepted` `ADR-0129` **L79**, and `ADR-INDEX` **L206** rules *"Never edit an Accepted ADR's decision text"* |
| **(c)** rely on the Matrix cell | ⛔ **REJECTED — already tested and rejected by `Accepted` governance** | `ADR-0129` **L81** ran exactly this argument — the register is *"pair-grained … on that convention alone the pair could be said to be 'covered'"* — and rejected it: *"**Purpose-scoping overrides it**"*, on BC Map **§20.2**'s own precedent that collapsing distinct edges *"would breach four rules"*. ⭐ The Matrix governs the **module-graph mechanism**; §7 **L292** governs **context-boundary existence**. Two registers, two questions |
| **(b)** a new governed edge | ⭐⭐ **SELECTED — and it is not a new decision at all** | ⭐ `Accepted` `ADR-0129` **`A-7`** (**L79**) **already decided it**: *"Google federated identity requires a **NEW, distinct** BC Map edge."* **L83** then declined to allocate the number, requiring it be *"re-measured immediately before minting"* |

⭐⭐⭐ **THE DECISIVE POINT: limb (b) is the EXECUTION of an existing `Accepted` decision, not the invention of a
new one.** `ADR-0129` decided the edge was required and deliberately withheld only the *number*. This ADR supplies
the number by measurement.

**Identifier — re-measured immediately before minting, as `ADR-0129` L83 requires:**

| Test | Result |
|---|---|
| Highest allocated edge in the BC Map register | ⭐ **`E-33`** |
| `E-34` occurrences **in the BC Map** | ⭐ **0** |
| `E-34` occurrences in `docs/`, each read individually | ⭐⭐ **47 — and ALL 47 are express refusals** (*"`E-34` NOT allocated"*); ⛔ **0 allocations** |
| Sequential numbering (`ADR-INDEX` **L206**) | ⭐ **`E-34` is the next lawful number** — ⛔ no leapfrog to `E-35` |

⭐ **A refusal to allocate is not an allocation.** The 47 prior occurrences are the record of the number being
**held free** for the act that would lawfully need it — this one.

> ⭐⭐ **`AO-2` DISPOSITION: `E-34` — `BC-18 Identity & Access` → `BC-31 Integration` (`CF`, Sync port, V1),
> scoped to INBOUND Google OIDC assertion validation ONLY.** Registered at BC Map **§24.1** (v1.18).
> ⛔ **`E-33` byte-unchanged** (L1108 md5-verified identical) · ⛔ **`ADR-0128` not reopened** · ⛔ **`E-35` not
> allocated** · ⛔ **`E-31` still reserved** · ⛔ **`E-27` still permanently vacant**.

**On `ADR-0131` §8.2 `P-4`.** ⚠ The draft cited `P-4` as barring the mint. ⭐ **That citation was over-broad and is
corrected here rather than repeated:** §8.2 is titled *"The eight things **a Technical Specification** may never
do"*, and `P-1` (*"MUST NOT supersede an ADR"*) and `P-2` confirm the subject throughout. ⛔ **`P-4` binds
Technical Specifications, not ADRs.** BC Map **L292** states the affirmative rule for this instrument: an absent
edge *"does not exist and **adding it requires an ADR**."* ⭐ **This is that ADR.** `P-4` remains binding on every
`TS-*` document and is **not weakened** — ⭐ and `E-34`'s allocation now simply makes `P-4`'s parenthetical figure
historical, exactly as `E-33`'s own mint did before it.

⛔ **Still not decided here, and still the Architecture Owner's:** no *further* edge, no rank change, no bounded
context, no aggregate. ⭐ **`E-34` is the only identifier this ADR allocates.**

---

## 4. Decision `D-3` / `AO-3` — the OIDC validation locus

> ⭐ **APPROVED: server-side / provider-side OIDC validation is the AUTHORITATIVE trust boundary.**
> ⛔ **The client MUST NOT be treated as the authority for Google identity claims.**
> ⭐ **`G-1`…`G-9` are APPROVED**, subject only to implementation **proving them through tests and gates**.

**Why the client cannot be the authority — existing boundary, not a new rule:** `ADR-0115` §5 already rejected
*"Direct provider calls from the Flutter client"* because *"`PRD-001`'s credential/authorization boundary and
`IMPL-020` reject placing server credentials in the client."* A client validating its own assertion is a UX
affordance, never an authentication guarantee.

| ID | Guarantee — all mandatory, all server-side | Source |
|---|---|---|
| **`G-1`** | JWS signature verified against Google's JWKS, with key fetch, cache and **rotation** | `AUTH-3.40` |
| **`G-2`** | `iss` ∈ { `https://accounts.google.com`, `accounts.google.com` } | `AUTH-3.40` |
| **`G-3`** | `aud` equals **our** registered client ID **exactly** | `AUTH-3.40` |
| **`G-4`** | `exp` / `iat` / `nbf` honoured with a **bounded** clock skew | `AUTH-3.40` |
| **`G-5`** | **`nonce` bound to the request and single-use** — replay defence. ⚠ **No current equivalent exists** | *(audit finding)* |
| **`G-6`** | `sub` non-empty and treated as **opaque** | `AUTH-3.49` |
| **`G-7`** | ⛔ **No token, `sub`, credential or session stored outside `BC-18`** | `AUTH-3.55`, `MP-GBR-27` |
| **`G-8`** | ⛔ `email_verified` **MUST NOT** be used as a matching key | `AUTH-3.52`, `AUTH-3.53` |
| **`G-9`** | Failure is **uniform** — no oracle distinguishing "unknown `sub`" from "invalid assertion" | `F-02`, `AR-7` |

---

## 5. Decision `D-4` / `AO-4` + `PO-1` / `PO-2` / `PO-3` — the identity model, `Unlinked` and revocation

> ⭐ **APPROVED** as recorded below.

| # | Approved rule | Source |
|---|---|---|
| 1 | The **immutable Google `sub`** is the `provider identity` key | `AUTH-3.49` |
| 2 | One `sub` → **at most one** `AccountId`; one `AccountId` holds **exactly one** `provider identity` | `AUTH-3.50`, `AUTH-3.51` |
| 3 | `AccountId` remains **independently generated and non-derivable** from `sub`, email, phone or any mutable attribute | `AUTH-4.20` |
| 4 | ⛔ **`Account.phone` is NOT the authentication identity key** and **MUST NOT** be the authentication uniqueness key | `AUTH-3.41`, `AUTH-4.1`, **`PO-1 = A`** |
| 5 | ⭐ `Account` **MAY retain** `phone` as **optional**, non-authenticating contact / provisioning data | **`PO-1 = A`**, **`PO-2 = C`** |
| 6 | **`Unlinked`** is a valid account state where the approved lifecycle requires it | PRD v3.0 §6, **`AO-4`** |
| 7 | ⭐ A **provisioned but unbound** account remains **`Provisioned`** — ⛔ **NOT** auto-converted to `Unlinked` merely because no Google identity is bound yet | **`PO-3 = A`** |
| 8 | Google identity binding **MUST preserve `PersonId` atomicity** and existing tenant/person invariants | `AUTH-3.54`, `ADR-0011`, `SID-INV-1`, `SID-INV-2` |
| 9 | ⛔ A **revoked or invalid** provider identity **MUST NOT** continue to create an authenticated session | `AUTH-6.26`, `AUTH-9.92` |
| 10 | Session **termination / rejection on detected revocation** is approved | `AUTH-6.26`, `AUTH-11.66` |
| 11 | ⛔ **Do NOT invent a background revocation-propagation mechanism** unless separately governed | **`AO-4`** |

### 5.1 ⭐ Why `PO-2 = C` resolves a real hazard rather than merely choosing an option

`lib/bootstrap/di.dart` **L248–L266** (`provisionIdentityForEnrollment`) matches on `phone`:

```dart
for (final a in auth.accounts) {
  if (a.phone == phone) return a.personId;   // di.dart L256
}
```

Its own comment states the purpose: *"A second library enrolling the same person yields a second
`StudentRecord` and the **SAME `PersonId`** — the asymmetry **`ID-5`** depends on."*

⚠ **So `phone` currently underwrites `SID-INV-1`/`SID-INV-2` — one Global Person Identity per person.** Under
Google Sign-In a reception-provisioned walk-in has **no `sub` yet**, so there is nothing to match on. Removing
`phone` outright would have **silently permitted duplicate `PersonId`s** for one person across libraries.

⭐ **`PO-2 = C` keeps `phone` as a non-authenticating matching/provisioning key while stripping its
authentication role** — satisfying `AUTH-3.41` **and** preserving `SID-INV-1`/`SID-INV-2`. ⛔ It is **not** a
second authentication factor and **MUST NOT** become one (`AUTH-3.45`, `AUTH-3.17`).

### 5.2 ⚠ `Provisioned` is an addition to the PRD's state table, and it is disclosed as such

Measured: **`provisioned` appears 0 times** in Authentication PRD v3.0, whose **§6.3** state table names only
**`Unlinked`**. ⚠ **No closed-set language governs the state vocabulary** (`grep -niE "closed set|exactly
these|MUST be one of"` → **0** matches in that document), so `Provisioned` is an **addition, not a
contradiction**.

⭐ `PO-3 = A` is also consistent with the PRD's own reasoning rather than merely permitted by it: `AUTH-9.90`
requires `Unlinked` to be **system-triggered** and forbids its use *"as a sanction, penalty or security
signal"*, and §6.2 scopes it to an identity that **was** bound and became invalid. A **never-bound** account has
a different history; reporting it as `Unlinked` would be inaccurate.

### 5.3 ⚠ The `AUTH-3.21` breach, disclosed rather than hidden

`AUTH-3.21` states *"Introducing a method **MUST NOT** require any change to the account model, the role model,
the session model or existing accounts."* ⚠⚠ **This design DOES change the account model.**

⛔ **That breach is not created here and is not concealed.** `ADR-0129` §6 already measured it and ruled the
remedy is *"**a major version and re-baseline**, not an additive amendment."* ⭐ This ADR records the breach and
routes it; it does **not** amend `AUTH-3.21`, and it does **not** claim the re-baseline has occurred.

---

## 6. Decision `D-5` / `AO-5` — module and dependency changes

> ⭐ **APPROVED: only the MINIMUM module/dependency changes required to implement this design.**

**Approved architecture constraints, verbatim:** preserve the **modular-monolith** structure · preserve the
existing **dependency direction** · domain code **MUST** depend only on **declared ports/contracts** · provider
SDK/API details **MUST** remain **outside the domain** · **bootstrap/composition root** wires concrete
implementations · ⛔ **no unrelated refactoring** · ⛔ **no new cross-module dependency merely for convenience**.

**The minimum change set, enumerated so "minimum" is checkable:**

| File | Change | Constraint |
|---|---|---|
| `packages/liboora_contracts/.../ports/` | **add** `IdentityProvider` + `ProviderAssertion` (Rank 0) | Rank 0 is depended upon by everything and depends on nothing |
| `tool/module_dependencies.yaml` **L754–L758** | `platform/integration` → `provides_ports:` **add** `identity_provider` | ⛔ no other port altered |
| `tool/module_dependencies.yaml` **L435–L444** | `platform/identity` → `ports:` **add** `platform/integration:identity_provider` | ⛔ **`ports:`, never `imports:`** — law **L2** |
| `lib/platform/integration/` | the concrete adapter | ⛔ SDK details confined here |
| `lib/bootstrap/di.dart` | wire the adapter — **the only** construction site | `no_orphan_ports_test` |

⭐ **Mechanical acceptance test for "minimum":** `dart run tool/check_module_boundaries.dart` **MUST** still
report exactly **`FAIL — 9 violation(s)`** and **`ACKNOWLEDGED DEBT — 28 finding(s) across 12 edge(s)`**. ⛔ Any
increase means the port was wired as an import, and the change is wrong. ⚠ The **9** are `ADR-0012` §3.4's
deliberately-unwaived `app -> domain/library` sites and are **unrelated** to authentication; this ADR ⛔ **does
not close, waive or baseline them**.

---

## 7. Decision `SEC-1` — secret custody

> ⭐ **APPROVED: the existing `A-9` secret-custody control is extended to `BC-18` / the Google Sign-In
> integration.**
> ⛔ Provider secrets, private credentials, service-role credentials and other sensitive integration material
> **MUST NOT** be committed to source control or exposed to the client application.
> ⛔ **Do NOT implement secret storage / vault integration yet** unless this ADR has formally reached the
> implementation stage.

**The office is found, not invented** — `ADR-0115` §8.1:

| Evidence | Text |
|---|---|
| **`SECP-OWN-001`** | *"Secrets & key vault, encryption … \| **SECURITY PLATFORM** \| **Owner.**"* |
| **`SECP-OWN-009`** | DEVOPS owns CI/CD, but *"Owns the **vault** the pipeline reads — the EA marks it **[vault owned by SECURITY PLATFORM]**"* |
| **`MP-NFR-05`** (Rank 1, L499) | *"Security \| Zero trust, **secrets management**, encryption, threat detection \| **SECURITY**"* |

⚠ **Why an extension was required at all:** `ADR-0115` §8.1's conferral is scoped *"for the V1 `BC-30` Offline
Sync runtime **only**"*, and `ADR-0129` **L170** records *"`ADR-0115` §8.1 is `BC-30`-scoped and `ADR-0124` did
**not** widen it to authentication."*

**Artefact classification:**

| Artefact | Custody | In source control? |
|---|---|---|
| Google **client secret** | SECURITY PLATFORM vault | ⛔ **Never** |
| Supabase **service-role key** | SECURITY PLATFORM vault | ⛔ **Never** |
| Google **client ID** *(public by design)* | Build configuration | ⚠ Per SECURITY PLATFORM direction at implementation |
| Supabase **anon key** *(public by design)* | Build configuration | ⚠ Per SECURITY PLATFORM direction at implementation |
| Android **SHA-1 / SHA-256** | Signing infrastructure | ⛔ **Never** |

---

## 8. Constraints restated — binding, and NOT re-decided here

| Constraint | Source |
|---|---|
| V1 authentication is **Google Sign-In only**; no selection interface | `AUTH-3.40`, `AUTH-3.15` |
| **Mobile / SMS OTP is V2** and ⛔ **MUST NOT** be a V1 authentication method | `AUTH-3.42`, `AUTH-3.46` |
| ⛔ No demo, guest, seeded sign-in, password, PIN, reusable secret or bypass | `AUTH-3.43`, `AUTH-3.44`, `MP-CON-11` |
| ⛔ No second independently authenticating method and no second factor | `AUTH-3.45`, `AUTH-3.17` |
| ⛔ **Email is NEVER** the identity, `AccountId`, `PersonId`, uniqueness, matching or re-link key | `AUTH-3.52`, `AUTH-3.53` |
| ⛔ Two `provider identity` records with different `sub` values **MUST NOT** be merged on a shared email | `AUTH-3.53` |
| **`PersonId` stays `BC-10`-owned**, created atomically and mandatorily with the Account | `AUTH-3.54`, `ADR-0011` |
| Method behaves **identically** for every account, library and role; ⛔ **never** a tenant setting | `AUTH-3.18`, `AUTH-3.19` |
| ⛔ No unsupported method present in a release build **in any form** | `AUTH-3.13` |
| Tokens, credentials and sessions confined to `BC-18` | `AUTH-3.55`, `MP-GBR-27` |
| Supabase is **an adapter behind a port, never a layer** | `MP-CON-03`, `ADR-0124` |
| ⭐ **`PO-4`** — V1 Google Sign-In is available to all users satisfying Google-account eligibility; ⛔ a user **MUST NOT** be blocked **solely** because they are a minor; a user without an eligible Google account receives ⛔ **NO** alternative V1 method | `AUTH-3.48`, **`PO-4`** |

⭐ **`PO-4` sharpens `AUTH-3.48` without weakening it.** The PRD's phrase *"including minors who cannot
independently satisfy Google's account eligibility"* is readable as "minors are excluded"; `PO-4` makes the real
test explicit — **eligibility, not age**. ⛔ The no-fallback limb is preserved verbatim: *"no fallback factor,
alternate method or compensating V1 path **MAY** be introduced."* **Implementation consequence:** ⛔ no age gate,
⛔ no minor-specific branch, ⛔ no alternate route.

---

## 9. Migration, test, security and release implications

**Migration.** `Account` gains `providerIdentity` and an `AccountState` (`Provisioned`, `Unlinked`, …); `phone`
becomes optional (`PO-1 = A`) and non-authenticating (`PO-2 = C`). The persisted `accountStore` requires a
**versioned codec migration** — the v1→v2 pattern already used in `lib/bootstrap/codecs.dart`. ⚠ Existing
persisted accounts hold **no `sub`**; under `PO-3 = A` they are **`Provisioned`**, ⛔ not `Unlinked`.

**Tests.** The **39** passing conformance tests are **OTP-shaped**, and under `AUTH-3.42` they exercise a
V1-forbidden method. ⭐ They **MUST be re-expressed against Google Sign-In, NOT deleted** — with a fake
`IdentityProvider` in `test/`, mirroring the existing `_RecordingDelivery` pattern
(`test/authentication_conformance_test.dart` **L58**). ⛔ **No test may be weakened, skipped or exempted**;
`G-1`…`G-9` are proven by tests and gates (`AO-3`).

**Security.** `G-5` (`nonce` replay defence) has **no current equivalent**. `G-9` uniform failure must be
preserved. ⚠ The **profile-build peek leak** — `lib/bootstrap/di.dart` **L602**, gated on `dart.vm.product`
**only** — must close (`TASK-D10` **AC-9**: *"profile builds reach testers"*).

**Release cleanliness (`AUTH-3.13`).** Once Google Sign-In works, `requestOtp`, `verifyOtp`,
`debugPeekChallenge`, `otpHint` and `kDemoChildPhone` must all be **removed** — this is `TASK-D10`
`D10-5`…`D10-10`, ⭐ **finally unblocked because a real sign-in route will exist**, satisfying `TASK-D10` §7's
prerequisite by a route it did not anticipate. `AC-8`/`AC-9` grep **release *and* profile** artefacts.

---

## 10. Blockers — what this ADR removes, and what survives it

**Removed on acceptance:** no implementation authority · undecided port shape · undecided validation locus ·
undecided identity model · undecided `Unlinked` semantics · undecided secret-custody boundary.

| Surviving blocker | Status | Owner |
|---|---|---|
| ⛔ **`A-9` implementation step** | `SEC-1` approves the **extension**; ⛔ vault integration **not** to be built until this ADR reaches the implementation stage | SECURITY PLATFORM |
| ⛔ **External configuration** | Google Cloud project, OAuth client IDs per platform, consent screen, redirect URIs, Android SHA-1/SHA-256, Supabase project + Google provider | ⭐ **Startable in parallel; needs no ADR** |
| ⚠ `ADR-0002` / `ADR-0005` supersession | Both still `Accepted` while contradicted; repo measures **0 superseded, 0 deprecated** — the mechanism is **untested** | Governance Owner |
| ⚠ `MP-DEP-03` (Rank 1) | Still demands V1 SMS + DLT; ⛔ unamended by `MASTER_PRD` v1.8 | Product + Architecture Owner |
| ⛔ `ADR-0012` §3.4 / Gate 3 | **9** violations. ⭐ **Unrelated to authentication** — needs §4 **Wave 4** port extraction. *This, not authentication, blocks `PRD-005`'s remaining `IMPL-*`* | Architecture Owner |
| ⚠ `AUTH-3.21` re-baseline | Required by §5.3 | Governance Owner |

---

## 11. Implementation sequence — ⛔ NOT STARTED, and blocked until acceptance

⛔ **No step below may begin until this ADR is `Accepted` AND `SEC-1`'s implementation step is released.**

1. `A-9` implementation release for `BC-18` *(blocking)*.
2. Google Cloud + Supabase configuration; secrets vaulted.
3. Declare `IdentityProvider` + `ProviderAssertion` in `liboora_contracts` (Rank 0).
4. Amend `tool/module_dependencies.yaml`; ⭐ **verify the boundary checker still reports 9 / 28**.
5. Implement the adapter in `platform/integration`; wire at `lib/bootstrap/di.dart` **only**.
6. Add `providerIdentity` + `AccountState` to `Account`; re-key uniqueness to `sub`; ⭐ **keep `PersonId`
   atomicity intact**.
7. Versioned `accountStore` codec migration.
8. Implement server-side `G-1`…`G-9`, including `G-5` `nonce`.
9. Replace the phone/OTP sign-in UI with a **single** Google Sign-In action — ⛔ no selection UI (`AUTH-3.15`).
10. Implement `Unlinked` + `AUTH-6.26` termination triggers. ⛔ **No background propagation mechanism**
    (`AO-4`).
11. Re-express the 39 conformance tests with a `test/`-only fake provider — ⛔ **none weakened**.
12. **Only now:** `TASK-D10` `D10-5`…`D10-10`; verify `AC-1`…`AC-10`, including **`AC-9` profile**.
13. Full gate: `flutter analyze` · `flutter test` · `flutter build web --release` · boundary **9 / 28
    unchanged** · release **and profile** artefact greps.

---

## 12. Governance compliance

| Rule | Compliance |
|---|---|
| `ADR-0131` §8.2 **`P-7`** — status is conferred, never self-claimed | ✅ Header states **`PROPOSED`**; ⛔ no acceptance asserted |
| `ADR-0131` §8.2 **`P-4`** — no invented boundary, edge, port or aggregate | ✅ A port is **proposed for approval**, not minted; ⛔ **no edge minted** (§3); ⛔ `E-34` not allocated |
| `ADR-0131` §8.2 **`P-3`** — no invented permission | ✅ ⛔ **0** permission identifiers; `AUTH-7.22` stays closed |
| `ADR-0131` §8.2 **`P-5`** — conflicts recorded, never silently repaired | ✅ `AUTH-3.21` breach (§5.3), `MP-DEP-03`, `ADR-0002`/`0005` all **recorded** |
| `ADR-0131` §8.2 **`P-2`** — no frozen PRD amended | ✅ ⛔ **0** PRDs amended |
| `ADR-0033` §7.1 — one act is not a standing licence | ✅ Scope is `PO-1`…`PO-4`, `AO-1`…`AO-5`, `SEC-1` **only**; ⛔ implementation, edge mint, `A-9` execution and PRD amendment all **refused** |
| `ADR-INDEX` **L206**/**L207** — never edit an Accepted ADR | ✅ `ADR-0129`, `ADR-0124`, `ADR-0128`, `ADR-0115`, `ADR-0011` **exercised**, ⛔ not edited |
| Baseline §7 rule 1 — ADR **before** a Rank 1–5 change | ✅ This **is** that ADR; ⛔ no such change made yet |
| Baseline §7 rule 4 — identifier moves only on a Rank 1–3 version change | ✅ Trigger **unmet**; ⛔ baseline **unchanged** |

**Citation cost:** ⭐ **ZERO.** This is a **new file**; ⛔ **0** `#L` anchors point into it, and ⛔ **0** existing
lines in any other document are shifted by creating it.

---

## 14. ⭐⭐ The acceptance act — and what it does NOT release

### 14.1 Gates tested before acceptance, not asserted

| Gate | Requirement | Result |
|---|---|---|
| **G-A** | All owner decisions recorded | ⭐ **10 / 10** — `PO-1`…`PO-4`, `AO-1`…`AO-5`, `SEC-1` |
| **G-B** | ⭐ **No decision left open** | ⭐ **SATISFIED** — `AO-2`'s edge limb, open in v1.0, is **RESOLVED at §3.1** (limb **(b)**, `E-34`) |
| **G-C** | Prerequisite architecture **registered**, not merely designed | ⭐ **SATISFIED** — `E-34` at BC Map **§24.1**; `identity_provider` in the manifest |
| **G-D** | `ADR-0129` §6.3's two architecture amendments executed | ⭐ **BOTH** — *"register the new Google federated identity edge"* and *"declare the sibling `identity_provider` port"* |
| **G-E** | Boundary baseline preserved (`AO-5`'s mechanical test) | ⭐ **`FAIL — 9 violation(s)`** + **`ACKNOWLEDGED DEBT — 28 finding(s) across 12 edge(s)`** — **byte-identical** |
| **G-F** | `P-7` respected | ⭐ Status conferred by **this act + two registry entries**, ⛔ not self-claimed |
| **G-G** | Baseline §7 rules 1–3 | ⭐ ADR written **before** the change; version + changelog + declaration **all in this commit** |

### 14.2 ⭐ What acceptance DOES release

⭐ The **design** is now authoritative: the `IdentityProvider` port shape (§2), the boundary relationship and
`E-34` (§3), the server-side validation locus and `G-1`…`G-9` (§4), the identity model (§5), the minimum change
set (§6) and the `A-9` extension to `BC-18` (§7). ⭐ **`E-34` and the manifest port are registered and real.**

### 14.3 ⛔⛔ What acceptance does NOT release — implementation remains BLOCKED

⚠⚠ **Acceptance of this ADR is NOT the implementation release, and this section exists so that is not misread.**

| Blocker | Why it still binds | Owner |
|---|---|---|
| ⛔⛔ **`SEC-1`'s own condition** | §7 states: *"⛔ **Do NOT implement secret storage / vault integration yet** unless this ADR **has formally reached the implementation stage**."* ⭐ Acceptance of a **design** is not entry to the implementation stage; `SEC-1` withheld that step expressly, and §10 records vault integration as *"**not** to be built until this ADR reaches the implementation stage"* | **SECURITY PLATFORM** |
| ⛔⛔ **Every credential is external and absent** | ⛔ **0** Google Cloud project, OAuth client ID, client secret, consent screen, redirect URI, Android SHA-1/SHA-256, Supabase project or Google provider configuration exists. ⭐ `G-3` requires `aud` to equal *"**our** registered client ID exactly"* — ⛔ **there is no client ID**, so `G-1`…`G-9` are **unprovable** today | **Product Owner + DEVOPS** (procurement) |
| ⚠ **Rank-1 `MP-DEP-03`** | Still requires V1 SMS + TRAI DLT while `AUTH-3.42` forbids V1 OTP — ⛔ **unamended**, and Rank 1 outranks this ADR | **Product Owner** |
| ⚠ **`ADR-0002` / `ADR-0005`** | Both still `Accepted` while contradicted; ⛔ supersession **NOT EXECUTED** (`ADR-0129` §7). ⚠ Repo measures **0 superseded** — the mechanism is untested | **Architecture Owner** |
| ⚠ **`AUTH-3.21` breach** | `ADR-0129` §6 measured it as requiring *"a major version and re-baseline"* — ⛔ not performed | **Product Owner** |

⭐⭐ **THE HONEST SUMMARY: the architecture is now lawful and registered; the implementation is not yet
authorised.** ⭐ What this act removes is the **governance** blocker (`AO-2`), which was the only one inside this
ADR's gift. ⛔ What remains is a **security-stage release** and a set of **external procurement** items, neither
of which an ADR can self-confer.

⛔ **Also NOT closed by this act:** `BLK-01`, `BLK-02`, `IMPL-020`, `TASK-D10`, Gate 3, D3, H1–H4, `MP-DEP-07`
and `ADR-0012` §3.4 — ⭐ and the **9** boundary violations are **unrelated to authentication**, being what
actually blocks `PRD-005`'s remaining `IMPL-*`.

---

## 13. Change history

| Version | Date | Change |
|---|---|---|
| **1.1** | 2026-09-11 | ⭐⭐ **PROMOTED `PROPOSED` → `Accepted`, AND `AO-2`'s LAST OPEN LIMB IS RESOLVED.** Conferral: one-act **Product Owner + Architecture Owner + SECURITY PLATFORM** by the human principal, ⛔ **reverting on completion** (`ADR-0033` §7.1); ⚠ **all three offices exercised by one principal** — ⛔ **no independent review, ARB quorum or external Security audit is claimed**. ⭐⭐⭐ **`AO-2` RESOLVED AS LIMB (b) — A NEW GOVERNED EDGE, `E-34`** (§3.1). ⭐ **This EXECUTES an existing `Accepted` decision rather than taking a new one:** `ADR-0129` **`A-7`** (**L79**) already held that *"Google federated identity requires a **NEW, distinct** BC Map edge"*, and **L83** withheld only the *number*, requiring it be *"re-measured immediately before minting"*. ⭐ **That re-measurement was performed:** highest allocated **`E-33`**; `E-34` **0** occurrences in the BC Map; **47** `E-34` occurrences across `docs/` read **individually** and ⭐⭐ **all 47 are express refusals — 0 allocations**; `ADR-INDEX` **L206** sequential numbering obeyed, ⛔ **no leapfrog to `E-35`**. ⭐ **A refusal to allocate is not an allocation.** ⛔⛔ **THE OTHER TWO LIMBS WERE TESTED AND REJECTED ON EXISTING GOVERNANCE, NOT ON PREFERENCE:** limb **(a)** (widen `E-33`) is **forbidden** by `ADR-0129` **L174** (*"`ADR-0128` / `E-33` — NOT reopened, NOT amended"*) and by the **citation lock** on BC Map **L1108** recorded at **L1234**/**L1311**/**L1350** with `ADR-INDEX` **L206**; limb **(c)** (the existing `IAM → INT` Matrix cell) was ⭐ **already run and rejected by `Accepted` `ADR-0129` L81** — the register is *"pair-grained"* but *"**Purpose-scoping overrides it**"*, on BC Map **§20.2**'s own warning that collapsing distinct edges *"would breach four rules"*. ⭐ The Matrix governs the **module-graph mechanism**; §7 **L292** governs **context-boundary existence** — two registers, two questions, both now satisfied. ⚠⚠ **A CITATION IN v1.0 WAS OVER-BROAD AND IS CORRECTED RATHER THAN REPEATED:** v1.0 cited `ADR-0131` **`P-4`** as barring the mint, but §8.2 is titled *"The eight things **a Technical Specification** may never do"* — ⛔ **`P-4` binds `TS-*` documents, not ADRs** — while BC Map **L292** states the affirmative rule for this instrument: an absent edge *"does not exist and **adding it requires an ADR**"*. ⭐ **`P-4` remains binding on every `TS-*` and is NOT weakened.** ⭐⭐ **TWO ARCHITECTURE AMENDMENTS EXECUTED — exactly the two `ADR-0129` §6.3 required:** **(1)** BC Map **v1.17 → v1.18** appends **§24**, registering **`E-34`** `BC-18 Identity & Access` → `BC-31 Integration` (`CF`, Sync port, **V1**), scoped to ⭐ **INBOUND Google OIDC assertion validation ONLY** — **edges 31 → 32**, context count **unchanged at 31 (23 in V1)**; **(2)** `tool/module_dependencies.yaml` declares **`contracts:identity_provider`** as a **rank-0 port** on `platform/identity` and its **adapter** on `platform/integration`. ⭐⭐ **THE PORT IS RANK 0, ON TWO MEASURED PRECEDENTS — `person_identity_factory` (manifest **L440–L444**: *"Declared as a **PORT, never an import** … so this platform never points upward"*) and `otp_delivery` (*"the seam is declared now, **at rank 0**"*) — so `platform/identity` (rank 4) NEVER points upward at `platform/integration` (rank 5) and law **L2** holds literally.** ⛔ **`sso_provider` is NOT reused, renamed or widened** and is **byte-unchanged**: `ADR-0129` **L76** measured the two as **opposites** — an **outbound** message we generated versus an **inbound** assertion an external issuer generated, whose failure modes differ **in kind** (*message undelivered* versus *identity forged*). ⛔⛔ **`E-33` IS BYTE-UNCHANGED — L1108 md5-verified identical before and after (`5918ee2d2699f6c10ba3c116cdb2f8c1`)** · ⛔ **`ADR-0128` NOT reopened** · ⛔ **`E-35` NOT allocated** · ⛔ **`E-31` still reserved** for `PRD-021C`/`TSF-GAP-009` and absent · ⛔ **`E-27` still permanently vacant**. ⭐ **CITATION COST: ZERO** — BC Map §24 is **appended at end of file** (the §21/§22/§23 discipline), shifting **0** citations; a newest-first changelog row would have landed at **L613** and shifted **ten**, including the locked **L1108**. ⭐⭐ **ALL PROJECT GATES GREEN WITH THE BASELINE HELD:** `flutter analyze` **No issues found!** · `flutter test` **807/807 All tests passed** · `flutter build web --release` **✓ Built** · `git diff --check` **clean** · architecture suite **256/256** (including **`no_orphan_ports_test`**, the test that would catch a declared-but-unimplemented port) · tenant-isolation + auth-conformance **63/63** · and ⭐⭐ **`AO-5`'s mechanical test for "minimum" PASSES BYTE-IDENTICALLY**: **`FAIL — 9 violation(s) in 1 category(ies)`** + **`ACKNOWLEDGED DEBT — 28 finding(s) across 12 edge(s)`**. ⚠⚠ **AND ONE CLAIM IS WITHDRAWN AS FALSIFIED BY ITS OWN MUTATION TEST.** An earlier wording asserted that *"a port wired as an import would have raised the count."* ⭐⭐ **MUTATION A DISPROVED IT:** the declaration was re-written as `{ target: platform/integration, mode: import }` and the checker still reported **`FAIL — 9` + `28 across 12`, byte-identically**. ⭐ **The reason is instructive, not alarming:** the checker reads **Dart import statements**, and ⛔ **no code uses this port yet**, so there is nothing for it to catch. ⭐ **What the unchanged baseline therefore proves is that this act added NO new coupling — it does NOT prove the `ports:`-not-`imports:` distinction is mechanically enforced today.** ⚠ **That enforcement becomes real only when the adapter is written**, and `AO-5`'s mechanical test should be re-run **then**. The manifest was restored **byte-identically** (verified by `diff`) and the baseline re-measured **unchanged**. ⛔⛔ **NOTHING IMPLEMENTED — 0 PRODUCTION CODE FILES:** `git diff` over `lib/`, `packages/`, `test/` and `pubspec.yaml` is **EMPTY**. ⛔ **0** Dart files, dependencies, SDKs, schemas, credentials or configuration · ⛔ **0** Google Cloud or Supabase resources · ⛔ `pubspec.yaml` **untouched** · ⛔ **no `IdentityProvider` class written** — ⭐ the port is **declared in the manifest**, which is a governance register, **not** code. ⛔⛔ **IMPLEMENTATION REMAINS BLOCKED, AND §14.3 SAYS SO IN TERMS:** ⛔ **`SEC-1`'s own condition is UNMET** — §7 forbids building secret storage *"unless this ADR has formally reached the **implementation stage**"*, and ⭐ **accepting a design is not entering that stage** · ⛔ **every credential is external and absent**, so **`G-3`** (*`aud` equals **our** registered client ID exactly*) is ⭐ **unprovable — there is no client ID** · ⚠ Rank-1 **`MP-DEP-03`** still demands V1 SMS+DLT, **unamended** · ⚠ **`ADR-0002`/`ADR-0005`** still `Accepted` while contradicted (**0 superseded** repo-wide) · ⚠ the **`AUTH-3.21`** re-baseline not performed. ⛔ **`BLK-01`, `BLK-02`, `IMPL-020`, `TASK-D10`, Gate 3, D3, H1–H4, `MP-DEP-07` and `ADR-0012` §3.4 ALL REMAIN OPEN** — ⭐ the **9** violations are **unrelated to authentication** and are what actually block `PRD-005`'s remaining `IMPL-*`. ⭐ **Registered in `ADR-INDEX` (registration + `Count`) and declared in `DOCUMENTATION_BASELINE` (Authority + §3.2 BC Map version cell + §8) IN THIS SAME COMMIT** — baseline §7 **rule 2** and **rule 3** discharged, **rule 1** satisfied (the ADR precedes the change). ⚠ **`BASELINE-2026-09-11-B` STANDS** — §7 **rule 4** moves the identifier only for a **Rank 1–3** version change, and the only versioned document amended is the **Rank 4** BC Map. ⛔ **No Rank 1–3 document, no frozen PRD, no permission, no `PERM-*`, no bounded context (**31**), no rank, no aggregate and no Authentication PRD v4.0.** |
| **1.0** | 2026-09-11 | ⭐⭐ **Created as `PROPOSED`.** Records **10 of 10** owner decisions for V1 Google Sign-In implementation authorisation: **`PO-1 = A`** (`Account.phone` optional contact data, ⛔ never the authentication identity or uniqueness key) · **`PO-2 = C`** (phone retained for **non-authentication** person matching/provisioning — ⭐ which preserves the `di.dart` **L256** cross-library `PersonId` match that `SID-INV-1`/`SID-INV-2` depend on, a hazard measured before the decision) · **`PO-3 = A`** (a provisioned-but-unbound account stays **`Provisioned`**, ⛔ not auto-converted to `Unlinked`) · **`PO-4`** (Google Sign-In available to all users meeting Google eligibility; ⛔ a user **MUST NOT** be blocked **solely** for being a minor; ⛔ **no** alternative V1 method) · **`AO-1`** (⭐ **new** `platform/integration:identity_provider`; ⛔ `sso_provider` **not** reused — it is manifest-scoped to *"possession challenge delivery only"* and `ADR-0128` §2.2 left its naming *"not resolved"*) · **`AO-2`** (⭐ governed relationship via the **existing** mechanism, downward-only preserved, ⛔ **no** new domain → capability dependency — ⚠ and the **`E-33`-widen / new-edge / existing-matrix** limb is **expressly left to the Architecture Owner**, since `ADR-0131` **`P-4`** bars minting an edge and **`E-34` is NOT allocated**) · **`AO-3`** (⭐ **server-side** OIDC validation is the authoritative trust boundary; **`G-1`…`G-9`** approved subject to proof by tests/gates; ⛔ the client is **never** the authority) · **`AO-4`** (Google `sub` immutable provider-identity key · `AccountId` independently generated and non-derivable · `Unlinked` valid where the lifecycle requires · **`PersonId` atomicity preserved** · ⛔ a revoked identity **MUST NOT** yield a session · ⛔ **no** background revocation-propagation mechanism unless separately governed) · **`AO-5`** (⭐ **minimum** module/dependency changes only, enumerated to five files, with the ⭐ **9 / 28 boundary baseline as the mechanical test of "minimum"**) · **`SEC-1`** (⭐ `A-9` extended to `BC-18`; ⛔ secrets **never** in source control or the client; ⛔ vault integration **not** built until the implementation stage). ⚠⚠ **THREE CONFLICTS ARE RECORDED, NOT REPAIRED:** the **`AUTH-3.21`** account-model breach (⭐ already measured by `ADR-0129` §6 as requiring *"a major version and re-baseline"*), Rank-1 **`MP-DEP-03`** still demanding V1 SMS+DLT, and **`ADR-0002`/`ADR-0005`** remaining `Accepted` while contradicted (⭐ repo measures **0 superseded** — the mechanism is untested). ⚠ **`Provisioned` is disclosed as an ADDITION** to PRD v3.0 §6.3's state table (measured: *"provisioned"* **0** occurrences; ⭐ **no closed-set language** governs the state vocabulary, so it is an addition, not a contradiction). ⛔⛔ **NOTHING IMPLEMENTED:** ⛔ **0** code, dependency, SDK, schema, credential, configuration or test files · ⛔ **0** Google Cloud or Supabase resources · ⛔ `pubspec.yaml` **untouched** · ⛔ **no** edge minted, **no** permission, **no** bounded context, **no** rank · ⛔ **`A-9` NOT executed** · ⛔ **`BLK-02`, `MP-DEP-03`, `TASK-D10`, Gate 3 and `ADR-0012` §3.4 ALL REMAIN OPEN** — ⭐ the **9** boundary violations are **unrelated to authentication** and are what actually block `PRD-005`'s remaining `IMPL-*`. ⛔ **NOT Accepted, NOT registered in `ADR-INDEX`, NOT admitted to the baseline** — ⭐ admission is a **separate governed act** requiring the three named offices. |
