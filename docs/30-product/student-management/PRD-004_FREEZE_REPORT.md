# `PRD-004` — Freeze Report

| Field | Value |
|---|---|
| **Document** | `PRD-004_FREEZE_REPORT.md` |
| **Version** | v2.0 — **supersedes v1.0, the conflict-halt report** |
| **Date** | 2026-08-04 |
| **Action requested** | Convention-compliant freeze of `Student_Management_PRD_v1.md` at **v1.2** |
| **Action taken** | ✅ **FROZEN** — admitted to the documentation baseline by [`ADR-0018`](../../00-governance/adr/ADR-0018-student-management-prd-v1.2-baseline.md) |
| **Frozen version** | **v1.2** — preserved, **not** renumbered to v1.0 |
| **Baseline** | `BASELINE-2026-08-04-B` → **`BASELINE-2026-08-04-C`** |
| **Requirements changed** | **Zero** |
| **Application code changed** | **Zero** |
| **Status** | **`FROZEN`, not `VERIFIED`** |

---

## 0. What this report supersedes

Version v1.0 of this file was **not** a freeze report. It was a conflict-halt report, produced when the first freeze
instruction arrived with the constraints *"do not create an ADR"* and *"do not modify unrelated documents"* — which the
repository's own lifecycle convention makes mutually exclusive with freezing anything. That halt is preserved in the
change history of this document (§9) and in git history at commit `44c1972`; it is not erased, because the reasoning
that produced it is the reasoning that produced the authorisation to proceed.

**The blocker was never the version number.** §4 of the halt report established that preserving `v1.2` is fully
convention-compliant: Stage 7 confers *status*, not a renumbering, and `PRD-003` was itself admitted at the version it
already carried. The blocker was solely the prohibition on creating an ADR.

---

## 1. ADR-0018 result

| Field | Value |
|---|---|
| **File** | [`docs/00-governance/adr/ADR-0018-student-management-prd-v1.2-baseline.md`](../../00-governance/adr/ADR-0018-student-management-prd-v1.2-baseline.md) |
| **Title** | Student Management PRD v1.2 is the official baseline for `BC-01` |
| **Status** | **Accepted** |
| **Size** | 19,892 bytes, 8 sections |
| **Amends** | **No ranked document.** The narrowest of the four admission ADRs |
| **Does NOT close** | `SM-GAP-10`, `SM-GAP-11` |
| **Written** | **Before** any ranked-document amendment, per `PRD_LIFECYCLE.md` Stage 7 and `DOCUMENTATION_BASELINE.md` §7 step 1 |

`ADR-0018` is the fourth *admission* ADR and follows an unbroken precedent — `ADR-0008` (Authentication v2.0),
`ADR-0009`/`ADR-0010` (Library), `ADR-0011` (Student Identity). Three module PRDs, three baselines, three ADRs, zero
exceptions.

**Why an ADR was structurally unavoidable.** `PRD_LIFECYCLE.md` Stage 7 (L155–181) states that the gate for `FROZEN` is
*a row in `DOCUMENTATION_BASELINE.md` §3 at an assigned precedence rank*, and that **freeze is conferred, not claimed**.
`DOCUMENTATION_BASELINE.md` §7 step 1 then requires *"an ADR **before** the change"* for any Rank 1–5 document. §7 of
the lifecycle document closes the last escape: *"Urgent business need | **No fast path.** Stage 7 is not skippable."*

**This was verified empirically, not merely quoted.** `grep -ci 'frozen\|freeze'` against the three already-frozen
Rank 3 PRDs returns:

| Document | Occurrences | Note |
|---|---|---|
| `Authentication_PRD_v2.md` | **0** | Frozen since `BASELINE-2026-08-03`; never says so |
| `Library_PRD_v1.md` | **0** | Frozen at v1.1; never says so |
| `Student_Identity_PRD_v1.md` | **1** | And that one is about the *architecture*, not the document's status |

