# ADR-0062 — `platform/security`'s outbound reach is NOT declared as ports; four upward `port` edges are refused

| Field | Value |
|---|---|
| **Status** | `Accepted` |
| **Date** | 2026-08-21 |
| **Deciders** | **Architecture Review Board**, acting through the **Architecture Owner** role defined in [`PRD_OWNERSHIP_MODEL.md`](../prd-ecosystem/PRD_OWNERSHIP_MODEL.md) §2.2 and §2.3 — *"Boundaries, ranks, **permitted edges**, precedence… every §11 exception"*. Exercised by **direct conferral of the human principal of this engagement**, §7 |
| **Supersedes** | Nothing |
| **Amends** | **Nothing.** `tool/module_dependencies.yaml` is **byte-unchanged** — no block added, no port declared, no rank moved, no exception created. No BC Map cell, no matrix row, no PRD |
| **Amended by** | — |
| **Baseline** | **No baseline re-issue.** No document changes version (§7 rule 4) |
| **Closes** | `SECP-ADR-004` · `SECP-DEP-003` · `SECP-GAP-042` · the `SECP-GAP-042` half of blocker **`B7-4`** |
| **Does NOT close** | The eight `IMPL-*` tasks blocked on an implementable dependency route remain **blocked pending code**, §5.2. This ADR decides what may lawfully be declared; **it declares nothing and verifies no code** |
| **Opens** | `SECP-GAP-046` (§6.2) · `SECP-GAP-047` (§6.3) |
| **Related** | `ADR-0011` (a rank moved rather than an exception granted) · `ADR-0012` · `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` **L49**, **L54**, **L85**, **L94** · BC Map `E-20` **L329** |

---

## 1. The question

`SECP-ADR-004`, verbatim:

> *"**Declare `platform/security`'s outbound dependencies.** L21 denies by default and the module has no block.
> Parts 3–7 assume four outbound reaches. Adding them changes the enforced dependency graph."*

And `SECP-DEP-003`: *"Declare `platform/security`'s outbound ports in `tool/module_dependencies.yaml`."*

**The requested act is refused, and the refusal is the decision.** Performing it as asked would create four
violations of a Rank 4 law in order to unblock a gate.

---

## 2. What was measured

### 2.1 The L2 test — the decisive measurement

`platform/security` is **rank 2**. The four reaches Parts 3–7 assume were each tested against
`LIBOORA_MODULE_DEPENDENCY_MATRIX.md` **L49**: *"**L2 — Downward only** | A module may depend only on modules of
**strictly lower rank**."*

| Assumed reach | Target rank | Direction from rank 2 | Verdict if declared as a `port` |
|---|---|---|---|
| `platform/identity` | **4** | **upward** | ⛔ **L2 violation** |
| `platform/audit` | **5** | **upward** | ⛔ **L2 violation** |
| `platform/communication` | **5** | **upward** | ⛔ **L2 violation** |
| `platform/configuration` | **3** | **upward** | ⛔ **L2 violation** |

**All four. Not one is lawful as a declared port.** Reproduced by parsing the manifest's own `ranks:` map, not read
from prose.

### 2.2 How the repository treats an L2 problem

| Measurement | Source | Result |
|---|---|---|
| Whether L2 admits exceptions | Matrix **L54** | *"**L1 is absolute. L2–L5 admit exceptions only through the ADR process in §11**"* |
| How many L2 exceptions exist | Matrix **L85** | *"Two exceptions to L2, both declared and bounded"* |
| What the nearest precedent chose | Matrix **L94**, `ADR-0011` | It moved the identity **to a lower rank** *"so `L2` is satisfied **literally** and no exception is created. `L1`…`L5` therefore remain exception-free"* |
| The default | Manifest **L21** | `default_decision: deny` — *"anything not listed is forbidden"* |

⭐ **The precedent is not "grant an exception." It is "restructure so no exception is needed."**

### 2.3 The framing of `SECP-GAP-042` was falsified

`SECP-GAP-042` presents the missing block as an anomaly. It is not.

