<!-- LIBOORA Design Documentation Foundation | 2026-09-09 -->

> This document is design governance and documentation. It does not amend product requirements, architecture decisions, bounded-context ownership, permissions, or backend contracts.
# LIBOORA Visual Language

| Field | Value |
|---|---|
| Status | PROPOSED — visual language for approval |
| Owner | UI/Visual Design Owner |
| Direction | CONFIRMED — lightweight premium 2.5D |

## 1. Visual ratio

- **About 70% clean 2D:** typography, surfaces, cards, lists, controls, and direct information hierarchy.
- **About 20% subtle depth:** restrained elevation, grouped surfaces, soft but readable separation, and focused emphasis.
- **About 10% premium 3D-style illustration:** selected brand, onboarding, education, or empty-state moments only.

These percentages are a visual decision, not a measurement requirement. **Status: CONFIRMED direction; exact implementation mix is RECOMMENDED.**

## 2. Premium without weight

Premium expression comes from proportion, whitespace, typographic confidence, image quality, consistent alignment, and calm feedback. Do not use WebGL, heavy 3D scenes, pervasive glass, or animation to manufacture premium feel. **Status: CONFIRMED exclusions.**

## 3. Color

Use semantic color roles with a high-contrast text pair, visible focus, and non-color state cues. Exact palette and contrast tokens are **TO BE DECIDED** in the Figma foundation and accessibility review.

## 4. Typography

Use a readable family with clear hierarchy and stable wrapping on small screens. Avoid overly compressed display faces for operational content. Exact family, weights, and type scale are **TO BE DECIDED**.

## 5. Depth

Elevation communicates relationship and priority. Use a small, consistent elevation scale. Avoid shadows that reduce edge clarity or create false affordances. **Status: RECOMMENDED.**

## 6. Illustration and iconography

Illustrations must support comprehension or brand trust and remain optional for task completion. Icons must be simple, recognizable, and paired with labels when meaning is not universal. **Status: RECOMMENDED.**

## 7. Motion

Motion should explain change, preserve orientation, and yield to reduced-motion settings. No essential state may depend on animation. **Status: RECOMMENDED.**