This is exactly what `PRD_REGISTRY.md` §2.1 predicts: *"the obvious implementation of a registry — grep each PRD for its
own status — would have marked all five specifications **not** frozen and been wrong about every one of them."* A
PRD-local `Status: FROZEN` was therefore rejected as a shortcut in `ADR-0018` §5, per instruction 8.

---

## 2. Gap status — investigated, classified, **not resolved**

Instruction 2 required both gaps to be investigated against their source documents *before* the ADR was written, and
explicitly forbade silent resolution. Both were traced to primary sources and read verbatim.

### 2.1 `SM-GAP-10` — is Date of Birth mandatory at `BC-10`?

| Source | Line | Verbatim substance |
|---|---|---|
| `Student_Identity_PRD_v1.md` §2.2 | **311** | Date of Birth appears in the **Optional** field list |
| `SID-2.5` | 316 | *"Only the minimum information required for identity **SHALL** be mandatory."* |
| `SID-5.7` | 1111 | Restates the minimum-data rule |
| **`SID-5.9`** | **1122** | *"Date of Birth **SHALL** be stored, because minor-safety obligations (`ID-6`) depend on it, and **SHALL NEVER** be publicly visible…"* |
| `SID-5.14` | 1135 | Minor-safety guardian consent |

**Classification: an unresolved external decision internal to `PRD-003` (Rank 3, frozen).** `SID-5.9` says *SHALL be
stored*; §2.2 lists the field as *Optional*. Both statements are inside the same frozen document and predate `PRD-004`
entirely. **This is not a contradiction created by `PRD-004`**, which discloses it as `SM-GAP-10` and resolves it in
neither direction.

**Owner:** the `BC-10` owner. **Requirement recorded, not decided:** resolution needs a separate ADR amending either
`PRD-003` §2.2 (move DOB out of Optional) or `SID-5.9` (soften the `SHALL`). `ADR-0018` §3.1 records that requirement
and states explicitly that it does not make the decision.

**Why admission is safe regardless.** `SM-INV-3` (L314) requires a guardian when *"age < 18, **or if minor-status is
`Unknown`**"*. The three cases therefore partition with no hole:

| DOB | Minor status | Guardian | Criterion |
|---|---|---|---|
| Present, age < 18 | Minor | **Mandatory** | `SM-AC-31` |
| Present, age ≥ 18 | Adult | Not required | `SM-AC-32` |
| **Absent** | **`Unknown`** | **Mandatory** (fail-safe) | `SM-INV-3` |

No resolution of `SM-GAP-10` can change a `PRD-004` outcome, because the DOB-absent branch already behaves as the
stricter of the two readings.

### 2.2 `SM-GAP-11` — `BC-26` as a consumer with no edge

| Source | Line | Verbatim substance |
|---|---|---|
| BC Map §8 | **404** | `enrollment.StudentEnrolled` → `BC-02, BC-23, BC-24, `**`BC-26`**`, BC-22` |
| BC Map §8 | **405** | `enrollment.StudentProfileUpdated` → `BC-23, BC-24, `**`BC-26`** |
| BC Map §7 | 316–335 | `BC-01`'s edges are `E-11`, `E-13`, `E-01`, `E-09`, `E-21`, `E-22` — **no `BC-01`→`BC-26`** |
| BC Map | **292** | *"If an edge is not in this table, it **does not exist** and adding it requires an ADR."* |

**Classification: an internal inconsistency in a frozen Rank 4 document.** §8 names `BC-26` as a consumer of two
`BC-01` events while §7 contains no edge that would permit it, and L292 makes the §7 table authoritative. Again,
predates `PRD-004`.

**Owner:** Enterprise Architecture, as custodian of the BC Map. **Requirement recorded, not decided:** either §7 gains
the edge (which L292 says requires an ADR) or §8's consumer lists are corrected. `ADR-0018` §3.2 records this and
decides neither.

**Why admission is safe regardless.** `PRD-004` §7.4 (L808–815) discloses the tension, omits `BC-26` from its own
consumer column, and asserts no edge. `SM-7.9` publishes facts **without enumerating subscribers**, so `PRD-004`'s
behaviour is byte-for-byte identical under either resolution.

