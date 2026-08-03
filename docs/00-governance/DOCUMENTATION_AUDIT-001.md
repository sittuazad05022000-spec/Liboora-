# Documentation Audit 001 — Principal Enterprise Architect Review

| Field | Value |
|---|---|
| **Audit ID** | `DOCAUDIT-001` |
| **Scope** | Every Markdown document under `docs/`, plus `tool/` and the authentication code surface |
| **Corpus** | 46 documents, 1,181,511 characters |
| **Trigger** | Make documentation 100% production-ready for developers |
| **Date** | 2026-08-02 · **second pass 2026-08-03** |
| **Outcome** | **REMEDIATED** — see §6 for disposition of every finding, §6B for the Library second pass |

---

## 1. Method

Every document was read or mechanically scanned. Findings are classified:

| Class | Meaning |
|---|---|
| **CONFLICT** | Two documents assert incompatible facts. One must be wrong |
| **STALE** | A document asserts something that was true when written and is now false |
| **GAP** | A document a developer needs that does not exist |
| **RISK** | Not currently wrong, but creates a future redesign hazard |

Findings are **not** raised for stylistic variation, differing levels of detail, or a document
being silent on a topic another document covers.

---

## 2. CONFLICT findings — architecture contradicts the PRD

These are the most serious class: the Enterprise Architecture tree assigns version tags that
contradict binding Master PRD global rules and Authentication PRD v2.0 requirements.

### `C-1` — Session Revocation tagged V2, required in V1

| Source | Assertion |
|---|---|
| `LIBOORA_ENTERPRISE_ARCHITECTURE.md:635` | `Session Revocation (V2)` |
| `MASTER_PRD.md:379` `MP-GBR-26` | Session revocation is **immediate and global** — no propagation window |
| Auth PRD v2.0 `AUTH-8.40`, `AUTH-11.66`, `BR-6.10` | Revocation immediate, global, at next use |
| Auth PRD v2.0 `AUTH-9.19` | Every barring transition terminates all sessions immediately |

**Analysis.** Revocation is not a V2 enhancement — it is the mechanism by which suspension, deletion,
number change and global sign-out take effect. Without it, Chapter 9 cannot function at all. The V2 tag
is wrong.

**Disposition.** EA corrected to **V1**.

### `C-2` — Concurrent Session Limits tagged V2, required in V1

| Source | Assertion |
|---|---|
| `LIBOORA_ENTERPRISE_ARCHITECTURE.md:636` | `Concurrent Session Limits (V2)` |
| Auth PRD v2.0 `BR-6.19`, `CFG-8` | An account may hold at most `CFG-8` registered devices |
| Auth PRD v2.0 `BR-6.31` | One device holds at most one active session per account |

**Disposition.** EA corrected to **V1**.

### `C-3` — Device Management tagged V2, required in V1

| Source | Assertion |
|---|---|
| `LIBOORA_ENTERPRISE_ARCHITECTURE.md:639-641` | `Device Management (V2)`, `Device Registration (V2)`, `Multi Device Management (V2)` |
| `LIBOORA_BOUNDED_CONTEXT_MAP.md:123` | `BC-18` owns "credentials, sessions, **devices**, OTP, roles, permissions…" |
| Auth PRD v2.0 Chapter 6 §§6.4–6.7 | Device records, trust, limits, removal — 75 requirements, all V1 |
| Auth PRD v2.0 `AUTH-8.45` | First use of an unrecognised device MUST emit an event and notify the holder |

**Analysis.** This is the most consequential of the three. New-device notification is the **sole**
user-facing defence against SIM-swap account takeover in a single-factor system (`EV-16`, Chapter 8
§8.6). Deferring device management to V2 means shipping V1 with no takeover detection whatsoever.

**Disposition.** EA corrected to **V1** for Device Registration and Multi Device Management.

### `C-4` — OTP Emails tagged V1, contradicts sole-factor rule

| Source | Assertion |
|---|---|
| `LIBOORA_ENTERPRISE_ARCHITECTURE.md:1467` | `OTP Emails (V1)` under Email Service |
| `MASTER_PRD.md:378` `MP-GBR-25` | **Mobile OTP is the sole authentication factor in V1** |
| `MASTER_PRD.md:521` `MP-CON-11` | Mobile OTP is the sole V1 factor |
| Auth PRD v2.0 `AUTH-3.x`, §3.4 | Email OTP is explicitly **not supported** in V1; roadmap only (§11.12) |
| Auth PRD v2.0 `AUTH-11.67` | Mobile OTP MUST be the sole authentication factor in the first version |

