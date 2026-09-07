# PRD-012a — Security Automation

> **PART 4 of 8 — Application, API, Session & Data Security.**
> Parts 1–3 are at [`PRD-012a_SECURITY_AUTOMATION.md`](./PRD-012a_SECURITY_AUTOMATION.md),
> [`PRD-012a_PART2_PLATFORM_ADMIN_SECURITY.md`](./PRD-012a_PART2_PLATFORM_ADMIN_SECURITY.md) and
> [`PRD-012a_PART3_ZERO_TRUST_IAM_TENANT_SECURITY.md`](./PRD-012a_PART3_ZERO_TRUST_IAM_TENANT_SECURITY.md).
> **None is modified by this document.**

| Field | Value |
|---|---|
| **PRD** | `PRD-012a` — Part 4 |
| **Module** | Security Automation |
| **Version** | **v0.4** (Part 4 added; Parts 1–3 unchanged) |
| **Status** | **`DRAFT`** — `PRD_LIFECYCLE.md` **Stage 2**. **This document confers no status on itself** |
| **Owning platform** | **SECURITY PLATFORM** — `[GENERIC]`, rank **2** |
| **Owning bounded context** | **None.** Part 1 §0.5 |
| **Module path** | `platform/security` (rank **2**) |
| **Product version** | **V1** — EA `Application Security` subtree is **V1**; the V2/V3 members are named in §2 |
| **Requirement prefix** | **`SECP-`** — continuing Part 1's registers |
| **Rank** | **Unranked.** **MUST NOT** be cited as authority against any ranked document |
| **Authorities applied** | As Part 3, plus `PRD-017` v0.2 `FROZEN` and `PRD-023` v0.1 `FROZEN` (Rank 3) applied directly in §7 and §8 |
| **Date** | 2026-08-21 |
| **Written at** | `e83ad29b5f2cffbde918878e20cc215d90a1b1f7` |

---

## 0. How to read Part 4

### 0.1 Normative language

