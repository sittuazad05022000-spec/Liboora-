# ADR-0061 — Rank 3 alertability outranks the EA's V2 `Alerting` tag, by precedence; the EA is not edited

| Field | Value |
|---|---|
| **Status** | `Accepted` |
| **Date** | 2026-08-21 |
| **Deciders** | **Architecture Review Board**, acting through the **Architecture Owner** role defined in [`PRD_OWNERSHIP_MODEL.md`](../prd-ecosystem/PRD_OWNERSHIP_MODEL.md) §2.2 and §2.3 — *"Boundaries, ranks, permitted edges, **precedence**"*. Exercised by **direct conferral of the human principal of this engagement**, §6 |
| **Supersedes** | Nothing |
| **Amends** | **Nothing.** No PRD, no BC Map, no matrix, no manifest, and **not** the Enterprise Architecture. `ADR-0058` records the identical *Amends* determination for the identical class of conflict |
| **Amended by** | — |
| **Baseline** | **No baseline re-issue.** No document changes version; baseline §7 rule 4 requires a **Rank 1–3** version change |
| **Closes** | `SECP-ADR-002` · `SECP-DEP-001` · `SECP-GAP-031` · `SECP-GAP-023` · the `SECP-GAP-031`/`023` half of blocker **`B7-4`** |
| **Does NOT close** | `SECP-GAP-042` and `SECP-GAP-043`, the other two conflicts in `B7-4` — separate ADRs. Nor does it prove any alert exists: it decides a precedence question and verifies no code |
| **Opens** | Nothing |
| **Related** | `ADR-0058` / `FIL-GAP-015` (the precedent) · `ADR-0038` **L101** · `MP-CON-08` · `DOCUMENTATION_BASELINE.md` §4 |

---

## 1. The question

`SECP-ADR-002`, verbatim:

> *"**Reconcile Rank 3 alertability (`AUTH-11.26`…`11.28`) with EA-V2 `Alerting`.** A Rank 3 `FROZEN` requirement and
> a Rank 6 version tag disagree. L253 forbids this PRD choosing. Amending a frozen PRD or the EA both require a
> recorded act."*

`SECP-GAP-023` is the same shape: `MP-RSK-01`'s cross-tenant mitigation against the EA's `Query Guardrails (V2)` and
`Cross-Tenant Leak Tests (V2)`.

The operative constraint is that **`PRD-012a` was right not to choose.** `DOCUMENTATION_BASELINE.md` §4 L253:
*"**A conflict is a defect.** If you find one, do not choose — raise it."* It raised it. This ADR is the recorded act
that answers it.

---

## 2. What was measured

| Measurement | Source | Result |
|---|---|---|
| The three alertability obligations | `prd-v2/11-NFR-Compliance-and-Final-Acceptance.md` **L130–132**; `Authentication_PRD_v2.md` **L4347–4349** | `AUTH-11.26` sustained verification-failure/lockout rise **MUST be alertable**; `AUTH-11.27` any cross-tenant access attempt **MUST be alertable immediately, no threshold**; `AUTH-11.28` any session-binding violation, likewise |
| Their rank | `DOCUMENTATION_BASELINE.md` §4 | **Rank 3** — `PRD-001` Authentication, `FROZEN` |
| The EA's `Alerting` placement | `LIBOORA_ENTERPRISE_ARCHITECTURE.md` **L1960–1965** | `Alerting (V2)`, with `Alert Rules (V2)`, `Alert Channels (V2)`, `Severity Levels (V2)`, `Alert Suppression (V3)`, `On-Call Escalation (V3)` |
| The EA's rank, and its own governing instruction | `DOCUMENTATION_BASELINE.md` §4, Rank 6 row | **Rank 6** — *"**Descriptive only.** Update it to match 1–5; **never the reverse**"* |
| Whether precedence is discretionary | `ADR-0038` **L101** | *"**Precedence — mechanical, not a decision** … So the tier question is already settled against the EA"* |
| The same rule at Rank 1 | `MP-CON-08` | Repeats the descriptive-only precedence order |
| What a rank disagreement *is* | `ADR-0045`/`ADR-0046` via `MP-CON-08` | *"a **defect to be raised**, not a choice to be made"* |
| The nearest precedent | `DOCUMENTATION_BASELINE.md` **L289**, `FIL-GAP-015` | *"Job Runtime is V1 at Rank 3 and V2 at Rank 6 — **a sequencing conflict resolved by precedence, the EA not edited**"* |
| How that precedent was executed | `ADR-0058` header; **L175** | *Amends:* *"Nothing. No PRD, no BC Map, no matrix, no manifest, no EA"*; the EA *"**not edited** — it is descriptive, and Job Runtime *as a scaled subsystem* genuinely remains V2"* |
| `MP-RSK-01`'s mitigation column | `MASTER_PRD.md` **L551** | *"**Multi-Tenant Test Suite in CI**; cache/index/namespace changes are security-reviewable"* — **Rank 1 already names a CI test suite** |
| The EA's cross-tenant tags | `LIBOORA_ENTERPRISE_ARCHITECTURE.md` **L2083**, **L2085** | `Query Guardrails (V2)`, `Cross-Tenant Leak Tests (V2)` |

