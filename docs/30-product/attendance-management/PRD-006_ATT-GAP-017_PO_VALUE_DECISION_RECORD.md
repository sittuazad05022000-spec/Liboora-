# `ATT-GAP-017` — Product Owner Value Decision Record (3 of 7 complete)

| Field | Value |
|---|---|
| **Document** | `ATT-GAP-017` Product Owner Value Decision Record |
| **Version** | v1.1 · 2026-08-04 |
| **Decision** | **Three of seven configurables COMPLETE — default + allowed range supplied by the Product Owner** |
| **Product Owner** | ✅ **DECIDED** — `ATT-CFG-011` **50 m / 20–200 m** · `ATT-CFG-012` **30 m / 5–100 m** · `ATT-CFG-023` **15 min / 0–60 min** (§1, §8) |
| **Remaining** | ⛔ **`ATT-CFG-005`, `006`, `019`, `014` — all BLOCKED** (§9) |
| **`ATT-GAP-017` status** | 🔴 **OPEN — 6 of 14 answers supplied** (§3, §8) |
| **`PRD-006` §16.3** | **NOT amended** — and §4 states why |
| **Subject** | `PRD-006_ATTENDANCE-MANAGEMENT.md` v1.3 DRAFT · SHA-256 `93ab1c60d740c4e0…` **unmodified** |
| **Freeze** | 🔴 **Not conferred.** Nothing here freezes anything |

> **What this record is.** It is the decision/approval record for the first genuine Product Owner values
> supplied for `ATT-GAP-017`. It records **exactly** what was decided, and — with equal care — **exactly what
> was not**. It invents no value, no range, no security threshold, no ADR acceptance and no ARB approval.

---

## 1. The decision as received

Three values were supplied by the Product Owner, who is the owner `PRD-006` §32 names for `ATT-GAP-017`:

| ID | Setting | Approved value | Register validation rule | Value satisfies rule? |
|---|---|---|---|---|
| `ATT-CFG-011` | GPS acceptance radius | **50 m** | *"Must be > 0 and within bound"* | ✅ `50 > 0` · bound itself not supplied |
| `ATT-CFG-012` | Minimum acceptable location accuracy | **30 m** | *"Must be > 0"* | ✅ `30 > 0` |
| `ATT-CFG-023` | Correction window | **15 minutes** | *"Must be ≥ 0"* | ✅ `15 ≥ 0` |

**Internal consistency check, computed:** `ATT-CFG-012` (30 m) is finer than `ATT-CFG-011` (50 m), so a fix
accepted at the accuracy floor is still resolvable inside the radius. The two values do not contradict each
other. No rule in `PRD-006` relates `ATT-CFG-023` to either.

**Authority.** `PRD_OWNERSHIP_MODEL.md` §2.2 assigns scope and product-value decisions to the Product Owner, and
`PRD-006` §32 names *"Product owner"* as `ATT-GAP-017`'s owner. These three values are therefore validly decided.

---

## 2. What was **not** supplied — measured, not assumed

| Item | Owner | State |
|---|---|---|
| **Allowed range for `ATT-CFG-011`** | Product Owner | ⛔ **Not supplied** |
| **Allowed range for `ATT-CFG-012`** | Product Owner | ⛔ **Not supplied** |
| **Allowed range for `ATT-CFG-023`** | Product Owner | ⛔ **Not supplied** |
| `ATT-CFG-005` rotation interval — value **and** range | Security Platform → PO | ⛔ **Not supplied** |
| `ATT-CFG-006` validity window — value **and** range | Security Platform → PO | ⛔ **Not supplied** |
| `ATT-CFG-019` OCR threshold | PO, after OCR ownership | ⛔ **Not supplied** |
| `ATT-CFG-014` Face match threshold | PO + Security Platform | ⛔ **Not supplied** |

The instruction supplying the three values explicitly directed that no remaining value, range, security
threshold, ADR acceptance or ARB decision be invented. None was.

---

## 3. Why `ATT-GAP-017` is **not** closed by this decision

`ATT-GAP-017` is not a request for seven numbers. Its text, verbatim from §32 L2178:

> *"What are the **default values and allowed ranges** for the seven numeric configurables marked unresolved in
> §16.3 (`ATT-CFG-005`, `006`, `011`, `012`, `014`, `019`, `023`)?"*

Two things are asked for each setting. **Three defaults were supplied; zero ranges were supplied.** Four
settings received neither.

For `ATT-CFG-011` the requirement is not merely the gap's phrasing — it is a **module-internal MUST**:

