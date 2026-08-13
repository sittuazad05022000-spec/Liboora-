# PRD-006 — Product Owner Decision Resolution Record

| Field | Value |
|---|---|
| **Type** | Decision **resolution** record. It records answers that were given, and what they do and do not authorise |
| **Not** | Not a PRD · not an ADR · not an approval · not an ARB ruling · not a freeze |
| **Version** | v1.0 |
| **Date** | 2026-08-05 |
| **Answers** | **7 of 8** decisions on [`PRD-006_OPTION_B_DECISION_SHEET.md`](./PRD-006_OPTION_B_DECISION_SHEET.md) v1.0 |
| **Subject at time of answering** | `PRD-006_ATTENDANCE-MANAGEMENT.md` **v1.4 DRAFT**, hash `28965ddbb4480a50`, 2418 lines |
| **Decision authority exercised** | **Product Owner only** |
| **Approvals asserted** | **None.** No ARB, Architecture Owner, Security Platform, Principal Enterprise Architect or independent-reviewer approval is claimed |
| **ADRs Accepted by this record** | **Zero.** `ADR-0021`…`ADR-0029` all remain **`Proposed`** |

> **What this record is for.** The Product Owner answered the decision sheet. Some of those answers settle a
> question completely. Others settle the *product* half of a question whose *architecture* half belongs to someone
> else. This record separates the two, so that nobody later reads a product answer as an architecture approval.
>
> **The separation is the Product Owner's own instruction**, quoted verbatim:
> *"Do NOT fabricate ARB approval… Do NOT mark an ADR as Accepted merely because the Product Owner approved a
> product decision… Do NOT invent missing technical values."*

---

## 1. The decisions as given

Recorded verbatim in substance. Where the Product Owner attached a constraint to an answer, the constraint is
part of the decision and is reproduced, not summarised away.

| ID | Question (short) | **Answer** | Constraints attached by the Product Owner |
|---|---|---|---|
| **D1** | May a library Wi-Fi connection create attendance automatically? | **A — YES, as an additive 7th attendance type** | *"**Do NOT fake it as FIXED_QR_WIFI.** Amend the required attendance-mode rules through the proper ADR/governance process."* |
| **D2** | Who owns Study Hours / session duration? | **C — split** | Attendance owns *"How long did this verified presence session last?"*; Analytics owns Study Hours totals, weekly/monthly aggregation, streaks and analytics views. *"Do NOT transfer the entire Study Hours domain to Attendance. Do NOT invent PRD-009. If ARB must rule whether session duration is an operational fact, **record that as the remaining ARB decision rather than pretending it is resolved.**"* |
| **D3** | May a Manager manage authorized Wi-Fi networks? | **YES** | Owner **and** Manager, *"according to the approved permission and audit model. Do not silently grant unrelated permissions."* |
| **D4** | Is a library-side device/software option permitted? | **YES** | *"**YES does NOT select a particular hardware, router, BSSID, API, gateway, certificate, or other mechanism.** Architecture/Security must choose the actual mechanism. Do not invent one."* |
| **D5** | How is presence detected on the student's device? | **C — app-open detection + periodic/background-aware checks + reconciliation** | Student *"should NOT be required to keep the Liboora app visibly open continuously. **Do not invent the periodic-check interval.** Do not claim Android background execution is guaranteed on every device."* |
| **D6** | Disconnect grace period? | **EXACTLY 5 MINUTES** | Brief disconnect does **not** immediately end the session. Abandoned status = **`INCOMPLETE / EXIT NOT VERIFIED`** |
| **D7** | *(not answered — see §5)* | — | — |
| **D8** | V1 scope | **A — all three** | Wi-Fi Presence · Automatic Attendance · Study Hours / session-duration capability |

### 1.1 The status vocabulary, as fixed by the Product Owner

Seven strings, given exactly. *"Do not invent alternative status names."*

