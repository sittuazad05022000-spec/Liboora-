# Risk Report — Student Identity Migration

| Field | Value |
|---|---|
| **Document** | Risk Report |
| **Version** | v1.0 |
| **Status** | Active — reassess when any `ADR-0012` wave closes or `TASK-D10` lands |
| **Date** | 2026-08-04 |
| **Scope** | Risks introduced, changed, or newly *revealed* by the `ADR-0011` code migration and by `IMPL-014` |
| **Companions** | [Migration Report](./ARCHITECTURE_MIGRATION_REPORT.md) · [Migration Checklist](./STUDENT_IDENTITY_MIGRATION_CHECKLIST.md) · [Validation Report](./STUDENT_IDENTITY_VALIDATION_REPORT.md) |

---

## 1. Scoring

| Likelihood | Impact | Severity = L × I |
|---|---|---|
| `3` Likely · `2` Possible · `1` Unlikely | `3` Release-blocking or data-integrity · `2` Structural decay · `1` Friction | `6–9` **High** · `3–4` **Medium** · `1–2` **Low** |

A risk is only closed when a **mechanism** closes it. "The team will remember" is not a mechanism; that is
the lesson `SID-4.56` encodes and this report applies to itself.

---

## 2. Risk register

### `RSK-01` — The nine unwaived findings are mistaken for a broken build

| | |
|---|---|
| **Severity** | **High (6)** — L3 × I2 |
| **Description** | Gate 3 exits 1. A future engineer under time pressure sees red, assumes the checker is misconfigured, and "fixes" it by adding an exception for `app → domain/library` or by relaxing the barrel rule |
| **Why likely** | This is the single most attractive shortcut in the repository. It converts a red pipeline to green in four lines of YAML, and the change would look like housekeeping in review |
| **Consequence** | A P0 release blocker (`TASK-D10`) becomes untracked debt with a 2027 expiry. The demo surfaces then ship |
| **Mitigation in place** | Recorded in **three** documents (`ADR-0012` §3.4, Plan `MIG-15`, Checker Design §6). A **test** asserts the edge is *not* waived: `app -> domain/library is deliberately NOT waived` — adding the exception turns the test suite red, so the shortcut is not silent |
| **Residual** | **Low.** A dedicated failing test is the strongest available guard short of closing `TASK-D10` |
| **Closes when** | `TASK-D10` removes the demo surfaces. Gate 3 then goes green with no manifest change |

### `RSK-02` — Waves expire and the exceptions are extended rather than paid

| | |
|---|---|
| **Severity** | **High (6)** — L2 × I3 |
| **Description** | The first wave expires **2026-10-31**. The cheapest response is to edit the date |
| **Consequence** | `ADR-0012` becomes a permanent waiver. The Matrix §11 promise — *"debt is time-boxed by the tooling, not by good intentions"* — is broken, and the pattern legitimises indefinite extension |
| **Mitigation in place** | Expiry is enforced by the tool, not by a calendar reminder: an expired exception stops waiving and the build fails. Verified by mutation (expiring all dates moved 9 → 14 blocking). A missing or unparseable date counts as **expired**, so the field cannot be quietly dropped. Extension requires editing a committed manifest under a named ADR — visible in review |
| **Residual** | **Medium.** The tool forces the *conversation* on the date; it cannot force the *answer*. This is a governance limit, not a tooling one |
| **Recommendation** | Treat any wave extension as requiring a **new ADR**, not an edit to `ADR-0012`. Matrix §11 step 2 already implies this; stating it here removes the ambiguity |

### `RSK-03` — Two specified checks are absent and could be assumed present

| | |
|---|---|
| **Severity** | **Medium (4)** — L2 × I2 |
| **Description** | Matrix §10.2 lists nine checks. The **tenant-key** (`X-13`) and **audit-mutation** (`X-10`) checks are **not implemented**. Ten categories *are* enforced, which invites the inference that coverage is complete |
| **Consequence** | A cross-tenant query or a mutated audit entry passes CI. `X-13` is a multi-tenant data-isolation rule — the highest-impact class of defect in this product |
| **Mitigation in place** | Recorded explicitly in Checker Design §7 with the exact wording that they *"must not be presumed enforced — by `SID-4.56` they remain unmet."* Partial cover from the tenant-isolation tests in `widget_test.dart` (behavioural, not structural) |
| **Residual** | **Medium.** Honest documentation reduces false confidence; it does not enforce the rule |
| **Recommendation** | Raise as a tracked implementation item. `X-13` should precede any persistent datastore work, because retrofitting tenant-key enforcement over existing queries is materially harder than enforcing it from the start |

