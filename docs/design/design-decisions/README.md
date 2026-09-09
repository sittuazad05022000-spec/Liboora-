<!-- LIBOORA Design Documentation Foundation | 2026-09-09 -->

> This document is design governance and documentation. It does not amend product requirements, architecture decisions, bounded-context ownership, permissions, or backend contracts.
# LIBOORA Design Decision Records

| Field | Value |
|---|---|
| Status | PROPOSED — DDR register and template |
| Owner | Design Documentation Owner |
| Authority | Founder/Product Authority for product direction; applicable source owner for PRD or architecture matters |

## 1. Purpose

A Design Decision Record captures a durable design choice, its source, alternatives, consequence, ownership, and approval. It is not an ADR and cannot replace an ADR, PRD change, architecture ruling, or governance act.

## 2. Required template

Copy this structure for each approved or unresolved design decision:

### DDR-NNNN — Short title

| Field | Value |
|---|---|
| Status | PROPOSED / APPROVED / TO BE DECIDED / CONFLICT |
| Date | YYYY-MM-DD |
| Owner | Design role |
| Approver | Founder/Product Authority or applicable authority role |
| Scope | Artifact, journey, or component |
| Source references | Repository paths and section/line references where available |
| Decision | What design will do |
| Alternatives | Considered options and why not selected |
| Consequences | Experience, accessibility, performance, implementation, and governance impact |
| Open questions | Remaining issues and owners |
| Review trigger | What would cause reconsideration |

## 3. Register

No design decision has been marked APPROVED by this foundation alone. Initial entries remain in the foundation documents as PROPOSED, RECOMMENDED, INHERITED, TO BE DECIDED, or CONFLICT until the named authority approves them.

## 4. Filing rules

Use a stable numeric ID, never reuse an ID, keep one decision per record, link the affected design artifacts, and add the record to this register. Do not use a DDR to disguise a product or architecture decision.
