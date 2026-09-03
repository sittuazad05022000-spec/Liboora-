# ADR-0011 — Global Person Identity is a platform identity, not a social profile

| Field | Value |
|---|---|
| **Status** | **Accepted** |
| **Date** | 2026-08-04 |
| **Deciders** | Product owner (authoritative ruling); Principal Enterprise Architect; DDD reviewer |
| **Supersedes** | Nothing. **Amends** `LIBOORA_BOUNDED_CONTEXT_MAP.md` §4 (The Identity Triad) — rules `ID-2`…`ID-5` are preserved; the *placement* and *cardinality* of `BC-10` change |
| **Amended by** | — |
| **Baseline** | `BASELINE-2026-08-04` |
| **Related** | `ADR-0008` (authentication baseline) · `ADR-0009` · `ADR-0010` · Bounded Context Map §4, §5, §7 · Module Dependency Matrix §2, §3 · Master PRD §12, §31 · Student Identity PRD v1.0 |

---

## 1. Context

The Student Identity & Profile PRD v1.0 was supplied for review. It asserts, as its foundational
premise, that **every student has exactly one Global Student Identity**, created as a consequence of
authentication, standing as the parent of that person's records in every organisation — Library,
School, College, Coaching and beyond.

The Bounded Context Map §4 — self-described as *"the highest-risk modelling decision in LIBOORA and
the one most likely to be got wrong by a team moving fast"* — described `BC-10` **Global Student
Identity** differently in two respects:

1. **Placement.** `BC-10` sat inside the **Social cluster** (`BC-10`…`BC-13`) at rank 8, alongside
   Social Graph, Messaging and Trust & Safety. Forbidden edge `X-05` *(Separate Ways)* prohibits any
   reference between the Library cluster and the Social cluster. Dependency law **L2** forbids a
   same-rank dependency across cluster lines. A library context therefore **could not reference
   `BC-10` at all** except through the single consented ACL bridge `E-13`.
2. **Cardinality.** `BC-10` was described as *"created when the human opts into the social product"*
   and *"**may not exist** for a student who only ever uses the library"* — an optional `0..1`.

Both statements were coherent **on the assumption that the only consumer of a global identity is a
social network.** That assumption is what this ADR overturns.

The product owner ruled explicitly:

> *"Do NOT make Global Student Identity an optional social-only identity… Global Student Identity is
> the permanent identity for the entire education ecosystem, not merely for social networking.
> Student Network is only a consumer of Global Student Identity. Social features must never become
> the reason Global Student Identity exists."*

This is a **product-strategy fact that the architecture had encoded incorrectly**, not a request to
weaken the architecture. The reusability of one person's identity across Library, School, College and
Coaching (`MP-FUT-02`…`MP-FUT-04`) is a stated platform objective. An identity that exists only when
someone opts into a social feature cannot serve it: a person enrolled at a library and a coaching
institute, who never touches the social product, would have no identity to share — which is the exact
duplication the module exists to prevent.

---

## 2. Decision

**`BC-10` is renamed Global Person Identity, reclassified, and relocated out of the Social cluster
into its own rank between the capability platforms and the domains. Its cardinality against the
authentication account becomes `1:1` and mandatory.**

### 2.1 The identity model

```
Authentication Account          (AccountId,        BC-18, rank 4)
        │ 1 ──── 1   mandatory, created together, never orphaned
        ▼
Global Person Identity          (PersonId,         BC-10, rank 7.5)   ← permanent, organisation-neutral
        │
        │ 1 ──── 0..*   one record per organisation, each tenant-scoped
        ├──► Student Record — Library A      (StudentRecordId, BC-01, rank 8)
        ├──► Student Record — Library B      (StudentRecordId, BC-01, rank 8)
        ├──► Student Record — School    (Future)
        ├──► Student Record — College   (Future)
        └──► Student Record — Coaching  (Future)

        ▲
        └── consumed by, never owned by:
            BC-11 Social Graph · BC-12 Messaging · BC-13 Trust & Safety · Student Network (Future)
```

### 2.2 What changes

