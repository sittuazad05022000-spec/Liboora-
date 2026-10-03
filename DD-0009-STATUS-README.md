# DD-0009 STATUS README — C-5 APP 3 Read-Only Platform Configuration Viewer

> Standalone handoff document. All facts below are verified from the Liboora
> repository as of the DD-0009 commit recorded in §1. This README is a
> summary; the design document itself is the source of truth.

---

## 1. Project / repository context

- **Repository:** `https://github.com/sittuazad05022000-spec/Liboora-.git`
- **Local path:** `/home/user/project`
- **Design document:** `docs/35-design/configuration/DD-0009-app-3-read-only-platform-configuration-viewer.md`
- **DD-0009 commit:** `162ddab` — `docs(design): persist DD-0009 C-5 viewer progress`
- **Document statistics (verified at that commit):** 914 lines, 67,016 bytes (~67 KB)
- **Push status:** ⚠️ **No push has been verified to succeed in this session.** `git push origin main` was attempted and failed with `fatal: could not read Username for 'https://github.com': No such device or address` (no GitHub credentials in the environment). Do not assume the commit is on the remote.

## 2. Title and purpose

**DD-0009 — APP 3 (read-only) platform configuration viewer surface design**

Designs surface **C-5** in bounded context **BC-25 Configuration**: the read-only
viewer that platform roles `PR-1` (Platform Administrator) and `PR-2`
(Platform Support) may use in **APP 3** (Platform Admin app) to view the
platform-default configuration parameters. It specifies presentation and
interaction behaviour at the fidelity that a Figma prototype or Flutter
implementation could be built without inventing UX, parameters, roles, or
authority.

**Design-only document. It designs. It does not authorize.**

## 3. Current status

- **Status:** `PROPOSED` — awaiting approval. NOT approved, NOT frozen, NOT authoritative.
- **Rank:** UNRANKED — where DD-0009 disagrees with any ranked document, the ranked document wins.
- **Verdict recorded in the document:** DESIGNED WITH EXPLICIT BLOCKERS.
- **Figma gate:** NOT OPEN (8 blockers listed in DD-0009 §26).
- **APP 3 runtime:** NOT authorized.

## 4. Target file path

```
docs/35-design/configuration/DD-0009-app-3-read-only-platform-configuration-viewer.md
```

## 5. Exact scope

- **Surface:** C-5 (read-only platform configuration viewer)
- **App:** APP 3 (Platform Admin) — reserved, empty, implementation NOT authorized
- **Bounded context:** BC-25 Configuration `[GENERIC]`, FOUNDATIONAL band
- **Behavior:** Read-only platform configuration viewer
- **Parameters:** exactly 19 (10 CFG + 9 SCFG), platform-default scope only
- **Out of scope:** surface C-4 (change history) — no V1 read surface per `ADR-0171`

## 6. The 19 authorized parameters

Source: `ADR-0154` §2.5 (10 CFG, Accepted) and `ADR-0155` §2.5 (9 SCFG, Accepted).
READ = `PR-1` + `PR-2`. WRITE = N/A (no write operation exists at scope 1).

### 6.1 The 10 CFG parameters (Authentication policy — `CONFIGURATION_GUIDE.md` §2)

| # | ID | Name | Default |
|---|---|---|---|
| 1 | `CFG-1` | OTP requests per mobile number / hour | 5 |
| 2 | `CFG-2` | Minimum interval between OTP requests | 30 sec |
| 3 | `CFG-3` | OTP requests per source network origin / hour | 100 |
| 4 | `CFG-4` | Temporary lock after quota exhaustion | 30 min |
| 5 | `CFG-5` | Idle session timeout (mobile / staff) | 30 d / 30 min |
| 6 | `CFG-6` | Absolute session lifetime (mobile / staff) | 90 d / 12 h |
| 7 | `CFG-7` | Trusted-device trust lifetime | 90 d |
| 8 | `CFG-8` | Maximum concurrently registered devices | 10 |
| 9 | `CFG-9` | Pending-verification retention | 24 h |
| 10 | `CFG-11` | Account-claim failures before lock | 5 / 24 h |

Note: `CFG-5` and `CFG-6` each carry two value limbs (mobile/staff) but remain
ONE parameter each — 0 new parameter IDs created.

### 6.2 The 9 SCFG parameters (Student identity policy — PRD-003 §5.5)

| # | ID | Name | Default |
|---|---|---|---|
| 1 | `SCFG-1` | Username length | 3–30 chars |
| 2 | `SCFG-3` | Username rename cooldown | 30 days |
| 3 | `SCFG-5` | Released-username hold period | 90 days |
| 4 | `SCFG-6` | Bio maximum length | 300 chars |
| 5 | `SCFG-7` | Global profile photo max size | 5 MB |
| 6 | `SCFG-8` | Global profile photo formats | JPEG, PNG, WebP |
| 7 | `SCFG-9` | Per-contributor composition timeout | 1,500 ms |
| 8 | `SCFG-10` | Public profile view rate limit | 60 / min / account |
| 9 | `SCFG-11` | Username availability-check rate limit | 30 / min / account |