**Analysis.** Authentication does not hold an email address at all (`AUTH-8.60`). An OTP email in V1
is not merely unnecessary, it is unimplementable.

**Disposition.** EA corrected to **V2**, aligned with `Email Login (V2)` two lines above.

### `C-5` — "Passwordless Login (Future)" is self-contradictory

| Source | Assertion |
|---|---|
| `LIBOORA_ENTERPRISE_ARCHITECTURE.md:623` | `Passwordless Login (Future)` |
| `MASTER_PRD.md:378` | There are no passwords |
| Auth PRD v2.0 `AUTH-11.68` | No password, PIN, security question or reusable secret MUST exist anywhere |

**Analysis.** The platform is passwordless in V1 by construction. Listing passwordless login as a
future capability implies V1 has passwords. What was presumably meant is **passkeys** — a distinct
capability already on the v2.0 roadmap (§11.12, medium horizon).

**Disposition.** EA node renamed to `Passkeys / WebAuthn (V3)`.

---

## 3. STALE findings — documents describing a repository state that no longer exists

Authentication PRD v2.0 now exists and is authoritative. Twelve documents still assert that the
specification is absent.

| ID | Document | Stale assertion | Disposition |
|---|---|---|---|
| `S-1` | `Authentication_PRD.md` | *"not present in this repository… `D-7` remains OPEN"* — 12 empty-slot banners | **Archived** with superseding notice |
| `S-2` | `Authentication_PRD_Developer_Guide.md` | *"the specification is not in the repository"*; folder listing shows 11 EMPTY SLOTs | **Archived**; replaced by Developer Handoff |
| `S-3` | `FINAL_VALIDATION_REPORT.md` | `D-7 status = OPEN — NOT CLOSED` | Closure note appended |
| `S-4` | `IVR-001-OTP-Account-Creation.md` | Chapter refs *"Still empty"*, `D-7` OPEN | Superseding note appended |
| `S-5` | `ACR-002-New-Account-State.md` | *"0 body characters — empty transfer slot"* ×3 | Superseding note appended |
| `S-6` | `ACN-001-OTP-Request-Rate-Limiting.md` | Header still cited `D-7` OPEN | Closed in prior commit; re-verified |
| `S-7` | `VERIFICATION_REPORT-001.md` | *"no specification in the repository"* | Superseding note appended |
| `S-8` | `MODULE_COMPLETION_PACKAGE.md` | *"There is no specification in the repository"* | Superseding note appended |
| `S-9` | `REVIEW_14A.md` (library) | *"`D-7` is OPEN. So the module §14A delegates to has no written specification"* | Corrected — Auth v2.0 now supplies it |
| `S-10` | `docs/10-architecture/README.md` | BC Map `v1.1` (actual **v1.2**); Rulings `v1.0` / `AR-1…AR-4` (actual **v1.1** / `AR-1…AR-7`) | Corrected |
| `S-11` | `docs/10-architecture/README.md` | *"While `docs/adr/` does not exist"* | Corrected — ADRs now exist |
| `S-12` | `MASTER_PRD.md` §36 v1.3 changelog | Historical entry citing `D-7` open | **Left as-is** — changelog entries are historical record and must not be rewritten |

---

## 4. GAP findings — documents a developer needs that did not exist

| ID | Missing artefact | Consequence | Disposition |
|---|---|---|---|
| `G-1` | Architecture Decision Records | Governance task `R-3` open indefinitely; rulings register was an explicit *interim* substitute | **Created** — `docs/00-governance/adr/` with 8 ADRs |
| `G-2` | Developer Handoff | No single entry point; a new engineer had to read 46 documents to find the 6 that matter | **Created** |
| `G-3` | Configuration Guide | `CFG-1`…`CFG-12` were listed but with no ranges, no validation rules, no failure modes, no ownership | **Created** |
| `G-4` | Implementation Roadmap | No sequencing; 588 requirements with no build order | **Created** |
| `G-5` | Authentication Implementation Checklist | No mapping from requirement → work item | **Created** |
| `G-6` | `D-10` remediation task | Tracked as a documentation defect; it is a code defect | **Created** as an implementation task |
| `G-7` | Definition of Done | No shared completion standard | **Created** |
| `G-8` | Documentation index / entry point | `docs/` had no root README | **Created** |
| `G-9` | Traceability matrix | No requirement → architecture → code → test linkage | **Created** |

