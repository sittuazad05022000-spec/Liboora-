# ADR-0027 — Authorized Wi-Fi network identity must be decided by Architecture/Security, and this ADR does not invent it

| Field | Value |
|---|---|
| **Status** | **Proposed** — not binding. *(`ADR-INDEX.md` status vocabulary: "Under consideration; not binding")* |
| **Date** | 2026-08-05 |
| **Deciders** | **Architecture owner (ARB) + security input** — `ATT-GAP-007` already names the Architecture owner. Platform (Android) input required, because the mechanism must be implementable under real OS restrictions |
| **Supersedes** | Nothing |
| **Amends** | **Nothing.** `ATT-XC-015` and `ATT-FR-039` are byte-identical. `PRD-006` is byte-identical |
| **Baseline** | **None issued.** Baseline remains **`BASELINE-2026-08-04-E`** |
| **Closes** | **Nothing.** It does not close `ATT-GAP-007` |
| **Related** | `ATT-XC-015` (L708) · `ATT-GAP-007` (🔴 OPEN, owner Architecture owner) · `ATT-XC-014` (L679) · `ATT-FR-039` (L712) · `ATT-FR-032`/`033` · `ATT-CFG-008` (L1162) · `ATT-FR-034`/`035`/`036` · `ATT-BR-017` · `ATT-BR-042` (L1750) · `ATT-AC-033` (L1852) · `ATT-FR-050` · `ADR-0028` (Android platform) |

> ⚠️ **`Proposed`. This ADR states the requirements a mechanism must satisfy. It proposes no mechanism.**
>
> The Product Owner's instruction: *"**DO NOT invent** a security mechanism without recording it as an approved
> architectural decision."* Accordingly, §4 lists **requirements and named candidate families with their known
> weaknesses**, and §5 declines to select.
>
> Measured, before and after authoring: `grep -ci "bssid"` = **0**, `grep -ci "ssid"` = **0** in `PRD-006`.

---

## 0. Product Owner decision recorded — a permission was granted, **not a mechanism**

> **This section records a Product Owner answer. It does not change this ADR's status, and it does not close
> `ATT-GAP-007`.** This ADR remains **`Proposed`**.

| PO decision | Question asked | Answer as given |
|---|---|---|
| **`D-13`** | D4 — may a library-side device or software component participate in verification? | **YES** — permitted if Architecture/Security determines it necessary. *"**YES does NOT select a particular hardware, router, BSSID, API, gateway, certificate, or other mechanism.**"* |

**`D-13` removes a constraint from the option space and adds nothing to it.** Before it, §4's candidate families
divided into those needing only the student's device and those needing something on the library side, and it was
unknown whether the latter were even permissible. They now are. **That is the entire content of the decision**, and
the Product Owner wrote the disclaimer themselves — reproduced above verbatim so no reader can mistake a permission
for a design.

**What `D-13` does not supply.** No hardware, no router, no BSSID, no SSID, no network identifier of any kind, no API,
no gateway, no certificate, no comparison rule, no format, no threshold, no timeout, no tolerance. The measurement in
the banner above still holds after this section was written: `grep -ci "bssid"` = **0** and `grep -ci "ssid"` = **0**
in `PRD-006`.

### 0.1 `ATT-GAP-007` is **narrowed and still counted OPEN**

`PRD-006` §32.1 continues to record `ATT-GAP-007` as 🔴 **OPEN**, and its verdict cell now reads *narrowed by `D-13`*
rather than resolved. The reason is stated in one line and is the same reason this ADR exists:

> **A permission is not a mechanism.** `ATT-XC-015` excludes the network-identity mechanism from `PRD-006`'s scope;
> `D-13` widens who may take part in supplying one but names none, so nothing `ATT-XC-015` excludes has been
> supplied. `ATT-XC-015` and `ATT-FR-039` are byte-identical apart from `ATT-FR-039`'s extension to cover the new
> capability, which likewise names no mechanism.

