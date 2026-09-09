<!-- LIBOORA Design Documentation Foundation | 2026-09-09 -->

> This document is design governance and documentation. It does not amend product requirements, architecture decisions, bounded-context ownership, permissions, or backend contracts.
# LIBOORA Design Change Management

| Field | Value |
|---|---|
| Status | PROPOSED — change and versioning model |
| Owner | Design Governance Owner |
| Rule | Design change is not permission to edit frozen source |

## 1. Change classes

| Class | Example | Status treatment | Required path |
|---|---|---|---|
| D1 Clarification | Copy, alignment, or visual correction with no behavioral impact | RECOMMENDED or APPROVED | Design owner review and changelog |
| D2 Design-system change | New token, component variant, or state | PROPOSED until approved | Design System Owner, accessibility/performance review, version update |
| D3 Experience change | Flow, navigation, screen, or interaction behavior changes | PROPOSED | Traceability update, product review, Founder/Product Authority if scope changes |
| D4 Source conflict | Design conflicts with PRD, ADR, architecture, or ownership | CONFLICT | Stop affected design, record source paths, escalate; do not edit source |
| D5 Product or architecture change | Requirement, permission, BC ownership, backend, or contract change | TO BE DECIDED | Use existing PRD/architecture governance; design follows the result |

## 2. Versioning

Design foundation documents use semantic intent: major for a changed approved foundation or governance model, minor for an additive approved capability within existing authority, patch for corrections and links. Exact repository release numbering is **TO BE DECIDED** by Design Governance Owner.

Figma versions identify date, artifact, source baseline, reviewer, and approval status. Drafts cannot be presented as approved.

## 3. Frozen-source guardrail

A request to correct, clarify, or align a frozen PRD or ADR is recorded in design as a source issue and routed to its owner. Design files may cite the discrepancy and design a safe placeholder or blocked state; they may not silently change the frozen file.

## 4. Approval record

Every approved change records: change ID, artifact and version, reason, source references, affected flows and components, owner, approver role, decision status, date, QA evidence, and unresolved follow-up.

## 5. Rollback

Figma branches and repository commits remain recoverable. If a change creates source conflict or accessibility/performance regression, revert the design artifact and retain the decision record explaining why.
