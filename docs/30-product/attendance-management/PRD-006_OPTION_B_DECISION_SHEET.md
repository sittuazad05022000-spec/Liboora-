# PRD-006 Option B — Consolidated Human Decision Sheet

| Field | Value |
|---|---|
| **Type** | Decision sheet. **Not** a PRD, **not** an amendment, **not** an ADR, **not** a decision |
| **Purpose** | The single place where every choice that genuinely needs a human is collected. There is no other sheet |
| **Version** | v1.0 |
| **Date** | 2026-08-05 |
| **Subject** | `PRD-006_ATTENDANCE-MANAGEMENT.md` v1.4 DRAFT — hash `28965ddbb4480a50` |
| **Decisions needed** | **8** |
| **Files modified to produce this** | **Zero** |
| **Approvals asserted** | **None** |
| **Blocks** | Stage 4 re-review for the Wi-Fi Presence scope. Existing attendance is **not** blocked by anything here |

> **How to use this sheet.**
> Each decision is written in plain language, with the options and what each one costs. Answer with the letter or
> YES/NO. You do not need to read the ADRs to answer — but each decision names its ADR if you want the detail.
>
> **Nothing changes in the repository until these are answered.** No document has been amended and no ADR is Accepted.

---

## Decision 1 — Should connecting to library Wi-Fi automatically record attendance, or should it prompt the student?

**ADR:** `ADR-0025` · **Decider:** Architecture Owner + you

**Why we are asking.** Today the system allows exactly six ways to record attendance, and the rule says *"exactly these
six, and no others."* A Wi-Fi-triggered attendance is a seventh way. There is no existing way to record it truthfully:
the closest one, "QR + Wi-Fi", means *the student scanned a QR code and was also on the Wi-Fi* — so using it for a
Wi-Fi-only event would record a QR scan that never happened. That would put false information in the audit trail.

| Option | What the student experiences | What it costs |
|---|---|---|
| **A** | Connects to Wi-Fi → attendance appears automatically. Fully automatic, as you asked | We add a **seventh** attendance type. Requires amending 3 rules in PRD-006 and 1 protected file |
| **B** | Connects to Wi-Fi → app shows "Confirm your attendance" → student taps once | **Nothing structural changes.** But it is **not fully automatic** — one tap is required |

**Your answer: A or B → ______**

> ⚠️ If you answer **A**, the Architecture Owner must still agree a seventh type is acceptable.
> If you answer **B**, understand that you are accepting one student tap instead of full automation.

---

## Decision 2 — Should Study Hours belong to the Attendance system, or to the Analytics system?

**ADR:** `ADR-0026` · **Decider:** Architecture Owner, then you

**Why we are asking.** Study Hours is currently assigned to the **Analytics** area (`BC-26`) by a higher-authority
document. But the Analytics area **has no specification document written yet** — it is listed as "planned" and its
folder does not exist. So Study Hours has an owner with nowhere to write it down.

| Option | Meaning | What it costs |
|---|---|---|
| **A** | Analytics keeps ownership. Attendance just reports when sessions start and stop | Correct by the book. But **Study Hours cannot ship until the Analytics document is written** |
| **B** | Move ownership to Attendance | Ships fastest. Requires changing a **higher-authority document** and 3 rules in PRD-006 |
| **C** | Split it: Attendance records **how long each session lasted** (a simple fact). Analytics owns **totals, weekly views, streaks** | **Possibly the cheapest** — Attendance is *already* allowed to report simple operational facts. May need **no** higher-authority change |
| **D** | Ship Wi-Fi presence + attendance now; add Study Hours later | Removes the hardest problem from V1. **But this contradicts your decision that Study Hours is required for V1** |

**Your answer: A, B, C or D → ______**

> 💡 **Option C is worth a close look.** The rule that gives Analytics "study hours" gives it as *analytics*. Recording
> "this session lasted 2 hours" may not be analytics at all — it may be an ordinary fact, like "checked in at 10:00".
> Only the Architecture Owner can rule on that, but if they agree, Option C costs the least and still ships in V1.

