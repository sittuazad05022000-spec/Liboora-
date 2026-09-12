# `ADR-0139` — `API-GAP-001` is FORMALLY RE-AFFIRMED OPEN on re-measured evidence; newly located Rank 6 evidence places API Deprecation Strategy at **V3**

| Field | Value |
|---|---|
| **ADR** | `ADR-0139` |
| **Status** | ⭐ **Accepted** — 2026-09-11, by direct, explicit conferral of the human principal of this engagement jointly exercising **Product Owner** and **Architecture Owner** authority — ⭐ **the exact pairing [`ADR-0135`](./ADR-0135-api-governance-style-error-taxonomy-versioning-idempotency-transport.md) L195 names for this gap** — scoped to **this act and nothing else**. ⛔ *"A conferral for one act is not a standing licence"* (`ADR-0033` §7.1); both offices **revert on completion**. ⛔ **No ARB quorum, attendee list, Security review or Legal opinion is asserted** |
| **Date** | 2026-09-11 |
| **Act** | ⭐ **Resolve or formally re-affirm `API-GAP-001` using ONLY existing governed evidence.** ⛔ **NOTHING ELSE** |
| **⭐⭐ Outcome** | ⛔⛔ **`API-GAP-001` REMAINS OPEN — formally RE-AFFIRMED, not resolved.** ⭐ The governed evidence is **insufficient** to decide any of the four points `ADR-0135` §3.2 enumerates, and ⭐ **newly located Rank 6 evidence (EA L1797, `API Deprecation Strategy (V3)`) places the subject one release horizon FURTHER OUT than `ADR-0135` recorded** |
| **Owner** | ⭐ **CONFIRMED UNCHANGED — Product Owner + Architecture Owner** (`ADR-0135` **L195**) |
| **Baseline** | ⚠ **`BASELINE-2026-09-11-B` STANDS** — `DOCUMENTATION_BASELINE.md` §7 **rule 4**'s limb is **UNMET**: ⛔ **no Rank 1–3 document changes version** |
| **Amends** | `ADR-INDEX` (registration + `Count`) · `DOCUMENTATION_BASELINE` (Authority + §8 changelog). ⛔⛔ **NO Rank 1–5 document is amended** |
| **Supersedes** | ⛔ **NOTHING.** `ADR-0135`'s `API-GAP-001` record is **re-affirmed and strengthened**, ⛔ **not superseded, narrowed or reinterpreted** |
| **Does NOT amend** | ⛔ `ADR-0135` · ⛔ `API-1`…`API-9` · ⛔ `API-8` · ⛔ `ADR-0133` / `0136` / `0137` / `0138` · ⛔ Authentication v3 · ⛔ `Q-04` / `LR-01` / `U-1`…`U-13` / `RET-01`…`RET-13` · ⛔ blocker **7a** · ⛔ `AUTH-7.22` · ⛔ `PRD_LIFECYCLE` §7A.4 or §7A.9 · ⛔ `MASTER_PRD` · ⛔ BC Map · ⛔ the Enterprise Architecture · ⛔ `TS-*` / `TS-001` / `docs/50-technical/` · ⛔ Stage-6A status |

---

## 0. ⛔⛔ WHAT THIS ADR DOES NOT DO — read first

1. ⛔⛔ **It invents NO API mechanism, versioning method, header name, endpoint, path, verb, status code, payload or schema.**
2. ⛔⛔ **It invents NO migration period, sunset period, deprecation window, support duration, notice period or numerical duration of any kind.** ⛔ **No number appears anywhere in this ADR as a policy value.**
3. ⛔⛔ **It creates NO new identifier, label, register or namespace.** ⭐ The four unresolved points are referred to **only** by their position and wording in `ADR-0135` **L183–L186**. ⭐ *(An earlier draft of this ADR proposed four short labels for them; a pre-commit collision sweep found that prefix **already in governed use across 22 files** as an unrelated governance-task family, and the draft was **rolled back before commit**. §6 records the lesson; ⛔ no label is introduced here.)*
4. ⛔⛔ **It does NOT select the `API-8` versioning mechanism.** Path-segment, header, media-type and query-parameter versioning remain **all open, none preferred or ranked**.
5. ⛔⛔ **It does NOT resolve `API-GAP-001`.** All four points stay **UNDECIDED**.
6. ⛔ **It does not touch `Q-04`, `LR-01`, `U-1`…`U-13` or `RET-01`…`RET-13`.**
7. ⛔ **It does not touch authentication, payment or permissions.** `AUTH-7.22` stays **CLOSED at 0**.
8. ⛔ **It does not alter `SX-02`'s withdrawn state and creates no `SX-05`** or any replacement identifier.
9. ⛔ **It does not allocate `TS-001`, create `docs/50-technical/`, or enter Stage 6A.**
10. ⛔ **It changes no code, test, tool or checker file**, and ⛔ **repairs no unrelated defect** — including the **eight** pre-existing broken `ADR-0079` links.

