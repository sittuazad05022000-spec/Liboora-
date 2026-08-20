# PRD-023 Settings & Configuration — Stage 3 Architecture Alignment Record

| Field | Value |
|---|---|
| **Document** | `PRD-023_ARCHITECTURE_ALIGNMENT.md` |
| **Subject** | `PRD-023` Settings & Configuration v0.1 `DRAFT` (1,443 lines, HEAD `67d7090`) |
| **Bounded context** | `BC-25` Configuration |
| **Module** | `platform/configuration`, rank 3 |
| **Lifecycle stage** | **Stage 3 — Architecture Review** |
| **Registry status sought** | `IN_REVIEW` |
| **Version** | v1.0 |
| **Date** | 2026-08-19 |
| **Baseline** | `BASELINE-2026-08-19-C` |
| **Gate under test** | `PRD_LIFECYCLE.md` L100 — *"a written alignment record naming every conflict and its disposition"* |
| **Reviewer role** | Architecture reviewer (`PRD_LIFECYCLE.md` §6). **No named holder exists** — `PGA-08` |
| **Governing authority** | `ADR-0017` **ACCEPTED** 2026-08-04, `BASELINE-2026-08-04-B` |
| **Verdict** | **PASS** — see §9 |

> `PRD_LIFECYCLE.md` L104: *"**A rejected finding must be recorded as rejected, with its reason.** … A review
> that records only accepted findings is indistinguishable from a review that found nothing."*
> §7 of this record exists to satisfy that sentence.

> **This review corrected three claims made by its own subject document.** §4.2, §5.3 and §6.4 below withdraw or
> restate assertions that Stage 2 made in good faith and that measurement does not support. A Stage 3 review that
> only confirms the draft it reviews has not reviewed it. All three corrections are carried as accepted findings
> (`A-01`, `A-05`, `A-07`) with named remediation, and none of them changes the scope `ADR-0017` §3.1 fixed.

---

## 1. The six checks, as the lifecycle states them

`PRD_LIFECYCLE.md` L88–102 defines Stage 3 as exactly six checks, each with a named authority and a named
failure mode. They are reproduced verbatim so that this review can be audited against its own terms.

| # | Check | Authority | Failure |
|---|---|---|---|
| 1 | Context ownership is exclusive | BC Map §3 | Two PRDs own one aggregate |
| 2 | Every integration edge exists in §7 | BC Map §7 | *"If an edge is not in this table, it does not exist"* — needs an ADR |
| 3 | Rank direction is downward | Dependency Matrix `L2` | Illegal import |
| 4 | No authorisation decided outside `BC-18` | `X-13` | **A security defect that passes its own tests** |
| 5 | No credential, OTP or session outside `BC-18` | `ID-1` | Prohibited |
| 6 | Tenant scoping correct | `MP-GBR-08`, `X-13` | Cross-tenant leak — `MP-RSK-01`, Critical |

Checks 1–6 are executed in §2 through §6 (checks 4 and 5 share §5). The three-bucket ownership split required
of this stage is §2.4. Every check is answered by a measurement or a citation, never by assurance.

---

## 2. Check 1 — Context ownership is exclusive

**Failure mode:** two PRDs own one aggregate.

### 2.1 What `PRD-023` claims to own

`ADR-0017` §3.1 fixes the scope at exactly six items, and §3.2 states *"**This ADR moves no requirement.**"*
The draft was measured against that list, item by item.

| # | `ADR-0017` §3.1 item | Draft section | Claimed as owned? | Competing claim measured? |
|---|---|---|---|---|
| 1 | Settings hierarchy and precedence order | §3 | Yes — the **machinery** | **No** |
| 2 | Feature flags, and the `BC-21` boundary | §6 | Yes | **No** — `BC-21` boundary held, §2.3 |
| 3 | Branding **values only** | §7.1 | Yes — values | **No** — `LibraryBranding` ceded, `CNF-XC-007` |
| 4 | Secret **references only** | §7.2 | Yes — references | **No** — material ceded, `CNF-XC-009` |
| 5 | The `E-19` typed-accessor contract | §4 | Yes | **No** — `E-19` names `BC-25` as sole provider |
| 6 | `LCFG-*` **resolution semantics** | §3.4 | Yes — resolution, not the list | **No** — `LCFG-1`…`13` cited, not restated |

**No seventh item is claimed.** Measured: the draft's §0.5 is a 13-row do-not-restate table and §15 a
consumed-authority list; neither adds an owned item. `ADR-0017` §5.3's second pre-registered risk —
*"`PRD-023` grows to absorb entitlement or security scope"* — does not materialise in this draft.

### 2.2 The aggregate question — disposition of `CNF-GAP-001`

This is the finding Stage 1 raised as `F-01` (High) and deliberately left for Stage 3, and Stage 1 `R-07`
rejected adopting the name as premature. It is re-measured here rather than inherited.

| Measurement | Command | Result |
|---|---|---|
| Occurrences of `LibrarySettings` outside PRD-023's own documents | `grep -rn "LibrarySettings" docs/` | **Exactly one** — `Library_PRD_v1.md:188` |
| That line, verbatim | — | `| **LibrarySettings** | BC-25 | Settings hierarchy and feature flags |` |
| Rows in BC Map §8 aggregate table | `awk '/^## 8\./,/^## 9\./' … | grep -c "^| BC-"` | **17** — `BC-01, 02, 03, 04, 05, 06, 10, 11, 12, 13, 18, 19, 20, 21, 24, 26, 27` |
| Is `BC-25` among them? | — | **No** |

So a **FROZEN Rank-3 PRD** (`Library_PRD_v1.md` v1.1) assigns an aggregate named `LibrarySettings` to `BC-25`,
while the **Rank-4 BC Map** — the authority for aggregate ownership under check 1 — grants `BC-25` no aggregate
at all. Rank 4 outranks Rank 3. `DOCUMENTATION_BASELINE.md` §4 governs the response:
*"A conflict is a defect. If you find one, **do not choose** — raise it."*

Stage 1 permitted exactly three dispositions. This review takes the third.

