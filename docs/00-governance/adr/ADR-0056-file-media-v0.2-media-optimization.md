# ADR-0056 — `PRD-017` v0.2: media optimization is a V1 obligation of `BC-29`, and video stays out

| Field | Value |
|---|---|
| **Status** | **Accepted** — 2026-08-20 |
| **Date** | 2026-08-20 |
| **Deciders** | **Architecture Owner** (`PRD_OWNERSHIP_MODEL.md` §2.2, L85 — *"any Rank 1–5 document change"*), with the **Product Owner** attesting the V1 scope addition per §2.4's stage table |
| **Supersedes** | — |
| **Amends** | `docs/30-product/file-media/PRD-017_FILE_AND_MEDIA.md` (**Rank 3, FROZEN v0.1**) → **v0.2**. New identifiers only; **no obligation-bearing (`FIL-FR`/`BR`/`INV`/`XC`) or Class B (`FIL-AC`/`CFG`) identifier is renumbered, reworded, withdrawn or deleted**. ⚠ **One Class C finding row is revised** — `FIL-GAP-012`, to record that `ADR-0055` closed its architecture half; see §8.2 |
| **Amended by** | — |
| **Baseline** | **`BASELINE-2026-08-20-C`** — a **Rank 3** document changes version, so `DOCUMENTATION_BASELINE.md` §7 step 4 **requires** a baseline re-issue. Supersedes `BASELINE-2026-08-20-B`. The **third** suffix advance in one day |
| **Closes** | Nothing. **This ADR adds obligations; it discharges none** |
| **Opens** | **`FIL-GAP-014`** (no authority supplies compression quality floors), **`FIL-GAP-015`** (`job_runtime` is V2 at Rank 6 but V1 processing needs it), **`FIL-GAP-016`** (video/audio optimization is unauthorised at V1 and the request for it is recorded, not granted) |
| **Related** | `ADR-0054` (froze v0.1) · `ADR-0055` (admitted `BC-12` to `E-22`) · `ADR-0042` (the EA-lags-a-PRD repair shape) · `PRD_LIFECYCLE.md` **§4** (the seven-step amendment path) · `FIL-FR-004`, `FIL-FR-005`, `FIL-FR-055`…`059`, `FIL-XC-014`, `FIL-XC-015`, `FIL-XC-016` · `FIL-GAP-005` · `MP-CON-08` · EA **L1874–1880** · BC Map **L138** |

> ✅ **ACCEPTED 2026-08-20.** The amendment in §8 has been executed: `PRD-017` is **v0.2**.
>
> This ADR exists because `PRD_LIFECYCLE.md` §4 requires it. `PRD-017` is **FROZEN**, the change is a **new
> requirement**, and L170 classifies that as *"Same as a business-rule change"* → **ADR → version increment →
> changelog → baseline, in that order**. L177 is the reason it is not skipped:
>
> > *"**A frozen PRD is never silently modified.** Not for an obvious correction, and not for one that is
> > certainly right… If a silent edit is acceptable when the editor is confident, the freeze protects nothing,
> > because every editor is confident."*

---

## 1. The question

The product instruction of 2026-08-20 asks for WhatsApp-style media optimization in **V1**: images compressed
while staying readable, **handwritten notes and study material legible**, document-aware profiles, adaptive video
transcoding, optimized serving variants, originals preserved on request, PDFs never blindly re-compressed, limits
owned by configuration/entitlement rather than hard-coded, and the whole pipeline secure, isolated, audited and
never able to serve a half-processed object.

Four questions had to be answered from the repository before a single requirement could be written:

1. Is media optimization inside `BC-29`'s boundary at all, or does it belong to another context?
2. Is it a **V1** obligation, given that the EA places *"Image Optimization & Thumbnails"* at **V2**?
3. Can **video** be optimized at V1, when `FIL-FR-005` (**frozen**) forbids accepting it and `FIL-XC-016`
   (**frozen**) forbids transcoding it?
4. Who owns the numeric limits — File & Media, Configuration, or Entitlement?

---

## 2. Evidence