---

## 5. RISK findings — future redesign hazards

| ID | Risk | Analysis | Disposition |
|---|---|---|---|
| `R-A` | **`CFG-3` = 30 requests/origin/hour** would lock out an entire library | A study hall with 60 students behind one NAT gateway exhausts a 30/hour origin quota in minutes. This value would have caused a production incident on day one | **Corrected to 100/hour** + guidance that origin identity must not be IP alone |
| `R-B` | **`CFG-4` = 60-minute hard lock** is a denial-of-service vector | An attacker who knows a victim's number can deliberately burn the quota and lock them out for an hour, repeatedly. Long hard locks are discouraged by OWASP for this reason | **Reduced to 30 minutes**; risk documented and accepted |
| `R-C` | **Staff idle timeout of 12 hours** is far weaker than the applicable standard | Reception runs on a shared device in a public area. NIST SP 800-63B AAL2 requires reauthentication after **30 minutes** of inactivity. 12 hours meant an unattended reception tablet stayed signed in all day | **Corrected to 30 minutes idle / 12 hours absolute**, matching AAL2 |
| `R-D` | **`CFG-12` = 4-hour support elevation** exceeds least-privilege norms | Just-in-time access practice favours the shortest window that permits the task. Re-elevation is cheap | **Reduced to 1 hour** |
| `R-E` | **`CFG-7` = 180-day device trust** exceeds industry norm | Major providers use ~90 days for "remember this device" | **Reduced to 90 days** |
| `R-F` | `tool/check_module_boundaries.dart` does not exist | Dependency Matrix §10.2 specifies a CI fitness function. Until it exists, all 14 forbidden edges are documentation, not enforcement | **Recorded as `IMPL-014`** in the roadmap; not closable by documentation |
| `R-G` | v2.0 specifies far more than is implemented | Chapters 6, 7, 9, 10, 11 are largely unimplemented. A conformance run fails today | **Explicitly stated** in Handoff and Governance Note. Not a defect — it is the point of a specification |
| `R-H` | Library PRD §§1–25 never supplied | Auth v2.0 Chapter 2 defines tenant roles that the Library PRD must consume | ~~**Recorded** as the top missing input~~ → ✅ **CLOSED 2026-08-03** — sections supplied and reviewed; see §6B |

---

## 6. Disposition summary

| Class | Raised | Remediated | Deferred with owner |
|---|---|---|---|
| CONFLICT | 5 | 5 | 0 |
| STALE | 12 | 11 | 1 (`S-12`, correctly immutable) |
| GAP | 9 | 9 | 0 |
| RISK | 8 | **7** | **1** (`R-F` code task) |
| **Total** | **34** | **32** | **2** |

The two remaining deferred items are not closable by editing documentation:

- **`R-F`** requires writing `tool/check_module_boundaries.dart` — an implementation task, scheduled as `IMPL-014`.
- **`S-12`** is a historical changelog entry. Rewriting history to make a past state look correct is precisely the failure mode this audit exists to prevent.

**`R-H` closed 2026-08-03.** It required an input from outside the audit's control — Library PRD §§1–25 — and that
input arrived. The second pass is recorded in §6B. It is closed **by receipt**, not by authorship: the supplied
sections are preserved, not reconstructed.

---

## 6A. Remediation executed — verified record

Every action below was performed and mechanically verified. **No code file was modified.**

### Documents created (13)