| Candidate disposition | Taken? | Reason |
|---|---|---|
| Adopt `LibrarySettings` as `BC-25`'s aggregate | **No** | Would elevate a Rank-3 mention over the Rank-4 aggregate table, and would have `PRD-023` create an aggregate the BC Map does not grant. That is inventing ownership |
| Declare `BC-25` aggregate-free and contradict `Library_PRD_v1.md:188` | **No** | Would silently overrule a FROZEN document from a Stage 3 record, which has no such authority |
| **Record the conflict, name the owner, and proceed without asserting an aggregate** | **Yes** | The draft already does exactly this: it names no aggregate, and carries the question as `CNF-GAP-001` |

**Disposition of `CNF-GAP-001`: ACCEPTED as an open conflict. Severity High. Owner Architecture Owner.**
It requires an ADR amending BC Map §8 (to grant the aggregate) **or** amending `Library_PRD_v1.md` L188 (to
withdraw the assignment). Neither is within a Stage 3 record's authority, and neither is attempted here.
This does **not** block Stage 3: the draft asserts no aggregate, so check 1's failure mode — *two PRDs own one
aggregate* — is not triggered. **Recorded as `A-01`.**

> **A note on what makes this safe.** `PRD-014` faced the mirror-image case: BC Map L383 *grants* `BC-21` an
> aggregate while Matrix L70 says R6 contexts own none (`ENT-GAP-006`, Low). There the grant existed and the
> denial was inferential. Here the denial is a table with 17 rows and the grant is one cell in a lower-ranked
> document. The asymmetry is why this is High and that was Low.

### 2.3 Reciprocity test — are the complements exact?

`PRD-014`'s §2.3 established that an ownership claim is only exclusive if the ceding document's exclusion is the
exact complement. Applied to `BC-25`'s four contested neighbours:

| Neighbour | `PRD-023` exclusion | Complement in the other document | Exact? |
|---|---|---|---|
| `BC-21` Entitlement | `CNF-XC-004` cedes `EntitlementSet`; `CNF-BR-001`…`005` draw the flag/entitlement line | `ENT-FR-012`…`019` own `E-17`; EA L106 *"Config resolves the flag; Business decides the entitlement"* | **Yes** |
| `BC-24` Audit Trail | `CNF-XC-010` cedes persistence, retention, query | `AUD-FR-003` — `BC-24` *"does not decide what is auditable elsewhere"* | **Yes** — and it is the exact complement: `BC-24` declines to decide, `PRD-023` declines to persist |
| `BC-19` Tenancy | `CNF-XC-*` cedes tenancy structure; §10 consumes `E-18` | `TEN-FR-010`…`020`; `TEN-FR-013` puts the interface at R0 | **Yes** |
| `SECURITY` / `BC-18` | `CNF-XC-009` cedes all secret material; `CNF-XC-006` cedes authorisation | `ID-1` — *"No context outside BC-18 may store a password, OTP, session or credential"* | **Yes** |
| `BC-29` File & Media | `CNF-XC-007` cedes `LibraryBranding`; images stay `FileRef`s | `E-22` — *"Domain holds a `FileRef`, never bytes"*; `ADR-0013` §5 | **Yes** |

**No gap and no overlap found in five complements.**

### 2.4 The three-bucket ownership split

Required explicitly by this stage. Every capability the draft touches is assigned to exactly one bucket. A
capability appearing in bucket 1 must be absent from 2 and 3, and the count must close.

**Bucket 1 — `BC-25` / Configuration-owned (owned outright by `PRD-023`)**

| Capability | Draft locus | `ADR-0017` §3.1 item |
|---|---|---|
| The five-scope hierarchy and its precedence order | §3, `CNF-FR-009`…`030` | 1 |
| Effective-value resolution machinery | §3, `CNF-XC-001`/`002` | 1, 6 |
| The `E-19` typed-accessor contract and its four properties | §4, `CNF-FR-031`…`046` | 5 |
| Startup validation of `INV-1`…`INV-16` | §5, `CNF-FR-047`…`050` | 5 (mechanism) |
| Feature-flag definition, evaluation, rollout | §6, `CNF-FR-051`…`054` | 2 |
| Branding **values** | §7.1, `CNF-FR-055`/`056` | 3 |
| Secret **references** | §7.2, `CNF-FR-057`…`059` | 4 |
| Change history of a configuration value | §8, `CNF-FR-060`…`063` | 1 |
| Resolution-machinery observability | §11, `CNF-FR-071`…`075` | 1 |
| Inherited-vs-set presentation | §12, `CNF-FR-076`…`082` | 1 |

**10 capabilities. All ten map to one of the six `ADR-0017` §3.1 items. No eleventh.**

**Bucket 2 — Existing BC / platform-owned (cited, never owned)**

| Capability | Owner | `PRD-023` exclusion |
|---|---|---|
| Authorisation, roles, sessions, credentials | `BC-18` | `CNF-XC-006` |
| Secret **material**, key material, device trust | `SECURITY`; `BC-18` for credentials | `CNF-XC-009` |
| Entitlement decisions, `EntitlementSet`, quotas | `BC-21` | `CNF-XC-004` |
| Tenancy structure, provisioning, `TenantContext` | `BC-19` / `PRD-013` | §10, cited |
| Audit persistence, retention, query | `BC-24` / `PRD-016` | `CNF-XC-010` |
| File bytes, thumbnails, signed URLs | `BC-29` / `PRD-017` | `CNF-XC-007` |
| `LibraryBranding` aggregate | `PRD-002`, `ADR-0013` §5 | `CNF-XC-007` |
| The `LCFG-1`…`13` **value list** | `PRD-002` §16.1 / §14B.9 | `ADR-0017` §3.2; §0.5 |
| `CFG-*`, `ICFG-*`, `SCFG-*`, `SMCFG-*`, `MM-CFG-*`, `SEAT-CFG-*`, `ATT-CFG-*` definitions | 8 FROZEN PRDs | §0.5, 13 rows |
| `BranchPolicy` effective-dating | `BC-06` | `CNF-XC-013` |
| Per-parameter observability table | `CONFIGURATION_GUIDE.md` §6 | `CNF-XC-015` |
| UI component library, tokens, WCAG targets | UI Design System (**does not exist**) | §14.1 |
| Latency and availability budgets | `NFR Budgets (V1)` (**does not exist**) | §14.1 |

**13 capabilities ceded. Two of the thirteen are ceded to documents that do not exist** — recorded as `A-06`.

**Bucket 3 — Cross-context / integration-owned**