| Source | Rank | What it establishes |
|---|---|---|
| BC Map **L138** | **4** | `BC-29` *"owns upload, virus scan, **thumbnailing**, signed URLs, storage abstraction"* — derivative generation is **inside** the boundary, at **V1** |
| `MASTER_PRD.md` **L194** | **1** | `BC-29` = *"Student documents, uploads, signed URLs, virus scan"* — no optimization verb, and **no prohibition** either |
| EA **L1877** | **6** | *"Image Optimization & Thumbnails (**V2**)"* |
| EA **L1878**, **L1880** | 6 | Document Preview **V3**; CDN Delivery **V2** |
| EA **L964** | 6 | *"Videos (**V3**)"* under *"Media & Text Sharing (V2)"* |
| Baseline **L139** | — | The EA is *"**Descriptive** — must follow the PRDs, never lead them"* |
| `PRD-017` `FIL-GAP-005` | 3 | The **identical** V1-vs-V2 conflict for thumbnailing was already ruled: *"Precedence resolves it in favour of V1 (`MP-CON-08`)"* |
| `PRD-017` `FIL-FR-055`…`059` | 3, FROZEN | A complete derivative framework already exists: generate, inherit access, regenerable, cascade-delete, bounded set |
| `PRD-017` **`FIL-FR-004`** | **3, FROZEN** | V1 supports **exactly three** content classes: images, PDF, non-executable office/text |
| `PRD-017` **`FIL-FR-005`** | **3, FROZEN** | *"Video and audio **SHALL NOT** be accepted in V1"* |
| `PRD-017` **`FIL-XC-016`** | **3, FROZEN** | The module *"**MUST NOT** implement video or audio transcoding, streaming, adaptive bitrate or media playback"* |
| `PRD-017` `FIL-CFG-002`, `003`, `007` | 3, FROZEN | Type allow-list, byte ceiling and derivative-size set are **already** configurables |

⚠ **Every `FIL-` row above is prefixed with `PRD-017` deliberately.** An identifier alone in a leading table
cell is indistinguishable from a **definition**, and `prd017_stage5.py` check 4c correctly flagged the first draft
of this table as *"ADR-0056 defines FIL-FR-004"*. An ADR **cites** requirements; only the owning PRD defines them.
The table was reshaped so the citation is unambiguous — **the checker was not exempted**.

---

## 3. Findings

### 3.1 Optimization is inside `BC-29`, at V1 — decided by precedence, not preference

BC Map L138 (**Rank 4**) puts *thumbnailing* in `BC-29` at V1, and `FIL-FR-055`…`059` already specify derivative
generation as a frozen V1 obligation. **Compression is the same operation class as thumbnailing**: read an
original, produce a bounded derived representation, never let it become the sole copy. The EA's V2 placement is
the *identical* conflict `FIL-GAP-005` already resolved in favour of V1 under `MP-CON-08`, and the baseline
records the EA as descriptive. **Ruling: media optimization is a V1 obligation of `BC-29`.**

The EA is **not edited by this ADR** — `FIL-GAP-005` notes that repair belongs to the `ADR-0042` shape and to the
Architecture Owner as a separate act. This ADR extends `FIL-GAP-005`'s scope note rather than opening a duplicate.

### 3.2 ⛔ Video optimization is REFUSED at V1 — and this is the central decision

The instruction asks for *"videos… adaptive compression/transcoding based on resolution, duration and file
characteristics."* Three frozen requirements stand in the way:

- **`FIL-FR-004`** — V1 supports exactly images, PDF, office/text.
- **`FIL-FR-005`** — *"Video and audio **SHALL NOT** be accepted in V1."*
- **`FIL-XC-016`** — the module *"**MUST NOT** implement video or audio transcoding, streaming, adaptive bitrate."*

And **no Rank 1–4 document authorises video at V1.** Measured: `MASTER_PRD.md` contains **zero** occurrences of
*"video"* or *"audio"*; BC Map L138 names none; the only Rank 6 mention places *"Videos"* at **V3**. `PRD-017`
§2.4 already recorded this measurement and concluded the answer was *"nowhere"*.

**So a V1 video-transcoding requirement would have to be founded on a product instruction alone, against three
frozen requirements and with no ranked authority behind it.** That is precisely the move
`PRD_LIFECYCLE.md` L177 forbids and `MP-CON-08` precedence does not license: precedence promoted thumbnailing
because a **higher-ranked** document (BC Map, Rank 4) already required it at V1. **For video there is no
higher-ranked document to promote from — there is nothing above V3.**

**Decision: video and audio optimization is NOT added to V1.** `FIL-FR-005` and `FIL-XC-016` remain in force,
**unamended**. Instead:

1. The **adaptive-profile machinery is specified generically** — profile selection by measured input
   characteristics — so that admitting video later is *"a configuration and entitlement change, not a redesign"*,
   which is exactly what frozen `FIL-FR-071` and `FIL-FR-005` promise.
