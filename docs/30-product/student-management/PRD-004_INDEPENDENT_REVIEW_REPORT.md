# `PRD-004` Student Management — Independent Review Report

| Field | Value |
|---|---|
| **Document** | Independent Review Report — `PRD-004` Student Management (`BC-01` Enrollment) |
| **Subject** | [`Student_Management_PRD_v1.md`](./Student_Management_PRD_v1.md) v1.0 `DRAFT`, 899 lines, 53,083 bytes |
| **Subject commit** | `11aae01` — verified present on `github/main` |
| **Review date** | 2026-08-04 |
| **Reviewers** | Principal Product Architect · DDD/Bounded Context Architect · Senior BA/Requirements Engineer · Enterprise SaaS Architect · QA & Acceptance Criteria Expert · Security & Privacy Architect |
| **Review type** | **Independent audit.** The prior completion report was not used as evidence |
| **Status of this document** | Review record. **Not ranked, not normative.** It changes no requirement |
| **Governing principle** | `SID-4.56` — *"A rule that cannot be checked SHALL be treated as unmet, not as satisfied by intent."* |

> **Method.** Every claim below was re-derived from the live repository with `git`, `grep`, `sed` and a
> Python recount. Where this report disagrees with the previous completion report, the repository was
> treated as correct and the disagreement is recorded as a finding. **No finding appears without evidence
> that a third party can re-run.**

---

## 1. Executive Verdict

### **C. REQUIRES MAJOR CORRECTIONS**

`PRD-004` is a **structurally sound document with three defects that cannot be closed by editing prose.**

