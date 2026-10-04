<!-- LIBOORA Design Documentation Foundation | 2026-10-03 -->

> This document is design governance and documentation. It does not amend product
> requirements, architecture decisions, bounded-context ownership, permissions, or
> backend contracts. It is a **prepared run record** under `DESIGN_CHANGE_MANAGEMENT.md`
> §4 that pre-fills only the fixed contract fields of the CP-B1 M1 probe. ⛔ **No result
> is recorded here** — CP-B1 / `FA-GAP-003` remain **⛔ BLOCKED / UNVERIFIED** until the
> M1 run executes on the admitted environment and the Design System Owner files `DDR-0012`.

# CP-B1 M1 Run Record — PREPARED (execution pending)

| Field | Value |
|---|---|
| **Status** | ⚠️ **PREPARED — EXECUTION PENDING** · ⛔ all result cells intentionally empty · ⛔ no PASS/FAIL/BLOCKED asserted · ⭐ **M1 execution scheduled to V2** at [`design-decisions/DDR-0036-cp-b1-m1-verification-deferred-to-v2.md`](design-decisions/DDR-0036-cp-b1-m1-verification-deferred-to-v2.md) *(2026-10-03 — governance routing only; this record still asserts no result; `FA-GAP-003` remains `BLOCKED / UNVERIFIED`; `DDR-0012` remains reserved-and-free; the `DDR-0002` V1 requirement remains fully in force)* |
| **Prepared** | 2026-10-03 · Design Documentation Owner (preparation only — the *decider* is the Design System Owner per `DEVANAGARI_RENDERING_PROBE.md` §1) |
| **Governing spec** | [`DEVANAGARI_RENDERING_PROBE.md`](DEVANAGARI_RENDERING_PROBE.md) §1–§6 · [`templates/DEVANAGARI_RENDERING_EVIDENCE_TEMPLATE.md`](templates/DEVANAGARI_RENDERING_EVIDENCE_TEMPLATE.md) |
| **Admitted environment** | [`CP-B1_EQUIVALENT_TARGET_PROPOSED_ACCEPTANCE.md`](CP-B1_EQUIVALENT_TARGET_PROPOSED_ACCEPTANCE.md) — KVM-less API-26 x86_64 AOSP AVD, **ACCEPTED** by both office slots 2026-10-02, scoped to the §2 glyph/rendering-guarantee evidence only |
| **Feeds** | `DDR-0012` (reserved-and-free — ⛔ not created by this record; filed by the Design System Owner from the executed evidence, probe §6/§7) |

## 1. Run identity (pre-filled from spec)

| Field | Value |
|---|---|
| Run ID / date | prepared 2026-10-03 · execution date *(fill at run)* |
| Operator role | Design System Owner *(fill at run — role, never personal name)* |
| Measurement point | ☑ **M1 — as-built baseline** (checked in advance per probe §4: M1 must run first) · ☐ M2 — post-remedy (⛔ M2 requires a filed `DDR-0012` remedy to exist) |
| App build / version | as-built Liboora at the probe commit *(fill — the commit the run documents; M1 is the unmodified build, probe §4)* |
| Probe commit (repo HEAD at run) | *(fill — repo HEAD at run; must match the app build)* |

**Mandatory environment limitation marker** (from the acceptance record §3 — must accompany every
piece of evidence produced on this target):

> *"KVM-less AVD — glyph-guarantee evidence only; ⛔ not TTI/jank/animation/performance-timing evidence."*

## 2. Target validity — planned configuration *(from acceptance §1; confirm observed at run)*

| Check | Planned value (admitted target) | Observed at run | Valid? |
|---|---|---|---|
| Android version / API | **8.0 / API 26** — the target must read API 26 at run time; a target reading any other API level is **BLOCKED**, never downgraded to FAIL | *(fill)* | ☐ |
| RAM | ~2 GB reference low-end class per `DDR-0034` | *(fill)* | ☐ |
| Resolution | 720×1600 | *(fill)* | ☐ |
| Device model | AOSP API-26 x86_64 system image (AVD), pure-software (KVM-less) emulation | *(fill)* | ☐ |
| Rendering engine | actual Android rendering of the as-built app — ⛔ no Chrome/web/desktop | *(fill)* | ☐ |
| App build / version | matches the commit under test | *(fill)* | ☐ |

⛔ Any "NO" above ⇒ the run is **BLOCKED** (probe §6), stop here; record BLOCKED, do not convert.

