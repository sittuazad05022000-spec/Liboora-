# ADR-0031 — Registering the presence-tolerance configuration requires a Rank 4 register amendment; this proposes it and performs none of it

| Field | Value |
|---|---|
| **Status** | **Proposed** — not binding. *(`ADR-INDEX.md` status vocabulary: "Under consideration; not binding")* |
| **Date** | 2026-08-05 |
| **Deciders** | **Architecture owner** — `TRACEABILITY_MATRIX.md` §2F is a **Rank 4** document, and `PRD-006` has no authority to amend it |
| **Supersedes** | Nothing |
| **Amends** | **Nothing.** `TRACEABILITY_MATRIX.md` and `PRD-006`'s registers are byte-identical |
| **Baseline** | **None issued.** Baseline remains **`BASELINE-2026-08-04-E`** |
| **Closes** | **Nothing** |
| **Related** | **`R-19`** · `R-8` · `D-18` · `PRD-006` §10A.7a · §16.3 · `ATT-CFG-008` · `ATT-FR-038` · `ATT-BR-017` · `ATT-FR-118` · `ATT-NFR-010` · `TRACEABILITY_MATRIX.md` §2F |

> ⚠️ **`Proposed`. This ADR proposes a register amendment. It performs none.** The Product Owner's instruction is
> *"Add the required configuration only through the proper governance path… identify and update the necessary
> `ATT-CFG` and `ATT-AC` records. Do NOT bypass the configuration/authorization registries."* **The proper path runs
> through the Architecture owner, because the registers are fixed by a Rank 4 document.** Identifying what must
> change is within this ADR's power; changing it is not.

---

## 1. The requirement

`D-18` authorises a configurable presence tolerance, default **30 minutes**, Owner- and Manager-configurable. The
product rule is written at `PRD-006` §10A.7a. **What is missing is the register entry**, and the Product Owner
explicitly requires it not be bypassed.

Proposed configuration, stated so an accepting authority can adopt it verbatim:

| Property | Value |
|---|---|
| **Name** | `attendancePresenceToleranceMinutes` |
| **Default** | **30** — the Product-Owner-approved value; **no other numeric value is proposed anywhere in this ADR** |
| **Owner may configure** | **YES** |
| **Manager may configure** | **YES** |
| **Scope** | Tenant / library |
| **Applies** | On **both** sides of the booked shift |
| **Audited** | **YES** — every change, under `ATT-FR-038` |
| **Validated** | **YES** — an invalid value is rejected and the previous value retained, exactly as all 24 existing rows behave |
| **Retroactivity** | **Changes MUST NOT alter historical attendance.** `ATT-FR-089` already requires evaluation against the rules in force *at the moment attendance occurred*, and `BC-06`'s policy versioning is *"never retroactive"* (BC Map §8) — so this requirement is **already** satisfied by an existing rule and needs no new one |
| **Permissions** | **No unrelated permission is granted, and no role is defined** — `ATT-FR-118` forbids defining one. This is the same Owner+Manager pairing `D-12` established for `ATT-CFG-008` |

**Deliberately not specified:** any allowed range or bound. The 24 existing rows each carry one, so a range is
expected — but a range is a **numeric value**, and the Product Owner authorised exactly two numbers (5 and 30) and
instructed *"Do NOT invent another numeric tolerance."* **An accepting authority must supply the bound.** Recording
the omission is more useful than filling it.

## 2. Why this cannot be done inside `PRD-006` — measured, not asserted

**The probe was run twice, on two different registers, and gave two different answers. Neither was inferred from the
other.**

`ATT-CFG-*` is fixed at **24** and `ATT-AC-*` at **213** by `TRACEABILITY_MATRIX.md` §2F. A twenty-fifth `ATT-CFG`
row was injected into a working copy of `PRD-006` §16.3 and the Stage 5 gate re-run. It failed **five** ways, three
decisive:

```
* section 0.3 declares ATT-CFG-* as 24 ending 024; computed 25 ending 025
* ATT-NFR-010 requires every obligation to carry a criterion; 1 uncovered: ['<the injected row>']
* section 2F registers ATT-CFG-* as 24 (001..024); computed 25 (001..025)
```