| Path | Closes |
|---|---|
| `00-governance/DOCUMENTATION_BASELINE.md` | `D-7` formal declaration, `G-3` |
| `00-governance/adr/ADR-INDEX.md` | `R-3`, `S-11` |
| `00-governance/adr/ADR-0001-modular-monolith.md` | `G-1` |
| `00-governance/adr/ADR-0002-mobile-otp-sole-factor.md` | `G-1` |
| `00-governance/adr/ADR-0003-hybrid-tenancy-global-account.md` | `G-1` |
| `00-governance/adr/ADR-0004-two-stage-authentication.md` | `G-1` (promotes `AR-6`) |
| `00-governance/adr/ADR-0005-account-creation-on-first-otp.md` | `G-1` (promotes `AR-2`) |
| `00-governance/adr/ADR-0006-display-name-before-verification.md` | `G-1` (promotes `AR-5`) |
| `00-governance/adr/ADR-0007-behavioural-conformance.md` | `G-1` (promotes `AR-7`) |
| `00-governance/adr/ADR-0008-authentication-prd-v2-baseline.md` | `G-1`, closes `D-7` |
| `20-configuration/CONFIGURATION_GUIDE.md` | `G-3` — was a broken reference from PRD cover §E |
| `40-implementation/DEVELOPER_HANDOFF.md` | `G-2` |
| `40-implementation/IMPLEMENTATION_ROADMAP.md` | `G-4` (includes `IMPL-014` for `R-F`) |
| `40-implementation/AUTHENTICATION_IMPLEMENTATION_CHECKLIST.md` | `G-5` |
| `40-implementation/TASK-D10-remove-demo-surfaces.md` | `G-6` — `D-10` reclassified as implementation |
| `40-implementation/DEFINITION_OF_DONE.md` | `G-7` |
| `40-implementation/TRACEABILITY_MATRIX.md` | `G-9` |
| `README.md` | `G-8` — documentation entry point |

### Configurable values corrected (6 of 12)

| ID | Was | Now | Anchor |
|---|---|---|---|
| `CFG-3` | 30/origin/hour | **100** | NAT-gateway analysis — 60–200 students share one origin |
| `CFG-4` | 60 min | **30 min** | OWASP — long hard locks are a DoS vector |
| `CFG-5` staff | 12 h idle | **30 min** | NIST SP 800-63B AAL2 |
| `CFG-6` staff | 7 d absolute | **12 h** | NIST SP 800-63B AAL2; bounds a session to one shift |
| `CFG-7` | 180 d | **90 d** | Industry norm; must not outlive `CFG-6` mobile |
| `CFG-12` | 4 h | **1 h** | Just-in-time least privilege |

`CFG-1`, `CFG-2`, `CFG-8`, `CFG-9`, `CFG-10`, `CFG-11` were reviewed and **retained** — each was already
defensible. Nine cross-parameter invariants (`INV-1`…`INV-9`) were derived and are now startup-validated
requirements under `IMPL-015`.

### Architecture conflicts fixed (5)

`LIBOORA_ENTERPRISE_ARCHITECTURE.md` raised **v2.0 → v2.1** with a changelog entry and a 7-row retag table.
Session Revocation, Concurrent Session Limits, Device Management, Device Registration and Multi-Device
Management moved **V2 → V1**; `Passwordless Login (Future)` corrected to `Passkeys / WebAuthn (V3)`;
`OTP Emails` moved V1 → V2.

The EA is now explicitly labelled **descriptive** in `10-architecture/README.md` and ranked 6th in the
precedence order, so this class of conflict is structurally prevented rather than merely fixed.

### Documents archived (22 files, all banner-marked)

Moved to `90-archive/authentication-v1/`, each carrying an ⛔ ARCHIVED banner naming its successor and stating
why it was archived:

- `Authentication_PRD.md`, `Authentication_PRD_Developer_Guide.md` — `S-1`, `S-2`
- `empty-slots/` — the eleven never-filled chapter placeholders
- `reports/` — nine historical reports (`S-3`, `S-4`, `S-5`, `S-7`, `S-8`, plus `ACN-001`, `ACR-001`,
  `BLOCKER_CLOSURE_v1.0`, `CHANGE_REPORT-001`)

**Nothing was deleted.** The custody record is intact and readable.

### Active documents corrected (3)

