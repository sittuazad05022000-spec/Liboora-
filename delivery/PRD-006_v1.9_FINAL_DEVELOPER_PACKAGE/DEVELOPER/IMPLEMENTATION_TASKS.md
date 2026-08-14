# IMPLEMENTATION_TASKS — PRD-006 Attendance Management v1.9

**Derived document.** The authoritative task list is
[`../PRD/PRD-006_IMPLEMENTATION_TASKS.md`](../PRD/PRD-006_IMPLEMENTATION_TASKS.md).
**This document summarises it. It creates no task and renumbers nothing.**

---

## 1. The measured shape of the backlog

| Property | Value |
|---|---|
| **Task count** | **80** |
| **Identifier range** | **`IMPL-600` … `IMPL-679`** |
| **Duplicates** | **0** |
| **Holes in the range** | **0** |
| **Identifiers outside `IMPL-600..679`** | **0** |
| **Obligation coverage** | **285 / 285 = 100.0%** |
| **Gate** | `prd006_task_coverage.py` — **PASS, exit 0** |

> **A note on a corrected figure, recorded rather than quietly fixed.** Earlier
> freeze records in this repository stated **"179 tasks"**. That number was
> **wrong** — it was never in the task file, and the gate that reads that file
> reports `Tasks parsed : 80`. All 11 occurrences across five governance
> documents were corrected to **80**, and the defect is registered as **`GCP-13`**
> in [`../GOVERNANCE/DOCUMENTATION_BASELINE.md`](../GOVERNANCE/DOCUMENTATION_BASELINE.md).
> The **`285/285 = 100.0%`** coverage figure beside it was always correct — *"which
> is precisely why the wrong number survived review: it sat next to a right one."*

## 2. ⚠️ The source file's header is stale — read its rows, not its metadata

`PRD-006_IMPLEMENTATION_TASKS.md` still says *"Source of truth: `PRD-006` v1.4
**DRAFT**"*, *"Written against `BASELINE-2026-08-04-E`. **Not admitted to it**"*
and *"`PRD-006` remains **`DRAFT`** with ⚠️ **CONDITIONAL** Stage 3 and Stage 4"*.

**All three statements are out of date.** `PRD-006` is **FROZEN at v1.9**, admitted
to **`BASELINE-2026-08-05-A`** by **`ADR-0034`** (`Accepted`), with **Stage 3
✅ ALIGNED 6/6** and **Stage 4 ✅ A — PASSED**.

The header was **deliberately not edited** for this package. The file is a
*"Backlog record. **Not ranked**, therefore editable without an ADR"* — but silently
amending a document inside a delivery package is the quiet-edit pattern this
project's governance forbids. **The correction is recorded here instead.**

Similarly, `IMPL-679`'s description says *"all 213 `ATT-AC-*`"*. The register is now
**222** (`ATT-AC-214` … `ATT-AC-222` were added by `ADR-0032` and the `R-19`
tolerance criterion). **Bind the harness to 222**, and treat the 213 in the task
text as stale.

## 3. The eight waves

| Wave | Range | Subject |
|---|---|---|
| **1** | `IMPL-600` … `IMPL-609` | Context boundary, ownership split, ports, aggregate, invariants |
| **2** | `IMPL-610` … `IMPL-619` | Roles, mode framework, mode independence, Fixed QR |
| **3** | `IMPL-620` … `IMPL-629` | Dynamic QR, Wi-Fi mode, GPS mode |
| **4** | `IMPL-630` … `IMPL-639` | Face verification, its prohibitions, and the **blocked** build |
| **5** | `IMPL-640` … `IMPL-649` | Manual entry, register image, OCR failure path, audit |
| **6** | `IMPL-650` … `IMPL-659` | Entry/exit determinism, time, duplicates, concurrency, volume |
| **7** | `IMPL-660` … `IMPL-669` | Owner configuration, configurables, device boundary, corrections |
| **8** | `IMPL-670` … `IMPL-679` | Authorization, tenancy, audit, events, Seating boundary, NFRs, acceptance |

Each task row in the source carries: description · module · priority · dependencies
· blocked-by · **Requirements** (the `ATT-*` obligations it satisfies) · test
notes. **`ATT-AC-*` do not appear in Requirements cells** — *"An acceptance
criterion is **verified by** a task's test, not"* satisfied by the task.

