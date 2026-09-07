# ADR-0063 — Platform step-up re-authentication is a security obligation layered on `BC-18`'s existing mechanism

| Field | Value |
|---|---|
| **Status** | `Accepted` |
| **Date** | 2026-08-21 |
| **Deciders** | **`BC-18` Identity & Access owner** — the owning role of `BC-18` per [`PRD_REGISTRY.md`](../prd-ecosystem/PRD_REGISTRY.md) §6, whose specification is `FROZEN` Rank 3 `Authentication_PRD_v2.md`. The **Domain Owner** role of [`PRD_OWNERSHIP_MODEL.md`](../prd-ecosystem/PRD_OWNERSHIP_MODEL.md) §2.2 — *"correctness within its bounded contexts"*. Exercised by **direct conferral of the human principal of this engagement**, §6 |
| **Supersedes** | Nothing |
| **Amends** | **Nothing. `Authentication_PRD_v2.md` is byte-unchanged.** No `AUTH-*` requirement is added, altered, softened or withdrawn; no authentication factor is created; no `SECP-*` identifier is minted or moved |
| **Amended by** | — |
| **Baseline** | **No baseline re-issue.** No document changes version (§7 rule 4) |
| **Closes** | `SECP-ADR-003` · `SECP-DEP-002` · `SECP-GAP-014` · `SECP-GAP-043` · the `SECP-DEP-002` half of blocker **`B7-4`** |
| **Does NOT close** | `SECP-GAP-015`. Proves no criterion: `SECP-AC-033` remains unproven, as do all 128 `SECP-AC-*` |
| **Opens** | Nothing |
| **Related** | `AUTH-8.81` · `SECP-FR-018` · `SECP-BR-008` · `SECP-HRO-001`/`002`/`011`/`012` · `MP-CON-11` · `MP-GBR-25` · `SECP-XC-005` |

---

## 1. The question

`SECP-ADR-003`, verbatim:

> *"**Is platform step-up re-authentication a security obligation or an authentication requirement?** `SECP-FR-018`
> extends re-auth to four operations `AUTH-8.81` does not name. `PRD-001` is `FROZEN` and Rank 3; this PRD is
> unranked and may not assert an authentication rule."*

`SECP-GAP-014` states the two candidate readings and — importantly — which one the PRD assumed:

- **Reading 1** — a **security-platform obligation** layered on `BC-18`'s existing mechanism, consistent with
  `AUTH-8.81`'s intent and **adding no factor**. *Permissible.*
- **Reading 2** — an **authentication requirement** only `PRD-001` may set.

> *"**Reading 2 is the conservative one and Part 2 does not assume Reading 1.**"*

`PRD-012a` was right not to assume. This ADR is the `BC-18` owner answering.

---

## 2. What was measured

| Measurement | Source | Result |
|---|---|---|
| `AUTH-8.81`'s text | `08-Security-and-Privacy.md` **L261**; `Authentication_PRD_v2.md` **L2983** | *"A stolen device holding a valid session **MUST NOT** be able to change the mobile number, remove other devices or elevate access **without re-authentication**"* |
| Its enumerated scope | Part 2 §8.2 | *"number change, device removal and access elevation… It does **not** enumerate the platform-side operations of §5"* |
| Whether `AUTH-8.81` is exhaustive | Read as written | It names three operations. **It contains no "and only these" clause** and no closure statement |
| V1 factor count | Part 2 §8.1; `MP-CON-11`, `MP-GBR-25` (Rank 1) | **Exactly one** — mobile OTP. `SECP-XC-005` forbids another |
| What "step-up" can therefore mean in V1 | Part 2 §8.1 | *"'step-up' in V1 can only mean **re-assertion of the same factor**, not a stronger one"* |
| `SECP-FR-018`'s text | Part 2 **L332** | Re-auth **MUST** precede `SECP-HRO-001`/`002`/`011`/`012`, and **MUST NOT** be satisfiable by session possession, device trust, or a prior re-auth older than the operation's own request |
| Its own declared split | Part 2 L332, Owner column | **`BC-18` (mechanism) + SECURITY (obligation)** — the PRD had already split it correctly |
| Guard against factor drift | `SECP-BR-008` | Re-auth **MUST NOT** be described, logged or presented as a second factor |
| The four operations | Part 2 §5 | `HRO-001` assign/revoke a platform role · `HRO-002` approve an elevation request · `HRO-011` change the vault secret or its rotation state · `HRO-012` alter security enforcement state |
| ⭐ **Whether `PRD-001` claims exclusivity over re-authentication** | `grep -nE "MUST NOT own\|MUST NOT be owned\|owns exclusively\|sole owner"` over `Authentication_PRD_v2.md` | **Only two such clauses exist**, `AUTH-10.4` **L3698** and `AUTH-10.26` **L4050** — both read *"Authentication **MUST NOT own audit** storage, retention or query"*. **Neither concerns re-authentication.** The third hit, `AERR-11` L4404, is an error code about record deletion |

### 2.1 The measurement that decides it

