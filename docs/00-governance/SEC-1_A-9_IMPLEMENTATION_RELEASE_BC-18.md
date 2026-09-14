# LIBOORA — `SEC-1` / `A-9` Implementation Release for `BC-18` (V1 Google Sign-In)

| Field | Value |
|---|---|
| **Document** | `SEC-1_A-9_IMPLEMENTATION_RELEASE_BC-18.md` |
| **Version** | **v1.0** |
| **Status** | ⭐ **RECORD OF A CONFERRAL.** This document **records** a security release conferred elsewhere; ⛔ it does **not** confer it, and ⛔ it decides nothing of its own. *"Status is **conferred** … **never claimed by a document about itself**"* (`ADR-0131` §8.2 **`P-7`**) |
| **Rank** | ⛔ **Not ranked.** Subordinate to every document it cites. Where this and a PRD/ADR differ, **the PRD/ADR wins** |
| **Date** | 2026-09-11 |
| **Recorded at** | `02c529f06b10af91497d2b55e3aedb9743e9c1e2` |
| **Conferring office** | ⭐ **SECURITY PLATFORM** — exercised by the human principal under a **one-act** conferral, ⛔ **reverting on completion** (`ADR-0033` §7.1). ⛔ **The office is vacant as constituted**; ⛔ **no independent review, ARB quorum or external Security audit is claimed** |
| **Subject** | `ADR-0146` **`SEC-1`** — the `A-9` secret-custody **implementation step** for **`BC-18` Identity & Access**, V1 Google Sign-In |
| **Scope** | ⛔ **`BC-18` ONLY.** ⛔ **NOT a standing licence.** ⛔ Confers **no** Product, Architecture or Governance authority |
| **Amends** | ⛔ **NOTHING.** ⛔ `ADR-0146` is **byte-unchanged** and its status remains **`Accepted`** — ⭐ `ADR-INDEX` **L206**: *"Never edit an Accepted ADR's decision text."* ⛔ No PRD, ADR, BC Map, Matrix, manifest or baseline is modified |
| **Baseline** | ⚠ **`BASELINE-2026-09-11-B` STANDS.** §7 **rule 4** moves the identifier only for a **Rank 1–3** version change; ⛔ this document is **unranked** and amends nothing. ⭐ §7 **rule 1** is not engaged — ⛔ **no Rank 1–5 document changes** |
| **Code impact** | ⛔ **NONE.** **0** files under `lib/`, `packages/`, `test/`, `tool/`, `android/`, `web/`; ⛔ `pubspec.yaml` untouched |

---

## 1. Why this document exists, and why it is not an ADR

⭐ **`SEC-1` was already `Accepted`. What was withheld was narrower than an approval.** `ADR-0146` §7 approved the
extension of `A-9` to `BC-18` **and** the prohibitions, while withholding exactly one thing:

> ⛔ *"**Do NOT implement secret storage / vault integration yet** unless this ADR has formally reached the
> implementation stage."*

§10 states the consequence in terms: *"`SEC-1` **approves the extension**; ⛔ vault integration **not** to be built
until this ADR reaches the implementation stage."*

⭐⭐ **So the gate was never a missing decision — it was an unmet condition**, and the condition names a **stage**.
That stage is defined: `PRD_LIFECYCLE` **L182** — **"Stage 8 — Implementation"**, governed by
`DEFINITION_OF_DONE` v1.2 and the six pipeline gates of Dependency Matrix §10.4.

⛔ **An ADR would be the wrong instrument.** Releasing a step that an `Accepted` ADR already conditioned is the
**exercise** of `SEC-1`, not an amendment to it. Writing an ADR would imply `ADR-0146` needed changing; it does
not, and **L206** forbids editing its decision text. ⭐ This follows the **`PAYMENT_GOVERNANCE_RESOLUTION.md`**
precedent — an unranked governance record in `docs/00-governance/`, deliberately **absent from baseline §3**,
which is a table of **ranked** authority.

---

## 2. The conferral, as received

> ⭐⭐ **SEC-1 IMPLEMENTATION RELEASE — APPROVED.** Acting as **SECURITY PLATFORM**, the principal confers the
> one-act implementation release for `SEC-1`/`A-9` for `BC-18` V1 Google Sign-In.

