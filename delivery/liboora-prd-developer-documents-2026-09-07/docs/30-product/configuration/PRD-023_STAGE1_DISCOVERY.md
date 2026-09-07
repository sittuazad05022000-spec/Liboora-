# PRD-023 Settings & Configuration — Stage 1 Discovery Record

| Field | Value |
|---|---|
| **Document** | `PRD-023_STAGE1_DISCOVERY.md` |
| **Subject PRD** | `PRD-023` Settings & Configuration |
| **Bounded context** | **`BC-25` Configuration** |
| **Lifecycle stage** | **Stage 1 — Discovery** |
| **Registry status sought** | `DISCOVERY` |
| **Version** | v1.0 |
| **Date** | 2026-08-20 |
| **Gate under test** | `PRD_LIFECYCLE.md` L72 — *"a context identified in the Bounded Context Map, **not already owned** in `PRD_REGISTRY.md` §6"* |
| **Governing authority** | [`ADR-0017`](../../00-governance/adr/ADR-0017-bc-25-configuration-ownership.md) — **ACCEPTED** 2026-08-04 |
| **Verdict** | **PASS** — see §10 |
| **Authority of this record** | None. This is a stage record, not a specification. It confers no requirement, no ownership, no rank and no status. |

> `PRD_LIFECYCLE.md` L41–42: *"Each transition has a **gate**: a named artefact that must exist. A gate is not an
> opinion — if the artefact does not exist, the stage has not been passed, however complete the work feels."*
> This document exists so that Stage 1 has been **passed** rather than merely felt complete.

> **A note on what makes `PRD-023` unlike its four predecessors.** `PRD-013`, `PRD-016` and `PRD-014` each entered
> Stage 1 as a **candidate**: a context that appeared to warrant a PRD, where Stage 1's job was to decide whether it
> did. `PRD-023` enters Stage 1 **already registered**. `ADR-0017` is `ACCEPTED` at Rank 2, it names `PRD-023` as
> `BC-25`'s owner, and `PRD_REGISTRY.md` §4.3 L327 and §6 L448 both carry the row. Stage 1's job here is therefore
> **not** to decide whether the PRD should exist — that is decided — but to discover, against evidence, **what the
> repository already says `BC-25` is**, so that Stage 2 writes requirements the repository can accept. Where this
> record finds the repository contradicting itself, it **reports the contradiction and does not resolve it**.

---

## 1. The four Stage 1 questions, answered against authority

`PRD_LIFECYCLE.md` L64–70 poses four questions and states what makes each one fail. Each is answered below with
the document, line and verbatim text that decides it. No answer rests on judgement alone.

| # | Question | Fails if | Answer | Deciding authority |
|---|---|---|---|---|
| 1 | Does a bounded context own this? | It is a presentation composition — dashboards, Parent Portal. **No PRD** | **Yes.** `BC-25` Configuration is a registered bounded context | BC Map **L134**: `| **BC-25** | **Configuration** | [GENERIC] | Configuration | V1 | Owns settings hierarchy, feature flags, branding values, secret *references*. |` |
| 2 | Does another PRD already own the context? | It is an amendment to that PRD, not a new one | **No.** `BC-25` → `PRD-023`, **Contested = No** | `PRD_REGISTRY.md` **§6 L448**: `| BC-25 | **PRD-023** | **No** — resolved 2026-08-04 by ADR-0013 + ADR-0017 |` |
| 3 | Is it V1/V2/V3, or Future? | Future ⇒ **stop** | **V1.** Three independent statements at three ranks agree | `MASTER_PRD.md` **§8 L170** (Rank 1): `| 18 | Settings & Configuration | BC-25 Configuration | [GENERIC] | V1 |`; BC Map **L134** (Rank 4, `V` column = `V1`); `ADR-0017` **§3** (Rank 2, `Scope | V1`) |
| 4 | Does it own an aggregate **and** an invariant? | Owning neither ⇒ **it is a capability of an existing context** | **Passes — but not by the route its three predecessors took.** See §1.2 | BC Map **L271**; `Library_PRD_v1.md` **L188**; `CONFIGURATION_GUIDE.md` §3 |

Questions 1, 2 and 3 pass without qualification. **Question 4 requires the argument in §1.2**, and it is the one
question this record does *not* dispose of cleanly — it produces the highest-severity finding in §7 (`F-01`).

### 1.1 The scope grant, verbatim

`ADR-0017` §3.1 and §3.2 are the two passages that bound everything `PRD-023` may own. They are transcribed here
in full, because Stage 2 is entitled to nothing outside them and Stage 4 will audit against them.

**`ADR-0017` §3.1 — *"What `PRD-023` will own when written"*, preceded by the sentence that gives it force:**

```
Scope is fixed now so the registration is not an open-ended reservation:

1. The settings hierarchy and its precedence order — platform default → tenant → library → branch → user.
2. Feature flags — definition, evaluation, rollout, and the boundary against BC-21 Entitlement (a flag says
   is this on; an entitlement says is this paid for).
3. Branding values — the values only. The images remain FileRefs issued by BC-29, and LibraryBranding
   as an aggregate stays with PRD-002 per ADR-0013 §5.
4. Secret references — references only. Never secret material; that is SECURITY.
5. The E-19 typed-accessor contract — the mechanism enforcing no raw string lookups in domain code.
6. The LCFG-* resolution semantics — how a configurable's effective value is determined. The LCFG-1…LCFG-13
   definitions stay in the Library PRD; PRD-023 owns the resolution machinery, not the value list.
```

**`ADR-0017` §3.2 — *"What `PRD-023` explicitly does **not** own"*:**

```
- No LIB-*, LCFG-*, SID-*, SCFG-* or ICFG-* requirement moves into it. This ADR moves no requirement.
- Not secret material (SECURITY), not entitlement decisions (BC-21), not tenancy structure (BC-19, PRD-013),
  not file bytes (BC-29, PRD-017).
```

Parsed into the six things Stage 2 may specify and the boundary each carries:

| # | Owned | The boundary that comes with it | Counterparty owner |
|---|---|---|---|
| 1 | The **settings hierarchy** and its precedence order | Five scopes, fixed: platform default → tenant → library → branch → user. Not four, not six | — |
| 2 | **Feature flags** — definition, evaluation, rollout | *"a flag says **is this on**; an entitlement says **is this paid for**"* | `BC-21` / `PRD-014` **FROZEN** |
| 3 | Branding **values** | The *images* are `FileRef`s; the `LibraryBranding` **aggregate** is `PRD-002`'s | `BC-29` / `PRD-017`; `PRD-002` **FROZEN** |
| 4 | Secret **references** | *"Never secret material"* | `SECURITY` platform |
| 5 | The **`E-19` typed-accessor contract** | The mechanism only — *"no raw string lookups in domain code"* | binds **all contexts** |
| 6 | The **`LCFG-*` resolution semantics** | *"the resolution machinery, **not the value list**"* | `PRD-002` **FROZEN** holds the definitions |

**Item 6 is the sharpest constraint in the grant, and the easiest to breach without noticing.** `PRD-023` owns
*how* an effective value is determined; it owns **no value, no default and no range** belonging to another
register. §5 enumerates what that withholds, and `F-14`/`R-03`/`R-04` in §7 record the three specific ways a
drafter would be tempted to breach it.

### 1.2 Question 4 — the aggregate-and-invariant test, answered honestly

Its three predecessors answered question 4 by pointing at one row of BC Map §8. **`PRD-023` cannot do that,
because `BC-25` has no row in BC Map §8.** Measured: §8 carries **17 aggregate rows**, for `BC-01`, `BC-02`,
`BC-03`, `BC-04`, `BC-05`, `BC-06`, `BC-10`, `BC-11`, `BC-12`, `BC-13`, `BC-18`, `BC-19`, `BC-20`, `BC-21`,
`BC-24`, `BC-26` and `BC-27`. `BC-25` is **absent** (M-10).

Question 4 nevertheless passes, on three independent grounds. They are given in order of strength.

**Ground 1 — the question's stated failure mode does not obtain.** The gate does not say *"fails if it owns no
aggregate"*. It says: *"Owning neither ⇒ **it is a capability of an existing context**."* The failure being
guarded against is a PRD written for something that is really a slice of another context. `BC-25` is the
opposite case. BC Map **L271**:

```
║  FOUNDATIONAL  ·  BC-18 Identity & Access   ·   BC-19 Tenancy   ·   BC-25 Configuration   ║
║  Every context depends on these three. They depend on nothing above them.                 ║
```

A context that **every** other context depends on, and that depends on nothing above it, is not a capability of
an existing context. It is one of the three the others are capabilities *of*. `PRD-014`'s Stage 1 §7.1 `R-10`
already established this band as decisive in the other direction — it **rejected** the claim that `BC-21` is
foundational precisely by citing L271's closed list of three, of which `BC-25` is one.

**Ground 2 — a Rank 3 frozen document names an aggregate for `BC-25`.** `Library_PRD_v1.md` **L188** (FROZEN
v1.1), inside its aggregate-ownership table:

```
| **`LibrarySettings`** | `BC-25` | Settings hierarchy and feature flags |
```

That is an explicit aggregate grant to `BC-25`, at Rank 3, in a frozen document, and its description is
word-for-word the first two items of `ADR-0017` §3.1. **It is also the only occurrence of the string
`LibrarySettings` in the entire repository** (M-05) — which is why it becomes `F-01` rather than a settled
answer.

**Ground 3 — an invariant surface exists and is already specified.** `CONFIGURATION_GUIDE.md` §3 publishes
sixteen cross-parameter invariants `INV-1`…`INV-16` and states the enforcement rule:

> *"These must be **validated at application startup**. A violation is a fatal configuration error — fail fast
> and loudly. A silently inconsistent security configuration is worse than a wrong one, because nobody
> notices."* … *"Startup validation must report **all** violations, not just the first."*

