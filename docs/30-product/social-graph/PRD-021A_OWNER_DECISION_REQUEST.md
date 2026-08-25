# PRD-021A — Owner Decision Request: the blockers remaining after the D2-P SHIP decision

| Field | Value |
|---|---|
| **Document** | `PRD-021A` Owner Decision Request |
| **Version** | v1.0 |
| **Scope** | The open blockers of **A2 v0.5** and **A3 v0.3** after `LCF-GAP-012` was resolved |
| **Source** | `PRD-021A_A2_..._v0.5.md` · `PRD-021A_A3_..._v0.3.md` · `PRD-021A_LCF-GAP-012_DECISION_RECORD.md` — sole sources |
| **Convention** | The Pack → Request pattern of `PRD-006_ATT-GAP-017_OWNER_DECISION_REQUEST.md` |
| **Decisions made here** | **Zero** |
| **Values proposed here** | **Zero** |
| **Gaps resolved here** | **Zero** |

> **Why this document exists.** After the Product Owner's `LCF-GAP-012` SHIP decision was integrated, every
> remaining blocker was tested against frozen and accepted authority to see whether it was **determinable**
> rather than a decision. **None is.** The measurement is recorded in §2 so the refusal is falsifiable, and
> each item is then routed to its named owner with the exact question it must answer. **Requesting a decision
> is not making one.**

---

## 1. What is already decided, and is not reopened here

| Item | State | Authority |
|---|---|---|
| **D2-P** — do comments and reactions ship? | ✅ **DECIDED — SHIP** | Explicit Product Owner scope decision, recorded in `PRD-021A_LCF-GAP-012_DECISION_RECORD.md` |
| `LCF-GAP-012` | ✅ **RESOLVED** | A2 v0.5 §34 |
| `LCR-DEC-002` | ✅ **RESOLVED — SHIP** | A3 v0.3 §32 |
| Release class of `CommunityComment` / `CommunityReaction` | ✅ **V2 — determined, not chosen** | `MP-SCOPE-04`, `MASTER_PRD.md` **L92**, **Rank 1** |

⭐ **The V2 determination is not an inference from EA L989.** That line reads `Comments (V3)` and sits under
**Notes Sharing**, a different capability branch. `MP-SCOPE-04` places `BC-14`/`BC-15` at **V2** at Rank 1, and
`LCF-INV-002` makes `BC-15` the sole owner of both aggregates. **Nothing in this document reopens any row above.**

---

## 2. The determinability test, and why it returned nothing

Each blocker was tested for whether frozen or accepted authority already fixes the answer. The probes and
their measured results:

| Probe | Scope searched | Result |
|---|---|---|
| Reaction kind tokens (`HELPFUL`, `THANKS`, `CLAP`, `UPVOTE`, `LIKE`, `LOVE`, `CELEBRATE`, `INSIGHTFUL`, `SUPPORT`, `THUMBS`) | `docs/` outside PRD-021A | **0** |
| `reaction kind` / `reaction type` / `reaction_kind` | `docs/`, `lib/`, `test/`, `tool/`, `CONFIGURATION_GUIDE.md` | **0** |
| Same, across **all branches** and the **full commit history** | `main`, `github/main`, 333 commits, `git log --all -S` | **0** — the set never existed |
| Any published ranking weight value for any signal | whole repository | **0** |
| `Privacy Owner` as a defined role | `PRD_OWNERSHIP_MODEL.md` | **0 occurrences** |
| `reaction` anywhere in the Enterprise Architecture | `LIBOORA_ENTERPRISE_ARCHITECTURE.md` | **0** |
| `LCF-` / `LCR-` / `LCM-` prefix registration | `TRACEABILITY_MATRIX.md` | **0 — unregistered** |

⚠ **The ten tokens in the first row are search terms, not candidates.** They were chosen to make the search
broad enough to be meaningful and are listed so the probe is reproducible. **This document proposes no reaction
kind**, and the presence of a token in a probe column SHALL NOT be read as a recommendation — enumerating the
set is the Product Owner's act under `LCF-BR-010` (§3.1).

