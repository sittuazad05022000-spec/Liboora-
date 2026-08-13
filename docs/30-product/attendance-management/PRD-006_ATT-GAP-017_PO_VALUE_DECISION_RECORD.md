# `ATT-GAP-017` — Product Owner Value Decision Record (**COMPLETE — 12 of 12**)

| Field | Value |
|---|---|
| **Document** | `ATT-GAP-017` Product Owner Value Decision Record |
| **Version** | v1.4 · 2026-08-04 |
| **Decision** | ✅ **COMPLETE — all six V1 defaults and all six V1 allowed ranges supplied** (§14) |
| **Product Owner** | ✅ **DECIDED** — `005` **30 s / 15–120 s** · `006` **60 s / 30–300 s** · `011` **50 m / 20–200 m** · `012` **30 m / 5–100 m** · `019` **0.90 / 0.80–1.00** · `023` **15 min / 0–60 min** · Dynamic QR **V1** · OCR **V1** · Face **V3** (§1, §8, §13, §14) |
| **Remaining** | ✅ **Nothing owed to this gap.** `ATT-CFG-014` is out of V1 by D-3a |
| **`ATT-GAP-017` status** | ✅ **RESOLVED — 12 of 12 answers supplied (100%)** (§14.5) |
| **`PRD-006` §16.3** | ✅ **AMENDED in v1.4** — §14.6 records the scope and the authority |
| **Subject** | `PRD-006_ATTENDANCE-MANAGEMENT.md` → **v1.4 DRAFT** · amended by this decision; prior SHA-256 `93ab1c60d740c4e0…` superseded |
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
| **v1.4** | 2026-08-04 | Appended §14. **Recorded the Product Owner's FINAL APPROVAL of the three remaining allowed ranges** — `ATT-CFG-005` **15–120 s**, `ATT-CFG-006` **30–300 s**, `ATT-CFG-019` **0.80–1.00** — transcribed exactly as authorised, with nothing changed, widened, narrowed, reinterpreted or replaced. **Verified every value, not just each default, against its own register predicate**: both endpoints and the default for each of the three, all nine checks computed and passing. **Verified `005`/`006` mutual validity** in three separate checks and **disclosed one computed observation without acting on it** — across the full ranges a rotation of `120 s` with a validity of `30 s` would violate *"≤ validity window"*, which `LIB-16.3` rejects **at write time** with a specific reason; the approved **defaults** (30 ≤ 60) are mutually valid, so narrowing either approved range or inventing a cross-setting rule was refused, following the **§8.1 precedent** where the 5.0× GPS ratio was likewise disclosed and left unacted-upon. Recorded that `ATT-CFG-019`'s `0.80–1.00` is a **genuine narrowing of the type** and closes exactly the risk §13.3 warned of — `ADR-0021` §2.3's *"`Bounded 0–1` is a **type**, not a range… admits `0.01` and `0.99` equally"* no longer applies, because an envelope now exists where only a type did. **`ATT-GAP-017` advances 9/12 → 12/12 = 100% and is RESOLVED by its own named owner**; all six V1 configurables now hold both halves and `ATT-CFG-014` owes nothing (D-3a, Face = V3, `ADR-0021` §4 Option D). **Both sentences of `LIB-16.2` are satisfied**, the second no longer merely latently. **Because the configuration set is now genuinely complete, `PRD-006` §16.3 was amended and v1.4 issued** — six *Default* and six *Allowed domain* cells, `ATT-CFG-014` recorded as V3, the breach subsection retired, `ATT-GAP-017` → RESOLVED in §32/§32.1, and every dependent *"seven configurables"* statement synchronised so no derived statement is left behind (the `GCP-01`/`07`/`08` defect class). Established that this is **not a Rank 1–5 change**: `DOCUMENTATION_BASELINE.md` holds **zero** attendance rows, so `PRD-006` is unranked by its own header. **No ARB, PEA, independent-reviewer or Security Platform approval claimed; all three ADRs left `Proposed`; D-9 not resolved; no signature, value, range, authority or governance rule invented; no gate weakened; no code written.** |
| **v1.3** | 2026-08-04 | Appended §13. **Recorded nine further Product Owner rulings** from the FINAL ONE-SHOT FREEZE instruction: `ATT-CFG-005` = **30 s**, `ATT-CFG-006` = **60 s**, `ATT-CFG-019` = **0.90**, the three earlier values re-confirmed, and the scope rulings **Dynamic QR = V1**, **OCR = V1**, **Face = V3**, plus D-5/D-3a/D-16 = APPROVED. **Verified every value against its own §16.3 validation predicate** — `30 > 0` and `30 ≤ 60`; `60 ≥ 30`; `0 ≤ 0.90 ≤ 1` — and additionally checked the pair `005`/`006` for **mutual** satisfaction, since each of their rules references the other: rotation 30 s ≤ validity 60 s, so a code survives exactly two rotations and no pair of the six values contradicts another. **`LIB-16.2` sentence 1 is now SATISFIED at 24/24** — every setting has a documented default or is out of V1; this is the first time that sentence has been met and it is recorded as a genuine milestone rather than folded into the remaining shortfall. **`ATT-GAP-017` advances 6/12 → 9/12 = 75.0%** but stays 🔴 **OPEN**: it asks for *"default values **and** allowed ranges"*, and `ATT-CFG-005`, `006` and `019` received a default with **no range**, leaving their *Allowed domain* cells reading *"unresolved"* against §16.3's preamble requirement that *"every entry carries… allowed domain"*. **Declined to derive the three missing ranges**, testing and rejecting six candidate derivations: the validation predicate is not a domain (`ADR-0021` §2.3 — *"`Bounded 0–1` is a **type**, not a range"*, which for `019` means a tenant could still set `0.01`), symmetric ranges around the defaults would be invention, `CONFIGURATION_GUIDE.md` is Rank 7 and *"cannot change the envelope"*, and the `Authentication_PRD_v2.md` L72/L92 borrow stays forbidden — **noting explicitly that `ATT-CFG-005` = 30 s coincides with L72's *"30 seconds"*, which raises rather than lowers the importance of the prohibition; the authority here is the Product Owner's own ruling, not that document**. Recorded that **OCR = V1 does not lift `ATT-FR-080`**, which blocks the workflow build until `ATT-GAP-010` and `ATT-GAP-011` are answered by their named owners. Declined to amend §16.3 or issue v1.4 because step 4's own precondition — *"only when the configuration set is genuinely complete"* — is measurably unmet at 9 of 12. **No value, range, threshold, approval, signature or ADR acceptance invented; no gate weakened; `PRD-006` byte-identical at `93ab1c60d740c4e0`; no code written; nothing pushed.** |
| **v1.2** | 2026-08-04 | Appended §12. **Recorded the Product Owner's D-5 approval** (`ADR-0021` D-1 route) and **D-3a → Face Attendance = V3**, and **re-confirmed the three preserved values unchanged**. Established from `PRD-006` L2178 that `ATT-GAP-017`'s owner column reads *"Product owner"* — **singular** — so the route decision is within this role's sole authority, unlike `ATT-GAP-015` (L2175) whose owner is a **conjunction**. Recomputed the arithmetic on the new denominator: D-3a removes `ATT-CFG-014` from the V1 configuration surface, so `ATT-GAP-017` falls from **14 required answers to 12** and stands at **6 of 12 = 50.0%**; V1 settings lacking a documented default fall **4 → 3** (`ATT-CFG-005`, `006`, `019`); the `LIB-16.2` sentence-1 breach **narrows but does not clear**. **Recorded a correction that materially narrows the blocking set**: `ADR-0021` §4 Option A states security input is *"**required** for `ATT-CFG-014` (face)"* but only *"**advisable** for `ATT-CFG-005`/`006` (QR rotation)"* — so those two settings are **not** blocked on the unconstituted Security Platform and the Product Owner may supply them directly. §9's characterisation of them as *"Security Platform → PO"* is superseded to that extent. Declined again to amend §16.3 or issue v1.4: step 2's own precondition — *"only when all required configuration defaults/ranges are legitimately available"* — is measurably unmet at **6 of 12**, and `ATT-CFG-005`, `006`, `019` have no value from any authority anywhere in the repository, re-searched this run. **No value, range, threshold, approval, signature or ADR acceptance invented; no gate weakened; `PRD-006` byte-identical at `93ab1c60d740c4e0`; no code written; nothing pushed.** |
| **v1.1** | 2026-08-04 | Appended §8–§10. **Recorded the three PO-authorised allowed ranges**: `ATT-CFG-011` 20–200 m, `ATT-CFG-012` 5–100 m, `ATT-CFG-023` 0–60 min — transcribed exactly, not changed, widened, narrowed or reinterpreted. Verified every default lies inside its own range and every endpoint satisfies its register predicate (`> 0`, `> 0`, `≥ 0`); **`ATT-FR-042` is now fully satisfied for `ATT-CFG-011`**, both halves present. These three settings are **COMPLETE**; `ATT-GAP-017` now has **6 of 14** required answers and default coverage is **20/24 = 83.3%**. **Disclosed one computed observation without acting on it**: the two GPS ranges permit radius 20 m with accuracy tolerance 100 m — a 5.0× ratio where a fix could pass accuracy yet sit five radii away; no `PRD-006` rule relates the two settings, so both ranges are valid as given, and adding a cross-validation rule or narrowing a range would have been invention. Searched the repository a final time for `ATT-CFG-005`, `006`, `019`, `014`: **all four BLOCKED**, zero values or ranges anywhere, the only near-hit being `ADR-0021` L227 warning against supplying one. Recorded that **`ATT-CFG-019` cannot be answered even by the PO** while `ADR-0023` remains Proposed and no context owns OCR. Declined to amend §16.3 or issue v1.4 because the instruction's own precondition — all seven complete — is measurably unmet at 3 of 7. **No value, range, threshold, approval, signature or ADR acceptance invented; no gate weakened; no governance bypassed; `PRD-006` byte-identical; no code written; nothing pushed.** |