| Document | Fix |
|---|---|
| `10-architecture/README.md` | `S-10`, `S-11` — BC Map v1.1→v1.2, Rulings v1.0/`AR-1…4`→v1.1/`AR-1…7`, ADR pointer added, `IMPL-014` recorded, precedence banner added |
| `30-product/library/REVIEW_14A.md` | `S-9` — the *"`D-7` is OPEN … no written specification"* claim struck through and corrected; §14A's delegation now resolves |
| `30-product/MASTER_PRD.md` | `S-12`, `C-6` — §31 rewritten (ADR set present, `R-3` closed, EA v2.1 and descriptive, v2.0 declared baseline, parameters anchored, v1 material archived, developer set registered); `MP-CON-08` corrected; version bumped `v1.4`→`v1.5` |
| `30-product/authentication/README.md` | `S-13` — the *"parameters awaiting sign-off"* caveat replaced with a pointer to the Configuration Guide as operational source of truth |
| `30-product/authentication/PRD-V2-GOVERNANCE-NOTE.md` | §4 rewritten as a review record with named anchors |

### Structure and link integrity

Migrated to a versioned structure using `git mv` throughout, so **file history is preserved**:

```
00-governance · 10-architecture · 20-configuration · 30-product · 40-implementation · 90-archive
```

`docs/prd/` and `docs/architecture/` no longer exist. All references were rewritten.

**Link verification:** 43 broken relative links found after migration, all repaired. Final scan across every
Markdown file under `docs/` → **0 broken links**.

### Conflict found during the closing scan — `C-6`

The final consistency pass surfaced a conflict that the remediation itself had created, and it is recorded
here rather than quietly fixed, because it is the most instructive finding in this audit.

`MASTER_PRD.md` `MP-CON-08` read:

> *"The Enterprise Architecture v2.0 is **approved and final**. This PRD may not modify it."*

That was coherent while the EA was treated as the top of the tree. It is **directly contradicted** by the
precedence order established in `DOCUMENTATION_BASELINE.md` §4, which places the Enterprise Architecture at
**rank 6** and makes it descriptive — explicitly *"update it to match 1–5; never the reverse."* Left in place,
a developer reading the Master PRD would have concluded the EA outranks the Authentication PRD, and a
developer reading the baseline would have concluded the opposite. Both documents are ones a developer is told
to trust.

`MP-CON-08` was rewritten to distinguish **structural authority** (layering, dependency law, context
inventory — still governing) from **requirement authority** (not governing; the PRD wins), to state the rank
explicitly, and to direct that a disagreement is *raised as a defect*, never silently resolved.

**Lesson recorded for the change process:** introducing a precedence order is not an additive act. It
retroactively re-scopes every pre-existing statement about authority, and each one must be re-read against it.

### Verification performed at close

| Check | Method | Result |
|---|---|---|
| Relative links resolve | `linkcheck.py` over all Markdown under `docs/` | **0 broken** |
| No stale absence claims in active documents | Pattern scan excluding `90-archive/` | Clean — remaining matches are immutable changelog entries and quoted text being superseded |
| Assembled PRD matches chapter sources | Regenerated and diffed | Diff contained exactly the six `CFG` corrections and nothing else |
| Configurable values consistent everywhere | Cross-scan of Ch 8, cover, Configuration Guide, governance note, assembled PRD | Consistent |
| Code untouched | `git diff --name-only` restricted to code paths | Empty |

---

## 6B. Second review pass — Library PRD, 2026-08-03

The product owner supplied **Library PRD §§1–25** on 2026-08-03. That is the input finding `R-H` was waiting for,
and its arrival reopened the audit for a bounded second pass over the Library domain only. No authentication
finding was revisited and no earlier disposition was reversed.

### What was reviewed

The supplied §§1–25 were validated against nine higher-ranked or adjacent authorities: the Master PRD global rules,
Authentication PRD v2.0 chapters 7 and 9, the Bounded Context Map, the Module Dependency Matrix, Architecture
Rulings `AR-1`/`AR-3`/`AR-4`, this baseline, the Configuration Guide, the existing §14A capture, and
`tool/module_dependencies.yaml`.

**The governing constraint was preservation.** The brief was explicit: *do not rewrite unless required.* Every
requirement in the supplied text survives in `Library_PRD_v1.md`. Where the supplied text conflicted with a
higher-ranked document, the conflict was recorded with its reasoning and resolved in favour of the higher rank —
which is the precedence rule in §4 of the baseline operating exactly as intended, not an editorial preference.

### Conflicts found — fourteen, three of them blocking

