# `PRD-004` Traceability Entries — Student Management & Library Members Directory

| Field | Value |
|---|---|
| **Document** | Traceability entries for [`Student_Management_PRD_v1.md`](Student_Management_PRD_v1.md) (`PRD-004`) |
| **Version** | v1.1 |
| **Status** | Supporting record. **Not ranked**, therefore editable without an ADR |
| **Date** | 2026-08-04 *(corrected same day by the `PRD-004` correction pass — findings `RF-04`, `RF-07`)* |
| **Baseline** | `BASELINE-2026-08-04-B` |
| **Purpose** | Phase 20 deliverable 4. Maps every `PRD-004` identifier group to its authoritative source, and records the prefix inventory destined for [`TRACEABILITY_MATRIX.md`](../../40-implementation/TRACEABILITY_MATRIX.md) §2C |
| **Precedence** | Below every document it cites. Where this file disagrees with `PRD-004`, **`PRD-004` is right and this file is a defect** |
| **Governing principle** | `SID-4.56` — *"A rule that cannot be checked SHALL be treated as unmet, not as satisfied by intent."* |

---

## 1. Prefix inventory — the §2C payload

Ten new registers, **248** identifiers, added to a repository that already carried **2,282** (`1,517`
authentication + `≈422` Library + `343` Student Identity).

| Prefix | Meaning | Count | Range | Chapter |
|---|---|---|---|---|
| `SM-c.n` | Functional requirement | **107** | `SM-1.1` … `SM-10.12` | 1–4, 6–8, 10 |
| `SM-BR-n` | Business rule | **16** | `SM-BR-1` … `SM-BR-16` | §9.1 |
| `SM-XC-n` | Exclusion — must be impossible | **14** | `SM-XC-1` … `SM-XC-14` | §1.5 |
| `SM-INV-n` | Domain invariant | **11** | `SM-INV-1` … `SM-INV-11` | §2.6 |
| `SM-EV-n` | Domain event (**closed set**) | **10** | `SM-EV-1` … `SM-EV-10` | §7.4 |
| `SM-PO-n` | Protected operation (**closed list**) | **12** | `SM-PO-1` … `SM-PO-12` | §8.2 |
| `SM-AC-n` | Acceptance criterion | **30** | `SM-AC-1` … `SM-AC-30` | §10.4 |
| `SMCFG-n` | Configurable parameter | **7** | `SMCFG-1` … `SMCFG-7` | §10.3 |
| `LMD-n` | **Library Members Directory requirement** | **31** | `LMD-1` … `LMD-31` | 5 |
| `SM-GAP-n` | **PROPOSED GAP** — no authoritative source | **10** | `SM-GAP-1` … `SM-GAP-10` | §10.6 |

**Total 248 base identifiers**, plus **15 sub-lettered clarifications** added by the 2026-08-04 correction pass
(`PRD-004` §0.2), giving **263** normative identifiers in total. Verified mechanically, not counted by hand.

> **Corrected 2026-08-04 (finding `RF-04`).** This table previously declared **242** over the pre-correction
> ranges. The independent review found that this document and `PRD-004` §7.4 disagreed about the event register,
> which made one of them wrong by construction. `PRD-004` is the specification and this document is derived from
> it, so the derived document was corrected — never the reverse.

> ⚠ **The declared count was wrong on first draft, and validation is what found it.** §0 of `PRD-004` originally
> declared **118** `SM-c.n` over `SM-1.1` … `SM-10.6`. A regex count returned **105** over `SM-1.1` … `SM-10.10`,
> making the total **242**, not 246. **The register was corrected to match the chapters; no filler requirement was
> added to reach 118.** Padding would have satisfied the number and corrupted the specification.

**Chapters 5 and 9 hold no `SM-c.n` by design** — chapter 5 numbers in `LMD-n` so a read-composition requirement
can never be mistaken for a `BC-01` domain requirement, and chapter 9 numbers in `SM-BR-n`.

### 1.1 Collision check — result and method

**Zero collisions.** Checked against every existing register:

| Checked against | Prefixes | Result |
|---|---|---|
| Authentication (`PRD-001`) | `AUTH-c.n`, `BR-c.n`, `XC-c.n`, `AC-c.n`, `PR-n`, `TR-n`, `EV-n`, `AERR-n`, `CFG-n`, `SO-n`, `PP-n`, `AU-n`, `EP-n` | ✅ no overlap |
| Library (`PRD-002`) | `LIB-n.m`, `LIB-14B.n`, `LCFG-n`, `LXC-n`, `LEV-n`, `LAC-n` | ✅ no overlap |
| Student Identity (`PRD-003`) | `SID-c.n`, `SID-BR-n`, `SXC-n`, `SPO-n`, `SEV-n`, `SID-INT-n`, `SID-INV-n`, `SCFG-n`, `SID-AC-n` | ✅ no overlap |

Command used, and its output:

```
grep -rIno "\(^\|[^-A-Za-z]\)SM-[0-9]\+\.[0-9]\+" docs --include=*.md | grep -v student-management/   → (empty)
grep -rIno "\(^\|[^-A-Za-z]\)SM-\(BR\|PO\|AC\|EV\|XC\|INV\|GAP\)-[0-9]" … | grep -v student-management/ → (empty)
grep -rIno "\bLMD-[0-9]"    docs --include=*.md | grep -v student-management/ → (empty)
grep -rIno "\bSMCFG-[0-9]"  docs --include=*.md | grep -v student-management/ → (empty)
```

### 1.2 Three near-collisions, recorded because they nearly happened

| Near-collision | Why it was avoided |
|---|---|
| `BR-n` | Already the Authentication business-rule prefix (**297** rules). This PRD uses **`SM-BR-n`**, never the bare form |
| `PO-n` | Already Authentication's; Student Identity had already added `SPO-n` to disambiguate. This PRD uses **`SM-PO-n`** |
| **`MP-SM-0n`** | A **broad `SM-` grep matches `MP-SM-01`…`MP-SM-09`** in `MASTER_PRD.md` lines 653–661. Inspected: those are **Certified Metric** IDs under prefix `MP-SM-`, not requirements. A strict word-boundary grep returns empty ⇒ **true negative, not a suppressed hit** |

> The third row is why the loose grep was not simply accepted as a failure. A checker that cannot tell a real
> collision from a substring is a checker that gets disabled.

---

## 2. Requirement-group traceability

Every group below cites a document of **higher rank** than `PRD-004` (a `DRAFT` aspiring to Rank 3).

| Group | Traces to | Rank of source |
|---|---|---|
| §1 ownership, `SM-XC-*` | Master PRD §8 modules 3–4 · BC Map lines 96, 209, 370, §4.1 `ID-1`…`ID-6` · `X-05`, `X-13` · `LIB-4.1`, `LIB-5.1` | 1, 3, 4 |
| §2 lifecycle, `SM-INV-*` | **BC Map line 209** (closed status set), line 370 (invariants) · `MP-GBR-14`, `MP-GBR-16`, `MP-GBR-19` · `ID-5` | 1, 4 |
| §3 registration | **`AR-2`** · `ADR-0011`, `MP-GBR-02` · `E-11`, `E-13` · `MP-ASM-04` · `MP-GBR-18` | 1, 2, 5 |
| §4 profile/guardian/documents | **`SID-2.8`** (normative ownership) · `E-22`, **`ADR-0016`** · `ID-6` | 2, 3, 4 |
| **§5 Directory `LMD-1`…`LMD-31`** | **Master PRD §8 module 3** *(read composition)* · **`AR-1`** · **`SID-2.38`–`SID-2.41`** · `LIB-16.6`, `LCFG-5`, `AP-3` · `14B` line 173 · `E-21` | 1, 3, 5, 7 |
| §6 operations | BC Map line 96 · `ID-2` · `MP-GBR-19` | 1, 4 |
| §7 integrations, `SM-EV-*` | BC Map §7 edges `E-01`, `E-09`, `E-11`, `E-13`, `E-21`, `E-22` · **line 292** · rule `F-3` | 4 |
| §8 security/audit, `SM-PO-*` | `LIB-4.1`, `LIB-4.2` · `AUTH-7.13`, `AUTH-7.16`, `AUTH-7.21` · `X-10`, `X-13` · `CFG-12` | 3, 4 |
| §9 rules, edge cases | `MP-GBR-03`, `MP-GBR-14`, `MP-GBR-16`, `MP-GBR-18`, `MP-GBR-19` · BC Map line 209 | 1, 4 |
| §10 data/API/config | `X-13` · `E-19`, **`ADR-0013`** · `LIB-16.2` pattern | 2, 3, 4 |