| # | Conferred term | Disposition |
|---|---|---|
| **R-1** | `A-9` secret custody is **RELEASED for implementation** | ⭐ **RECORDED** — `ADR-0146` §11's gate condition is **MET** |
| **R-2** | **Vault integration is AUTHORISED** for the **Google client secret** and the **Supabase service-role key** | ⭐ **RECORDED** — ⛔ authorised, **not performed**; ⛔ **0 vault entries created by this act** |
| **R-3** | Google **client ID** and Supabase **anon key** **MUST be supplied through build-time configuration / injection** and **MUST NOT be committed to source control** | ⭐⭐ **RECORDED — and this RESOLVES the one genuinely open question.** `ADR-0146` §7 left these *"⚠ Per SECURITY PLATFORM direction at implementation"*; ⭐ **the direction is now given, and it is the stricter of the two available readings** |
| **R-4** | **Client secret**, **Supabase service-role key** and **Android SHA-1 / SHA-256** **MUST NEVER** enter source control or the client application | ⭐ **RECORDED** — ⭐ restates `ADR-0146` §7 unweakened |
| **R-5** | `ADR-0146` **§11 may proceed from step 2** | ⭐ **RECORDED** — ⛔ **step 2 is not started by this act** |
| **R-6** | **One-act conferral, `BC-18` only; NOT a standing licence** | ⭐ **RECORDED** — ⭐ expires on completion (`ADR-0033` §7.1) |

### 2.1 ⭐ The custody table as it now stands

⭐ **`R-3` changes one column for two rows and nothing else.** The table is restated in full so the delta is
visible rather than implied:

| Artefact | Custody | In source control? |
|---|---|---|
| Google **client secret** | SECURITY PLATFORM vault | ⛔ **NEVER** *(`R-4`)* |
| Supabase **service-role key** | SECURITY PLATFORM vault | ⛔ **NEVER** *(`R-4`)* |
| Android **SHA-1 / SHA-256** | Signing infrastructure | ⛔ **NEVER** *(`R-4`)* |
| Google **client ID** *(public by design)* | ⭐ **Build-time configuration / injection** | ⛔ **NO — MUST NOT be committed** *(`R-3`)* |
| Supabase **anon key** *(public by design)* | ⭐ **Build-time configuration / injection** | ⛔ **NO — MUST NOT be committed** *(`R-3`)* |

⚠⚠ **`R-3` IS STRICTER THAN `ADR-0146` §7 PERMITTED, AND THAT IS RECORDED AS A TIGHTENING, NOT A REINTERPRETATION.**
§7 classified the client ID and anon key as *"public by design"* and left the source-control question open to
SECURITY PLATFORM direction. ⭐ The direction given **forecloses committing them**. ⛔ **Nothing is weakened**; a
prohibition is added within the discretion §7 expressly reserved.

⭐⭐ **The engineering consequence, stated plainly so no later pass mistakes it:** ⛔ **no Dart source file, no
`pubspec.yaml`, no `web/index.html`, no `AndroidManifest.xml` and no committed `.json` may contain the client ID
or the anon key.** ⭐ They arrive by **`--dart-define`**, an **injected untracked file**, or CI-provided
environment — the **mechanism is a DevOps/implementation choice**, ⛔ **not decided here**.

⚠ **`google-services.json` is named explicitly, because it is the likely trap.** It carries the OAuth client ID.
⭐ It is already covered by `.gitignore` **L23** (`**/google-services.json`) — ⛔ **that line MUST NOT be removed
or narrowed**, and the file MUST NOT be force-added.

---

## 3. What this act does — and does NOT — do

### 3.1 ⭐ What is now unblocked

⭐ **`ADR-0146` §11's gate condition is MET:** the ADR is `Accepted` **and** `SEC-1`'s implementation step is
released. ⭐ Steps **2 → 13** are unblocked **as authority**; ⛔ **none is started**.

### 3.2 ⛔ What this act deliberately does NOT do

- ⛔ **0 secrets created.** No client secret, service-role key, anon key, client ID, keystore, fingerprint or token
- ⛔ **0 vault entries created** — `R-2` **authorises**, it does not perform
- ⛔ **0 Google Cloud resources** — no project, consent screen, OAuth client or redirect URI
- ⛔ **0 Supabase resources** — no project, region, provider configuration or callback URL
- ⛔ **0 lines of code**; ⛔ **no `IdentityProvider` class**; ⛔ **no dependency added**
- ⛔ **`ADR-0146` NOT modified** — status remains **`Accepted`**, text **byte-unchanged**
- ⛔ **No placeholder, sample or example value** is recorded anywhere — ⭐ a placeholder is indistinguishable from a
  real value in a later diff, and **`G-3`** requires `aud` to equal **our** client ID *exactly*
- ⛔ **No Product, Architecture or Governance authority** is exercised, claimed or implied