**The third failure was not anticipated by reasoning and is the reason this ADR exists in this shape.** A new
configurable is an *obligation*; `ATT-NFR-010` requires every obligation to carry an acceptance criterion; `ATT-AC-*`
is **also** fixed at 213. **So `D-18` needs TWO Rank 4 amendments, not one.** The probe row was reverted and the gate
returned to **exit 0** before any other work proceeded.

**By contrast**, injecting the two new status strings authorised by `D-20` produced **PASS, exit 0** — because
`grep` for the existing status strings in `TRACEABILITY_MATRIX.md` returns **0**: status strings are **not registered
identifiers**. **Two superficially similar additions, two different verdicts.** This is why each was tested rather
than one result generalised.

## 3. What an accepting decision must amend

| # | Document | Rank | Change required |
|---|---|---|---|
| **1** | `TRACEABILITY_MATRIX.md` §2F | **4** | `ATT-CFG-*` count 24 → 25 |
| **2** | `TRACEABILITY_MATRIX.md` §2F | **4** | `ATT-AC-*` count 213 → 214 (at least one; more if the authority wants the four tolerance windows separately verified) |
| **3** | `PRD-006` §0.3 | unranked | The self-declared count, which the gate cross-checks against §2F |
| **4** | `PRD-006` §16.3 | unranked | The new row, with the bound §1 declines to invent |
| **5** | `PRD-006` §30 | unranked | The new criterion(s) |

**Items 3–5 are within `PRD-006`'s own authority and are trivial once 1–2 are granted. Items 1–2 are not, and no part
of this ADR performs them.** `TRACEABILITY_MATRIX.md`'s hash is verified byte-identical at
`51ba0d739a4c0bea` after this ADR was written.

## 4. Options

| # | Option | Consequence |
|---|---|---|
| **O-1** | Amend §2F for both registers; add the row and criterion | The clean path. Needs Architecture owner action on a Rank 4 document |
| **O-2** | Extend an **existing** `ATT-CFG` row to carry the tolerance | **Rejected on inspection.** No existing row is about shift timing: `ATT-CFG-008`/`009` are the Wi-Fi network list and strictness; `ATT-CFG-023` is the *correction* window, a different concept. Overloading one would misfile the value and mislead every later reader |
| **O-3** | Leave the tolerance as a **product rule** with no register entry | **What `PRD-006` v1.6 does today**, as a holding position. The behaviour is specified and auditable; the value is not registrable, so tooling cannot verify it and no acceptance criterion covers it. **Acceptable only as an interim state, and it is labelled as one** |
| **O-4** | Treat tolerance as part of `BC-06`'s `AttendanceRules` (`E-04`) | **Plausible and not this ADR's to decide.** `E-04` already carries `graceMinutes`, so an argument exists that tolerance belongs there — but `E-04` is branch-wide and `D-18` is per-library-tenant, and extending `E-04`'s payload amends a **Rank 4** contract. Referred, not selected |

**No option is selected.** **O-4 deserves explicit consideration** because it might place the value where its
neighbours already live, and because getting this wrong means the tolerance is owned by the wrong context for the
life of the product.

## 5. Consequences

- **If accepted (O-1):** the tolerance becomes a first-class configurable, gate-verified and criterion-covered;
  `R-19` closes.
- **If left `Proposed`:** `PRD-006` §10A.7a's product rule stands, the **default 30 minutes applies as specified**,
  and the value remains unregistrable — so **no acceptance criterion verifies it** and Stage 4 will see an
  obligation with no test. **This is a real gap, and it is disclosed rather than minimised.**
- **In every case:** no numeric value beyond 5 and 30 is introduced, and no existing configurable is altered.

## 6. What this ADR explicitly does not do

- It does **not** amend `TRACEABILITY_MATRIX.md` or any other Rank 1–4 document — all 13 protected hashes verified
  byte-identical.
- It does **not** add `ATT-CFG` or `ATT-AC` identifiers to `PRD-006`, and does **not** write the probe identifier
  anywhere (the Stage 5 gate reads any well-formed identifier as a citation, and a hypothetical is not a citation).
- It does **not** invent a numeric bound, range, second tolerance, or any value other than the approved **30**.
- It does **not** select an option, and explicitly refers **O-4** upward rather than resolving it.
- It does **not** weaken, waive or reconfigure any gate check.
- It does **not** assert approval by any person or body, and does **not** become `Accepted` by being written.