---

## 1. Context

`Accepted` `ADR-0135` established the V1 API governance baseline on 2026-09-10: `API-1`…`API-9` decided, and one limb **stopped**:

> ⛔⛔ **`API-GAP-001` — OPEN.** The API deprecation / sunset / multi-version-support policy is **undecided**. **Authority required: Product Owner + Architecture Owner.** ⛔ **Not resolvable by Architecture alone.** ⚠ **Consequence stated plainly: `B-5` is therefore DISPOSED, not fully closed** — see §8. *(`ADR-0135` **L194–196**)*

⭐ That authority — **Product Owner + Architecture Owner** — is conferred for **this act**, and this ADR discharges the question `ADR-0135` deferred: **can the gap now be resolved from governed evidence, or must it be re-affirmed OPEN?**

⚠ `ADR-0138` corrected an unrelated documentation defect and expressly left `API-GAP-001` **unaltered**. ⭐ This is the first act with authority to address the gap itself.

---

## 2. The four unresolved points — as `ADR-0135` §3.2 states them

`ADR-0135` **L179–186** records, verbatim:

> ⛔⛔ **A versioning *policy* needs more than "carry a version": it needs to say what happens when a version ends.** **Measured: `grep -rn "deprecation window\|sunset period\|support window"` across all of `docs/` returns exactly `0`.** There is **no** governed statement of:
>
> - how long a released API version is supported;
> - what notice a breaking change requires;
> - whether two versions may be served simultaneously;
> - who may declare a version deprecated, and who must consent.

⭐⭐ **Those four bullets are the whole of what `API-GAP-001` leaves open.** ⛔ **This ADR assigns them no labels and coins no identifiers** — they are referred to throughout as **the first, second, third and fourth bullet of `ADR-0135` L183–L186**, which is how a future act must cite them.

---

## 3. Re-measurement — performed independently, not inherited

### 3.1 `ADR-0135`'s own sweep, re-run

`ADR-0135` **L180** recorded its sweep as returning *"exactly `0`"*.

⚠ **Re-run at `HEAD` `4f81352`, that same sweep returns 4 — and all four are SELF-REFERENCES**, so the measurement's substance holds:

| Hit | Nature |
|---|---|
| `ADR-0135` **L161** | the ADR's own prose naming the machinery |
| `ADR-0135` **L180** | the ADR **quoting its own search string** |
| `ADR-0135` **L392** | the ADR's own changelog |
| `ADR-INDEX` **L1042** | the index **quoting that same search string** |

⭐⭐ **Governed statements of an API deprecation/sunset policy: still ZERO.** ⚠ The rise from 0 to 4 is entirely the act of *recording* the gap, and is disclosed so that a future auditor re-running L180's grep does not read **4** as a contradiction.

### 3.2 Each of the four points, tested independently

| Point (`ADR-0135` L183–186) | Instrument | Result |
|---|---|---|
| **1st bullet** — *"how long a released API version is supported"* | `api.*(supported for\|support for)\s*[0-9]` and `[0-9]+ (month\|day\|week\|year).*(deprecat\|sunset\|api version)` | ⛔ **0** |
| **2nd bullet** — *"what notice a breaking change requires"* | `notice period` repo-wide | ⛔ **0** |
| **3rd bullet** — *"whether two versions may be served simultaneously"* | `two versions\|both versions\|simultaneous.*version\|serve.*version`, excluding `ADR-0135`/`ADR-INDEX` | ⚠ **6 hits — ALL irrelevant.** Every one concerns **document** versioning (`ADR-0034` renumbering; `DOCUMENTATION_BASELINE` v1.0→v1.2; `PRD_REGISTRY` v1.6; `PRD-005` review) or **duplicate person records** (Authentication v2 §04 and L1146). ⛔ **0** concern API versions |
| **4th bullet** — *"who may declare a version deprecated, and who must consent"* | `declare.*deprecat` and `deprecat.*(owner\|authority\|consent)`, excluding self-references | ⛔ **0** |

