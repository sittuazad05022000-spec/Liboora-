<!-- LIBOORA Design Documentation Foundation | CP-B1 M1 probe execution runbook | 2026-10-03 -->

> This document is **design-governance execution preparation**. It is a **runbook** for a
> single external act that **this repository's sandbox cannot perform**: an actual Android
> API-26 AOSP rendering of the as-built app. ⛔ It records **no result**, **no verdict**, and
> **no evidence**. ⛔ It does not amend product requirements, architecture decisions,
> bounded-context ownership, permissions, roles, scopes or backend contracts. Until the run
> below executes on a real target and the Design System Owner files `DDR-0012`,
> CP-B1 / `FA-GAP-003` remain **⛔ BLOCKED / UNVERIFIED**.

# CP-B1 M1 Probe — Execution Runbook (single external action)

## 0. Why this is external

The admitted test environment (`CP-B1_EQUIVALENT_TARGET_PROPOSED_ACCEPTANCE.md`, dual-accepted
2026-10-02) is a **KVM-less Android API-26 x86_64 AOSP AVD** under **pure-software
emulation**. This repository sandbox has **none** of the required tooling:

| Requirement | In this sandbox | Verdict |
|---|---|---|
| Android SDK (`emulator`, `avdmanager`, `sdkmanager`, `adb`) | absent | ⛔ |
| JVM (`java`) — the emulator launcher needs it | absent | ⛔ |
| `/dev/kvm` | absent (KVM-less by design, but a **host** with the emulator is still required) | ⛔ |
| `flutter` SDK (`pubspec.yaml` `sdk: ^3.9.2`; app uses `dev.flutter.flutter-gradle-plugin`) | absent | ⛔ |

Therefore the M1 probe **must** run on a host that has: a JVM, the Android SDK with the
**API-26 x86_64 AOSP system image**, and the **Flutter SDK** — and where the sandbox's
KVM-absence is acceptable (pure-software AVD emulation). That host act is the **single
remaining external action**. This runbook + `capture_evidence.sh` make it deterministic.

## 1. Preconditions (verify before starting — any "NO" ⇒ record **BLOCKED** and stop)

- [ ] Host has `java`, `flutter`, and the Android SDK (`$ANDROID_HOME`) installed and on `PATH`.
- [ ] API-26 x86_64 **AOSP** system image installed:
      `sdkmanager "platforms;android-26" "system-images;android-26;x86_64;aosp"`
- [ ] The app is built **at the documented probe commit** (record `git rev-parse HEAD` here),
      and the M1 build is the **unmodified, as-shipped** build — ⛔ **no** `theme.dart` /
      `pubspec.yaml` / font / fallback change (that is the M2 remedy, not M1).
- [ ] The capture output directory is empty and reserved for this run.

## 2. Build the KVM-less API-26 AVD

```bash
# One-time: install the API-26 x86_64 AOSP image
sdkmanager "platforms;android-26" "system-images;android-26;x86_64;aosp"

# Create the AVD. Choose a device profile that is 720x1600 / ~2 GB RAM.
# Profile names are host/SDK-version dependent; e.g. "Nexus 5" is 1920x1080, so
# prefer a 720x1600-class profile, or pass an explicit -d / edit the AVD config:
avdmanager create avd -n liboora_api26_probe \
  -k "system-images;android-26;x86_64;aosp" \
  -d "pixel_7"          # <- replace with a 720x1600-class profile on this SDK

# Enforce the DDR-0034 / acceptance §1 reference class by editing ~/.android/avd/liboora_api26_probe.avd/config.ini:
#   hw.ramSize=2048
#   hw.lcd.width=720
#   hw.lcd.height=1600
#   hw.cpu.arch=x86_64
#   hw.keyboard=yes
#   hw.gpu=swiftshader_indirect    # software rendering (KVM-less)

# Launch KVM-less (pure-software):
emulator -avd liboora_api26_probe -accel off
# Wait for boot:
adb wait-for-device && adb shell getprop sys.boot_completed
```

**Target validity (acceptance §1 — fill from the booted AVD; any NO ⇒ BLOCKED):**