| Measurement | Result |
|---|---|
| Modules in the `ranks:` map | **22** |
| Modules with their own dependency block | **14** |
| Modules **without** one | **8** — `platform/infrastructure` (1), `platform/data` (2), **`platform/security` (2)**, `platform/configuration` (3), `platform/observability` (3), `platform/services` (3), `platform/event` (3), `platform/integration` (5) |
| Modules at **ranks 1–3** | **7** |
| …of which have a block | **0 of 7** |

⭐ **Every module at rank 1–3 lacks a block. `platform/security` is not an anomaly — it is the pattern**, and
`platform/data`, its rank-2 twin, is in exactly the same position. A low-rank provider platform has little to declare
*outbound* precisely because almost nothing sits below it.

### 2.4 ⚠ An instrument defect in this pass, disclosed

The first script written to produce §2.3 looked for a nested `modules:` key. **There is none** — module blocks are
**top-level** keys in this manifest. It returned *"22 without a block, 0 with"*, which is absurd on its face, and an
earlier working note in this chain had recorded **7** without a block. Neither figure was published. The corrected
parse — *"a top-level mapping carrying its own `rank` key"* — returns **14 with / 8 without**, and **8 is the figure
this ADR publishes.** The earlier 7 was wrong and is named here rather than quietly replaced; the correction
**strengthens** the finding rather than weakening it. This is the same defect class this register has recorded
repeatedly: a measuring instrument wrong before the thing it measured.

### 2.5 The lawful mechanisms that need no outbound port

| Reach | Lawful route already in the repository | Evidence |
|---|---|---|
| **audit** | **Events.** No dependency block required at all | BC Map **L329**: `E-20 \| All contexts \| BC-24 Audit Trail \| PL \| Event (fire-and-forget, outbox-backed)`; `platform/audit`'s own assertion **AU-3**: *"recording occurs in the emitter's transaction"* |
| **identity** (policy decision) | **A rank-0 interface in `contracts`.** `platform/identity` already demonstrates it for its own apparent upward reach | `platform/identity`'s inline comment: *"Declared as a **PORT, never an import**: the interface is **rank 0** and the implementation is rank 7.5, so **this platform never points upward**"* |
| **configuration** | Same rank-0 contracts pattern, or inbound injection | Manifest MODES header L13–17: `port` = *"interface declared by consumer, implemented elsewhere, DI-wired (NO import)"* |
| **communication** | **Events**, per the same `E-20`-class transport | Manifest MODES: `event` = *"async only, via the event platform, payload from contracts (NO import)"* |

### 2.6 There is no code to constrain

| Probe | Result |
|---|---|
| `ls -d lib/platform/*` | `analytics, audit, business, data, event, identity, observability, services, tenancy` — **no `security`** |
| `find lib packages -type d -name security` | **empty** |
| `platform/identity`'s `provides_ports:` consumers of `policy_decision` | `domain/library`, `domain/social`, `platform/ai`, `platform/analytics`, `platform/workflow` — **`platform/security` is NOT among them** |
| Existing `platform/security:*` manifest occurrences | `crypto` (L107/181/239), `secrets` and `pii_redaction` (L278/279) — all **other modules consuming security's PROVIDED ports**, never security's outbound reach |

**`platform/security` exists as a rank and as a set of provided ports. It has no directory and no source file.**
Declaring four outbound dependencies for a module with no code would constrain nothing and pre-commit the design.

---

## 3. What was considered and refused