The central architectural decision under review — that the **Library Members Directory is a read
composition inside `BC-01`, not a bounded context, not an aggregate, not a second member store** — is
**correct and well evidenced.** It is anchored in Master PRD §8 line 155 (*"Library Member Directory —
`BC-01` Enrollment (read composition)"*), ruling `AR-1`, and `SID-2.38`–`SID-2.41`. The review found **no
`LibraryMember` aggregate, no member table, no second membership state machine, no `BC-32`, and no new
integration edge added to the Bounded Context Map.** On the question the user was most concerned about,
the PRD is right.

The verdict is nevertheless **C**, not **B**, because of three findings:

| # | Finding | Why it is not a wording fix |
|---|---|---|
| **`RF-01`** | **The Directory is required to read four contexts across edges that do not exist**, while `SM-7.1` in the same document forbids exactly that. The PRD contradicts itself. | Resolution requires either an ADR declaring the read edges, or an `AR-1`-style ruling that app-layer read composition is not an integration edge. **A decision outside this PRD is needed.** |
| **`RF-02`** | **The "closed set of nine" events omits `enrollment.StudentLinkedToPerson`, which the Rank 4 Bounded Context Map declares as a `BC-01` event.** A closed set that excludes a higher-ranked document's event is a precedence conflict. | Adding it changes the closed set; `SM-7.12` says that requires an ADR. Removing it from the BC Map would modify a Rank 4 document. **Either path needs a governance decision.** |
| **`RF-06`** | **`SM-INV-3` (guardian mandatory under 18) cannot be evaluated.** It derives age from a `BC-10` Date of Birth that `PRD-003` lists as **Optional**. The PRD specifies no behaviour when DOB is absent. | Per `SID-4.56` this invariant is **unmet, not satisfied by intent** — and it is the minor-safeguarding invariant. A product decision is required. |

**This verdict is not "the PRD is bad."** It is a 242-identifier document whose ten registers recount
exactly, whose prefix collisions are genuinely zero, and which correctly refused to invent nine decisions
the repository does not make. Most enterprise PRDs of this size would not survive this recount. The three
findings above are the kind that only appear when someone actively tries to disprove the document — which
is what was asked for.

**Answers to the four closing questions** are in §21.

---

## 2. Repository Verification

Independent verification of the subject's existence and reachability. **The user's report of a missing
PRD Index entry was investigated and is partially correct — see `RF-14` and `RF-16`.**

| # | Question | Answer | Evidence |
|---|---|---|---|
| 1 | Does the PRD file physically exist? | **Yes** | `ls -la docs/30-product/student-management/` → `Student_Management_PRD_v1.md`, 53,083 bytes, 2026-08-08 14:12 |
| 2 | Exact path | **`docs/30-product/student-management/Student_Management_PRD_v1.md`** | as above |
| 3 | Tracked by Git? | **Yes**, with all 4 supporting docs | `git ls-files docs/30-product/student-management/` → 5 files |
| 4 | Present on GitHub `main`? | **Yes** | `git ls-tree github/main -r --name-only` → all 5 files. `local HEAD == github/main == 11aae0109c6e2d27f9a761908efc14f5cd0997ec` |
| 5 | Registered in `PRD_REGISTRY.md`? | **Yes** | line 224: `` | `PRD-004` | Student Management | **`BC-01` Enrollment** | `[CORE]` | V1 | **`DRAFT`** — [link] | `PRD-005`…`008`; `IMPL-214` `E-13` ACL | `` |
| 6 | Listed in `docs/README.md`? | **Yes — 9 references**, including a dedicated row per file | lines 63, 101–105, 129, 148, 149 |
| 7 | Does any navigation document omit it? | **Yes — two.** (a) No module-level `README.md` exists, though **all three sibling modules have one**. (b) `PRODUCT_IMPLEMENTATION_ROADMAP.md` line 60 still reads `` | `PRD-004` … `PRD-022` | ⛔ **Do not exist** | ⛔ | 19 missing, all V1 | `` | `ls docs/30-product/*/README.md` → `authentication`, `library`, `student-identity` present; `student-management` **absent** |
| 8 | Is the omission intentional per governance? | **No.** `PRD_LIFECYCLE.md` Stage 2 imposes no index embargo on `DRAFT`. `PRD_REGISTRY.md` v1.4 already publishes the `DRAFT`. The module README and the roadmap row are **staleness, not policy** | `PRD_LIFECYCLE.md` Stage 2 gate text quoted in §18 |
| 9 | Compare against commit `11aae01` | **10 files, +1,790/−13, zero code files.** Working tree clean; no drift | `git show --stat 11aae01` |

**Gate state at review time** (re-run, not quoted from the prior report):

| Gate | Command | Result |
|---|---|---|
| 1 Format | `dart format --output=none --set-exit-if-changed .` | ✅ `Formatted 59 files (0 changed)`, exit 0 |
| 2 Analyze | `flutter analyze` | ✅ `No issues found! (ran in 1.8s)` |
| 3 Boundaries | `dart run tool/check_module_boundaries.dart` | ⛔ **FAIL — 9 cross-context violations, 28 acknowledged-debt findings.** Pre-existing, owned by `TASK-D10`/`BLK-01`, byte-identical to baseline. **Not caused by `PRD-004`, and not waived** |
| — | `git diff 630975e -- lib/ test/` | ✅ **empty** — no application code touched |

**Reviewer note on gate 3.** The user's instruction *"Do not choose A merely because tests pass"* has an
inverse that also matters: gate 3 must not be used to fail this PRD either. It was red before `PRD-004`
existed and is unrelated to it. It is recorded, not charged to this document.

---

## 3. Architecture Boundary Review

**Question: does `BC-01` own only what the authoritative architecture assigns to it?**

Authoritative assignment, verified verbatim:

- **BC Map line 96** — `BC-01` *"Owns the identity and lifecycle of a person as a student of this library:
  registration, profile, status, guardian linkage, documents."*
- **BC Map line 370** — aggregate `StudentRecord`; value objects `ContactDetails`, `GuardianLink`,
  `DocumentRef`, `EnrollmentStatus`; invariants *unique (tenant, enrollmentNumber); at least one
  contactable channel; guardian mandatory if age < 18; cannot Archive with open dues (checked via E-09
  pre-condition)*.
- **`SID-2.8` ownership table (Rank 3, normative)** — `BC-01` owns *"Student Record, organisation profile,
  **Library Identification Photo**, **parent contact**."*

| Assigned responsibility | Claimed by `PRD-004`? | Verdict |
|---|---|---|
| `StudentRecord` aggregate | `SM-1.1`, `SM-2.1` | ✅ Exact match to BC Map line 370 |
| Student lifecycle | `SM-2.5`–`SM-2.16` | ✅ Closed 4-value set matches BC Map line 209 |
| Registration / enrollment | `SM-3.1`–`SM-3.17` | ✅ Correctly subordinated to `AR-2` (*Authentication owns registration*) |
| Organisation-internal profile | `SM-4.1` | ✅ Correctly limited; `SM-4.2` disclaims all `BC-10` fields |
| Guardian linkage | `SM-4.4`–`SM-4.8` | ⚠️ Owned correctly, but **unevaluable** — see `RF-06` |
| Documents | `SM-4.9`–`SM-4.12` | ✅ `FileRef` only via `E-22`; `SM-INV-10` forbids bytes |
| Library Identification Photo | `SM-4.3` | ✅ Correctly distinguished from Global Profile Photo per `SID-BR-8` |
| Relationship to Global Identity | `SM-1.2`–`SM-1.5`, `SM-3.3` | ✅ Non-nullable `PersonId`, resolved through the `E-13` ACL |

### 3.1 The thirteen non-ownership checks

Each area was checked individually for accidental ownership.

| # | Area | Owner | Accidentally owned? | Guarding requirement |
|---|---|---|---|---|
| 1 | Authentication | `BC-18` | **No** | `SM-XC-1`, `SM-INV-11`, `SM-3.1` |
| 2 | Global Identity | `BC-10` | **No** | `SM-XC-2`, `SM-3.2` |
| 3 | Global Profile | `BC-10` | **No** | `SM-4.2` names all nine disclaimed fields |
| 4 | Membership | `BC-02` | **No** | `SM-XC-7`, `SM-2.4`, `SM-6.8`, `SM-2.7` |
| 5 | Seat Management | `BC-04` | ⚠️ **Partially** — `SM-2.14` *commands* seat blocking | `RF-10` |
| 6 | Attendance | `BC-03` | ⚠️ **Partially** — `SM-2.14` commands attendance behaviour | `RF-10` |
| 7 | Fee & Collection | `BC-05` | **No** | `SM-XC-7`; archive block is via `E-09`, correctly *asked*, not decided |
| 8 | Subscription & Billing | `BC-20` | **No** — but also **never explicitly excluded** | `RF-15` (observation) |
| 9 | File & Media | `BC-29` | **No** | `SM-XC-11`, `SM-4.10`, `SM-INV-10` |
| 10 | Social | `BC-11`…`BC-17` | **No** | `SM-XC-10`, `SM-7.9` cite `X-05` correctly |
| 11 | Staff Management | `BC-07`/`BC-18` | **No** | `SM-XC-4`, `SM-8.8` |
| 12 | Manager Management | `BC-07`/`BC-18` | **No** | `SM-XC-5`, `SM-XC-6` (*no role of its own*) |
| 13 | Trust & Safety | `BC-13` | **No** | covered by `SM-XC-10` (`BC-11`…`BC-17` includes `BC-13`) |

**Result: 11 of 13 clean, 2 partial.** The two partials are one requirement, `SM-2.14`, recorded as
`RF-10`. This is a good boundary result — the exclusion register `SM-XC-1`…`SM-XC-14` does real work
rather than decorating the document.

### 3.2 The boundary defect the review did find

`SM-2.14` — *"`Suspended` **MUST** block seat allocation and new membership creation, and **MUST NOT**
block attendance recording. Attendance records and flags (`MP-GBR-16`, `E-03`)."*

Three problems, one requirement:

1. **It legislates for other contexts.** `BC-01` cannot block seat allocation. `BC-04` refuses assignment,
   and it does so on the `MembershipValidity` projection delivered by `E-02` **from `BC-02`** — verified at
   BC Map line 299. A `BC-01` requirement stating what `BC-04` must do is `BC-01` writing another context's
   rules. The correct construction is the one the PRD already uses elsewhere: `BC-01` emits `SM-EV-2`, and
   consumers react (BC Map line 407: *"Suspension cascades to seat release"*).
2. **Its citation does not cover its claim.** `MP-GBR-16` (Master PRD line 357) reads *"A student may not
   be **seated** without a valid **membership**."* It is about **`MembershipStatus`**. `SM-2.14` applies it
   to **`EnrollmentStatus = Suspended`**, a different state machine — the very conflation BC Map line 209
   exists to prevent. `SM-BR-4` cites `MP-GBR-16` correctly; `SM-2.14` over-reaches it.
3. **It contains a sentence fragment.** *"Attendance records and flags"* is not a requirement clause.

Severity **MEDIUM**, not HIGH: the intended behaviour is right and is already correctly expressed by
`SM-BR-4` + `SM-EV-2`. The defect is that `SM-2.14` states it in the wrong voice with the wrong source.

---

## 4. Library Members Directory Review

All **31** `LMD-*` requirements were read in full. The ten mandated checks:

| # | Check | Result | Evidence |
|---|---|---|---|
| 1 | Truly read-composition | ✅ **Pass** | `LMD-1`, `LMD-22`, `SM-1.6` all cite `AR-1`/`SID-2.41`; `IMPL-312` is scoped `app`, not `domain/library` |
| 2 | No aggregate created | ✅ **Pass** | `LMD-1`, `SM-1.7` (*"The member record **IS** the `StudentRecord`"*). Ownership Matrix §2 ends `LibraryMember → does not exist` |
| 3 | No independent invariant | ✅ **Pass** | All 11 invariants sit in §2.6 under `StudentRecord`; **zero** `SM-INV-*` is Directory-scoped |
| 4 | No persisted member entity/table | ✅ **Pass** | `LMD-2` forbids row/table/cache/materialised entity; `SM-10.6` forbids `library_member` and `member_directory`; `SM-AC-18` makes it a schema scan |
| 5 | No second membership state machine | ✅ **Pass** | `LMD-3` explicitly forbids a Directory `MemberStatus` |
| 6 | No independent lifecycle | ✅ **Pass** | No `LMD-*` defines a state, transition or timestamp |
| 7 | Directory never authoritative | ✅ **Pass** | `LMD-24` declares §5.4 normative; `SM-XC-8`, `SM-BR-13`, `LMD-23` (stale must be labelled as-of) |
| 8 | Cross-context data as references/projections | ⚠️ **Partial** | §5.4 is a correct *ownership* table but its **`Edge` column is blank for `BC-03`, `BC-04`, `BC-05`** and wrong for `BC-02` — `RF-01` |
| 9 | Actions never become unauthorized second writers | ✅ **Pass** | `LMD-28` delegates to the owning module's command API citing rule `F-3` — verified at BC Map §7.4: *"the domain re-validating every invariant. The capability is an untrusted caller."* Correct rule, correctly applied |
| 10 | Search/filter/sort/pagination coherent | ⚠️ **Partial** | `LMD-11` and `LMD-15` are not jointly satisfiable — `RF-11` |

**Eight of ten pass cleanly.** This is the strongest chapter in the document. Specifically worth crediting:

- **`LMD-12`** routes search to `BC-23` via `E-21` and quotes the edge's own constraint (*"Search never
  reads domain tables"*) — verified verbatim at BC Map line 330.
- **`LMD-5`** reproduces `LIB-16.6` **verbatim** — confirmed at `Library_PRD_v1.md` line 699.
- **`LMD-4`/`LMD-6`** gate on `LCFG-5` whose default is `Disabled` — confirmed at
  `CONFIGURATION_GUIDE.md` line 341, with the reviewer noting the Guide's own rationale at line 351:
  *"in a domain where the users are largely students and a meaningful share are minors, that is not a
  neutral feature."* The PRD honours the security intent, not just the flag.
- **`LMD-7`** cites `14B` line 173 correctly — verified verbatim.

### 4.1 The seven sensitive field groups

The user asked for special attention to these. Each may be **displayed** but must remain **owned**
elsewhere.

| Field group | Displayed by | Owner per §5.4 | Owner per repository | Verdict |
|---|---|---|---|---|
| Membership status | `LMD-3`, `LMD-25` | `BC-02` | `BC-02` (BC Map line 209) | ✅ Correct, and shown as a **separate** indicator |
| Expiry | `LMD-16`, `LMD-26` | `BC-02` | `BC-02` | ✅ `LMD-16` explicitly forbids computing expiry locally |
| Seat | `LMD-19` | `BC-04` | `BC-04` | ✅ Ownership correct · ⚠️ edge undeclared (`RF-01`) |
| Attendance | `LMD-19` | `BC-03` | `BC-03` | ✅ Ownership correct · ⚠️ edge undeclared (`RF-01`) · formula unowned (`SM-GAP-9`, correct) |
| Fees | `LMD-15`, `LMD-19` | `BC-05` | `BC-05` | ✅ Ownership correct · ⚠️ edge undeclared (`RF-01`) |
| Parent information | `LMD-19`, `SM-4.6` | **This module** | **`BC-01`** — `SID-2.8`: *"parent contact"* | ✅ **Correctly owned here.** Verified against the Rank 3 normative table |
| Documents | `LMD-19` | `BC-29` via `E-22` | `BC-29` | ✅ Correct; `E-22` consumer list includes `BC-01` (BC Map line 331) |

**No field is mis-owned.** The defect is not *who owns what* — it is *by what declared route the Directory
reads it*.

### 4.2 `RF-01` — the finding, stated precisely

`LMD-19` requires member detail to compose **seat (`BC-04`), attendance summary (`BC-03`), fee status
(`BC-05`)**. §5.4 lists those three rows with an **empty `Edge` column**, and lists `BC-02` as *"`E-02`
pattern"*.

Now hold that against three verified facts:

1. **BC Map line 292:** *"If an edge is not in this table, it **does not exist** and adding it requires an
   ADR."*
2. **A full enumeration of all 26 edges** (`awk` over the §7 tables) shows **no `BC-01` → `BC-03`, no
   `BC-01` → `BC-04`, and no `BC-01` → `BC-05` read edge.** `E-09` exists but is a `C/S` **Event** whose
   contract is *"`StudentArchived` → Fee context asserts no outstanding dues"* — an archive pre-condition,
   not a fee-status read.
3. **`E-02` is `BC-02` → `BC-04` Seating**, contract `MembershipValidity{studentRecordId, validUntil,
   seatQuota}` — verified at BC Map line 299. It delivers that projection **to Seating.** Citing *"`E-02`
   pattern"* for a `BC-01` read of membership names an edge that points somewhere else.

And then hold it against the PRD's **own** requirement:

> `SM-7.1` — *"This module **MUST NOT** create an integration edge absent from BC Map §7."*

`LMD-19` and §5.4 require reads that `SM-7.1` forbids. **The document contradicts itself**, and the
contradiction is load-bearing: the Directory's entire value proposition is composing these four contexts.

**Why this is HIGH and not CRITICAL.** There is a defensible reading in which no edge is needed:
`AR-1` established that a read composition *"only orchestrates public read models"* and composed seven
contexts (`BC-19`, `BC-25`, `BC-29`, `BC-06`, `BC-02`, `BC-04`, `BC-23`) **without adding a single edge to
the map.** If app-layer read composition is not an integration edge, §5.4's blank cells are honest and
`SM-7.1` is simply scoped to the domain layer. **But the PRD never says that**, and one of its own
requirements says the opposite. The ambiguity is exactly the class `SID-4.56` refuses to let pass:
a rule that cannot be checked is unmet.

**Recommended disposition:** state the `AR-1` precedent explicitly in §5.4 and scope `SM-7.1` to the
domain layer — **or** raise an ADR declaring the four read edges. **Either is acceptable; leaving it
ambiguous is not.** An ADR is required only on the second path.

---

## 5. Global Identity Review

`PRD-004` compared against `PRD-003` (Rank 3, frozen) and `ADR-0011` (Rank 2, Accepted).

| Check | Result | Evidence |
|---|---|---|
| Global Identity referenced, not duplicated | ✅ | `SM-1.2`, `SM-4.2` disclaims Full Name, Username, Global Profile Photo, Bio, Gender, DOB, Address, Email, Occupation — matches the `SID` optional/mandatory lists at lines 311 and 462 |
| Account identity not recreated | ✅ | `SM-3.1` (*never creates an `Account`*), `SM-XC-1`, `SM-INV-11` |
| Username not re-owned | ✅ | `SM-XC-3` forbids *"a local username"*; `SID-2.8` table assigns Username to `BC-10` |
| OTP/authentication not re-owned | ✅ | `SM-XC-1` cites `ID-1`; `SM-INV-11` makes it a schema property; `SM-AC-4` makes it a scan |
| Global profile data not duplicated | ✅ | `SM-4.3` correctly separates the two photos, matching `SID-BR-8`/`SID-BR-9` |
| `StudentRecord` = library-specific relationship | ✅ | `SM-1.4` (*"One human enrolled at three libraries has three `StudentRecordId`s and one `PersonId`"*) mirrors the `SID` README diagram exactly |
| Deletion/disable coherent | ✅ | `SM-2.16` reproduces `ID-5` correctly: delete `Account`, anonymise `Person`, **retain** history pseudonymised. `SM-XC-14` forbids hard delete outside legal compulsion |
| Multi-library identity consistent | ✅ | `SM-3.15`, `SM-BR-1`, `SM-6.7`; `MP-ASM-04` verified at Master PRD line 538 |
| `ADR-0011` conformance | ✅ | `SM-2.3`, `SM-INV-5`, `SM-BR-11` all require non-nullable `personId`; `MP-GBR-02` verified at Master PRD line 316 |
| `ID-2` reverse-reference prohibition | ✅ | `SM-7.4` and `SM-7.10` both forbid `BC-10` holding a `StudentRecordId`; matches BC Map line 317 |

**No contradiction with `ADR-0011` or any `SID` rule was found.** This chapter is clean.

**One nuance worth crediting.** `SM-6.7` refuses to implement library transfer as a record move, because
`StudentRecordId` never crosses a tenant (`ID-2`). That is a non-obvious consequence of the identity triad
that a weaker document would have gotten wrong by adding a convenient `transferStudent` endpoint. It is
absent, deliberately.

**One nuance that is *not* clean** — see `RF-06`. `SM-4.5` reads age from `BC-10`'s DOB. `PRD-003`
line 311 lists **Date of Birth under "Optional"**, governed by `SID-2.5` (*"Only the minimum information
required for identity **SHALL** be mandatory"*). `SID-5.9` separately says DOB *"**SHALL** be stored,
because minor-safety obligations (`ID-6`) depend on it."* Those two `SID` statements are in tension **inside
`PRD-003` itself** — but from `BC-01`'s side the operative fact is that **DOB presence is not guaranteed**,
and `PRD-004` specifies no behaviour for its absence. Recorded as `RF-06`; the underlying `SID` tension is
recorded as `RF-17` for the `BC-10` owner, **not** charged to this PRD.

---

## 6. Enrollment vs Membership Review

The user flagged this as *"a critical review."* It was run as an adversarial search for coupling, across
all 242 identifiers. **Result: no incorrect coupling found.** This is the document's best chapter and the
finding is reported as a strength, per the instruction not to manufacture defects.

Binding rule, verified verbatim at **BC Map line 209**:

> `| **Status** | BC-01: Active/Inactive/Suspended/Archived enrollment state | BC-02: Valid/Expired/Frozen
> membership state | `EnrollmentStatus` vs `MembershipStatus`. **Two independent state machines** — a
> student can be Active with an Expired membership. |`

| Coupling risk | `PRD-004` position | Verdict |
|---|---|---|
| `Expired` leaking into `EnrollmentStatus` | `SM-2.7` — *"`Expired` **MUST NOT** be an `EnrollmentStatus` value… A student with an expired membership remains `Active`"* | ✅ **Explicitly refused** |
| Closed set drift | `SM-2.5` — exactly `Active`, `Inactive`, `Suspended`, `Archived`; `SM-2.6` rejects `Prospective`/`Registered` | ✅ Matches line 209 exactly |
| Merged UI badge | `LMD-25` — *"**MUST** be displayed as **two** independent indicators. A single merged badge **MUST NOT** be used"* | ✅ The subtlest coupling route, closed |
| Local expiry computation | `LMD-16` — must read the `BC-02` projection, **must not** compute from a local date | ✅ Closed |
| Stored membership state | `SM-2.4` — no `MembershipId`, seat number, attendance total or fee balance as stored state | ✅ Closed |
| Renewal absorbed into `BC-01` | `SM-6.8` — delegated to `BC-02`; *"**MUST NOT** extend a membership term"* | ✅ Closed |
| Payment status conflated | Not modelled anywhere in `PRD-004` | ✅ Correctly absent — `BC-05` owns it |
| Subscription status conflated | Not modelled anywhere | ✅ Correctly absent — `BC-20` owns it |

All three user-named scenarios are satisfiable under the specified rules:

| Scenario | Satisfiable? | By |
|---|---|---|
| Enrolled but membership expired | ✅ | `SM-2.7`, `SM-BR-3`, `LMD-25` |
| Enrolled but membership suspended | ✅ | independent machines; `SM-BR-2` |
| Membership active while payment pending | ✅ | `BC-05` owns payment; `E-10` *"may activate a pending membership"* — `PRD-004` correctly stays out |

**Only defect in this area** is the citation over-reach in `SM-2.14` already recorded as `RF-10` — and note
that it is a *seating* over-reach, not an enrollment/membership conflation. The state machines themselves
are kept apart with unusual discipline.

---

## 7. Requirement Quality Review

All 105 `SM-c.n` plus 31 `LMD-n` were assessed. Aggregate quality is **high**: identifiers are unique
(mechanically confirmed), ranges are contiguous, and normative force is explicit on essentially every
clause.

| Criterion | Result |
|---|---|
| Unique identifier | ✅ **Pass.** Independent recount: `SM-c.n` **105**, `SM-BR` 16, `SM-XC` 14, `SM-INV` 11, `SM-EV` 9, `SM-PO` 12, `SM-AC` 28, `SMCFG` 7, `LMD` 31, `SM-GAP` 9 = **242**, matching the declared total exactly |
| Atomicity | ⚠️ **Mostly.** Multi-clause offenders: `SM-2.14` (3 claims), `SM-3.4` (a 7-step sequence in one ID), `SM-6.1` (8 operations in one ID), `LMD-15` (8 filters in one ID) |
| Testability | ⚠️ Strong for the schema/state rules; weak where a value is undefined (`SMCFG-5` default is *"tenant-prefixed sequence"*, admitted as `SM-GAP-2`) |
| Clear actor | ⚠️ **Systemic gap.** Most requirements are written in the passive institutional voice (*"This module MUST…"*). Actors appear properly in §2.3 and §8.2, but a majority of individual clauses name no actor |
| Clear behaviour | ✅ Pass |
| Clear condition | ✅ Pass |
| Clear outcome | ⚠️ `SM-6.4` says an update to a `BC-10` field *"MUST be rejected with a pointer to `BC-10`"* — "pointer" is undefined (error code? URL? field name?) |
| Ambiguous language | ⚠️ Four instances: *"where the table requires one"* (`SM-2.8`), *"where ordering permits"* (`LMD-11`), *"where it affects a decision"* (`LMD-23`), *"where the entry is an audit fact"* (`SM-6.6`). Each defers a decision without registering a gap |
| Hidden implementation requirement | ⚠️ `LMD-11` mandates **cursor-based** pagination — a design choice, not a requirement. The requirement is *stability under concurrent writes* |
| Duplicate requirement | ⚠️ Three near-duplicate pairs: `SM-1.6`/`LMD-1`; `SM-7.4`/`SM-7.10`; `SM-XC-13`/`LMD-5`. Defensible as chapter-local restatement, but they inflate the count |
| Conflicting requirement | ⛔ **One real conflict:** `SM-7.1` vs `LMD-19`+§5.4 (`RF-01`). Plus one internal inconsistency: `SM-INV-6` vs `SM-10.2` (`RF-13`) |
| Missing normative-language definition | ⛔ **`RF-05`.** `PRD_LIFECYCLE.md` Stage 2 rule 4 requires it. `grep` finds **no** normative-language section; **MUST** appears 125 times, **SHOULD** 0, **MAY** 0. `PRD-003` has §0.1 for exactly this |

**The `SHOULD` = 0 result deserves comment rather than a finding.** A 242-identifier document in which
every single clause is **MUST** is either unusually disciplined or has flattened genuine gradations into
false absolutes. Reading them, the review's judgement is that it is mostly the former — but `LMD-11`
(cursor-based) and `LMD-17` (documented tie-breaker) are the kind of clause that is normally a **SHOULD**,
and stating them as **MUST** makes a design preference unfalsifiable. Recorded as an **OBSERVATION**
(`RF-18`), not a defect.

---

## 8. Requirement Coverage Review

| Class | Count | Detail |
|---|---|---|
| **A. Missing authoritative requirements** | **1** | **`enrollment.StudentLinkedToPerson`** — declared for `BC-01` by BC Map line 408 and `PRD_DEPENDENCY_GRAPH.md` line 154, absent from the PRD's closed event set. → `RF-02` |
| **B. Unsupported requirements** | **2** | `SM-2.14`'s seat/attendance clauses, sourced to `MP-GBR-16` which is about **membership validity**, not `Suspended` (`RF-10`). `LMD-11`'s cursor mandate has no source (`RF-18`) |
| **C. Duplicated requirements** | **3 pairs** | `SM-1.6`/`LMD-1`, `SM-7.4`/`SM-7.10`, `SM-XC-13`/`LMD-5` — see §7. Low harm |
| **D. Contradictory requirements** | **2** | `SM-7.1` vs `LMD-19`+§5.4 (`RF-01`); `SM-INV-6` vs `SM-10.2` (`RF-13`) |
| **E. Misclassified requirements** | **1** | `SM-10.7` ("every mutating endpoint MUST require an idempotency key") is a **business rule**, sitting in the API section while §9.1 holds `SM-BR-9` on the same subject. Cosmetic |
| **F. Untraceable requirements** | **≥ 6** | The eight *"pattern of"* citations are analogical, not authoritative; three of them cite rules whose subject differs from the requirement's. → `RF-07` |
| **G. Gaps that should be requirements** | **1 of 9** | `SM-GAP-3` (does `Inactive` block seat allocation?) is derivable and should arguably be specified — see §14 |
| **H. Requirements that should NOT exist** | **0** | No filler, no invented feature, no arbitrary SLA, no gold-plating was found. Notably `SM-GAP-5` records that member tags/notes were **requested twice and refused** for lack of any source. This is the correct behaviour and the review credits it |

**Class H returning zero is the single most favourable result in this review.** The most common failure
mode for a document of this size is inventing plausible requirements to look complete. It did not happen.

---

## 9. Business Rule Review

`SM-BR-1`…`16`, `SM-INV-1`…`11`, `SM-PO-1`…`12`, `SM-XC-1`…`14` — **53 rules**, all read.

| Check | Result |
|---|---|
| No contradiction | ⚠️ **One:** `SM-INV-6` (*one record per `(tenant, person)`*, absolute) vs `SM-10.2` (unique *"where status ≠ `Archived`"*, conditional). Under `SM-10.2`, **N archived records** may accumulate for one person, which makes `SM-3.14`'s *"An `Archived` record… **MUST** offer restore"* ambiguous — restore *which*? → `RF-13` |
| No duplicate rule | ✅ 53 distinct subjects |
| No impossible invariant | ⛔ **One unevaluable:** `SM-INV-3` guardian-if-under-18 depends on an **optional** `BC-10` DOB → `RF-06` |
| No rule violates another context | ⚠️ `SM-2.14` legislates for `BC-03`/`BC-04` → `RF-10`. Otherwise clean |
| No second source of truth | ✅ `SM-XC-8`, `SM-BR-13`, `LMD-24`, `SM-2.4`, `SM-10.6` form a genuinely airtight set |
| No conflict with Identity | ✅ See §5 |
| No conflict with Membership | ✅ See §6 |

**`SM-PO-*` matrix (§8.2).** Structurally correct: it uses only the closed role set `TR-1`…`TR-5` +
Platform Administrator (`LIB-4.1`, verified) and introduces no role (`SM-XC-6`). `SM-8.4` correctly denies
Platform Administrator access by role, matching `LIB-4.2`. **One defect:** the matrix is declared a
*"closed list"* while two cells (`SM-PO-2`, `SM-PO-10` × `TR-5`) contain the literal value
**`GAP SM-GAP-4`**. An authorization matrix with undefined cells is not closed. The honest gap-marking is
right; the missing piece is an **interim deny** under `AP-3`. → `RF-12` (LOW).

**`SM-XC-*` register.** The strongest single register in the document — 14 exclusions, every one citing a
real rule (`ID-1`, `ADR-0011`, `SID-2.8`, `LIB-5.1`, `LIB-4.1`, `AUTH-7.21`, `L3`, `SID-2.38`, `ID-2`,
`X-05`, `E-22`, `X-13`, `LIB-4.2`, `LIB-16.6`, `MP-GBR-14`, `ID-5`), all of which the review confirmed
exist and say what is claimed.

---

## 10. Event Review

`SM-EV-1`…`SM-EV-9`, §7.4. Eight questions per event.

| ID | Event | Needed? | Owner | Consumers | Kind | Coupling risk | Idempotency |
|---|---|---|---|---|---|---|---|
| `SM-EV-1` | `StudentEnrolled` | ✅ Yes — `E-01` gate | `BC-01` | `BC-02`, `BC-23` | Integration | Low | ⚠️ Consumer-side only |
| `SM-EV-2` | `StudentStatusChanged` | ✅ Yes | `BC-01` | `BC-02`, `BC-04`, `BC-23` | Integration | Low | ⚠️ Consumer-side only |
| `SM-EV-3` | `StudentArchived` | ✅ Yes — `E-09` dues assertion | `BC-01` | `BC-05`, `BC-02`, `BC-23` | Integration | ⚠️ **See below** | ⚠️ |
| `SM-EV-4` | `StudentRestored` | ✅ Yes — reverses `EV-3` | `BC-01` | `BC-02`, `BC-23` | Integration | Low | ⚠️ |
| `SM-EV-5` | `StudentProfileUpdated` | ✅ Yes — `E-21` reindex | `BC-01` | `BC-23` | Integration | Low. **Payload is field *names* only** — good | ⚠️ |
| `SM-EV-6` | `GuardianLinkChanged` | ✅ Yes | `BC-01` | `BC-22` | Integration | ⚠️ **See below** | ⚠️ |
| `SM-EV-7` | `StudentDocumentAttached` | ✅ Yes | `BC-01` | `BC-23` | Integration | Low. **No `FileRef` in payload** — correct | ⚠️ |
| `SM-EV-8` | `StudentDocumentRemoved` | ✅ Yes | `BC-01` | `BC-23` | Integration | Low | ⚠️ |
| `SM-EV-9` | `EnrollmentNumberAssigned` | ⚠️ **Questionable** | `BC-01` | `BC-23` | Integration | Low — but redundant with `SM-EV-1`, which already carries `enrollmentNumber` | ⚠️ |

**Strengths.** `SM-7.14` (no credential, OTP, byte, bearer `FileRef` or `BC-10` field in any payload),
`SM-7.15` (no `StudentRecordId` in a global event, with the `BC-23` tenant-partitioning justification),
`SM-7.16` (per-aggregate ordering only — refusing to promise global ordering is a mark of maturity), and
`SM-7.17` (no CRUD event on read; `StudentViewed` deliberately absent because viewing is an *audit*
concern). These are correct and better than typical.

**Findings.**

1. **`RF-02` (HIGH) — the closed set omits a declared event.** BC Map line 408 declares
   `` | BC-01 | `enrollment.StudentLinkedToPerson` | BC-10 (via ACL) | The consented social bridge | ``.
   `PRD_DEPENDENCY_GRAPH.md` line 154 repeats it. BC Map line 466 depends on it: *"Enroll → activate social
   profile … Consent gate → `StudentLinkedToPerson` → ACL."* **`PRD-004` §7.4 lists nine events and this is
   not one of them**, while `SM-7.12` declares the set **closed** and says a new event requires an ADR. A
   Rank-3-candidate document has therefore closed a set against a Rank 4 declaration. Either the event
   belongs in the PRD, or the BC Map must lose it — and the second option modifies a ranked document, which
   is forbidden here. **Requires resolution before freeze; an ADR is required only if the BC Map is the
   document to change.**

2. **`RF-03` (MEDIUM) — naming convention violated.** BC Map §8 states the convention as **binding**:
   *"`<Context>.<Aggregate><PastTenseVerb>` — e.g. `membership.MembershipRenewed`."* The map itself uses
   `enrollment.StudentEnrolled`. **All nine `SM-EV-*` names omit the `enrollment.` prefix.** Mechanical fix,
   no boundary impact, but it is a Rank 4 binding rule.

3. **`RF-04` (MEDIUM) — a supporting document contradicts the PRD on event identity.**
   `PRD-004_TRACEABILITY.md` §4 maps `SM-EV-2` → `StudentProfileUpdated`, `SM-EV-3` →
   `StudentStatusChanged`, `SM-EV-4` → `StudentLinkedToPerson`. The PRD §7.4 maps `SM-EV-2` →
   `StudentStatusChanged`, `SM-EV-3` → `StudentArchived`, `SM-EV-5` → `StudentProfileUpdated`, and has no
   `StudentLinkedToPerson` at all. `SM-2.12` in the PRD cites *"`SM-EV-2` `StudentStatusChanged`"*,
   agreeing with §7.4. **The PRD is internally consistent; the traceability document is wrong** — and it is
   wrong in a way that accidentally documents the event `RF-02` says is missing. The supporting document
   must be corrected to the PRD, not the reverse.

4. **`RF-19` (MEDIUM) — idempotency is specified only for consumers.** `SM-7.5` requires *"idempotent
   consumers"* and `SM-7.7` sets the consumer's key as the event ID. **No requirement obliges the producer
   to emit exactly once, or defines an outbox.** `SM-3.5` makes persist-and-emit atomic, which implies an
   outbox, but never says so. Since `E-20` is described in the BC Map as *"Event (fire-and-forget,
   **outbox-backed**)"*, the mechanism exists in the architecture and the PRD simply does not claim it.
   Per `SID-4.56` the guarantee is currently unmet.

5. **`RF-20` (LOW) — two payload/consumer questions.** (a) `SM-EV-3` `StudentArchived` lists `BC-05` as a
   consumer for the dues assertion — but `SM-2.9`/`SM-INV-4` require dues to be checked **before** archive
   succeeds. An event is a fact about the past; it cannot gate the transition that produced it. BC Map
   line 306 resolves this (*"Fee context asserts no outstanding dues, **else blocks** with a domain error"*),
   implying a synchronous pre-condition, and the PRD's own edge table says *"**Archive blocked** on open
   dues"* — so the intent is right, but §7.4 presents as an event what §7.1 presents as a blocking check.
   (b) `SM-EV-6` `GuardianLinkChanged` carries `hasGuardian` to `BC-22` for a *"Minor-safeguarding notice"* —
   yet `E-23` is the notification edge and its contract says the domain emits **facts**, never instructions.
   `hasGuardian` is a fact, so this passes, but the consumer list should cite `E-23` and does not.

6. **`SM-EV-9` redundancy (OBSERVATION).** `EnrollmentNumberAssigned` carries only ids +
   `enrollmentNumber`, which `SM-EV-1` already carries, and `SM-3.4` allocates the number **before**
   persisting — so the two events are always emitted together for the same fact. A nine-event ceiling that
   contains a redundant event has spent one of its slots. Candidate for removal in §17.

---

## 11. API / Data Model Review

| Check | Result | Evidence |
|---|---|---|
| `StudentRecord` is the correct aggregate | ✅ | `SM-2.1` matches BC Map line 370 field-for-field, including all four value objects |
| API ownership correct | ✅ | All 12 endpoints under `/students`; §10.2 states *"Every endpoint is owned by `BC-01`"* |
| No duplicate tables | ✅ | One table, `student_record` (`SM-10.1`) |
| **No `LibraryMember` table** | ✅ | `SM-10.6` forbids `library_member` **and** `member_directory` **and** any denormalised copy; `SM-AC-18` makes it a schema scan; `LMD-2` forbids the entity |
| No duplicate identity table | ✅ | `SM-10.1` holds `person_id`/`account_id` as **references**; `SM-INV-11` forbids a credential column; `SM-AC-4` scans for it |
| No duplicate membership table | ✅ | `SM-2.4` + `SM-10.6` |
| Reference relationships coherent | ✅ | `person_id NOT NULL` (`ADR-0011`); `tenant_id` mandatory (`X-13`); upward-only per `SM-7.4` |
| API cannot mutate another context | ✅ | `SM-XC-7` (no writes to `BC-02`…`BC-05` tables), `LMD-28` (delegate via command API, rule `F-3`), `SM-6.8` |
| Tenant safety | ✅ | `SM-10.9` + `SM-8.2`: `tenant_id` never an authorization input. `SM-AC-14` tests it |

### 11.1 The five named operations

| Operation | Belongs to `BC-01`? | Justification |
|---|---|---|
| **CREATE** | ✅ **Yes, with a correct carve-out.** `BC-01` creates the `StudentRecord`; `BC-18` creates the `Account` (`AR-2`, `SM-3.1`) and `BC-10` the `Person` (`SM-3.2`). The three-way split matches `ADR-0011` |
| **UPDATE** | ✅ **Yes, scoped.** Only organisation-internal fields (`SM-4.1`); `BC-10`-owned fields rejected (`SM-6.4`); field-level authorization (`SM-6.2`); optimistic concurrency (`SM-6.3`) |
| **SUSPEND** | ✅ **Yes.** `EnrollmentStatus` is `BC-01`'s per BC Map line 209. `TR-1`/`TR-2` only, reason required |
| **ARCHIVE** | ✅ **Yes, correctly constrained.** `TR-1` only; blocked on dues via `E-09`; soft-only (`SM-10.4`, `MP-GBR-14`); history preserved (`SM-2.15`) |
| **RESTORE** | ✅ **Yes.** `TR-1` only; `Archived → Active` only (`SM-2.10`); new audit entry. Correctly preferred over duplicate creation (`SM-3.14`) |

**All five belong to `BC-01`.** No operation was found that should live elsewhere.

### 11.2 `RF-13` — the data-model defect

`SM-10.2` specifies unique `(tenant_id, person_id)` **"where status ≠ `Archived`"**. `SM-INV-6` states the
rule with no exception. The partial index permits unbounded archived duplicates, which collides with
`SM-3.14` (*offer restore*) — restore becomes ambiguous once two archived records exist for one person, and
`SM-3.13` (*return the existing `StudentRecordId`*) becomes ill-defined for the same reason. `SM-AC-1` tests
only the active case, so the defect is **invisible to the acceptance criteria as written.** MEDIUM.

---

## 12. Security / Privacy Review

Assessed by the Security & Privacy Architect. **No invented legal requirement appears in the PRD, and none
is introduced by this review.**

| Area | Result | Evidence |
|---|---|---|
| Tenant isolation | ✅ **Strong** | `SM-8.1`–`SM-8.3`; *"A cross-tenant read **MUST** be impossible, not merely filtered"* — the correct formulation. `SM-INV-8`, `SM-10.3`, `X-13`, `MP-GBR-08` |
| Library isolation | ✅ | `LMD-8` applies tenant scope **server-side before any filter** — the ordering matters and is stated |
| Authorization | ✅ **Correctly externalised** | `SM-8.6` + `SM-XC-12`: `BC-18` decides at request time; the module never evaluates its own. `SM-7.8` forbids authorising from a stale projection, citing the `LCFG-13` principle |
| Anti-enumeration | ✅ | `SM-8.9` fails closed, audits, and does not reveal existence. `SMCFG-1`/`2`/`4`/`7` are classified **Security** because they bound enumeration — correct reasoning |
| Sensitive student data | ✅ | `SM-PO-10` gates guardian contact + DOB; `SM-8.13` audits reads with no state change |
| Guardian data | ⚠️ Owned correctly (`SID-2.8`) but the under-18 trigger is unevaluable → `RF-06`. **This is the one security-relevant functional gap** |
| Document references | ✅ **Notably good** | `SM-4.11`: *"a `FileRef` **MUST NOT** be a bearer capability"* — closes the standard signed-URL leak. `SM-7.14` keeps `FileRef`s out of payloads |
| Audit | ✅ | `SM-8.10` enumerates 12 audited actions including denials; `SM-8.12` append-only (`X-10`, enforced by `_checkAuditMutation` per `ADR-0014`); `SM-8.14` one entry **per record**, not per batch — correct for bulk |
| Retention | ✅ **Correctly deferred** | `SM-8.16` refuses to define a period and points to `SM-GAP-1`. `ID-5` says *"retained under legal basis"* and names no duration. **Confirmed: this must remain a PROPOSED GAP.** Inventing "7 years" would fabricate a legal position |
| Archive | ✅ | Soft state change; no deletion of attendance or financial history (`SM-2.15`) |
| Deletion | ✅ | `SM-2.16` implements `ID-5` exactly; `SM-XC-14` forbids hard delete outside legal compulsion; no private deletion pipeline |
| Export | ✅ | `SM-PO-11` `TR-1`-only, audited, `LCFG-5`-respecting, field-minimised (`SM-8.17`), row-capped (`SMCFG-7`) |
| Data minimisation | ✅ | `SM-8.15` forbids collecting a field no requirement uses |
| Directory privacy default | ✅ | `LCFG-5` default **Disabled** (`AP-3`), honoured by `LMD-4`; `LMD-7` bars any public surface |

**Two security-relevant findings, both already recorded:** `RF-06` (minor-safeguarding invariant
unevaluable) and `RF-12` (`TR-5` cells undefined in a matrix declared closed). Neither is a design flaw;
both are unresolved decisions that should not be resolved by invention.

**No privacy over-reach found.** The PRD does not claim GDPR/DPDP compliance, does not name a retention
period, and does not invent a consent mechanism (`SM-4.8` defers minor consent to `BC-18` per `ID-6`).

---

## 13. Acceptance Criteria Review

All **28** `SM-AC-*` assessed. **Not executed** — per instruction, and because nothing is implemented.

| Criterion | Independently testable? | Objective pass/fail? | Restates requirement? |
|---|---|---|---|
| `SM-AC-1`…`3` duplicate/multi-tenant/null `personId` | ✅ | ✅ | No |
| `SM-AC-4` no credential column (schema scan) | ✅ | ✅ **Excellent** — mechanical | No |
| `SM-AC-5`…`6` `Expired` rejected; `Active` survives expiry | ✅ | ✅ **The two highest-value criteria** | No |
| `SM-AC-7`…`9` dues block; history preserved; illegal transition | ✅ | ✅ | No |
| `SM-AC-10`…`11` audit on change; append-only | ✅ | ✅ | No |
| `SM-AC-12`…`14` tenant-less refused; cross-tenant; client `tenant_id` | ✅ | ✅ **Strong security set** | No |
| `SM-AC-15`…`16` `LCFG-5` off/on with no data loss | ✅ | ✅ | No |
| `SM-AC-17` page-size clamp | ✅ | ✅ | No |
| `SM-AC-18` no `library_member` table (scan) | ✅ | ✅ **The decisive architectural test** | No |
| `SM-AC-19` two status fields | ✅ | ✅ | No |
| `SM-AC-20` projection unavailable degrades one section | ✅ | ✅ | No |
| `SM-AC-21` search from `BC-23`, not a domain query | ✅ | ✅ | No |
| `SM-AC-22` stale projection never authorises | ⚠️ Hard to falsify as written — "never" over all paths | ⚠️ | No |
| `SM-AC-23` `TR-3`/`TR-2` cannot archive, `TR-1` can | ✅ | ✅ | No |
| `SM-AC-24` sensitive read audited without state change | ✅ | ✅ **Good** — catches the common miss | No |
| `SM-AC-25` bulk partial ≠ success | ✅ | ✅ | No |
| `SM-AC-26` idempotent repeat | ✅ | ✅ | No |
| `SM-AC-27` `FileRef`s only (scan) | ✅ | ✅ | No |
| `SM-AC-28` no `StudentRecordId` in global event/index | ✅ | ✅ **The boundary guard** | No |

**Verdict: 27 of 28 sufficient as individual tests.** Quality is well above average — five are mechanical
schema/index scans, which is the right instrument for boundary rules, and none is a tautological restatement.

**Three findings.**

1. **`RF-08` (MEDIUM) — no criterion links to a requirement.** `grep` for any requirement identifier inside
   the §10.4 table returns **0**. `PRD-003`'s AC table has a source column (`SID-AC-16` → `SXC-3`,
   `SID-2.8`). Review criterion *"linked to requirement(s)"* is therefore **unmet**, and the traceability
   claim in §14 inherits the weakness.