| Situation | Status string |
|---|---|
| Correct shift + verified presence | **`VERIFIED PRESENCE`** |
| Wrong shift | **`SCHEDULE MISMATCH`** |
| All valid devices disconnected > 5 minutes | **`SESSION ENDED`** |
| Proper exit cannot be reliably verified | **`INCOMPLETE / EXIT NOT VERIFIED`** |
| Device/account cannot be identified | **`UNKNOWN DEVICE / UNVERIFIED PRESENCE`** |
| Unknown person manually verified as a member | **`VERIFIED MEMBER`** |
| Unknown person not verified | **`UNVERIFIED — NO ATTENDANCE`** |

### 1.2 The final product principle, as given

> *"ONE STUDENT ACCOUNT = ONE ACTIVE PRESENCE SESSION. MULTIPLE REGISTERED DEVICES MUST NEVER CREATE DUPLICATE
> ATTENDANCE OR DUPLICATE STUDY HOURS. A brief Wi-Fi disconnect is tolerated for EXACTLY 5 MINUTES. After 5
> minutes without any valid registered device: → SESSION ENDED. If the ending cannot be reliably verified: →
> INCOMPLETE / EXIT NOT VERIFIED. Never fabricate an exit time. Existing attendance functionality remains
> untouched."*

**Product Owner decision identifiers assigned by this record**, following the `D-3a` precedent already carried in
PRD-006 §33.2 for the Face reclassification: **`D-10`** (D1) · **`D-11`** (D2) · **`D-12`** (D3) · **`D-13`** (D4) ·
**`D-14`** (D5) · **`D-15`** (D6) · **`D-16`** (D8). These are decision labels in the governance sense, **not**
identifiers in any `ATT-*` register, and they add nothing to any register count.

---

## 2. What each answer resolves — and what it does not

| Decision | **Fully resolved by the Product Owner** | **Still requires another authority** |
|---|---|---|
| **D1 / `D-10`** | The *product* question: automatic Wi-Fi attendance is in V1 scope, as an **additive seventh** type. Reuse of `ATTENDANCE_MODE_FIXED_QR_WIFI` is **prohibited** | The seventh mode's **`AttendanceMethod` constant, its enable configurable and its acceptance criterion cannot be created** — every one is a new identifier in a register whose count is fixed by a **Rank 4** document (§3.2). Requires the **Architecture Owner**, plus `ADR-0025` acceptance |
| **D2 / `D-11`** | The *product* split: Attendance may hold verified session duration; Analytics keeps totals, aggregation, streaks and views. `PRD-009` is **not** invented | **The ARB ruling on whether session duration is an *operational fact* under `ATT-FR-145` is expressly preserved as open**, on the Product Owner's own instruction. Also open: the delivery path to `BC-26` (`ATT-GAP-003`) |
| **D3 / `D-12`** | **Completely resolved.** Manager gains authorized-Wi-Fi management alongside Owner, under existing authorization, tenant-isolation and audit rules. No new role, no new permission model, no unrelated permission | Nothing. `manager` already exists (`ATT-FR-003`); §19.2 already grants it operational scope; `ATT-FR-118` forbids inventing a role and none is invented |
| **D4 / `D-13`** | The *product* permission: a library-side device or software component **may** be required if Architecture/Security determines it necessary | **The mechanism.** No hardware, router, BSSID, API, gateway or certificate is selected. `ATT-GAP-007` is **narrowed, not closed** — its owner remains the Architecture owner |
| **D5 / `D-14`** | The *product* shape: continuous foreground presence **MUST NOT** be required; detection is opportunistic plus reconciliation | **The periodic-check interval, the permission matrix and the platform execution model.** All remain with Architecture/Security (`ADR-0028` §4 is six columns of *"To be decided"*). No interval is invented |
| **D6 / `D-15`** | **Completely resolved.** Grace = **exactly 5 minutes**; abandoned status = `INCOMPLETE / EXIT NOT VERIFIED` | Nothing on the value. The Product Owner supplied the number this repository refused to invent |
| **D8 / `D-16`** | **Completely resolved as scope.** All three capabilities are V1 scope | Scope is not buildability. Each capability still inherits its own open blockers |
| **Shift validation** | The *product* rule: verified presence outside the booked shift is `SCHEDULE MISMATCH`, alerts student and creates an Owner/Manager review item | ⛔ **BLOCKED — no authorised data path exists.** See §4. This is a genuine architecture decision and is **not** worked around |