### 3.1 Anchor tasks worth knowing before you start

| Task | Subject |
|---|---|
| `IMPL-600` | Bounded-context skeleton for `BC-03` and **the ownership split** — what it owns versus what it must not |
| `IMPL-601` | **The Single Owner Rule as an enforced boundary, not a comment** |
| `IMPL-602` | The six inbound port surfaces — **declared as ports with fakes, never as implementations of upstream contexts** |
| `IMPL-603` | The entitlement check that runs **before** the aggregate mutates |
| `IMPL-604` | The three outbound port surfaces — occupancy trigger, audit, notification, **fire-and-forget where the map says so** |
| `IMPL-605` | **The four edges that do NOT exist, expressed as impossibilities** — Analytics, File & Media, AI Assistance, Search Indexing |
| `IMPL-674` | Publishes **exactly four events** to exactly the consumers BC Map §7 authorises |
| `IMPL-677` | The offline conflict-resolution policy this module **defines** and Sync executes — **Dynamic QR's offline behaviour left undefined** |
| `IMPL-679` | The acceptance harness binding every `ATT-AC-*` to a named test. ⛔ **BLOCKED by `ATT-GAP-017a`** |

## 4. Blocked tasks — do not "unblock" them by inventing the missing input

Every row below is blocked because a **named owner** has not decided something.
Implementing the missing piece would close an open gap by accident.

| Task(s) | Blocker | Required behaviour |
|---|---|---|
| `IMPL-630` | **`ATT-GAP-009`** — no V1 owner for a face scanner's lifecycle | **BLOCKED** |
| `IMPL-631` | **`ATT-GAP-012`** — no owner for a face template | **BLOCKED** |
| `IMPL-632` | **`ATT-GAP-013`** — no liveness capability exists | **BLOCKED** |
| `IMPL-633` | **`ATT-GAP-014`** — biometric erasure is a conflict, not a void | **BLOCKED** |
| `IMPL-634` | `ATT-GAP-015` (moot in effect) | Implements the **refusal**; `ATT-FR-064` blocks the Face build regardless |
| `IMPL-620` | **`ATT-GAP-006`** — no cryptographic construction exists | Builds the rotation **behaviour only**. Secrets are `BC-25`'s references |
| `IMPL-622`, `IMPL-625`, `IMPL-626` | **`ATT-GAP-007`/`008`/`008a`** | **Build the prohibitions, not the detections** |
| `IMPL-641` | **`ATT-GAP-011`** — no context owns OCR/Vision | Builds against **a port with a fake**; defines **no** capability owner |
| `IMPL-644` | **`ATT-GAP-016`** — no retention rule for a register image | **Cannot set a retention period** |
| `IMPL-661` | **`ATT-GAP-017`** — seven configurables have no default | **Cannot supply the missing seven**. Reads all **24** `ATT-CFG-*` through `E-19` |
| `IMPL-663` | **`ATT-GAP-018`** — no *"at least one mode"* constraint is authorised | **Preserves the permissive behaviour** |
| `IMPL-673` | **`ATT-GAP-005`** — retention undecided upstream | **Implements audit emission, never a retention policy** |
| `IMPL-674` | `ATT-GAP-003`/`004`/`010` — named consumers with no edge | Publishes to **only** the authorised consumers |
| `IMPL-676`, `IMPL-677` | `ATT-GAP-016a` / **`ATT-GAP-017a`** | **Implement the prohibitions** — no latency or throughput figure exists |
| `IMPL-679` | **`ATT-GAP-017a`** | ⛔ Blocked on the non-functional half |

### 4.1 Cross-PRD dependencies

| Upstream | Effect |
|---|---|
| **`PRD-005`** `BC-02` — `IMPL-432` (`E-03` producer) | `IMPL-604` builds the **consumer against a port with a fake**. Attendance **records and flags, never blocks** |
| **`PRD-004`** `BC-01` — `IMPL-300`, `IMPL-301` | `IMPL-603` has **no upstream identity projection**. This module **never creates or renames a student** |
| **`PRD-007`** `BC-04` — `IMPL-551` (`E-08` consumer) | `IMPL-675` is the **producer side of a link whose consumer is also unbuilt** |
| **`BC-06`** Library Policy — `E-04` | `IMPL-605`, `IMPL-651`, `IMPL-660` **conform and define nothing** |
| **`PRD-023`** `BC-25` Configuration **unwritten** | `IMPL-661` reads all **24** `ATT-CFG-*` through `E-19` anyway |
| `BC-18`, `BC-21`, `BC-19`, `BC-30` | `IMPL-670` **defines no role**; `IMPL-602` calls `E-17` **before** mutation |
| `BC-24`, `BC-22` | `IMPL-673` emits over `E-20` **fire-and-forget, never synchronously**; `IMPL-678` emits **facts**, implements **no dispatch** |

