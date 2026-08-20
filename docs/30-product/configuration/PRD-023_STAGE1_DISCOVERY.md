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
