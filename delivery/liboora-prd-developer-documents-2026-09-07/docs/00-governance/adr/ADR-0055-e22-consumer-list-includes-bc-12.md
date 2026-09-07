# ADR-0055 — Edge `E-22` must list `BC-12`, the context that carries V1 student-to-student file sharing

| Field | Value |
|---|---|
| **Status** | **Accepted** — 2026-08-20 |
| **Date** | 2026-08-20 |
| **Deciders** | **Architecture Review Board**, acting through the **Architecture Owner** role defined in `PRD_OWNERSHIP_MODEL.md` §2.2 and §2.3 (L85, L102) — the role `PRD_OWNERSHIP_MODEL.md` L284 records as the *only* approving body for a Rank 1–5 document change |
| **Supersedes** | — |
| **Amends** | `docs/10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md` (Rank 4) — §7, edge **`E-22`**, the *Consumer* cell only. **No edge added, no edge removed, no mode changed, no mechanism changed, no contract changed, no context reclassified, no aggregate moved, no invariant altered, no tenancy mode touched.** Executed, see §7 |
| **Amended by** | — |
| **Baseline** | **No baseline re-issue.** BC Map is **Rank 4**; `DOCUMENTATION_BASELINE.md` §7 step 4 moves the baseline identifier *"only when a Rank 1–3 document changes version"*. `ADR-0016` recorded the identical exemption for the identical cell |
| **Closes** | **`FIL-GAP-012`** and blocker **`B-11`** — the architecture half only, see §5 |
| **Does NOT close** | `FIL-GAP-001`…`011`, `FIL-GAP-013`, `B-2`, `GCP-20`, `GCP-22`, `ADR-0022`, or any acceptance criterion. **This ADR authorises an edge; it verifies no code** |
| **Related** | **`ADR-0016`** (the exact one-cell precedent, `BC-10`) · `ADR-0011` (created the omission class) · `ADR-0054` (froze `PRD-017` carrying this gap) · `ADR-0013` §5 · `FIL-FR-006`, `FIL-FR-007`, `FIL-FR-075`…`082` · `FIL-XC-019`, `FIL-XC-020`, `FIL-XC-022` · BC Map **L292** (the governing rule), **L331** (`E-22`), **L378** (`BC-12`) · `tool/module_dependencies.yaml` **L242** · `S3-A-01` |

> ✅ **ACCEPTED 2026-08-20. The migration in §7 has been executed.**
>
> This is the **second** instance of the defect class `ADR-0016` opened: a **Rank 3 PRD depends on an edge the
> Rank 4 edge register does not list**, and BC Map L292 rules that an unlisted edge **does not exist**. As in
> `ADR-0016`, the map is genuinely *incomplete* rather than mis-citing, and the contradiction is **live between
> ranks** — here it is sharper than in `ADR-0016`, because the **module manifest already grants the port** while
> the map denies the edge. Two authoritative records disagree today.

---

## 1. Context

### 1.1 The rule that makes this a defect, and that also forbids fixing it quietly

Bounded Context Map §7, **line 292**:

> *"Every edge that crosses a context boundary in V1. If an edge is not in this table, it **does not exist** and
> adding it requires an ADR."*

The rule cuts both ways, exactly as `ADR-0016` §1.1 observed. It is why this ADR exists — the consumer cannot
simply be typed into the cell — and it is why the omission matters: until amended, the map asserts that
`BC-12 → BC-29` **does not exist**.

`PRD-017` itself refuses to perform this amendment, and says so normatively:

- **`FIL-FR-007`** — the module *"**SHALL NOT** widen `E-22`'s consumer list, and **SHALL NOT** treat a port grant
  in `tool/module_dependencies.yaml` as authorising an edge the BC Map does not record."*
- `PRD-017` §2.5 records that *"a Stage 2 draft has no standing to amend a Rank 4 register"* and names the
  Architecture Owner as the gap's owner.
- `ADR-0054` §3.2 **declined** to perform the amendment, because the authority conferred there was the
  **Governance Owner**, and `PRD_OWNERSHIP_MODEL.md` L85 assigns *"boundaries, ranks, permitted edges"* to the
  **Architecture Owner**. That refusal is the reason this ADR is a separate instrument rather than a paragraph in
  `ADR-0054`.

**Nothing in the chain above was a stall.** Each step routed the decision to the role competent to make it. This
ADR is that role making it.

### 1.2 The live contradiction, measured

`E-22`'s consumer cell and the runtime manifest disagree **today**, before any change:

| Authority | Rank | What it says about `domain/social` reaching File & Media |
|---|---|---|
| BC Map **L331**, `E-22` consumer cell | **4** | Consumers are `BC-01`, `BC-10`, `BC-14`. `BC-11`/`BC-12`/`BC-13` **absent** → under L292 the edge **does not exist** |
| `tool/module_dependencies.yaml` **L242** | runtime manifest | `domain/social` (`contexts: [graph, messaging, safety]`, **L235**) is **granted `platform/services:files`** |

Measured directly:

```
$ grep -n "platform/services:files" tool/module_dependencies.yaml
110:    - platform/services:files     # domain/library   → BC-01  ✅ on E-22
184:    - platform/services:files     # domain/person    → BC-10  ✅ on E-22 (added by ADR-0016)
242:    - platform/services:files     # domain/social    → BC-11/12/13  ❌ NOT on E-22
```

So the manifest grants a port for an edge the map says does not exist. `FIL-FR-007` resolves which one wins — a
port grant is **not** an edge authorisation — so the *manifest* is not the defect and must not be "fixed" by
revoking the grant. The **map is incomplete**, and this is the third grant of the same port whose map row was
never extended.

### 1.3 Why `ADR-0011` is the origin of this class, again

`ADR-0016` §1.2 found that `ADR-0011` extended `E-21`'s consumer list for `BC-10` and **missed `E-22`**. The same
migration is the origin here: `ADR-0011` moved `identity` out of `domain/social` and left the block holding
`graph, messaging, safety` with a `files` port grant (manifest **L233–L234** carry the comment recording the
move), while no `E-22` row was written for any of the three social contexts. `ADR-0016` fixed the `BC-10` half of
that oversight. **This ADR fixes the remaining half.**

---

## 2. The requirement that needs the edge

`PRD-017` **FROZEN v0.1** specifies Student-to-Student Text + File/Media Sharing in `FIL-FR-075`…`FIL-FR-082`,
and the product instruction of 2026-08-20 retains it in **V1** scope. `PRD-017` §2.5 then records the
consequence plainly:

> *"**The V1 product requirement is therefore specified here in full but is not servable until `E-22` lists the
> sharing context.**"*

That is an accurate statement of the architecture, not a complaint about it. `FIL-FR-006` requires the module to
**refuse** a caller whose context is absent from `E-22`. A frozen requirement therefore guarantees that every
student-to-student share is refused at runtime until this cell changes. The specification is complete and
**unservable by construction**.

---

## 3. Which contexts actually need admitting — the necessity test

`FIL-GAP-012` was originally raised against **three** contexts. Stage 3 tested necessity **per context** rather
than admitting the whole cluster, and recorded finding **`S3-A-01`**: *"the `E-22` amendment required by V1
sharing is `BC-12` only."* This ADR re-derives that result independently from BC Map §8 rather than adopting it
on trust, because admitting a context that does not need the edge would be exactly the "unauthorized dependency
edge" the instruction forbids.

| Context | BC Map §8 row | Does it need to hold or fetch bytes for V1 sharing? | Ruling |
|---|---|---|---|
| **`BC-12` Messaging** | **L378** — owns `Conversation`; `Message`, `DeliveryReceipt`, `RetentionPolicy`; *"participants must satisfy `canMessage` at send time"* | **YES.** A shared file is an attachment **on a message in a conversation**. `BC-12` owns the `Message` that carries the `FileRef`, must obtain the object's metadata to render it, and must request the signed URL when a recipient opens it. Nothing else can do this without taking over message semantics | ⛔ **ADMIT** |
| `BC-11` Social Graph | **L377** — owns `Friendship`, `BlockList`, `FriendRequest` | **NO.** `BC-11` answers *"may these two people interact"* — a boolean over the graph. It never holds a `FileRef`, never renders an attachment, never needs a signed URL. Admitting it would let the friendship graph fetch bytes it has no reason to touch | ✅ **DO NOT ADMIT** |
| `BC-13` Trust & Safety | **L379** — owns `ModerationCase`, `AbuseReport`, `EnforcementAction` | **NO.** Moderation reaches File & Media by **`E-14`**, which is **outbound from `BC-13`** — enforcement fan-out. `BC-13` instructs deletion; it does not consume the file capability inbound. `FIL-XC-022` already forbids this module originating a moderation verdict | ✅ **DO NOT ADMIT** |

**Ruling: `E-22` admits `BC-12` and only `BC-12`.** This is the **minimum architecture change** that makes the
frozen sharing requirement servable — one context, one cell, and the two contexts that do not need the edge stay
off it.

### 3.1 What was deliberately *not* done