| Aspect | Was | Is now |
|---|---|---|
| Name | Global Student **Identity** | Global **Person** Identity |
| Rank | 8, inside the Social cluster | **7.5**, its own tier — below every domain, above every capability platform |
| Cluster | Social (`BC-10`…`BC-13`) | **None.** Social cluster is now `BC-11`…`BC-13` |
| Classification | `[SUPPORTING]` | **`[CORE]`** — it is the platform's identity spine |
| Cardinality to Account | `0..1`, opt-in | **`1:1`, mandatory** |
| Created when | Human opts into social | **With the authentication account** |
| Consumers | Social contexts only | **Every domain**, current and future |

### 2.3 What does NOT change — the reason rank 7.5 exists rather than a merge

The three-identity separation is **retained in full**. This ADR relocates one context; it does not
collapse the triad. All of the following remain binding, unamended:

| Rule | Statement | Why it survives |
|---|---|---|
| `ID-1` | No context outside `BC-18` may store a credential, OTP, session or password | Global Person Identity holds **no** mobile number. See §2.4 |
| `ID-2` | `StudentRecordId` never leaves its tenant; must not appear in any global context, event or index | `BC-10` stores **no** `StudentRecordId` and **no** `tenantId`. The reference points **downward only**: `BC-01` holds `personId`, not the reverse |
| `ID-3` | Social contexts must not resolve which organisation a person attends unless published | Unchanged and now **structurally guaranteed**: `BC-11`…`BC-13` sit at rank 8 and cannot see `BC-01` either |
| `ID-4` | Library contexts key on `StudentRecordId`; may hold a `PersonId` reference | Retained — but the reference becomes **non-nullable**, since a `PersonId` now always exists |
| `ID-5` | Account deletion deletes the `Account` and anonymises the `Person`; it does **not** delete `StudentRecord` financial and attendance history | **This is the load-bearing reason the split is kept.** A single merged identity makes "erase me" and "retain the fee ledger under legal basis" mutually exclusive |
| `ID-6` | A minor's account is linked to guardian consent before any social context activates | Retained; `BC-18` gate |
| `X-05` | Library cluster ↔ Social cluster: Separate Ways | **Retained verbatim.** `BC-10` leaving the Social cluster does not open the edge; `BC-11`…`BC-13` remain unreachable from `BC-01`…`BC-06` |
| `MP-GBR-08` | Every tenant-scoped query carries a tenant key | `BC-10` is not tenant-scoped and holds no tenant-scoped data. Nothing is relaxed |

**Rank 7.5 is what makes this legal under L2.** A domain at rank 8 may depend on rank 7.5 because it
is strictly lower. Had `BC-10` stayed at rank 8, every library reference to it would be a same-rank
cross-cluster dependency — forbidden. The half-rank is deliberate and is the minimum change that
satisfies both the ruling and law **L2**; it is not a new tier of the platform stack.

### 2.4 The mobile number stays in Authentication

Global Person Identity is `1:1` with the account and is created alongside it, but it **does not hold
the verified mobile number**. In a system whose sole authentication factor is a mobile number
(`MP-GBR-25`), that field is a **credential**, not profile data — the same finding that produced
`LIB-6.4` in the Library PRD. `BC-10` holds an opaque `AccountId` reference. Any display of the
number is a read-through to `BC-18` under authorisation, never a stored copy.

### 2.5 Guardian information is not global

Guardian and parent contact details remain owned by **`BC-01` Enrollment**, per `ID-6` and the
existing `BC-01` invariant *"guardian mandatory if age < 18"*. Guardian data is
**tenant-scoped third-party PII**: the parent is not the account holder, has not authenticated, and
consented to one organisation. Storing it in a context with no `tenantId` would place a
non-consenting third party's contact details in a global scope, reachable by every organisation the
student ever joins.

The **capability** the PRD asks for is preserved — the aggregated profile screen still shows parent
contact — by composing it from `BC-01` per organisation, exactly as it composes membership and
attendance.

---

## 3. Consequences

### Positive

- **The platform objective becomes achievable.** One person, one identity, reused across Library,
  School, College and Coaching with no migration — `SID-INV-007`, `MP-FUT-02`…`MP-FUT-04`.
- **Social becomes a consumer, not the owner.** `BC-11`…`BC-13` read `PersonId`. Deleting the social
  product would not delete anyone's identity.
