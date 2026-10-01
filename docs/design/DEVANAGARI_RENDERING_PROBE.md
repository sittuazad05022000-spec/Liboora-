<!-- LIBOORA Design Documentation Foundation | 2026-10-01 -->

> This document is design governance and documentation. It does not amend product
> requirements, architecture decisions, bounded-context ownership, permissions, or
> backend contracts.

# Devanagari Rendering Probe — CP-B1 / FA-GAP-003 Execution Specification

| Field | Value |
|---|---|
| Status | ⚠️ **PROPOSED — preparation document** · ⛔ **not a verification** · CP-B1 / `FA-GAP-003` remain **⛔ BLOCKED / UNVERIFIED** *(closure pack §3 field 7; action plan §4.3 — this document does not alter those status cells)* |
| Rank | ⛔ UNRANKED — unranked living procedure document, sibling of `DESIGN_QA.md` |
| Owner | Design System Owner (probe result) → Technical Owner (environment + bundling/fallback) · Design Governance Owner (licence, per `DDR-0002`) |
| Purpose | Fixed execution specification for the **future** target-class rendering evidence run that closes the CP-B1 guarantee probe — so that when a valid target exists, the run is deterministic and its evidence unambiguous |
| ⛔ Non-claims | No rendering has been verified · no result is asserted anywhere in this document · `DDR-0012` is **not** created by this document · no font bundling or fallback configuration exists · `theme.dart` / `pubspec.yaml` unchanged · Chrome / web / desktop rendering and any Android API level other than 26 are **invalid** for this probe |

## 1. Target (fixed — substitution is a BLOCKED condition, §6)

Per `DDR-0034` (ACCEPTED, Technical Owner, 2026-10-01), the probe measures the
as-built Liboora app on the confirmed V1 class only:

| Parameter | Value |
|---|---|
| Android version / API | **8.0 / API 26** (a target reading any other API level = BLOCKED, not FAIL) |
| RAM reference class | **2 GB** |
| Display reference | **720×1600** |
| Network assumption | primarily 4G, intermittent/degraded *(context only — rendering evidence is offline-independent)* |
| App under test | **as-built Liboora at the commit the run documents** — M1 at the unmodified build; M2 at the post-remedy build |
| Rendering under test | **Actual Android rendering** of the app or the platform text stack on that target — ⛔ no Chrome, web, desktop, or headless substitute |

## 2. Fixture set (proposed — to be ratified by the Design System Owner as part of the run)

⛔ These are **specification strings, not executed evidence.** All sequences are
recorded NFC-normalized; codepoint annotations are included for the high-risk
conjuncts so the set is deterministic and reproducible. Owner may finalize exact
name strings; categories F1–F7 and criteria C1–C8 are the contract.

| # | Category | Representative NFC fixture content |
|---|---|---|
| `F1` | **Basic characters** — independent vowels + consonants | `अ आ इ ई उ ऊ ऋ ए ऐ ओ औ` · `क ख ग घ ङ च छ ज झ ट ठ ड ढ ण त थ द ध न प फ ब भ म य र ल व श ष स ह` |
| `F2` | **Vowel matras** | `ा ि ी ु ू ृ े ै ो ौ` · anusvara `ं` · visarga `ः` · on bases: `का कि की कु कू कृ के कै को कौ` |
| `F3` | **Halants** (virama on/off) | `क ख ग` vs `क् ख् ग्` |
| `F4` | **Conjuncts** | `ज्ञ` *(U+091C U+095E)* · `क्ष` *(U+0915 U+0938 U+094D)* · `क्षि` *(U+0915 U+0938 U+094D U+0940)* · `त्र` *(U+0915 U+0930 U+094D)* · `श्य` · `क्व` |
| `F5` | **Mixed Hindi + Latin** | `कृष्ण 1` · `R3-B कृष्ण` · `A-102 कृष्ण` |
| `F6` | **Numerals / punctuation** | Devanagari digits `० १ २ ३ ४ ५ ६ ७ ८ ९` · disambiguation set `0/O o` · `1/l/I` · `।` danda · `? ! . , ;` |
| `F7` | **Representative student names** (full, multi-syllable, F2+F4 exercising) | `ज्ञानदेव` · `कृष्णकान्त` · `राधिका` · `सृष्टि` · `प्रिया` |

## 3. Visual acceptance criteria (all must hold per fixture, per measurement point)