---

## Decision 3 — Should Manager be allowed to manage authorized Wi-Fi networks?

**Decider:** You (Product Owner) — this is a permissions decision, **not** an architecture one, so it needs no ADR

**Why we are asking.** Manager is a **real role** that already exists in the system, described as *"daily operations
management."* Managers already do real work: manual attendance entry, verifying registers, corrections.

But we measured every configuration setting in the document — **all 24 of 24 say "Owner"**. Manager currently has
**no** configuration authority at all. Your instruction said *"do not silently expand Manager privileges"*, so we are
asking instead of assuming.

| Option | Meaning |
|---|---|
| **YES** | Manager can add, remove, enable, disable and label authorized Wi-Fi networks, the same as Owner |
| **NO** | Only Owner manages Wi-Fi. Manager keeps their existing operational duties |
| **PARTIAL** | Manager can **view** networks but not change them |

**Your answer: YES / NO / PARTIAL → ______**

> Note: this is the **only** one of the eight decisions that is entirely yours and needs no technical input.

---

## Decision 4 — How do we prove a Wi-Fi network is really the library's?

**ADR:** `ADR-0027` · **Decider:** Architecture Owner + security, with platform input

**Why we are asking.** Anyone can name their phone hotspot the same thing as the library Wi-Fi. So the network **name
alone can never be proof** — you said this yourself, and the existing document already agrees.

The current document deliberately refuses to specify how a network is identified; it is recorded as an open gap owned
by the Architecture Owner. **We have not invented a mechanism**, because you told us not to. `ADR-0027` lists five
families of approach with their honest weaknesses, for the Architecture Owner to choose from.

**Your input needed on one part only — the others are technical:**

> **Are you willing for the library to run a small piece of equipment or software on its own network** (a device or
> service the app can check with) if that turns out to be the strongest option?
>
> **YES / NO → ______**

If **NO**, the stronger options are off the table and the Architecture Owner must choose from the weaker ones, which
means more spoofing is possible. That is a real trade-off and it is yours to make.

> ⚠️ Whatever is chosen, the system will **never** claim cheating is impossible. That rule already exists, is already
> tested, and is **not being weakened**.

---

## Decision 5 — How automatic can presence detection really be on Android?

**ADR:** `ADR-0028` · **Decider:** Platform Owner reports the facts, then you choose

**Why we are asking.** You asked for two things that pull against each other, and both are reasonable:

- the student should not have to keep the app open
- do not assume Android allows unlimited background work

Android actively restricts apps running in the background. Phone manufacturers restrict it further. So there is a
spectrum, and the more automatic we make it, the less reliably it works.

| Option | How automatic | How reliable |
|---|---|---|
| **A** | Fully automatic, nothing on screen | Least reliable — the phone may stop it |
| **B** | Automatic, but a small permanent notification is shown | More reliable, slightly intrusive |
| **C** | Detects when the student opens the app, plus periodic checks, and fills gaps afterwards | Reliable |
| **D** | Student taps once to start and once to end | Most reliable — no background work at all |

**Your answer: A, B, C or D → ______**

> 💡 If you chose **B** in Decision 1 (a confirmation tap), then **D** here costs you almost nothing extra — the student
> is already tapping. The two decisions fit together.

---

## Decision 6 — What happens if the Wi-Fi drops for a moment?

**Decider:** You, with technical input · Referenced by `ADR-0028`

**Why we are asking.** If a student's phone briefly loses Wi-Fi — walking past a wall, a lift, a router hiccup —
should their study session end immediately, or survive a short gap?

**We have deliberately not invented a number**, because you told us not to and the document forbids it.

| Question | Your answer |
|---|---|
| Should a brief disconnect end the session immediately? | YES / NO → ______ |
| If NO — how long may the gap be before the session ends? | ______ minutes |
| If a session never gets a proper ending (phone died, app killed) — what should it become? | ______ |