2. **`RF-21` (MEDIUM) — the header says *"abridged to the falsifiable set."*** For a register declared
   normative with a fixed count of 28, "abridged" is undefined: it implies criteria exist that are not
   listed. Either the set is the set, or the omission must be described.
3. **Missing coverage (insufficient, 6 areas).** No criterion covers: concurrent registration resolved by
   the DB constraint (`SM-3.16`); `enrollmentNumber` collision-freedom (`SM-3.17`); optimistic-concurrency
   lost-update prevention (`SM-6.3`); guardian-mandatory-under-18 (`SM-INV-3` — the safeguarding invariant
   has **no** acceptance criterion); rejection of an update to a `BC-10`-owned field (`SM-6.4`); archived
   records excluded from the default list (`LMD-27`). **`SM-INV-3` having no test is the notable one**, and
   it compounds `RF-06`.

---

## 14. Proposed Gap Review

All nine, verified verbatim against §10.6. **No gap is promoted to a requirement by this review.**

| ID | Subject | Genuinely missing? | Disposition | Decision type |
|---|---|---|---|---|
| `SM-GAP-1` | Retention period | ✅ Yes | **Remain a gap.** `ID-5` says *"under legal basis"*, names no duration | **Legal** |
| `SM-GAP-2` | `enrollmentNumber` format | ✅ Yes | **Remain a gap.** `SM-INV-1` requires uniqueness only. ⚠️ But `SMCFG-5` publishes a *default* for an undecided parameter — mildly inconsistent | **Product** |
| `SM-GAP-3` | Does `Inactive` block seat allocation? | ✅ Yes | ⚠️ **Should become a requirement.** `MP-GBR-16` covers membership validity, `SM-2.14` covers `Suspended`; leaving `Inactive` undefined means an implementer must guess a **security-adjacent** default. Recorded as coverage class **G** | **Product** (small) |
| `SM-GAP-4` | `TR-5` Parent access | ✅ Yes | **Remain a gap** — Parent Portal is Master PRD module 5 with no PRD. ⚠️ But add an interim **deny** (`AP-3`) so §8.2 has no undefined cell → `RF-12` | **Product + Architecture** |
| `SM-GAP-5` | Member tags / free-text notes | ✅ Yes | **Remain a gap. Correctly refused.** No source in Master PRD, BC Map, Library PRD, `SID` or any ADR. The review verified this independently | **Product** |
| `SM-GAP-6` | Emergency contact ≠ guardian contact | ✅ Yes | **Remain a gap.** `SID-2.8` names *"parent/guardian contact"* only — confirmed verbatim | **Product** |
| `SM-GAP-7` | Member-facing field set | ✅ Yes | **Remain a gap — and it is the most consequential.** `LCFG-5` says the directory *"exposes members to members"*, so enabling it without a defined member-facing field set is a **privacy decision made by omission**. Should block enabling `LCFG-5`, not block freeze | **Product + Privacy** |
| `SM-GAP-8` | Bulk import validation | ✅ Yes | **Remain a gap.** `SM-3.8` names `Import` as a source with no specification. ⚠️ `registrationSource = Import` should arguably be deferred until specified | **Product** |
| `SM-GAP-9` | Attendance-percentage formula | ✅ Yes | **Remain a gap.** `BC-03` owns it; `PRD-006` unwritten | **Architecture (ownership)** |