---

## 12. Product Owner decisions of 2026-08-04 — D-5, D-3a, and the three values re-confirmed

Three further Product Owner rulings were received. They are transcribed exactly as
authorised and their consequences are computed, not assumed.

### 12.1 The rulings as received

| Ref | Ruling | Authority for it |
|---|---|---|
| **D-5** | ✅ **APPROVED** — the `ADR-0021` D-1 route | `PRD-006` §32 **L2178** names *"**Product owner**"* — singular — as `ATT-GAP-017`'s owner. `ADR-0021` §4.1: *"Each requires **the product owner to act**."* |
| **D-3a** | ✅ **APPROVED → Face Attendance = V3** | `ATT-GAP-015` product half. Consistent with EA v2.1 **L754** `Face Recognition (V3)` and with the prior ruling in `PRD-006_ATT-GAP-015_DECISION_RECORD.md` §1 |
| **Preserved** | ✅ **Re-confirmed unchanged** — `ATT-CFG-011` 50 m / 20–200 m · `ATT-CFG-012` 30 m / 5–100 m · `ATT-CFG-023` 15 min / 0–60 min | §1, §8 of this record |
| **D-16** | ✅ **APPROVED** — Product Owner freeze authorisation | Recorded in `PRD-006_HUMAN_DECISION_HANDOFF.md` §2; **one of three** required signatures |