| Tempting move | Refused because |
|---|---|
| Admit `BC-11`, `BC-12`, `BC-13` together, since the manifest grants the port to `domain/social` as a whole | The manifest's unit is the **module**; the BC Map's unit is the **context**. Widening to the module's granularity would admit two contexts that fail the §3 necessity test. **The map is the finer instrument and it stays finer.** The residual manifest/map asymmetry is recorded in §6 rather than erased |
| Revoke the `platform/services:files` grant at manifest L242 to remove the contradiction | That would "resolve" the contradiction by breaking the frozen requirement instead of enabling it. `FIL-FR-007` already establishes the grant is not an authorisation, so the grant is harmless; the missing map row was the defect |
| Move share-eligibility, conversation semantics or moderation into `BC-29` so no new edge is needed | Precisely the ownership migration the instruction forbids. `FIL-XC-019`/`020`/`022` exist to prevent it, and they are **frozen**. An edge is the correct instrument; ownership transfer is not |
| Add a brand-new edge `BC-12 → BC-29` | Unnecessary and worse: `E-22` **is** the "consume the file capability" edge. A second edge for the same relationship would fragment the register and duplicate the contract |
| Let `PRD-017` widen the list itself, now that it is FROZEN | `FIL-FR-007` forbids it; the freeze does not confer architecture authority; and `ADR-0054` already declined for want of the Architecture Owner role |
| Close `FIL-GAP-012` outright and call the capability shippable | The gap has an **architecture** half and an **implementation** half. §5 closes only the half this ADR can reach |

---

## 4. Decision

1. **`E-22`'s consumer cell is amended** from `BC-01, BC-10, BC-14` to `BC-01, BC-10, BC-12, BC-14` — ordered
   numerically, matching the existing cell's convention.
2. **`BC-12` Messaging is authorised** to consume the `BC-29` File & Media capability over `E-22`, under `E-22`'s
   **existing and unchanged** contract: *"Domain holds a `FileRef`, never bytes or a raw storage path."*
3. **`BC-11` and `BC-13` are NOT admitted.** They fail the §3 necessity test. A future need must be its own ADR.
4. **No ownership moves.** `BC-11` keeps eligibility/friendship/blocking; `BC-12` keeps conversation and message
   semantics; `BC-13` keeps moderation; `BC-29` keeps storage and the media lifecycle. `FIL-XC-019`, `FIL-XC-020`
   and `FIL-XC-022` remain in force **unamended** and this ADR relies on them.
5. **No new edge, no mode change, no contract change.** `CF` and *"Sync port"* are untouched. Context count
   remains **31 (23 in V1)**.
6. **Tenancy is unchanged.** `E-22` already carries a global-class consumer (`BC-10`, admitted by `ADR-0016`), so
   a global-class shared object introduces no new isolation model — Stage 3 finding `S3-A-02`. `BC-12` is a
   tenant-scoped context and `FIL-FR-044`'s purpose/isolation register continues to govern; **no `PRD-013`
   constraint is relaxed**.
7. **`FIL-FR-006` now admits the sharing caller by operation of the amended cell** — the requirement's *text* is
   unchanged, and that is the point: it was written to read the register, so amending the register changes the
   outcome without touching the frozen requirement.
8. **BC Map version → v1.8**, changelog row added, per baseline §7 rules 2 and 3.
9. **No baseline re-issue** — Rank 4, per baseline §7 step 4 and the `ADR-0016` precedent.

---

## 5. What this ADR closes, and what it explicitly does not

**`FIL-GAP-012` / `B-11` has two halves, and honesty requires separating them.**

| Half | Status after this ADR | Evidence |
|---|---|---|
| **Architecture authorisation** — *"is `BC-12` permitted to consume the file capability?"* | ✅ **CLOSED.** `E-22` lists `BC-12`; BC Map v1.8; L292 satisfied | §7 migration, executed and verified |
| **Implementation** — *"does the code refuse or serve a `BC-12` caller?"* | ⛔ **OPEN.** No `lib/` code implements `FIL-FR-006`'s register check, and `B-2`'s seven architecture tests are still missing | No Flutter code was written in this task, by instruction |

So: **the blocker on the *implementation tasks* is lifted; the *capability* is not thereby verified.** `IMPL-1230`
…`1236` may leave `BLOCKED` because the authority they waited on now exists. They may **not** be marked done.

**`ADR-0054`'s statement that `PRD-017` froze carrying an open `FIL-GAP-012` remains true as of that baseline** and
is not retroactively edited. This ADR is the later act that resolves it, and the gap register records the
transition rather than pretending the gap never existed.

---

## 6. Residual asymmetry, disclosed rather than erased

After this amendment, `domain/social`'s manifest grant still exceeds its map authorisation:

| Manifest grant (L242) | Contexts in that module | On `E-22` after v1.8 |
|---|---|---|
| `platform/services:files` to `domain/social` | `graph` (`BC-11`), `messaging` (`BC-12`), `safety` (`BC-13`) | **`BC-12` only** |