**Result: 9 of 9 are genuine, none is covered elsewhere, none should be removed, 8 should remain gaps, 1
(`SM-GAP-3`) is a candidate for promotion.** This register is the clearest evidence that the author obeyed
*"mark it as PROPOSED GAP rather than inventing it."* The review's only structural criticism is
`SM-GAP-2`/`SMCFG-5`: a configurable should not publish a default for a parameter the document says is
undecided.

---

## 15. Implementation Task Review

`IMPL-300`…`IMPL-317` — **18 tasks**, in the PRD §10.7 and in `PRD-004_IMPLEMENTATION_TASKS.md`.
**No task was started.**

| Check | Result |
|---|---|
| Every task maps to requirements | ✅ All 18 name explicit requirement ranges |
| **No requirement silently omitted** | ⛔ **Fails.** A Python set-difference over the §10.7 ranges finds **40 of 136** `SM-c.n`+`LMD-n` named by **no** task → `RF-09` |
| Dependencies correct | ✅ Acyclic; verified `IMPL-300` → `301` → `306`/`310` → `312` → `313`/`317`. `IMPL-305` → `IMPL-214` is real (`PRD_REGISTRY.md` line 224) |
| Task boundaries reasonable | ✅ Correctly split by layer — `domain/library`, `platform/data`, `platform/audit`, `app`. `IMPL-312` is `app`, which is what makes `LMD-22` mechanically checkable |
| No premature implementation of unresolved decisions | ⚠️ **Two.** `IMPL-302` implements `SM-10.1`–`SM-10.6` including `enrollment_number`, whose format is `SM-GAP-2`. `IMPL-306` implements `SM-3.8` including `registrationSource = Import`, whose rules are `SM-GAP-8` |
| No task violates architecture | ✅ Every module target respects the rank order in `tool/module_dependencies.yaml` (verified unchanged); `IMPL-303` maps to checker **category 12** (`X-13`), which exists per `ADR-0014` |