> ⚠️ The last question matters more than it looks. An existing rule says the system **must never invent an end time**
> for a session, because a made-up ending is worse than a missing one. So an abandoned session must become something
> honest — for example "ended, duration unknown" — and you must decide what that something is.

---

## Decision 7 — Where should the Presence Session live in the system?

**ADR:** `ADR-0024` · **Decider:** Architecture Owner (**no input needed from you**)

**Why it is on this sheet.** For completeness only. This is a purely technical placement question with four options,
all costed in `ADR-0024`. It is listed so you can see the full set of blockers, **not** because you need to answer it.

**Your answer: none required.** ✅

---

## Decision 8 — Confirm V1 scope, now that the costs are visible

**Decider:** You (Product Owner)

**Why we are asking.** You decided Option B is required for V1. That decision stands and is not being questioned. But
the analysis surfaced one fact you could not have known when you decided: **the Analytics document that is supposed to
own Study Hours does not exist yet.**

You are entitled to keep your decision, or to adjust it now that this is visible.

| Option | Meaning |
|---|---|
| **A** | All three ship in V1: Wi-Fi Presence + Automatic Attendance + Study Hours. Confirms your original decision |
| **B** | Wi-Fi Presence + Automatic Attendance in V1; Study Hours follows in V1.1 once Analytics exists |
| **C** | Something else — please state it |

**Your answer: A, B or C → ______**

> This is a genuine choice, not a nudge. **A is entirely achievable** — it just requires Decision 2 to land on option
> B or C, because option A there waits on a document nobody has written yet.

---

## Summary — who must answer what

| # | Decision | Who decides | Do you need to answer? |
|---|---|---|---|
| 1 | Automatic attendance, or one tap? | Architecture Owner + **you** | ✅ **YES** |
| 2 | Study Hours ownership | Architecture Owner, then **you** | ✅ **YES** |
| 3 | Manager Wi-Fi permission | **You alone** | ✅ **YES** |
| 4 | Wi-Fi identity mechanism | Architecture Owner + security | ⚠️ one part only |
| 5 | Android automation level | Platform Owner, then **you** | ✅ **YES** |
| 6 | Disconnect / grace policy | **You** + technical input | ✅ **YES** |
| 7 | Presence Session placement | Architecture Owner | ❌ no |
| 8 | V1 scope confirmation | **You alone** | ✅ **YES** |

**Six of eight need you. Two are purely technical.**

---

## What is already settled and is NOT on this sheet

So the list above is not longer than it needs to be. These were checked and need **no decision**:

| Item | Status |
|---|---|
| Existing QR attendance | ✅ **Unchanged.** Not deleted, not weakened, not made optional |
| Existing QR + Wi-Fi attendance | ✅ **Unchanged** |
| Existing GPS verification | ✅ **Unchanged.** Radii stay **50 m (20–200 m)** and **30 m (5–100 m)** |
| Location stays optional per library | ✅ **Already the case** — default is Unset |
| Existing attendance records | ✅ **Unchanged.** No migration needed — nothing is built yet |
| Anti-cheating honesty rules | ✅ **Already stricter than you asked.** No change, and already tested |
| Tenant isolation (Library A can't use Library B's config) | ✅ **Already enforced** |
| Audit trail for Wi-Fi config changes | ✅ **Already exists** |
| Multiple Wi-Fi networks per library | ✅ **Already supported** — the setting is already a list |
| Duplicate attendance prevention | ✅ **Already handled** by existing idempotency rules |
| Correction workflow | ✅ **Unchanged** |
| No continuous polling / heartbeat | ✅ **Already required** by existing rules |
| Attendance / Presence / Study Hours stay separate | ✅ Consistent with existing rules and preserved throughout |

---

## Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-05 | Initial consolidated decision sheet for Option B. 8 decisions, 6 requiring the Product Owner. No document amended, no ADR accepted, no approval asserted, no numeric value invented |
