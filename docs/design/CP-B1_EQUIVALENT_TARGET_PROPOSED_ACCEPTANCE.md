<!-- LIBOORA Design Documentation Foundation | 2026-10-02 -->

> This document is design governance and documentation. ⛔ Until the two named offices
> below filled both owner slots it **decided nothing** and **approved nothing**; ⭐
> **both slots are now filled (2026-10-02)** — this record is now the **approval record
> for equivalent-environment admissibility only**, and ⛔ not a rendering result.
> It does not amend product requirements, architecture decisions, bounded-context
> ownership, permissions, roles, scopes or backend contracts.

# CP-B1 — Proposed Acceptance: KVM-less API-26 x86_64 AVD as Owner-Accepted Equivalent Test Environment

| Field | Value |
|---|---|
| **Status** | ⭐ **ACCEPTED** — both office slots in §5 now filled (2026-10-02) · ⛔ no approval was fabricated, inferred, or self-assigned by AI — both statements were provided explicitly by the authorized human principal · prior state retained: ⛔ PROPOSED — PENDING DUAL OWNER ACCEPTANCE · both approver slots ⛔ UNRECORDED |
| **Decision status** | ⭐ **ACCEPTED** — both slots in §5 filled by the named offices (2026-10-02) · prior state retained: ⛔ PENDING |
| **Prepared** | 2026-10-02 · ⭐ **Design Documentation Owner** (preparation only — the *deciders* are the two offices in §5) |
| **Scope** | ⭐ Admissibility ruling for **one specific environment**: a KVM-less Android API-26 x86_64 AOSP AVD, for **CP-B1 Devanagari glyph/rendering-guarantee evidence only** · ⛔ no other evidence type, no other gate, no code change |
| **Source references** | `DEVANAGARI_RENDERING_PROBE.md` §1/§4/§5/§6 · `templates/DEVANAGARI_RENDERING_EVIDENCE_TEMPLATE.md` · `LIBOORA_DESIGN_AUTHORITY_CLOSURE_PACK.md` §3 field 7 re-trigger (*"an explicitly owner-accepted equivalent test environment under the repository's governance rules"*) · `DDR-0034` (confirmed V1 class) · `DESIGN_GOVERNANCE.md` §3 rule 4 (no silent convenience resolution) · `DDR-0002` (the Indic rendering requirement the guarantee must meet) |
| **Closes / changes** | ⛔ Nothing by itself — CP-B1 / `FA-GAP-003` remain **⛔ BLOCKED / UNVERIFIED**; `DDR-0012` remains **reserved-and-free**; G5 unchanged; no code, `pubspec`, or Android configuration is touched |

## 1. Target under acceptance (fixed — any other value is a BLOCKED condition, not a waiver)

| Parameter | Value |
|---|---|
| Android version / API | **8.0 / API 26** — the target **must read API 26** at run time; a target reading any other API level is `BLOCKED`, never downgraded to `FAIL` (`DEVANAGARI_RENDERING_PROBE.md` §6) |
| RAM | **~2 GB** (reference low-end class per `DDR-0034`) |
| Display | **720×1600** (per `DDR-0034`) |
| Image | **AOSP API-26 x86_64 system image** (AVD), running in the current sandbox under **pure-software (KVM-less) emulation** |
| Network | `DDR-0034`'s *primarily 4G / degraded* assumption is **context only** — the rendering guarantee is offline-independent (`DEVANAGARI_RENDERING_PROBE.md` §1 L27); **no network evidence is taken on this target** |
| App under test | **as-built Liboora at the probe commit** — M1 at the unmodified build; ⛔ no `theme.dart` / `pubspec.yaml` / font-configuration change for the probe |

## 2. Scope of admissibility (what the AVD may evidence — and only that)

⭐ **ONLY the Devanagari glyph/rendering guarantee** — the question `DDR-0002` poses:
*"does the confirmed V1 Android platform font stack render Devanagari reliably on the
target class?"* Concretely, acceptance admits the AVD to produce:

- **Fixtures F1–F7** (basic characters · vowel matras · halants · conjuncts · mixed
  Hindi+Latin · numerals/punctuation · representative student names) as specified in
  `DEVANAGARI_RENDERING_PROBE.md` §2 — the categories + C1–C8 are the contract;
- **Acceptance criteria C1–C8** (correct shaping per the expected Devanagari
  orthographic form · matra placement · conjunct formation · no tofu · no clipping ·
  no overlap · correct baseline · acceptable at 720×1600) per §3 of the probe doc;
- **The M1 → M2 evidence flow** (§4 of the probe doc): **M1** measures the **as-built,
  unchanged** platform stack (the "undeclared dependency" question); **M2** runs only
  if M1 fails, on the build carrying the `DDR-0012` remedy. ⛔ M2 has no authority
  before M1; ⛔ and M2's remedy design belongs to `DDR-0012` (still not created).

Rationale recorded for the owners: **glyph shaping is a deterministic text-rendering
property, independent of emulation speed.** The AOSP API-26 system image carries the
real platform font stack (Noto Sans Devanagari is part of the AOSP font set), so the
AVD measures exactly the guarantee `DDR-0002` requires — *which face renders each
glyph, and whether it renders correctly* — even under software emulation.

## 3. Limitations (MUST be recorded with every piece of evidence produced here)

- ⛔ **KVM is unavailable in this sandbox** (`/dev/kvm` absent; host is a nested VM
  without KVM passthrough) → the AVD runs under pure-software x86_64 emulation.
- ⛔ **Therefore this environment MUST NOT be used for:** TTI · jank · frame-budget
  (16 ms) · animation-duration · or any **performance-timing** evidence. Those metrics
  belong to `NFR_BUDGETS_V1` / `PERFORMANCE.md` (Design Performance Owner + Engineering)
  and remain **outside CP-B1**; a KVM-less target cannot vouch for them.