---

## 3. Findings that changed the execution, measured before anything was written

Five findings were established by measurement, before a byte was amended. Each one changed what could lawfully be
done, and two of them contradict the plan this work started with.

### 3.1 Finding A — the Stage 5 gate was **already red**, and this work's own previous commit caused it

`python3 tool/docs_check/prd006_traceability.py` at HEAD `3982993` exits **1**:

```
FAIL — 2 problem(s):
  * ATT-* identifier(s) found outside the module and outside the registry:
      ['docs/00-governance/adr/ADR-0024-wifi-presence-session-architecture.md:12:`ATT-BR-0', …]
  * bare 'ATT-' token found outside the module and outside the registry: [same file]
```

Every **content** check passed: 516 identifiers · 285 obligation-bearing · 1340 occurrences across 519 distinct ·
213 AC rows / 334 citations · **0 dangling** · **0 orphan** · `ATT-NFR-010` coverage **285/285 = 100.0%** · gap
ledger 21 rows, 3 resolved / 1 narrowed / 17 open.

**Cause.** The collision-scan whitelist at `prd006_traceability.py` L434-441 enumerates five allowed locations and
does not include `ADR-0024`…`ADR-0028`. Those five ADRs were created by commit `3982993` — this work's own
preceding commit — and every legitimate `ATT-*` citation in them is scored as a collision.

**It is disclosed rather than discovered later.** It was found because the gate was run *before* writing, not
after; had it been run only at step 13, the failure would have been misattributed to the new amendment.

**Handling, and its precedent.** `DOCUMENTATION_BASELINE.md` L298 records the sanctioned form of exactly this
maintenance for the sibling script:

> *"One Stage 5 gate script was maintained, and the maintenance is recorded rather than performed silently:
> `tool/docs_check/prd007_traceability.py` had its collision-scan `ALLOWED` list widened by four **named** files …
> because recording a freeze requires the governance layer to cite the register it admits… It follows the existing
> convention rather than inventing one: `prd005_traceability.py` already enumerates the identical four files for
> `MM-*` on the reasoning that **'a citation is not a collision'**… The list remains enumerated file by file rather
> than widened to a directory, so a stray `SEAT-` elsewhere in governance still fails the run, and the checks that
> detect a genuine collision — another register *defining* a `SEAT-` identifier — are unchanged."*

The same is done here, to the same standard: **named files only**, never a directory, and **no check weakened**.
See §6.

### 3.2 Finding B — §2F cross-checks **all ten registers**, and this was proven empirically, not inferred

`prd006_traceability.py` L392-402 loops `for reg in ORDER` where
`ORDER = ["FR","BR","INV","EVT","XC","PO","CFG","NFR","AC","GAP"]`, and cross-checks each register's count and
range against §2F of `TRACEABILITY_MATRIX.md` — a **Rank 4** document.

**The test.** A single temporary row defining `ATT-BR-046` was injected into a copy of §7.2 and the gate re-run.
Result:

```
BR           46     46   ATT-BR-001 … ATT-BR-046
FAIL — 7 problem(s):
  * section 0.3 declares ATT-BR-* as 45 ending 045; computed 46 ending 046
  * ATT-NFR-010 requires every obligation to carry a criterion; 1 uncovered: ['ATT-BR-046']
  * section 2F registers ATT-BR-* as 45 (001..045); computed 46 (001..046)