| Option | Why refused |
|---|---|
| **Do what `SECP-ADR-004` literally asks: add a `platform/security` block with four outbound `ports`** | ⛔ **Refused. This is the central refusal.** §2.1 — all four targets are **higher-ranked**, so all four would be **L2 violations**. Matrix L94 records that `L1`…`L5` are **exception-free** today; this act would end that with four breaches at once, in a rank-2 security platform, to unblock a Stage 7 gate. **That is precisely "changing the rules to make the gate pass."** |
| **Grant four §11 L2 exceptions** | ⛔ Refused. L54 permits exceptions through §11 and the Architecture Owner is the role that grants them — so this was available. Refused because `ADR-0011` **chose the opposite** for the structurally identical problem: it *"moved the identity to a lower rank… so `L2` is satisfied **literally** and no exception is created."* Quadrupling the exception count (2 → 6) when a no-exception route exists inverts the repository's own precedent |
| **Move `platform/security` to a higher rank so the reaches become downward** | ⛔ Refused. It is the `ADR-0011` move in form, but it would place the **security** platform above identity, configuration, audit and communication — meaning every one of them could then depend on security while security could no longer provide `crypto` downward to `platform/data` (rank 2) or `contracts`. It fixes four edges by breaking the three that already work and are consumed at five sites |
| **Declare the reaches as `import`** | ⛔ Refused, strictly worse. `import` is compile-time and upward-pointing imports are what `banned_imports` exists to stop |
| **Add the block with only `provides_ports`, no outbound** | ⚠ Considered seriously, and **still refused — as unnecessary rather than unlawful.** The three provided ports already function: they are consumed at five sites and enforced by `default_decision: deny` at the *consumer* end. A block asserting only what already works would be a cosmetic edit to a Rank 4-governed instrument, and §2.3 shows **0 of 7** rank 1–3 modules have one. Recorded as **`SECP-GAP-046`** for whoever writes the code |
| **Weaken `default_decision: deny` or the L2 checker** | ⛔ Refused absolutely. `ADR-0012` keeps `check_module_boundaries.dart` failing on 9 real violations by design. *"A gate that cannot fail is not a gate"* |
| **Leave `SECP-GAP-042` open and defer** | ⛔ Refused. The question *"may these four be declared as ports?"* has a **measurable answer — no** — and deferring a measurable answer would leave every future reader to re-derive it |

---

## 4. Decision

**1. The four outbound reaches are NOT declared as ports. The request is refused on measurement.** All four targets
(`platform/identity` 4, `platform/audit` 5, `platform/communication` 5, `platform/configuration` 3) rank **above**
`platform/security` (2). Declaring them as `port` dependencies would create **four L2 violations** of a Rank 4 law
that `ADR-0011`/Matrix L94 record as currently **exception-free**.

**2. `tool/module_dependencies.yaml` is not amended. No block is added.** The absence of a block is **not** the
defect `SECP-GAP-042` took it for: **0 of the 7 modules at ranks 1–3 have one** (§2.3). `platform/security` is
conforming to the pattern, not deviating from it.

**3. The reaches are re-expressed lawfully, using mechanisms that already exist** (§2.5). This is a determination of
what is *permitted*, not a declaration:

| Reach | Lawful route | Requires a manifest edit? |
|---|---|---|
| Audit recording | **Event**, via `E-20` (fire-and-forget, outbox-backed), recorded in the emitter's transaction | **No** |
| Policy decision from `BC-18` | **Port whose interface lives in `contracts` (rank 0)** — the pattern `platform/identity` already uses and documents | **No** — rank 0 is below rank 2, so L2 holds **literally** |
| Configuration values | Same rank-0 contracts interface, or inbound DI | **No** |
| Communication / notification | **Event**, per the manifest's `event` mode | **No** |

**Every one of the four is achievable with `L2` satisfied literally and no exception created** — which is exactly
what `ADR-0011` did and what Matrix L94 records as the house style.

**4. `SECP-GAP-042` is closed**, and its framing is corrected: the finding was *"the module lacks a block"*; the
measured answer is *"no rank 1–3 module has one, all four assumed reaches would be unlawful as ports, and all four
have lawful alternatives that need no block."*

### 4.1 What this rests on