Seven of the sixteen (`INV-10`…`INV-16`) each relate a configurable in one register to a configurable in
another — e.g. `INV-10`: `LCFG-11 ≤ CFG-6`. **No single owning PRD can enforce a cross-register invariant**,
because neither register's owner sees both values. The enforcement point is the resolution machinery, and
`ADR-0017` §3.1 item 6 assigns the resolution machinery to `PRD-023`. The *definitions* stay where they are;
the *enforcement obligation* has exactly one possible home.

**What Stage 1 therefore concludes, and what it refuses to conclude.**

| Concluded | Refused |
|---|---|
| Question 4 does not fail, on any of the three grounds above | That `LibrarySettings` **is** the name of `PRD-023`'s aggregate |
| `BC-25` has an invariant surface, and it is the enforcement of `INV-1`…`INV-16` | That `BC-25` owns a **domain** aggregate in BC Map §8's sense |
| A Rank 3 frozen document grants `BC-25` an aggregate | That BC Map §8's omission of `BC-25` is a defect |

The last three are **architecture judgements**. `PRD_LIFECYCLE.md` §6 assigns Stage 3 to the **architecture
reviewer**, and Stage 1 does not make Stage 3's decisions. They are carried as `F-01`, with a named owner and an
explicit disposition to Stage 3.

---

## 2. Mechanical ordering — what was measured before anything was concluded

Every claim in this record was produced by a command, not by an impression. The commands and their results are
recorded so that a reviewer can re-run them and get the same answer.

| # | Measurement | Command shape | Result |
|---|---|---|---|
| M-01 | `CNF-` prefix collisions, anchored | `grep -rhoE '\bCNF-[A-Z0-9-]+' docs/ tool/ lib/ packages/ test/ \| sort -u \| wc -l` | **0** |
| M-02 | `CNF-` reverse-direction hazard | `grep -rhoE '.CNF-[A-Z]' docs/ tool/` | **empty** — no token ends in a character that would absorb `CNF-` |
| M-03 | `SET-` — the rejected alternative, anchored | `grep -rhoE '\bSET-[A-Z0-9]+' docs/ tool/ \| sort -u \| wc -l` | **0** — free, but rejected on other grounds (`R-02`) |
| M-04 | `CONF-` — the occupied alternative | `grep -rhoE '\bCONF-[0-9]+' docs/ \| sort -u` | **`CONF-1`, `CONF-2`, `CONF-3`** ⇒ **occupied**, `CONF-` unusable |
| M-05 | `LibrarySettings` occurrences repo-wide | `grep -rn 'LibrarySettings' docs/ lib/ packages/ tool/` | **exactly 1** — `Library_PRD_v1.md:188` |
| M-06 | `BC-25` dependency pressure | `grep -rl 'BC-25' docs/ tool/ packages/ lib/ \| wc -l` | **74 files** |
| M-07 | `BC-25` in code | `grep -rl 'BC-25' tool/ packages/ lib/ \| wc -l` | **0** |
| M-08 | The `settings` port — consumers | `grep -n 'platform/configuration:settings' tool/module_dependencies.yaml` | **7** — L108, L182, L240, L280, L309, L336, L513 |
| M-09 | The `settings` port — providers | `grep -n 'provides_ports' -A6 tool/module_dependencies.yaml \| grep -c 'settings'` | **0** ⇒ **orphan port** |
| M-10 | `BC-25` in BC Map §8 | §8 read in full; aggregate rows enumerated | **17 rows; `BC-25` absent** |
| M-11 | `BC-25` in BC Map §9 | §9 producer column enumerated | **14 producers; `BC-25` absent.** `grep -cE 'configuration\.\|config\.\|settings\.\|flag\.'` = **0** event names |
| M-12 | Configuration code surface | `find lib packages -iname '*config*' -o -iname '*setting*'` | **0 files.** `lib/platform/` has 9 dirs, no `configuration/` |
| M-13 | `PRD-023` references already in the repository | `grep -rl 'PRD-023' docs/ tool/ lib/ packages/ test/ \| wc -l`; `grep -c` in registry | **27 files**; **19** occurrences in `PRD_REGISTRY.md` alone |
| M-14 | Architecture tests present | `ls test/architecture/ \| wc -l` | **1** — `boundary_checker_test.dart`, which appears **nowhere** in Matrix §10.3's list of seven |
| M-15 | Parameters governed at Rank 7 | `grep -cE '^\| `(CFG\|LCFG\|ICFG)-[0-9]+`' CONFIGURATION_GUIDE.md` | **63 table rows** across §2/§2A/§2B, covering **35 distinct parameters** |
| M-16 | Configurable definitions repo-wide, **word-anchored** | per-register `grep -rhoE "(^\|[^A-Z-])${p}-[0-9]+"` then de-suffixed and `sort -u` | **104** across **8** owning PRDs — see §4.6 |
| M-17 | Feature-flag references | `grep -rn 'feature flag' docs/ -i \| wc -l` | **27** |
| M-18 | Secret-reference references | `grep -rni 'secret reference' docs/ \| wc -l` | **7** |
| M-19 | `LibraryBranding` references | `grep -rn 'LibraryBranding' docs/ \| wc -l` | **13** |
| M-20 | ADRs touching `BC-25` | `grep -rlE 'BC-25\|configuration ownership' docs/00-governance/adr/ \| wc -l` | **10 of 52** |
| M-21 | The `E-19` constraint's footprint | `grep -rni 'typed config\|typed accessor\|raw string lookup' docs/ \| wc -l` | **35** |
| M-22 | Next free `IMPL-*` block | `grep -rhoE 'IMPL-[0-9]+' docs/ tool/ \| sed 's/IMPL-//' \| sort -n -u \| tail -6` | `…1027, 1028, 1029, 1030, 1099, 1100`. **`1030`–`1099` is `PRD-014`'s declared reserve**; **`1100`+ unallocated** |
| M-23 | Working tree containment | `git status --porcelain`; `git status --short lib/ packages/ test/ tool/` | **0** / **0 lines** at the start of Stage 1 |

**Ordering was observed, not asserted.** M-01 through M-04 ran **before any identifier prefix was chosen**, per
`PRD_LIFECYCLE.md` L82 rule 2 — *"Prefixes are chosen against §5's collision procedure **before** writing."*
M-22 ran **before any `IMPL-*` number was contemplated**, per L139 — *"Take the next free range. **Never reuse or
reassign a number.**"* M-23 ran before the directory `docs/30-product/configuration/` was created.

**Two of these measurements corrected earlier working figures**, and the corrections are disclosed rather than
quietly absorbed:

| Earlier working figure | Measured | Why the first number was wrong |
|---|---|---|
| `BC-25` pressure *"~46 files"* | **74** (M-06) | The first count was taken over `docs/` alone and by an eyeball of concentrations, not by `grep -rl` over all four trees |
| Next free block *"`IMPL-1030`"* | **`IMPL-1100`** (M-22) | `IMPL-1030` **occurs** as the lower bound of `PRD-014`'s growth reserve (`PRD-014_IMPLEMENTATION_TASKS.md:123`, ratified `ADR-0052:279`). **Occurrence is not occupancy — but a declared reserve is.** Taking it would have been the reassignment allocation rule 1 forbids |

---

## 3. The ownership check in full

`PRD_LIFECYCLE.md` L72 states the Stage 1 gate as a conjunction with two halves. Both are tested.

### 3.1 Half one — the context is in the Bounded Context Map

BC Map **L134**, verbatim:

```
| **BC-25** | **Configuration** | `[GENERIC]` | Configuration | V1 | Owns settings hierarchy, feature flags,
branding values, secret *references*. |
```

Parsed against the table's own column headers:

| Column | Value | Consequence for `PRD-023` |
|---|---|---|
| `BC` | **`BC-25`** | The context exists and is numbered |
| Name | **Configuration** | The ubiquitous term is *Configuration*, not *Settings*. §4.1 takes this up |
| Classification | `[GENERIC]` | Matches `ADR-0017` §3 exactly. A generic subdomain — bought or built once, not a differentiator |
| Owning platform | **Configuration** | Corroborated by `tool/module_dependencies.yaml` L31 `platform/configuration: 3` |
| `V` | **V1** | Question 3 passes |
| Owns | settings hierarchy · feature flags · branding **values** · secret **references** | **Four things.** The italicisation of *references* is the source's own emphasis and is load-bearing |

**Half one passes.** Note that this single line is the origin of `ADR-0017` §3.1's four substantive items —
items 5 and 6 come from `E-19` (L328) and from the `LCFG-*` register respectively. The scope grant is therefore
not an invention of the ADR; it is a transcription of Rank 4 plus two named edges.

### 3.2 Half two — no other PRD owns the context

`PRD_REGISTRY.md` **§6 L448**, verbatim:

```
| `BC-25` | **`PRD-023`** | **No** — resolved 2026-08-04 by `ADR-0013` + `ADR-0017` |
```

The column is headed **Contested?** and the value is **No**. **Half two passes.**

This half deserves more than a citation, because `BC-25` is the one context in the repository whose ownership was
*wrongly recorded as uncontested*, then *corrected to contested*, then *resolved*. The registry preserves all
three states rather than overwriting them, and the reasoning matters to Stage 2:

| Date | Recorded state | Where | Why it changed |
|---|---|---|---|
| before 2026-08-04 | *"`BC-06`, `BC-25` \| `PRD-002` \| No"* | `PRD_REGISTRY.md` §6 | **False but invisible.** `BC-25` is in neither Master §31 nor §8.1, so no *registered PRD* contested `Library_PRD_v1.md`'s header. The collision was with the **BC Map's platform column**, and a PRD-to-PRD comparison could not see it (registry v1.2 changelog) |
| 2026-08-04 | contested, count 2 → **3** | registry v1.2 | Corrected during Phase 4 validation. §6.1 retitled *"The three contested contexts"* |
| 2026-08-04 | **`PRD-023`**, contested **0** | registry v1.3, via `ADR-0013` + `ADR-0017` | `ADR-0013`: a capability context is owned by its **platform**, not by the domain consuming it. `ADR-0017`: that platform's PRD is `PRD-023` |