```

The temporary row was removed and the file restored to `28965ddbb4480a50` before anything else was done.

**Consequence.** Two of those three failures are internal to PRD-006 and fixable under Product Owner authority.
**The third is not.** It fails against a Rank 4 document whose amendment belongs to the Architecture Owner, and
governance step 10 forbids modifying it. Therefore:

> **No new identifier may be added in ANY of the ten registers** — not `ATT-FR-152`, not `ATT-BR-046`, not
> `ATT-CFG-025`, not a new `ATT-XC`, not a new `ATT-AC`.

The plan this work inherited said only that new **`ATT-AC`** numbers should be avoided. That was **materially
wrong**, and the amendment was re-shaped around the measurement rather than the assumption.

**The lawful alternative is precedented in the matrix itself**, `TRACEABILITY_MATRIX.md` L446: a Stage 4 finding
was *"closed during Stage 4 reconciliation by **extending `ATT-AC-152`, not by inventing a criterion**."* Every
amendment in §5 follows that form.

### 3.3 Finding C — the six-mode closure is **not pinned in any Rank 1–4 document**

Measured across the Rank 1–4 set:

| Document | Rank | Result |
|---|---|---|
| `MASTER_PRD.md` (hash `5c31a3363d99a5f6`) | 1 | **No mode enumeration.** No "six modes", no `AttendanceMethod` value list |
| `LIBOORA_BOUNDED_CONTEXT_MAP.md` | 4 | §8 **L372** gives `BC-03`'s entities as `Punch, VerificationEvidence(GPS/WiFi/QR), CorrectionRecord` — **it does not enumerate the modes**. "six core **contexts**" at L106 is unrelated |
| `Library_PRD_v1.md` | 3 | **L689** `| Attendance Method | The selection | BC-03 Attendance |` — delegates the *behaviour* to `BC-03` and enumerates nothing |
| `TRACEABILITY_MATRIX.md` | 4 | Register **counts** only |

**Consequence.** *"Exactly six modes"* exists **only inside PRD-006**, an unranked DRAFT the Product Owner owns.
So D1 = A needs **no Rank 1–4 amendment on the mode-set axis** — which is cheaper than the impact report feared.
Note also that BC Map L372 already lists **Wi-Fi as a legitimate form of `VerificationEvidence`**, so Wi-Fi
evidence itself is ratified; what is not ratified is a *scan-less* method value.

What still blocks the mode is **Finding B**, not the Rank 1–4 mode set: the seventh mode needs a seventh enable
configurable (`ATT-CFG-025`), and the `ATT-CFG` count is fixed at 24 by Rank 4 §2F.

### 3.4 Finding D — Conflict 14: the booked student shift has **no data path into `BC-03`**

See §4. This was not in the thirteen-conflict set carried into this work.

### 3.5 Finding E — a **suffixed gap successor** is lawful, and is the one register-safe extension point

Tested the same way, with a temporary `ATT-GAP-007a` row:

```
GAP          18     18   ATT-GAP-001 … ATT-GAP-018  (+4 suffixed rows)
FAIL — 4 problem(s):
  * ATT-GAP-007a is defined but section 0.3's row does not declare it
  * section 32 states 3/1/17 …; the ledger's own verdict cells yield 3/1/18