---

## 4. ⚠⚠ A CONTRADICTION INSIDE `ADR-0146` IS DISCLOSED, NOT REPAIRED

⚠ `ADR-0146` contradicts itself on **external configuration**:

| Locus | Text | Effect |
|---|---|---|
| **§10**, L372 | External configuration is *"⭐ **Startable in parallel; needs no ADR**"* | would permit it **before** this release |
| **§11**, L382 | *"⛔ **No step below may begin** until this ADR is `Accepted` **AND** `SEC-1`'s implementation step is released"* — and external configuration is **step 2** | ⛔ **forbids** it until now |

⭐ **§11 was treated as controlling** while the release was outstanding — the specific, sequenced provision over
the general summary, and the conservative reading. ⭐⭐ **This release renders the conflict MOOT for practical
purposes**, since both limbs now permit external configuration. ⚠ **But the defect is not cured**, and it is
recorded rather than silently passed over: a future reader of §10 alone would draw the wrong conclusion about the
gate that existed between acceptance and this release.

⛔ **NOT repaired here.** Repair means editing an `Accepted` ADR's text, which **L206** forbids — it requires a
**successor ADR**. **Owner: Governance Owner.**

---

## 5. Remaining blockers — measured at `02c529f`, after this release

| # | Blocker | Status | Owner |
|---|---|---|---|
| **1** | **External configuration** — Google Cloud project, consent screen, OAuth client IDs (Android + Web), redirect URIs, Supabase project + Google provider | ⭐ **UNBLOCKED as authority; ⛔ NOT performed** — ⛔ withheld by the principal's *"do not create Google/Supabase resources yet unless separately instructed"* | DevOps Platform + Product Owner |
| **2** | **Android signing keystore** | ⛔ **ABSENT** — measured: `android/release-key.jks` **missing**, `~/.android/debug.keystore` **missing**. ⭐ So **SHA-1/SHA-256 CANNOT be extracted** and the Android OAuth client cannot be completed. ⭐ `keytool` **is available** at `/usr/bin/keytool` | DevOps Platform |
| **3** | **`G-1`…`G-9` unprovable** | ⛔ **BLOCKED BY #1** — **`G-3`** requires `aud` to equal *"**our** registered client ID **exactly**"*, and ⛔ **there is no client ID**. ⭐ No test can pass against a credential that does not exist | — *(consequential)* |
| **4** | **Rank-1 `MP-DEP-03`** | ⛔ **OPEN** — still demands V1 SMS + TRAI DLT while `AUTH-3.42` forbids V1 OTP; ⛔ **unamended**, and ⭐ **Rank 1 outranks `ADR-0146`** | Product + Architecture Owner |
| **5** | **`ADR-0002` / `ADR-0005` supersession** | ⛔ **NOT EXECUTED** — both still `Accepted` while contradicted; ⚠ repo measures **0 superseded, 0 deprecated** — the mechanism is **untested** | Governance Owner |
| **6** | **`AUTH-3.21` re-baseline** | ⛔ **OPEN** — `ADR-0129` §6 measured it as requiring *"a major version and re-baseline"* | Governance Owner |
| **7** | **`ADR-0012` §3.4 / Gate 3** | ⛔ **OPEN — 9 violations.** ⭐ **Unrelated to authentication**; needs §4 **Wave 4** port extraction. ⭐ *This, not authentication, is what blocks `PRD-005`'s remaining `IMPL-*`* | Architecture Owner |
| **8** | **§10/§11 contradiction** (§4 above) | ⚠ **DISCLOSED, not repaired** — needs a successor ADR | Governance Owner |

⭐⭐ **`SEC-1` / `A-9` IS NO LONGER ON THIS LIST.** ⭐ It was the single gate; it is released. ⛔ **Blockers 4–7
pre-date authentication and are not cured by this act.**

---

## 6. Verification performed

| Check | Result |
|---|---|
| `ADR-0146` status | ⭐ **`Accepted`** — unchanged by this act |
| `ADR-0146` text | ⛔ **byte-unchanged** |
| Secrets tracked in git | ⭐ **0** — `git ls-files` over `*.jks`, `*.keystore`, `key.properties`, `google-services.json`, `*.env`, `adminsdk` |
| `.gitignore` secret coverage | ⭐ **PRESENT** — `android/key.properties` (L14), `android/*.jks` (L15), `*.keystore` (L16), `**/google-services.json` (L23), `*.env` / `.env*` (L25–26). ⛔ **Unmodified by this act** |
| Client-side credential leakage | ⭐ **0** — `web/index.html` contains **0** `client_id` / `google` / `gsi` references |
| Android package identity | ⭐ **consistent** — `applicationId`, `namespace`, `MainActivity.kt` path and its `package` all `com.liboora.app` |
| Production code | ⛔ **untouched** |

