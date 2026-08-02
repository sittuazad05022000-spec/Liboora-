# Enterprise Review — Library PRD §14A, Library Discovery & Enrollment

**Reviewed document:** [`14A-Library-Discovery-And-Enrollment.md`](./14A-Library-Discovery-And-Enrollment.md) (captured verbatim)
**Review date:** 2026-08-02
**Reviewer roles:** Principal Software Architect · Staff Engineer · Enterprise PM · Domain Architect · Security Architect · Senior QA
**Verdict at time of review:** **REQUIRES MAJOR REVISION** — 7 confirmed conflicts, 2 of them blocking.

---

## 0. Post-ruling status — updated 2026-08-02

The product owner has issued rulings `AR-1`…`AR-4`
([`ARCHITECTURE_RULINGS.md`](../../architecture/ARCHITECTURE_RULINGS.md)). The review body below is preserved
**unedited** as the historical record. This section records the current disposition of each conflict.

| Conflict | Ruling | Disposition |
|---|---|---|
| `CC-1` Capability unregistered | `AR-1` | ✅ **Resolved.** Registered as a read composition, `MASTER_PRD.md` §8 module 19, *not a context*. Context count unchanged at 31 |
| `CC-2` Cross-tenant index vs `X-13` | `AR-3` | ✅ **Resolved at architecture level.** Platform Public Discovery Index distinguished from Tenant Operational Data, Context Map §11.1. `MP-GBR-08`, `SE-1`, `X-13` remain in force, unmodified |
| `CC-3` Six owners in one profile | `AR-1` | ✅ **Resolved.** Discovery composes and references; owns nothing. ⚠ §14A.5 / §14A.7 / `LIB-DISC-007` wording corrections outstanding for the next PRD revision |
| `CC-4` Flow unimplementable | `AR-2` | ⚠ **Architecture confirmed; implementation gap OPEN.** Account creation on first successful OTP explicitly approved. Divergence documented in [`ACR-001`](../authentication/ACR-001-OTP-Account-Creation.md). **No production code changed** pending approval |
| `CC-5` Notifications contradiction | — | ⬜ **Outstanding.** Documentation wording, next PRD revision |
| `CC-6` Maps vendor knowledge | — | ⬜ **Outstanding.** Documentation wording, next PRD revision |
| `CC-7` Invitations unowned | `AR-4` | ◐ **Ownership resolved** — Library Management / Tenant Organization. **Security specification deferred by ruling; must not be invented** |
| `R-A`…`R-G` | — | ⬜ **Outstanding.** Documentation only |
| `U-1`…`U-6` | — | ⬜ **Still unverified.** `U-4` (§§1–25 not supplied) remains the largest gap |

**Revised freeze readiness: REQUIRES MINOR CHANGES — blocked only by `U-4`.** All four structural blockers are
ruled. What remains is documentation wording (`CC-3` residue, `CC-5`, `CC-6`, `R-A`…`R-G`), one approval gate
(`ACR-001`), one deferred specification (`AR-4` security rules), and the unsupplied §§1–25 — which alone
prevents a freeze, since §14A cannot be frozen in isolation from the document it belongs to.

---

## 1. Method and sources

Every finding below cites a document that **exists on disk in this repository**. Nothing is asserted from
conversation memory. Where a required source does not exist, the observation is classified **Unverified**
rather than resolved.

| # | Authoritative source | Path | Status |
|---|---|---|---|
| 1 | Foundation | — | ⚠️ Ambiguous / absent (`U-1`) |
| 2 | Master PRD | `docs/prd/MASTER_PRD.md` | ✅ 696 lines, 36 sections |
| 3 | System Architecture | `docs/architecture/LIBOORA_ENTERPRISE_ARCHITECTURE.md` | ✅ Designated by ruling **R-1** |
| 4 | Bounded Context Map | `docs/architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md` | ✅ 523 lines, 31 contexts |
| 5 | ADRs | — | ❌ Zero files (`U-2`) |
| 6 | Module Dependency Matrix | `docs/architecture/LIBOORA_MODULE_DEPENDENCY_MATRIX.md` + `tool/module_dependencies.yaml` | ✅ |
| 7 | Authentication PRD | `docs/prd/authentication/` | ⚠️ 11 chapters empty; substance only in `BLOCKER_CLOSURE_v1.0.md` |
| 8 | Development Standards | — | ❌ Only stock `flutter_lints` (`U-3`) |