| Edge | Direction | Present in BC Map §7? | `PRD-023`'s role |
|---|---|---|---|
| `E-19` typed config accessors | All contexts → `BC-25` | **Yes**, §7.3 L328 | **Provider.** This document writes the contract |
| `E-18` ambient `TenantContext` | All contexts → `BC-19` | **Yes**, §7.3 L327 | Consumer |
| `E-20` audit fact | All contexts → `BC-24` | **Yes**, §7.3 L329 | Producer — see §3.2 |
| `E-22` `FileRef` for branding images | `BC-01, BC-10, BC-14` → `BC-29` | **Yes**, §7.3 L331 | **Not a consumer** — `BC-25` is not on the consumer list, and the draft does not add itself |
| `E-17` entitlement check | All write paths → `BC-21` | **Yes**, §7.3 L326 | **Neither.** `E-17`'s note says the disposition is *"recorded in Config"*; the draft holds the value, does not perform the check |
| `policy_decision` port | → `platform/identity` | Manifest L442, closed consumer list | **Forbidden by omission** — §5.2 |

**Zero edges created. Zero edges assumed. Every edge in bucket 3 is pre-existing in BC Map §7.**

**Split closes:** 10 owned + 13 ceded + 6 edges. No capability appears in two buckets; the ceded set and the
owned set are disjoint by inspection of the exclusion identifier attached to each ceded row.

### 2.5 No capability ownership is silently absorbed by `BC-25`

Required explicitly by this stage. The test applied: for every register the draft touches, does it **define** a
member or **cite** one?

| Register | Members defined by `PRD-023` | Members cited | Verdict |
|---|---|---|---|
| `CFG-*` (12), `LCFG-*` (13), `ICFG-*` (10), `SCFG-*` (11), `SMCFG-*` (7), `MM-CFG-*` (9), `SEAT-CFG-*` (18), `ATT-CFG-*` (24) | **0** | 104, as a census table in §3 | Cited, not absorbed |
| `INV-1`…`INV-16` | **0** — `CNF-FR-047`…`050` state *validation of* them | 16 | Cited, not absorbed |
| `TEN-FR-*`, `AUD-FR-*`, `ENT-FR-*` | **0** | Several | Cited |
| `CNF-CFG-*` | **0 — register declared empty** | — | See §6.5 |
| `CNF-EVT-*` | **0 — register declared empty** | — | See §3.3 |

**Measured: zero configurable parameters are defined by `PRD-023`.** This is the discipline `ADR-0017` §5.3's
third risk anticipated — *"`LCFG-*` requirements silently migrate out of the Library PRD"* — and it did not occur.
The precedent is `TRACEABILITY_MATRIX.md` L209-210: *"`SMCFG-1` is **cited rather than duplicated**."*

**Check 1 verdict: PASS**, with `A-01` (`CNF-GAP-001`) accepted as an open conflict that does not trigger the
failure mode.

---

## 3. Check 2 — Every integration edge exists in §7

**Failure mode:** *"If an edge is not in this table, it does not exist"* — adding one needs an ADR.
BC Map §7 preamble **L292** states it: *"If an edge is not in this table, it **does not exist** and adding it
requires an ADR."*

### 3.1 Edge inventory

Every edge the draft names was checked against BC Map §7. The result is in §2.4 bucket 3: **six edges named,
six pre-existing, zero created.** `E-19` is the one the draft *provides*; it is BC Map §7.3 L328 and it names
`BC-25` as the provider explicitly. Writing its contract is not creating an edge — it is discharging
`ADR-0017` §3.1 item 5.

### 3.2 The `E-20` audit path — and a correction to this review's own prior assumption

The Stage 2 draft's `CNF-FR-061` requires the audit fact *"be emitted through **`E-20`** to `BC-24`."* Entering
this review, the working hypothesis — carried forward from `PRD-014`'s `ENT-GAP-005` — was that this crosses the
`H-1` capability→capability taxonomy gap and would force a **CONDITIONAL PASS**. **Measurement refutes that
hypothesis, and it is withdrawn.**

| Measurement | Command / locus | Result |
|---|---|---|
| Which band contains `BC-25`? | BC Map **L271** | **`FOUNDATIONAL` · `BC-18` · `BC-19` · `BC-25`** |
| Which band contains `BC-21` (the `PRD-014` case)? | BC Map **L263** | `CAPABILITY & GENERIC` |
| Which band contains `BC-24`? | BC Map **L266** | `CAPABILITY & GENERIC` |
| `E-20` row | BC Map **L329** | `All contexts | BC-24 Audit Trail | PL | Event (fire-and-forget, outbox-backed)` |
| Does §7.3 already contain non-domain consumers? | BC Map **L338** `E-25`, **L339** `E-26` | **Yes** — `E-25` is `BC-20` (capability band, L129) → `BC-31`; `E-26` is `BC-27` (L136) → `BC-26`, `BC-23` |

Three consequences, each decisive:

1. **`BC-25` is not capability-band.** It is foundational. `PRD-014`'s `H-1` reasoning turned on `BC-21` being
   capability-band (its own record says so at L364: *"`BC-21` is capability-band, so the edge would be
   capability→capability"*). That premise is simply false for `BC-25`. **`H-1` does not apply to `PRD-023`.**
2. **`E-20`'s consumer column is `All contexts`, not `All domain contexts`.** A foundational context is a
   context. The edge as written already covers `BC-25`.
3. **§7.3's title is not a closed constraint on its own contents.** The section is titled *"Domain → Capability
   (downward, ports only)"*, yet it contains `E-25` (`BC-20` → `BC-31`) and `E-26` (`BC-27` → `BC-26`, `BC-23`) —
   two edges whose upstream is not domain-band. The heading describes the dominant case; the **table** is
   normative, per L292's *"this table"*. Reading the heading as a prohibition would invalidate two edges the
   BC Map itself publishes.

**Disposition: `CNF-FR-061` stands as written. No edge is added. `H-1` is NOT inherited by `PRD-023`.**
Recorded as **`A-02`** — a finding of *fact corrected*, not a defect. The prior hypothesis is recorded as
rejected at `R3-01` so that the reasoning is auditable rather than merely absent.

> **Why this is not opportunism.** The permissive reading is being adopted *against* the reviewer's own prior
> position, on three independent measurements, one of which (§7.3 already containing `E-25`/`E-26`) would break
> the BC Map if the restrictive reading were correct. `PRD-014` remains correctly CONDITIONAL: `BC-21` really is
> capability-band and `E-20` really is not granted to it any more than to any other capability context. The two
> records differ because the two contexts sit in different bands, which is a fact about the BC Map, not a
> difference in how strictly the two reviews read it.

### 3.3 `CNF-EVT-*` remains empty — confirmed

Required explicitly by this stage: *"`CNF-EVT` remains empty unless authoritative evidence proves otherwise."*

| Measurement | Command | Result |
|---|---|---|
| `BC-25` in the BC Map §9 producer table | `awk '/^## 9\./,/^## 10\./' … | grep -c "BC-25"` | **0** |
| Producers actually listed in §9 | — | `BC-01` (×4 + register), `BC-02` (×5), `BC-03` (×4), `BC-04` (×2), `BC-05` (×3), `BC-06`, `BC-10` (×5 + register), `BC-11`, `BC-12`, `BC-13` (×2), `BC-18`, `BC-19`, `BC-20` |
| Numbered `CNF-EVT-` members in the draft | grep | **0** |

`BC-25` is named nowhere in §9, in either the Producer or the Primary-consumers column. **No authoritative
evidence exists for a `BC-25`-produced event.** `CNF-EVT-*` therefore remains empty, and Stage 5 must not create
a member. This mirrors `ENT-EVT-*` (empty for the same reason, `PRD-014` L390) and `AUD-EVT-*`
(`AUD-FR-012`) and `TEN-EVT-*` — a third instance of an established precedent, not a novelty.

> **A distinction that matters, and is not being blurred.** §3.2 concludes `BC-25` may *emit through `E-20`*;
> §3.3 concludes `BC-25` *produces no Published Language event*. These are not in tension. `E-20` is
> `PL`-pattern delivery **into** `BC-24`; the fact travels on `BC-24`'s inbound contract, and §9 governs a
> context's **own** published event surface, which `BC-25` does not have. Were `CNF-FR-061` read as creating a
> `configuration.SettingChanged` domain event on the bus, it would require a §9 amendment. It is not so read,
> and Stage 4 should confirm the draft's wording does not drift toward that reading.

**Check 2 verdict: PASS.** Zero edges added; `E-20` lawful on measurement; `CNF-EVT-*` empty confirmed.

---

## 4. Check 3 — Rank direction is downward

**Failure mode:** an illegal import. Authority: Matrix **L49 `L2`** — *"strictly lower rank… Same-rank
dependencies are forbidden except within a declared cluster"*; **L54** — *"L1 is absolute. L2–L5 admit
exceptions only through the ADR process in §11."*

### 4.1 Enforcement measured from the checker source, not the rank table

Required explicitly by this stage: *"dependency/rank enforcement from actual checker code."*

| Measurement | Locus | Result |
|---|---|---|
| Rank check signature | `_checkRankOrdering(File file, Module? module, List<({String uri, int line})> imports)` | Takes **imports only** |
| Upward import | `if (target.rank > module.rank)` | `'rank-ordering'` violation |
| Same-rank import | `else if (target.rank == module.rank)` | `'same-rank'`, *"Forbidden outside a declared cluster"* |
| What a port is | manifest MODES | *"interface declared by consumer, implemented elsewhere, DI-wired (**NO import**)"* |
| Is `provides_ports` enforced? | `grep -c "provides_ports" tool/check_module_boundaries.dart` | **0 — never read by the checker** |

`platform/configuration` is rank 3. Under the draft's design it imports `contracts` (rank 0) and nothing else,
so no upward or same-rank import arises. **Check 3's failure mode is not triggered.**

### 4.2 Correction to the draft's §1.3 — confirmed correct, and strengthened

The Stage 2 draft withdrew an earlier claim that `L2` arithmetic forbids `platform/configuration` from calling
authorisation at rank 4. This review **confirms the withdrawal was correct** and confirms both counter-examples
independently:

| Counter-example | Verified | Consequence |
|---|---|---|
| `platform/identity` (rank 4) declares `platform/tenancy:tenant_context` (rank 4) as a **port** | Manifest L428, present and unflagged | A same-rank **port** is lawful. Rank arithmetic forbids nothing here |
| `TenantContext` interface lives in `liboora_contracts` (R0), read at R2 | Matrix §8.3 L403 | Reading tenant context is never an upward dependency, at any rank |

The draft's replacement basis — `default_decision: deny` plus `policy_decision`'s closed consumer list — is the
correct one and is verified at §5.2. **Recorded as `A-07`: a self-correction verified as sound.**

### 4.3 A defect in the draft's supporting reasoning, and its correction

The draft's §1.3 cites the manifest's closed-world rule as making an authorisation call *"forbidden by omission,
**mechanically, today**."* The second half of that clause is **not supported by the checker source** and is
corrected here.

```dart
if (module.declaredImports.isEmpty) return;   // check_module_boundaries.dart L778
```

`platform/configuration` has **no module block** in the manifest (§5.2), so its `declaredImports` is empty and
the `default_decision: deny` check **returns before evaluating anything**. A module without a block is
*exempted* from the closed-world check, not caught by it. Additionally, `provides_ports` — the structure holding
`policy_decision`'s consumer list — is never read by the checker at all (0 occurrences).

So the prohibition in §1.3 is **normatively sound and mechanically unenforced**. Under `SID-4.56` — *"A rule
that cannot be checked SHALL be treated as **unmet**"* — the draft's word *"mechanically"* overstates the
guarantee by exactly one word, and the fix is a one-word correction plus an explicit `SID-4.56` disclosure, not
a change of position. **Recorded as `A-05`. Severity Medium. Owner: product owner of `PRD-023`, at Stage 4.**

**Check 3 verdict: PASS.** No illegal import is specified or implied. `A-05` and `A-07` recorded.

---

## 5. Checks 4 and 5 — No authorisation, credential, OTP or session outside `BC-18`

**Failure modes:** check 4 — *"a security defect that passes its own tests"*; check 5 — prohibited outright.
Authorities: Matrix `X-13`; BC Map **`ID-1`** (L178) — *"No context outside `BC-18` may store a password, OTP,
session or credential."*

### 5.1 Classification of every credential-adjacent mention

`grep -n "credential\|OTP\|AuthSession\|password"` over the draft returns **8** hits. Each is classified. A raw
count proves nothing; the failure mode is an *introduction* disguised among *citations*.

| Line | Text in role | Classification |
|---|---|---|
| 151 | `| Authorisation decisions, roles, sessions, credentials | BC-18 | Never called … CNF-XC-006 |` | **Cession** — bucket-2 row naming `BC-18` as owner |
| 304 | *"no library sets its own OTP quota. Both are Configuration"* | **Boundary argument** — uses OTP as an example of a value a library may *not* set |
| 505 | *"a library could raise its own OTP quota"* — stated as the harm being prevented | **Prohibition rationale** |
| 507 | *"never bypass OTP"*, quoting `CONFIGURATION_GUIDE.md` §4 rule 2 | **Verbatim citation** of a Rank-7 guide |
| 858 | *"credential capable of doing so"* | **Prohibition** |
| 864 | *"…a credential, a password, an OTP, a session token, a device trust marker or key material"* | **Exclusion list** — the body of `CNF-XC-009` |
| 865 | *"Owner: **SECURITY** platform; **`BC-18`** for credentials and sessions"* | **Explicit cession of ownership** |
| 968 | *"must never disable a control, never bypass OTP, and never introduce a demo account"* | **Verbatim citation** |

**Result: 8 of 8 are citations, prohibitions, cessions or exclusion text. Zero introductions.** The draft
stores no credential, defines no session, and sets no OTP parameter. Notably, the strongest OTP mentions
(304, 505) exist to argue that a runtime scope must *not* be able to override an authentication parameter — the
draft is using OTP to tighten its own scope, which is the opposite of the check-5 failure mode.

### 5.2 Check 4 — authorisation, and the orphan `platform/configuration:settings` port

Required explicitly by this stage. Measured:

| Measurement | Command | Result |
|---|---|---|
| Inbound references to `platform/configuration:settings` | grep | **7** — manifest L108, 182, 240, 280, 309, 336, 513 |
| A `platform/configuration:` module block | `grep -n "^platform/configuration:$"` | **0 — none exists** |
| `policy_decision` consumer list | manifest L442-443 | `[domain/library, domain/social, platform/ai, platform/analytics, platform/workflow]` |
| Is `platform/configuration` on it? | — | **No** |

`platform/configuration` cannot lawfully call authorisation: it is not a declared consumer of the only port that
provides it. Combined with §5.1's zero introductions and `CNF-XC-006`'s explicit cession, **check 4 passes.**
The one qualification is `A-05` (§4.3): the prohibition is normative, not machine-enforced.

**The orphan port is not a `PRD-023` defect — it is a manifest-wide convention.** The draft (§1.2) and Stage 1
(`M-08`/`M-09`) both present *"seven modules declare a dependency on a port no module provides"* as a finding
about `platform/configuration`. Measured across all rank-1-to-3 platform modules:

| Module | Module block | Inbound port references |
|---|---|---|
| `platform/infrastructure` | **none** | 0 |
| `platform/data` | **none** | 6 |
| `platform/security` | **none** | 5 |
| **`platform/configuration`** | **none** | **7** |
| `platform/observability` | **none** | 7 |
| `platform/services` | **none** | 14 |
| `platform/event` | **none** | 0 |
| `platform/integration` | **none** | 4 |

**Eight of twenty ranked modules have no block.** `platform/services` is referenced 14 times — twice as often
as `settings` — and is equally blockless. The manifest declares a *provider* block only where a module needs
`banned_imports`, `provides_ports` or `imports` of its own; the checker synthesises the rest via
`_defaultPath(name)` from the rank list alone (L406).

**Disposition of the orphan-port finding: ACCEPTED, but RECLASSIFIED.** It is real, it does block implementation
(a module with no block has no declared `imports`, so it cannot lawfully declare a compile-time dependency on
anything — and, per §4.3, is silently exempted from the deny check rather than caught by it), and the draft
correctly records it as `CNF-GAP-007` and defers it to Stage 6. But it is **not specific to `BC-25`** and must
not be presented as though `PRD-023` inherited a unique defect. **Recorded as `A-03`. Severity Medium. Owner:
Architecture Owner** for the manifest-wide pattern; **`PRD-023` Stage 6** for its own block only.

### 5.3 Disposition of `CNF-GAP-004` — the kernel port list

Measured. Matrix §6.3, `liboora_contracts` spec block:

```
port_interfaces: "only ports of universal reach (TenantContext, Telemetry, Clock)"
change_policy: "Architecture Review Board approval required. Additive only within a major version."
```

`settings` is **absent** from the three named. Yet `E-19` binds *"All contexts"*, which is the definition of
universal reach. Counter-measurement on consumer count:

| Port | Consumer declarations |
|---|---|
| `platform/tenancy:tenant_context` | **8** |
| `platform/configuration:settings` | **7** |
| `platform/observability:telemetry` | **7** |

By the manifest's own arithmetic, `settings` is **indistinguishable from `telemetry`**, which *is* on the list.
So either the list is under-inclusive, or "universal reach" means something narrower than the consumer count
suggests and `E-19` is delivered by a different mechanism.

**Disposition of `CNF-GAP-004`: ACCEPTED as an open architectural question. Severity Medium. Owner Architecture
Owner.** It is **not** resolved here, for a reason of authority rather than difficulty: `change_policy` reserves
additions to `liboora_contracts` for the **Architecture Review Board**, so a Stage 3 record adding `settings` to
the shared kernel would be usurping a named body. The draft correctly states the obligation without asserting
the placement. **Recorded as `A-04`.** This does not block Stage 3: nothing in checks 1–6 depends on where the
`E-19` interface physically lives, and `CNF-FR-031`…`046` specify the contract's *shape*, which is
placement-independent.

**Checks 4 and 5 verdict: PASS.** 8 of 8 credential mentions are citations or cessions; authorisation forbidden
by omission and ceded explicitly; `A-03`, `A-04`, `A-05` recorded.

---

## 6. Check 6 — Tenant scoping correct

**Failure mode:** cross-tenant leak — `MP-RSK-01`, **Critical**. Authorities: `MP-GBR-08`; Matrix `X-13`.

### 6.1 The five global-boundary rules, applied

| Rule | Verbatim | `PRD-023` locus | Satisfied? |
|---|---|---|---|
| `MP-GBR-06` | *"Every request carries a resolved tenant context"* | §10, consumes `E-18` | **Yes** |
| `MP-GBR-07` | *"A consumer that processes an event without establishing tenant context **fails loudly, never defaults**"* | `CNF-FR-068` | **Yes** — and it is stronger than required |
| `MP-GBR-08` | *"Every search index and vector namespace is tenant-partitioned"* | `CNF-FR-069` | **Yes** — every cache key carries `tenantId` |
| `MP-GBR-09` | *"A change to a cache key, index name or vector namespace is a **security-reviewable change**"* | `CNF-FR-070` | **Yes** |
| `TEN-FR-011` | *"**MUST NOT** default to a tenant and **MUST NOT** default to null"* | `CNF-FR-068` | **Yes** |

`CNF-FR-068` is worth quoting for its precision: an absent tenant context must produce a **failure**, not a
default, not null, not the platform default, and **not an empty result**. The last clause is the one that matters
and is the hardest to get right — an empty result is the failure mode `AUD-FR-015` exists to forbid, because it
is indistinguishable from a legitimately empty answer. The draft imports that lesson from a FROZEN PRD rather
than rediscovering it.

### 6.2 The subtlest requirement in the draft

`CNF-INV-004` states that another tenant's value must not be observable via cache, error, log, telemetry **or a
validation failure reason** — with the worked example of a message reading *"conflicts with `tenant-4417`'s
value."* This is a genuine side-channel, it is not required by any rule cited above, and no other PRD in the
repository states it. **It is noted here as strengthening rather than as a finding**, because a Stage 3 record
should record where its subject exceeded its obligations as well as where it fell short.

### 6.3 The hierarchy itself is the risk surface

`BC-25` resolves across **five scopes** — platform default → tenant → library → branch → user. Scope 1 is
**cross-tenant by construction**: it is the only value in the system that is legitimately shared across tenant
boundaries. A defect in precedence resolution is therefore a cross-tenant read by design, not by accident.

The draft's controls: `CNF-INV-003` (never return another tenant's value on any path), `CNF-INV-004` (§6.2),
`CNF-BR-009` (no tenant role writes scope 1, citing `AUTH-2.9`), `CNF-FR-069` (`tenantId` in every cache key).
`CNF-BR-010` adds the distinction that read authority is not write authority. These are adequate **as
specifications**.