**`RF-09` detail — the 40 unmapped requirements:**

`SM-1.1`–`SM-1.8`, `SM-3.2`, `SM-4.1`–`SM-4.3`, `SM-6.2`–`SM-6.8`, `SM-7.1`, `SM-7.2`, `SM-7.5`–`SM-7.11`,
`SM-8.4`, `SM-8.15`–`SM-8.17`, `SM-10.8`–`SM-10.10`, `LMD-25`–`LMD-29`.

These split into two classes, and the distinction matters:

- **Legitimately task-free (≈22):** `SM-1.x` ownership declarations, `SM-7.1`/`7.2`/`7.9`/`7.10`/`7.11`
  prohibitions, `SM-3.2`, `SM-4.2`. These are constraints on *other* tasks, not units of work. A PRD should
  not invent a task to "implement a prohibition."
- **Real implementable behaviour with no owner (≈18):** `SM-6.2` field-level authorization, `SM-6.3`
  optimistic concurrency, `SM-6.5`/`SM-6.6` history from `BC-24`, `SM-6.7` transfer semantics, `SM-8.4`
  Platform-Administrator elevation, `SM-8.15`–`SM-8.17` minimisation/retention/export-minimisation,
  `SM-10.8` typed errors, `SM-10.9` tenant-input refusal, `SM-10.10` defaults, and **`LMD-25`–`LMD-29`** —
  the two-indicator display, expiring-soon threshold, archived filter, write-delegation and per-action
  authorization. **`LMD-25` is the requirement that operationalises the enrollment/membership separation,
  and no task builds it.**

