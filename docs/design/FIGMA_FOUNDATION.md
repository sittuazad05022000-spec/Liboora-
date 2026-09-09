<!-- LIBOORA Design Documentation Foundation | 2026-09-09 -->

> This document is design governance and documentation. It does not amend product requirements, architecture decisions, bounded-context ownership, permissions, or backend contracts.
# LIBOORA Figma Foundation

| Field | Value |
|---|---|
| Status | PROPOSED — Figma operating model |
| Owner | Figma Design Owner |
| Mechanism | CONFIRMED — Figma MCP implements approved design artifacts |

## 1. File structure

Recommended pages: Cover and Governance, Foundations, Components, Patterns, Library Discovery, Operations, Community Exploration, Handoff, Archive. Page names are **RECOMMENDED** until the Figma Design Owner publishes the canonical file.

## 2. Naming

Use stable, searchable names: Foundation / Token / Category / Name; Component / Category / Name; Pattern / Journey / Name; Screen / Surface / State. Names must not imply a backend owner or permission that the source does not define.

## 3. Libraries

Foundations publish before components. Components publish before patterns. Patterns publish before screens. Figma Design Owner controls publishing; Design System Owner approves system changes; Accessibility Owner reviews accessibility-sensitive components.

## 4. Component anatomy

Each component includes default, hover or focus where applicable, pressed, disabled or unavailable where applicable, loading, empty, error, offline or stale states where relevant, mobile and larger-width variants, content-length examples, and accessibility annotations.

## 5. Variables and tokens

Use semantic variables for color, type, spacing, radius, elevation, motion, and breakpoints. Exact token names and values are **TO BE DECIDED** in the canonical Figma file. Do not hard-code page-specific values when a semantic token is appropriate.

## 6. Figma to engineering

A handoff frame links to the design traceability row, identifies source-backed behavior, shows states and responsive variants, and lists unresolved questions. Figma is the implementation mechanism for design artifacts, not the authority for PRDs, ADRs, or backend contracts.
