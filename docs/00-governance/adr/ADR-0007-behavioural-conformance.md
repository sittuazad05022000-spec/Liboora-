# ADR-0007 — Conformance validates observable behaviour, not storage

| Field | Value |
|---|---|
| **Status** | Accepted |
| **Date** | 2026-08-02 |
| **Promotes** | `AR-7` (Architecture Rulings register v1.1) |
| **Scope** | Test strategy · all conformance suites |

## Context

Conformance rule `F-02` exists to prevent **account enumeration**: an attacker must not be able to learn whether
a mobile number is registered by watching how the system responds to an OTP request.

The original conformance test asserted that **no challenge was stored** for an unregistered number. That is an
assertion about internal state — specifically, membership of the in-memory `_issued` map, read through a
debug-only peek surface that is disabled in every release wiring. The assertion was doing two things wrong at
once. It could **pass while the system is insecure**: an implementation could store nothing and still leak
existence through a different response code, a different message, or a measurably different latency. And it
could **fail while the system is secure**: any implementation that pre-allocates a challenge for every request
precisely so that registered and unregistered numbers behave identically would be marked non-conformant for
doing the right thing.

A test that can be both a false negative and a false positive is not testing the requirement.

## Decision

**Conformance tests assert observable behaviour. They do not assert internal storage, data structures, private
fields, or implementation details.**

For `F-02` specifically, the assertion is re-expressed as the security property it was always meant to express:

> A caller can observe **no difference** between a registered and an unregistered mobile number until OTP
> verification succeeds — same response shape, same status, same message, same timing class, same subsequent
> behaviour.

`F-01` and `F-02` remain **closed**. Neither the defect nor its guard is removed; the guard is re-aimed at the
property the defect was about.

This generalises. Where a requirement is a security or behavioural property, the test asserts what an external
caller can see. Where a requirement is genuinely structural — an identifier format, a state-machine transition
that is itself part of the contract — the test may assert the structure, because the structure *is* the
observable requirement.

## Consequences

**Positive.** The suite now fails exactly when the security property is broken, and only then. Implementations
are free to change internal representation — in-memory map, cache, database, provider-side challenge — without
rewriting tests. The debug-only peek surface is no longer load-bearing for correctness, which removes a reason
to keep it.

**Negative.** Behavioural assertions are harder to write. Timing-equivalence in particular can only be asserted
as a timing *class*, not an exact duration, so it is a weaker guarantee than a state assertion would be. Some
properties need a test double at the boundary rather than direct inspection.

**Neutral.** Existing tests that assert structure where structure *is* the contract are unaffected and were not
rewritten.

## Consequence for the debug peek surface

`debugPeekChallenge` was introduced to support the storage-based assertion. With that assertion removed, the
surface has no conformance justification. Its removal is tracked as an implementation task alongside the other
demo/debug surfaces, because it currently auto-fills the OTP into the login field — a release-build concern
under `MP-CON-11`, not a test-strategy concern.

## References

Authentication PRD v2.0 Chapter 8 §8.3, `AUTH-11.73` ·
`ARCHITECTURE_RULINGS.md` `AR-7` · `IVR-001` §6.1, risk `RK-3` ·
`test/authentication_conformance_test.dart`