> `ATT-FR-042` (L737) — *"An acceptance radius **MUST** be configurable per tenant (`ATT-CFG-011`) **with a
> default and a bounded allowed range**."*

So `50 m` satisfies exactly half of `ATT-FR-042`. The other half remains open, and `ATT-BR-043` forbids
supplying it here: *"no value **SHALL** be substituted for it."* A bound is a value.

**Arithmetic, recomputed.** `LIB-16.2`'s first sentence — *"Every setting **MUST** have a documented default"* —
concerns defaults only, and against that sentence the position genuinely improves:

| Measure | Before | **After these three** |
|---|---|---|
| Settings with no documented default | **7** | **4** — `ATT-CFG-005`, `006`, `014`, `019` |
| `LIB-16.2` sentence-1 coverage | 17/24 = 70.8% | **20/24 = 83.3%** |
| `LIB-16.2` sentence 1 | 🔴 breached | 🔴 **still breached** — four settings remain |
| Settings with no allowed range | **7** | **7 — unchanged** |

**The `LIB-16.2` breach is reduced, not cleared.** It remains the single freeze-blocking condition.

---

## 4. Why `PRD-006` §16.3 was **not** amended in this commit

Writing `50 m`, `30 m` and `15 minutes` into the Default column was considered and **declined**, for four
reasons that are all measurable rather than cautious:

1. **It would create an internal contradiction for `ATT-CFG-011`.** The Default column would read `50 m` while
   the Allowed domain column still reads *"Bounded distance — **unresolved**"*. `ATT-FR-042` demands both, so
   the row would assert a satisfied requirement that is half unsatisfied.
2. **`ATT-BR-043` would be triggered against the remaining four.** The rule keys off *"a configurable whose
   Default column names an unresolved gap"*. Editing three rows while four still name `ATT-GAP-017` is
   coherent — but every dependent statement then becomes wrong, which is point 3.
