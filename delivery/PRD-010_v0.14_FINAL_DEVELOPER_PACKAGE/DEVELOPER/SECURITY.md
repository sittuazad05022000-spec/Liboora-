# Security Policy

| Field | Value |
|---|---|
| **Applies to** | The Liboora repository and any deployment built from it |
| **Version** | v1.0 |
| **Date** | 2026-08-04 |
| **Authoritative specification** | [`docs/30-product/authentication/prd-v2/08-Security-and-Privacy.md`](./docs/30-product/authentication/prd-v2/08-Security-and-Privacy.md) |

This document explains **how to report a vulnerability** and states the **security rules that apply when writing
code**. It does not restate the security specification. Where this document and the Authentication PRD disagree,
**the PRD governs** — see [`docs/00-governance/DOCUMENTATION_BASELINE.md`](./docs/00-governance/DOCUMENTATION_BASELINE.md) §4
for the precedence order.

---

## 1. Reporting a vulnerability

**Do not open a public issue, pull request or discussion for a security vulnerability.** A public report tells
attackers before it tells maintainers.

| Step | Action |
|---|---|
| 1 | Report **privately** to the maintainers — use GitHub's *Report a vulnerability* (Security → Advisories) or a private channel to a maintainer |
| 2 | Include: affected version or commit SHA, component, reproduction steps, observed and expected behaviour, and impact |
| 3 | Wait for acknowledgement before any disclosure |

**What to expect:**

| Stage | Target |
|---|---|
| Acknowledgement of your report | 3 working days |
| Initial assessment and severity | 10 working days |
| Fix or documented mitigation for High and Critical | 30 days from confirmation |
| Public disclosure | Coordinated with you, after a fix is available |

Please practise **coordinated disclosure**: give us a reasonable window to ship a fix. We will credit reporters who
wish to be credited.

### 1.1 In scope

Vulnerabilities in this repository's code, dependency configuration, architecture-enforcement tooling, or in
documented behaviour that would produce an insecure implementation if followed.

**Especially in scope — the two highest-value classes for this product:**

| Class | Why it matters here |
|---|---|
| **Cross-tenant data access** | Liboora is multi-tenant. Data belonging to one library must never be reachable from another. Treated as **blocker severity** |
| **Authentication bypass** | Mobile OTP is the sole V1 factor. Any path to a session without a verified OTP is critical |

### 1.2 Out of scope

Reports with no security impact: results from automated scanners without a demonstrated exploit; missing hardening
headers on a local development server; the deliberately non-zero exit of
`tool/check_module_boundaries.dart` (see [`docs/00-governance/adr/ADR-0012-scaffold-port-inversion-debt.md`](./docs/00-governance/adr/ADR-0012-scaffold-port-inversion-debt.md)).

The demo and seed data under `lib/bootstrap/seed.dart` is **not** production data. Weaknesses there are tracked as
`TASK-D10` (removal of demo surfaces before release), not as vulnerabilities — but a weakness that would *survive*
`TASK-D10` is in scope.

---

## 2. Secrets management

**No secret belongs in this repository.** Not in code, not in a comment, not in a test fixture, not in a commit
message, and not "temporarily."

`.gitignore` already excludes the files most often leaked:

```
**/google-services.json      Firebase Android configuration
**/GoogleService-Info.plist  Firebase iOS configuration
android/key.properties       Release signing credentials
android/*.jks · *.keystore   Signing keystores
*.env · .env*                Environment files
```

**Rules:**

| Rule | Detail |
|---|---|
| Never commit a credential | API keys, tokens, signing keys, DLT credentials, service-account JSON, connection strings |
| Never weaken these ignores | Removing an entry above requires review and a stated reason |
| Supply configuration at build or run time | Not from a checked-in file |
| Treat any exposed secret as compromised | **Rotate it.** Deleting the commit is not sufficient — it remains in history and in every clone and fork |
| Keep signing material out of the sandbox | Release keystores are held by the release owner |

If you discover a committed secret, report it privately per §1 — do **not** open a public issue naming it.

---

## 3. Authentication rules

These derive from the Authentication PRD v2.0. They are restated because violating them is the most common way to
introduce a critical defect.

| Rule | Detail |
|---|---|
| **There are no passwords** | Not hashed, not optional, not "for admins." None. Mobile number plus one-time code is the sole V1 factor |
| **No secret in a log** | Never log an OTP, a session token, or a full mobile number |
| **Refusals must be indistinguishable** | An authentication or claim refusal must not reveal whether an account exists. See `AUTH-4.32` |
| **Knowledge is not proof** | Knowing a person's details never authenticates them; an account claim requires verification. See `AUTH-4.27` |
| **One Account maps to exactly one Person identity** | Created in the same transaction. See `SID-4.11` and [`docs/00-governance/adr/ADR-0011-global-person-identity.md`](./docs/00-governance/adr/ADR-0011-global-person-identity.md) |
| **Tenant scope is mandatory on tenant data** | A tenant-less query on tenant data is a **blocker**, not a bug to schedule |

---

## 4. Security best practices for contributors

| Practice | Detail |
|---|---|
| **Validate at the boundary** | Never trust client input. Re-validate in the domain layer even when the UI has already checked |
| **Authorise server-side** | Hiding a widget is not authorisation. Enforce the decision where the data is |
| **Fail closed** | On ambiguity — an unparseable policy, an unknown tenant, a missing claim — deny. The boundary checker follows the same rule: it halts rather than passing when it cannot understand its own configuration |
| **Least privilege** | Grant the narrowest role and scope that works |
| **Do not log personal data** | Minimise, and never log identity fields alongside identifiers |
| **Honour erasure semantics** | Erasure anonymises the Person and retains `StudentRecord` history (`ID-5`). Do not implement it as a hard delete |
| **Keep dependencies deliberate** | Flutter 3.35.4 / Dart 3.9.2 are version-locked. Adding a dependency is an architectural decision — see [`CONTRIBUTING.md`](./CONTRIBUTING.md) |
| **Never silence a security-relevant check** | If a check is wrong, change the rule through an ADR |

### 4.1 Known gaps, stated honestly

Two specified enforcement checks are **not implemented**, and per `SID-4.56` — *a rule that cannot be checked
SHALL be treated as unmet* — they are recorded as unmet rather than assumed satisfied:

| Check | Status | Consequence |
|---|---|---|
| `X-13` tenant-key check | **Not implemented** | Tenant-key discipline is review-verified only. Should be implemented before any persistent datastore |
| `X-10` audit-mutation check | **Not implemented** | Audit immutability is review-verified only |

Current status is authoritative in
[`docs/40-implementation/IMPLEMENTATION_STATUS.md`](./docs/40-implementation/IMPLEMENTATION_STATUS.md).

---

## 5. Supported versions

The project is pre-release. Only `main` receives security fixes; there are no maintained release branches yet.

| Version | Supported |
|---|---|
| `main` | ✅ |
| Any earlier commit or tag | ❌ — rebase onto `main` |

---

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-04 | Created. Reporting process, secrets management, authentication rules, contributor practices, and the two unmet enforcement checks recorded per `SID-4.56` |
