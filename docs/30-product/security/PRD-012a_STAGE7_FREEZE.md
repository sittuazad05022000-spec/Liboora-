# PRD-012a — Stage 7 Freeze & Governance Record

| Field | Value |
|---|---|
| **Document** | Stage 7 record for `PRD-012a` — Security Automation |
| **Subject** | [`PRD-012a_SECURITY_AUTOMATION.md`](PRD-012a_SECURITY_AUTOMATION.md) + [`PART2`](PRD-012a_PART2_PLATFORM_ADMIN_SECURITY.md)…[`PART8`](PRD-012a_PART8_TRACEABILITY_AND_ACCEPTANCE.md) — **eight files, v0.1…v0.8** |
| **Stage** | **Stage 7 — Freeze & Governance** (`PRD_LIFECYCLE.md` **L155–L181**) |
| **Verdict** | **PASS — `PRD-012a` is `FROZEN` at Rank 3** |
| **Conferring authority** | `ACCEPTED` [`ADR-0064`](../../00-governance/adr/ADR-0064-prd-012a-security-automation-v0.8-baseline.md) + the rows at [`DOCUMENTATION_BASELINE.md`](../../00-governance/DOCUMENTATION_BASELINE.md) **L198** (§3.3) and **L252** (§4). ⛔ **Neither is this document.** This record reports a conferral made elsewhere and confers nothing |
| **Baseline** | **`BASELINE-2026-08-21-A`** (supersedes `BASELINE-2026-08-20-C`) |
| **Subject hash before** | **Unchanged — there is no "before" and "after" pair to publish, and that is the finding.** All eight Parts are **byte-identical** to `bd85a31`, the commit at which Stages 5 and 6 measured them: `git diff --stat bd85a31 HEAD` over all eight paths returns **EMPTY**, and `git status --porcelain docs/30-product/security/` returns **EMPTY** |
| **Subject hash after** | Identical, and published per file in §3. Part 1 `dbd01d4d00165c77…`, Part 8 `a8c45d79eb8154f7…` — **the two values `DOCUMENTATION_BASELINE.md` L198 cites**, reproduced here independently |
| **Date** | 2026-08-21 |
| **Precedence** | **None.** A stage record holds no rank. It is not evidence of its own conclusion |

---

## 1. The gate, and the artefact that satisfies it

`PRD_LIFECYCLE.md` **L159** states the gate in one clause:

> *"**Gate:** a row in `DOCUMENTATION_BASELINE.md` §3 at an assigned precedence rank."*

and **L161** states the rule this record is careful not to break:

> *"Freeze is **conferred, not claimed**."*

So the question is narrow. Not *"is `PRD-012a` good enough to freeze?"* — Stages 3, 4, 5 and 6 answered that at their
own gates — but **"does the row exist, and did an authority entitled to write it write it?"**

| Requirement of the gate | Artefact | Verified |
|---|---|---|
| A `DOCUMENTATION_BASELINE.md` §3 row at an assigned rank | **L198**, inside `### 3.3 Product` (heading measured at **L141**) — covering all eight Parts at **v0.8**; plus **L199** (Stage 3/4/6 records) and **L200** (the Stage 7 blocker record, retained) | ✅ |
| A §4 precedence entry | **L252**, **Rank 3**, scoped to *"the **SECURITY platform (rank 2)**"* | ✅ |
| An ADR authorising the ranked-document change **before** the change | [`ADR-0064`](../../00-governance/adr/ADR-0064-prd-012a-security-automation-v0.8-baseline.md), `Accepted`, **24,265 bytes**, written and complete **before any ranked file was touched** — baseline §7 rule 1 | ✅ |
| A baseline identifier advance, a Rank 1–3 document entering the baseline | `BASELINE-2026-08-20-C` → **`BASELINE-2026-08-21-A`**, baseline §7 rule 4 | ✅ |
| The registry reflecting the conferred status | `PRD_REGISTRY.md` §4.1 — `PRD-012a` **`FROZEN`**, `PRD-012` **`RETIRED`** — plus **six** re-derived §7 count rows (§5) | ✅ |
| The ADR registered | `ADR-INDEX.md` **L95–L99**, count re-derived **64 files / 51 accepted / 13 proposed** | ✅ |
| Prior stage gates passed | Stage 1 **`NOT APPLICABLE`** (`ADR-0060`) · Stage 3 ⚠ **ALIGNED WITH ONE STRUCTURAL FINDING** (5/6) · Stage 4 ✅ **6/6** · Stage 5 ✅ **427 identifiers, 15 registers** · Stage 6 ✅ **A — PASS**, `IMPL-1300`…`1359` | ✅ |