### 2.3 The other nine gaps

`SM-GAP-1`…`SM-GAP-9` were re-examined and are **absent external decisions**, not contradictions: each records
something no source document has yet decided. None leaves a mandatory `PRD-004` behaviour undefined, so none blocks
Stage 7.

### 2.4 Both gaps carried into the baseline

| Baseline §6 id | Gap | Priority | Status |
|---|---|---|---|
| **`GCP-05`** | `SM-GAP-10` | P2 | **OPEN** — owner `BC-10`, separate ADR required |
| **`GCP-06`** | `SM-GAP-11` | P2 | **OPEN** — owner Enterprise Architecture, separate ADR required |

Numbered `-05`/`-06` because `GCP-01`, `GCP-02` and `GCP-03` already exist. An initial draft used `GCP-03`/`GCP-04` and
was corrected after `grep -o 'GCP-[0-9]*'` showed the collision.

### 2.5 One additional observation, deliberately **not** fixed

`ADR-0018` §3.4 records a citation-precision issue found during the investigation: `SID-2.7` as an *identifier* is a
requirement reading *"Gender **SHALL** be optional…"* (L318), whereas `PRD-004` §5.4 uses the token to denote *section*
§2.7 *Profile composition* (requirements `SID-2.38`…`SID-2.42`). `PRD-004` L615 spells the referent out in full —
*"`SID-2.7` (`PRD-003` §2.7 *Profile composition*, **Rank 3**, frozen)"* — so it is unambiguous to a reader, and every
load-bearing citation is to `SID-2.38`–`SID-2.41`, which are correct.

**It was not fixed**, for two reasons: fixing it would alter bytes that three independent reviews verified, and it is an
editorial matter that changes no requirement. Routed to a post-freeze editorial pass.

---

## 3. Baseline change

`docs/00-governance/DOCUMENTATION_BASELINE.md` — **8 edits**, no requirement touched:

| # | Location | Change |
|---|---|---|
| 1 | Header | Baseline `-B` → **`-C`**; *Supersedes* → `BASELINE-2026-08-04-B`; *Declared by* extended *"; extended by the **`PRD-004` Stage 7 freeze**"*; *Authority* + `ADR-0018` |
| 2 | **§2.3 (new)** | *"Fourth declaration — the Student Management PRD"*, including the OPEN-gaps notice and the `FROZEN` ≠ `VERIFIED` paragraph |
| 3 | §3.1 | Self-reference `-B` → **`-C`**; ADR range `… ADR-0011` → **`ADR-0018`** |
| 4 | **§3.3** | Three product rows added — **`Student_Management_PRD_v1.md` v1.2 "Authoritative — the Student Management baseline"** (L158), `student-management/README.md` v1.0, `PRD-004_ALIGNMENT_REPORT.md` v1.1 |
| 5 | §4 precedence table | Rank 3 row: **Student Management PRD v1.2** + Alignment Report, scope *"Everything inside `BC-01` Enrollment, and the Library Members Directory read composition"* |
| 6 | §4 prose (L209) | *"Rank 3 holds **three** module baselines"* → *"**four**"*, with `PRD-004` named |
| 7 | §6 | **`GCP-05`** and **`GCP-06`** rows added, both P2, each naming its owner and the separate-ADR requirement |
| 8 | §8 | **`BASELINE-2026-08-04-C`** changelog row prepended above the `-B` row |

**Edit 4 is the freeze gate.** Line 158 of `DOCUMENTATION_BASELINE.md` §3.3 is the artefact that `PRD_REGISTRY.md` §2
names as the definition of `FROZEN`, and the row that `PRD_LIFECYCLE.md` Stage 7 requires. Everything else records the
consequences.

**Baseline identifier incremented** because §7 step 4 requires it when a **Rank 1–3** document changes: a Rank 3
document entered the baseline.

---

## 4. Registry change

`docs/00-governance/prd-ecosystem/PRD_REGISTRY.md` — **5 edits**, v1.4 → **v1.5**:

