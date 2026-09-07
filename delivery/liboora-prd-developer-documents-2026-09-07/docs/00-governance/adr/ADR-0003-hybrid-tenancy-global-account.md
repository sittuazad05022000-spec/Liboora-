# ADR-0003 — Global account, tenant-scoped role assignment

| Field | Value |
|---|---|
| **Status** | Accepted |
| **Date** | 2026-08-02 |
| **Promotes** | Bounded Context Map §11 |
| **Scope** | `BC-18` Identity & Access, `BC-19` Tenancy |

## Context

A student may attend two study halls. A parent may have children at three. An owner may operate a chain
of branches. If identity were tenant-scoped, each of these people would hold several unrelated accounts,
each with its own mobile number registration, and would re-authenticate on every switch.

The opposing risk is that a shared identity becomes a shared exposure: one library learning about a
person's relationship with another would breach the core promise of a multi-tenant product.

## Decision

**The `Account` is global and cross-tenant. Role assignments are tenant-scoped.** Exactly one library is
active per session, and every tenant-scoped authorization decision is evaluated against that library
alone. Roles held elsewhere never influence a decision in the active library, and no interface, event or
error discloses that an account participates in any other library.

## Consequences

**Positive.** One registration per person. Switching libraries requires no re-authentication. Multi-library
participation is modelled directly rather than simulated by duplicate accounts. Account lifecycle
(suspension, deletion, number change) applies once, globally, which is the correct semantics for an
identity concern.

**Negative.** Tenant isolation must be enforced at every authorization decision rather than at a data
partition, because the identity itself spans tenants. This is a continuous obligation, not a one-time
structural guarantee — hence `EV-26` alerting on every cross-tenant attempt with no threshold. A global
account also means compromise of one account can expose several tenants, raising the value of the
account-protection controls in Chapter 8.

**Neutral.** Account state is global; membership state is tenant-scoped. These are different concepts and
must never be conflated (`AUTH-9.3`).

## Alternatives considered

| Alternative | Rejected because |
|---|---|
| Tenant-scoped identity | Forces duplicate accounts and repeated registration; makes multi-library membership unimplementable |
| Global identity with global roles | Destroys tenant isolation; an owner at one library would hold owner rights everywhere |
| Account linking across tenant identities | All the complexity of both models plus a linking mechanism to get wrong |

## References

Authentication PRD v2.0 Chapters 2, 5, 7 · `AUTH-11.62`, `AUTH-11.63` · Bounded Context Map §4 Identity Triad, §11
