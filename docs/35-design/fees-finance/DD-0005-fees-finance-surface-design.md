<!-- LIBOORA Design Doc | DD-0005 | BC-05 Fee & Collection -->

> This document is design documentation. It does not amend product requirements,
> architecture decisions, bounded-context ownership, permissions, or backend
> contracts.
# `DD-0005` — Fees & Finance surface design

| Field | Value |
|---|---|
| **Design Doc** | `DD-0005` |
| **Version** | **v0.1** |
| **Status** | ⛔ **`PROPOSED`** — awaiting approval. ⛔ **NOT approved, NOT frozen, NOT authoritative.** ⛔ This document does **not** claim its own status |
| **Rank** | ⛔⛔ **UNRANKED.** Where this disagrees with any ranked document, **the ranked document wins and this Design Doc is the defect** |
| **Bounded context** | **`BC-05` Fee & Collection** — `[CORE]`, Library Management cluster, tenant-scoped |
| **Subject PRD** | `PRD-008` Revenue & Finance — **`FROZEN` v1.7**, Rank 3, admitted by `ADR-0049` under `BASELINE-2026-08-17-A` |
| ⛔⛔ **Governing V1 payment authority** | **`ADR-0130`** (Rank 2, **Accepted**) — **student payment in V1 is CASH ONLY.** ⛔ This **supersedes in effect** `PRD-008` §6.1 **L209**–**L214**. See §20 |
| **Preceded by** | ⭐ The **BC-05 Fees & Finance Design Readiness Audit**, verdict **READY WITH EXPLICIT DESIGN GAPS**, plus a mandated all-ADR sweep (134 ADRs read, 61 finance-relevant, 18 deciding) |
| **Owner** | UX Architecture Owner *(role, never a personal name)* |
| **External method** | UI/UX Pro Max skill — `nextlevelbuilder/ui-ux-pro-max-skill` @ **`15de38f`**, MIT. ⚠️ **Reference only, subordinate to every Liboora source** |
| **Purpose** | Specify the `BC-05` surfaces precisely enough that a Figma prototype can be built **without inventing UX** |
| **Verdict** | ⭐ **READY WITH EXPLICIT DESIGN GAPS** — §24 |

---

## 1. Document Identity

### 1.1 What this document does

It specifies the **presentation and interaction behaviour** of the surfaces
`PRD-008` requires, at the fidelity a Figma author or a Flutter implementer
needs in order to build without guessing.

### 1.2 ⛔⛔ What this document does NOT do

| ⛔ Not done | Why |
|---|---|
| ⛔ Create a business rule | `PRD-008` is Rank 3; this is UNRANKED |
| ⛔ Create a permission | §23's matrix is closed; `FEE-XC-014` bars inventing one |
| ⛔ Expand V1 | `ADR-0130` narrows V1; ⛔ nothing here widens it |
| ⛔ Resolve a conflict | §20 preserves **2** conflicts unresolved |
| ⛔ Modify a PRD or ADR | **0 bytes** of either changed |
| ⛔ Change BC ownership | `BC-26` keeps reports; `BC-20` keeps SaaS revenue |
| ⛔ Fix implementation deviations | §18 records **5**, fixes **0** |

### 1.3 ⭐⭐ Why `BC-05` needs a Design Doc — and why an earlier instrument said it did not

⛔ `docs/35-design/README.md` recorded `fees-finance/` as ⚪ **NOT REQUIRED**,
reasoning: *"`PRD-008` §42.7 is an express statement of **absence**."*

⭐⭐ **The accepted audit falsified that.** §42.7 is titled *"One app, six UIs
— **no effect on this register**, recorded so the absence is deliberate"*. The
*"absence"* is of **`BC-05` obligations arising from a client-architecture
decision** — ⛔ **not** an absence of surfaces.

| Prior claim | ⭐ Measured | Verdict |
|---|---|---|
| §42.7 proves absence | ⛔ §42.7 is about client architecture | ⛔ **Misread** |
| 1 surface requirement | ⭐ `FEE-FR-062` · `FEE-FR-046` · `FEE-BR-015` are **display mandates** | ⛔ **Contradicted** |

⭐⭐⭐ **Fourth consecutive failure of a naive reading** — `PRD-004`, `PRD-006`,
`PRD-007`, now `PRD-008`. ⚠️ The mode shifted: the first three were bad **word
counts**; this was a **single section read out of context**.

### 1.4 ⭐ Skill disposition — 20 mandated perspectives

Each expert below produced a **finding**, recorded in §22. ⛔ None was decorative.
⭐ **Three refusals are recorded**, because an expert who never declines is not
being consulted.

| # | Perspective | Disposition |
|---|---|---|
| 1 | Product Manager | ⭐ APPLIED — §5 |
| 2 | Business Analyst | ⭐ APPLIED — §8 |
| 3 | UX Researcher | ⚠️ **PARTLY REFUSED** — ⛔ no user research exists in this repository; findings split evidence vs hypothesis |
| 4 | Senior UI/UX Designer | ⭐ APPLIED — §6, §9 |
| 5 | **Psychologist / Behavioural Science** | ⭐ APPLIED — §13 |
| 6 | Behavioural UX / Trust | ⭐ APPLIED — §13.7 |
| 7 | Accessibility | ⚠️ **PARTLY REFUSED** — ⛔ `PRD-008` ratifies **no** a11y requirement; §14 classifies, does not ratify |
| 8 | Information Architect | ⭐ APPLIED — §6.2 |
| 9 | Interaction Designer | ⭐ APPLIED — §12 |
| 10 | Finance / Product Ops | ⭐ APPLIED — §6, §11 |
| 11 | RBAC & Security | ⭐ APPLIED — §7 |
| 12 | SaaS Multi-Tenant Architect | ⭐ APPLIED — §7.4 |
| 13 | Backend / Domain Architect | ⭐ APPLIED — §15 |
| 14 | Data & Analytics | ⭐ APPLIED — §16 |
| 15 | QA / Test Engineer | ⭐ APPLIED — §11, §23 |
| 16 | Customer Success | ⚠️ **PARTLY REFUSED** — market claims marked **hypothesis**, not requirement |
| 17 | India Payments / Compliance | ⭐ APPLIED — §13.8; ⛔ **no legal requirement invented** |
| 18 | Design System | ⭐ APPLIED — §17 |
| 19 | Cross-Feature Consistency | ⭐ APPLIED — §15 |
| 20 | Governance / Documentation | ⭐ APPLIED — §19–§21 |

---

## 2. Authority & Source Order

⭐ Applied in this order. ⛔ A lower rank never overrides a higher one.

| Rank | Source | Applied as |
|---|---|---|
| **1** | `MASTER_PRD.md` — §6 L105–111 roles; `MP-GBR-12` immutability | Role vocabulary; no-mutation rule |
| **2** | ⭐⭐ **`ADR-0130`** Accepted — **cash only V1** | ⛔⛔ **GOVERNS** every payment-method decision |
| **2** | `ADR-0134` Accepted — divergence disclosed, successor determined | §20 conflict text |
| **2** | `ADR-0049` Accepted — `PRD-008` v1.7 baseline | Freeze authority |
| **2** | `ADR-0039`, `ADR-0042`, `ADR-0043` Accepted | Refund V1; Invoice = projection |
| **2** | `ADR-0037` Accepted — cash supported, **server-authoritative** | ⛔ No offline write |
| **2** | ⚠️ `ADR-0046`, `ADR-0047` Accepted — **stale V1 limbs** | §20.2 conflict |
| **3** | **`PRD-008` FROZEN v1.7** | All non-payment-method requirements |
| **4** | BC Map v1.18 L100 / L204 / L374 / L420–422 | Ownership, aggregate, events |
| **6** | Enterprise Architecture | ⚠️ **DESCRIPTIVE ONLY** (`MP-CON-08`) |
| — | `DD-0001`…`DD-0004` | ⚠️ UNRANKED peers — consistency only |
| — | UI/UX Pro Max @ `15de38f` | ⚠️ Methodology only — §17.4 |

⚠️ **Status nuance, resolved by rule.** `PRD-008`'s own Version field reads
*"still DRAFT"*. `PRD_REGISTRY.md` §2.1 governs: *"Freeze is **not
self-declared**… conferred externally by admission to the baseline."*
⭐ It **is** FROZEN. ⛔ Not a conflict.

### 2.1 ⛔ Excluded as authority

| Excluded | Why |
|---|---|
| ⛔ `ADR-0038`, `ADR-0041` | **`PROPOSED`** — ⛔ not authority |
| ⛔ `lib/domain/library/fee/**` | ⛔⛔ **CODE IS NOT PRODUCT AUTHORITY** — §18 |
| ⛔ EA L821–823, L1395–1424 | Rank 6 descriptive |

---

## 3. App Boundary

⭐ Per README §2B.3, all five declarations are stated.

| App | In scope? | Roles | Code home |
|---|---|---|---|
| ⭐ **APP 1 — Student App** | ⭐ **YES** | `TR-4` Student · `TR-5` Parent | `lib/app/student/{student,parent}/` |
| ⭐ **APP 2 — Library App** | ⭐ **YES** | `TR-1` Owner · `TR-2` Manager · `TR-3` Reception | `lib/app/staff/{owner,manager,reception}/` |
| ⛔⛔ **APP 3 — Platform Admin** | ⛔⛔ **NO — 0 surfaces** | — | — |