As Part 1 §0.1 and Part 3 §0.1. **MUST**/**SHALL** binding; **SHOULD** a strong default requiring a recorded reason
to depart from; **MAY** genuinely optional; **directional** statements carry **no V1 obligation**.

### 0.2 What Part 4 does, and does not, do

| Part 4 does | Part 4 does **not** |
|---|---|
| State the application- and API-level properties every request path must exhibit | Define an API, endpoint, route, schema, payload or status code |
| Require server-side validation and refusal, and require it be tested | Restate `PRD-001`'s rate limiting or brute-force rules — §6 cites them |
| State session **security** obligations that apply beyond authentication | Define sessions, bounds, bindings or credentials — `BC-18` owns them |
| State sensitive-data handling obligations for surfaces this module touches | Own PII classification, data privacy or retention — §8.4 names the owners |
| Bind sensitive operations to Part 2's closed `SECP-HRO-*` set | Extend that closed set — `SECP-BR-004` closed it |
| Bind every normative requirement to a measurable criterion | Specify tables, APIs, SQL, code, UI, cloud resources or cryptographic mechanisms |

### 0.3 Identifier registers — Part 4's ranges

| Register | Meaning | Parts 1–3 | **Part 4** | Part 4 range | Reserved for Parts 5–8 |
|---|---|---|---|---|---|
| `SECP-FR-NNN` | Functional security requirement | 30 | **16** | `031`…`046` | `047`+ |
| `SECP-BR-NNN` | Business rule | 11 | **3** | `012`…`014` | `015`+ |
| `SECP-XC-NNN` | Exclusion | 22 | **4** | `023`…`026` | `027`+ |
| `SECP-OWN-NNN` | Ownership boundary | 18 | **3** | `019`…`021` | `022`+ |
| `SECP-AC-NNN` | Acceptance criterion | 57 | **19** | `058`…`076` | `077`+ |
| `SECP-GAP-NNN` | Gap / open question | 24 | **3** | `025`…`027` | `028`+ |

**Part 4 declares 48 identifiers.** Running total for `PRD-012a`: **246**.

> ⚠ **Citation is not declaration.** Out-of-range `SECP-*` numbers below are citations of Parts 1–3.

### 0.4 Prefix collision check

No new prefix. The `SECP-` selection and the `SEC-` rejection are recorded once, in Part 1 §0.4.

---

## 1. Purpose

Part 4 covers the *Prevent* stage at the **request boundary**: the properties an application or API path must exhibit
when a caller — authenticated or not, honest or not — presents input to it. It also covers the handling of
**sensitive data** on the surfaces this module is responsible for.

Its scoping constraint is the same one that shaped Parts 2 and 3, and it bites hardest here:

> `PRD-001` §8 already specifies rate limiting (`AUTH-8.16`…`8.23`), brute-force protection
> (`AUTH-8.24`…`8.28`), replay protection (`AUTH-8.29`…`8.33`) and session protection (`AUTH-8.34`…`8.39`) — at
> **Rank 3**, **`FROZEN`**. Part 4 must not restate any of it. What Part 4 adds is (a) the same properties **outside**
> authentication, where no ranked document reaches, and (b) the **verification** obligation.

---

## 2. EA scope boundary for Part 4

| EA capability | Tag | Part 4 treatment |
|---|---|---|
| `Input Sanitization` | **V1** | Normative — §5 |
| `OWASP Top 10 Coverage` | **V1** | Normative — §4.2 |
| `CSRF / XSS / SQLi Protection` | **V1** | Normative — §4.2, §5 |
| `Secure Headers` | **V1** | Normative — §4.3 |
| `Encryption in Transit` / `At Rest` | **V1** | Normative — §8.1 |
| `Dependency Vulnerability Scanning` | **V2** | **Part 7**, scoped as V2 there. Not promoted here |
| `WAF`, `DDoS Protection`, `IP Allow/Deny` | **V2** | **Excluded from V1** — `SECP-XC-023` |
| `Geo Restrictions` | **V3** | **Excluded from V1** — `SECP-XC-023` |
| `Bot & Abuse Detection` | **V2** | **Excluded from V1** — `SECP-XC-023`; the V1 substitute is §6 |
| `Field Level Encryption`, `Tokenization` | **V2 / V3** | Excluded — Part 3 `SECP-XC-021` |
| `PII Inventory`, `Data Minimization` | **V2** | **Excluded from V1** — `SECP-XC-024`; consequence in `SECP-GAP-025` |
| `DSR`, `Right to Erasure`, `RoPA`, `Residency` | **V3** | **Excluded from V1** — `SECP-XC-024` |
| `Minor Data Protection` | **V2** | **Excluded from V1** — `SECP-XC-024`; `SECP-GAP-026` records the collision with Rank 1 `MP-RSK-02` |

`SECP-XC-023` — Part 4 **MUST NOT** be read as placing a web application firewall, DDoS protection, IP allow/deny
listing, geo restriction or bot/abuse detection in V1 scope. Each is EA **V2** or **V3**. No V1 requirement below
depends on any of them. *Owner: SECURITY platform, at the version EA records.*

`SECP-XC-024` — Part 4 **MUST NOT** specify a PII inventory, a data-minimisation programme, a data-subject-request
process, an erasure workflow, a record of processing activities, a residency control or a minor-data-protection
programme. Each is EA **V2** or **V3**, and the V1 obligations that touch personal data are discharged by ranked
requirements cited in §8. *Owner: SECURITY platform (EA L2050 `Data Privacy`) with DATA platform, at V2/V3;
`MP-NFR-10` assigns compliance jointly to SECURITY and DATA.*

---

## 3. Ownership boundaries specific to Part 4

`SECP-OWN-019` — **Authentication-path abuse controls belong to `PRD-001`.** Rate limits on OTP request and
verification, per-number and per-origin quotas, temporary locks, challenge attempt budgets and their configurables
`CFG-1`…`CFG-4` and `CFG-11` are `PRD-001` §8's, at Rank 3 and `FROZEN`. Part 4 **cites** them and adds nothing to
them. *Owner: `BC-18` Identity & Access (`PRD-001`).*

`SECP-OWN-020` — **File and media handling belongs to `BC-29`.** Upload admission, virus and malware scanning,
signed-URL issuance and expiry, object metadata, derivative inheritance and tenant scoping of objects are
`PRD-017`'s — `FIL-FR-018`, `FIL-FR-019`, `FIL-FR-020`, `FIL-FR-035`…`041`, `FIL-FR-043`, `FIL-FR-047`,
`FIL-FR-066`. Part 4 adds no upload rule, no scanning rule and no URL rule. *Owner: `BC-29` File & Media
(`PRD-017`).*

`SECP-OWN-021` — **Configuration validation belongs to `BC-25`.** Type and range validation of writes, atomic
refusal, all-violations startup validation, typed accessors and total resolution are `PRD-023`'s — `CNF-FR-021`,
`CNF-FR-022`, `CNF-FR-023`, `CNF-FR-025`, `CNF-FR-035`, `CNF-FR-043`, `CNF-FR-044`, `CNF-FR-047`, `CNF-FR-049`,
`CNF-FR-050`. Part 4 adds no validation rule for configuration. *Owner: `BC-25` Configuration (`PRD-023`).*

---

## 4. Application and API security

### 4.1 Server authority

`SECP-FR-031` — Every security-relevant decision — authorisation, validation, quota, eligibility, state transition —
**SHALL** be taken on the server. A decision taken only in a client **SHALL NOT** be relied upon, and its absence
from the client **SHALL NOT** change the server's outcome. *Grounded in `AUTH-8.20`; generalised beyond authentication
by this requirement, where no ranked document reaches.*

`SECP-FR-032` — The server **SHALL NOT** accept, from a client, any value that determines its own authority: an
identity, a tenant, a role, a permission, a price, a quota, a limit, an expiry, a signature validity or a decision
outcome. Where such a value appears in a request it **SHALL** be ignored and the server's own value used, or the
request refused. *Grounded in `AUTH-8.20`, `SECP-FR-024` (tenant validated, not trusted).*

`SECP-BR-012` — **A field a client can set is a field an attacker can set.** Any request field that influences a
security outcome **SHALL** be treated as hostile input regardless of the client that normally sends it, and the
presence of a well-behaved first-party client **SHALL NOT** be accepted as mitigation. *Classifies a defect class so
it can be tested for; adds no rule about any specific field.*

### 4.2 Injection and common web weakness classes

`SECP-FR-033` — Data supplied by a caller **SHALL NOT** be interpreted as code, query, command, markup, template,
path or serialised object by any component in this module's scope. Interpretation contexts **SHALL** be separated
from data by construction rather than by escaping applied at the call site. *Grounded in EA `CSRF/XSS/SQLi
Protection` **V1** and `Input Sanitization` **V1**. This document specifies no mechanism — `SECP-XC-025`.*

`SECP-FR-034` — State-changing requests **SHALL NOT** be executable as a side effect of a caller merely visiting or
loading a resource. A state change **SHALL** require an explicit, caller-attributable request. *Grounded in EA
`CSRF Protection` **V1**.*

`SECP-FR-035` — The OWASP Top 10 weakness classes **SHALL** each have a stated V1 position in this module's scope:
either a control that addresses it, a ranked requirement that owns it, or a recorded gap. A class with no stated
position **SHALL** be treated as an unmet requirement. *Grounded in EA `OWASP Top 10 Coverage` **V1**. The obligation
is completeness of position, not a claim of immunity — Part 1 §2.2 forbids the latter.*

`SECP-XC-025` — Part 4 **MUST NOT** name a library, framework, parser, encoder, sanitiser, header value, cipher,
regular expression or configuration setting. Mechanism is implementation. `PRD-001` §8's preamble declines the same
for the same reason: *"it does not specify algorithms, ciphers, key lengths, libraries, storage layouts, transport
configuration."* *Owner: implementation, under Part 7's testing obligations.*

### 4.3 Response and transport hygiene

`SECP-FR-036` — Responses **SHALL NOT** disclose internal implementation detail — stack traces, framework versions,
file paths, query text, internal identifiers of other tenants, or the existence of resources the caller is not
authorised to know about. *Grounded in `SECP-FR-026` (indistinguishable refusals), `AUTH-8.22`, `FIL-FR-047`.*

`SECP-FR-037` — All caller-facing traffic **SHALL** be transported over an encrypted channel, and a request arriving
unencrypted **SHALL** be refused rather than redirected into a path that has already transmitted its payload.
*Grounded in EA `Encryption in Transit` **V1**.*

`SECP-FR-038` — Security-relevant response headers **SHALL** be applied by default to every response and **SHALL NOT**
depend on a per-route opt-in. A route added without explicit security configuration **SHALL** inherit the restrictive
default. *Grounded in EA `Secure Headers` **V1**; the default-restrictive direction follows `MP-GBR-07` and
`tool/module_dependencies.yaml` **L21**'s `default_decision: deny`.*

---

## 5. Input and request validation

`SECP-FR-039` — Every request **SHALL** be validated against a declared shape before any business logic executes.
Validation **SHALL** cover presence, type, range, length and enumeration membership, and **SHALL** reject rather than
coerce a value that does not conform. *The reject-rather-than-coerce direction follows `CNF-FR-021` and `CNF-FR-044`,
which `PRD-023` chose over *"the forgiving behaviour."* Configuration's own validation remains `SECP-OWN-021`'s.*

`SECP-FR-040` — Validation failure **SHALL** refuse the whole request. A request covering several items **SHALL NOT**
be partially applied. *Follows `CNF-FR-023`'s atomicity choice, applied to requests rather than to configuration
writes.*

`SECP-FR-041` — An unrecognised field, parameter or header in a request **SHALL NOT** cause the request to be
interpreted more permissively than a request without it. *Closes the class where an unknown field selects a legacy
path, a debug mode or a relaxed validator.*

`SECP-FR-042` — Validation **SHALL** be applied identically regardless of the request's origin, client type, client
version or declared user agent. *Follows `CNF-FR-025` (*"validated identically to writes originating from a product
action, a…"*) and `AUTH-8.21`/`BR-8.11` (limits identical regardless of registration status).*

`SECP-BR-013` — **Validation is a gate, not a filter.** A validator that removes offending content and proceeds
**SHALL** be treated as a defect where the requirement is refusal, because the surviving request is one no caller
actually sent and no rule was written for. *Cites `SECP-FR-039`, `SECP-FR-040`.*

---

## 6. Abuse and rate limiting — where supported

### 6.1 What already exists, at Rank 3

`PRD-001` §8 owns abuse control on the authentication path completely:

| Concern | Owner | Identifiers |
|---|---|---|
| Per-number OTP request quota, per-origin quota, minimum interval | `PRD-001` | `AUTH-8.16`, `AUTH-8.17`, `AUTH-8.18`, `CFG-1`…`CFG-3` |
| Temporary lock on quota exhaustion | `PRD-001` | `AUTH-8.19`, `CFG-4` |
| Server-side evaluation, no client influence | `PRD-001` | `AUTH-8.20` |
| Uniformity — no registration-status disclosure | `PRD-001` | `AUTH-8.21`, `BR-8.11` |
| Refusal opacity — no quota or reset disclosure | `PRD-001` | `AUTH-8.22` |
| **No bypass by any role, including platform roles** | `PRD-001` | `AUTH-8.23` |
| Challenge attempt budget; invalidation; per-challenge counting | `PRD-001` | `AUTH-8.24`, `AUTH-8.25`, `AUTH-8.26` |
| Repeated exhaustion emits a security event | `PRD-001` | `AUTH-8.27` |
| Indistinguishable verification failure modes | `PRD-001` | `AUTH-8.28` |
| Claim-attempt rate limiting | `PRD-001` | `AUTH-4.28`, `CFG-11` |

**Part 4 restates none of these and adds nothing to them** — `SECP-OWN-019`.

### 6.2 What Part 4 adds

The gap is that these rules govern the **authentication path**. No ranked document rate-limits a non-authentication
operation.

`SECP-FR-043` — An operation outside the authentication path whose abuse would impose disproportionate cost — on the
platform, on a tenant, or on a third party such as a delivery provider — **SHALL** be subject to a server-side limit,
and the limit **SHALL** be a configuration parameter owned by `BC-25` rather than a constant. *The configurable
requirement follows `CNF-FR-035`'s typed-accessor obligation and avoids `SECP-XC-014`'s duplicate-source problem; the
parameter itself is `BC-25`'s to declare, not this document's to mint.*

`SECP-FR-044` — A limit applied under `SECP-FR-043` **SHALL** exhibit the four properties `PRD-001` established for
the authentication path: server-side evaluation against server time (`AUTH-8.20`), uniformity across callers
(`AUTH-8.21`), refusal opacity (`AUTH-8.22`), and **no bypass by any role, including platform roles**
(`AUTH-8.23`). *Adopts four ranked properties by reference rather than restating them, so no second source of truth
is created.*

`SECP-FR-045` — Where an operation's abuse cost is borne by a single tenant, the limit **SHALL** be scoped so that
one tenant's exhaustion does not refuse another tenant's requests. *Grounded in `AUTH-11.20` (*"no tenant's load MUST
be capable of degrading another tenant's authentication"*), generalised beyond authentication.*

`SECP-GAP-025` — **V1 has no distributed or network-layer abuse control.** EA tags `WAF` **V2**, `DDoS Protection`
**V2**, `IP Allow/Deny` **V2** and `Bot & Abuse Detection` **V2**. `SECP-FR-043`…`045` bound the cost of abuse at the
application layer only. A volumetric or distributed attack is therefore **not** addressed at V1, and the platform's
V1 position is stated rather than implied. **Priority: Medium.** *Not an argument for promoting the V2 nodes; it is
the reason `SECP-FR-043`'s scope is "disproportionate cost" rather than "all abuse."*

---

## 7. Session security beyond authentication

### 7.1 The boundary

`PRD-001` §8 owns session protection: unpredictability and non-encoding (`AUTH-8.34`), binding to one account, one
device and one library (`AUTH-8.35`, `ADR-0004`), dual idle and absolute boundaries (`AUTH-8.36`, `CFG-5`, `CFG-6`),
per-use evaluation (`AUTH-8.37`), **sessions carry no authorization** (`AUTH-8.38`), and non-appearance in any log,
event payload, metric, error, report or support interface (`AUTH-8.39`). Global sign-out is `AUTH-8.80`; no activity
extends the absolute boundary (`AUTH-8.82`). Staff and platform sessions use the shorter bounds — 30 minutes idle,
12 hours absolute — per `AUTH-6.19` and `BR-6.7`.

Part 2 already added the platform-admin session obligations (`SECP-FR-016`, `SECP-FR-017`, `SECP-BR-007`). Part 4 adds
only what applies to **every** session at the request boundary.

`SECP-FR-046` — A session identifier or credential **SHALL NOT** appear in a URL, a query string, a referrer, a
client-side log, an analytics payload, a crash report, a screenshot surface or a support view. *Extends `AUTH-8.39`'s
prohibited-surface list to surfaces `PRD-001` does not enumerate; the ranked rule is cited, not restated. Aligns with
`AUTH-11.24` (observability contains no session identifier) and EA `PII-Safe Logging` **V1**.*

`SECP-BR-014` — **A session's continued existence is not evidence of continued entitlement.** Because `AUTH-8.38`
puts no authorization in a session, any control that infers permission, role, tenant or elevation from session
presence is a defect. *Cites `AUTH-8.38`, `SECP-FR-019`, `SECP-XC-003`.*

`SECP-XC-026` — Part 4 **MUST NOT** define a session, its lifetime, its bounds, its binding, its termination
semantics, its storage or its representation, and **MUST NOT** introduce a second session concept for security
purposes. *Owner: `BC-18` (`PRD-001` §6 and §8). Cites `SECP-XC-006`.*

---

## 8. Sensitive data and secure data handling

### 8.1 What V1 obliges

> ⚠ **Numbering note.** Part 4's `SECP-FR-*` range **closes at `046`**, as §0.3 states, and the next number belongs
> to Part 5. This note exists so that a reader who expects a data-handling requirement here does not infer that one
> was lost: none was. **No identifier is skipped inside Part 4's declared range**, and Part 4 mints no placeholder —
> writing a reserved-but-undeclared identifier into the text would make a repository-wide search report it as
> existing, which is exactly the collision hazard `PRD_LIFECYCLE.md` §5 rule 2 asks authors to avoid.

Data-handling obligations in Part 4 are carried by the requirements already declared: `SECP-FR-036` (no internal
disclosure), `SECP-FR-037` (encrypted transport), `SECP-FR-046` (no session material on prohibited surfaces), and
Part 3's `SECP-FR-030` (secrets by reference only). Part 4 adds no further `SECP-FR-*`.

### 8.2 Sensitive data on surfaces this module touches

The prohibition set that V1 actually enforces is assembled from ranked sources, and Part 4's contribution is to
require that it be **verified as a set** rather than observed piecemeal:

| Surface | Must not contain | Ranked source |
|---|---|---|
| Logs, telemetry, metrics | Personal data, credentials, session identifiers | `AUTH-11.24`; EA `PII-Safe Logging` **V1** |
| Observability signals | Individual-attributable data (tenant attribution only) | `AUTH-11.25` |
| Audit payloads | Secret references where the parameter is sensitive | `CNF-FR-059` |
| Configuration, source, build artefacts, error messages | Secret material | Part 3 `SECP-FR-030`; `CNF-FR-057`, `CNF-FR-058` |
| Object metadata | Tenant-facing business meaning | `FIL-FR-030` |
| Responses | Internal detail, other tenants' identifiers, existence of unauthorised resources | `SECP-FR-036`; `FIL-FR-047` |
| Any log, event, metric, error, report, support interface | Session identifiers | `AUTH-8.39`; `SECP-FR-046` |

`SECP-AC-070` binds verification of this set as a whole.

### 8.3 Protection of sensitive operations

Part 2 enumerated the platform-scoped high-risk operations as the **closed set** `SECP-HRO-001`…`012`, and
`SECP-BR-004` closed it with a default-refuse rule for anything unlisted that is platform-scoped, irreversible or
tenant-affecting — *"silence is not permission."*

**Part 4 does not extend that set.** It records how the set interacts with the request boundary:

- Every `SECP-HRO-*` operation is subject to `SECP-FR-019` (per-operation decision), `SECP-FR-031` (server
  authority), `SECP-FR-039` (validated shape) and `SECP-FR-028` (fail closed).
- `SECP-FR-018` (Part 2) remains **`PENDING-AUTHORITY`** and Part 4 does **not** activate it. Its re-authentication
  reading awaits `BC-18`'s confirmation per `SECP-GAP-014`, and nothing in Part 4 may be read as that confirmation.
- Tenant-scoped protected operations on identity are `SPO-1`…`SPO-9` (`PRD-003`), a closed set Part 4 likewise does
  not extend.

`SECP-GAP-026` — **`MP-RSK-02` is Rank 1 Critical; `Minor Data Protection` is EA V2.** `MASTER_PRD.md` L551 ranks
minor-safety failure **Critical**, and the platform serves study halls whose members include minors. EA L2050 tags
`Minor Data Protection` **V2** and `Data Privacy` **V2** overall. V1's protections for minors are therefore whatever
the tenant-facing PRDs already specify — notably guardianship in `PRD-003` — plus the generic controls in Parts 3–4;
**no minor-specific security capability exists at V1**. Stated, not silently promoted and not silently omitted.
**Priority: High.** *Routed to the Architecture Owner and to `PRD-003`'s owner in Part 8; this document neither
amends `PRD-003` nor promotes the EA node.*

### 8.4 Ownership of the data-privacy programme

`SECP-XC-024` already excludes PII inventory, minimisation, DSR, erasure, RoPA and residency from V1. Their owners
are EA L2050's `Data Privacy` subtree (SECURITY platform, **V2/V3**) jointly with the DATA platform under
`MP-NFR-10`. `AUD-GAP-004`'s undefined support-access list is `PRD-016`'s and is **not** adopted here.

`SECP-GAP-027` — **No V1 document classifies which fields are sensitive.** §8.2's table is assembled from seven
ranked sources, each prohibiting emission on its own surface; no single V1 artefact declares the platform's sensitive
field set, because `PII Inventory` is EA **V2**. Verification under `SECP-AC-070` is therefore per-source rather than
against a canonical classification. **Priority: Medium.** *This is the concrete cost of `PII Inventory` being V2, and
is recorded rather than closed.*

---

## 9. Acceptance criteria

| ID | Criterion | Binds |
|---|---|---|
| `SECP-AC-058` | For a sampled operation, the security decision is observed on the server; removing or disabling the client-side check does not change the outcome | `SECP-FR-031` |
| `SECP-AC-059` | A request supplying each of identity, tenant, role, permission, quota, limit, expiry and outcome as client fields is submitted; in every case the server's own value is used or the request is refused, and no supplied value takes effect | `SECP-FR-032`, `SECP-BR-012` |
| `SECP-AC-060` | Caller-supplied data placed in code, query, command, markup, template, path and serialised-object positions is not interpreted in any of the seven cases; separation is by construction, evidenced in the design record | `SECP-FR-033` |
| `SECP-AC-061` | A state change cannot be produced by a caller loading a resource; an attempt produces no state change and is refused | `SECP-FR-034` |
| `SECP-AC-062` | Each OWASP Top 10 class has a recorded V1 position — control, ranked owner, or gap — and the count of classes with a position equals ten | `SECP-FR-035` |
| `SECP-AC-063` | Responses under fault and refusal conditions are inspected and contain no stack trace, framework version, file path, query text, other tenant's identifier, or existence signal for an unauthorised resource | `SECP-FR-036` |
| `SECP-AC-064` | An unencrypted request is refused, and inspection confirms the payload was not first transmitted to an application handler | `SECP-FR-037` |
| `SECP-AC-065` | A route added without explicit security configuration is observed to carry the restrictive default headers; the count of routes lacking them is zero | `SECP-FR-038` |
| `SECP-AC-066` | For a sampled operation, requests violating presence, type, range, length and enumeration membership are each refused, not coerced — five cases, five refusals | `SECP-FR-039`, `SECP-BR-013` |
| `SECP-AC-067` | A multi-item request with one invalid item leaves no item applied; the store is unchanged | `SECP-FR-040`, `SECP-BR-013` |
| `SECP-AC-068` | A request bearing an unrecognised field, parameter and header is not treated more permissively than the same request without them; outcomes are identical | `SECP-FR-041` |
| `SECP-AC-069` | The same invalid request submitted with differing origin, client type, client version and user agent is refused identically in all four cases | `SECP-FR-042` |
| `SECP-AC-070` | Each of the seven surfaces in §8.2 is inspected against its stated prohibition and contains no prohibited content; seven checks, zero occurrences | §8.2; `SECP-FR-036`, `SECP-FR-037`, `SECP-FR-046` |
| `SECP-AC-071` | For each operation designated under `SECP-FR-043`, a server-side limit is observed, and the limit's value is read from a `BC-25` parameter rather than from a constant in this module | `SECP-FR-043` |
| `SECP-AC-072` | A limit under `SECP-FR-043` is verified for all four adopted properties: server-time evaluation, uniformity, refusal opacity, and refusal to bypass for a Platform Administrator | `SECP-FR-044` |
| `SECP-AC-073` | Tenant A exhausting a limit does not cause refusal of tenant B's requests for the same operation | `SECP-FR-045` |
| `SECP-AC-074` | URLs, query strings, referrers, client logs, analytics payloads, crash reports and support views are inspected; no session identifier or credential appears in any of the seven | `SECP-FR-046` |
| `SECP-AC-075` | An operation attempted with a valid session but without a current authorisation decision is refused; session presence alone grants nothing | `SECP-BR-014` |
| `SECP-AC-076` | Part 4 declares no API, endpoint, route, schema, status code, session concept, library, cipher or header value; a search for such a declaration returns none | `SECP-XC-025`, `SECP-XC-026`, `SECP-OWN-019`…`021` |

### 9.1 Coverage table

| Requirement | Criterion | Requirement | Criterion |
|---|---|---|---|
| `SECP-FR-031` | `AC-058` | `SECP-FR-040` | `AC-067` |
| `SECP-FR-032` | `AC-059` | `SECP-FR-041` | `AC-068` |
| `SECP-FR-033` | `AC-060` | `SECP-FR-042` | `AC-069` |
| `SECP-FR-034` | `AC-061` | `SECP-FR-043` | `AC-071` |
| `SECP-FR-035` | `AC-062` | `SECP-FR-044` | `AC-072` |
| `SECP-FR-036` | `AC-063`, `AC-070` | `SECP-FR-045` | `AC-073` |
| `SECP-FR-037` | `AC-064`, `AC-070` | `SECP-FR-046` | `AC-074`, `AC-070` |
| `SECP-FR-038` | `AC-065` | `SECP-BR-012` | `AC-059` |
| `SECP-FR-039` | `AC-066` | `SECP-BR-013` | `AC-066`, `AC-067` |
| `SECP-BR-014` | `AC-075` | `SECP-XC-023` | `AC-076` |
| `SECP-XC-024` | `AC-076` | `SECP-XC-025` | `AC-076` |
| `SECP-XC-026` | `AC-076` | `SECP-OWN-019`…`021` | `AC-076` |

**16 `SECP-FR-*`, 3 `SECP-BR-*`, 4 `SECP-XC-*` and 3 `SECP-OWN-*` are declared in Part 4; all 26 are bound above.
Uncovered: none.**

---

## 10. Gaps declared in Part 4

| ID | Gap | Priority | Blocked by |
|---|---|---|---|
| `SECP-GAP-025` | No V1 distributed or network-layer abuse control; WAF, DDoS, IP allow/deny and bot detection are all EA **V2** | Medium | EA L2050 version tags |
| `SECP-GAP-026` | `MP-RSK-02` minor-safety is Rank 1 **Critical**, yet `Minor Data Protection` is EA **V2**; no minor-specific security capability exists at V1 | **High** | EA L2050 version tag; `PRD-003` owns guardianship |
| `SECP-GAP-027` | No V1 artefact classifies the platform's sensitive field set; `PII Inventory` is EA **V2**, so §8.2 verification is per-source, not canonical | Medium | EA L2050 version tag |

---

## 11. Lifecycle status

**Stage 2 (Draft),** on the same basis as Part 3 §11: file on disk, versioned header, registers declared with
contiguous ranges, normative language defined, no new prefix. Stage 1's gate remains unmet and disclosed (no
security `BC-nn`; `SECP-GAP-010`), with authority to proceed from `PRD_REGISTRY.md` §4.1. Stage 5 not started;
`SECP-` not registered in `TRACEABILITY_MATRIX.md`. **Freeze is conferred, not claimed.**

---

## 12. Change history

| Version | Date | Change |
|---|---|---|
| v0.4 | 2026-08-21 | Part 4 created. 48 identifiers: `SECP-FR-031`…`046`, `SECP-BR-012`…`014`, `SECP-XC-023`…`026`, `SECP-OWN-019`…`021`, `SECP-AC-058`…`076`, `SECP-GAP-025`…`027`. `PRD-001` §8's rate-limiting, brute-force, replay and session-protection rules **cited, never restated** (`SECP-OWN-019`); `PRD-017`'s upload/scan/signed-URL rules and `PRD-023`'s validation rules likewise (`SECP-OWN-020`, `SECP-OWN-021`). Non-authentication abuse limiting added where no ranked document reaches (`SECP-FR-043`…`045`), adopting four `PRD-001` properties **by reference**. WAF/DDoS/bot detection held **V2** (`SECP-XC-023`, `SECP-GAP-025`); PII inventory, DSR, erasure, residency and minor-data protection held **V2/V3** (`SECP-XC-024`, `SECP-GAP-026`, `SECP-GAP-027`). §8.1 records a range-boundary note, minting **no** placeholder identifier, so that no reader infers a lost requirement and no repository-wide search reports one as existing. `SECP-HRO-*` and `SPO-*` closed sets **not extended**; `SECP-FR-018` left `PENDING-AUTHORITY`. No identifier from Parts 1–3 renumbered, reworded or withdrawn. |