### 6.4 The enforcement gap — `CNF-GAP-008`

| Measurement | Result |
|---|---|
| Files in `test/architecture/` | **1** — `boundary_checker_test.dart` |
| Matrix §10.3 required architecture tests | **7** |
| Is `tenant_isolation_test.dart` among the existing? | **No** |

Under `SID-4.56`, `CNF-INV-003` and `CNF-INV-004` are **unmet on the day this PRD freezes**. The draft states
this in §10.3 in exactly those words and carries it as `CNF-GAP-008`. **Recorded as `A-06`. Severity High
(the failure mode is `MP-RSK-01`, Critical). Owner Implementation lead.** Pre-existing and product-wide: it
affects all 11 FROZEN PRDs equally, and merge-blocking pipeline gate 4 (Matrix §10.4) is green on **0 of 7**
required properties.

This does **not** fail check 6. The check tests whether *tenant scoping is correct* in the specification; it is.
That the repository cannot yet *prove* it is a pre-existing condition of the repository, disclosed rather than
concealed — the same disposition `PRD-013`, `PRD-016` and `PRD-014` each took.

### 6.5 Disposition of `CNF-GAP-006` — the EA V1/V2 conflict

Measured:

| Locus | Statement |
|---|---|
| EA **L526** | `Secret Reference Resolution (V2)` ← SCOPED (secrets owned by SECURITY PLATFORM) |
| EA **L529** | `Feature Flags (V2)` ← MERGED (Shared Core: Feature Flags) |
| EA **L528** | `Feature Configuration (V2)` — the whole subtree |
| `ADR-0017` §3 | `PRD-023` is **V1** |
| `ADR-0017` §3.1 | Items 2 and 4 assign feature flags and secret references to `PRD-023` |

