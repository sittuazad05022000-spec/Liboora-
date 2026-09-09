<!-- LIBOORA Design Documentation Foundation | 2026-09-09 -->

> This document is design governance and documentation. It does not amend product requirements, architecture decisions, bounded-context ownership, permissions, or backend contracts.
# LIBOORA UX Architecture

| Field | Value |
|---|---|
| Status | PROPOSED — experience architecture for review |
| Owner | UX Architecture Owner |
| Product source | FROZEN / INHERITED PRDs and accepted ADRs |

## 1. UX architecture rules

- **INHERITED:** the interface reflects existing actor and domain boundaries; it does not create new roles or permissions.
- **RECOMMENDED:** one primary task per surface, with the current status and next action visible before secondary detail.
- **RECOMMENDED:** compose information from the existing owning capability rather than reproducing it in another surface.
- **TO BE DECIDED:** exact product navigation labels and account-level entry points where the applicable PRD does not settle them.

## 2. Library Search First

**CONFIRMED:** Search or Nearby → Library Profile → Availability → Shift or Seat → Booking.

| Step | UX purpose | Ownership guardrail |
|---|---|---|
| Search or Nearby | Help a prospective student find a library using the existing discovery contract | C2 consumes BC-23; it does not create search, indexing, ranking, or a second marketplace. |
| Library Profile | Establish trust and show the library facts available to the public surface | C3 composes facts owned by existing contexts; it owns no field. |
| Availability | Make freshness and the available selection legible | Availability is displayed from source-owned data; design does not invent a real-time guarantee. |
| Shift or Seat | Make the existing choice understandable before initiation | Seat and booking ownership remain with the applicable frozen library/seat authority. |
| Booking | Present a clear initiation, confirmation, or failure state | No duplicate booking system, lock, quota, or reservation authority is introduced. |

## 3. Task architecture

The default surface hierarchy is: context → current state → primary action → supporting facts → recovery or secondary actions. Use progressive disclosure for operational detail. Do not hide a failure condition behind a decorative interaction.

## 4. Trust architecture

Where source data can change between read and action, the UI should communicate that the action is checked against current state. The final outcome comes from the owning system, not from a client-side promise.

## 5. Community boundary

**CONFLICT:** the repository baseline and ADR records mention PRD-021A baseline authority, while the A1 continuity artifact and Stage 7 blocker state that A1 remains draft/not frozen. Until governance reconciles that record, design treats community concepts as source-traceable exploration only and does not invent public visibility, participation, moderation, or permission behavior.