### 3.1 ⭐⭐ Why APP 3 = 0 — three independent sources

| # | Source | Text |
|---|---|---|
| 1 | **`FEE-XC-016`** | ⛔ *"Perform **any** cross-tenant financial read, write, aggregate or export"* |
| 2 | **§23 role table** | 5 **tenant** roles; ⛔ *"**MUST NOT** be extended"* |
| 3 | **§42.7** | *"a Platform Admin UI compiled into the same binary as the Reception UI **still cannot reach** another tenant's financial records"* |

⛔⛔ **Library Owner ≠ Platform Owner.** `TR-1` Owner holds *"complete business
control"* of **one tenant**. `FEE-XC-001`/`002` bar `BC-05` from `BC-20` SaaS
revenue entirely. ⛔ A platform-level finance view has **no** `BC-05` surface.

### 3.2 ⭐ App-Boundary QA — the 13 checks (README §2B.5)

| # | Check | Result |
|---|---|---|
| 1 | Every surface assigned to exactly one app | ⭐ **PASS** — §6 |
| 2 | Every surface assigned to named roles | ⭐ **PASS** — §7 |
| 3 | No role invented | ⭐ **PASS** — §23's 5 roles only |
| 4 | Parent inside APP 1, not separate | ⭐ **PASS** |
| 5 | Student data scoped to self | ⭐ **PASS** — `FEE-FR-054` |
| 6 | `TR-1`/`TR-2`/`TR-3` differences respected | ⭐ **PASS** — §7.2 |
| 7 | Platform roles separated (`AUTH-2.5`) | ⭐ **PASS** — APP 3 = 0 |
| 8 | Figma preserves boundaries | ⭐ **PASS** — §24.3 |
| 9 | No mixed-role shell | ⭐ **PASS** |
| 10 | Tenant scope explicit | ⭐ **PASS** — §7.4 |
| 11 | Cross-app dependency named | ⭐ **PASS** — §3.3 |
| 12 | No permission inferred from visibility | ⭐ **PASS** — `FEE-XC-014` |
| 13 | Evidence cited per declaration | ⭐ **PASS** |

⭐ **13 of 13 PASS.**

### 3.3 Cross-app dependency

⭐ **One dependency, and it is read-only.** The APP 1 student/parent views are
**read projections of the same `FeeLedger`** that APP 2 staff surfaces write.

⛔⛔ **They MUST NOT share a component.** `FEE-XC-019` bars exposing
*"transactions, payment details, receipts, discounts, balances, **staff notes,
reasons**"* across the boundary. ⭐ A shared widget is how a staff note
eventually renders on a student's screen.

---

## 4. Role Boundary

| Role | App | Scope | Financial capability |
|---|---|---|---|
| `TR-4` **Student** | 1 | ⭐ **self only** | ⛔ **READ ONLY** — `FEE-FR-054`: *"MUST NOT record, confirm, discount, correct or refund any payment"* |
| `TR-5` **Parent** | 1 | ⭐ **`guardianOf` only** | ⛔ **READ ONLY** — `FEE-FR-055`: *"limited to **fee updates for guarded students only**"* |
| `TR-3` **Reception** | 2 | tenant-wide | ⭐ Record cash payment; issue receipt |
| `TR-2` **Manager** | 2 | tenant-wide | ⭐ Above + view facts + correction *(⛔ `FEE-GAP-005`)*; ⛔ **no discount approval by default** |
| `TR-1` **Owner** | 2 | tenant-wide | ⭐ All of the above + fee structure + **sole discount approver by default** |

⛔ **`FEE-FR-053`** — every financial write authorised against **role AND tenant
scope**. ⛔ **`FEE-XC-014`** — ⛔ no new role; ⛔ no capability granted by
dashboard visibility.

---

## 5. Scope / Non-Scope

### 5.1 ⭐ In scope — 16 surfaces

⭐ Derived from `PRD-008` §6.1 **as governed by `ADR-0130`**. See §6.

### 5.2 ⛔ Out of scope — each with its authority

| # | Excluded | Authority | ⛔ Not invented by me |
|---|---|---|---|
| 1 | ⛔⛔ **UPI payment** | **`ADR-0130`** §1.1 | Rank 2 Accepted |
| 2 | ⛔⛔ **Card payment** | **`ADR-0130`** §1.1 | Rank 2 Accepted |
| 3 | ⛔⛔ **Online payment** | **`ADR-0130`** §1.1 | Rank 2 Accepted |
| 4 | ⛔⛔ **Payment gateway** | **`ADR-0130`** §1.1 | Rank 2 Accepted |
| 5 | ⛔ Webhook reconciliation | `ADR-0130` §7 supersedes §6.1 L214 | Rank 2 |
| 6 | ⛔ Payment verification *(rail)* | `ADR-0130` §7 supersedes §6.1 L213 | Rank 2 |
| 7 | ⛔ Bank transfer | `ADR-0043` §4 | Product Owner |
| 8 | ⛔ Partial payment | `FEE-XC-004`, `FEE-BR-013` | Frozen PRD |
| 9 | ⛔ Cash-drawer reconciliation | `NG-8` — **V2** | EA tier |
| 10 | ⛔⛔ **Dashboards, reports, exports** | **`FEE-XC-012`/`013`** — ⭐ **`BC-26` owns** | Frozen PRD |
| 11 | ⛔ SaaS revenue / commission | `FEE-XC-001`/`002`/`023` | Frozen PRD |
| 12 | ⛔ Platform finance view | `FEE-XC-016` — APP 3 = 0 | Frozen PRD |
| 13 | ⛔ Tax / GST | `NG-2` — V3 | EA |
| 14 | ⛔ Named fee taxonomy | ⛔ `FEE-GAP-004` — **no approved list exists** | Gap |
| 15 | ⛔ Risk / fraud / trust scores | `FEE-XC-021` | Frozen PRD |
| 16 | ⛔ Offline financial write | `FEE-XC-022`, `ADR-0037` | Rank 2 |

⛔⛔ **Correcting a `NOT REQUIRED` row does not enlarge V1.** `ADR-0130`
**narrows** it, and this document narrows with it.

---

## 6. Surface Inventory

### 6.1 ⭐ The 16 surfaces

⭐ IDs `F1`…`F16` are **local to this document**. ⛔ They are not requirement
identifiers and create nothing.

| ID | Surface | App | Status | Source |
|---|---|---|---|---|
| **`F1`** | Fee structure definition | 2 | ⚠️ **PARTIALLY DESIGNABLE** | §10; ⛔ `FEE-GAP-004` |
| **`F2`** | Fee obligation raise | 2 | ⭐ **DESIGNABLE** | §11, `E-07` |
| **`F3`** | ⭐⭐ Cash payment capture | 2 | ⭐ **DESIGNABLE** | §13, **`ADR-0130`**, `FEE-BR-010` |
| **`F4`** | Receipt | 1+2 | ⭐ **DESIGNABLE** | §16, §29.4 |
| **`F5`** | Invoice *(issued document)* | 1+2 | ⭐ **DESIGNABLE** | §12, §29.3 |
| **`F6`** | ⭐⭐ Itemised payment breakdown | 1 | ⭐ **DESIGNABLE** | **`FEE-FR-062`**, `FEE-AC-083` |
| **`F7`** | Discount application | 2 | ⚠️ **PARTIALLY DESIGNABLE** | §17; ⛔ `FEE-GAP-007` |
| **`F8`** | Refund record | 2 | ⚠️ **PARTIALLY DESIGNABLE** | §18.1, `ADR-0039`; ⛔ approver undetermined |
| **`F9`** | Correction / adjustment | 2 | ⛔ **BLOCKED** | ⛔⛔ `FEE-GAP-005` |
| **`F10`** | Student financial profile | 1 | ⭐ **DESIGNABLE** | `FEE-FR-045`/`046` |
| **`F11`** | Outstanding / overdue dues | 1+2 | ⭐ **DESIGNABLE** | `FEE-FR-047`/`048` |
| **`F12`** | Financial history | 1+2 | ⭐ **DESIGNABLE** | `FEE-FR-049`…`051` |
| **`F13`** | Parent fee-updates view | 1 | ⭐ **DESIGNABLE** | `FEE-FR-055`, `FEE-AC-058` |
| **`F14`** | Student fee list *(staff view)* | 2 | ⭐ **DESIGNABLE** | §19, §20 |
| **`F15`** | ⚠️ Reconciliation queue | 2 | ⛔ **NOT V1** *(scope collapsed)* | §20.1 |
| **`F16`** | ⛔ Online payment initiation | 1 | ⛔ **NOT V1** | **`ADR-0130`** |

**Totals — ⭐ 10 DESIGNABLE · ⚠️ 3 PARTIAL · ⛔ 1 BLOCKED · ⛔ 2 NOT V1.**

### 6.2 ⭐ Information architecture