Implementation evidence (`lib/platform/identity/identity.dart`, `test/authentication_conformance_test.dart`)
is cited **only** to show where code deviates from an authoritative document — never as a source of requirements.

---

## 2. Executive Summary

§14A is a **materially better document than the previous draft.** Three conflicts raised against the earlier
version are resolved outright by the new wording — see `FP-2`, `FP-3`, `FP-4`. The module-boundary language in
§14A.8 is architecturally correct and needs no change.

The remaining problems are structural, not editorial, and cluster into three groups.

**Group 1 — the capability has no owner (`CC-1`, `CC-3`, `CC-7`).** §14A describes a V1 capability that appears
in **none** of: the Master PRD's 18 core modules, the Bounded Context Map's 31 contexts, or the dependency
manifest. Under `default_decision: deny` it therefore has no rank, no allow-list and no permitted ports —
meaning no line of it may lawfully be written today. Its public profile (§14A.5) aggregates fields owned by
**six** different bounded contexts, and its Private mode (§14A.6) depends on an invitation mechanism that no
context owns.

**Group 2 — cross-tenant discovery collides with tenant partitioning (`CC-2`, blocking).** §14A.4 requires
searching across all libraries. Three separate authorities require every search index to be tenant-prefixed,
and the manifest rates a violation `blocker`. As written, §14A.4 cannot be implemented without breaching a
blocker-severity rule.

**Group 3 — the flow's own precondition is missing from the implementation (`CC-4`, blocking, and the most
important finding in this review).** §14A.7's flow is **correct** — the Bounded Context Map states plainly that
an `AccountId` is *"Created on first successful OTP"*. But the shipped code refuses to issue a verifiable
challenge to any unknown number, so **no new user can complete §14A.7 today.** The conflict is between the
architecture (which permits self-registration) and the implementation (which prevents it) — **not** with §14A.
Every acceptance criterion that depends on a first-time user is currently unachievable.

Nothing in §14A weakens Authentication, Authorization, Tenant Isolation, Security or bounded-context ownership.
§14A.8 and §14A.10 actively strengthen two of them.

| Category | Count |
|---|---|
| Confirmed Conflicts | **7** (`CC-2`, `CC-4` blocking) |
| Recommendations | **7** |
| False Positives | **6** (3 are conflicts *resolved* by this revision) |
| Unverified Observations | **6** |

---

## 3. Confirmed Conflicts

### CC-1 · The capability is unregistered in every authoritative register — BLOCKING TO IMPLEMENTATION

