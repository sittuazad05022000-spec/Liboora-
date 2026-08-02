# Library PRD — Organization & Library Management

> **STATUS — PARTIAL RECEIPT. NOT FROZEN.**
> Section 14A has been received verbatim and reviewed.
> **Sections 1–25 have NOT been received into this workspace.**
>
> **Architecture rulings `AR-1`…`AR-4` have been applied** — see
> [`../../architecture/ARCHITECTURE_RULINGS.md`](../../architecture/ARCHITECTURE_RULINGS.md).
> Four of the seven review conflicts are resolved at the architecture level.
> The §14A text itself is **unchanged** — the rulings settled ownership and classification, not requirements.

## Documents

| File | Contents | Status |
|---|---|---|
| [`14A-Library-Discovery-And-Enrollment.md`](./14A-Library-Discovery-And-Enrollment.md) | Section 14A — Library Discovery & Enrollment, 13 subsections, 13 business rules `LIB-DISC-001`…`LIB-DISC-013`, 10 acceptance criteria | ✅ Captured verbatim |
| [`REVIEW_14A.md`](./REVIEW_14A.md) | Enterprise review of §14A against the seven authoritative sources | ✅ Complete |
| `01-25-*.md` | Sections 1–25 | ❌ **NOT RECEIVED** |

## Why sections 1–25 are absent

The product owner's message declared the document to be *"Sections 1–25 + Section 14A"* and *"the complete and latest approved Library PRD."*
The message body contained **only the text of section 14A**. The line

```
Library PRD
Sections 1–25
+
Section 14A (latest enterprise version)
```

is a **title label**, not section content. No text for sections 1 through 25 was present.

Verified absent from the workspace before this file was written:

| Search performed | Result |
|---|---|
| `grep -rl 'Organization & Library Management\|Library PRD'` over all `*.md` `*.txt` `*.yaml` | zero hits |
| `find /home/user -iname '*librar*'` (excluding build, `.git`, pub-cache, Flutter SDK) | no project file |
| Scan of every blob in the Git object store for `Organization & Library Management` | zero hits |

Sections 1–25 have therefore **never existed in this repository**. They were not lost; they were never supplied.
They are not reconstructed here, because reconstructing unverifiable requirements is forbidden by the
Enterprise Development Guardrails (*"Do not invent requirements"*, *"Do NOT rely on conversation memory"*).

## Capture rule

`14A-Library-Discovery-And-Enrollment.md` is a **faithful capture**. Nothing in the owner's text was added,
removed, reordered, reworded, normalised or summarised. All review findings live in `REVIEW_14A.md` so that
the captured document is never contaminated by commentary.

## Ownership — settled by ruling `AR-1`

**Library Discovery & Enrollment is not a bounded context.** It is an application / read composition capability
of the Library domain. It owns **no aggregate, no invariant and no business state**; it orchestrates public read
models and delegates every domain operation to the owning module. Registered as **module 19** in
`MASTER_PRD.md` §8, marked *not a context*. Bounded-context count remains **31 (23 in V1)**.

Related rulings: `AR-2` Authentication owns registration and account creation on first successful OTP ·
`AR-3` the public discovery directory is not a tenant data index · `AR-4` invitations are owned by
Library Management / Tenant Organization.

## Ownership caveat recorded during review

The document title *"Organization **&** Library Management"* spans **two bounded-context clusters**:

- **"Organization"** → `BC-19` Tenancy `[GENERIC]`, Shared Core, module `platform/tenancy`, rank 4
- **"Library Management"** → `BC-01`…`BC-06` `[CORE]`, module `domain/library`, rank 8

Binding resolution, Bounded Context Map §5 line 200:

> **`Library`** — BC-19: the tenant organisation (billing entity) · BC-06: a physical branch with hours and seats →
> **`TenantOrganisation` (BC-19)** vs **`Branch` (BC-06)**

A single PRD spanning two owners at two ranks was flagged as `CC-3` in the review. **Resolved by `AR-1`:**
Discovery composes both clusters as read models and owns neither, so no ownership is transferred and no data is
duplicated. The wording corrections in §14A.5 / §14A.7 / `LIB-DISC-007` remain outstanding for the next PRD
revision.

## Change history

| Date | Change |
|---|---|
| 2026-08-02 | Directory created. §14A captured verbatim. Enterprise review published. §1–25 recorded as not received. |
| 2026-08-02 | Rulings `AR-1`…`AR-4` applied to architecture documentation. `CC-1`, `CC-2`, `CC-4` (architecture level) and `CC-7` (ownership) resolved. §14A text unchanged. |