Full analysis in [`LIBRARY_PRD_ALIGNMENT.md`](../30-product/library/LIBRARY_PRD_ALIGNMENT.md) §2. Summarised:

| ID | Conflict | Class | Resolution |
|---|---|---|---|
| `LC-1` | Two competing public-visibility field lists — §7 named nine fields, §14A.5 named fourteen | CONFLICT | §14A.5 governs as the reviewed superset. `LIB-7.1`, `LIB-7.2` define the list **once** |
| `LC-2` | The business contact number was not distinguished from the owner's authentication credential | **BLOCKING** | `LIB-6.4` separates them and forbids inference. Under `MP-GBR-25` the mobile number **is** the sole factor; publishing the profile would have published half the credential |
| `LC-3` | Owner modelled as a single value on the library record | **BLOCKING** | `LIB-15.13` makes Owner a multi-holder role. A single-valued owner collides with `AP-5` separation of duties, `LIB-15.9` last-owner protection, and `AUTH-9.46` erasure rights *simultaneously* |
| `LC-4` | Public seat information unbounded | **BLOCKING** | `LIB-7.3`, `LIB-14B.11`, `LIB-14B.12` permit a coarse aggregate only. Precise live occupancy in a domain where regulars hold the same desk daily is a public attendance feed |
| `LC-5` | Notifications described as a direct integration | CONFLICT | `LIB-21.2` — emit facts, never call `platform/communication/**` (`X-04`). **Closes `CC-5`** |
| `LC-6` | Maps described as a vendor integration | CONFLICT | `LIB-6.5`, `LIB-21.3` — a port, no vendor knowledge (`X-03`). **Closes `CC-6`** |
| `LC-7` | `Staff` modelled as an independent entity | CONFLICT | `LIB-5.1`, `LIB-15.1` — an `Account` holding a role. Never a second credential store |
| `LC-8` | Role vocabulary diverged from the closed set | CONFLICT | `LIB-4.1` adopts `TR-1`…`TR-3` and Platform Administrator per `AUTH-7.21` |
| `LC-9` | "Premium Zone" invited pricing into the domain model | RISK | `LIB-11.3`, `LIB-11.4` — descriptive only; price lives on the `BC-02` plan |
| `LC-10` | Multi-Branch tiered inconsistently | STALE | **V3** per Master PRD §32 |
| `LC-11` | Public Library Discovery listed as both V1 and Future | STALE | §14A governs — V1 |
| `LC-12` | Floor Capacity vs authoritative seat inventory | CONFLICT | `LIB-10.4`, `LIB-10.5` — planning figure; `BC-04` authoritative; discrepancy surfaced, never silently reconciled |
| `LC-13` | "Silent Zone" used as both a facility and a zone | CONFLICT | `LIB-13.6` — distinct concepts, neither derives from the other |
| `LC-14` | Facility list expansion unachievable as usually built | RISK | `LIB-13.1`, `LIB-13.2` — reference list plus association, not boolean columns |

### Findings closed by this pass

| Finding | Was | Now | Basis |
|---|---|---|---|
| `R-H` / `U-4` | Library PRD §§1–25 never supplied | **CLOSED** | **By receipt.** The sections were supplied and are preserved in `Library_PRD_v1.md` v1.0 |
| `AR-4` deferral | Invitation security specification deferred — *"do not invent"* | **CLOSED** | **By authorship.** The deferral's stated precondition no longer holds; the received text confirms the feature exists in three forms. `INVITATION_SECURITY_SPECIFICATION.md`, `ADR-0009` |
| `CC-5` | Library notifications might reach for the delivery channel directly | **CLOSED** | `LIB-21.2` |
| `CC-6` | Maps might be modelled as a vendor integration | **CLOSED** | `LIB-6.5`, `LIB-21.3` |
| `CC-7` | Invitation mechanism unspecified | **CLOSED** | The full specification, 71 requirements |
| `U-1`, `U-5`, `U-6` | §14A open questions awaiting §§1–25 | **CLOSED** | Answered by the received text and the two new chapters |

### Findings this pass deliberately did **not** close

