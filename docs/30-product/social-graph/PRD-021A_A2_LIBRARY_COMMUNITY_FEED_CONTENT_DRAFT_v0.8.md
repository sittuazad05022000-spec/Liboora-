<!--
  PROVENANCE — PRD-021A Part A2

  Purpose of this file
  --------------------
  CONTEXT-LOSS RECOVERY / CONTINUITY ARTEFACT.

  This file exists so that the exact state of PRD-021A Part A2 can be
  recovered from the repository after a context loss. It is NOT a freeze, NOT a
  baseline, and NOT a final document.

  v0.8 supersedes v0.7. v0.7, v0.6, v0.5, v0.4 and v0.3 are retained on disk and
  in git history; none is deleted, edited nor overwritten. This is deliberate and
  load-bearing: ACCEPTED ADR-0082 L421 records the sha256 of A2 v0.7
  (9192a8b1626716b5...) as a hash anchor, and L424 records that v0.7 is
  "deliberately NOT EDITED". Authoring v0.8 as a NEW FILE keeps that anchor
  byte-true and leaves every existing citation to v0.7 resolving. v0.8 therefore
  falsifies nothing in ADR-0082 and requires no amendment to it.

  Status        : DRAFT — v0.8
  Freeze status : NOT FROZEN. NOT FINAL. NOT APPROVED. NOT BASELINED.
  Lifecycle     : No stage advanced. The 7-stage finalisation and freeze happen
                  only after A1-A8 are all complete. A4-A8 do not exist; A3
                  exists (v0.6). Stage 3 is NOT CONFERRED. v0.8 makes Stage 3
                  Check 2 re-runnable by giving the three BC-11 consumptions a
                  self-blocking form; conferral itself remains a Governance
                  Owner act and is NOT claimed here.
  Identifiers   : The LCF- prefix is REGISTERED by ACCEPTED ADR-0080 section 5
                  (L195); LCF-GAP-001 is CLOSED. Individual LCF-* identifiers in
                  this document remain PROPOSED and UNRATIFIED - the prefix is
                  conferred, the requirements it labels are not.

  v0.4 CHANGELOG — P1 defect-fix and integrity pass
  -------------------------------------------------
  v0.4 is an INTEGRITY pass over v0.3. It fixes register/reference defects only.
  It performs NO redesign, NO scope expansion, NO renumbering, and it invents,
  removes, merges and splits NO requirement. Every architectural determination of
  v0.3 is preserved unchanged: V2 classification, BC-15 ownership of
  CommunityPost, the BC-14 attachment route, the A1 dependency, and all eight
  recorded conflicts with their named decision owners.

  Fixed in v0.4:
    D1  LCF-FR-* count: §33.1 declared 86; the register actually defines 110
        (001-110, dense). Count corrected to 110 and the false "gaps arising
        from renumbering" note corrected. No FR was added or removed.
    D2  LCF-XC-* count: §33.1 declared 29 but the document defined only 27 and
        cited two identifier positions that were never defined, while
        LCF-XC-026 and LCF-XC-027 were cited in sections 17 and 18 with no
        definition anywhere. The two undefined positions are no longer cited,
        and 026 and 027 are now defined from their own citation text. Register
        is now 29 defined, 0 dangling.
    D3  LCF-GAP-* dangling references: 001, 004, 007, 008, 010 and 011 were
        cited but never defined. All six are now defined in the new section
        33.2 gap register, each stating exactly what its existing citations
        already asserted. Nothing new is claimed. Count corrected 14 -> 9.
    D4  Cross-reference defects corrected: the LCF- prefix ratification gap was
        cited as a DEC identifier that the decision register assigns to a
        different subject, and the A3 dependency was cited by the wrong DEP
        number. Both now point at the correct existing identifiers.
    D5  Section 0 stated "NOT written to the repository" and "Repository :
        UNCHANGED. 0 files written". Both were true when v0.3's content was
        authored and both are false for a file that now lives in git. They are
        corrected here rather than preserved, because this pass was instructed
        to make the document internally consistent. The correction is disclosed,
        not silent.

  v0.5 CHANGELOG — D2-P scope resolution (LCF-GAP-012)
  ----------------------------------------------------
  v0.5 applies ONE authorised scope decision and its consequences. It performs NO
  redesign and NO renumbering, and it invents, removes, merges and splits NO
  requirement. Every architectural determination of v0.4 is preserved unchanged.

    S1  LCF-GAP-012 RESOLVED by an explicit Product Owner scope decision:
        Community Comments and Community Reactions are IN SCOPE and SHALL SHIP in
        this generation. Recorded in PRD-021A_LCF-GAP-012_DECISION_RECORD.md.
        LCF-XC-017 is NARROWED to threads and mentions only. The ~14 already
        specified comment/reaction identifiers are PRESERVED UNCHANGED - nothing
        is deleted, because deletion would have violated "invent, remove, merge,
        split no requirement".
    S2  LCF-GAP-014 RECORDED (new). LCF-BR-010 requires the reaction kind set to
        be "defined in this part's data model (section 22)", but section 22 states
        only "Closed set" and never enumerates a kind. SHIP makes this obligation
        live. Enumerating the set would be inventing requirements, so it is
        recorded and routed to the Product Owner, not filled in.

  Reported but deliberately NOT changed (see section 34):
    R2  LCF-FR-026 cites two exclusion identifiers whose subjects do not match
        the V3 capabilities it names. The correct targets are ambiguous, so it
        is reported and left intact. This is LCF-GAP-013, an Architecture Owner
        decision, and v0.5 has no authority over it.
        [v0.6: SUPERSEDED - the targets were determinable after all, and are
         repointed under ACCEPTED ADR-0076. See T2.]

  v0.8 CHANGELOG - three published findings remediated. NO redesign, NO
  renumbering, NO removal, NO merge and NO split of any requirement. Every
  architectural determination of v0.4, v0.5, v0.6 and v0.7 is preserved
  unchanged. v0.8 mints exactly ONE identifier (LCF-ADR-007), so register totals
  move from 318 identifiers / 16 registers to 319 identifiers / 16 registers.

  Source of truth: PRD-021A_ITEM_DISPOSITION_REASSESSMENT.md, section 5
  (findings S-1, S-2, S-3) and section 2 (item E-1). v0.8 executes S-1, S-2 and
  E-1. It deliberately does NOT execute S-3 (see the NOT-changed list below).

    S1  S-1 RESOLVED - the contradictory LCF- prefix wording is reconciled at
        all SIX sites the reassessment measured. v0.7 asserted, in the same
        document, both that the prefix is REGISTERED (changelog U3, per ACCEPTED
        ADR-0080 section 5 L195) and that it is "proposed, not conferred". The
        second reading is stale. Reconciled at:

          1. the provenance Identifiers block (this header)
          2. section 0's prefix note
          3. LCF-RSK-014 - the risk that the prefix might collide with a future
             ratification. RETIRED: a REGISTERED prefix cannot collide with a
             future ratification of itself. Position retained, not renumbered
             (PRD-023 CNF-FR-008).
          4. section 32 checklist item 20 - marked DONE, discharged by ADR-0080
             section 5 L195
          5. section 33.1's closing note
          6. the LCF-GAP-001 register row

        The distinction PRESERVED at every site: the PREFIX is conferred; the
        318 (now 319) individual LCF-* identifiers it labels remain PROPOSED and
        UNRATIFIED. Registering a namespace is not ratifying its contents.

    S2  S-2 RESOLVED - the A2 register cells and their dependents are reconciled
        with ACCEPTED ADR-0078 (Accepted 2026-08-25). ADR-0078's Closes row
        (L12) and its section 5.1 (L200) both name "A2 antecedents Conflicts 5
        and 6", which this document itself routes at section 20.2 to
        LCF-ADR-005/LCF-DEC-003 (v0.7 L1102) and LCF-ADR-006/LCF-DEC-003a
        (v0.7 L1118). Those four were still listed OPEN. Now CLOSED:

          LCF-ADR-005  ADR-0078 section 2.1 L58 - the community scope
                       identifier carries NO tenantId
          LCF-ADR-006  ADR-0078 section 2.1 L63 - BC Map L450 is scoped, not
                       universal
          LCF-DEC-003  outcome recorded
          LCF-DEC-003a outcome recorded; the blocker "no BC-15 event can be
                       lawfully emitted" is LIFTED

        Six dependent cells and the two conflict rows 5 and 6 in the
        "Architecture Conflicts / Decisions Required" appendix are updated to
        match. Decision-owner cells are struck through and marked
        "discharged by ADR-0078" - NOT reassigned, NOT invented.

        TWO precise limits are recorded rather than glossed:

        (a) S-2 unblocks NEITHER of the two surfaces that read as if it should.
            LCF-API-013 remains NOT PROVIDED because it also depends on the
            tenant-partitioned index class AR-3, which is still unspecified.
            LCF-AC-035 remains DEFERRED because it is independently blocked by
            LCF-GAP-011 - integration_test/ does not exist (re-measured at
            authoring time: ls -d integration_test -> No such file or
            directory). Each cell says "One of two blockers cleared".

        (b) The section 20.2 objection is NOT settled by ADR-0078 and is NOT
            claimed to be. New section 20.5 discloses the residual: ADR-0078
            rules that the field is absent; section 20.2 objected that a 1:1
            communityId "may be a tenantId wearing a different name", which is
            an objection about SEMANTICS, not about the field. Measured:
            ADR-0078 contains ZERO occurrences of communityId, "Option 1",
            "evasion", "1:1" and "wearing". Section 20.5 states the residual and
            assigns it to NO ONE - assigning it would be an owner act.

        Also RETIRED at v0.8, preconditions having ceased to exist:
        LCF-RSK-001 and LCF-RSK-002. Original risk text preserved inline;
        positions retained, never renumbered (PRD_LIFECYCLE.md section 5
        rule 5).

    E1  E-1 RESOLVED - the unconditional BC-11 consumption identified by
        Stage 3 Check 2 now has self-blocking form. Three requirements -
        LCF-FR-034 (v0.7 L591), LCF-AUTH-012 (v0.7 L818) and LCF-FR-096
        (v0.7 L1178) - were unconditional SHALLs consuming BC-11, while ZERO
        BC Map section 7 rows source BC-15. BC Map L292 provides: "If an edge is
        not in this table, it does not exist and adding it requires an ADR."
        Each of the three now carries a self-blocking clause in the SAME SHAPE
        this document already uses at LCF-FR-043 (v0.7 L660): "Until
        LCF-ADR-002 is accepted, ... SHALL be treated as blocked."

        This INVENTS NO RULE. It states the consequence BC Map L292 already
        imposes. Specifically:
          - no new edge is declared
          - no BC Map row is added, and BC Map is NOT modified
          - no threshold, window or quota value is stated (LCF-FR-096's clause
            says so explicitly; those values remain unspecified, LCF-GAP-006)
          - LCF-AUTH-012's clause records that the fail-closed direction is
            architecturally forced, not chosen: serving content while block
            enforcement is unreachable is the unsafe reading

        NEW IDENTIFIER: LCF-ADR-007 is minted and registered for the missing
        BC-15 -> BC-11 edge, so the three clauses point at a registered
        requirement rather than at nothing. It records that TWO Architecture
        Owner acts are required, not one: (i) a BC Map section 7 edge row under
        L292, and (ii) a Module Dependency Matrix cluster extension under rule
        L2 (Matrix L49), because domain/social is rank 8
        (tool/module_dependencies.yaml L47) and the declared Social cluster
        (Matrix L90) is BC-11/BC-12/BC-13 only. Neither act is performed here.

    R   Register bookkeeping - positions only, no renumbering:
          LCF-ADR-*  6 -> 7   (001-007; 007 minted at v0.8)
          LCF-DEC-*  7        (unchanged; 003 and 003a CLOSED, not removed)
          LCF-RSK-*  18       (unchanged; 001, 002, 014 RETIRED, positions kept)
        Total: 318 -> 319 identifiers across 16 registers.

  Reported but deliberately NOT changed at v0.8:

    - S-3 is NOT executed. ADR-0082 L43's "18 genuinely open items" covers only
      3 of 6 registers (it contains ZERO LCF-ADR-* and ZERO LCF-DEC-* ids;
      ADR-0081 section 1 L27 excludes them by construction). That finding is
      published as a DELTA in the reassessment record. Amending an ACCEPTED ADR
      is a Governance Owner act; ADR-0082 is NOT amended and NOT contradicted.

    - ADR-0075 section 8.5 Option B remains OPEN. The bare EA line-citations are
      the CLASS defect and Option B touches FROZEN documents, which
      PRD_LIFECYCLE.md L177 forbids. Its Governance + Architecture Owner
      authority remains unavailable.

    - LCF-XC-028 still cites EA L919 where the node measures at L920. A
      PRE-EXISTING off-by-one, outside the authority of the finding being
      remediated. Disclosed, not repaired.

    - LCF-GAP-002 and LCF-GAP-003 remain unused positions. Non-contiguity is
      disclosed, not closed by renumbering.

    - LCF-GAP-004, 006, 007, 008, 009, 010, 011 remain OPEN with their existing
      owners. v0.8 closes no gap for which no authority exists.

    - LCF-DEC-* items other than 003 and 003a are untouched. No owner decision
      is invented and no product value is supplied anywhere in v0.8.

    STATUS IS UNCHANGED: NOT FROZEN, NOT FINAL, NOT APPROVED, NOT BASELINED,
    and NO lifecycle stage advanced. In particular Stage 3 is NOT CONFERRED:
    v0.8 makes Stage 3 Check 2 RE-RUNNABLE by removing the unconditional
    consumption, but conferring a stage is a Governance Owner act and is NOT
    claimed here. LCF-ADR-007 is a REQUIREMENT for an ADR, not an ADR; no ADR
    is created by v0.8.

  v0.7 CHANGELOG - three ADRs integrated. NO redesign, NO renumbering; it
  invents, removes, merges and splits NO requirement, and mints NO identifier.
  Every architectural determination of v0.4, v0.5 and v0.6 is preserved
  unchanged. Register totals are UNCHANGED at 318 identifiers / 16 registers,
  because v0.7 CLOSES gaps rather than adding any.

    U1  LCF-GAP-013 now FULLY RESOLVED. The EA enumeration half - BLOCKED at
        v0.6 - is CLOSED by ACCEPTED ADR-0079, which executed ADR-0075
        section 8.5 Option A. The Enterprise Architecture is now v2.3 and its
        new section 12 enumerates Community Comments (V2) and Community
        Reactions (V2) owned by BC-15.

        Why it stopped being blocked: the blocker was never "editing the EA
        is unsafe", it was "inserting into the capability tree is unsafe".
        Inserting at L972 breaks 240 EA line-citations across 39 files, three
        FROZEN. But the highest EA line cited anywhere in the repository is
        L2404, in a then-2,549-line file - so an append below it breaks
        nothing. Measured after execution: 482 EA line-citations re-resolved,
        0 invalidated, 0 cited-line contents changed, 0 frozen files touched,
        EA L967-973 byte-identical, and no diff hunk between L12 and L2449.

        ADR-0075 keeps its EXECUTION BLOCKED status and is NOT superseded:
        the act it prescribed is still forbidden. ADR-0079 performed a
        different act reaching the same outcome.

    U2  LCF-GAP-005 CLOSED ON MEASUREMENT, not on decision. Its text asserts
        "A3 does not exist on disk". A3 now exists (v0.4, 1,175 lines, commit
        8a02d52). No owner decision was required or taken.

        Its sibling LCF-GAP-011 was tested the same way and REMAINS OPEN:
        integration_test/ still does not exist. Same shape, opposite result,
        each measured rather than assumed.

    U3  LCF-GAP-001 CLOSED by ACCEPTED ADR-0080. The LCF- prefix is
        REGISTERED. This became possible only because ADR-0080 constituted
        the Governance Owner role - the authority the gap was routed to, which
        until now was named in three Accepted ADRs but defined nowhere.

  Reported but deliberately NOT changed at v0.7:

    - LCF-GAP-004, 006, 007, 008, 009, 010, 011 remain OPEN with their
      existing owners. v0.7 resolves no gap for which no authority exists.
      Every one of them needs a value, an artefact or a role other than the
      three that acted here (ADR-0081 section 4.1).

    - LCF-XC-028 still cites EA L919 where the node measures at L920. This is
      a PRE-EXISTING off-by-one, present before this pass, and it is NOT
      repaired here: LCF-XC-028 is not the citation ADR-0076 repointed, and
      editing a requirement row to fix an unrelated drift is outside the
      authority of the three ADRs integrated at v0.7. Disclosed, routed.

    - The 281 bare EA line-citations (ADR-0075 section 8.5 Option B) remain
      OPEN. That is the CLASS defect; ADR-0079 removed an INSTANCE of it.
      Option B touches 32 files including FROZEN PRD-017 and the PRD-012a
      family, which PRD_LIFECYCLE.md L177 forbids.

    STATUS IS UNCHANGED: NOT FROZEN, NOT FINAL, NOT APPROVED, NOT BASELINED,
    and NO lifecycle stage advanced. ADR-0081 section 5.1 records ELEVEN
    unmet conditions, the first being that PRD-020 is still DRAFT while
    PRODUCT_IMPLEMENTATION_ROADMAP.md L161-164 forbids PRD-021 shipping
    before it. Closing five gaps is progress; it is not readiness.

  v0.6 CHANGELOG - owner rulings integrated. NO redesign, NO renumbering; it
  invents, removes, merges and splits NO requirement. Every architectural
  determination of v0.4 and v0.5 is preserved unchanged. One identifier is
  minted (LCF-BR-010a) on explicit Product Owner authority.

    T1  LCF-GAP-014 RESOLVED. The closed reaction kind set is exactly LIKE,
        HELPFUL, CELEBRATE, by explicit Product Owner enumeration recorded in
        PRD-021A_LCF-GAP-012_DECISION_RECORD.md v2.0 section 7.2. Written into
        section 17 and section 22. LCF-BR-010 moves UNSATISFIED -> SATISFIED.
        LCF-BR-010a is minted to state the closure rule, mirroring LCF-FR-027's
        existing model for the post type set - a reused pattern, not a new one.

    T2  LCF-GAP-013 citation half RESOLVED by ACCEPTED ADR-0076. LCF-FR-026's
        two cited identifiers are repointed: LCF-XC-016 -> LCF-XC-006, and
        LCF-XC-017 -> LCF-XC-029. Determined, not guessed - LCF-XC-028 was
        eliminated because it cites EA L919, a (V1) node, and a V1 node cannot
        ground a V3 exclusion; LCF-XC-029 is the only exclusion row citing EA
        L973, one of the two lines LCF-FR-026 itself names. No exclusion row
        was edited; only the two citing cells changed.

    T3  Section 31 corrected. v0.5's claim that "the next free number is
        ADR-0066" was WRONG. PRD-020 section 29.2 earmarks ADR-0066 through
        ADR-0073 to named subjects, ADR-0069 is marked DO NOT OPEN, and
        PRD_LIFECYCLE.md section 5 rule 5 forbids reusing a number. The ADRs
        governing this part are ADR-0075 through ADR-0078.

  Reported but deliberately NOT changed at v0.6 (see section 34):
    U1  The EA still does not enumerate Community Comments or Community
        Reactions. ADR-0075 was raised and ACCEPTED IN PRINCIPLE for exactly
        that, but its execution is BLOCKED and was reverted: inserting two
        lines into the EA capability tree shifts 175 line-number citations
        across 32 files, three of them FROZEN. ADR-0075 section 8 records the
        measurement and routes four options. LCF-GAP-013's enumeration half
        therefore stays OPEN. This document's normative text is unaffected -
        the EA is Rank 6 and descriptive (MP-CON-08).

    U2  LCF-GAP-001 and LCF-GAP-004 through LCF-GAP-011 are unchanged and
        remain OPEN with their existing owners. v0.6 resolves no gap for which
        it was not given explicit owner authority.

    U3  This document is still DRAFT. It is NOT frozen, NOT approved, NOT
        baselined, and confers no readiness on any PRD-021A part.

  What persisting this file DID and DID NOT do
  --------------------------------------------
    - It wrote exactly ONE file. A1 v0.2 was NOT modified.
    - It creates no bounded context. The count remains 31 (23 in V1).
    - It creates no integration edge, event, aggregate row, permission, role or
      configurable in any Rank 1-5 register.
    - It amends no FROZEN PRD, no ACCEPTED ADR, no Rank 1-5 artefact.
    - It creates no ADR and mints no ADR number.
    - It does not answer ADR-0036 section 8.2 question 2.
    - It records no acceptance criterion as passing.
    - It confers no status on this document.

  Directory placement is NOT the placement decision
  -------------------------------------------------
  Filed under docs/30-product/social-graph/ alongside A1, because PRD-021 is
  registered as "Social Graph & Messaging" (PRD_REGISTRY.md L321) and that is the
  document under which the A-series work was commissioned. That is a FILING
  convention only. It is NOT an architecture placement, a bounded-context
  assignment, a cluster assignment or a PRD_REGISTRY.md row. Relocating this
  file later is a git mv.