2. The **product request is recorded as `FIL-GAP-016`**, with the named remedy: a Rank 1 or Rank 4 authority must
   admit video as a V1 file type, then an ADR may lift `FIL-XC-016`. **OPEN, owner Product Owner + Architecture
   Owner.**

Refusing this is the honest answer, not a limitation. Writing a V1 video-transcoding requirement would have made
the register *look* complete while contradicting three frozen requirements in the same document.

### 3.3 Document integrity: PDFs must not be lossy-compressed, and that is a rule, not a preference

The instruction and the repository agree here. `FIL-XC-015` (frozen) already forbids rendering a document
preview (EA: **V3**). A PDF or office document therefore has **no** lossy path in V1: it may be losslessly
re-compressed at the container level or left alone, and its byte-exact recoverability is an **invariant**, not a
configurable. This becomes `FIL-INV-012` and `FIL-BR-018`.

### 3.4 Readability of study material is the *reason* this is hard, so it gets a measurable floor

*"Handwritten notes, study material, assignments and text-heavy images must remain highly readable"* is the whole
point of the feature and the easiest thing to lose. A requirement saying "preserve good quality" is untestable
and `SID-4.56` rules that *"a rule that cannot be checked SHALL be treated as unmet."* Therefore:

- The module **classifies** each image as *document-like* (text-heavy/handwritten) or *photographic*, and selects
  a **document-aware profile** for the former — higher quality floor, no chroma subsampling that smears
  thin strokes, minimum long-edge resolution preserved.
- A **quality floor** is configurable and **bounded**, and the acceptance criteria are written against a
  **fixture corpus** of handwritten and text-heavy images, so "readable" is measured, not asserted.
- ⚠ **No Rank 1–4 authority supplies the numeric floor.** Opened as **`FIL-GAP-014`** rather than inventing a
  number and presenting it as derived. The requirement is complete; the *value* is owed by Configuration.

### 3.5 Ownership of limits stays out of File & Media

The instruction says limits must come *"through configuration/entitlement ownership rather than hard-coding
policy in File & Media."* This matches frozen `FIL-XC-009` and the existing `FIL-CFG-*` design: `FIL-CFG-002`
(types), `003` (byte ceiling), `007` (derivative sizes) are already configurables consumed over `E-19`. The new
optimization parameters extend that register — they do **not** create a policy owner inside `BC-29`.
**Original-quality upload is an entitlement decision** consumed, never minted here (`FIL-BR-001`'s consumed-
permission rule).

### 3.6 Failure must never expose a partial object

*"Failed processing must never expose an invalid/incomplete media object."* The frozen document already has the
right primitive — `FIL-FR-057`, a derivative *"**SHALL NOT** be the sole copy"* — but nothing states that a
half-written derivative is unreadable. That becomes an **invariant** (`FIL-INV-013`): an object is servable only
in a terminal-ready state, and a failed or in-flight processing attempt is never served. This is why the
lifecycle is specified as an explicit state machine rather than a set of flags.

### 3.7 Processing changes nothing about authorization, tenancy or audit

Optimization runs **inside** the existing guarantees, so no new authorization or isolation model is created:
`FIL-FR-056` (frozen) already makes a derivative inherit the original's access decision, tenant class and
lifecycle state. The new requirements **restate nothing** and instead add the two facts that framework does not
cover: a processing worker gets **no ambient authority** beyond the object it was given, and processing outcomes
are **auditable by the consumer** over the `FIL-BR-011` route — because `BC-29` publishes no event, so `E-20` is
unavailable to it (frozen §13.2). `FIL-EVT-*` therefore **stays empty**, and no member is minted.

---

## 4. Decision

1. **Media optimization is a V1 obligation of `BC-29`**, on the `MP-CON-08` precedence ruling already recorded in
   `FIL-GAP-005`.
2. **`PRD-017` goes to v0.2** by the `PRD_LIFECYCLE.md` §4 path, with **18 new obligations** across four
   registers (13 `FIL-FR`, 2 `FIL-BR`, 2 `FIL-INV`, 1 `FIL-XC`) and **18 new acceptance criteria**, all appended
   contiguously. ⚠ **These figures were corrected against measurement during execution.** The drafted plan said
   *"19 requirements across five registers"* and *"16 criteria"*; the executed amendment is **18 obligations across
   four** and **18 criteria**. Two causes, both recorded rather than smoothed: `FIL-FR-095` and `FIL-CFG-015` were
   **added during execution** because writing the configurable exposed that nothing bounded the `PROCESSING` state,
   which would have left `FIL-FR-092`'s terminal-state promise and `FIL-INV-013`'s servability rule unenforceable;
   and the criteria grew from 16 to 18 to cover the two new obligations. `FIL-CFG-*` is **Class B**, so counting it
   among *"requirement registers"* was itself an error in the plan.