**The authority question is the one worth stating plainly, because five ADRs were written and only one of them was
this role's to write.** `PRD_LIFECYCLE.md` §6 **L282** assigns *Stage 7; the baseline* to the **Governance Owner**.
That role authorised `ADR-0064` and nothing else. `ADR-0060`, `ADR-0061` and `ADR-0062` are **Architecture Owner**
decisions; `ADR-0063` is the **`BC-18` Identity & Access owner's**. ⚠ **Three roles, five decisions — and the reason
that matters is `ADR-0033` §7.1: *"A conferral for one act is not a standing licence."*** Had one role signed all
five, the admission would have been a single actor agreeing with itself.

---

## 2. Order of operations, because the order is itself a rule

`DOCUMENTATION_BASELINE.md` §7 rule 1: *"A change to any Rank 1–5 document requires an ADR **before** the change."*
That makes sequence a compliance matter, not a convenience. The order actually followed:

| # | Act | File | Why here and not elsewhere |
|---|---|---|---|
| 1 | Resolve `SECP-ADR-001`, `002`, `004` | `ADR-0060`, `ADR-0061`, `ADR-0062` | **Architecture Owner.** These are the structural questions. An admission written first would have been an admission of a document whose architecture was still undecided |
| 2 | Resolve `SECP-ADR-003` | `ADR-0063` | **`BC-18` owner.** Not the Architecture Owner's, and not the Governance Owner's — the requirement touches a frozen Rank 3 authentication mechanism |
| 3 | Determine the Stage 1 / `BC-nn` question | `ADR-0060` | ⛔ Resolved by **dissolution, not repair**: Stage 1's gate is context-scoped and does not reach a platform-scoped specification. **No `BC-32` was created** |
| 4 | Write the admission ADR | `ADR-0064` | §7 rule 1. **Nothing ranked was touched until this file existed and was complete** |
| 5 | Advance the baseline | `DOCUMENTATION_BASELINE.md` | The conferring document: header, §3.1 self-reference, §3.3 (3 rows), §4 (Rank 2 count 51/64, the Rank 3 row, *"thirteen"* → *"fourteen"*), §6 (gap row), §8 (changelog) |
| 6 | Register the ADRs | `ADR-INDEX.md` | The index follows the ADRs it indexes; the count is **re-derived from all 64 files, not incremented** |
| 7 | Update the registry | `PRD_REGISTRY.md` | §4.1 statuses first, then the §7 counts — each **measured, not incremented** (§5) |
| 8 | Correct the traceability matrix | `TRACEABILITY_MATRIX.md` §2N | `ADR-0064` §4 item 6: *"corrected, not rewritten"*, prior text **retained verbatim** |
| 9 | **The subject's own metadata** | — | ⛔ **NOT PERFORMED, and deliberately.** See §4.1. The eight Parts are byte-unchanged |
| 10 | Write this record | this file | A record of acts already performed. It cannot precede them |
| 11 | Re-run the checkers | `tool/docs_check/*.py` | §7 verdict |

⚠ **Step 9 is where this record departs from every predecessor.** `PRD-017`'s Stage 7 record edited its subject last
*"and deliberately so — the subject reports its status, it does not assert it."* Here the subject was **not edited at
all**. Four gate records (Stages 3, 4, 5, 6) are anchored to Part hashes; editing a Part to add the word `FROZEN`
would have invalidated four records to add a claim the document has no standing to make. **The status lives in the
register and the baseline, which is where a reader is told to look.**

---

## 3. Subject hashes, published so the byte-identity claim can be checked