The ledger therefore moves from *3 resolved / 0 narrowed / 17 open* to *3 resolved / **1 narrowed** / 18 open* — the
narrowing is recorded as a distinct state precisely so that it is not mistaken for a closure.

### 0.2 ⛔ REMAINING ARCHITECTURE + SECURITY DECISION — unchanged

Everything in §4, §5 and §6 stands. The mechanism, its identity format, its comparison rule and its spoof-resistance
posture remain for the **Architecture Owner (ARB) with Security input**, as `ATT-GAP-007`'s owner entry already
names. `D-13` tells that authority it *may* consider library-side options; it does not tell it what to choose, and it
does not shorten the list of requirements a choice must satisfy.

---

## 1. Context

`PRD-006` deliberately refuses to specify how a Wi-Fi network is technically identified. `ATT-XC-015` (L708) excludes
specifying network identification and spoof detection, and routes it to **`ATT-GAP-007`** — status 🔴 **OPEN**, owner
**Architecture owner**.

Two adjacent rules constrain any future answer, and **neither is weakened by this ADR**:

- `ATT-XC-014` (L679) — Wi-Fi **MUST NOT** be treated as proof that a specific person was present. The document's own blockquote at L682: *"Two students on the same network are indistinguishable to a network check."*
- `ATT-FR-039` (L712) — the mode **MUST NOT** be presented as spoofing-resistant.

Option B requires the gap to be **closed**, because a presence session that grants attendance and Study Hours needs a
network-identity test stronger than a string comparison.

## 2. The question

**By what technical mechanism is an authorized library Wi-Fi network identified, such that copying the library's
network name does not by itself create valid presence?**

## 3. Requirements any accepted mechanism MUST satisfy

Taken from the Product Owner's §8, plus the existing rules that already bind:

| # | Requirement | Source |
|---|---|---|
| R-1 | The network name (SSID) alone **MUST NOT** be sufficient proof | request §8 |
| R-2 | Copying the library's network name **MUST NOT** automatically create valid presence | request §8 |
| R-3 | Tenant isolation **MUST** be enforced; Library A's configuration is never usable by Library B | `ATT-BR-017`, request §8 |
| R-4 | Authorized-network configuration **MUST** be library-specific | `ATT-CFG-008` (already tenant-scoped) |
| R-5 | Spoofing resistance **MUST** be described **honestly**, including its limits | request §8, `ATT-FR-039` |
| R-6 | The system **MUST NOT** claim cheating is impossible | `ATT-BR-042` (L1750), request §23 |
| R-7 | Wi-Fi **MUST NOT** be treated as proof of *individual* identity | `ATT-XC-014` |
| R-8 | The mechanism **MUST** be implementable under real Android platform restrictions | request §8, §12 — see `ADR-0028` |
| R-9 | Verification failure **MUST** be distinguishable, never a generic error, and **MUST NOT** silently downgrade | `ATT-FR-034`/`035`/`036`, `ATT-NFR-005` |
| R-10 | Duplicate authorization entries **MUST** be preventable — which requires a definition of "the same network" | request §10 |

**R-10 is the reason this gap blocks more than security.** Until "same network" has a technical definition, the
Owner/Manager requirement *"prevent duplicate networks"* has no testable meaning, and the multi-AP handoff rule
(request §10) cannot be written either.

## 4. Candidate families, with their known weaknesses

Listed as **input to the decision**, not as a proposal. Each is a family already well known in the industry; naming a
family is not inventing a mechanism, and no parameter, threshold or format is proposed for any of them.