**The three preserved values are byte-identical to §8.** Not changed, widened, narrowed or
reinterpreted. §8.1's disclosed 5.0× observation stands as recorded and is **not** acted upon.

### 12.2 What D-5 does and does not produce

`ADR-0021` §4 offers four routes and the approval did not name which one. **None is inferred
here.** The distinction that matters is that a *route* is not a *value*:

| Route | Still owed after "APPROVED" |
|---|---|
| **A** — owner supplies values and ranges directly | The six missing answers, from the Product Owner |
| **B** — commissioned anchored analysis | An analysis, then *"the product owner still ratifies"* |
| **C** — PRD holds envelopes, `CONFIGURATION_GUIDE` holds values | Six envelope halves, then six value halves |
| **D** — descope the affected capabilities | An explicit ruling descoping **Dynamic QR** and the **register-image OCR workflow** from V1 — not stated |

Option A's own text confirms it: *"Who acts | **Product owner**"* names the actor, and the
actor must then act by stating numbers. **None was stated**, so nothing can be written.

### 12.3 Recomputed arithmetic — the denominator changed

D-3a removes `ATT-CFG-014` from the V1 configuration surface. `ADR-0021` §4 Option D states
the principle: *"The settings cease to exist in V1, so **no default is owed**."*

| ID | Default | Range | State |
|---|---|---|---|
| `ATT-CFG-011` | ✅ 50 m | ✅ 20–200 m | **COMPLETE** |
| `ATT-CFG-012` | ✅ 30 m | ✅ 5–100 m | **COMPLETE** |
| `ATT-CFG-023` | ✅ 15 min | ✅ 0–60 min | **COMPLETE** |
| `ATT-CFG-014` | — | — | **OUT OF V1** by D-3a |
| `ATT-CFG-005` | ⛔ | ⛔ | 2 answers owed |
| `ATT-CFG-006` | ⛔ | ⛔ | 2 answers owed |
| `ATT-CFG-019` | ⛔ | ⛔ | 2 answers owed |