| File | Version | sha256 (first 16) |
|---|---|---|
| `PRD-012a_SECURITY_AUTOMATION.md` | v0.1 | `dbd01d4d00165c77` |
| `PRD-012a_PART2_PLATFORM_ADMIN_SECURITY.md` | v0.2 | `6752e5a01244e1d0` |
| `PRD-012a_PART3_ZERO_TRUST_IAM_TENANT_SECURITY.md` | v0.3 | `0908005425958477` |
| `PRD-012a_PART4_APPLICATION_API_SESSION_DATA_SECURITY.md` | v0.4 | `d2794ab294731707` |
| `PRD-012a_PART5_THREAT_DETECTION_MONITORING_ALERTS.md` | v0.5 | `254f45e29977de30` |
| `PRD-012a_PART6_SECURITY_AUTOMATION_INCIDENT_RESPONSE.md` | v0.6 | `2620bad1e56e6b86` |
| `PRD-012a_PART7_AUDIT_VULNERABILITY_TESTING_RESILIENCE.md` | v0.7 | `a1e95f1e694fa934` |
| `PRD-012a_PART8_TRACEABILITY_AND_ACCEPTANCE.md` | v0.8 | `a8c45d79eb8154f7` |

⚠ **`PRD-017`'s record had to publish a before/after pair and explain a change; this one publishes a single column
and explains an absence.** `git diff --stat bd85a31 HEAD` over all eight paths returns **EMPTY** — so **no alignment
supplement was required and none was written**. This is the `PRD-016`/`PRD-023` condition, not the `PRD-008`/`PRD-013`
one, and the difference is measured rather than asserted.

⚠ **`PRD-012a` is admitted at v0.8 — the SIXTH v0.x document frozen at its authored version** — per `ADR-0020` §4
item 2: *"Freeze confers status; it does not renumber."* **The version did not move, because nothing changed.**

---

## 4. What this freeze does not do

### 4.1 The subject was not edited, and one marker is knowingly left standing

⛔ **`SECP-FR-018` retains its `PENDING-AUTHORITY` marker** at Part 2 **L332/L348/L452/L526/L544/L555**, even though
[`ADR-0063`](../../00-governance/adr/ADR-0063-platform-step-up-reauth-is-a-security-obligation-on-bc18-mechanism.md)
has **substantively satisfied its condition**. Removing it is an amendment to a now-frozen Rank 3 document, requiring
its own ADR under `PRD_LIFECYCLE.md` **L172**, and it would invalidate four hash-anchored gate records.

**This is the `FIL-GAP-012` precedent exactly** — closed in fact, row not editable without amendment authority. **An
implementer MUST read `ADR-0063` beside Part 2.** `SECP-GAP-014` and `SECP-GAP-043` therefore remain **OPEN as
register rows** while being **answered in substance**, and the baseline says so at **L294** rather than letting the
two facts drift apart.

⚠ **`ADR-0063`'s header row states it *closes* `SECP-GAP-014` and `SECP-GAP-043`.** Tested against its own body: the
only other mentions are **L27** (stating the two candidate readings) and **L164** (the changelog). **The header
describes the substantive answer; the register rows record the marker.** Both are true of different things, and this
record states which is which rather than picking the reading that looks tidier.

### 4.2 `FROZEN` is not `VERIFIED`

| Claim a reader might make | Measured |
|---|---|
| The acceptance criteria are proven | ⛔ **0 of 128** |
| The implementation tasks are done | ⛔ **0 of 60** (`IMPL-1300`…`1359`) |
| The open questions are settled | ⛔ **0 of 47 closed. All 47 OPEN** |
| Code exists | ⛔ **0 lines.** `lib/platform/security/` **does not exist as a directory** |

`SID-4.56`: *"A rule that cannot be checked SHALL be treated as unmet."*

### 4.3 The gap count ROSE

**44 → 47** (**22 High · 23 Medium · 2 Low**). `ADR-0060` opened `SECP-GAP-045`; `ADR-0062` opened `SECP-GAP-046`
and `SECP-GAP-047`. ⚠ **An admission that *reduced* a gap count would be the suspicious outcome**, and the direction
is recorded because the intuitive one is wrong.