| Ground | Source | Rank |
|---|---|---|
| L2 — downward only, strictly lower rank | Matrix **L49** | **4** |
| L1 absolute; L2–L5 exceptions only via §11 | Matrix **L54** | **4** |
| Two L2 exceptions exist, both bounded | Matrix **L85** | **4** |
| The house response to an L2 problem is to restructure, not to except | Matrix **L94**, `ADR-0011` | **4** / **2** |
| Audit is reached by event, not dependency | BC Map **L329** `E-20`; `platform/audit` AU-3 | **4** |
| A rank-0 interface lets a low platform consume a high implementation lawfully | `platform/identity`'s own manifest block and comment | **4** |
| Anything unlisted is forbidden | Manifest **L21** | **4** |
| Permitted edges are the Architecture Owner's to decide | `PRD_OWNERSHIP_MODEL.md` §2.2 | derived |

### 4.2 What it does not rest on

- **Not** on the absence of a block being permissible *because* no precedent requires one — the argument runs the
  other way: **7 of 7** low-rank modules measured show the pattern positively. `ADR-0050` §5's warning against
  absence-as-rule is respected.
- **Not** on `lib/platform/security/` being absent. That makes the declaration **premature**, not unlawful; the L2
  measurement is what makes it unlawful, and it would hold identically if the code existed.

---

## 5. What this ADR does not do

### 5.1 It declares nothing

`tool/module_dependencies.yaml` is **byte-unchanged**: **0 blocks added, 0 ports declared, 0 events registered,
0 ranks moved, 0 exceptions created, 0 `banned_imports` altered.** It states which declarations would be lawful. The
declaration itself belongs to the commit that introduces the code, so the manifest and the module land together.

### 5.2 It does not unblock the eight blocked tasks

`PRD-012a_IMPLEMENTATION_TASKS.md` §4.2 lists eight tasks blocked on a dependency route. Their **architectural**
question is now answered — the route exists and is named per reach. They remain **blocked pending code**, exactly as
`ADR-0059`'s precedent distinguishes: *"'Resolved' is not 'discharged'."*

### 5.3 It verifies no code

**0 lines** under `lib/`, `packages/`, `test/`, `web/`, `tool/`. `check_module_boundaries.dart` is unmodified and its
output is unchanged — still **EXIT=1 / 9 violations, by design** under `ADR-0012`. **No new violation is introduced,
and that is the point: declaring the four ports would have introduced four.**

### 5.4 It does not freeze `PRD-012a`

Stage 7 is a Governance Owner act needing its own ADR and a baseline §3 row.

---

## 6. Findings

### 6.1 Accepted

| # | Finding | Disposition |
|---|---|---|
| `A-1` | All four assumed outbound reaches are **upward** and unlawful as ports | **Accepted.** §4 finding 1 — the basis of the refusal |
| `A-2` | `SECP-GAP-042`'s "anomalous missing block" framing is **false**; 0 of 7 rank 1–3 modules have a block | **Accepted and published.** §2.3 |
| `A-3` | All four reaches have lawful, already-existing alternatives requiring no manifest edit | **Accepted.** §4 finding 3 |
| `A-4` | `lib/platform/security/` does not exist | **Accepted** as making the declaration premature, not as the reason it is refused |
| `A-5` | This pass's own first measuring script was wrong, and an earlier working figure of 7 was wrong | **Disclosed**, §2.4. The published figure is **8**, from the corrected parse |

### 6.2 `SECP-GAP-046` — opened

> **`SECP-GAP-046`** — `platform/security` has no dependency block, and when its code is written one will be needed
> to declare `crypto`, `secrets` and `pii_redaction` as `provides_ports` and to record the event/contracts routes
> §4 finding 3 permits. **Owner: Architecture Owner**, in the commit that introduces `lib/platform/security/`.
> **Priority: P2** — nothing is unenforced today, because the three provided ports are policed at the consumer end
> by `default_decision: deny`.

### 6.3 `SECP-GAP-047` — opened

> **`SECP-GAP-047`** — **7 of the 7 modules at ranks 1–3 have no dependency block**, so the manifest constrains the
> platform's lowest and most security-sensitive layers less than its upper ones. This is a structural observation
> about the manifest, well beyond `PRD-012a`, and it is **recorded rather than acted on**. **Owner: Architecture
> Owner.** **Priority: P3** — no known violation results; `default_decision: deny` still governs every consumer.

---

## 7. Authority