```

**§2F did not fail.** The GAP register still declares **18 numbers**, so the Rank 4 count is untouched; both
failures are internal declarations inside PRD-006 that the Product Owner may correct. The precedent is PRD-006's
own §0.3: three suffixed successors already exist (`ATT-GAP-008a`, `016a`, `017a`), following `PRD-005`'s
`MM-GAP-010a`.

**Consequence.** A genuinely new open question may be recorded as a suffixed successor **of a genuine parent**. It
may **not** be used to smuggle in an unrelated question — `ATT-GAP-019` would fail §2F, and a suffix on an
unrelated parent would be dishonest labelling. Where neither is available, the question is recorded as a
**Proposed ADR** instead, which is how Conflict 14 is handled.

---

## 4. Conflict 14 — `SCHEDULE MISMATCH` has no authorised input

The Product Owner requires every verified presence to be compared with *"the student's booked library schedule"*.
Measurement shows `BC-03` cannot obtain that schedule through any declared edge.

| Measurement | Result |
|---|---|
| `grep -in "shift"` in PRD-006 | **3 hits, all `BC-07` Staff & Shift** (L174, L235, L240). **Zero** about a student's booked shift |
| BC Map **L101** | `BC-06` Library Policy owns *"working hours, holidays, attendance rules, seat rules, grace periods"* — **branch-wide, not per student** |
| Frozen `PRD-007` **L158** | *"**`Shift`** — a named time window; `Shift` definitions are owned by `BC-06` (`LIB-16.4`)"* |
| Frozen `PRD-007` **`SEAT-FR-046`** (L476-480) | A `SeatAllocation` carries `StudentRecordId`, `tenantId`, allocation type, time window (`validFrom`, `validUntil`) and a **shift reference (nullable)** |
| `BC-03` inbound **`E-03`** | `BC-02 → BC-03`, payload `MembershipValidity{studentRecordId, validUntil, seatQuota}` — **no shift** |
| `BC-03` inbound **`E-04`** | `BC-06 → BC-03`, payload `AttendanceRules{openTime, closeTime, graceMinutes, lateEntryPolicy}` — **branch-wide, no per-student shift** |
| `BC-04 → BC-03` edge | **Does not exist.** `E-08` runs `BC-03 → BC-04`, the opposite direction |
| BC Map §7 **L292** | *"If an edge is not in this table, it **does not exist** and adding it requires an ADR."* |

**Therefore the per-student booked shift lives in `BC-04`'s `SeatAllocation`, and `BC-03` has no authorised way to
read it.** `SCHEDULE MISMATCH` cannot be computed from any input `BC-03` is permitted to have.

**What is done about it.** The *product* rule is recorded (what the status means, who is alerted). The *mechanism*
is **not invented**: no `BC-04 → BC-03` edge is asserted, `E-04`'s payload is not silently extended, and the
branch-wide `AttendanceRules` open/close times are **not** substituted for a per-student shift — that substitution
would produce a wrong `SCHEDULE MISMATCH` for every student whose booking is narrower than opening hours, which is
most of them. It is raised as **`ADR-0029` (`Proposed`)** and listed in §5 as a **REMAINING HUMAN/ARCHITECTURE
DECISION**.

---

## 5. REMAINING HUMAN / ARCHITECTURE DECISIONS

Listed as the Product Owner instructed: *"For anything that genuinely requires Architecture Owner / ARB / Security
authority → clearly list it as: REMAINING HUMAN/ARCHITECTURE DECISION. Do NOT invent an answer merely to make the
freeze pass."*

| # | Decision required | Authority | Carried by | Blocks |
|---|---|---|---|---|
| **R-1** | Where does a Library Presence Session live — subordinate entity in `AttendanceDay`, separate aggregate in `BC-03`, owned by `BC-04`, or a new bounded context? | Architecture Owner / ARB | `ADR-0024` §3 (4 options, 9 constraints) | The whole feature's structure |
| **R-2** | Is a **scan-less** `AttendanceMethod` value permitted, and may a seventh mode be added to an invariant-bearing enum? | Architecture Owner / ARB | `ADR-0025` | The seventh mode's definition |
| **R-3** | **Is verified session duration an *operational fact* under `ATT-FR-145`, or a metric owned by `BC-26`?** *Expressly preserved as open on the Product Owner's own instruction* | ARB | `ADR-0026` §8 | Whether `BC-03` may expose duration at all |
| **R-4** | By what mechanism is an authorized network identified, and can spoofing be detected? D4 permits a library-side component; it selects none | Architecture Owner + Security Platform | `ADR-0027` §4 (`F-1`…`F-5`), `ATT-GAP-007` **narrowed** | Any anti-spoof claim |
| **R-5** | Platform execution model, **permission matrix** and the **periodic-check interval** for D5 = C | Architecture Owner + Security Platform | `ADR-0028` §4 (six columns, all *"To be decided"*) | Detection reliability claims |
| **R-6** | **How does `BC-03` obtain the student's booked shift?** No edge exists (§4) | Architecture Owner — needs an ADR per BC Map §7 L292 | **`ADR-0029` (new, `Proposed`)** | `SCHEDULE MISMATCH` entirely |
| **R-7** | May `ATT-FR-134`'s closed four-event set be opened, if the feature needs a new event? BC Map §9 is Rank 4 | Architecture Owner | `ADR-0024` §5, `ADR-0025` §6 | New event publication |
| **R-8** | **Amendment of `TRACEABILITY_MATRIX.md` §2F register counts**, without which no new `ATT-FR`, `ATT-BR`, `ATT-CFG`, `ATT-XC` or `ATT-AC` identifier can exist (Finding B) | Architecture Owner | This record §3.2 | The seventh mode's configurable, and every new criterion |
| **R-9** | Is `BC-26` a consumer of `attendance.*`? BC Map §9 says yes, §7 declares no edge | Architecture Owner | `ATT-GAP-003` | Study Hours delivery under D2 = C |
| **R-10** | **D-9** — does a CONDITIONAL Stage 3/4 verdict permit entry to Stage 7? | Architecture Owner | `ADR-0021` §5 | Any freeze |

**None of these is answered by this record, and none is answered by a Product Owner decision.**

### 5.1 D7 was not answered

The decision sheet carried eight decisions. **D7 received no answer** and is **not** treated as resolved, not
defaulted, and not inferred from the other seven. It remains open on the sheet.

---

## 6. Gate-script maintenance, recorded not performed silently

`tool/docs_check/prd006_traceability.py` — collision-scan `ALLOWED` list widened by **six named files**:
`ADR-0024`, `ADR-0025`, `ADR-0026`, `ADR-0027`, `ADR-0028`, `ADR-0029`.

| Property | Before | After |
|---|---|---|
| Form of the list | Named files, enumerated | **Named files, enumerated** — unchanged in form |
| Widened to a directory? | No | **No.** A stray `ATT-` in any other governance file still fails |
| Collision detection changed? | — | **No.** Another register *defining* an `ATT-` identifier still fails |
| Count/range/coverage/dangling/orphan checks | — | **Untouched** |
| §2F cross-check | — | **Untouched** — the check that constrains this very amendment is left fully armed |

**Reasoning, quoted from the precedent rather than invented:** *"a citation is not a collision"*
(`prd005_traceability.py`, via `DOCUMENTATION_BASELINE.md` L298). The five ADRs exist precisely to route
architecture decisions about `ATT-*` rules to their proper authority, and they cannot do that without naming the
rules they route.

**This is disclosed as maintenance caused by this work's own prior commit** (§3.1), not presented as a
pre-existing condition.

---

## 7. What this record does **not** do

- It does **not** accept any ADR. `ADR-0021`…`ADR-0029` are all **`Proposed`**.
- It does **not** claim ARB, Architecture Owner, Security Platform or independent-reviewer approval.
- It does **not** invent: the periodic-check interval · a notification cooldown, frequency or escalation interval ·
  a second grace period · a network identification mechanism · any hardware, router, BSSID, API, gateway or
  certificate · `PRD-009` · an exit timestamp · a `BC-04 → BC-03` edge · a new event.
- It does **not** modify any Rank 1–4 document. `MASTER_PRD.md`, the BC Map, the Module Dependency Matrix,
  `TRACEABILITY_MATRIX.md`, `Library_PRD_v1.md`, `PRD-SEAT-MANAGEMENT.md` and `Student_Identity_PRD_v1.md` are
  byte-for-byte unchanged.
- It does **not** reinterpret an existing attendance mode to perform the new behaviour. `ATT-BR-007` is preserved,
  and the prohibition on recording a scan-less event as `FIXED_QR_WIFI` is made explicit.
- It does **not** claim that spoofing, proxy attendance or cheating is impossible.
- It does **not** confer a rank, a Stage verdict or a freeze. **Stage 7 is not entered.**
- It touches **no** code: `lib/`, `test/`, `pubspec.yaml`, `android/` and `web/` are unmodified.

---

*End of `PRD-006_PO_DECISION_RESOLUTION_RECORD.md` v1.0.*