This is **not** a defect to fix by widening the map. It is the ordinary consequence of the manifest being
**module-grained** and the map being **context-grained**, and it is already how `ADR-0016` left `domain/person`.
The runtime guard against a `BC-11` or `BC-13` caller slipping through the module-level grant is **`FIL-FR-006`**,
which tests the *caller's bounded context* and not its module. That requirement is frozen and unamended.

Recorded as a **new open item**, `GCP-23`, so the asymmetry is tracked rather than assumed benign:

> **`GCP-23`** — The module manifest grants `platform/services:files` at module granularity while `E-22`
> authorises at context granularity. `FIL-FR-006` is the only mechanism preventing an unauthorised context inside
> a granted module from consuming the capability, and it is **specified but not implemented** (`B-2`). Until a
> boundary or architecture test enforces context-level checking, the module-level grant is broader than the
> authorisation. Owner: Architecture Owner + Technical Owner. **OPEN.**

---

## 7. Migration requirements — **executed 2026-08-20**

| # | Change | Document | Rank | Executed |
|---|---|---|---|---|
| **M1** | §7 `E-22`: consumer cell `BC-01, BC-10, BC-14` → `BC-01, BC-10, BC-12, BC-14`, with the amending ADR cited in the contract cell as `ADR-0016` is | `LIBOORA_BOUNDED_CONTEXT_MAP.md` | **4** | ✅ |
| **M2** | Version → **v1.8**; changelog row; *"unchanged by v1.1…v1.7"* count note extended to v1.8 | same | **4** | ✅ |
| **M3** | Register this ADR | `ADR-INDEX.md` | — | ✅ |
| **M4** | Record `FIL-GAP-012` / `B-11` architecture half CLOSED; open `GCP-23` | `PRD-017` §16 (via `ADR-0056`), `DOCUMENTATION_BASELINE.md` §6 | 3 / 2 | ✅ |
| **M5** | Review `IMPL-1230`…`1236` blocked status | `PRD-017_IMPLEMENTATION_TASKS.md` | 4 | ✅ |

**Not required:** no baseline re-issue caused by this ADR (Rank 4 — baseline §7 step 4); **no change to
`tool/module_dependencies.yaml`** (see §6 — the grant is not the defect); no change to `E-14`, `E-16`, `E-20`,
`E-21`; no context, aggregate, invariant, event, identity rule or tenancy mode changed; no `lib/` source file
touched.

---

## 8. Consequences

**Positive.** The frozen V1 sharing requirement becomes servable in principle. The manifest/map contradiction of
§1.2 is resolved in the direction the higher-precedence document requires. The `ADR-0011` omission class is now
fully closed for `E-22` — both `BC-10` and `BC-12`.

**Negative / accepted.** `E-22` now has four consumers, and every one of them widens the blast radius of a
`BC-29` outage; `PRD-017` §13's failure requirements are the mitigation and they are unverified. `GCP-23` is new
debt created by *disclosing* an asymmetry that previously went unstated — the asymmetry existed before this ADR;
only its record is new.

**Not a consequence.** No context gained an aggregate. No PRD gained ownership. No entitlement changed. Nothing
became verified.

---

## 9. Compliance

| Rule | Where | Satisfied by |
|---|---|---|
| *"Adding requires an ADR"* | BC Map **L292** | This ADR, accepted before the edit |
| *"A change to any Rank 1–5 document requires an ADR before the change"* | Baseline §7 rule 1 | Same |
| Version incremented + changelog, same commit | Baseline §7 rules 2–3 | M2 |
| Baseline identifier moves only for Rank 1–3 | Baseline §7 rule 4 | No re-issue; Rank 4 |
| *"Only the Architecture Owner approves"* | `PRD_OWNERSHIP_MODEL.md` **L284** | Deciders row |
| *"Ownership or boundary change… MUST NOT be amended by a PRD revision alone"* | `PRD_LIFECYCLE.md` **L174**, `LIB-26.2` | An ADR, not a PRD revision |
| Ownership boundaries preserved | `FIL-XC-019`/`020`/`022`, BC Map §8 | §4 item 4; no exclusion amended |

---

## 10. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-20 | Created and **Accepted**. Amends BC Map §7 edge `E-22`, consumer cell only, admitting **`BC-12` Messaging** and no other context. Closes the **architecture half** of `FIL-GAP-012` / `B-11`; leaves the implementation half open. Opens **`GCP-23`** for the module-vs-context granularity asymmetry. Re-derives Stage 3's `S3-A-01` independently from BC Map §8 rather than adopting it. Follows `ADR-0016` as the exact precedent, including its no-baseline-re-issue exemption |