-->

# PRD-021A — Part A2
# Library Community Feed & Content

**v0.4 — DRAFT** · integrity pass over v0.3; supersedes v0.3, which is retained in git history

---

## 0. Provenance and status

```
Status        : DRAFT — v0.4. Persisted in the repository. Supersedes v0.3.
Freeze status : NOT FROZEN. NOT FINAL. NOT APPROVED. NOT BASELINED.
Lifecycle     : No stage advanced. Stage 7 freeze happens only after A1–A8 exist.
Repository    : This document is committed. v0.3 is retained, not overwritten.
                No other artefact is amended by this document.
Scope tag     : V2 — by repository authority, not by text substitution (see §7).
Predecessor   : A1 v0.2, docs/30-product/social-graph/
                PRD-021A_A1_LIBRARY_COMMUNITY_FOUNDATION_DRAFT_v0.2.md (1,532 L, commit 8a730e4)
```

**What this document does NOT do:**
- creates no bounded context — the count remains **31 (23 in V1)**
- creates no integration edge, event, permission, role, configurable or aggregate row in any Rank 1–5 register
- amends no `FROZEN` PRD (`PRD-004`, `PRD-005`, `PRD-007`, `PRD-017`), no `ACCEPTED` ADR, no Rank 1–4 artefact
- does not answer `ADR-0036` §8.2 q2
- does not mint an ADR number
- claims no acceptance criterion passes
- duplicates no ownership held by A1, A3–A8, `BC-10`, Library Membership (`BC-02`), Library Management (`BC-01`…`BC-09`) or Files & Media (`BC-29`)

✅ **The `LCF-` prefix used below is REGISTERED** by `ACCEPTED` `ADR-0080` §5 (**L195**), which constituted the Governance Owner role and registered both `LCF-` and `LCR-` in the same act. `LCF-GAP-001` is **CLOSED**. Every repository PRD carries a registered prefix (`MM-`, `SM-`, `FIL-`, `TSF-`, `CNF-`, `ENT-`, `LMD-`, `LCM-`), and `LCF-` now joins them. ⚠ Registration of the **prefix** is not ratification of the **identifiers**: each `LCF-*` requirement below remains PROPOSED until its own gate is satisfied.

---

## 1. Executive Summary

A2 specifies the **Library Community Feed** — the private, single-library surface on which members of one library post, read and discuss study-related content.

Three determinations distinguish v0.3 from the v0.1 draft, each forced by repository measurement rather than preference:

| # | v0.1 said | Repository says | v0.3 |
|---|---|---|---|
1 | Community Feed is **V1** | **V2** — `LIBOORA_ENTERPRISE_ARCHITECTURE.md` **L970**; `MASTER_PRD.md` **L92** (**Rank 1**); BC Map **L119**/**L147** | **V2**, with the V1/V2 seam specified in §7 |
2 | A2 owns `CommunityPost` under A1's placement | A1 is an `AR-1` read composition that *"owns no aggregate"* | `CommunityPost` is **`BC-15`'s** aggregate. A2 is its **specification**, not a new context (§5, §22) |
3 | Attachments are a `FileRef` held by A2 | `E-22` consumers are `BC-01, BC-10, BC-12, BC-14` (BC Map **L331**); *"if an edge is not in this table, it does not exist"* (**L292**) | A2 holds **no `FileRef`**. Attachments are a **`BC-14` Content Sharing** reference (§10) — `BC-14` **already holds `E-22`** |

⭐ **The third determination is the most consequential and is new to this pass.** `BC-14` Content Sharing — *"Owns user-generated notes, media, links; copyright and takedown"* (BC Map **L118**) — has been an `E-22` consumer since **v1.5** and remained one through **v1.8**. It is **V2**, in the same **Global Student** cluster as `BC-15`, and its declared ownership is exactly "the shared artefact". Routing community attachments through `BC-14` therefore requires **no widening of `E-22`** and asks nothing of `BC-29` that `PRD-017` `FIL-FR-006`/`FIL-FR-007` forbid.

⛔ It still requires **one** new edge — `BC-15 → BC-14` — because no such edge exists (measured: `BC-15` appears in exactly **two** edge rows, both inbound `E-14`). That is a strictly smaller and more natural ask than admitting a content-bearing context to the storage edge, and it is an **Architecture Owner** decision (`LCF-ADR-002`).

A fourth determination is **not** made here because it cannot lawfully be made by a PRD — see §20 and `LCF-DEC-003`.

---

## 2. Problem Statement

A library's members are co-located, co-enrolled and mutually accountable, yet today have no shared surface inside the product. The consequences, in the order they matter:

`LCF-FR-001` — Members of one library have no place to ask a study question of people who share their room, timetable and syllabus.
`LCF-FR-002` — Library-relevant announcements have no durable home; `BC-22` Notification Delivery is a **push channel**, not a readable record.
`LCF-FR-003` — Knowledge produced inside one library (notes, resource links, exam intelligence) leaves with the member who produced it.
`LCF-FR-004` — Absent a first-party surface, members coordinate on external platforms where the platform can offer **no** minor-safety control, **no** moderation and **no** tenant boundary.

**What this problem is not.** It is not discovery, not a public profile, not a rating system, and not a global network. Those are separate surfaces with separate owners (§4, §5).

`LCF-FR-005` — A2 **SHALL** serve exactly one relationship: *a member of library L, reading and writing content visible only to members of library L.*

---

## 3. Goals

| ID | Goal |
|---|---|
`LCF-FR-006` | A durable, ordered, **library-private** content surface, readable only by principals A1 determines to be participants |
`LCF-FR-007` | A single post aggregate with an explicit lifecycle, owned by exactly one bounded context |
`LCF-FR-008` | Content types that are **useful in a study library**, deliberately narrow (§8) |
`LCF-FR-009` | Attachment support that adds **no** new storage consumer and holds **no** bytes and **no** raw storage path |
`LCF-FR-010` | Deterministic, resumable retrieval that does **not** presuppose a pagination convention the repository lacks (§14) |
`LCF-FR-011` | Deterministic default ordering, with **ranking delegated entirely** to A3 (§16) |
`LCF-FR-012` | Moderation **integration** with `BC-13`, defining no moderation policy of its own (§11, §12) |
`LCF-FR-013` | Membership and grace-window behaviour **inherited** from A1, redefined nowhere (§12) |
`LCF-FR-014` | Server-side scope enforcement, object-level authorization, and no cross-library leakage under any read path (§20) |
`LCF-FR-015` | A specification that requires **zero** silent amendments to any frozen or accepted artefact, and that names every amendment it *does* require as an explicit ADR requirement (§31) |

---

## 4. Non-Goals

| ID | Excluded | Owner / authority |
|---|---|---|
`LCF-XC-001` | Public Library Profile, public library search, location-based discovery | `14A-Library-Discovery-And-Enrollment.md` §14A.4–§14A.6 (**FROZEN**) |
`LCF-XC-002` | Ratings and reviews of libraries | Library Discovery surface; explicitly **not** the private Community |
`LCF-XC-003` | Local Discovery / Global Discovery / cross-library student networking | **Outside V1 and outside A2.** Nearest repository feature is `Nearby Students` — **V2**, EA **L929** |
`LCF-XC-004` | Friend graph, follow graph, block list | `BC-11` Social Graph — `Friendship`, `BlockList` (BC Map **L377**) |
`LCF-XC-005` | Direct messaging, conversations | `BC-12` Messaging — `Conversation` (BC Map **L378**) |
`LCF-XC-006` | Moderation cases, abuse reports, enforcement actions, strikes, appeals | `BC-13` — `ModerationCase` (BC Map **L379**) |
`LCF-XC-007` | Study groups, community roles, group membership | **`BC-15`'s other aggregates** — BC Map **L119**. A2 specifies `CommunityPost` only |
`LCF-XC-008` | Membership status, plan, term, freeze, renewal | `BC-02` — `Membership` (BC Map **L371**); `PRD-005` **FROZEN** |
`LCF-XC-009` | The membership-validity determination and the participant predicate | **A1** — `LCM-RM-*`, `LCM-AUTH-003` |
`LCF-XC-010` | Global profile, username, privacy settings, profile photo | `BC-10` — `GlobalStudentProfile` (BC Map **L376**) |
`LCF-XC-011` | Bytes, storage vendors, virus scan, thumbnails, signed URLs | `BC-29` — `PRD-017` **FROZEN** |
`LCF-XC-012` | Ranking, relevance scoring, personalisation, recommendation | **A3** (planned) — `LCF-DEP-005` |
`LCF-XC-013` | Notification delivery, channel selection, quiet hours | `BC-22` (BC Map **L131**) |
`LCF-XC-014` | Search index construction, relevance, query rewriting | `BC-23` (BC Map **L132**) |
`LCF-XC-015` | Analytics metric definitions, projections, reports | `BC-26` (BC Map **L135**) |
`LCF-XC-016` | Rate-limit policy authorship | `BC-11` holds `RateLimitCounter` (**L377**); `TSF-CFG-009` bounds request limits. A2 **consumes** (§21) |
`LCF-XC-017` | Threaded replies and mentions | **Narrowed at v0.5.** Comments and reactions are **IN SCOPE and SHIP** in this generation by explicit Product Owner decision (`LCF-GAP-012` RESOLVED — see `PRD-021A_LCF-GAP-012_DECISION_RECORD.md`); they are specified in §17, §22 and §24. Threads remain excluded by `LCF-XC-026`; mentions remain unspecified |
`LCF-XC-018` | Any new bounded context | Count stays **31 (23 in V1)** — BC Map **L149** |
`LCF-XC-019` | Any new membership system | `BC-02` + A1 only |
`LCF-XC-020` | Any new storage system | `BC-29` only, reached via `BC-14` |
`LCF-XC-021` | Any new ranking system | A3 only |
`LCF-XC-022` | Any new event transport | `PL` event mechanism per BC Map §10 only |
`LCF-XC-023` | Any new permission identifier | `AUTH-7.22` closes the catalogue; `ADR-0036` §7.1 records **zero** `PERM-*` repo-wide |
`LCF-XC-024` | Video and audio content | `FIL-FR-005` — refused at V1; `FIL-GAP-016` records the refusal |
`LCF-XC-025` | Cross-library search, global content discovery, semantic/vector search over community content | Restated at §15; index classes are categorically separate per `AR-3` (BC Map **§11.1 L494**) |
`LCF-XC-026` | Threaded replies to comments | Comments are single-level — `LCF-FR-082` |
`LCF-XC-027` | Edit history and revision retrieval | Only an edit marker is specified — `LCF-BR-011` |
`LCF-XC-028` | Anti-spam heuristics, reputation scoring, abuse detection | `BC-13` — EA **L919** `Anti-Spam & Rate Limits (V1)`. Restated at §21 |
`LCF-XC-029` | The analytics product for community content | `Community Analytics` is **V3** — EA **L973**. Restated at §26 |

---

## 5. Ownership Boundaries

### 5.1 The bounded-context determination

The single most consequential question this part answers is: **which bounded context owns
`CommunityPost`?**

A1 cannot own it. `AR-1` (`ARCHITECTURE_RULINGS.md` §23) requires that the Library Community
capability "owns no aggregate, no invariant, no business state", that "the count remains 31
(23 in V1)", and that "no `BC-` identifier is assigned". A1 restates that constraint in four
places — L131 (the test verbatim), L178 (`Owns no aggregate ✅`), L370 (`LCM-INV-014`) and
L615 (`LCM-AC-010`). A part that owns no aggregate cannot acquire one in a sibling part.

Therefore the post aggregate must live in an existing bounded context. Six candidates were
tested against the Bounded Context Map:

Candidate | Verdict | Measured basis
--- | --- | ---
A new `BC-32` | ❌ REJECTED | `AR-1` fixes the count at 31. Creating a context to hold a Community aggregate is exactly the move `AR-1` forbids.
`BC-11` Student Network | ❌ REJECTED | BC Map §8 L377 fixes its aggregates as `Friendship`, `BlockList`, `RateLimitCounter`. A post is none of those. `ADR-0055` L113 additionally refuses `BC-11` a `FileRef`.
`BC-12` Messaging | ❌ REJECTED | BC Map §8 L378 fixes `Conversation`, `RetentionPolicy`. A feed post is not a conversation; conflating them would put post content under `RetentionPolicy`, which A2 does not own.
`BC-13` Trust & Safety | ❌ REJECTED | BC Map §8 L379 fixes `ModerationCase`. `PRD-020` L610 (`TSF-XC-031`) explicitly excludes community "membership or post lifecycle" from Trust & Safety.
`BC-14` Content Sharing | ❌ REJECTED as post owner | BC Map L118 scopes it to "user-generated notes, media, links". An attachment is that. A post — with author, community scope, lifecycle and visibility — is not. (`BC-14` is still used, as the attachment owner: §10.)
⭐ `BC-15` Community & Groups | ✅ **DETERMINED** | BC Map L119: "Owns communities, study groups, membership of groups, community roles". A post published into a community is community state. `BC-15` is already a consumer of `E-14` (BC Map L318), already a target of `safety.EnforcementActionTaken` (BC Map L433), and is scheduled V2 (BC Map L147, `MASTER_PRD.md` L92) — the same version band as this capability.

`LCF-FR-016` | `CommunityPost` SHALL be owned by `BC-15` Community & Groups. No other bounded
context SHALL declare ownership of it.

`LCF-FR-017` | This part SHALL NOT create, request or imply a new bounded context. The count
SHALL remain 31 (23 in V1), per `AR-1`.

`LCF-INV-001` | No `BC-` identifier is minted by this part.

`LCF-INV-002` | `BC-15` remains the sole owner of `CommunityPost`, `CommunityComment` and
`CommunityReaction` for the whole of this part.

### 5.2 The post / artefact split

A post is a **community publication event with a lifecycle**. An attachment is a **stored
artefact with bytes, a MIME type and a copyright/takedown posture**. The Bounded Context Map
already separates those two things, and this part preserves the separation rather than
collapsing it.

Concern | Owner | Measured basis
--- | --- | ---
Post identity, author, community scope, lifecycle, visibility | `BC-15` | BC Map L119
Comment, reaction | `BC-15` | Same aggregate root family (§22)
Attachment artefact — notes, media, links | `BC-14` | BC Map L118, verbatim
Byte storage, signed URL, virus scan | `BC-29` | `PRD-017`, reached only via `E-22`
Moderation case over a post | `BC-13` | BC Map L379; `PRD-020` L607
Community identity, roles, membership | `BC-15` | BC Map L119, L200, L212
Person identity behind an author | `BC-10`, referenced upward via `E-13` | BC Map L307, L487

`LCF-FR-018` | A post SHALL reference an attachment only as an opaque `SharedContentRef`
owned by `BC-14`. A post SHALL NOT hold a `FileRef`, a storage key, a bucket name, a signed
URL or any storage-vendor concept.

`LCF-FR-019` | This part SHALL NOT redefine, restate or narrow any A1-owned concept. Where a
behaviour is already specified in A1, A2 SHALL reference the A1 identifier rather than
re-express it.

`LCF-INV-003` | A2 introduces no second definition of community membership, community role,
or grace behaviour. Those remain A1-owned.

### 5.3 Ownership register

Row | Concern | Owning artefact | Owning context | Status in this part
--- | --- | --- | --- | ---
1 | `CommunityPost` aggregate | A2 (this part) | `BC-15` | Specified here
2 | `CommunityComment` | A2 | `BC-15` | Specified here
3 | `CommunityReaction` | A2 | `BC-15` | Specified here
4 | Community membership | A1 | `BC-15` | Referenced only
5 | Community role | A1 | `BC-15` | Referenced only
6 | Membership grace window | A1 (`ADR-0036`) | `BC-02` → A1 | Referenced only, blocked
7 | Attachment artefact | `PRD` for `BC-14` (does not exist yet) | `BC-14` | Referenced only — see `LCF-GAP-004`
8 | Byte storage | `PRD-017` (FROZEN) | `BC-29` | Referenced only, never called directly
9 | Moderation case | `PRD-020` (DRAFT, unranked) | `BC-13` | Referenced only
10 | Abuse report subject types | `PRD-020` L607 | `BC-13` | Referenced only
11 | Feed ranking | A3 (does not exist) | `BC-15` | Referenced only — see `LCF-GAP-005`
12 | Notification delivery | Platform Services | Realtime Engine — **unowned** | Conflict 8
13 | Rate limit counters | `BC-11` (BC Map L377) | `BC-11` | Referenced only
14 | Person identity | `BC-10` | `BC-10` | Referenced upward only via `E-13`
15 | Tenant context | `BC-19`+, ambient via `E-18` | — | ✅ **Conflict 5 RESOLVED** at v0.8 by `ACCEPTED` `ADR-0078`: `BC-15` carries **no** `tenantId`

---

## 6. Community Feed Architecture

The feed is a read surface over `BC-15`-owned post state, composed with three things this
part does not own: attachments (`BC-14`), moderation outcomes (`BC-13`) and ranking (A3).

```
                    ┌─────────────────────────────────────────┐
                    │  Client (Flutter)                       │
                    │  feed list · post detail · composer     │
                    └───────────────┬─────────────────────────┘
                                    │ LCF-API-001..014 (§23)
                    ┌───────────────▼─────────────────────────┐
                    │  A2 — Library Community Feed Content    │
                    │  (capability surface, owns no context)  │
                    └───────────────┬─────────────────────────┘
                                    │
        ┌───────────────────────────┼───────────────────────────┐
        │                           │                           │
┌───────▼──────────┐   ┌────────────▼───────────┐   ┌───────────▼──────────┐
│  BC-15           │   │  BC-14                 │   │  BC-13               │
│  Community &     │   │  Content Sharing       │   │  Trust & Safety      │
│  Groups          │   │                        │   │                      │
│  CommunityPost   │──▶│  SharedContentRef      │   │  ModerationCase      │
│  Comment         │   │  (notes, media, links) │   │  (PRD-020, unranked) │
│  Reaction        │   └────────────┬───────────┘   └───────────┬──────────┘
│  Membership (A1) │                │ E-22                      │ E-14
│  Role (A1)       │                │ (already granted,         │ (already
└───────┬──────────┘                │  BC Map L331)             │  includes
        │                  ┌────────▼───────────┐               │  BC-15,
        │                  │  BC-29             │               │  BC Map
        │                  │  File & Media      │               │  L318)
        │                  │  PRD-017 FROZEN    │               │
        │                  └────────────────────┘               │
        │                                                       │
        │  ⛔ NEW EDGE REQUIRED: BC-15 → BC-14                   │
        │     (LCF-ADR-002 — Architecture Owner)                 │
        │                                                       │
        │                                              ┌────────▼─────────┐
        │                                              │ Local enforcement│
        │  E-13 (upward only, BC Map L307)             │ read model       │
        ▼                                              │ LCF-RM-001..005 │
┌──────────────────┐                                   └──────────────────┘
│  BC-10           │
│  GlobalStudent   │        ⛔ Realtime: no owning context, no edge.
│  Profile         │           Signal is content-free (LCF-INV-013).
└──────────────────┘           LCF-ADR-004 — Architecture Owner.
```

`LCF-FR-020` | The feed SHALL be a read projection over `BC-15`-owned post state. It SHALL
NOT be a system of record. (BC Map L385: "no projection is a system of record".)

`LCF-FR-021` | Every consumer this part introduces SHALL be idempotent, keyed on `eventId`,
per BC Map L447 ("At-least-once. Therefore every consumer must be idempotent").

`LCF-FR-022` | The capability surface SHALL reach `BC-29` only transitively through `BC-14`.
It SHALL NOT hold a direct edge to `BC-29`.

`LCF-FR-023` | Any edge this part requires that is absent from BC Map §7 SHALL be raised as
an ADR requirement and SHALL NOT be assumed. (BC Map L292: "If an edge is not in this table,
it does not exist and adding it requires an ADR".)

---

## 7. The V1 / V2 scope boundary

### 7.1 Authorities

Three Rank 1–4 artefacts place this capability in **V2**, unanimously:

Authority | Line | Text measured
--- | --- | ---
`MASTER_PRD.md` (Rank 1) | L92 | `MP-SCOPE-04 \| Content Sharing (BC-14), Community & Groups (BC-15) \| V2`
`LIBOORA_ENTERPRISE_ARCHITECTURE.md` | L970 | `Community Feed (V2)` — inside the `Community (V2)` block, L967–974
`LIBOORA_BOUNDED_CONTEXT_MAP.md` (Rank 4) | L119, L147 | `BC-15 … V2`; `V2 \| 6 \| BC-07, BC-08, BC-09, BC-14, BC-15, BC-28`

Corroborated from the product side: `PRD-020` L607 (`TSF-FR-027`) states the abuse-report
subject register includes `COMMUNITY_POST` and `COMMUNITY_COMMENT` from V1 but is
"unpopulated until `BC-15` ships" — i.e. Trust & Safety already assumes community content
does not exist in V1. `PRD_REGISTRY.md` L391 records `BC-14, BC-15` as
"V2 \| PLANNED — correctly deferred".

`LCF-FR-024` | This part SHALL be scoped to **V2**. No requirement in it SHALL be presented
as V1-deliverable.

### 7.2 The six design consequences

The version correction is **not a label change**. Four of the six consequences below are
dependencies that only become lawful at V2 — which is the reason earlier drafts of this part
kept colliding with the architecture.

\# | Consequence | Measured basis | Why it is a design change, not a relabel
--- | --- | --- | ---
1 | **Fan-out is available.** The feed may assume a fan-out strategy exists. | EA L1854 `Fan-Out Strategy (V2)` | At V1 no fan-out model exists (EA L86: "Realtime Engine present but with no presence, fan-out or scaling model"). A V1 feed would have had to invent one; a V2 feed may consume one.
2 | **Moderator Console is available.** Post takedown has a human surface. | EA L921 `Moderator Console (V2)` | At V1 there is no console, so §11.3 would have needed an in-part moderation UI — duplicating `BC-13`.
3 | **Attachments are lawful.** Media and text sharing exist. | EA L957–964 `Media & Text Sharing (V2)`, `Images (V2)`, `PDFs (V2)` | At V1 attachments do not exist as a product capability at all, so §10 would have been unimplementable regardless of the edge question.
4 | **Group-shaped sharing exists.** | EA L944–955 `Group Chat (V2)`, `Image Sharing (V2)`, `File Sharing (V2)` | A many-to-many content surface has no V1 sibling; V2 gives it peers with consistent semantics.
5 | **`BC-14` is a contemporary, not a future context.** | BC Map L118 `BC-14 … V2` | Routing attachments through `BC-14` is only coherent if `BC-14` ships in the same band. At V1 it would have been a forward reference.
6 | **The V1 surface stays empty by design.** | `PRD-020` L607 | The V1 abuse-report register is deliberately unpopulated. A V1 feed would have contradicted a Trust & Safety requirement.

`LCF-FR-025` | Any dependency this part takes on a V2 platform capability SHALL be recorded
with its EA line reference, so a V1 reader can see why the dependency is not yet available.

`LCF-FR-026` | This part SHALL NOT require any V3 capability. `Moderation (V3)` and
`Community Analytics (V3)` (EA L972–973) are out of scope (`LCF-XC-006`, `LCF-XC-029`).

⭐ **Two citations repointed at v0.6 under `ACCEPTED` `ADR-0076`.** v0.5 cited `LCF-XC-016`
(rate-limit policy authorship) and `LCF-XC-017` (comments and reactions — which now **ship**),
neither of which excludes a V3 capability. The replacements were **determined, not chosen**:
`LCF-XC-006` is this document's moderation exclusion, and `LCF-XC-029` is the **only**
exclusion row citing EA **L973** `Community Analytics` — one of the two lines this very
requirement names. `LCF-XC-028` was eliminated on **version**: it cites EA **L919**, a
**`(V1)`** node, and a V1 node cannot ground a V3 exclusion. **Two cells changed; the
requirement's meaning is unchanged, and no exclusion row itself was edited.**

### 7.3 The A1 / A2 seam

A1 is the foundation part: community existence, membership, roles, visibility posture. A2 is
the content part: what gets published into a community and how it is read back.

Seam | A1 side | A2 side
--- | --- | ---
Who may read a community | A1 owns the membership predicate | A2 consumes it (`LCF-AUTH-001`)
Who may post | — | A2 owns it (`LCF-AUTH-003`)
Community privacy posture | A1 (`LCM-FR-022` L249 — never public) | A2 inherits; adds no public read path (`LCF-SEC-004`)
Grace window on lapsed membership | A1, blocked on `ADR-0036` q2 | A2 inherits the blocker verbatim (`LCF-DEP-002`, `LCF-AC-034`)
No persisted state at the capability layer | A1 `LCM-INV-001` | A2 restates for its own surface (`LCF-INV-002` names `BC-15` as owner)
Tenant reasoning | A1, on the `E-13` upward-only pattern | A2 defers to A1 (§20, Conflict 5)

`LCF-INV-004` | Where A1 and A2 both touch a concept, A1 is authoritative and A2 SHALL cite
the A1 identifier.

---

## 8. Post Types

The type set is **closed**. Four types, no extension point, because an open type set would
require a vocabulary entry and BC Map L214 records "a CI lint rule … fails the build if a
banned bare term appears".

Type | Meaning | Attachment permitted | Notes
--- | --- | --- | ---
`TEXT` | Body text only | No | The only type with no `BC-14` dependency
`NOTE` | Body text plus one or more shared notes | Yes — `BC-14` note class | BC Map L118 "notes"
`MEDIA` | Body text plus image or document | Yes — `BC-14` media class | Restricted by `FIL-FR-004` to images and documents
`LINK` | Body text plus an external URL | Yes — `BC-14` link class | BC Map L118 "links"

`LCF-FR-027` | The post type set SHALL be exactly `TEXT`, `NOTE`, `MEDIA`, `LINK`. No fifth
type SHALL be added without a PRD amendment.

`LCF-FR-028` | A post's type SHALL be immutable after creation.

`LCF-FR-029` | `MEDIA` posts SHALL accept only the content classes `PRD-017` `FIL-FR-004`
admits — images and documents.

`LCF-FR-030` | Video and audio SHALL be refused, per `FIL-FR-005` L384 ("video/audio SHALL
NOT be accepted in V1"). See `LCF-XC-024`.

`LCF-INV-005` | A `TEXT` post SHALL hold zero attachment references. A non-`TEXT` post SHALL
hold at least one.

---

## 9. Post Creation

`LCF-FR-031` | A member of a community SHALL be able to create a post in that community,
subject to `LCF-AUTH-003`.

`LCF-FR-032` | Post creation SHALL be atomic with respect to its attachment references: a
post SHALL NOT become `PUBLISHED` while any referenced `SharedContentRef` is unresolved.

`LCF-FR-033` | Post creation SHALL record author, community, type, body, attachment
references, and creation timestamp.

`LCF-FR-034` | Post creation SHALL be rate limited. The counter is `BC-11`-owned
(`RateLimitCounter`, BC Map L377); this part SHALL NOT introduce a second counter (§21).

⛔ **Self-blocking clause (added at v0.8 — Stage 3 Check 2).** BC Map **L292** provides: *"If an
edge is not in this table, it does not exist and adding it requires an ADR."* No BC Map §7 row
sources `BC-15`, so the `BC-15 → BC-11` edge this requirement consumes **does not yet exist**.
**Until an `ACCEPTED` ADR registers that edge, post creation SHALL be treated as blocked**, in the
same shape `LCF-FR-043` already uses for `LCF-ADR-002`. This clause invents no rule: it states the
consequence BC Map L292 already imposes. Decision owner: ⛔ **Architecture Owner** — the edge is
raised as `LCF-ADR-007` (§31), and registering it is that owner's act, not this part's.

`LCF-FR-035` | Post creation SHALL be refused when the author's membership is not in an
entitled state, per the A1 predicate. A2 SHALL NOT define its own entitlement states.

`LCF-FR-036` | A refused creation SHALL be indistinguishable, to the caller, between "not a
member", "membership lapsed" and "community does not exist" — per `LCF-SEC-006`.

`LCF-BR-001` | Body text is mandatory for every type, including attachment-bearing types. An
attachment SHALL NOT stand alone without a body.

`LCF-BR-002` | Body length bounds are a configuration concern. This part SHALL NOT mint a
`LCF-CFG-*` identifier and SHALL NOT copy a numeric bound from any unranked source.
`CONFIGURATION_GUIDE.md` L863 records that adding a parameter is a PRD amendment. See
`LCF-GAP-006`.

`LCF-BR-003` | Attachment count bounds are likewise deferred to configuration
(`LCF-GAP-006`).

---

## 10. Content and Attachments

### 10.1 The rule

`LCF-FR-037` | An attachment SHALL be created and owned by `BC-14` Content Sharing, and
referenced from the post as an opaque `SharedContentRef`.

`LCF-FR-038` | This part SHALL NOT hold, transport, log or render a `FileRef`, storage key,
bucket identifier or signed URL.

`LCF-FR-039` | The caller that reaches `BC-29` SHALL be `BC-14`. `PRD-017` `FIL-FR-006`
(L405–408) admits a caller only "where the caller's bounded context appears in `E-22`'s
consumer list"; BC Map L331 lists `BC-01, BC-10, BC-12, BC-14`. `BC-14` is listed, so this
route satisfies `FIL-FR-006` **by construction**.

`LCF-FR-040` | This part SHALL NOT widen `E-22`. `FIL-FR-007` (L410–412) forbids widening and
forbids treating a port grant in `tool/module_dependencies.yaml` as authorising an edge the
BC Map does not record.

`LCF-FR-041` | This part SHALL NOT rely on `domain/social`'s file port grant
(`module_dependencies.yaml` L242). `PRD-017` L414–418 records that "`domain/social`'s
declared file access is currently unusable" and files it as `FIL-GAP-003`, owned by the
Architecture Owner.

`LCF-FR-042` | Attachment lifecycle — upload, scan, takedown, copyright — SHALL remain
`BC-14`/`BC-29` behaviour. This part SHALL NOT specify it. See `LCF-XC-011`.

`LCF-INV-006` | No `LCF-*` requirement in this part places a bounded context other than
`BC-14` on the `BC-29` call path.

### 10.2 The one unresolved edge

BC Map §7 does not record a `BC-15 → BC-14` edge. BC Map L292 is explicit: "If an edge is not
in this table, it does not exist and adding it requires an ADR."

Therefore attachments require **exactly one new edge row**:

Property | Value
--- | ---
From | `BC-15` Community & Groups
To | `BC-14` Content Sharing
Style | Reference (opaque `SharedContentRef`), not shared state
Direction | One-way. `BC-14` SHALL NOT read post state.
`E-22` impact | **None.** `E-22`'s consumer list is untouched.
`PRD-017` impact | **None.** `PRD-017` is FROZEN and stays byte-unchanged.
Decision owner | ⛔ **Architecture Owner** — `LCF-ADR-002`

`LCF-FR-043` | Until `LCF-ADR-002` is accepted, `NOTE`, `MEDIA` and `LINK` posts SHALL be
treated as blocked. `TEXT` posts are unaffected.

### 10.3 The `ADR-0055` necessity test

`ADR-0055` is the closest precedent and is applied here as a test rather than as an argument
from analogy. It admitted `BC-12` to `E-22` and refused `BC-11`, with the refusal reasoned at
L113: `BC-11` "never holds a `FileRef`, never renders an attachment, never needs a signed
URL".

Applying that same test to this part:

Question | Answer for the community capability
--- | ---
Does it ever hold a `FileRef`? | **No** — `LCF-FR-038` forbids it.
Does it ever render an attachment? | **No** — rendering is `BC-14`'s surface.
Does it ever need a signed URL? | **No** — it holds a `SharedContentRef`.

All three answers match `ADR-0055`'s **refusal** profile, not its admission profile. That is
the affirmative reason `E-22` is left alone: by `ADR-0055`'s own criteria this capability
should *not* be an `E-22` consumer. The `BC-14` route is therefore not a workaround — it is
the route the existing ruling implies.

`LCF-INV-007` | The necessity test above SHALL be re-run, and its outcome recorded, if any
future revision proposes giving this capability direct storage access.

---

## 11. Post Lifecycle

### 11.1 The closed state set

Four states. The set is closed for the same reason the type set is (§8): an open lifecycle
would need vocabulary registration under BC Map L214.

State | Meaning | Visible in feed | Reachable from
--- | --- | --- | ---
`DRAFT` | Created, attachments not yet resolved | No | — (initial)
`PUBLISHED` | Visible to entitled community members | Yes | `DRAFT`
`DELETED` | Withdrawn by the author | No | `PUBLISHED`
`REMOVED` | Withdrawn by moderation action | No | `PUBLISHED`

`LCF-FR-044` | The post state set SHALL be exactly `DRAFT`, `PUBLISHED`, `DELETED`,
`REMOVED`.

`LCF-FR-045` | Transitions SHALL be exactly `DRAFT → PUBLISHED`, `PUBLISHED → DELETED`,
`PUBLISHED → REMOVED`. No other transition SHALL exist.

`LCF-FR-046` | `DELETED` and `REMOVED` SHALL be terminal. A post SHALL NOT be restored to
`PUBLISHED`.

`LCF-FR-047` | `DELETED` and `REMOVED` SHALL be distinct states and SHALL NOT be collapsed
into one, because the actor differs and `BC-13` needs the distinction for enforcement
accounting.

`LCF-INV-008` | A post in `DRAFT`, `DELETED` or `REMOVED` SHALL never appear in any feed
response, any search result, any count, or any notification payload.

`LCF-BR-004` | Deletion SHALL be a state transition, not a physical erase, so that a
`BC-13` moderation case opened over the post remains resolvable.

### 11.2 Author deletion

`LCF-FR-048` | The author of a `PUBLISHED` post SHALL be able to transition it to `DELETED`.

`LCF-FR-049` | Deleting a post SHALL cascade to its comments and reactions such that none of
them remain retrievable.

`LCF-FR-050` | Deleting a post SHALL NOT delete the referenced `SharedContentRef`. Attachment
lifecycle is `BC-14`-owned (`LCF-FR-042`); the post SHALL emit the removal-of-reference
signal only.

`LCF-INV-009` | A `DELETED` post's body SHALL not be retrievable through any API in §23.

### 11.3 Moderation integration

`BC-13` owns `ModerationCase` (BC Map L379) and `PRD-020` L610 (`TSF-XC-031`) forbids Trust &
Safety from specifying "community roles, membership or post lifecycle". So the split is:
`BC-13` decides, `BC-15` applies.

The mechanism reuses the pattern already implemented for messaging enforcement — a local,
rebuildable read model over `BC-13` events, with a fail-closed staleness gate. That pattern
exists in the repository at `lib/domain/social/messaging/enforcement_projection.dart` and is
referenced here as prior art, not copied.

`LCF-FR-051` | This part SHALL consume `safety.EnforcementActionTaken` over `E-14`. BC Map
L433 already routes that event to `BC-15`, and L318 already lists `BC-15` as an `E-14`
consumer, so **no new edge is required for moderation**.

`LCF-RM-001` | A local enforcement read model SHALL be maintained from `E-14` events. It
SHALL be a projection, never hand-edited (BC Map L383) and never a system of record
(BC Map L385).

`LCF-RM-002` | The read model SHALL be rebuildable from the event stream without loss.

`LCF-RM-003` | The read model SHALL expose its lag as an observable measure.

`LCF-RM-004` | When lag exceeds the staleness ceiling, the gate SHALL **fail closed** —
posting and reading SHALL be refused rather than served from stale enforcement state.

`LCF-RM-005` | The staleness ceiling SHALL NOT be defined in this part. `PRD-020` L1683
(`TSF-CFG-030`) records 5 s p99 with a 30 s hard ceiling, but `PRD-020` is **DRAFT v0.1,
Stage 2, unranked** and states that it "confers no status on itself". Copying a numeric from
an unranked source would launder it into a ratified one. See `LCF-GAP-007`.

`LCF-FR-052` | A post transitioned to `REMOVED` by enforcement SHALL disappear from every
read surface without revealing that enforcement occurred (`LCF-SEC-007`).

`LCF-FR-053` | Reporting a post SHALL route to `BC-13` using the subject types `PRD-020` L607
already reserves — `COMMUNITY_POST` and `COMMUNITY_COMMENT`. This part SHALL NOT define new
subject types.

`LCF-INV-010` | Every `E-14` consumer introduced here SHALL be idempotent keyed on `eventId`
(BC Map L447).

---

## 12. Visibility and Authorization

### 12.1 The authorization model

Deny by default. `07-Roles-Permissions-and-Access-Policies.md` L51 (`AP-3`) establishes
deny-by-default; `XC-7.2` establishes that a deny defeats an allow.

`LCF-AUTH-001` | Reading a community feed SHALL require the caller to satisfy the A1
membership predicate for that community. A2 SHALL NOT define its own predicate.

`LCF-AUTH-002` | Reading a post detail SHALL require the same predicate as reading the feed
it belongs to. There SHALL be no deep-link path that bypasses the feed predicate.

`LCF-AUTH-003` | Creating a post SHALL require entitled membership plus a community role that
permits publication. Roles are A1/`BC-15`-owned (BC Map L212 `CommunityRole`).

`LCF-AUTH-004` | Editing a post SHALL require the caller to be its author.

`LCF-AUTH-005` | Deleting a post SHALL require the caller to be its author, or an enforcement
action from `BC-13`.

`LCF-AUTH-006` | Commenting SHALL require the same predicate as reading, plus a role that
permits commenting.

`LCF-AUTH-007` | Reacting SHALL require the same predicate as reading.

`LCF-AUTH-008` | This part SHALL NOT mint a permission identifier. `AUTH-7.22` (L122) closes
the permission catalogue, and `ADR-0036` §7.1 records **zero** `PERM-*` identifiers repo-wide.
See `LCF-GAP-008`.

`LCF-AUTH-009` | This part SHALL NOT introduce a new tenant role. `TR-1`…`TR-5`
(`07-Roles…` L87) is closed.

`LCF-AUTH-010` | Authorization SHALL be evaluated on every request. A cached authorization
decision SHALL NOT outlive the request. `LCFG-13` never applies to an authorization decision
(`CONFIGURATION_GUIDE.md`).

`LCF-AUTH-011` | Authorization SHALL be applied in addition to authentication, per
`14B-Public-Library-Preview.md` L231 ("authorisation … in addition to authentication").

`LCF-AUTH-012` | A block relationship SHALL suppress content bidirectionally. `BlockList` is
`BC-11`-owned (BC Map L377); this part consumes it and SHALL NOT hold its own block state.

⛔ **Self-blocking clause (added at v0.8 — Stage 3 Check 2).** This requirement consumes a
`BC-11`-owned aggregate across a `BC-15 → BC-11` edge that BC Map §7 does not record (**L292**).
**Until an `ACCEPTED` ADR registers that edge, community content SHALL be treated as blocked
rather than served unfiltered.** ⭐ The fail-closed direction is deliberate and is **not** a product
choice: serving content while block enforcement is unreachable would be the unsafe reading, and
`LCF-FR-043` already establishes *treated as blocked* as this part's standing form for an
unregistered edge. Decision owner: ⛔ **Architecture Owner** — `LCF-ADR-007` (§31).

### 12.2 Membership and grace inheritance

`LCF-FR-054` | Where membership entitlement depends on the renewal grace window, this part
SHALL inherit A1's behaviour without restatement.

`LCF-FR-055` | The grace window's **first-day** behaviour is undetermined. `ADR-0036` answers
q1 (3 calendar days mandatory in V1) and q3 (FIXED), but **q2 remains UNANSWERED** and is
owned by the **Product Owner**. A1 records this as `LCM-GAP-001` (L755) / `LCM-RSK-001`
(L695) / `LCM-DEC-001` (L1436). A2 inherits it as `LCF-DEP-002`.

`LCF-FR-056` | A1 L1096 records that there is **no session-scoped grace**. A2 SHALL NOT
introduce one.

`LCF-INV-011` | A2 contains no independent definition of the grace window, its length, or its
boundary behaviour.

---

## 13. Feed Retrieval

`LCF-FR-057` | A caller SHALL be able to retrieve the feed of a single community they are
entitled to read.

`LCF-FR-058` | The feed SHALL contain only `PUBLISHED` posts (`LCF-INV-008`).

`LCF-FR-059` | The feed SHALL exclude posts authored by, or visible to, a party in a block
relationship with the caller (`LCF-AUTH-012`).

`LCF-FR-060` | The feed SHALL exclude posts suppressed by the local enforcement read model
(`LCF-RM-001`).

`LCF-FR-061` | The feed response SHALL carry, per post: identity, type, author reference,
body, attachment references, creation timestamp, edit marker, comment count, reaction
summary.

`LCF-FR-062` | The feed response SHALL NOT carry any storage-level attachment detail
(`LCF-FR-038`).

`LCF-FR-063` | The feed response SHALL NOT carry the author's `StudentRecordId` or any
tenant-scoped identifier. Author identity SHALL be a `PersonId`-level reference obtained
upward via `E-13` (BC Map L307, "Reference direction is upward only").

`LCF-FR-064` | A feed request against a community the caller cannot read SHALL be
indistinguishable from one against a community that does not exist (`LCF-SEC-006`).

`LCF-BR-005` | The default feed order SHALL be reverse-chronological until A3 supplies a
ranking (§16).

---

## 14. Pagination

### 14.1 The measured finding

`grep -rniE 'cursor' docs/10-architecture/*.md` returns **zero results**. There is no
repository-wide pagination convention — no cursor format, no opacity rule, no stability
guarantee, no page-size register.

This part therefore states a **contract** and refuses to invent the **convention**. A
convention invented inside one PRD becomes a de facto standard nobody ratified.

### 14.2 The minimum contract

`LCF-FR-065` | Feed retrieval SHALL be paginated. An unbounded feed response SHALL NOT exist.

`LCF-FR-066` | The pagination token SHALL be opaque to the client. A client SHALL NOT
construct, parse, decompose or arithmetically manipulate it.

`LCF-FR-067` | The pagination token SHALL NOT encode a `tenantId`, a `StudentRecordId`, or
any identifier the caller is not otherwise entitled to see.

`LCF-BR-006` | Pagination SHALL be stable with respect to insertion: a post created during
paging SHALL NOT cause a previously returned post to be returned again.

`LCF-BR-007` | Pagination SHALL be stable with respect to deletion: a post deleted during
paging SHALL NOT cause an unread post to be skipped.

`LCF-BR-008` | A page size SHALL be bounded server-side. The bound is a configuration
concern and SHALL NOT be minted here (`LCF-GAP-006`).

`LCF-INV-012` | No pagination token issued by this part is meaningful to, or portable across,
another tenant or another caller.

⛔ The **format and repository-wide convention** are an Architecture Owner decision —
`LCF-ADR-003` / `LCF-DEC-005`. This part SHALL NOT select one.

---

## 15. Filtering and Search

`LCF-FR-068` | The feed SHALL support filtering by post type (§8).

`LCF-FR-069` | The feed SHALL support filtering by author, expressed as a `PersonId`-level
reference.

`LCF-FR-070` | Search over post bodies SHALL be scoped to a single community the caller is
entitled to read. A cross-community search SHALL NOT exist in this part.

`LCF-FR-071` | Search SHALL NOT return `DRAFT`, `DELETED` or `REMOVED` posts
(`LCF-INV-008`).

`LCF-FR-072` | Search indices SHALL be tenant-partitioned. BC Map L490 records that
"Indices, caches, projections, prompts, embeddings and files are all tenant-partitioned" and
that isolation is "asserted per query, not by convention".

`LCF-FR-073` | The community search index SHALL belong to the tenant-partitioned index class,
not the global class. BC Map §11.1 L494 (`AR-3`) records the two classes as "categorically
different".

`LCF-BR-009` | Search relevance ordering is not a ranking decision (§16); it SHALL NOT be
used to smuggle a ranking model into this part.

Cross-library search, global content discovery and semantic/vector search over community
content are out of scope for this part — `LCF-XC-025` (§4).

---

## 16. Ranking Integration with A3

A3 does not exist. `grep -rl "Part A3" docs/` returns **0 files**. This part therefore
specifies the *seam*, not the algorithm.

`LCF-FR-074` | Feed ordering SHALL be pluggable: the retrieval surface SHALL accept an
ordering supplied by A3 without a contract change.

`LCF-FR-075` | Until A3 exists, ordering SHALL be reverse-chronological (`LCF-BR-005`).

`LCF-FR-076` | This part SHALL NOT define a ranking signal, weight, decay function or
engagement metric. Those are A3-owned (`LCF-XC-021`).

`LCF-FR-077` | Ranking SHALL NOT be able to surface a post the authorization layer would
refuse. Ordering operates strictly inside the authorized set.

`LCF-FR-078` | An ordering supplied by A3 SHALL NOT alter the membership of the result set —
only its sequence.

Ranking-seam note — A3 does not exist on disk, so the ranking seam is specified but
untestable until it does (`LCF-GAP-005`, defined in §33.2).

---

## 17. Post Detail

`LCF-FR-079` | A caller SHALL be able to retrieve a single post by identity, subject to
`LCF-AUTH-002`.

`LCF-FR-080` | Post detail SHALL carry the post, its comments, and its reaction summary.

`LCF-FR-081` | Comments SHALL be paginated under the same contract as §14.

`LCF-FR-082` | A comment SHALL be single-level. Threaded replies are out of scope
(`LCF-XC-026`).

`LCF-FR-083` | A reaction SHALL be at most one per caller per post. A second reaction
replaces the first.

`LCF-FR-084` | The reaction summary SHALL be an aggregate count per reaction kind. It SHALL
NOT enumerate reacting members, because a member list is directory-shaped data
(`LCF-SEC-011`).

`LCF-BR-010` | The reaction kind set SHALL be closed and SHALL be defined in this part's data
model (§22). It SHALL NOT be client-extensible.

`LCF-BR-010a` | The reaction kind set SHALL be exactly `LIKE`, `HELPFUL`, `CELEBRATE`. A
fourth kind SHALL NOT be added without a PRD amendment, and no kind SHALL be removed while a
dependent part references it.

✅ **`LCF-BR-010` is SATISFIED at v0.6.** §22 now enumerates the closed set, so the field is
*declared* closed **and** *defined* here, which is what `LCF-BR-010` required. The enumeration
is an explicit **Product Owner** act recorded in
`PRD-021A_LCF-GAP-012_DECISION_RECORD.md` **v2.0 §7.2** — **`LCF-GAP-014` is RESOLVED.**
Individual kinds may now be referenced by this and by dependent parts; A3 `LCR-RS-003`
designates **`HELPFUL`** as its helpfulness signal on that authority.

⭐ `LCF-BR-010a` mirrors the closure model `LCF-FR-027` already uses for the post type set
(*"exactly `TEXT`, `NOTE`, `MEDIA`, `LINK`. No fifth type SHALL be added without a PRD
amendment"*). The pattern is **reused, not invented**. ⚠ `LIKE` and `CELEBRATE` carry **no**
ranking meaning: `LCF-FR-084`'s reaction summary aggregates all three, and only `HELPFUL`
is designated to a ranking signal.

`LCF-INV-014` | Retrieving a post by identity SHALL apply exactly the same authorization
predicate as retrieving it through the feed. No API in §23 SHALL offer a weaker path.

---

## 18. Edit and Delete

`LCF-FR-085` | The author of a `PUBLISHED` post SHALL be able to edit its body.

`LCF-FR-086` | Editing SHALL NOT change the post's type (`LCF-FR-028`), its community, or its
author.

`LCF-BR-011` | An edited post SHALL carry a visible edit marker. Edit history is out of scope
(`LCF-XC-027`).

`LCF-BR-012` | Editing SHALL re-run the same rate limit and enforcement gates as creation. An
edit SHALL NOT be a path around a posting restriction.

`LCF-BR-013` | A post in `DELETED` or `REMOVED` SHALL NOT be editable (`LCF-FR-046`).

`LCF-INV-015` | An edit SHALL NOT resurrect an attachment reference that `BC-14` has taken
down.

---

## 19. Realtime Integration

### 19.1 The measured position

Property | Measurement
--- | ---
Does any bounded context own the Realtime Engine? | **No.** No BC Map row assigns it.
Does any BC Map edge carry realtime delivery? | **No.** BC Map §7 has no realtime row.
What does the EA say exists? | `Realtime Engine (V1)` EA L1847; `Connection Management (V1)` L1852
What does the EA say is missing? | `Presence Service (V2)` L1853; **`Fan-Out Strategy (V2)` L1854**; `Realtime Scaling & Backpressure (V3)` L1855
Does the EA acknowledge the gap? | **Yes** — L86: "Realtime Engine present but with no presence, fan-out or scaling model"

So a new-post notification has a *capability* to ride on (V2 fan-out) but **no owning context
and no edge**. This part therefore specifies the signal in a way that is safe under any
future transport choice.

### 19.2 Requirements

`LCF-INV-013` | Any realtime signal this part emits SHALL be **content-free**: it SHALL carry
no post body, no attachment reference, no author identity and no community name. It SHALL
carry only enough to prompt an authorized re-fetch.

`LCF-FR-087` | The client SHALL obtain post content only through the authorized read APIs of
§23. A realtime signal SHALL NOT be a content delivery channel.

`LCF-FR-088` | A realtime signal SHALL NOT be delivered to a caller who would be refused the
corresponding read. Delivery is not an authorization bypass.

`LCF-FR-089` | Loss of a realtime signal SHALL degrade the experience only. The feed SHALL
remain correct on the next authorized read (`LCF-NFR-009`).

`LCF-FR-090` | This part SHALL NOT specify the transport, the fan-out topology, the
subscription model, or the backpressure policy.

⛔ Owner, edge and fan-out model are an Architecture Owner decision — `LCF-ADR-004` /
`LCF-DEC-006`. This part SHALL NOT select one.

---

## 20. Multi-Tenant Isolation

### 20.1 The `ID-2` conflict

This is the deepest conflict in this part, and it is **pre-existing** — surfaced by A2, not
created by it.

A library community is, by A1's construction, private to one library. Library-private data is
tenant-scoped, and BC Map L486 requires row-level security such that "a query without tenant
predicate must fail at runtime".

But `CommunityPost` is owned by `BC-15` (§5.1), and BC Map L488 places `BC-15` inside the
Global band:

> `BC-11→17 Student Network | Global. No tenantId. Keyed on PersonId. | Must never receive a
> StudentRecordId or tenantId (rule ID-2). Consumers of BC-10, never owners (ADR-0011)`

So the register that assigns the aggregate simultaneously forbids that aggregate from holding
the discriminator a library-private community requires. `X-05`
(`LIBOORA_MODULE_DEPENDENCY_MATRIX.md` L354) reinforces the separation: the link is "the
`PersonId` link via ACL (`E-13`) only", and `tool/module_dependencies.yaml` bans
`domain/library/**` imports from `domain/social`.

### 20.2 The three options

Option | Shape | Cost | Assessment
--- | --- | --- | ---
⭐ **1 — Opaque `communityId`** | `BC-15` holds a `communityId` and no `tenantId`. Tenant reasoning stays in A1, on the existing `E-13` upward-only ACL pattern (BC Map L307). | No BC Map tenancy amendment. No new identifier class. | **Proposed.** It keeps `ID-2` literally satisfied. ⚠ **Honest objection against my own proposal:** a `communityId` that maps 1:1 to a library may simply be a `tenantId` wearing a different name. If that is judged to be `ID-2` evasion rather than compliance, Option 1 fails and Option 2 or 3 is required. I do not decide this.
2 — Admit a tenant discriminator to `BC-15` | Amend BC Map L488 to carve `BC-15` out of the Global band. | Rank 4 amendment; weakens a rule that currently has zero exceptions. | Not proposed. Recorded for completeness.
3 — Move the aggregate to a tenant-scoped context | Reassign `CommunityPost` to a `BC-01`–`BC-09` context. | Contradicts BC Map L119, which gives community ownership to `BC-15`. | Not proposed. Recorded for completeness.

`LCF-FR-091` | `CommunityPost` SHALL NOT hold a `StudentRecordId`. (BC Map L488, rule `ID-2`.)

`LCF-FR-092` | This part SHALL NOT amend BC Map L488, the tenancy table, or rule `ID-2`.

`LCF-FR-093` | Until the conflict is resolved, community scope SHALL be expressed as an
opaque `communityId` and tenant reasoning SHALL remain in A1.

⛔ Architecture Owner decision — `LCF-ADR-005` / `LCF-DEC-003`.

### 20.3 The event-level corollary

BC Map L450 states: "`tenantId` is mandatory on every domain event. A consumer that processes
an event without establishing tenant context must fail loudly, not default."

BC Map L488 states that `BC-11`→`BC-17` must **never** receive a `tenantId`.

A `BC-15` domain event cannot satisfy both. This is not specific to community posts — it
arises for any event emitted by any context in the Global band, so it is **pre-existing**.

`LCF-FR-094` | This part SHALL NOT resolve the L450 / L488 contradiction and SHALL NOT choose
a default. Events in §24 are specified with their payload shape but with the tenant field
marked **UNRESOLVED**.

⛔ Architecture Owner decision — `LCF-ADR-006` / `LCF-DEC-003a`.

### 20.4 Isolation requirements

`LCF-SEC-001` | A post SHALL be readable only within the community that owns it.

`LCF-SEC-002` | No API in §23 SHALL return a post from a community the caller is not entitled
to read.

`LCF-SEC-003` | Cross-community leakage SHALL be asserted by test, not assumed by convention
(BC Map L490: "asserted per query, not by convention").

`LCF-SEC-004` | There SHALL be no unauthenticated read path to any community post.
`14A-Library-Discovery-And-Enrollment.md` §14A.5 (L134–172) lists what may be public and then
lists what "shall never be publicly accessible", whose first two entries are `Student
Information` and `Member Directory`. Community content is neither in the public list nor
separable from member identity.

`LCF-SEC-005` | The public library profile surface (`PRD` 14A/14B) SHALL remain entirely
separate from the private community surface. No field defined in this part SHALL appear on a
public profile.

`LCF-SEC-006` | "Not entitled" and "does not exist" SHALL be indistinguishable in every
response.

`LCF-SEC-007` | "Removed by enforcement", "deleted by author" and "never existed" SHALL be
indistinguishable to a non-author caller.

`LCF-SEC-008` | An attachment reference SHALL NOT be resolvable by a caller who cannot read
the post that carries it. The `BC-14` route SHALL NOT become an authorization bypass.

`LCF-SEC-009` | A pagination token SHALL NOT widen access (`LCF-FR-067`).

`LCF-SEC-010` | Search SHALL NOT leak the existence of a post outside the caller's entitled
set.

`LCF-SEC-011` | Reaction and comment surfaces SHALL NOT enumerate members. Member Directory
is tenant-private "in any form" (`14B` L173) and defaults to Disabled (`LCFG-5`,
`CONFIGURATION_GUIDE.md` L355).

`LCF-SEC-012` | Author references SHALL be `PersonId`-level only (`LCF-FR-063`).

`LCF-SEC-013` | Minor-safety posture SHALL be inherited, not restated. `SM-INV-3`
(`Student_Management_PRD_v1.md` L314) treats `Unknown` age as minor; this part introduces no
weaker default.

`LCF-SEC-014` | Logs, traces and error messages SHALL NOT contain post bodies, attachment
references or `StudentRecordId` values.

`LCF-SEC-015` | Analytics SHALL receive aggregates only, never post content (§26).

`LCF-SEC-016` | Any cache or index this part relies on SHALL be tenant-partitioned
(BC Map L490).

---

### 20.5 ⚠ The residual `ADR-0078` does not reach (recorded at v0.8)

§20.2 raised an honest objection against its own preferred Option 1: a `communityId` that maps
one-to-one onto a library *may simply be a `tenantId` wearing a different name*. `ACCEPTED`
`ADR-0078` determines the **field** question — `BC-15` carries no `tenantId` — and v0.8 records
that determination in §31 and §34.

⛔ **It does not rule on the semantic objection.** Measured against the ADR's text:

Token searched in `ADR-0078` | Occurrences
--- | ---
`communityId` | **0**
`Option 1` | **0**
`evasion` | **0**
`1:1` | **0**
`wearing` | **0**

⇒ The objection **survives** the closure of Conflicts 5 and 6. v0.8 **discloses** it and assigns it
to no one: nothing in the repository allocates it, and this part mints no identifier for it. It is
recorded here so that a later reader does not mistake `LCF-ADR-005`'s closure for a ruling that the
`communityId` model is semantically sound. `LCF-SEC-001`…`005` are unaffected — they constrain
readability, not identifier semantics.

---

## 21. Rate Limiting Integration

`LCF-FR-095` | Post creation, commenting, reacting and editing SHALL all be rate limited.

`LCF-FR-096` | The counter SHALL be the `BC-11`-owned `RateLimitCounter` (BC Map §8 L377).
This part SHALL NOT introduce a second counter aggregate.

⛔ **Self-blocking clause (added at v0.8 — Stage 3 Check 2).** The `BC-15 → BC-11` edge required to
read that counter is **not** recorded in BC Map §7 (**L292**). **Until an `ACCEPTED` ADR registers
the edge, the rate-limited operations named in `LCF-FR-095` — post creation, commenting, reacting
and editing — SHALL be treated as blocked.** No second counter is introduced, and no threshold,
window or quota value is stated here: those remain unspecified (`LCF-GAP-006`). Decision owner:
⛔ **Architecture Owner** — `LCF-ADR-007` (§31).

`LCF-FR-097` | This part SHALL NOT specify limit values. They are configuration
(`LCF-GAP-006`) and this part mints no `LCF-CFG-*`.

`LCF-FR-098` | A rate-limit refusal SHALL be distinguishable from an authorization refusal to
the caller, because the remedy differs — but SHALL NOT reveal the limit value.

`LCF-INV-016` | Rate limiting SHALL NOT be used as a substitute for authorization. A refusal
under `LCF-AUTH-*` SHALL be evaluated first.

Anti-spam heuristics, reputation scoring and abuse detection are `BC-13`-owned
(EA L919 `Anti-Spam & Rate Limits (V1)`) and out of scope here — `LCF-XC-028` (§4).

---

## 22. Data Model and Aggregate Ownership

All three aggregates below are `BC-15`-owned (`LCF-FR-016`). BC Map §8 (L370–386) is the
aggregate registry, and **neither `BC-14` nor `BC-15` currently has a row in it**.

`CommunityPost` — aggregate root

Field | Shape | Notes
--- | --- | ---
`postId` | Opaque identity | Not derivable from any tenant identifier
`communityId` | Opaque reference | §20.2 Option 1. **Not** a `tenantId`.
`authorRef` | `PersonId`-level reference | Upward only via `E-13` (BC Map L307)
`type` | One of `TEXT`, `NOTE`, `MEDIA`, `LINK` | Closed (§8), immutable
`body` | Text | Mandatory (`LCF-BR-001`); bounds deferred (`LCF-GAP-006`)
`attachmentRefs` | Zero or more `SharedContentRef` | `BC-14`-owned; opaque (`LCF-FR-018`)
`state` | One of `DRAFT`, `PUBLISHED`, `DELETED`, `REMOVED` | Closed (§11.1)
`createdAt` | Timestamp | —
`editedAt` | Timestamp or absent | Drives the edit marker (`LCF-BR-011`)
`tenantField` | ✅ **RESOLVED at v0.8 — the field is ABSENT** | Conflicts 5 and 6 are CLOSED by `ACCEPTED` `ADR-0078`: `BC-15` events carry **no** `tenantId` (§2.1 **L58**, **L63**). This is a determination that the field does **not** exist, not a specification of its shape.

`CommunityComment` — child of `CommunityPost`

Field | Shape | Notes
--- | --- | ---
`commentId` | Opaque identity | —
`postId` | Reference to parent | Single-level only (`LCF-FR-082`)
`authorRef` | `PersonId`-level reference | —
`body` | Text | Bounds deferred (`LCF-GAP-006`)
`state` | `PUBLISHED`, `DELETED`, `REMOVED` | No `DRAFT` — comments have no attachment resolution step
`createdAt` | Timestamp | —

`CommunityReaction` — child of `CommunityPost`

Field | Shape | Notes
--- | --- | ---
`postId` | Reference to parent | —
`actorRef` | `PersonId`-level reference | At most one per actor per post (`LCF-FR-083`)
`kind` | Closed set — exactly `LIKE`, `HELPFUL`, `CELEBRATE` | `LCF-BR-010` ✅ **satisfied at v0.6**; `LCF-BR-010a` states the closure rule. Not client-extensible. Enumerated by explicit **Product Owner** decision (`PRD-021A_LCF-GAP-012_DECISION_RECORD.md` **v2.0 §7.2**), which RESOLVES **`LCF-GAP-014`**. ⭐ `HELPFUL` is the kind A3 `LCR-RS-003` designates as its helpfulness signal; `LIKE` and `CELEBRATE` carry no ranking meaning
`createdAt` | Timestamp | —

`LCF-FR-099` | These three aggregates SHALL be registered in BC Map §8 under `BC-15`. That
registration is a Rank 4 amendment and is **not performed by this part**.

`LCF-FR-100` | BC Map §8 currently has **no row** for `BC-14` or for `BC-15`. Adding the
`BC-15` row, and extending L119, is an Architecture Owner action — `LCF-ADR-001`.

Aggregate-registration note — until `BC-15` has a §8 row, these aggregates are specified
but unregistered (`LCF-GAP-009`, defined in §33.2).

---

## 23. API Contracts

Fourteen contracts. Five are declared **NOT PROVIDED** — deliberately, because providing them
would require inventing a convention or crossing an unratified edge.

ID | Operation | Provided | Basis / reason
--- | --- | --- | ---
`LCF-API-001` | Create `TEXT` post | ✅ Yes | No `BC-14` dependency
`LCF-API-002` | Create `NOTE` / `MEDIA` / `LINK` post | ⛔ **NOT PROVIDED** | Requires the `BC-15 → BC-14` edge (`LCF-ADR-002`). `LCF-FR-043` blocks it.
`LCF-API-003` | Retrieve community feed | ✅ Yes | Ordering reverse-chronological (`LCF-BR-005`)
`LCF-API-004` | Retrieve next feed page | ⛔ **NOT PROVIDED** | Token format is unratified (`LCF-ADR-003`). The *contract* is stated in §14; the wire shape is not.
`LCF-API-005` | Retrieve post detail | ✅ Yes | `LCF-AUTH-002`, `LCF-INV-014`
`LCF-API-006` | Edit post body | ✅ Yes | `LCF-FR-085`
`LCF-API-007` | Delete own post | ✅ Yes | `LCF-FR-048`
`LCF-API-008` | Create comment | ✅ Yes | `LCF-AUTH-006`
`LCF-API-009` | Delete own comment | ✅ Yes | Same predicate as post deletion
`LCF-API-010` | Set / replace reaction | ✅ Yes | `LCF-FR-083`
`LCF-API-011` | Retrieve reaction summary | ✅ Yes | Aggregate counts only (`LCF-FR-084`)
`LCF-API-012` | Report post or comment | ✅ Yes | Routes to `BC-13` over `E-14`; subject types already reserved by `PRD-020` L607
`LCF-API-013` | Search within community | ⛔ **STILL NOT PROVIDED at v0.8** | ⚠ Conflict 5 is now CLOSED (`ADR-0078`), **but this API is not thereby unblocked.** It also depends on the index class `AR-3`, which remains **unspecified**. `ADR-0078` §5.2 confers no readiness and does not specify an index class. One of two blockers cleared; the API stays NOT PROVIDED.
`LCF-API-014` | Subscribe to feed updates | ⛔ **NOT PROVIDED** | No realtime owner, no edge (`LCF-ADR-004`)

⛔ A fifth non-provision: **no API in this part exposes a tenant discriminator**, because
Conflict 5 / Conflict 6 leave the `tenantField` UNRESOLVED (§22).

`LCF-FR-101` | Every provided API SHALL apply the §12 authorization predicate before any
other processing.

`LCF-FR-102` | Every provided API SHALL be tenant-safe under whichever resolution Conflict 5
receives. No API SHALL be designed such that only one resolution can satisfy it.

`LCF-FR-103` | A NOT PROVIDED contract SHALL NOT be partially implemented. Shipping a
placeholder would create the de facto convention this part refuses to invent.

---

## 24. Events

Six events. All are `BC-15`-emitted. Every payload carries an `eventId` for idempotency
(BC Map L447). Every payload's tenant field is **UNRESOLVED** per `LCF-FR-094`.

ID | Event | Payload (excluding tenant field) | Consumers
--- | --- | --- | ---
`LCF-EVT-001` | `community.PostPublished` | `eventId`, `postId`, `communityId`, `authorRef`, `type`, `createdAt` | Realtime signal source (content-free at delivery, `LCF-INV-013`); A3 ranking; analytics aggregate
`LCF-EVT-002` | `community.PostEdited` | `eventId`, `postId`, `editedAt` | Cache invalidation; analytics
`LCF-EVT-003` | `community.PostDeleted` | `eventId`, `postId`, `deletedAt` | Cache invalidation; `BC-14` reference-removal signal (`LCF-FR-050`)
`LCF-EVT-004` | `community.PostRemoved` | `eventId`, `postId`, `removedAt` | Emitted on enforcement application; SHALL NOT reveal the enforcement reason (`LCF-SEC-007`)
`LCF-EVT-005` | `community.CommentPublished` | `eventId`, `commentId`, `postId`, `authorRef`, `createdAt` | Realtime signal source; analytics
`LCF-EVT-006` | `community.ReactionChanged` | `eventId`, `postId`, `actorRef`, `kind` | Reaction summary projection; analytics

`LCF-FR-104` | The event set SHALL be closed at these six. A seventh SHALL require a PRD
amendment.

`LCF-FR-105` | No event payload SHALL carry a post body, an attachment reference or a
`StudentRecordId`.

`LCF-FR-106` | Every consumer SHALL be idempotent keyed on `eventId` (BC Map L447).

`LCF-FR-107` | This part SHALL NOT introduce a new event transport. The `PL` event mechanism
of BC Map §10 is the only one (`LCF-XC-022`).

---

## 25. Performance and Reliability

`LCF-NFR-001` | Feed retrieval SHALL be bounded by pagination (`LCF-FR-065`), so response
size does not grow with community age.

`LCF-NFR-002` | Feed retrieval SHALL be servable from a tenant-partitioned index
(`LCF-SEC-016`), not a full scan.

`LCF-NFR-003` | Latency targets SHALL NOT be minted in this part. This part introduces no
numeric performance budget and no `LCF-CFG-*`. See `LCF-GAP-010`.

`LCF-NFR-004` | The enforcement read model SHALL fail closed on staleness (`LCF-RM-004`),
trading availability for correctness.

`LCF-NFR-005` | Every consumer SHALL tolerate at-least-once delivery (BC Map L447).

`LCF-NFR-006` | The feed projection SHALL be rebuildable from the event stream
(`LCF-RM-002`), because BC Map L385 forbids treating it as a system of record.

`LCF-NFR-007` | Attachment resolution latency SHALL NOT block feed retrieval. A post SHALL
render with an unresolved attachment reference rather than failing the whole page.

`LCF-NFR-008` | A `BC-14` outage SHALL degrade attachment-bearing posts only. `TEXT` posts
SHALL remain fully readable.

`LCF-NFR-009` | A realtime outage SHALL degrade freshness only, never correctness
(`LCF-FR-089`).

`LCF-NFR-010` | A `BC-13` outage SHALL NOT fail open. Under staleness the gate refuses
(`LCF-RM-004`).

`LCF-NFR-011` | Pagination SHALL remain stable under concurrent write load
(`LCF-BR-006`, `LCF-BR-007`).

`LCF-NFR-012` | No requirement in this part SHALL depend on `Realtime Scaling &
Backpressure`, which is V3 (EA L1855).

---

## 26. Analytics

`LCF-FR-108` | Analytics SHALL receive aggregate counts only — posts per community, comments
per post, reaction totals.

`LCF-FR-109` | Analytics SHALL NOT receive post bodies, attachment references, author
identities or any tenant-scoped identifier (`LCF-SEC-015`).

`LCF-FR-110` | Analytics data SHALL be tenant-partitioned (BC Map L490).

`Community Analytics` is **V3** (EA L973) — `LCF-XC-029` (§4). This part specifies only what
the event stream makes available; it does not specify the analytics product.

---

## 27. Edge Cases

\# | Case | Specified behaviour
--- | --- | ---
1 | Author's membership lapses after posting | Post remains `PUBLISHED`. Membership governs *acting*, not retroactive content removal.
2 | Author's membership lapses mid-grace | Inherits A1. First-day behaviour UNDETERMINED (`LCF-FR-055`).
3 | Author is blocked by a reader | Post suppressed for that reader only (`LCF-AUTH-012`).
4 | Reader is blocked by the author | Same suppression, bidirectional.
5 | Attachment taken down by `BC-14` after publish | Post remains; reference renders as unavailable. Body is unaffected.
6 | Attachment never resolves | Post SHALL NOT leave `DRAFT` (`LCF-FR-032`).
7 | Post reported, no case opened yet | Post stays visible. Reporting is not suppression.
8 | Post `REMOVED` by enforcement | Vanishes from all read surfaces; reason never disclosed (`LCF-SEC-007`).
9 | Enforcement read model stale beyond ceiling | Gate fails closed (`LCF-RM-004`).
10 | Duplicate `E-14` event | Idempotent, keyed on `eventId` (`LCF-INV-010`).
11 | Out-of-order `E-14` events | Read model SHALL converge; terminal states are terminal (`LCF-FR-046`).
12 | Post deleted while a reader is paging | Reader SHALL NOT skip an unread post (`LCF-BR-007`).
13 | Post created while a reader is paging | Reader SHALL NOT see a duplicate (`LCF-BR-006`).
14 | Pagination token replayed by a different caller | Refused. Tokens are not portable (`LCF-INV-012`).
15 | Pagination token replayed after the post is deleted | Token remains valid; the deleted post is simply absent.
16 | Community deleted while posts exist | A1-owned. A2 SHALL NOT define community deletion.
17 | Caller requests a community they cannot read | Indistinguishable from non-existence (`LCF-SEC-006`).
18 | Caller requests a post in another tenant's community | Same indistinguishable refusal (`LCF-SEC-002`).
19 | Caller edits a `REMOVED` post | Refused (`LCF-BR-013`).
20 | Caller edits to re-add a taken-down attachment | Refused (`LCF-INV-015`).
21 | Second reaction from the same actor | Replaces the first (`LCF-FR-083`).
22 | Reaction on a `DELETED` post | Refused. `DELETED` is terminal and invisible (`LCF-INV-008`).
23 | Comment on a `REMOVED` post | Refused, indistinguishably from non-existence.
24 | Rate limit reached | Refused, distinguishably from authorization, without revealing the limit (`LCF-FR-098`).
24a | Rate limit reached *and* authorization would also refuse | Authorization refusal is evaluated first (`LCF-INV-016`), so the response reveals nothing about the limit.
25 | Minor-age author, age `Unknown` | Treated as minor (`LCF-SEC-013`, `SM-INV-3`).
26 | Realtime signal delivered to a now-unentitled caller | Signal is content-free; the subsequent read is refused (`LCF-INV-013`, `LCF-FR-088`).
27 | `BC-14` entirely unavailable | `TEXT` posts fully functional; other types degraded (`LCF-NFR-008`).

---

## 28. Scope

### 28.1 In scope

- `CommunityPost`, `CommunityComment`, `CommunityReaction` — specification and `BC-15` ownership
- Post types, lifecycle, creation, edit, delete
- Feed retrieval, pagination *contract*, filtering, in-community search *requirements*
- Authorization and visibility for content
- Moderation integration seam with `BC-13` over the existing `E-14`
- Attachment reference model via `BC-14`
- Six domain events
- The ranking seam for A3

### 28.2 Out of scope

Everything in the `LCF-XC-*` register (§4, §15, §17, §18, §21, §26) — 29 exclusions,
including: community creation and membership (A1), ranking algorithm (A3), moderation
decisioning (`BC-13`), attachment storage (`BC-29`), realtime transport, public library
discovery and profile (14A/14B), Local/Global Discovery, cross-library search, threaded
replies, edit history, member enumeration, `Community Analytics` (V3), `Moderation` (V3), and
video/audio content.

### 28.3 Explicitly preserved progression

This part sits at step 2 of the ratified progression and does not reorder it:

**Library-first → Library Community → Same-Library Student Network → future Local/Global
Discovery**

`LCF-XC-018` and `LCF-XC-019` (§4) keep Local and Global Discovery outside V1 and outside
this part. `Nearby Students` is V2 per EA L929 and is not specified here.

---

## 29. Acceptance Criteria

Thirty-six criteria. **33 verifiable · 1 unwritable · 2 deferred.** The unwritable and
deferred ones are labelled as such rather than being quietly downgraded to something testable.

ID | Criterion | Status
--- | --- | ---
`LCF-AC-001` | A `TEXT` post created by an entitled member becomes `PUBLISHED` | Verifiable
`LCF-AC-002` | A post created by a non-member is refused | Verifiable
`LCF-AC-003` | A refusal for non-membership is byte-identical to one for a non-existent community | Verifiable
`LCF-AC-004` | Post type is immutable across an edit | Verifiable
`LCF-AC-005` | A `TEXT` post carries zero attachment references | Verifiable
`LCF-AC-006` | A non-`TEXT` post cannot reach `PUBLISHED` with an unresolved reference | Verifiable
`LCF-AC-007` | No `FileRef`, storage key, bucket name or signed URL appears in any response | Verifiable
`LCF-AC-008` | No response contains a `StudentRecordId` | Verifiable
`LCF-AC-009` | Only `BC-14` appears on the `BC-29` call path | Verifiable by architecture test
`LCF-AC-010` | `E-22`'s consumer list is unchanged by this part | Verifiable by diff
`LCF-AC-011` | `PRD-017` is byte-unchanged by this part | Verifiable by hash
`LCF-AC-012` | The feed returns only `PUBLISHED` posts | Verifiable
`LCF-AC-013` | A `DELETED` post's body is unretrievable through every API in §23 | Verifiable
`LCF-AC-014` | A `REMOVED` post is indistinguishable from a never-existing one | Verifiable
`LCF-AC-015` | `DELETED` and `REMOVED` are terminal | Verifiable
`LCF-AC-016` | Deleting a post cascades to comments and reactions | Verifiable
`LCF-AC-017` | Deleting a post does not delete the `SharedContentRef` | Verifiable
`LCF-AC-018` | A blocked party's posts are suppressed bidirectionally | Verifiable
`LCF-AC-019` | An enforcement event suppresses the post without disclosing the reason | Verifiable
`LCF-AC-020` | A duplicate `E-14` event produces no second effect | Verifiable
`LCF-AC-021` | The enforcement read model rebuilds from the stream without loss | Verifiable
`LCF-AC-022` | The gate fails closed when lag exceeds the ceiling | Verifiable once the ceiling is ratified
`LCF-AC-023` | Post detail applies the same predicate as the feed | Verifiable
`LCF-AC-024` | There is no deep-link path that bypasses the feed predicate | Verifiable
`LCF-AC-025` | A reaction summary never enumerates members | Verifiable
`LCF-AC-026` | A second reaction from the same actor replaces the first | Verifiable
`LCF-AC-027` | An edit re-runs the rate-limit and enforcement gates | Verifiable
`LCF-AC-028` | An edit cannot resurrect a taken-down attachment | Verifiable
`LCF-AC-029` | A rate-limit refusal does not reveal the limit value | Verifiable
`LCF-AC-030` | An authorization refusal is evaluated before a rate-limit refusal | Verifiable
`LCF-AC-031` | No realtime signal carries post content | Verifiable
`LCF-AC-032` | A realtime signal is never delivered to a caller who would be refused the read | Verifiable
`LCF-AC-033` | No event payload carries a body, an attachment reference or a `StudentRecordId` | Verifiable
⛔ `LCF-AC-034` | Grace-window **first-day** posting behaviour is correct | **UNWRITABLE.** `ADR-0036` q2 is unanswered, so the expected result does not exist. Writing a test would fabricate the answer. Owner: **Product Owner**.
⏸ `LCF-AC-035` | Cross-tenant isolation of community posts is asserted per query | ⚠ **STILL DEFERRED at v0.8.** Conflict 5 / `LCF-ADR-005` is CLOSED by `ACCEPTED` `ADR-0078`, **but this criterion is not thereby writable**: it remains blocked because `integration_test/` does **not** exist (`LCF-GAP-011`, re-measured at v0.8 — `ls -d integration_test` → *No such file or directory*). One of two blockers cleared.
⏸ `LCF-AC-036` | Pagination stability under concurrent write load | **DEFERRED.** Depends on Conflict 7 (`LCF-ADR-003`) for the token shape, and on `integration_test/`.

---

## 30. Risks and Mitigations

ID | Risk | Severity | Mitigation / owner
--- | --- | --- | ---
~~`LCF-RSK-001`~~ | ⛔ **RETIRED at v0.8 — the risk did not materialise.** Conflict 5 resolved **consistently with** Option 1: `ACCEPTED` `ADR-0078` §2.1 determines `BC-15` carries no `tenantId`, so the `communityId` model is **not** invalidated. Position retained, not renumbered. Original text: *Conflict 5 resolves against Option 1, invalidating the `communityId` model* | **High** | §20.2 records Options 2 and 3 so the fallback path is pre-described. Owner: Architecture Owner.
~~`LCF-RSK-002`~~ | ⛔ **RETIRED at v0.8 — the risk did not materialise.** Conflict 6 resolved in favour of emission: `ACCEPTED` `ADR-0078` §2.1 **L63** rules L450 scoped, so `BC-15` events **may** be emitted without a `tenantId`. Position retained, not renumbered. Original text: *Conflict 6 resolves such that `BC-15` events cannot be emitted at all* | **High** | §24 leaves the tenant field UNRESOLVED rather than assuming. Owner: Architecture Owner.
`LCF-RSK-003` | `LCF-ADR-002` is refused, permanently blocking attachment-bearing posts | Medium | `LCF-FR-043` already scopes the blast radius to three of four post types. `TEXT` ships regardless.
`LCF-RSK-004` | `LCF-ADR-001` is refused, leaving the aggregates unregistered | Medium | `LCF-GAP-009` records the state; nothing is implemented against an unregistered aggregate.
`LCF-RSK-005` | A pagination convention is ratified elsewhere that contradicts §14's contract | Medium | §14 states only invariants that any reasonable convention satisfies.
`LCF-RSK-006` | A realtime owner is assigned to a context that cannot reach `BC-15` | Medium | `LCF-INV-013` makes the signal content-free, so the transport choice is decoupled from content authorization.
`LCF-RSK-007` | A3 never ships, leaving the ranking seam permanently unexercised | Low | `LCF-FR-075` gives a correct default.
`LCF-RSK-008` | `PRD-020` changes its enforcement contract before it is ranked | Medium | `LCF-RM-005` refuses to copy `PRD-020` numerics, so only the *shape* is coupled.
`LCF-RSK-009` | `PRD-020`'s staleness ceiling is never ratified, leaving `LCF-AC-022` untestable | Medium | `LCF-GAP-007`. Owner: whoever ranks `PRD-020`.
`LCF-RSK-010` | `BC-14` has no PRD, so `SharedContentRef` has no ratified shape | **High** | `LCF-GAP-004`. This part treats it as opaque precisely so that its shape can be decided elsewhere.
`LCF-RSK-011` | `FIL-GAP-003` is resolved by widening `E-22` to `domain/social`, tempting a shortcut past `BC-14` | Medium | §10.3's necessity test records the affirmative reason not to take that route.
`LCF-RSK-012` | Grace-window ambiguity (`ADR-0036` q2) propagates into implementation as an arbitrary default | **High** | `LCF-AC-034` is declared UNWRITABLE rather than being given a guessed expected value.
`LCF-RSK-013` | Configuration bounds are added without a PRD amendment | Low | `LCF-BR-002` cites `CONFIGURATION_GUIDE.md` L863.
~~`LCF-RSK-014`~~ | ~~The `LCF-` prefix collides with a future ratified prefix~~ | **n/a** | ⛔ **RETIRED at v0.8.** The risk's precondition no longer exists: `ADR-0080` §5 **L195** REGISTERED `LCF-`, closing `LCF-GAP-001`. A registered prefix cannot collide with a future ratification of itself. Position retained, not renumbered (`PRD-023` `CNF-FR-008`).
`LCF-RSK-015` | Member enumeration leaks via reaction or comment surfaces | Medium | `LCF-SEC-011`, `LCF-FR-084`. `LCFG-5` defaults the directory to Disabled.
`LCF-RSK-016` | Community content leaks onto a public library profile | **High** | `LCF-SEC-004`, `LCF-SEC-005`, grounded in `14A` §14A.5 and `14B` L173.
`LCF-RSK-017` | `integration_test/` never materialises, leaving `LCF-AC-035` / `036` permanently deferred | Medium | `LCF-GAP-011`. Pre-existing repository condition, not introduced here.
`LCF-RSK-018` | A future revision treats this DRAFT as ratified because it is now committed to `main` | Medium | §0 and the provenance block both state DRAFT status explicitly; no register in the governance tree references it.

---

## 31. ADR Requirements

Six ADRs are **required**. This part **creates none of them and mints no ADR number.**
⚠ **v0.5's observation here was WRONG and is corrected at v0.6.** v0.5 read `ADR-INDEX.md`'s
*"`ADR-0066`…`ADR-0073` remain unopened"* as meaning `ADR-0066` was the next free number.
It is not: `PRD-020` **§29.2** earmarks `ADR-0066`…`ADR-0073` to **named** subjects — with
`ADR-0069` marked **DO NOT OPEN** — and `PRD_LIFECYCLE.md` **§5 rule 5** forbids reusing a
number. *Unopened* is not *unallocated*. A reference count over `docs/ tool/ lib/ test/`
returns **non-zero** for every number `0066`–`0074` and **zero** for `0075`–`0078`. The ADRs
raised for this part are therefore **`ADR-0075`**–**`ADR-0078`**, and `ADR-INDEX.md` now
records **69** files. **This part still creates no ADR and mints no ADR number of its own.**
`ADR-INDEX.md` L143 requires an ADR **before implementation**, which is why all six are
listed as blockers rather than follow-ups.

ID | Required decision | Owner | Blocks
--- | --- | --- | ---
`LCF-ADR-001` | Register `BC-15`'s aggregates in BC Map §8 (one new row) and extend L119 | Architecture Owner | §22, `LCF-GAP-009`
`LCF-ADR-002` | Admit the `BC-15 → BC-14` reference edge to BC Map §7 | Architecture Owner | `LCF-API-002`, all non-`TEXT` post types
`LCF-ADR-003` | Ratify a repository-wide pagination convention | Architecture Owner | `LCF-API-004`, `LCF-AC-036`
`LCF-ADR-004` | Assign a realtime owner, edge and fan-out model | Architecture Owner | `LCF-API-014`
`LCF-ADR-005` | ✅ **CLOSED at v0.8 by `ACCEPTED` `ADR-0078`.** Resolve `ID-2` vs library-private community scope — **determined: the community scope identifier carries NO `tenantId`** (`ADR-0078` §2.1, **L58**). The ADR's *Closes* row (**L12**) and §5.1 (**L200**) both name *"A2 antecedents Conflicts 5 and 6"*; §20.2 (**L1102** of v0.7) routes Conflict 5 here | ~~Architecture Owner~~ — **discharged** by `ADR-0078` | §20, `LCF-API-013`, `LCF-AC-035` (both still blocked on **other** grounds — see §20.4)
`LCF-ADR-007` | ⛔ **NEW at v0.8.** Admit the `BC-15 → BC-11` reference edge to BC Map §7, so that `LCF-FR-034`, `LCF-AUTH-012` and `LCF-FR-096` may consume `RateLimitCounter` and `BlockList`. ⚠ **Two acts are required, not one**: BC Map **L292** requires the edge row, and `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` rule `L2` (**L49**) additionally requires the declared **Social cluster** (Matrix **L90** = `BC-11`/`12`/`13`) to be extended, because `domain/social` is rank **8** (`tool/module_dependencies.yaml` **L47**) and same-rank dependencies outside a declared cluster are forbidden | **Architecture Owner** | `LCF-FR-034`, `LCF-AUTH-012`, `LCF-FR-096`, `LCF-FR-095`; Stage 3 Check 2
`LCF-ADR-006` | ✅ **CLOSED at v0.8 by `ACCEPTED` `ADR-0078`.** Resolve BC Map L450 against L488 — **determined: L450 is scoped, not universal**; its *"every domain event"* means every event **from a tenant-scoped context** (`ADR-0078` §2.1, **L63**). `BC-15` is in the Global band, so L488 governs and no `tenantId` is required | ~~Architecture Owner~~ — **discharged** by `ADR-0078` | §24 tenant field

---

## 32. Implementation Checklist

Twenty items. **None is startable** until its blocking ADR is accepted — `ADR-INDEX.md` L143.
No `IMPL-` numbers are minted, because `IMPL-` allocation is a registry action.

\# | Item | Blocked by
--- | --- | ---
1 | Register `CommunityPost` / `Comment` / `Reaction` in BC Map §8 | `LCF-ADR-001`
2 | Add the `BC-15 → BC-14` edge row | `LCF-ADR-002`
3 | Resolve the tenant model | `LCF-ADR-005`
4 | Resolve the event tenant field | `LCF-ADR-006`
5 | Ratify the pagination convention | `LCF-ADR-003`
6 | Assign the realtime owner | `LCF-ADR-004`
7 | Answer `ADR-0036` q2 | Product Owner
8 | Rank `PRD-020` so its staleness ceiling becomes citable | `PRD-020` owner
9 | Produce a `BC-14` PRD defining `SharedContentRef` | `LCF-GAP-004`
10 | Implement the `CommunityPost` aggregate | Items 1, 3
11 | Implement lifecycle transitions | Item 10
12 | Implement the `E-14` enforcement read model | Item 10
13 | Implement the fail-closed staleness gate | Items 8, 12
14 | Implement `LCF-API-001`, `003`, `005`–`012` | Items 10, 11
15 | Implement `LCF-API-002` | Items 2, 9
16 | Implement `LCF-API-004` | Item 5
17 | Implement `LCF-API-013` | Items 3, 5
18 | Implement `LCF-API-014` | Item 6
19 | Create `integration_test/` and write `LCF-AC-035` / `036` | `LCF-GAP-011`
20 | ~~Ratify the `LCF-` prefix in the identifier registry~~ ✅ **DONE** — `ADR-0080` §5 **L195** | ~~`LCF-GAP-001`~~ **CLOSED**

---

## 33. Architecture Consistency Audit

Every row below was measured against the repository during the revision that produced v0.3.

\# | Check | Result
--- | --- | ---
1 | Does this part create a bounded context? | ✅ No — `LCF-INV-001`, `AR-1` satisfied
2 | Does it own an aggregate outside `BC-15`? | ✅ No — `LCF-INV-002`
3 | Does it contradict `AR-1`'s "owns no aggregate" for the A1 capability? | ✅ No — the aggregate is `BC-15`'s, not the capability's
4 | Does it widen `E-22`? | ✅ No — `LCF-FR-040`, `LCF-AC-010`
5 | Does it modify `PRD-017` (FROZEN)? | ✅ No — `LCF-AC-011`
6 | Does it rely on the unusable `domain/social` file port? | ✅ No — `LCF-FR-041`
7 | Does it require a new edge? | ⚠ Yes — exactly one, `BC-15 → BC-14`, raised as `LCF-ADR-002` per BC Map L292
8 | Does it require a new `E-14` edge for moderation? | ✅ No — BC Map L318 already lists `BC-15`
9 | Does it mint a `BC-` identifier? | ✅ No
10 | Does it mint an `ADR-` number? | ✅ No. ⚠ v0.5's `ADR-0066` observation was **wrong** and is corrected in §31 — `0066`–`0073` are earmarked by `PRD-020` §29.2. The four ADRs governing this part (`ADR-0075`–`0078`) were raised by the **Architecture Owner**, not by this document
11 | Does it mint a `PERM-` identifier? | ✅ No — `LCF-AUTH-008`, `AUTH-7.22` respected
12 | Does it mint a tenant role? | ✅ No — `LCF-AUTH-009`, `TR-1`…`TR-5` closed
13 | Does it mint a `CFG-` parameter? | ✅ No — `LCF-BR-002`, `CONFIGURATION_GUIDE.md` L863 respected
14 | Does it copy a numeric from an unranked source? | ✅ No — `LCF-RM-005` refuses `PRD-020` L1683
15 | Does it claim V1? | ✅ No — `LCF-FR-024`, V2 per `MASTER_PRD.md` L92
16 | Does it require a V3 capability? | ✅ No — `LCF-FR-026`
17 | Does it duplicate A1 ownership? | ✅ No — `LCF-INV-003`, `LCF-INV-004`
18 | Does it duplicate `BC-13` ownership? | ✅ No — `TSF-XC-031` boundary respected
19 | Does it expose community content publicly? | ✅ No — `LCF-SEC-004`, `LCF-SEC-005`
20 | Does it resolve any conflict it is not authorised to resolve? | ✅ No — all six ADR requirements and all seven decisions are routed to named owners

### 33.1 Register state

Counts below are the **measured** contents of this document, verified by definition-scan.
Every register is dense — no declared identifier is undefined, and no defined identifier is
undeclared.

Register | Count | Range | Notes
--- | --- | --- | ---
`LCF-FR-*` | 110 | `001`–`110` | Dense, no gaps, no duplicates
`LCF-BR-*` | **14** | `001`–`013`, `010a` | Dense. ⭐ v0.6 adds `LCF-BR-010a` (the reaction-kind closure rule) — the **only** identifier v0.6 mints. Suffixed rather than numbered `014`, following this document's own `LCF-DEC-003a` precedent, so no existing number moves
`LCF-INV-*` | 16 | `001`–`016` | Dense
`LCF-AUTH-*` | 12 | `001`–`012` | Dense
`LCF-RM-*` | 5 | `001`–`005` | Dense
`LCF-SEC-*` | 16 | `001`–`016` | Dense
`LCF-API-*` | 14 | `001`–`014` | 9 provided, 5 NOT PROVIDED
`LCF-EVT-*` | 6 | `001`–`006` | Set closed (`LCF-FR-104`)
`LCF-NFR-*` | 12 | `001`–`012` | Dense
`LCF-AC-*` | 36 | `001`–`036` | **33 verifiable · 1 unwritable (`LCF-AC-034`) · 2 deferred (`LCF-AC-035`, `LCF-AC-036`)**
`LCF-XC-*` | 29 | `001`–`029` | Dense; all defined in §4
`LCF-RSK-*` | 18 | `001`–`018` | Dense. `001`, `002` and `014` ⛔ RETIRED at v0.8 — their preconditions ceased to exist. **Positions retained, never renumbered** (`PRD_LIFECYCLE.md` §5 rule 5)
`LCF-GAP-*` | 12 | `001`, `004`–`014` | `001`, `004`–`011` defined in §33.2; `012`–`014` defined in §34. **At v0.7: `001` ✅ CLOSED (`ADR-0080` — `LCF-` prefix REGISTERED), `005` ✅ CLOSED on measurement (`ADR-0081`), `012` ✅ RESOLVED, `013` ✅ FULLY RESOLVED (`ADR-0079` closed the enumeration half), `014` ✅ RESOLVED, `013` ⚠ half resolved** — all three retained, because a resolved gap is not retired (`PRD-023` `CNF-FR-008` forbids reusing a position). `001` and `004`–`011` remain **OPEN**, unchanged. Positions `002`, `003` unused
`LCF-ADR-*` | **7** | `001`–`007` | Requirements only; **no ADR created**. `005` and `006` ✅ CLOSED by `ACCEPTED` `ADR-0078`; **`007` minted at v0.8** for the `BC-15 → BC-11` edge (Stage 3 Check 2)
`LCF-DEC-*` | 7 | `001`–`003`, `003a`, `004`–`006` | Includes `LCF-DEC-003a`. `003` and `003a` ✅ CLOSED by `ACCEPTED` `ADR-0078`; no position added or renumbered
`LCF-DEP-*` | 5 | `001`–`005` | Dense

**Total: 319 identifiers across 16 registers.** v0.5 added exactly one identifier
(`LCF-GAP-014`); **v0.6 adds exactly one (`LCF-BR-010a`)**; **v0.8 adds exactly one
(`LCF-ADR-007`)** and removes none. ⚠ The v0.7 changelog's *"UNCHANGED at 318 identifiers"*
is **historically correct for v0.7** and is deliberately left standing; **319** is the v0.8
figure. Three `LCF-RSK-*` positions (`001`, `002`, `014`) are ⛔ **RETIRED** at v0.8 and
**still counted** — a retired identifier keeps its position and is never reused
(`PRD-023` `CNF-FR-008`, `PRD_LIFECYCLE.md` §5 rule 5), so retirement does not reduce the total. `LCF-GAP-012`,
`LCF-GAP-013` and `LCF-GAP-014` are all **retained** with their positions — a resolved gap is
not retired (`PRD-023` `CNF-FR-008`).

Every one of them is **PROPOSED and UNRATIFIED**. ✅ The `LCF-` **prefix** itself is
**REGISTERED** by `ACCEPTED` `ADR-0080` §5 (**L195**); `LCF-GAP-001` is **CLOSED**. The prefix
being conferred does not confer the identifiers it labels.

### 33.2 Gap register

Every gap below was already asserted somewhere in this document; v0.4 gives each one a
definition so that no reference dangles. No new gap is claimed and no gap is resolved here.

ID | Gap | Owner | Cited at
--- | --- | --- | ---
`LCF-GAP-001` | ✅ **CLOSED at v0.7, wording reconciled at v0.8.** The `LCF-` prefix **is registered** — `ACCEPTED` `ADR-0080` §5 **L195** registered it (and `LCR-` at **L196**) in the act that constituted the Governance Owner role | ~~Governance Owner~~ — **discharged** by `ADR-0080` | §0, §30 (`LCF-RSK-014` RETIRED), §32 item 20 DONE, §33.1
`LCF-GAP-004` | No PRD exists for `BC-14` Content Sharing, so `SharedContentRef` has no ratified shape | Architecture Owner / `BC-14` PRD author | §5.3 row 7, §30 (`LCF-RSK-010`), §32 item 9, `LCF-DEP-003`. ⚠ v0.5 removed the §4 `LCF-XC-017` citation: that cell excluded **comments**, whereas this gap is about **`BC-14` attachments**. The cross-reference was a defect and is corrected by the `LCF-GAP-012` resolution
`LCF-GAP-005` | A3 does not exist on disk, so the ranking seam is specified but unexercised | A3 author | §5.3 row 11, §16. ✅ **CLOSED at v0.7 ON MEASUREMENT, not on decision** (`ADR-0081` §3): the predicate is a statement of fact about the filesystem, and it is now **false** — A3 exists as `PRD-021A_A3_COMMUNITY_FEED_RANKING_DRAFT_v0.4.md`, **1,175** lines, committed in `8a02d52`, with the ranking seam exercised in its §12.1 weight table. ⭐ **The only residual item in either annex closable without an owner's decision.** ⚠ Its sibling `LCF-GAP-011` was tested identically and **remains OPEN** — `integration_test/` still does not exist, so that predicate is still **true**
`LCF-GAP-006` | Body length, attachment count and page-size bounds are configuration parameters that this part refuses to mint. Adding one is a PRD amendment (`CONFIGURATION_GUIDE.md` L863) | Product Owner + Configuration Owner | §9 (`LCF-BR-002`, `LCF-BR-003`), §14 (`LCF-BR-008`), §21 (`LCF-FR-097`)
`LCF-GAP-007` | The enforcement staleness ceiling cannot be cited while `PRD-020` is DRAFT/unranked, so `LCF-AC-022` has no ratified threshold | `PRD-020` owner | §11.3 (`LCF-RM-005`), §30 (`LCF-RSK-009`), §32 item 8, `LCF-DEP-004`
`LCF-GAP-008` | The permission catalogue is closed (`AUTH-7.22`) and `ADR-0036` §7.1 records zero `PERM-*` repo-wide, so this part's authorization requirements have no permission identifier to bind to | Governance Owner / Auth PRD owner | §12.1 (`LCF-AUTH-008`)
`LCF-GAP-009` | BC Map §8 has no aggregate row for `BC-15`, so `CommunityPost`, `CommunityComment` and `CommunityReaction` are specified but unregistered | Architecture Owner (`LCF-ADR-001`) | §22 (`LCF-FR-099`, `LCF-FR-100`), §30 (`LCF-RSK-004`), §33 row 1 of the conflicts table
`LCF-GAP-010` | This part mints no latency or throughput budget, so §25 has no numeric performance target | Product Owner + Architecture Owner | §25 (`LCF-NFR-003`)
`LCF-GAP-011` | `integration_test/` does not exist in the repository, so `LCF-AC-035` and `LCF-AC-036` cannot be written even once their blocking decisions land | Engineering Owner | §29, §30 (`LCF-RSK-017`), §32 item 19

Positions **002** and **003** of this register are **unused**. No identifier was ever assigned
to either, and none is assigned here. They are noted so that a future revision does not
silently reuse them.

---

## 34. Known defects reported, not fixed

v0.4 was authorised to fix **objectively verified integrity defects only**. v0.5 additionally
applies **one** authorised Product Owner scope decision (`LCF-GAP-012`). The items below record
the current state of each reported defect.

ID | Defect | Resolution state | Owner
--- | --- | --- | ---
`LCF-GAP-012` | `LCF-XC-017` (§4) excluded "Comments, reactions, threads, mentions" while §17, §22 and §24 of this same document specify `CommunityComment`, `CommunityReaction`, `LCF-API-008`–`011`, `LCF-EVT-005` and `LCF-EVT-006` | ✅ **RESOLVED at v0.5.** Explicit Product Owner decision: comments and reactions are **IN SCOPE and SHIP**. `LCF-XC-017` is **narrowed** to threads/mentions; the specification is **preserved in full**. The deletion option was rejected because it would violate "invent, remove, merge, split no requirement". Recorded in `PRD-021A_LCF-GAP-012_DECISION_RECORD.md` | **Product Owner** — ✅ decided
`LCF-GAP-014` | `LCF-BR-010` (§17) requires the reaction kind set to "be defined in this part's data model (§22)", but §22 declares only `Closed set` and never enumerates a member. Contrast `LCF-FR-027`, which enumerates the post-type set exactly | ✅ **RESOLVED at v0.6.** Explicit **Product Owner** enumeration — the set is exactly `LIKE`, `HELPFUL`, `CELEBRATE`. Recorded in `PRD-021A_LCF-GAP-012_DECISION_RECORD.md` **v2.0 §7.2**; written into §17 (`LCF-BR-010a`) and §22. `LCF-BR-010` is now **satisfied**, and dependent parts may reference individual kinds | **Product Owner** — ✅ decided
`LCF-GAP-013` | `LCF-FR-026` cites `LCF-XC-016` and `LCF-XC-017` as the exclusions covering `Moderation (V3)` and `Community Analytics (V3)`, but `LCF-XC-016` is rate-limit policy authorship and `LCF-XC-017` is comments/reactions. The V3 subjects are actually covered by `LCF-XC-006` (moderation) and `LCF-XC-029` (analytics) | ⚠ **HALF RESOLVED at v0.6.** ✅ The **citation** half is closed by `ACCEPTED` `ADR-0076`: repointed to `LCF-XC-006` (moderation) and `LCF-XC-029` (analytics). **Not guessed — measured**: `LCF-XC-028` was eliminated because it cites EA **L919**, a **`(V1)`** node that cannot ground a **V3** exclusion, and `LCF-XC-029` is the only exclusion row citing EA **L973**. ✅ **The EA enumeration half is CLOSED at v0.7 — so this gap is now FULLY RESOLVED** (`ADR-0079`). It was **BLOCKED** at v0.6 because inserting two nodes into the EA capability tree at **L972** shifts **240** EA line-citations across **39** files, three of them **FROZEN**. ⭐ **The blocker was removed by measuring *where* an edit is safe rather than *whether* editing is safe**: the highest EA line cited anywhere in the repository is **L2404** in a then-2,549-line file, so `ADR-0079` executed `ADR-0075` §8.5 **Option A** — an append-only amendment to **EA v2.3** adding a `v2.3` changelog entry (L2450) and a new **§12 Capability Enumeration Addenda** (L2570) enumerating **Community Comments (V2)** and **Community Reactions (V2)** owned by `BC-15`. Verified: **482** EA line-citations re-resolved, **0** invalidated, **0** cited-line contents changed, **0** frozen documents modified, and EA **L967–973** byte-identical. ⚠ `ADR-0075`'s own Status remains `EXECUTION BLOCKED` and it is **not** superseded — the act *it* prescribed is still forbidden; `ADR-0079` performed a different act. ⛔ The underlying **class** defect survives: the EA is still cited by bare line number **281** times, which is `ADR-0075` §8.5 **Option B**, now routed to the **Governance Owner** constituted by `ADR-0080`. The EA is **Rank 6 and descriptive**, so this document's normative text is unaffected either way | **Architecture Owner** — ✅ decided

**No item above affects any architectural determination in this document.** `BC-15` ownership,
the `BC-14` attachment route, the V2 classification, the A1 dependency and all eight recorded
conflicts are unchanged by the `LCF-GAP-012` resolution.

**Release class is a determination, not a v0.5 choice.** `MASTER_PRD.md` **L92**
(`MP-SCOPE-04`, Rank 1) places `BC-15` at **V2**; `LCF-INV-002` makes `BC-15` the sole owner of
`CommunityComment` and `CommunityReaction`. Both are therefore **V2**. This is **not** inferred
from EA **L989** `Comments (V3)`, which sits under **Notes Sharing** — a different capability
branch. The EA's `Community (V2)` block (**L967–973**) does not enumerate comments, and the EA
contains **no** reaction node at any version; per `MP-CON-08` (`MASTER_PRD.md` **L519**) that is
*"a defect to be raised, not a choice to be made"*, and it is **raised, not resolved here**
— the EA is Rank 6 and must follow the PRDs, never lead them. Enumerating those EA nodes is an
**Architecture Owner** act under EA §10.5.

⚠ **`LCF-GAP-013` is unaffected by the narrowing.** `LCF-XC-016` and `LCF-XC-017` never covered
`Moderation (V3)` or `Community Analytics (V3)` under any reading, so `LCF-FR-026`'s
mis-citation is unchanged in substance and remains an **Architecture Owner** decision.

---

# Architecture Conflicts / Decisions Required

This section is the deliverable's operative part. Nothing below it is decided by this
document.

## Conflicts

\# | Conflict | Exact citation | Smallest compatible resolution | Status / owner
--- | --- | --- | --- | ---
1 | Earlier drafts placed the Community Feed in **V1** | `MASTER_PRD.md` L92 (`MP-SCOPE-04` → V2); EA L970 `Community Feed (V2)`; BC Map L119, L147 | Scope the whole part to V2 and re-derive its dependencies (§7.2) | ✅ **RESOLVED in v0.3.** No decision required.
2 | `CommunityPost` had no owner; A1 cannot own it | `ARCHITECTURE_RULINGS.md` `AR-1` §23; A1 L131, L178, L370 (`LCM-INV-014`), L615 (`LCM-AC-010`) | Assign the aggregate to `BC-15` (BC Map L119) | ✅ **RESOLVED in v0.3.** No decision required.
3 | `CommunityPost` cannot be registered — BC Map §8 has **no row** for `BC-14` or `BC-15` | `LIBOORA_BOUNDED_CONTEXT_MAP.md` §8, L370–386 | Add **one** §8 row for `BC-15` listing its three aggregates, and extend L119's ownership sentence | ⛔ **Architecture Owner** — `LCF-ADR-001`
4 | Attachments need a `BC-15 → BC-14` edge, which BC Map §7 does not record | BC Map L292 ("If an edge is not in this table, it does not exist and adding it requires an ADR"); L331 (`E-22` consumers = `BC-01, BC-10, BC-12, BC-14`); `PRD-017` `FIL-FR-006` L405, `FIL-FR-007` L410 | Add **one** reference-edge row `BC-15 → BC-14`. `E-22` untouched; `PRD-017` untouched | ⛔ **Architecture Owner** — `LCF-ADR-002`
5 ⭐ | `BC-15` is in the **Global** band and may never hold a `tenantId`, yet a library community is tenant-private | BC Map **L488**: `BC-11→17 Student Network \| Global. No tenantId. Keyed on PersonId. \| Must never receive a StudentRecordId or tenantId (rule ID-2)`. Also L486, and `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` L354 (`X-05`) | **Option 1** — `BC-15` holds an opaque `communityId`; tenant reasoning stays in A1 on the existing `E-13` upward-only ACL pattern (BC Map L307). ⚠ Objection recorded in §20.2: a 1:1 `communityId` may be a `tenantId` renamed. Options 2 and 3 recorded as fallbacks | ✅ **RESOLVED at v0.8** — `ACCEPTED` `ADR-0078` §2.1 (**L58**): `BC-15` carries **no** `tenantId`. `LCF-ADR-005` / `LCF-DEC-003` **CLOSED**. ⚠ The §20.2 objection is **not** ruled on by the ADR and survives as a residual (§20.5)
6 ⭐ | `tenantId` is mandatory on **every** domain event, but `BC-15` may never hold one | BC Map **L450** vs BC Map **L488** | A rule stating which of L450 / L488 governs events emitted from the Global band. **Pre-existing** — arises for any `BC-11`…`BC-17` event, surfaced by this part, not created by it | ✅ **RESOLVED at v0.8** — `ACCEPTED` `ADR-0078` §2.1 (**L63**): **L450 is scoped, not universal**; L488 governs the Global band. `LCF-ADR-006` / `LCF-DEC-003a` **CLOSED**
7 | No pagination convention exists repository-wide | `grep -rniE 'cursor' docs/10-architecture/*.md` → **0 results** | This part states the contract only (§14.2). The convention is ratified elsewhere | ⛔ **Architecture Owner** — `LCF-ADR-003` / `LCF-DEC-005`
8 | No bounded context owns the Realtime Engine; no realtime edge exists | EA L86, L1852–L1855; BC Map §7 has no realtime row and BC Map has no realtime ownership row | This part emits only a **content-free** signal (`LCF-INV-013`) so it is safe under any transport. Owner, edge and fan-out model decided elsewhere | ⛔ **Architecture Owner** — `LCF-ADR-004` / `LCF-DEC-006`

## Decisions required

ID | Decision | Owner | Consequence if undecided
--- | --- | --- | ---
`LCF-DEC-001` | Accept or refuse the `BC-15` aggregate registration (Conflict 3) | Architecture Owner | Aggregates remain unregistered; nothing implementable
`LCF-DEC-002` | Accept or refuse the `BC-15 → BC-14` edge (Conflict 4) | Architecture Owner | `NOTE` / `MEDIA` / `LINK` posts permanently blocked
`LCF-DEC-003` | ✅ **CLOSED at v0.8 by `ACCEPTED` `ADR-0078`.** The outcome matches **Option 1** (opaque `communityId`, no `tenantId` on `BC-15`) as recorded in §20.2. ⚠ `ADR-0078` reaches this outcome on its **own** reasoning — it contains **0** occurrences of `communityId` or `Option 1` — so v0.8 records the outcome, **not** an endorsement of §20.2's argument | ~~Architecture Owner~~ — **discharged** | `communityId` semantics are no longer provisional as to tenancy; see the residual at §20.5
`LCF-DEC-003a` | ✅ **CLOSED at v0.8 by `ACCEPTED` `ADR-0078`.** L450 is scoped to tenant-scoped contexts; L488 governs the Global band (§2.1, **L63**). `BC-15` events may be emitted **without** a `tenantId` | ~~Architecture Owner~~ — **discharged** | The blocker *"no `BC-15` event can be lawfully emitted"* is **lifted**
`LCF-DEC-004` | Answer `ADR-0036` **q2** — grace-window first-day behaviour | **Product Owner** | `LCF-AC-034` stays UNWRITABLE; inherited from A1 (`LCM-DEC-001`)
`LCF-DEC-005` | Ratify a pagination convention (Conflict 7) | Architecture Owner | `LCF-API-004` stays NOT PROVIDED
`LCF-DEC-006` | Assign realtime ownership and fan-out model (Conflict 8) | Architecture Owner | `LCF-API-014` stays NOT PROVIDED

## Dependencies

ID | Depends on | Nature | Blocking
--- | --- | --- | ---
`LCF-DEP-001` | **A1** (`PRD-021A` Part A1 v0.2, on disk) | Membership predicate, roles, community existence, privacy posture | Satisfied — A1 exists
`LCF-DEP-002` | **`ADR-0036` q2** | Grace-window first-day behaviour. Inherited from A1 `LCM-GAP-001` / `LCM-RSK-001` / `LCM-DEC-001` | ⛔ Blocking `LCF-AC-034`
`LCF-DEP-003` | **A `BC-14` PRD** | Defines `SharedContentRef`. No such PRD exists | ⛔ Blocking `LCF-API-002`
`LCF-DEP-004` | **`PRD-020` ranking** | Its staleness ceiling cannot be cited while it is DRAFT/unranked | ⛔ Blocking `LCF-AC-022`
`LCF-DEP-005` | **A3** | Ranking. `grep -rl "Part A3" docs/` → 0 files | Non-blocking — `LCF-FR-075` supplies a default

---

## Compliance statement

This document was produced under an instruction that permitted **no** repository
modification other than its own creation. Specifically:

- It creates **no** bounded context and mints **no** `BC-` identifier.
- It creates **no** ADR and mints **no** ADR number. ⚠ v0.5 named `ADR-0066` as *"the observed
  next free number"*; that observation was **incorrect** and is corrected in §31 — `0066`–`0073`
  are earmarked by `PRD-020` §29.2 and `0069` is marked **DO NOT OPEN**. The governing ADRs are
  **`ADR-0075`**–**`ADR-0078`**, raised under separate Architecture Owner authority.
- It amends **no** architecture artefact, **no** ADR, and **no** Rank 1–5 artefact. In
  particular `MASTER_PRD.md`, `LIBOORA_BOUNDED_CONTEXT_MAP.md`,
  `LIBOORA_ENTERPRISE_ARCHITECTURE.md`, `ARCHITECTURE_RULINGS.md`, `PRD_REGISTRY.md`,
  `CONFIGURATION_GUIDE.md`, `PRD-017_FILE_AND_MEDIA.md` and
  `tool/module_dependencies.yaml` are untouched.
- It does **not** modify `PRD-021A` Part A1 v0.2.
- It mints **no** `PERM-*`, **no** tenant role, and **no** `CFG-*` parameter.
- It copies **no** numeric value from an unranked source.
- It takes **none** of the seven decisions listed above. Each is routed to a named owner.
- It overrides **no** frozen PRD, ADR, Master PRD, Bounded Context Map entry or architecture
  ruling.
- It invents **no** convention. Where a convention was missing — pagination, realtime
  transport, staleness numerics — the absence is recorded and routed rather than filled.
- It preserves the ratified progression: **Library-first → Library Community →
  Same-Library Student Network → future Local/Global Discovery.**
- It keeps Local and Global Discovery outside V1 and outside this part.
- It keeps the public Library Profile / Discovery / Ratings surface entirely separate from
  the private Community surface.
- It introduces **no** duplicate ownership with A1, A3–A8, `BC-10`, Library Membership,
  Library Management, or Files & Media.

**Status: DRAFT. Not frozen. Not approved. Not baselined. Every `LCF-*` identifier is
PROPOSED and UNRATIFIED.**

---

*End of PRD-021A Part A2 v0.3 (DRAFT).*
