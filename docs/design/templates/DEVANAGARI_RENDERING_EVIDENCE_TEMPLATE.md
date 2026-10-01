<!-- LIBOORA Design Documentation Foundation | Devanagari rendering evidence template -->

> This document is design governance and documentation. It does not amend product
> requirements, architecture decisions, bounded-context ownership, permissions, or
> backend contracts.

# Devanagari Rendering Evidence — TEMPLATE (CP-B1 / FA-GAP-003)

> **How to use.** Copy this file, rename it for the run, and fill every field from
> what the run **actually observed** on a valid target. A completed form is **not**
> a PASS — it records evidence; the verdict per the decision rule lives in the run
> record that this form feeds. ⛔ Do not pre-fill results. ⛔ Do not fill a form from
> Chrome/web/desktop or any non-API-26 target — that run is **BLOCKED**, and the
> form must say so.

## 1. Run identity

| Field | Value |
|---|---|
| Run ID / date | *(fill)* |
| Operator role | *(fill — role, never personal name)* |
| Measurement point | ☐ **M1 — as-built baseline** · ☐ **M2 — post-remedy** · ⛔ M2 requires the `DDR-0012` remedy to exist; ⛔ M1 must be run **first** |
| Governing spec | [`DEVANAGARI_RENDERING_PROBE.md`](../DEVANAGARI_RENDERING_PROBE.md) |

## 2. Target validity (⛔ any "NO" ⇒ the run is BLOCKED, stop here)

| Check | Value / observed | Valid? |
|---|---|---|
| Android version / API | *(observed)* | ☐ reads **API 26** |
| RAM | *(observed)* | ☐ **2 GB** class |
| Resolution | *(observed)* | ☐ **720×1600** |
| Device model | *(observed)* | ☐ noted |
| Rendering engine | *(observed)* | ☐ **actual Android rendering of the as-built app** — ⛔ no Chrome/web/desktop |
| App build / version | *(observed)* | ☐ matches the commit under test |
| Probe commit (repo HEAD at run) | *(observed)* | ☐ noted |

## 3. Environment (record, don't hide)

| Field | Value |
|---|---|
| Device(s) — model + ROM (≥ 2 recommended across the class) | *(fill)* |
| If only one SKU available | ⚠️ **known limitation recorded** (OEM ROM font stacks vary on low-end devices) |
| Font stack observed (platform dump) | *(fill — which faces are present on this ROM)* |

## 4. Fixture results (M1 and M2 separately)

Per fixture category `F1`–`F7` and criterion `C1`–`C8` — one row per fixture×criterion
that a defect applies to; a clean category records **PASS** once.

| Fixture (NFC) | Category | Criteria observed | Result | Defect type / location | Evidence ref |
|---|---|---|---|---|---|
| *(fill)* | `F1` basic | `C1`…`C8` | ☐ PASS ☐ FAIL | *(tofu / clip / overlap / baseline / unshaped)* | *(screenshot id / font-dump line)* |
| *(fill)* | `F2` matras | | ☐ | | |
| *(fill)* | `F3` halants | | ☐ | | |
| *(fill)* | `F4` conjuncts | | ☐ | | |
| *(fill)* | `F5` mixed | | ☐ | | |
| *(fill)* | `F6` numerals | | ☐ | | |
| *(fill)* | `F7` names | | ☐ | | |

## 5. Font actually used (per fixture)

| Fixture | Face that rendered it | Fallback engaged? | Face of fallback |
|---|---|---|---|
| *(fill)* | *(e.g. platform Noto Sans Devanagari / .notdef)* | ☐ yes ☐ no | *(face name)* |

## 6. Visual evidence inventory

| Item | Location / id | Captured? |
|---|---|---|
| Screenshot — full-canvas, all 7 categories | *(fill)* | ☐ |
| Screenshot — in-context name surface | *(fill)* | ☐ |
| Font-substitution dump / log excerpt | *(fill)* | ☐ |

## 7. Run verdict (per `DEVANAGARI_RENDERING_PROBE.md` §6)

| Verdict | Definition met? |
|---|---|
| ⛔ **BLOCKED** | invalid/unavailable API-26 target, or missing required evidence (any §2 "NO") |
| ⛔ **FAIL** | valid target, any fixture/criterion violation in §4 |
| ⭐ **PASS** | all 7 categories × all 8 criteria on the valid target |

- M1 verdict: ☐ BLOCKED ☐ FAIL ☐ PASS
- M2 verdict (M2 only, and only after a `DDR-0012` remedy exists): ☐ BLOCKED ☐ FAIL ☐ PASS

> ⛔ A PASS on M1 does **not** resolve CP-B1: it routes to the `DDR-0012` decision
> (declare the fallback chain). A FAIL on M1 routes to bundling/subsetting, and **M2
> must PASS** before the guarantee is met. ⛔ `DDR-0012` is filed by the Design System
> Owner from this evidence — this form feeds it; it does not create it.
