<!-- LIBOORA Design Documentation Foundation | 2026-09-09 -->

> This document is design governance and documentation. It does not amend product requirements, architecture decisions, bounded-context ownership, permissions, or backend contracts.
# LIBOORA Design Ownership

| Field | Value |
|---|---|
| Status | PROPOSED — role model pending Founder/Product Authority approval |
| Naming rule | INHERITED — roles, not personal names |
| Ownership rule | INHERITED — design ownership cannot override PRD, architecture, BC, permission, or backend ownership |

## 1. Ownership model

This model is equivalent in form to the repository PRD ownership model: every design responsibility has one accountable owner, explicit authority, boundaries, approval evidence, and an escalation path. A role may consult others, but consultation does not transfer accountability.

| Role | Responsibility | Authority | Boundary | Approval | Escalation |
|---|---|---|---|---|---|
| Design Vision Owner | Maintains the experience direction and visual north star | Proposes experience direction and rejects drift | Cannot change product scope or source authority | Founder/Product Authority | Design Governance Owner, then Founder/Product Authority |
| Design Governance Owner | Owns design governance, gates, status vocabulary, and decision hygiene | Enforces design process and records | Cannot amend PRDs or ADRs | Founder/Product Authority for model; governance record for process | Founder/Product Authority or Architecture Owner by issue |
| UX Architecture Owner | Owns task structure, journeys, and interaction architecture | Approves UX architecture artifacts | Cannot invent capability or role | Design Governance Owner; product decisions to Founder/Product Authority | Product or Architecture authority |
| Information Architecture Owner | Owns content grouping, labels, hierarchy, and findability | Approves IA and navigation structure | Cannot create a new domain or duplicate system | UX Architecture Owner | UX Architecture Owner, then Founder/Product Authority |
| Design System Owner | Owns tokens, foundations, usage rules, and library health | Approves system primitives and composition rules | Cannot dictate backend contracts | Design Governance Owner | Component Architecture Owner or Accessibility Owner |
| UI/Visual Design Owner | Owns visual expression, composition, and illustration use | Approves visual direction within foundation | Cannot turn decoration into product behavior | Design Vision Owner | Design Vision Owner, then Founder/Product Authority |
| Component Architecture Owner | Owns component taxonomy, states, APIs as design contracts, and composition | Approves reusable component architecture | Does not own software implementation or domain behavior | Design System Owner and Design–Engineering Handoff Owner | Engineering counterpart through handoff owner |
| Accessibility Owner | Owns accessibility criteria, review, and exception records | Can block design approval for unresolved accessibility risk | Cannot waive legal or product obligations; cannot invent permissions | Design QA Owner and Design Governance Owner | Founder/Product Authority for product trade-offs |
| Responsive Design Owner | Owns breakpoint behavior, layout adaptation, and device-mode rules | Approves responsive specifications | Cannot assume device capabilities or network behavior not sourced | UX Architecture Owner | Design Governance Owner |
| Design Performance Owner | Owns design-side weight, asset, motion, and perceived-performance guidance | Can require lighter assets or states | Cannot set backend SLOs or claim measured performance | Design Governance Owner with Engineering input | Engineering authority for implementation limits |
| Figma Design Owner | Owns the canonical Figma file, pages, libraries, branches, and publish discipline | Controls canonical design artifact hygiene | Cannot approve business decisions | Design System Owner and Design Governance Owner | Design Governance Owner |
| Design QA Owner | Owns design acceptance checks and evidence | Can return work for correction | Cannot approve unreconciled source conflict | Design Governance Owner | Accessibility, Performance, or Engineering owner as applicable |
| Design–Engineering Handoff Owner | Owns delivery package, annotations, states, assets, and open questions | Declares handoff ready | Cannot sign off implementation behavior beyond design evidence | Design QA Owner and engineering counterpart | Architecture or Product authority by issue |
| PRD→Design Traceability Owner | Owns requirement-to-design mapping and source freshness | Can reject untraceable design claims | Cannot reinterpret frozen requirements | Design Governance Owner | Source owner; Founder/Product Authority for product ambiguity |
| Design Documentation Owner | Owns this documentation set, links, index, and audit record | Can update design docs under change control | Cannot silently update frozen source | Design Governance Owner | Design Governance Owner, then source authority |

## 2. Separation of powers

The author, reviewer, implementation mechanism, and final business authority are separate by design. AI may draft or validate. Figma MCP may implement. None of them is final business authority.

## 3. Approval evidence

An approval must name the artifact, version, decision status, approver role, date, and unresolved conditions. A comment such as “looks good” is not sufficient approval evidence.