⛔⛔ **ALL FOUR POINTS MEASURE ZERO GOVERNED EVIDENCE.**

### 3.3 ⭐⭐ NEWLY LOCATED EVIDENCE — EA **L1797**

⭐⭐ **A governed line bearing directly on this gap was located that `ADR-0135` did not cite.**

`LIBOORA_ENTERPRISE_ARCHITECTURE.md` **L1797**, verbatim:

```
├── API Deprecation Strategy (V3)
```

Its surrounding block, verbatim (**L1785–L1798**):

```
├── API Authentication (V1)
├── API Authorization (V1)
├── API Versioning (V2)
├── API Documentation (V1)
│   ├── REST Documentation (V1)
│   ├── SDK Documentation (V2)
│   └── Webhook Documentation (V2)
│
├── API Lifecycle Management (V2)
├── API Monitoring (V2)
├── API Analytics (V2)
├── API Rate Limiting (V2)
├── API Deprecation Strategy (V3)
└── GraphQL API (Future)
```

⚠ **`ADR-0135` cited L1793 (`API Lifecycle Management` **(V2)**) but not L1797.** ⭐ **L1797 names this gap's subject most precisely — *"API Deprecation Strategy"* — and it is tagged (V3), one release horizon FURTHER OUT than the (V2) `ADR-0135` relied upon.** Measured: **L1797 is cited by no governance document** (`grep "L1797\|API Deprecation Strategy"` returns only the EA line itself).

⛔⛔ **What this evidence does NOT do.** The Enterprise Architecture is **Rank 6 — *"Descriptive only. Update it to match 1–5; never the reverse"*** (`DOCUMENTATION_BASELINE` §6 **L278**; inventory **L140**). ⛔ **So L1797 CANNOT resolve `API-GAP-001`, and is NOT relied on here as a decision.** ⭐ It is recorded for exactly two reasons:

1. ⭐ It **strengthens** `ADR-0135`'s safety rationale — the subject is descriptively placed at **V3**, so deciding it at V1 would invent an obligation even further from any governed requirement.
2. ⚠ It **corrects the completeness** of `ADR-0135`'s evidence survey ⛔ **without amending `ADR-0135`**.

### 3.4 The "safe to leave open" rationale, re-verified

| `ADR-0135` L198–201 claim | Re-measured at `HEAD` `4f81352` |
|---|---|
| *"V1 has **no external API consumer**"* | ✅ **CONFIRMED** — `MASTER_PRD` returns **0** hits for *partner api / public api / third-party api / external consumer / developer api* |
| *"`Public Developer APIs` is **(Future)** at EA L1783"* | ✅ **CONFIRMED verbatim** — EA **L1783**: `│   └── Public Developer APIs (Future)` |
| *"a real gap that blocks a public API, not a V1 launch blocker"* | ✅ **CONFIRMED, and now further supported** by EA **L1797** (V3) |

---

## 4. Decision