## 3. Environment (pre-recorded)

| Field | Value |
|---|---|
| Device(s) — model + ROM | Single admitted target: AOSP API-26 x86_64 AOSP AVD (~2 GB, 720×1600), KVM-less |
| If only one SKU available | ⚠️ **Known limitation recorded in advance** (probe §5: ≥2 devices recommended; OEM ROM font stacks vary on low-end devices — a single-SKU result must record this) |
| Font stack observed (platform dump) | *(fill at run — expected to include Noto Sans Devanagari in the AOSP image; record the actual faces present)* |

## 4. Fixture results — contract fixtures (probe §2, NFC-normalized)

Pre-filled from the probe §2 fixture set (the categories F1–F7 and criteria C1–C8 are the
contract). ⛔ Result / defect / evidence columns stay empty until the run observes them.

| Fixture (NFC) | Category | Criteria observed | Result | Defect type / location | Evidence ref |
|---|---|---|---|---|---|
| `अ आ इ ई उ ऊ ऋ ए ऐ ओ औ` · `क ख ग घ ङ च छ ज झ ट ठ ड ढ ण त थ द ध न प फ ब भ म य र ल व श ष स ह` | `F1` basic | `C1`–`C8` | ☐ PASS ☐ FAIL *(fill)* |  |  |
| `ा ि ी ु ू ृ े ै ो ौ` · anusvara `ं` · visarga `ः` · on bases: `का कि की कु कू कृ के कै को कौ` | `F2` matras | `C1`–`C8` | ☐ |  |  |
| `क ख ग` vs `क् ख् ग्` | `F3` halants | `C1`–`C8` | ☐ |  |  |
| `ज्ञ` *(U+091C U+095E)* · `क्ष` *(U+0915 U+0938 U+094D)* · `क्षि` *(U+0915 U+0938 U+094D U+0940)* · `त्र` *(U+0915 U+0930 U+094D)* · `श्य` · `क्व` | `F4` conjuncts | `C1`–`C8` | ☐ |  |  |
| `कृष्ण 1` · `R3-B कृष्ण` · `A-102 कृष्ण` | `F5` mixed | `C1`–`C8` | ☐ |  |  |
| Devanagari digits `० १ २ ३ ४ ५ ६ ७ ८ ९` · disambiguation set `0/O o` · `1/l/I` · `।` danda · `? ! . , ;` | `F6` numerals | `C1`–`C8` | ☐ |  |  |
| `ज्ञानदेव` · `कृष्णकान्त` · `राधिका` · `सृष्टि` · `प्रिया` | `F7` names | `C1`–`C8` | ☐ |  |  |

Criteria contract (probe §3): `C1` correct shaping · `C2` matra placement · `C3` conjunct
formation · `C4` no tofu · `C5` no clipping · `C6` no overlap · `C7` correct baseline ·
`C8` acceptable at 720×1600 in the real name-display surface.

## 5. Font actually used (per fixture)

| Fixture | Face that rendered it | Fallback engaged? | Face of fallback |
|---|---|---|---|
| `F1` | *(fill — e.g. platform Noto Sans Devanagari / .notdef)* | ☐ yes ☐ no | |
| `F2` | | ☐ | |
| `F3` | | ☐ | |
| `F4` | | ☐ | |
| `F5` | | ☐ | |
| `F6` | | ☐ | |
| `F7` | | ☐ | |

## 6. Visual evidence inventory

| Item | Location / id | Captured? |
|---|---|---|
| Screenshot — full-canvas, all 7 categories | *(fill at run)* | ☐ |
| Screenshot — in-context name surface (F7) | *(fill at run)* | ☐ |
| Font-substitution dump / log excerpt (face per glyph; whether fallback engaged) | *(fill at run)* | ☐ |

M1 baseline is captured **before any remedy**; ⛔ M2 only after M1 = FAIL and a filed
`DDR-0012` remedy build exists.

## 7. Run verdict (per `DEVANAGARI_RENDERING_PROBE.md` §6) — ⛔ not recorded

| Verdict | Definition met? |
|---|---|
| ⛔ **BLOCKED** | invalid/unavailable API-26 target, or missing required evidence (any §2 "NO") |
| ⛔ **FAIL** | valid target, any fixture/criterion violation in §4 |
| ⭐ **PASS** | all 7 categories × all 8 criteria on the valid target |

