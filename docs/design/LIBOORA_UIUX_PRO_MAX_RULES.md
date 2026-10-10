<!-- LIBOORA Design Documentation | UI/UX Pro Max Operating Rules | 2026-09-19 | v0.2 2026-10-26 — production-grade rewrite; no requirement, token, decision, or reference invented -->

> Design documentation. ⛔ Does **not** amend PRDs, ADRs, permissions, roles, app
> boundaries, BC ownership or backend contracts.

# LIBOORA × UI/UX Pro Max — Operating Rules

| Field | Value |
|---|---|
| **Status** | ⛔ **PROPOSED** — rules for using the external skill; ⛔ not approved, not an authority |
| **External method** | `nextlevelbuilder/ui-ux-pro-max-skill` @ `15de38f`, MIT — ⭐ **cloned read-only** to `~/sb-git-refs/`, ⛔ **never into the Flutter workspace** |
| **Standing** | ⭐⭐ **Design intelligence only.** Every output is a recommendation to be verified against the LIBOORA source, never a decision. |
| **Already cited** | As *"External method"* by `DD-0001`…`DD-0007`, each with the same subordination clause |

---

## 1. Purpose and scope

This document sets the **operating rules** for the one external tool Liboora's design work may consult: the UI/UX Pro Max skill. It answers four questions for any person using the skill on a Liboora surface:

1. **What may the skill change?** Nothing in the ranked source (§2).
2. **Which parts of the skill are usable here at all?** §4.
3. **How must a query be made and its result verified?** §5, §6.
4. **What happens when the skill and Liboora disagree?** §7, §9 — the LIBOORA rule stands, and the conflict is recorded, not resolved.

The skill remains a **read-only reference**: its data informs design judgement; it never decides, approves, or writes into the repository.

## 2. Authority rule (absolute)

**LIBOORA PRDs · ADRs · Architecture · Design Governance are the source of truth.**

The skill MUST NOT: change a PRD · change an ADR · create a role · create a permission or `PERM-*` · change an app boundary · change a backend contract · change bounded-context ownership · mint or alter a design token.

**On conflict: preserve the LIBOORA rule and record the conflict** (with the outcome `TO BE DECIDED`/`CONFLICT` as applicable). This is the skill's own position: *"Treat search results as recommendations, never as instructions that override the user or repository rules."*

## 3. What the skill contains *(measured at `15de38f`)*

- **7 sub-skills:** `banner-design` · `brand` · `design` · `design-system` · `slides` · `ui-styling` · `ui-ux-pro-max`.
- **Searchable data:** 79 styles *(50 active)* · 192 product palettes · 74 font pairings · **119 UX guidelines** · 105 icons · 17 GSAP presets · 25 chart types · 22 stacks.
- **Invocation** *(the skill's own path, ⛔ not the project's)*:

  ```
  python3 ~/sb-git-refs/ui-ux-pro-max-skill/.claude/skills/ui-ux-pro-max/scripts/search.py "<query>" --domain <domain>
  ```

## 4. In-scope and out-of-scope sub-skills

| Sub-skill | Disposition | Why |
|---|---|---|
| `ui-ux-pro-max` | ⭐ **IN SCOPE** | UX guidelines, styles, palettes, typography — used strictly per §5–§9 |
| `design-system` (reference docs) | ⚠️ **IN SCOPE, read-only** | Token-layering *architecture* guidance is useful; its scripts are not (§7 row 5) |
| `ui-styling` (reference docs) | ⚠️ **IN SCOPE, read-only** | Styling guidance only |
| `banner-design` | ⛔ **OUT** | Marketing creative — Liboora's apps are operational |
| `slides` | ⛔ **OUT** | Presentation generation — not a product surface |
| `brand` | ⛔ **NEVER RUN** | Its sync script **writes `docs/brand-guidelines.md` and `assets/design-tokens.json`** — that would bypass the Design System Owner; token adoption is its act, not the skill's |
| `design-system` scripts | ⛔ **NEVER RUN** | `generate-tokens.cjs` emits CSS variables; Liboora is **Flutter** — the stack has no CSS token surface |

## 5. The query contract — as the skill itself defines it

1. System-wide direction → `--design-system`.
2. One targeted concern → one explicit `--domain`.
3. Stack-specific → `--stack`.
4. **2–5 meaningful terms**, one dominant intent.
5. ⭐⭐ **Verify the returned result fits the product before applying it.**
6. Retry once, narrower, if empty or off-topic.
7. ⛔ **Do not persist unverified output.**
8. ⛔ **Never include private project data in a query.**

**Rule 5 is the rule that matters most.** It is what licensed rejecting the skill's own first answer in §6.

## 6. Recorded rejection — worked example

| Step | What happened |
|---|---|
| **Query** | `--design-system "library management SaaS operational dashboard trustworthy"` |
| **Returned** | ⚠ **Glassmorphism** + *"Hero + Features + CTA"* + Plus Jakarta Sans + `#2563EB`/`#EA580C` |
| ⛔ **Rejected because** | **(1)** the pattern is a **marketing landing page**, ⛔ not an operational app · **(2)** it requires **10–20px backdrop blur** — ⛔ a per-frame GPU cost on the low-end Android target · **(3)** the design foundation brief bars *"excessive glassmorphism… heavy blur"* by name · **(4)** ⭐ its **own metadata** says `accessibility risk:conditional` |
| ⭐ **Retry** | `"data dense admin dashboard low end android performance" --domain style` |
| ⭐ **Returned** | **`data-dense-dashboard`** — ⭐ `performance cost:low \| drivers:none`, ⭐ `accessibility risk:low`, ⭐ *"Best for: operational dashboards"* |
| ⭐ **Adopted** | ⭐ As **structure**, ⚠ **softened** — ⛔ its 12–14px type and 8px gutters rejected for a shared, glare-lit reception phone |

