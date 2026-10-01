<!-- LIBOORA Design Documentation Foundation | 2026-09-09 -->

> This document is design governance and documentation. It does not amend product requirements, architecture decisions, bounded-context ownership, permissions, or backend contracts.
# LIBOORA Design Performance

| Field | Value |
|---|---|
| Status | RECOMMENDED — design-side performance guidance; numeric budgets are TO BE DECIDED |
| Owner | Design Performance Owner |
| Constraints | CONFIRMED — low-end Android, low/intermittent network, mobile-first · ⭐ **Official V1 target device profile confirmed by the Technical Owner** at [`design-decisions/DDR-0034-cp-a-v1-device-profile-confirmed-by-technical-owner.md`](design-decisions/DDR-0034-cp-a-v1-device-profile-confirmed-by-technical-owner.md) (2026-10-01) — Android 8.0 / API 26 · 2 GB + 720×1600 reference class · intermittent/degraded connectivity, primarily 4G · ⛔ numeric SLOs remain `TO BE DECIDED` (`NFR Budgets (V1)` is a separate act) |

## 1. Performance posture

Design should remain useful before every remote asset, secondary detail, or nonessential enhancement is available. The primary task must not depend on a large illustration, animation, blur layer, or high-bandwidth media.

## 2. Asset rules

- Prefer SVG or appropriately compressed raster assets.
- Use one illustration only when it earns comprehension or brand value.
- Lazy-load below-the-fold and nonessential media.
- Provide stable placeholders that do not cause layout shift.
- Avoid full-screen video, heavy 3D, WebGL, and large decorative backgrounds.
- Keep icon and component assets reusable rather than duplicating near-identical files.

## 3. Network and state rules

Every remote-dependent surface specifies loading, timeout or failure presentation where the source contract exposes it, stale-data handling, offline handling, retry behavior, and whether previously loaded content can remain useful. Design does not invent cache semantics or offline writes.

## 4. Motion and effects

Use short transitions and transform/opacity-friendly effects. Treat blur, backdrop filters, continuous animation, parallax, and particle effects as exceptions requiring explicit justification. **Status: RECOMMENDED.**

## 5. Budgets

Numeric limits for image weight, font weight, animation duration, screen payload, and time-to-interactive are **TO BE DECIDED** with Engineering. Until then, Design Performance Owner may reject an asset or effect that is plainly disproportionate to the task.