3. **No obligation-bearing or Class B identifier is renumbered, reworded, withdrawn or deleted.** Verified by
   snapshotting every pre-existing definition line and re-matching it — see §8.2, which records the **one**
   deliberate Class C exception rather than claiming a clean sweep.
4. **Video and audio optimization is REFUSED at V1** (§3.2). `FIL-FR-005` and `FIL-XC-016` stand unamended;
   `FIL-GAP-016` records the request and the remedy.
5. **PDF/document integrity is an invariant**, not a setting (§3.3).
6. **Study-material readability gets a bounded, fixture-tested floor**, with the missing value opened as
   `FIL-GAP-014` (§3.4).
7. **All numeric limits live in `FIL-CFG-*`**, consumed over `E-19`; entitlement decisions stay consumed (§3.5).
8. **A partial or failed object is never servable** — invariant, plus an explicit lifecycle state machine (§3.6).
9. **`FIL-EVT-*` remains DECLARED EMPTY.** No event is minted, because no BC Map producer row exists for `BC-29`.
10. **Baseline re-issued to `BASELINE-2026-08-20-C`** — mandatory, Rank 3 version change.

---

## 5. What this ADR does NOT rest on

- **Not** on the EA. The EA is descriptive and places this work at V2; it is cited as *evidence of a conflict*
  and resolved by precedence, not used as authority.
- **Not** on the product instruction alone. Where the instruction had no ranked backing — video — it was
  **refused**, and the refusal is the proof the instruction was not treated as authority.
- **Not** on `ADR-0055`. That ADR authorised an edge; this one adds requirements. They are independent and either
  could stand without the other.
- **Not** on any claim that the new requirements are implemented, tested or verified. **None of them are.**

---

## 6. Options considered

| Option | Verdict |
|---|---|
| Edit the frozen PRD directly and note it in the changelog | ⛔ **Rejected.** `PRD_LIFECYCLE.md` L170 classifies a new requirement as a business-rule change requiring an ADR first. L177 forbids the silent path explicitly |
| Write the optimization requirements into a *new* PRD | ⛔ **Rejected.** `PRD_LIFECYCLE.md` L67: *"Does another PRD already own the context? It is an amendment to that PRD, not a new one."* `BC-29` is `PRD-017`'s |
| Include V1 video transcoding as instructed | ⛔ **Rejected** — §3.2. Three frozen requirements and zero ranked authority |
| Amend `FIL-FR-005`/`FIL-XC-016` to permit video | ⛔ **Rejected.** Withdrawing a frozen requirement needs *"an ADR stating what replaces it"* (L172) **and** a ranked authority to justify it. The authority does not exist; manufacturing one is the failure mode this repository is built to prevent |
| Put quality floors as literals in the PRD | ⛔ **Rejected.** Hard-codes policy in File & Media, against `FIL-XC-009` and the explicit instruction |
| Invent a plausible quality floor to avoid opening a gap | ⛔ **Rejected.** A fabricated number that reads as derived is worse than a disclosed hole. `FIL-GAP-014` |
| Bump to v1.0 rather than v0.2 | ⛔ **Rejected.** `ADR-0020` §4: freeze does not renumber, and every other module baseline sits at v0.x. A minor increment matches the change: additive, no breaking edit |

---

## 7. Consequences

**Positive.** WhatsApp-class media handling becomes a *specified* V1 capability with testable criteria; study
material has a defended readability floor; document integrity is an invariant; the lifecycle can no longer serve
a half-processed object; limits stay with their proper owners.

**Negative / accepted.** `PRD-017`'s uncovered-obligation count rises, because new Class A obligations arrive
with criteria attached but the module's overall coverage is diluted — §8 republishes the measured figure rather
than hiding it. Three new gaps are opened. `job_runtime` is Rank 6 V2 while V1 processing needs it
(`FIL-GAP-015`), inherited from frozen `FIL-XC-017`. Nothing here is implemented.

**Not a consequence.** No context boundary moved. No ownership migrated. No frozen requirement was reworded. No
event was minted. Nothing became verified.

---

## 8. Execution — the `PRD_LIFECYCLE.md` §4 seven steps, **executed 2026-08-20**