`PRD_REGISTRY.md` §6.1 carries the banner `ADR-0013` §6.2 required, quoted here because Stage 2 must not undo it
by accident:

> *"**`PRD-002`'s entry now lists one owned context where it listed four. This is not a scope reduction** — it is
> the same scope, correctly attributed."*

**The practical consequence for `PRD-023`.** `PRD-002` (FROZEN v1.1) still *consumes* `BC-25` and still *owns* the
`TenantOrganisation`, `StaffAssignment` and `LibraryBranding` aggregates. `PRD-023` owning `BC-25` takes
**nothing** from `PRD-002`. Any Stage 2 requirement that reads as removing something from the Library PRD is
wrong on its face.

### 3.3 The near-misses that had to be excluded

Three candidates could plausibly have been read as already owning this context. Each is excluded on evidence.

| Candidate | Why it looks like the owner | Why it is not |
|---|---|---|
| **`PRD-002` Library** | Its header listed `BC-25` until 2026-08-04; it holds `LCFG-1`…`LCFG-13`; L1093 reads `| Settings, feature flags, branding values, secret references | BC-25 | **Owns** |` | That row records **what `BC-25` owns**, not what `PRD-002` owns — it is a row *in* `PRD-002`'s table *about* `BC-25`. `ADR-0013` §5 and the v1.1 header amendment settle it: `PRD-002` owns `BC-06` and consumes `BC-25` through a port |
| **`PRD-013` Tenancy** | Settings resolve *per tenant*; `PRD-013` owns tenant scope; `ADR-0013` §7 offered folding `BC-25` into it as an admissible resolution | Rejected in `ADR-0017` §4 option C1, on a measurement: *"Settings resolve across **five** scopes, only one of which is the tenant."* Also `PRD-013` §0.2 **declares `TEN-CFG-*` empty** — it publishes no configurable at all |
| **`SECURITY` platform** | Owns secrets; `CONFIGURATION_GUIDE.md` §2A names **Security** as owner of six `LCFG-*` values | Rejected in `ADR-0017` §4 option C3: *"`BC-25` holds **references**; SECURITY holds material. Merging them would put branding colours and feature flags behind a security boundary."* The §2A *owner* column names the **risk owner of the value**, not the owner of the register |

---

## 4. What `BC-25` owns — discovered, not assumed

Everything below was found in the repository. Nothing is proposed. Where the repository is silent, this section
says so rather than filling the silence.

### 4.1 The name — *Configuration*, and why *Settings* is not a synonym

The prompt asks Stage 2 to settle *"Settings vs Configuration terminology"*. Stage 1's contribution is to record
that **the repository already uses the two words differently, at four ranks, consistently**:

| Source | Rank | Usage | What it implies |
|---|---|---|---|
| `MASTER_PRD.md` §8 L170 | 1 | *"**Settings & Configuration**"* — the module title | Both words, joined. The **product surface** is *Settings*; the **platform** is *Configuration* |
| BC Map L134 | 4 | Context **name** = *Configuration*; first owned item = *"**settings hierarchy**"* | The context is *Configuration*; *settings* is a thing inside it |
| `tool/module_dependencies.yaml` L31, L108 | tooling | module `platform/configuration`; port `platform/configuration:**settings**` | The **module** is *configuration*; the **port** is *settings* |
| `CONFIGURATION_GUIDE.md` §4 | 7 | *"`LCFG-1`…`LCFG-5` … are **per-library settings, not per-environment**. They are set by each library **through `BC-25`**"* | *Settings* = per-tenant/per-library values a customer changes. *Configuration* = the whole apparatus, including per-environment values a customer never sees |

**The distinction the repository is already drawing** — recorded as a finding for Stage 2 to make normative, not
as a decision Stage 1 makes:

- **Configuration** is the superset: every value that can change without changing the specification, plus the
  machinery that resolves it. `CONFIGURATION_GUIDE.md` §1: *"the value can change per environment or per
  deployment **without changing the specification, the architecture, or any interface**."*
- **Settings** is the customer-facing subset: values scoped to a tenant, library, branch or user, changed through
  the product rather than through a deployment.

`CONFIGURATION_GUIDE.md` §4 is the load-bearing evidence, because it **partitions an existing register along
exactly this line**: of thirteen `LCFG-*`, nine are *"per-library settings, not per-environment"* and are set
*"through `BC-25`"*, while the rest appear in the environment-profile table. One register, two kinds of value,
and Rank 7 already tells them apart.

### 4.2 The settings hierarchy — five scopes, and only two are populated today

`ADR-0017` §3.1 item 1 fixes the precedence order: `platform default → tenant → library → branch → user`.
Measured against what the repository specifies at each level:

| Scope | Specified today? | Evidence |
|---|---|---|
| **platform default** | **Yes, extensively.** All 35 Rank 7 parameters have a default with a stated anchor | `CONFIGURATION_GUIDE.md` §2, §2A, §2B — each entry gives *"recommended default + anchor"* |
| **tenant** | **Partly.** `PRD-013` owns tenant scope and `TenantContext` but **publishes no configurable** | `PRD-013` §0.2: *"`TEN-CFG-*` is **declared empty.**"* BC Map L540 `Q-01`: *"Configurable per tenant (BC-25), default 24h grace"* — an **Open** recommendation, not a decision |
| **library** | **Yes, for nine values.** The clearest specified scope after platform default | `CONFIGURATION_GUIDE.md` §4: *"`LCFG-1`…`LCFG-5` and `LCFG-7`…`LCFG-10` are **per-library settings**… set by each library **through `BC-25`**"* |
| **branch** | **Named, never specified.** `LCFG-7`, `LCFG-9` are *"per branch"* **quantities**; `BranchPolicy` is `BC-06`'s aggregate | `Library_PRD_v1.md` L722, L724; BC Map §8 `BC-06 | BranchPolicy` |
| **user** | **Not specified anywhere.** No user-scoped configurable exists in any register | M-16: all 104 are platform-, library- or module-scoped. `SID-5.45`: *"Every value above **SHALL** be platform-wide"* |

**Finding.** The hierarchy `ADR-0017` fixes has **five** levels; the repository populates **two**, names a third
without a value, has an explicitly **empty** register at a fourth, and has **nothing at all** at the fifth. This
is `F-05` — not a defect in `ADR-0017`, but the measure of how much of item 1 Stage 2 must specify from scratch
rather than describe from existing practice.

**A boundary that must not be blurred.** `BranchPolicy` is `BC-06`'s aggregate with its own invariant
(*"policy changes are versioned with `effectiveFrom` — **never retroactive**"*, BC Map §8). A *branch-scoped
setting* resolved by `BC-25` and a *branch policy* owned by `BC-06` are different things. `PRD-023` may resolve a
value **at** branch scope; it may not own `BranchPolicy`. Carried to §5 candidate 9.

### 4.3 Feature flags — the one item whose boundary a FROZEN PRD already drew

`ADR-0017` §3.1 item 2 grants *"definition, evaluation, rollout, and the boundary against `BC-21` Entitlement."*
Unusually, the boundary is **already asserted from the other side, by a FROZEN document**:

| Source | Status | Verbatim |
|---|---|---|
| `PRD-014_ENTITLEMENT.md` **L485** `ENT-XC-008` | **FROZEN** | *"The module **MUST NOT** define, evaluate or roll out a feature flag. *Owner: **`BC-25`***"* |
| `PRD-014_ENTITLEMENT.md` **L335** `ENT-BR-004` | **FROZEN** | *"A feature flag being on does **not** confer entitlement, and an entitlement being present…"* |
| `PRD-014_ENTITLEMENT.md` **L536** `ENT-AC-024` | **FROZEN** | *"Entitlement code resolves no feature flag and makes no authorisation decision"* |
| `LIBOORA_ENTERPRISE_ARCHITECTURE.md` **L106** | Rank 6 | *"Config resolves the flag; Business decides the entitlement."* |

`ENT-XC-008`'s three verbs — **define, evaluate, roll out** — are the same three `ADR-0017` §3.1 item 2 grants,
in the same order. A frozen exclusion and an accepted ADR agree exactly. **`PRD-023` inherits this boundary
already drawn**, and §5.1 records the reciprocity obligation that follows.

**The finding that comes with it.** `ENT-GAP-002` (`PRD-014` L580) is **High / OPEN**, owner recorded as
*"Governance Owner and `BC-25` / `PRD-023`"*. A frozen PRD has already named `PRD-023` as co-owner of an open
gap. Stage 2 must address it or record why it does not; it may not ignore it. Carried as `F-06`.

### 4.4 Branding values — a split already executed, with `PRD-023` on neither side of the aggregate

`ADR-0017` §3.1 item 3 is the narrowest grant in the set, and the repository states the split three times:

| Source | Verbatim |
|---|---|
| `Library_PRD_v1.md` **L190** (FROZEN) | `| LibraryBranding | BC-25 + BC-29 | **Split.** Values in BC-25; image binaries in BC-29 |` |
| `ADR-0013` **§5** | `| BC-25 Configuration | *BC-25's PRD — §7* | **LibraryBranding values → PRD-002** | port — platform/configuration:settings |` |
| `ARCHITECTURE_RULINGS.md` **`AR-1`** | `| Logo · Cover Image · Description *(branding values)* | BC-25 Configuration |` |

Read together, these say something more precise than *"`PRD-023` owns branding values"*:

- The **aggregate** `LibraryBranding` belongs to **`PRD-002`** (`ADR-0013` §5; `ADR-0017` §3.1 item 3:
  *"`LibraryBranding` as an aggregate stays with `PRD-002`"*).
- The **image binaries** belong to **`BC-29` / `PRD-017`**.
- What `BC-25` holds is the **value class** — a colour, a display name, a description string — and the mechanism
  by which such a value is stored, scoped and resolved.

