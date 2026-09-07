# Student Identity & Profile — Module Index

**Owning context:** `BC-10` Global Person Identity `[CORE]`, rank 7.5
**Baseline:** `BASELINE-2026-08-04`
**Precedence:** Rank 3, alongside Authentication PRD v2.0 and Library PRD v1.0

---

## What this module is

The **Global Person Identity** is one person's permanent identity across the whole LIBOORA education
ecosystem. It is created atomically with their authentication account, it outlives every organisation
they join or leave, and it is reused unchanged by future School, College and Coaching products.

It is **not** a social profile. Social features consume it; they are never the reason it exists.

```
Authentication Account          (AccountId,  BC-18, rank 4)
        │ 1 ──── 1   mandatory · atomic · never orphaned
        ▼
Global Person Identity          (PersonId,   BC-10, rank 7.5)   ← THIS MODULE
        │ 1 ──── 0..*
        ├──► Student Record — Library A     (StudentRecordId, BC-01, tenant-scoped)
        ├──► Student Record — Library B     (StudentRecordId, BC-01, tenant-scoped)
        └──► School / College / Coaching    (Future)

        ▲ consumed by, never owned by
        └── BC-11 Social Graph · BC-12 Messaging · BC-13 Trust & Safety
```

## Documents

| Document | Purpose |
|---|---|
| [`Student_Identity_PRD_v1.md`](./Student_Identity_PRD_v1.md) | The specification. Chapters 1–5, all registers |
| [`STUDENT_IDENTITY_ALIGNMENT.md`](./STUDENT_IDENTITY_ALIGNMENT.md) | 13 conflicts reconciled; 11 accepted, **2 rejected** with reasons |
| [`ADR-0011`](../../00-governance/adr/ADR-0011-global-person-identity.md) | The identity architecture decision |
| [`STUDENT_IDENTITY_IMPLEMENTATION_TASKS.md`](../../40-implementation/STUDENT_IDENTITY_IMPLEMENTATION_TASKS.md) | `IMPL-200`+ — what remains to be built |

## Chapter map

| Chapter | Contents |
|---|---|
| §0 | How to read; register index; relationship to the supplied draft |
| 1 | Purpose, responsibilities owned and **not** owned, `SXC-1`…`SXC-11` exclusions, the identity architecture |
| 2 | Identity model, Global Profile, `PersonId`, privacy, lifecycle, duplicate prevention, composition, ownership boundary, `SID-BR-1`…`SID-BR-18` |
| 3 | Creation, view, update, both photos, privacy controls, timeline, permissions, audit, 14 edge cases |
| 4 | Integration seams per context, `SEV-1`…`SEV-16` events, `SID-INT-1`…`SID-INT-12` forbidden integrations |
| 5 | `SPO-1`…`SPO-9`, data protection, measurable NFRs, `SID-INV-1`…`SID-INV-14`, `SCFG-1`…`SCFG-11`, `SID-AC-1`…`SID-AC-26`, future scope |

## Registers

| Register | Range | Meaning | Closed? |
|---|---|---|---|
| `SID-n.m` | Ch 1–5 | Requirements | — |
| `SID-BR-*` | 1–18 | Business rules | — |
| `SXC-*` | 1–11 | Exclusions — out of scope by decision | — |
| `SPO-*` | 1–9 | Protected operations | **Yes** |
| `SEV-*` | 1–16 | Domain events | **Yes** |
| `SID-INT-*` | 1–12 | Forbidden integrations | — |
| `SID-INV-*` | 1–14 | Domain invariants | — |
| `SCFG-*` | 1–11 | Configurable parameters | — |
| `SID-AC-*` | 1–26 | Acceptance criteria | **Yes — the only register** |

Role names are drawn from the closed Authentication set `TR-1`…`TR-5` plus Platform Administrator
(`AUTH-7.21`). This module introduces none.

## The five rules most often broken

1. **The mobile number is a credential, not profile data.** It lives in `BC-18` and is read through, never stored here. *(`SXC-1`, `ID-1`)*
2. **Private is the default.** Public requires recorded consent. *(`SID-2.27`)*
3. **The reference direction is downward only.** A Student Record holds a `PersonId`; the identity holds no list of records. *(`ID-2`, `SID-1.38`)*
4. **The Global Profile Photo and the Library Identification Photo are different assets.** Hiding one never affects the other. *(`SID-INV-13`)*
5. **Organisation staff never edit the Global Profile.** They edit Student Records. *(`SID-3.31`)*

## Status

Specified, **not implemented.** No `domain/person` module, no `PersonId` type and no rank 7.5 tier exist
yet. `Q-05` is closed: an identity exists for every account, with or without any enrollment.