⭐ **One corroborating measurement, which decides nothing but points the same way.** **FROZEN, Rank 3**
`PRD-017` records `FIL-GAP-006` — *"No V1 context owns comments, likes or reactions on shared content"* — and
routes it to the **Product Owner**. A frozen document independently treating this as an owner's decision is
evidence that it is not a clerical fact to be looked up. It is cited as corroboration, **not** as authority
for any value.

---

## 3. Product Owner — three decisions

### 3.1 `LCF-GAP-014` — enumerate the reaction kind set

**The obligation is already asserted and currently unsatisfied.** A2 `LCF-BR-010` (§17):

> *"The reaction kind set SHALL be closed and SHALL be defined in this part's data model (§22). It SHALL NOT
> be client-extensible."*

A2 §22's `kind` row declares only `Closed set — ⛔ members not yet enumerated`. **No member is named
anywhere.** The contrast inside the same document shows what satisfying this looks like — `LCF-FR-027`:
*"The post type set SHALL be exactly `TEXT`, `NOTE`, `MEDIA`, `LINK`."*

| Question | Owner | Blocked by |
|---|---|---|
| What is the closed set of reaction kinds? | **Product Owner** | Nothing — decidable today |

> **`LCF-GAP-014` — REACTION KIND SET (Product Owner).**
> · The closed set SHALL be exactly: ______________________________________________
> · Which member, if any, denotes "helpful" for ranking purposes: __________________
> I confirm this is a product decision and not a set copied from another product, platform or example
> (`LCF-BR-010` forbids a client-extensible set).
>
> Product Owner: ______________________ Date: __________

⚠ **Consequence if left open.** `LCF-BR-010` remains breached inside A2, and **no dependent part may reference
any individual reaction kind** — which is precisely what blocks §3.2 below.

### 3.2 `LCR-GAP-003` — which kind denotes "helpful"

**This is strictly downstream of §3.1 and is listed separately because it is a different question.** The
original gap — *"do comments and reactions exist?"* — is **ANSWERED** by D2-P. What remains is narrower:
`LCR-RS-003` Helpfulness needs a kind to key on, and no kind exists to name.

| Question | Owner | Blocked by |
|---|---|---|
| Which reaction kind, if any, is the helpfulness signal? | **Product Owner** | **`LCF-GAP-014`** — prerequisite |

**No signature block is offered.** The question is not answerable before §3.1, and offering a blank to sign
would invite a kind to be named that the closed set does not contain. Answer §3.1's second limb instead.

### 3.3 `LCR-DEC-008` — the weight for `LCR-RS-004`

**The substrate is authoritative; only the value is missing.** A2 `LCF-FR-061` already carries *"comment
count, reaction summary"* per post in the feed response, and `LCF-FR-084` defines the summary as an aggregate
count per kind. No new field, store, edge or event is required. A3 v0.3 therefore holds `LCR-RS-004` at
🟡 **ELIGIBLE**, contributing **exactly zero** under `LCR-FR-028a`.

**Why the number is not proposed here.** A3 `LCR-FR-034`:

> *"No reserved weight is published here… Weights are assigned when a signal activates, by whoever owns its
> activation."*

With `LCR-FR-033` requiring active weights to sum to exactly `100`, activating a second signal is a **value**
decision. D2-P decided **scope**, not values.

| Question | Owner | Blocked by |
|---|---|---|
| The weight for `LCR-RS-004`, and the renormalised active set | **Product Owner** | Nothing — decidable today |

> **`LCR-DEC-008` — ENGAGEMENT WEIGHT (Product Owner).**
> · `LCR-RS-001` Recency weight: __________
> · `LCR-RS-004` Legitimate engagement weight: __________
> · I confirm the active weights sum to exactly `100` (`LCR-FR-033`, `LCR-FR-035`).
>
> Product Owner: ______________________ Date: __________

⭐ **Current active set, for reference and not as a proposal:** `LCR-RS-001` Recency = `100`. It is the whole
active range today because it is the only active signal.

---

## 4. Architecture Owner — two decisions, each needing its own ADR

### 4.1 D2-A-i — enumerate comments and reactions in the Enterprise Architecture

**Measured state of the EA `Community (V2)` block (L967–973) — six children:**

```
├── Community (V2)
│   ├── Public Communities (V2)
│   ├── Private Communities (V2)
│   ├── Community Feed (V2)
│   ├── Community Roles (V2)
│   ├── Moderation (V3)
│   └── Community Analytics (V3)
```