**So `PRD-023`'s branding scope is a resolution obligation, not a data obligation.** It owns *"a branding value is
a configuration value, resolved through the hierarchy in §4.2 and read through the typed accessor in §4.5"*. It
does not own the logo, the `FileRef`, or the aggregate that holds them. Getting this wrong in the generous
direction would annex a frozen PRD's aggregate — precisely `ADR-0017` §5.3's second pre-registered risk.

### 4.5 The `E-19` typed-accessor contract — one table cell, binding every context

BC Map **L328**, verbatim, the entire specification that exists today:

```
| E-19 | All contexts | BC-25 Configuration | `CF` | Sync port | Typed config accessors; no raw string lookups
in domain code |
```

`ADR-0017` §2.5 characterises this, and the characterisation was verified rather than accepted:

> *"a platform-wide constraint on every context, currently specified **nowhere but this one table cell**."*

Verified by M-21: **35** references across `docs/` to *typed config*, *typed accessor* or *raw string lookup* —
every one of which **cites** the constraint (from `ADR-0017`, the guide, PRD alignment records, the matrix).
**None specifies it.** There is no accessor signature, no failure mode for a missing key, no statement of what
"typed" admits, no rule for a key that exists with an out-of-range value.

This matters more than a normal specification gap, because of what the repository does with unspecified rules.
`SID-4.56`: *"**A rule that cannot be checked SHALL be treated as unmet.**"* `E-19` binds *all contexts*; it
cannot be checked; therefore it is unmet **everywhere**, today. `ADR-0017` §4 rejected option A on exactly this
reasoning. **Item 5 is the highest-leverage thing `PRD-023` specifies**, and Stage 2 should treat it as the core
of the PRD rather than one clause among six. Carried as `F-08`.

### 4.6 The `LCFG-*` resolution semantics — machinery for 104 values it does not own

`ADR-0017` §3.1 item 6, restated because the boundary is the whole point: *"`PRD-023` owns the **resolution
machinery**, not the value list."*

The value list `PRD-023` does **not** own, measured word-anchored (M-16), cross-checked against
`TRACEABILITY_MATRIX.md` §2's authoritative counts:

| Register | Measured | Matrix says | Owning PRD | Status |
|---|---:|---:|---|---|
| `CFG-n` | **12** | 12 (L42) | `PRD-001` Authentication | FROZEN v2.0 |
| `LCFG-n` | **13** | 13 (L70) | `PRD-002` Library | FROZEN v1.1 |
| `ICFG-n` | **10** | 10 (L71) | Invitation Security Specification | Rank 3 |
| `SCFG-n` | **11** | 11 (L106) | `PRD-003` Student Identity | FROZEN v1.0 |
| `SMCFG-n` | **7** | 7 (L154) | `PRD-004` Student Management | FROZEN v1.2 |
| `MM-CFG-n` | **9** | 9 (L230) | `PRD-005` Membership | FROZEN v1.4 |
| `SEAT-CFG-n` | **18** | 18 (L321) | `PRD-007` Seat | FROZEN v1.0 |
| `ATT-CFG-n` | **24** | 24 (L423) | `PRD-006` Attendance | FROZEN v1.9 |
| `TEN-CFG-n` | **0 in force** | 0 | `PRD-013` Tenancy | **declared empty**, `TEN-CFG-001` retired |
| `AUD-CFG-n` | **0** | 0 | `PRD-016` Audit Trail | **declared empty** |
| `ENT-CFG-n` | **0** | 0 | `PRD-014` Entitlement | **declared empty by finding** |
| **TOTAL** | **104** | **104** | **8 owning PRDs, all FROZEN** | |

**Two measurement corrections are disclosed**, because a careless count gets both wrong, in opposite directions:

1. **`CFG-017` is not a `CFG-*` register member.** A naive `grep -o 'CFG-[0-9]\+'` returns it, and also absorbs
   `LCFG-`, `ICFG-`, `SCFG-`, `SMCFG-`, `MM-CFG-`, `SEAT-CFG-`, `ATT-CFG-` and `TEN-CFG-` into the `CFG-` count.
   Anchored, `CFG-017` survives — so it was opened. It appears at
   `PRD-007_SR-1_CORRECTION_RECORD.md:118`, `PRD-007_STAGE4_REREVIEW_2.md:126-127` and
   `PRD-007_STAGE4_COMPREHENSIVE_CORRECTION.md:298-299`, in each case as an **in-prose abbreviation of
   `SEAT-CFG-017`** (surrounding text: `` `FR-242`, `CFG-017` ``). **`CFG-n` = 12**, matching the matrix.
   *This is the exact failure mode on which §6 rejects the `SET-` prefix.*
2. **`MM-CFG-*` was initially counted as zero** by searching for `MMCFG` — the pattern every other register
   follows — when this register is hyphenated. **Nine values were invisible.** Recorded because the same error
   would silently understate Stage 3's ownership map.

**One pre-existing discrepancy in another module's register is recorded, not touched.** `ATT-CFG-025` occurs in
the Attendance PRD's text while `TRACEABILITY_MATRIX.md` L423 closes the register at **24**. Whether the text or
the matrix is right is `PRD-006`'s question, not `PRD-023`'s. Carried as `F-12`, disposition **report only**.

**What the machinery must therefore serve.** 104 values, defined in 8 frozen PRDs, operationally documented in a
Rank 7 guide, related to each other by 16 cross-parameter invariants of which 7 span two registers, resolved
across 5 scopes of which 2 are populated — with **no code and no port implementation** (M-09, M-12).

### 4.7 The invariant surface — `INV-1`…`INV-16`, and why enforcement lands here

`CONFIGURATION_GUIDE.md` §3 publishes sixteen invariants and the rule that they are *"validated at application
startup"*, that a violation is *"a fatal configuration error — fail fast and loudly"*, and that validation
*"must report **all** violations, not just the first."*

`INV-9` is the general clause: *"Every value within its declared range."* `INV-10`…`INV-16` are the seven
cross-register ones — `INV-10`: `LCFG-11 ≤ CFG-6`; `INV-11`: `LCFG-11 > CFG-2 × CFG-1`; `INV-12`:
`LCFG-13 ≤ 3600 s`. Each relates a value owned by one PRD to a value owned by another.

Two facts make enforcement `PRD-023`'s obligation rather than a shared one:

1. **No single owning PRD can enforce a cross-register invariant.** `PRD-002` cannot see `CFG-6`; `PRD-001`
   cannot see `LCFG-11`. The only component holding both is whatever resolves configuration.
2. **The obligation is already written and already unimplemented.** `IMPL-015` requires *"invariants
   `INV-1`…`INV-9`"* validated at startup, in every environment, reporting all violations, refusing to start on
   any violation; `IMPL-016` requires `CFG-1`…`CFG-12` exposed as *"typed, injected configuration"*. **Both
   pre-date `PRD-023` and neither is done** (M-12).

**Consequence for Stage 6, recorded now so it is not discovered late.** `IMPL-015` and `IMPL-016` exist and are
on the critical path (`IMPL-015` → `IMPL-016` → `IMPL-020` → `TASK-D10`). Stage 6 **must not re-issue them under
new numbers**; its tasks must reference them and add only what is genuinely new. Note also that `IMPL-015` names
`INV-1`…`INV-9` while the guide publishes `INV-1`…`INV-16` — a seven-invariant shortfall in the roadmap, carried
as `F-11`.

### 4.8 The module and the port — declared, consumed by seven, provided by none

| Fact | Evidence |
|---|---|
| Module exists in the rank table | `tool/module_dependencies.yaml` **L31**: `platform/configuration: 3` |
| It has **no module block** | Measured: **8 of 17** platform modules lack one (`infrastructure`, `data`, `security`, **`configuration`**, `observability`, `services`, `event`, `integration`) |
| The port is named | `platform/configuration:settings` |
| **7 modules consume it** | L108 `domain/library`, L182 `domain/person`, L240 `domain/social`, L280 `platform/ai`, L309 `platform/analytics`, L336 `platform/workflow`, L513 `app` |
| **0 modules provide it** | M-09. The only two `provides_ports:` blocks are L188 (`domain/person`) and L442 (`platform/identity`) |
| No code exists | M-12: `lib/platform/` has 9 directories, none named `configuration`; 0 files match `*config*`/`*setting*` |

**A correction to `ADR-0017`'s framing, offered as corroboration rather than contradiction.** `ADR-0017` §2.5
calls `platform/configuration` *"declared, unspecified, unimplemented."* All three are true. But *"declared
without a module block"* is **not distinguishing** — 8 of 17 platform modules are in that position, and it is the
norm at ranks 0–3. The genuinely distinguishing fact is sharper: **`platform/configuration:settings` is an orphan
port — 7 consumers, 0 providers.** The manifest header reads `default_decision: deny  # anything not listed is
forbidden`, so seven modules declare a dependency on a capability nothing supplies.

**And the instrument that would catch it does not exist.** `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` §10.3 requires
`no_orphan_ports_test.dart` — *"Every declared port has exactly one registered implementation at the composition
root."* Measured (M-14): `test/architecture/` contains **one** file, `boundary_checker_test.dart`, which appears
nowhere in §10.3's list of seven. The gap and its detector are missing together, and merge-blocking pipeline gate
4 (`flutter test test/architecture/`) is **green while asserting none of the seven required properties**. Another
`SID-4.56` case. Carried as `F-09`.

### 4.9 The event surface — `BC-25` publishes nothing, and that is a finding

| Measurement | Result |
|---|---|
| Producers in BC Map §9 | **14**: `BC-01`…`BC-06`, `BC-10`…`BC-13`, `BC-18`, `BC-19`, `BC-20`, `BC-27` |
| `BC-25` among them | **No** — zero occurrences of `BC-25` anywhere in §9 |
| Event names matching `configuration.`/`config.`/`settings.`/`flag.` | **0** (M-11) |
| `BC-25` in §7's integration table | **Once, as a provider** — `E-19`, a **synchronous port**, not an event |