`ADR-0017` §3 is **Rank 2**. The Enterprise Architecture is **Rank 6**, and its own governing rule is
*"Descriptive only. Update it to match 1–5; **never the reverse**."*

**Disposition of `CNF-GAP-006`: ACCEPTED. Severity Low. Owner Architecture Owner.** The precedence is not in
doubt — Rank 2 governs, so feature flags and secret references are V1 and `PRD-023` owns them. What is
*unresolved* is the **document defect**: EA still says V2, and per `DOCUMENTATION_BASELINE.md` §4 *"A conflict is
a defect. If you find one, do not choose — raise it."* Correcting a Rank-6 document is the Architecture Owner's
act, not a Stage 3 record's — and doing it here would be the mirror of the overreach `ADR-0017` §5.3's first
risk anticipates. **The scope question is settled; the document conflict is raised and left open.**
**Recorded as `A-08`.**

**Check 6 verdict: PASS.** All five global-boundary rules satisfied; one requirement exceeds them; `A-06` and
`A-08` recorded.

---

## 7. Candidate findings recorded as REJECTED, with reasons

`PRD_LIFECYCLE.md` L104 requires this section. Eleven candidates were raised during the review and rejected.
The `PRD-014` review accepted 8 of 19; this one accepts 8 of 19.

| # | Candidate finding | Why rejected |
|---|---|---|
| `R3-01` | *"`CNF-FR-061` crosses the `H-1` capability→capability gap, as `PRD-014` `ENT-GAP-005` did, so Stage 3 must be CONDITIONAL."* | **Rejected on measurement — this was the reviewer's own entering hypothesis.** `H-1` turns on the upstream being capability-band. BC Map **L271** places `BC-25` in the **FOUNDATIONAL** band, not L263's capability band. `E-20`'s consumer column reads *"All contexts."* And §7.3 already publishes `E-25` (`BC-20`→`BC-31`) and `E-26` (`BC-27`→…), so the restrictive reading of the §7.3 heading would invalidate two BC Map edges. The hypothesis was wrong; recording it as rejected is why §3.2 is auditable |
| `R3-02` | *"Adopt `LibrarySettings` as `BC-25`'s aggregate — a FROZEN PRD names it, so it is settled."* | Rejected. `Library_PRD_v1.md` is **Rank 3**; the BC Map §8 aggregate table is **Rank 4** and has 17 rows without `BC-25`. Adopting the name elevates the lower rank and invents ownership the BC Map does not grant. Requires an ADR (`A-01`) |
| `R3-03` | *"Declare `BC-25` aggregate-free, since BC Map §8 omits it."* | Rejected as the mirror error. It would have a Stage 3 record silently overrule `Library_PRD_v1.md:188`, a FROZEN document. §4's *"do not choose — raise it"* forbids both directions |
| `R3-04` | *"Add `settings` to `liboora_contracts` `port_interfaces` — `E-19` binds all contexts, so it plainly has universal reach, and the consumer count (7) equals `telemetry`'s."* | **Rejected as an action; accepted as a finding (`A-04`).** The arithmetic is real and is now recorded. But Matrix §6.3 `change_policy` reserves kernel additions to the **Architecture Review Board**. Acting on a sound argument without the conferred authority is precisely the overreach `ADR-0017` §5.3 risk 1 anticipates |
| `R3-05` | *"Correct EA L526/L529 from V2 to V1 — Rank 2 governs, so the answer is not in doubt."* | **Rejected as an action; accepted as a finding (`A-08`).** The precedence conclusion is stated in §6.5. But EA is a Rank-6 document owned by the Architecture Owner, and a Stage 3 record editing Rank 6 to match Rank 2 is still an unauthorised edit |
| `R3-06` | *"The orphan `platform/configuration:settings` port is a `BC-25`-specific blocker and should be severity High."* | **Rejected as scoped; accepted as reclassified (`A-03`).** Measured: **8 of 20** ranked modules have no block, including `platform/services` with **14** inbound references. The pattern is manifest-wide. Presenting it as a `PRD-023` defect would have overstated `BC-25`'s exposure and understated the product-wide one |
| `R3-07` | *"`platform/configuration` calling authorisation is forbidden mechanically today, so `CNF-XC-006` needs no `SID-4.56` disclosure."* | **Rejected on the checker source; the opposite is accepted as `A-05`.** `check_module_boundaries.dart` **L778**: `if (module.declaredImports.isEmpty) return;` — a module with no block is *exempted* from the deny check. And `provides_ports` has **0** occurrences in the checker. The rule is normative and unenforced |
| `R3-08` | *"`PRD-023` should define `CNF-CFG-*` members — a Configuration PRD with no configurables is absurd."* | Rejected. `ADR-0017` §3.2: *"This ADR moves no requirement."* The 104 configurables belong to 8 FROZEN PRDs; `PRD-023` owns the **machinery**. `TEN-CFG-*`, `AUD-CFG-*` and `ENT-CFG-*` are all empty by the same logic — three precedents, not an anomaly |
| `R3-09` | *"Create `CNF-EVT-001` for `configuration.SettingChanged` — §8's change history obviously implies an event."* | Rejected. **`BC-25` appears 0 times in BC Map §9.** An event surface requires a §9 amendment. §3.3's distinction holds: emitting *through* `E-20` into `BC-24` is not the same as publishing an event of one's own |
| `R3-10` | *"`PRD-023` should author the missing UI Design System tokens, since §12 depends on them and nothing else will."* | Rejected. `MP-NFR-06`/`MP-NFR-08` name the **UI Design System** as owner; it is a **Rank-1**-mandated artefact. A Rank-3 PRD authoring a Rank-1 artefact is `ADR-0017` §5.3 risk 1 exactly. Recorded as `A-06`'s second limb instead |
| `R3-11` | *"`CNF-FR-047`…`050` validating `INV-1`…`INV-16` absorbs the `CONFIGURATION_GUIDE.md` invariant register into `BC-25`."* | Rejected on reading. The draft defines **0** `INV-*` members; it requires *validation of* the 16 that `CONFIGURATION_GUIDE.md` §3 defines. The guide itself demands this: *"It is a reason the validation must be mechanical."* Validating a register is not owning it |

