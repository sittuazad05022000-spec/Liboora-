# `PRD-006` — Authority Determination for `ATT-CFG-005`, `006`, `014`, `019`

| Field | Value |
|---|---|
| **Version** | v1.0 · 2026-08-04 |
| **Instruction** | Authority Resolution Master — *"Existing repository/governance ko exhaustively audit karo aur determine karo … legitimate existing authority"*; *"Owner/Manager ya koi naya authority tabhi use karo jab existing governance explicitly authorize karti ho."* |
| **Method** | Audit of `PRD_OWNERSHIP_MODEL.md` (the repository's own authority instrument), `PRD_REGISTRY.md`, `DOCUMENTATION_BASELINE.md`, all 23 ADRs, and `PRD-006` §16.3. Every finding computed. |
| **Result** | **2 of 4 authorities FOUND and actionable · 2 of 4 MISSING AUTHORITY** |
| **Values collected** | **None.** Locating an authority is not the same as that authority having spoken (§5). |
| **`PRD-006`** | **NOT amended. NOT frozen.** v1.3 DRAFT, sha256 `93ab1c60d740c4e0`. |

---

## 1 · The instrument that governs this question

`PRD_OWNERSHIP_MODEL.md` is the repository's authority register. Its own header constrains how it may be used:

> L10: *"**Precedence** | **Unranked.** Governance process, not a requirement source. **Never outranks a PRD**"*

Its role table (L82–86) is the operative test — note the fourth column:

| Role | Decides | Does **not** decide |
|---|---|---|
| **Product Owner** | *"Whether a requirement is correct and in scope"* | *"How it is structured or built"* |
| **Domain Owner** | *"Whether a rule is consistent with the domain model"* | *"Which contexts the PRD owns (that is an ADR)"* |
| **Architecture Owner** (convenes as **ARB**) | *"ADR approval; any Rank 1–5 document change; every §11 exception"* | *"Business scope or priority"* |
| **Technical Owner** | *"Sequencing and technical approach"* | *"Whether a requirement is right"* |

And L90–95 forecloses the shortcut of routing everything to one role:

> *"**The Product Owner is not the default answer.** `ADR-0011`'s header records *'Deciders: Product owner (authoritative ruling); Principal Enterprise Architect; DDD reviewer'* — three roles for one decision, precisely because scope, structure and domain correctness are **separable judgements**."*

`PRD-006`'s own assignment, L163: Product Owner · Domain Owner **Library Domain** · Architecture Owner **ARB** · Technical Owner Platform Engineering.

---

## 2 · Was the tenant `Owner` role an available authority? — Tested, and NO

§16.3's Owner column reads **`Owner`** for all four settings, which is the tenant Owner role (`ATT-FR-033`: *"The configuration **MUST** be owned by the Owner role and stored through `BC-25`"*). This was tested as a candidate authority because it is the most tempting reading.

**It does not authorise what is needed.** The tenant Owner sets a **value inside a domain**; it does not define the **domain**. Measured:

```
grep -rniE 'owner (may|can|must) (set|define|choose|configure).{0,80}(range|domain|envelope|bound)' docs/
  →  0 hits
```

No rule anywhere authorises any Owner or Manager to define an allowed domain. `LIB-16.2` requires the *documented default*; `LIB-16.3` requires validation *against* a domain — both presuppose the domain already exists. A tenant Owner choosing the bounds of their own validation would be self-authorising, which is the `ATT-BR-043` failure mode.

**Per the instruction — *"Owner/Manager … tabhi use karo jab existing governance explicitly authorize karti ho"* — governance does not explicitly authorize it, so it is not used.**

---

## 3 · `ATT-CFG-014` (Face) and `ATT-CFG-019` (OCR) — ✅ AUTHORITY FOUND

| Item | Finding |
|---|---|
| **Authority** | **Architecture Owner, convened as the Architecture Review Board (ARB)** |
| **Basis** | `PRD_OWNERSHIP_MODEL.md` L85 — ARB decides *"ADR approval"* and *"any Rank 1–5 document change"*. L106: *"`ADR-INDEX` and Matrix §11 both name the Architecture Review Board as the…"* approving body. L163 assigns ARB as `PRD-006`'s Architecture Owner. |
| **Standing?** | ✅ **Yes — this is a real, currently-constituted authority.** It requires no unauthored document. |
| **What it must decide** | `ATT-CFG-014`: ratify Face V3 (`ATT-GAP-015`; owner recorded as *"Product owner + architecture owner"*). `ATT-CFG-019`: select an option in `ADR-0023` and thereby assign OCR/Vision ownership (`ATT-GAP-011`, owner *"Architecture owner — needs an ADR"*). |
| **Status** | ⏳ **AUTHORITY EXISTS, DECISION NOT GIVEN.** All three ADRs remain `Proposed`; git history shows ADR status has only ever been `Proposed` and no commit has ever added a ticked approval. |

**Important limit on this finding.** ARB is competent to *assign ownership* and *approve ADRs*. Whether ARB is also competent to state the numeric envelope is a separate question the model answers in the negative for one of the two: a face-match threshold is a security parameter, and the ARB's *"Does not decide"* cell excludes *"business scope or priority"* while `ATT-GAP-014` names **"Legal counsel + Security Platform"** as the biometric owner. So for `ATT-CFG-014` the ARB can lift the V1/V3 scope question but **cannot alone supply the threshold envelope** — that lands back in §4.

---

## 4 · `ATT-CFG-005` and `ATT-CFG-006` (Dynamic QR) — ⛔ MISSING AUTHORITY

| Item | Finding |
|---|---|
| **Nominated owner** | **Security Platform.** This is *formally registered*, not inferred: `PRD_OWNERSHIP_MODEL.md` **L180** assigns `PRD-012a` Security Automation → Domain Owner **Security Platform**, and `PRD-006`'s own `ATT-GAP-006` names *"Security Platform owner"*. |
| **Is it actionable today?** | ⛔ **No.** |

Three independent measurements establish why:

1. **The owning document is not open.** `PRD_OWNERSHIP_MODEL.md` L331: *"**`PRD-012` remains ⚠ Split and unassignable** … the split is **confirmed** as already authorised by Master PRD §8 *Correction 2*, but **confirmation is not execution** — **`PRD-012a` has not been opened**, so `PRD-012` is not retired and this finding stays open."* `PRD_REGISTRY.md` L248 puts it more bluntly: `PRD-012` *"is therefore a placeholder that will never be authored."*
2. **The role cannot be exercised.** L186–189: assignment rule 1 (one holder per role) *"**cannot be satisfied** until the document is divided."* `PRD-012` spans SECURITY platform (rank 2) and `BC-28` Workflow (rank 6) — *"two owners at two ranks"* — which `PRD_REGISTRY.md` §4.1 records as violating the Single Owner Rule (EA §10.1.1).
3. **No accepted ADR has ever exercised it.** Searched all ADRs naming *"Security Platform"* → **0 files**. No accepted decision from this authority exists anywhere in the repository.

**No substitute exists, and this was tested rather than assumed:**

```
PRD_OWNERSHIP_MODEL.md searched for: delegate | escalate | interim | acting | proxy | on-behalf | vacant
  →  no delegation mechanism.  L35 states the opposite principle:
     an absent owner "terminates the search for a real one."
```

**Verdict: ⛔ MISSING AUTHORITY.** A registered owner that has never been constituted is not an available authority. Per the instruction, no new rule, owner, value or range is created to fill it.

---

## 5 · Why no values were collected, even where authority was found

The instruction says *"Agar authority mil jaye — required decision/value/range collect/record karo."* Authority **was** found for §3. No value was collected, for a reason that is measured rather than argued:

**Identifying an authority does not make that authority speak.** The ARB exists and is competent; it has not ruled. Recording a value "on the ARB's behalf" would be the fake approval the instruction forbids. Measured state of ARB assent:

| Search | Result |
|---|---|
| ADR status ever `Accepted` for `ADR-0021`/`0022`/`0023` (full git history) | **0** — only ever `Proposed`, in two byte-variants |
| Commits ever adding a ticked approval box | **0** |
| Genuine ticked approvals in the decision package | **0** (24 `☐` unticked; 8 signature lines blank) |
| ARB approval documents in `attendance-management/` | 1 request only — signature line blank |

---

## 6 · Consolidated authority determination

| # | Setting | Legitimate existing authority | Actionable? | Status |
|---|---|---|---|---|
| 1 | `ATT-CFG-005` QR rotation interval | **Security Platform** — registered at `PRD_OWNERSHIP_MODEL.md` L180 | ⛔ **No** — `PRD-012a` never opened; role unexercisable; 0 accepted ADRs | ⛔ **MISSING AUTHORITY** |
| 2 | `ATT-CFG-006` QR validity window | **Security Platform** — same basis | ⛔ **No** — same three measurements | ⛔ **MISSING AUTHORITY** |
| 3 | `ATT-CFG-019` OCR threshold | **ARB** — L85, L106, L163; `ATT-GAP-011` names *"Architecture owner — needs an ADR"* | ✅ **Yes** — constituted, competent to select `ADR-0023`'s option | ⏳ **AUTHORITY FOUND — decision not given** |
| 4 | `ATT-CFG-014` Face V3 | **ARB** for the V1/V3 scope ratification (`ATT-GAP-015`); **Legal counsel + Security Platform** for the threshold envelope (`ATT-GAP-014`) | 🟡 **Partly** — ARB yes; the envelope half hits row 1's missing authority | ⏳ **SPLIT — ratification authority found, envelope authority missing** |

---

## 7 · Blockers that remain, and why none was resolved here

| # | Blocker | Owner | Missing decision |
|---|---|---|---|
| 1 | `ATT-CFG-005`/`006` default + domain | Security Platform | ⛔ **MISSING AUTHORITY** — needs `PRD-012a` opened, or an ARB-approved ADR reassigning the decision to a constituted role |
| 2 | `ATT-CFG-019` default + domain | **ARB** (authority exists) | Select `ADR-0023` option A/B/C/D, then the assigned owner sets the envelope |
| 3 | `ATT-CFG-014` | **ARB** + Legal/Security | Face V3 ratification; envelope blocked by #1 |
| 4 | `ADR-0021`/`0022`/`0023` all `Proposed` | Architecture Owner | Real approval — not tickable here |
| 5 | No admitting ADR exists | Architecture Owner | An `ADR-0020`-shaped instrument; prerequisites unmet |
| 6 | `LIB-16.2` breach, no precedent | Governance | 0 of 7 admission ADRs ever froze with a live Rank 3 breach |
| 7 | **D-2** unconfirmed | Governance | Whether a CONDITIONAL Stage 3/4 verdict permits Stage 7 entry |
| 8 | No baseline row / rank | Architecture Owner | Conferred after #5 |

**Freeze not performed.** Conditions 1–8 are not satisfied, so `PRD-006` is not amended to v1.4 and not frozen. `ATT-CFG-014` is not marked resolved. No conditional verdict was upgraded.

---

## 8 · What this document did not do

| # | Not done | Why |
|---|---|---|
| 1 | Did not create a new authority, role, rule or delegation | Instruction; and L35 forbids substituting for an absent owner |
| 2 | Did not use the tenant Owner/Manager to set a domain | §2 — governance does not *explicitly* authorize it (0 hits) |
| 3 | Did not record a value or range for any of the four | §5 — authority found ≠ authority spoken |
| 4 | Did not accept any `Proposed` ADR | No approval exists in the working tree or in history |
| 5 | Did not amend `PRD-006`, cut v1.4, or freeze | Conditions unmet (§7) |
| 6 | Did not touch `DOCUMENTATION_BASELINE.md`, `PRD_REGISTRY.md` or `ADR-INDEX.md` | Stage 7 is conferred, not claimed |
| 7 | Did not modify any protected document or any code | 11 hashes verified byte-identical |
| 8 | Did not weaken or modify a gate | Both gates re-run unmodified at exit 0 |

---

## 9 · Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-04 | Authority audit of the four unresolved settings against `PRD_OWNERSHIP_MODEL.md`. **ARB found and actionable** for `ATT-CFG-019` and for the Face V3 ratification half of `ATT-CFG-014`. **Security Platform registered at L180 but MISSING AUTHORITY** for `ATT-CFG-005`/`006` and the `ATT-CFG-014` envelope — `PRD-012a` never opened (L331 *"confirmation is not execution"*), role unexercisable under rule 1 (L186), 0 ADRs ever naming it as decider, and no delegation mechanism exists (L35). Tenant Owner tested and rejected as an envelope authority (0 hits). No value collected, no approval assumed, no freeze performed. |
