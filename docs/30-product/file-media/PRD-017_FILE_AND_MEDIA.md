# PRD-017 — File & Media

| Field | Value |
|---|---|
| **PRD** | `PRD-017` |
| **Module** | File & Media |
| **Version** | **v0.1** |
| **Status** | **`DRAFT`** — [`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md) **Stage 2 (Draft)**. Stages 3–7 not yet run. **This document confers no status on itself** |
| **Owning bounded context** | **`BC-29` File & Media** `[GENERIC]` — Platform Services, BC Map **L138** |
| **Product version** | **V1** — `MASTER_PRD.md` **L194** and **L638** (Rank 1), BC Map **L138** (Rank 4), `PRD_REGISTRY.md` **L307** |
| **Owned aggregate** | **NONE ASSERTED — see §6.1 and `FIL-GAP-001`.** BC Map §8 lists **17** aggregate rows and `BC-29` is **not among them** (measured: 0). This document does **not** mint one |
| **Module path** | `platform/services` (**rank 3**, `tool/module_dependencies.yaml` **L33**) |
| **Manifest port name** | `platform/services:files` — **3 declared consumers, 0 providers** (`FIL-GAP-002`) |
| **Integration edge** | **`E-22`** — BC Map **L331**: *"`BC-01`, `BC-10`, `BC-14` → `BC-29` File & Media \| `CF` \| Sync port \| Domain holds a `FileRef`, never bytes or a raw storage path"* |
| **Requirement prefix** | **`FIL-`** — selected by measurement, §0.4 |
| **Lifecycle stage** | **Stage 2 — Draft.** Stage 1 evidence was gathered in the read-only audit recorded in §18.2; **no `PRD-017_STAGE1_DISCOVERY.md` artefact exists** and this document does not claim one (`FIL-GAP-008`). Stages 3, 4, 5, 6, 7 **NOT BEGUN** |
| **Governing authority** | [`ADR-0013`](../../00-governance/adr/ADR-0013-capability-context-ownership.md) — **`ACCEPTED`** 2026-08-04, `BASELINE-2026-08-04-B`. §5 assigns `BC-29` to `PRD-017`; **§2.1 states it does *not create* `PRD-017`**. **This document is that write** |
| **Registry status** | **`PLANNED`** in [`PRD_REGISTRY.md`](../../00-governance/prd-ecosystem/PRD_REGISTRY.md) §4.3 **L307**. **Not changed by this document** — the register is written by a governance act, not by its subject |
| **Rank** | **None yet.** Rank 3 is conferred by [`DOCUMENTATION_BASELINE.md`](../../00-governance/DOCUMENTATION_BASELINE.md) §3.3/§4 at Stage 7, **not claimed here** |
| **Baseline** | Written against **`BASELINE-2026-08-20-A`** — the baseline current when this text was authored |
| **Date** | 2026-08-20 |

> ⚠ **Two frozen Rank 3 documents already depend on this specification, and it did not exist until now.**
> `PRODUCT_IMPLEMENTATION_ROADMAP.md` **L93** states it: *"Already consumed by `PRD-002` (`LIB-6.6`) and `PRD-003`
> (`SID-4.35`) — **two frozen PRDs depend on an unwritten one**."* `PRD_GAP_ANALYSIS.md` **L258** adds the same
> finding under `PGA-04`: *"ownership exists — **requirements do not**."* This document supplies the requirements.
> It **does not** amend either frozen PRD, and where a frozen requirement already fixes a rule, this document
> **cites** it rather than restating it, so no second source of truth is created.

> ⚠ **Scope is bounded by `ADR-0013` §5, not negotiated here.** The ownership formula is
> *"**Binaries owned by `BC-29`; `FileRef`s held by consumers**"*. This document therefore specifies the
> **capability contract** — upload, storage, access, lifecycle — and specifies **nothing** about the tenant-facing
> records that hold a `FileRef`. Where a reader expects a file-adjacent concern that is absent here, **§15 names
> its owner**.

---

## 0. Reading this document

### 0.1 Normative language

| Term | Meaning |
|---|---|
| **MUST** / **SHALL** | An absolute obligation. Non-compliance is a defect |
| **MUST NOT** / **SHALL NOT** | An absolute prohibition |
| **SHOULD** | Recommended. A departure requires a recorded reason |
| **MAY** | Permission. No obligation either way |
| *cited* | A statement whose authority lives elsewhere. Reproduced for navigation, **not** made true here |

Every obligation in this document carries an identifier. **There are no unnumbered requirements.**

### 0.2 Identifier registers — declared up front, with ranges

`PRD_LIFECYCLE.md` **L79–86** requires registers published *"up front, with ranges"*, and L82 rule 3 adds that
ranges must be contiguous because *"a gap makes the published range false"*. The ranges below are a promise: no
identifier outside them exists in this document, and every identifier inside them is defined **exactly once**.

**Class A — obligation-bearing registers**

| Prefix | Meaning | Count | Range | Contiguous? |
|---|---|---|---|---|
| `FIL-FR-` | Functional requirement | **82** | `FIL-FR-001` … `FIL-FR-082` | Yes |
| `FIL-BR-` | Business rule | **17** | `FIL-BR-001` … `FIL-BR-017` | Yes |
| `FIL-INV-` | Invariant | **11** | `FIL-INV-001` … `FIL-INV-011` | Yes |
| `FIL-EVT-` | Domain event published by this context | **0** | **DECLARED EMPTY** — see §0.3 | n/a |
| `FIL-XC-` | Exclusion — a prohibition with a named owner elsewhere | **22** | `FIL-XC-001` … `FIL-XC-022` | Yes |

**Class B — supporting registers**

| Prefix | Meaning | Count | Range | Contiguous? |
|---|---|---|---|---|
| `FIL-AC-` | Acceptance criterion | **78** | `FIL-AC-001` … `FIL-AC-078` | Yes |
| `FIL-CFG-` | Configurable parameter this module publishes | **9** | `FIL-CFG-001` … `FIL-CFG-009` | Yes |

**Class C — finding register**

| Prefix | Meaning | Count | Range | Contiguous? |
|---|---|---|---|---|
| `FIL-GAP-` | Open gap this PRD records but cannot close | **13** | `FIL-GAP-001` … `FIL-GAP-013` | Yes |

> **Totals: 232 identifiers across 8 registers, of which 1 is declared EMPTY. 132 are obligation-bearing.**
> **No identifier is retired; none has ever been issued before.**

### 0.3 `FIL-EVT-*` is DECLARED EMPTY, and this is a finding rather than an omission

**Measurement.** BC Map §9 — the Event Surface register — was scanned for rows in which `BC-29` is the
**producer**: `grep -c '^| BC-29'` → **0**. BC Map **L292** holds that *"if an edge is not in this table, it does
not exist and adding it requires an ADR"*, and §7's equivalent rule governs the context table.

Minting an event name here would therefore assert a publication path that a **Rank 4 frozen** document says does
not exist — a Stage 3 failure, not a Stage 2 convenience. `BC-29` is a **synchronous capability** in the map:
its single edge `E-22` is typed `CF` (*"Sync port"*), not `PL` (event). Emptiness is stated so that a reader can
distinguish *"this module publishes nothing"* from *"someone forgot the register"*.

This follows the precedent set four times: `TEN-EVT-*`, `AUD-EVT-*`, `ENT-EVT-*` and `CNF-EVT-*` are all
declared empty on measured evidence. `FIL-FR-062` states the prohibition **positively** so the emptiness is
enforceable rather than merely described, and `FIL-GAP-004` records the consequence: **audit of file operations
cannot travel by `E-20`** from this module, because `E-20` is an event edge and this module publishes no event.

### 0.4 The identifier prefix — `FIL-`, chosen by measurement before anything was written

`PRD_LIFECYCLE.md` **L82** rule 2: *"Prefixes are chosen against §5's collision procedure **before** writing."*
§5 rule 2 requires a prefix *"checked against every existing register before use"*, and rule 3 adds that on
collision *"change the new prefix, never the existing one"*.

**Forward scan — is the candidate occupied?** Anchored across `docs/ tool/ lib/ test/`:

| Candidate | `\bX-[0-9]+` | `\bX-{FR,BR,INV,EVT,XC,CFG,AC,GAP,NFR}-[0-9]+` | Verdict |
|---|---:|---:|---|
| **`FIL-`** | **0** | **0** across all nine suffixes | ✅ **free** |
| `FM-` | 0 | — | ⚠ free, **rejected on ambiguity** — two letters, and `FM` is a common abbreviation |
| `MED-` | 0 | — | ⚠ free, **rejected on scope** — names only the media half; this module owns documents and PDFs too |
| `FILE-` / `MEDIA-` | 0 | — | ⚠ free, **rejected** — both are ordinary English words, the hazard `SET-` was rejected for in `PRD-023` |

**Reverse hazard — does any existing word *embed* the candidate?** A lookbehind scan, using the corrected form
that `S5-C-02` established after the first attempt read its own match instead of the preceding character:

```
grep -roP '(?<=[A-Za-z0-9])FIL-' docs/ tool/ lib/ test/   →  0
grep -roP '(?<=[A-Za-z0-9])MED-' docs/ tool/ lib/ test/   →  0
```

**Substring hazard in the other direction** — does any existing prefix *end* in a letter that would absorb
`FIL-`? `grep -roE '\b[A-Z]*FIL-'` → **0 matches**, so no register such as a hypothetical `PROFIL-` exists.

**Why `FIL-` over the equally-free `FM-`.** `PRD-023` §6 recorded that a prefix should be *"a token that appears
in prose only when someone means this register"*. `FIL-` satisfies that; `FM-` is short enough to collide with
future prose and is not obviously derived from the module name. Choosing the shorter prefix would optimise for
today's typing and against every future `grep`.

⚠ **A scanning caution recorded for Stage 5, not resolved here.** `FIL-INV-*` coexists with the platform register
`INV-n` (`INV-1`…`INV-16`) and with `INV-SEC-*` / `INV-XC-*`. `FIL-INV-001` is a **distinct token** from `INV-1`,
so this is **not** a collision — but a naive `grep 'INV-'` will over-count. `PRD-014` `R-02` and `PRD-023` §6
raised the identical point and carried it as a **scanning requirement**. The same disposition applies.

### 0.5 What this document deliberately does not do

| Not done | Why |
|---|---|
| Write code or SQL | Out of scope for Stage 2 by instruction; and a schema is Stage 3/6 work |
| Assert an aggregate for `BC-29` | BC Map §8 grants it none. `FIL-GAP-001` records the gap; **this document takes no side** |
| Add, rename or widen an `E-*` edge | BC Map **L292** requires an accepted ADR. `FIL-GAP-003` records the need |
| Amend `LIB-6.6`, `SID-3.19`, `SID-3.20`, `SID-4.35`, `SID-4.36` or `SID-4.37` | All **FROZEN Rank 3**. This document **satisfies** them; it changes none |
| Name a storage vendor | `MP-CON-01` forbids a vendor name in domain code; `MP-CON-02` makes BaaS choice *"a deployment decision, not an architecture decision"* |
| Resolve any contradiction found in the audit | §16 measures and records them. Resolution belongs to the named owner |
| Confer its own status, rank or baseline | Stage 7's, by a baseline row |

---

## 1. Vision and scope

### 1.1 The problem this module exists to solve

Every tenant-facing module in Liboora eventually needs to hold something that is not a row: a library logo, a
student's identity photograph, a scanned admission document, a shared note. If each module solves that problem
locally, the platform acquires as many upload paths, as many validation rules, as many URL-signing schemes and as
many retention behaviours as it has modules — and each one is an independent opportunity for a cross-tenant leak,
which `MP-GBR-09` names *"the single highest-severity failure mode in the architecture"*.

`BC-29` exists so that there is **exactly one** such path. BC Map **L138** states its charter verbatim:

> *"`BC-29` \| **File & Media** \| `[GENERIC]` \| Platform Services \| V1 \| Owns upload, virus scan, thumbnailing,
> signed URLs, storage abstraction."*

### 1.2 The ownership formula, taken from `ADR-0013` rather than invented

`ADR-0013` §5, **ACCEPTED**, fixes the division of rights:

> *"`BC-29` File & Media \| `PRD-017` \| **Binaries owned by `BC-29`; `FileRef`s held by consumers** \| port —
> `platform/services:files`"*

and its normative rule makes the distinction general:

> *"**Context ownership** is the right to define the capability's contract, invariants and lifecycle. **Aggregate
> ownership** is the right to define a specific tenant-facing record that lives within it. They are different
> rights and may be held by different PRDs."*

This document exercises the **first** right and not the second. Everything below is a statement about the
**capability**: what an upload must satisfy, what a stored object must carry, who may read it, how it dies. The
records that *point at* stored objects — `StudentRecord.DocumentRef[]`, `LibraryBranding`,
`GlobalStudentProfile`'s photo — belong to `PRD-004`, `PRD-002` and `PRD-003` and are untouched here.

### 1.3 The V1 line — what ships, and the one item the repository puts in dispute

`FIL-FR-*` below specifies a **single upload path, a single storage abstraction, a private-by-default access
model, signed short-lived read URLs, size/type validation, replace, soft-delete, hard-delete and retention**.
That is the smallest set that can satisfy the two frozen consumers and the BC Map charter.

⚠ **`Virus & Malware Scan` is claimed as V1 by three documents and as V2 by one, and this document follows
precedence rather than choosing.** Measured:

| Document | Rank | Says |
|---|---|---|
| `Student_Identity_PRD_v1.md` **L633** (`SID-3.20`) | **3, FROZEN** | *"Uploads **SHALL** pass virus scanning and **SHALL** be served through signed, expiring URLs — `BC-29`."* |
| `Student_Identity_PRD_v1.md` **L932** (`SID-4.36`) | **3, FROZEN** | *"Upload, virus scanning, thumbnailing and signed-URL issuance **SHALL** be owned by `BC-29`."* |
| `LIBOORA_BOUNDED_CONTEXT_MAP.md` **L138** | **4** | `BC-29` *"Owns upload, **virus scan**, thumbnailing, signed URLs"* — the context is **V1** |
| `LIBOORA_ENTERPRISE_ARCHITECTURE.md` **L1876** | **6, Descriptive** | `Virus & Malware Scan (V2)` · `Image Optimization & Thumbnails (V2)` |

**Precedence resolves this without a judgement call.** The baseline's own cell for the EA reads *"**Descriptive**
— must follow the PRDs, never lead them"*, and `MASTER_PRD.md` **L519** (`MP-CON-08`) states the same rule. The
`ADR-0042` precedent applied it in exactly this shape: a **Rank 6** `(V2)` token was corrected to `(V1)` because
Rank 4 placed the capability in V1. **This document therefore specifies virus scanning and thumbnailing as V1
obligations**, on the two frozen Rank 3 `SHALL`s and Rank 4's context release — and it **does not edit the EA**,
because amending a ranked document is not a Stage 2 act. The drift is recorded as **`FIL-GAP-005`**.

### 1.4 What "smallest production-grade foundation" excludes

Deliberately **not** in V1, and each with its authority: **CDN delivery** (EA L1879, V2 — and no Rank 1–4
document requires it), **document preview rendering** (EA L1878, V3), **media transcoding of video/audio**
(§2.3), **content-addressable de-duplication** (no authority requires it), **a job runtime of this module's own**
(`platform/services:job_runtime` is a separate declared port, EA L1865 places Job Runtime at V2), and **any AI or
ML classification of uploaded content** (`BC-27` AI Assistance owns that, and BC Map §7.4 rules `F-1`/`F-3` make
a domain → `BC-27` edge *architecturally backwards*).

---

## 2. Context and boundary

### 2.1 Position in the architecture

| Property | Value | Authority |
|---|---|---|
| Bounded context | `BC-29` File & Media, `[GENERIC]` | BC Map **L138** (Rank 4) |
| Owning platform | Platform Services | BC Map **L138** |
| Module path / rank | `platform/services`, **rank 3** | `tool/module_dependencies.yaml` **L33** |
| Band | Platform-services band, BC Map **L267** — *not* the FOUNDATIONAL band | BC Map **L267**, **L271** |
| Release | **V1** | `MASTER_PRD.md` **L638**, BC Map **L138** |
| Integration edge | **`E-22`**, `CF`, sync port | BC Map **L331** |
| Port | `platform/services:files` | manifest **L110**, **L184**, **L242** |
| Banned imports | `domain/**`, `app/**` — rank 3 may not import rank 7.5 or 8 | Matrix `L2`; manifest **L518–523** |

`FIL-FR-001` — The module **SHALL** be implemented at `platform/services` (**rank 3**) and **SHALL NOT** import
from `domain/**` or `app/**`. *(Matrix law `L2`, downward-only; manifest `banned_imports`.)*

`FIL-FR-002` — The module **SHALL** expose its entire capability as the registered port
**`platform/services:files`** and **SHALL NOT** be reachable by any other route. *(Manifest **L110**, **L184**,
**L242**; `ADR-0013` §5 *"port — `platform/services:files`"*.)*

`FIL-FR-003` — The module **SHALL NOT** know the identity of any storage vendor in its own contract. A vendor
adapter **SHALL** live behind the storage abstraction and be wired at the composition root. *(`MP-CON-01`;
`MP-CON-02` — *"Choosing a BaaS for V1 is a **deployment decision, not an architecture decision**"*;
`MP-CON-03` — the data layer *"must remain abstract so a dedicated backend can replace direct BaaS access
later"*.)*

### 2.2 What this module owns

1. **Upload** — accepting bytes, validating them, and committing them to storage.
2. **Storage abstraction** — the port behind which any object store may sit.
3. **The `StoredObject` record** — the module's own bookkeeping for a set of bytes: its metadata, owner,
   tenant, lifecycle state. ⚠ **Not asserted as an aggregate** — see §6.1.
4. **`FileRef` issuance** — the opaque identifier consumers hold.
5. **Access mediation** — deciding, per request, whether a signed URL may be issued at all.
6. **Signed, expiring read URLs.**
7. **Virus/malware scanning** of uploaded bytes (§1.3).
8. **Image thumbnailing / derivative generation** (§1.3, and bounded by §8.4).
9. **Lifecycle** — replace, soft-delete, hard-delete, retention execution.

### 2.3 ⛔ What this module does NOT own — the boundary the request names explicitly

**`PRD-017` owns file/media *infrastructure*. It owns no social, messaging or content-sharing behaviour.**
Each exclusion below names the owner, so the boundary is enforceable rather than aspirational.

`FIL-XC-001` — The module **MUST NOT** define, store or evaluate a **social feed**, a friendship, a friend
request, a block, a follow or any social-discovery rule. *(Owner: `BC-11` Social Graph — `PRD-021`. BC Map
**L115**, **L377**.)*

`FIL-XC-002` — The module **MUST NOT** define a **conversation, message, delivery receipt, presence signal or
messaging retention policy**, and **MUST NOT** decide whether two people may message one another. *(Owner:
`BC-12` Messaging — `PRD-021`. BC Map **L116**, **L378**. `canMessage` is evaluated at send time by `BC-12`.)*

`FIL-XC-003` — The module **MUST NOT** define **comments, likes, reactions or any engagement counter** on a
stored object. *(No context in BC Map §3 owns these at V1; the nearest is `BC-14` Content Sharing at **V2**.
Naming an owner here would invent one — recorded as **`FIL-GAP-006`**.)*

`FIL-XC-004` — The module **MUST NOT** define **copyright, licensing, attribution or takedown** rules for
user-generated content. *(Owner: `BC-14` Content Sharing — BC Map **L118**: *"Owns user-generated notes, media,
links; **copyright and takedown**"*. ⚠ `BC-14` is **V2**; see `FIL-GAP-007`.)*

`FIL-XC-005` — The module **MUST NOT** make an **authorisation decision**. It **MUST** ask `BC-18` per request
through `platform/identity:policy_decision` and **MUST NOT** cache the answer. *(Matrix `X-13`: an authorisation
decided outside `BC-18` is *"a security defect that passes its own tests"*. `MP-GBR-26` forbids caching;
manifest **L186** carries the same comment.)*

`FIL-XC-006` — The module **MUST NOT** define the platform's **tenant-partitioning mechanism, row-level security
model or tenant context propagation**. It **MUST** consume `platform/tenancy:tenant_context`. *(Owner: `BC-19`
Tenancy — `PRD-013`, `TEN-FR-002`, `TEN-FR-013`.)*

`FIL-XC-007` — The module **MUST NOT** decide **what is auditable** in another bounded context, nor define the
audit record. *(Owner: `BC-24` Audit Trail — `PRD-016`, `AUD-FR-003`.)*

`FIL-XC-008` — The module **MUST NOT** define, store or compute a **`FeatureGate`, `UsageCounter` or `Limit`**,
and **MUST NOT** decide whether a tenant is entitled to a quantity of storage. It **MUST** ask through
`platform/business:entitlement`. *(Owner: `BC-21` Entitlement — `PRD-014`, `ENT-FR-012`, `ENT-FR-013`.
See §5.4.)*

`FIL-XC-009` — The module **MUST NOT** define a **configuration value's default, range or resolution order**.
It **MUST** read every configurable through `platform/configuration:settings`. *(Owner: `BC-25` Configuration —
`PRD-023`, edge `E-19`. See §8.5.)*

`FIL-XC-010` — The module **MUST NOT** define a **design token, colour, typeface or component**. *(Owner: UI
Design System — `MP-NFR-06`, `MP-NFR-08`, Rank 1. ⚠ **The document does not exist**; `FIL-GAP-009`.)*

`FIL-XC-011` — The module **MUST NOT** index stored objects for **search or discovery**, nor read another
module's store to do so. *(Owner: `BC-23` Search Indexing — `PRD-015`, edge `E-21`, Matrix `X-08`.)*

`FIL-XC-012` — The module **MUST NOT** perform **OCR, vision, classification, tagging, summarisation or any
model inference** on stored bytes. *(Owner: `BC-27` AI Assistance. BC Map §7.4 rules `F-1`/`F-3` make a
domain → `BC-27` edge architecturally backwards; `ADR-0022` §2.2 records the same finding for `ATT-GAP-011`.)*

`FIL-XC-013` — The module **MUST NOT** define, own or interpret any **tenant-facing business record** that holds
a `FileRef` — including `StudentRecord`, `DocumentRef`, `LibraryBranding`, `GlobalStudentProfile` or the Library
Identification Photo. *(`ADR-0013` §5: *"`FileRef`s held by consumers"*. Owners: `PRD-004`/`BC-01`,
`PRD-002`/`BC-06`, `PRD-003`/`BC-10`.)*

`FIL-XC-014` — The module **MUST NOT** deliver content over a **CDN** or define a cache-invalidation topology
for public delivery. *(EA **L1880** places CDN Delivery at **V2**; no Rank 1–4 document requires it at V1.)*

`FIL-XC-015` — The module **MUST NOT** render a **document preview**. *(EA **L1878**: Document Preview **V3**.)*

`FIL-XC-016` — The module **MUST NOT** implement **video or audio transcoding, streaming, adaptive bitrate or
media playback**. *(No Rank 1–4 authority requires it at V1; see §2.4.)*

`FIL-XC-017` — The module **MUST NOT** operate its own **worker pool, queue, retry scheduler or cron**. It
**MUST** consume `platform/services:job_runtime`. *(Manifest **L338**; EA **L1865** places Job Runtime at V2 —
see `FIL-GAP-010`.)*

`FIL-XC-018` — The module **MUST NOT** define the platform's **client mutation queue, replay or conflict
resolution**. *(Owner: `BC-30` Offline Sync — `PRD-018`, BC Map **L139**, edge `E-24`.)*

`FIL-XC-019` — The module **MUST NOT** decide **whether two people may exchange anything**. It stores no
friendship, no block, no rate limit and no `canMessage` result, and re-evaluates none of them. *(Owner: `BC-11`
Social Graph — `PRD-021`. BC Map **L115**, **L320**, **L377**. `FIL-FR-076`.)*

`FIL-XC-020` — The module **MUST NOT** define **message text, message ordering, delivery receipts, read receipts,
presence, typing indicators or conversation membership**, and **MUST NOT** store the text of a message. A share
grant is an access record, not a message. *(Owner: `BC-12` Messaging — `PRD-021`. BC Map **L116**, **L378**.
`FIL-FR-075`.)*

`FIL-XC-021` — The module **MUST NOT** implement **public sharing, anonymous sharing, share-by-link without a
named recipient, or public discovery/search of shared files**. Every grant names exactly one recipient
`PersonId`. *(`FIL-FR-075`, `FIL-FR-078`. No Rank 1–4 document requires public file sharing; the product
instruction of 2026-08-20 excludes it explicitly. Discovery is `BC-23`'s — `FIL-XC-013`.)*

`FIL-XC-022` — The module **MUST NOT** implement **abuse reporting, moderation, strikes or bans** over shared
content, and **MUST NOT** decide that a share was inappropriate. *(Owner: `BC-13` Trust & Safety — BC Map
**L117**, **L379**, and `E-14`'s enforcement fan-out. This module executes deletions it is instructed to make; it
originates no moderation verdict.)*

### 2.4 Video and audio — the request asked "where V1 requires them", and the measured answer is *nowhere*

The scope brief includes *"video/audio **where V1 requires them**"*. That conditional was tested rather than
assumed. Every Rank 1–4 statement of `BC-29`'s content types was read:

| Source | Rank | Content types named |
|---|---|---|
| BC Map **L138** | 4 | *"upload, virus scan, **thumbnailing**, signed URLs, storage abstraction"* |
| `MASTER_PRD.md` **L194** | 1 | *"**Student documents**, uploads, signed URLs, virus scan"* |
| `LIB-6.6` (FROZEN) | 3 | **Logo**, **Cover Image** |
| `SID-3.19`, `SID-4.35` (FROZEN) | 3 | **Global Profile Photo** |
| `SID-3.21`/`SID-4.37` (FROZEN) | 3 | **Library Identification Photo** |
| `PRD-004` `DocumentRef[]` (FROZEN) | 3 | Student **documents** |
| EA **L1874–1880** | 6 | Upload, Signed URLs, Virus Scan, Image Optimization, **Document Preview**, CDN |

**No Rank 1–4 document names video or audio as a V1 file type.** The only context that owns *"user-generated
notes, media, links"* is `BC-14`, which BC Map **L118** places at **V2**. Accordingly:

`FIL-FR-004` — V1 **SHALL** support exactly three content classes: **images** (raster, for logos, covers and
photographs), **PDF documents**, and **non-executable office/text documents** enumerated by `FIL-CFG-002`.

`FIL-FR-005` — Video and audio **SHALL NOT** be accepted in V1. The type allow-list `FIL-CFG-002` **SHALL** be
the single point at which this is enforced, so admitting a new class later is a **configuration and entitlement
change, not a redesign**. *(This is the *"future extensibility without overbuilding V1"* requirement discharged
concretely; see also `FIL-FR-071`.)*

### 2.5 ⚠ Two frozen consumers and a consumer list that does not match the manifest

`E-22`'s consumer list is **exactly** `BC-01`, `BC-10`, `BC-14` (BC Map **L331**). The module manifest grants
the `platform/services:files` port to **three** modules: `domain/library` (**L110**), `domain/person` (**L184**)
and `domain/social` (**L242**). Mapping one to the other:

| Manifest module | Contexts it holds | On `E-22`'s list? |
|---|---|---|
| `domain/library` **L110** | `enrollment` (`BC-01`), membership, attendance, seating, fee, policy | ✅ `BC-01` is listed |
| `domain/person` **L184** | `identity` (`BC-10`) | ✅ `BC-10` is listed, added by `ADR-0016` |
| `domain/social` **L242** | `graph` (`BC-11`), `messaging` (`BC-12`), `safety` (`BC-13`) | ⛔ **None of the three is on `E-22`** |
| — | `BC-14` Content Sharing | ⚠ **listed on `E-22`, but is V2, and holds no manifest module** |

**This is a contradiction between a Rank 4 register and the module manifest, and this document does not resolve
it.** It is recorded as **`FIL-GAP-003`** and specified around:

`FIL-FR-006` — The module **SHALL** serve a caller only where the caller's bounded context appears in `E-22`'s
consumer list as recorded in BC Map §7.3. A caller whose context is absent **SHALL** be refused.
*(BC Map **L292**: *"If an edge is not in this table, it does not exist."* `ADR-0022` §1 applies the same
reading to `BC-03`.)*

`FIL-FR-007` — The module **SHALL NOT** widen `E-22`'s consumer list, and **SHALL NOT** treat a port grant in
`tool/module_dependencies.yaml` as authorising an edge the BC Map does not record. *(`ADR-0022` §7: *"No edge
added."* Widening requires an accepted ADR.)*

> ⚠ **The consequence is stated rather than hidden.** Under `FIL-FR-006`, a `domain/social` caller is refused
> today even though the manifest grants it the port. That is the *specified* behaviour because the Rank 4 register
> outranks the manifest — but it means **`domain/social`'s declared file access is currently unusable**, which is
> a live defect in one of the two documents. Its owner is the **Architecture Owner**; `FIL-GAP-003`.

### 2.6 Student-to-student sharing is a V1 capability, and what that costs

**Product decision, recorded 2026-08-20: student-to-student sharing of study material is in V1 scope.** A student
may send another eligible student a PDF, a photograph of handwritten notes, an assignment, a reference document,
or a text message carrying study information. This subsection states what that requires of **this** module and,
just as importantly, what it does **not** move here.

**The capability needs no new bounded context and no V2 feature.** That is measured, not assumed:

| Element | Owner | V1? | Evidence |
|---|---|---|---|
| Friendship / eligibility to contact | `BC-11` Social Graph — `PRD-021` | ✅ **V1** | BC Map **L115** |
| Conversation, message, delivery, retention | `BC-12` Messaging — `PRD-021` | ✅ **V1** | BC Map **L116**, **L378** |
| `canMessage(a, b)` at send time | `BC-11`, asked by `BC-12` | ✅ **V1** | BC Map **L320** (`E-16`), **L378** |
| Abuse reports, moderation, blocks | `BC-13` Trust & Safety | ✅ **V1** | BC Map **L117** |
| The **bytes** of a shared file | **`BC-29` — this module** | ✅ **V1** | `ADR-0013` §5 |
| The **text** of a message | `BC-12` — **not this module** | ✅ **V1** | `FIL-XC-002` |

⚠ **`BC-14` Content Sharing is *not* the owner of this capability and is not needed for it.** `BC-14` is **V2**
(BC Map **L118**) and owns *"copyright and takedown"* over published user-generated content — a publishing and
rights concern, not peer-to-peer transfer. Peer sharing rides `BC-11`/`BC-12`, both already **V1**. Nothing in
this subsection promotes `BC-14`, and `FIL-GAP-007` is unchanged.

⛔ **The blocker is `E-22`, and this document does not clear it.** `BC-11`, `BC-12` and `BC-13` are **absent from
`E-22`'s consumer list** (§2.5), so under `FIL-FR-006` a `domain/social` caller is refused — *including* a
student-to-student share. **The V1 product requirement is therefore specified here in full but is not servable
until `E-22` lists the sharing context.** Widening a Rank 4 edge requires an accepted ADR (BC Map **L292**), and
`ADR-0016` is the exact precedent: it amended *"the Consumer cell only. No edge added, no edge removed, no mode
changed"* to admit `BC-10` for `SID-4.35`. **This PRD does not write that ADR** — a Stage 2 draft has no standing
to amend a Rank 4 register, and `ADR-0013` §2.1 shows even an accepted ADR states plainly what it does not do.
Recorded as **`FIL-GAP-012`**, severity **Blocking**, owner **Architecture Owner**, and as blocker **`B-11`**.

**What this module adds for sharing is a purpose and a grant, not a social model.** `FIL-FR-004`'s three content
classes already cover *"PDF notes, handwritten-note images, assignments, study material, reference documents"* —
**no type widening is required**, and video/audio messaging stays excluded by `FIL-FR-005`. What is genuinely new
is that an object must become readable by a **person who did not upload it**, which every requirement before this
subsection assumed away. `FIL-FR-075`…`FIL-FR-082` specify exactly that and nothing more.

---

## 3. Actors and permissions

### 3.1 Actors

This module has **no actor model of its own**. Every actor below is defined elsewhere and is *cited*.

| Actor | Defined by | Interaction with this module |
|---|---|---|
| **Authenticated person** | `BC-18` Authentication / `BC-10` `PersonId` | Uploads and reads objects they are permitted to |
| **Library staff (role-bearing)** | `BC-18`; `MP-GBR-23` — *"independent grants per library"* | Uploads and reads within one tenant |
| **Guardian** | `MP-GBR-05`; scope `guardianOf` (`MP-GBR-21`) | Reads a minor's objects where the scope permits |
| **Consuming bounded context** | BC Map §7.3 `E-22` | Calls the port on behalf of a caller |
| **The platform itself** | — | Executes retention and hard-delete (§9.6) |
| **Support / operator** | `BC-24` records support access | Has **no** privileged read path here (`FIL-FR-021`) |

### 3.2 The permission model is consumed, never defined

`FIL-FR-008` — Every access decision **SHALL** be obtained from `BC-18` through
`platform/identity:policy_decision`, per request, and **SHALL NOT** be cached, memoised or inferred from a prior
answer. *(`MP-GBR-26`; manifest **L186**; `X-13`.)*

`FIL-FR-009` — The module **SHALL** treat a permission as **scope-bearing**: holding a permission is not the same
as being able to exercise it on a given object. *(`MP-GBR-20`, Rank 1, verbatim.)*

`FIL-FR-010` — The module **SHALL** recognise exactly the three scopes `self`, `guardianOf` and `tenantWide`, and
**SHALL NOT** introduce a fourth. *(`MP-GBR-21` — *"The scope register is closed… No fourth scope may be
introduced without an ADR."*)*

`FIL-FR-011` — A refusal on a `self` or `guardianOf` scope **SHALL** be **indistinguishable from not-found**. The
response **SHALL NOT** disclose that the object exists. *(`MP-GBR-22`, Rank 1 — *"authorization must not disclose
existence"*.)*

`FIL-FR-012` — A grant held in one tenant **SHALL** confer nothing in another. *(`MP-GBR-23`.)*

`FIL-BR-001` — Permission to **read** an object and permission to **replace or delete** it are distinct and
**SHALL** be evaluated separately. Read access **SHALL NOT** imply write access.

`FIL-BR-002` — The **uploader** of an object holds no implicit permanent right over it. Rights follow the
permission model at the time of the request, not the identity recorded at upload. *(Otherwise a staff member who
leaves a library retains access — the harm `MP-GBR-23` addresses.)*

---

## 4. Functional requirements

### 4.1 Upload

`FIL-FR-013` — The module **SHALL** expose exactly **one** upload operation on the port. There **SHALL NOT** be a
second, privileged or "internal" upload path. *(`SID-4.36`: *"This module **SHALL NOT** re-implement or bypass any
of them"* — the bypass prohibition applies to this module's own surface too.)*

`FIL-FR-014` — An upload request **SHALL** carry, at minimum: the caller's resolved **tenant context**, the
caller's **actor identity**, a declared **content type**, a declared **byte length**, and an **intended
purpose** drawn from `FIL-CFG-001`.

`FIL-FR-015` — The module **SHALL** reject an upload for which no tenant context is resolved. It **SHALL NOT**
default to a tenant, and **SHALL** fail loudly. *(`TEN-FR-010`, `TEN-FR-011`; `MP-GBR-06`, `MP-GBR-07`.)*

`FIL-FR-016` — The module **SHALL** validate the declared content type against the **byte content** of the
upload, not against the filename or the client-declared MIME type alone. A mismatch **SHALL** be a refusal.

`FIL-FR-017` — The module **SHALL** validate **byte length** against the limit resolved for the purpose
(`FIL-CFG-003`) **before** any bytes are committed to storage.

`FIL-FR-018` — The module **SHALL** subject every uploaded object to **virus and malware scanning** before it
becomes readable. *(`SID-3.20`, `SID-4.36`, both FROZEN Rank 3; BC Map **L138**. See §1.3 on the EA drift.)*

`FIL-FR-019` — An object that has not completed scanning **SHALL NOT** be readable by any caller, and no signed
URL **SHALL** be issued for it. *(§9.2's state machine makes this mechanical.)*

`FIL-FR-020` — An object that **fails** scanning **SHALL NOT** be readable, **SHALL NOT** be replaceable into a
readable state, and **SHALL** be routed to permanent deletion under `FIL-FR-050`.

`FIL-FR-021` — There **SHALL** be no privileged read path that bypasses `FIL-FR-019` — not for support, not for
operations, not for debugging. *(A support read path that bypasses scanning is a malware-distribution path.)*

`FIL-FR-022` — The module **SHALL** issue a **`FileRef`** on successful upload, and the `FileRef` **SHALL** be the
only value a consumer receives.

### 4.2 The `FileRef` contract

`FIL-FR-023` — A `FileRef` **SHALL** be **opaque**: it **SHALL NOT** encode, embed or permit derivation of a
storage path, bucket name, vendor identifier, object key or public URL. *(`E-22`, BC Map **L331**: *"Domain holds
a `FileRef`, **never bytes or a raw storage path**"*; manifest **L184**: *"`FileRef` only (`E-22`) — never bytes
or raw paths"*.)*

`FIL-FR-024` — A `FileRef` **SHALL** be stable for the lifetime of the object it denotes, and **SHALL NOT** be
reissued, recycled or reassigned to different bytes — except by the replace operation, which is defined in
§9.4 as preserving the `FileRef` deliberately.

`FIL-FR-025` — A `FileRef` **SHALL NOT** be guessable or enumerable. Sequential, monotonic or otherwise
predictable references **SHALL NOT** be used. *(An enumerable reference converts an authorisation defect into a
bulk extraction.)*

`FIL-FR-026` — A `FileRef` **SHALL** be resolvable only within the tenant that owns the object. Presenting a
valid `FileRef` under a different tenant context **SHALL** be refused as not-found. *(`FIL-INV-002`;
`MP-GBR-03`.)*

`FIL-FR-027` — Two `FileRef`s **SHALL** have independent lifecycles. Deleting one **SHALL NOT** delete or
invalidate another, even where both denote visually identical bytes. *(`SID-4.37`, FROZEN Rank 3, states this
requirement for the Global Profile Photo and the Library Identification Photo specifically; this generalises it
to the capability, which is what makes `SID-4.37` satisfiable. See §8.4, which derives the **prohibition on
content de-duplication** from this requirement.)*

### 4.3 Metadata and ownership

`FIL-FR-028` — Every stored object **SHALL** carry: a **`tenantId`**, the **actor** who uploaded it, a
**server-assigned creation timestamp**, the **verified content type**, the **byte length**, a **content digest**,
the **purpose** (`FIL-CFG-001`), its **lifecycle state** (§9.2) and its **scan verdict**.

`FIL-FR-029` — The creation timestamp **SHALL** be **server time**, obtained through `platform/services:clock`.
Client-supplied time **SHALL NOT** be recorded as the time of record. *(`AUD-FR-007` states the same rule for
audit; manifest **L185** notes the `clock` port with `X-09`.)*

`FIL-FR-030` — Metadata **SHALL NOT** include any tenant-facing business meaning. The module **SHALL NOT** hold a
student's name, enrollment number, membership state, fee status or any other domain field. *(`FIL-XC-013`;
`MP-GBR-03` — *"`StudentRecordId` **never** leaves its tenant"*.)*

`FIL-FR-031` — The **original filename** supplied by a client **MAY** be retained as a display label. It
**SHALL NOT** be used as a storage key, **SHALL NOT** be used for type determination, and **SHALL** be treated as
untrusted input on every path that renders it.

`FIL-FR-032` — Ownership of an object **SHALL** be expressed as **(tenant, purpose, actor-of-record)** and
**SHALL NOT** be expressed as a reference to a domain aggregate. *(A reference from rank 3 to rank 8 would invert
the dependency direction — Matrix `L2`.)*

`FIL-FR-033` — The module **SHALL NOT** maintain a reverse index from an object to the domain records that hold
its `FileRef`. *(Consequence: the module cannot know whether an object is still referenced — recorded as
**`FIL-GAP-002`** and specified around in §9.5.)*

### 4.4 Read and access

`FIL-FR-034` — All stored objects **SHALL** be **private by default**. There **SHALL** be no state in which an
object is readable without an access decision. *(`FIL-INV-004`.)*

`FIL-FR-035` — Read access **SHALL** be delivered exclusively as a **signed, expiring URL**. The module
**SHALL NOT** expose a permanent, unauthenticated or guessable URL. *(`SID-3.20`, FROZEN: *"served through
signed, expiring URLs"*; `SID-4.36`.)*

`FIL-FR-036` — A signed URL **SHALL** be issued only after an affirmative access decision for **that caller**,
**that object** and **that moment**. *(`FIL-FR-008`.)*

`FIL-FR-037` — A signed URL's validity **SHALL** be bounded by `FIL-CFG-004` and **SHALL** be the **shortest**
period that satisfies the delivery path, not a convenient round number.

`FIL-FR-038` — A signed URL **SHALL NOT** be extendable, renewable or refreshable. A caller that needs continued
access **SHALL** obtain a new decision.

`FIL-FR-039` — A signed URL **SHALL** grant **read only**. There **SHALL** be no signed URL that permits
overwrite, delete or metadata mutation.

`FIL-FR-040` — Revoking a permission **SHALL** prevent the issuance of **new** signed URLs immediately. ⚠ It
**SHALL NOT** be claimed to invalidate URLs already issued; the module **SHALL** bound that exposure by
`FIL-FR-037` instead of asserting a guarantee it cannot keep. *(`FIL-BR-009`; this is why the URL window is a
security parameter and not a performance one.)*

`FIL-FR-041` — A "public" object — one whose access decision is *"any authenticated caller in this tenant"* —
**SHALL** still be served by a signed expiring URL, and **SHALL** still be tenant-scoped. There **SHALL NOT** be
an internet-public storage path in V1. *(`LIB-7.1` fixes the publicly visible field set for a library profile in
`Library_PRD_v1.md` §14A.5 — a **domain** decision. This module renders no such decision; see `FIL-GAP-011`.)*

`FIL-FR-042` — A refusal **SHALL** be distinguishable **by cause** to the caller only where doing so discloses
nothing: *unauthenticated*, *malformed request*, *object not in a readable state*. A refusal caused by an access
decision **SHALL** be reported as not-found. *(`FIL-FR-011`; `MP-GBR-22`. `ENT-FR-019` uses the same
distinguish-by-cause construction for entitlement refusals.)*

### 4.5 Tenant isolation on every surface

`FIL-FR-043` — Every stored object **MUST** carry a `tenant_id`. *(`TEN-FR-018`; `MASTER_PRD.md` **L398** —
*"**Mandatory** for tenant-scoped contexts. **Forbidden** in global contexts"*.)*

⚠ **`FIL-FR-043` and the Global Profile Photo are in apparent tension, and the resolution is stated rather than
assumed.** `BC-10` is **organisation-neutral** and *"holds no `tenantId`"* (BC Map **L114**), yet `SID-4.35`
requires its photo to be a `BC-29` `FileRef`. Therefore:

`FIL-FR-044` — The module **SHALL** support exactly two isolation classes, declared per **purpose**
(`FIL-CFG-001`): **tenant-scoped** objects, which carry a `tenant_id` and are reachable only within it; and
**global** objects, which carry **no** `tenant_id` and are reachable only through an access decision keyed on the
`PersonId` that owns them. An object **SHALL** belong to exactly one class, fixed at upload and immutable
thereafter. *(`TEN-FR-018`'s *"**Forbidden** in global contexts"* is what makes the second class necessary rather
than a loophole; **L400**: *"'Where applicable' is now a decision rule, not a hedge."*)*

`FIL-FR-045` — Every cache key, lookup key, index name and storage namespace this module constructs **MUST** be
tenant-partitioned for tenant-scoped objects. *(`TEN-FR-019`; `MP-GBR-08`; Matrix `X-13` — *"Cache/index/vector
key without `tenantId`"*, **the highest-severity failure class in the system**.)*

`FIL-FR-046` — A change to any cache key, index name or storage namespace **MUST** be treated as a
**security-reviewable change**. *(`TEN-FR-020`; `MP-GBR-09`.)*

`FIL-FR-047` — A cross-tenant object **MUST** be **unreachable and unobservable** — including through counts,
totals, latency differences, error messages and refusal reasons. *(`FIL-INV-002`; `MP-GBR-22`; `MP-RSK-01`.)*

`FIL-FR-048` — A global object **SHALL NOT** be reachable by a tenant-scoped access decision, and a
tenant-scoped object **SHALL NOT** be reachable by a global one. The two classes **SHALL NOT** share a key
namespace. *(Prevents `FIL-FR-044`'s second class becoming a tenant-isolation bypass.)*

### 4.6 Lifecycle operations

`FIL-FR-049` — The module **SHALL** support **replace**: substituting the bytes behind an existing `FileRef`,
subject to the same validation and scanning as an upload. *(`SID-3.17`: *"A person **MAY** upload, replace, remove
or hide it."*)*

`FIL-FR-050` — The module **SHALL** support **soft-delete**: marking an object unreadable while retaining its
bytes and metadata for the retention window. *(`MP-GBR-14`: *"Soft delete is preferred for important business
data."*)*

`FIL-FR-051` — The module **SHALL** support **permanent delete**: irreversible destruction of bytes.
*(`MP-GBR-14`: *"except where erasure is legally compelled, in which case the Hard Delete Pipeline and
anonymisation path execute"*.)*

`FIL-FR-052` — The module **SHALL** execute a **retention rule** per purpose, and **SHALL NOT** invent the
period. Every period **SHALL** be a configurable (`FIL-CFG-006`) resolved through `BC-25`. *(⚠ **No Rank 1–7
authority supplies a value.** `MP-NFR-10` assigns retention to *SECURITY + DATA Governance*. `PRD-016` faced the
identical vacuum and carried it as `AUD-GAP-001` rather than inventing a number; the same disposition applies —
**`FIL-GAP-008`**.)*

`FIL-FR-053` — A **legal hold** **SHALL** block permanent deletion and retention expiry, and **SHALL NOT** be
overridable by any operation in this module. *(`MP-GBR-13`; `MP-NFR-10`. `BC-24`'s `AuditEntry` invariant states
*"legal hold blocks purge"*.)*

`FIL-FR-054` — The module **SHALL NOT** decide **when** an erasure obligation arises. It **SHALL** execute one
presented to it. *(`MP-NFR-10` — DSR and right-to-erasure belong to SECURITY + DATA Governance.)*

### 4.7 Derivatives and thumbnails

`FIL-FR-055` — The module **SHALL** generate **image thumbnails / derivatives** for image objects.
*(`SID-4.36`, FROZEN Rank 3: thumbnailing *"**SHALL** be owned by `BC-29`"*; BC Map **L138**. §1.3 records the
EA's contrary `(V2)` token.)*

`FIL-FR-056` — A derivative **SHALL** inherit the access decision, tenant class and lifecycle state of its
**original**, and **SHALL NOT** be independently addressable by a `FileRef`. *(A derivative addressable in its own
right is an access-control bypass around the original.)*

`FIL-FR-057` — A derivative **SHALL** be regenerable from its original and **SHALL NOT** be the sole copy of any
information. *(Makes the derivative set disposable, which is what permits `FIL-FR-058`.)*

`FIL-FR-058` — Deleting an original — soft or permanent — **SHALL** delete every derivative of it. A derivative
**SHALL NOT** survive its original in any state. *(`FIL-INV-006`.)*

`FIL-FR-059` — Derivative sizes **SHALL** be a bounded, declared set (`FIL-CFG-007`). The module **SHALL NOT**
generate arbitrary sizes on request. *(An on-demand resizer with an unbounded parameter is a compute
amplification vector.)*

### 4.8 Failure, retry and idempotency

`FIL-FR-060` — Every mutating operation on the port **SHALL** be **idempotent**, keyed on a caller-supplied
idempotency key obtained through `platform/services:idempotency`. *(Manifest **L112**, **L339**;
`ENT-FR-008` applies the same rule to event handlers. ⚠ `ADR-0012`'s port debt, manifest **L647**, records that
*"only the interfaces are missing"* — `FIL-GAP-010`.)*

`FIL-FR-061` — A retried upload with the same idempotency key **SHALL** return the original `FileRef` and
**SHALL NOT** create a second object.

`FIL-FR-062` — The module **SHALL NOT** publish any domain event. *(§0.3; BC Map §9 producer rows for
`BC-29` = **0**; BC Map **L292**. `AUD-FR-012` uses the identical positive-prohibition construction.)*

`FIL-FR-063` — A partial upload **SHALL NOT** produce a readable object. An interrupted upload **SHALL** leave no
addressable `FileRef`. *(`FIL-INV-003`.)*

`FIL-FR-064` — Where an upload's bytes commit but its metadata record does not, the bytes **SHALL** be
unreachable and **SHALL** be reclaimed by the orphan sweep of `FIL-FR-065`. The reverse — a metadata record
without bytes — **SHALL** present as an object in a failed state, never as a readable one.

`FIL-FR-065` — The module **SHALL** operate a reclamation sweep for **orphaned bytes** — bytes with no
corresponding metadata record. It **SHALL** run through `platform/services:job_runtime` (`FIL-XC-017`).

`FIL-FR-066` — Unavailability of virus scanning **SHALL** cause uploads to be **refused**, not admitted
unscanned. The disposition is **fail-closed** and **SHALL NOT** be configurable to fail-open. *(Contrast
`ENT-FR-018`, where `E-17`'s timeout disposition *is* per-feature configurable; a scanner is not, because
admitting unscanned bytes converts an availability incident into a malware incident. Recorded so no future reader
"harmonises" the two.)*

`FIL-FR-067` — Unavailability of this module **SHALL NOT** corrupt a consumer's state. A consumer that cannot
obtain a `FileRef` **SHALL** be able to abandon its operation cleanly. *(`AUD-FR-009` states the analogous
non-blocking rule for audit.)*

### 4.9 Progress and realtime — specified only as far as authority permits

`FIL-FR-068` — The module **SHALL** report upload progress **synchronously to the uploading caller** on the
`E-22` port. It **SHALL NOT** fan progress out to other sessions, devices or actors.

`FIL-FR-069` — The module **SHALL NOT** consume or provide `platform/services:realtime`. *(⚠ Measured: the
`realtime` port is granted to **`domain/social` only** (manifest **L242–243**) and appears in the manifest
**once**; BC Map contains **no** realtime edge and **no** realtime context. Asserting a realtime dependency here
would create an unrecorded edge — **`FIL-GAP-003`** class. This is the *"realtime/progress where justified"*
scope item answered by measurement: **it is not justified at V1**.)*

`FIL-FR-070` — Progress reporting **SHALL NOT** be authoritative for any state. The authoritative state of an
object is its lifecycle state (§9.2). *(`MP-NFR-09`: *"The observability plane is **never authoritative**."*)*

### 4.10 Extensibility without overbuilding

`FIL-FR-071` — Admitting a new content class, size limit or purpose **SHALL** require only a change to
`FIL-CFG-001`…`FIL-CFG-003` and, where a limit is entitlement-bearing, a `BC-21` decision — **not** a change to
this module's contract. *(This is the *"future extensibility"* obligation made testable: the test is that the
allow-list is the only enforcement point, per `FIL-FR-005`.)*

`FIL-FR-072` — The storage abstraction **SHALL** be expressed so that a second storage backend can be introduced
without a change to the `E-22` port signature. *(`MP-CON-03`.)*

`FIL-FR-073` — The module **SHALL NOT** pre-build a capability listed in §1.4 as out of scope, and **SHALL NOT**
leave a partially implemented one behind an unreachable flag. *(`SEAT-BR-045`'s discipline generalised: a gap
resolved by implementation choice is not resolved.)*

`FIL-FR-074` — Every configurable this module publishes **SHALL** carry a declared **default** and a declared
**range**. A configurable without both **SHALL NOT** be published. *(`PRD-023` Stage 4 gate; `CNF-`'s own rule
that *"a configuration module publishing unbounded configurables would be self-refuting"* applies to its
consumers too.)*

### 4.11 Shared-object access — the infrastructure behind student-to-student sharing

> **Scope note.** These requirements make an object readable by a person who did not upload it. They define
> **no** friendship, conversation, message, delivery guarantee or eligibility rule — those stay with `PRD-021`
> under `FIL-XC-001` and `FIL-XC-002`, which are unchanged. Every requirement here is subject to `FIL-FR-006`,
> so none is servable until `E-22` lists the sharing context (`FIL-GAP-012`).

`FIL-FR-075` — The module **SHALL** support a **share grant**: a record that a named **recipient** `PersonId` may
read a named `FileRef`. A grant **SHALL** identify the `FileRef`, the granting actor, the recipient, the server
time of grant, its state, and the **eligibility-decision reference** supplied under `FIL-FR-076`. *(This is the
whole of what sharing requires from a file capability: the bytes and the metadata already exist under
`FIL-FR-013`…`FIL-FR-033`.)*

> ⚠ **Corrected at Stage 4 (`S4-D-04`).** The property list originally named five items and omitted the decision
> reference, while `FIL-FR-076` obliged the module to **record** one. An obligation to store a value that the
> record is not required to carry is not merely redundant — it is **unimplementable without contradicting the
> record definition**, and no criterion could have proven it either way. The reference is now a named property,
> which is what makes `FIL-AC-077` observable.

`FIL-FR-076` — The module **SHALL NOT** decide **whether** a share is permitted. The **calling context**
**SHALL** have obtained the eligibility decision before requesting the grant, and **SHALL** supply a reference to
it; the module **SHALL** record that reference rather than re-deriving it, and **SHALL** refuse a grant request
that carries no decision reference. For student-to-student sharing the calling context is **`BC-12` Messaging**,
which is the context `E-16` positions to ask `BC-11` for `canMessage(a, b)`; this module **SHALL NOT** ask
`BC-11` itself. *(`FIL-XC-001`, `FIL-XC-002`, `FIL-XC-005`. `canMessage(a, b)`
is evaluated by `BC-11` at send time — BC Map **L320**, **L378** — and a second evaluation here could disagree
with the first, which is the defect Matrix `X-13` calls *"a security defect that passes its own tests"*.)*

`FIL-FR-077` — A share grant **SHALL** convey **read access only**. A recipient **SHALL NOT** be able to replace,
soft-delete, permanently delete, re-share, or alter the metadata of a shared object, and **SHALL NOT** become its
owner. *(`FIL-FR-039` already restricts issued URLs to read; this extends the same rule to the grant itself.)*

`FIL-FR-078` — A recipient's read **SHALL** be served only through a signed, expiring URL issued per request
under `FIL-FR-035`…`FIL-FR-041`. A share grant **SHALL NOT** cause an object to become public, anonymously
reachable, or discoverable by enumeration. *(`SID-3.20`; `FIL-FR-034` private-by-default; `FIL-XC-011`.)*

`FIL-FR-079` — A share grant **SHALL** be **revocable** by the granting actor or by an actor `BC-18` authorises.
On revocation the module **SHALL** immediately cease issuing new URLs to that recipient. Consistent with
`FIL-FR-040`, revocation **SHALL NOT** be claimed to invalidate URLs already issued; the residual exposure
**SHALL** be bounded by `FIL-CFG-004`. *(`FIL-BR-009` states this trade-off and its owner.)*

`FIL-FR-080` — A share grant **SHALL NOT** survive the object it points at. While the object is soft-deleted,
every grant on it **SHALL** be unreadable **without any change to the grant's own state**; permanent deletion
**SHALL** remove the grants. If the object is restored within `FIL-CFG-006`, grants still in `Active` **SHALL**
become readable again and grants in `Revoked` **SHALL** remain unreadable. A grant **SHALL NOT** be a reason to
retain bytes past `FIL-CFG-006`. *(`FIL-INV-006`; `FIL-FR-058`; `FIL-INV-009`, which already makes readability
follow the object. Retention authority stays with `FIL-GAP-008`.)*

> ⚠ **Corrected at Stage 4 (`S4-D-02`).** The first draft of this requirement said soft-delete *"**SHALL**
> suspend every grant"*. `Suspended` is not one of the two states `FIL-INV-010` permits, and `Revoked` is
> **terminal** there — so a suspended grant was either an undeclared third state or an irreversible one, and the
> latter would have contradicted `FIL-BR-008`, which makes soft-delete **reversible within the retention
> window**. The fix removes the phantom state instead of adding one: **readability follows the object**
> (`FIL-INV-009`), and grant state is untouched by object lifecycle.

`FIL-FR-081` — Both parties to a share **SHALL** be in the **same isolation class** as the object
(`FIL-FR-044`), and a grant **SHALL NOT** be the means by which an object crosses classes. A grant naming a
recipient outside the object's class **SHALL** be refused as not-found. *(`FIL-FR-047`; `MP-GBR-03`. ⚠ See §7.3:
the sharing contexts are **global**, not tenant-scoped, and that is stated rather than smoothed over.)*

`FIL-FR-082` — Grant, revocation and first read by a recipient **SHALL** be auditable by the calling context in
the same transaction as the operation that caused them. Consistent with `FIL-FR-062`, this module **SHALL NOT**
publish an event to achieve it. *(`AUD-FR-008`; `MP-GBR-13`. The limits of this are `FIL-GAP-004`.)*

---

## 5. Business rules

`FIL-BR-003` — An object exists in exactly **one** lifecycle state at any instant (§9.2). There is no state in
which an object is both readable and deleted.

`FIL-BR-004` — Scanning **precedes** readability, always. There is no ordering in which an object becomes
readable and is scanned afterwards. *(`FIL-INV-001`.)*

`FIL-BR-005` — Validation **precedes** storage commitment. Bytes that fail `FIL-FR-016` or `FIL-FR-017`
**SHALL NOT** occupy storage. *(Otherwise the size limit is advisory and storage is a denial-of-service target.)*

`FIL-BR-006` — Replace **preserves** the `FileRef` and **replaces** the bytes. This is deliberate: a consumer
holding the reference need not be updated, which is precisely why the consumer must not treat the reference as a
guarantee of unchanged content. *(`FIL-FR-024`.)*

`FIL-BR-007` — Replace **SHALL** be treated as a new upload for validation, scanning and quota purposes. A
replacement is not exempt because a predecessor passed.

`FIL-BR-008` — Soft-delete is **reversible within the retention window** and irreversible after it. The window is
`FIL-CFG-006`, resolved through `BC-25`, and is **not** defined here (`FIL-GAP-008`).

`FIL-BR-009` — The security guarantee of a signed URL is its **expiry**, not its revocability. A shorter window is
a stronger guarantee. *(`FIL-FR-040` states the limit honestly; this rule states the consequence for whoever sets
`FIL-CFG-004`.)*

`FIL-BR-010` — A tenant-scoped object and a global object are **never** the same object. Where the same image is
needed in both classes, two objects with two `FileRef`s exist. *(`FIL-FR-027`, `FIL-FR-048`; and `SID-4.37`, which
requires exactly this for the Global Profile Photo and the Library Identification Photo. It is also why §8.4
forbids de-duplication.)*

`FIL-BR-011` — The module refuses rather than guesses. Where an access decision, tenant context, scan verdict or
configuration value cannot be obtained, the operation is refused. *(`MP-NFR-12`: *"Where a decision cannot be
rendered correctly, **it is refused** rather than guessed."*)*

`FIL-BR-012` — A storage quota is **entitlement**, not storage. This module measures and reports consumption; it
does not decide whether consumption is permitted. *(`FIL-XC-008`; `ENT-FR-017` — `BC-21` *"**SHALL** expose the
remaining allowance for every counted feature it governs"*.)*

`FIL-BR-013` — The module holds **no** knowledge of why an object was uploaded beyond its declared **purpose**.
Purpose is a routing and policy key, not a business fact.

`FIL-BR-014` — An object whose scan verdict is *infected* is never recoverable by any operation. There is no
override, quarantine-release or administrative approval path in V1. *(`FIL-FR-020`, `FIL-FR-021`.)*

`FIL-BR-015` — **Sharing transfers access, never ownership.** The uploading actor remains the owner for the whole
life of the object, and the number of recipients does not change who may replace or delete it. *(`FIL-FR-077`.)*

`FIL-BR-016` — **Eligibility is asked, never inferred.** The existence of a prior share, a prior conversation or a
prior successful read is **not** evidence that a further share is permitted. Each share is authorised on its own
facts by the calling context. *(`FIL-FR-076`; `FIL-FR-008`, which forbids caching a decision; `MP-GBR-26`.)*

`FIL-BR-017` — **A shared file follows the object, not the message.** If the calling context deletes a message,
conversation or friendship, this module takes no action on the bytes; and if the object is deleted, no grant
survives it. The two lifecycles are related only through `FIL-FR-080`. *(`FIL-XC-002` keeps message retention
with `BC-12`; `FIL-INV-006` keeps derivative and grant removal with the object.)*

---

## 6. Data model requirements

> **These are requirements *on* a data model, not a data model.** No SQL, DDL, schema or column type appears
> here, by instruction and by stage. Physical design is Stage 3 and Stage 6 work.

### 6.1 ⚠ `BC-29` owns no aggregate in the Bounded Context Map, and this document does not mint one

**Measurement.** BC Map §8 — the *Aggregate & Invariant Register* — was counted: **17** rows, one per owning
context. `BC-29` appears in **zero** of them (`grep` count: 0). BC Map §7 states the governing rule for its
tables: *"if not in this table it does not exist."*

This is the same shape `PRD-023` met for `BC-25`, and the same disposition applies. `PRD-023`'s header records it
as *"**UNRESOLVED** — `CNF-GAP-001` … the PRD takes neither side"*, and that PRD was **frozen** with the gap open.

`FIL-FR-033`, `FIL-FR-028` and §6.2 therefore specify the **properties a record must have** without asserting
that the record is an aggregate root of `BC-29`. Recorded as **`FIL-GAP-001`**, owner **Architecture Owner**, to
be settled at Stage 3.

⚠ **The tension is stated in both directions rather than resolved.** `PRD_LIFECYCLE.md` Stage 1's gate asks *"Does
it own an aggregate and an invariant?"* and warns that *"owning neither ⇒ it is a capability of an existing
context"*. `BC-29` owns **invariants** in substance (§7) but **no BC Map aggregate row**. Whether that means the
map is incomplete — the `ADR-0016` situation — or that `BC-29` is correctly aggregate-less as a pure capability
is **not decided here**, because deciding it would amend a Rank 4 frozen document without an ADR.

### 6.2 Required properties of the stored-object record

`FIL-INV-001` — An object **MUST NOT** be readable before its scan verdict is *clean*. There **MUST** be no code
path that reads an unscanned or infected object. *(`FIL-BR-004`; `SID-3.20`.)*

`FIL-INV-002` — A tenant-scoped object **MUST** carry a `tenant_id`, and **MUST** be unreachable from any other
tenant by any route — read, list, count, search, cache, error message or timing. *(`TEN-FR-018`, `TEN-FR-019`;
`MP-GBR-08`; `X-13`; `MP-RSK-01`.)*

`FIL-INV-003` — A `FileRef` **MUST** denote either a complete object or nothing. It **MUST NOT** denote a partial
one. *(`FIL-FR-063`.)*

`FIL-INV-004` — An object **MUST NOT** exist in a state that is readable without an access decision.
*(`FIL-FR-034`.)*

`FIL-INV-005` — A `FileRef` **MUST** be immutable and **MUST NOT** be reassigned to a different object.
*(`FIL-FR-024`.)*

`FIL-INV-006` — A derivative **MUST NOT** exist without its original. *(`FIL-FR-058`.)*

`FIL-INV-007` — An object under **legal hold MUST NOT** be permanently deleted by any operation, including
retention expiry. *(`FIL-FR-053`; `MP-GBR-13`.)*

`FIL-INV-008` — A **global** object (`FIL-FR-044`) **MUST NOT** carry a `tenant_id`. *(`TEN-FR-018` —
*"**Forbidden** in global contexts"*; BC Map **L114** — `BC-10` *"holds no `tenantId`"*.)*

`FIL-INV-009` — A share grant **MUST** reference exactly one existing `FileRef` and exactly one recipient
`PersonId`. A grant referencing a non-existent, soft-deleted or permanently deleted object **MUST NOT** be
readable. *(`FIL-FR-075`, `FIL-FR-080`.)*

`FIL-INV-010` — A share grant **MUST** be in exactly one state — `Active` or `Revoked` — at any instant, and
`Revoked` **MUST** be terminal. *(`FIL-FR-079`; the same single-state discipline as `FIL-BR-003`.)*

`FIL-INV-011` — A grant **MUST NOT** name the granting actor and the recipient as the same `PersonId`. Access to
one's own object is ownership, not a grant. *(`FIL-BR-015`.)*

### 6.3 What the record must NOT contain

`FIL-FR-030` fixes this positively. Restated as a data-model constraint for Stage 3's benefit: the record
**SHALL NOT** contain a `StudentRecordId` (`MP-GBR-03`), any domain field, any credential or secret value
(`BC-18`/`ID-1`), any raw storage path exposed to a consumer (`E-22`), or any configuration **value** as opposed
to a reference to one (`FIL-XC-009`).

---

## 7. Security and tenant isolation requirements

### 7.1 The security posture, stated as obligations already numbered above

| Concern | Requirement | Ceded authority |
|---|---|---|
| Authorisation | `FIL-FR-008`, `FIL-XC-005` | `BC-18` — `X-13` |
| Scope semantics | `FIL-FR-009`, `FIL-FR-010` | `MP-GBR-20`, `MP-GBR-21` |
| Existence non-disclosure | `FIL-FR-011`, `FIL-FR-042`, `FIL-FR-047` | `MP-GBR-22` |
| Tenant partitioning | `FIL-FR-043`…`FIL-FR-048`, `FIL-INV-002`, `FIL-INV-008` | `BC-19` — `TEN-FR-018`/`019`/`020` |
| Key-change review | `FIL-FR-046` | `MP-GBR-09` |
| Malware | `FIL-FR-018`…`FIL-FR-021`, `FIL-FR-066`, `FIL-BR-014` | `SID-3.20`, `SID-4.36` |
| URL exposure | `FIL-FR-035`…`FIL-FR-041`, `FIL-BR-009` | `SID-3.20` |
| Erasure / hold | `FIL-FR-051`, `FIL-FR-053`, `FIL-FR-054`, `FIL-INV-007` | `MP-NFR-10`, `MP-GBR-13`, `MP-GBR-14` |
| Encryption | **Deliberately unnumbered — see below** | `MP-NFR-05` |

⚠ **Encryption is deliberately not given its own numbered requirement, and the reason is stated.**
`MP-NFR-05` assigns *"Zero trust, secrets management, encryption, threat detection"* to **SECURITY**, Rank 1. No
Rank 1–4 document states an encryption algorithm, key-rotation period or at-rest requirement for stored objects.
Writing one here would be this document making a **security determination it has no standing to make** —
the precise error `PRD-016` avoided when it declined to invent a retention period. Recorded as
**`FIL-GAP-009`**, owner **SECURITY**. The register in §0.2 therefore ends at **`FIL-FR-074`** and no further
identifier is minted here: the range stays contiguous and the gap is in the *subject*, not the numbering.
*(An earlier draft of this row cited a `FIL-FR-` number **one past the end of the range** (075) that was never
defined; the Stage 2 self-consistency audit
removed it, because a citation to an undefined identifier is a defect even when the surrounding prose explains
that the identifier does not exist.)*

### 7.2 ⚠ Row-level security: the repository has no RLS architecture document, and this is measured

The scope brief asks for *"RLS/security requirements"*. Every occurrence of `RLS` / *row-level security* in
`docs/` was located. There are **three**, and **none is an architecture specification**:

| Site | What it is |
|---|---|
| `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` **L403** | One clause: *"`TenantContext` is needed at R2 (row-level security) and set at R9 (request edge). A downward import would violate `L2`."* |
| `PRD-013_ARCHITECTURE_ALIGNMENT.md` | A Stage 3 record, not an authority |
| `PRD-023_SETTINGS_AND_CONFIGURATION.md` **L1084** (`CNF-XC-012`) | An **exclusion**: that module *"**MUST NOT** define the platform's tenant-partitioning mechanism, row-level security…"* |

**No document at any rank defines the platform's RLS model.** Two PRDs disclaim it and one architecture line
mentions where the context is needed. Likewise `Supabase` appears in `docs/` exactly **twice** — `MASTER_PRD.md`
**L227/L228**, both marked ***"Not named in EA — candidate only"***, and **L271** records that naming a vendor as
a layer was **corrected out** of v1.0.

Therefore:

`FIL-XC-006` (above) cedes the mechanism, and this document states its isolation obligations as **behavioural**
(`FIL-FR-043`…`048`, `FIL-INV-002`, `FIL-INV-008`) rather than as RLS policy text. **No RLS predicate, policy
name or Supabase Storage bucket policy is written here**, because no authority exists to write it against, and
inventing one would bind the platform to a vendor `MP-CON-01`/`MP-CON-02` forbid naming.
Recorded as **`FIL-GAP-009`** (security) and **`FIL-GAP-011`** (no database/storage architecture artefact).

### 7.3 ⚠ Student-to-student sharing is **global**, not tenant-scoped, and the brief's wording must be corrected

The product instruction asks for *"tenant/library membership isolation"* on peer sharing. **The repository says
peer sharing is not tenant-scoped, and the instruction cannot be satisfied as literally worded.** Measured:

| Evidence | What it says |
|---|---|
| BC Map **L488** | `BC-11`→`BC-17` Student Network is *"**Global.** No `tenantId`. Keyed on `PersonId`"* and *"Must never receive a `StudentRecordId` or `tenantId` (rule `ID-2`)"* |
| BC Map **L114** | `BC-10` Global Person Identity *"holds no `tenantId`"* |
| `TEN-FR-018` (FROZEN) | `tenant_id` is *"**Forbidden** in global contexts"* |

A student is a **person** (`BC-10`, global) who may hold membership in more than one library. Friendship and
messaging are keyed on `PersonId`, not on a tenant. Requiring a `tenant_id` on a peer share would therefore
**violate frozen Rank 3 `TEN-FR-018` and Rank 4 rule `ID-2`** — the precise defect `FIL-FR-044`'s two isolation
classes exist to prevent. Accordingly:

- A shared study document is a **global-class** object (`FIL-FR-044`), isolated by an access decision keyed on
  `PersonId` (`FIL-FR-081`), **not** by a tenant predicate.
- **This is not weaker isolation, it is differently keyed.** `FIL-FR-047`'s not-found refusal, `FIL-FR-034`'s
  private-by-default, `FIL-FR-078`'s signed-URL-only rule and `FIL-FR-081`'s same-class rule all still apply, and
  `FIL-INV-008` forbids the object carrying a `tenant_id` at all.
- **Tenant-scoped library documents remain tenant-scoped.** A student's Library Identification Photo
  (`PRD-004`) and a library's logo (`LIB-6.6`) are tenant-class objects and are **not** shareable peer-to-peer by
  this mechanism, because `FIL-FR-081` forbids a grant crossing classes.

⚠ **If the product intent is genuinely that peer sharing must be confined to co-members of one library, that is a
requirement on `BC-11`'s eligibility rule — `PRD-021`'s to state and `BC-11`'s to evaluate — not a tenant
predicate on the bytes.** This module would then receive an eligibility decision that already accounts for it
(`FIL-FR-076`) and would need no change. Recorded as **`FIL-GAP-013`**, owner **Product + `PRD-021`**, because
resolving it here would mean this document writing a social-graph rule that `FIL-XC-019` forbids it from owning.

---

## 8. Storage architecture requirements

### 8.1 The abstraction

`FIL-FR-003` and `FIL-FR-072` fix it. Restated as architecture obligations for Stage 3: the storage port is the
**only** boundary at which a vendor exists; the port's signature carries no vendor concept; and the module's own
logic is expressible without knowing whether the backing store is object storage, block storage or a database.

### 8.2 Bucket / container strategy

`FIL-BR-010` and `FIL-FR-048` fix the invariant that matters: the two isolation classes **share no key
namespace**. Beyond that:

⚠ **This document does not prescribe a bucket topology**, because the choice between *one container partitioned
by key prefix* and *one container per tenant* is a **deployment** decision under `MP-CON-02`, and the repository
holds no storage-architecture document to decide it against (`FIL-GAP-011`). What is specified is the **property
any topology must satisfy**: `FIL-FR-045`'s tenant-partitioned namespace, `FIL-FR-046`'s
security-reviewable-change rule, and `FIL-INV-002`'s unreachability.

### 8.3 Keys and paths

`FIL-FR-023` forbids a consumer from learning a path. Additionally, from `FIL-FR-025` and `FIL-FR-031`: a storage
key **SHALL NOT** be derived from a client-supplied filename, and **SHALL NOT** be sequential or enumerable.

### 8.4 De-duplication is forbidden in V1, and the reason is a frozen requirement

`FIL-FR-027` requires independent lifecycles, and `SID-4.37` (FROZEN, Rank 3) requires it by name:

> *"A `FileRef` for a Global Profile Photo and a `FileRef` for a Library Identification Photo **SHALL** be
> distinct references with independent lifecycles. Deleting one **SHALL NOT** delete or invalidate the other."*

Content-addressable de-duplication would make two identical uploads **one** stored object, so deleting one would
delete the other — directly violating a frozen Rank 3 requirement. It is therefore excluded (§1.4), and the
exclusion is **derived from authority rather than from a preference for simplicity**.

The **content digest** of `FIL-FR-028` is retained for **integrity verification only**. `FIL-BR-010` states the
consequence.

### 8.5 Configurables this module publishes

Nine values, resolved through `platform/configuration:settings` (`E-19`) and **owned as values by their scope
owner, not by this module** (`FIL-XC-009`). `FIL-FR-074` requires a declared **default and range** for each;
**eight satisfy it and one does not** — `FIL-CFG-006` carries a range but no default, for the reason stated
below. The exception is named here rather than in a footnote, because a subsection that opens by claiming all
nine comply and then discloses an exception is internally contradictory.

| ID | Configurable | Why it must be configurable |
|---|---|---|
| `FIL-CFG-001` | **Purpose register** — the closed set of upload purposes, each with its isolation class (`FIL-FR-044`) | Adding a purpose must not change the contract (`FIL-FR-071`) |
| `FIL-CFG-002` | **Content-type allow-list** per purpose | The single enforcement point for `FIL-FR-005` |
| `FIL-CFG-003` | **Maximum byte length** per purpose | A logo and a scanned document have different bounds |
| `FIL-CFG-004` | **Signed-URL validity window** | A security parameter (`FIL-BR-009`), tunable without redeploy |
| `FIL-CFG-005` | **Scan timeout** and refusal behaviour ⚠ **fail-closed is NOT configurable** (`FIL-FR-066`) — only the timeout is | Availability tuning without weakening the guarantee |
| `FIL-CFG-006` | **Retention window** per purpose, and the soft-delete reversibility window | ⛔ **No authority supplies a value** — `FIL-GAP-008` |
| `FIL-CFG-007` | **Derivative size set** (`FIL-FR-059`) | Bounded, declared, not caller-supplied |
| `FIL-CFG-008` | **Orphan-sweep interval** (`FIL-FR-065`) | Operational |
| `FIL-CFG-009` | **Maximum concurrent uploads per actor** | Abuse control that is not an entitlement (`FIL-BR-012`) |

⚠ **`FIL-CFG-006` is published with a declared range but NO default**, in apparent tension with `FIL-FR-074`. The
tension is deliberate and disclosed rather than resolved by invention: `MP-NFR-10` assigns retention to
*SECURITY + DATA Governance*, and `PRD-016` established that a retention period invented by a PRD *"would have
been a legal determination made by a document with no standing to make one"*. `FIL-FR-052` therefore forbids the
module from operating without a resolved value, which makes the missing default a **startup refusal** rather than
a silent zero. `FIL-GAP-008` carries it.

---

## 9. Upload and download lifecycle

### 9.1 Ordering, stated once and normatively

`FIL-BR-004` and `FIL-BR-005` fix it: **authorise → validate → commit bytes → scan → become readable**. No
requirement in this document permits a different order.

### 9.2 Lifecycle states

`FIL-FR-028` requires the state be recorded. The states, and the transitions this document permits:

| State | Readable? | Entered from | By |
|---|---|---|---|
| `Pending` | No | — | upload accepted, bytes committed (`FIL-FR-013`…`017`) |
| `Scanning` | No | `Pending` | scanner engaged (`FIL-FR-018`) |
| `Available` | **Yes**, subject to a decision | `Scanning` | verdict *clean* (`FIL-FR-019`) |
| `Infected` | **Never** | `Scanning` | verdict *infected* (`FIL-FR-020`) → `FIL-FR-051` |
| `Failed` | No | `Pending`, `Scanning` | timeout, refusal, interruption (`FIL-FR-063`, `FIL-FR-064`, `FIL-FR-066`) |
| `SoftDeleted` | No | `Available` | `FIL-FR-050` |
| `PermanentlyDeleted` | No — **terminal** | `SoftDeleted`, `Infected`, `Failed` | `FIL-FR-051`, blocked by `FIL-INV-007` |

`FIL-BR-003` forbids simultaneous states. `FIL-BR-014` forbids `Infected` → anything but permanent deletion.

### 9.3 Download

`FIL-FR-034`…`FIL-FR-042` fix it. Summarised for Stage 3: a download is *always* a fresh access decision plus a
short-lived signed URL, and *never* a stored link.

### 9.4 Replace

`FIL-FR-049`, `FIL-BR-006`, `FIL-BR-007`. A replace re-enters `Pending` and traverses §9.2 again; the previous
bytes follow the retention rule of the purpose, not immediate destruction, so a mistaken replacement is
recoverable within the window (`FIL-BR-008`).

### 9.5 ⚠ Delete without reference counting — the consequence is specified, not wished away

`FIL-FR-033` forbids a reverse index, so **this module cannot know whether a `FileRef` is still held by a domain
record.** That is a direct consequence of `ADR-0013` §5's split and of Matrix `L2` (rank 3 may not read rank 8).
Therefore:

`FIL-BR-003`-consistent behaviour: a delete request is honoured on the **caller's** authority and the module
**does not** attempt to verify that no consumer still holds the reference. A consumer that holds a `FileRef` to a
deleted object receives a not-found refusal (`FIL-FR-042`) and **must** handle it — which is why `FIL-BR-006`
warns that a `FileRef` is not a guarantee of retrievability.

**The dangling-reference risk is real and is recorded as `FIL-GAP-002`**, owner **Architecture Owner**. It is not
solved by a reverse index, because that would invert the dependency direction; the plausible solutions
(consumer-side reconciliation, or a `BC-29` → consumer notification that would need a new `E-*` edge) both
require decisions outside this document.

### 9.6 Retention execution

`FIL-FR-052`…`FIL-FR-054`, `FIL-INV-007`, `FIL-CFG-006`. Execution runs on `platform/services:job_runtime`
(`FIL-XC-017`) and is **blocked entirely** while `FIL-CFG-006` is unresolved (`FIL-GAP-008`).

---

## 10. API requirements

> **Contract requirements, not a contract.** No signature, type, endpoint, verb or payload schema is written
> here — that is Stage 3/6 work and the instruction forbids code.

`FIL-FR-002` fixes the surface as `platform/services:files`. The operations the requirements above oblige the
port to carry, each traced to the requirement that demands it:

| Operation | Obliged by | Must carry |
|---|---|---|
| **Upload** | `FIL-FR-013`, `FIL-FR-014` | tenant context, actor, purpose, declared type, declared length, idempotency key |
| **Issue read access** | `FIL-FR-035`, `FIL-FR-036` | `FileRef`, caller identity; returns a signed URL with a bounded lifetime |
| **Replace** | `FIL-FR-049` | `FileRef`, new bytes, idempotency key |
| **Soft-delete** | `FIL-FR-050` | `FileRef`, actor |
| **Permanent delete** | `FIL-FR-051` | `FileRef`, actor, erasure or retention authority |
| **Read metadata** | `FIL-FR-028` | `FileRef`; returns metadata only, never a path (`FIL-FR-023`) |
| **Report consumption** | `FIL-BR-012` | tenant; returns measured consumption, never a verdict |

`FIL-FR-060` makes every mutating operation idempotent. `FIL-FR-042` and `FIL-FR-011` fix the refusal vocabulary.
`FIL-FR-068` fixes progress as synchronous to the caller only.

⚠ **No error catalogue is written here.** The repository has **no Event Catalog and no error-code register** —
`PRD-023`'s blocker `B-5` records that *"Event Catalog does not exist as a separate artefact; BC Map §7.3 is the
authority"*. Inventing a code register would create an eighth unregistered identifier space. `FIL-GAP-011`.

---

## 11. UI/UX requirements

> ⚠ **The UI Design System does not exist.** `MASTER_PRD.md` **L500** (`MP-NFR-06`) and **L502** (`MP-NFR-08`)
> place it at **Rank 1** and name it owner of *"tokens, components and accessibility targets"*, and
> `find docs -iname '*UI_DESIGN_SYSTEM*'` returns **0**. `PRD-023` classified this as blocker **`B-3`**,
> *"⛔ BLOCKED — external, product"*. The same disposition applies: the requirements below state **what the
> surface must express**, and `FIL-XC-010` forbids this document from defining a single token.

`FIL-FR-034`'s private-by-default posture and `FIL-FR-011`'s non-disclosure rule both have surface consequences,
and they are stated as obligations so they can be tested:

*(These are UI obligations carried by requirements already numbered: no new `FIL-FR-*` is minted for the surface,
because doing so would exceed the declared range. The mapping is given so §14 and §18 can trace them.)*

| The surface must | Carried by | Why |
|---|---|---|
| Show upload **progress** to the uploading actor, and to no one else | `FIL-FR-068` | Fan-out would need a realtime edge that does not exist (`FIL-FR-069`) |
| Show the declared **size and type limits before submission**, not after refusal | `FIL-FR-017`, `FIL-CFG-002`, `FIL-CFG-003` | A limit discovered by failing is a defect, not a validation |
| Attach a **refusal to the field that caused it** | `FIL-FR-042` | An unattached error is unactionable |
| Present an access refusal as **not-found**, with no hint that the object exists | `FIL-FR-011`, `FIL-FR-047` | `MP-GBR-22` |
| Distinguish *scanning* from *available* rather than showing a broken image | §9.2, `FIL-FR-019` | The user must not read "not yet scanned" as "failed" |
| Never render a **raw storage URL** or path | `FIL-FR-023` | `E-22` |
| Treat a client filename as **untrusted** on render | `FIL-FR-031` | Injection via display label |
| Offer **soft-delete as recoverable** and permanent delete as **explicitly irreversible** | `FIL-BR-008`, `FIL-FR-051` | `MP-GBR-14` |
| Be **portrait-optimised and accessible** | `MP-NFR-06`, `MP-NFR-08` | Cited, **not defined** (`FIL-XC-010`) |

---

## 12. Validation and failure handling

### 12.1 Validation, in the order it must occur

| Step | Requirement | On failure |
|---|---|---|
| 1. Tenant context resolved | `FIL-FR-015` | Refuse, fail loudly, never default |
| 2. Access decision obtained | `FIL-FR-008`, `FIL-FR-036` | Refuse; not-found where the scope demands (`FIL-FR-011`) |
| 3. Purpose is in `FIL-CFG-001` | `FIL-FR-014` | Refuse |
| 4. Content type in `FIL-CFG-002` **and** matching byte content | `FIL-FR-016` | Refuse |
| 5. Byte length within `FIL-CFG-003` | `FIL-FR-017` | Refuse **before** committing bytes (`FIL-BR-005`) |
| 6. Entitlement, where the purpose is counted | `FIL-BR-012`, `FIL-XC-008` | Refuse with the cause `BC-21` gave (`ENT-FR-019`) |
| 7. Bytes committed | `FIL-FR-063`, `FIL-FR-064` | No addressable `FileRef`; orphan sweep reclaims |
| 8. Scan | `FIL-FR-018`, `FIL-FR-066` | `Infected` → `FIL-FR-020`; unavailable → **fail-closed** |
| 9. Becomes `Available` | `FIL-FR-019` | — |

### 12.2 Failure and retry

`FIL-FR-060`, `FIL-FR-061` (idempotency), `FIL-FR-063`…`FIL-FR-065` (partial and orphan), `FIL-FR-066`
(fail-closed scanning), `FIL-FR-067` (consumer non-corruption), `FIL-BR-011` (refuse rather than guess).

⚠ **No retry count, backoff curve or latency budget is stated, and the reason is measured.** `PRD-023`'s blocker
**`B-4`** records: *"**NFR Budgets** do not exist. No document at any rank bounds a resolution latency, cache TTL
or startup-validation duration."* `find docs -iname '*NFR_BUDGETS*'` → **0**. Naming a number here would **invent
a budget**. `FIL-GAP-009`-adjacent; recorded as part of `FIL-GAP-011`.

---

## 13. Observability and audit

### 13.1 Observability

`FIL-FR-070` fixes the posture. `MP-NFR-09`, Rank 1, supplies the rest and is *cited*: *"Logs, metrics, traces,
per-tenant observability. The observability plane is **never authoritative** and must not carry identifiers it is
not cleared to hold."*

Consequences already carried by numbered requirements: telemetry travels through
`platform/observability:telemetry`; it **must not** carry a `StudentRecordId` (`MP-GBR-03`), a storage path
(`FIL-FR-023`) or an untrusted filename rendered as structured data (`FIL-FR-031`); and per-tenant metrics obey
`FIL-FR-045`'s partitioning.

### 13.2 ⚠ Auditability: the module publishes no event, so `E-20` is not available to it

**This is the sharpest structural finding in the audit, and it is recorded rather than solved.**

- `MP-GBR-13`, Rank 1: *"Every critical action is auditable."*
- `E-20` (BC Map **L329**) is the audit edge: *"All contexts → `BC-24` Audit Trail \| `PL` \| **Event**
  (fire-and-forget, outbox-backed) \| Domain never calls audit synchronously."*
- `AUD-FR-010` requires `BC-24` to consume audit facts *"via `E-20`"*.
- But **`BC-29` is a producer in zero BC Map §9 rows** (measured), and `FIL-FR-062` forbids this module from
  publishing an event, because minting one would create a publication path **L292** says does not exist.

**The two cannot both be satisfied by this document.** Uploading, replacing and permanently deleting a file are
plainly critical actions under `MP-GBR-13`; the mechanism to audit them is an event this module may not publish.

`FIL-GAP-004` records it, owner **Architecture Owner**, and this document specifies the **only** disposition
available without inventing an edge:

`FIL-BR-011`-consistent behaviour: the **consumer** that requested a file operation audits it as part of its own
operation, using its own already-declared `E-20` path — which is also what `AUD-FR-008` requires
(*"The audit fact **MUST** commit in the same database transaction as the state change it describes"*) and
`AUD-FR-003` requires (*"**SHALL NOT** decide what is auditable in another bounded context"*).

⚠ **The residual exposure is stated:** a **platform-initiated** operation — retention expiry (`FIL-FR-052`) and
the orphan sweep (`FIL-FR-065`) — has **no consumer** to audit it, and **no audit path of its own**. Under
`MP-GBR-13` that is a gap, and it is carried as `FIL-GAP-004` rather than closed by asserting an event.

---

## 14. Acceptance criteria

78 criteria. Each is written to be **observable** — a test can pass or fail it — and each names the obligation it
verifies. ⚠ **Criteria are NOT written for 17 of the 22 `FIL-XC-*` exclusions**: an exclusion states what must be
*impossible*, and a criterion asserting that something never happens is **unfalsifiable by observation**. This is
the same structural fact `PRD-023` published as its 67.3% coverage rather than rounding to 100%; §14.3 states the
arithmetic.

> ⚠ **Both figures in this paragraph were stale and were corrected at Stage 4.** The count said `76` after two
> criteria had been added, and the exclusion figure still said `18` after the Stage 2 recount had already measured
> **17**. Neither error was in the criteria themselves — they were in the *summary of* the criteria, which is the
> part no register check reads. **A count written in prose is a claim, and it decays every time the thing it counts
> changes.**

### 14.1 Upload, validation, scanning

`FIL-AC-001` — An upload with no resolved tenant context is refused, and no object is created. *(`FIL-FR-015`)*
`FIL-AC-002` — An upload whose byte content contradicts its declared content type is refused. *(`FIL-FR-016`)*
`FIL-AC-003` — An upload renamed to an allowed extension but carrying disallowed content is refused. *(`FIL-FR-016`, `FIL-FR-031`)*
`FIL-AC-004` — An upload exceeding `FIL-CFG-003` is refused, and no bytes remain in storage afterwards. *(`FIL-FR-017`, `FIL-BR-005`)*
`FIL-AC-005` — An upload for a purpose absent from `FIL-CFG-001` is refused. *(`FIL-FR-014`)*
`FIL-AC-006` — A video or audio upload is refused under the V1 allow-list. *(`FIL-FR-004`, `FIL-FR-005`)*
`FIL-AC-007` — An object in `Pending` or `Scanning` yields no signed URL. *(`FIL-FR-019`)*
`FIL-AC-008` — An object whose scan verdict is *infected* yields no signed URL by any operation, including replace. *(`FIL-FR-020`, `FIL-BR-014`)*
`FIL-AC-009` — With the scanner unavailable, uploads are refused and no object reaches `Available`. *(`FIL-FR-066`)*
`FIL-AC-010` — No configuration value makes the scanner fail open. *(`FIL-FR-066`, `FIL-CFG-005`)*
`FIL-AC-011` — There is exactly one upload entry point on the port. *(`FIL-FR-013`)*
`FIL-AC-012` — No operation returns bytes of an object that is not `Available`. *(`FIL-FR-021`, `FIL-INV-001`)*
`FIL-AC-013` — A successful upload returns a `FileRef`. *(`FIL-FR-022`)*
`FIL-AC-014` — An interrupted upload leaves no resolvable `FileRef`. *(`FIL-FR-063`, `FIL-INV-003`)*
`FIL-AC-015` — Bytes committed without a metadata record are reclaimed by the sweep and are unreachable meanwhile. *(`FIL-FR-064`, `FIL-FR-065`)*
`FIL-AC-016` — A retried upload with the same idempotency key returns the original `FileRef` and creates no second object. *(`FIL-FR-060`, `FIL-FR-061`)*

### 14.2 References, metadata, access, isolation, lifecycle

`FIL-AC-017` — A `FileRef` contains no storage path, bucket, vendor token or URL, under any encoding. *(`FIL-FR-023`)*
`FIL-AC-018` — Two `FileRef`s issued in sequence are not derivable from one another. *(`FIL-FR-025`)*
`FIL-AC-019` — A valid `FileRef` presented under a different tenant context is refused as not-found. *(`FIL-FR-026`, `FIL-INV-002`)*
`FIL-AC-020` — Deleting one `FileRef` leaves another denoting identical bytes fully readable. *(`FIL-FR-027`, `FIL-BR-010`; satisfies `SID-4.37`)*
`FIL-AC-021` — Every stored object carries all nine metadata elements. *(`FIL-FR-028`)*
`FIL-AC-022` — The recorded creation time is server time; a client-supplied time is not recorded as the time of record. *(`FIL-FR-029`)*
`FIL-AC-023` — Metadata contains no `StudentRecordId` and no domain business field. *(`FIL-FR-030`, `MP-GBR-03`)*
`FIL-AC-024` — A client filename is never used as a storage key. *(`FIL-FR-031`, `FIL-FR-025`)*
`FIL-AC-025` — No metadata operation returns a reverse list of the domain records holding a `FileRef`. *(`FIL-FR-033`)*
`FIL-AC-026` — No object is readable without an access decision, in any lifecycle state. *(`FIL-FR-034`, `FIL-INV-004`)*
`FIL-AC-027` — Read access is delivered only as a signed URL with a bounded lifetime. *(`FIL-FR-035`)*
`FIL-AC-028` — A signed URL is issued only after an affirmative decision for that caller and object. *(`FIL-FR-036`)*
`FIL-AC-029` — A signed URL is unusable after `FIL-CFG-004` elapses. *(`FIL-FR-037`)*
`FIL-AC-030` — No operation extends or refreshes an issued signed URL. *(`FIL-FR-038`)*
`FIL-AC-031` — A signed URL cannot be used to write, overwrite, delete or mutate metadata. *(`FIL-FR-039`)*
`FIL-AC-032` — After a permission is revoked, no new signed URL is issued for that caller. *(`FIL-FR-040`)*
`FIL-AC-033` — A "public" object is still served by a signed, tenant-scoped, expiring URL. *(`FIL-FR-041`)*
`FIL-AC-034` — An access-decision refusal is indistinguishable from not-found in body, status and timing. *(`FIL-FR-011`, `FIL-FR-042`, `FIL-FR-047`)*
`FIL-AC-035` — Every tenant-scoped object carries a `tenant_id`; no global object carries one. *(`FIL-FR-043`, `FIL-FR-044`, `FIL-INV-008`)*
`FIL-AC-036` — Every cache key, lookup key and namespace this module builds contains the tenant identifier for tenant-scoped objects. *(`FIL-FR-045`, `X-13`)*
`FIL-AC-037` — No enumeration, count or aggregate exposes the existence of a cross-tenant object. *(`FIL-FR-047`)*
`FIL-AC-038` — A global object is unreachable via a tenant-scoped decision, and vice versa; their key namespaces do not intersect. *(`FIL-FR-048`)*
`FIL-AC-039` — An object's isolation class cannot be changed after upload. *(`FIL-FR-044`)*
`FIL-AC-040` — A replace re-runs validation and scanning, and preserves the `FileRef`. *(`FIL-FR-049`, `FIL-BR-006`, `FIL-BR-007`)*
`FIL-AC-041` — A soft-deleted object is unreadable and is restorable within `FIL-CFG-006`. *(`FIL-FR-050`, `FIL-BR-008`)*
`FIL-AC-042` — A permanently deleted object is unrecoverable by any operation. *(`FIL-FR-051`)*
`FIL-AC-043` — Retention does not execute while `FIL-CFG-006` is unresolved; the module refuses rather than defaulting. *(`FIL-FR-052`, `FIL-BR-011`)*
`FIL-AC-044` — An object under legal hold survives retention expiry and an explicit permanent-delete request. *(`FIL-FR-053`, `FIL-INV-007`)*
`FIL-AC-045` — No operation in this module originates an erasure obligation. *(`FIL-FR-054`)*
`FIL-AC-046` — An object occupies exactly one lifecycle state; no state is both readable and deleted. *(`FIL-BR-003`, §9.2)*

### 14.3 Derivatives, events, progress, extensibility

`FIL-AC-047` — A derivative is not addressable by its own `FileRef`. *(`FIL-FR-056`)*
`FIL-AC-048` — Deleting an original removes every derivative, in both soft and permanent forms. *(`FIL-FR-058`, `FIL-INV-006`)*
`FIL-AC-049` — A derivative size not in `FIL-CFG-007` is refused; caller-supplied dimensions are not honoured. *(`FIL-FR-059`)*
`FIL-AC-050` — The module publishes zero domain events; no outbox row, topic or subscriber exists for it. *(`FIL-FR-062`, §0.3)*
`FIL-AC-051` — Upload progress is observable only by the uploading actor's own request, and the module holds no realtime port. *(`FIL-FR-068`, `FIL-FR-069`)*
`FIL-AC-052` — Adding a content type requires only a `FIL-CFG-002` change: no port signature, contract or code path changes. *(`FIL-FR-071`, `FIL-FR-072`)*

**Added by the Stage 2 self-consistency audit.** The audit's coverage recount found four obligation-bearing
requirements that carried real behaviour yet no criterion. Three are closed here; the fourth is `FIL-FR-046`,
which remains uncovered for the reason given below.

`FIL-AC-053` — Every access decision is obtained from `BC-18` per request, and no decision is cached, reused across requests, or inferred from a previous grant. Replaying an operation after the caller's permission is revoked is refused. *(`FIL-FR-008`)*
`FIL-AC-054` — No object reaches `Available` without a completed scan verdict. Injecting an object directly into `Available` without a verdict is not possible through any operation, configuration value or privileged path. *(`FIL-FR-018`, `FIL-FR-022`, `FIL-BR-004`)*
`FIL-AC-055` — Consumption reporting returns a **measured** figure and never a verdict: it returns no allowance, no remaining balance and no permitted/denied judgement. *(`FIL-BR-012`, `FIL-XC-008`)*
`FIL-AC-056` — Where a purpose is counted, an upload refused by `BC-21` is refused with the cause `BC-21` supplied, and the module substitutes no cause of its own. *(`FIL-BR-012`; `ENT-FR-019`, which requires an exceeded allowance and a disabled gate to remain distinguishable)*

### 14.4 Shared-object access (student-to-student sharing)

`FIL-AC-057` — A share grant records the `FileRef`, granting actor, recipient `PersonId`, server-assigned grant time, state and eligibility-decision reference; a grant missing any of these is refused. *(`FIL-FR-075`, `FIL-INV-009`)*
`FIL-AC-058` — The module performs no eligibility evaluation of its own: with the calling context's decision reference absent, the grant is refused, and no friendship, block or `canMessage` result is read or stored. *(`FIL-FR-076`, `FIL-XC-019`)*
`FIL-AC-059` — A recipient attempting to replace, soft-delete, permanently delete, re-share or edit metadata of a shared object is refused, and ownership is unchanged. *(`FIL-FR-077`, `FIL-BR-015`)*
`FIL-AC-060` — A recipient's read is served only by a signed URL with a bounded lifetime; no grant makes an object publicly or anonymously reachable, and no unauthenticated request succeeds. *(`FIL-FR-078`, `FIL-XC-021`)*
`FIL-AC-061` — After revocation, no new URL is issued to that recipient; the response is indistinguishable from not-found. *(`FIL-FR-079`, `FIL-FR-042`)*
`FIL-AC-062` — Revocation is not claimed to invalidate an already-issued URL; the documented exposure equals the `FIL-CFG-004` lifetime and no longer. *(`FIL-FR-079`, `FIL-BR-009`)*
`FIL-AC-063` — While an object is soft-deleted no grant on it is readable, and each grant's recorded state is unchanged by the soft-delete; permanent deletion removes the grants. *(`FIL-FR-080`, `FIL-INV-009`)*
`FIL-AC-064` — An existing grant does not extend retention: the object is still purged at `FIL-CFG-006`. *(`FIL-FR-080`)*
`FIL-AC-065` — A grant naming a recipient outside the object's isolation class is refused as not-found, and no object changes class through a grant. *(`FIL-FR-081`, `FIL-FR-047`)*
`FIL-AC-066` — A shared global-class object carries **no** `tenant_id` at any point in the share flow. *(`FIL-FR-081`, `FIL-INV-008`, `TEN-FR-018`)*
`FIL-AC-067` — A tenant-class object cannot be granted to a recipient by this mechanism. *(`FIL-FR-081`, §7.3)*
`FIL-AC-068` — Grant, revocation and a recipient's first read are each recorded by the calling context in the same transaction, and this module publishes no event to achieve it. *(`FIL-FR-082`, `FIL-FR-062`)*
`FIL-AC-069` — A prior share, conversation or successful read does not authorise a further share: each grant requires a fresh decision. *(`FIL-BR-016`, `FIL-FR-008`)*
`FIL-AC-070` — Deleting a message, conversation or friendship in the calling context causes no change to stored bytes or metadata. *(`FIL-BR-017`, `FIL-XC-020`)*
`FIL-AC-071` — A grant is `Active` or `Revoked` and never both; `Revoked` cannot return to `Active`. *(`FIL-INV-010`)*
`FIL-AC-072` — A grant whose granting actor and recipient are the same `PersonId` is refused. *(`FIL-INV-011`)*
`FIL-AC-073` — No message text is stored by this module: a share carries a `FileRef` and access facts only. *(`FIL-XC-020`)*
`FIL-AC-074` — No share-by-link without a named recipient can be created, and no endpoint lists or searches shared files across recipients. *(`FIL-XC-021`)*
`FIL-AC-075` — The module originates no moderation verdict: it exposes no abuse-report, strike or ban operation. *(`FIL-XC-022`)*
`FIL-AC-076` — Video and audio remain refused for a shared object exactly as for any other upload. *(`FIL-FR-005`, `FIL-FR-016`)*

**Added by the Stage 4 requirements review.** The review corrected three sharing requirements and each correction
introduced observable behaviour that no existing criterion asserted. Adding the criteria — rather than leaving the
corrected text untested — is what keeps *"every requirement is testable"* true after a repair.

`FIL-AC-077` — A stored grant carries the eligibility-decision reference it was given, byte-for-byte as supplied, and the module derives, recomputes or substitutes no reference of its own. *(`FIL-FR-075`, `FIL-FR-076`)*

> ⚠ **This criterion was rewritten during the same review that added it (`S4-D-05`).** As first written it asserted
> that *"a grant request carrying no eligibility-decision reference is refused"* — which is **exactly what
> `FIL-AC-058` already asserts**, with an **identical citation set** `(`FIL-FR-076`, `FIL-XC-019`)`. A
> duplicate-detection pass over all 78 criteria found the collision by comparing citation sets, not wording, which
> is why paraphrase did not hide it. The `FIL-FR-076` repair had in fact left the **positive** half untested — that
> the supplied reference is *recorded unchanged* — so the criterion now asserts that instead. **A review that
> repairs a requirement must re-run duplicate detection over its own additions**, because the fixer is the party
> least likely to notice that the fix restates something.

`FIL-AC-078` — An object restored from soft-delete within `FIL-CFG-006` again serves reads to grants that were `Active` at the time of deletion, and does not serve reads to grants that were `Revoked`. *(`FIL-FR-080`, `FIL-BR-008`, `FIL-INV-010`)*

⚠ **`FIL-FR-046` (security review of an isolation-key change) is deliberately left uncovered.** A criterion
would have to assert that a **human review process** occurred, which is not observable in the system under test.
`PRD-014` set this precedent for `ENT-FR-017`: a criterion asserted here *"would test"* behaviour *"which this
PRD does not govern"*. The obligation stands; it is verified by governance, not by a test.

**Coverage, computed and stated rather than claimed.** 132 obligation-bearing identifiers
(82 `FIL-FR` + 17 `FIL-BR` + 11 `FIL-INV` + 0 `FIL-EVT` + 22 `FIL-XC`). Coverage is counted by extracting the
citation set of the **78 `FIL-AC-*` definition lines only** — not the whole of §14, because §14 also *names* the
uncovered identifiers and counting those would inflate the figure.

> ⚠ **Corrected at Stage 4 (`S4-D-06`).** This paragraph read *"114 obligation-bearing identifiers"* immediately
> followed by the breakdown `82 + 17 + 11 + 0 + 22`, **which sums to 132**. The sentence therefore contradicted its
> own parenthesis, and the ratio published two lines below — `94 of 132` — contradicted it again. The stale `114`
> was a survivor of the pre-sharing register sizes, carried through a scope change that added 18 obligations.
> **The arithmetic was checkable against a total printed in the same sentence, and it still went unnoticed through
> three passes** — which is why totals are now recomputed rather than read.

**94 of 132 are covered = 71.2%. 38 are uncovered = 28.8%.**

The 38 divide into two kinds. **17 of the 22 `FIL-XC-*` are uncovered by construction** — an exclusion is not
falsifiable by observing this module. **Five are the exception**: the four sharing exclusions
`FIL-XC-019`…`FIL-XC-022`, because each forbids a *behaviour a share flow could otherwise exhibit* and so is
observable, and `FIL-XC-008`, which `FIL-AC-055` makes observable by asserting that consumption reporting
returns a measured figure and never a verdict. The remaining **21** are the definitional, structural and cited
obligations, which state where a rule *lives* rather than what the system *does*: `FIL-FR-001`, `FIL-FR-002`,
`FIL-FR-003`, `FIL-FR-006`, `FIL-FR-007`, `FIL-FR-009`, `FIL-FR-010`, `FIL-FR-012`, `FIL-FR-024`,
`FIL-FR-032`, `FIL-FR-046`, `FIL-FR-055`, `FIL-FR-057`, `FIL-FR-067`, `FIL-FR-070`, `FIL-FR-073`,
`FIL-FR-074`, `FIL-BR-001`, `FIL-BR-002`, `FIL-BR-013`, `FIL-INV-005`.

⚠ **This list was corrected during the V1 sharing-scope pass.** It previously named `FIL-BR-009` as uncovered
and claimed 18 uncovered exclusions and 20 remaining. Both were stale: the new `FIL-AC-062`, written for
revocation, **also covers `FIL-BR-009`** (the guarantee of a signed URL is its expiry, not its revocability),
and `FIL-XC-008` was already covered by `FIL-AC-055`. Adding criteria changed the composition of the uncovered
set, not only its size — **a coverage list must be recounted after every addition, never carried forward.**

⚠ **Four substantive obligations were found uncovered by the audit and three are now closed.** `FIL-FR-008`
(a `BC-18` decision on **every** request, never cached) and `FIL-FR-018` (scanning is **mandatory**) carried
real behaviour that no criterion asserted — `FIL-AC-009` and `FIL-AC-010` tested only the
*scanner-unavailable* and *never-fail-open* paths, not the positive requirement that a scan runs at all. The
quota obligation `FIL-BR-012` was likewise untestable. `FIL-AC-053`…`FIL-AC-056` close all three, and the
`FIL-AC-*` range was **extended contiguously to 056** and re-declared in §0.2 rather than leaving the published
range false. The fourth, `FIL-FR-046`, stays uncovered for the stated reason: it obliges a **human security
review**, which is not observable in the system under test.

⚠ **This figure is published unrounded and is NOT a claim of verification: 0 of 76 criteria are proven by a
passing test, because no implementation exists.** The precedent avoided is `PRD-006` v1.0, which published
*"100% coverage"* against a true 49.1%. ⚠ **This paragraph itself was corrected during the Stage 2
self-consistency audit**: the first draft asserted *"89 of 114 = 78.1%"* while naming 43 uncovered identifiers —
an internally impossible pair. The figure above was recomputed mechanically from the citation set, and the
draft's list was also found to have wrongly included `FIL-BR-005` (which **is** covered, by `FIL-AC-004`) and
to have omitted `FIL-FR-008` and `FIL-FR-018`. See §18.3.

---

## 15. Dependencies and consumed authority

### 15.1 Authority consumed — every rule this document cites rather than makes

| Authority | Rank | What it fixes here |
|---|---|---|
| `MASTER_PRD.md` `MP-GBR-03`, `06`…`09`, `13`, `14`, `20`…`23`, `26` | **1** | Tenant rules, scope register, non-disclosure, audit, soft delete |
| `MASTER_PRD.md` `MP-CON-01`, `02`, `03`, `08` | **1** | No vendor in domain; BaaS is deployment; abstract data layer; descriptive-EA rule |
| `MASTER_PRD.md` `MP-NFR-05`, `06`, `08`, `09`, `10`, `12` | **1** | Security, UI, accessibility, observability, compliance, refuse-rather-than-guess |
| `MASTER_PRD.md` **L194**, **L638** | **1** | `BC-29` content and V1 membership |
| `ADR-0013` | **2** | `BC-29` → `PRD-017`; *"Binaries owned by `BC-29`; `FileRef`s held by consumers"* |
| `ADR-0016` | **2** | `BC-10` on `E-22`, required by `SID-4.35` |
| `ADR-0012` | **2** | The `platform/services` port debt (`FIL-GAP-010`) |
| `Student_Identity_PRD_v1.md` `SID-3.19`, `SID-3.20`, `SID-4.35`, `SID-4.36`, `SID-4.37` | **3, FROZEN** | `FileRef` only; virus scan; signed expiring URLs; ownership of upload/scan/thumbnail/signing; independent lifecycles |
| `Library_PRD_v1.md` `LIB-6.6`, `LIB-7.1` | **3, FROZEN** | Logo/cover through `BC-29` by id, no binaries, no constructed URL; public-field set owned there |
| `PRD-013_TENANCY.md` `TEN-FR-002`, `010`, `011`, `013`, `018`, `019`, `020` | **3, FROZEN** | Tenant context and partitioning |
| `PRD-016_AUDIT_TRAIL.md` `AUD-FR-003`, `007`, `008`, `009`, `010`, `012` | **3, FROZEN** | Audit ownership, server time, same-transaction, non-blocking, `E-20` |
| `PRD-014_ENTITLEMENT.md` `ENT-FR-012`, `013`, `017`, `018`, `019` | **3, FROZEN** | The entitlement port, its pre-mutation position, allowance reporting |
| `PRD-023_SETTINGS_AND_CONFIGURATION.md` `CNF-XC-008`, `CNF-XC-012` | **3, FROZEN** | `BC-25` explicitly disclaims file operations **and** the RLS model |
| `Student_Management_PRD_v1.md` `DocumentRef[]` | **3, FROZEN** | The consumer record; **not** owned here |
| `LIBOORA_BOUNDED_CONTEXT_MAP.md` **L114**, **L118**, **L138**, **L267**, **L292**, **L331**, §7.4, §8, §9 | **4** | Context, band, edge, the edge-existence rule, the aggregate and event registers |
| `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` `L2`, `X-03`, `X-05`, `X-08`, `X-10`, `X-13`, **L403** | **4** | Downward-only, forbidden edges, the one RLS clause |
| `tool/module_dependencies.yaml` **L33**, **L110**, **L184**, **L242**, **L338**, **L518-523**, **L647** | **5** | Rank, port grants, banned imports, the port debt |
| `LIBOORA_ENTERPRISE_ARCHITECTURE.md` **L86**, **L1874-1880** | **6, Descriptive** | The file-pipeline inventory — ⚠ **contradicts Rank 3 on virus scan; see §1.3 and `FIL-GAP-005`** |

### 15.2 Consumers of this module

| Consumer | Route | Requirement that consumes | Status |
|---|---|---|---|
| `BC-01` Enrollment (`PRD-004`) | `E-22` · manifest **L110** | `DocumentRef[]`, Library Identification Photo | **FROZEN** |
| `BC-06` Library Policy (`PRD-002`) | `E-22` via `domain/library` **L110** | `LIB-6.6` logo and cover | **FROZEN** |
| `BC-10` Global Person Identity (`PRD-003`) | `E-22` · manifest **L184** | `SID-3.19`, `SID-4.35` profile photo | **FROZEN** |
| `BC-14` Content Sharing | `E-22` (BC Map **L331**) | — | ⚠ **V2**, holds no manifest module — `FIL-GAP-007` |
| `domain/social` (`BC-11`/`12`/`13`) | manifest **L242** | **V1 student-to-student sharing** — §2.6, `FIL-FR-075`…`082` | ⛔ **Not on `E-22`** — refused by `FIL-FR-006`. **Blocks the V1 capability**; `FIL-GAP-003`, `FIL-GAP-012`, `B-11` |
| `BC-03` Attendance | — | `ATT-FR-080` register-image workflow | ⛔ **Excluded** by `ATT-XC-004`; `ADR-0022` **Proposed**, undecided |

### 15.3 Ports this module consumes

`platform/tenancy:tenant_context` · `platform/identity:policy_decision` · `platform/configuration:settings`
· `platform/observability:telemetry` · `platform/services:clock` · `platform/services:idempotency`
· `platform/services:job_runtime` · `platform/business:entitlement` · `platform/data:repository`
· `platform/security:crypto`

⚠ **None of these is declared as a `ports:` list for `platform/services` in the manifest**, because
**`platform/services` has no module block at all** — only a rank at **L33**. Measured: `grep -n
'^platform/services:'` → **no match**, against 16 modules that do have blocks. This is the identical defect
`PRD-023` carried as blocker **`B-1`** for `platform/configuration`, with the identical consequence:
`check_module_boundaries.dart` **L778** (`if (module.declaredImports.isEmpty) return;`) **exempts a blockless
module from the `default_decision: deny`**, so this module's boundary is currently **unenforced**.
**`FIL-GAP-010`**, owner **Architecture Owner**.

---

## 16. Open gaps and risks

**13 gaps. All OPEN. None is resolved by this document, and none may be resolved by an implementation choice.**

> ⚠ **Corrected at Stage 5 (`S5-D-01`).** This line read *"**11 gaps**"* while the table below carried **13** rows
> and §0.2 declared **13** with the range `FIL-GAP-001` … `FIL-GAP-013`. `FIL-GAP-012` and `FIL-GAP-013` were added
> **by the Stage 3 architecture alignment** — the `E-22` consumer omission and the peer-sharing isolation wording —
> and the preamble count was not moved with them. **The same class of defect as `S4-D-06`**, found the same way: a
> checker recomputed the register instead of reading the sentence. It is the *fourth* stale prose count in this
> document's short history, which is why §0.2's table — not any sentence — is the authority, and why both Stage 5
> checkers now recompute every published total rather than trust one. **A count written in prose is a claim, and it
> decays every time the thing it counts changes.**
>
> ⚠ The rows were also **out of numeric order** — `012`, `013`, `011` — because `FIL-GAP-011` was appended after the
> two Stage 3 additions. Reordered to `001`…`013`. Contiguity was never affected (both checkers verify the *set*,
> not the row order), so this is legibility rather than correctness — but a register whose rows do not ascend
> invites a reader to assume a number is missing.

| ID | Gap | Severity | Owner | Evidence |
|---|---|---|---|---|
| **`FIL-GAP-001`** | **`BC-29` owns no aggregate in BC Map §8.** 17 rows, `BC-29` in none (measured 0). `PRD_LIFECYCLE.md` Stage 1 asks *"Does it own an aggregate and an invariant?"* — this module owns invariants but no registered aggregate. **This PRD takes neither side** | **High** | Architecture Owner | BC Map §8; §6.1 above; the `CNF-GAP-001` precedent |
| **`FIL-GAP-002`** | **No reference counting is possible.** `FIL-FR-033` forbids a reverse index (Matrix `L2`), so a delete cannot verify that no consumer still holds the `FileRef`. Dangling references are a specified, not accidental, outcome | **High** | Architecture Owner | §9.5; `ADR-0013` §5 |
| **`FIL-GAP-003`** | **`E-22`'s consumer list and the module manifest disagree.** `E-22` = `BC-01`, `BC-10`, `BC-14`; manifest **L242** grants `domain/social` (`BC-11`/`12`/`13`) the `files` port. Under BC Map **L292** that edge *"does not exist"*, so `FIL-FR-006` refuses the caller — meaning a declared port grant is **currently unusable** | **High** | Architecture Owner | BC Map **L331**; manifest **L242**; `ADR-0022` is the precedent mechanism |
| **`FIL-GAP-004`** | **File operations cannot be audited by this module.** `MP-GBR-13` requires every critical action be auditable; `E-20` is an **event** edge; `BC-29` is a producer in **0** BC Map §9 rows, so `FIL-FR-062` forbids publishing. Consumer-side audit covers consumer-initiated operations; **retention expiry and the orphan sweep have no audit path at all** | **High** | Architecture Owner | §13.2; BC Map §9, **L292**, **L329**; `AUD-FR-010` |
| **`FIL-GAP-005`** | **Virus scan and thumbnailing are V1 at Ranks 3 and 4 and V2 at Rank 6.** `SID-3.20`/`SID-4.36` (FROZEN) and BC Map **L138** vs EA **L1876**/**L1877**. Precedence resolves it in favour of V1 (`MP-CON-08`), and the EA is **not edited here** — amending a ranked document is not a Stage 2 act. The `ADR-0042` precedent shows the repair shape | **Medium** | Architecture Owner | §1.3; EA **L1874-1880**; baseline §3 EA cell |
| **`FIL-GAP-006`** | **No V1 context owns comments, likes or reactions on shared content.** `FIL-XC-003` prohibits them here but can name no owner; the nearest is `BC-14`, at **V2** | **Low** | Product Owner | BC Map §3.2; `FIL-XC-003` |
| **`FIL-GAP-007`** | **`BC-14` Content Sharing is `V2` yet appears on the V1 edge `E-22`'s consumer list**, and holds no module in the manifest. A V1 capability lists a V2 consumer it cannot be called by | **Medium** | Architecture Owner | BC Map **L118** vs **L331** |
| **`FIL-GAP-008`** | **No authority supplies a retention period, soft-delete window or legal-hold trigger.** `MP-NFR-10` assigns them to SECURITY + DATA Governance. `FIL-CFG-006` is published with a range and **no default**, and `FIL-FR-052` makes the absence a startup refusal rather than a silent zero | **High** | SECURITY + DATA Governance | `MP-NFR-10`; the `AUD-GAP-001` precedent |
| **`FIL-GAP-009`** | **No encryption, key-management or RLS specification exists at any rank**, and **no UI Design System and no NFR Budgets document exists** (`find` → 0 each). This document therefore states behaviour, not policy, and defines no token, algorithm or budget | **High** | SECURITY · UI Design System owner · NFR owner | §7.1, §7.2, §11, §12.2; `PRD-023` blockers `B-3`, `B-4` |
| **`FIL-GAP-010`** | **`platform/services` has NO module block in `tool/module_dependencies.yaml`** — only a rank at **L33**. `check_module_boundaries.dart` **L778** exempts a blockless module from `default_decision: deny`, so this module's boundary is **unenforced**. `ADR-0012`'s debt at **L647** records that *"only the interfaces are missing"*, expiring **2027-03-31** | **High** | Architecture Owner | manifest; the `CNF-GAP-007` / `B-1` precedent |
| **`FIL-GAP-011`** | **No database, storage or API-error architecture artefact exists.** `Supabase` appears in `docs/` twice, both *"Not named in EA — **candidate only**"*, and **L271** records that naming a vendor as a layer was corrected out. No Event Catalog and no error register exist. Bucket topology and error vocabulary are therefore **unspecifiable** here without inventing an authority | **Medium** | Architecture Owner | `MASTER_PRD.md` **L227**, **L228**, **L271**; `PRD-023` blocker `B-5` |
| **`FIL-GAP-012`** | ⛔ **`E-22` does not list the sharing contexts, so V1 student-to-student sharing is specified but not servable.** `BC-11`/`BC-12`/`BC-13` are absent from `E-22`'s consumer list (BC Map **L331**) while the manifest **L242** grants `domain/social` the `files` port. Under `FIL-FR-006` the caller is refused. Widening needs an accepted ADR (**L292**); `ADR-0016` is the precedent shape and **this PRD does not write it** | **Blocking** | Architecture Owner | BC Map **L331**, **L292**; manifest **L242**; §2.6; `ADR-0016` |
| **`FIL-GAP-013`** | **"Tenant/library membership isolation" cannot apply to peer sharing as worded.** BC Map **L488** makes `BC-11`→`BC-17` *"Global. No `tenantId`"* and `TEN-FR-018` forbids `tenant_id` in global contexts. If sharing must be confined to co-members of one library, that is `BC-11`'s eligibility rule for `PRD-021` to state, not a tenant predicate here | **High** | Product + `PRD-021` | §7.3; BC Map **L488**, **L114**; `TEN-FR-018`; `FIL-XC-019` |

### 16.1 Risks

| Risk | Consequence | Mitigation in this document |
|---|---|---|
| Cross-tenant object exposure | `MP-RSK-01`, *"highest-severity failure class in the system"* | `FIL-FR-043`…`048`, `FIL-INV-002`, `FIL-INV-008`, `FIL-AC-035`…`039` |
| Malware distribution through a trusted platform surface | Reputational and legal | `FIL-FR-018`…`021`, `FIL-FR-066`, `FIL-BR-014`, fail-closed and non-configurable |
| Signed URL leakage | Time-bounded unauthorised read | `FIL-FR-037`, `FIL-FR-038`, `FIL-BR-009` — and `FIL-FR-040` **declines to overclaim** revocability |
| Enumeration of references | Bulk extraction from a single authorisation defect | `FIL-FR-025`, `FIL-AC-018` |
| Storage-cost runaway | `MP-NFR-11` FinOps | `FIL-FR-017`, `FIL-FR-059`, `FIL-CFG-009`, `FIL-BR-012` — and `FIL-XC-008` keeps the *decision* with `BC-21` |
| Dangling `FileRef` after delete | Broken consumer surfaces | ⛔ **Not mitigated** — `FIL-GAP-002`, stated rather than papered over |
| Unaudited platform-initiated deletion | `MP-GBR-13` breach | ⛔ **Not mitigated** — `FIL-GAP-004` |

---

## 17. Lifecycle and implementation readiness

### 17.1 Stage position

| Stage | State | Evidence |
|---|---|---|
| **1 — Discovery** | ⚠ **Evidence gathered; no artefact written.** The read-only audit in §18.2 answered all four Stage 1 gate questions, and the gate itself — *"a context identified in the Bounded Context Map, **not already owned** in `PRD_REGISTRY.md` §6"* — is **satisfied**: BC Map **L138** identifies `BC-29`, and registry **L449** records `BC-29` → `PRD-017`, *"**No** — resolved 2026-08-04 by `ADR-0013`"*. **But `PRD_LIFECYCLE.md` L41 holds that *"if the artefact does not exist, the stage has not been passed"***, and `docs/30-product/file-media/PRD-017_STAGE1_DISCOVERY.md` **does not exist**. Recorded, not claimed as passed | §18.2; `PRD_REGISTRY.md` **L449** |
| **2 — Draft** | ✅ **This document.** Header present; registers declared up front with contiguous ranges (§0.2); prefix chosen by the §5 procedure **before** writing (§0.4); normative language defined (§0.1) | `PRD_LIFECYCLE.md` **L79–86** |
| **3 — Architecture Review** | ⬜ **NOT BEGUN** | — |
| **4 — Requirements Review** | ⬜ **NOT BEGUN** | — |
| **5 — Traceability & Conferral** | ⬜ **NOT BEGUN.** No `FIL-*` identifier is registered in `TRACEABILITY_MATRIX.md` | — |
| **6 — Implementation Backlog** | ⬜ **NOT BEGUN.** No `IMPL-*` range allocated | §17.2 |
| **7 — Freeze** | ⬜ **NOT BEGUN.** `DOCUMENTATION_BASELINE.md` §3 holds **no row** admitting `PRD-017` — the only place freeze can be conferred | — |

⚠ **`FIL-GAP-008`-adjacent governance note, recorded because it will otherwise be discovered at Stage 3:** the
absent Stage 1 artefact is a real gate deficiency. This document does **not** write one retroactively, because a
discovery record produced *after* the draft it was supposed to gate would document a decision already made. It is
carried as a lifecycle finding here rather than manufactured.

### 17.2 The next free `IMPL-*` range, measured rather than assumed

| Range | Holder | Source |
|---|---|---|
| `IMPL-1100`…`1129` | `PRD-023` — 30 tasks | `PRD-023_IMPLEMENTATION_TASKS.md` **L9**, ratified `ADR-0053` §5 |
| `IMPL-1130`…`1199` | `PRD-023` growth **reserve** | `PRD-023_IMPLEMENTATION_TASKS.md` **L88** |
| **`IMPL-1200` +** | **Unallocated** | `PRD-023_IMPLEMENTATION_TASKS.md` **L89** — literally *"`IMPL-1200` + \| Unallocated"* |

**The next free block is `IMPL-1200`+.** ⚠ **Not** taken from `PRD_LIFECYCLE.md` L147–153, **whose table is
stale** — `PRD-023`'s Stage 5 record states this explicitly for the same reason. **No range is allocated here**:
allocation is Stage 6, and identifier rule 1 is *"never reuse or reassign a number"*, so a speculative
reservation would burn numbers a Stage 6 record has not justified.

### 17.3 Implementation readiness — ⛔ NOT READY, and the blockers are named

| # | Blocker | Class | Blocks |
|---|---|---|---|
| **B-1** | No `platform/services` **module block** in the manifest, so the boundary is unenforced (`FIL-GAP-010`) | ⛔ external, architecture | Any boundary proof for this module |
| **B-2** | `test/architecture/` holds only `boundary_checker_test.dart`; **all seven Matrix §10.3 tests are missing**, including `tenant_isolation_test.dart` | ⛔ external, architecture | `FIL-AC-035`…`039` can be *written*, not *passed* |
| **B-3** | **UI Design System does not exist** (`MP-NFR-06`/`08`, Rank 1) | ⛔ external, product | §11 states expression only |
| **B-4** | **NFR Budgets do not exist** — no latency, retry or timeout bound at any rank | ⛔ external, product | `FIL-CFG-005`, §12.2 |
| **B-5** | **No retention authority** (`FIL-GAP-008`) | ⛔ external, legal | `FIL-FR-052`, `FIL-CFG-006`, `FIL-AC-043` |
| **B-6** | **No encryption / RLS specification** (`FIL-GAP-009`) | ⛔ external, security | §7.2 |
| **B-7** | **Five service-port interfaces do not exist** — `ADR-0012` debt, manifest **L647** | ⚠ constrains | `FIL-FR-060`, `FIL-FR-065`, `FIL-XC-017` |
| **B-8** | **`E-22` / manifest disagreement** (`FIL-GAP-003`) | ⚠ constrains | `FIL-FR-006` refusal behaviour |
| **B-9** | **No audit path for platform-initiated operations** (`FIL-GAP-004`) | ⚠ constrains | `MP-GBR-13` compliance |
| **B-11** | ⛔ **`E-22` omits `BC-11`/`BC-12`/`BC-13`** (`FIL-GAP-012`), so every requirement in §4.11 is refused by `FIL-FR-006` until an `ADR-0016`-shaped amendment lists the sharing context | ⛔ external, architecture | **All of V1 student-to-student sharing** |
| **B-10** | **`FIL-FR-046` carries no acceptance criterion and cannot carry one** — it obliges a **human security review** of an isolation-key change, which is not observable in the system under test. *(The three other uncovered substantive obligations found by the audit — `FIL-FR-008`, `FIL-FR-018`, `FIL-BR-012` — were closed by `FIL-AC-053`…`056`.)* | ⚠ external, governance | Verification of `MP-GBR-09` compliance |

⛔ **`DRAFT` is not `FROZEN`, and neither is `VERIFIED`: 0 of 76 acceptance criteria are proven by a test, 0 tasks
exist, all 13 `FIL-GAP-*` are OPEN, and coverage stands at a measured 71.2%.**

---

## 18. Traceability

### 18.1 Requirement → authority

| Requirement group | Traced to |
|---|---|
| `FIL-FR-001`…`003` | Matrix `L2`; manifest **L33**, `banned_imports`; `MP-CON-01`/`02`/`03`; `ADR-0013` §5 |
| `FIL-FR-004`…`007` | BC Map **L138**, **L292**, **L331**; `MASTER_PRD.md` **L194**; `ADR-0022` §1 |
| `FIL-FR-008`…`012`, `FIL-BR-001`/`002` | `MP-GBR-20`…`23`, `MP-GBR-26`; `X-13`; manifest **L186** |
| `FIL-FR-013`…`022`, `FIL-BR-004`/`005` | `SID-3.20`, `SID-4.36` (FROZEN); BC Map **L138**; `TEN-FR-010`/`011` |
| `FIL-FR-023`…`027`, `FIL-BR-006`/`007`/`010` | `E-22` BC Map **L331**; manifest **L184**; **`SID-4.37`** (FROZEN); `LIB-6.6` (FROZEN) |
| `FIL-FR-028`…`033`, `FIL-BR-013` | `MP-GBR-03`; `AUD-FR-007`; `ADR-0013` §5; Matrix `L2` |
| `FIL-FR-034`…`042`, `FIL-BR-009` | `SID-3.20` (FROZEN); `MP-GBR-22`; `ENT-FR-019`; `LIB-7.1` |
| `FIL-FR-043`…`048`, `FIL-INV-002`/`008` | `TEN-FR-018`/`019`/`020`; `MP-GBR-08`/`09`; `X-13`; BC Map **L114** |
| `FIL-FR-049`…`054`, `FIL-BR-008`, `FIL-INV-007` | `SID-3.17`; `MP-GBR-13`/`14`; `MP-NFR-10` |
| `FIL-FR-055`…`059`, `FIL-INV-006` | `SID-4.36` (FROZEN); BC Map **L138**; §8.4 |
| `FIL-FR-060`…`067`, `FIL-BR-011`/`014` | manifest **L112**/**L339**/**L647**; `ENT-FR-008`/`018`; `AUD-FR-009`/`012`; `MP-NFR-12`; BC Map §9 |
| `FIL-FR-068`…`070` | manifest **L242-243**; BC Map (no realtime edge); `MP-NFR-09` |
| `FIL-FR-071`…`074`, `FIL-BR-012` | `MP-CON-03`; `ENT-FR-017`; `PRD-023` Stage 4 gate; `SEAT-BR-045` discipline |
| `FIL-XC-001`…`022` | Each names its owner inline in §2.3; `019`…`022` name `BC-11`/`BC-12`/`BC-13` and the public-sharing prohibition |
| `FIL-INV-001`…`008` | §6.2, each with its source |
| `FIL-CFG-001`…`009` | §8.5, each with its reason; `E-19`; `FIL-XC-009` |
| `FIL-AC-001`…`052` | §14, each naming the obligation it verifies |
| `FIL-FR-075`…`082`, `FIL-BR-015`…`017`, `FIL-INV-009`…`011`, `FIL-XC-019`…`022` | **V1 student-to-student sharing** — product instruction 2026-08-20; BC Map **L115**/**L116**/**L117** (`BC-11`/`12`/`13` all **V1**), **L320** (`E-16` `canMessage`), **L378`**, **L488** (global band); `TEN-FR-018`; `SID-3.20`; `AUD-FR-008`; `ADR-0016` (the `E-22` precedent) |
| `FIL-GAP-001`…`013` | §16, each with measured evidence |

### 18.2 The read-only audit this document was written from

Conducted before any line above was drafted. **No file was modified during it.**

**Registers and governance:** `PRD_REGISTRY.md` (**L144**, **L148**, **L307**, **L405**, **L449**, **L458**,
**L465**, **L479**, **L480**, **L502**, **L503**, **L512**, **L517**, **L521**, **L540**, **L541**) ·
`PRD_LIFECYCLE.md` (§3 Stages 1–3, §5 identifier rules, §6 roles) · `PRD_OWNERSHIP_MODEL.md` (**L199**, §4.3,
§4.4) · `PRD_DEPENDENCY_GRAPH.md` (**L113** `D-11`) · `PRD_GAP_ANALYSIS.md` (**L174**, **L250-262** `PGA-04`) ·
`PRODUCT_IMPLEMENTATION_ROADMAP.md` (**L85-110**, Wave **1.4**) · `DOCUMENTATION_BASELINE.md` (§3.1, §3.2, §3.3,
§4, §7) · `ADR-INDEX.md` (**L50**, **L84**).

**ADRs:** `ADR-0013` (the normative rule, §2 table, **§2.1**, §3, **§5**, §6.1, **L313**) · `ADR-0016`
(**L12**, **L56**, **L59**, **L62**, **L80**, **L89**, **L101**, **L110**, **L113**, **L136**, **L176**) ·
**`ADR-0022`** (read in full — the `BC-03` question, **Proposed**, and the exact precedent mechanism) ·
`ADR-0053` (**L186**, **L261**) · `ADR-0012` (via manifest **L647**) · `ADR-0042` (via the baseline EA cell).

**Architecture:** `LIBOORA_BOUNDED_CONTEXT_MAP.md` — §3.2/§3.3 context tables (**L96**, **L101**, **L114**…
**L118**, **L133**…**L140**), **L267** band line, **§7 L288-296** the *"if not in this table it does not exist"*
rule, **§7.3 edges L326**, **L328**, **L329**, **L330**, **L331**, §7.4 `F-1`/`F-3`, **§8** aggregates
(**17 rows**, BC-29 count **0**), **§9** producers (BC-29 count **0**), edges touching BC-29 (count **1**) ·
`LIBOORA_MODULE_DEPENDENCY_MATRIX.md` (**L13**, **L94**, **L229**, **L352**, **L354**, **L359**, **L362**,
**L403**, **L579**, **L580**) · `LIBOORA_ENTERPRISE_ARCHITECTURE.md` (**L86**, **L1865-1893**).

**Rank 1:** `MASTER_PRD.md` (**L119-122**, **L194**, **L227**, **L228**, **L237-239**, **L271**, **L315-319**,
**L337-340**, **L350-357**, **L373**, **L495-508**, **L638**).

**Frozen consumers:** `Library_PRD_v1.md` (**L250-275**, `LIB-6.5`, **`LIB-6.6`**, `LIB-7.1`) ·
`Student_Identity_PRD_v1.md` (**L625-645**, `SID-3.17`…`SID-3.21`; **L920-945**, §4.8, **`SID-4.35`**,
**`SID-4.36`**, **`SID-4.37`**) · `Student_Management_PRD_v1.md` (**L179**, **L223**, **L226**, **L411**) ·
`PRD-013_TENANCY.md` (**L53-58**, **L121-240**) · `PRD-016_AUDIT_TRAIL.md` (**L44**, **L106-242**) ·
`PRD-014_ENTITLEMENT.md` (**L40-80** the register format, **L191-320**) ·
`PRD-023_SETTINGS_AND_CONFIGURATION.md` (**L1-40** header, **L852** `CNF-XC-008`, **L1084** `CNF-XC-012`) ·
`PRD-023_STAGE1_DISCOVERY.md` §6 (the prefix-selection method) ·
`PRD-023_IMPLEMENTATION_TASKS.md` (**L9**, **L88**, **L89**, **L128-132** blockers) ·
`PRD-004_OWNERSHIP_MATRIX.md` (**L34**) · `REVIEW_14A.md` (**L219**).

**Manifest and code:** `tool/module_dependencies.yaml` (**L26-33**, **L99-120**, **L172-190**, **L229-248**,
**L282**, **L338**, **L515**, **L518-523**, **L647-651**; and the **absence** of a `platform/services:` block) ·
`lib/platform/services/` (**one file**, `services.dart`) · `TRACEABILITY_MATRIX.md` §2–§2L (the prefix census).

**Measurements taken:** BC Map §8 rows = **17**, BC-29 in **0** · BC Map §9 BC-29 producer rows = **0** ·
edges touching BC-29 = **1** · `FIL-` forward scan across nine suffixes = **0** each · bare `FIL-[0-9]+` = **0** ·
reverse lookbehind `(?<=[A-Za-z0-9])FIL-` = **0** · `[A-Z]*FIL-` = **0** · `MED-`/`FM-`/`FILE-`/`MEDIA-` = **0** ·
highest allocated `IMPL-` = **1130**, reserve to **1199**, next free **1200** · `platform/services:files` consumer
grants = **3** · `platform/services` module blocks = **0** · UI Design System / NFR Budgets / Event Catalog /
Database Architecture documents = **0 each** · `Supabase` in `docs/` = **2**, both *"candidate only"* ·
`RLS` in `docs/` = **3**, none an architecture spec.

### 18.3 Change history

| Version | Date | Change |
|---|---|---|
| **v0.1** | 2026-08-20 | **Created at Stage 2 (Draft).** The first requirements ever written for `BC-29`, discharging the `PGA-04` finding that *"ownership exists — **requirements do not**"* while **two frozen Rank 3 PRDs** (`LIB-6.6`, `SID-4.35`) already consumed it. Authority: `ADR-0013` §5, whose **§2.1 records that it does *not create* `PRD-017`** — this document is that write. **232 identifiers across 8 registers**, 1 declared **EMPTY** (`FIL-EVT-*`, because `BC-29` is a producer in **0** BC Map §9 rows and minting an event would assert a path **L292** says does not exist), **132 obligation-bearing**, **78 acceptance criteria**, coverage published unrounded at a **measured 94/132 = 71.2%** with **17 of 22 exclusions uncovered by construction** and 21 definitional/structural obligations named. Prefix **`FIL-`** selected by the `PRD_LIFECYCLE.md` §5 procedure **before** writing, with **zero collisions in both directions** across four candidates. **0 aggregates asserted** — BC Map §8 grants `BC-29` none and **this document takes neither side** (`FIL-GAP-001`). **0 events, 0 `E-*` edges added, 0 requirements moved, 0 frozen documents modified.** ⚠ **Four repository contradictions measured and RECORDED rather than repaired**: `E-22`'s consumer list vs the manifest's `domain/social` grant (`FIL-GAP-003`); `BC-14` at **V2** on a **V1** edge (`FIL-GAP-007`); virus scan and thumbnailing **V1 at Ranks 3/4 and V2 at Rank 6** — resolved by *precedence*, not judgement, and **the EA was not edited** (`FIL-GAP-005`); and the audit path that cannot exist because `BC-29` publishes no event (`FIL-GAP-004`). ⚠ **`PRD_DEPENDENCY_GRAPH.md` L113's *"Owner exists (`PRD-002` owns `BC-29`)"* is stale against `ADR-0013` and was deliberately NOT corrected** — repairing an unrelated register is not a Stage 2 act. ⚠ **Four architecture artefacts were sought and found ABSENT** — UI Design System, NFR Budgets, Event Catalog, and any database/storage/RLS specification — so no token, budget, error code, bucket topology, encryption scheme or RLS predicate is written here, and **`Supabase` is not named**, both occurrences in `docs/` being *"candidate only"* (`FIL-GAP-009`, `FIL-GAP-011`). ⚠ **`platform/services` has no module block in the manifest**, so the boundary is unenforced — the identical defect `PRD-023` carried as `B-1` (`FIL-GAP-010`). ⚠ **Stage 1's artefact does not exist and is NOT written retroactively**; the gate deficiency is recorded in §17.1 instead. **All 13 `FIL-GAP-*` OPEN; 11 blockers, 6 ⛔ hard-external.** **No `IMPL-*` range allocated** (Stage 6) — measured next-free is **`IMPL-1200`+**, ⚠ **not** from `PRD_LIFECYCLE.md`'s stale table. **No code, no SQL.** ⚠ **A 10-check self-consistency audit was run before finalising and found three internal defects, all corrected in this same v0.1**: (1) §14.3 published *"89 of 114 = 78.1%"* while naming 43 uncovered identifiers — an arithmetically impossible pair; the figure was **recomputed mechanically** from the `FIL-AC-*` citation sets to **75/114 = 65.8%**, and the named list was corrected (`FIL-BR-005` wrongly listed as uncovered; `FIL-FR-008` and `FIL-FR-018` wrongly omitted), which also surfaced new blocker **`B-10`**; (2) §4.2 cited an `FIL-XC-` number **one past the end** of the declared 001–018 range, never defined; (3) §7.1 cited an `FIL-FR-` number **one past the end** of the declared 001–074 range, never defined. Both phantom citations were removed. **A second audit pass against the full CORE SCOPE brief then tested all 24 scope bullets and found one further defect: the storage-quota obligation `FIL-BR-012` was stated but **untestable** (zero criteria), and `FIL-FR-008`/`FIL-FR-018` were likewise uncovered. `FIL-AC-053`…`FIL-AC-056` were added, the `FIL-AC-*` range **extended contiguously to 056** and re-declared in §0.2, and coverage rose to a measured **75/114 = 65.8%**. Blocker `B-10` was narrowed to the single obligation that genuinely cannot be tested (`FIL-FR-046`, a human security review).** **A third pass then applied a product scope correction: student-to-student sharing is a V1 capability.** The brief presented it as promotion out of V2; **measurement found nothing to promote.** `BC-11` Social Graph, `BC-12` Messaging and `BC-13` Trust & Safety are **already V1** (BC Map **L115**, **L116**, **L117**) and `PRD-021` is registered **V1** (`PRD_REGISTRY.md` **L307**-adjacent row **L311**); the only V2 context, `BC-14` (**L118**), owns *"copyright and takedown"* over **published** content and is **not the owner of peer transfer**. So **no context was promoted, no version token was edited, and no new content type was minted** — `FIL-FR-004` already admits images, PDF and non-executable documents, which covers PDF notes, handwritten-note images, assignments and reference material, while `FIL-FR-005` keeps video and audio refused. **19 identifiers were added and every register was extended contiguously with zero renumbering of existing identifiers**: `FIL-FR-075`…`082` (share grant, recorded-not-derived authorization, read-only access, signed-URL-only delivery, revocation, lifecycle subordination, isolation-class equality, audit), `FIL-BR-015`…`017`, `FIL-INV-009`…`011`, and `FIL-XC-019`…`022`. **20 acceptance criteria `FIL-AC-057`…`FIL-AC-076` were added, giving every one of the 18 new obligation-bearing requirements at least one testable criterion (measured: missing = 0).** The **`PRD-021` boundary is enforced mechanically, not by intent**: `FIL-XC-019` refuses all eligibility, friendship, block and `canMessage` state to `BC-11`; `FIL-XC-020` refuses message text, ordering, receipts, presence and conversation membership to `BC-12`; `FIL-XC-022` refuses moderation to `BC-13`; and `FIL-FR-076` **records** the decision reference rather than re-deriving it, reasoned from Matrix `X-13` because a second `canMessage` evaluation could disagree with the owner's. The DO-NOT-ADD list is discharged as a *testable* prohibition by `FIL-XC-021` with `FIL-AC-074` — no public sharing, no anonymous sharing, no share-by-link without a named recipient, no public discovery. ⛔ **Two findings were RECORDED, not solved.** (1) `E-22` does not list `BC-11`/`BC-12`/`BC-13` (BC Map **L331**) while the manifest **L242** grants `domain/social` the `files` port, so under `FIL-FR-006` the caller is refused and **the V1 requirement is specified in full but is not servable**; widening a Rank 4 edge needs an accepted ADR (**L292**) and `ADR-0016` is the exact precedent shape — **this PRD does not write it** (`FIL-GAP-012`, **Blocking**, blocker `B-11`). (2) The brief's *"tenant/library membership isolation"* is **unsatisfiable as worded**: BC Map **L488** makes the `BC-11`→`BC-17` band *"Global. No `tenantId`"* under rule `ID-2` and frozen `TEN-FR-018` calls `tenant_id` *"Forbidden in global contexts"*. Rather than violate a frozen Rank 3 rule, §7.3 specifies shared study documents as **global-class** objects keyed on `PersonId` — **not weaker isolation, differently keyed** — keeps tenant-class library documents non-shareable via `FIL-FR-081`, and routes the real intent to `BC-11`'s eligibility rule (`FIL-GAP-013`). **0 frozen documents modified, 0 `E-*` edges added, 0 ADRs written, 0 existing identifiers moved or renamed, 0 aggregates, 0 events. Stage 2 only; Stages 3–7 NOT begun.** ⚠ **The recount also caught a defect this very pass introduced**: the new `FIL-AC-062` incidentally covered `FIL-BR-009`, and `FIL-XC-008` was already covered, so §14.3's uncovered list was stale — corrected to 17 uncovered exclusions and 21 remaining, proving **a coverage list must be recounted after every addition, not carried forward.** **Verified after correction: 232 identifiers defined, 232 cited, 0 dangling, 0 duplicate definitions, all 8 ranges contiguous from 001, every declared §0.2 count equal to its measured definition count, 0 missing acceptance criteria among new requirements, and 0 V1/V2 contradictions.** `DRAFT` — confers nothing on itself |