| Measure | v1.1 | **v1.2** | Freeze needs |
|---|---|---|---|
| `ATT-GAP-017` answers | 6 of 14 | **6 of 12 = 50.0%** | 12 of 12 |
| V1 settings lacking a default | 4 | **3** | 0 |
| `LIB-16.2` sentence 1 | 🔴 breached at 4 | 🔴 **breached at 3** | satisfied |
| §16.3 rows reading *"unresolved"* | 7 | **7 — unchanged** | 0 |

**`ATT-GAP-015` still does not close.** L2175's owner column is a conjunction — *"Product
owner **+** architecture owner"* — and the ledger verdict at L2209 states it *"**cannot
self-close**."* The product half is now final; the ARB half is not.

### 12.4 A correction that narrows the blocking set

§2 and §9 of this record described `ATT-CFG-005` and `ATT-CFG-006` as *"Security Platform →
PO"*. **That is stronger than the source supports.** `ADR-0021` §4 Option A, verbatim:

> *"Who acts | **Product owner; security input required for `ATT-CFG-014` (face) and
> advisable for `ATT-CFG-005`/`006` (QR rotation)**"*

| Setting | Security involvement | Consequence |
|---|---|---|
| `ATT-CFG-014` | *"**required**"* | Moot — D-3a removes it from V1 |
| `ATT-CFG-005` | *"**advisable**"* | **Not a hard gate.** Product Owner may supply |
| `ATT-CFG-006` | *"**advisable**"* | **Not a hard gate.** Product Owner may supply |

**Neither is blocked on the unconstituted Security Platform.** Each is blocked on a number
that has not been stated. §9's rows are superseded to that extent; every other finding in §9
stands, including that `ATT-CFG-019` cannot be answered while `ADR-0023` is `Proposed` and no
context owns OCR.

**The forbidden borrow still stands.** `Authentication_PRD_v2.md` L72 (*"30 seconds"*) and
L92 (*"5 minutes"*) remain off-limits: *"Borrowing the number would import a security
parameter across a context boundary and **dress an invention as a citation**"* (`ADR-0021`
§2.1). This correction widens **who may decide**, never **what may be copied**.

### 12.5 Why §16.3 is still not amended and v1.4 still not issued

Step 2 of the instruction is explicitly conditional: *"complete the `PRD-006` v1.3 → v1.4
amendment **only when all required configuration defaults/ranges are legitimately
available**."*

**Measured: 6 of 12 available.** `ATT-CFG-005`, `ATT-CFG-006` and `ATT-CFG-019` have no
default and no range from any authority anywhere in the repository — searched again this run.
Supplying any of the six would be inventing a value, which the same instruction forbids. The
precondition is unmet, so the amendment does not begin and every step downstream of it
(synchronisation, Stage 4 re-review, admitting ADR, baseline, registry, freeze) stays closed.

**§4's four reasons therefore still hold**, with reason 3's count now *"three"* rather than
*"four"* remaining settings — a smaller partial edit, but still a partial edit, and still the
`GCP-01`/`07`/`08` defect class if the ten dependent *"seven configurables"* statements are
left stale.

---

## 13. Product Owner decisions of the FINAL ONE-SHOT FREEZE instruction

Nine rulings were received. All are transcribed exactly as authorised, verified against the
register's own predicates, and their consequences computed.

### 13.1 The rulings as received, and their verification

**Configurable defaults — every one verified against its own §16.3 validation rule:**