**Where in §14A:** §14A.1 (*"primary user acquisition, library discovery, and enrollment entry point of the
platform"*), §14A.7, `LIB-DISC-007`.

**Conflicts with:**
- `docs/prd/MASTER_PRD.md` §8 lines 146–191 — **18** core product modules enumerated. Library Discovery &
  Enrollment is **not** among them.
- `MASTER_PRD.md` §8.1 lines ~178–190 — the explicit catch-all list of *"Bounded contexts absent from the v1.0
  module list"* (BC-19, BC-21, BC-23, BC-24, BC-29, BC-30, BC-31, BC-11/12/13). Discovery is **not** there either.
- `MASTER_PRD.md` §5.1 line 82 — *"In scope for V1: The 23 V1 bounded contexts registered in the context map
  §3.4"*. A closed, enumerated set.
- `LIBOORA_BOUNDED_CONTEXT_MAP.md` lines 90–132 — all 31 contexts. **None** owns public/anonymous discovery, a
  cross-tenant library catalog, or enrollment initiation.
- `tool/module_dependencies.yaml` — no module block exists, while line ~10 sets `default_decision: deny`.

**Why this is a genuine conflict:** the manifest denies by default. A capability with no block has no rank, no
`imports`, no `ports` and no `emits_events`. Every dependency it needs is forbidden until declared.

**Impact if unchanged:** the capability cannot be implemented at all without violating the dependency manifest.
Any code written for it would be unauthorised by construction, and — once `MP-DEP-06`'s boundary checker exists
— would fail CI.

**Minimum change required:** register it. A **documented precedent already exists** and requires no invention:
`MASTER_PRD.md` §8 modules 3, 5, 10, 11 and 12 are registered as *"read composition"* / *"Composition over read
models"* / *"not a context"*, and §8 Correction 1 states verbatim that such surfaces *"own no aggregate and no
invariant."* Recommended registration:

> **Library Discovery & Enrollment** — a **read composition** over `BC-19` Tenancy, `BC-25` Configuration,
> `BC-06` Library Policy, `BC-02` Membership, `BC-04` Seating and `BC-29` File & Media, projected through
> `BC-23` Search Indexing. Owns **no aggregate and no invariant**. Not a bounded context.

**Requires an owner ruling.** I may not assign a `BC-` number or author a manifest block unilaterally.

---

### CC-2 · Cross-tenant discovery vs mandatory tenant partitioning — BLOCKER SEVERITY

**Where in §14A:** §14A.4 (Search by Library Name / City / Locality / PIN Code, Discover Nearby, Distance-based
Sorting), `LIB-DISC-003`, `LIB-DISC-013`.

**Conflicts with three independent authorities:**
- `MASTER_PRD.md` line 329, **`MP-GBR-08`**: *"Every search index and vector namespace is tenant-partitioned.
  Every RAG retrieval is tenant-scoped **and** permission-aware."*
- `tool/module_dependencies.yaml`, `platform/search` assertion **`SE-1`**: `"every index name is
  tenant-prefixed"` — annotated `# X-13`.
- `tool/module_dependencies.yaml`, `global` block: `tenant_key_required_in:` includes **`search index names`**,
  with `tenant_key_violation_severity: blocker`.
- `LIBOORA_BOUNDED_CONTEXT_MAP.md` line 124 — `BC-23` owns *"tenant index isolation"*.

**Why this is a genuine conflict:** a tenant-prefixed index is queryable only within one tenant. Discovery must
query across all tenants at once, for a caller who has no tenant context (§14A.5 is pre-authentication, so no
`TenantContext` exists — cf. `E-18` line 317, *"Propagated, never passed as a parameter"*). The two
requirements are mutually exclusive as written.

**Impact if unchanged:** §14A.4 is unimplementable. Any attempt produces a tenant-less index name, which the
manifest classifies as a **blocker**, the highest severity defined.

**Minimum change required:** distinguish *tenant-owned data* from *the tenant directory*. The discovery index's
indexed unit is the **`TenantOrganisation` aggregate itself** (`BC-19`, line 371) — not any tenant's students,
attendance or finances. That is a platform-level catalog, categorically different from the leakage `X-13`
exists to prevent. This must be recorded as a **narrow, explicit exemption** to `MP-GBR-08` and `SE-1`,
enumerating exactly the public fields of §14A.5 and nothing else.

**Requires an owner + Security Architect ruling.** An exemption to a blocker-severity multi-tenant invariant is
not mine to grant.

---

### CC-3 · §14A.5's public profile spans six owners — Single Owner Rule

**Where in §14A:** §14A.5 field list; §14A.7 *"The Library module owns only discovery and enrollment
initiation"*; document title *"Organization **&** Library Management"*.

**Conflicts with:**
- `LIBOORA_BOUNDED_CONTEXT_MAP.md` line 200, a **binding resolution**: *"`Library` — BC-19: the tenant
  organisation (billing entity) · BC-06: a physical branch with hours and seats → `TenantOrganisation` (BC-19)
  vs `Branch` (BC-06)."* The phrase *"the Library module"* is therefore ambiguous by definition.
- Single Owner Rule, EA §10.1.1, invoked verbatim in `MASTER_PRD.md` §8 Correction 2: *"A single module name
  spanning two owners at two ranks violates the Single Owner Rule."*

**Field-by-field ownership** (all citations from the Bounded Context Map):

| §14A.5 field | Owning context | Evidence |
|---|---|---|
| Library Name · Business Address · Map Location · Library Status | `BC-19` Tenancy | line 120; `Tenant` aggregate line 371 |
| Logo · Cover Image · Description *(branding)* | `BC-25` Configuration | line 126 — *"branding values"* |
| Gallery | `BC-29` File & Media | line 130 — *"upload, virus scan, thumbnailing, signed URLs"* |
| Operating Hours · Weekly Holidays | `BC-06` Library Policy | line 95 — *"working hours, holidays"* |
| Facilities & Amenities | **unowned** | no context claims it — see `R-D` |
| Membership Plans & Pricing | `BC-02` Membership | line 193 — `MembershipPlan` (BC-02) |
| Seat Capacity | `BC-04` Seating | line 93 — *"seat inventory"* |
| Business Contact Information | `BC-19` Tenancy | line 120 (organisation record) |

**Impact if unchanged:** if built as an owner, Discovery duplicates six contexts' data — the exact
`R1 — One language per context` violation (line 44) and a direct breach of the *"reference, never duplicate"*
guardrail. Multi-branch (V3, `MP-SCOPE-07`) then breaks, because a single "Library" record would already
conflate tenant and branch.

**Minimum change required:** restate §14A.5 as a **read projection** with each field annotated by owning
context, and replace *"the Library module owns…"* in §14A.7/`LIB-DISC-007` with *"Library Discovery owns the
discovery projection and the enrollment-initiation trigger. It owns no aggregate and no invariant."*
No business requirement is lost — only ownership language changes.

---

### CC-4 · §14A.7 is architecturally correct but currently unimplementable — BLOCKING, HIGHEST IMPACT

**Where in §14A:** §14A.7 flow (*Join Library → Authentication → Registration (if required) → Membership
Processing*), `LIB-DISC-008`, `LIB-DISC-012`, acceptance criteria 6 and 7.

**§14A is RIGHT.** The architecture explicitly sanctions self-registration —
`LIBOORA_BOUNDED_CONTEXT_MAP.md` §4, Identity Triad table:

> | **Account** | `AccountId` | BC-18 Identity & Access | Global, cross-tenant | **Created on first successful
> OTP.** Destroyed on account deletion. Holds *credentials only*. |

An account coming into existence on first successful OTP **is** self-registration. §14A.7 conforms to it.

**The conflict is with the implementation.** `lib/platform/identity/identity.dart` line 307–318:

```dart
  void requestOtp(String phone) {
    final code = _generateCode();
    final challenge = _Challenge(code: code, expiresAt: _clock.now().add(challengeTtl));
    // The only branch is on *storage*, never on the response. An unregistered
    // number consumes the same work and yields the same observable outcome.
    if (_accountForPhone(phone) != null) {
      _issued[phone] = challenge;
    }
  }
```

A challenge is **stored only for numbers that already have an account.** An unknown number can never verify,
so an `AccountId` can never be *"created on first successful OTP"*. The defect `F-02` remediation achieved
response uniformity by making unknown numbers **unverifiable** rather than **registrable** — it removed the
enumeration oracle and self-registration together.

**Secondary conflict — the requirement is unspecified.** `docs/prd/authentication/03-Registration.md` is an
empty transfer slot: 1,284 bytes, 29 lines, **0 body characters** (confirmed at `Authentication_PRD.md`
lines 29, 96, 114 and 232–264). Defect `D-7` is OPEN. So the module §14A delegates to has no written
registration specification.

**Impact if unchanged:** **every first-time user's journey terminates at "Authentication".** `LIB-DISC-012`
(*preserve the intended action*) can never fire for a new user. Acceptance criteria 6 and 7 are unachievable.
The stated objectives *"Reduce onboarding friction"* and *"Increase membership conversion"* are unreachable —
conversion for new users is structurally zero. This is the finding to fix first.

**Minimum change required — and it satisfies both rules at once:**
1. `BC-18` issues and stores a challenge for **every** well-formed number, uniformly (preserves `F-02`; the
   26 conformance tests in `test/authentication_conformance_test.dart` continue to hold, since uniformity is
   asserted on the *observable response*, not on storage).
2. On **successful verification** of a number with no `Account`, `BC-18` creates one — exactly as the Identity
   Triad lifecycle already specifies. No enumeration oracle is created, because the discriminating information
   is revealed only *after* the caller has proven possession of the number.
3. Authentication PRD Chapter 3 must be written to specify this (closes part of `D-7`).

This reconciliation is **derived entirely from existing documents**, not invented. It also answers the product
owner's question about a free sign-up option: the architecture already provides for one.

**Requires:** an owner ruling to authorise the `BC-18` change (guardrails forbid unapproved authentication
changes), plus Chapter 3 content.

---

### CC-5 · §14A.12 lists Notifications, which §14A.3 places out of scope, and which `X-04` forbids

**Where in §14A:** §14A.12 lists *"Notifications"* as an Integration. §14A.3 **Out of Scope** also lists
*"Notifications"*. The document contradicts itself.

**Conflicts with:** `tool/module_dependencies.yaml`, `domain/library.banned_imports`:

```yaml
    - "platform/communication/**" # X-04 emit facts instead
```

`BC-22` Notification Delivery (line 123) owns *"channel selection, templates, deduplication, quiet hours"*.

**Impact if unchanged:** an implementer following §14A.12 writes a forbidden import; one following §14A.3 omits
notification capability entirely. Ambiguity guarantees one of the two is wrong.

**Minimum change required:** delete *"Notifications"* from §14A.12, or reword to
*"emits domain events; `BC-22` Notification Delivery subscribes"*. Keep the §14A.3 out-of-scope entry.
No business intent changes — only the mechanism is named correctly.

---

### CC-6 · §14A.12 lists Maps as a direct integration — `X-03` no vendor knowledge

**Where in §14A:** §14A.12 *"Maps"*; §14A.5 *"Map Location"*; `LIB-DISC-013`.

**Conflicts with:** `domain/library.banned_imports` → `"platform/integration/**"  # X-03 no vendor knowledge`,
and `BC-31` Integration (line 132), which owns *"outbound third-party contracts, credentials, retries"*.

**Impact if unchanged:** map-vendor identity leaks into the library domain, which is precisely what `X-03`
forbids. Swapping providers later becomes a domain change.

**Minimum change required:** reword to *"map rendering and geocoding via a port; the vendor contract is owned by
`BC-31` Integration"*. Capability preserved; vendor knowledge stays out of the domain.

---

### CC-7 · The invitation mechanism has no owner anywhere in the architecture

**Where in §14A:** §14A.6 Private — *"Invitation Link · QR Code · Library Invitation Code"*,
*"Accepts membership requests only from invited users"*; `LIB-DISC-004`.

**Conflicts with:** `grep -inE 'invitation|invite|referral'` over `LIBOORA_BOUNDED_CONTEXT_MAP.md` returns
**zero matches**. No context owns invitation issuance, validation, expiry, single-use semantics or revocation.
No aggregate, no invariant, no events. (`platform/services:qr` **is** an available port for `domain/library`,
so QR *rendering* is solved — issuance and validation are not.)

**Impact if unchanged:** Private visibility mode — one of only two modes required by `LIB-DISC-001` — is
unimplementable. `LIB-DISC-004` is partially unverifiable. An invitation code is a **security-bearing token**;
leaving it unowned means no one specifies its entropy, TTL, single-use enforcement or revocation, which is how
tenant-isolation bypasses get built by accident.

**Minimum change required:** assign ownership and specify the token's invariants. Candidates, both defensible
from existing documents: `BC-19` Tenancy (an invitation is an organisation-scoped artifact) or `BC-01`
Enrollment (an invitation initiates enrollment). **Requires an owner ruling** — and, because the artifact is
security-bearing, a Security Architect review.

---

## 4. Recommendations

Non-blocking. Each improves traceability or removes ambiguity without altering business intent.

| ID | Observation | Minimum change |
|---|---|---|
| **R-A** | *"Student Identity module"* (§14A.1, §14A.3, §14A.7, `LIB-DISC-010`, §14A.12) is not a name in the architecture. There are two distinct owners: `BC-10` **Global Student Identity** (`PersonId`, global, opt-in, *"may not exist"*, line 106/155) and `BC-01` **Enrollment** (`StudentRecordId`, per-tenant, line 157). Rules `ID-2`/`ID-3`/`ID-4` make them non-interchangeable, and line 198 separates `StudentProfile` (BC-01) from `PublicProfile` (BC-10). | Name `BC-01` Enrollment for the per-tenant student record created at join; state that `PersonId` linkage is **opt-in** via edge `E-13` (`ACL`, line 307). Note line 189: the bare word `Student` is *"banned in shared code"*. |
| **R-B** | *"Student Management"* (§14A.1) is a product-module name, not a context. | Cross-reference `MASTER_PRD.md` §8 module 4 → `BC-01` Enrollment. |
| **R-C** | *"Library Management"* as an Integration (§14A.12) names a **cluster** of six contexts, not a module. | Name the specific contexts consumed: `BC-06` (hours/holidays), `BC-02` (plans/pricing), `BC-04` (seat capacity). |
| **R-D** | *"Library Type Filters"* (§14A.4) and *"Facilities & Amenities"* (§14A.5) have no domain vocabulary. No `LibraryType` or `Facility` register exists in `packages/liboora_contracts`, whose closed registers are otherwise exhaustive (`AccessRole` 5, `Permission` 10, `AccessScope` 3, `ExternalOutcome` 7, `ErrorClass` 8, `DomainErrorCode` 79). | Define closed registers owned by `BC-19` or `BC-25`, or defer both filters to V2. Free-text filters cannot be indexed consistently. |
| **R-E** | *"Future Availability Filters"* (§14A.4) is undated, while `MASTER_PRD.md` §5.2 dates every deferral with an `MP-SCOPE-nn` id and an arrival version. | Tag explicitly as V2 or V3 with an `MP-SCOPE` id, or remove. |
| **R-F** | Section numbering *"14A"*. The Master PRD uses flat `1`…`36`; a letter suffix implies insertion without renumbering. Precedent: open defect `D-9` exists for exactly this class of problem (`EC-01…EC-48`). | Either promote to a full numbered section at the next revision, or document the suffix convention in §30 Documentation Standards. Cosmetic, but `MP-CON-15` requires the spec be version-controlled and unambiguous. |
| **R-G** | *"Library Status"* is publicly exposed (§14A.5). `BC-19` owns `TenantLifecycleState` (line 371), whose values are driven by billing — `BC-20` owns `DunningState` (line 372). Publishing the raw lifecycle state would disclose a library's **commercial standing** with LIBOORA to prospective students. | Expose a derived two-value public flag (e.g. *accepting members / not accepting*), not the raw `TenantLifecycleState`. Classified Recommendation rather than Conflict because no cited document forbids it outright — but it is a real commercial-confidentiality exposure and contradicts §14A.10's own intent to protect *"Financial Information"*. |

---

## 5. False Positives

Observations that **look** like conflicts and are not. Three are conflicts raised against the previous draft
that this revision **resolves** — recorded so they are not re-litigated.

| ID | Observation | Why it is NOT a conflict |
|---|---|---|
| **FP-1** | Unauthenticated public browsing appears to contradict `MP-CON-11` (line 512): *"no demo or guest accounts in any release build."* | Anonymous public read is **not a guest account**. No `AccountId`, no `AuthSession`, no `Credential` is created — so `MP-CON-11` and `MP-GBR-27` (*no credential outside `BC-18`*) are both untouched. §14A.5 exposes only tenant-owned public fields. **No conflict.** |
| **FP-2** | ✅ **RESOLVED from previous draft.** §14A.10: *"Business Contact Information shall be separate from the Library Owner's authentication credentials."* | The earlier draft would have published the owner's mobile number, which **is** the sole V1 authentication factor (`MP-GBR-25`) — neutralising the `F-02` uniformity guarantee for the highest-privilege accounts. The new wording fixes this precisely and aligns with `MP-GBR-27` and `ID-1`. **Credit to this revision.** |
| **FP-3** | ✅ **RESOLVED from previous draft.** `LIB-DISC-002`: publicly discoverable *"only after successful verification and activation"*. | Replaces the earlier public-by-default-at-create behaviour. Consistent with `BC-19`'s `TenantLifecycleState` and its invariant *"suspended tenant rejects all writes"* (line 371). **No conflict.** |
| **FP-4** | ✅ **RESOLVED from previous draft.** §14A.5 lists *"Seat Capacity (Optional)"* — static capacity, **not** live occupancy. | The earlier draft's public live-occupancy requirement contradicted `E-08` (line 295): *"**Seating is the occupancy owner**, Attendance is the trigger."* Static capacity is a `BC-04` layout fact and safe to publish. **No conflict.** |
| **FP-5** | §14A.9 lists *"AI Services"* and *"Chat"* as protected operations — Chat lives in `domain/social`, which `domain/library` is banned from importing (`X-05` Separate Ways). | §14A.9 is an **authentication-gating list**, not an integration list. Naming an operation as auth-gated creates no import. `X-05` untouched. **No conflict.** |
| **FP-6** | §14A.8: *"The Library module shall never perform authentication, registration, OTP verification, authorization, or session management directly."* | Exactly correct and **stronger** than required. Matches `MP-GBR-27`, `ID-1`, and the manifest — `domain/library` holds only `platform/identity:policy_decision` and the narrow `account_directory` port (Amendment `A-2`: *"Read-only, single-subject, no listing, no lookup by number"*). **No change needed.** |

---

## 6. Unverified Observations

Cannot be proven or disproven from documents that exist. Recorded, **not** resolved.

| ID | Observation | Missing source |
|---|---|---|
| **U-1** | Any §14A claim traceable only to *"Foundation"*. | No file named Foundation. Nearest candidate `02-Authentication-Foundation.md` has **0 body characters**. |
| **U-2** | §14A's ownership assertions (§14A.1, §14A.7, `LIB-DISC-007`…`010`) cannot be checked against recorded decisions. | **Zero ADR files.** Deferred as `R-3`. |
| **U-3** | Naming, API shape and validation conventions for the new capability. | No Development Standards document; only stock `flutter_lints` (28 lines). Deferred as `R-4`. |
| **U-4** | Whether §14A duplicates, contradicts or correctly cross-references the parent document — and whether *"Library Type"*, *"Facilities"* or visibility are already defined there. | **Sections 1–25 were not received.** See `README.md`. This is the largest unverified area: internal consistency of the Library PRD is entirely unassessed. |
| **U-5** | Whether discovery emits events, and under which identifiers. | Event register `EVT-1001`…`EVT-1036` member names *"were never available"* (Amendment `A-4`; `Authentication_PRD.md` line 480). |
| **U-6** | `LIB-DISC-013` distance-based sorting and *"Discover Nearby"* require geospatial query capability. | No geo/spatial capability appears in the 31 contexts or in the `platform/search` manifest block (`rank: 5`, assertions `SE-1`/`SE-2` only). Cannot confirm `BC-23` supports geo queries. Classified Unverified, not Conflict. |

---

## 7. Freeze Readiness Assessment

### **REQUIRES MAJOR REVISION**

Not *Ready to Freeze*, and not *Ready after Minor Changes*. The justification is structural, not editorial:

1. **Two blocking conflicts.** `CC-2` collides with a `blocker`-severity multi-tenant invariant asserted by
   three independent authorities. `CC-4` means the document's central flow cannot complete for any new user.
   Neither is fixable by rewording §14A — both need decisions outside this document.
2. **The capability has no owner.** `CC-1` means there is no bounded context, no product-module entry and no
   manifest block. Under `default_decision: deny`, **no line of this capability may lawfully be implemented
   today.** A PRD cannot be frozen when its owning module does not exist.
3. **Four rulings are required that I may not make.** Registering a module (`CC-1`), exempting an index from
   `MP-GBR-08`/`SE-1` (`CC-2`), changing `BC-18` authentication behaviour (`CC-4`), and assigning ownership of a
   security-bearing invitation token (`CC-7`). The guardrails reserve all four to the owner.
4. **Sections 1–25 are unassessed** (`U-4`). §14A cannot be frozen in isolation from the document it is a
   section of — duplication and contradiction against §1–25 are entirely unmeasured.

### Path to freeze

| Step | Action | Owner | Status |
|---|---|---|---|
| 1 | Rule on `CC-1` — register Library Discovery as a read composition | Product owner + Architect | ✅ **Done** — `AR-1` |
| 2 | Rule on `CC-4` — authorise the `BC-18` self-registration reconciliation | Product owner + Security | ✅ **Ruled** — `AR-2`. Implementation awaits `ACR-001` approval |
| 3 | Rule on `CC-2` — grant or refuse the tenant-directory index distinction | Product owner + Security | ✅ **Done** — `AR-3` |
| 4 | Rule on `CC-7` — assign invitation ownership | Product owner + Security | ✅ **Done** — `AR-4`. Security spec deferred by ruling |
| 5 | Approve `ACR-001`, then implement account creation on first OTP | Product owner + Security | ⬜ Pending |
| 6 | Apply `CC-3` residue, `CC-5`, `CC-6` wording corrections | Documentation | ⬜ Pending next PRD revision |
| 7 | Apply `R-A`…`R-G` | Documentation | ⬜ Pending next PRD revision |
| 8 | Document the `AR-4` invitation security specification | Product owner + Security | ⬜ Deferred by ruling |
| 9 | Supply sections 1–25 and re-review for internal consistency | Product owner | ⬜ **Outstanding — sole freeze blocker** |
| 10 | Re-assess freeze readiness | Reviewer | ⬜ Pending |

### What is already sound and must not be changed

- §14A.8 — the authentication-boundary statement. Correct and stronger than required (`FP-6`).
- §14A.10 — the public-information policy, including the credential-separation rule (`FP-2`).
- `LIB-DISC-002` — verify-then-activate (`FP-3`).
- `LIB-DISC-005` / `LIB-DISC-006` — the anonymous-read / authenticated-write split (`FP-1`).
- §14A.7's **flow order** — architecturally correct per the Identity Triad (`CC-4`); it is the implementation
  that must move, not the document.

---

## 8. Confirmation of preservation

| Guardrail | Compliance |
|---|---|
| Business requirements preserved | ✅ All 13 `LIB-DISC-*` rules, 13 subsections and 10 acceptance criteria captured verbatim. Zero deletions. |
| No invented requirements | ✅ No requirement added. All 7 conflicts cite an existing document; all recommendations are rewordings or deferrals. |
| Business intent unchanged | ✅ No objective, scope item or acceptance criterion altered. |
| Authentication not weakened | ✅ `CC-4`'s remedy **preserves** `F-02` uniformity and all 26 conformance tests, and is derived from the Identity Triad lifecycle. |
| Authorization not weakened | ✅ Untouched. `policy_decision` port unchanged. |
| Tenant isolation not weakened | ✅ `CC-2` is **escalated**, not waived. No exemption granted by this review. |
| Security not weakened | ✅ `CC-7` escalates an unowned security token rather than specifying one unilaterally. |
| Bounded-context ownership preserved | ✅ `CC-3` reassigns nothing; it documents existing owners and recommends Discovery own no aggregate. |