```
APP 2 — LIBRARY APP                    APP 1 — STUDENT APP
├── Finance                            ├── My Fees
│   ├── F14 Student fee list           │   ├── F10 Financial profile
│   │     └── F2  Raise obligation     │   │     ├── F11 Outstanding
│   │     └── F3  Record cash payment  │   │     └── F6  Itemised breakdown
│   │           └── F4 Receipt         │   ├── F12 History
│   │     └── F7  Apply discount       │   ├── F4  Receipt (read)
│   │     └── F8  Record refund        │   └── F5  Invoice (read)
│   │     └── F9  Correction ⛔BLOCKED  │
│   ├── F5  Invoice                    └── (Parent)
│   ├── F11 Outstanding / overdue          └── F13 Fee updates — guardianOf
│   └── F12 History                              (read-only projection)
└── Settings
    └── F1  Fee structure ⚠️PARTIAL

⛔ NOT PRESENT: dashboards/reports (BC-26) · F15 · F16 · APP 3
```

⭐ **Rationale (Information Architect):** finance is reached **through the
student**, not as a parallel ledger tree. `FEE-XC-010` holds only a
`StudentRecordId`, so a finance-first tree would need identity `BC-05` does not
own.

---

## 7. Role × Surface × Permission Matrix

### 7.1 ⭐⭐ The matrix — derived strictly from `PRD-008` §23.1

⛔ **Consumed, never invented.** ⭐ `—` = surface **absent**, not disabled.

| # | Surface | `TR-4` Student | `TR-5` Parent | `TR-3` Reception | `TR-2` Manager | `TR-1` Owner | APP 3 |
|---|---|---|---|---|---|---|---|
| 1 | `F1` Fee structure | — | — | — | — | ⭐ **define/amend** | ⛔ — |
| 2 | `F2` Raise obligation | — | — | — | ⭐ raise | ⭐ raise | ⛔ — |
| 3 | `F3` Cash payment capture | — | — | ⭐ **record** | ⭐ record | ⭐ record | ⛔ — |
| 4 | `F4` Receipt | 👁 own | 👁 guarded | ⭐ **issue** | ⭐ issue | ⭐ issue | ⛔ — |
| 5 | `F5` Invoice | 👁 own | 👁 guarded | 👁 | 👁 | 👁 | ⛔ — |
| 6 | `F6` Itemised breakdown | 👁 **own** | 👁 guarded | — | — | — | ⛔ — |
| 7 | `F7` Discount | — | — | — | ⛔ **none by default** | ⭐ **sole approver** | ⛔ — |
| 8 | `F8` Refund | — | — | — | ⚠️ TBD | ⚠️ TBD | ⛔ — |
| 9 | `F9` Correction | — | — | — | ⛔ BLOCKED | ⛔ BLOCKED | ⛔ — |
| 10 | `F10` Financial profile | 👁 **self only** | — | 👁 | 👁 | 👁 | ⛔ — |
| 11 | `F11` Outstanding dues | 👁 own | 👁 guarded | 👁 | 👁 | 👁 | ⛔ — |
| 12 | `F12` History | 👁 own | ⚠️ TBD | 👁 | 👁 | 👁 | ⛔ — |
| 13 | `F13` Parent fee updates | — | 👁 **guardianOf** | — | — | — | ⛔ — |
| 14 | `F14` Student fee list | — | — | 👁 | 👁 | 👁 | ⛔ — |
| 15 | `F15` Reconciliation queue | ⛔ NOT V1 | ⛔ | ⛔ | ⛔ | ⛔ | ⛔ — |
| 16 | `F16` Online payment | ⛔ NOT V1 | ⛔ | ⛔ | ⛔ | ⛔ | ⛔ — |

⭐ **`TR-2` Manager has NO discount approval by default** — §23.1: *"`owner` —
**sole approver by default**. `manager` has **NO approval access by default**"*.
⛔ The design must not render an approve control for Manager.

### 7.2 ⭐ The three staff roles are not one role

| Role | Sees | Does |
|---|---|---|
| `TR-3` Reception | student fee list, dues, receipts | ⭐ **record cash, issue receipt** — nothing else |
| `TR-2` Manager | + tenant financial facts | + raise obligation; ⛔ **no discount approval** |
| `TR-1` Owner | + fee structure | + define pricing, **approve discount** |

⛔ **Not one screen with greyed controls** (README §2B.4 check 6).

### 7.3 ⭐⭐ Absent vs disabled — the rule

| Situation | Treatment |
|---|---|
| Role never holds the operation | ⭐⭐ **ABSENT** — ⛔ not rendered disabled |
| Role holds it, precondition unmet | ⭐ **DISABLED** + reason |
| Operation blocked by a gap | ⭐ **ABSENT** + no promise of a future control |

⛔ **Non-disclosing denial.** A student must never learn another student's
financial state from an error message. `FEE-XC-019` bars cross-disclosure.

### 7.4 ⭐ Tenant isolation

| Scope | Rule |
|---|---|
| Tenant | ⛔ **`FEE-XC-016`** — ⛔ any cross-tenant read/write/aggregate/export |
| Student | ⛔ `FEE-FR-054` — `TR-4` self only |
| Guardian | ⛔ `FEE-FR-055` — `guardianOf` only |
| Event | ⭐ *"Event with no tenant context → **fail loudly, never default**"* (§34) |

⭐⭐ **No cross-student financial leakage** is structurally required, not a
design preference: `FEE-INV-006`-class scoping plus `FEE-XC-016`.

---

## 8. Requirement Traceability

⭐ Format: **Design Decision → Source → Requirement/Constraint → Status**.
⛔ No identifier is invented; every `FEE-*` below was read in `PRD-008`.

| # | Design decision | Source | Requirement / Constraint | Status |
|---|---|---|---|---|
| 1 | `F3` offers **cash only** | **`ADR-0130`** §1.1 | Rank 2 Accepted | ⭐ **SUPPORTED** |
| 2 | `F3` confirms **immediately**, no pending step | `PRD-008` §29.2 | `FEE-BR-010` — cash enters `CONFIRMED` directly | ⭐ **SUPPORTED** |
| 3 | `F6` itemises and never collapses | §16.1 | **`FEE-FR-062`**, `FEE-AC-083` | ⭐ **SUPPORTED** |
| 4 | `F6` shows **no** commission/gateway/tax line | §16.1 | `FEE-AC-083` verifies **absence** | ⭐ **SUPPORTED** |
| 5 | `F10` shows 5 components + derived balance | §19 | `FEE-FR-046` | ⭐ **SUPPORTED** |
| 6 | Balance never rendered as a stored ratio | §20 | `FEE-INV-009`, `FEE-XC-009` | ⭐ **SUPPORTED** |
| 7 | ⛔ `MeterBar` prohibited | §20 | `FEE-INV-009` *"never stored independently"* | ⭐ **SUPPORTED** |
| 8 | `F11` overdue computed as predicate | §20 | `FEE-FR-048`, `FEE-BR-022` | ⭐ **SUPPORTED** |
| 9 | `F12` offers no edit/delete affordance | §21 | `FEE-FR-051`, `FEE-XC-011` | ⭐ **SUPPORTED** |
| 10 | `F4` receipt has **one** state | §29.4 | *"no second receipt state"* | ⭐ **SUPPORTED** |
| 11 | `F4` wrong receipt → compensating record | §29.4 | `FEE-FR-037` | ⭐ **SUPPORTED** |
| 12 | `F5` invoice is a **projection**, not a machine | §29.3 | `ADR-0043` §6 | ⭐ **SUPPORTED** |
| 13 | `F5` shows underlying `FeeDue` state, not just `ISSUED` | §29.3 | *"`OVERDUE` is not lost — it is read from the `FeeDue`"* | ⭐ **SUPPORTED** |
| 14 | `F7` shows original, discount, payable **separately** | §17.1 | `FEE-BR-017` | ⭐ **SUPPORTED** |
| 15 | `F7` has **no** percentage ceiling control | §17.1 | `FEE-BR-018` — ⛔ *"**No** maximum… is specified"* | ⭐ **SUPPORTED** |
| 16 | `F7` absent for Manager by default | §23.1 | *"`manager` has **NO** approval access by default"* | ⭐ **SUPPORTED** |
| 17 | `F8` refund is full-amount only | §18.1, §29.5 | `FEE-FR-042`, `FEE-BR-019` | ⭐ **SUPPORTED** |
| 18 | `F8` has no refund status chip | §29.5 | *"no `PARTIALLY_REFUNDED`, no `REFUND_PENDING`"* | ⭐ **SUPPORTED** |
| 19 | `F9` absent, not disabled | §23.1, §34 | ⛔ `FEE-GAP-005` | ⛔ **GAP** |
| 20 | `F13` limited to `guardianOf` | §23.1 | `FEE-FR-055`, `FEE-AC-058` | ⭐ **SUPPORTED** |
| 21 | `F13` shows no staff note or reason | §32 | `FEE-XC-019` | ⭐ **SUPPORTED** |
| 22 | ⛔ No risk/defaulter badge anywhere | §32 | `FEE-XC-021` | ⭐ **SUPPORTED** |
| 23 | ⛔ No partial-payment field | §13.6 | `FEE-XC-004`, `FEE-BR-013` | ⭐ **SUPPORTED** |
| 24 | ⛔ No dashboard or report surface | §22 | `FEE-XC-012`/`013` — `BC-26` owns | ⭐ **SUPPORTED** |
| 25 | ⛔ No offline capture affordance | §28 | `FEE-XC-022`, `ADR-0037` | ⭐ **SUPPORTED** |
| 26 | ⛔ No fee-type picker with named types | §10 | ⛔ `FEE-GAP-004` | ⛔ **GAP** |
| 27 | Loading / empty / success visuals | — | ⛔ **no source** | ⚠️ **TBD** — `DD5-TBD-004` |
| 28 | Token values | `theme.dart` | ⚠️ unratified | ⚠️ **TBD** — `DD5-TBD-001` |
| 29 | Accessibility standard | `ACCESSIBILITY.md` | ⚠️ *"RECOMMENDED… Target TBD"* | ⚠️ **TBD** — `DD5-TBD-002` |
| 30 | *"Fee updates"* scope for Parent | §23.1 | ⚠️ term undefined | ⚠️ **TBD** — `DD5-TBD-005` |