| # | Criterion |
|---|---|
| `C1` | **Correct shaping** — the Unicode sequence must be correctly shaped according to the expected Devanagari orthographic form, with proper consonant joining, matra positioning, and no visual corruption |
| `C2` | **Matra placement** — dependent vowel signs attach at the correct positional slot with correct contact to the base consonant |
| `C3` | **Conjunct formation** — each F4 conjunct renders as the correct combined/ligatured form, not decomposed side-by-side codepoints |
| `C4` | **No tofu** — zero U+FFFD / `.notdef` / empty-box glyphs for any fixture codepoint |
| `C5` | **No clipping** — no ascender/descender/matra truncated at screen or name-surface edges at 720×1600 |
| `C6` | **No overlap** — no glyph collision (matra over consonant, conjunct overlap, Latin/Devanagari run collision) |
| `C7` | **Correct baseline** — matras/conjuncts sit on the expected baseline; no vertical drift between Devanagari and Latin within mixed runs |
| `C8` | **Acceptable at 720×1600** — C1–C7 hold at the app's target type scales/line-heights in the real name-display surface, not only a raw text canvas |

## 4. Measurement points (baseline → treatment order is mandatory)

| Point | App state | Purpose |
|---|---|---|
| **M1 — baseline (as-built, unchanged)** | Unmodified build: platform default face, no bundled font, no declared fallback chain (the configuration as shipped at the run's commit) | Measures what the **undeclared platform dependency** does on the confirmed class. **M1 must run before any font remedy is applied.** |
| **M2 — post-remedy** | The build carrying the `DDR-0012` remedy (declared fallback chain and/or bundled subsetted Devanagari face) | The CP-B1 guarantee is met only when **M2 passes C1–C8 on all fixtures** |

⛔ M1 measures the *platform* stack; it is the baseline, **not** the shipped guarantee.

## 5. Evidence (per measurement point × device)

Capture per the template `templates/DEVANAGARI_RENDERING_EVIDENCE_TEMPLATE.md`:
device model · Android version + API (must read 26) · RAM · resolution ·
app build/version + probe commit · the font actually used per fixture (font-substitution
log/dump) · screenshots or equivalent visual evidence of each fixture in-context and
full-canvas · fixture × criterion result matrix · whether fallback engaged and by which face.

≥ **2** devices spanning the 2 GB / API-26 / 720×1600 class is recommended
(OEM ROM font stacks vary on low-end devices; a single-SKU result must record that
as a known limitation).

## 6. PASS / FAIL / BLOCKED decision rule

| Verdict | Definition |
|---|---|
| ⛔ **BLOCKED** | The run was **not** on a valid target, or required evidence is missing: wrong API level · not the 2 GB / 720×1600 class · Chrome/web/desktop or other-API substitute · app not the as-built build under test · font dump or visual evidence not captured. **Any substitution ⇒ BLOCKED, never downgraded to FAIL.** CP-B1 / `FA-GAP-003` status remains ⛔ BLOCKED / UNVERIFIED. |
| ⛔ **FAIL** | Valid target, but **any** fixture in **any** category violates **any** of C1–C8 (tofu, broken conjunct/matra, clipping, overlap, baseline drift, unshaped sequence). Recorded per-fixture with defect type and location. |
| ⭐ **PASS** | All 7 fixture categories satisfy all 8 criteria on the valid target, with the rendering face documented. |

Probe outcome → decision routing (⛔ the probe is **evidence**, not the decision):
- **M1 = PASS** → the platform stack satisfies the guarantee; `DDR-0012` remedy =
  **declare an explicit fallback chain** (make the dependency declared; near-zero cost).
- **M1 = FAIL** → `DDR-0012` remedy = **bundle a subsetted Devanagari face**
  (+ declare fallback); **M2 must PASS** C1–C8 on all fixtures.
- **Either way:** CP-B1 moves from BLOCKED to resolved **only when the Design System
  Owner files `DDR-0012`** on this evidence (its reserved identifier remains
  free until an actual probe result exists — ⛔ not created by this preparation).

## 7. What `DDR-0012` will decide (owner flow after the probe)

Design System Owner, from the probe result: **(1)** bundle-vs-fallback selection
(cost governed by the `DDR-0034` 2 GB class); **(2)** the exact fallback chain to
declare; **(3)** subsetting scope if bundling; **(4)** numeral disambiguation
treatment for seat/enrollment numbers (F6); **(5)** licence routing to Design
Governance Owner; **(6)** amend `DESIGN_SYSTEM.md` L21 · `VISUAL_LANGUAGE.md` §4 ·
`MASTER` L181. ⛔ The `pubspec.yaml` / `theme.dart` code change is the downstream
**Technical Owner** implementation act — not part of the design decision.

## 8. Prohibited for this probe (recorded per `DESIGN_GOVERNANCE.md` §3)

- ⛔ Chrome, web, desktop, or headless rendering as evidence
- ⛔ Any Android API level other than 26 (the guarantee answer may differ across
  levels; §A.4 of the closure pack records exactly this risk)
- ⛔ Substituting another device class for 2 GB / 720×1600
- ⛔ Fabricated device screenshots, font dumps, or results — a BLOCKED run is
  recorded as BLOCKED, never converted to PASS by inference
- ⛔ Claiming CP-B1 / `FA-GAP-003` resolved before `DDR-0012` is filed on M2 evidence