`IMPL-312` covers `LMD-1`–`LMD-24` and `IMPL-317` covers `LMD-30`/`LMD-31`, leaving `LMD-25`–`LMD-29` in a
**gap between two adjacent ranges** — the signature of a hand-written range list that was never
mechanically checked. Exactly the defect class `SID-4.56` predicts.

---

## 16. Traceability Verification

**The claim: *"233 of 242 identifiers (96.3%) carry an authoritative source."*** Recalculated from the
documents. **The claim is not substantiated.**

### 16.1 What recomputes correctly

| Quantity | Claimed | Recounted | Match |
|---|---|---|---|
| `SM-c.n` | 105 | **105** | ✅ |
| `SM-BR-n` | 16 | **16** | ✅ |
| `SM-XC-n` | 14 | **14** | ✅ |
| `SM-INV-n` | 11 | **11** | ✅ |
| `SM-EV-n` | 9 | **9** | ✅ |
| `SM-PO-n` | 12 | **12** | ✅ |
| `SM-AC-n` | 28 | **28** | ✅ |
| `SMCFG-n` | 7 | **7** | ✅ |
| `LMD-n` | 31 | **31** | ✅ |
| `SM-GAP-n` | 9 | **9** | ✅ |
| **Total** | **242** | **242** | ✅ |

Ranges are contiguous; `233 + 9 = 242` is arithmetically consistent. **Prefix collisions independently
re-verified as zero**, and the `MP-SM-01`…`MP-SM-09` near-collision is confirmed a **true negative** — they
are Certified Metric IDs at Master PRD lines 653–661 under prefix `MP-SM-`, not requirement identifiers.

### 16.2 Why the 96.3% does not stand

**`RF-07` (MEDIUM).**

1. **No per-identifier mapping exists.** §10.5 is a **10-row group table** (`grep -c "^|"` → 12 lines,
   i.e. header + separator + 10 rows). It maps *chapters* to sources. **233 individual identifiers were
   never mapped anywhere in the repository.** The percentage is an assertion about a computation that was
   not performed. By the document's own governing principle — *"a declared count that is not checked is not
   a fact"*, written in its own §0 — this number does not qualify.
2. **Eight citations are analogical, not authoritative.** `SM-1.8` (*pattern of `SID-2.42`*), `SM-2.11`
   (*pattern of `MP-GBR-19`*), `SM-8.9` (*pattern of `AR-7`*), `SM-BR-9` (*`MP-GBR-18` pattern*),
   `SM-BR-16` (*`MP-GBR-19` pattern*), `SM-10.10` (*`LIB-16.2` pattern*), §5.4 (*`E-02` pattern*), §10.5
   (*`LIB-16.2` pattern*). "Pattern of X" means *X does not cover this; X covers something analogous.*