**Coverage — see `PRD-004` §10.5.1, which is authoritative.** The table above shows that every *requirement
group* names a higher-ranked source. It does **not** establish a per-identifier coverage percentage, and an
earlier version of this document wrongly presented one (**"233 of 242, 96.3%"**) as if it did. That figure is
**withdrawn**: it was inferred from a ten-row group table, so it could not have been measured.

The replacement figure is computed per identifier by `tool/docs_check/prd004_traceability.py` and published in
`PRD-004` §10.5.1. **The computed figure is lower than the withdrawn claim.** The `SM-GAP-*` set remains excluded
from the denominator, because carrying no source **by definition** is what makes them gaps rather than
requirements. Finding `RF-07`.

### 2.1 The Directory's traceability, stated precisely

`LMD-1`…`LMD-31` are the requirements a reviewer is most likely to suspect of being invented, since the brief
asked for a whole PRD's worth of them. Their sources:

| Requirement | Verbatim source |
|---|---|
| `LMD-1` — no aggregate | `AR-1`: a read composition *"owns no aggregate, no invariant, no business state"* |
| `LMD-2` — no persisted member row/table/cache | `SID-2.38` (read-only composition pattern) |
| `LMD-3` — no independent invariant | `AR-1` |
| `LMD-4`–`LMD-7` — visibility gating | **`LCFG-5`**: member directory, default **Disabled**, `AP-3` deny-by-default |
| `LMD-5` — disabling suppresses without deleting | **`LIB-16.6`**, adopted as a **verbatim** requirement |
| `LMD-12`–`LMD-14` — search | `E-21` → `BC-23` Search Indexing |
| `LMD-16`, `LMD-26` — membership/expiry display | `BC-02` projection; BC Map line 209 keeps the two state machines separate |
| `LMD-18`–`LMD-22` — per-caller authorisation | `SID-2.39`; `LIB-4.1` closed role set |
| `LMD-23`–`LMD-24` — graceful degradation | `SID-2.40` |
| tenancy | `14B` line 173: *"Member Directory in any form → `LCFG-5`, tenant-private"* |
| placement | `SID-2.41` — **not in the domain layer**, consistent with `AR-1` |

---

## 3. ADR traceability

| ADR | Status | Applied where |
|---|---|---|
| `ADR-0011` Global Person Identity | Accepted | `SM-1.2`, `SM-1.4`, `SM-3.3` — non-nullable `PersonId` via `E-13`; `1:1` `Account`↔`Person` |
| `ADR-0013` Capability-context ownership | Accepted | §10.3 — `BC-25` config reached via `E-19`, owned by `PRD-023`, not by this module |
| `ADR-0016` `E-22` consumer list includes `BC-10` | Accepted | `SM-4.9`–`SM-4.12` — documents as `FileRef`, never bytes |

**No new ADR is required by `PRD-004`, and none is proposed.** Every conflict found during alignment was resolved
**toward** the frozen architecture (see [`PRD-004_ALIGNMENT_REPORT.md`](PRD-004_ALIGNMENT_REPORT.md) §3), so
nothing was overridden. An ADR would be needed only to *change* BC Map line 209, line 292, `AR-1` or `SID-2.8` —
and `PRD-004` changes none of them.

---

## 4. Event traceability — closed set of ten