⚠ **The subject's own `SECP-GAP` register still tops out at 044**, measured. `045`–`047` exist only in the ADRs that
opened them — which is the correct consequence of not editing the subject, and is stated so the two figures are not
read as a discrepancy.

### 4.4 No architecture artefact was amended

| File | `git diff bd85a31 HEAD` |
|---|---|
| `LIBOORA_ENTERPRISE_ARCHITECTURE.md` | **EMPTY** |
| `LIBOORA_BOUNDED_CONTEXT_MAP.md` | **EMPTY** |
| `tool/module_dependencies.yaml` | **EMPTY** |
| `authentication/Authentication_PRD_v2.md` | **EMPTY** |

⚠ **`ADR-0062` REFUSED all four requested outbound `port` declarations** rather than granting them; the manifest is
untouched. ⚠ **`ADR-0061` did NOT edit the EA**, because the two documents describe different objects. ⚠ **`ADR-0063`
neither amended nor contradicted frozen `AUTH-8.81`.**

⚠ **Bounded contexts remain at 31, measured** — 31 distinct `BC-nn` tokens in the BC Map, max `BC-31`, and **`BC-32`
appears nowhere in it**. A repository-wide sweep finds **123 `BC-32` occurrences across 23 files and not one is a
definition**: `ADR-0035` §5.2.5 is titled *"Why `BC-32` MUST NOT be created"* and `PAYMENT_GOVERNANCE_RESOLUTION.md`
§3.1 records *"`BC-32` is REFUSED"*. ⛔ **So `ADR-0060`'s refusal is the SECOND independent refusal of a `BC-32`, not
a novel act** — which strengthens it, and was found by measuring rather than by citing `ADR-0060` back to itself.

---

## 5. Counts, each re-derived rather than incremented

| Count | Value | How |
|---|---|---|
| Identifiers | **427** across **15** registers, **all contiguous 1..max** | Re-measured this pass; matches `TRACEABILITY_MATRIX.md` §2N exactly |
| Class A obligations | **109** (84 `SECP-FR-*` + 25 `SECP-BR-*`) | Register census |
| Acceptance criteria | **128**, coverage **109/109 = 100.0%** | Part 8 §5 |
| ADR files | **64** — 51 `Accepted`, 13 `Proposed` | Directory census. **Five ADDED (`ADR-0060`…`0064`); zero modified** |
| Registry rows | **25 rows / 24 distinct numbers** — `FROZEN` **14**, `IMPLEMENTING` **1**, `DRAFT` **2**, `PLANNED` **7**, `RETIRED` **1** | Mechanical status census; 14+1+2+7+1 = 25 ✅ |
| PRD documents on disk | **26 files / 17 identities** | ⚠ **+8 files, not +1** — `PRD-012a` is eight files |
| Rank 3 module baselines | **14** | ⚠ §4 holds **13 rows** — `GCP-20`, disclosed not repaired |
| `docs_check` checkers | **25 scripts, TOTAL NONZERO = 5 (baseline 5)** | **No regression.** The same five pre-existing failures, not repaired |

⚠ **Two counts were NOT moved, and the restraint is the point.**

1. **"PRDs unassignable under rule 1" stays at `1`.** `PRD_REGISTRY.md` §8 rule 7 makes `PRD_OWNERSHIP_MODEL.md`
   *"the authority on ownership"*, and that model **still** records `PRD-012` as ⚠ Split/unassignable (**L179**,
   **L305**) with `PRD-012a`/`PRD-012b` *"(reserved)"* (**L180–181**). Reducing the register's count would put the
   register **ahead of its own authority** — the exact inversion rule 7 exists to prevent.
2. **The matrix `Baseline` field stays `BASELINE-2026-08-04-D`.** §7 rule 4 moves the identifier only for a
   **Rank 1–3** version change, and the matrix is **unranked** — it confers nothing.

---

## 6. Disposition of every item NOT closed — reason **and** named owner

`PRD_LIFECYCLE.md` permits an item to be resolved, formally deferred, or dispositioned. **Nothing below is left
without an owner**, because a deferral without an owner is an abandonment.