## 7. HELD / excluded parameters (explicitly NOT in this surface)

| ID | Reason held | Owner |
|---|---|---|
| `CFG-10` | DPDP erasure obligation | Legal + Security |
| `CFG-12` | Self-referential: bounds `PR-2`'s own elevation | Authorization Owner (`ADR-0165`) |
| `SCFG-2` | Review authority not identifiable | Authorization Owner (`ADR-0166`) |
| `SCFG-4` | DPDP-adjacent retention | Privacy Owner |

These 4 are NOT designed, NOT authorized, and NOT displayed in C-5.
Rows are absent entirely — not greyed out, not rendered read-only.

## 8. Read-only rules

The surface is read-only by construction. No write control of any kind appears:

- No edit controls
- No save controls
- No reset / reset-to-inherited (`CNF-FR-078` not engaged)
- No update flows
- No write paths (`WRITE = N/A` on all 19, per `ADR-0154` D-4, `ADR-0155` S-4)
- No export, no scope selector, no tenant override
- No implementation authorization — `SECP-FR-007` ("no privileged capability
  in anticipation of need"), `ADR-0154` D-7/B1 limb 11
- DD-0009 §7.2 contains a keyword scan verifying 0 write-control terms appear
  as authority in the document

## 9. Roles and permission boundary

- **Authorized readers:** `PR-1` Platform Administrator, `PR-2` Platform Support
- **Excluded:** `TR-1`/`TR-2`/`TR-3` (tenant roles receive 0 read on these 19); `TR-4`/`TR-5`
- **`PR-2` ceiling:** may read thresholds (non-sensitive operational metadata);
  never authentication factors, session secrets, or tenant business data
- **Permission catalogue:** `AUTH-7.22` remains closed at zero — 0 `PERM-*` minted
- **Role set:** platform roles closed at two (`PRD-001` §2.3)
- **Tenant/business data:** not engaged — these are platform-level objects
- **Cross-app dependency:** one, declared, one-directional, read-only
  (APP 2 reads the same scope-1 values; no navigation between apps)

## 10. UI/UX design summary

- **Screens (2):**
  - **V-1 — Platform Configuration Viewer (main list):** 19 read-only rows in 2 groups (Authentication policy · Student identity policy); container width 65–75ch; no write controls
  - **V-2 — Parameter Detail (read-only):** full name, description, default, current value, range, owner, classification; back-only; no change history (C-4 out of scope)
- **Grouping:** `PRD-023` §13.2 two-group structure (by owning register) — not invented
- **Components:** only the `Read-only parameter row` (`PRD-023` §12.2) is used;
  the other 5 components (`Inherited-value field`, `Reset-to-inherited control`,
  `Range-bounded input`, `Field-level refusal`, `Scope selector`) are explicitly
  refused with source. No `MeterBar`, no sliders, no toggles.
- **States:** loading = skeleton rows; error = message + retry; empty = does not
  occur (19 fixed parameters); permission = not reachable for non-platform roles;
  offline = OPEN, no behavior invented
- **Interaction:** row tap → detail; long-press copy; back navigation; vertical scroll only
- **Responsive:** mobile portrait first (`MP-NFR-06`); tablet behavior deliberately NOT specified (0 breakpoints exist — `DBT-002`)
- **Accessibility:** intent named (no color-only cues, semantic labels, 48dp touch targets from Liboora's DESIGN_DECISION_PACK); WCAG numeric targets NOT adopted (owner = UI Design System, which does not exist as a ratified document)
- **Search / filter / sort:** OUT OF SCOPE — not authorized for C-5; explicitly refused

## 11. UI/UX Pro Max — reference divergence (disclosure)

DD-0009 was designed using the UI/UX Pro Max skill (`nextlevelbuilder/ui-ux-pro-max-skill`) as an unranked, reference-only methodology. Two different references are in play:

| Reference | Value | Meaning |
|---|---|---|
| Repository-pinned Liboora adoption reference | **`15de38f`** | The commit recorded in `LIBOORA_UIUX_PRO_MAX_RULES.md` and used by DD-0004/DD-0006/DD-0007 |
| Actually executed external workflow | **`09170ee`** (v2.13.0) | The commit cloned and whose `search.py` workflow was run for DD-0009 (`--domain ux`, `stack flutter`) |

These two references DIFFER. The divergence is recorded in DD-0009's metadata
header and §21. The skill is subordinate to every Liboora source; every rule
is either applied against a Liboora source, refused with a named Liboora
source, or deferred. 3 applied · 1 adapted · 6 refused (incl. Riverpod,
dark mode, `flutter 3.44.x` version-gating against Liboora's 3.35.4 pin).

## 12. Design-system constraints (OPEN, not resolved by DD-0009)

- **`DBT-001` — OPEN:** colour/spacing/typography token values exist in `theme.dart` but are not ratified in `DESIGN_SYSTEM.md`. DD-0009 names token references as intent only; 0 values adopted.
- **`DBT-005` — OPEN:** radius used in code but not tokenised (no `LiblRadius` class; 7 `BorderRadius.circular` calls, 3 values). No radius specified in C-5.
- **`DBT-008` — OPEN:** `G0`–`G4` recorded/PASSED (2026-09-30 / 2026-10-01), `G5` unrecorded and **deferred to V2** per [`DDR-0035`](docs/design/design-decisions/DDR-0035-g5-closure-deferred-to-v2-option-a.md) (Option A); `CP-B1`/M1 rendering evidence remains pending/unverified; the `DDR-0002` V1 Indic/Devanagari requirement remains in force.
- `CNF-XC-016` prohibits this module from defining design tokens; the owner is
  the UI Design System, which does not yet exist as a document. DD-0009 makes no
  unauthorized design-system decisions.

## 13. QA summary

- **13-check App-Boundary QA (README §2B.5):** 12 of 13 PASS · 1 GAP
  (check 8 — Figma gate; not rounded to 13/13)
- **DESIGN_QA checklist:** 5 PASS · 4 PARTIAL · 1 BLOCKED (handoff)
- **Figma gate:** NOT OPEN — 8 explicit blockers
  (DBT-001, DBT-005, DBT-008, DBT-002, DBT-003, DBT-004, SECP-FR-007, no Figma artifact)
- **Read-only keyword scan (DD-0009 §7.2):** PASS — 0 write-control terms

## 14. Current blockers / open questions

| # | Question | Owner | Status |
|---|---|---|---|
| QQ-1 | Operational meaning of the scope-1 read surface | Product Owner | OPEN |
| QQ-2 | §2B.5 readiness when a surface is prohibited from being designed | Design Governance Owner | OPEN (`DDR-0025` §4 Q2) |
| QQ-3 | "Approved use" for APP 3 in V1 | Product Owner | OPEN (`DDR-0025` §4 Q5; gates `SECP-FR-007`) |
| QQ-5 | APP 3 entry point (no app shell exists) | Architecture Owner | OPEN |
| QQ-6 | Offline behavior for platform-default reads | Engineering Owner | OPEN |
| QQ-7 | Stale pointer in `lib/app/platform_admin/README.md` L6 | Technical Owner | OPEN (disclosed, not corrected) |
| — | C-4 reader allocation (joint conferral) | Authorization Owner + BC-24 Owner | OPEN (`DDR-0025` §4 Q1) |

## 15. Out-of-scope items

C-4 change history/audit surface (no V1 read surface — `ADR-0171`) · all write
surfaces C-1–C-3 · APP 2 tenant configuration (DD-0007's domain) · the 4 HELD
parameters · search/filter/sort · export/reporting (BC-26, `PRD-009`) · scope
selector · inherited-value display · reset-to-inherited · range-before-write ·
field-level refusal · design tokens/radius/WCAG numbers (DBT-001/005/008) ·
responsive breakpoints (DBT-002) · performance budgets (NFR Budgets V1 does not
exist) · UI/UX Pro Max as authority · implementation/code · APP 3 runtime
authorization · new roles/permissions/action classes.

## 16. Implementation boundary (read this)

**DD-0009 describes the design only. It does NOT authorize APP 3
implementation or runtime work.**

- `ADR-0154` D-7: READ allocation may precede runtime; the ADR does not authorize APP 3 implementation.
- `SECP-FR-007`: a privileged capability must not be granted in anticipation of need.
- `lib/app/platform_admin/` remains reserved and empty (0 Dart files).
- `DDR-0025`: design act is permitted; runtime authorization is a separate future act gated on a Product-fact "approved use".

## 17. Document statistics (verified)

- 914 lines · 67,016 bytes (~67 KB)
- Committed at `162ddab` (`docs(design): persist DD-0009 C-5 viewer progress`)
- Sections: 28 (§1 Document identity … §28 Document completeness map)
- Later commits on main (e.g. `f758a31`, `b20d46d`) are automated session-file commits (`.ideavo/project`) and do not modify DD-0009.

## 18. Next recommended step

**Independent review of DD-0009 before any implementation authorization.**
Suggested reviewer profile: Sonnet 4.6 (or equivalent), reviewing against the
governing sources (`ADR-0154`, `ADR-0155`, `ADR-0171`, `DDR-0025`,
`PRD-023` §12, `CONFIGURATION_GUIDE.md`). The review should verify the 19/4
parameter boundary, the read-only invariants, the 13-check QA (12/13 + 1 GAP),
and the OPEN status of DBT-001/002/005/008. ⛔ No implementation work may
start until an independent review passes AND the APP 3 runtime question
(`SECP-FR-007` "approved use") is decided by the Product Owner.