Reproduced from `PRD-004` §7.4, which is authoritative. All names carry the `enrollment.` context prefix required
by **BC Map §8** (`<Context>.<Aggregate><PastTenseVerb>`).

| ID | Event | Consumer | Edge |
|---|---|---|---|
| `SM-EV-1` | `enrollment.StudentEnrolled` | `BC-02`, `BC-23` | `E-01`, `E-21` |
| `SM-EV-2` | `enrollment.StudentStatusChanged` | `BC-02`, `BC-04`, `BC-23` | `E-01`, `E-21` |
| `SM-EV-3` | `enrollment.StudentArchived` | `BC-05`, `BC-02`, `BC-23` | `E-09`, `E-21` |
| `SM-EV-4` | `enrollment.StudentRestored` | `BC-02`, `BC-23` | `E-01`, `E-21` |
| `SM-EV-5` | `enrollment.StudentProfileUpdated` | `BC-23` | `E-21` |
| `SM-EV-6` | `enrollment.GuardianLinkChanged` | `BC-22` | `E-23` |
| `SM-EV-7` | `enrollment.StudentDocumentAttached` | `BC-23` | `E-21` |
| `SM-EV-8` | `enrollment.StudentDocumentRemoved` | `BC-23` | `E-21` |
| `SM-EV-9` | `enrollment.EnrollmentNumberAssigned` | `BC-23` | `E-21` |
| `SM-EV-10` | `enrollment.StudentLinkedToPerson` | `BC-10` **via ACL** | `E-13` |

> **Corrected 2026-08-04 (findings `RF-04`, `RF-02`, `RF-03`).** The previous version of this table listed nine
> events, placed `StudentLinkedToPerson` at `SM-EV-4`, and omitted the `enrollment.` prefix — all three disagreeing
> with `PRD-004` §7.4. `StudentLinkedToPerson` is now `SM-EV-10` in the PRD, and the five events this table had
> collapsed into a single `SM-EV-5`…`SM-EV-9` row are enumerated individually, because a summary row cannot be
> traced.

Cross-checked against `PRD_DEPENDENCY_GRAPH.md` line 154, which already lists `StudentEnrolled`,
`StudentProfileUpdated`, `StudentStatusChanged` and `StudentLinkedToPerson` for `BC-01` (`PRD-004`). **The graph
predicted these events before this PRD existed; the PRD did not invent them** — which is precisely why
`SM-EV-10` had to be *added* to the PRD rather than treated as a new design (`RF-02`).

**`SM-AC-28` guards the boundary:** no `StudentRecordId` in any global event or index — it is tenant-scoped
(`ID-4`). `SM-7.12b` applies the same limit to `SM-EV-10`'s payload.

---

## 5. Configurable-parameter traceability

| ID | Parameter | Source | Default |
|---|---|---|---|
| `SMCFG-1` | Directory enabled | **`LCFG-5`** (consumed, not redefined) | **Disabled** (`AP-3`) |
| `SMCFG-2` | Directory page size | `LMD-*` pagination | as declared §10.3 |
| `SMCFG-3` | Near-expiry warning window | `BC-02` projection | as declared §10.3 |
| `SMCFG-4` | Bulk operation cap | `LMD-30`, `LMD-31` | as declared §10.3 |
| `SMCFG-5` | `enrollmentNumber` pattern | ⚠ **placeholder** — see `SM-GAP-2` | undecided |
| `SMCFG-6` | Guardian-required age threshold | `SM-INV-4`, BC Map line 370 | 18 |
| `SMCFG-7` | Document count limit | `SM-4.*` | as declared §10.3 |

All are read through `E-19` from `BC-25`. **`SMCFG-1` does not duplicate `LCFG-5`** — it *is* `LCFG-5`, consumed.
`SMCFG-5` is explicitly flagged as a placeholder rather than presented as a decision.

---

## 6. Test traceability — what is asserted vs. what is executable