Comments are **absent**; `reaction` occurs **0 times in the entire EA at any version**. Two PRD parts now
specify aggregates the descriptive architecture does not name.

**Why this is raised and not repaired.** `MP-CON-08` (`MASTER_PRD.md` **L519**, Rank 1) holds that the EA is
*"descriptive, not prescriptive"*, sits at **rank 6**, and that where it disagrees with a higher-ranked
document *"the higher-ranked document wins and the Enterprise Architecture is updated to match — never the
reverse. **A disagreement is a defect to be raised, not a choice to be made.**"* It is raised here.
Amending the EA requires EA **§10.5 step 1** — *"Propose the change as an ADR"* — and the `ADR-0042`
precedent shows the shape: a one-token Rank 6 correction carried by an accepted ADR.

| Question | Owner | Note |
|---|---|---|
| Which EA nodes are added under `Community (V2)`, and at which version tag? | **Architecture Owner** | The **version** half is already determined: **V2**, per `MP-SCOPE-04` Rank 1. The **enumeration** half is the decision |

> **D2-A-i — EA ENUMERATION (Architecture Owner).**
> · ADR number raised for this change: __________
> · Node(s) added under `Community (V2)`: ______________________________________________
> · Version tag assigned per EA §10.3: __________
> · I confirm the direction of correction is Rank 6 following Rank 1, never the reverse (`MP-CON-08`).
>
> Architecture Owner: ______________________ Date: __________

⚠ **The baseline identifier does not advance for this.** `DOCUMENTATION_BASELINE.md` §7 rule 4 permits a
suffix advance only when a **Rank 1–3** document changes version, and the EA is **Rank 6** — the same
exemption `ADR-0042` and `ADR-0055` already record.

### 4.2 D2-A-ii / `LCF-GAP-013` — repoint `LCF-FR-026`'s citations