- ⛔ The AVD is **not a physical-device substitute** for performance validation — it is
  accepted **only** for the glyph/rendering guarantee within §2's scope.
- ⭐ Any future owner act may **narrow, amend, or withdraw** this equivalence; this
  record is a bounded admissibility ruling, not a permanent environment class decision.

## 4. Evidence requirements — UNCHANGED (this acceptance waives nothing)

Per `DEVANAGARI_RENDERING_PROBE.md` §5 and the template, every run on the accepted
environment must still capture:

1. **Device/API metadata** — device model (AVD config), **Android version + API
   (must read 26)**, RAM (~2 GB), resolution (720×1600);
2. **The actual app build** — as-built at the documented probe commit (M1); post-remedy
   build (M2 only, if M1 fails);
3. **Screenshots or equivalent visual evidence** — every fixture, in-context name
   surface and full-canvas;
4. **The font actually used per fixture** — font-substitution dump/log naming the face
   that rendered each glyph and whether fallback engaged;
5. **M1 baseline first** — before any remedy; ⛔ M2 only after M1 FAIL;
6. **The full fixture × criterion result matrix** (F1–F7 × C1–C8) per the template §4;
7. ⛔ **The §3 limitation marker** — every record produced on this environment must
   state: *"KVM-less AVD — glyph-guarantee evidence only; ⛔ not TTI/jank/animation/
   performance-timing evidence."*

## 5. Governance — required approvals (⭐ both accepted 2026-10-02; neither fabricated)

| # | Approver office (per existing convention) | Ground | Decision status | Date |
|---|---|---|---|---|
| 1 | **Design System Owner** *(office at `DESIGN_OWNERSHIP.md` §1 — owns the probe result; CP-B1 field 1)* | The acceptance *binds the Design System's guarantee probe* to a specific environment class | ⭐ **ACCEPTED** — *"I, the Design System Owner, accept the KVM-less API-26 x86_64 AOSP AVD as the equivalent test environment for CP-B1 Devanagari glyph/rendering-guarantee evidence ONLY (F1–F7, C1–C8, M1→M2), subject to the documented §3 limitation that it is not valid for TTI, jank, animation, frame-budget, or performance-timing evidence."* · Provenance: explicit approval statement supplied by the authorized human principal on the office's behalf, 2026-10-02 · prior state retained: ⛔ UNRECORDED — PENDING (no approval claimed) | **2026-10-02** |
| 2 | **Technical Owner** *(office constituted at `PRD_OWNERSHIP_MODEL.md` L86 — implementation/technical approach; the environment's technical validity is his ruling; CP-B1 field 1 second limb)* | The AVD/KVM condition is a **technical equivalence** claim; the closure-pack re-trigger requires it be *"explicitly owner-accepted"* | ⭐ **ACCEPTED** — *"I, the Technical Owner, accept the KVM-less software-emulated API-26 AVD as a technically valid equivalent target for the CP-B1 Devanagari glyph/rendering guarantee, subject to the documented §3 limitation that it is not valid for performance-timing evidence."* · Provenance: explicit approval statement supplied by the authorized human principal on the office's behalf, 2026-10-02 · prior state retained: ⛔ UNRECORDED — PENDING (no approval claimed) | **2026-10-02** |

**Effect of dual acceptance (only when both slots are filled by the offices):**
- The KVM-less API-26 AVD becomes the **admitted equivalent test environment** under
  the closure-pack re-trigger, for the §2 scope only;
- The CP-B1 probe may then **execute** (M1 first; M2 only on M1 FAIL) and its results
  feed `DDR-0012` (which is **still not created by this document**).

**What this record does NOT do (explicit, per `DESIGN_GOVERNANCE.md` §3):**
- ⛔ Does **NOT** close CP-B1 / `FA-GAP-003` — they remain **BLOCKED / UNVERIFIED**;
  closure requires the M1/M2 result **and** the `DDR-0012` decision;
- ⛔ Does **NOT** create or reference `DDR-0012` as existing (it remains reserved-and-free);
- ⛔ Does **NOT** mark any fixture PASS/FAIL — no result is asserted anywhere here;
- ⛔ Does **NOT** amend `DESIGN_GOVERNANCE.md` §4, any gate count, `DBT-008`, G5, or
  any live status cell — the closure-pack / action-plan `BLOCKED / UNVERIFIED` wording
  stands until the probe itself is run;
- ⛔ Does **NOT** modify application code, `pubspec.yaml`, `android/` configuration,
  fonts, or fallback settings;
- ⛔ Does **NOT** extend admissibility beyond §2 (TTI / jank / animation / performance
  stay outside CP-B1 by §3).

## 6. Change-control note

Per `DESIGN_CHANGE_MANAGEMENT.md` §4 fields: artifact = this acceptance record ·
decision status **ACCEPTED** (both approver slots filled 2026-10-02) · owner
(preparation: Design Documentation Owner; decision: Design System Owner +
Technical Owner) · date prepared **2026-10-02** · date of acceptance **2026-10-02**
(both slots filled, recorded in §5 with the exact approval statements, their
provenance, and their dates) · source references per the header ·
unresolved follow-up = the subsequent M1 probe run on the accepted environment
(the two approver slots are now filled; ⛔ closure of CP-B1 still requires the
M1/M2 result **and** the `DDR-0012` decision, neither of which this record makes).
*Prior state retained: decision status PENDING, date of acceptance UNRECORDED,
unresolved follow-up = the two UNRECORDED approver slots + M1 probe run.*
