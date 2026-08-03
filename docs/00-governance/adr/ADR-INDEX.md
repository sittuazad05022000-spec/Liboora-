# Architecture Decision Records — Index

| Field | Value |
|---|---|
| **Status** | Active register of record |
| **Supersedes** | `ARCHITECTURE_RULINGS.md` as the *interim* register (rulings `AR-1`…`AR-7` are preserved and promoted, not discarded) |
| **Closes** | Governance task `R-3` — "a formal ADR set is deferred" |
| **Date** | 2026-08-02 |

---

## Why this register exists

`docs/10-architecture/ARCHITECTURE_RULINGS.md` describes itself as the *"interim register of record until a formal
ADR set exists"*, and `docs/10-architecture/README.md` instructed contributors to *"record the decision in
`ARCHITECTURE_RULINGS.md`"* **"while `docs/adr/` does not exist."**

It now exists. Approved rulings `AR-1`…`AR-7` remain valid and binding; each is promoted to an ADR below with its
original identifier preserved as a cross-reference. **No ruling was reinterpreted during promotion.**

## Status vocabulary

| Status | Meaning |
|---|---|
| **Accepted** | In force. Binding on all implementation |
| **Superseded** | Replaced by a later ADR, which is named |
| **Deprecated** | No longer applies; nothing replaces it |
| **Proposed** | Under consideration; not binding |

## Register

| ADR | Title | Status | Promotes | Governs |
|---|---|---|---|---|
| [`ADR-0001`](./ADR-0001-modular-monolith.md) | Modular monolith with a pure-Dart shared kernel | Accepted | — | Whole platform |
| [`ADR-0002`](./ADR-0002-mobile-otp-sole-factor.md) | Mobile OTP as the sole V1 authentication factor | Accepted | `MP-GBR-25`, `MP-CON-11` | `BC-18` |
| [`ADR-0003`](./ADR-0003-hybrid-tenancy-global-account.md) | Global account, tenant-scoped role assignment | Accepted | BC Map §11 | `BC-18`, `BC-19` |
| [`ADR-0004`](./ADR-0004-two-stage-authentication.md) | Authentication and session issuance are separate stages | Accepted | `AR-6` | `BC-18` |
| [`ADR-0005`](./ADR-0005-account-creation-on-first-otp.md) | Account creation on first successful OTP verification | Accepted | `AR-2` | `BC-18` |
| [`ADR-0006`](./ADR-0006-display-name-before-verification.md) | Display name collected before verification, always present | Accepted | `AR-5` | `BC-18` |
| [`ADR-0007`](./ADR-0007-behavioural-conformance.md) | Conformance validates observable behaviour, not storage | Accepted | `AR-7` | Test strategy |
| [`ADR-0008`](./ADR-0008-authentication-prd-v2-baseline.md) | Authentication PRD v2.0 is the official baseline | Accepted | Closes `D-7` | Documentation |

## Rulings preserved but not promoted

| Ruling | Subject | Why not an ADR |
|---|---|---|
| `AR-1` | Library Discovery is a composition, not a bounded context | Domain-model classification, already binding in the Bounded Context Map §3. Recorded there, not duplicated here |
| `AR-3` | Public Library Discovery index | Library-domain decision; belongs to the Library PRD when §§1–25 are supplied |
| `AR-4` | Invitation ownership | **Incomplete** — the invitation security specification was never written. Recorded as a gap in the Implementation Roadmap, not as an accepted decision |

## Process

1. A decision that changes structure, ownership, a boundary, or a platform-wide rule requires an ADR **before** implementation.
2. Number sequentially. Never reuse a number. Never edit an Accepted ADR's decision text — supersede it with a new ADR.
3. An ADR supersedes; it does not delete. The superseded record stays readable.
4. Record the ADR number in the commit that implements it.