---

## 8. Accepted findings

| ID | Finding | Check | Severity | Owner | Disposition |
|---|---|---|---|---|---|
| `A-01` | `Library_PRD_v1.md:188` assigns aggregate `LibrarySettings` to `BC-25`; BC Map §8 (17 rows, Rank 4) grants `BC-25` no aggregate. Rank-3 vs Rank-4 conflict | 1 | **High** | Architecture Owner | **OPEN** (`CNF-GAP-001`). Needs an ADR amending BC Map §8 **or** `Library_PRD_v1.md` L188. Draft asserts no aggregate, so check 1's failure mode is not triggered |
| `A-02` | `BC-25` is **FOUNDATIONAL** (BC Map L271), not capability-band. `H-1` is therefore **not** inherited by `PRD-023`, contrary to the reviewer's entering hypothesis | 2 | Informational — **fact corrected** | This record | **CLOSED.** `CNF-FR-061` stands. Reasoning at §3.2; rejected hypothesis at `R3-01` |
| `A-03` | `platform/configuration` has no manifest module block. **Reclassified**: 8 of 20 ranked modules have none, incl. `platform/services` with 14 inbound refs. Manifest-wide, not `BC-25`-specific | 4 | **Medium** | Architecture Owner (pattern); `PRD-023` Stage 6 (own block) | **OPEN** (`CNF-GAP-007`). Stage 6 must author the block and must not present the pattern as `BC-25`'s alone |
| `A-04` | Matrix §6.3 `port_interfaces` names only `TenantContext, Telemetry, Clock`; `settings` is absent though `E-19` binds all contexts and its consumer count (7) equals `telemetry`'s | 4 | **Medium** | Architecture Owner / **Architecture Review Board** | **OPEN** (`CNF-GAP-004`). Not resolved here: `change_policy` reserves kernel additions to the ARB. Placement-independent, so Stage 3 is unaffected |
| `A-05` | Draft §1.3 says the authorisation prohibition is enforced *"mechanically, today."* Checker **L778** exempts blockless modules from the deny check, and `provides_ports` is read **0** times. Normative but unenforced | 3, 4 | **Medium** | `PRD-023` product owner, at **Stage 4** | **OPEN.** Requires a one-word correction plus an explicit `SID-4.56` disclosure. Position unchanged; guarantee restated honestly |
| `A-06` | `test/architecture/` holds **1** of Matrix §10.3's **7** required tests; `tenant_isolation_test.dart` absent. Under `SID-4.56`, `CNF-INV-003`/`004` are unmet at freeze. Second limb: UI Design System and `NFR Budgets (V1)` do not exist, so §12 and §11 cite absent owners | 6 | **High**, pre-existing and product-wide | Implementation lead; UI Design System owner; NFR owner | **OPEN, inherited** (`CNF-GAP-008`, §14.1). Disclosed, not concealed — same disposition as `PRD-013`, `PRD-016`, `PRD-014` |
| `A-07` | Draft §1.3's withdrawal of the earlier `L2`-arithmetic argument is **verified correct**: same-rank ports are lawful (manifest L428), and `TenantContext` sits at R0 (Matrix L403) | 3 | Informational — **self-correction verified** | This record | **CLOSED.** The replacement basis is sound, subject to `A-05` |
| `A-08` | EA L526 and L529 place `Secret Reference Resolution` and `Feature Flags` at **V2**; `ADR-0017` §3 (Rank 2) makes `PRD-023` **V1** and §3.1 assigns both to it | 6 | **Low** | Architecture Owner | **OPEN** (`CNF-GAP-006`). Precedence settled in §6.5 — Rank 2 governs, both are V1. The Rank-6 document defect is raised, not corrected |

