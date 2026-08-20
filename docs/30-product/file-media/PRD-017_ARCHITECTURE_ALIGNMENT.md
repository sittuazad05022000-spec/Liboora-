# PRD-017 File & Media — Stage 3 Architecture Alignment Record

| Field | Value |
|---|---|
| **Subject** | [`PRD-017_FILE_AND_MEDIA.md`](./PRD-017_FILE_AND_MEDIA.md) **v0.1** `DRAFT` |
| **Subject hash** | ``85adb6fa85fa687743992fe377ffa7652af5b4a625107efb2c2e9031dd1cb44e`` — measured, not asserted |
| **Bounded context** | **`BC-29` File & Media** `[GENERIC]`, BC Map **L138** |
| **Stage** | **3 of 9 — Architecture Review.** Stages 4–7 not run by this record |
| **Authority** | [`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md) §3 Stage 3 — six checks against Ranks 1–5 |
| **Gate** | *"a written alignment record naming every conflict and its disposition"* |
| **Status of this record** | **Unranked.** Not admitted to `DOCUMENTATION_BASELINE.md`. It confers nothing on its subject |
| **Version** | v1.0 · 2026-08-20 |

> ⚠ **This record changed nothing in the architecture.** **0** `E-*` edges added, **0** consumer cells amended,
> **0** contexts reclassified, **0** manifest lines changed, **0** ADRs written, **0** frozen documents touched.
> Where the review found a genuine architectural insufficiency it is **recorded with a named owner**, which is
> what Stage 3 is for. BC Map **L292** — *"If an edge is not in this table, it **does not exist** and adding it
> requires an ADR"* — is the rule this record obeys rather than the rule it works around.

> ⚠ **A rejected finding is recorded as rejected, with its reason.** `PRD_LIFECYCLE.md` §3 Stage 3:
> *"A review that records only accepted findings is indistinguishable from a review that found nothing."*
> §8 lists **6** rejected candidates.

---

## 1. The six checks, as the lifecycle states them

`PRD_LIFECYCLE.md` §3 Stage 3 fixes the checks and their authorities. They are reproduced verbatim so that this
record cannot quietly substitute an easier test:

| # | Check | Authority | Failure |
|---|---|---|---|
| 1 | Context ownership is exclusive | BC Map §3 | Two PRDs own one aggregate |
| 2 | Every integration edge exists in §7 | BC Map §7 | *"If an edge is not in this table, it does not exist"* — needs an ADR |
| 3 | Rank direction is downward | Dependency Matrix `L2` | Illegal import |
| 4 | No authorisation decided outside `BC-18` | `X-13` | **A security defect that passes its own tests** |
| 5 | No credential, OTP or session outside `BC-18` | `ID-1` | Prohibited |
| 6 | Tenant scoping correct | `MP-GBR-08`, `X-13` | Cross-tenant leak — `MP-RSK-01`, Critical |

**The V1 student-to-student sharing scope is inside the subject of this review, not an addendum to it.** It is
tested by checks 1, 2, 4 and 6 on equal terms with every other capability in the draft.

---

## 2. Check 1 — Context ownership is exclusive

### 2.1 The aggregate question is left exactly where Stage 2 left it

BC Map §8 lists **17** aggregate rows. `BC-29` appears in **none** of them (measured: 0). The draft asserts no
aggregate and records the condition as `FIL-GAP-001`.

**Disposition: the gap stays OPEN and this record does not close it.** Minting an aggregate for `BC-29` would be
a Rank 4 change, which needs an ADR *before* the change (baseline §7). Asserting that `BC-29` needs none would
equally be a judgement about a Rank 4 table. Stage 3 validates the draft against the map; it does not repair
the map. This follows the `PRD-023` precedent, whose §2.2 disposed of `CNF-GAP-001` the same way for `BC-25`.

### 2.2 Ownership between `PRD-017`, `PRD-021`/`BC-11`/`BC-12`, and Trust & Safety

This is the check the sharing scope most needed, and it is decided from the aggregate table (BC Map §8), not
from intent:

| BC Map §8 row | Aggregate | Entities | Therefore owned by |
|---|---|---|---|
| **L377** `BC-11` Social Graph | `Friendship` · `BlockList` | `FriendRequest`, `RateLimitCounter` | **`PRD-021`** — friendship, blocks, rate limits |
| **L378** `BC-12` Messaging | `Conversation` | `Message`, `DeliveryReceipt`, `RetentionPolicy` | **`PRD-021`** — conversations, messages, delivery, retention |
| **L379** `BC-13` Trust & Safety | `ModerationCase` | `AbuseReport`, `EnforcementAction`, `StrikeRecord`, `Appeal` | **`BC-13`** — reports, moderation, strikes, appeals |
| BC Map **L138** `BC-29` | *(none — see §2.1)* | — | **`PRD-017`** — bytes, metadata, validation, access, lifecycle |

**The draft's exclusions map one-to-one onto those rows, and the mapping is exact rather than approximate:**

| Draft exclusion | Refuses | Owner named | Aggregate that proves the owner |
|---|---|---|---|
| `FIL-XC-019` | eligibility, friendship, block, rate limit, `canMessage` storage | `BC-11` / `PRD-021` | `Friendship`, `BlockList` (**L377**) |
| `FIL-XC-020` | message text, ordering, receipts, presence, conversation membership | `BC-12` / `PRD-021` | `Conversation`, `Message`, `DeliveryReceipt` (**L378**) |
| `FIL-XC-022` | abuse reporting, moderation, strikes, bans, inappropriateness verdicts | `BC-13` | `ModerationCase`, `AbuseReport` (**L379**) |
| `FIL-XC-021` | public sharing, anonymous sharing, link-without-recipient, public discovery | none — **prohibited outright** | n/a; discovery is `BC-23` (`FIL-XC-013`) |

✅ **Check 1 PASS.** No aggregate is claimed twice. Every social/messaging/safety concept the sharing flow touches
is refused by an identified exclusion naming the owning context, and each owner is confirmed by an aggregate row
rather than by assertion.

### 2.3 `FIL-FR-076` is the load-bearing ownership clause, and it is correct

`FIL-FR-076` — *the module **SHALL NOT** decide whether a share is permitted; it records the decision reference
it was given.*

This is the clause that keeps `PRD-017` out of `PRD-021`'s aggregate. Its reasoning is independently sound under
check 4: BC Map **L320** (`E-16`) puts `canMessage(a, b)` in `BC-11`, and **L378** requires participants to
satisfy `canMessage` **at send time**. If `BC-29` re-derived eligibility it would hold a second, independently
evolving copy of a rule whose authoritative form lives elsewhere — the `X-13` failure shape, *"a security defect
that passes its own tests."*

⚠ **One imprecision found and recorded, not silently accepted.** `FIL-FR-076` obliges the module to record
*"the decision reference"* without stating **who** is obliged to have obtained it. Because `E-16` runs
`BC-11` → `BC-12`, the only context positioned to hold that reference is `BC-12`. The draft does not say so.
This is a **Stage 4 wording defect**, routed to Stage 4 as **`S4-F-01`** rather than fixed here, because Stage 3
validates boundaries and does not edit requirement text.

---

## 3. Check 2 — Every integration edge exists in BC Map §7

### 3.1 Edge inventory, measured

| Edge | Row | Direction | `PRD-017`'s role |
|---|---|---|---|
| **`E-22`** | **L331** | `BC-01`, `BC-10`, `BC-14` → `BC-29` | **Provider.** The only edge into this context |
| `E-18` | L327 | All contexts → `BC-19` | Consumer — ambient `TenantContext` |
| `E-19` | L328 | All contexts → `BC-25` | Consumer — typed config accessors |
| `E-20` | L329 | All contexts → `BC-24` | **Producer of an audit *fact*** — not an event (§3.3) |
| `E-17` | L326 | All write paths → `BC-21` | Consumer — entitlement/quota check |
| `E-16` | L320 | `BC-11` → `BC-12` | **Neither.** Cited as the *owner's* path; this module is not on it |
| `E-14` | L318 | `BC-13` → `BC-11`, `BC-12`, `BC-14`, `BC-15` | **Neither.** `BC-29` is not a fan-out target |

**Edges into `BC-29`: exactly 1.** Edges created by this record: **0**.

### 3.2 ⛔ The finding this stage exists to produce: `E-22` does not admit the sharing caller

The V1 sharing capability requires a `domain/social` context to call `platform/services:files`. Measured state:

```
BC Map L331   E-22 consumers : BC-01, BC-10, BC-14
BC Map L292   rule           : "If an edge is not in this table, it does not exist"
manifest L242 domain/social  : ports include platform/services:files     ← grant EXISTS
```

Two Rank 4/5 documents disagree: the **manifest already grants** `domain/social` the `files` port, while the
**BC Map edge register does not list it**. Under precedence the BC Map wins, so `FIL-FR-006` correctly refuses
the caller — and the V1 requirement is **specified in full but not servable**.

**This record confirms Stage 2's finding and does NOT clear it.** `FIL-GAP-012` stays **OPEN**, blocker `B-11`
stays **OPEN**, and no edge is amended here.

### 3.3 ⭐ The gap is NARROWED, which is a Stage 3 result rather than a repair

Stage 2 framed the requirement as *"`E-22` must list `BC-11`/`BC-12`/`BC-13`"* — three contexts. **That framing
is wider than the evidence supports, and this review corrects it downward.** Necessity was tested per context:

| Context | Does it need to hold a `FileRef`? | Evidence | Verdict |
|---|---|---|---|
| **`BC-12` Messaging** | **Yes.** A shared study document is delivered *within a conversation*; `Conversation`/`Message` (**L378**) is the only aggregate that can carry the reference to the shared object | **L378**; `FIL-BR-017` (*a shared file follows the object, not the message*) | ⛔ **REQUIRED — the minimal sufficient consumer** |
| `BC-11` Social Graph | **No.** Its aggregates are `Friendship` and `BlockList` (**L377**). Its role is answering `canMessage` over `E-16`. **Answering an eligibility question requires no file access** | **L377**, **L320** | ✅ **NOT required** |
| `BC-13` Trust & Safety | **No.** Its aggregates are `ModerationCase`, `AbuseReport` (**L379**), and `E-14` is an **outbound** event fan-out. `FIL-XC-022` forbids this module from originating any moderation verdict; `BC-13` instructs deletion, and a deletion instruction is not a `FileRef` read | **L379**, **L318**, `FIL-XC-022` | ✅ **NOT required for V1 sharing** |

**Measured corroboration:** a repository-wide search for any requirement giving `BC-11`, `BC-13` or `domain/social`
a `FileRef` obligation returns **0 results**. The only `FileRef` obligations that exist name `BC-01` (`LIB-6.6`,
`PRD-004`), `BC-10` (`SID-4.35`) and `BC-14` — all already on `E-22`.

> **Why narrowing matters, and why it is not a softening.** `ADR-0016`'s §4.3 records the exact risk of a
> consumer-cell amendment: *"Read as licence to add edges when convenient — **High**."* Its mitigation is
> *"One cell, one edge, named explicitly."* Requesting three contexts where the evidence supports **one** would
> have granted file access to two contexts that have no requirement for it, permanently, on the strength of a
> product brief. **The narrowest sufficient amendment is the correct one.**

**Recorded as accepted finding `S3-A-01` (§9): the `E-22` amendment required by V1 sharing is `BC-12` only.**

### 3.4 The precedent is exact, and there are now two independent instances of it

| Precedent | Amendment | Ratio decidendi |
|---|---|---|
| `ADR-0016` (**Accepted** 2026-08-04) | `E-22` consumers `BC-01, BC-14` → `BC-01, BC-10, BC-14` | A Rank 3 requirement (`SID-4.35`) depended on an unlisted edge. *"the Consumer cell only. No edge added, no edge removed, no mode changed"* |
| `ADR-0022` (**Proposed**, not binding) | `BC-03` → `BC-29` considered | Frames the same question for Attendance; **decides nothing**, §7 *"No edge added."* |
| `ATT-GAP-010` (**OPEN**) | `BC-03` not on `E-22` | The identical gap, carried openly by a **frozen** PRD rather than self-resolved |

⚠ **`ATT-GAP-010` is the governing behavioural precedent for `FIL-GAP-012`.** `PRD-006` reached **FROZEN** while
carrying an OPEN `E-22` gap. So an unresolved `E-22` consumer question **does not** by itself bar freeze — it
must be carried transparently. That is what §10 does.

⚠ **`ADR-0016` also settles the isolation objection before it can be raised.** `BC-10` is a **global** context
(BC Map **L114**, *"Global. No `tenantId`"*) and it is **already an accepted `E-22` consumer**. A global-class
consumer of `BC-29` is therefore **established practice, not a novelty introduced by sharing.**

✅ **Check 2 PASS with one recorded blocking gap.** Every edge the draft relies on exists in §7. The one edge the
draft needs and does not have is named, narrowed to its minimal form, assigned to the Architecture Owner, and
**left unamended**.

### 3.5 No event is invented — re-verified independently

BC Map §9 producer rows for `BC-29`: **0** (measured). The draft declares `FIL-EVT-*` **EMPTY** and mints no
number. `FIL-FR-082` makes grant/revocation/first-read *"auditable **by the calling context**"* — routing the
fact through `E-20`, whose owner already publishes, rather than granting `BC-29` a publisher role it does not
have. ✅ **0 events invented**, including for sharing.

---

## 4. Check 3 — Rank direction is downward

Measured from the manifest, not from the rank prose:

```
tool/module_dependencies.yaml L33    platform/services : 3
tool/module_dependencies.yaml L229   domain/social     : 8   (contexts: graph, messaging, safety)
tool/module_dependencies.yaml L242   domain/social ports: platform/services:files
```

`domain/social` (8) → `platform/services` (3) is **strictly downward**, satisfying `L2`, and is declared as a
**port**, satisfying `L3`. The Dependency Matrix **L354** settles the `X-05` question explicitly for the
neighbouring case: `X-05` forbids `LIBRARY MANAGEMENT ↔ STUDENT NETWORK`; it says nothing about a social module
calling a **rank-3 platform service**, which every domain module does.

**Therefore the missing `E-22` row is a *register* omission, not an illegal dependency** — precisely the shape
`ADR-0016` §1.4 describes: *"`domain/person` (7.5) → `platform/services` (3) is a legal downward port call, so
the checker passes it — correctly. Nothing mechanical was ever going to catch a missing row in a prose table."*

**Architecture checks run (this record's own evidence):**

```
dart run tool/check_module_boundaries.dart      EXIT 1 (by design, ADR-0012 §3.4)
    cross-context 9 · ACKNOWLEDGED DEBT 28 across 12 edges
    → byte-identical to the pre-existing baseline; PRD-017 introduced 0 new findings
tool/docs_check/*.py sweep                      total nonzero = 5 (expected 5, all pre-existing)
    alignment_record_freshness · prd004 · prd005 · prd006 · prd007 traceability
```

⚠ **The sweep's silence about `PRD-017` is not a clearance.** **No `prd017_*` checker exists.** Writing one is
Stage 5 work; its absence is stated so that "5 as expected" is not misread as coverage.

✅ **Check 3 PASS.**

---

## 5. Checks 4 and 5 — Authorisation, credentials, OTP, session

### 5.1 Every access decision is delegated, and the sharing path is the strictest case

| Draft requirement | Effect |
|---|---|
| `FIL-FR-008` | An access decision is obtained from `BC-18` **per request**; never cached, reused or inferred |
| `FIL-FR-076` | The module **SHALL NOT** decide whether a share is permitted |
| `FIL-FR-079` | Revocation is by the granting actor **or an actor `BC-18` authorises** |
| `FIL-BR-016` | Eligibility is **asked, never inferred** — prior share, conversation or read is not evidence |
| `FIL-XC-019` | No eligibility/`canMessage` evaluation or storage |

`FIL-BR-016` is the sharpest clause in the draft. The natural implementation shortcut — *"they were allowed to
share yesterday, so allow the read today"* — is exactly `X-13`'s *"security defect that passes its own tests"*,
because a `BlockList` change (**L377**) is invisible to a cached grant. The draft forbids it and `FIL-AC-069`
makes the prohibition observable.

### 5.2 Credentials, OTP, session

Measured across the draft: **0** requirements defining a credential, OTP, session, token issuance or password
rule. Signed URLs (`FIL-FR-035`…`041`, `FIL-FR-078`) are **capability URLs over an already-authorised decision**,
not authentication credentials, and `FIL-CFG-004` bounds their lifetime. `ID-1` is not engaged.

✅ **Checks 4 and 5 PASS.** No authorisation is decided outside `BC-18`; no credential material is defined.

---

## 6. Check 6 — Tenant scoping, validated against frozen `PRD-013`

### 6.1 The rules, applied

| Rule | Source | Rank | Status |
|---|---|---|---|
| `TEN-FR-018` — *"Every row of a tenant-scoped context **MUST** carry `tenant_id`; every row of a global context…"* | `PRD-013` **L204** | **3 FROZEN** | Binding |
| `TEN-AC-014` — *"a global-context row carries **no `tenant_id` column at all**"* | `PRD-013` **L343** | **3 FROZEN** | Binding |
| `ID-2` — `BC-11`→`BC-17` *"**Global.** No `tenantId`. Keyed on `PersonId`"* | BC Map **L488** | 4 | Binding |
| `BC-19`→`31` — *"files are **all** tenant-partitioned"* | BC Map **L490** | 4 | Binding — see §6.2 |
| `X-13` — key without `tenantId` ⇒ cross-tenant leak | Matrix **L362** | 4 | Binding |

### 6.2 ⭐ The apparent contradiction between L488 and L490, driven to root cause

This is the hardest point in the review and it must not be glossed.

- **L490** places `BC-19`→`BC-31` — which **includes `BC-29`** — in the *"Tenant-aware"* band: *"Indices, caches,
  projections, prompts, embeddings and **files** are **all** tenant-partitioned."*
- **L488** places `BC-11`→`BC-17` in the *"Global"* band: *"No `tenantId`. Keyed on `PersonId`."*

Read naively, a file shared between two students must be both tenant-partitioned (because it is a file) and
non-tenant-keyed (because its parties are global). **The resolution is already in the repository and required no
invention:** L490's own wording is *"Tenant-**aware**… **own no tenant data of record**."* `BC-29` **carries and
propagates** the isolation key of whoever owns the record; it does not originate one. `ADR-0016` proves this
operationally — **`BC-10`, a global context with no `tenantId` (L114), is already an accepted `E-22` consumer**,
and `SID-4.35`'s Global Profile Photo is a global-class object held by `BC-29` today.

**Therefore a global-class shared study document is not a new isolation model. It is the existing `BC-10` case
with a different owning context.**

### 6.3 The draft's §7.3 is correct, and the brief's wording was correctly refused

The product brief asked for *"tenant/library membership isolation"* on peer sharing. Taken literally that
requires a `tenant_id` on a `BC-11`→`BC-17`-class object, which **violates frozen `TEN-FR-018` and `TEN-AC-014`
and Rank 4 rule `ID-2`**. The draft instead:

| Draft clause | Effect |
|---|---|
| `FIL-FR-044` | A shared study document is a **global-class** object |
| `FIL-FR-081` | Both parties **SHALL** be in the **same isolation class**; a cross-class grant is refused **as not-found** |
| `FIL-AC-065`/`066`/`067` | Make cross-class refusal, the absence of `tenant_id`, and tenant-class non-grantability observable |
| `FIL-GAP-013` | Routes *"confine sharing to co-members of one library"* to `BC-11`'s **eligibility rule** — `PRD-021`'s to state |

✅ **This is the architecturally correct disposition and this record ratifies it.** Isolation is **differently
keyed, not weaker**: a global object is isolated by an access decision on `PersonId`; a tenant object is isolated
by `tenant_id`; and `FIL-FR-081` forbids a grant crossing between them, so no tenant-scoped library document can
leak into a peer share. `FIL-FR-081`'s *refused **as not-found*** also satisfies `X-13`'s intent by denying an
existence oracle.

⚠ **`FIL-GAP-013` stays OPEN** with owner **Product + `PRD-021`**. Nothing here decides `BC-11`'s eligibility
rule, because that is `PRD-021`'s aggregate.

✅ **Check 6 PASS.**

---

## 7. Classification — owned / consumed / deferred / blocked

The lifecycle requires a clear classification. Every capability the draft touches falls in exactly one bucket.

### 7.1 OWNED by `PRD-017` (`BC-29`)

Binary storage and retrieval · upload initiation and completion · content-type and size validation ·
virus/malware scan gating · object metadata · object lifecycle (soft delete, permanent delete, retention) ·
signed-URL issuance and expiry · storage abstraction · integrity verification · **share grant record,
read-only conveyance, revocation, isolation-class equality, and the auditability of grant/revoke/first-read**
(`FIL-FR-075`…`082`).

### 7.2 CONSUMED from other contexts (never re-implemented)

| Consumed | From | Edge |
|---|---|---|
| Access decision | `BC-18` | `FIL-FR-008` |
| Share eligibility / `canMessage` | `BC-11` via `BC-12` | `E-16`; `FIL-FR-076` |
| Ambient tenant context | `BC-19` | `E-18` |
| Configuration values | `BC-25` | `E-19` |
| Audit persistence | `BC-24` | `E-20` |
| Quota / entitlement verdict | `BC-21` | `E-17` |

### 7.3 DEFERRED (out of V1 scope, owner named)

Publishing rights, copyright, takedown → **`BC-14`, V2** (L118) · public discovery/search → `BC-23`
(`FIL-XC-013`) · video/audio content → **no Rank 1–4 authority requires it** (`FIL-FR-005`) · realtime
transport (`FIL-FR-069`) · CDN, thumbnail pipeline as V2 EA tokens (`FIL-GAP-005`, EA is **Rank 6 Descriptive**).

### 7.4 BLOCKED (specified, not servable)

| Capability | Blocked by | Owner | Status |
|---|---|---|---|
| **V1 student-to-student sharing** | **`E-22` omits `BC-12`** (§3.3) | **Architecture Owner** | ⛔ `FIL-GAP-012`, `B-11` — **OPEN** |
| Library-membership confinement of sharing | `BC-11` eligibility rule unwritten | Product + `PRD-021` | `FIL-GAP-013` — **OPEN** |
| `domain/social`'s declared `files` port | Same `E-22` omission | Architecture Owner | `FIL-GAP-003` — **OPEN** |

**No bucket overlaps.** Owned ∩ Consumed = ∅ (each consumed item carries a `FIL-XC-*` or a delegation clause).
Owned ∩ Deferred = ∅. The blocked set is a subset of Owned that cannot yet be *reached*, not a separate claim.

---

## 8. Candidate findings recorded as REJECTED, with reasons

| # | Candidate | Verdict |
|---|---|---|
| R-1 | **Write the `E-22` widening ADR inside this record** | **Rejected.** A Stage 3 alignment record is unranked and confers nothing; baseline §7 requires *an ADR before the change*, authored by the Architecture Owner. `ADR-0022` is the precedent for framing without deciding |
| R-2 | **Request `BC-11`, `BC-12` and `BC-13` on `E-22`** (Stage 2's framing) | **Rejected — narrowed to `BC-12` only** (§3.3). No repository requirement gives `BC-11` or `BC-13` a `FileRef` need (measured: 0 results). `ADR-0016` §4.3 names over-broad amendment as the **High** risk |
| R-3 | **Create a new edge `E-27` for `domain/social` → `BC-29`** | **Rejected.** Identical mode, mechanism and constraint to `E-22`. `ADR-0016` §3 option 2 rejected exactly this and set the precedent: *extend the consumer list* |
| R-4 | **Declare the tenant-isolation conflict a `PRD-013` defect** | **Rejected.** `TEN-FR-018` and `TEN-AC-014` are frozen Rank 3 and **correct**; the conflict was in the *brief's wording*, not in `PRD-013`. Inverting precedence to accommodate a brief is `ADR-0016` §3 option 4's rejected shape |
| R-5 | **Promote `BC-14` to V1 so sharing has a "content" owner** | **Rejected.** `BC-14` owns publishing rights and takedown (L118), not peer transfer. `BC-11`/`BC-12` are already V1, so promotion is unnecessary as well as out of scope |
| R-6 | **Mint the first member of `FIL-EVT-*` for `ShareGranted` so audit has a path** | **Rejected.** `BC-29` is a producer in **0** BC Map §9 rows. `FIL-FR-082` already routes the fact through the **calling context** and `E-20`. Minting the event would assert a path L292 says does not exist. ⚠ Named **by kind, not by number**, corrected at Stage 5 (`S5-C-07`): writing the specific identifier here created a citation to an identifier this row exists to keep nonexistent |

---

## 9. Accepted findings

| # | Finding | Disposition |
|---|---|---|
| **`S3-A-01`** | The `E-22` amendment required by V1 sharing is **`BC-12` Messaging only** — not three contexts | **ACCEPTED.** Narrows `FIL-GAP-012`. Owner: Architecture Owner. Stage 7 must carry it, not close it |
| **`S3-A-02`** | A **global-class** `E-22` consumer is established practice (`BC-10`, `ADR-0016`), so global-class shared documents introduce no new isolation model | **ACCEPTED.** Ratifies draft §7.3 and `FIL-FR-081` |
| **`S3-A-03`** | `FIL-FR-076` does not name **who** must have obtained the eligibility decision; `E-16`'s direction implies `BC-12` | **ACCEPTED as a Stage 4 defect → `S4-F-01`.** Not edited here |
| **`S3-A-04`** | No `prd017_*` checker exists, so the green docs_check sweep says nothing about this PRD | **ACCEPTED.** Routed to **Stage 5** |
| **`S3-A-05`** | `FIL-GAP-013` (library-membership confinement) is genuinely `PRD-021`'s, not a `BC-29` requirement | **ACCEPTED.** Stays OPEN, owner Product + `PRD-021` |

---

## 10. Verdict

| Check | Result |
|---|---|
| 1 — Context ownership exclusive | ✅ **PASS** — 0 aggregates claimed twice; 4 exclusions map 1:1 onto §8 rows |
| 2 — Every edge exists in §7 | ⚠ **PASS WITH A RECORDED BLOCKING GAP** — 7 edges verified; 1 required edge absent, narrowed to `BC-12`, unamended |
| 3 — Rank direction downward | ✅ **PASS** — 8 → 3 via a declared port; `L2`, `L3` satisfied; checker baseline unchanged |
| 4 — No authorisation outside `BC-18` | ✅ **PASS** — decision per request, never cached, never inferred |
| 5 — No credential/OTP/session | ✅ **PASS** — 0 such requirements |
| 6 — Tenant scoping correct | ✅ **PASS** — L488/L490 reconciled from repository text; frozen `TEN-FR-018`/`TEN-AC-014` upheld |

### **STAGE 3 VERDICT: PASS — CONDITIONAL**

**6 of 6 checks pass.** The condition is stated precisely, because a conditional pass that hides its condition is
worse than a fail:

> ⛔ **The V1 student-to-student sharing capability is architecturally sound, correctly bounded, and NOT SERVABLE.**
> It cannot be implemented until `E-22`'s consumer cell admits **`BC-12`** by an ADR authored by the Architecture
> Owner. Every other capability in `PRD-017` is unaffected and fully aligned.

**This is a `PRD-014`-shaped conditional pass, not a `PRD-023`-shaped unconditional one** — and the distinction is
recorded so Stage 6 knows that one task group is contingent.

---

## 11. What this record deliberately does not do

- **Does not amend `E-22`**, or any BC Map cell, or the manifest. **0 edges, 0 cells, 0 ports.**
- **Does not write `ADR-0054` or any ADR.** That is the Architecture Owner's act at Stage 7 if governance requires it.
- **Does not edit the subject PRD.** The subject hash is unchanged by this record. `S3-A-03` is routed to Stage 4.
- **Does not close a single `FIL-GAP-*`.** All **13** remain OPEN.
- **Does not confer rank or status.** It is unranked; `PRD-017` remains `DRAFT` until a baseline row exists.
- **Does not claim mechanical coverage.** No `prod017` checker exists (`S3-A-04`).
- **Contains no code, no SQL, no schema.**

---

## 12. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-20 | Stage 3 Architecture Alignment for `PRD-017` v0.1. **6 of 6 checks PASS, conditional.** Ownership decided from BC Map §8 aggregate rows (**L377**/**L378**/**L379**), giving a 1:1 mapping from `FIL-XC-019`/`020`/`022` onto `BC-11`/`BC-12`/`BC-13`. ⭐ **Stage 2's `E-22` requirement was NARROWED from three contexts to `BC-12` alone** (`S3-A-01`): `BC-11`'s aggregates are `Friendship`/`BlockList` and its role is answering `canMessage` over `E-16`, which needs no file access; `BC-13`'s are `ModerationCase`/`AbuseReport` and `E-14` is outbound. A repository-wide search for a `FileRef` obligation on `BC-11`/`BC-13`/`domain/social` returned **0**. Narrowing follows `ADR-0016` §4.3, which names over-broad amendment as the **High** risk and prescribes *"one cell, one edge, named explicitly."* ⭐ **The L488/L490 isolation conflict was driven to root cause** (`S3-A-02`): L490's *"Tenant-**aware**… own no tenant data of record"* means `BC-29` propagates an owner's key rather than originating one, and **`BC-10` — a global context with no `tenantId` — is already an accepted `E-22` consumer via `ADR-0016`**, so a global-class shared document is the existing `SID-4.35` case with a different owner, not a new isolation model. Frozen `TEN-FR-018` and `TEN-AC-014` are upheld, and the brief's *"tenant/library membership isolation"* wording is confirmed **unsatisfiable as written** and correctly routed to `BC-11`'s eligibility rule (`FIL-GAP-013`). **6 candidate findings recorded as REJECTED with reasons**, including writing the ADR here (R-1), the three-context request (R-2), a new edge `E-27` (R-3), amending frozen `PRD-013` (R-4), promoting `BC-14` (R-5) and minting a `FIL-EVT-*` (R-6). **5 findings ACCEPTED**, one of them routed to Stage 4 as `S4-F-01` (`FIL-FR-076` does not name who must hold the eligibility decision). Architecture checks run: `check_module_boundaries.dart` **exit 1 by design**, 9 cross-context + 28 acknowledged across 12 edges — **byte-identical to the pre-existing baseline, so `PRD-017` introduced 0 new findings**; `docs_check` sweep **5 nonzero, all pre-existing**, with the explicit caveat that **no `prd017_*` checker exists** so the sweep's silence is not a clearance (`S3-A-04`, routed to Stage 5). **0 edges added, 0 consumer cells amended, 0 manifest lines changed, 0 ADRs written, 0 frozen documents touched, 0 events invented, 0 gaps closed, 0 aggregates minted.** All **13** `FIL-GAP-*` remain OPEN; **11** blockers stand. Unranked — confers nothing on its subject |