Three authorities make the disposition unambiguous:

1. BC Map §7 **L292**: an edge not in the table **does not exist**. There is no configuration event edge.
2. **Precedent, three times.** `PRD-013` §0.2 declared `TEN-CFG-*` empty and retired its one identifier;
   `PRD-016` declared `AUD-CFG-*` empty; `PRD-014` declared `ENT-CFG-*` *"EMPTY by finding"*. **Declaring a
   register empty, with the measurement attached, is established practice** — it is not an omission.
3. `PRD-013` §6 closed its event surface at exactly two and explained why more would be invention.

**Therefore Stage 2 must declare `CNF-EVT-*` EMPTY.** Issuing a `configuration.SettingChanged` event would create
an edge Rank 4 says does not exist — and `PRD-014`'s Stage 1 `R-11` already rejected exactly that move for
`BC-21`.

**The obvious objection, and its answer.** `SID-5.46` (FROZEN) requires *"A change to any value above **SHALL** be
audited with actor, previous value and new value."* Does `BC-25` not need an event to discharge that? **No.**
`E-20` already exists: *"All contexts | BC-24 Audit Trail | `PL` | Event (fire-and-forget, outbox-backed) | Domain
never calls audit synchronously."* Every context audits through `E-20`. `BC-25` using the edge that already binds
it is not the same as `BC-25` publishing a domain event of its own. Recorded so Stage 2 does not mint an event to
solve a problem `E-20` already solves.

---

## 5. What `BC-25` does **not** own — exclusion candidates with named owners

`PRD-013` §7's standard governs the form these must take at Stage 2: *"Every exclusion states what must be
**impossible**. An exclusion is not a deferral."* Stage 1's job is only to enumerate the candidates and name each
owner, so that Stage 2 cannot silently annex one.

| # | Candidate | Owner | Authority |
|---|---|---|---|
| 1 | **Secret material** — any secret value, key or credential | `SECURITY` platform | `ADR-0017` §3.1 item 4, §3.2, §4 option C3 |
| 2 | **Entitlement decisions** — whether a tenant is *allowed*, or has *quota left* | `BC-21` / `PRD-014` **FROZEN** | `ADR-0017` §3.2; `ENT-BR-004`; EA L106 |
| 3 | **Authorisation decisions** | `BC-18` / `PRD-001` **FROZEN** | `TEN-XC-003` precedent; `MP-GBR-20`…`23`; `LIB-16.9`; `LCFG-13` *"**Never** applies to an authorization decision"* |
| 4 | **Tenancy structure** — the `Tenant` aggregate, `TenantContext`, tiers, residency | `BC-19` / `PRD-013` **FROZEN** | `ADR-0017` §3.2; `PRD-013` §2, §3 |
| 5 | **File bytes** — image binaries, `FileRef` issuance, storage | `BC-29` / `PRD-017` | `ADR-0017` §3.1 item 3, §3.2 |
| 6 | The **`LibraryBranding` aggregate** | `PRD-002` **FROZEN** | `ADR-0013` §5; `ADR-0017` §3.1 item 3 |
| 7 | The **`LCFG-1`…`LCFG-13` definitions** — names, defaults, ranges, rationales | `PRD-002` **FROZEN** | `ADR-0017` §3.1 item 6: *"the definitions stay in the Library PRD"* |
| 8 | The **`CFG-*`, `ICFG-*`, `SCFG-*`, `SMCFG-*`, `MM-CFG-*`, `SEAT-CFG-*`, `ATT-CFG-*` definitions** | `PRD-001`, Invitation Spec, `PRD-003`, `PRD-004`, `PRD-005`, `PRD-007`, `PRD-006` — **all FROZEN** | `ADR-0017` §3.2: *"**This ADR moves no requirement.**"* By parity with item 7 |
| 9 | **`BranchPolicy`** — working hours, holidays, attendance rules, seat rules | `BC-06` / `PRD-002` **FROZEN** | BC Map §8. Resolving a value *at* branch scope ≠ owning branch policy (§4.2) |
| 10 | The **13 structural facts that are not configurable** | The PRDs that specify them | `CONFIGURATION_GUIDE.md` §1: *"Exposing any of these as a tunable is a **defect**"* |
| 11 | The **operational guidance** — environment profiles, per-parameter observability tables | `CONFIGURATION_GUIDE.md`, **Rank 7** | Rank 7 *is* the operational guidance; a PRD does not absorb the guide |
| 12 | **`Q-01`, `Q-03`, `Q-04`, `Q-06`** — the four open Master PRD questions | Architecture Owner | BC Map §13's column is headed **"Recommendation"**; `MASTER_PRD.md` §34 reads **"Open"**. `PRD-014` Stage 1 `R-04` rejected adopting one |
| 13 | **Secret resolution at runtime** — fetching material behind a reference | `SECURITY` platform | EA L71/L132: *"`Secrets Management` re-homed to Security Platform; Config retains `Secret Reference Resolution` only"* |
| 14 | **Role definitions** — `TR-1`…`TR-5` and Platform Administrator | `PRD-001` **FROZEN** | `DEFINITION_OF_DONE.md`: *"**No new role name.** `TR-1`…`TR-5` and Platform Administrator are the whole set"* |

**Candidate 10 deserves emphasis, because it is the exclusion a configuration PRD is most likely to breach by
being helpful.** `CONFIGURATION_GUIDE.md` §1 lists thirteen structural facts — OTP code length 6 digits, OTP
challenge validity 5 min, 5 verification attempts, single-use challenge, one concurrent challenge per number,
mobile OTP only in V1, exactly one active library per session, `IT-1`/`IT-2` entropy 128 bits, `IT-3` entropy
≥ 40 bits, exactly three invitation types, the closed list `PO-1`…`PO-12`, the §14A.5 public-profile allow-list,
invitation single-use policy — and rules: *"Exposing any of these as a tunable is a **defect**, because operators
could then configure the system out of conformance with its own specification."* `DEFINITION_OF_DONE.md` restates
it as a gate — *"No PRD §F structural fact made configurable"*, *"No **closed register** extended in code"* — and
closes with *"**'Temporarily' does not apply to this table.**"* A PRD that owns the mechanism for making things
configurable must specify, normatively, that this list **cannot be reached through it**.

### 5.1 The reciprocity check

Where a frozen PRD excludes something and names `BC-25` as its owner, `PRD-023`'s eventual claim must match the
exclusion **exactly** — no wider, no narrower. Verified in both directions:

| Frozen exclusion | Names `BC-25` as owner of | `ADR-0017` §3.1 grants | Match |
|---|---|---|---|
| `ENT-XC-008` — *"MUST NOT define, evaluate or roll out a feature flag"* | define · evaluate · roll out | item 2: *"definition, evaluation, rollout"* | **Exact — same three verbs, same order** |
| `SID` §5.5 preamble — *"Every value below is configuration, owned by `BC-25`, read through a typed accessor"* | the values are configuration; access is typed | items 5, 6 | **Exact** — `PRD-023` owns the accessor, not `SCFG-*` |
| `Library_PRD_v1.md` L1093 — *"Settings, feature flags, branding values, secret references \| BC-25 \| **Owns**"* | four things | items 1–4 | **Exact** — the same four as BC Map L134 |
| `Library_PRD_v1.md` L190 — *"Split. Values in `BC-25`; image binaries in `BC-29`"* | branding values | item 3 | **Exact**, with the aggregate reserved to `PRD-002` |
| `ARCHITECTURE_RULINGS.md` `AR-1` — *"Logo · Cover Image · Description *(branding values)* \| BC-25"* | branding values in a read model | item 3 | **Exact** |

**No frozen document names `BC-25` as owner of anything `ADR-0017` §3.1 does not grant, and `ADR-0017` grants
nothing no frozen document acknowledges.** The one apparent excess is `LibrarySettings` (§1.2, `F-01`) — an
aggregate *name* granted at Rank 3, not a *scope* item.

### 5.2 Frozen PRDs that consume `BC-25` — cite, never restate

Eight FROZEN PRDs define configurables that `PRD-023` will resolve. **`PRD-023` must cite them and must not
restate them** — two sources of truth for one default is the failure `TRACEABILITY_MATRIX.md` L209–210 already
guards against, in the identical situation:

> *"`SMCFG-1` is **cited rather than duplicated** — `SMCFG-1` **is** `LCFG-5`, consumed through `E-19`."*

That row is the precedent for `PRD-023`'s whole relationship to the eight registers: **one value, one owner, cited
across the boundary through `E-19`, never copied.**

| PRD | Status | Register | Count | `PRD-023`'s posture |
|---|---|---|---:|---|
| `PRD-001` Authentication | FROZEN v2.0 | `CFG-*` | 12 | Cite. `IMPL-016` already requires these typed and injected |
| `PRD-002` Library | FROZEN v1.1 | `LCFG-*` | 13 | Cite. Guide §4 already partitions them by scope |
| Invitation Security Spec | Rank 3 | `ICFG-*` | 10 | Cite |
| `PRD-003` Student Identity | FROZEN v1.0 | `SCFG-*` | 11 | Cite — **and honour `SID-5.44`/`5.45`/`5.46`** as constraints on the mechanism |
| `PRD-004` Student Management | FROZEN v1.2 | `SMCFG-*` | 7 | Cite. `SMCFG-1` **is** `LCFG-5` — the aliasing case |
| `PRD-005` Membership | FROZEN v1.4 | `MM-CFG-*` | 9 | Cite |
| `PRD-006` Attendance | FROZEN v1.9 | `ATT-CFG-*` | 24 | Cite. The `ATT-CFG-025`/24 discrepancy is `PRD-006`'s (`F-12`) |
| `PRD-007` Seat | FROZEN v1.0 | `SEAT-CFG-*` | 18 | Cite |

