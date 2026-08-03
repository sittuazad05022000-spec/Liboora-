# Library PRD — Organization & Library Management

> **STATUS — COMPLETE AND FROZEN.**
> Sections 1–25 were received on 2026-08-03, validated, and are authoritative as **Library PRD v1.0**.
> Two normative extensions (§14A, §14B) and the Invitation Security Specification complete the domain.
>
> Declared into the documentation baseline as **`BASELINE-2026-08-03`** §2.1.
> Precedence **Rank 3** — the same rank the Authentication PRD holds for `BC-18`.

---

## 1. The documents

Four are **normative**. Two are records and carry no authority.

| File | Contents | Status |
|---|---|---|
| [`Library_PRD_v1.md`](./Library_PRD_v1.md) | **The Library baseline.** §§1–25 · ~130 `LIB-n.m` requirements · `LBR-1`…`LBR-8` · `LXC-1`…`LXC-10` · `LAC-1`…`LAC-12` · `LCFG-1`…`LCFG-10` · `LEV-1`…`LEV-22` · §26 ownership boundary | ✅ **Normative — v1.0** |
| [`14A-Library-Discovery-And-Enrollment.md`](./14A-Library-Discovery-And-Enrollment.md) | Discovery & enrollment · `LIB-DISC-001`…`013` · **the public field allow-list (§14A.5)** | ✅ **Normative — v1.0** |
| [`14B-Public-Library-Preview.md`](./14B-Public-Library-Preview.md) | Anonymous preview · `LIB-14B.1`…`51` · the closed protected-operation list `PO-1`…`PO-12` · intent preservation · `LCFG-11`…`LCFG-13` | ✅ **Normative — v1.0** |
| [`INVITATION_SECURITY_SPECIFICATION.md`](./INVITATION_SECURITY_SPECIFICATION.md) | `INV-SEC-001`…`071` · types `IT-1`…`IT-3` · entropy, expiry, revocation, single use, validation, audit, rate limiting · `ICFG-1`…`ICFG-10` · `IAC-1`…`IAC-25` | ✅ **Normative — v1.0** |
| [`LIBRARY_PRD_ALIGNMENT.md`](./LIBRARY_PRD_ALIGNMENT.md) | Validation record — the fourteen conflicts found, what changed, what deliberately did not | 📋 Record — **not** specification |
| [`REVIEW_14A.md`](./REVIEW_14A.md) | The 2026-08-02 review of §14A, with every finding's disposition | 📋 Record — **not** specification |

**"The Library PRD" means all four normative documents**, never one alone. A requirement read in isolation from the
other three will be implemented wrongly — most of the security-relevant constraints are cross-references.

---

## 2. Where to start

| You are | Read, in order |
|---|---|
| Implementing the module | [`DEVELOPER_HANDOFF.md`](../../40-implementation/DEVELOPER_HANDOFF.md) §4A → the four normative documents → [`LIBRARY_IMPLEMENTATION_TASKS.md`](../../40-implementation/LIBRARY_IMPLEMENTATION_TASKS.md) |
| Reviewing the specification | `Library_PRD_v1.md` §0 (how to read) → `LIBRARY_PRD_ALIGNMENT.md` |
| Deciding a configuration value | [`CONFIGURATION_GUIDE.md`](../../20-configuration/CONFIGURATION_GUIDE.md) §2A, §2B |
| Checking a boundary | `Library_PRD_v1.md` §26 → [`LIBOORA_BOUNDED_CONTEXT_MAP.md`](../../10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md) |

---

## 3. The two decisions worth knowing before reading anything

### `ADR-0009` — an invitation is a claim, not a credential

> *A scoped, revocable, expiring claim to be offered a role or an enrollment opportunity — never a credential.*

Possession of an invitation must never authenticate anybody. If it did, forwarding a WhatsApp message would
**transfer an identity**, and the platform would have a second authentication factor that is routinely pasted into
group chats. That defeats `MP-GBR-25`, `ADR-0002` and `ADR-0004` at once.

### `ADR-0010` — public information is served anonymously from a projection

Anyone may browse branding, gallery, facilities, membership plans, coarse seat availability and operating hours
**without logging in**. This does not relax tenant isolation: the preview reads a projection containing only the
§14A.5 allow-list. `MP-GBR-08`, `X-13` and deny-by-default (`AP-3`) are untouched.

---

## 4. Ownership