- M1 verdict: ☐ BLOCKED ☐ FAIL ☐ PASS *(⛔ unfilled — execution pending)*
- M2 verdict: not applicable until a `DDR-0012` remedy exists *(⛔ unfilled)*

**Decision routing on execution (probe §6):** M1 = PASS → `DDR-0012` remedy = declare an
explicit fallback chain. M1 = FAIL → `DDR-0012` remedy = bundle a subsetted Devanagari face
(+ declare fallback); M2 must then PASS C1–C8 on all fixtures. Either way CP-B1 moves from
BLOCKED to resolved **only when the Design System Owner files `DDR-0012`** on this evidence.

## 8. Execution tooling (prepared 2026-10-03 — the single external action)

The M1 probe **cannot be executed from this repository sandbox**: no `emulator`/`adb`/
`sdkmanager`, no JVM, no Flutter SDK, and no `/dev/kvm` are available here, while the
admitted target is a KVM-less API-26 x86_64 AOSP AVD under pure-software emulation. The
execution therefore requires one external host act. All repository-side preparation is
complete:

| Artifact | Location | Role |
|---|---|---|
| **Execution runbook** | [`tool/devanagari_probe/CP-B1_M1_PROBE_RUNBOOK.md`](../../tool/devanagari_probe/CP-B1_M1_PROBE_RUNBOOK.md) | Deterministic host steps 2–5: build the KVM-less AVD, install the as-built M1 app, capture fixtures F1–F7, fill the evidence form from observed values only |
| **Raw-capture helper** | [`tool/devanagari_probe/capture_evidence.sh`](../../tool/devanagari_probe/capture_evidence.sh) | Collects `target_validity.txt`, `fontlog_system.txt`, `shot_<F>.png`, `fontlog_<F>.txt` and a raw-artifact `RUN_MANIFEST.txt` into a staging dir — ⛔ writes no result, no verdict, no DDR-0012 |
| **Evidence form** | [`templates/DEVANAGARI_RENDERING_EVIDENCE_TEMPLATE.md`](templates/DEVANAGARI_RENDERING_EVIDENCE_TEMPLATE.md) | The observed-value form this run feeds (copy → `DEVANAGARI_RENDERING_EVIDENCE_<RUNID>.md`) |

**The single remaining external action** (runbook §7): on a host with a JVM, the Android
SDK with the API-26 x86_64 AOSP image, and the Flutter SDK — run the KVM-less AVD, build +
install the unmodified M1 app, render F1–F7 in-context, capture with `capture_evidence.sh`,
fill the evidence form from the observed artifacts **only**, then the **Design System Owner
files `DDR-0012`** from that result. Until that host act, CP-B1 / `FA-GAP-003` remain
**⛔ BLOCKED / UNVERIFIED**; this record (and the runbook and the helper) assert no result.

## 9. What this record does not do (per `DESIGN_GOVERNANCE.md` §3)

- ⛔ Records **no result** — no fixture PASS/FAIL, no verdict, no font-dump assertion.
- ⛔ Does **not** change any live status cell: `DESIGN_DEBT.md` `DBT-008`, closure-pack §12
  item #2, and the action-plan `FA-GAP-003` row all remain **⛔ BLOCKED / UNVERIFIED**.
- ⛔ Does **not** create or reference `DDR-0012` as existing (it remains reserved-and-free).
- ⛔ Does **not** modify `theme.dart`, `pubspec.yaml`, fonts, fallback configuration, or any
  application code; no Figma artifact; no commit, no push.
- ⛔ Does **not** extend admissibility beyond the accepted scope — TTI/jank/animation/
  performance-timing evidence stay outside CP-B1 on this target (acceptance §3 limitation).

## 10. Change-control note

Per `DESIGN_CHANGE_MANAGEMENT.md` §4: artifact = this prepared M1 run record · decision
status **PREPARED / EXECUTION PENDING** · owner (preparation: Design Documentation Owner;
execution + decision: Design System Owner, with Technical Owner for environment/bundling) ·
date prepared **2026-10-03** · date of decision UNRECORDED · source references per header ·
unresolved follow-up = **execute the M1 run on the admitted KVM-less API-26 AVD, fill every
observation cell from what the run actually observed, then the Design System Owner files
`DDR-0012`** — until then CP-B1 / `FA-GAP-003` remain BLOCKED / UNVERIFIED.