**`SID-5.44`…`5.46` are the sharpest constraints any consumer places on the mechanism**, and they are transcribed
because Stage 2 must satisfy them rather than discover them late:

- **`SID-5.44`** — *"No configuration value **SHALL** be able to change the **default** privacy mode, alter the
  allow-list, disable an audit event, or set `SCFG-5` to 0 in production."*
- **`SID-5.45`** — *"Every value above **SHALL** be platform-wide. None **SHALL** be organisation-configurable,
  because this module is not organisation-scoped."*
- **`SID-5.46`** — *"A change to any value above **SHALL** be audited with actor, previous value and new value."*

`DEFINITION_OF_DONE.md` §5 turns `SID-5.44` into a gate with a stated failure mode: *"A public profile default, an
allow-list change, or `SCFG-5 = 0`, set by configuration \| `SID-5.44`. **Configuration must be rejected at
startup, not accepted with a warning.**"*

Read as requirements on `PRD-023`'s machinery, these three say: the hierarchy must support a value **declared
platform-only, which cannot be overridden at any lower scope** (`SID-5.45`); resolution must **reject at startup**
rather than warn (`SID-5.44`); and every change must carry **actor, previous value, new value** (`SID-5.46`) —
discharged through `E-20`, per §4.9.

---

## 6. The identifier prefix — `CNF-`, chosen by measurement before anything was written

`PRD_LIFECYCLE.md` L82 rule 2: *"Prefixes are chosen against §5's collision procedure **before** writing."*
Stage 5's gate additionally requires *"prefixes registered in `TRACEABILITY_MATRIX.md` §2, **verified
mechanically, zero collisions both directions**."* Five candidates were tested in both directions before one was
selected.

| Candidate | Forward scan | Reverse hazard | Verdict |
|---|---:|---|---|
| `CONF-` | **3** — `CONF-1`, `CONF-2`, `CONF-3` (`PRD-004_ALIGNMENT_REPORT.md`, admitted at `DOCUMENTATION_BASELINE.md:160`) | — | ⛔ **REJECTED — occupied** |
| `CFG-` | **12** — `PRD-001`'s live register | — | ⛔ **REJECTED — occupied** |
| `SC-` | **16** — `SC-1`…`SC-13` Student Identity alignment | — | ⛔ **REJECTED — occupied** |
| `SET-` | **0** across all nine register suffixes | Anchored scans clean, **but "SET" is a common English word** and a frequent code token | ⚠ available, **rejected on risk** |
| **`CNF-`** | **0** (M-01) | `.CNF-[A-Z]` → **empty** (M-02). Not an English word; not a Dart keyword; no register ends in a letter that would absorb it | ✅ **SELECTED** |

**Why `CNF-` is preferred over the equally-free `SET-`.** §4.6 records `CFG-017`: a prose abbreviation that a
naive scan reads as a register member, and which cost real measurement effort to disprove. `SET-` invites exactly
that failure at higher frequency — *"set the value"*, *"SET-based"*, `Set<T>` — while `CNF-` is a token that
appears in prose only when someone means this register. Choosing the freer-looking prefix over the
lower-ambiguity one would optimise for today's `grep` and against every future one.

**Register shape**, matching all three most recent frozen PRDs (`PRD-013`, `PRD-016`, `PRD-014`):

| Prefix | Meaning | Expected Stage 2 disposition |
|---|---|---|
| `CNF-FR-*` | Functional requirements | Populated |
| `CNF-BR-*` | Business rules | Populated |
| `CNF-INV-*` | Invariants | Populated — the `INV-1`…`INV-16` enforcement obligation (§4.7) |
| `CNF-EVT-*` | Event surface | **DECLARED EMPTY** by measurement (§4.9) |
| `CNF-XC-*` | Exclusions | Populated — §5's fourteen candidates |
| `CNF-CFG-*` | Configurables **this module** publishes | Stage 2 to determine. **Any value published here needs a default and a range** (Stage 4 gate); a configuration module publishing unbounded configurables would be self-refuting |
| `CNF-AC-*` | Acceptance criteria | Populated |
| `CNF-GAP-*` | Open gaps | Populated — §7's findings that `PRD-023` records rather than fills |

**A caution recorded for Stage 5, not resolved here.** `CNF-INV-*` coexists with the platform register `INV-n`
(`INV-1`…`INV-16`, `TRACEABILITY_MATRIX.md` L82) and with `INV-SEC-*` / `INV-XC-*`. `CNF-INV-001` is a distinct
token from `INV-1`, so this is **not** a collision — but a naive `grep 'INV-'` will over-count. `PRD-014`'s Stage
1 `R-02` raised the identical point and carried it forward as a **scanning requirement** rather than a collision.
The same disposition applies, and it matters more here because this module's subject matter *is* the `INV-*`
register.

**No `CNF-*` identifier is issued by this record.** Issuing them is Stage 2's, with ranges declared up front
(`PRD_LIFECYCLE.md` L79–86).

---

## 7. Findings carried forward

Every finding below was produced by a measurement. Each carries **evidence, severity, owner and disposition**.
Findings considered and **rejected** are in §7.1 with reasons — because `PRD_LIFECYCLE.md` L104 holds that
*"A review that records only accepted findings is indistinguishable from a review that found nothing."*

| ID | Finding | Evidence | Severity | Owner | Disposition |
|---|---|---|---|---|---|
| **`F-01`** | **The `LibrarySettings` aggregate question.** `Library_PRD_v1.md` **L188** (FROZEN, Rank 3) declares `| **LibrarySettings** | BC-25 | Settings hierarchy and feature flags |`. That string occurs **exactly once repo-wide** (M-05), and **`BC-25` is absent from BC Map §8's 17-aggregate table** (M-10, Rank 4). `ADR-0013` §5 assigns only *"`LibraryBranding` values → `PRD-002`"* for `BC-25` and is **silent on `LibrarySettings`** | `Library_PRD_v1.md:188`; BC Map §8 read in full; M-05; `ADR-0013` §5 | **High** — decides whether `PRD-023` has an aggregate at all | **Architecture reviewer** | **Accepted; deliberately NOT resolved.** Whether `BC-25` owns a domain aggregate, and whether it is named `LibrarySettings`, is a Stage 3 judgement (`PRD_LIFECYCLE.md` §6). Stage 1 records that question 4 does not fail (§1.2) and stops there. **Claiming the aggregate would assert something Rank 4 does not recognise; denying it would contradict a frozen Rank 3 grant.** Neither is Stage 1's to do |
| **`F-02`** | **EA places two `PRD-023` V1 scope items at V2.** `LIBOORA_ENTERPRISE_ARCHITECTURE.md` L500–535 lists `Feature Flags (V2)` and `Secret Reference Resolution (V2)`, while `ADR-0017` §3.1 items 2 and 4 assign both to `PRD-023`, which is **V1** | EA L500–535; `ADR-0017` §3, §3.1 | **Medium** | Architecture reviewer | **Accepted as a conflict to be *named*, not silently resolved.** Precedence settles it — EA is **Rank 6, *"Descriptive only. Update it to match 1–5; never the reverse"*** — but `DOCUMENTATION_BASELINE.md` §4 rules *"A conflict is a defect. If you find one, **do not choose** — raise it."* Stage 3 must state the conflict and the disposition explicitly |
| **`F-03`** | **The orphan port.** `platform/configuration:settings` is consumed by **7** modules and provided by **0**, under a manifest whose header reads `default_decision: deny` | M-08, M-09; yaml L108, 182, 240, 280, 309, 336, 513; `provides_ports` at L188, L442 only | **High** | Implementation lead | **Accepted.** Recorded. **No code change at Stages 1–7.** Stage 6 must produce a task binding the port to an implementation at the composition root |
| **`F-04`** | **All seven required architecture tests are missing.** Matrix §10.3 requires seven; `test/architecture/` contains **one** file, `boundary_checker_test.dart`, which appears **nowhere** in §10.3's list. Merge-blocking gate 4 is therefore **green while asserting 0 of 7** — including `no_orphan_ports_test.dart`, which would catch `F-03`, and `tenant_isolation_test.dart` | M-14; Matrix §10.3, §10.4 | **High**, **pre-existing and inherited** | Implementation lead | **Accepted as inherited.** A textbook `SID-4.56` case (*"A rule that cannot be checked SHALL be treated as unmet"*). `PRD-023` **must not invent specifications** for these — Matrix §10.3 already states each. Stage 6 may sequence the two that bear on `BC-25`; the other five belong to their own owners |
| **`F-05`** | **The five-scope hierarchy is populated at two levels.** platform default ✔ · tenant **register declared empty** · library ✔ (9 values) · branch **named, never specified** · user **nothing at all** | §4.2; `CONFIGURATION_GUIDE.md` §4; `PRD-013` §0.2; M-16 | **Medium** | Product owner, `PRD-023` | **Accepted.** Not a defect — the measure of how much of `ADR-0017` §3.1 item 1 Stage 2 specifies from scratch. Stage 2 **must not invent a user-scoped configurable** to populate level five |
| **`F-06`** | **A frozen PRD names `PRD-023` as co-owner of an open gap.** `ENT-GAP-002` (`PRD-014` L580) is **High / OPEN**, owner *"Governance Owner and `BC-25` / `PRD-023`"* | `PRD-014_ENTITLEMENT.md:580` | **High** | Governance owner + product owner, `PRD-023` | **Accepted.** Stage 2 must address it or record why it does not. `PRD-023` **may not edit `PRD-014`** to close it — that needs its own ADR (`DOCUMENTATION_BASELINE.md` §7 rule 1) |
| **`F-07`** | **Four open Master PRD questions are all configuration-shaped, and one names `BC-25` explicitly.** BC Map L540 `Q-01`: *"Configurable per tenant (BC-25), default 24h grace"*. `Q-03`, `Q-04`, `Q-06` likewise | BC Map §13 L540; `MASTER_PRD.md` §34 | **High** | Architecture Owner | **Accepted.** `PRD-023` owns the **mechanism** by which such a value is expressed, defaulted, ranged and resolved; it owns **no value**. Adopting `Q-01`'s *"default 24h grace"* would convert a Rank 4 **Recommendation** into a Rank 3 rule — exactly what `PRD-014`'s `R-04` rejected |
| **`F-08`** | **`E-19` binds every context and is specified in exactly one table cell.** 35 references across `docs/`; **every one cites, none specifies** (M-21). No accessor signature, no missing-key failure mode, no definition of what *"typed"* admits | BC Map L328; M-21; `ADR-0017` §2.5 | **High** | Product owner, `PRD-023` | **Accepted, and elevated.** Under `SID-4.56` an uncheckable rule is **unmet**, so `E-19` is unmet in every context today. This is the **core** of `PRD-023`, not one clause of six |
| **`F-09`** | `platform/configuration` has **no module block** in `tool/module_dependencies.yaml` — but so do **8 of 17** platform modules, so `ADR-0017` §2.5's framing is true and **not distinguishing** | Measured across all 17 ranked platform modules | **Low** | Implementation lead | **Accepted as a correction to an inherited characterisation.** The distinguishing fact is `F-03`, not the missing block. Recorded so Stage 3 does not rest an argument on a non-distinguishing observation |
| **`F-10`** | **`BC-25` publishes no event.** 0 of BC Map §9's 14 producers; 0 event names matching config patterns; `BC-25`'s only §7 appearance is `E-19`, a **synchronous port** | M-11; BC Map §7, §9 read in full | **Medium** | Product owner, `PRD-023` | **Accepted.** Stage 2 **must declare `CNF-EVT-*` EMPTY**, with the measurement attached, per the `TEN-CFG-*`/`AUD-CFG-*`/`ENT-CFG-*` precedent. `SID-5.46`'s audit obligation discharges through **`E-20`**, not a new event |
| **`F-11`** | **`IMPL-015` names `INV-1`…`INV-9`; the guide publishes `INV-1`…`INV-16`.** A seven-invariant shortfall in the roadmap's startup-validation task — and the seven omitted (`INV-10`…`INV-16`) are precisely the **cross-register** ones | `IMPLEMENTATION_ROADMAP.md` `IMPL-015`; `CONFIGURATION_GUIDE.md` §3 | **Medium** | Implementation lead | **Accepted.** Recorded. `PRD-023` **must not edit the roadmap**. Stage 6 references `IMPL-015`/`IMPL-016` rather than re-issuing them, and notes the shortfall |
| **`F-12`** | **`ATT-CFG-025` occurs in text while `TRACEABILITY_MATRIX.md` L423 closes the register at 24** | M-16; matrix L423 | **Low**, **pre-existing, another module's** | Product owner, `PRD-006` | **Accepted as report-only.** `PRD-006` is FROZEN v1.9. Not `PRD-023`'s to repair, and repairing it would need an ADR |
| **`F-13`** | **`DOCUMENTATION_BASELINE.md` §4 has 10 Rank-3 rows while its own prose says *eleven*; the `PRD-014` Entitlement row is missing.** `ADR-0052` was accepted, the §3.3 row written and the §4 prose count advanced — but the §4 table row was never added. Third recurrence of the `GCP-16`/`GCP-19` defect class | `DOCUMENTATION_BASELINE.md` §4 L220–258 enumerated; `grep -c "Entitlement PRD"` in §4 = **0** | **Medium** | Governance owner | **Accepted; reported, NOT repaired.** Candidate **`GCP-20`** (next free). Repository safety rule 3 forbids modifying unrelated files. **Operationally relevant:** `PRD-023`'s Stage 7 writes a §3 row and asserts a §4 rank, so `PRD-023` would appear in §4 while a frozen predecessor does not. Disclosed per the `GCP-15`…`GCP-19` precedent |
| **`F-14`** | **No configuration code exists.** `lib/platform/` has 9 directories, none named `configuration`; `find lib packages -iname "*config*" -o -iname "*setting*"` → **0 files**; `BC-25` appears **0 times** in `tool/`, `packages/`, `lib/` | M-07, M-12 | **Medium** | Implementation lead | **Accepted.** The whole capability is unbuilt. Consequence for Stage 6: every task is greenfield, and **nothing** may be recorded as satisfied-in-place |

