<!-- LIBOORA Design Documentation Foundation | 2026-09-09 -->

> This document is design governance and documentation. It does not amend product requirements, architecture decisions, bounded-context ownership, permissions, or backend contracts.
# LIBOORA Design Governance

| Field | Value |
|---|---|
| Status | PROPOSED — equivalent design governance model, pending Founder/Product Authority approval |
| Final authority | CONFIRMED — Founder/Product Authority |
| AI boundary | CONFIRMED — AI authors and reviews; AI is not final business authority |

## 1. Governance purpose

Design governance keeps experience decisions aligned with frozen product and architecture authority. It governs design artifacts and decisions; it does not replace PRD governance, architecture governance, or bounded-context ownership.

## 2. Decision status vocabulary

| Status | Meaning |
|---|---|
| FROZEN | Source requirement, ADR, architecture ruling, or baseline is immutable through design work. |
| CONFIRMED | Explicitly established by the design brief or verified repository fact. |
| INHERITED | Carried from an existing authoritative document. |
| APPROVED | Accepted by the Founder/Product Authority or the applicable repository authority. |
| RECOMMENDED | Design guidance with a clear rationale, not yet an approval. |
| PROPOSED | A design model or option awaiting approval. |
| TO BE DECIDED | Requires a named human authority or source update. |
| CONFLICT | Sources disagree; preserve both facts and escalate. |

## 3. Governance rules

1. FROZEN and INHERITED source material is cited, never rewritten in a design document.
2. A design artifact cannot grant a permission, create a role, name a backend, add a bounded context, or change BC ownership.
3. A design recommendation must identify its owner, rationale, status, and affected source references.
4. A CONFLICT is not closed by choosing the more convenient design.
5. Design approval does not approve a PRD, architecture decision, implementation, or release.
6. Founder/Product Authority is the final authority for business and product design direction.

## 4. Design gates

| Gate | Required evidence | Decision status | Approver / escalation |
|---|---|---|---|
| G0 Source audit | Relevant PRDs, freeze records, ADRs, architecture, and developer docs read | CONFIRMED | Design Documentation Owner; escalate source ambiguity to Design Governance Owner |
| G1 Experience architecture | Flows, IA, navigation, screen states, and traceability exist | PROPOSED | UX Architecture Owner; escalate scope conflict to Founder/Product Authority |
| G2 Foundation | Tokens, components, visual rules, accessibility, and performance guidance exist | PROPOSED | Design System Owner and Accessibility Owner |
| G3 Handoff | Annotated specs, states, responsive behavior, and trace links are complete | PROPOSED | Design–Engineering Handoff Owner |
| G4 Design QA | Evidence covers visual, interaction, accessibility, responsive, and constrained-network behavior | PROPOSED | Design QA Owner |
| G5 Change | Version, impact, decision record, and approvals are recorded | PROPOSED | Design Governance Owner |

## 5. AI governance

| Actor | Role | Authority boundary | Status |
|---|---|---|---|
| Opus 5 | Design Documentation Author | May draft, normalize, and cross-reference design documentation. Cannot approve business scope or resolve source conflicts. | CONFIRMED |
| GPT-5.6 Luna | Independent Reviewer / Validator | May identify omissions, contradictions, broken links, and traceability gaps. Cannot act as final authority. | CONFIRMED |
| Figma MCP | Design implementation mechanism | May implement approved design artifacts in Figma. Cannot change source requirements or governance. | CONFIRMED |
| Founder/Product Authority | Final product and business authority | Approves or rejects proposed design direction and resolves product decisions within authority. | CONFIRMED |

## 6. Escalation

Source contradiction → Design Documentation Owner records CONFLICT → Design Governance Owner checks precedence → Product or Architecture authority decides within its boundary → Founder/Product Authority decides unresolved product direction → design record is updated without editing frozen source.