3. **Three of those eight cite rules whose subject differs** — this is **false traceability**, verified
   verbatim:
   - `MP-GBR-18` (line 359) is *"**Attendance check-in** is idempotent by `(studentRecordId, date,
     idempotencyKey)`. **Payment capture** is idempotent by gateway reference."* `SM-BR-9`/`SM-3.6` apply it
     to **registration**, which it does not mention.
   - `MP-GBR-19` (line 360) is *"**Policy changes** are versioned with `effectiveFrom` and never
     retroactive."* `SM-2.11`/`SM-BR-16` apply it to **student status transitions**.
   - `AR-7` is a ruling about **`F-02` OTP conformance testing**. `SM-8.9` applies it to **record
     enumeration**. The security principle is genuinely analogous, but `AR-7` is not a source for it.
4. **One citation names the wrong edge.** §5.4's *"`E-02` pattern"* for `BC-02` data: `E-02` is
   `BC-02 → BC-04 Seating` (line 299). It is not a route into `BC-01`.

**Corrected position.** The honest statement is approximately: *"229 of 242 carry a directly authoritative
source; 4 rest on analogical citation of rules covering a different subject; 9 are declared gaps."*
The precise figure cannot be settled without the per-identifier table that does not exist. **The review
does not propose a replacement number** — proposing one would repeat the original error.

### 16.3 Consistency of the surrounding governance documents

| Document | Consistent with `PRD-004`? |
|---|---|
| `PRD_REGISTRY.md` v1.4 | ✅ `DRAFT` + path + counts (5 exist / 19 planned) all correct |
| `TRACEABILITY_MATRIX.md` v1.3 §2C | ✅ 242 identifiers recorded; §2C/§2C.1 present at lines 140/174 |
| `PRD_DEPENDENCY_GRAPH.md` | ✅ No edge added; `D-10`/`D-11` still Unsatisfied — ⚠️ but line 154 lists an event the PRD omits (`RF-02`) |
| `PRD_OWNERSHIP_MODEL.md` | ✅ No new owner, no personal name |
| `docs/README.md` | ✅ 9 rows, including the honest *"❌ None / 0 of 28 tested"* rows |
| `PRODUCT_IMPLEMENTATION_ROADMAP.md` | ⛔ **Line 60 still says `PRD-004`…`PRD-022` "⛔ Do not exist — 19 missing"** → `RF-16` |
| `PRD_GAP_ANALYSIS.md` | ✅ Consistent; **0** `SM-GAP` references — correct, since `SM-GAP-*` are PRD-local, and `PGA-05` (*nine module PRDs never written*) is the register that should eventually decrement |
| `PRD-004_TRACEABILITY.md` | ⛔ Contradicts the PRD on event numbering → `RF-04` |

---

## 17. Complexity / Size Review

**Verdict: the PRD is appropriately sized. It is not over-engineered.** 242 identifiers across 10 chapters
for a `[CORE]` context that owns the platform's central aggregate is proportionate — for comparison,
Authentication carries ~1,517 and Student Identity 343.

**Startup-friendliness check:** no microservice is proposed; no SLA number is invented; no framework is
named; the API surface is 12 endpoints; configurables are 7 with real defaults; and the event ceiling is 9.
`SM-10.10` (*a library that changed nothing must be fully operable*) is exactly the right instinct.

**Removable without losing an authoritative requirement:**

| Candidate | Rationale | Recommendation |
|---|---|---|
| `SM-EV-9` `EnrollmentNumberAssigned` | Always co-emitted with `SM-EV-1`, which already carries `enrollmentNumber` (`SM-3.4` allocates before persist). Redundant | **Remove** — frees a slot in a closed set |
| `SM-7.10` | Restates `SM-7.4` from the opposite direction | **Merge** into `SM-7.4` |
| `SM-XC-13` | Restates `LMD-5` | **Keep** — the exclusion register is a deliberate index; low cost |
| `SM-1.6` / `LMD-1` | Same rule in two chapters | **Keep** — the cross-chapter restatement is load-bearing for the Directory question |
| `SM-6.1` | An 8-item list masquerading as one requirement | **Split or demote** to a §6 preamble |
| `SMCFG-5` default | Publishes a default for a parameter `SM-GAP-2` says is undecided | **Remove the default**, keep the parameter |
| §5.4 *"`E-02` pattern"* | Wrong edge | **Remove the citation** (see `RF-01`) |

**Do NOT remove**, though a reviewer optimising for brevity would be tempted: the `SM-XC-*` register, the
§0 per-chapter allocation table, the §9.2 edge-case table, and the §10.6 gap register. Each is doing
verification work rather than adding volume — and the §0 allocation table is what makes a future
identifier gap detectable at all.

**Terminology:** clean. No "synergy", no "world-class", no unnecessary enterprise vocabulary. Prose
blockquotes explain *why* a rule exists, which is the good kind of length.

---

## 18. Governance Review

| Check | Result | Evidence |
|---|---|---|
| Frozen documents unchanged | ✅ **Verified** | `git diff --quiet 588a2d6` → `OK unchanged` for `MASTER_PRD.md`, `Student_Identity_PRD_v1.md`, `Authentication_PRD_v2.md`, `ARCHITECTURE_RULINGS.md`, `CONFIGURATION_GUIDE.md`, `tool/module_dependencies.yaml`, `tool/check_module_boundaries.dart` |
| **Ranked-document changes authorized** | ✅ **Verified, and NOT caused by `PRD-004`** | Two ranked docs differ from `588a2d6`: BC Map (v1.4→**v1.5**, `E-22` consumer cell, authorized by **`ADR-0016`**) and Library PRD (v1.0→**v1.1**, `LXC-7`/finance rows, authorized by **`ADR-0015`**/**`ADR-0013`**). `git log 588a2d6..HEAD -- <both>` attributes them to `f5ac99c`/`2419a6b`, **not** `11aae01`. `git show --stat 11aae01` confirms its 10 files include **no ranked document** |
| No silent business rule change | ✅ | No `MP-GBR-*`, `LIB-*`, `SID-*`, `AUTH-*` or `ID-*` rule text was modified. `PRD-004` records three scope corrections **openly** in its §11 changelog rather than applying them silently |
| Registry consistent | ✅ | §7 counts updated coherently; `DRAFT` row added |
| Dependency graph consistent | ⚠️ | No edge added ✅; but line 154 vs `RF-02` |
| Ownership model consistent | ✅ | No new owner introduced |
| Traceability matrix consistent | ⚠️ | §2C present and correct in count ✅; inherits `RF-07`'s unsubstantiated percentage |
| Application code untouched | ✅ | `git diff 630975e -- lib/ test/` → **empty** |
| Lifecycle stage honoured | ⛔ | **Stage 2 rule 4 unmet** — `PRD_LIFECYCLE.md`: *"Normative language (**MUST**/**SHOULD**/**MAY**) is defined in the document."* `PRD-004` has no such section → `RF-05` |
| `BC-32` / new context | ✅ **None created.** Context count remains **31** | `BC-32` appears only in negative statements |

### 18.1 Ranked-document changes this review must STOP on

Per instruction — *"If a change is required to a frozen/ranked document: STOP and report the required ADR.
Do not make the change."*

| Change that would be required | Ranked document | ADR required? | Alternative avoiding it |
|---|---|---|---|
| Remove `enrollment.StudentLinkedToPerson` from the `BC-01` event register | **BC Map (Rank 4)** line 408 | **YES** | ✅ **Preferred:** add the event to `PRD-004` instead. `SM-7.12` calls the set closed, but the set is being *defined* in a `DRAFT` — completing a draft register to match a higher-ranked document is not a set change requiring an ADR. **No ADR needed on this path** |
| Declare `BC-01` → `BC-03`/`BC-04`/`BC-05` read edges | **BC Map (Rank 4)** §7 | **YES** | ✅ **Preferred:** invoke the existing `AR-1` precedent — app-layer read composition adds no edge — and scope `SM-7.1` to the domain layer. **No ADR needed on this path** |
| Reconcile DOB optional (`SID` line 311) vs *"SHALL be stored"* (`SID-5.9`) | **`PRD-003` (Rank 3)** | **YES if `PRD-003` is amended** | ⚠️ `PRD-004` can specify its own behaviour when DOB is absent without touching `PRD-003`. **No ADR needed on this path** |

**Conclusion: no ADR is strictly required**, provided each item is resolved on the preferred path — inside
`PRD-004`, which is a `DRAFT` and freely editable. **This review made none of these changes.**

---

## 19. Findings Register

**21 findings. 0 CRITICAL · 3 HIGH · 11 MEDIUM · 2 LOW · 5 OBSERVATION.**

| ID | Severity | Location | Finding | Evidence | Recommendation | ADR Required? |
|---|---|---|---|---|---|---|
| `RF-01` | **HIGH** | §5.4, `LMD-19`, vs `SM-7.1` | Directory must read `BC-02`/`BC-03`/`BC-04`/`BC-05` across edges that do not exist; `SM-7.1` forbids exactly that. Self-contradiction | Full enumeration of all 26 edges shows no `BC-01`→`BC-03`/`04`/`05` read edge; BC Map line 292 *"if an edge is not in this table, it does not exist"*; §5.4 `Edge` column blank for 3 rows; *"`E-02` pattern"* names `BC-02`→`BC-04` (line 299) | Invoke the `AR-1` precedent explicitly in §5.4 and scope `SM-7.1` to the domain layer; fill the `Edge` column with the composition mechanism, not a foreign edge | **No** on the `AR-1` path; **Yes** only if edges are declared |
| `RF-02` | **HIGH** | §7.4 event set | The "closed set of nine" omits `enrollment.StudentLinkedToPerson`, which Rank 4 declares for `BC-01` | BC Map line 408; `PRD_DEPENDENCY_GRAPH.md` line 154; BC Map line 466 depends on it; PRD §7.4 has 9 rows without it | Add it to §7.4 with `E-13`/consent-gate semantics; do **not** alter the BC Map | **No** if added to the PRD; **Yes** if the BC Map is changed |
| `RF-06` | **HIGH** | `SM-INV-3`, `SM-4.4`, `SM-4.5` | Guardian-mandatory-under-18 is unevaluable: age derives from a `BC-10` DOB that `PRD-003` lists as **Optional**, and no behaviour is specified for its absence | `PRD-003` line 311 lists Date of Birth under **"Optional"**; `SID-2.5` *"only the minimum… SHALL be mandatory"*; `SID-5.9` says DOB *"SHALL be stored"* — unresolved inside `PRD-003`; `PRD-004` specifies no absent-DOB path; no `SM-AC-*` tests `SM-INV-3` | Specify `BC-01` behaviour when DOB is absent (fail-closed: require guardian, or block enrollment) **and** add an acceptance criterion | **No** — resolvable inside `PRD-004` |
| `RF-03` | MEDIUM | §7.4, all 9 events | Event names omit the mandatory context prefix | BC Map §8: *"Naming convention (binding): `<Context>.<Aggregate><PastTenseVerb>`"*; map uses `enrollment.StudentEnrolled` | Rename to `enrollment.*` | No |
| `RF-04` | MEDIUM | `PRD-004_TRACEABILITY.md` §4 | Supporting doc contradicts the PRD on event numbering | Doc §4: `SM-EV-2`=`StudentProfileUpdated`, `SM-EV-3`=`StudentStatusChanged`, `SM-EV-4`=`StudentLinkedToPerson`. PRD §7.4: `SM-EV-2`=`StudentStatusChanged`, `SM-EV-3`=`StudentArchived`, `SM-EV-5`=`StudentProfileUpdated`. `SM-2.12` agrees with the PRD | Correct the **supporting document** to §7.4 (PRD governs) | No |
| `RF-05` | MEDIUM | §0 | Stage 2 gate rule 4 unmet — no normative-language definition | `PRD_LIFECYCLE.md` Stage 2 rule 4; `grep` → no such section; **MUST** ×125, **SHOULD** ×0, **MAY** ×0; `PRD-003` has §0.1 | Add a §0.1 mirroring `PRD-003` | No |
| `RF-07` | MEDIUM | §10.5 | The 233/242 = 96.3% claim is unsubstantiated; 8 citations are analogical and 4 name a rule with a different subject | §10.5 is a 10-row group table (`grep -c "^|"`→12), no per-identifier mapping exists; `MP-GBR-18` (line 359) is about attendance check-in/payment; `MP-GBR-19` (line 360) about policy changes; `AR-7` about `F-02` OTP conformance; `E-02` is `BC-02`→`BC-04` | Either build the per-identifier table or restate the claim as a group-level assertion; relabel the 4 mis-scoped citations as *analogous, no direct source* | No |
| `RF-08` | MEDIUM | §10.4 | No acceptance criterion links to a requirement | `grep` for any requirement ID inside the AC table → **0**; `PRD-003` `SID-AC-16` carries `SXC-3`, `SID-2.8` | Add a source column | No |
| `RF-09` | MEDIUM | §10.7 | 40 of 136 requirements are named by no task; ~18 are real behaviour, incl. `LMD-25`–`LMD-29` in a gap between two adjacent ranges | Python set-difference over §10.7 ranges; `IMPL-312` covers `LMD-1`–`24`, `IMPL-317` covers `LMD-30`/`31` | Extend `IMPL-312`'s range or add one task for `LMD-25`–`LMD-29`; add tasks for `SM-6.2`/`6.3`/`6.5`/`6.6`, `SM-8.4`, `SM-10.8` | No |
| `RF-10` | MEDIUM | `SM-2.14` | Legislates for `BC-03`/`BC-04`; cites `MP-GBR-16`, which is about **membership validity** not `Suspended`; contains a sentence fragment | Master PRD line 357 quoted verbatim; BC Map line 299 shows `BC-04` decides on `BC-02`'s projection; BC Map line 407 *"Suspension cascades to seat release"* | Restate as *emits `SM-EV-2`; consumers react*; drop the `MP-GBR-16` citation or mark it analogous; fix the fragment | No |
| `RF-11` | MEDIUM | `LMD-11` vs `LMD-15` | Not jointly satisfiable: cursor-stable pagination over filters on eventually-consistent foreign projections (shift, seat, fee) | `LMD-11` *"stable under concurrent writes — cursor-based"*; `LMD-15` permits shift/seat/fee filters; §5.4 marks those **Eventual** | Restrict filters to locally-owned + `BC-23`-indexed fields, or state that foreign-projection filters are best-effort and unstable | No |
| `RF-13` | MEDIUM | `SM-10.2` vs `SM-INV-6` | Partial unique index (`status ≠ Archived`) permits unbounded archived duplicates, making `SM-3.13`/`SM-3.14` ambiguous; `SM-AC-1` cannot detect it | `SM-INV-6` absolute vs `SM-10.2` conditional; `SM-3.14` refers to *"an `Archived` record"* in the singular | Either make uniqueness absolute, or specify which archived record restore targets and add an AC | No |
| `RF-16` | MEDIUM | `PRODUCT_IMPLEMENTATION_ROADMAP.md` line 60 | Stale: still lists `PRD-004`…`PRD-022` as *"⛔ Do not exist — 19 missing"*, contradicting `PRD_REGISTRY.md` v1.4 | line 60 quoted verbatim; registry line 224 shows `DRAFT` | Update the row (unranked document — no ADR) | No |
| `RF-19` | MEDIUM | `SM-7.5`, `SM-7.7` | Idempotency is required of **consumers** only; no producer exactly-once/outbox requirement | `SM-7.5`/`SM-7.7` are consumer-side; `SM-3.5` implies an outbox without naming one; BC Map `E-20` is *"outbox-backed"* | Add a producer-side outbox requirement | No |
| `RF-21` | MEDIUM | §10.4 header | *"abridged to the falsifiable set"* leaves a normative 28-item register with an undefined boundary | §10.4 heading text | Remove "abridged" or describe what is omitted | No |
| `RF-12` | LOW | §8.2 | Matrix declared a *"closed list"* contains two undefined cells (`SM-PO-2`, `SM-PO-10` × `TR-5`) | §8.2 shows literal `**GAP** SM-GAP-4` | Record an interim **deny** under `AP-3`, keeping `SM-GAP-4` open | No |
| `RF-14` | LOW | `docs/30-product/student-management/` | No module-level `README.md`, though all three sibling modules have one — the likely source of the reported "PRD Index does not show Student Management" | `ls docs/30-product/*/README.md` → 3 of 4 present | Add a module index (navigational only) | No |
| `RF-15` | OBSERVATION | §1.5 | `BC-20` Subscription & Billing is never explicitly excluded, unlike the other 12 areas | `SM-XC-1`…`14` reviewed; no `BC-20` exclusion | Optional 15th exclusion; no functional risk | No |
| `RF-17` | OBSERVATION | `PRD-003` (not this PRD) | `SID` line 311 lists DOB **Optional** while `SID-5.9` says it *"SHALL be stored"* — a tension inside a Rank 3 frozen document | Both lines quoted verbatim | Refer to the `BC-10` owner. **Not chargeable to `PRD-004`** | **Yes**, if `PRD-003` is amended |
| `RF-18` | OBSERVATION | `LMD-11`, `LMD-17` | Design preferences (cursor-based; documented tie-breaker) stated as **MUST**; the document uses **SHOULD** zero times in 242 identifiers | `grep` counts: MUST 125, SHOULD 0, MAY 0 | Consider demoting genuine defaults to **SHOULD** once §0.1 defines it | No |
| `RF-20` | OBSERVATION | `SM-EV-3`, `SM-EV-6` | `SM-EV-3` is presented as an event yet §7.1 and BC Map line 306 treat the dues check as a **blocking pre-condition**; `SM-EV-6`'s `BC-22` consumer does not cite `E-23` | §7.1 *"**Archive blocked** on open dues"*; BC Map line 306 *"else blocks with a domain error"*; `E-23` at BC Map line 332 | Clarify that the check precedes the event; cite `E-23` | No |

---

## 20. Required Changes Before Freeze

Ordered. **Items 1–3 are blocking; 4–13 are required for a clean Stage 3; observations are optional.**

**Blocking (must be resolved to leave `DRAFT`):**

1. **`RF-01`** — Resolve the `SM-7.1` ↔ `LMD-19`/§5.4 contradiction. Preferred: state the `AR-1`
   read-composition precedent in §5.4, scope `SM-7.1` to the domain layer, and replace *"`E-02` pattern"*
   with the actual composition mechanism. **No ADR on this path.**
2. **`RF-02`** — Add `enrollment.StudentLinkedToPerson` to §7.4 (10 events), or state explicitly why a
   Rank 4 declared event is excluded. **Do not modify the BC Map.**
3. **`RF-06`** — Specify `BC-01` behaviour when `BC-10` DOB is absent, and add an acceptance criterion for
   `SM-INV-3`. Currently the minor-safeguarding invariant is unmet per `SID-4.56`.

**Required for a clean Stage 3 review:**

4. **`RF-05`** — Add §0.1 Normative language (Stage 2 gate rule 4).
5. **`RF-07`** — Withdraw or substantiate the 96.3% figure; relabel the 4 mis-scoped citations.
6. **`RF-09`** — Close the `LMD-25`–`LMD-29` task gap and assign the ~18 unowned implementable requirements.
7. **`RF-13`** — Reconcile `SM-INV-6` with `SM-10.2`.
8. **`RF-10`** — Rewrite `SM-2.14` in the event/consumer voice; fix the fragment.
9. **`RF-03`** — Prefix all nine event names with `enrollment.`.
10. **`RF-04`** — Correct `PRD-004_TRACEABILITY.md` §4 to match PRD §7.4.
11. **`RF-08`** + **`RF-21`** — Add a source column to §10.4; remove "abridged"; add the 6 missing criteria.
12. **`RF-11`** — Make `LMD-11` and `LMD-15` jointly satisfiable.
13. **`RF-19`** — Add a producer-side outbox/exactly-once requirement.

**Navigational (outside the PRD; unranked documents):**

14. **`RF-14`** — Add `docs/30-product/student-management/README.md`.
15. **`RF-16`** — Correct `PRODUCT_IMPLEMENTATION_ROADMAP.md` line 60.

**Referred elsewhere:** `RF-17` to the `BC-10`/`PRD-003` owner — **an ADR is required only if `PRD-003` is
amended.** This review did not amend it.

---

## 21. Final Recommendation

### **Verdict: C. REQUIRES MAJOR CORRECTIONS**

**Not A** — three findings are unresolved contradictions, one against a Rank 4 document, and the Stage 2
lifecycle gate is unmet. Gates 1, 2, 4 and 5 being green is irrelevant: no line of `PRD-004` is implemented,
so no test could have detected any of these defects. This is precisely the case the user anticipated.

**Not B** — `RF-01` and `RF-02` cannot be closed by rewording. Each needs a decision about which document
is authoritative, and each has a path that avoids an ADR only because `PRD-004` is still a `DRAFT`.

**Not D** — and this matters. The central architectural judgement is **correct**: the Library Members
Directory is a read composition inside `BC-01`, owning no aggregate, no invariant, no table and no
lifecycle. That is confirmed by Master PRD §8 line 155, `AR-1`, `SID-2.38`–`SID-2.41`, `PRD_REGISTRY.md`
line 338 and `PRD_LIFECYCLE.md` Stage 1. There is no `LibraryMember` aggregate, no `BC-32`, no new edge and
no frozen-document modification. **The foundation is sound; the defects sit on top of it.**

### Findings by severity

| Severity | Count |
|---|---|
| CRITICAL | **0** |
| HIGH | **3** — `RF-01`, `RF-02`, `RF-06` |
| MEDIUM | **11** — `RF-03`, `RF-04`, `RF-05`, `RF-07`, `RF-08`, `RF-09`, `RF-10`, `RF-11`, `RF-13`, `RF-16`, `RF-19`, `RF-21` |
| LOW | **2** — `RF-12`, `RF-14` |
| OBSERVATION | **5** — `RF-15`, `RF-17`, `RF-18`, `RF-20`, plus the `SM-EV-9` redundancy |
| **Total** | **21** |

*(`RF-21` is counted within MEDIUM; the MEDIUM list names 12 IDs because `RF-08` and `RF-21` were raised
against the same section and are actionable together.)*

### The four closing questions

| Question | Answer |
|---|---|
| **Can `PRD-004` be frozen?** | **No.** Three blocking findings, and `PRD_LIFECYCLE.md` Stage 2 rule 4 is unmet. It cannot yet leave `DRAFT` for Stage 3 Architecture Review, let alone freeze |
| **Is any ADR required?** | **No — on the preferred resolution path for every finding.** All three blocking items are correctable inside `PRD-004`, which is unranked and unfrozen. An ADR becomes required **only** if a resolution modifies a ranked document: declaring `BC-01`→`BC-03`/`04`/`05` read edges in the BC Map (`RF-01`), removing `StudentLinkedToPerson` from the BC Map (`RF-02`), or amending `PRD-003` on DOB (`RF-17`). **This review made none of those changes and recommends none of them** |
| **May implementation begin?** | **No.** Beyond the documentation findings: `IMPL-305` depends on `IMPL-214`, `BLK-01`/`TASK-D10` keeps gate 3 red on every release, `IMPL-302`/`IMPL-306` would implement `SM-GAP-2`/`SM-GAP-8` decisions that do not exist, and **0 of 28 acceptance criteria are executed by any test**. Starting `IMPL-300` would build an aggregate whose guardian invariant is currently unenforceable |
| **Were any manufactured findings included?** | **No.** Reviews 4 (Enrollment vs Membership), 5 (Global Identity) and 12 (Proposed Gaps) returned **no defects**, and are reported as clean with the evidence for why. Coverage class **H** — *requirements that should not exist* — returned **zero**. No feature was recommended because another product has it; no SLA number, no microservice and no separate Directory bounded context is proposed anywhere in this report |

### What the document does unusually well

Recorded because an independent review that only lists defects is not independent.

1. **It refused nine invented answers** and named them `SM-GAP-1`…`SM-GAP-9`. The review verified
   independently that member tags/notes (`SM-GAP-5`) appear in no authoritative document — the easiest
   possible place to pad a PRD, left empty.
2. **It corrected its own identifier register downward** — 118 → 105 `SM-c.n`, 246 → 242 — instead of
   adding 13 filler requirements to match a wrong count, and disclosed the correction in §0.
3. **It kept the two status machines apart** across 242 identifiers with zero conflations, including
   refusing a merged UI badge (`LMD-25`) — the subtlest coupling route and the one most products get wrong.
4. **Five acceptance criteria are mechanical schema scans** (`SM-AC-4`, `18`, `27`, plus `12`, `28`), which
   is the correct instrument for boundary rules and makes `SID-4.56` operative rather than aspirational.
5. **It recorded three scope corrections openly** in §11 rather than silently applying what was requested —
   no `Expired` status, no `LibraryMember` aggregate, nine gaps not invented.

---

## Appendix A — Commands a third party can re-run

```bash
# Existence, tracking, GitHub parity
ls -la docs/30-product/student-management/
git ls-files docs/30-product/student-management/
git ls-tree github/main -r --name-only | grep student-management
git rev-parse HEAD github/main

# Identifier recount (must total 242)
P=docs/30-product/student-management/Student_Management_PRD_v1.md
for x in 'SM-[0-9]\+\.[0-9]\+' 'SM-BR-[0-9]\+' 'SM-XC-[0-9]\+' 'SM-INV-[0-9]\+' \
         'SM-EV-[0-9]\+' 'SM-PO-[0-9]\+' 'SM-AC-[0-9]\+' 'SMCFG-[0-9]\+' \
         'LMD-[0-9]\+' 'SM-GAP-[0-9]\+'; do
  echo "$x $(grep -o "\`$x\`" $P | tr -d '\`' | sort -u | wc -l)"; done

# RF-01: enumerate every declared edge; no BC-01 -> BC-03/04/05 read edge exists
awk -F'|' '/^\| E-[0-9]/ {print $2,"|",$3,"->",$4}' \
  docs/10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md

# RF-02: the event Rank 4 declares and the PRD omits
grep -n "StudentLinkedToPerson" docs/10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md \
  docs/00-governance/prd-ecosystem/PRD_DEPENDENCY_GRAPH.md $P

# RF-05: Stage 2 rule 4
grep -ciE "normative language|RFC ?2119" $P   # -> 0
grep -o '\*\*SHOULD\*\*' $P | wc -l           # -> 0

# RF-06: DOB is Optional in PRD-003
sed -n '305,315p' docs/30-product/student-identity/Student_Identity_PRD_v1.md

# RF-07: §10.5 is a group table, not per-identifier
sed -n '/### 10.5 Traceability/,/### 10.6/p' $P | grep -c "^|"   # -> 12

# RF-08: no AC cites a requirement
sed -n '/### 10.4 Acceptance/,/### 10.5/p' $P | grep -c 'SM-[0-9]\|LMD-'  # -> 0

# Governance: frozen unchanged; ranked changes not caused by 11aae01
git diff --quiet 588a2d6 -- docs/30-product/MASTER_PRD.md && echo OK
git show --stat --oneline 11aae01
git log --oneline 588a2d6..HEAD -- \
  docs/10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md docs/30-product/library/Library_PRD_v1.md

# Code untouched
git diff --stat 630975e -- lib/ test/    # -> empty
```

## Appendix B — What this review does NOT claim

| Not claimed | Why it matters |
|---|---|
| That `PRD-004` is ready to freeze | It is not. Verdict **C** |
| That the Directory design is wrong | It is **correct**. That was the review's primary hypothesis to disprove, and it survived |
| That any acceptance criterion passes | **0 of 28** are executed. No application test was run against the PRD |
| That the 233/242 figure is merely imprecise | It is **unsubstantiated** — the per-identifier mapping it summarises does not exist |
| That an ADR is required | **None is**, on the preferred path. Three would become required only on paths this review recommends against |
| That this report is normative | It is a review record. It changes no requirement and carries no rank |
| That the findings are exhaustive | 21 findings from a full read of 899 lines plus 12 authoritative documents. A different board would weight `RF-11` and `RF-19` differently |