| Item | Disposition | Owner | Reason |
|---|---|---|---|
| `SECP-GAP-010` — should this platform own an aggregate? | ⏸ **Formally deferred** | **Architecture Owner** | Rank 4 structural question. `ADR-0060` §5.3 declined it explicitly rather than answering it in passing — and it is the finding that made `BC-32` refusable, since a new context would have been **empty by construction** |
| `SECP-DEP-005` — `BC-24`'s support-access category list | ⏸ **Formally deferred** | **`BC-24` owner** | A **frozen Rank 3** document's own gap (`AUD-GAP-004`). Not this role's to fill, and filling it would amend a frozen document without its owner |
| `SECP-GAP-014` / `SECP-GAP-043` — the `PENDING-AUTHORITY` marker | ✅ **Answered in substance**, ⏸ **row deferred** | **Product Owner + `BC-18` owner** | `ADR-0063` settled the reading. The **marker** is a subject amendment (§4.1) |
| `SECP-GAP-045` — `PRD_LIFECYCLE.md` §6 names no owner for Stage 1 | ⏸ **Formally deferred** | **Governance Owner, as a lifecycle amendment** | Amending Rank 1 process text is a **separate act** from admitting a document. ⚠ Found by measurement while establishing who could answer `SECP-ADR-001`, and **disclosed rather than papered over by asserting standing** |
| `SECP-GAP-046`, `SECP-GAP-047` — manifest block / rank-0 contract route | ⏸ **Formally deferred** | **Architecture Owner** | Opened by `ADR-0062`; both Rank 4 |
| `SECP-GAP-001`…`044` (remainder) | ⏸ **Admitted OPEN** | As recorded per row in Part 8 §6 | `ADR-0064` §4 item 8 admits every one **without ratifying any** |
| ⭐ **`SECP-DEP-007` — the `PRD_OWNERSHIP_MODEL.md` half** | ⛔ **NOT PERFORMED — routed** | **Governance Owner, under its own ADR** | See §6.1. **The most consequential item in this table** |
| ⭐ **`PRD_REGISTRY.md` §2 lacks a `RETIRED` row** | ⛔ **NOT PERFORMED — routed** | **Governance Owner** | See §6.2 |
| `GCP-20` — §3.3 says fourteen Rank 3 baselines, §4 holds thirteen rows | ⏸ **Disclosed, not repaired** | **Governance Owner** | The missing row is `PRD-014`. Repairing it silently would be an undisclosed edit to a Rank 1 document's precedence table |
| `GCP-14`, `GCP-21`…`GCP-25` | ⏸ **Standing deferral** | **Governance Owner** | Pre-existing; unchanged by this pass |

### 6.1 `SECP-DEP-007` is only PARTIALLY discharged, and the count was NOT moved to hide it

Part 8 **L358** requires: *"Update `PRD_REGISTRY.md` §4.1 **and** `PRD_OWNERSHIP_MODEL.md` to reflect the executed
split."* **Two files. One was updated.**

`ADR-0064` §4 item 5 discharges it **"for the registry"** — its own narrower and correct wording — while
**`ADR-0064`'s header row overclaims** *"Closes … `SECP-DEP-007`"*. Tested rather than reasoned about:
**`grep -n "OWNERSHIP_MODEL\|Ownership Model\|ownership model" ADR-0064` returns exit code 1 — ZERO occurrences.**

So **no decision authorises the ownership-model edit**, and making it now would be a change to a ranked document with
its ADR written *afterwards* — precisely what baseline §7 rule 1 forbids. ⚠ **The decision text governs the header
row, not the reverse**, and the discrepancy is published rather than resolved in whichever direction was convenient.

**The consequence is the count in §5:** because §8 rule 7 makes the ownership model the **authority** on ownership,
and it still records `PRD-012` as unassignable, the register's *"unassignable"* cell **stays at 1**. ⛔ **The
convenient answer — `0`, "the split is executed" — was refused.**

### 6.2 `RETIRED` is not in the registry's closed status vocabulary