| Family | Basic idea | Known weakness that must be disclosed |
|---|---|---|
| **F-1 — Network name only** | Compare the advertised name | ❌ Fails R-1 and R-2 outright. Recorded only to state that it is **excluded** |
| **F-2 — Hardware access-point identifier** | Match the access point's hardware-level identifier as well as its name | Can be cloned by a determined attacker; on modern Android, reading it typically requires location permission, which interacts with request §13 and `ADR-0028`. Availability is **platform-dependent and must be confirmed**, not assumed |
| **F-3 — Network-side challenge** | The library network (or a device on it) answers a challenge only the genuine network can answer | Strongest of the families listed; requires library-side infrastructure the Owner must operate, which is an operational and cost decision, not only a technical one |
| **F-4 — Reachability of a library-local endpoint** | Presence is inferred from reachability of something only reachable inside the library | Weaker than F-3; can be defeated by tunnelling; needs a per-tenant configuration item |
| **F-5 — Corroboration with an independent signal** | Combine the network check with the **existing, already-approved** optional location check | Adds no new radius — `ATT-CFG-011` **50 m / 20–200 m** and `ATT-CFG-012` **30 m / 5–100 m** are reused unchanged. But location is **optional per tenant** (`ATT-CFG-010`, default **Unset**) and request §11 requires it stay optional, so this cannot be the sole defence |

**No family above is selected, combined, parameterised or recommended here.** Any accepted mechanism will likely be a
combination, and choosing the combination is exactly the decision `ATT-GAP-007` reserves to the Architecture owner.

## 5. Decision

**None. Deferred to the Architecture owner (ARB) with security and platform input.**

The accepting decision must record:

1. Which family or combination is adopted.
2. How R-1 through R-10 are each satisfied.
3. An **honest statement of residual risk** — what attacks remain possible.
4. The definition of **"the same network"** for duplicate prevention (R-10).
5. Confirmation from platform input that the mechanism is achievable on supported Android versions (`ADR-0028`).

## 6. What is already in place and needs no decision

| Fact | Consequence |
|---|---|
| `ATT-CFG-008` (L1162) — *"Approved Wi-Fi network(s) · Owner · **Empty** · Tenant-scoped **list**"* | The configuration slot **already exists** and is already a tenant-scoped list. No new configurable is needed to hold multiple networks |
| `ATT-FR-038` — audit on Wi-Fi configuration change | Request §9's audit requirement is **already satisfied** |
| `ATT-BR-017` — tenant scoping, backend-enforced | R-3 and R-4 are **already satisfied** |
| `ATT-FR-034`/`035`/`036` — distinguishable failures, no silent downgrade | R-9 is **already satisfied** |
| `ATT-BR-042` (L1750) + `ATT-AC-033` (L1852) | R-6 is **already satisfied and already testable** — the anti-cheating honesty position needs **no change whatsoever** |
| `ATT-XC-014`, `ATT-FR-039` | R-5 and R-7 are **already satisfied**, and are **stricter** than the request asks |

**Six of the ten requirements are already met by existing rules.** The open work is R-1, R-2, R-8 and R-10 — all four
of which are the single network-identity question.

## 7. Consequences

- **If accepted:** `ATT-XC-015` is amended in `PRD-006` to point at this decision instead of excluding the topic; `ATT-GAP-007` closes; R-10's definition unblocks duplicate prevention and the multi-AP handoff rule.
- **If left `Proposed`:** `ATT-GAP-007` stays 🔴 OPEN. Wi-Fi Presence cannot be specified, because presence has no verifiable trigger. Existing QR + Wi-Fi attendance is **unaffected** — it never depended on this gap being closed, because Wi-Fi there is only a secondary condition on a QR scan.
- **In every case:** no anti-cheating rule is weakened, and no claim of impossibility is made.

## 8. What this ADR explicitly does not do

- It does **not** specify a network-identity mechanism, format, identifier or comparison rule.
- It does **not** propose any numeric threshold, timeout, retry count or tolerance.
- It does **not** amend `ATT-XC-015`, `ATT-FR-039`, `ATT-XC-014` or any other rule.
- It does **not** close `ATT-GAP-007`.
- It does **not** claim any mechanism is spoof-proof.
- It does **not** assert approval by any person or body.
- It does **not** treat `D-13`'s YES as selecting, narrowing to, or hinting at any mechanism — §0 reproduces the Product Owner's own disclaimer to that effect.
- It does **not** close, downgrade or reclassify `ATT-GAP-007`, which remains 🔴 OPEN and merely **narrowed**.
- It does **not** become `Accepted` by virtue of §0. Its status is unchanged: **`Proposed`**.
