#!/usr/bin/env bash
# =============================================================================
# CP-B1 M1 Devanagari rendering probe — raw-evidence capture helper
# =============================================================================
# GOAL: collect the *observed* artifacts for the M1 runbook (runbook section 4/5)
#       into a reserved staging directory so the evidence form can be filled
#       from what the run ACTUALLY observed.
#
# STRICT BOUNDARIES (DEVANAGARI_RENDERING_PROBE.md section 8; acceptance section 3):
#   * This script captures artifacts and metadata only.
#   * It records NO result, NO verdict, NO fixture PASS/FAIL.
#   * It does not create DDR-0012, does not amend any live status cell,
#     does not modify theme.dart / pubspec.yaml / fonts / fallback config.
#   * CP-B1 / FA-GAP-003 remain BLOCKED / UNVERIFIED until a real target run
#     plus the Design System Owner's DDR-0012 filing.
#
# USAGE:
#   1) Boot the KVM-less API-26 AVD (runbook section 2) and connect adb.
#   2) Build + install the as-built M1 app (runbook section 3).
#   3) cd tool/devanagari_probe
#      ./capture_evidence.sh <STAGE_DIR> [SERIAL]
#   4) Render each fixture F1..F7 on-screen (automation or manual tap),
#      calling ./capture_evidence.sh --fixture <F1..F7> <STAGE_DIR> [SERIAL]
#      between renders to grab the on-screen screenshot + font log.
#
# OUTPUTS (under <STAGE_DIR>):
#   target_validity.txt      device/API/RAM/resolution/ABI/accel metadata
#   fontlog_system.txt       dumpsys fontlog — faces present on this ROM
#   shot_<F>.png            in-context + full-canvas screenshots per fixture
#   fontlog_<F>.txt         per-fixture Font-substitution log excerpt
#   RUN_MANIFEST.txt        raw artifact inventory + the mandatory limitation marker
# =============================================================================
set -euo pipefail

LIMITATION_MARK='KVM-less AVD - glyph-guarantee evidence only; not TTI/jank/animation/performance-timing evidence.'

# run <cmd...> : print stdout (CR-stripped) or <unreadable>; never fails the script.
run() {
  local out
  if out=$("${@}" 2>/dev/null | tr -d '\r'); then
    printf '%s' "$out"
  else
    printf '<unreadable>'
  fi
}

main() {
  local mode="${1:-}"
  if [[ "$mode" == "--fixture" ]]; then
    fixture_capture "${2:-}" "${3:-}" "${4:-}"
    return 0
  fi
  base_capture "$mode" "${2:-}"
}

fixture_capture() {
  local fix="$1" stage="${2:-}" serial="${3:-}"
  if [[ -z "$stage" || -z "$fix" ]]; then
    echo "--fixture requires <F1..F7> and <STAGE_DIR>" >&2
    exit 2
  fi
  case "$fix" in
    F1|F2|F3|F4|F5|F6|F7) ;;
    *) echo "fixture must be F1..F7, got '$fix'" >&2; exit 2 ;;
  esac
  mkdir -p "$stage"
  local adb=(adb)
  [[ -n "$serial" ]] && adb=(adb -s "$serial")
  "${adb[@]}" exec-out screencap -p > "$stage/shot_${fix}.png" 2>/dev/null || true
  "${adb[@]}" shell logcat -d -s Font:V > "$stage/fontlog_${fix}.txt" 2>/dev/null || true
  echo "-- ${fix}: shot_${fix}.png, fontlog_${fix}.txt" >> "$stage/RUN_MANIFEST.txt"
  printf '[capture] fixture %s: shot_%s.png + fontlog_%s.txt captured\n' "$fix" "$fix" "$fix"
}

base_capture() {
  local stage="$1" serial="$2"
  if [[ -z "$stage" ]]; then
    echo "usage: ./capture_evidence.sh <STAGE_DIR> [SERIAL]" >&2
    echo "       ./capture_evidence.sh --fixture <F1..F7> <STAGE_DIR> [SERIAL]" >&2
    exit 2
  fi
  mkdir -p "$stage"
  local adb=(adb)
  [[ -n "$serial" ]] && adb=(adb -s "$serial")

  printf '[capture] target-validity metadata -> %s/target_validity.txt\n' "$stage"
  {
    echo "# CP-B1 M1 target-validity metadata (observed)  $(date -u +%Y-%m-%dT%H:%M:%SZ)"
    echo "serial=${serial:-<default>}"
    echo "sdk_level   = $(run "${adb[@]}" shell getprop ro.build.version.sdk)"
    echo "release     = $(run "${adb[@]}" shell getprop ro.build.version.release)"
    echo "abi         = $(run "${adb[@]}" shell getprop ro.product.cpu.abi)"
    echo "resolution  = $(run "${adb[@]}" shell wm size)"
    echo "meminfo_kb  = $(run "${adb[@]}" shell head -1 /proc/meminfo)"
    echo "limitation  = ${LIMITATION_MARK}"
    echo ""
    echo "VALIDITY SELF-CHECK (runbook section 2 - any NO means the run is BLOCKED; record BLOCKED):"
    echo "  [ ] ro.build.version.sdk reads 26"
    echo "  [ ] resolution reads 720 x 1600"
    echo "  [ ] memory ~2 GB class"
    echo "  [ ] abi x86_64"
    echo "  [ ] emulator started with -accel off (KVM-less / software)"
  } > "$stage/target_validity.txt"

  printf '[capture] system font stack -> %s/fontlog_system.txt (faces present on this ROM)\n' "$stage"
  "${adb[@]}" shell dumpsys fontlog > "$stage/fontlog_system.txt" 2>/dev/null || \
    echo "<dumpsys fontlog unavailable on this image>" > "$stage/fontlog_system.txt"

  # Raw-artifact manifest (NO verdict, NO result).
  {
    echo "# CP-B1 M1 raw-evidence manifest  $(date -u +%Y-%m-%dT%H:%M:%SZ)"
    echo "# This manifest records RAW ARTIFACTS ONLY. It records no result, no verdict, no fixture PASS/FAIL."
    echo "- target_validity.txt, fontlog_system.txt"
    echo '- present fixtures:'
    local any=0 f
    for f in F1 F2 F3 F4 F5 F6 F7; do
      if [[ -f "$stage/shot_${f}.png" ]]; then printf ' %s' "$f"; any=1; fi
    done
    [[ $any -eq 1 ]] || printf ' (none yet)'
    echo ""
    echo "limitation = ${LIMITATION_MARK}"
    echo "boundary = capture only; DDR-0012 not created; CP-B1/FA-GAP-003 remain BLOCKED / UNVERIFIED"
  } > "$stage/RUN_MANIFEST.txt"

  printf '[capture] done. Staging: %s\n' "$stage"
  printf '[capture] Next: fill docs/design/DEVANAGARI_RENDERING_EVIDENCE_<RUNID>.md ONLY from observed artifacts above. Record no verdict here.\n'
}

main "$@"