`PRD_REGISTRY.md` §2 (**L37–L47**) lists ten statuses and states: *"A PRD is in **exactly one** of these states. **No
other value is permitted in the Status column.**"* **`RETIRED` is absent from that list.**

But §8 rule 1 and §4.1 **L264–L265** both **name retirement as the mechanism** — *"`PRD-012` itself is retired on the
day `PRD-012a` is opened; its number is **not** reused."* ⛔ **The defect is therefore §2's incomplete vocabulary, not
the status value**, and the fix is a §2 row — a Governance Owner act on a Rank 1 process document, **distinct from
admitting a PRD, and NOT performed here.** Disclosed at `PRD_REGISTRY.md` §10 v2.1 as finding (1).

---

## 7. Verdict

| Mandatory Stage 7 gate clause | Result |
|---|---|
| A row in `DOCUMENTATION_BASELINE.md` §3 at an assigned precedence rank | ✅ **PASS** — L198 (§3.3), rank assigned at L252 (§4) |
| Conferred, not claimed | ✅ **PASS** — conferred by `ADR-0064`; the subject makes no self-declaration and was not edited |
| ADR before the change (§7 rule 1) | ✅ **PASS** — `ADR-0064` complete before any ranked edit |
| Baseline identifier advanced (§7 rule 4) | ✅ **PASS** — `BASELINE-2026-08-21-A` |
| Registry reflects the conferred status (§8 rule 3, same commit) | ✅ **PASS** — §4.1 + six re-derived §7 rows |
| `FROZEN` only if in baseline §3 at Rank 1–5 (§8 rule 4) | ✅ **PASS** — Rank 3 |
| ADR registered and counts re-derived | ✅ **PASS** — 64/51/13 |
| Prior stage gates | ✅ **PASS** — Stage 1 `NOT APPLICABLE`, Stages 3–6 recorded |
| Repository checkers show no regression | ✅ **PASS** — 5 nonzero of 25, **baseline 5** |
| Code unaffected | ✅ **PASS** — `flutter analyze` *No issues found!*; **0 lines** under `lib/`, `packages/`, `test/`, `web/` |

### **VERDICT: PASS. `PRD-012a` is `FROZEN` at Rank 3 under `BASELINE-2026-08-21-A`.**

⛔ **Every mandatory clause is satisfied by an artefact that exists, and not one gate was made to pass by changing a
requirement.** The eight Parts were never opened for writing: **0 identifiers minted, 0 requirements changed, 0
acceptance criteria changed, 0 counts edited in the subject.** Where a gate could only have been passed by editing
the subject or by asserting an authority not held — the `PENDING-AUTHORITY` marker, the ownership-model half of
`SECP-DEP-007`, §2's missing `RETIRED` row, `BC-32` — **the gate clause was satisfied another lawful way or the item
was routed to its owner, and never by writing the edit and hoping the authority followed.**

---

## 8. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-21 | Created. Stage 7 record for `PRD-012a` Security Automation v0.8 — **PASS at Rank 3**. Records the conferral made by `ADR-0064` under `BASELINE-2026-08-21-A`, the four B7 blockers closed by **four separate authorities across three roles**, and the **eleven** items formally deferred or dispositioned with a reason **and** a named owner each (§6). ⛔ **Three things this record refuses to do:** publish a before/after subject-hash pair (**there is no change to publish** — all eight Parts byte-identical to `bd85a31`), move the *"unassignable"* count to `0` (**§8 rule 7 makes `PRD_OWNERSHIP_MODEL.md` the authority and it still says otherwise** — §6.1), and remove `SECP-FR-018`'s `PENDING-AUTHORITY` marker (**a subject amendment needing its own ADR** — §4.1). ⚠ **Two findings routed to the Governance Owner rather than performed:** the `PRD_OWNERSHIP_MODEL.md` half of `SECP-DEP-007`, unauthorised because `ADR-0064` contains **zero** mentions of that file despite its header claiming closure; and §2's missing `RETIRED` status row. ⚠ **`BC-32`'s refusal was found to be the SECOND independent refusal**, not a novel act — `ADR-0035` §5.2.5 refused it for the payment gateway — established by sweeping all **123** occurrences across **23** files and confirming **none is a definition**. |