**Fourteen findings accepted.** Five (`F-01`, `F-02`, `F-06`, `F-07`, `F-13`) are things `PRD-023` must **record
rather than fill**; four (`F-03`, `F-04`, `F-11`, `F-14`) are implementation gaps it must **document rather than
fix**; one (`F-09`) corrects a characterisation inherited from its own governing ADR.

### 7.1 Findings considered and **rejected**, with reasons

`PRD_LIFECYCLE.md` L104: *"**A rejected finding must be recorded as rejected, with its reason.**"*

| ID | Candidate finding | Why rejected |
|---|---|---|
| `R-01` | *"`BC-25` fails Stage 1 question 4 — it owns no aggregate, since BC Map §8 omits it, so it is a capability of an existing context"* | **Rejected on the question's own stated failure mode.** The gate reads *"Owning neither ⇒ **it is a capability of an existing context**."* BC Map **L271** places `BC-25` in the **FOUNDATIONAL** band — *"Every context depends on these three. They depend on nothing above them."* A context every other context depends on is not a capability *of* one of them. `PRD-014`'s Stage 1 `R-10` already made L271's three-member list decisive in the opposite direction. Three further grounds in §1.2 |
| `R-02` | *"Use `SET-` — it measured 0 in both directions, same as `CNF-`"* | **Rejected on future-collision risk, not on measurement.** Both are free today. But §4.6 documents `CFG-017`: a prose abbreviation that a naive scan reads as a register member. *"SET"* is an English verb and a Dart type name (`Set<T>`), so `SET-` invites that failure repeatedly. `CNF-` appears in prose only when someone means this register |
| `R-03` | *"`ADR-0017` §3.1 item 6 gives `PRD-023` `LCFG-*`, so the thirteen definitions should move into it"* | **Rejected as the exact opposite of what item 6 says.** Verbatim: *"The `LCFG-1`…`LCFG-13` **definitions stay in the Library PRD**; `PRD-023` owns the resolution machinery, **not the value list**."* §3.2 adds *"**This ADR moves no requirement.**"* And `Library_PRD_v1.md` is **FROZEN v1.1** — moving anything out of it needs its own ADR. `ADR-0017` §5.3 pre-registers this as a **Medium** risk: *"`LCFG-*` requirements silently migrate out of the Library PRD"* |
| `R-04` | *"`Q-01` says `24h grace` and BC Map even names `BC-25`, so `PRD-023` should specify it as the platform default"* | **Rejected as invention.** BC Map §13's fourth column is headed **"Recommendation"**; its preamble says *"Each should become an ADR"*; `MASTER_PRD.md` §34 records `Q-01` as **Open**. `~~Q-05~~` shows what closure looks like — struck through with an ADR named — and `Q-01` has none. `PRD-014`'s `R-04` rejected the identical move for `Q-03`. Adopting it would mint a Rank 3 default from a Rank 4 suggestion |
| `R-05` | *"EA's `CONFIGURATION PLATFORM (V1)` tree is a specification of `PRD-023`'s V1 scope — Settings Registry, Tenant Overrides, Inheritance & Precedence"* | **Rejected as a source of obligation; accepted as corroboration.** EA is **Rank 6, descriptive only**. `PRD-014`'s `R-05` established the precedent: *"Rank 6 cannot mint requirements."* The tree **corroborates** `ADR-0017` §3.1 item 1 almost exactly, which is worth recording — and the places where it disagrees are `F-02`, raised rather than adopted |
| `R-06` | *"`PRD-023` should issue `configuration.SettingChanged` — `SID-5.46` requires configuration changes to be audited"* | **Rejected as invention of an event.** BC Map §7 L292: an edge not in the table does not exist, and there is no configuration event edge (M-11). `E-20` — *"All contexts | BC-24 Audit Trail | Event (fire-and-forget, outbox-backed)"* — already binds every context and discharges `SID-5.46`. `PRD-014`'s `R-11` rejected exactly this move. §4.9 |
| `R-07` | *"`Library_PRD_v1.md` L188 grants `LibrarySettings` to `BC-25`, so `PRD-023`'s aggregate is `LibrarySettings` — settled"* | **Rejected as premature, in Stage 1's own voice.** The grant is real and is why question 4 does not fail. But the name occurs **once** repo-wide and `BC-25` is **absent from BC Map §8**, so adopting it would assert at Rank 3 something Rank 4 does not recognise. `PRD_LIFECYCLE.md` §6 assigns architecture judgements to Stage 3. Carried as `F-01`, unresolved **on purpose** |
| `R-08` | *"Repair `DOCUMENTATION_BASELINE.md` §4's missing `PRD-014` row while we are here — it is a one-line fix"* | **Rejected.** Repository safety rule 3: do not modify unrelated files. Rank 1–5 changes need an ADR **before** the edit (`DOCUMENTATION_BASELINE.md` §7 rule 1). `PRD-014`'s `R-07` rejected the identical temptation for the stale `IMPL-227+` table. Recorded as `F-13`, candidate `GCP-20`, owner named |
| `R-09` | *"`ADR-0017` §2.5 is wrong that `platform/configuration` is distinctive in lacking a module block — report it as an ADR defect"* | **Partially rejected.** The observation is correct and is recorded as `F-09`. But `ADR-0017`'s sentence — *"declared, unspecified, unimplemented"* — is **true**; it is merely not *distinguishing*. A true statement that proves less than it appears to is not a defect in an accepted ADR, and *"Do NOT modify `ADR-0017`"* is an explicit instruction. Recorded as a correction to the **argument**, not to the document |
| `R-10` | *"`PRD-023` should specify a user-scoped configurable, since `ADR-0017` fixes a five-level hierarchy and level five is empty"* | **Rejected as invention.** No user-scoped configurable exists in any of the eight registers (M-16). `SID-5.45` runs the other way: *"Every value above **SHALL** be platform-wide."* `PRD-023` may specify **that the hierarchy has a user level and how it resolves**; inventing a value to occupy it would breach Stage 4's *"every configurable has a default and a range"* and `ADR-0017` §5.3's *"everything configurable"* risk |
| `R-11` | *"`CONFIGURATION_GUIDE.md` is Rank 7 and `PRD-023` is Rank 3, so the PRD should absorb the guide's 35 parameters and supersede it"* | **Rejected on the rank model.** Rank 7 is *operational guidance*, a different **kind** of document, not a lower-quality PRD. The guide's §5 change-control rule points the other way: *"**adding a parameter → a PRD amendment** — the specification declares what is configurable, this guide does not."* Guide and PRD are complements; absorbing it would put 35 values under a second owner |
| `R-12` | *"`PRD-023` owns branch-scoped settings, therefore it owns `BranchPolicy`"* | **Rejected on a distinction BC Map §8 makes explicitly.** `BranchPolicy` is `BC-06`'s aggregate with its own invariant — *"policy changes are versioned with `effectiveFrom` (never retroactive)"*. Resolving a value **at** branch scope is not owning the policy aggregate that lives at that scope. Conflating them would annex a frozen PRD's aggregate. §5 candidate 9 |
| `R-13` | *"The `settings` port's 7 consumers / 0 providers is a `tool/module_dependencies.yaml` defect — fix the manifest"* | **Rejected as an action; accepted as a finding.** The manifest **correctly** records what the modules declare; the missing thing is an **implementation**, not a manifest line. Writing a `provides_ports: [settings]` block for a module with no code would make the boundary checker pass while nothing exists — the failure `SID-4.56` names. Recorded as `F-03`, disposition: a Stage 6 task |
| `R-14` | *"`PRD-023` should specify the six missing architecture tests it depends on"* | **Rejected on an explicit instruction and on ownership.** *"Do not invent new specifications for these. Use the existing Dependency Matrix §10.3 requirements."* §10.3 already states all seven. Two bear on `BC-25` (`no_orphan_ports_test.dart`, `every_event_has_schema_test.dart` — vacuous here, since `CNF-EVT-*` is empty); the rest belong to other owners. Recorded as `F-04` |

