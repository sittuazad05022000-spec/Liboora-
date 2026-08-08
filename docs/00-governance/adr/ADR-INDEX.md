# Architecture Decision Records — Index

| Field | Value |
|---|---|
| **Status** | Active register of record |
| **Supersedes** | `ARCHITECTURE_RULINGS.md` as the *interim* register (rulings `AR-1`…`AR-7` are preserved and promoted, not discarded) |
| **Closes** | Governance task `R-3` — "a formal ADR set is deferred" |
| **Date** | 2026-08-02 · **last extended 2026-08-04** |
| **Count** | **12 accepted** — `ADR-0001` … `ADR-0012` · **2 proposed** — `ADR-0013`, `ADR-0014` |

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
| [`ADR-0009`](./ADR-0009-invitation-security-model.md) | An invitation is a revocable claim, not a credential | Accepted | Completes `AR-4` | Library Management, `BC-18` |
| [`ADR-0010`](./ADR-0010-public-preview-anonymous-access.md) | Public library information is served anonymously from a projection | Accepted | Extends `AR-3` | Library Discovery, `BC-23`, `BC-19` |
| [`ADR-0011`](./ADR-0011-global-person-identity.md) | Global Person Identity is a platform identity, not a social profile | Accepted | Amends BC Map §4; closes `Q-05` | `BC-10`, `BC-01`, `BC-11`…`BC-13`, `BC-18` |
| [`ADR-0012`](./ADR-0012-scaffold-port-inversion-debt.md) | V1 scaffold port-inversion debt is time-boxed, not forgiven | Accepted | Applies Dependency Matrix §11; closes `MIG-14` | Whole platform — 12 dated exceptions, 4 removal waves |
| [`ADR-0013`](./ADR-0013-capability-context-ownership.md) | A capability context is owned by its platform, not by the domain that consumes it | **Proposed** | Would resolve `PGA-11` | `BC-19`, `BC-29`, `BC-25`; `PRD-002`, `PRD-013`, `PRD-015`, `PRD-017` |
| [`ADR-0014`](./ADR-0014-tenant-key-and-audit-mutation-enforcement.md) | `X-13` and `X-10` are enforced by reading the manifest that already declared them | **Proposed** | Completes `IMPL-014` — 10 of 12 → 12 of 12 | `tool/check_module_boundaries.dart`; Dependency Matrix §10.2, §10.4 |

**Two ADRs are `Proposed` and therefore not binding.** Both were written *before* the change they
describe, as step 1 of the Process below requires. Neither has altered a ranked document:

* **`ADR-0013`** requests an amendment to `Library_PRD_v1.md` (Rank 3, frozen). Its migration
  section is fenced — *"nothing in this section may be executed while this ADR reads Proposed"* —
  and the PRD is untouched.
* **`ADR-0014`** requests a correction to the Dependency Matrix (Rank 4) header, from
  *"10 of 12"* to *"12 of 12"* enforcement coverage. The enforcement code it records is already
  authorised by `IMPL-014` and changes no ranked document; the Matrix correction is **not** made,
  because Baseline §7 step 1 admits no exception for a correction that happens to be favourable.

## Rulings preserved but not promoted

| Ruling | Subject | Why not an ADR |
|---|---|---|
| `AR-1` | Library Discovery is a composition, not a bounded context | Domain-model classification, already binding in the Bounded Context Map §3. Recorded there, not duplicated here |
| `AR-3` | Public Library Discovery index | Library-domain decision. Now **carried into the Library PRD v1.0** (§14A, §14B). The *anonymous access mechanism* it implies is promoted to [`ADR-0010`](./ADR-0010-public-preview-anonymous-access.md); the ruling itself stands unchanged |
| `AR-4` | Invitation ownership | **Ownership** remains a Bounded Context Map §14 statement and is not duplicated here. The security specification the ruling deferred is now written, and the *governing principle* it required is promoted to [`ADR-0009`](./ADR-0009-invitation-security-model.md). The deferral is **lifted** |

## Process

1. A decision that changes structure, ownership, a boundary, or a platform-wide rule requires an ADR **before** implementation.
2. Number sequentially. Never reuse a number. Never edit an Accepted ADR's decision text — supersede it with a new ADR.
3. An ADR supersedes; it does not delete. The superseded record stays readable.
4. Record the ADR number in the commit that implements it.

## Change history