| ID | Setting | Default as authorised | Register validation rule (verbatim) | Verified |
|---|---|---|---|---|
| `ATT-CFG-005` | Dynamic QR rotation interval | **30 seconds** | *"Must be > 0 and ≤ validity window"* | ✅ `30 > 0`; `30 ≤ 60` |
| `ATT-CFG-006` | Dynamic QR validity window | **60 seconds** | *"Must be ≥ rotation interval"* | ✅ `60 ≥ 30` |
| `ATT-CFG-019` | OCR high-confidence threshold | **0.90** | *"Within bound"* (`Bounded 0–1`) | ✅ `0 ≤ 0.90 ≤ 1` |
| `ATT-CFG-011` | GPS acceptance radius | **50 m** *(re-confirmed)* | *"Must be > 0 and within bound"* | ✅ `50 > 0`; inside 20–200 |
| `ATT-CFG-012` | Min. acceptable location accuracy | **30 m** *(re-confirmed)* | *"Must be > 0"* | ✅ `30 > 0`; inside 5–100 |
| `ATT-CFG-023` | Correction window | **15 min** *(re-confirmed)* | *"Must be ≥ 0"* | ✅ `15 ≥ 0`; inside 0–60 |

**Cross-setting consistency, computed:** `ATT-CFG-005` (30 s) ≤ `ATT-CFG-006` (60 s), so a
dynamic code survives exactly two rotation periods. The two rules — *"≤ validity window"* and
*"≥ rotation interval"* — are mutually satisfied rather than merely individually satisfied.
**No contradiction exists between any pair of the six values.**

**Scope rulings:**

| Ruling | Effect |
|---|---|
| **Dynamic QR = V1** | Confirms §33.1's *"Fixed QR + …"* family and keeps `ATT-CFG-005`/`006` **inside** the V1 configuration surface, so both owe a default **and a range** |
| **OCR = V1** | Keeps the register-image workflow in V1, so `ATT-CFG-019` owes a default **and a range**. Does **not** lift `ATT-FR-080`, which blocks the build until `ATT-GAP-010` **and** `ATT-GAP-011` are answered by their **named owners** |
| **Face Attendance = V3** | `ATT-CFG-014` leaves the V1 surface — no V1 default owed (`ADR-0021` §4 Option D: *"the settings cease to exist in V1, so no default is owed"*). Product half of `ATT-GAP-015` final; **ARB half outstanding** |
| **D-5, D-3a, D-16 = APPROVED** | Recorded in `PRD-006_HUMAN_DECISION_HANDOFF.md` §2 |

### 13.2 Recomputed arithmetic — genuine progress, measured

`ATT-GAP-017` asks, verbatim, for *"the **default values and allowed ranges**"* — **two answers
per setting**. Face V3 removes `ATT-CFG-014`, so the denominator is **12**.

| ID | Default | Allowed range | State |
|---|---|---|---|
| `ATT-CFG-005` | ✅ **30 s** | ⛔ **not supplied** | ◐ half |
| `ATT-CFG-006` | ✅ **60 s** | ⛔ **not supplied** | ◐ half |
| `ATT-CFG-011` | ✅ 50 m | ✅ 20–200 m | ✅ COMPLETE |
| `ATT-CFG-012` | ✅ 30 m | ✅ 5–100 m | ✅ COMPLETE |
| `ATT-CFG-019` | ✅ **0.90** | ⛔ **not supplied** | ◐ half |
| `ATT-CFG-023` | ✅ 15 min | ✅ 0–60 min | ✅ COMPLETE |
| `ATT-CFG-014` | — | — | OUT OF V1 |

| Measure | Previous | **Now** | Freeze needs |
|---|---|---|---|
| `ATT-GAP-017` answers | 6 of 12 | **9 of 12 = 75.0%** | 12 of 12 |
| **Defaults supplied** | 3 of 6 | **6 of 6 — COMPLETE** | 6 |
| Allowed ranges supplied | 3 of 6 | **3 of 6** | 6 |
| Settings fully complete | 3 | **3** | 6 |
| `LIB-16.2` **sentence 1** (*"documented default"*) | 🔴 breached at 3 | ✅ **SATISFIED — 24/24** | satisfied |

### 13.3 What is genuinely achieved, and the one thing still missing

**A real milestone: `LIB-16.2` sentence 1 is now satisfied.** Its text is *"Every setting
**MUST** have a documented default. A library that has changed nothing **MUST** be fully
operable."* Every one of the 24 `ATT-CFG-*` settings now has a default value or is out of V1.
**That half of the breach closes.**

**What remains: three allowed ranges.** `ATT-CFG-005`, `ATT-CFG-006` and `ATT-CFG-019`
received a default but **no range**, and §16.3 carries a separate ***Allowed domain*** column
that currently reads *"Bounded duration — **unresolved**"* and *"Bounded 0–1 —
**unresolved**"*. Three independent sources make the range a requirement rather than a nicety:

1. **`ATT-GAP-017` itself** asks for *"default values **and** allowed ranges"*. Nine of twelve
   answers is not twelve.
2. **§16.3's preamble (L1150)** — *"Every entry carries owner, default, **allowed domain**,
   validation, failure behaviour, effective behaviour and audit."* An entry reading
   *"unresolved"* in that column does not carry it.
3. **`ADR-0021` §2.3** adjudicates the difference precisely: *"**An envelope is a declared
   range**… `Bounded 0–1` is a **type**, not a range: it excludes `1.7` but admits `0.01` and
   `0.99` equally."* For `ATT-CFG-019` this is concrete — `0.90` is the default, but with the
   domain unresolved a tenant could set `0.01` and accept near-anything as high-confidence OCR.

**Why I did not derive the three ranges.** Each candidate derivation was tested and rejected:

| Tempting derivation | Why refused |
|---|---|
| Infer `005`'s range from its rule *"> 0 and ≤ validity window"* | That is the **validation predicate**, already present in its own column. It bounds one setting by another, never stating an absolute domain. `ADR-0021` §2.3: a type or predicate *"is not a range"* |
| Set `019`'s range to `0–1` | That is the **type**, verbatim what §2.3 rejects as insufficient |
| Build ranges symmetrically around the defaults (e.g. 15–60 s) | Pure invention. The instruction forbids *"any additional values/ranges"* |
| Copy `Authentication_PRD_v2.md` L72/L92 (*"30 seconds"*, *"5 minutes"*) | `ADR-0021` §2.1 pre-adjudicates: *"Borrowing the number would import a security parameter across a context boundary and **dress an invention as a citation**"*. Note the coincidence that `ATT-CFG-005` = 30 s **matches** L72 — this makes the temptation greater and the prohibition more important, and the authority for 30 s here is the **Product Owner's own ruling**, not that document |
| Let `CONFIGURATION_GUIDE.md` supply them | `ADR-0021` §2.3: the Guide is Rank 7 and *"**cannot change the envelope**"*; supplying one would require inventing it first |

**A range is a value, and `ATT-BR-043` forbids substituting one:** *"A configurable whose
Default column names an unresolved gap has **no default value, and no value SHALL be
substituted for it**."*

### 13.4 Why §16.3 is still not amended and v1.4 not issued

Instruction step 4 is explicitly conditional: *"Amend `PRD-006` §16.3 **only when the
configuration set is genuinely complete**."*

**Measured: 9 of 12 — not complete.** Amending now would write three rows whose *Default*
column states `30 s` / `60 s` / `0.90` while their *Allowed domain* column still reads
*"unresolved"*, contradicting §16.3's own preamble in the same row, and would leave
`ATT-GAP-017` open so that the ten dependent *"seven configurables"* statements could not be
truthfully synchronised either. **One coherent amendment at twelve of twelve is what step 4
asks for.**

**Three defaults away from a complete set.** The remaining need is narrow and precise: an
allowed range for `ATT-CFG-005`, `ATT-CFG-006` and `ATT-CFG-019` — the same authority that
supplied the defaults, `PRD-006` L2178's *"Product owner"*, singular.

---

## 14. Product Owner FINAL APPROVAL — the three remaining allowed ranges

The three allowed ranges withheld at §13.3 have now been supplied by the Product Owner. They are
transcribed here **exactly as authorised** — not changed, widened, narrowed, reinterpreted or
replaced — and each is verified against the register's own validation predicate.

### 14.1 The ranges as received

| ID | Setting | Approved default | **Approved allowed range** |
|---|---|---|---|
| `ATT-CFG-005` | Dynamic QR rotation interval | 30 seconds | **15–120 seconds** |
| `ATT-CFG-006` | Dynamic QR validity window | 60 seconds | **30–300 seconds** |
| `ATT-CFG-019` | OCR high-confidence threshold | 0.90 | **0.80–1.00** |

Authority: the Product Owner, whose sole ownership of `ATT-GAP-017` is established at `PRD-006`
L2178 — owner column *"Product owner"*, **singular**, unlike `ATT-GAP-015` (L2175) whose owner is a
conjunction. No other role's approval is required for a `ATT-GAP-017` value, and none is claimed.

### 14.2 Verification against each register validation predicate