| Assertion | Checkable today? | By what |
|---|---|---|
| Boundary rules (`L1`–`L5`) | ✅ **yes** | `dart run tool/check_module_boundaries.dart` (gate 3) |
| Tenant key on all access (`X-13`) | ✅ **yes** | checker `_checkTenantKey`, category 12 |
| Audit append-only (`X-10`) | ✅ **yes** | checker `_checkAuditMutation` |
| No `library_member` table (`SM-10.6`, `OWN-4`) | ❌ **not yet** | becomes executable at `IMPL-302` (schema scan) |
| `personId` never exported (`SM-AC-28`, `OWN-6`) | ❌ **not yet** | becomes executable at `IMPL-316` |
| 30 `SM-AC-*` criteria | ❌ **not yet** | zero tests written; `IMPL-300`…`IMPL-323` unstarted |

> **Stated plainly:** of the 30 acceptance criteria, **0 are currently executed by any test.** Three
> architecture-level rules the PRD relies on *are* enforced today, and they were enforced before this PRD existed.
> Per `SID-4.56`, the remaining 27 are **unmet**, not "satisfied by design."

---

## 7. What this document does **not** claim

| Not claimed | Actual state |
|---|---|
| That `TRACEABILITY_MATRIX.md` §2C already exists | **It does not.** §1 here is the payload prepared for it; the matrix edit is a separate, pending change |
| That coverage means correctness | A coverage figure means an identifier **names** a source. It does not prove the requirement is the right one |
| That this document measures coverage | **It does not.** §2 is a group-level map. The per-identifier figure is computed in `PRD-004` §10.5.1 by `tool/docs_check/prd004_traceability.py` |
| That the 10 gaps will be filled | They are open. A source must appear **before** a requirement |
| That any `SM-AC-*` passes | **None is executed.** §6 |
| That gate 3 is green | **Legitimately red** — 9 `cross-context` violations owned by `TASK-D10`/`BLK-01`, unrelated to `PRD-004`, **not waived** |

---

## 8. Change history

| Version | Date | Change |
|---|---|---|
| v1.1 | 2026-08-04 | **Corrected by the `PRD-004` correction pass.** Three defects, all found by independent review, all resolved by correcting *this* file rather than the PRD — as the Precedence row above requires. (1) `RF-04`: §4 listed **nine** events, placed `StudentLinkedToPerson` at `SM-EV-4`, omitted the BC Map §8 `enrollment.` prefix, and collapsed five events into one untraceable summary row; it now reproduces `PRD-004` §7.4 exactly, with `SM-EV-10` and all ten names enumerated. (2) `RF-07`: the **"233 of 242, 96.3%"** coverage claim is **withdrawn** — it was inferred from a ten-row group table and therefore was never measured; §2 now states plainly that this document maps *groups*, and points to `PRD-004` §10.5.1 where the figure is computed per identifier by `tool/docs_check/prd004_traceability.py`. The computed figure is **lower** than the withdrawn claim. (3) Stale counts refreshed to the post-correction registers: **248** base identifiers (was 242) plus 15 sub-lettered clarifications, `SM-c.n` 105→107, `SM-EV-n` 9→10, `SM-AC-n` 28→30, `SM-GAP-n` 9→10, tasks `IMPL-300`…`IMPL-323`. **No requirement was invented and no count was padded**; every changed number is reproduced by the checker. |
| v1.0 | 2026-08-04 | Created as Phase 20 deliverable 4. Records the ten new registers (**242** identifiers) as the payload for `TRACEABILITY_MATRIX.md` §2C, with a **zero-collision** result proved by quoted commands and three near-collisions documented — including `MP-SM-0n` in `MASTER_PRD.md`, confirmed a **true negative** by strict word-boundary grep rather than dismissed. Discloses that §0 of `PRD-004` first declared **118** `SM-c.n` (actual **105**, total **242** not 246) and that **the register was corrected rather than the chapters padded**. Maps all ten requirement groups, 3 ADRs, 9 events, 7 configurables to higher-ranked sources, and states that **0 of 28 acceptance criteria are currently executed**. |