A **direct, explicit conferral by the human principal of this engagement**, instructing that `SECP-ADR-001`, `002`
and `004` be resolved *"through the **Architecture Owner's authority**"*, and — decisively for this ADR — that the
resolution must **never change repository rules or requirements to make a gate pass**.

**That instruction is the authority, and it is the only authority claimed** (`ADR-0033` §7.2 form). **Not a standing
grant** (§7.1): it authorises the determination in §4, not a manifest amendment, not a rank change, and not a §11
exception — all three of which the Architecture Owner role *could* otherwise reach.

### 7.1 What is not claimed

- **No ARB meeting**, quorum, attendee list or sign-off date.
- **No Security review**, no Principal Enterprise Architect approval, no product-owner signature.
- **No port, block, event, exception or rank declared or moved.**
- **No code verified**, and **no freeze conferred.**

---

## 8. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-21 | Created `Accepted`. Resolves `SECP-ADR-004` / `SECP-DEP-003` / `SECP-GAP-042` **by refusing the act they request.** ⭐ **The four outbound `port` declarations are REFUSED on measurement:** `platform/security` is **rank 2**, and `platform/identity` (4), `platform/audit` (5), `platform/communication` (5) and `platform/configuration` (3) all rank **above** it — so all four would be **L2 violations** of Matrix **L49** (*"downward only… strictly lower rank"*), in a law that Matrix **L85**/**L94** record as **exception-free** because `ADR-0011` chose to move a rank rather than grant an exception. Declaring them would have created four Rank 4 violations to unblock a Stage 7 gate. ⚠ **`SECP-GAP-042`'s framing is FALSIFIED and corrected:** the missing block is not an anomaly — **8 of 22** modules lack one and **0 of the 7 modules at ranks 1–3 have one**, including `platform/data`, security's rank-2 twin. `platform/security` follows the pattern rather than deviating from it. ⚠ **All four reaches are re-expressed lawfully with no manifest edit at all**: audit and communication by **event** (BC Map **L329** `E-20`, fire-and-forget/outbox-backed, recorded in the emitter's transaction per `AU-3`), identity and configuration by a **rank-0 `contracts` interface** — the exact pattern `platform/identity` already documents for its own apparent upward reach (*"the interface is rank 0 and the implementation is rank 7.5, so this platform never points upward"*). **L2 is satisfied literally and no exception is created**, which is the `ADR-0011` house style. ⚠ **Three tempting alternatives refused:** four §11 L2 exceptions (would take the count 2 → 6 when a no-exception route exists), moving `platform/security` up a rank (fixes four edges by breaking the three `crypto`/`secrets`/`pii_redaction` ports that already work at five consumption sites), and weakening `default_decision: deny` or the L2 checker. ⚠ **`lib/platform/security/` does not exist** — disclosed as making the declaration *premature*, and expressly **not** used as the reason for refusal; the L2 measurement would hold identically if the code existed. ⚠ **An instrument defect in this pass is disclosed (§2.4)**: the first script searched for a nested `modules:` key that this manifest does not use and returned an absurd 0-with-a-block; an earlier working figure of **7** was also wrong. **Neither was published; the corrected parse returns 14 with / 8 without**, and the correction *strengthens* the finding. **Amends nothing: `tool/module_dependencies.yaml` byte-unchanged — 0 blocks, 0 ports, 0 events, 0 ranks moved, 0 exceptions, 0 `banned_imports` touched; 0 BC Map cells, 0 matrix rows, 0 PRDs, no baseline re-issue, 0 lines of code.** `check_module_boundaries.dart` unmodified, output unchanged at its by-design **EXIT=1 / 9 violations** — **0 new violations, which is the whole point.** **Opens `SECP-GAP-046`** (the block owed when the code is written) and **`SECP-GAP-047`** (7 of 7 low-rank modules unblocked — recorded, not acted on). ⛔ **The eight blocked `IMPL-*` tasks are answered architecturally but remain BLOCKED pending code** — *"resolved is not discharged"*. **Confers no freeze** |