⭐ **26 SUPPORTED · 2 GAP · 4 TBD — ⛔ 0 unsupported product decisions.** §23.2.

---

## 9. User Flows

⭐ **9 flows.** ⛔ Each maps to a surface and a source; none invents a step.

| # | Flow | Surfaces | Source | Status |
|---|---|---|---|---|
| `FL1` | Owner defines a fee structure | `F1` | §10 | ⚠️ PARTIAL |
| `FL2` | Obligation raised from membership | `F2` | `E-07`, §11 | ⭐ DESIGNABLE |
| `FL3` | ⭐⭐ **Reception records a cash payment → receipt** | `F14`→`F3`→`F4` | **`ADR-0130`**, `FEE-BR-010`, §16 | ⭐ DESIGNABLE |
| `FL4` | Owner approves a discount before settlement | `F14`→`F7` | `FEE-FR-038`…`041` | ⚠️ PARTIAL |
| `FL5` | Refund recorded against a confirmed payment | `F8` | `FEE-FR-042` | ⚠️ PARTIAL |
| `FL6` | Student views own dues and breakdown | `F10`→`F11`→`F6` | `FEE-FR-045`/`046`/`062` | ⭐ DESIGNABLE |
| `FL7` | Student opens a receipt | `F12`→`F4` | §16, §21 | ⭐ DESIGNABLE |
| `FL8` | Parent views a guarded student's fee updates | `F13` | `FEE-FR-055` | ⭐ DESIGNABLE |
| `FL9` | Staff reviews a student's financial history | `F14`→`F12` | `FEE-FR-049`…`051` | ⭐ DESIGNABLE |

### 9.1 ⭐⭐ `FL3` — the load-bearing flow

```
F14 Student fee list
      │  staff selects the student   [TR-3 / TR-2 / TR-1]
      ▼
F3  Record cash payment
      │  ⭐ CASH is the ONLY method offered        ← ADR-0130 §1.1
      │  ⛔ NO UPI / card / online / gateway tab
      │  ⭐ amount = FULL payable                   ← FEE-BR-013
      │  ⛔ NO partial-amount field                 ← FEE-XC-004
      │  ⭐ idempotency key at API edge             ← FEE-FR-029
      ▼
   CONFIRMED  ⭐ immediately — cash has no rail     ← FEE-BR-010
      │  ⛔ no PENDING step is shown
      ▼
F4  Receipt ISSUED  ⭐ single state, immutable      ← §29.4
      │  ⛔ no VOID / CANCEL control                ← FEE-XC-007
      ▼
fee.FeePaymentReceived  →  BC-02 · BC-26 · BC-24 · BC-22
```

⚠️ **Design consequence of cash-only, stated:** `FL3` has **no failure branch
from a payment rail**, because there is no rail. ⛔ The only failures are input
validation and authorisation — ⛔ **a rail-failure UI must not be designed.**

---

## 10. State Model

### 10.1 ⭐ The 9 states — all source-backed

| Machine | States | Source |
|---|---|---|
| **`FeeDue`** | `DUE` · `OVERDUE` · `PAID` · `CANCELLED` | §29.1 |
| **`FeePayment`** | `PENDING` · `CONFIRMED` · `FAILED` · `CANCELLED` | §29.2 |
| **Receipt** | `ISSUED` | §29.4 |
| **Invoice** | ⛔⛔ **NOT a machine** — 3 projected labels | §29.3, `ADR-0043` §6 |
| **Refund** | ⛔ **no state table, deliberately** | §29.5 |

⛔⛔ **No `PARTIALLY_PAID`.** §29.1 and `FEE-BR-013`.

### 10.2 ⛔ Forbidden transitions the design must make unreachable

| Forbidden | Source | Design consequence |
|---|---|---|
| `PAID → DUE`/`OVERDUE`/`CANCELLED` | §29.1 | ⛔ no "reopen" control on a paid due |
| `CANCELLED → *` | §29.1 | ⛔ no "restore" control |
| `CONFIRMED → *` | `MP-GBR-12` | ⛔ no edit/delete on a confirmed payment |
| `FAILED → CONFIRMED` | §29.2 | ⛔ no "retry into success" |
| Amount rewrite | `FEE-INV-002` | ⛔ no editable amount after issue |
| Receipt edit/delete | `FEE-XC-007` | ⛔ no void control |

### 10.3 ⚠️⚠️ A measured consequence of cash-only — disclosed, not resolved

⭐ `FEE-BR-010`: cash enters `CONFIRMED` **directly**. ⛔ `ADR-0130` removes
every non-cash rail from V1.

⚠️⚠️ **Therefore `PENDING` and `FAILED` may have no reachable V1 trigger.**

⛔ **I do not delete them.** They are `PRD-008` §29.2 states in a FROZEN
document, and a Design Doc cannot remove a state. ⭐ Recorded as
**`DD5-GAP-003`** for the Product Owner, and the design **renders them if the
system produces them** rather than assuming it cannot.

### 10.4 Invoice projection

| Label | Projects from | Design rule |
|---|---|---|
| `ISSUED` | `DUE` **or** `OVERDUE` | ⭐⭐ **The label does not distinguish them.** `F5` **MUST** also show the underlying `FeeDue` state, or `OVERDUE` is lost to the reader — §29.3 |
| `PAID` | `PAID` | — |
| `CANCELLED` | `CANCELLED` | — |

---

## 11. Edge Cases

⭐ **All 14 from `PRD-008` §34, each dispositioned.** ⚠️ Two are re-scoped by
`ADR-0130`, and that is disclosed rather than silently dropped.

| # | Scenario | Required outcome | Surface | Disposition |
|---|---|---|---|---|
| 1 | Payment confirmed, membership activation fails | Payment **stands**; ledger authoritative | `F3`,`F4` | ⭐ **DESIGNED** — receipt issues; ⛔ no rollback offered |
| 2 | Payment for a voided membership | Activation refused; refund decision by `BC-05` | `F8` | ⛔ **BLOCKED** — `FEE-GAP-001` approver |
| 3 | Duplicate payment **callback** | No second payment/receipt/event | — | ⚠️ **NO V1 TRIGGER** — callbacks are gateway-only; `ADR-0130` |
| 4 | Client shows success, rail never confirms | Stays `PENDING`; no receipt | — | ⚠️ **NO V1 TRIGGER** — no rail; `ADR-0130` |
| 5 | Device offline at collection | ⛔ Online payment **MUST NOT** succeed | `F3` | ⭐ **DESIGNED** — ⛔ no offline queue; `ADR-0037` |
| 6 | Fee structure changed after obligation raised | Existing obligation **unchanged** | `F1`,`F2` | ⭐ **DESIGNED** — `F1` states this before saving |
| 7 | **Wrong amount entered** | ⛔ no authorised correction path | `F9` | ⛔⛔ **BLOCKED** — `FEE-GAP-005` |
| 8 | Student archived with outstanding dues | Archival **blocked** with domain error | `F11` | ⭐ **DESIGNED** — `FEE-INV-004` |
| 9 | Discount exceeds original amount | Rejected | `F7` | ⭐ **DESIGNED** — `FEE-INV-007` |
| 10 | **Two staff record the same cash payment** | Idempotency key; duplicate surfaced | `F3` | ⚠️ **PARTIAL** — ⭐ key applies (`FEE-FR-029`); ⛔ the *surfacing* half needed `F15`, now not V1 |
| 11 | **Student pays ₹500 of ₹2000** | ⛔ **No V1-legal representation** | `F3` | ⛔⛔ **BLOCKED** — `FEE-XC-004`, `FEE-GAP-008` |
| 12 | Cash drawer disagrees with ledger | Out of V1 scope | — | ⛔ **NOT V1** — `NG-8` |
| 13 | Event arrives twice from `E-07` | Idempotent on `eventId` | `F2` | ⭐ **DESIGNED** — invisible to the user |
| 14 | Event with no tenant context | **Fail loudly, never default** | all | ⭐ **DESIGNED** — ⛔ no silent fallback |

**Totals — ⭐ 8 DESIGNED · ⚠️ 3 re-scoped/partial · ⛔ 3 BLOCKED/NOT V1.**

### 11.1 ⚠️⚠️ Wrong-student risk — measured as absent

⛔ **`PRD-008` §34 contains no wrong-student edge case.** The Psychologist and
QA reviewers both raised it (§13.4). ⛔ I do **not** add it — that would invent a
requirement. ⭐ Recorded as **`DD5-GAP-002`**.

---

## 12. Failure & Recovery States