### 2.1 The measurement that settles `SECP-GAP-023` separately

`SECP-GAP-023` was framed as *"is cross-tenant leak mitigation deferred to V2?"*. **Rank 1 answers it without any
precedence argument at all**: `MP-RSK-01`'s *Mitigation* column names a **Multi-Tenant Test Suite in CI** as the
mitigation for a **Critical** risk. A mitigation stated at Rank 1 in the present tense is not deferred by a Rank 6
version tag. The EA's `Cross-Tenant Leak Tests (V2)` describes a *scaled subsystem*; it does not postpone the Rank 1
mitigation — precisely the distinction `ADR-0058` L175 drew for Job Runtime.

---

## 3. What was considered and refused

| Option | Why refused |
|---|---|
| **Edit the EA: retag `Alerting (V2)` → `(V1)`** | ⛔ Refused, and this is the central refusal. It looks like the tidy fix and `ADR-0042` did once move exactly one EA token. But `ADR-0058` faced this identical conflict class and **declined**, and its reasoning holds here: the EA is **descriptive**, and `Alerting` **as a scaled subsystem** — rules engine, channels, severity taxonomy, suppression, on-call escalation — genuinely remains V2. What Rank 3 requires is that three specific conditions be **alertable**, not that the V2 alerting *platform* exist. Retagging would overstate what Rank 3 compels and would edit a document the baseline says to update *to match* 1–5, when 1–5 and 6 are not in fact describing the same object |
| **Amend frozen `PRD-001` to soften `AUTH-11.26`…`11.28` to V2** | ⛔ Refused absolutely. It would weaken three frozen `MUST` obligations to make a gate pass — the act the instruction for this pass expressly forbids — and `PRD_LIFECYCLE.md` L177 holds that *"a frozen PRD is never silently modified"*. `PGA-01` and `PGA-02` are confirmed defects left standing for this reason |
| **Let `PRD-012a` choose a reading in its own text** | ⛔ Refused. Baseline §4 **L253** forbids it, and `PRD-012a` correctly did not. Its restraint is upheld, not overridden |
| **Declare the conflict unresolvable and defer** | ⛔ Refused. `ADR-0038` L101 is explicit that precedence is *"mechanical, not a decision"* — the tier question **is already settled** by the rank table. Deferring a mechanically-settled question would manufacture an open item out of an answered one |
| **Create a new `SECP-*` requirement obliging the alerts** | ⛔ Refused. `PRD-012a` already carries the obligations it needs, and `AUTH-11.26`…`11.28` are `BC-18`'s. Restating another PRD's frozen requirement in this module would create the second source of truth `ADR-0040` L166 forbids |

---

## 4. Decision

**1. The conflict is resolved by precedence, and precedence was already decided.** `DOCUMENTATION_BASELINE.md` §4
places `PRD-001` at **Rank 3** and the Enterprise Architecture at **Rank 6**, *"Descriptive only. Update it to match
1–5; never the reverse."* `MP-CON-08` repeats it at Rank 1. Therefore:

> **`AUTH-11.26`, `AUTH-11.27` and `AUTH-11.28` are binding V1 obligations. The EA's `Alerting (V2)` tag does not
> defer them.**

**2. The EA is NOT edited**, on the `ADR-0058` precedent. The two documents are not describing the same object:
Rank 3 requires three **conditions to be alertable**; Rank 6 tags an **alerting subsystem** — rules, channels,
severity taxonomy, suppression, escalation — which genuinely remains V2. A V1 obligation that a cross-tenant attempt
be alertable is satisfiable without the V2 subsystem existing.

**3. `SECP-GAP-023` is closed on Rank 1, not on precedence.** `MP-RSK-01`'s mitigation column names a **Multi-Tenant
Test Suite in CI**. That mitigation is stated at Rank 1 for a **Critical** risk and is **not deferred**. The EA's
`Query Guardrails (V2)` and `Cross-Tenant Leak Tests (V2)` describe scaled machinery, not the postponement of the
Rank 1 mitigation.

**4. Nothing is amended.** No PRD, no BC Map, no matrix, no manifest, no EA, no requirement text. This ADR records
which document governs; it changes neither.

### 4.1 What this rests on