3. **Ten dependent statements say "seven", and each would need recomputing:** L1185 heading, L1187 list,
   L1190, L1214 (`ATT-BR-044`'s operability check), L1229, `ATT-AC-199` (L2059), `ATT-AC-212` (L2071),
   L2178 (the gap text), L2212 (the ledger verdict) and L2316. A partial edit that leaves any of them reading
   *"seven"* is exactly the `GCP-01`/`07`/`08` defect class this repository has logged three times: *a derived
   statement left behind by a change to the thing it describes*.
4. **It would change the subject document, and change nothing about freeze.** Amending v1.3 → v1.4 re-triggers
   Stage 4 (the subject hash would move off `93ab1c60d740c4e0`, which is the trigger test), and the outcome
   would still be a `LIB-16.2` breach at four settings. The document would be re-reviewed to arrive at the same
   verdict.

**Therefore the correct sequencing is: collect the remaining four values *and* all seven ranges, then amend
§16.3 once, increment to v1.4, and re-run Stage 4.** One coherent amendment, not two incoherent ones. This
record preserves the decision losslessly until then, exactly as `PRD-006_ATT-GAP-015_DECISION_RECORD.md`
preserves the Face V3 ruling without amending §12.

---

## 5. Stage results at the time of this record

| Stage | Result |
|---|---|
| **Stage 4** | ⚠️ **CONDITIONALLY PASSED** — 0 commits to subject since `93fa81f`, hash identical → no re-review triggered. **Not upgraded** |
| **Stage 5** | ✅ **exit 0** — 516 identifiers · 285 obligation-bearing · 0 dangling · 0 orphan · 0 collisions · ledger 18 open |
| **Stage 6** | ✅ **exit 0** — 80 tasks · 12 BLOCKED · **285/285 = 100.0%** |
| **Stage 7** | 🔴 **UNSATISFIED** — `attendance-management` rows in `DOCUMENTATION_BASELINE.md`: **0**; registry L236 `` `PLANNED` `` |

---

## 6. What this record did **not** do

| Not done | Why |
|---|---|
| Invent a range for any of the three | `ATT-BR-043` — *"no value **SHALL** be substituted"*. A bound is a value |
| Invent `ATT-CFG-005`/`006` ranges | Security Platform input; absent |
| Invent `ATT-CFG-019` or `ATT-CFG-014` | OCR ownership undecided; Face threshold needs security input |
| Amend `PRD-006` §16.3 | §4 — four measured reasons; the amendment must be made once, completely |
| Close `ATT-GAP-017` | §3 — three of fourteen required answers supplied (7 defaults + 7 ranges) |
| Accept `ADR-0021`, `0022` or `0023` | No acceptance authority present. All remain **Proposed** |
| Record an ARB approval for Face V3 | None exists — searched again, including full git history |
| Add a baseline row / flip the registry | No accepted admitting ADR exists (§12.3 of the freeze execution record) |
| Mark `PRD-006` FROZEN | Freeze is *"conferred, not claimed"* — `PRD_LIFECYCLE.md` L161 |

---

## 7. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-04 | Created. Records the first genuine Product Owner values for `ATT-GAP-017`: `ATT-CFG-011` = **50 m**, `ATT-CFG-012` = **30 m**, `ATT-CFG-023` = **15 minutes**. Verified each against its register validation rule (`> 0`, `> 0`, `≥ 0` — all satisfied) and checked the two distance values for mutual consistency (30 m accuracy floor is finer than the 50 m radius, so they do not conflict). Recomputed `LIB-16.2` sentence-1 coverage: **17/24 → 20/24 = 83.3%**; settings lacking a default **7 → 4** (`005`, `006`, `014`, `019`); settings lacking an allowed range **7 → 7, unchanged**. Established from source that `ATT-GAP-017` asks for *"default values **and** allowed ranges"* and that `ATT-FR-042` requires `ATT-CFG-011` to have **both**, so three defaults answer 3 of 14 required items and **the gap stays OPEN**. Declined to amend `PRD-006` §16.3, giving four measured reasons: the `ATT-CFG-011` row would self-contradict, ten dependent statements say *"seven"*, a partial edit reproduces the logged `GCP-01`/`07`/`08` defect class, and amending the subject re-triggers Stage 4 to reach the same verdict. **No range, threshold, approval, signature or ADR acceptance invented; no gate weakened; `PRD-006` and all protected documents byte-identical; no code written; nothing pushed.** |

---

## 8. Ranges supplied — the three settings are now COMPLETE

The Product Owner subsequently supplied the missing allowed ranges. **Recorded exactly as authorised; not
changed, widened, narrowed or reinterpreted.**

| ID | Setting | Default | **Allowed range** | Register validation rule | Verified |
|---|---|---|---|---|---|
| `ATT-CFG-011` | GPS acceptance radius | **50 m** | **20 – 200 m** | *"Must be > 0 and within bound"* | ✅ `20 > 0`; `20 ≤ 50 ≤ 200` |
| `ATT-CFG-012` | Minimum location accuracy | **30 m** | **5 – 100 m** | *"Must be > 0"* | ✅ `5 > 0`; `5 ≤ 30 ≤ 100` |
| `ATT-CFG-023` | Correction window | **15 min** | **0 – 60 min** | *"Must be ≥ 0"* | ✅ `0 ≥ 0`; `0 ≤ 15 ≤ 60` |

Every default falls inside its own range, and every range endpoint satisfies the register's validation
predicate. **`ATT-FR-042` is now fully satisfied for `ATT-CFG-011`** — it required *"a default **and** a bounded
allowed range"*, and both now exist.

**These three settings are complete.** Of the fourteen answers `ATT-GAP-017` requires (7 defaults + 7 ranges),
**six now exist**.

### 8.1 One disclosed observation — recorded, not acted upon

Computed from the two GPS ranges as authorised:

| Combination | Radius | Accuracy tolerance | Ratio |
|---|---|---|---|
| **Chosen defaults** | 50 m | 30 m | 0.6× — accuracy finer than radius ✅ |
| **Worst combination the ranges permit** | 20 m (min) | 100 m (max) | **5.0×** |

At the permitted extremes a tenant could set a 20 m radius while accepting fixes accurate only to ±100 m, so a
position could pass the accuracy test yet be five radii from the library. No rule in `PRD-006` relates
`ATT-CFG-011` to `ATT-CFG-012` — `ATT-FR-045` and `ATT-FR-046` evaluate them independently — so this is **not a
rule violation** and both ranges are validly recorded as given.

**It is disclosed, not corrected.** Adding a cross-validation rule (for example *"accuracy tolerance MUST NOT
exceed the radius"*) would be inventing a requirement the Product Owner did not authorise, and narrowing either
range would breach the instruction not to narrow them. It is surfaced here so the decision is made knowingly by
its owner rather than discovered later in implementation.

---

## 9. The four remaining configurables — searched again, all BLOCKED

A final repository-wide search for authoritative values or ranges for the remaining four:

| ID | Setting | Owner | Result |
|---|---|---|---|
| `ATT-CFG-005` | Dynamic QR rotation interval | **Security Platform** → PO | ⛔ **BLOCKED** — no value, no range anywhere |
| `ATT-CFG-006` | Dynamic QR validity window | **Security Platform** → PO | ⛔ **BLOCKED** — no value, no range anywhere |
| `ATT-CFG-019` | OCR high-confidence threshold | PO, after OCR ownership | ⛔ **BLOCKED** — `ADR-0023` **Proposed**; ownership unassigned |
| `ATT-CFG-014` | Face match confidence threshold | PO + Security Platform | ⛔ **BLOCKED** — no ARB approval of Face V3 exists |

The only near-hit in the entire repository is `ADR-0021` L227, which is not a value but a warning about
supplying one: *"a range is itself a security statement (`0.01` vs `0.95` for face match). Splitting it does
**not** reduce the judgement required; it relocates half of it."*

No Security Platform approval document exists in `attendance-management/`; the sole approval artefact is
`PRD-006_ATT-GAP-015_APPROVAL_REQUEST.md`, whose ARB signature line remains blank.

**`ATT-CFG-019` cannot be answered even by the Product Owner today.** `ADR-0023`'s own title states *"No context
owns an OCR/Vision capability, **and this ADR does not assign one**."* Until ownership is assigned, there is no
owner to set the threshold — the instruction's own condition *"`ADR-0023` governance follow karo"* is therefore
unmet, and accepting that ADR without ARB authority is prohibited.

---

## 10. Why §16.3 still cannot be amended, and v1.4 not issued

The instruction's finalization sequence is explicitly conditional: *"**Jab saare 7 configurables ke default +
allowed range legitimately available ho jayein**"* — then amend, synchronise, version and freeze.

**Measured: 3 of 7 settings are complete. 4 are not.** The condition is unmet, so steps 1–8 do not begin.

| Measure | Original | **Now** | Freeze needs |
|---|---|---|---|
| Settings with a documented default | 17/24 | **20/24 = 83.3%** | 24/24 |
| Settings with a documented range | 17/24 | **20/24** | 24/24 |
| Settings fully complete of the seven | 0 | **3** | 7 |
| `ATT-GAP-017` answers supplied | 0/14 | **6/14** | 14/14 |
| `LIB-16.2` sentence 1 | 🔴 breached | 🔴 **still breached** — 4 settings | satisfied |

Amending §16.3 for three rows now would move the subject hash off `93ab1c60d740c4e0`, re-trigger Stage 4, force
the ten *"seven"* statements to be recomputed to *"four"*, and still terminate in a `LIB-16.2` breach — a second
full amendment cycle would then be needed when the last four arrive. **One coherent amendment at seven-of-seven
is what the instruction asks for and what the document deserves.**

---

## 11. Change history

| Version | Date | Change |
|---|---|---|
| **v1.1** | 2026-08-04 | Appended §8–§10. **Recorded the three PO-authorised allowed ranges**: `ATT-CFG-011` 20–200 m, `ATT-CFG-012` 5–100 m, `ATT-CFG-023` 0–60 min — transcribed exactly, not changed, widened, narrowed or reinterpreted. Verified every default lies inside its own range and every endpoint satisfies its register predicate (`> 0`, `> 0`, `≥ 0`); **`ATT-FR-042` is now fully satisfied for `ATT-CFG-011`**, both halves present. These three settings are **COMPLETE**; `ATT-GAP-017` now has **6 of 14** required answers and default coverage is **20/24 = 83.3%**. **Disclosed one computed observation without acting on it**: the two GPS ranges permit radius 20 m with accuracy tolerance 100 m — a 5.0× ratio where a fix could pass accuracy yet sit five radii away; no `PRD-006` rule relates the two settings, so both ranges are valid as given, and adding a cross-validation rule or narrowing a range would have been invention. Searched the repository a final time for `ATT-CFG-005`, `006`, `019`, `014`: **all four BLOCKED**, zero values or ranges anywhere, the only near-hit being `ADR-0021` L227 warning against supplying one. Recorded that **`ATT-CFG-019` cannot be answered even by the PO** while `ADR-0023` remains Proposed and no context owns OCR. Declined to amend §16.3 or issue v1.4 because the instruction's own precondition — all seven complete — is measurably unmet at 3 of 7. **No value, range, threshold, approval, signature or ADR acceptance invented; no gate weakened; no governance bypassed; `PRD-006` byte-identical; no code written; nothing pushed.** |