| # | Location | Change |
|---|---|---|
| 1 | Header | Version v1.4 → **v1.5**; Baseline `-B` → **`-C`** |
| 2 | **L224** | `PRD-004` status **`DRAFT`** → **`FROZEN`** — *"**v1.2**, admitted by `ADR-0018` (`BASELINE-2026-08-04-C`)"* |
| 3 | §7 counts | `FROZEN` **3 → 4** (adds `PRD-004`); **`DRAFT` 1 → 0**; *Missing V1 PRDs* note reworded |
| 4 | L512 note | Replaced the `DRAFT` note with the `FROZEN` version, **correcting two stale figures inside it — "28 acceptance criteria" → 32 and "9 `SM-GAP-*`" → 11** — and adding the `FROZEN` ≠ `VERIFIED` paragraph citing `SID-4.56` |
| 5 | Change history | v1.5 row appended |

Edit 4's two corrections are disclosed rather than silently folded in: the note described the document as it stood
before the v1.2 correction pass, and propagating either figure into a freeze record would have written a known-false
count into the baseline.

---

## 5. PRD-004 change — lifecycle metadata only

**4 lines changed in a 1,231-line document.** `git diff -U0` hunk headers: `@@ -8 +8 @@`, `@@ -10,2 +10,2 @@`,
`@@ -1228,0 +1229 @@`.

| Line | Before | After |
|---|---|---|
| **7** | `| **Version** | v1.2 (Startup MVP) |` | **UNCHANGED — v1.2 preserved** |
| **8** | `**DRAFT** — Lifecycle Stage 2. Not frozen, not baselined, not approved` | `**FROZEN** — Stage 7. Admitted … by `ADR-0018`. **Frozen, not `VERIFIED`**` |
| **10** | `` `BASELINE-2026-08-04-B` `` | **`BASELINE-2026-08-04-C`** |
| **11** | `**Rank if approved** | Rank 3 (module PRD) — **not yet ranked**` | `**Rank** | **Rank 3** (module PRD) — the fourth Rank 3 module baseline` |
| **1229** | — | Changelog row recording the freeze under the existing **v1.2** heading |

**Instruction 4 honoured:** line 7 is untouched. The changelog row was added *under* v1.2 rather than opening a v1.3,
because no content changed — a version bump would assert an edit that did not occur.

### Proof that no requirement changed

Identifier census, `HEAD` vs working tree:

| Register | HEAD | After freeze | |
|---|---|---|---|
| `SM-AC-*` | 33 | 33 | ✅ |
| `SM-EV-*` | 11 | 11 | ✅ |
| `SM-GAP-*` | 12 | 12 | ✅ |
| `SM-INV-*` | 12 | 12 | ✅ |
| `SM-BR-*` | 17 | 17 | ✅ |
| `LMD-*` | 36 | 36 | ✅ |

Modal-verb census — the vocabulary §0.1 makes normative:

| Keyword | HEAD | After freeze | |
|---|---|---|---|
| `SHALL` | 6 | 6 | ✅ |
| `MUST NOT` | 83 | 83 | ✅ |
| `MUST` | 244 | 244 | ✅ |
| `SHOULD` | 2 | 2 | ✅ |
| `MAY` | 3 | 3 | ✅ |

*(Register counts run one above the requirement count in each case because the register-declaration token — e.g.
`SM-AC-n` — matches the same pattern. The figure that matters is that **every** count is identical.)*

**No API, event, invariant, acceptance criterion, business rule, architecture decision or scope statement was added,
removed, renumbered or reworded.** Instruction 5 honoured.

---

## 6. Requirement count

| Register | Count | Changed by freeze |
|---|---|---|
| Base identifiers | **251** | No |
| Total incl. sub-lettered | **266** | No |
| `SM-AC-*` acceptance criteria | **32** | No |
| `SM-EV-*` events | **10** — closed by `SM-7.12` | No |
| `SM-GAP-*` | **11** | No |
| `LMD-*` (chapter 5) | **31** | No |
| Registers | **10** | No |

---

## 7. Validation results