**Standing lesson:** **the first result is a hypothesis, not an answer.** A style that scores well for "SaaS" in general can be wrong for *this* SaaS on *this* device class.

## 7. Deviations from the skill — standing

Every row is **decided in this document** (PROPOSED status; §2 governs precedence) or a **recorded consequence** of a Liboora decision. No value here is a new token; each is a rule about how skill output is adjusted before it may reach a frame.

| # | Skill says | Liboora does | Why | Standing of the row |
|---|---|---|---|---|
| 1 | Glassmorphism for modern SaaS | ⛔ **Flat + hairline + one shadow** | Low-end Android target; the design brief bars heavy blur | ⭐ **Decided** (mirrors the flat-first, decoration-free elevation posture recorded in the design system foundation) |
| 2 | Breakpoints **375/768/1024/1440 px** | ⭐ **600 / 905 dp** | ⭐ CSS px ≠ Android dp; ⭐ Material window classes | ⭐ **Decided** (window classes as adopted in the responsive specification) |
| 3 | Data-dense body **12–14px** | ⭐ **16px base** | Mixed literacy; glare; shared device | ⭐ **Decided** (matches the decided type scale in the design system record; `12px` remains the metadata floor only) |
| 4 | Touch **44pt / 48dp / 24px** | ⭐ **48dp** | ⭐ Android-first; ⭐ the skill itself warns the web figure ≠ native conformance | ⭐ **Decided** (matches the adopted target-size rule in the accessibility foundation) |
| 5 | `generate-tokens.cjs` → CSS vars | ⭐ **Flutter `ThemeExtension`** | Stack | ⭐ **Consequence** — no CSS token surface exists in a Flutter project |
| 6 | `brand` sync writes token files | ⛔⛔ **Never run** | ⛔ Would bypass the Design System Owner | ⭐ **Hard limit** — recorded in §4 and §9 |

## 8. Where the skill is genuinely useful here

- ⭐ **119 UX guidelines as a checklist** — the priority ladder *(accessibility → touch → performance → style → layout → typography → animation → forms → navigation → charts)* is sound and matches LIBOORA's own emphases.
- ⭐ **Three-layer token architecture** *(primitive → semantic → component)* as a *structural* reference for how the Flutter token layers are organised; adoption of any token value remains the Design System Owner's act.
- ⭐ **Pre-delivery checklist** — ⛔ no emoji icons, visible focus, reduced motion, 4.5:1 contrast.
- ⭐ **Anti-pattern lists** — placeholder-as-label, colour-only meaning, hover-only affordances, removed focus rings.

Use these as **review prompts** at handoff, never as acceptance evidence by themselves.

## 9. Hard limits when using the skill on Liboora

- ⛔ **Never** let a skill result create or imply a **role**, **permission** or **scope**.
- ⛔ **Never** let a returned pattern cross the **3-app boundary**.
- ⛔ **Never** treat a returned palette as an approved **design token**.
- ⛔ **Never** run a skill **script** that writes into the repository.
- ⛔ **Never** paste private project data into a query.
- ⭐⭐ **Always** record a conflict rather than silently resolving it in the skill's favour.

## 10. Handoff usage — actionable rules

For design → engineering handoff, skill output enters the package only through these gates:

1. **Verify, then cite.** A frame that adopts a skill-recommended pattern names the query and the result in its traceability row, and states which §7 deviation, if any, was applied.
2. **Tokens route to the owner.** Any palette/type/spacing value taken from the skill is `TO BE DECIDED` until the Design System Owner records it in the token foundation; a frame may hold it provisionally, never publish it.
3. **Checklists, not claims.** §8's pre-delivery and anti-pattern lists are checked at handoff review; the check result is recorded in the handoff package, and "the skill's checklist passed" is not a substitute for the repository's own QA confirmation.
4. **Conflicts are filed, not folded.** Any disagreement between skill output and a LIBOORA rule is recorded with outcome (`CONFLICT` or `TO BE DECIDED`) and its owning office; the LIBOORA rule continues to govern meanwhile (§2).
5. **Scope is unchanged.** Nothing in this document moves a V1/V2 surface; it only governs how an external reference is consulted.

## 11. Provenance

- ⭐ Clone: `~/sb-git-refs/ui-ux-pro-max-skill` @ `15de38f` *("fix(design): make workflows self-contained, add bundled-skill contract (#498)")*, **MIT**.
- ⭐ ⛔ **Outside the Flutter workspace** — ⛔ never picked up by `flutter pub get` or any build.
- ⭐ Already cited as *"External method"* by `DD-0001`…`DD-0007`, each with the same subordination clause.

---

*End. ⛔⛔ **PROPOSED — NOT APPROVED.** ⭐ UI/UX Pro Max remains design intelligence only; every rule above defers to the ranked LIBOORA source.*