**Eight findings. Two CLOSED as corrections of fact, six OPEN.** None of the six is closed by this record, and
none is presented as closed. Two of the eight (`A-02`, `A-07`) correct the review's or the draft's own prior
reasoning; a third (`A-05`) corrects the draft against the reviewer's initial agreement with it.

---

## 9. Verdict

| # | Check | Verdict | Basis |
|---|---|---|---|
| 1 | Context ownership is exclusive | **PASS** | 6 of 6 `ADR-0017` §3.1 items owned, no seventh; 5 reciprocity complements exact; 0 configurables absorbed; `A-01` open but failure mode not triggered |
| 2 | Every integration edge exists in §7 | **PASS** | **Zero edges added.** `E-20` lawful on three independent measurements (`A-02`); `CNF-EVT-*` empty confirmed at 0 hits in §9 |
| 3 | Rank direction is downward | **PASS** | No upward or same-rank import specified; enforcement measured from checker source; `A-05`, `A-07` |
| 4 | No authorisation outside `BC-18` | **PASS** | Forbidden by omission from `policy_decision`'s closed consumer list; ceded by `CNF-XC-006`; `A-03`, `A-04`, `A-05` |
| 5 | No credential, OTP or session outside `BC-18` | **PASS** | **8 of 8** mentions are citations, prohibitions, cessions or exclusion text. Zero introductions |
| 6 | Tenant scoping correct | **PASS** | `MP-GBR-06`…`09` and `TEN-FR-011` all satisfied; `CNF-INV-004` exceeds requirement; `A-06`, `A-08` |

### **STAGE 3 VERDICT: PASS**

**Unconditional.** This is a stronger verdict than `PRD-013`'s and `PRD-014`'s CONDITIONAL PASS, and the reason
is a single measured fact rather than a difference in rigour: **`BC-25` sits in the FOUNDATIONAL band** (BC Map
L271), so the `H-1` capability→capability taxonomy gap that conditioned both predecessors **does not apply to
it**. `E-19` names `BC-25` as its provider explicitly, and `E-20`'s consumer column reads *"All contexts."*
`PRD-023` needs no edge that BC Map §7 does not already publish.

Six findings remain OPEN (`A-01`, `A-03`, `A-04`, `A-05`, `A-06`, `A-08`). None of the six is a Stage 3 failure:

- `A-01`, `A-04`, `A-08` require ADRs or Architecture Review Board action — **conflicts raised, not resolved**,
  which is what `DOCUMENTATION_BASELINE.md` §4 demands.
- `A-03` and `A-06` are pre-existing repository conditions affecting all 11 FROZEN PRDs equally.
- `A-05` is a wording correction carried into Stage 4.

**Proceed to Stage 4 — Requirements Review.**

---

## 10. What this record deliberately does not do

| Not done | Why |
|---|---|
| Assign `BC-25` an aggregate | BC Map §8 grants none. Requires an ADR (`A-01`) |
| Deny `Library_PRD_v1.md:188` | It is FROZEN. A Stage 3 record cannot overrule it (`R3-03`) |
| Add `settings` to `liboora_contracts` | `change_policy` reserves it to the Architecture Review Board (`R3-04`) |
| Correct EA L526/L529 | Rank 6, Architecture Owner's document (`R3-05`) |
| Author the `platform/configuration` manifest block | Stage 6's task; also manifest-wide (`A-03`) |
| Write `tenant_isolation_test.dart` or the other six | Implementation, not Stage 3 (`A-06`) |
| Author UI Design System tokens or NFR budgets | Rank-1 artefacts; `ADR-0017` §5.3 risk 1 (`R3-10`) |
| Create any `CNF-EVT-*` or `CNF-CFG-*` member | No authoritative evidence exists (`R3-08`, `R3-09`, §3.3) |
| Amend the PRD-023 draft | Stage 3 reviews; Stage 4 dispositions. `A-05` is handed to Stage 4 |
| Close `H-1` | Product-wide, Architecture Owner's, needs an ADR amending BC Map §7 — and, per `A-02`, is not on `PRD-023`'s path |

---

## 11. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-19 | Stage 3 Architecture Alignment record created. All six lifecycle checks executed against named authorities with measured evidence. Three-bucket ownership split performed: **10 owned / 13 ceded / 6 edges**, closing with no capability in two buckets. `CNF-GAP-001`, `CNF-GAP-004` and `CNF-GAP-006` disposed of with repository evidence — all three raised as open conflicts rather than resolved, per `DOCUMENTATION_BASELINE.md` §4. Edge inventory verified: **zero edges added**. `CNF-EVT-*` confirmed empty (0 hits in BC Map §9). Orphan-port finding **reclassified** as manifest-wide (8 of 20 modules blockless). The reviewer's entering hypothesis that `CNF-FR-061` inherits `H-1` was **measured and withdrawn** — `BC-25` is FOUNDATIONAL band, not capability band. Two draft claims corrected (`A-05`, `A-07`). 8 findings accepted with evidence, severity, owner and disposition; **11 candidate findings recorded as rejected with reasons**. Verdict **PASS**, unconditional |

---

*End of Stage 3 Architecture Alignment Record.*