| # | Decision |
|---|---|
| **`D-1`** | ⛔⛔ **`API-GAP-001` IS FORMALLY RE-AFFIRMED OPEN.** ⭐ It is **NOT resolved, NOT closed, NOT narrowed, NOT partially decided and NOT deferred to a date.** ⭐⭐ Re-affirmation **under the authority the gap itself names** is a stronger record than the original stop, because the office that was missing on 2026-09-10 has now examined the evidence and reached the same conclusion. |
| **`D-2`** | ⭐ **The reason is measured insufficiency, not absence of authority.** ⛔ All four points of `ADR-0135` **L183–186** return **ZERO** governed evidence (§3.2). ⭐ **Product Owner + Architecture Owner authority WAS conferred for this act and WAS exercised** — and it found nothing to decide from. ⛔ Deciding any point would therefore **invent** a policy, not apply one. |
| **`D-3`** | ⛔⛔ **NO mechanism, method, header, endpoint, migration period, sunset period, notice period, support duration or numerical duration is invented, defaulted, preferred, ranked or implied — for any of the four points.** |
| **`D-4`** | ⛔⛔ **NO new identifier, label, register or namespace is created.** ⭐ The four points are cited **by position and wording in `ADR-0135` L183–L186** — the first, second, third and fourth bullet — and a future act must cite them the same way. |
| **`D-5`** | ⭐ **The owning authority is CONFIRMED UNCHANGED: Product Owner + Architecture Owner** (`ADR-0135` **L195**). ⛔ **No new office is named, constituted or invented.** |
| **`D-6`** | ⭐⭐ **EA L1797 (`API Deprecation Strategy (V3)`) is RECORDED as newly located Rank 6 evidence**, strengthening the *"safe to leave open"* rationale. ⛔ **It is NOT relied on as a decision** — the EA is **Rank 6, descriptive only** — and ⛔ **the EA is NOT amended.** |
| **`D-7`** | ⭐ **A resolution TRIGGER is recorded, in kind and not in time:** `API-GAP-001` must be revisited **before Liboora exposes an API to any consumer it does not itself ship** — i.e. before any partner, third-party, public or developer API surface exists. ⛔ **No date, duration or release number is set**, and ⛔ **no V1 obligation is created**. ⭐ It restates the condition `ADR-0135` **L200** already identified: *"with one first-party client, a version can be retired by shipping the client."* |
| **`D-8`** | ⛔ **`API-1`…`API-9` are untouched**, including **`API-7`** (a version identifier **is** required from first release) and **`API-8`** (mechanism **NOT** selected). ⛔ **`ADR-0135` is byte-unchanged** at blob **`09b85fad4fd33bc5ef392e1372487b78b1328b9f`**. |
| **`D-9`** | ⛔ **Blocker `B-5` remains DISPOSED, not fully closed** (`ADR-0135` §8). ⭐ This ADR does **not** re-close it, and ⛔ **does not unblock Stage 6A**. |

---

## 5. Consequences

### 5.1 What changes

⭐ **Only the quality of the record.** The gap moves from *"stopped by an Architecture-only act for want of Product Owner authority"* to *"examined under the full named authority and re-affirmed OPEN on measured insufficiency, with its four points independently re-tested and new Rank 6 evidence recorded."*

⛔ **No status, gate, requirement, mechanism, identifier or number changes.**

### 5.2 Stage 6A

| Item | Status after this ADR |
|---|---|
| **`API-GAP-001`** | ⛔⛔ **OPEN — formally re-affirmed.** Authority **Product Owner + Architecture Owner** (confirmed unchanged) |
| **`API-8`** mechanism | ⚠ **DEFERRED — unchanged** |
| **Idempotency header name** | ⛔ **NOT SPECIFIED — unchanged**; `PRD_LIFECYCLE` L407 keeps it as §6A work |
| **Stage-6A entry** | ⛔ **NOT ENTERED by this act.** ⭐ Entry remains governed by `PRD_LIFECYCLE` §7A.4 `E-1`…`E-4`, which are **unamended**; ⭐ `E-4` already admits *"the dependency is **recorded as a gap with a named owning office**"*, and this ADR ⭐ **makes that record more precise without changing the criterion** |
| **`TS-001`** | ⛔ **NOT ALLOCATED** |
| **`docs/50-technical/`** | ⛔ **NOT CREATED** |
| **Blocker `B-5`** | ⭐ **DISPOSED, not fully closed — unchanged** |

⚠ **Stated plainly: this ADR does not bring Stage 6A closer by resolving anything.** ⭐ What it does is remove the *procedural* defect in the gap's record — it was stopped for want of an authority that has now been exercised — so no future act need wonder whether the stop was merely an authority failure.

### 5.3 Everything else