### `RSK-04` — Line-based parsing misjudges an import

| | |
|---|---|
| **Severity** | **Medium (3)** — L3 × I1 |
| **Description** | The checker parses import lines textually rather than using the analyzer. A commented-out or conditional import could in principle be miscounted |
| **Why accepted** | Deliberate, and recorded in Checker Design §2: the checker must run **when resolution is broken**, which is exactly when boundary feedback matters most. An analyzer-based checker cannot run on a tree that does not resolve |
| **Consequence if it misfires** | A **false positive** — a finding that is not real. Noisy, not dangerous: it fails closed |
| **Mitigation in place** | Findings carry file **and line number**, so any false positive is disproved in seconds. Zero false positives observed across 38 findings, each traced to a real import |
| **Residual** | **Low.** Failing closed on an ambiguous line is the correct bias for a governance tool |

### `RSK-05` — The false-green class of test failure

| | |
|---|---|
| **Severity** | **Medium (4)** — L2 × I2 |
| **Description** | Breaking the `L1` cycle made seeding an **optional** parameter. Eleven call sites relied on implicit seeding; left unchanged they would have booted an **empty** container and still passed |
| **Status** | **Closed for the known instances** — all 11 sites updated explicitly and the suite re-run (71/71) |
| **Residual risk** | The *pattern* persists: `boot()` with no seeder is legal, so a future test can be written that silently asserts nothing |
| **Residual** | **Medium.** A structural hazard, not a present defect |
| **Recommendation** | Any new test that boots a container must pass a seeder explicitly. Worth adding to `DEFINITION_OF_DONE.md` when that document is next revised — a test that passes against an empty container is worse than no test, because it reports success |

### `RSK-06` — In-memory stores defer a real schema migration

| | |
|---|---|
| **Severity** | **Medium (4)** — L2 × I2 |
| **Description** | Item 13 (migrations) was correctly **N/A**: every repository is in-memory. When persistence arrives, making `personId` non-nullable becomes a genuine schema migration with backfill and a nullable-window problem |
| **Consequence** | The migration that was free today is not free later, and the constraint (`NOT NULL`) is the part most likely to be omitted under delivery pressure |
| **Mitigation in place** | The invariant is enforced in the **domain** (`required`, non-nullable, `final`) and asserted by conformance tests, so persistence cannot silently reintroduce a null without failing a test on read-back |
| **Residual** | **Medium** until a datastore exists |
| **Recommendation** | The first persistence task must carry `NOT NULL` on both `personId` columns and a uniqueness constraint expressing `SID-INV-1`. Recorded here so the requirement is not rediscovered by incident |

### `RSK-07` — GitHub backup is not current — ✅ **CLOSED 2026-08-04**

| | |
|---|---|
| **Severity when open** | **Medium (4)** — L2 × I2 |
| **Description** | `github/main` was at `38f6ab9`. The migration commit `a22fd7e` and the documentation pack existed **only in the sandbox**. Authentication failed: `remote: Invalid username or token`, `curl api.github.com/user` → **401**, `~/.git-credentials` was **0 bytes** |
| **Consequence** | Loss of the sandbox would have lost the migration |
| **Mitigation while open** | Work was committed locally, so it was recoverable within the sandbox lifetime. Reported rather than silently retried |
| **Resolution** | Authorization restored and verified (credential store 0 → 75 bytes; API 401 → **200**). Divergence measured first — local 3 ahead, remote 0 ahead — so a fast-forward `git push github main` was correct and **no history was rewritten**. Pushed `38f6ab9..011db0c` |
| **Verified by** | GitHub API `git/ref/heads/main` returns `011db0c1b7b4aba6336f9b4b32e4f7b00fa65fa3`, identical to local `HEAD`; post-push divergence is **0 / 0**; four files including a frozen PRD return HTTP 200 by content API, confirming the tree and not merely the ref. Deliberately **not** verified by the push command's own exit code |
| **Residual** | **None** for this migration. The general risk recurs for any future commit not yet pushed |

### `RSK-08` — Rank 7.5 invites further fractional ranks