`LCF-FR-026` reads: *"This part SHALL NOT require any V3 capability. `Moderation (V3)` and `Community
Analytics (V3)` (EA L972–973) are out of scope (`LCF-XC-016`, `LCF-XC-017`)."*

Both cited identifiers have the wrong subject — `LCF-XC-016` is rate-limit policy authorship, and
`LCF-XC-017` is (now) threaded replies and mentions.

⭐ **This is why it is a decision and not a typo. Each V3 subject has two defensible candidates:**

| V3 subject | Candidate A | Candidate B |
|---|---|---|
| `Moderation (V3)` | `LCF-XC-006` — moderation cases, abuse reports, enforcement, strikes, appeals (`BC-13`, BC Map L379) | `LCF-XC-028` — anti-spam heuristics, reputation scoring, abuse detection (`BC-13`, EA L919) |
| `Community Analytics (V3)` | `LCF-XC-015` — analytics metric definitions, projections, reports (`BC-26`) | `LCF-XC-029` — the analytics product for community content (EA L973) |

Selecting a pair is a choice between live alternatives. **The `PRD_LIFECYCLE.md` fast path does not reach
it:** L170 and L291 permit fixing a *"typo or broken link"* directly, but both identifiers are syntactically
valid and resolve to real rows — the defect is **semantic**. The controlling precedent is **`ACCEPTED`
`ADR-0015`**, which required a full ADR to repoint three wrong context citations, and whose own risk row
warns against being *"used as precedent for editing frozen documents to fix 'obvious' typos without an
ADR"*, authorising *"three named cells in one named file"* only.

> **D2-A-ii — CITATION REPOINTING (Architecture Owner).**
> · Exclusion identifier covering `Moderation (V3)`: __________
> · Exclusion identifier covering `Community Analytics (V3)`: __________
> · ADR number raised for this change: __________
>
> Architecture Owner: ______________________ Date: __________

⚠ **Narrowing `LCF-XC-017` did not worsen this gap.** Neither cited identifier covered either V3 subject
under any prior reading, so the mis-citation is unchanged in substance.

---

## 5. Blocked at a role that does not exist

| Item | Routed to | Status |
|---|---|---|
| `LCR-DEC-003` / `LCR-GAP-006` — is per-viewer impression tracking permissible? | **Privacy Owner + Product Owner** | ⛔ **NOT REQUESTABLE** |

**`Privacy Owner` occurs 0 times in `PRD_OWNERSHIP_MODEL.md`.** The role these items are routed to is not
defined in the repository, over a population that `SM-INV-3` records as minor-inclusive. **No signature block
is offered**, because there is no defined authority to sign it.

⭐ **This is an escalation to the Governance Owner**, not a decision request: either the role is constituted,
or the two items are re-routed to an existing authority. **Neither is proposed here.**

---

## 6. Structurally unarbitrable — recorded so it is not mistaken for an oversight

| Item | Why no precedence appeal exists |
|---|---|
| `LCR-GAP-009` — does the community scope identifier carry a `tenantId`? | BC Map **L450** and **L488** are **both Rank 4**. `MP-CON-08` resolves disagreements *between* ranks; with both sources at the same rank there is no higher rank to appeal to. `ADR-0042` recorded the same shape for two Rank 6 lines — *"`MP-CON-08` structurally cannot arbitrate"* |

This needs the **Architecture Owner** to rule on the intended reading, not a precedence calculation.

---

## 7. Remaining open items, routed but not restated

Each already carries a definition and a named owner in its own register. Listed for completeness so this
request is exhaustive rather than selective.

| ID | Owner | Register |
|---|---|---|
| `LCR-DEC-001` — does a help/resolution state exist? | Product Owner | A3 §32 |
| `LCR-DEC-006` — does an official announcement surface exist? | Product Owner | A3 §32 |
| `LCR-DEC-004` / `LCR-GAP-004` — admit a `BC-15 → BC-11` edge? | Architecture Owner | A3 §31, §32 |
| `LCR-DEC-007` / `LCR-GAP-008` / `LCF-GAP-009` — register `BC-15`'s aggregates in BC Map §8 | Architecture Owner | A3 §31, §32; A2 §33.2 |
| `LCR-GAP-002` — no `helpState`, announcement type or priority field | Product Owner (with the A2 author) | A3 §31 |
| `LCR-GAP-007` — no consumable content-quality contract from `BC-13` | `BC-13` owner | A3 §31 |
| `LCR-GAP-010` / `LCF-GAP-010` — no latency or throughput budget | Product Owner + Architecture Owner | A3 §31; A2 §33.2 |
| `LCR-GAP-001` / `LCF-GAP-001` — the `LCR-` and `LCF-` prefixes are unregistered | **Governance Owner** | A3 §31; A2 §33.2 |
| `LCF-GAP-004` — no PRD exists for `BC-14` Content Sharing | Architecture Owner / `BC-14` author | A2 §33.2 |
| `LCF-GAP-006` — body length, attachment count, page-size bounds | Product Owner + Configuration Owner | A2 §33.2 |
| `LCF-GAP-007` — enforcement staleness ceiling uncitable while `PRD-020` is DRAFT | `PRD-020` owner | A2 §33.2 |
| `LCF-GAP-008` — permission catalogue closed; no `PERM-*` to bind to | Governance Owner / Auth PRD owner | A2 §33.2 |
| `LCF-GAP-011` — `integration_test/` does not exist | Engineering Owner | A2 §33.2 |

---

## 8. One new observation, reported and deliberately not registered

`PRD-020` **`TSF-FR-027`** requires the `AbuseReport` subject-type register to include `COMMUNITY_POST` and
`COMMUNITY_COMMENT` — **but names no `COMMUNITY_REACTION`**. Now that reactions ship, whether a reaction is a
reportable subject is an open question.

**It is deliberately NOT recorded as a new gap identifier.** `PRD-020` is **DRAFT and unranked**, so it cannot
bind A2; and minting an A2 identifier for a question that belongs to another document's owner would be
inventing a requirement. **Routed to the `PRD-020` owner as an observation.**

---

## 9. Sequence — what each decision unblocks

| Step | Who | Closes | Then unblocked |
|---|---|---|---|
| 1 | **Product Owner** — reaction kind set (§3.1) | `LCF-GAP-014`; satisfies `LCF-BR-010` | `LCR-GAP-003`, and with it `LCR-RS-003` |
| 2 | **Product Owner** — engagement weight (§3.3) | `LCR-DEC-008` | `LCR-RS-004` ELIGIBLE → ACTIVE; `LCR-AC-022` becomes writable |
| 3 | **Architecture Owner** — ADR for EA enumeration (§4.1) | D2-A-i; `LCR-FND-007`…`013` | The EA stops contradicting two PRD parts |
| 4 | **Architecture Owner** — ADR for citation repointing (§4.2) | `LCF-GAP-013` / D2-A-ii | — |
| 5 | **Architecture Owner** — aggregate registration and the `BC-15 → BC-11` edge | `LCR-DEC-004`, `LCR-DEC-007`, `LCR-GAP-008`, `LCF-GAP-009` | A3 §20 registration |
| 6 | **Governance Owner** — prefix conferral; the Privacy Owner role | `LCR-GAP-001`, `LCF-GAP-001`; unblocks §5 | `LCR-DEC-003` becomes requestable |

⛔ **Steps 1–2 are unblocked today, and completing them does not make A3 freezable.** A3 v0.3 is **NOT READY /
NOT FROZEN** with 9 open gaps and 6 open decision requirements, and
`PRODUCT_IMPLEMENTATION_ROADMAP.md` **L161–164** independently holds that *"`PRD-021` must not ship before
`PRD-020`… a release-blocking defect, not a schedule change."* **Partial progress does not confer readiness.**

---

## 10. What this request deliberately did not do

| Not done | Why |
|---|---|
| Propose any reaction kind | `LCF-BR-010` reserves the set to this part's data model, and enumerating it is the Product Owner's act. **No kind is proposed, recommended or implied.** ⚠ Precisely stated: ten kind tokens **do** appear once, at §2 L44, **inside the probe column recording what was searched for and that the result was `0`**. They are search terms evidencing absence — **not a candidate set, and not to be read as one** |
| Propose any ranking weight | `LCR-FR-034` reserves weight values to the activation owner. **Zero numbers appear** |
| Choose between the `LCF-FR-026` candidate pairs | §4.2 presents both; choosing is the Architecture Owner's act |
| Amend the Enterprise Architecture | Rank 6 following Rank 1 requires an ADR first (EA §10.5 step 1) |
| Amend `LCF-FR-026`, `LCF-XC-016` or any A2 requirement | A2 v0.5 is **byte-unchanged** by this document |
| Amend A3 | A3 v0.3 is **byte-unchanged** by this document |
| Reopen D2-P | It is decided — SHIP. §1 records it and nothing here disturbs it |
| Resolve any gap or decision requirement | Every one remains at its recorded status. **Requesting is not deciding** |
| Create or accept an ADR | None is minted. `ADR-INDEX.md` is not amended |
| Create a BC, edge, aggregate, event, permission, storage model or architecture concept | None is required by any decision recorded to date |
| Mark A3 READY or FROZEN | Its governance criteria are not satisfied |
| Constitute the Privacy Owner role | §5 escalates it; constituting a role is a Governance Owner act |
| Register the `LCF-` / `LCR-` prefixes | A Governance Owner act; measured as unregistered in §2 |

---

## 11. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | — | Created as the owner-boundary artefact after the post-D2-P blockers were re-measured and **none was found determinable from frozen or accepted authority**. Records the determinability probes and their zero results in §2, including searches across all branches and the full 333-commit history, so the refusal is falsifiable rather than asserted. Routes three decisions to the **Product Owner** (reaction kind set, the helpfulness kind, the engagement weight) with signature blocks for the two that are decidable today, and deliberately **no** signature block for the one that is prerequisite-blocked. Routes two to the **Architecture Owner**, each requiring its own ADR, and shows for `LCF-FR-026` the **two defensible candidates per V3 subject** that make it a decision rather than a typo, against the `ADR-0015` precedent and the `PRD_LIFECYCLE.md` fast path that does not reach it. Records that `LCR-DEC-003`/`LCR-GAP-006` are **not requestable** because `Privacy Owner` is undefined in the ownership model, and that `LCR-GAP-009` is **structurally unarbitrable** because both sources are Rank 4. Discloses one new observation — `TSF-FR-027` names no `COMMUNITY_REACTION` — and **declines to register it** as a gap. **Proposes no reaction kind, no weight, no citation target, no EA node and no value of any kind. Resolves nothing, freezes nothing, amends no A2, A3, EA, BC Map, frozen PRD or ADR, and mints no identifier in any register.** |