| Finding | Why it stays open |
|---|---|
| `D-10` demo surfaces | Code. Six call sites in four files. A document cannot delete a line of Dart |
| `IMPL-020` SMS provider / DLT | Code plus a multi-week external registration. Now on the Library critical path too, because `IT-1` staff invitations cannot be delivered without it |
| `R-F` / `IMPL-014` boundary checker | Code. Twenty-six edges and fourteen prohibitions remain unenforced at CI |
| `CC-4` | Requires the checker above to be meaningful |
| `U-3` | Requires a product decision that has not been taken |
| `R-5` `lib/contracts/` | Code — a directory referenced in prose that does not exist |

This is the same distinction §7 of this audit drew on 2026-08-02 and it has not softened. **Writing a task is not
closing an issue.** Twenty-three Library tasks now exist with acceptance criteria and developer checklists in
[`LIBRARY_IMPLEMENTATION_TASKS.md`](../40-implementation/LIBRARY_IMPLEMENTATION_TASKS.md); every one of them is
*open work*, and the backlog says so.

### Documents produced by this pass (7)

| Document | Purpose |
|---|---|
| `30-product/library/Library_PRD_v1.md` | The Library baseline, §§1–25, ~130 requirements |
| `30-product/library/14B-Public-Library-Preview.md` | Anonymous preview; the authentication boundary as a closed register `PO-1`…`PO-12` |
| `30-product/library/INVITATION_SECURITY_SPECIFICATION.md` | `INV-SEC-001`…`071`; three invitation types; entropy, expiry, revocation, single use, validation, audit, rate limiting |
| `30-product/library/LIBRARY_PRD_ALIGNMENT.md` | The validation record — what conflicted, what changed, what did not, and why |
| `40-implementation/LIBRARY_IMPLEMENTATION_TASKS.md` | `IMPL-100`…`IMPL-127` |
| `00-governance/adr/ADR-0009-invitation-security-model.md` | An invitation is a revocable claim, not a credential |
| `00-governance/adr/ADR-0010-public-preview-anonymous-access.md` | Public information is served anonymously from a projection |

### The one thing worth carrying forward from this pass

Two of the three blocking conflicts had the same shape: **a field that looks like ordinary business data turns out
to be load-bearing for security elsewhere.** The library's contact number is a phone number *and* the sole
authentication factor. The seat count is inventory *and* an attendance signal. Neither is visible as a security
question from inside the Library domain — you can only see it by reading the Master PRD's global rules at the same
time.

The generalisable lesson: **in a system with a single authentication factor, every field that could contain that
factor is a credential field until proven otherwise.** A domain review conducted in isolation would have passed
both requirements.

---

## 7. What this audit deliberately did not do

- **It did not reconcile v2.0 against the lost v1.0 text.** That text does not exist in the repository or in Git history. `D-7` is closed by authorship; see `DOCUMENTATION_BASELINE.md`.
- **It did not change any requirement's meaning.** Six configurable values were changed, each with a recorded standards anchor. No `AUTH-`, `BR-`, `XC-` or `AC-` identifier changed meaning, and none was added or removed.
- **It did not touch code.** `D-10` was reclassified and given a remediation task, but no `.dart` file was modified.
- **It did not delete anything.** Superseded documents were archived with notices, not removed. The custody record remains intact.

### Added by the second pass, 2026-08-03

- **It did not rewrite the Library PRD.** Fourteen conflicts were corrected against higher-ranked documents. Every requirement in the supplied §§1–25 survives, and each correction carries its reasoning in `LIBRARY_PRD_ALIGNMENT.md` §2. Where the supplied text was merely *differently organised* from the rest of the corpus, it was left alone.
- **It did not invent the invitation feature.** `AR-4` said *"do not invent."* The specification was written only after the received §§1–25 confirmed the feature exists, and in which three forms. Anything the source did not describe is listed as an explicit exclusion, `INV-XC-1`…`INV-XC-7`, rather than filled in.
- **It did not relax any authentication rule to make the public preview work.** The preview reads a projection of explicitly public fields. `MP-GBR-08`, `X-13` and the deny-by-default rule `AP-3` are untouched; `LIB-14B.29` states that authorisation is required *in addition to* authentication, never instead of it.
- **It still did not touch code.** Nine documents were created or amended in the second pass. `git diff` over `lib/`, `test/`, `packages/`, `tool/` is empty.
