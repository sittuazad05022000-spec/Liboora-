# Engineering Decision Request — `TASK-D10`'s SMS/OTP provider dependency (`MP-DEP-03`)

| Field | Value |
|---|---|
| **Document type** | **Decision request.** ⛔ This document decides nothing, waives nothing and silences nothing |
| **Raised** | 2026-09-01, by the `PRD-021A` **Final Governance + Engineering Unblock** pass |
| **Raised under** | Instruction 3: *"Resolve `TASK-D10`'s required SMS/OTP provider/dependency through the Engineering Owner. **Do not waive or silence the 9 module-boundary violations.**"* |
| **Decision required from** | **Implementation lead** — `PRD_LIFECYCLE.md` **L280**: *"Implementation lead \| Stages 6 and 8"*. ⚠ The gap registers name this role *"Engineering Owner"* (e.g. A2 **L1841**); they are the same accountable role under two labels, and **§5 asks for that naming to be reconciled** |
| **Holder** | ⛔ **No named holder.** `PGA-08` was closed **role-based**, and `PRD_OWNERSHIP_MODEL.md` rule **7.4** reads *"never record a personal name"* |
| **Status** | ⏳ **AWAITING AN ENGINEERING DECISION AND AN EXTERNAL PROCUREMENT ACT** |
| **⛔ What was NOT done** | **0** waivers written · **0** entries added to any allow-list · **0** checkers edited or skipped · **0** `banned_imports` relaxed · **0** provider names invented · gate 3 left **RED at exactly 9** |

> ⛔ **The 9 module-boundary violations are NOT waived and NOT silenced by this document.**
> `dart run tool/check_module_boundaries.dart` still exits **1** with `FAIL — 9 violation(s)`, measured
> at HEAD. That is deliberate: `ADR-0012` **L160** calls the red pipeline *"the correct signal"*.

---

## 1. The exact question

> **Which SMS/OTP delivery provider will be procured and integrated to satisfy `MP-DEP-03`, on what
> timeline — and does the Implementation lead accept that `TASK-D10`, and therefore the 9
> `app -> domain/library` boundary violations, remain OPEN and RED until it lands?**

---

## 2. ⭐ Why this cannot be resolved inside the repository

`MASTER_PRD.md` **L570**, read verbatim:

| **MP-DEP-03** | SMS provider + **DLT template registration** | **External** | V1 launch — authentication cannot function without it |

⭐ **Its Type is `External`.** It is a **procurement and regulatory** act — an Indian DLT template
registration requires a registered sender entity — not a coding task. No amount of work in this
repository can discharge it, and **no engineer can approve it into existence**.

**Measured at HEAD:**

| Probe | Result |
|---|---|
| `grep -rniE "twilio\|msg91\|gupshup\|kaleyra\|textlocal\|sms_provider" lib/ pubspec.yaml` | **0 matches** |
| `grep -rniE "sendOtp\|send_otp\|otpDeliver" lib/` | **0 matches** |

⛔ **No provider is chosen, and this document does not choose one.** Naming a vendor here would be
exactly the invented dependency instruction 8 forbids.

---

## 3. Why the 9 violations are chained to it

`TASK-D10` **§7**, verbatim:

> *"**Therefore `TASK-D10` cannot complete before a real OTP delivery path exists** — an SMS provider
> integration under `MP-DEP-03` (DLT-registered templates)… **Attempting `TASK-D10` before SMS delivery
> exists will fail**."*

`ADR-0012` **§3.4** (L151–163), verbatim:

> *"The nine `app -> domain/library` sites are **not** waived. Four of them (`login_screen.dart`,
> `session.dart`) are already scheduled for deletion by `TASK-D10`… Waiving an edge that is already
> scheduled to disappear would convert a tracked release blocker into untracked debt with a later
> expiry date. The checker therefore continues to fail on these nine sites, **which is the correct
> signal: `TASK-D10` is not done**."*

`ADR-0012` **L181**: `` | `app -> domain/library` | **Not waived.** Closes with `TASK-D10` | n/a | ``

**The chain, stated once:** no SMS provider → `TASK-D10` cannot complete → the 4 demo-surface files
cannot be deleted → the 9 imports persist → gate 3 stays RED. ⭐ **Every link is quoted from an
`Accepted` record. None of it is inference.**

### 3.1 The 9 violations, enumerated (unchanged, re-measured at HEAD)

```
lib/app/dashboards/money_page.dart:13         '../../domain/library/fee/fee.dart'
lib/app/dashboards/reception_desk.dart:13     '../../domain/library/enrollment/enrollment.dart'
lib/app/dashboards/seat_map_page.dart:12      '../../domain/library/seating/seating.dart'
lib/app/dashboards/student_dashboard.dart:12  '../../domain/library/membership/membership.dart'
lib/app/dashboards/students_page.dart:13,14   enrollment.dart, fee.dart
lib/app/session.dart:15,16,17                 enrollment.dart, fee.dart, membership.dart
```

Root cause is structural, not accidental: `tool/module_dependencies.yaml` **L502–526** gives `app`
rank 9 with `imports: [contracts]`, and lists `domain/library` under **`ports:`** — a port, not an
`import` mode. ⛔ **Moving `domain/library` into `imports` would legalise the violation by editing the
rule it breaks.** That is the silencing instruction 3 forbids, and it is not done.

---

## 4. ⚠ A dependent product decision that is already recorded and must not be re-opened