- **Duplication is eliminated at the root.** Every organisation module references one identity.
- **`Q-05` is answered and closed.** *"Is Global Student available to a person with no library
  enrollment?"* — Yes, necessarily: the identity exists from account creation. The "reduced trust
  tier" recommendation is retained as a `BC-13` moderation concern, not an identity concern.
- **Deletion and privacy remain implementable**, because `ID-5` is untouched.
- **`ID-4`'s null path disappears**, removing a class of defect: library code no longer needs a
  degrade-gracefully branch for a missing `PersonId`.

### Negative / accepted costs

- **The Bounded Context Map's highest-risk section is amended.** Amending §4 is not free; it is the
  section most likely to be misread. Mitigation: `ID-1`…`ID-6` are preserved verbatim and the
  amendment is confined to placement, name, classification and cardinality — recorded in this ADR and
  cross-referenced from §4 itself.
- **A half-rank is unusual.** `7.5` will look odd. The alternative — renumbering every rank from 8
  upward — would touch every entry in `tool/module_dependencies.yaml` and every rank citation in two
  architecture documents for no behavioural gain.
- **`1:1` mandatory creation adds a step to account creation.** An account and an identity must be
  created atomically, or an account can exist with no identity. This becomes invariant
  `SID-INV-001` and a P0 task.
- **One more V1 context is load-bearing.** `BC-10` moves from `[SUPPORTING]` to `[CORE]`, raising its
  test and review bar. This reflects reality rather than adding work.

### Neutral

- Context count stays **31**, V1 count stays **23**. Nothing is added or removed; one context is
  reclassified and relocated.
- The Social cluster shrinks from four members to three (`BC-11`…`BC-13`), with internal edges
  `E-14`…`E-16` re-pointed accordingly.

---

## 4. Alternatives considered

| Alternative | Why rejected |
|---|---|
| **Leave `BC-10` optional and social-only** (the review's "Option A" as first drafted) | Rejected by the product owner, and correctly: it makes cross-product identity reuse impossible for the majority of users, who will never touch a social feature. The architecture would have quietly blocked a stated platform objective |
| **Collapse the triad into one identity** ("Option B") | Would satisfy the PRD's diagrams most literally and was explicitly offered. Rejected: it makes `ID-5` unsatisfiable — erasure and financial retention become mutually exclusive — and merges two tenancy models and two privacy regimes, the harm `X-05` exists to prevent |
| **Keep `BC-10` at rank 8 and add an allowed edge from `BC-01`** | Violates **L2** (same-rank cross-cluster dependency). L2 is what makes the graph provably acyclic without inspecting it; puncturing it for one edge forfeits that property |
| **Move `BC-10` into `BC-18` Identity & Access** | Violates `ID-1` in spirit: a context holding credentials must not also hold a public profile, username and privacy settings. It would also make the public profile unavailable without a credential read |
| **Duplicate identity per organisation and reconcile later** | This is the "Duplicate Student Records" problem the PRD exists to solve, and the one the module was commissioned to prevent |

---

## 5. Compliance

| Requirement | Where enforced |
|---|---|
| `1:1` Account ↔ Person, atomically created | `SID-INV-001`, `SID-2.1`, task `IMPL-200` |
| `BC-10` stores no `tenantId`, no `StudentRecordId` | `tool/module_dependencies.yaml` `banned_symbols` under `domain/person`; CI schema scan |
| `BC-10` stores no credential or mobile number | `ID-1`, `SID-INV-004`, security review |
| Guardian data stays in `BC-01` | `SID-INV-006`, `SXC-3` |
| Private is the default profile visibility | `AP-3`, `SID-INV-008`, `SCFG-5` |
| Social contexts consume, never own | `X-05` retained; `domain/social` cannot import `domain/library`; `banned_symbols` unchanged |
| Rank 7.5 respected | `tool/module_dependencies.yaml` ranks; `IMPL-014` boundary checker |

---

## 6. Change history

| Date | Change |
|---|---|
| 2026-08-04 | Accepted. Amends Bounded Context Map §4: `BC-10` renamed Global Person Identity, moved to rank 7.5, reclassified `[CORE]`, cardinality to account becomes `1:1` mandatory. Rules `ID-1`…`ID-6` and forbidden edge `X-05` preserved unamended. Closes open question `Q-05`. |