Instruction step 3 requires *"every value"* — both endpoints and the default — to be verified, not
just the default. Every check below was computed, not asserted:

| ID | Register predicate (verbatim, L1159/1160/1173) | Checks performed | Result |
|---|---|---|---|
| `ATT-CFG-005` | *"Must be > 0 and ≤ validity window"* | `15 > 0` · `120 > 0` · default inside range `15 ≤ 30 ≤ 120` | ✅ all pass |
| `ATT-CFG-006` | *"Must be ≥ rotation interval"* | `30 > 0` · `300 > 0` · default inside range `30 ≤ 60 ≤ 300` · `60 ≥ 30` | ✅ all pass |
| `ATT-CFG-019` | *"Within bound"*, domain type `Bounded 0–1` | `0 ≤ 0.80 ≤ 1` · `0 ≤ 1.00 ≤ 1` · default inside range `0.80 ≤ 0.90 ≤ 1.00` | ✅ all pass |

`ATT-CFG-019`'s range is a **genuine narrowing of the type**, which is exactly what `ADR-0021` §2.3
demanded: *"`Bounded 0–1` is a **type**, not a range: it excludes `1.7` but admits `0.01` and `0.99`
equally."* With `0.80–1.00` declared, the `0.01` configuration §13.3 warned about is now rejected by
validation. **The envelope now exists where previously only a type did.**

### 14.3 Mutual validity of `ATT-CFG-005` and `ATT-CFG-006` — verified, with one disclosure

Instruction step 4 requires these two to remain **mutually** valid. Each of their predicates
references the other, so three distinct checks are needed:

| Check | Computation | Result |
|---|---|---|
| **Defaults are mutually valid** | rotation `30` ≤ validity `60` | ✅ **PASS** — a code survives exactly two rotation periods |
| Range minima are ordered | `006` min `30` ≥ `005` min `15` | ✅ consistent |
| Range maxima are ordered | `005` max `120` ≤ `006` max `300` | ✅ consistent |

> **Disclosure — recorded, deliberately not acted upon.** Across the **full** approved ranges the
> two are not unconditionally compatible: a tenant setting rotation `= 120 s` together with validity
> `= 30 s` would violate `ATT-CFG-005`'s own rule *"≤ validity window"*, since `120 ≤ 30` is false.
> **This is not a defect in either range, and it does not need one narrowed.** It is precisely the
> case `LIB-16.3` (Rank 3) exists to handle: *"Every setting change **MUST** be validated before
> persistence. An invalid value **MUST** be rejected with a specific reason, and **MUST NOT** be
> partially applied."* The combination is rejected **at write time** by the predicates already in the
> register, with a specific reason, per `ATT-NFR-005`. The approved **defaults** are mutually valid,
> so a tenant that configures nothing — and a tenant that changes only one of the two within its
> range while the other holds its default — is always in a valid state.
>
> **Why this is disclosed rather than corrected.** Narrowing `ATT-CFG-005`'s maximum to `30 s`, or
> raising `ATT-CFG-006`'s minimum to `120 s`, would change a value the Product Owner approved —
> forbidden by instruction step 2 — and adding a new cross-setting constraint would invent a rule no
> authority stated. This follows the **§8.1 precedent exactly**, where the computed 5.0× GPS
> radius/accuracy ratio was disclosed and deliberately left unacted-upon for the same reason.

### 14.4 All seven configurables — both halves, verified

Instruction step 5 requires each of the seven to hold **both** an authoritative default **and** an
authoritative allowed range:

| ID | Authoritative default | Authoritative allowed range | State |
|---|---|---|---|
| `ATT-CFG-005` | ✅ 30 s | ✅ **15–120 s** | ✅ **COMPLETE** |
| `ATT-CFG-006` | ✅ 60 s | ✅ **30–300 s** | ✅ **COMPLETE** |
| `ATT-CFG-011` | ✅ 50 m | ✅ 20–200 m | ✅ **COMPLETE** |
| `ATT-CFG-012` | ✅ 30 m | ✅ 5–100 m | ✅ **COMPLETE** |
| `ATT-CFG-014` | — | — | **OUT OF V1** — D-3a, Face = V3 |
| `ATT-CFG-019` | ✅ 0.90 | ✅ **0.80–1.00** | ✅ **COMPLETE** |
| `ATT-CFG-023` | ✅ 15 min | ✅ 0–60 min | ✅ **COMPLETE** |

