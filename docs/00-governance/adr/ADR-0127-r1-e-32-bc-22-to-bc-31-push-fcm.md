# ADR-0127 — R1: allocate E-32 to the BC-22 → BC-31 Push/FCM edge

| Field | Value |
|---|---|
| **ADR** | `ADR-0127` — R1 allocation decision for the existing Push/FCM egress contract |
| **Status** | ⭐ **Accepted** — 2026-09-09 |
| **Decider** | **Architecture Owner**, under the explicit R1 decision request |
| **Scope** | The edge identifier allocation only. No PRD precedence act, OTP-SMS ownership act, R2 repair, M2 execution, code change or TASK-D10 change |
| **Supersedes** | — |
| **Related** | `ADR-0126` (D2 split and R1 routing) · `MASTER_PRD.md` L229 · `PRD-010` `NTF-FR-031` · `PRD-021C` C8 §13 · BC Map L292 and E-25 |

## 1. Decision

**Approve the following allocation:**

| Identifier | Upstream | Downstream | Pattern | Mechanism | Release | Scope |
|---|---|---|---|---|---|---|
| **`E-32`** | **BC-22 Notification Delivery** | **BC-31 Integration** | **`CF`** | **Sync port** | **V1** | **Push/FCM egress only** |

This decision records the Architecture Owner's approval of the identifier for the already-authoritative Push/FCM contract. It does not invent a new capability, event, payload, provider, credential boundary, or integration pattern.

The allocation is approved now, but **BC Map registration/mint is deliberately deferred to M2**. Until M2 is separately entered, the BC Map remains unchanged and contains no `E-32` row or declaration.

## 2. Authoritative evidence

### 2.1 Rank-1 product authority

`MASTER_PRD.md` L229 records:

> Push notifications | `BC-22` via `BC-31` Integration | Channel adapter | Firebase Cloud Messaging | Yes — FCM (V1)

This is the governing V1 product contract.

### 2.2 Rank-3 notification authority

`PRD-010_NOTIFICATIONS_AND_COMMUNICATION.md` `NTF-FR-031` states that Push **MUST** reach FCM through `BC-31` and that `BC-22` must not hold FCM credentials. Its `NTF-INV-005` places outbound third-party contracts and provider credentials in `BC-31`.

### 2.3 BC Map authority and precedent

BC Map L292 states that an edge absent from the integration table does not exist and requires an ADR to add. Existing `E-25` is the precedent for a capability-to-integration `CF` edge over a Sync port. This ADR supplies the required allocation decision; it does not yet perform the BC Map change.

### 2.4 E-31 reservation evidence

PRD-021C C8 `LMT-XC-009` says `E-31` would be next but is not minted. C8 §13 separately requires a referral transport between `BC-13` and `BC-19`, identifies `E-31` as the required edge number, assigns the matter to the Architecture Owner with the BC-19 owner, and records that it blocks `IMPL-1424`.

That PRD is a Stage-2 draft and therefore does not create a rank precedence conflict. Nevertheless, its explicit reservation is load-bearing identifier hygiene. **`E-31` is untouched and reserved; this ADR does not reassign, consume, or mint it.**

## 3. Explicit boundaries and non-decisions

1. **Push/FCM only.** This ADR does not authorize or describe OTP SMS delivery.
2. **OTP-SMS ownership remains OPEN.** The `IMPL-020` OTP route assumption is not reconciled here against frozen `AUTH-10.37` or baselined `PRD-010` N7.
3. **No E-31 change.** The reserved `BC-13 → BC-19` referral-transport question remains under its own Architecture Owner + BC-19 owner route.
4. **No BC Map change.** No row, section, version, context count, edge count or changelog entry is added by this ADR.
5. **No R2 repair.** The stale `PRD-021A` citation to BC Map L649 is not repaired here.
6. **No M2.** M2 remains held until its stated prerequisites are satisfied and separately executed.
7. **No implementation.** No code, checker, dependency, test, adapter, `TASK-D10` file or implementation blocker is changed or closed by this ADR.
8. **No frozen or Rank-1–3 artifact change.** `MASTER_PRD`, `PRD-010`, `PRD-021C` and all other frozen/Rank-1–3 artifacts remain untouched.

## 4. Execution and next gate

This ADR is the R1 approval act only. The next gates are:

1. **R2:** repair the pre-existing stale BC Map L649 citation under the PRD-021A owner route; do not silently overwrite it.
2. **M2:** after R2 is cleared, append the approved `E-32` edge to the BC Map using the repository's append-only/version/changelog discipline. M2 is not executed by this ADR.
3. **Implementation:** code and `TASK-D10` remain blocked by the existing D1/D2 implementation gate and are not unblocked by this allocation approval alone.

## 5. Approval record

**Architecture Owner decision: ACCEPTED.**

Approved decision: **`E-32` = `BC-22 → BC-31`, `CF` + Sync port, V1, Push/FCM egress only.**

The approval is intentionally narrower than execution: it allocates the identifier decision while preserving `E-31`, leaving the BC Map byte-unchanged, and deferring R2, M2, OTP-SMS ownership, code and TASK-D10.

## 6. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-09 | Dedicated R1 ADR prepared and **Accepted**. Approved `E-32` for the existing `BC-22 → BC-31` Push/FCM contract; preserved `E-31`; deferred BC Map registration to M2; made no Rank-1–3, PRD, R2, M2 or implementation changes. |