⛔ `Q-04` legal content **OPEN**; `LR-01` **PERMANENTLY OPEN**; `U-1`…`U-13` **unresolved**; `RET-01`…`RET-13` unchanged · ⛔ `MP-DEP-07` still **DISCHARGED** · ⛔ blocker **7a OPEN and UNAMENDED** · ⛔ `ATT-GAP-005`/`014`/`016`, `AUD-GAP-001`, `MP-GBR-04`, `MP-NFR-10` **UNAMENDED** · ⛔ `AUTH-7.22` **CLOSED at 0**; authentication and payment **untouched** · ⛔ `SX-02` stays **WITHDRAWN**; ⛔ **no `SX-05`** · ⛔ `TSG-GAP-001`…`006` **all still DEFERRED** · ⛔ **0** files under `lib/`, `test/`, `tool/`, `packages/`, `android/`, `web/`; `pubspec.yaml` unchanged.

---

## 6. ⭐ A recorded lesson on identifier discipline

⚠ **An earlier draft of this ADR introduced four short labels for the four points of §2.** A pre-commit sweep — the one `ADR-0138` §6 mandated — measured that prefix as **already in governed use across 22 files** as an unrelated governance-task family, cited by `ADR-0001`, `ADR-0002`, `ADR-0003`, `DOCUMENTATION_BASELINE` and `DOCUMENTATION_AUDIT-001`.

⭐⭐ **The draft was rolled back before commit, and this ADR introduces no label at all.** ⭐ Two things are worth recording:

1. ⭐ **The `ADR-0138` §6 remedy worked on its first real application.** The collision was caught by measurement against the **projected final diff**, not by intuition.
2. ⭐ **Referring to existing text by position is always available, and costs nothing.** A label is a convenience; ⛔ a colliding label is a defect. Where a short reference is merely convenient, ⭐ **prefer citing the source line.**

⚠ Recorded as **guidance from a Product + Architecture Owner act**. ⛔ It creates no gate, mints no identifier and amends no ranked document.

---

## 7. Citation-cost measurement

| File | Rank | Change | Citations shifted |
|---|---|---|---|
| `ADR-0139` | — | **NEW FILE** | ⭐ **0** |
| `ADR-INDEX` | — | `ADR-0139` registered as an **EOF addendum**; **L9** `Count` cell **prepended** per this file's convention | ⭐ **0** |
| `DOCUMENTATION_BASELINE` | — | **L10** Authority gains `ADR-0139`; §8 changelog row **inserted** directly below its header separator | ⭐ **0** |
| `ADR-0135` | 2 | ⛔ **NONE — byte-unchanged** | ⭐ **0** |
| `MASTER_PRD` · BC Map · `PRD_LIFECYCLE` · the EA | 1 · 4 · 3 · 6 | ⛔ **NONE** | ⭐ **0** |

⭐⭐ **No Rank 1–5 document is amended, so `DOCUMENTATION_BASELINE` §7 rule 1 is satisfied trivially** — and ⚠ **§7 rule 4's limb is UNMET (no Rank 1–3 version change), so `BASELINE-2026-09-11-B` STANDS.** ⭐ That the baseline does **not** move is itself evidence this act is correctly scoped.

---

## 8. ⛔ What this ADR expressly does NOT do

- ⛔ Resolve, close, narrow or partially decide `API-GAP-001` or any of the four points of `ADR-0135` L183–186
- ⛔ Invent or imply any API mechanism, versioning method, header name, endpoint, path, verb, status code, payload or schema
- ⛔ Invent or imply any migration period, sunset period, deprecation window, support duration, notice period or numerical duration
- ⛔ Select the `API-8` versioning mechanism, or prefer or rank any candidate
- ⛔ Create any new identifier, label, register or namespace
- ⛔ Amend `ADR-0135`, `API-1`…`API-9`, or any Accepted ADR's decision text
- ⛔ Amend the Enterprise Architecture — L1797 is **read**, not written, and the EA remains **Rank 6 descriptive only**
- ⛔ Name, constitute or invent any office, role or authority
- ⛔ Mint any permission — `AUTH-7.22` stays **CLOSED at 0**
- ⛔ Touch `Q-04`, `LR-01`, `U-1`…`U-13`, `RET-01`…`RET-13`
- ⛔ Touch authentication, payment or permissions
- ⛔ Alter `SX-02`'s withdrawn state, or create `SX-05` or any replacement identifier
- ⛔ Allocate `TS-001`, create `docs/50-technical/`, author any `TS-*`, or enter Stage 6A
- ⛔ Decide `TSG-GAP-001`…`006`
- ⛔ Close or re-status blocker `B-5`, blocker **7a**, or any gap
- ⛔ Amend `PRD_LIFECYCLE` §7A.9's `API` boundary row or §7A.4's entry criteria
- ⛔ Change any code, test, tool or checker file
- ⛔ Repair any unrelated defect, including the eight pre-existing broken `ADR-0079` links
- ⛔ Push to any remote