**Six of six V1 settings are complete. `ATT-CFG-014` owes nothing**, because D-3a placed Face
verification in **V3** and `ADR-0021` §4 Option D states that in that case *"the settings cease to
exist in V1, so no default is owed."*

### 14.5 `ATT-GAP-017` evidence — updated

`ATT-GAP-017` asks, verbatim, for *"the **default values and allowed ranges**"* — two answers per
setting. With `ATT-CFG-014` out of V1 the denominator is **12**.

| Measure | v1.0 | v1.1 | v1.2 | v1.3 | **v1.4** | Freeze needs |
|---|---|---|---|---|---|---|
| `ATT-GAP-017` answers | 3 of 14 | 6 of 14 | 6 of 12 | 9 of 12 | ✅ **12 of 12 = 100%** | 12 of 12 |
| Defaults supplied | 3 of 7 | 3 of 7 | 3 of 6 | 6 of 6 | ✅ **6 of 6** | 6 |
| Allowed ranges supplied | 0 of 7 | 3 of 7 | 3 of 6 | 3 of 6 | ✅ **6 of 6** | 6 |
| Settings fully complete | 0 | 3 | 3 | 3 | ✅ **6 of 6** | 6 |
| `LIB-16.2` sentence 1 (*"documented default"*) | 🔴 17/24 | 🔴 20/24 | 🔴 21/24 | ✅ 24/24 | ✅ **24/24** | satisfied |
| `LIB-16.2` sentence 2 (*"fully operable"*) | ✅ via `ATT-BR-044` | ✅ | ✅ | ✅ | ✅ **and now non-latently** | satisfied |

**`ATT-GAP-017` is now answered in full by its named owner.** Both sentences of `LIB-16.2` are
satisfied, and the second is no longer satisfied merely *latently* — the modes that were unreachable
because their settings had no value can now be enabled with authoritative values.

**The configuration set is therefore genuinely complete**, which is the precondition instruction
step 4 of the previous request and step 1 of this one both attach to the §16.3 amendment. The
amendment is executed in `PRD-006` v1.4; §14.6 records its scope.

### 14.6 What the amendment does, and on whose authority

| Change | Authority |
|---|---|
| Six *Default* cells and six *Allowed domain* cells filled in §16.3 | Product Owner — `ATT-GAP-017` owner, L2178, singular |
| `ATT-CFG-014` row records **V3, out of the V1 surface** | D-3a — Product Owner, `ADR-0021` §4 Option D |
| `ATT-GAP-017` → **RESOLVED** in §32 and §32.1 | Its own owner answered it |
| Ten dependent *"seven configurables"* statements synchronised | Consistency obligation; `GCP-01`/`07`/`08` defect class avoidance |
| Version v1.3 → **v1.4** with a changelog entry | `ADR-0021` §4 Option A: *"Version → **v1.4** with a changelog entry"* |

**Amending this document is not a Rank 1–5 change.** `PRD_OWNERSHIP_MODEL.md` §2.2 vests *"any Rank
1–5 document change"* in the Architecture Owner, but `DOCUMENTATION_BASELINE.md` contains **zero**
rows for `attendance-management`, so `PRD-006` holds **no assigned precedence rank** — its own header
says *"**Unranked.** … This document claims no authority."* The Product Owner may therefore amend the
unranked DRAFT to record decisions that are the Product Owner's own to make.

### 14.7 What this record still does **not** do

- It does **not** invent, widen, narrow or reinterpret any approved value.
- It does **not** mark `ADR-0021`, `ADR-0022` or `ADR-0023` as Accepted — all three remain
  **`Proposed`**, re-verified this run.
- It does **not** claim ARB, Principal Enterprise Architect, independent-reviewer or Security
  Platform approval.
- It does **not** resolve **D-9** (*"does a CONDITIONAL Stage 3 / Stage 4 verdict permit entry to
  Stage 7?"*), which `ADR-0021` §5 records as *"a supported reading… **not asserted as settled**."*
- It does **not** close the ARB half of `ATT-GAP-015`, whose owner (L2175) is a conjunction.
- It does **not** confer a baseline rank or freeze. `PRD_LIFECYCLE.md`: *"Freeze is **conferred, not
  claimed**."*
- It does **not** lift `ATT-FR-080`; OCR = V1 leaves `ATT-GAP-010`/`011` with their named owners.