| Failure | Source | Recovery | Status |
|---|---|---|---|
| Discount > original | `FEE-INV-007` | Reject inline, keep entry | ⭐ DESIGNED |
| Refund > received | BC Map L374 *"refund ≤ received"* | Reject inline | ⭐ DESIGNED |
| Archive with dues | `FEE-INV-004` | Domain error, stay on screen | ⭐ DESIGNED |
| Wrong amount after confirm | ⛔ `FEE-GAP-005` | ⛔⛔ **NONE EXISTS** | ⛔ BLOCKED |
| Wrong receipt issued | `FEE-FR-037` | ⭐ Compensating record — ⛔ not a void | ⭐ DESIGNED |
| Authorisation denied | `FEE-FR-053` | Non-disclosing message | ⭐ DESIGNED |
| Missing tenant context | §34 | ⭐ **Fail loudly** | ⭐ DESIGNED |
| Loading state | ⛔ no source | — | ⚠️ **TBD** `DD5-TBD-004` |
| Empty state | ⛔ no source | — | ⚠️ **TBD** `DD5-TBD-004` |
| Success confirmation | ⛔ no source | — | ⚠️ **TBD** `DD5-TBD-004` |

⛔⛔ **Loading, empty and success states remain TBD.** ⛔ `PRD-008` specifies
none, and inventing them here would create requirements. ⭐ §17.3 records
*methodology* guidance for them, explicitly **not** as requirements.

---

## 13. Psychology & Behavioural Science Review

⛔⛔ **AUTHORITY LIMIT, STATED FIRST.** The Psychologist has **no authority**
over product scope, business rules, permissions, pricing or governance. ⭐ Every
row below is one of: **PRD REQUIREMENT** *(already required)*, **DESIGN
GUIDANCE** *(presentation only)*, or **GAP/TBD** *(unsupported — escalated, not
implemented)*.

### 13.1 ⭐ Student

| Dimension | Finding | Class |
|---|---|---|
| **Financial anxiety** | ⛔⛔ **`FEE-GAP-008` is the largest risk in this module.** A student who pays ₹500 of ₹2000 gets **no record at all** (`FEE-XC-004`). They paid, and the screen is unchanged | ⛔ **GAP** |
| **Uncertainty** | ⭐ `FEE-FR-047` derives balance as `Σ dues − Σ receipts`, so the number is always recomputable and never stale | ⭐ **PRD REQUIREMENT** |
| **Payment confirmation** | ⭐ Cash confirms immediately (`FEE-BR-010`) — ⭐ no waiting, no ambiguity. ⛔ But no success visual is specified | ⭐ PRD + ⚠️ **TBD** |
| **Overdue interpretation** | ⛔⛔ *"Due reminder and overdue notifications… are **not** backed by any event"* (§26). A student can become `OVERDUE` **silently** | ⛔ **GAP** |
| **Dignity / privacy** | ⭐⭐ `FEE-XC-021` bars **any** risk score, fraud score, trust score, blacklist or watchlist. ⭐ A student in arrears **cannot be flagged** | ⭐ **PRD REQUIREMENT** |
| **Cognitive load** | ⭐ `FEE-FR-046` names 5 components + balance = 6 elements; ⚠️ ordering unspecified | ⚠️ **DESIGN GUIDANCE** |

### 13.2 ⭐ Parent

| Dimension | Finding | Class |
|---|---|---|
| **Fee clarity** | ⭐ `FEE-FR-062` itemisation applies to any student-facing breakdown | ⭐ **PRD REQUIREMENT** |
| **Trust** | ⭐ `FEE-BR-017` keeps original, discount and payable independently visible — ⛔ a parent cannot be shown a rounded single figure | ⭐ **PRD REQUIREMENT** |
| ⚠️ **"Fee updates" interpretation** | ⛔ Master PRD L111 grants *"fee updates"*; ⛔ **the term is nowhere defined.** Does a parent see the overdue amount? the receipt? the discount reason? | ⚠️ **TBD** `DD5-TBD-005` |
| **Outstanding understanding** | ⭐ Same derived figure as the student's — ⛔ no second computation | ⭐ **PRD REQUIREMENT** |
| **Privacy boundaries** | ⭐⭐ `FEE-XC-019` bars staff notes and reasons; `FEE-FR-055` bars any non-guarded student | ⭐ **PRD REQUIREMENT** |

### 13.3 ⭐ Reception — the highest-pressure role

| Dimension | Finding | Class |
|---|---|---|
| **Payment-entry load** | ⭐⭐ **Cash-only V1 sharply reduces it** — one method, no rail, no pending state. ⭐ An unintended benefit of `ADR-0130` | ⭐ **PRD/ADR-derived** |
| ⚠️ **Wrong-student risk** | ⛔⛔ Real and **unaddressed**: money is irreversible (`MP-GBR-12`) and ⛔ **no correction path exists** (`FEE-GAP-005`). ⭐ `FL3` enters via `F14` *(student first, then amount)*, which reduces but does not remove it | ⛔ **GAP** `DD5-GAP-002` |
| ⚠️ **Wrong-amount risk** | ⛔⛔ Same irreversibility, same missing correction | ⛔ **GAP** `FEE-GAP-005` |
| **Confirmation confidence** | ⭐ `FEE-BR-015`: *"**deliberately not hidden behind a fake atomic button**"* — ⭐ the PRD's own anti-dark-pattern stance | ⭐ **PRD REQUIREMENT** |
| **Error recovery** | ⭐ `FEE-FR-037` compensating record only — ⛔ never an edit | ⭐ **PRD REQUIREMENT** |
| **Duplicate-payment risk** | ⭐ `FEE-FR-029` idempotency key; ⚠️ the *surfacing* half relied on `F15` | ⚠️ **PARTIAL** |
| **Busy-counter pressure** | ⚠️ Plausible in Indian libraries at month-start; ⛔ **no repository evidence** | ⚠️ **HYPOTHESIS** |

### 13.4 ⭐ Manager

| Dimension | Finding | Class |
|---|---|---|
| **Reconciliation confidence** | ⚠️⚠️ `F15` is **not V1** under `ADR-0130`. ⛔ The Manager has no queue surface in V1 | ⚠️ **Re-scoped** |
| **Exception handling** | ⛔ The two live exceptions (wrong amount, voided-membership refund) are **both blocked** | ⛔ **GAP** |
| **Information overload** | ⭐ `FEE-XC-012`/`013` keep aggregation out of `BC-05` — ⭐ the Manager sees **facts**, not analytics | ⭐ **PRD REQUIREMENT** |
| **Correction workflow** | ⛔⛔ **Does not exist** — `FEE-GAP-005` | ⛔ **GAP** |

### 13.5 ⭐ Owner

| Dimension | Finding | Class |
|---|---|---|
| **Financial oversight** | ⭐ Owner sees tenant financial **facts** (§23.1); ⛔ dashboards are `BC-26`'s | ⭐ **PRD REQUIREMENT** |
| **Discount decisions** | ⭐ Sole approver by default; ⛔ **no ceiling** exists to lean on (`FEE-BR-018`) — ⭐ the design must present the **full context** (original, discount, payable, reason) rather than a threshold warning | ⭐ PRD + ⚠️ **GAP** `FEE-GAP-007` |
| **Refund decisions** | ⚠️ V1 scope decided (`ADR-0039`); ⛔ the **approver role** is still undetermined | ⛔ **GAP** `FEE-GAP-001` |
| **Ledger trust** | ⭐⭐ `FEE-FR-051` — history is **not editable or deletable**; `FEE-XC-011` bars purging. ⭐ The strongest trust guarantee in the module | ⭐ **PRD REQUIREMENT** |

### 13.6 ⭐ Cross-cutting

| Dimension | Finding | Class |
|---|---|---|
| **Payment hesitation** | ⭐ Largely out of V1 scope — cash is staff-mediated at a counter | ⚠️ **HYPOTHESIS** |
| **Dark-pattern risk** | ⭐⭐ **Structurally near-zero.** With only **3** `fee.*` events and ⛔ **no** reminder event, dunning pressure **cannot be built** within V1. ⛔ The design **MUST NOT** invent nagging to fill that silence | ⭐ **PRD-derived** |
| **Unnecessary pressure** | ⭐ No risk badge, no defaulter list, no score (`FEE-XC-021`) | ⭐ **PRD REQUIREMENT** |

### 13.7 ⭐ Behavioural UX / Trust

⭐⭐ **Convergence finding.** `PRD-008` independently reaches dignity-preserving
positions: mandatory itemisation · no collapsed charges · no scores or
blacklists · no reminder events · an append-only immutable history · an
explicit refusal to hide failure *"behind a fake atomic button"*.

⭐ **The design's job here is restraint, not addition.**

### 13.8 ⭐ India Payments / Compliance — audited, nothing invented

| Item | Repository position |
|---|---|
| ⭐ Currency / time | INR + IST (`MP-CON-12` precedent, `ANL-FR-037`) |
| ⭐ V1 method | ⛔⛔ **CASH ONLY** — `ADR-0130` |
| ⛔ Gateway / provider | ⛔ **No V1 provider.** `ADR-0130` §5 supersedes `ADR-0046`'s Razorpay V1 limb |
| ⛔ Tax / GST | ⛔ **V3** (`NG-2`) — ⛔ `FEE-AC-083` verifies a tax line is **absent** |
| ⛔ Retention | ⛔ **Undefined** — `FEE-GAP-011`; ⛔ *"no period invented"* |
| ⛔ Legal requirements | ⛔⛔ **NONE INVENTED.** ⛔ No statute, RBI rule or GST obligation is asserted anywhere in this document |