### 4.2 A red gate you will inherit

**`BLK-01` / `TASK-D10`:** *"**Gate 3 is red today** (9 `cross-context`
violations; `ADR-0012` expiry 2026-10-31). Any PR in this backlog inherits a red
gate 3 until `TASK-D10` lands."*

This is **pre-existing and expected**, and it is `ADR-0012` time-boxed debt. Do
not "fix" it inside an attendance PR.

### 4.3 Eighteen open gaps, and no task closes one

*"Eighteen open questions. **No task resolves any of them.** `IMPL-679` exists in
part to keep them open."*

## 5. Tasks that must NOT be created

From the source's §8. Each has a registered exclusion behind it.

| Tempting task | Why it must not exist |
|---|---|
| *"Add a staff punch-in screen while we're here"* | **`ATT-XC-001`.** Staff attendance is `BC-07` HR & Staff, **V2** |
| *"Extract attendance into its own service so scanning scales"* | **`ATT-XC-002`, `ADR-0001`.** A bounded context **inside the monolith** |
| *"Add a `BC-26` Analytics client so the dashboard has data"* | **`ATT-XC-003`, `ATT-FR-137`, `ATT-GAP-003` open** |
| *"Call Trust & Safety when a fraud signal fires"* | **`ATT-XC-003`, `ATT-FR-137`, `ATT-GAP-004` open** — T&S *"acts **on** other contexts"* |
| *"Upload the register image to File & Media"* | **`ATT-XC-004`, `ATT-GAP-010` open.** `E-22`'s consumer list **excludes** `BC-03` |
| *"Send the register photo to the AI service to run the OCR"* | **`ATT-XC-005`, `ATT-GAP-011`.** BC Map §7.4 **refutes** the requested edge |
| *"Add fuzzy student search to manual entry"* | **`ATT-XC-006`, `ATT-FR-070`.** Exact lookup through the port only |
| *"Join the student-profile table to render names"* | **`ATT-XC-007`, `ATT-BR-002`.** **The Single Owner Rule is not relaxed for a read** |
| *"Keep the session token in `VerificationEvidence` to debug a failed scan"* | **`ATT-XC-008`, `ATT-FR-123`, `ATT-FR-133`.** Evidence describes **what was verified, never who the person is** |
| *"Wrap check-in and seat occupancy in one transaction"* | **`ATT-XC-009`, `ATT-NFR-013`, `ATT-FR-142`.** Attendance is complete **when the attendance write commits** |
| *"Add an NFC tap mode"* | **`ATT-XC-010`.** RFID, NFC, BLE are **Future/V3**. V1 has **six** modes |
| *"Build a `VerificationStrategy` pipeline so the six modes plug in uniformly"* | **`ATT-XC-011`, `ATT-BR-004`.** The modes are **independent and each sufficient alone** |

**And from the v1.9 material specifically:** no fifth event, no `ATT-CFG-025`, no
tenth status string, no `E-27`, no timer, no foreground service, no retention
default, no periodic interval, no latency figure.

## 6. How to use this with the source

1. Open [`../PRD/PRD-006_IMPLEMENTATION_TASKS.md`](../PRD/PRD-006_IMPLEMENTATION_TASKS.md) §5 for the actual rows.
2. Read the **Requirements** cell and open every cited `ATT-*` in the frozen PRD.
3. Check §4 above before starting — the task may be **deliberately blocked**.
4. Bind tests to `ATT-AC-*` per
   [`TESTING_REQUIREMENTS.md`](./TESTING_REQUIREMENTS.md) — **222**, not 213.
5. **Never renumber, merge or split a task.** The gate asserts the exact span
   `IMPL-600..679` with **0 holes**.