| | |
|---|---|
| **Severity** | **Low (2)** — L2 × I1 |
| **Description** | `domain/person: 7.5` parses as a float. Nothing prevents `7.75` when the next placement argument arises |
| **Consequence** | Rank ordering degrades into an unreadable real-number line, and "which rank does this belong at?" stops having a principled answer |
| **Mitigation in place** | `ADR-0011` justifies 7.5 from the *domain* — identity is consumed by every library context and consumes none of them. It is a position, not a convenience |
| **Residual** | **Low** |
| **Recommendation** | A new fractional rank should require an ADR that argues the *domain* position, exactly as `ADR-0011` did |

### `RSK-09` — Documentation drift about `IMPL-014`

| | |
|---|---|
| **Severity** | **Low (2)** — L2 × I1 |
| **Description** | Ten statements across seven documents assert the checker *"does not exist"* and that boundaries are *"unenforced"*. Those statements were true at `9f15750` and are now false |
| **Consequence** | A reader concludes boundaries are unenforced and skips the gate, or wastes time implementing a tool that exists |
| **Status** | Corrected in Phase 6 of this migration — see the [Implementation Status](./IMPLEMENTATION_STATUS.md) record |
| **Mitigation** | Found by **mechanical** cross-reference validation, not by reading. The same script can be re-run |
| **Residual** | **Low** |

---

## 3. Risks explicitly **not** on this register

Recording these prevents a future reader assuming they were missed.

| Candidate | Why it is not a risk |
|---|---|
| "The rank-4 → rank-7.5 call breaks `L2`" | It does not. `AuthService` depends on a **rank-0** interface; the implementation is injected at the composition root. Verified: **0** checker findings name `domain/person` |
| "Making identity mandatory breaks walk-in enrollment" | Handled by `provisionIdentityForEnrollment`: an identity is minted, but the account is role-less and unverified and **grants no session** until claimed (`AUTH-4.23`…`AUTH-4.28`). Asserted by test |
| "Removing `GlobalStudentProfile` loses social data" | `SocialPresence` retains social state keyed by `PersonId`. What was removed is the **duplication** of identity fields, which `SID-BR-11` and `SID-4.53` forbid |
| "`personId` in events would be useful" | It would also permit a cross-tenant join answering *"which libraries does this person attend?"* — forbidden by `SID-4.19`. Closed as no-change (`MIG-17`) |
| "Re-keying the four contexts on `PersonId` is cleaner" | `SID-4.23` forbids it. It would also break per-tenant isolation |

---

## 4. Summary

| Severity | Open | Closed | IDs |
|---|---|---|---|
| **High** | 2 | — | `RSK-01`, `RSK-02` |
| **Medium** | 4 | 1 | `RSK-03`, `RSK-04`, `RSK-05`, `RSK-06` · closed: `RSK-07` |
| **Low** | 2 | — | `RSK-08`, `RSK-09` |

**8 open, 1 closed.**

**Both High risks are governance risks, not correctness risks.** No risk on this register threatens the
correctness of the migrated identity model — that is guarded by the compiler (non-nullable, `final`, `required`),
by 14 conformance tests, and by a boundary checker reporting zero findings against `domain/person`.

Every remaining High and Medium risk is either enforced by tooling (`RSK-01`, `RSK-02`), documented as explicitly
unmet (`RSK-03`), fails closed (`RSK-04`), closed for known instances (`RSK-05`), or guarded at the domain layer
(`RSK-06`). `RSK-07` was outside my control and reported rather than concealed; it has since been **closed** by
restored authorization and a push verified against the remote API.

The two High risks are unchanged by the push. Getting the work off the sandbox removes a *loss* risk; it does
nothing about debt waves being extended rather than paid (`RSK-02`), which is the risk most likely to outlive
this migration.

---

## 5. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-04 | Created alongside the `ADR-0011` code migration. Nine risks registered; five candidate risks explicitly excluded with reasons. `RSK-07` records the GitHub authentication failure as an open, unresolved blocker rather than a completed push. |
| v1.1 | 2026-08-04 | `RSK-07` **closed** — authorization restored and verified, `main` fast-forwarded `38f6ab9..011db0c`, push confirmed via the GitHub API rather than the push command's exit code. The original failure is retained in the entry as history. Register now 8 open / 1 closed; both High risks unchanged. |