| Check | Command to observe | Must read |
|---|---|---|
| Android / API | `adb shell getprop ro.build.version.sdk` | **26** |
| API label | `adb shell getprop ro.build.version.release` | **8.0** |
| Resolution | `adb shell wm size` | **720 x 1600** |
| RAM class | `adb shell cat /proc/meminfo \| head -1` | **~2 GB** class |
| Architecture | `adb shell getprop ro.product.cpu.abi` | **x86_64** |
| Emulation | emulator started with `-accel off` | **KVM-less (software)** |

## 3. Build and install the M1 as-built app

```bash
PROBE_COMMIT="$(git rev-parse HEAD)"     # record this in the evidence form §1
flutter pub get
flutter build apk --debug                # unmodified build — M1 baseline
adb install -r build/app/outputs/flutter-apk/app-debug.apk
adb shell am start -n <applicationId>/<MainActivity>   # per AndroidManifest
```

Record the **app build / version** and the **probe commit** in evidence form §1/§2.

## 4. Capture the fixture evidence (C1–C8)

For each fixture `F1`–`F7` (the NFC strings in
`docs/design/CP-B1_M1_RUN_RECORD_PENDING_2026-10-03.md` §4 — ⛔ **use those exact
strings, do not retype them**), render it in-context and on a full canvas, and record:
- a **screenshot** (`adb exec-out screencap -p > shot_<F>.png`), and
- the **font that actually rendered each glyph** via the Android font-substitution log:

```bash
# Enable the platform font-substitution log, render a fixture, then dump it:
adb shell setprop persist.debug.rendering 1            # (if available on this image)
adb shell "logcat -s Font:V" &                          # captures Font-substitution events
# ... render the fixture on-screen (automation or manual tap) ...
adb shell logcat -d -s Font:V > fontlog_<F>.txt         # the "face that rendered it" + fallback
```

`dumpsys` alternative for the active font list on this ROM (acceptance §3 "font stack observed"):

```bash
adb shell dumpsys fontlog > fontlog_system.txt          # which faces are present on this ROM
```

Run `F6` (numerals) carefully — `C4` no-tofu and the `0/O/o`, `1/l/I` disambiguation set are
the highest-risk glyphs. Run `F7` (names) **in the real name-display surface** for `C8`
("acceptable at 720×1600 in the real name surface, not only a raw text canvas").

## 5. Fill the evidence form (only observed values)

Copy `docs/design/templates/DEVANAGARI_RENDERING_EVIDENCE_TEMPLATE.md` →
`docs/design/DEVANAGARI_RENDERING_EVIDENCE_<RUNID>.md` and fill **only from what the run
observed** (device/API metadata, the build, screenshots, the per-fixture face + fallback,
the F×C result matrix). ⛔ **Do not pre-fill results.** `capture_evidence.sh` in this folder
collects the raw artifacts into a staging dir; it writes **no** result/verdict cell.

## 6. Verdict routing (Design System Owner — NOT this runbook)

Per `DEVANAGARI_RENDERING_PROBE.md` §6:

- **M1 = PASS** → `DDR-0012` remedy = **declare an explicit fallback chain**.
- **M1 = FAIL** → `DDR-0012` remedy = **bundle a subsetted Devanagari face** (+ declare
  fallback); **M2 must PASS** C1–C8 on all fixtures.
- Either way CP-B1 moves from BLOCKED to resolved **only when the Design System Owner files
  `DDR-0012`** on this evidence (reserved-and-free until then).

## 7. The single remaining external action

> **Run steps 2–5 above on a host that has a JVM, the Android SDK with the API-26 x86_64
> AOSP image, and the Flutter SDK; capture the observed evidence into
> `DEVANAGARI_RENDERING_EVIDENCE_<RUNID>.md`; then the Design System Owner files `DDR-0012`
> from that result; then G5 + the final authority act proceed.**

⛔ Nothing in this runbook asserts a rendering result, a fixture verdict, a PASS, or a
signature. The ⚠ known single-SKU limitation (acceptance §1: one admitted AVD; probe §5
recommends ≥2 spanning the class) must be recorded on the evidence form.