| Step | Action | Executed |
|---|---|---|
| **1** | Write this ADR — **before** the change | ✅ |
| **2** | Accept it | ✅ Status **Accepted** |
| **3** | Increment `PRD-017` **v0.1 → v0.2** | ✅ |
| **4** | Update the PRD changelog — same commit | ✅ §18.3 |
| **5** | Update `DOCUMENTATION_BASELINE.md` — same commit → **`BASELINE-2026-08-20-C`** | ✅ |
| **6** | Update `TRACEABILITY_MATRIX.md` — identifiers changed | ✅ §2M |
| **7** | Update `PRD_REGISTRY.md` | ✅ L307 |
| **+** | Register this ADR in `ADR-INDEX.md` | ✅ |

### 8.1 Identifiers added — contiguous, no reuse

| Register | Was | Added | Now |
|---|---|---|---|
| `FIL-FR-*` | 82 | **`083`…`095`** (13) | **95** |
| `FIL-BR-*` | 17 | **`018`…`019`** (2) | **19** |
| `FIL-INV-*` | 11 | **`012`…`013`** (2) | **13** |
| `FIL-XC-*` | 22 | **`023`** (1) | **23** |
| `FIL-CFG-*` | 9 | **`010`…`015`** (6) | **15** |
| `FIL-AC-*` | 78 | **`079`…`096`** (18) | **96** |
| `FIL-GAP-*` | 13 | **`014`…`016`** (3) | **16** |
| `FIL-EVT-*` | **0** | **none — DECLARED EMPTY** | **0** |
| **Total** | **232** | **+45** | **277** |

`PRD_LIFECYCLE.md` §5 rule 5 — *"Numbers are never reused"* — is satisfied: every new identifier extends its
register's maximum.

### 8.2 Pre-existing text preserved — measured, not asserted

Verified by extracting every pre-existing identifier's definition line from v0.1 and from v0.2 and comparing.
**Measured result: 231 of 232 byte-identical, 1 deliberately revised, 0 removed, 0 renumbered.**

⚠ **This ADR originally claimed "232 of 232" and the claim was FALSE.** The measurement was run after the edits
and returned 231. The revised line is **`FIL-GAP-012`**, a **Class C finding** row, rewritten to record that
`ADR-0055` closed its architecture half while its implementation half stays open. That revision is *authorised* —
`ADR-0055` §5 requires it, and a gap register whose rows may never change could never record a gap closing — but
the ADR's own preservation claim did not carve it out, so the claim was corrected to the measured figure rather
than the figure re-interpreted to fit the claim.

**All 132 v0.1 obligation-bearing identifiers and all 87 Class B identifiers are byte-identical.** The exception
is confined to one row of one Class C register. The method and result are reproducible:

```
snapshot every ^`FIL-XX-NNN` — and ^| `FIL-XX-NNN` | definition line before the edit
re-match each after the edit; report missing, changed, added
```

This is the same discipline `S4-D-06` exists to enforce: a total that is carried forward instead of recomputed is
the defect class this repository has already been bitten by twice.

---

## 9. Compliance

| Rule | Where | Satisfied by |
|---|---|---|
| ADR **before** the change | `PRD_LIFECYCLE.md` §4 step 1; baseline §7 rule 1 | This ADR, accepted first |
| Version increment + changelog, same commit | §4 steps 3–4; baseline §7 rule 2 | §8 |
| Baseline updated, same commit | §4 step 5; baseline §7 rule 4 | `BASELINE-2026-08-20-C` |
| Traceability updated if identifiers changed | §4 step 6 | Matrix §2M |
| Registry updated | §4 step 7 | L307 |
| Identifiers unique platform-wide, contiguous, never reused | §5 rules 1, 4, 5 | §8.1 |
| *"A frozen PRD is never silently modified"* | L177 | The whole instrument |
| *"A rule that cannot be checked SHALL be treated as unmet"* | `SID-4.56` | Every new obligation carries an AC or is disclosed uncovered |

---

## 10. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-20 | Created and **Accepted**. Authorises `PRD-017` **v0.1 → v0.2** adding **18 obligations / 18 acceptance criteria / 6 configurables / 3 gaps** (**45** identifiers, measured) for V1 media optimization: image compression with a document-aware profile for handwritten and text-heavy study material, lossless-only document handling, adaptive profile selection by measured input characteristics, serving variants, original preservation, an explicit upload→validation→processing→ready/failed lifecycle, progress/retry/idempotency, and a servability invariant. **Video and audio optimization was REFUSED** — `FIL-FR-005` and `FIL-XC-016` stand unamended and the request is recorded as `FIL-GAP-016`. Re-issues the baseline to **`BASELINE-2026-08-20-C`** because a Rank 3 document changed version |