⚠️ **Refusal recorded (expert 17):** I was asked to audit India payments/
compliance. ⛔ I decline to state any legal requirement, because **no repository
source establishes one** and inventing compliance rules is more dangerous than
omitting them.

---

## 14. Accessibility Review

⛔⛔ **`PRD-008` ratifies NO accessibility requirement.** Measured: **0**
accessibility identifiers in its registers.

| Class | Item | Status |
|---|---|---|
| ⛔ **RATIFIED** | *(none)* | ⛔⛔ **ZERO** |
| ⚠️ **METHODOLOGY** | `docs/design/ACCESSIBILITY.md` — *"Color is never the only carrier of status, error, selection, or availability"* | ⚠️ *"RECOMMENDED — pending formal approval"* |
| ⚠️ **METHODOLOGY** | ProMax #36 contrast 4.5:1 · #37 colour-only · #43/#54 form labels · #22 touch 48dp Android | ⚠️ External reference |
| ⚠️ **TBD** | Target standard | ⚠️ *"**TO BE DECIDED**"* — `DD5-TBD-002` |
| ⚠️ **TBD** | Minimum touch target | ⚠️ `DD5-TBD-003` |

### 14.1 ⚠️⚠️ The colour-only risk is acute here

⭐ `DUE` · `OVERDUE` · `PAID` · `CANCELLED` are **four states a user must
distinguish in a financial context**, where misreading has money consequences.

⚠️ **METHODOLOGY guidance** *(⛔ not ratified, ⛔ not a requirement)*: pair every
state with a **text label**, ⛔ never colour alone.

⛔ **I cannot mandate this** — no ratified standard exists. ⭐ Recorded so the
Accessibility Owner can ratify or reject it.

### 14.2 Measured implementation baseline

⭐ **0** occurrences of `Semantics`, `semanticsLabel`, `meetsGuideline` or
`textScaleFactor` under `lib/`; **0** accessibility assertions under `test/`
(`DIT-007`). ⛔ Stated as fact, ⛔ not as a defect this document may fix.

---

## 15. Cross-Context Dependencies

| BC | Direction | Edge | ⭐ Design rule |
|---|---|---|---|
| `BC-01` Enrollment | consumes | `E-09` | ⛔ **`FEE-XC-010`** — hold a **`StudentRecordId` reference only**. ⛔ No finance surface may render a student attribute `BC-05` does not own |
| `BC-02` Membership | consumes / publishes | `E-07` / `E-10` | ⭐ Obligation raised from a membership price snapshot; ⛔ `MM-XC-004` forbids a second ledger |
| ⛔⛔ **`BC-03` Attendance** | ⛔ **NONE** | ⛔ | ⛔⛔ **`FEE-XC-003`** — ⛔ *"Derive a fee obligation from **attendance, presence**…"* **FORBIDDEN** |
| ⛔⛔ **`BC-04` Seating** | ⛔ **NONE** | ⛔ | ⛔⛔ **`FEE-XC-003`** — ⛔ *"…or **seat occupancy**"* **FORBIDDEN** |
| `BC-06` Library Policy | consumes | `E-06` | Operating rules |
| `BC-22` Notification | publishes | `E-23` | ⭐ Facts only — ⛔ *"never 'send an SMS'"* |
| `BC-24` Audit | publishes | `E-20` | ⛔ `FEE-XC-015` — ⛔ never local, never synchronous |
| `BC-26` Analytics | publishes | — | ⭐ **`BC-26` owns reports** — §16 |

### 15.1 ⛔⛔ The prohibited coupling — stated because it is counter-intuitive

⭐ `DD-0003` and `DD-0004` are joined by a presence↔allocation contract.
⛔⛔ **`BC-05` has the opposite relationship: NO coupling is permitted.**

> `FEE-XC-003` — ⛔ *"Derive a fee obligation from attendance, presence or seat occupancy."*

⛔ **Therefore no finance surface may display an attendance or seat fact as a
financial driver**, and ⛔ no seat or attendance surface may show a fee
consequence. ⭐ A *"you were absent, so you owe…"* rendering is **forbidden**.

### 15.2 Consistency with `DD-0001`…`DD-0004`

| Check | Result |
|---|---|
| Header format | ⭐ Matches all four |
| `PROPOSED` / UNRANKED | ⭐ Matches |
| App-boundary declaration | ⭐ Matches `DD-0003`/`DD-0004`; ⚠️ `DD-0001`/`DD-0002` predate §2B |
| APP 3 = 0 | ⭐ Third consecutive DD to measure this |
| Conflict preservation | ⭐ Matches `DD-0004`'s treatment of `SEAT-CONFLICT-001` |
| Token substitution | ⭐ Same `DBT-001` substitution as all four |

---

## 16. Finance ↔ Analytics Boundary

| Concern | Owner | Authority |
|---|---|---|
| Financial **facts** — dues, payments, receipts, discounts, refunds, history | ⭐ **`BC-05`** | BC Map L100 / L374 |
| Certified **metrics** | ⛔ **`BC-26`** | ⛔ `FEE-XC-012` |
| Reporting **store** | ⛔ **`BC-26`** | ⛔ `FEE-XC-013` |
| **Dashboards** | ⛔ **Not a context** — composition | BC Map L84 |
| **Exports** | ⛔ **`BC-26`** | BC Map L135 |
| SaaS revenue | ⛔ **`BC-20`** | ⛔ `FEE-XC-001`/`002` |

⛔⛔ **`DD-0005` therefore contains NO dashboard, NO report and NO export
surface.** ⭐ `PRD-008` §22 is explicit: *"This draft claims no report as a V1
deliverable of `BC-05`; **it delivers facts**."*

⛔ **No duplicate ownership is created.**

---

## 17. Design-System Dependencies

### 17.1 Tokens — consumed, ⛔ never invented

⭐ `LiblColors` and `LiblSpace` (`lib/app/shared/theme.dart`) are the only token
sources. ⚠️ **Their values are unratified** — the same `DBT-001` substitution
carried by `DD-0001`…`DD-0004`. ⛔ **No new token is defined here.**

### 17.2 Components

| Component | Use | Status |
|---|---|---|
| `PanelCard`, `SectionHeader`, `Pill`, `Monogram`, `EmptyState`, `MetricTile` | reusable | ⭐ EXISTS |
| ⛔⛔ **`MeterBar`** | ⛔⛔ **PROHIBITED** | ⛔ `FEE-INV-009` — the balance is *"never stored independently"*; a fraction bar asserts a stored ratio. ⭐ Same prohibition `DD-0004` applied for `SEAT-FR-245` |

⭐ **4 new components PROPOSED** *(⛔ design-level only, ⛔ no product effect)*:
`AmountRow` *(itemised line — `FEE-FR-062`)* · `StateChip` *(text + colour, ⛔ never colour alone)* · `LedgerEntry` *(append-only history row)* · `ReceiptDocument` *(immutable document render)*.

### 17.3 ⭐ UI/UX Pro Max Review

⚠️ Reference only, `15de38f`, MIT. ⛔ **No adopted principle becomes a product
requirement.** ⛔ Framework rows targeting Flutter **3.44.x** are not applicable
(Liboora is **3.35.4**), and its Riverpod guidance is **REJECTED** (measured
dependency is **Provider 6.1.5+1**).

| Principle | Relevance to Finance | Decision | Reason |
|---|---|---|---|
| #54 Input labels — visible, never placeholder-only | Amount / reason fields on `F3`, `F7` | ⭐ **ADOPT** | Design treatment only; ⛔ no requirement created |
| #55 Error placement — inline, per-field | `FEE-INV-007` discount rejection | ⭐ **ADOPT** | Presents an existing rule |
| #56 Inline validation on blur | Amount entry | ⭐ **ADAPT** | ⛔ Must not imply partial amounts are valid (`FEE-XC-004`) |
| #32 Loading buttons — disable to prevent double submit | ⭐⭐ Duplicate cash entry | ⭐ **ADOPT** | Complements `FEE-FR-029`; ⛔ does not replace it |
| #34 Success feedback | `F3` → `F4` | ⚠️ **TBD** | ⛔ No success state specified — `DD5-TBD-004` |
| #35 Confirmation dialogs for irreversible actions | ⭐⭐ Payments are irreversible (`MP-GBR-12`) | ⭐ **ADOPT** | ⛔ Presentation only; ⛔ creates no approval step |
| #10 Loading states / skeletons | All list surfaces | ⚠️ **TBD** | ⛔ Unspecified — `DD5-TBD-004` |
| #19 Content jumping — reserve space | Async amounts shifting | ⭐ **ADOPT** | ⭐ Acute where the figure is money |
| #36 Contrast 4.5:1 | All financial text | ⚠️ **TBD** | ⛔ No ratified a11y standard — `DD5-TBD-002` |
| #37 Colour-only | ⭐⭐ 4 `FeeDue` states | ⭐ **ADOPT as methodology** | ⚠️ Cannot be mandated — §14.1 |
| #22 Touch target 48dp Android | Counter use, one-handed | ⚠️ **TBD** | ⛔ No ratified minimum — `DD5-TBD-003` |
| #23 Touch spacing 8px | Adjacent money actions | ⭐ **ADAPT** | ⭐ Maps to `LiblSpace.sm` |
| #30 Active / pressed state | Payment confirm control | ⭐ **ADOPT** | Feedback only |
| #24 Gesture conflicts — avoid horizontal swipe | ⛔ Swipe-to-delete on a ledger row | ⭐ **ADOPT** | ⭐ Reinforces `FEE-XC-011` — history is not deletable |
| #27 Haptic feedback | Payment confirmation | ⚠️ **TBD** | ⛔ Unverified on low-end Android |
| #6 Breadcrumbs | — | ⛔ **REJECT** | Web pattern; ⛔ Liboora is mobile-first |
| #46–#53 Web performance | — | ⛔ **REJECT** | ⛔ Web-only; not applicable |
| #7/#8 Riverpod state management | — | ⛔⛔ **REJECT** | ⛔ Contradicts the measured **Provider** dependency |