---

## 8. Prerequisites verified before proceeding

| Prerequisite | Method | Result |
|---|---|---|
| Working tree clean at start | `git status --porcelain` | **0 lines** |
| No implementation code touched | `git status --short lib/ packages/ test/ tool/` | **0 lines** |
| `PRD-023` identity reserved for `BC-25` | `PRD_REGISTRY.md` §4.3 **L327** | Confirmed, `PLANNED` |
| `BC-25` uncontested | `PRD_REGISTRY.md` §6 **L448** | Confirmed, **Contested = No** |
| Governing ADR is in force | `ADR-0017` header | **`ACCEPTED`** 2026-08-04, `BASELINE-2026-08-04-B` |
| Rank 1 authority exists | `MASTER_PRD.md` §8 **L170** | Confirmed — module 18, `[GENERIC]`, **V1** |
| Prefix `CNF-` free, both directions | M-01, M-02 | **0** / **empty** |
| `IMPL-1100`+ free | M-22 | Confirmed by measurement; **`IMPL-1030`–`1099` is `PRD-014`'s reserve** and was **not** taken |
| Target directory | `mkdir -p docs/30-product/configuration` | Created; did not previously exist. Follows the `tenancy/`, `audit/`, `entitlement/` precedent |
| Stage 1 gate artefact | this file | Exists on disk |

---

## 9. What this record deliberately does **not** do

| Not done | Why |
|---|---|
| Issue any `CNF-*` identifier | Stage 2's, with ranges declared up front (`PRD_LIFECYCLE.md` L79–86) |
| Decide whether `PRD-023` owns an aggregate, or whether it is `LibrarySettings` | `F-01`. An architecture judgement; `PRD_LIFECYCLE.md` §6 assigns Stage 3 to the architecture reviewer |
| Resolve the EA V1/V2 conflict | `F-02`. Precedence would settle it, but the baseline rules *"do not choose — raise it"* |
| Allocate `IMPL-1100`+ | Stage 6's gate. M-22 establishes availability only |
| Answer `Q-01`, `Q-03`, `Q-04` or `Q-06` | `F-07`, `R-04`. Each needs an ADR by the Architecture Owner |
| Specify a default, a range or a value for any configurable | `ADR-0017` §3.1 item 6. `PRD-023` owns machinery, not values |
| Move any `LCFG-*`, `CFG-*`, `SCFG-*` or `ICFG-*` requirement | `ADR-0017` §3.2, `R-03`. Eight owning PRDs are FROZEN |
| Author a configuration event | `F-10`, `R-06`. `E-20` already discharges the audit obligation |
| Modify `ADR-0017` or any frozen document | Explicit instruction; `DOCUMENTATION_BASELINE.md` §7 rule 1 |
| Repair the baseline §4 missing row | `F-13`, `R-08`. Candidate `GCP-20`, owner named, safety rule 3 |
| Write the seven architecture tests, or specify them | `F-04`, `R-14`. Matrix §10.3 already states them |
| Implement the `settings` port, or add a `provides_ports` line | `F-03`, `R-13`. No code change at Stages 1–7 |
| Absorb `CONFIGURATION_GUIDE.md` | `R-11`. Rank 7 is a complement, not a subordinate |
| Confer any status on `PRD-023` | Status is conferred by the registry and the baseline, never by a stage record |

---

## 10. Verdict

| Gate element | Required | Actual | Result |
|---|---|---|---|
| Context identified in the Bounded Context Map | Yes | `BC-25`, BC Map **L134** | **PASS** |
| Not already owned in `PRD_REGISTRY.md` §6 | Yes | §6 **L448**, Contested = **No** | **PASS** |
| Q1 — a bounded context owns it | Yes | `BC-25` is a context in the **FOUNDATIONAL** band (L271), not a composition | **PASS** |
| Q2 — no other PRD owns the context | Yes | `PRD-023` is the registered owner; contested count **0** | **PASS** |
| Q3 — V1/V2/V3, not Future | Yes | **V1** at three ranks — Master §8 L170, BC Map L134, `ADR-0017` §3 | **PASS** |
| Q4 — owns an aggregate **and** an invariant | Yes | **PASS on three grounds** (§1.2), with the aggregate *name* unresolved as `F-01` | **PASS, qualified** |
| Gate artefact exists on disk | Yes | this file | **PASS** |

### **Stage 1 verdict: PASS.**

`PRD-023` is warranted — and, uniquely among the PRDs taken through this lifecycle, it was **already authorised
before Stage 1 began**. `ADR-0017` is `ACCEPTED` at Rank 2, `MASTER_PRD.md` §8 module 18 is Rank 1, and
`PRD_REGISTRY.md` carries the row at §4.3 and §6. Stage 1's contribution is therefore not the decision but the
**evidence base**: what `BC-25` already is, according to 74 files that reference it.

**14 findings accepted** (`F-01`…`F-14`), **14 candidate findings rejected with reasons** (`R-01`…`R-14`).

**The three facts that most shape Stage 2:**

1. **`E-19` is the core, and it is unspecified.** A constraint binding *every context* exists in one table cell.
   Under `SID-4.56` it is therefore **unmet everywhere**. `PRD-023` exists primarily to make it checkable
   (`F-08`).
2. **`PRD-023` owns machinery for 104 values it does not own.** Eight FROZEN PRDs hold the definitions; a Rank 7
   guide holds the operational detail; sixteen invariants relate them, seven across register boundaries that no
   single owner can see. The machinery is the scope; the values are not (`ADR-0017` §3.1 item 6).
3. **Nothing is built.** No code, no port implementation, no test, no module block — and the architecture test
   that would have caught the orphan port is itself missing (`F-03`, `F-04`, `F-14`).

**The one question Stage 1 hands forward unresolved, on purpose:** whether `BC-25` owns an aggregate, and whether
it is `LibrarySettings`. A frozen Rank 3 document says yes and names it; Rank 4 does not list `BC-25` among its
seventeen aggregates. Deciding this is Stage 3's, and resolving it here — in either direction — would have been
the flattering move.

Stage 1 passing does **not** confer `DISCOVERY` status in the registry, and this record does not claim it.
Registry status is conferred by an edit to `PRD_REGISTRY.md`, which the lifecycle reserves for the controlled
Stage 7 update.

**Proceed to Stage 2 — Draft.**

---

## 11. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-20 | Stage 1 Discovery record created. Four Stage 1 questions answered against cited authority, with question 4 argued on three grounds rather than the single BC Map §8 row its three predecessors used. Gate tested in both halves; the three-state ownership history of `BC-25` transcribed. `ADR-0017` §3.1/§3.2 quoted verbatim as the scope boundary. Nine aspects of `BC-25` discovered and recorded — name, hierarchy, feature flags, branding, `E-19`, `LCFG-*` semantics, invariant surface, module/port, event surface. Fourteen exclusion candidates named with owners; reciprocity verified exact in five directions. Prefix `CNF-` selected after testing five candidates in both directions; `CNF-EVT-*` identified for **EMPTY** declaration. 23 mechanical measurements recorded, two of which corrected earlier working figures (`BC-25` pressure 46 → **74**; next free block `IMPL-1030` → **`IMPL-1100`**). 14 findings accepted with evidence, severity, owner and disposition; 14 candidate findings recorded as rejected with reasons. `F-01` (the `LibrarySettings` aggregate question) and `F-02` (the EA V1/V2 conflict) deliberately **carried unresolved** to Stage 3. `F-13` records a governance defect in `DOCUMENTATION_BASELINE.md` §4, reported and **not repaired**. Verdict **PASS** |