`ADR-0085` **§5** selected `TASK-D10` **§3.3 Option B** for `D10-10` on Product Owner authority: the
parent→student relationship uses an **explicit link model**, and ⛔ **must not be inferred**. That makes
deleting `kDemoChildPhone` (`lib/app/session.dart:26`) **mandatory**, because inference is precisely
what it does.

⭐ **Consequence for Engineering:** `TASK-D10` is now *larger*, not smaller — it must delete the demo
inference **and** stand up an explicit link lookup **and** have a real OTP path. Recorded so the
sequencing is not underestimated.

---

## 5. What the Implementation lead is being asked to decide

| # | Decision | Why it cannot be taken here |
|---|---|---|
| 1 | **Which provider** satisfies `MP-DEP-03` | Procurement. Naming one would invent a dependency |
| 2 | **Who performs DLT template registration**, and when | External regulatory act by a registered entity |
| 3 | Whether `TASK-D10` is **re-sequenced** around the wait, or blocks | Stage 6/8 scheduling — `PRD_LIFECYCLE.md` **L280** |
| 4 | Confirm the **9 violations stay RED** until `TASK-D10` lands | Only the owner of the debt may re-affirm it; ⛔ this pass will not waive it |
| 5 | Reconcile the role label **"Engineering Owner"** (gap registers) with **"Implementation lead"** (`PRD_LIFECYCLE.md` L280) | Two labels for one accountable role is a governance defect, not an engineering one — routed, not fixed |

---

## 6. ⛔ What this request explicitly does not do

- ⛔ Does **not** waive, suppress, allow-list or downgrade any of the 9 violations.
- ⛔ Does **not** edit `tool/module_dependencies.yaml`, `tool/check_module_boundaries.dart` or any test.
- ⛔ Does **not** name, select, recommend or assume an SMS provider.
- ⛔ Does **not** mark `TASK-D10` complete, partially complete or re-scoped.
- ⛔ Does **not** stub, mock or fake an OTP delivery path — a fake path would make `TASK-D10` *appear*
  completable and is the precise failure `TASK-D10` §7 warns of.
- ⛔ Does **not** claim gate 3 passes. It **fails**, at exactly **9**, by design.

---

## 7. ⭐ How this request can lawfully be answered

⚠ **Added 2026-09-01, by append.** §1–§6 are unchanged. **Nothing here decides anything, waives
anything or names any vendor.**

### 7.1 ⛔ This one cannot be unblocked by a conferral alone

`GOVERNANCE_DECISION_REQUEST_PRD-020-RANK.md` §7 records that a vacant governance office can be acted
through by **direct conferral scoped to a single act**, exercised eight times. ⛔ **That remedy does not
reach this request**, and the difference is the whole point of §2.

`MASTER_PRD.md` **L570** types `MP-DEP-03` as **`External`**. A conferral is an act of *authority over
this repository*; it cannot cause an SMS provider contract to exist, and it cannot cause an Indian **DLT
template registration** to be granted by a telecom regulator. Measured again at this commit:
**0** provider packages, **0** `sendOtp` call sites.

| | Governance rank decision | This request |
|---|---|---|
| Blocked by | a vacant **office** | a missing **external artefact** |
| Unblocked by | one sentence of conferral | ⛔ a signed provider contract **and** DLT registration |
| Can an instruction supply it? | ⭐ **Yes** | ⛔ **No** |

⭐ **Consequence, stated plainly:** no instruction given in this engagement — however specific, however
authoritative — can discharge `MP-DEP-03`. Only the procurement and the registration can. Any change to
`lib/`, `tool/module_dependencies.yaml` or the checkers that made gate 3 turn green **before** that
artefact exists would be a manufactured PASS.

### 7.2 What an authority CAN decide now, without the provider

Two things are genuinely decidable today, and neither requires the contract:

| # | Decidable now | Why it does not need the provider |
|---|---|---|
| 1 | Whether `TASK-D10`'s **non-SMS** items may proceed ahead of §7 | §6 sequencing is an engineering judgement about ordering |
| 2 | The **`ADR-0085` §5 `D10-10`** parent-link option | §3.3 options A/B/C are design choices, not procurement |

⛔ Neither closes the 9 violations. The 9 close only when the 4 demo files are deleted, which
`TASK-D10` §7 makes conditional on the SMS prerequisite. `ADR-0012` **L181** — *"Not waived. Closes with
`TASK-D10`."*

### 7.3 ⭐ The exact wording that would move this request

> *"Acting as Implementation lead for this act: the V1 SMS provider is [**named provider**], DLT template
> registration is [complete / in progress, expected DATE]. `TASK-D10` §7 may therefore [begin / not yet
> begin]. `D10-10` takes option [A / B / C]. The 9 `ADR-0012` violations remain **RED** until the 4 demo
> files are deleted, and are **not** to be waived, allow-listed or silenced in the interim."*

⚠ ⛔ **The provider name must come from the authority.** This document will not supply, suggest,
shortlist or rank one, because `MP-DEP-03` is a procurement fact and inventing it would be inventing a
dependency.

### 7.4 ⛔ What §7 does not do

- ⛔ Names, suggests, shortlists or ranks **no** SMS provider.
- ⛔ Writes **no** waiver, allow-list entry or suppression; edits **no** checker and **no** manifest.
- ⛔ Does **not** claim the 9 violations are acceptable — only that they are **correctly** RED.
- ⛔ Does **not** authorise `TASK-D10` §7, `D10-10`, or any deletion.
- ⛔ Does **not** treat §7.2 as permission to begin; it identifies what an authority *could* decide.