⭐ **7 ADOPT · 3 ADAPT · 4 REJECT · 5 TBD.**

### 17.4 2D / 2.5D / 3D

| Treatment | Use | Count |
|---|---|---|
| ⭐ **2D** | All ledger, list, form and state surfaces | **14** |
| ⭐ **2.5D** | `F4` Receipt and `F5` Invoice only — ⭐ modest elevation so they read as **documents** | **2** |
| ⛔⛔ **3D** | ⛔ **NONE** | **0** |

⛔ **3D has no use case in finance.** Money is read, compared and trusted; ⛔
depth adds no information and risks implying a physicality the ledger lacks.

---

## 18. Implementation Deviations

⛔⛔ **CODE IS NOT PRODUCT AUTHORITY.** Recorded as **evidence**; ⛔ **none is
fixed here**, and ⛔ none becomes a requirement.

| ID | Location | Deviation | Violates |
|---|---|---|---|
| ⛔⛔ **`AIV-F01`** | `fee_ledger.dart` L126 | `static const int maxUnapprovedPercent = 20` — a hard-coded discount ceiling | ⛔⛔ **`FEE-BR-018`** — *"**No** maximum discount percentage, ceiling or range is specified"*; `FEE-GAP-007` **OPEN** |
| ⛔⛔ **`AIV-F02`** | `fee_ledger.dart` L19 | `enum PaymentMode { cash, upi, card, bankTransfer, cheque }` | ⛔⛔ **`ADR-0130`** — ⭐ **only `cash` is V1-lawful**; `bankTransfer` excluded by `ADR-0043` §4; ⛔ `cheque` appears in **no** source |
| ⛔ **`AIV-F03`** | `fee_ledger.dart` L17 | `enum FeeCategory { membership, seat, locker, lateFee, security, other }` | ⛔ `FEE-GAP-004` — **no approved taxonomy**; ⛔ `locker`/`lateFee`/`security` invented |
| ⚠️ **`AIV-F04`** | `fee_ledger.dart` L81 | `Receipt.isRefund` boolean | ⚠️ Refund modelled as a receipt **flag**, not the `RefundRecord` BC Map L374 names |
| ⛔ **`AIV-F05`** | `fee_ledger.dart` | ⛔ **No `FeeDue` state field** — no `DUE`/`OVERDUE`/`PAID`/`CANCELLED` | ⛔ §29.1's 4-state machine is **not implemented** |

⚠️ **Design consequence:** these surfaces are specified against **`PRD-008` as
governed by `ADR-0130`**, ⛔ **not** against the current code. ⭐ An implementer
will find the code offers **5** payment modes where the design offers **1** —
⭐ **the design is right and the code is the defect.**

⛔ **Test status stated plainly:** `flutter test` was **NOT run** for this
document; it was written by **inspection**. ⛔ **0** surface tests exist for
`BC-05`.

---

## 19. Gaps

### 19.1 ⛔ BLOCKING (1)

| ID | Blocks | Owner |
|---|---|---|
| ⛔⛔ **`FEE-GAP-005`** | `F9` Correction — ⛔ *"no authorised correction path exists"* for a mis-entered obligation. ⭐ With cash-only plus `MP-GBR-12` immutability, this is now the **only** route out of a keying error | Product Owner |

### 19.2 ⚠️ NON-BLOCKING (6)

| ID | Effect |
|---|---|
| `FEE-GAP-001` | Refund **approver role** undetermined → `F8` partial |
| `FEE-GAP-004` | ⛔ No fee taxonomy → `F1` cannot offer named types |
| `FEE-GAP-007` | ⛔ No discount ceiling → `F7` shows context, ⛔ not a threshold |
| `FEE-GAP-008` | ⛔ Partial payment unrepresentable → §13.1's largest anxiety risk |
| `FEE-GAP-011` | ⛔ Retention undefined → ⛔ no archival affordance |
| `FEE-GAP-017` | Cash-only library cannot pay commission → ⛔ **NOT resolved** by `ADR-0130` |

### 19.3 ⭐ New design-side gaps

| ID | Gap |
|---|---|
| ⭐ **`DD5-GAP-001`** | ⛔⛔ **No overdue/reminder notification exists.** §26: *"Due reminder and overdue notifications… are **not** backed by any event."* A student may go `OVERDUE` **silently**. ⛔ I do **not** add a fourth event — `FEE-XC-017` forbids it |
| ⭐ **`DD5-GAP-002`** | ⛔ **No wrong-student edge case** in §34, despite irreversible money and no correction path |
| ⭐ **`DD5-GAP-003`** | ⚠️ `FeePayment.PENDING`/`FAILED` may have **no reachable V1 trigger** under cash-only — §10.3 |

---

## 20. Conflicts

⛔⛔ **PRESERVED, NOT RESOLVED.** ⭐ Each states the four mandated parts.

### 20.1 ⛔⛔ `FEE-CONFLICT-001` — V1 payment methods

| Part | Content |
|---|---|
| ⭐ **1. GOVERNING V1 RULE** | **`ADR-0130`** (Rank 2, **Accepted**, 2026-09-10): *"Student payment in V1 is **cash only**. UPI, card, online payment and gateway are **V2**."* |
| ⛔ **2. CONFLICTING LOWER-RANKED REQUIREMENT** | **`PRD-008` §6.1** (Rank 3, **FROZEN** v1.7) lists as **V1 in scope**: **L209** UPI payment · **L210** Card payment · **L211** Online payment · **L213** Payment verification · **L214** Webhook reconciliation |
| ⭐ **3. DESIGN CONSEQUENCE** | ⭐ `F3` offers **cash only**. ⛔ `F16` online payment is **NOT V1**. ⛔ `F15` reconciliation queue is **NOT V1** — `FEE-BR-015` governs *"payments whose **rail state** and ledger disagree"*, and ⛔ **cash has no rail**. ⚠️ §34 edge cases **3** and **4** lose their V1 trigger. ⚠️ `MP-GBR-18` idempotency *"by gateway reference"* is **AMENDED**; `MP-RSK-04` duplicate capture is **RE-SCOPED to V2** |
| ⛔ **4. UNRESOLVED GOVERNANCE REPAIR** | ⛔⛔ **A `PRD-008` v1.8 successor amendment is DETERMINED but NOT EXECUTED** (`ADR-0134` §3; recorded **outstanding** at `ADR-0130` §9). ⛔ **Not authorised here.** ⛔ `PRD-008` is **byte-unchanged** |

⛔ **This document does not choose.** Precedence chose:
`DOCUMENTATION_BASELINE.md` §4 ranks Rank 2 above Rank 3. ⛔ Designing
`PRD-008` §6.1's rows would be designing a **superseded** requirement.

### 20.2 ⛔ `FEE-CONFLICT-002` — stale V1 limbs, a discoverability defect

| Part | Content |
|---|---|
| ⭐ **1. GOVERNING V1 RULE** | `ADR-0130` §5 — ⛔ *"There is **no V1 payment gateway** for student payment, so there is **no V1 provider**."* |
| ⛔ **2. CONFLICTING LOWER-RANKED REQUIREMENT** | ⚠️⚠️ Not lower-ranked — **equal rank, superseded in part.** ⭐ **`ADR-0046`** (Accepted): *"The V1 payment gateway provider is **Razorpay**"*. ⭐ **`ADR-0047`** (Accepted): authored `PRD-019` §4, *"the V1 payment webhook contract"*. ⛔ **Neither file records its own supersession** — only `ADR-0130` §5 does, one-directionally |
| ⭐ **3. DESIGN CONSEQUENCE** | ⛔ **No gateway, provider, webhook or verification surface** is designed. ⚠️ A reader who opens `ADR-0046` alone sees a **live V1 decision** that is not live |
| ⛔ **4. UNRESOLVED GOVERNANCE REPAIR** | ⛔ A back-reference in `ADR-0046`/`ADR-0047` is **owed** to the Architecture Owner. ⛔ **Not performed here** — `ADR-INDEX.md` L206: *"**Never edit an Accepted ADR's decision text**"*. ⭐ This is the **same discoverability failure** `ADR-0134` was written to close for `PRD-008`, now repeated one level up |