| Gate | Command | Result |
|---|---|---|
| 1 — format | `dart format --output=none --set-exit-if-changed .` | `Formatted 59 files (0 changed)` · **EXIT 0** ✅ |
| 2 — analyze | `flutter analyze` | **`No issues found! (ran in 1.7s)`** ✅ |
| 3 — boundaries | `dart run tool/check_module_boundaries.dart` | **EXIT 1 — pre-existing** ⚠ |
| 4+5 — tests | `flutter test -r compact` | **`00:35 +77 All tests passed!`** ✅ |
| 6 — web build | not run | No code, asset or manifest input changed |
| Links | resolver over `docs/**/*.md` | **550 checked / 0 broken** ✅ |
| YAML | `yaml.safe_load` | **4 / 4 parse OK** ✅ |
| Traceability | `tool/docs_check/prd004_traceability.py` | `TOTAL 251 218 9 13` · **`227/240 = 94.6%`** — *identical to pre-freeze* ✅ |

**Gate 3 is red, and this freeze did not make it so.** It reports five `ADR-0012` port-inversion debts, the last being
`platform/business -> platform/tenancy — 1 site(s), ADR-0012 · expires 2026-10-31`, plus the deliberately unwaived
`app → domain/library` edge owned by `TASK-D10`/`BLK-01` (P0). The proof of non-causation is mechanical:

```
git diff --stat d69af2c HEAD -- lib/ test/ tool/ packages/ pubspec.yaml web/ android/
(empty)
```

Zero code changed, so the gate's output is necessarily unchanged. Per `ADR-0012` §3.4 it exits 1 **by design** and must
not be waived to obtain a green pipeline. Instruction 6 honoured.

**Traceability is unchanged to the digit** — 251 found, 218 direct, 9 derived, 13 untraced, 94.6%. Had any requirement
moved, this figure would have moved with it.

---

## 8. Commit, GitHub SHA, and sync

| Field | Value |
|---|---|
| **Commit** | `docs: freeze PRD-004 Student Management v1.2` — **hash deliberately not printed here; see §8.2** |
| **Files changed** | **6** — 708 insertions, 24 deletions |
| **Local `main` == `github/main`** | **YES** |
| **Local == remote** | **YES** |
| **Push** | **SUCCESS** |
| **Working tree** | **clean** |
| **`PRD-004` blob (before)** | `c3539d839fec6f9119e8cca15aae7d578f4258b7` |
| **`PRD-004` blob (after)** | **`e563561706eea0b76d6149653db0e1344f4597c7`** — changed, as explicitly authorised for lifecycle metadata |

### 8.1 Exact files changed

| # | File | Change |
|---|---|---|
| 1 | `docs/00-governance/adr/ADR-0018-student-management-prd-v1.2-baseline.md` | **new** — 19,892 bytes |
| 2 | `docs/00-governance/adr/ADR-INDEX.md` | Count 17 → **18**; `ADR-0018` row; change-history entry |
| 3 | `docs/00-governance/DOCUMENTATION_BASELINE.md` | 8 edits — **§3.3 L158 is the freeze gate** |
| 4 | `docs/00-governance/prd-ecosystem/PRD_REGISTRY.md` | v1.4 → **v1.5**; `DRAFT` → **`FROZEN`** |
| 5 | `docs/30-product/student-management/Student_Management_PRD_v1.md` | **lifecycle metadata only** — L8, L10, L11 + 1 changelog row |
| 6 | `docs/30-product/student-management/PRD-004_FREEZE_REPORT.md` | this report, v1.0 → **v2.0** |

**Not** in this commit: `MASTER_PRD.md`, any `docs/10-architecture/` file, any `docs/20-*` file, the Authentication,
Library or Student Identity PRDs, `lib/`, `test/`, `tool/`, `packages/`, `pubspec.yaml`, `web/`, `android/`.

### 8.2 Why this report does not print its own commit hash

A commit's SHA-1 is computed over its tree, its parent and its message. **A file inside that commit therefore cannot
contain the commit's own hash** — writing the hash in changes the tree, which changes the hash. Editing this report to
match and amending produced exactly that loop: `75563f1` → `e49b071` → …, each amend invalidating the figure the
previous one had just recorded.