`PRD-001` **does** know how to reserve and how to cede: `AUTH-10.4` and `AUTH-10.26` explicitly disclaim ownership of
audit. **A frozen document that states its boundaries where it means them, and states none for
re-authentication, has not reserved re-authentication exclusively.** Reading 2 requires an exclusivity clause that
was searched for and **does not exist**.

Inferring exclusivity from silence would be the `PRD-013` blocker-1 error precisely — `ADR-0050` §5: *"It is history,
not a rule… **No such rule exists to be breached**."*

---

## 3. What was considered and refused

| Option | Why refused |
|---|---|
| **Adopt Reading 2 and delete or downgrade `SECP-FR-018`** | ⛔ Refused. It would **remove a security obligation from `PRD-012a` to make a gate pass** — the act this pass was expressly forbidden. It also has no authority behind it: §2.1 measured **no** exclusivity clause. `SECP-FR-018` also *strengthens* protection for four high-risk platform operations; deleting it to tidy a governance question would trade a real control for a clean table |
| **Amend `AUTH-8.81` to name the four operations** | ⛔ Refused. `AUTH-8.81` is **frozen Rank 3**. `PRD_LIFECYCLE.md` L177: *"A frozen PRD is never silently modified. Not for an obvious correction, and not for one that is certainly right."* And it is **unnecessary** — `AUTH-8.81` protects a *session-holding attacker* scenario, not a platform-operations list; adding four platform operations would expand an authentication requirement to cover a platform this document does not own |
| **Add a second factor for the four operations** | ⛔ Refused absolutely. Rank 1 `MP-CON-11` and `MP-GBR-25` fix V1 at one factor and `SECP-XC-005` forbids another. Would violate Rank 1 from a Rank 2 ADR |
| **Read `AUTH-8.81`'s three operations as an exhaustive list** | ⛔ Refused as unsupported. It contains no closure clause. Treating an enumeration as a ceiling would mean *every* obligation not listed in `PRD-001` is prohibited platform-wide — a reading that would invalidate large parts of several frozen PRDs |
| **Defer to a future ARB** | ⛔ Refused. `SECP-DEP-002` names the **`BC-18` owner** as the party who must confirm the reading, and that role is conferred here. Deferring an answerable question that the named owner is present to answer manufactures a blocker |
| **Have `PRD-012a` assert the reading in its own text** | ⛔ Refused. An unranked document may not settle a Rank 3 boundary about itself. §8.3's restraint is upheld: the answer arrives from the owner, in an ADR |

---

## 4. Decision

**Reading 1 is confirmed by the `BC-18` owner.**

**1. `SECP-FR-018` is a SECURITY-platform obligation layered on `BC-18`'s existing mechanism. It is not an
authentication requirement.** The split `SECP-FR-018`'s own Owner column already records — *"`BC-18` (mechanism) +
SECURITY (obligation)"* — is correct and is hereby confirmed:

| Element | Owner |
|---|---|
| The re-authentication **mechanism** — factor, challenge, verification, failure handling, lockout | **`BC-18`**, unchanged. `PRD-012a` invokes; it does not implement |
| The **obligation** that four platform operations require re-auth first | **SECURITY platform** (`PRD-012a`) |
| The **rule** that session possession, device trust or a stale prior re-auth cannot satisfy it | **SECURITY platform** — a freshness constraint on the platform's own operations |

**2. No new factor is created, and none may be.** V1 has exactly one factor (mobile OTP), fixed at Rank 1 by
`MP-CON-11`/`MP-GBR-25`. `SECP-FR-018` requires **re-assertion of that same factor**, per Part 2 §8.1. `SECP-BR-008`
— re-auth must never be described, logged or presented as a second factor — is confirmed as the operative guard.

**3. `AUTH-8.81` is neither amended nor contradicted.** It states a **minimum** for three user-facing operations. It
is not exhaustive and contains no closure clause. `SECP-FR-018` extends the *same protective principle* to four
platform-side operations `AUTH-8.81` never addressed. **Consistent with its intent, additive to its scope, and
identical in factor.**

**4. `PRD-001` holds no exclusivity over re-authentication.** Measured, §2.1: its only ownership disclaimers concern
**audit**. A document that states boundaries where it means them has not reserved this one by silence.

### 4.1 What this rests on

| Ground | Source | Rank |
|---|---|---|
| `AUTH-8.81` names three operations with no closure clause | `Authentication_PRD_v2.md` **L2983** | **3** |
| `PRD-001`'s only exclusivity clauses concern audit | **L3698**, **L4050**, measured | **3** |
| V1 has exactly one factor and no second may be added | `MP-CON-11`, `MP-GBR-25`; `SECP-XC-005` | **1** |
| Step-up in V1 can only mean re-assertion of the same factor | Part 2 §8.1 | unranked, derived from Rank 1 |
| `SECP-FR-018` already declares the mechanism/obligation split | Part 2 **L332** | unranked |
| Re-auth must never be presented as a second factor | `SECP-BR-008` | unranked |
| Correctness within `BC-18` is the Domain Owner's | `PRD_OWNERSHIP_MODEL.md` §2.2 | derived |