---

## 9. ⚠ Honest assessment

1. ⚠ **This ADR resolves nothing substantive, and that is the correct outcome.** The measured evidence for all four points is **zero**. An act with full authority that invents a policy from zero evidence is worse than one that records the zero.
2. ⭐ **But it is not a null act.** Three things exist now that did not before: the four points have been **independently re-tested** rather than inherited; the gap has been **examined by the authority it names**, so it is no longer merely *"stopped for want of an office"*; and **EA L1797** is on the record.
3. ⚠ **`ADR-0135`'s own sweep no longer returns 0** (§3.1). The cause is benign — recording a gap creates text matching the gap's own search string — but it is disclosed so a future auditor does not read it as a contradiction.
4. ⚠ **EA L1797 was available on 2026-09-10 and was not cited.** ⛔ That is not a defect in `ADR-0135`'s **conclusion** — which L1793 already supported — but it **was** an incomplete evidence survey, and it is recorded rather than quietly absorbed.
5. ⚠ **This ADR's own first draft carried an identifier collision** (§6). It was caught pre-commit and rolled back. ⭐ Recorded because a governance record that hides its own near-miss teaches nothing.

---

## 10. Changelog

| Version | Date | Change |
|---|---|---|
| **1.0** | 2026-09-11 | ⭐⭐ **Created and `Accepted`. `API-GAP-001` IS FORMALLY RE-AFFIRMED OPEN** — under the **Product Owner + Architecture Owner** conferral that `ADR-0135` **L195** names, examined against re-measured governed evidence and found **insufficient to decide any point**. ⭐ The four unresolved points of `ADR-0135` **L183–186** — support duration; breaking-change notice; simultaneous versions; who declares and who consents — were **independently re-tested** and ⛔ **each measures ZERO governed evidence**; ⛔⛔ **no label, identifier, register or namespace is created for them, and they are cited by position and wording only**. ⭐⭐ **Newly located Rank 6 evidence recorded: EA **L1797** `API Deprecation Strategy (V3)`**, which `ADR-0135` did not cite and which places the subject **one horizon further out** than the L1793 **(V2)** it relied on — ⛔ **strengthening the rationale, NOT resolving the gap**, since the EA is **descriptive only** and ⛔ **is not amended**. ⚠ Disclosed: `ADR-0135` **L180**'s sweep now returns **4**, all **self-references**, so governed statements remain **ZERO**. ⚠ Also disclosed (§6): this ADR's **first draft carried an identifier collision**, caught pre-commit by the `ADR-0138` §6 sweep and **rolled back**. ⛔⛔ **NO mechanism, versioning method, header, endpoint, migration period, sunset period, notice period, support duration or numerical duration invented, defaulted, preferred or implied; `API-8` NOT selected; `ADR-0135` byte-unchanged (`09b85fad4fd33bc5ef392e1372487b78b1328b9f`); `API-1`…`API-9` untouched; `B-5` still DISPOSED-not-closed; Stage 6A NOT entered; `TS-001` NOT allocated; `docs/50-technical/` NOT created; `Q-04`/`LR-01`/`U-1`…`U-13`/`RET-01`…`RET-13` untouched; authentication, payment and permissions untouched (`AUTH-7.22` closed at 0); `SX-02` stays withdrawn and no `SX-05` created; blocker 7a OPEN and UNAMENDED; no office constituted; 0 code files; no push.** ⚠ **`BASELINE-2026-09-11-B` STANDS** — §7 rule 4's limb **UNMET**, no Rank 1–3 version change; ⛔ **no Rank 1–5 document amended at all.** |

---

*End of `ADR-0139`. ⛔ **Accepted** — re-affirms a gap rather than guessing it closed, and ⛔ **coins nothing to do it.*** ⚠ **`API-GAP-001` remains OPEN, its four points unanswered and its authority unchanged.***