| Date | Change |
|---|---|
| 2026-08-04 | Added `ADR-0014` (`X-13` and `X-10` are enforced by reading the manifest that already declared them), **Proposed**. Closes the last two of the twelve enforcement categories Dependency Matrix §10.2 specifies, taking `IMPL-014` from **10 of 12** to **12 of 12**. **The cause was not a missing rule definition.** Both rules were already declared in `module_dependencies.yaml` — `banned_method_names` on `platform/audit` (`X-10`) and `global.tenant_key_required_in` + `tenant_key_violation_severity: blocker` (`X-13`) — and the checker never read either key. A manifest key that nothing reads is `SID-4.56`'s failure mode with a configuration file standing in for the good intention. **No rule was added and none weakened.** Four options rejected, including deleting the unread keys (would make the documents consistent by lowering them to the tooling's level) and waiving gate 3 to obtain a green pipeline (forbidden by `ADR-0012` §3.4; would also disable `X-10` and `X-13` as a side effect). Both checks find **nothing** on the current tree — `audit.dart` exposes only `append()`, and `platform/search` does not exist — so the six new tests each prove a check *fires* on a synthetic violation, since an "all clear" assertion cannot distinguish a working check from an absent one. Also automates the six §10.4 gates, which had no workflow file and ran by convention only. **`Proposed` because the consequent correction is to a Rank 4 document**: Baseline §7 step 1 requires an ADR *before* changing any Rank 1–5 document, and admits no exception for a correction that happens to be favourable. The Matrix is **unmodified**. No PRD, no law, no `X-*` rule text and no frozen document was touched. |
| 2026-08-04 | Added `ADR-0013` (a capability context is owned by its platform, not by the domain that consumes it), **Proposed**. Raised by `PGA-11`: `Library_PRD_v1.md`'s owning-contexts header claims `BC-19`, `BC-25` and `BC-29`, which the Bounded Context Map's **"Owning Platform"** column assigns to Shared Core, Configuration and Platform Services respectively. The Library PRD also contradicts itself — line 1094 records `BC-29` as *"References by id"* while its header says *"Owns"*. Distinguishes **context ownership** (contract, invariants, lifecycle) from **aggregate ownership** (a specific tenant-facing record), and holds that only the former is what "no duplicate ownership between PRDs" governs. The decisive evidence is mechanical: a rank-8 module owning a rank-3 capability would force `domain/person` (7.5), `platform/audit` (5) and `platform/search` (5) to depend **upward**, violating `L2` and `L4` and re-creating the `X-05` shape that `ADR-0011` introduced rank 7.5 to remove. Five options considered; splitting `BC-19` into `BC-19a`/`BC-19b` rejected as inventing a context no source document names. `BC-25` deliberately **left open** — no registered PRD exists to transfer it to, and inventing one would be inventing a requirement. **`Proposed` because the change it requests is to `Library_PRD_v1.md` (Rank 3, frozen)**; its migration section is fenced until Accepted and the PRD is **unmodified**. |
| 2026-08-04 | Added `ADR-0012` (V1 scaffold port-inversion debt is time-boxed, not forgiven), **Accepted**. Raised by the first-ever execution of `IMPL-014`, which found **38 violations** against pristine `9f15750`: one `L1` cycle and 37 cross-context mode violations. The cycle was **fixed in code** — `L1` is *"the one law with zero exceptions"* (Dependency Matrix §2) and §11 step 3 records that it is **never** approved for waiver. The 37 mode violations are pre-existing scaffold debt, governed here by **12 dated exceptions** across four removal waves (earliest expiry `2026-10-31`), each carrying `adr:` and `expires:` per §11 step 4. Three alternatives were rejected: weakening the checker, amending the manifest to `mode: import` (Matrix §12 permits exactly **one** direct-import permission), and extracting all 13 ports in the same commit as an identity migration. **The `app → domain/library` edge (9 findings) is deliberately NOT waived** — it is already tracked by `TASK-D10`, a P0 release blocker, and waiving it would convert a tracked blocker into untracked debt. Gate 3 therefore exits 1 by design. No existing ADR was edited or superseded; `ADR-0011` is untouched. No PRD was modified. |
| 2026-08-04 | Added `ADR-0011` (Global Person Identity is a platform identity). **This is the first ADR to amend the Bounded Context Map's Identity Triad (§4)** — `BC-10` is renamed, reclassified `[SUPPORTING]` → `[CORE]`, moved from the Social cluster to **rank 7.5**, and its cardinality changed from `0..1` opt-in to **`1:1` mandatory**. Linkage rules `ID-1`…`ID-6` and prohibition `X-05` are **preserved unamended**; only placement, name, classification and cardinality change. Consequentially amends global business rule `MP-GBR-02` (Master PRD v1.7) and makes `ID-4`'s `PersonId` non-nullable. Closes `Q-05`. No existing ADR was edited or superseded. |
| 2026-08-03 | Added `ADR-0009` (invitation security model) and `ADR-0010` (public preview anonymous access), both **Accepted**. Updated the two "preserved but not promoted" entries: `AR-3` and `AR-4` are unchanged as rulings, but the *gaps* they carried are closed. No existing ADR was edited, reinterpreted or superseded. |
| 2026-08-02 | Register created. `ADR-0001`…`ADR-0008` accepted; rulings `AR-1`…`AR-7` preserved. Closes `R-3`. |