### 4.2 What it does not rest on

- **Not** on convenience. Reading 2 was the conservative option and it was tested against `PRD-001`'s own text
  rather than dismissed.
- **Not** on silence-as-permission. The positive evidence is that `PRD-001` **does** disclaim ownership where it
  means to (audit, twice) and does not here.
- **Not** on any new factor, criterion or requirement. **0** identifiers minted in either document.

---

## 5. What this ADR does not do

| Thing | Why not |
|---|---|
| **Amend `Authentication_PRD_v2.md`** | **Byte-unchanged.** `AUTH-8.81` stands exactly as frozen |
| **Create a factor, challenge type or lockout rule** | All belong to `BC-18`'s mechanism, and V1's single factor is Rank 1-fixed |
| **Prove anything works** | `SECP-AC-033` is **not** proven; **0 of 128** `SECP-AC-*` are proven by a test |
| **Close `SECP-GAP-015`** | A different question, untouched here |
| **Freeze `PRD-012a`** | Stage 7 is a Governance Owner act with its own ADR and baseline row |
| **Touch code** | **0 lines** under `lib/`, `packages/`, `test/`, `web/`, `tool/` |

---

## 6. Authority

A **direct, explicit conferral by the human principal of this engagement**, instructing that `SECP-ADR-003` be
resolved *"through the **BC-18 / Identity owner authority**"*. **That instruction is the authority, and it is the
only authority claimed** — the form `ADR-0033` §7.2 records.

**Not a standing grant** (`ADR-0033` §7.1). It authorises the `BC-18` owner to **confirm which reading of an existing
requirement is correct**. It does **not** authorise amending `PRD-001`, adding an `AUTH-*` requirement, or altering
any authentication mechanism — and §5 records that none was done. Notably, the conferred role is the one that *could*
amend `PRD-001`; it is deliberately not used, because §4 finding 3 establishes that no amendment is required.

### 6.1 What is not claimed

- **No ARB meeting**, quorum, attendee list or sign-off date.
- **No Security review**, no Principal Enterprise Architect approval, no product-owner signature.
- **No frozen requirement amended, added, softened or withdrawn.**
- **No factor created**; **no criterion proven**; **no freeze conferred.**

---

## 7. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-21 | Created `Accepted`. Resolves `SECP-ADR-003` / `SECP-DEP-002` / `SECP-GAP-014` / `SECP-GAP-043` by confirming **Reading 1**: `SECP-FR-018` is a **SECURITY-platform obligation layered on `BC-18`'s existing mechanism**, not an authentication requirement — confirming the *"`BC-18` (mechanism) + SECURITY (obligation)"* split the requirement's own Owner column already carried. ⭐ **The decisive measurement is a probe of `PRD-001` for exclusivity, and it came back empty:** the only *"MUST NOT own"* clauses in `Authentication_PRD_v2.md` are `AUTH-10.4` (**L3698**) and `AUTH-10.26` (**L4050**), and **both concern audit** — so **no clause reserves re-authentication to `PRD-001`**. Because that document demonstrably *does* state its boundaries where it means them, its silence here is evidence rather than a gap to be filled by inference; treating silence as prohibition would be exactly the `PRD-013` blocker-1 error `ADR-0050` §5 withdrew (*"No such rule exists to be breached"*). ⚠ **`AUTH-8.81` is neither amended nor contradicted** — it names three user-facing operations, carries **no closure clause**, and states a **minimum**; `SECP-FR-018` extends the same protective principle to four platform-side operations (`SECP-HRO-001`/`002`/`011`/`012`) it never addressed. ⚠ **No factor is created and none may be**: V1 holds exactly one (mobile OTP), fixed by **Rank 1** `MP-CON-11`/`MP-GBR-25` with `SECP-XC-005` forbidding another, so step-up *"can only mean re-assertion of the same factor"*; `SECP-BR-008` is confirmed as the guard against it ever being logged or presented as a second factor. ⚠ **Four alternatives refused:** deleting or downgrading `SECP-FR-018` (would remove a security control to make a gate pass, and would trade a real protection for a tidy table), amending frozen `AUTH-8.81` to name the four operations (`PRD_LIFECYCLE.md` **L177**, and unnecessary), adding a second factor (violates Rank 1), and reading `AUTH-8.81`'s three operations as exhaustive (unsupported — and a reading that would invalidate parts of several frozen PRDs). ⚠ **The conferred role is the one that could amend `PRD-001`, and it deliberately did not** — the amendment is not required, so it was not made. **Amends nothing: `Authentication_PRD_v2.md` byte-unchanged, 0 `AUTH-*` added/altered/withdrawn, 0 factors, 0 `SECP-*` identifiers minted or moved, no baseline re-issue, 0 lines of code.** ⛔ **Proves nothing: `SECP-AC-033` unproven, 0 of 128 `SECP-AC-*` proven by a test.** Does not close `SECP-GAP-015` and **confers no freeze** |