---

## 21. TBDs

| ID | Item | Owner |
|---|---|---|
| `DD5-TBD-001` | ⛔ Token values unratified (`DBT-001`) | Design Owner |
| `DD5-TBD-002` | ⛔⛔ Accessibility standard — *"TO BE DECIDED"* | Accessibility Owner |
| `DD5-TBD-003` | ⛔ Minimum touch target | Design Owner |
| `DD5-TBD-004` | ⛔ Loading / empty / success states | Product + Design |
| `DD5-TBD-005` | ⛔ *"Fee updates"* scope for `TR-5` Parent | Product Owner |
| `DD5-TBD-006` | ⛔ Ordering of `FEE-FR-046`'s 5 components | Design Owner |
| `DD5-TBD-007` | ⛔ Receipt document format — ⛔ **I decline to assume PDF** (`ANL-GAP-014` precedent) | Product Owner |
| `DD5-TBD-008` | ⛔ Overdue visual treatment, absent any notification | Product + Design |

---

## 22. Expert Findings / Sign-off Matrix

| # | Expert | Finding | Where |
|---|---|---|---|
| 1 | Product Manager | ⭐ V1 **narrowed** by `ADR-0130`; ⛔ 16 exclusions each with authority | §5.2 |
| 2 | Business Analyst | ⭐ 30 decisions traced: 26 supported, 2 gap, 4 TBD | §8 |
| 3 | UX Researcher | ⚠️ **REFUSAL** — ⛔ no user research exists; 3 items marked hypothesis | §13.3, §13.6 |
| 4 | Senior UI/UX Designer | ⭐ 16 surfaces, 2-app IA, ⛔ no finance-first tree | §6 |
| 5 | **Psychologist** | ⭐ Per-role analysis ×5 + cross-cutting; ⛔ 0 new requirements | §13 |
| 6 | Behavioural UX / Trust | ⭐ Convergence: the PRD is already dignity-preserving | §13.7 |
| 7 | Accessibility | ⚠️ **REFUSAL** — ⛔ 0 ratified requirements; 4-state colour risk flagged | §14 |
| 8 | Information Architect | ⭐ Finance reached **through the student** (`FEE-XC-010`) | §6.2 |
| 9 | Interaction Designer | ⭐ 9 flows; ⚠️ 3 state classes TBD | §9, §12 |
| 10 | Finance / Product Ops | ⭐ Cash-only collapses `F15`; ⛔ correction path missing | §20.1, §19.1 |
| 11 | RBAC & Security | ⭐ 16×6 matrix; ⭐ Manager has **no** discount approval | §7.1 |
| 12 | Multi-Tenant Architect | ⭐ `FEE-XC-016` absolute; ⭐ APP 3 = 0 | §3.1, §7.4 |
| 13 | Backend / Domain Architect | ⭐ Balance derived, never stored ⇒ ⛔ `MeterBar` prohibited | §17.2 |
| 14 | Data & Analytics | ⭐ `BC-26` owns reports; ⛔ 0 dashboards here | §16 |
| 15 | QA / Test Engineer | ⭐ 14 edge cases dispositioned; ⛔ **0** surface tests exist | §11, §18 |
| 16 | Customer Success | ⚠️ **REFUSAL** — market claims marked hypothesis, not requirement | §13.3 |
| 17 | India Payments / Compliance | ⛔⛔ **No legal requirement invented**; cash-only recorded | §13.8 |
| 18 | Design System | ⭐ 6 components reused, 4 proposed, ⛔ 1 prohibited | §17 |
| 19 | Cross-Feature Consistency | ⛔⛔ `FEE-XC-003` forbids attendance/seat coupling | §15.1 |
| 20 | Governance / Documentation | ⭐ 2 conflicts preserved; ⛔ 0 PRD/ADR bytes changed | §20 |

⛔ **No expert signed off on readiness.** ⭐ This is a findings matrix, ⛔ not an
approval.

---

## 23. Designability Matrix

### 23.1 Surfaces

| Class | Count | IDs |
|---|---|---|
| ⭐ **DESIGNABLE NOW** | **10** | `F2` `F3` `F4` `F5` `F6` `F10` `F11` `F12` `F13` `F14` |
| ⚠️ **PARTIALLY** | **3** | `F1` `F7` `F8` |
| ⛔ **BLOCKED** | **1** | `F9` |
| ⛔ **NOT V1** | **2** | `F15` `F16` |

### 23.2 ⭐⭐ Zero-unsupported-decisions check

| Question | Result |
|---|---|
| Design decisions recorded | **30** (§8) |
| ⭐ Mapped to PRD / ADR / architecture | **26** |
| ⛔ Marked GAP | **2** |
| ⚠️ Marked TBD | **4** |
| ⛔⛔ **Unsupported product decisions** | ⭐⭐ **0** |

| Prohibition | Result |
|---|---|
| ⛔ New business rule created? | ⭐ **NO** |
| ⛔ New permission created? | ⭐ **NO** |
| ⛔ V1 expanded? | ⭐ **NO** — `ADR-0130` narrowed it |
| ⛔ Conflict resolved silently? | ⭐ **NO** — 2 preserved |
| ⛔ PRD/ADR modified? | ⭐ **NO** — 0 bytes |
| ⛔ BC ownership changed? | ⭐ **NO** |
| ⛔ Psychology changed scope? | ⭐ **NO** — §13 classifies only |

---

## 24. Readiness Classification

> ## ⭐⭐ **READY WITH EXPLICIT DESIGN GAPS**

### 24.1 Why not `NOT READY`

| Test | Result |
|---|---|
| Surfaces enumerable from authority? | ⭐ **YES** — 16, each traced |
| Flows specified? | ⭐ **YES** — 9 |
| States fixed by source? | ⭐ **YES** — 9 across 5 machines |
| Edge cases dispositioned? | ⭐ **YES** — 14 of 14 |
| Permissions authoritative? | ⭐ **YES** — closed 10-row §23.1 |
| App boundary determinate? | ⭐ **YES** — APP 3 = 0 from 3 sources |
| Most of it designable now? | ⭐ **YES** — **10 of 16** |

### 24.2 Why not `READY`

| Blocker | Scope |
|---|---|
| ⛔ `FEE-GAP-005` | 1 surface (`F9`) |
| ⛔⛔ `FEE-CONFLICT-001` | Every payment surface's provenance |
| ⛔ `FEE-CONFLICT-002` | Gateway/webhook discoverability |
| ⚠️ `DD5-TBD-001`/`002` | Tokens + a11y standard |
| ⚠️ 3 `DD5-GAP-*` | Measured source silences |

### 24.3 ⛔⛔ Figma gate — **NOT OPEN**

⛔ **No Figma file exists** — the same repository fact as `DD-0001`…`DD-0004`.
⛔ **The gate is not opened by this document existing.**

| # | Blocker | Owner |
|---|---|---|
| 1 | ⚠️ `DD5-TBD-001` — ⛔ no ratified token values | Design Owner |
| 2 | ⚠️⚠️ `DD5-TBD-002` — ⛔⛔ `PRD-008` ratifies **no** accessibility requirement, and 4 `FeeDue` states risk colour-only encoding | Accessibility Owner |
| 3 | ⛔⛔ `FEE-CONFLICT-001` — ⭐ a payment-capture prototype must either show UPI/card per the **FROZEN PRD**, or omit them per the **governing ADR**. ⛔ **Both are wrong** without the substitution approved | Product + Architecture Owner |
| 4 | ⛔ `FEE-GAP-005` — ⛔ a correction surface cannot be prototyped from nothing | Product Owner |
| 5 | ⛔ This document is `PROPOSED`, not approved | Product Owner |

⛔ **This document creates no Figma file, frame, component library or token.**
⛔ **Figma output is never authority over PRD or ADR.**

### 24.4 ⛔⛔ What this document does NOT claim

| ⛔ Not claimed | Why |
|---|---|
| ⛔⛔ **APPROVED** | Status is `PROPOSED` |
| ⛔⛔ **FROZEN** | UNRANKED; freeze is conferred |
| ⛔⛔ **CONFLICT-FREE** | ⛔ **2 open conflicts** — §20 |
| ⛔⛔ **IMPLEMENTATION-READY** | ⛔ 5 deviations · 1 blocking gap · 8 TBDs |
| ⛔⛔ **TESTED** | ⛔ Written by inspection; `flutter test` **not run**; **0** surface tests |
| ⛔ **Figma-open** | ⛔ 5 blockers — §24.3 |

---

## 25. Changelog

| Version | Date | Change |
|---|---|---|
| ⭐ **v0.1** | 2026-09-17 | **Created.** First Design Doc for `BC-05`. 16 surfaces `F1`…`F16` · 9 flows · 9 states / 5 machines · 14 edge cases · 10-row permission matrix · 30 traced decisions. ⭐ Written after the **BC-05 Readiness Audit** and a mandated **134-ADR sweep** which discovered ⛔⛔ **`ADR-0130`** — cash-only V1 — materially narrowing the audit's original surface set *(`F15`, `F16` withdrawn from V1)*. ⭐ 2 conflicts preserved **unresolved**; 5 implementation deviations recorded **unfixed**; ⛔ **0 bytes** of any PRD or ADR changed |
