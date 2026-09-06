#!/usr/bin/env bash
#
# LIBOORA — run the MODULE_DEPENDENCY_MATRIX §10.4 pipeline gates locally.
#
# The same six gates, in the same order, as .github/workflows/architecture.yml.
# The requirement is that enforcement "work in CI" *and* "work locally"; keeping
# one ordered list in two places is how the two drift apart, so this script and
# the workflow are deliberately identical in content and order.
#
# Usage:
#   tool/gates.sh            # stop at the first failing gate (as CI does)
#   tool/gates.sh --all      # run every gate, then summarise
#
# Exit codes: 0 all gates passed · 1 at least one gate failed.
#
# NOTE — gate 3 is expected to fail today on nine `app -> domain/library`
# violations. ADR-0012 §3.4 deliberately leaves them un-waived so TASK-D10 (a
# P0 release blocker) stays tracked. That is a correct red, not a broken script.

set -uo pipefail

cd "$(dirname "$0")/.." || exit 2

KEEP_GOING=0
[[ "${1:-}" == "--all" ]] && KEEP_GOING=1

FAILED=()
PASSED=()

run_gate() {
  local num="$1" name="$2"
  shift 2
  printf '\n\033[1m── Gate %s · %s ──\033[0m\n' "$num" "$name"
  if "$@"; then
    PASSED+=("$num $name")
    printf '\033[32m✓ gate %s passed\033[0m\n' "$num"
    return 0
  fi
  FAILED+=("$num $name")
  printf '\033[31m✗ gate %s FAILED\033[0m\n' "$num"
  if [[ $KEEP_GOING -eq 0 ]]; then
    summary
    exit 1
  fi
  return 1
}

summary() {
  printf '\n\033[1m════ §10.4 gate summary ════\033[0m\n'
  for g in "${PASSED[@]:-}"; do [[ -n "$g" ]] && printf '  \033[32m✓\033[0m %s\n' "$g"; done
  for g in "${FAILED[@]:-}"; do [[ -n "$g" ]] && printf '  \033[31m✗\033[0m %s\n' "$g"; done
  if [[ ${#FAILED[@]} -eq 0 ]]; then
    printf '\n\033[32mAll gates passed.\033[0m\n'
  else
    printf '\n\033[31m%d gate(s) failed.\033[0m Gates 3 and 4 block merge (§10.4).\n' "${#FAILED[@]}"
  fi
}

run_gate 1 'dart format'                       dart format --output=none --set-exit-if-changed .
run_gate 2 'flutter analyze'                    flutter analyze
run_gate 3 'boundary checker (X-10, X-13)'      dart run tool/check_module_boundaries.dart
run_gate 4 'architecture tests'                 flutter test test/architecture/
run_gate 5 'full test suite'                    flutter test
run_gate 6 'build verification'                 flutter build web --release

summary
[[ ${#FAILED[@]} -eq 0 ]] || exit 1