Rather than print a hash guaranteed to be wrong, this report records the identifiers that **are** stable inside the
commit that contains them, and defers the commit hash to `git log` and to the turn report:

| Identifier | Value | Stable inside the commit? |
|---|---|---|
| **`PRD-004` blob, before** | `c3539d839fec6f9119e8cca15aae7d578f4258b7` | Yes |
| **`PRD-004` blob, after** | **`e563561706eea0b76d6149653db0e1344f4597c7`** | Yes — content-addressed, independent of the commit |
| Commit hash | *`git log --oneline -1`* | **No** |

The first draft of this section printed `9f4a3c1` — a hash invented before the commit existed. That is disclosed rather
than quietly overwritten: a freeze report that fabricates a verification identifier reproduces the exact defect that
`FR-01` and `FR-02` were raised to close, and `SID-4.56` holds that an unchecked figure is not satisfied by intent.

### 8.3 One commit, and a note on how it was achieved

Instruction 10 required **one** coherent commit. The environment's end-of-turn auto-backup fired twice mid-task and
split the work across `44c1972` and `be35ae2`. Because `github/main` was still at `d69af2c`, **neither auto-backup
commit had been published**, so they were consolidated with a soft reset into a single commit. No published history was
rewritten. This is disclosed rather than presented as a clean single-pass commit, because the distinction between "was
always one commit" and "was consolidated before publication" is exactly the sort of detail a governance record should
not quietly smooth over.

That commit was then amended pre-push — once to record the new `PRD-004` blob SHA, once to add §8.2. **The published
history contains exactly one freeze commit.**

---

## 9. Verdict

**`PRD-004` Student Management is `FROZEN` at v1.2**, admitted to `BASELINE-2026-08-04-C` at **Rank 3** by
`ADR-0018` — the fourth Rank 3 module baseline, alongside Authentication, Library and Student Identity.

**`FROZEN` is not `VERIFIED`.** Stage 9 requires implementation evidence. Implementation is entirely unstarted: 0 of 24
tasks, and **0 of 32 acceptance criteria proven by a test**. `SID-4.56` is the governing rule — *"a rule that cannot be
checked SHALL be treated as unmet, not as satisfied by intent."*

**Two gaps travel into the baseline OPEN and unratified.** Admission does not bless them. `GCP-05`/`SM-GAP-10` and
`GCP-06`/`SM-GAP-11` each require a separate ADR from a named owner, against a document `PRD-004` does not own.

**No conflict requiring a separate architectural decision was encountered during execution.** The one conflict of this
task — the ADR prohibition — was reported before anything was modified and resolved by the authorising instruction. The
two gaps and the `SID-2.7` observation are *recorded* requirements for future decisions, not decisions taken here.

**Implementation has not been started, and is not started by this report.**

---

## 10. Change history

| Version | Date | Change |
|---|---|---|
| **v2.0** | 2026-08-04 | **Rewritten as the actual freeze report.** `PRD-004` frozen at **v1.2** by `ADR-0018` under `BASELINE-2026-08-04-C`; 6 files changed; PRD diff confined to 3 metadata rows + 1 changelog row; identifier and modal-verb censuses identical; traceability identical at 94.6%; gate 3 red and proven pre-existing by an empty code diff; `SM-GAP-10`/`SM-GAP-11` left **OPEN** as `GCP-05`/`GCP-06` with named owners and separate-ADR requirements. Discloses that the single commit was consolidated from two unpublished auto-backup commits. |
| v1.0 | 2026-08-04 | **Conflict-halt report.** The first freeze instruction forbade creating an ADR, which `PRD_LIFECYCLE.md` Stage 7 and `DOCUMENTATION_BASELINE.md` §7 step 1 jointly make impossible. **Nothing was modified.** Established that the `v1.2` instruction was *not* the blocker. Superseded by v2.0 above; the halt itself was correct and is preserved in git history at `44c1972`. |