| Ground | Source | Rank |
|---|---|---|
| Rank 3 outranks Rank 6 | `DOCUMENTATION_BASELINE.md` §4 | **1** |
| The EA is descriptive and follows 1–5, never leads | `DOCUMENTATION_BASELINE.md` §4 Rank 6 row; `MP-CON-08` | **1** |
| Precedence is mechanical, not discretionary | `ADR-0038` **L101** | **2** |
| A rank disagreement is a defect to raise, not a choice | `MP-CON-08` via `ADR-0045`/`ADR-0046` | **1** |
| A Rank 3/Rank 6 sequencing conflict is resolved by precedence with the EA left unedited | `ADR-0058`; `FIL-GAP-015` at baseline **L289** | **2** |
| The cross-tenant mitigation is a present-tense CI suite | `MASTER_PRD.md` **L551**, `MP-RSK-01` | **1** |

### 4.2 What it does not rest on

- **Not** on the EA. `ADR-0046` §2.1 refuses *"the EA already says X"* as grounds, and the EA is the **lower**-ranked
  document here in any case.
- **Not** on any new requirement. **0** `SECP-*` identifiers are minted.
- **Not** on convenience. The narrower finding — that the two documents describe different objects — is stated
  instead of the broader and easier one that the EA is simply wrong.

---

## 5. What this ADR does not do

| Thing | Why not |
|---|---|
| **Prove any alert exists** | It decides precedence. **0** alerts are implemented, **0** acceptance criteria are proven, and no `SECP-AC-*` moves. `ADR-0055`'s phrasing applies: *"This ADR authorises an edge; it verifies no code."* |
| **Edit the EA** | §3, §4 finding 2. The tag stays `Alerting (V2)` |
| **Touch frozen `PRD-001`** | Byte-unchanged. Its three obligations are **cited**, not restated or amended |
| **Close `SECP-GAP-042` or `SECP-GAP-043`** | Separate questions with separate owners — `ADR-0062` and `ADR-0063` |
| **Freeze `PRD-012a`** | Stage 7 is a Governance Owner act requiring its own ADR and a baseline §3 row |
| **Touch code** | **0 lines** under `lib/`, `packages/`, `test/`, `web/`, `tool/` |

---

## 6. Authority

A **direct, explicit conferral by the human principal of this engagement**, instructing that `SECP-ADR-001`, `002`
and `004` be resolved *"through the **Architecture Owner's authority**"*. **That instruction is the authority, and it
is the only authority claimed** — the form `ADR-0033` §7.2 records.

**Not a standing grant** (`ADR-0033` §7.1). It authorises the precedence determination in §4 and nothing wider —
which is why the EA is left unedited even though the Architecture Owner is the role that *could* amend it. Knowing
an amendment is available is not a reason to make one that precedent says is not required.

### 6.1 What is not claimed

- **No ARB meeting** held, minuted or attended; no quorum, attendee list or sign-off date.
- **No Security review**, no Principal Enterprise Architect approval, no product-owner signature.
- **No frozen document amended**, and **no alert proven to exist**.
- **This ADR does not freeze `PRD-012a`.**

---

## 7. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-21 | Created `Accepted`. Resolves `SECP-ADR-002` / `SECP-DEP-001` / `SECP-GAP-031` **by precedence**: `PRD-001` is **Rank 3** and the EA is **Rank 6, "Descriptive only… never the reverse"**, so **`AUTH-11.26`, `AUTH-11.27` and `AUTH-11.28` are binding V1 obligations** and the EA's `Alerting (V2)` tag does not defer them. ⭐ **The EA is deliberately NOT edited**, on the `ADR-0058`/`FIL-GAP-015` precedent (*"a sequencing conflict resolved by precedence, the EA not edited"*), because the two documents describe **different objects**: Rank 3 requires three **conditions to be alertable**, Rank 6 tags an **alerting subsystem** (rules, channels, severity, suppression, escalation) that genuinely remains V2. Retagging would have overstated what Rank 3 compels. ⚠ **`SECP-GAP-023` is closed on Rank 1 rather than on precedence** — `MP-RSK-01` at `MASTER_PRD.md` **L551** already names a **Multi-Tenant Test Suite in CI** as the mitigation for a **Critical** risk, so it is not deferred by the EA's `Query Guardrails (V2)` / `Cross-Tenant Leak Tests (V2)` tags. ⚠ **Amending frozen `PRD-001` to soften three `MUST` obligations to V2 was available and is refused absolutely** — it would weaken frozen requirements to make a gate pass. ⚠ **`PRD-012a`'s refusal to choose is upheld, not overridden**: baseline §4 **L253** (*"A conflict is a defect… do not choose — raise it"*) is why this ADR exists rather than a paragraph in the PRD. ⚠ **Deferral was refused** because `ADR-0038` **L101** holds precedence to be *"mechanical, not a decision"* — the tier question was already settled. **Amends nothing: 0 PRDs, 0 BC Map cells, 0 matrix rows, 0 manifest entries, 0 EA tokens, 0 requirements minted or moved, no baseline re-issue, 0 lines of code.** ⛔ **Decides precedence; verifies no code** — 0 alerts implemented, 0 criteria proven. Does not close `SECP-GAP-042`/`043` and **confers no freeze** |