**Library Discovery & Enrollment is not a bounded context** (`AR-1`). It is an application-level read composition —
no aggregate, no invariant, no business state. It composes `BC-19` Tenancy, `BC-25` Configuration, `BC-29` File &
Media, `BC-06` Library Policy, `BC-02` Membership and `BC-04` Seating through `BC-23` Search Indexing. The
bounded-context count remains **31 (23 in V1)**.

**"Library" is ambiguous and the code must not use it unqualified.** Bounded Context Map §5:

| Term | Is | Owned by |
|---|---|---|
| `TenantOrganisation` | The billing entity — the customer | `BC-19` Tenancy `[GENERIC]`, rank 4 |
| `Branch` | The physical location with opening hours and seats | `BC-06` Library Policy `[CORE]`, rank 8 |

The PRD title *"Organization **&** Library Management"* spans both, which was raised as `CC-3` during the §14A
review and resolved by `AR-1`: Discovery composes both clusters and owns neither, so no ownership moves and no data
is duplicated. §26 of the PRD carries the full ownership table — **changing it is an architecture change requiring an
ADR** (`LIB-26.2`).

**Model `branchId` on every core record from the first migration**, even though V1 ships one branch per
organisation. Multi-branch is **V3**; adding the column later is a migration across every core table.

---

## 5. Implementation status — nothing is built

| | |
|---|---|
| Specification | ✅ Complete, frozen, baselined |
| Code | ❌ **None.** No tenancy module, no library aggregate, no public projection, no invitation mechanism |
| Tasks | 23 open — `IMPL-100`…`IMPL-127`, 12 at P0 within the module |

A complete specification is not progress toward a shipped module; it is permission to start. The tasks are in
[`LIBRARY_IMPLEMENTATION_TASKS.md`](../../40-implementation/LIBRARY_IMPLEMENTATION_TASKS.md) with acceptance
criteria and per-task traps.

**`IMPL-020` — SMS provider and DLT registration — is on this module's critical path.** An `IT-1` staff invitation is
delivered by SMS. DLT approval is an external, multi-week process, and it should be started before any Library code
is written.

---

## 6. How this document came to be frozen

Recorded because the custody history is the reason the specification can be trusted.

On 2026-08-02 the product owner supplied a document described as *"Sections 1–25 + Section 14A"*. The message body
contained **only §14A**; the line naming sections 1–25 was a title label, not content. Their absence was verified
mechanically — a content grep across all `*.md`, `*.txt` and `*.yaml`, a filename search across `/home/user`, and a
scan of every blob in the Git object store — all returning zero hits. The sections had never existed in the
repository. They were recorded as **not received** (finding `U-4` / `R-H`), and **not reconstructed**, because
inventing unverifiable requirements is precisely the failure this process exists to prevent.

On 2026-08-03 the sections were supplied. They are preserved in `Library_PRD_v1.md`.

**`U-4` is therefore closed by receipt, not by authorship** — the distinction that separates it from `D-7`, where
the Authentication PRD had to be written from scratch because the original was unrecoverable. Every requirement in
the supplied text survives. Fourteen conflicts against higher-ranked documents were found and corrected, three of
them blocking; each correction and its reasoning is in `LIBRARY_PRD_ALIGNMENT.md` §2. Nothing was removed.

### Capture rule — still in force

`14A-Library-Discovery-And-Enrollment.md` is a **faithful capture** and remains byte-for-byte as received. Nothing
was added, removed, reordered, reworded, normalised or summarised. All commentary lives in `REVIEW_14A.md` so the
captured text is never contaminated. The same rule governs `Library_PRD_v1.md`: corrections are recorded in the
alignment document, and where the supplied text was merely *differently organised* from the rest of the corpus it
was left alone.

---

## 7. Change history

| Date | Change |
|---|---|
| 2026-08-03 | **Sections 1–25 received, validated and frozen as Library PRD v1.0.** §14B and the Invitation Security Specification authored. `ADR-0009` and `ADR-0010` accepted. `U-4`/`R-H`, `CC-5`, `CC-6`, `CC-7` and the `AR-4` deferral closed. Admitted to the documentation baseline at Rank 3 as `BASELINE-2026-08-03`. This README rewritten from a partial-receipt notice to the frozen index; the custody history is preserved in §6. |
| 2026-08-02 | Rulings `AR-1`…`AR-4` applied to architecture documentation. `CC-1`, `CC-2`, `CC-4` (architecture level) and `CC-7` (ownership) resolved. §14A text unchanged. |
| 2026-08-02 | Directory created. §14A captured verbatim. Enterprise review published. §§1–25 recorded as not received. |