---

## 7. Change history

| Version | Date | Change |
|---|---|---|
| **1.0** | 2026-09-11 | ⭐⭐ **Created as a RECORD of the `SEC-1` / `A-9` implementation release for `BC-18`**, conferred by the human principal acting as **SECURITY PLATFORM** under a **one-act** conferral that ⛔ **reverts on completion** (`ADR-0033` §7.1); ⚠ the office is **vacant as constituted** and ⛔ **no independent review or external Security audit is claimed**. ⭐ **Records `R-1`…`R-6`**: `A-9` **RELEASED for implementation** · vault integration **AUTHORISED** for the Google client secret and Supabase service-role key · ⭐⭐ **`R-3` RESOLVES the one open question `ADR-0146` §7 reserved** — the Google **client ID** and Supabase **anon key** **MUST** arrive by **build-time configuration/injection** and ⛔ **MUST NOT be committed**, which is ⭐ **stricter than §7 permitted and is recorded as a tightening, not a reinterpretation** · ⛔ client secret, service-role key and Android **SHA-1/SHA-256** **NEVER** in source control or the client · `ADR-0146` **§11 may proceed from step 2** · ⛔ **`BC-18` only, not a standing licence**. ⭐ **`SEC-1`/`A-9` is REMOVED from the blocker list** — it was the single gate. ⛔⛔ **NOTHING PERFORMED:** ⛔ **0** secrets, vault entries, Google Cloud resources, Supabase resources, keystores, fingerprints, tokens, dependencies or lines of code; ⛔ **0** placeholder or example values (⭐ a placeholder is indistinguishable from a real value in a later diff, and **`G-3`** needs **our** client ID *exactly*); ⛔ **`ADR-0146` byte-unchanged and still `Accepted`** — ⭐ `ADR-INDEX` **L206** forbids editing an `Accepted` ADR's decision text, which is also ⭐ **why this is a record and not an ADR**: releasing a step an `Accepted` ADR already conditioned is the **exercise** of `SEC-1`, not an amendment to it. ⭐ **Instrument chosen on the `PAYMENT_GOVERNANCE_RESOLUTION.md` precedent** — an **unranked** governance record in `docs/00-governance/`, deliberately ⛔ **absent from baseline §3**, which is a table of **ranked** authority. ⚠⚠ **A CONTRADICTION INSIDE `ADR-0146` IS DISCLOSED, NOT REPAIRED:** §10 **L372** calls external configuration *"Startable in parallel; needs no ADR"* while §11 **L382** gates **every** step — including step 2, external configuration — behind this very release; ⭐ §11 was treated as controlling (specific over general, conservative reading), ⭐ this release makes the conflict **moot in practice**, ⛔ but the defect **stands** and needs a **successor ADR** — **Governance Owner**. ⚠ **`ADR-0146` §10's *"Startable in parallel"* cell is therefore now accurate by accident, not by repair.** ⛔ **REMAINING BLOCKERS:** external configuration (⭐ unblocked as authority, ⛔ **withheld by the principal's instruction** — *"do not create Google/Supabase resources yet"*) · ⛔ **no Android keystore exists** (`release-key.jks` and `~/.android/debug.keystore` both measured **missing**, so **SHA-1/SHA-256 cannot be extracted**; `keytool` **is** present) · ⛔ **`G-1`…`G-9` unprovable** while **`G-3`** has no client ID to match · ⚠ Rank-1 **`MP-DEP-03`** unamended and **outranking** · ⚠ **`ADR-0002`/`ADR-0005`** supersession NOT executed (**0 superseded** repo-wide — untested mechanism) · ⚠ **`AUTH-3.21`** re-baseline · ⛔ **`ADR-0012` §3.4 / Gate 3** — **9** violations, ⭐ **unrelated to authentication** and ⭐ **what actually blocks `PRD-005`'s remaining `IMPL-*`**. ⚠ **`BASELINE-2026-09-11-B` STANDS** — ⛔ this document is **unranked** and amends **nothing**, so §7 rule 4's limb is unmet and rule 1 is not engaged. ⛔ **No PRD, ADR, BC Map, Matrix, manifest or baseline modified; no permission, `PERM-*`, edge, port, bounded context, rank or aggregate created.** |
