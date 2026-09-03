# LIBOORA — Enterprise Architecture

> **Enterprise Education Platform Ecosystem**
> Modular Monolith → Microservice Ready · Multi-Tenant SaaS · AI Native

| Field | Value |
|---|---|
| **Document** | LIBOORA Enterprise Architecture (Master) |
| **Version** | `v2.3` |
| **Status** | Reviewed & Refined — Approved for Implementation |
| **Last Updated** | 2026-08-25 |
| **Reviewed By** | Principal Enterprise Architect · SaaS Platform Architect · DDD Expert · Cloud Architect · AI Platform Architect |
| **Supersedes** | `v1.0` (pre-review architecture tree) |
| **Platform Count** | 25 |
| **Change Summary** | 11 duplicates merged (0 nodes lost) · 8 modules re-homed · 1 new platform (EVENT PLATFORM) · 3 platform candidates rejected |

---

## Table of Contents

1. [Review Scope & Method](#1-review-scope--method)
2. [Platform-by-Platform Review & Scoring](#2-platform-by-platform-review--scoring)
3. [Duplicate Resolution Matrix](#3-duplicate-resolution-matrix)
4. [New Platform Decisions](#4-new-platform-decisions)
5. [Principle Validation](#5-principle-validation)
6. [Enterprise Audit Scores](#6-enterprise-audit-scores)
7. [Principal-Architect Critique & Remediation](#7-principal-architect-critique--remediation)
8. [Complete Enterprise Architecture Tree](#8-complete-enterprise-architecture-tree)
9. [Post-Refinement Platform Scores](#9-post-refinement-platform-scores)
10. [Governing Rules & Conventions](#10-governing-rules--conventions)
11. [Changelog](#11-changelog)

---

## 1. Review Scope & Method

This document is the output of a **professional enterprise architecture review and refinement** — not a redesign. The following constraints were binding throughout:

1. The architecture was never rewritten from scratch.
2. The existing hierarchy, ASCII tree formatting and indentation are preserved.
3. Every `V1` / `V2` / `V3` / `Future` tag is preserved.
4. No module was deleted. Modules were only **merged** when they represented the *same* responsibility — and in every merge the original node survives as a **child**, so nothing is lost.
5. Every platform obeys the **Single Responsibility Principle**.
6. Every module has **exactly one owner platform**. All other appearances are explicitly labelled as consumers/views.
7. Naming is normalised across the whole architecture.
8. No unnecessary complexity was introduced. A new platform was added **only** where a genuine architectural hole existed.

### Reconstruction Notice

The source tree supplied for review was truncated at `PLATFORM SERVICES → Realtime Engine → Live Notifications`. The following platforms were requested for verification but were not present in the transmitted text, and have therefore been **architected to enterprise standard and marked `[RECONSTRUCTED]`** in the final tree:

- `INTEGRATION PLATFORM`
- `SECURITY PLATFORM`
- `DEVOPS PLATFORM`
- `QUALITY PLATFORM`
- `INFRASTRUCTURE`
- `DATA PLATFORM` (pre-existing storage nodes)
- `PLATFORM SERVICES` (tail beyond Realtime Engine)
- `FUTURE ECOSYSTEM` (pre-existing nodes)

**Action for the architecture owner:** diff these sections against the canonical `v1.0` file and merge any pre-existing nodes. Every other node in this document is byte-preserved from the source.

---

## 2. Platform-by-Platform Review & Scoring

| # | Platform | Score /10 | Critical findings | Refinement applied |
|---|---|---|---|---|
| 1 | **FOUNDATION** | 8.5 | Strong doc set. `ADR Index` duplicated (top-level + child). `Coding Standards` / `Coding Guidelines` / `Coding Conventions` = 3 names, 1 responsibility. No **Bounded Context Map** as first-class, no **NFR Budgets**, no **Tenancy Model** decision doc, no **Threat Model**. | Merged `ADR Index`; consolidated coding-standard naming under Governance ownership; added Tenancy Model, Modularization Strategy, NFR Budgets, Threat Model, Compliance Requirements, Cost Model. |
| 2 | **ARCHITECTURE GOVERNANCE** | 8.0 | Governs documents but not **runtime**. No Fitness Functions, no Module Dependency enforcement, no ADR-to-code traceability. | Added Architecture Fitness Functions, Module Boundary Enforcement, Dependency Rules, ADR Traceability, AI Governance Review, Governance Automation. |
| 3 | **CONFIGURATION PLATFORM** | 9.0 | Well-scoped. Owned Feature Flags while Shared Core held a competing node. `Secrets Management` was mis-homed here — belongs to Security. | Absorbed Shared Core `Settings & Configuration`, `Configuration Management`, `Feature Flags`, and Tenant/Library Branding. `Secrets Management` re-homed to Security Platform; Config retains `Secret Reference Resolution` only. |
| 4 | **SHARED CORE PLATFORM** | 5.5 → 8.5 | **Largest SRP violation in the architecture.** A god-module owning Search, Notifications, Audit, Config, Feature Flags, Background Jobs and RBAC — all of which now have dedicated platforms. Multi-tenancy (the #1 SaaS concern) was buried three levels deep with no tenant-context propagation, residency, or noisy-neighbour control. | 9 modules re-homed to their true owners. Tenant management hardened with Tenant Context Propagation, Tenant Tiers & Quotas, Data Residency, Noisy Neighbour Protection, Offboarding & Data Export. Shared Core reduced to genuine cross-cutting primitives. |
| 5 | **IDENTITY & ACCESS** | 7.5 | `Device Management` + `Multi Device Management` = duplicate. No **Service Identity / M2M**, no **SSO / SAML / SCIM** (mandatory for institutional deals), no **ABAC**, no **Impersonation with audit**, no **Consent Management** (parental consent for minors is a legal requirement). | Merged device modules. Added Enterprise SSO, Provisioning (SCIM/JIT), ABAC Policies + Policy Decision Point, Service Identity, Support Impersonation, Consent Management incl. Minor Guardian Consent. |
| 6 | **LIBRARY MANAGEMENT** | 8.5 | Excellent domain depth — this is the real product. But 4 dashboards duplicated Analytics computation; `Student Payments` duplicated Business Platform; `Branding` duplicated Config; `Business Automation` duplicated Workflow. Ownership was blurred. Attendance had no anti-fraud, no idempotency, no offline path. Seat had no concurrency control. | Declared **Core Domain (DDD)**. Dashboards reclassified as *presentation over Analytics read-models*; payments as *domain intent over Business Platform rails*; automation as *domain rules executed by Workflow Platform*. Added Idempotent Check-In, Anti-Fraud Controls, Offline Attendance Capture, Clock Skew Handling, Seat Locking & Concurrency, Occupancy Domain Service, Fee Structures, Cash Reconciliation, Multi-Branch Management. |
| 7 | **GLOBAL STUDENT PLATFORM** | 7.0 | A social platform with **no Trust & Safety spine** — an existential legal risk on a minor-heavy product. No abuse reporting, no moderation pipeline, no social-graph rate limiting, no block enforcement, no chat retention/encryption stance. | Added full **Trust & Safety** branch (Report & Abuse, Moderation Pipeline, Automated Filters, Minor Safety Controls, Anti-Spam & Rate Limits, Block Enforcement, Moderator Console, Strikes, Appeals). Chat hardened with Delivery Guarantees, Retention Policy, Encryption at Rest, Presence. Added content scanning, copyright takedown, listing moderation, anti-gaming controls. |
| 8 | **AI PLATFORM** | 8.0 | Very strong for V1, but: `Prompt Library` ≡ `Prompt Registry` (duplicate); `AI Memory Layer` ≡ `AI Memory Store` (duplicate); `Prompt Evaluation` ⊂ `AI Evaluation` (duplicate); `AI Workflow Engine` wrongly owned. **No PII redaction before model calls**, no tenant-scoped RAG isolation guarantee, no model cards / AI governance, no human-in-the-loop before AI-initiated writes. | 4 duplicates merged (all demoted to children — zero loss). `AI Workflow Engine` re-homed to Workflow Platform. Added AI Governance, PII Redaction Gateway, Human-in-the-Loop, Permission-Aware Retrieval, Tenant Isolation Guarantees, ML & Prediction Services, AI Rate Limits & Quotas, Input/Output Guardrails, AI Observability Hooks. |
| 9 | **WORKFLOW PLATFORM** | 8.5 | Good. Overlapped `Background Jobs` and `Scheduler`. Missing Sagas / compensating transactions, idempotency, dead-letter handling, concurrency limits. | Clean split established: **Workflow = orchestration** (owns Scheduler), **Platform Services = runtime** (`Job Runtime`: workers/queues). Added Saga Orchestration, Idempotency Keys, Dead Letter Handling, Concurrency Limits, Missed Run Recovery. Absorbed `AI Workflow Engine`. |
| 10 | **EVENT PLATFORM** *(NEW)* | — → 9.0 | **Genuine architectural hole.** The architecture had `Event Catalog` (docs), `Event Store` (storage), `Event Triggers` (workflow) and `Domain Events` (model) — but **no owner of the runtime event backbone**. Without Outbox + Schema Registry + Broker + Consumer Groups + Replay + DLQ, "Event-Driven readiness" and "Future Microservice readiness" are aspirational, not real. | **New platform added** — the single highest-ROI change in this review. |
| 11 | **BUSINESS PLATFORM** | 8.0 | Solid billing. Missing dunning, proration, revenue recognition, tax jurisdiction engine, entitlement-as-a-service, and PLG lifecycle (onboarding/activation/churn). Single gateway (Razorpay) = vendor lock-in. | Added Entitlement Service (single source of truth for limits), Plan Catalog, Payment Gateway Abstraction, Payment Idempotency, Webhook Reconciliation, Proration Engine, Dunning Management, Revenue Recognition, Tax Jurisdiction Rules, Customer Lifecycle. |
| 12 | **COMMUNICATION PLATFORM** | 8.0 | `Notification Preferences` appeared twice inside the same platform. Templates fragmented across Email/SMS/Notification. No deduplication, quiet hours, throttling, delivery-guarantee model, bounce handling, or DLT/TRAI compliance. | Merged the duplicate. Added **Delivery Orchestration** (absorbing Shared Core `Notification Engine`) with Channel Fallback, Deduplication, Throttling, Quiet Hours & DND, Delivery Guarantees. Unified `Notification Templates` as sole template owner. Added Consent & Unsubscribe, DLT/TRAI Compliance, Bounce Handling, Token Lifecycle. |
| 13 | **SEARCH PLATFORM** | 8.5 | Good. Absorbed Shared Core's duplicate `Search Engine`. Missing permission-filtered indexing at write time and a tenant index isolation guarantee. | Absorbed duplicate as `Search Engine Core`. Added Tenant Index Isolation, Permission-Aware Indexing, Index Backfill Jobs, Search Relevance Config, Query Rewriting. |
| 14 | **ANALYTICS PLATFORM** | 7.5 | `Custom Reports` and `Scheduled Reports` duplicated (top-level + under Reporting Engine). **No semantic/metric layer** → every dashboard would recompute "revenue" differently, the classic enterprise BI failure. No product analytics (funnels/cohorts). Reads risked hitting OLTP directly. | Merged duplicates. Added **Metric Layer (Semantic Layer)**, Analytics Data Contracts, **Read Model Store (CQRS)**, Product Analytics, Student Dashboard, Report Distribution, Large Export Jobs. Declared AI-backed prediction models as owned by AI Platform. |
| 15 | **AUDIT PLATFORM** | 8.5 | Good separation. Needed to absorb Shared Core `Audit Logs` and `Activity Timeline`. Missing immutability guarantee, AI action logging, and access transparency for tenant admins. | Absorbed both duplicates as owner. Added Immutable Append-Only Store, AI Action Logs, Access Transparency, Audit Search, Legal Hold. |
| 16 | **API PLATFORM** | 8.5 | Strong. `Shared SDK` vs `SDK Management` ambiguity. Missing idempotency, pagination/filtering standards, contract-first workflow, BFF for mobile, tenant resolution at the edge. Developer Portal / Marketplace / SDK were scattered. | Added API Contracts (OpenAPI as source of truth), Tenant Resolution, Request Validation, Idempotency Support, Timeout & Retry Policy, BFF Layer, and a consolidated **Developer Experience** branch — deliberately *not* a new platform. |
| 17 | **INTEGRATION PLATFORM** | `[RECONSTRUCTED]` 8.0 | Absent from the transmitted tree, yet Payments, SMS, FCM, WhatsApp, SSO providers and accounting exports all require one owner for outbound third-party contracts, retries and credential handling. | Full platform architected: Connector Framework, Third Party Registry, provider integrations, Integration Credential Management, Sync Engine, Idempotent Delivery, Integration Monitoring, Integration Marketplace. |
| 18 | **PLATFORM SERVICES** | `[PARTIAL]` 7.5 | Truncated in source. Realtime Engine present but with no presence, fan-out or scaling model. **No Offline-First Sync** — fatal for a Flutter attendance app used in poor-signal library basements. No file pipeline (virus scan, thumbnails, signed URLs). No idempotency service. | Platform completed: Job Runtime (absorbing `Background Jobs`), Offline Sync Engine + Conflict Resolution, File Pipeline, Storage Abstraction, Cache Service, Rate Limiter, QR Service, PDF Generation, Geolocation, Feature Delivery, Idempotency Service, Time & Timezone Service, Realtime scaling/backpressure. |
| 19 | **OBSERVABILITY PLATFORM** | 8.5 | Good coverage of the "three pillars", but missing SLO/error-budget engineering, per-tenant observability, AI observability, mobile observability and incident process. | Added SLO Management, Error Budgets, Tenant-Level Observability, AI Observability, Mobile Observability, Incident Management (Runbooks, Postmortems, MTTR), PII-Safe Logging, Tenant & User log context. |
| 20 | **SECURITY PLATFORM** | `[RECONSTRUCTED]` 8.5 | Absent as an owner — security was scattered as "Security Review Process", "Account Security", "AI Safety". No enterprise SaaS passes a security questionnaire without a Security Platform. | Full platform: Secrets & Key Management (now sole owner), Encryption, Zero Trust, Application Security, Threat Detection, Perimeter Protection (WAF/DDoS), Vulnerability Management, Pen Testing, Data Privacy (DPDP/GDPR, DSR, RoPA, Residency, Minor Protection), Compliance Programs (SOC 2 / ISO 27001), Security Incident Response, Security Posture Metrics. |
| 21 | **DATA PLATFORM** | 8.0 | Storage tiers were good. Missing **data governance** (classification, lineage, ownership, PII tagging, retention), migration/lifecycle, backup/PITR, and an explicit home for multi-tenant data isolation. Analytics reads had no isolated store. | Governance folded **into** Data Platform (deliberately not a separate platform). Added Tenant Data Isolation (with cross-tenant leak tests), Analytics Store, Data Governance branch, Data Lifecycle, Schema Migration, Backup & Recovery, Module Schema Ownership, CDC publishing to Event Platform. |
| 22 | **DEVOPS PLATFORM** | `[RECONSTRUCTED]` 8.0 | Absent. Flutter mobile makes release engineering non-trivial: store review latency, forced upgrade, kill switch, OTA config, staged rollout, client/server compatibility. | Full platform: CI Pipeline, CD Pipeline, Release Engineering, **Mobile Release Management**, Infrastructure as Code, DB Migration Automation, Rollback Automation, Environment Management incl. ephemeral previews, Developer Productivity. |
| 23 | **QUALITY PLATFORM** | `[RECONSTRUCTED]` 8.0 | `Testing Strategy` existed only as a *document* in Foundation with no runtime owner. No contract testing, load testing, chaos, accessibility QA, or multi-tenant isolation tests. | Full platform: Test Automation, **Contract Testing**, Load & Stress Testing, Chaos Engineering, Accessibility Testing, **Multi-Tenant Test Suite**, Test Data Management, Quality Gates, Defect Management, Release Readiness Review. |
| 24 | **INFRASTRUCTURE** | `[RECONSTRUCTED]` 8.0 | Absent. No owner for compute, network, edge, regions, DR or cost. | Full platform: Cloud Foundation, Compute, Networking, CDN & Edge, Regions & Availability, Scaling, Disaster Recovery, **FinOps & Cost Management**, Capacity Planning, Infrastructure Security Baseline. |
| 25 | **FUTURE ECOSYSTEM** | 8.0 | Plugin Platform was a good addition but lacked sandboxing/certification, and there was no multi-product identity or billing federation, nor marketplace governance. | Added Product Suite Federation, Plugin Sandboxing & Permissions, Plugin Review & Certification, Partner Program, Marketplace Governance. |

---

## 3. Duplicate Resolution Matrix

**Governing rule applied:** *one responsibility → one owning platform → every other appearance becomes an explicitly-labelled consumer/view (kept, never deleted), or is merged as a child node (nothing lost).*

| Duplicate | Appeared in | **Owner (source of truth)** | Resolution |
|---|---|---|---|
| **Audit Logs** | Shared Core, Audit Platform | **AUDIT PLATFORM** | Shared Core node **merged out** → became `Audit Logs → System Action Logs`. Domain platforms *emit*, never *store*. |
| **Activity Timeline** | Shared Core, Student Profile | **AUDIT PLATFORM** (`Activity Timeline`) | Shared Core node merged in; Student Profile node retained as a UI view. |
| **Search** | Shared Core `Search Engine`, Search Platform, Student Search | **SEARCH PLATFORM** | Shared Core `Search Engine (V2)` **merged** → `Search Engine Core (V2)`. Domain searches are query clients. |
| **Feature Flags** | Shared Core, Config `Feature Configuration`, Business `Feature Limits` | **CONFIGURATION PLATFORM** (definition + rollout) / **BUSINESS PLATFORM** (*entitlement* = what a plan permits) | Shared Core node merged into `Feature Configuration → Feature Flags`. New `Entitlement Service` is the plan-limit authority. Config resolves the flag; Business decides the entitlement. |
| **Scheduler / Background Jobs** | Shared Core `Background Jobs`, Workflow `Scheduler` | **WORKFLOW PLATFORM** = *when & why* (orchestration); **PLATFORM SERVICES** = *how* (`Job Runtime`) | Shared Core `Background Jobs (V2)` **re-homed** into Platform Services `Job Runtime`. |
| **Prompt Library vs Prompt Registry** | AI Platform (both) | **AI PLATFORM → Prompt Registry** | **Obvious duplication → merged.** `Prompt Library (V1)` and `Prompt Versioning (V2)` demoted to children of Prompt Registry. Zero loss. |
| **Prompt Evaluation vs AI Evaluation** | AI Platform (both) | **AI Evaluation** | `Prompt Evaluation (V3)` merged as a child. |
| **AI Memory Layer vs AI Memory Store** | AI Platform (both) | **AI Memory Store** | Merged: `AI Memory Layer (V2)` becomes the access-API child of the store. |
| **AI Workflow Engine** | AI Platform | **WORKFLOW PLATFORM** | Incorrect ownership → **re-homed** under `AI Workflow Automation`. AI *authors*; Workflow *executes*. |
| **Notification** | Shared Core `Notification Engine`, Communication Platform, Library `Notification Settings` | **COMMUNICATION PLATFORM** | Shared Core `Notification Engine (V1)` **merged** into `Delivery Orchestration`. Library node is a tenant preference UI. |
| **Notification Preferences** | Communication Platform (twice, same platform) | Communication → Notification Management | **Obvious duplication → merged.** |
| **Configuration** | Shared Core `Settings & Configuration` + `Configuration Management`, Config Platform, Org Mgmt `Tenant Configuration`, Library Settings | **CONFIGURATION PLATFORM** | Both Shared Core nodes merged in. Org-Mgmt `Tenant Configuration` merged as `Tenant Overrides`. Library Settings = domain-scoped values *stored via* Config Platform. |
| **Branding** | Org Mgmt `Tenant Branding`, Config `Branding Configuration`, Library Settings `Branding` | **CONFIGURATION PLATFORM** | Org-Mgmt and Library nodes merged into `Branding Configuration`. |
| **RBAC / Roles & Permissions** | Shared Core, Identity `Authorization`, Staff Management | **IDENTITY & ACCESS PLATFORM** | Shared Core `Roles & Permissions (RBAC) (V1)` **merged** into `Authorization → RBAC`. Staff node is an admin screen. |
| **Device Management vs Multi Device Management** | Identity (both) | Identity → Device Management | **Obvious duplication → merged** as child. |
| **Login History vs Login & Access Logs** | Identity, Audit | **AUDIT PLATFORM** (raw), Identity (user-facing view) | Both kept; ownership declared. |
| **Custom Reports / Scheduled Reports** | Analytics (top-level *and* under Reporting Engine) | Analytics → Reporting Engine | **Obvious duplication → merged.** |
| **Revenue Analytics** | Business, Analytics, Library `Analytics & Growth Reports` | **ANALYTICS PLATFORM** (computation) | Business & Library nodes retained as *domain views over Analytics read-models*. |
| **Student / Attendance / Membership / Occupancy Analytics** | Library, Analytics | **ANALYTICS PLATFORM** | Library nodes are embedded dashboards. |
| **Student Payments** | Library `Revenue & Finance`, Business Platform | **BUSINESS PLATFORM** (money movement) / Library (fee *domain intent*) | Both retained; ownership declared. |
| **Seat Recommendations** | AI `Seat Recommendations`, Library `Smart Seat Recommendations` | **AI PLATFORM** (algorithm) | Library node is the surface. |
| **Parent Assistant** | Library `AI Parent Assistant`, AI `Parent Assistant` | **AI PLATFORM** | Library node is the entry point. |
| **Coding Standards / Guidelines / Conventions** | Foundation ×2, Governance ×1 | **ARCHITECTURE GOVERNANCE → Coding Standards** | Foundation's two nodes retained as *handbook chapters* under Development Standards; Governance is the normative owner. |
| **ADR Index** | Foundation (twice) | Foundation → ADR Summary | **Obvious duplication → merged.** |
| **Architecture Principles** | Foundation (Handbook child), Governance | **ARCHITECTURE GOVERNANCE** | Foundation node is a documentation chapter. |
| **Documentation Standards** | Foundation, Governance | **ARCHITECTURE GOVERNANCE** | Foundation node is a chapter. |
| **Shared SDK vs SDK Management** | Shared Core, API Platform | Shared Core = **internal** SDK; API Platform = **public/partner** SDK | Both kept; scope clarified via children. |
| **Export** | Analytics `Export Engine`, Audit `Export Audit Logs`, Student `Import & Export` | **ANALYTICS PLATFORM → Export Engine** | Others are domain-specific callers. |
| **Crash Reporting / Performance Monitoring** | Observability, Foundation NFRs | **OBSERVABILITY PLATFORM** | Ownership declared. |
| **Secrets Management** | Configuration Platform (v1.0 placement), Security | **SECURITY PLATFORM → Secrets & Key Management** | **Re-homed.** Config Platform keeps `Secret Reference Resolution` only. |
| **Disaster Recovery** | Foundation plan, Deployment Guide, Infrastructure | Foundation = **plan document**; **INFRASTRUCTURE** = execution | Ownership declared. |
| **Vector Search vs Vector Database** | AI, Data | AI = query & relevance; Data = storage & ops | **Not duplicates** — both retained. |
| **Predictive Analytics / Forecasting** | Analytics, AI | Analytics = *surface & definitions*; **AI PLATFORM** = *models* | Ownership declared; `ML & Prediction Services` added to AI Platform. |

**Total: 31 overlaps adjudicated · 11 obvious duplicates merged (zero nodes lost) · 9 modules re-homed · 0 modules deleted.**

---

## 4. New Platform Decisions

Restraint was applied deliberately: a platform was added **only** where no existing owner could absorb the responsibility without violating SRP.

| Candidate | Verdict | Reasoning |
|---|---|---|
| **EVENT PLATFORM** | ✅ **ADDED (V2)** | The architecture had Event Catalog (docs), Event Store (data), Event Triggers (workflow) and Domain Events (model) — but **no owner of the runtime backbone**. Without Outbox, Schema Registry, Broker, Consumer Groups, Replay and DLQ, both "Event-Driven readiness" and "Future Microservice readiness" are unachievable. Highest-ROI addition in the review. |
| **JOB PLATFORM** | ❌ **REJECTED** | Would fragment a responsibility that splits cleanly today: Workflow owns orchestration & scheduling; Platform Services owns `Job Runtime`. A third platform adds ceremony, not clarity. |
| **DEVELOPER PLATFORM** | ❌ **REJECTED** | Developer Portal, SDK Management, API Marketplace and API Documentation already live in API Platform. Grouped into a **`Developer Experience`** branch instead. Promote to a platform only when external developers become a revenue line. |
| **DATA GOVERNANCE PLATFORM** | ❌ **REJECTED as platform / ✅ ADDED as branch** | Classification, lineage, PII tagging, retention and DSR belong *next to the data*; enforcement belongs to Security Platform. Added as `DATA PLATFORM → Data Governance`. A startup cannot staff a separate governance platform in year one. |
| **TENANT PLATFORM** | ❌ **REJECTED / hardened in place** | Rather than relocate the existing `Organization (Tenant) Management`, it was hardened with the missing enterprise tenancy primitives (context propagation, tiers & quotas, residency, noisy-neighbour, offboarding). Preserves the existing hierarchy. |
| **NOTIFICATION PLATFORM** | ❌ **REJECTED** | Communication Platform already is it. |
| **BILLING PLATFORM** | ❌ **REJECTED** | Business Platform owns it; splitting would orphan subscription/entitlement cohesion. |

**Net: +1 platform (EVENT PLATFORM). Total = 25 platforms.**

---

## 5. Principle Validation

| Principle | Before | After | What closed the gap |
|---|---|---|---|
| Domain Driven Design | ⚠️ 6 | ✅ 9 | Bounded contexts declared; Library Mgmt = Core Domain, Global Student = Supporting, Config/Event/Audit = Generic Subdomains; Domain Events, Context Map, Ubiquitous Language, Anti-Corruption Layers formalised |
| Clean Architecture | ⚠️ 7 | ✅ 9 | Layered Architecture & Module Guidelines now *enforced* by Fitness Functions + Dependency Rules, not merely documented |
| Hexagonal Architecture | ❌ 4 | ✅ 9 | **Ports & Adapters made explicit**: Integration Platform = outbound adapters, API Platform = inbound adapters, plus Payment Gateway Abstraction, AI Provider Abstraction, Storage Abstraction |
| Modular Monolith readiness | ⚠️ 6 | ✅ 9 | Module Boundary Enforcement, single-owner rule, Module Schema Ownership, no cross-module DB reads |
| Future Microservice readiness | ❌ 4 | ✅ 8 | Event Platform + Transactional Outbox + Service Catalog + Service APIs + Service Extraction Playbook + Strangler Fig strategy |
| API First | ⚠️ 7 | ✅ 9 | API Contracts (OpenAPI as source of truth), contract-testing gate, idempotency, pagination standards, BFF layer |
| Event Driven readiness | ❌ 3 | ✅ 9 | **EVENT PLATFORM** |
| Multi-Tenant SaaS | ⚠️ 6 | ✅ 9 | Tenant Context Propagation, Tenant Data Isolation + leak tests, Residency, Tiers & Quotas, Noisy Neighbour, per-tenant observability, tenant index isolation, tenant RAG isolation |
| AI Native Architecture | ⚠️ 7 | ✅ 9 | RAG + Embeddings + Vector + Agent Registry **+ AI Governance + PII Redaction + Human-in-the-Loop + Guardrails + AI Observability** |
| Enterprise Governance | ⚠️ 7 | ✅ 9 | Fitness functions, ADR traceability, compliance programs, deprecation governance, access transparency |
| Security by Design | ❌ 4 | ✅ 9 | **SECURITY PLATFORM** as owner: zero trust, secrets, encryption, threat detection, DPDP/GDPR, DSR, SOC 2 / ISO readiness |
| Cloud Native | ⚠️ 6 | ✅ 9 | Infrastructure + DevOps + IaC + multi-region + autoscaling + readiness/liveness + degraded-mode detection |
| Scalability | ⚠️ 6 | ✅ 9 | CQRS read models, cache tier, queues, partitioning/sharding, CDN & edge, capacity planning, backpressure |
| Maintainability | ⚠️ 6 | ✅ 9 | Duplicates merged, single ownership everywhere, naming normalised, technical-debt governance |
| Extensibility | ⚠️ 7 | ✅ 9 | Plugin Platform (sandboxed), Connector Framework, Webhooks, Extension SDK, Custom Fields |
| Separation of Concerns | ❌ 5 | ✅ 9 | Shared Core de-godded (9 re-homes) |

---

## 6. Enterprise Audit Scores

| Dimension | Before | **After** |
|---|---|---|
| **Overall Architecture** | 6.8 / 10 | **9.1 / 10** |
| **Scalability** | 6.5 / 10 | **9.0 / 10** |
| **Enterprise Readiness** | 6.0 / 10 | **9.2 / 10** |
| **Maintainability** | 6.2 / 10 | **9.0 / 10** |
| **AI Readiness** | 7.5 / 10 | **9.3 / 10** |
| **SaaS Readiness** | 6.5 / 10 | **9.2 / 10** |
| **Production Readiness** | 5.5 / 10 | **8.8 / 10** |
| **Future-proof** | 6.8 / 10 | **9.2 / 10** |

> **Why Production Readiness is capped at 8.8:** the architecture is now excellent, but production readiness is *earned by execution* — SLOs actually met, DR drills actually passed, penetration test actually cleared, contract tests actually running in CI. No diagram can pre-earn those points.

---

## 7. Principal-Architect Critique & Remediation

> *"If this architecture were presented to a Principal Architect at Google, Microsoft, Amazon, Atlassian or Shopify, what weaknesses would they still identify?"*

They would not attack the module list. They would attack these **14 things** — every one of which is now remediated in the final tree.

| # | Critique | Remediation |
|---|---|---|
| 1 | *"Where is your tenant isolation **guarantee**, not just a folder?"* Multi-tenancy was a sub-node, not an invariant. | Tenant Context Propagation, Tenant Data Isolation + cross-tenant leak tests, per-tenant quotas, tenant-scoped index & RAG isolation |
| 2 | *"You have an Event Catalog but no event bus. So it isn't event-driven — it's a wish."* | **EVENT PLATFORM**: Outbox, Schema Registry, Consumer Groups, Replay, DLQ, CDC |
| 3 | *"Shared Core is a god-module. In three years everything depends on it and you can never split it."* | 9 modules re-homed; Module Boundary Enforcement + Dependency Rules Matrix |
| 4 | *"No SLOs, no error budgets. You have monitoring, not reliability engineering."* | SLO Management, SLI Definitions, Error Budgets, Burn-Rate Alerts, Runbooks, Incident Management, MTTR |
| 5 | *"Your AI writes to production data with no human-in-the-loop and no PII redaction. That's an incident and a regulatory finding."* | PII Redaction Gateway, Human-in-the-Loop, AI Governance, Model Cards, Regional Model Routing, AI Action Logs, AI Observability |
| 6 | *"No semantic/metric layer → 'revenue' will mean five different things in five dashboards within 18 months."* | Metric Layer (Semantic Layer), Certified Metrics, Analytics Data Contracts |
| 7 | *"No SSO / SAML / SCIM. You cannot sell to a single institution or chain."* | Enterprise SSO (SAML/OIDC), SCIM Provisioning, JIT Provisioning, ABAC, Service Identity |
| 8 | *"A social product for minors with no Trust & Safety pipeline is an existential legal risk, not a backlog item."* | Trust & Safety branch, Minor Safety Controls, Consent Management, Minor Guardian Consent, Moderation Pipeline, Appeals |
| 9 | *"An attendance app that needs network in a library basement — with no offline-first sync or conflict resolution."* | Offline Sync Engine, Local Write Queue, Conflict Resolution, Delta Sync, Clock Skew Handling, Offline Attendance Capture |
| 10 | *"No idempotency on payments or attendance. Double-charges and duplicate check-ins are inevitable at scale."* | Idempotency Support (API), Idempotency Keys (Workflow), Idempotency Service (Platform Services), Payment Idempotency, Idempotent Check-In, Idempotent Consumers |
| 11 | *"Mobile means the client is a distributed system you don't control. Where is forced upgrade, kill switch, staged rollout, schema back-compat?"* | Mobile Release Management: App/Play Store Delivery, Forced Upgrade, Client Kill Switch, Staged Rollout, Client Compatibility Matrix, OTA Config |
| 12 | *"No FinOps. AI + realtime + analytics will destroy your gross margin silently."* | FinOps & Cost Management, Cost per Tenant, AI Cost Attribution, Budget Alerts, Unit Economics, Cost Model |
| 13 | *"No data lifecycle: no retention, no deletion pipeline, no DSR, no residency. You fail DPDP/GDPR on day one of enterprise procurement."* | Data Governance branch, Data Lifecycle, Retention Enforcement, Hard Delete Pipeline, Anonymization, DSR, Right to Erasure, Data Residency Enforcement, Legal Hold |
| 14 | *"You have no explicit strategy for **how** you exit the monolith. Everyone plans microservices; nobody plans the seam."* | Modularization Strategy: Module Ownership Map, Cross-Module Rules, Service Extraction Playbook, Strangler Fig Strategy, Service Catalog |

---

## 8. Complete Enterprise Architecture Tree

### Legend

| Marker | Meaning |
|---|---|
| `← NEW` | Module added during this review |
| `← MERGED` | Duplicate absorbed here; original node preserved as a child |
| `→ owned by X` | Node retained but authoritative owner is platform X |
| `[VIEW over X]` | Presentation/read-only surface over platform X |
| `[client of X]` | Calls platform X; does not own the capability |
| `[RECONSTRUCTED]` | Not present in transmitted source — architected here, diff against canonical v1.0 |
| `[OWNER of ...]` | Explicit single-owner declaration |

```
LIBOORA
Enterprise Education Platform Ecosystem
(25 Platforms · Modular Monolith → Microservice Ready · Multi-Tenant SaaS · AI Native)

═══════════════════════════════════════════════════════════════
LAYER 0 — GOVERNANCE & FOUNDATION
═══════════════════════════════════════════════════════════════

├── FOUNDATION (V1)
│
├── Master PRD (V1)
│   ├── Product Vision (V1)
│   ├── Product Goals (V1)
│   ├── Business Requirements (V1)
│   ├── Functional Requirements (V1)
│   ├── Non-Functional Requirements (V1)
│   ├── Success Metrics (V1)
│   ├── Product Roadmap (V1)
│   ├── Risks & Assumptions (V1)
│   └── Future Vision (Future)
│
├── ADR Summary (V1)
│   ├── ADR Index (V1)                                   ← MERGED (was duplicated top-level)
│   ├── Accepted Decisions (V1)
│   ├── Proposed Decisions (V2)
│   ├── Deprecated Decisions (V2)
│   └── Decision History (V2)
│
├── Architecture Handbook (V1)
│   ├── Architecture Principles (V1)
│   ├── System Overview (V1)
│   ├── Layered Architecture (V1)
│   ├── Module Guidelines (V1)
│   ├── Scalability Strategy (V2)
│   ├── Multi-Tenant Strategy (V2)
│   ├── Security Principles (V2)
│   ├── Performance Guidelines (V2)
│   └── Enterprise Standards (V3)
│
├── System Architecture (V1)
│   ├── High Level Architecture (V1)
│   ├── Logical Architecture (V1)
│   ├── Physical Architecture (V2)
│   ├── Deployment Architecture (V2)
│   ├── Component Diagram (V2)
│   ├── Sequence Diagrams (V2)
│   ├── Integration Diagram (V2)
│   └── Infrastructure Diagram (V3)
│
├── Domain Model (V1)
│   ├── Bounded Contexts (V1)
│   ├── Core Entities (V1)
│   ├── Aggregates (V2)
│   ├── Domain Events (V2)
│   ├── Context Mapping (V2)
│   ├── Ubiquitous Language (V1)                          ← NEW
│   └── Anti-Corruption Layers (V2)                       ← NEW
│
├── Data Dictionary (V1)
│   ├── Entity Definitions (V1)
│   ├── Field Definitions (V1)
│   ├── Enumerations (V1)
│   ├── Data Types & Formats (V1)
│   ├── PII Classification (V2)                           ← NEW
│   └── Ownership & Stewardship (V2)
│
├── Business Capability Map (V1)
│   ├── Capability Levels (V1)
│   ├── Capability to Module Mapping (V1)
│   ├── Capability Ownership (V2)
│   └── Capability Maturity (V3)
│
├── Event Catalog (V2)
│   ├── Event Registry (V2)
│   ├── Event Schemas (V2)
│   ├── Producers & Consumers (V2)
│   ├── Event Versioning (V3)
│   └── Event Governance (V3)
│
├── Service Catalog (V2)
│   ├── Service Registry (V2)
│   ├── Service Ownership (V2)
│   ├── Service Dependencies (V2)
│   ├── Service SLAs (V3)
│   └── Service Lifecycle (V3)
│
├── Tenancy Model (V1)                                    ← NEW
│   ├── Isolation Strategy (V1)
│   ├── Tenant Identification (V1)
│   ├── Shared vs Dedicated Resources (V2)
│   ├── Data Residency Model (V3)
│   └── Tenant Tier Definitions (V2)
│
├── Modularization Strategy (V1)                          ← NEW
│   ├── Modular Monolith Design (V1)
│   ├── Module Ownership Map (V1)
│   ├── Cross-Module Rules (V1)
│   ├── Service Extraction Playbook (V3)
│   └── Strangler Fig Strategy (Future)
│
├── NFR Budgets (V1)                                      ← NEW
│   ├── Latency Budgets (V1)
│   ├── Availability Targets (V1)
│   ├── Throughput Targets (V2)
│   ├── Cost Budgets (V2)
│   └── Mobile Performance Budgets (V1)
│
├── Threat Model (V2)                                     ← NEW
│   ├── Trust Boundaries (V2)
│   ├── Attack Surface Analysis (V2)
│   ├── STRIDE Analysis (V2)
│   └── Mitigation Register (V3)
│
├── Compliance Requirements (V2)                          ← NEW
│   ├── DPDP Act Requirements (V2)
│   ├── GDPR Requirements (V3)
│   ├── Minor Data Protection (V2)
│   └── Audit & Retention Obligations (V2)
│
├── Cost Model (V2)                                       ← NEW
│   ├── Unit Economics (V2)
│   ├── Cost per Tenant (V2)
│   ├── AI Cost Model (V2)
│   └── Infrastructure Cost Model (V3)
│
├── Database Design (ERD) (V1)
│   ├── Core ERD (V1)
│   ├── Module ERDs (V1)
│   ├── Relationships (V1)
│   ├── Naming Standards (V1)
│   ├── Index Strategy (V2)
│   ├── Partition Strategy (V3)
│   └── Archive Strategy (V3)
│
├── API Specification (V1)
│   ├── REST Standards (V1)
│   ├── API Naming Convention (V1)
│   ├── Authentication Standards (V1)
│   ├── Error Standards (V1)
│   ├── Idempotency Standards (V1)                        ← NEW
│   ├── Pagination & Filtering Standards (V1)             ← NEW
│   ├── Versioning Strategy (V2)
│   ├── Rate Limiting Rules (V2)
│   └── Webhook Standards (V2)
│
├── UI Design System (V1)
│   ├── Design Tokens (V1)
│   ├── Color System (V1)
│   ├── Typography (V1)
│   ├── Iconography (V1)
│   ├── Spacing Rules (V1)
│   ├── Components Library (V1)
│   ├── Responsive Guidelines (V2)
│   ├── Accessibility Guidelines (V2)
│   ├── Theming & White Label Tokens (V2)                 ← NEW
│   └── Motion System (V3)
│
├── Development Standards (V1)
│   ├── Folder Structure (V1)
│   ├── Coding Guidelines (V1)
│   ├── Coding Conventions (V1)
│   ├── Git Workflow (V1)
│   ├── Branch Strategy (V1)
│   ├── Commit Standards (V1)
│   ├── Pull Request Standards (V1)
│   ├── Code Review Checklist (V2)
│   └── Documentation Standards (V2)
│
├── Testing Strategy (V1)
│   ├── Unit Testing (V1)
│   ├── Integration Testing (V1)
│   ├── Widget Testing (V1)
│   ├── Contract Testing (V2)                             ← NEW
│   ├── End-to-End Testing (V2)
│   ├── Regression Testing (V2)
│   ├── Performance Testing (V2)
│   └── Security Testing (V3)
│
├── Deployment Guide (V1)
│   ├── Development Environment (V1)
│   ├── Staging Environment (V1)
│   ├── Production Environment (V1)
│   ├── Release Process (V2)
│   ├── Rollback Process (V2)
│   └── Disaster Recovery (V3)
│
├── Product Roadmap (V1)
│   ├── MVP (V1)
│   ├── Growth Roadmap (V2)
│   ├── Enterprise Roadmap (V3)
│   └── Ecosystem Roadmap (Future)
│
├── Project Glossary (V1)
├── Environment Strategy (V1)
├── Migration Strategy (V2)
├── Architecture Decision Log (V1)
├── Versioning Strategy (V1)
├── Release Strategy (V2)
├── Risk Register (V1)
├── Technical Debt Register (V2)
├── Deprecation Policy (V2)
├── Architecture Review Checklist (V2)
└── Disaster Recovery Plan (V3)

═══════════════════════════════════════════════════════════════

├── ARCHITECTURE GOVERNANCE (V1)
│
├── Architecture Principles (V1)
│   ├── Clean Architecture (V1)
│   ├── Modular Design (V1)
│   ├── Domain Driven Design (V2)
│   ├── Hexagonal Architecture (V2)                       ← NEW
│   ├── API First (V2)
│   ├── Event Driven Principles (V2)                      ← NEW
│   ├── Security by Design (V2)                           ← NEW
│   └── Cloud Native Principles (V3)
│
├── Architecture Fitness Functions (V2)                   ← NEW
│   ├── Dependency Direction Checks (V2)
│   ├── Layer Violation Detection (V2)
│   ├── Coupling Metrics (V3)
│   └── Automated Architecture Tests (V3)
│
├── Module Boundary Enforcement (V1)                      ← NEW
│   ├── Public Module APIs (V1)
│   ├── Forbidden Cross-Module Access (V1)
│   ├── Schema Ownership Rules (V2)
│   └── Import Lint Rules (V1)
│
├── Dependency Rules (V1)                                 ← NEW
│   ├── Allowed Dependencies Matrix (V1)
│   ├── Circular Dependency Prevention (V1)
│   └── Third Party Approval (V2)
│
├── ADR Traceability (V2)                                 ← NEW
│   ├── Decision to Module Mapping (V2)
│   ├── Decision to Code Mapping (V3)
│   └── Decision Compliance Checks (V3)
│
├── Architecture Review Process (V1)
├── Architecture Decision Records (ADR) (V1)
├── Architecture Compliance (V2)
├── Coding Standards (V1)
├── Documentation Standards (V1)
├── Dependency Governance (V2)
├── Versioning Governance (V2)
├── Technical Debt Management (V2)
├── Security Review Process (V2)
├── Design Review Process (V2)
├── Change Management (V2)
├── Release Governance (V2)
├── AI Governance Review (V2)                             ← NEW
├── Governance Automation (V3)                            ← NEW
├── Deprecation Governance (V3)
└── Architecture Metrics (V3)

═══════════════════════════════════════════════════════════════
LAYER 1 — CROSS-CUTTING PLATFORMS
═══════════════════════════════════════════════════════════════

├── CONFIGURATION PLATFORM (V1)
│
├── Global Configuration (V1)
│   ├── Platform Defaults (V1)
│   ├── System Parameters (V1)
│   ├── Settings Registry (V1)                            ← MERGED (Shared Core: Settings & Configuration)
│   ├── Config Schema Registry (V2)
│   └── Config Validation (V2)
│
├── Tenant Configuration (V1)
│   ├── Tenant Overrides (V1)                             ← MERGED (Org Mgmt: Tenant Configuration)
│   ├── Inheritance & Precedence (V1)
│   ├── Config Templates (V2)
│   └── Bulk Configuration (V3)
│
├── Runtime Configuration (V2)
│   ├── Hot Reload Config (V2)
│   ├── Remote Config Delivery (V2)
│   ├── Config Cache (V2)
│   ├── Client Config Sync (V2)                           ← NEW
│   └── Kill Switches (V3)
│
├── Environment Configuration (V1)
│   ├── Development Config (V1)
│   ├── Staging Config (V1)
│   ├── Production Config (V1)
│   └── Secret Reference Resolution (V2)                  ← SCOPED (secrets owned by SECURITY PLATFORM)
│
├── Feature Configuration (V2)
│   ├── Feature Flags (V2)                                ← MERGED (Shared Core: Feature Flags)
│   ├── Feature Toggles (V2)
│   ├── Plan-Based Features (V2)
│   ├── Tenant Feature Sets (V2)
│   ├── Progressive Rollout (V3)
│   ├── Targeting Rules (V3)                              ← NEW
│   └── A/B Experiments (V3)
│
├── Branding Configuration (V2)
│   ├── Logo & Assets (V2)
│   ├── Theme & Colors (V2)
│   ├── Tenant Branding (V2)                              ← MERGED (Org Mgmt + Library Settings)
│   ├── Custom Domain (V3)
│   └── White Label Support (V3)
│
├── Configuration Versioning (V2)
│   ├── Config History (V2)
│   ├── Diff & Compare (V2)
│   ├── Rollback Config (V2)
│   └── Config Promotion (V3)
│
├── Configuration Management (V2)                          [lifecycle & tooling]
│
└── Configuration Audit (V3)
    ├── Change Log (V3)
    ├── Approval Trail (V3)
    ├── Access Log (V3)
    └── Compliance Evidence (Future)

═══════════════════════════════════════════════════════════════

├── SHARED CORE PLATFORM (V1)
│   [SRP RESTORED — 9 modules re-homed to their owner platforms]
│
├── Organization (Tenant) Management (V1)
│   ├── Tenant Registration (V1)
│   ├── Tenant Onboarding (V1)                            ← NEW
│   ├── Tenant Context Propagation (V1)                   ← NEW (critical multi-tenant invariant)
│   ├── Tenant Lifecycle States (V1)                      ← NEW
│   ├── Tenant Tiers & Quotas (V2)                        ← NEW
│   ├── Tenant Branding (V2)                              → owned by CONFIGURATION PLATFORM
│   ├── Tenant Isolation (V2)
│   ├── Noisy Neighbour Protection (V3)                   ← NEW
│   ├── Data Residency Assignment (V3)                    ← NEW
│   ├── Tenant Backup (V3)
│   ├── Tenant Offboarding & Data Export (V3)             ← NEW
│   └── Tenant Migration (V3)
│
├── Library Management (V1)
├── File & Document Management (V1)
├── Support & Feedback (V1)
├── Help Center (V1)
├── Shared Utilities (V1)
│   ├── Date & Time Utilities (V1)                        ← NEW
│   ├── Validation Utilities (V1)                         ← NEW
│   ├── Formatting Utilities (V1)                         ← NEW
│   └── ID & Slug Generation (V1)                         ← NEW
│
├── Shared Components (V1)
│   ├── UI Component Library (V1)                         ← NEW
│   ├── Form Framework (V1)                               ← NEW
│   ├── Table & List Framework (V2)                       ← NEW
│   └── Empty / Error / Loading States (V1)               ← NEW
│
├── Shared SDK (V2)                                        [INTERNAL SDK — public SDK owned by API PLATFORM]
├── Error Handling Framework (V1)                          ← NEW
├── Result & Failure Types (V1)                            ← NEW
└── Localization (V2)
    ├── Language Packs (V2)                                ← NEW
    ├── Translation Management (V2)                        ← NEW
    ├── RTL Support (V3)                                   ← NEW
    └── Regional Formats (V2)                              ← NEW

    ── RE-HOMED OUT OF SHARED CORE ──
    Settings & Configuration      → CONFIGURATION PLATFORM
    Configuration Management      → CONFIGURATION PLATFORM
    Feature Flags                 → CONFIGURATION PLATFORM
    Roles & Permissions (RBAC)    → IDENTITY & ACCESS PLATFORM
    Search Engine                 → SEARCH PLATFORM
    Notification Engine           → COMMUNICATION PLATFORM
    Audit Logs                    → AUDIT PLATFORM
    Activity Timeline             → AUDIT PLATFORM
    Background Jobs               → PLATFORM SERVICES (Job Runtime)

═══════════════════════════════════════════════════════════════

├── IDENTITY & ACCESS PLATFORM (V1)
│
├── Authentication (V1)
│   ├── Mobile OTP Login (V1)
│   ├── Email Login (V2)
│   ├── Social Login (V2)
│   ├── Enterprise SSO (SAML / OIDC) (V3)                 ← NEW
│   ├── Multi-Factor Authentication (V3)
│   └── Passkeys / WebAuthn (V3)                          ← RENAMED (was "Passwordless Login (Future)")
│
├── Authorization (V1)
│   ├── Roles & Permissions (RBAC) (V1)                   ← MERGED (from Shared Core)
│   ├── Permission Registry (V1)                          ← NEW
│   ├── Scope Resolution (V1)                             ← NEW
│   ├── ABAC Policies (V3)                                ← NEW
│   └── Policy Decision Point (V3)                        ← NEW
│
├── Session Management (V1)
│   ├── Token Issuance (V1)                               ← NEW
│   ├── Refresh & Rotation (V1)                           ← NEW
│   ├── Session Revocation (V1)                           ← RETAGGED V2→V1 (MP-GBR-26, AUTH-11.66)
│   └── Concurrent Session Limits (V1)                    ← RETAGGED V2→V1 (CFG-8, BR-6.31)
│
├── Device Management (V1)                                ← RETAGGED V2→V1 (BC-18 owns devices)
│   ├── Device Registration (V1)                          ← RETAGGED V2→V1 (Auth PRD v2.0 §6.4)
│   ├── Multi Device Management (V1)                      ← RETAGGED V2→V1 (Auth PRD v2.0 §6.7)
│   ├── Trusted Devices (V3)
│   └── Remote Device Logout (V2)
│
├── Service Identity (V2)                                 ← NEW
│   ├── Machine-to-Machine Auth (V2)
│   ├── Service Accounts (V2)
│   └── Workload Identity (V3)
│
├── Provisioning (V3)                                     ← NEW
│   ├── SCIM Provisioning (V3)
│   ├── Bulk User Provisioning (V2)
│   ├── Just-In-Time Provisioning (V3)
│   └── Deprovisioning (V3)
│
├── Consent Management (V2)                               ← NEW
│   ├── Terms Acceptance (V1)
│   ├── Privacy Consent (V2)
│   ├── Minor Guardian Consent (V2)
│   ├── AI Data Usage Consent (V2)
│   └── Consent Withdrawal (V3)
│
├── Support Impersonation (V3)                            ← NEW
│   ├── Impersonation Request (V3)
│   ├── Time-Bound Access (V3)
│   └── Impersonation Audit Trail (V3)
│
├── Student Identity & Profile (V1)
├── Parent Identity (V1)
├── Library Member Directory (V1)
├── Account Recovery (V1)
├── Identity Verification (V2)
├── Access Policies (V2)
├── Login History (V2)                                    [VIEW over AUDIT PLATFORM logs]
├── Account Security (V2)
└── Identity Lifecycle (V3)

═══════════════════════════════════════════════════════════════
LAYER 2 — DOMAIN PLATFORMS
═══════════════════════════════════════════════════════════════

├── LIBRARY MANAGEMENT PLATFORM (V1)
│   [DDD: CORE DOMAIN — highest investment, richest model]
│
├── Student Management (V1)
│   ├── Student Registration (V1)
│   │   ├── Basic Information (V1)
│   │   ├── Contact Details (V1)
│   │   ├── Parent Information (V1)
│   │   ├── Emergency Contact (V1)
│   │   ├── Documents (V1)
│   │   ├── Photo Upload (V1)
│   │   ├── Custom Fields (V2)
│   │   └── Bulk Import (V2)
│   │
│   ├── Student Profile (V1)
│   │   ├── Personal Information (V1)
│   │   ├── Membership Details (V1)
│   │   ├── Attendance Summary (V1)
│   │   ├── Seat Information (V1)
│   │   ├── Payment History (V1)
│   │   ├── Activity Timeline (V2)                        [VIEW over AUDIT PLATFORM]
│   │   ├── Documents (V2)
│   │   ├── Notes (V2)
│   │   └── AI Insights (V3)                              [surface of AI PLATFORM]
│   │
│   ├── Student Status (V1)
│   │   ├── Active (V1)
│   │   ├── Inactive (V1)
│   │   ├── Suspended (V2)
│   │   ├── Archived (V2)
│   │   └── Deleted (Future)
│   │
│   ├── Student Search (V1)                               [client of SEARCH PLATFORM]
│   ├── Student Filters (V1)
│   ├── Student Tags (V2)
│   ├── Student Groups (V2)
│   ├── Student Timeline (V2)
│   ├── Import & Export (V2)                              [client of Export Engine]
│   ├── Duplicate Detection & Merge (V2)                  ← NEW
│   └── Student Analytics (V3)                            [VIEW over ANALYTICS PLATFORM]
│
├── Membership Management (V1)
│   ├── Membership Plans (V1)
│   ├── Membership Creation (V1)
│   ├── Membership Renewal (V1)
│   ├── Membership Upgrade (V1)
│   ├── Membership Downgrade (V2)
│   ├── Membership Freeze (V2)
│   ├── Membership Transfer (V2)
│   ├── Membership Cancellation (V2)
│   ├── Proration Rules (V2)                              ← NEW (executed by BUSINESS PLATFORM)
│   ├── Auto Renewal (V3)
│   ├── Membership History (V2)
│   ├── Membership Analytics (V3)                         [VIEW over ANALYTICS PLATFORM]
│   └── Cross Library Membership (Future)
│
├── Attendance Management (V1)
│   ├── QR Attendance (V1)
│   ├── Dynamic QR (V1)
│   ├── GPS Verification (V1)
│   ├── Wi-Fi Verification (V1)
│   ├── Entry Tracking (V1)
│   ├── Exit Tracking (V1)
│   ├── Offline Attendance Capture (V1)                   ← NEW (uses Offline Sync Engine)
│   ├── Idempotent Check-In (V1)                          ← NEW (prevents duplicate punches)
│   ├── Anti-Fraud Controls (V2)                          ← NEW (proxy attendance, replayed QR)
│   ├── Clock Skew Handling (V2)                          ← NEW
│   ├── Late Entry Rules (V2)
│   ├── Early Exit Rules (V2)
│   ├── Attendance Corrections (V2)
│   ├── Attendance Policies (V2)
│   ├── Attendance Reports (V2)
│   ├── RFID Attendance (V3)
│   ├── Face Recognition (V3)
│   ├── NFC/BLE Attendance (V3)
│   └── Hybrid Attendance (Future)
│
├── Seat Management (V1)
│   ├── Seat Layout (V1)
│   ├── Floor Management (V1)
│   ├── Seat Categories (V1)
│   ├── Seat Assignment (V1)
│   ├── Seat Transfer (V1)
│   ├── Seat Availability (V1)
│   ├── Seat Locking & Concurrency (V1)                   ← NEW (prevents double-allocation)
│   ├── Occupancy Domain Service (V1)                     ← NEW
│   ├── Seat Reservation (V2)
│   ├── Seat Maintenance (V2)
│   ├── Seat History (V2)
│   ├── Drag & Drop Layout (V2)
│   ├── Auto Seat Assignment (V3)
│   ├── 3D Seat Layout (Future)
│   └── Smart Seat Recommendations (Future)               [algorithm owned by AI PLATFORM]
│
├── Parent Portal (V1)
│   ├── Student Overview (V1)
│   ├── Attendance (V1)
│   ├── Membership Status (V1)
│   ├── Fee Status (V1)
│   ├── Notifications (V1)
│   ├── Reports (V2)
│   ├── Communication (V2)
│   └── AI Parent Assistant (Future)                      [owned by AI PLATFORM]
│
├── Reception Dashboard (V1)                              [presentation over ANALYTICS read-models]
│   ├── Walk-in Registration (V1)
│   ├── Student Check-In (V1)
│   ├── Student Check-Out (V1)
│   ├── Seat Assignment (V1)
│   ├── Membership Renewal (V1)
│   ├── Payment Collection (V1)
│   ├── Visitor Entry (V2)
│   ├── Daily Summary (V2)
│   ├── Shift Handover (V2)                               ← NEW
│   └── Reception Analytics (V3)
│
├── Manager Dashboard (V1)
│   ├── Daily Operations (V1)
│   ├── Student Monitoring (V1)
│   ├── Attendance Monitoring (V1)
│   ├── Staff Monitoring (V2)
│   ├── Revenue Monitoring (V2)
│   ├── Issue Management (V2)
│   ├── Performance Reports (V3)
│   └── AI Recommendations (V3)
│
├── Owner Dashboard (V1)
│   ├── Business Overview (V1)
│   ├── Occupancy Overview (V1)
│   ├── Revenue Overview (V1)
│   ├── Membership Overview (V1)
│   ├── Attendance Overview (V1)
│   ├── Growth Reports (V2)
│   ├── Financial Reports (V2)
│   ├── Multi Library Dashboard (V3)
│   └── AI Business Insights (V3)
│
├── Revenue & Finance (V1)                                [domain intent — rails owned by BUSINESS PLATFORM]
│   ├── Student Payments (V1)
│   ├── Fee Collection (V1)
│   ├── Fee Structures (V1)                               ← NEW
│   ├── Discounts (V1)
│   ├── Refunds (V1)
│   ├── Expenses (V2)
│   ├── Profit & Loss (V2)
│   ├── Cash Flow (V2)
│   ├── Cash Reconciliation (V2)                          ← NEW
│   ├── Tax Reports (V3)
│   ├── GST Support (V3)
│   └── Financial Forecasting (Future)
│
├── Analytics & Growth Reports (V1)                       [VIEWS over ANALYTICS PLATFORM]
│   ├── Student Analytics (V1)
│   ├── Attendance Analytics (V1)
│   ├── Revenue Analytics (V1)
│   ├── Occupancy Analytics (V1)
│   ├── Membership Analytics (V2)
│   ├── Marketing Analytics (V2)
│   ├── Predictive Analytics (V3)
│   └── AI Growth Insights (V3)
│
├── Library Settings (V1)                                 [values stored via CONFIGURATION PLATFORM]
│   ├── Library Profile (V1)
│   ├── Working Hours (V1)
│   ├── Holidays (V1)
│   ├── Membership Settings (V1)
│   ├── Attendance Rules (V2)
│   ├── Seat Rules (V2)
│   ├── Notification Settings (V2)
│   └── Branding (V3)
│
├── Business Automation (V2)                              [domain rules executed by WORKFLOW PLATFORM]
│   ├── Automated Reminders (V2)
│   ├── Fee Reminder (V2)
│   ├── Membership Expiry Reminder (V2)
│   ├── Attendance Alerts (V2)
│   ├── Workflow Automation (V3)
│   ├── Smart Rules Engine (V3)
│   └── AI Automation (Future)
│
├── Staff Management (V2)
│   ├── Staff Registration (V2)
│   ├── Roles & Permissions (V2)                          [admin UI over IDENTITY PLATFORM]
│   ├── Attendance (V2)
│   ├── Shift Scheduling (V2)                             ← NEW
│   ├── Payroll Support (V3)
│   ├── Performance Review (V3)
│   └── Staff Analytics (V3)
│
├── Visitor Management (V2)
│   ├── Visitor Registration (V2)
│   ├── Visitor Pass (V2)
│   ├── Visitor Log (V2)
│   ├── Visitor Approval (V3)
│   └── Visitor Reports (V3)
│
├── Inventory Management (V2)
│   ├── Books (V2)
│   ├── Book Issue & Return (V2)                          ← NEW
│   ├── Furniture (V2)
│   ├── Devices (V2)
│   ├── Consumables (V2)
│   ├── Stock Tracking (V2)
│   └── Inventory Reports (V3)
│
├── Multi-Branch Management (V3)                          ← NEW
│   ├── Branch Registry (V3)
│   ├── Branch Hierarchy (V3)
│   ├── Cross-Branch Reporting (V3)
│   └── Branch Level Permissions (V3)
│
└── Asset Management (V3)
    ├── Asset Registry (V3)
    ├── Asset Allocation (V3)
    ├── Maintenance Schedule (V3)
    ├── Warranty Tracking (V3)
    ├── Depreciation Reports (Future)
    └── Asset Analytics (Future)

═══════════════════════════════════════════════════════════════

├── GLOBAL STUDENT PLATFORM (V1)
│   [DDD: SUPPORTING DOMAIN — social graph & community]
│
├── Global Student Identity (V1)
│   ├── Global Profile (V1)
│   ├── Username Management (V1)
│   ├── Public Profile (V1)
│   ├── Privacy Settings (V1)
│   ├── Profile Verification (V2)
│   ├── Multiple Library Memberships (V2)
│   ├── Academic Portfolio (V3)
│   └── Cross Product Identity (Future)
│
├── Trust & Safety (V1)                                   ← NEW (non-negotiable for a minor-heavy platform)
│   ├── Report & Abuse Flow (V1)
│   ├── Content Moderation Pipeline (V2)
│   ├── Automated Content Filters (V2)
│   ├── Minor Safety Controls (V1)
│   ├── Anti-Spam & Rate Limits (V1)
│   ├── Block Enforcement (V1)
│   ├── Moderator Console (V2)
│   ├── Strike & Ban System (V3)
│   └── Appeals Process (V3)
│
├── Student Discovery (V1)
│   ├── Search Students (V1)                              [client of SEARCH PLATFORM]
│   ├── Discovery Privacy Controls (V1)                   ← NEW
│   ├── Nearby Students (V2)
│   ├── Recommended Students (V2)
│   ├── Common Interests (V2)
│   ├── Smart Matching (V3)
│   └── AI Discovery (Future)
│
├── Friends (V1)
│   ├── Send Request (V1)
│   ├── Accept / Reject (V1)
│   ├── Friends List (V1)
│   ├── Request Rate Limits (V1)                          ← NEW
│   ├── Mutual Friends (V2)
│   ├── Close Friends (V2)
│   ├── Block Users (V2)
│   └── Friend Suggestions (V3)
│
├── Chat System (V1)
│   ├── One-to-One Chat (V1)
│   ├── Message Delivery Guarantees (V1)                  ← NEW
│   ├── Message Retention Policy (V2)                     ← NEW
│   ├── Encryption at Rest (V2)                           ← NEW
│   ├── Read Receipts & Presence (V2)                     ← NEW
│   ├── Group Chat (V2)
│   ├── Image Sharing (V2)
│   ├── File Sharing (V2)
│   ├── Voice Messages (V3)
│   ├── Video Calling (Future)
│   └── AI Chat Assistant (Future)
│
├── Media & Text Sharing (V2)
│   ├── Images (V2)
│   ├── PDFs (V2)
│   ├── Notes (V2)
│   ├── Links (V2)
│   ├── Malware & Content Scanning (V2)                   ← NEW
│   ├── Videos (V3)
│   └── Cloud Attachments (V3)
│
├── Community (V2)
│   ├── Public Communities (V2)
│   ├── Private Communities (V2)
│   ├── Community Feed (V2)
│   ├── Community Roles (V2)                              ← NEW
│   ├── Moderation (V3)
│   └── Community Analytics (V3)
│
├── Study Groups (V2)
│   ├── Create Group (V2)
│   ├── Join Group (V2)
│   ├── Invite Members (V2)
│   ├── Shared Notes (V2)
│   ├── Study Sessions (V3)
│   └── AI Study Rooms (Future)
│
├── Notes Sharing (V2)
│   ├── Upload Notes (V2)
│   ├── Download Notes (V2)
│   ├── Categories (V2)
│   ├── Copyright & Takedown (V2)                         ← NEW
│   ├── Ratings (V3)
│   ├── Comments (V3)
│   └── AI Note Summary (Future)
│
├── Student Marketplace (V3)
│   ├── Buy & Sell Books (V3)
│   ├── Stationery (V3)
│   ├── Listing Moderation (V3)                           ← NEW
│   ├── Digital Resources (Future)
│   ├── Order History (V3)
│   └── Marketplace Analytics (Future)
│
├── Student Portfolio (V3)
│   ├── Certificates (V3)
│   ├── Achievements (V3)
│   ├── Skills (V3)
│   ├── Projects (Future)
│   └── Resume Builder (Future)
│
├── Student Reputation System (V3)
│   ├── Reputation Score (V3)
│   ├── Badges (V3)
│   ├── Levels (V3)
│   ├── Anti-Gaming Controls (V3)                         ← NEW
│   ├── Leaderboards (Future)
│   └── Trust Score (Future)
│
├── Events (V3)
│   ├── Workshops (V3)
│   ├── Seminars (V3)
│   ├── Competitions (V3)
│   ├── Event Registration (V3)
│   └── Event Analytics (Future)
│
└── Student Achievements (V3)
    ├── Milestones (V3)
    ├── Rewards (V3)
    ├── Streaks (V3)
    ├── Certificates (Future)
    └── Achievement Analytics (Future)

═══════════════════════════════════════════════════════════════
LAYER 3 — INTELLIGENCE & ORCHESTRATION
═══════════════════════════════════════════════════════════════

├── AI PLATFORM (V1)
│
├── AI Orchestrator (V1)
│   ├── Request Routing (V1)
│   ├── Model Selection (V1)
│   ├── Context Assembly (V1)                             ← NEW
│   ├── Provider Fallback (V2)
│   ├── Cost Optimization (V2)
│   ├── Token Budgeting (V2)                              ← NEW
│   ├── Response Caching (V2)                             ← NEW
│   └── Load Balancing (V3)
│
├── AI Governance (V2)                                    ← NEW (largest AI gap closed)
│   ├── Model Cards (V2)
│   ├── AI Data Usage Policy (V2)
│   ├── Consent for AI Processing (V2)
│   ├── Regional Model Routing (V3)
│   ├── Model Approval Process (V2)
│   ├── AI Incident Log (V3)
│   └── Responsible AI Reporting (V3)
│
├── PII Redaction Gateway (V2)                            ← NEW
│   ├── Inbound Redaction (V2)
│   ├── Outbound Scrubbing (V2)
│   ├── Tokenization & Rehydration (V3)
│   └── Redaction Audit (V3)
│
├── Human-in-the-Loop (V2)                                ← NEW
│   ├── AI Suggestion Review (V2)
│   ├── Approval Before Write (V2)
│   ├── Confidence Thresholds (V2)
│   └── Override & Feedback Capture (V3)
│
├── AI Super Assistant (V1)
│   ├── Student Assistant (V1)
│   ├── Library Assistant (V1)
│   ├── Owner Assistant (V1)
│   ├── Reception Assistant (V2)
│   ├── Parent Assistant (V2)
│   └── Multi-Agent Assistant (Future)
│
├── AI Study Coach (V1)
│   ├── Study Plans (V1)
│   ├── Daily Goals (V1)
│   ├── Progress Tracking (V1)
│   ├── Focus Suggestions (V2)
│   ├── Revision Planner (V2)
│   └── Personalized Learning (V3)
│
├── AI Library Assistant (V1)
│   ├── Library Q&A (V1)
│   ├── Membership Help (V1)
│   ├── Attendance Help (V1)
│   ├── Seat Assistance (V1)
│   ├── Library Insights (V2)
│   └── Voice Assistant (Future)
│
├── AI Business Advisor (V2)
│   ├── Revenue Suggestions (V2)
│   ├── Occupancy Optimization (V2)
│   ├── Cost Analysis (V2)
│   ├── Growth Recommendations (V3)
│   └── Predictive Business Planning (Future)
│
├── RAG Engine (V2)
│   ├── Ingestion Pipeline (V2)
│   ├── Chunking Strategy (V2)
│   ├── Retrieval Pipeline (V2)
│   ├── Tenant Isolation Guarantees (V2)                  ← HARDENED
│   ├── Permission-Aware Retrieval (V2)                   ← NEW
│   ├── Re-Ranking (V3)
│   └── Grounding & Citations (V3)
│
├── Embedding Service (V2)
│   ├── Embedding Models (V2)
│   ├── Batch Embedding (V2)
│   ├── Incremental Re-Embedding (V3)
│   └── Embedding Cache (V3)
│
├── Vector Search (V2)
│   ├── Similarity Search (V2)
│   ├── Metadata Filtering (V2)
│   ├── Namespace Partitioning (V2)
│   ├── Hybrid Search (V3)
│   └── Relevance Tuning (V3)
│
├── Prompt Registry (V1)                                  ← MERGED OWNER (Prompt Library + Prompt Versioning)
│   ├── Prompt Catalog (V1)
│   ├── Prompt Library (V1)                               ← MERGED (was duplicate module)
│   ├── Prompt Versioning (V2)                            ← MERGED (was duplicate module)
│   ├── Prompt Metadata (V1)
│   ├── Prompt Ownership (V2)
│   ├── Prompt Approval (V3)
│   └── Prompt Deprecation (V3)
│
├── Prompt Templates (V1)
│   ├── Role Templates (V1)
│   ├── Variable Injection (V1)
│   ├── Localization Templates (V2)
│   ├── Template Composition (V2)
│   └── Template Testing (V3)
│
├── AI Evaluation (V3)
│   ├── Prompt Evaluation (V3)                            ← MERGED (was duplicate module)
│   ├── Accuracy Evaluation (V3)
│   ├── Regression Suites (V3)
│   ├── Hallucination Detection (V3)
│   ├── Golden Datasets (V3)
│   ├── Human Review Loop (V3)
│   └── Continuous Evaluation (Future)
│
├── Agent Registry (V3)
│   ├── Agent Definitions (V3)
│   ├── Agent Capabilities (V3)
│   ├── Agent Permissions (V3)
│   ├── Agent Versioning (V3)
│   └── Agent Lifecycle (Future)
│
├── AI Memory Store (V2)                                  ← MERGED OWNER (absorbed AI Memory Layer)
│   ├── AI Memory Layer (V2)                              ← MERGED (access API)
│   ├── Short Term Memory (V2)
│   ├── Long Term Memory (V2)
│   ├── Conversation Store (V2)
│   ├── User Preference Memory (V3)
│   └── Memory Retention Policy (V3)
│
├── AI Smart Actions (V2)
│   ├── One-Click Actions (V2)
│   ├── Smart Shortcuts (V2)
│   ├── Action Permission Checks (V2)                     ← NEW
│   ├── Context Actions (V3)
│   └── Workflow Automation (Future)                      [executed by WORKFLOW PLATFORM]
│
├── AI Smart Navigation (V2)
│   ├── Context Navigation (V2)
│   ├── Suggested Screens (V2)
│   ├── Deep Linking (V2)
│   └── Predictive Navigation (V3)
│
├── AI Recommendation Engine (V2)
│   ├── Student Recommendations (V2)
│   ├── Membership Suggestions (V2)
│   ├── Seat Recommendations (V3)
│   ├── Library Recommendations (V3)
│   └── Cross Product Recommendations (Future)
│
├── ML & Prediction Services (V3)                         ← NEW (owns models behind Analytics surfaces)
│   ├── Churn Prediction (V3)
│   ├── Occupancy Forecasting (V3)
│   ├── Revenue Forecasting (V3)
│   ├── Feature Store (V3)
│   └── Model Training Pipeline (Future)
│
├── Tool Registry (V1)
├── Tool Permissions (V3)
├── AI Analytics (V2)
├── AI Cost Monitoring (V2)
├── AI Usage Analytics (V2)
├── AI Observability Hooks (V2)                           ← NEW (traces to OBSERVABILITY PLATFORM)
├── Model Fallback (V2)
├── AI Model Management (V2)
├── AI Provider Abstraction (V2)                          [Hexagonal port]
├── AI Rate Limits & Quotas (V2)                          ← NEW
├── MCP Server (V3)
├── MCP Client (V3)
├── Context Manager (V3)
├── AI Safety & Guardrails (V2)
│   ├── Input Guardrails (V2)                             ← NEW
│   ├── Output Guardrails (V2)                            ← NEW
│   ├── Jailbreak Detection (V3)                          ← NEW
│   └── Toxicity Filters (V2)                             ← NEW
│
└── Autonomous AI Agents (Future)

    ── RE-HOMED OUT OF AI PLATFORM ──
    AI Workflow Engine  → WORKFLOW PLATFORM (AI Workflow Automation)

═══════════════════════════════════════════════════════════════

├── WORKFLOW PLATFORM (V2)
│   [OWNS: orchestration, scheduling, rules · RUNTIME owned by PLATFORM SERVICES]
│
├── Workflow Engine (V2)
│   ├── Workflow Definition (V2)
│   ├── State Machine (V2)
│   ├── Step Execution (V2)
│   ├── Idempotency Keys (V2)                             ← NEW
│   ├── Parallel & Branching (V3)
│   ├── Retry & Compensation (V3)
│   ├── Dead Letter Handling (V2)                         ← NEW
│   ├── Concurrency Limits (V3)                           ← NEW
│   └── Long Running Workflows (V3)
│
├── Saga Orchestration (V3)                               ← NEW
│   ├── Distributed Transactions (V3)
│   ├── Compensating Actions (V3)
│   └── Saga State Tracking (V3)
│
├── Business Rules Engine (V2)
│   ├── Rule Definition (V2)
│   ├── Condition Builder (V2)
│   ├── Action Builder (V2)
│   ├── Rule Priority (V2)
│   ├── Rule Testing (V3)
│   └── Rule Versioning (V3)
│
├── Approval Engine (V2)
│   ├── Approval Requests (V2)
│   ├── Single Level Approval (V2)
│   ├── Multi Level Approval (V3)
│   ├── Delegation (V3)
│   └── Escalation (V3)
│
├── Event Triggers (V2)                                   [subscribes to EVENT PLATFORM]
│   ├── Domain Event Triggers (V2)
│   ├── Webhook Triggers (V2)
│   ├── Threshold Triggers (V2)
│   └── Composite Triggers (V3)
│
├── Scheduler (V2)                                        [OWNER of scheduling intent]
│   ├── Cron Jobs (V2)
│   ├── Delayed Jobs (V2)
│   ├── Recurring Tasks (V2)
│   ├── Timezone Handling (V2)
│   ├── Missed Run Recovery (V2)                          ← NEW
│   └── Job Prioritisation (V3)
│
├── Automation Rules (V2)
│   ├── Reminder Automation (V2)
│   ├── Expiry Automation (V2)
│   ├── Attendance Automation (V2)
│   ├── Finance Automation (V3)
│   └── Custom Automation (V3)
│
├── Workflow Templates (V3)
│   ├── Prebuilt Templates (V3)
│   ├── Tenant Templates (V3)
│   ├── Template Cloning (V3)
│   └── Template Marketplace (Future)
│
├── Workflow Analytics (V3)
│   ├── Execution Metrics (V3)
│   ├── Bottleneck Analysis (V3)
│   ├── Failure Analysis (V3)
│   └── SLA Tracking (Future)
│
├── Workflow History (V2)
│   ├── Execution Log (V2)
│   ├── Step Audit Trail (V2)
│   ├── Replay Execution (V3)
│   └── Retention Policy (V3)
│
└── AI Workflow Automation (Future)
    ├── AI Workflow Engine (V2)                           ← MERGED (re-homed from AI PLATFORM)
    ├── Natural Language Workflow Builder (Future)
    ├── AI Suggested Automations (Future)
    ├── Self Optimising Workflows (Future)
    └── Autonomous Operations (Future)

═══════════════════════════════════════════════════════════════

├── EVENT PLATFORM (V2)                                   ← NEW PLATFORM (highest-value addition)
│   [The runtime event backbone — enables Event-Driven & Microservice readiness]
│
├── Event Bus (V2)
│   ├── Message Broker (V2)
│   ├── Topics & Partitions (V2)
│   ├── Publish API (V2)
│   ├── Subscribe API (V2)
│   └── Ordering Guarantees (V3)
│
├── Domain Event Publishing (V2)
│   ├── Transactional Outbox (V2)
│   ├── Event Envelope Standard (V2)
│   ├── Tenant Context in Events (V2)
│   └── Correlation & Causation IDs (V2)
│
├── Event Schema Registry (V2)
│   ├── Schema Definitions (V2)
│   ├── Schema Compatibility Rules (V2)
│   ├── Schema Evolution (V3)
│   └── Contract Validation (V2)
│
├── Event Consumers (V2)
│   ├── Consumer Groups (V2)
│   ├── At-Least-Once Delivery (V2)
│   ├── Idempotent Consumers (V2)
│   ├── Consumer Lag Monitoring (V2)
│   └── Poison Message Handling (V3)
│
├── Event Replay (V3)
│   ├── Replay by Time Range (V3)
│   ├── Replay by Aggregate (V3)
│   └── Read Model Rebuild (V3)
│
├── Dead Letter Queue (V2)
│   ├── Failed Event Store (V2)
│   ├── Manual Reprocess (V2)
│   └── DLQ Alerting (V2)
│
├── Change Data Capture (V3)
│   ├── DB Change Streams (V3)
│   ├── CDC to Event Mapping (V3)
│   └── CDC to Data Lake (V3)
│
├── Event Governance (V3)
│   ├── Event Ownership (V3)
│   ├── Deprecation of Events (V3)
│   └── Event Documentation Sync (V3)
│
└── Event Analytics (V3)
    ├── Event Volume Metrics (V3)
    ├── Latency Metrics (V3)
    └── Failure Rate Metrics (V3)

═══════════════════════════════════════════════════════════════
LAYER 4 — BUSINESS & ENGAGEMENT
═══════════════════════════════════════════════════════════════

├── BUSINESS PLATFORM (V1)
│
├── SaaS Subscription (V1)
│   ├── Free Trial (V1)
│   ├── Monthly Plans (V1)
│   ├── Quarterly Plans (V1)
│   ├── Yearly Plans (V1)
│   ├── Plan Catalog (V1)                                 ← NEW
│   ├── Enterprise Plans (V3)
│   └── Custom Plans (Future)
│
├── Entitlement Service (V1)                              ← NEW (single source of truth for limits)
│   ├── Entitlement Resolution API (V1)
│   ├── Plan to Feature Mapping (V1)
│   ├── Quota Tracking (V2)
│   ├── Overage Handling (V3)
│   └── Grace Periods (V2)
│
├── Subscription Plan Enforcement (V1)
│   ├── Feature Limits (V1)
│   ├── Seat Limits (V1)
│   ├── Student Limits (V1)
│   ├── Usage Limits (V2)
│   ├── API Limits (V2)
│   └── AI Usage Limits (V2)
│
├── Subscription Lifecycle Management (V1)
│   ├── Trial (V1)
│   ├── Active (V1)
│   ├── Expired (V1)
│   ├── Suspended (V2)
│   ├── Cancelled (V2)
│   └── Reactivation (V2)
│
├── Customer Lifecycle (V2)                               ← NEW
│   ├── Onboarding Journey (V2)
│   ├── Activation Milestones (V2)
│   ├── Health Score (V3)
│   ├── Churn Risk Signals (V3)
│   ├── Winback Campaigns (V3)
│   └── Expansion & Upsell (V3)
│
├── Student Payments (V1)                                 [OWNER of money movement]
│   ├── Online Payments (V1)
│   ├── Cash Payments (V1)
│   ├── UPI Payments (V1)
│   ├── Card Payments (V1)
│   ├── Payment Idempotency (V1)                          ← NEW
│   ├── Partial Payments (V2)
│   └── Split Payments (V3)
│
├── Payment Gateway (V1)
│   ├── Payment Gateway Abstraction (V1)                  ← NEW (Hexagonal port)
│   ├── Razorpay (V1)
│   ├── Payment Verification (V1)
│   ├── Webhook Reconciliation (V1)                       ← NEW
│   ├── Refund Management (V2)
│   ├── Payment Retry (V2)
│   └── Multiple Gateways (V3)
│
├── Billing & Invoicing (V1)
│   ├── Invoice Generation (V1)
│   ├── Receipt Generation (V1)
│   ├── Proration Engine (V2)                             ← NEW
│   ├── Dunning Management (V2)                           ← NEW
│   ├── Revenue Recognition (V3)                          ← NEW
│   ├── Credit Notes (V2)
│   ├── Debit Notes (V2)
│   └── GST Invoices (V3)
│
├── Revenue Analytics (V1)                                [VIEW over ANALYTICS PLATFORM]
├── Financial Reports (V1)
├── AdMob Monetization (V2)
├── Coupon & Offers (V2)
├── Referral System (V2)
├── Tax Management (V3)
│   ├── Tax Jurisdiction Rules (V3)                       ← NEW
│   └── Tax Calculation Engine (V3)                       ← NEW
│
├── Financial Audit Support (V3)
├── Expense Management (V2)
├── Business Insights (V2)
├── Multi-Library Billing (V3)
└── Franchise Management (Future)

═══════════════════════════════════════════════════════════════

├── COMMUNICATION PLATFORM (V1)
│
├── Delivery Orchestration (V1)                           ← NEW (absorbed Shared Core Notification Engine)
│   ├── Notification Engine (V1)                          ← MERGED (from Shared Core)
│   ├── Channel Selection (V1)
│   ├── Channel Fallback (V2)
│   ├── Deduplication (V2)
│   ├── Throttling & Batching (V2)
│   ├── Quiet Hours & DND (V2)
│   ├── Delivery Guarantees (V2)
│   └── Delivery Status Tracking (V2)
│
├── Notification Management (V1)
│   ├── Notification Center (V1)
│   ├── Notification History (V1)
│   ├── Notification Preferences (V1)                     ← MERGED (was duplicated top-level)
│   ├── Scheduled Notifications (V2)
│   └── Smart Notifications (V3)
│
├── Push Notification Engine (V1)
│   ├── Firebase Cloud Messaging (V1)
│   ├── Topic Notifications (V1)
│   ├── Device Notifications (V1)
│   ├── Token Lifecycle Management (V1)                   ← NEW
│   ├── Bulk Notifications (V2)
│   └── Rich Notifications (V3)
│
├── Email Service (V1)
│   ├── OTP Emails (V2)                                   ← RETAGGED V1→V2 (MP-GBR-25: mobile OTP is the sole V1 factor)
│   ├── Transaction Emails (V1)
│   ├── Bounce & Complaint Handling (V2)                  ← NEW
│   ├── Bulk Emails (V2)
│   └── Email Analytics (V2)
│
├── SMS Service (V1)
│   ├── OTP SMS (V1)
│   ├── Transaction SMS (V1)
│   ├── DLT / TRAI Compliance (V1)                        ← NEW
│   ├── Bulk SMS (V2)
│   └── SMS Analytics (V2)
│
├── In-App Messaging (V1)
│   ├── Inbox (V1)
│   ├── System Messages (V1)
│   ├── Broadcast Messages (V2)
│   ├── Smart Inbox (V3)
│   └── AI Message Drafting (Future)
│
├── Notification Templates (V2)                           [OWNER of all channel templates]
│   ├── Email Templates (V1)                              ← CONSOLIDATED
│   ├── SMS Templates (V1)                                ← CONSOLIDATED
│   ├── Push Templates (V2)                               ← CONSOLIDATED
│   ├── Template Localization (V2)                        ← NEW
│   └── Template Versioning (V3)                          ← NEW
│
├── Consent & Unsubscribe (V2)                            ← NEW
│   ├── Channel Consent (V2)
│   ├── Unsubscribe Links (V2)
│   └── Suppression Lists (V2)
│
├── Announcement System (V1)
├── Broadcast Messaging (V2)
├── Communication Analytics (V2)
├── WhatsApp Integration (V3)                             [adapter in INTEGRATION PLATFORM]
├── Voice Calls (Future)
└── Video Broadcasting (Future)

═══════════════════════════════════════════════════════════════

├── SEARCH PLATFORM (V2)
│
├── Search Engine Core (V2)                               ← MERGED (Shared Core: Search Engine)
│   ├── Query Parser (V2)
│   ├── Ranking Engine (V2)
│   ├── Search Relevance Config (V3)
│   └── Query Rewriting (V3)
│
├── Global Search (V2)
│   ├── Cross Module Search (V2)
│   ├── Unified Result Ranking (V2)
│   ├── Tenant Scoped Search (V2)
│   ├── Permission Aware Results (V2)
│   └── Command Palette Search (V3)
│
├── Full Text Search (V2)
│   ├── Tokenisation & Analysers (V2)
│   ├── Fuzzy Matching (V2)
│   ├── Highlighting (V2)
│   ├── Synonyms (V3)
│   └── Multi-Language Support (V3)
│
├── Search Index (V2)
│   ├── Index Definitions (V2)
│   ├── Tenant Index Isolation (V2)                       ← NEW
│   ├── Permission-Aware Indexing (V2)                    ← NEW
│   ├── Real-Time Indexing (V2)                           [driven by EVENT PLATFORM]
│   ├── Bulk Reindexing (V2)
│   ├── Index Backfill Jobs (V2)                          ← NEW
│   ├── Index Health (V3)
│   └── Index Versioning (V3)
│
├── Search Filters (V2)
│   ├── Faceted Filters (V2)
│   ├── Range Filters (V2)
│   ├── Sort Options (V2)
│   └── Dynamic Facets (V3)
│
├── Search Suggestions (V3)
│   ├── Autocomplete (V3)
│   ├── Did You Mean (V3)
│   ├── Trending Searches (V3)
│   └── Personalised Suggestions (Future)
│
├── Saved Searches (V3)
│   ├── Save Query (V3)
│   ├── Shared Searches (V3)
│   ├── Quick Views (V3)
│   └── Search Alerts (Future)
│
├── Search Analytics (V3)
│   ├── Query Volume (V3)
│   ├── Zero Result Queries (V3)
│   ├── Click Through Rate (V3)
│   └── Relevance Feedback (Future)
│
└── AI Search (Future)
    ├── Semantic Search (Future)
    ├── Natural Language Query (Future)
    ├── Conversational Search (Future)
    └── Answer Generation (Future)

═══════════════════════════════════════════════════════════════
LAYER 5 — INSIGHT & TRUST
═══════════════════════════════════════════════════════════════

├── ANALYTICS PLATFORM (V1)
│
├── Metric Layer (Semantic Layer) (V1)                    ← NEW (prevents metric drift)
│   ├── Metric Definitions (V1)
│   ├── Dimension Definitions (V1)
│   ├── Certified Metrics (V2)
│   ├── Metric Versioning (V3)
│   └── Metric Documentation (V2)
│
├── Analytics Data Contracts (V2)                         ← NEW
│   ├── Source Contracts (V2)
│   ├── Freshness SLAs (V2)
│   └── Breaking Change Detection (V3)
│
├── Read Model Store (V2)                                 ← NEW (CQRS — protects OLTP)
│   ├── Materialized Views (V2)
│   ├── Aggregation Tables (V2)
│   ├── Incremental Refresh (V2)
│   └── Rebuild from Events (V3)
│
├── Dashboard Engine (V1)
│   ├── Owner Dashboard (V1)
│   ├── Manager Dashboard (V1)
│   ├── Reception Dashboard (V1)
│   ├── Parent Dashboard (V1)
│   ├── Student Dashboard (V1)                            ← NEW
│   └── Executive Dashboard (V2)
│
├── Business Intelligence (V1)
│   ├── Revenue Analytics (V1)
│   ├── Student Analytics (V1)
│   ├── Attendance Analytics (V1)
│   ├── Occupancy Analytics (V1)
│   ├── Membership Analytics (V2)
│   └── Growth Analytics (V2)
│
├── Product Analytics (V2)                                ← NEW
│   ├── Event Tracking (V2)
│   ├── Funnels (V2)
│   ├── Cohorts (V2)
│   ├── Retention Curves (V3)
│   └── Feature Adoption (V2)
│
├── Reporting Engine (V1)
│   ├── Daily Reports (V1)
│   ├── Weekly Reports (V1)
│   ├── Monthly Reports (V1)
│   ├── Custom Reports (V2)                               ← MERGED (was duplicated top-level)
│   ├── Scheduled Reports (V2)                            ← MERGED (was duplicated top-level)
│   └── Report Distribution (V2)                          ← NEW
│
├── KPI Engine (V2)
│   ├── Revenue KPIs (V2)
│   ├── Operational KPIs (V2)
│   ├── Student KPIs (V2)
│   ├── Financial KPIs (V2)
│   └── AI KPIs (V3)
│
├── Data Visualization (V1)
│   ├── Charts (V1)
│   ├── Graphs (V1)
│   ├── Heatmaps (V2)
│   ├── Trend Analysis (V2)
│   └── Interactive Dashboards (V3)
│
├── AI Insights (V2)                                      [models owned by AI PLATFORM]
├── Predictive Analytics (V3)                             [models owned by AI PLATFORM]
├── Forecasting (V3)                                      [models owned by AI PLATFORM]
├── Export Engine (V1)                                    [OWNER of generic export]
│   ├── PDF Export (V1)
│   ├── Excel Export (V1)
│   ├── CSV Export (V1)
│   ├── Large Export Jobs (V2)                            ← NEW
│   ├── Scheduled Export (V2)
│   └── API Export (V3)
│
└── Executive Analytics (V3)

═══════════════════════════════════════════════════════════════

├── AUDIT PLATFORM (V1)
│
├── Audit Logs (V1)                                       ← MERGED OWNER (from Shared Core)
│   ├── User Action Logs (V1)
│   ├── System Action Logs (V1)
│   ├── Admin Action Logs (V1)
│   ├── Login & Access Logs (V2)
│   ├── AI Action Logs (V2)                               ← NEW
│   ├── Immutable Append-Only Store (V2)                  ← NEW
│   └── Tamper Evident Logging (V3)
│
├── Activity Timeline (V1)                                ← MERGED (from Shared Core)
│   ├── Entity Timeline (V1)
│   ├── User Timeline (V1)
│   └── Tenant Timeline (V2)
│
├── Entity History (V2)
│   ├── Student History (V2)
│   ├── Membership History (V2)
│   ├── Attendance History (V2)
│   ├── Payment History (V2)
│   └── Seat History (V2)
│
├── Change History (V2)
│   ├── Field Level Diff (V2)
│   ├── Before / After Snapshots (V2)
│   ├── Actor Attribution (V2)
│   └── Restore Previous Value (V3)
│
├── Access Transparency (V3)                              ← NEW
│   ├── Support Access Log (V3)
│   ├── Tenant Visible Access Report (V3)
│   └── Impersonation Records (V3)
│
├── Compliance Reports (V3)
│   ├── Data Access Reports (V3)
│   ├── Privacy Compliance (V3)
│   ├── Financial Compliance (V3)
│   └── Regulatory Reports (Future)
│
├── Audit Reports (V2)
│   ├── Daily Audit Report (V2)
│   ├── Module Audit Report (V2)
│   ├── User Audit Report (V2)
│   └── Anomaly Report (V3)
│
├── Audit Search (V2)                                     ← NEW [client of SEARCH PLATFORM]
├── Export Audit Logs (V2)
│   ├── CSV Export (V2)
│   ├── PDF Export (V2)
│   ├── Scheduled Export (V3)
│   └── SIEM Streaming (Future)
│
└── Retention Policies (V3)
    ├── Retention Rules (V3)
    ├── Archival (V3)
    ├── Purge Policy (V3)
    └── Legal Hold (Future)

═══════════════════════════════════════════════════════════════
LAYER 6 — INTERFACE & INTEGRATION
═══════════════════════════════════════════════════════════════

├── API PLATFORM (V1)
│
├── API Gateway (V1)
│   ├── Request Routing (V1)
│   ├── Authentication (V1)
│   ├── Authorization (V1)
│   ├── Tenant Resolution (V1)                            ← NEW
│   ├── Request Validation (V1)                           ← NEW
│   ├── Rate Limiting (V2)
│   └── API Caching (V2)
│
├── API Contracts (V1)                                    ← NEW (OpenAPI = source of truth)
│   ├── OpenAPI Specifications (V1)
│   ├── Contract First Workflow (V1)
│   ├── Code Generation (V2)
│   └── Breaking Change Detection (V2)
│
├── Internal APIs (V1)
│   ├── Module to Module APIs (V1)
│   ├── Contract Definitions (V1)
│   ├── Internal Auth (V1)
│   └── Backward Compatibility (V2)
│
├── External APIs (V2)
│   ├── Partner APIs (V2)
│   ├── Tenant APIs (V2)
│   ├── Usage Quotas (V2)
│   └── Sandbox Environment (V3)
│
├── Admin APIs (V1)
│   ├── Tenant Administration (V1)
│   ├── User Administration (V1)
│   ├── Configuration APIs (V2)
│   └── Privileged Action Audit (V2)
│
├── Service APIs (V1)
│   ├── Service to Service Contracts (V1)
│   ├── Service Discovery (V2)
│   ├── Circuit Breaker (V2)
│   ├── Timeout & Retry Policy (V2)                       ← NEW
│   └── Idempotency Support (V2)
│
├── BFF Layer (V2)                                        ← NEW (mobile-optimised aggregation)
│   ├── Mobile BFF (V2)
│   ├── Web Admin BFF (V2)
│   ├── Response Shaping (V2)
│   └── Payload Optimization (V2)
│
├── API Keys (V2)
│   ├── Key Issuance (V2)
│   ├── Key Rotation (V2)
│   ├── Scopes & Permissions (V2)
│   ├── Key Revocation (V2)
│   └── Key Usage Analytics (V3)
│
├── Webhooks (V2)
│   ├── Event Delivery (V2)
│   ├── Retry Mechanism (V2)
│   ├── Signature Verification (V3)
│   └── Webhook Logs (V3)
│
├── Developer Experience (V3)                             ← CONSOLIDATED (no new platform needed)
│   ├── Developer Portal (Future)
│   ├── SDK Management (V3)
│   ├── API Marketplace (Future)
│   ├── API Playground (Future)
│   └── Public Developer APIs (Future)
│
├── API Authentication (V1)
├── API Authorization (V1)
├── API Versioning (V2)
├── API Documentation (V1)
│   ├── REST Documentation (V1)
│   ├── SDK Documentation (V2)
│   └── Webhook Documentation (V2)
│
├── API Lifecycle Management (V2)
├── API Monitoring (V2)
├── API Analytics (V2)
├── API Rate Limiting (V2)
├── API Deprecation Strategy (V3)
└── GraphQL API (Future)

═══════════════════════════════════════════════════════════════

├── INTEGRATION PLATFORM (V2)                             [RECONSTRUCTED]
│   [Hexagonal outbound adapters — all third-party contact points]
│
├── Connector Framework (V2)
│   ├── Connector SDK (V2)
│   ├── Connector Lifecycle (V2)
│   ├── Retry & Backoff (V2)
│   ├── Idempotent Delivery (V2)
│   └── Sandbox / Live Modes (V3)
│
├── Third Party Registry (V2)
│   ├── Provider Catalog (V2)
│   ├── Provider Health (V2)
│   ├── Provider Failover (V3)
│   └── Provider Cost Tracking (V3)
│
├── Payment Integrations (V1)
├── SMS / Email Provider Integrations (V1)
├── Push Provider Integration (V1)
├── WhatsApp Business Integration (V3)
├── Identity Provider Integrations (V3)
├── Accounting Integrations (V3)
│   ├── Tally Export (V3)
│   ├── Zoho Books (Future)
│   └── QuickBooks (Future)
│
├── Calendar & Productivity Integrations (V3)
├── Storage Provider Integrations (V2)
├── Integration Credential Management (V2)                [vault owned by SECURITY PLATFORM]
├── Sync Engine (V3)
│   ├── Inbound Sync (V3)
│   ├── Outbound Sync (V3)
│   ├── Conflict Handling (V3)
│   └── Sync Audit (V3)
│
├── Integration Monitoring (V2)
├── Integration Error Handling (V2)
└── Integration Marketplace (Future)

═══════════════════════════════════════════════════════════════
LAYER 7 — RUNTIME & OPERATIONS
═══════════════════════════════════════════════════════════════

├── PLATFORM SERVICES (V1)                                [COMPLETED]
│
├── Realtime Engine (V1)
│   ├── Live Attendance (V1)
│   ├── Live Seat Updates (V1)
│   ├── Live Dashboard (V1)
│   ├── Live Notifications (V1)
│   ├── Connection Management (V1)                        ← NEW
│   ├── Presence Service (V2)                             ← NEW
│   ├── Fan-Out Strategy (V2)                             ← NEW
│   └── Realtime Scaling & Backpressure (V3)              ← NEW
│
├── Offline Sync Engine (V1)                              ← NEW (critical for Flutter field usage)
│   ├── Local Write Queue (V1)
│   ├── Sync Protocol (V1)
│   ├── Conflict Resolution (V2)
│   ├── Delta Sync (V2)
│   ├── Sync Status UI Contract (V1)
│   └── Offline Capability Matrix (V2)
│
├── Job Runtime (V2)                                      ← NEW OWNER (absorbed Background Jobs)
│   ├── Background Jobs (V2)                              ← MERGED (from Shared Core)
│   ├── Worker Pools (V2)
│   ├── Queue Management (V2)
│   ├── Retry & Backoff (V2)
│   ├── Job Observability (V2)
│   └── Autoscaling Workers (V3)
│
├── File Pipeline (V1)                                    ← NEW
│   ├── Upload Service (V1)
│   ├── Signed URLs (V1)
│   ├── Virus & Malware Scan (V2)
│   ├── Image Optimization & Thumbnails (V2)
│   ├── Document Preview (V3)
│   └── CDN Delivery (V2)
│
├── Storage Abstraction (V1)                              ← NEW (Hexagonal port)
├── Cache Service (V2)                                    ← NEW
├── Rate Limiter Service (V2)                             ← NEW
├── QR Service (V1)                                       ← NEW
│   ├── QR Generation (V1)
│   ├── Rotating Token QR (V1)
│   └── QR Validation (V1)
│
├── PDF & Document Generation (V1)                        ← NEW
├── Geolocation Service (V1)                              ← NEW
├── Feature Delivery Service (V2)                         ← NEW [reads CONFIGURATION PLATFORM]
├── Idempotency Service (V2)                              ← NEW
└── Time & Timezone Service (V1)                          ← NEW

═══════════════════════════════════════════════════════════════

├── OBSERVABILITY PLATFORM (V1)
│
├── Logging (V1)
│   ├── Structured Logging (V1)
│   ├── Log Levels (V1)
│   ├── Correlation IDs (V2)
│   ├── Tenant & User Context (V1)                        ← NEW
│   ├── PII-Safe Logging (V1)                             ← NEW
│   ├── Log Aggregation (V2)
│   └── Log Retention (V3)
│
├── Metrics (V2)
│   ├── System Metrics (V2)
│   ├── Application Metrics (V2)
│   ├── Business Metrics (V2)
│   ├── Metric Dashboards (V2)
│   └── Custom Metrics (V3)
│
├── Distributed Tracing (V3)
│   ├── Trace Context Propagation (V3)
│   ├── Span Collection (V3)
│   ├── Latency Breakdown (V3)
│   └── Dependency Mapping (Future)
│
├── SLO Management (V2)                                   ← NEW (reliability engineering)
│   ├── SLI Definitions (V2)
│   ├── SLO Targets (V2)
│   ├── Error Budgets (V2)
│   ├── Burn Rate Alerts (V3)
│   └── SLO Reporting (V3)
│
├── Tenant-Level Observability (V2)                       ← NEW
│   ├── Per-Tenant Latency (V2)
│   ├── Per-Tenant Error Rate (V2)
│   ├── Per-Tenant Usage (V2)
│   └── Noisy Tenant Detection (V3)
│
├── AI Observability (V2)                                 ← NEW
│   ├── Prompt & Response Traces (V2)
│   ├── Token & Cost Metrics (V2)
│   ├── Model Latency (V2)
│   └── Quality Signals (V3)
│
├── Mobile Observability (V2)                             ← NEW
│   ├── App Performance (V2)
│   ├── ANR & Jank Tracking (V2)
│   ├── Network Failure Rates (V2)
│   └── Device & OS Breakdown (V2)
│
├── Crash Reporting (V1)
│   ├── Firebase Crashlytics (V1)
│   ├── Crash Grouping (V1)
│   ├── Stack Trace Symbolication (V2)
│   ├── Crash Free Users (V2)
│   └── Release Regression Detection (V3)
│
├── Performance Monitoring (V2)
│   ├── App Start Time (V2)
│   ├── Screen Render Performance (V2)
│   ├── Network Performance (V2)
│   ├── API Latency (V2)
│   └── Database Performance (V3)
│
├── Alerting (V2)
│   ├── Alert Rules (V2)
│   ├── Alert Channels (V2)
│   ├── Severity Levels (V2)
│   ├── Alert Suppression (V3)
│   └── On-Call Escalation (V3)
│
├── Uptime Monitoring (V2)
│   ├── Endpoint Checks (V2)
│   ├── Status Page (V3)
│   ├── Synthetic Monitoring (V3)
│   └── SLA Reporting (V3)
│
├── Incident Management (V3)                              ← NEW
│   ├── Incident Dashboard (V3)
│   ├── Active Incidents (V3)
│   ├── Incident Timeline (V3)
│   ├── Runbooks (V2)
│   ├── Postmortems (V3)
│   └── MTTR Analytics (Future)
│
└── Health Monitoring (V2)
    ├── Service Health Checks (V2)
    ├── Dependency Health (V2)
    ├── Readiness & Liveness (V2)
    └── Degraded Mode Detection (V3)

═══════════════════════════════════════════════════════════════

├── SECURITY PLATFORM (V1)                                [RECONSTRUCTED]
│   [OWNER of all security & privacy enforcement]
│
├── Secrets & Key Management (V1)                         ← OWNER (re-homed from CONFIGURATION PLATFORM)
│   ├── Secret Vault (V1)
│   ├── Secret Rotation (V2)
│   ├── Encryption Key Management (V2)
│   ├── Certificate Management (V3)
│   └── Access Policies for Secrets (V2)
│
├── Encryption (V1)
│   ├── Encryption in Transit (V1)
│   ├── Encryption at Rest (V1)
│   ├── Field Level Encryption (V2)
│   ├── Tokenization (V3)
│   └── Key Rotation Strategy (V3)
│
├── Zero Trust Architecture (V3)
│   ├── Service Authentication (V3)
│   ├── Least Privilege Enforcement (V2)
│   ├── Network Segmentation (V3)
│   └── Continuous Verification (Future)
│
├── Application Security (V1)
│   ├── Input Sanitization (V1)
│   ├── OWASP Top 10 Controls (V1)
│   ├── CSRF / XSS / SQLi Protection (V1)
│   ├── Secure Headers (V1)
│   └── Dependency Vulnerability Scanning (V2)
│
├── Threat Detection (V2)
│   ├── Anomaly Detection (V2)
│   ├── Brute Force Protection (V1)
│   ├── Bot & Abuse Detection (V2)
│   ├── Account Takeover Detection (V3)
│   └── SIEM Integration (V3)
│
├── Perimeter Protection (V2)
│   ├── WAF (V2)
│   ├── DDoS Protection (V2)
│   ├── IP Allow / Deny Lists (V2)
│   └── Geo Restrictions (V3)
│
├── Vulnerability Management (V2)
│   ├── SAST (V2)
│   ├── DAST (V3)
│   ├── Dependency Audit (V2)
│   ├── Patch Management (V2)
│   └── Bug Bounty (Future)
│
├── Penetration Testing (V3)
├── Data Privacy (V2)
│   ├── PII Inventory (V2)
│   ├── Data Minimization (V2)
│   ├── Data Subject Requests (DSR) (V3)
│   ├── Right to Erasure (V3)
│   ├── Records of Processing (RoPA) (V3)
│   ├── Data Residency Enforcement (V3)
│   └── Minor Data Protection (V2)
│
├── Compliance Programs (V3)
│   ├── DPDP Act (V2)
│   ├── GDPR (V3)
│   ├── SOC 2 Readiness (V3)
│   ├── ISO 27001 Readiness (Future)
│   └── Compliance Evidence Automation (Future)
│
├── Security Incident Response (V2)
│   ├── Incident Playbooks (V2)
│   ├── Breach Notification Process (V3)
│   ├── Forensics Support (V3)
│   └── Post-Incident Review (V3)
│
├── Security Awareness & Training (V3)
└── Security Metrics & Posture (V3)

═══════════════════════════════════════════════════════════════
LAYER 8 — DATA, DELIVERY & INFRASTRUCTURE
═══════════════════════════════════════════════════════════════

├── DATA PLATFORM (V1)
│
├── Primary Database (V1)                                 [RECONSTRUCTED]
│   ├── Transactional Store (V1)
│   ├── Module Schema Ownership (V1)                      ← NEW
│   ├── Connection Pooling (V2)
│   ├── Read Replicas (V2)
│   ├── Query Optimization (V2)
│   ├── Partitioning & Sharding (V3)
│   └── Multi-Region Replication (Future)
│
├── Tenant Data Isolation (V1)                            ← NEW (enforced invariant)
│   ├── Row Level Isolation (V1)
│   ├── Tenant ID Enforcement (V1)
│   ├── Query Guardrails (V2)
│   ├── Schema / DB per Tenant (V3)
│   └── Cross-Tenant Leak Tests (V2)
│
├── Cache Database (V2)
│   ├── Redis Cache (V2)
│   ├── Cache Invalidation (V2)
│   ├── Session Cache (V2)
│   ├── Query Cache (V3)
│   └── Distributed Cache (V3)
│
├── Event Store (V3)
│   ├── Event Persistence (V3)
│   ├── Event Streams (V3)
│   ├── Event Replay (V3)
│   ├── Snapshotting (Future)
│   └── Event Sourcing Support (Future)
│
├── Vector Database (V2)
│   ├── Vector Collections (V2)
│   ├── Namespace Isolation (V2)
│   ├── Index Configuration (V2)
│   ├── Backup & Restore (V3)
│   └── Scaling Strategy (V3)
│
├── Analytics Store (V2)                                  ← NEW
│   ├── OLAP Warehouse (V2)
│   ├── Aggregation Pipelines (V2)
│   └── Query Isolation from OLTP (V2)
│
├── Data Lake (V3)
│   ├── Raw Data Zone (V3)
│   ├── Curated Data Zone (V3)
│   ├── ETL / ELT Pipelines (V3)
│   ├── Data Catalog (V3)
│   └── Data Governance (Future)
│
├── AI Knowledge Base (V2)
│   ├── Document Sources (V2)
│   ├── Knowledge Ingestion (V2)
│   ├── Tenant Knowledge Isolation (V2)
│   ├── Knowledge Refresh (V3)
│   └── Knowledge Quality Scoring (Future)
│
├── Data Governance (V2)                                  ← NEW (branch, not a platform)
│   ├── Data Classification (V2)
│   ├── PII Tagging (V2)
│   ├── Data Ownership & Stewardship (V2)
│   ├── Data Lineage (V3)
│   ├── Data Quality Rules (V2)
│   ├── Master Data Management (V3)
│   └── Data Contracts (V2)
│
├── Data Lifecycle (V2)                                   ← NEW
│   ├── Retention Enforcement (V2)
│   ├── Archival Pipeline (V3)
│   ├── Hard Delete Pipeline (V2)
│   ├── Anonymization (V3)
│   └── Legal Hold Support (V3)
│
├── Schema Migration (V1)                                 ← NEW
│   ├── Versioned Migrations (V1)
│   ├── Zero Downtime Migrations (V2)
│   ├── Backward Compatible Changes (V1)
│   └── Rollback Migrations (V2)
│
├── Backup & Recovery (V1)                                ← NEW
│   ├── Automated Backups (V1)
│   ├── Point-In-Time Recovery (V2)
│   ├── Restore Testing (V2)
│   └── Cross-Region Backup (V3)
│
└── Change Data Capture (V3)                              [publishes to EVENT PLATFORM]

═══════════════════════════════════════════════════════════════

├── DEVOPS PLATFORM (V1)                                  [RECONSTRUCTED]
│
├── CI Pipeline (V1)
│   ├── Build Automation (V1)
│   ├── Static Analysis (V1)
│   ├── Test Execution (V1)
│   ├── Artifact Management (V2)
│   └── Build Caching (V2)
│
├── CD Pipeline (V1)
│   ├── Automated Deployment (V1)
│   ├── Environment Promotion (V1)
│   ├── Approval Gates (V2)
│   ├── Blue / Green Deployment (V3)
│   └── Canary Deployment (V3)
│
├── Release Engineering (V1)
│   ├── Versioning & Tagging (V1)
│   ├── Release Notes Automation (V2)
│   ├── Changelog Generation (V2)
│   └── Release Calendar (V2)
│
├── Mobile Release Management (V1)                        ← NEW (Flutter-specific reality)
│   ├── App Store Delivery (V1)
│   ├── Play Store Delivery (V1)
│   ├── Staged Rollout (V2)
│   ├── Forced Upgrade (V1)
│   ├── Client Kill Switch (V2)
│   ├── Client Compatibility Matrix (V2)
│   └── Over-The-Air Config (V2)
│
├── Infrastructure as Code (V2)
│   ├── Terraform Modules (V2)
│   ├── Environment Templates (V2)
│   ├── Drift Detection (V3)
│   └── Policy as Code (V3)
│
├── Secrets in Pipeline (V1)                              [vault owned by SECURITY PLATFORM]
├── Database Migration Automation (V2)
├── Rollback Automation (V2)
├── Deployment Observability (V2)
├── Environment Management (V1)
│   ├── Development (V1)
│   ├── Staging (V1)
│   ├── Production (V1)
│   └── Ephemeral Preview Environments (V3)
│
└── Developer Productivity (V3)
    ├── Local Dev Setup (V1)
    ├── Seed & Fixture Data (V2)
    ├── Codegen Tooling (V2)
    └── Internal Developer Portal (Future)

═══════════════════════════════════════════════════════════════

├── QUALITY PLATFORM (V1)                                 [RECONSTRUCTED]
│
├── Test Automation (V1)
│   ├── Unit Test Suite (V1)
│   ├── Widget Test Suite (V1)
│   ├── Integration Test Suite (V1)
│   ├── End-to-End Suite (V2)
│   └── Test Coverage Reporting (V2)
│
├── Contract Testing (V2)                                 ← NEW
│   ├── Provider Contract Tests (V2)
│   ├── Consumer Contract Tests (V2)
│   ├── Event Schema Tests (V2)
│   └── Breaking Change Gate (V2)
│
├── Load & Stress Testing (V2)
│   ├── Baseline Load Tests (V2)
│   ├── Peak Scenario Tests (V2)
│   ├── Soak Tests (V3)
│   └── Capacity Validation (V3)
│
├── Chaos Engineering (V3)                                ← NEW
│   ├── Failure Injection (V3)
│   ├── Dependency Outage Drills (V3)
│   └── Recovery Validation (V3)
│
├── Accessibility Testing (V2)                            ← NEW
│   ├── Screen Reader Testing (V2)
│   ├── Contrast & Font Scaling (V2)
│   └── WCAG Compliance Checks (V3)
│
├── Multi-Tenant Test Suite (V2)                          ← NEW
│   ├── Cross-Tenant Isolation Tests (V2)
│   ├── Permission Matrix Tests (V2)
│   └── Entitlement Tests (V2)
│
├── Test Data Management (V2)
│   ├── Synthetic Data Generation (V2)
│   ├── Data Masking (V2)
│   └── Fixture Libraries (V1)
│
├── Quality Gates (V1)
│   ├── Coverage Thresholds (V1)
│   ├── Static Analysis Gate (V1)
│   ├── Security Scan Gate (V2)
│   └── Performance Budget Gate (V3)
│
├── Defect Management (V1)
│   ├── Bug Triage (V1)
│   ├── Severity & Priority (V1)
│   ├── Root Cause Analysis (V2)
│   └── Defect Metrics (V3)
│
├── Regression Management (V2)
├── UAT Management (V2)
└── Release Readiness Review (V2)

═══════════════════════════════════════════════════════════════

├── INFRASTRUCTURE (V1)                                   [RECONSTRUCTED]
│
├── Cloud Foundation (V1)
│   ├── Account & Project Structure (V1)
│   ├── IAM & Roles (V1)
│   ├── Resource Tagging (V2)
│   └── Landing Zone (V3)
│
├── Compute (V1)
│   ├── Application Runtime (V1)
│   ├── Container Orchestration (V3)
│   ├── Serverless Functions (V2)
│   └── Worker Nodes (V2)
│
├── Networking (V1)
│   ├── VPC & Subnets (V2)
│   ├── Load Balancing (V1)
│   ├── DNS Management (V1)
│   ├── Private Connectivity (V3)
│   └── Service Mesh (Future)
│
├── CDN & Edge (V2)
│   ├── Static Asset CDN (V1)
│   ├── Media Delivery (V2)
│   ├── Edge Caching (V2)
│   └── Edge Functions (Future)
│
├── Regions & Availability (V2)
│   ├── Single Region Baseline (V1)
│   ├── Multi-AZ Deployment (V2)
│   ├── Multi-Region Strategy (V3)
│   └── Data Residency Regions (V3)
│
├── Scaling (V2)
│   ├── Horizontal Autoscaling (V2)
│   ├── Vertical Scaling (V1)
│   ├── Queue-Based Scaling (V2)
│   └── Predictive Scaling (Future)
│
├── Disaster Recovery (V3)
│   ├── RTO / RPO Targets (V2)
│   ├── Backup Strategy (V1)
│   ├── Failover Runbooks (V3)
│   └── DR Drills (V3)
│
├── FinOps & Cost Management (V2)                         ← NEW (margin protection)
│   ├── Cost Visibility (V2)
│   ├── Cost Allocation & Tagging (V2)
│   ├── Cost per Tenant (V3)
│   ├── AI Cost Attribution (V2)
│   ├── Budget Alerts (V2)
│   └── Rightsizing & Savings Plans (V3)
│
├── Capacity Planning (V3)
├── Infrastructure Security Baseline (V2)                 [policy owned by SECURITY PLATFORM]
└── Sustainability & Efficiency (Future)

═══════════════════════════════════════════════════════════════
LAYER 9 — ECOSYSTEM
═══════════════════════════════════════════════════════════════

├── FUTURE ECOSYSTEM (Future)
│
├── Product Suite Federation (Future)                     ← NEW
│   ├── Multi-Product Registry (Future)
│   ├── Cross-Product Navigation (Future)
│   ├── Unified Ecosystem Identity (Future)
│   └── Unified Ecosystem Billing (Future)
│
├── Plugin Platform (Future)
│   ├── Plugin Registry (Future)
│   ├── Extension SDK (Future)
│   ├── Plugin Marketplace (Future)
│   ├── Plugin Sandboxing & Permissions (Future)          ← NEW
│   ├── Plugin Review & Certification (Future)            ← NEW
│   ├── Third Party Plugins (Future)
│   └── Custom Extensions (Future)
│
├── Partner Program (Future)                              ← NEW
│   ├── Partner Onboarding (Future)
│   ├── Revenue Sharing (Future)
│   └── Partner Certification (Future)
│
├── Marketplace Governance (Future)                       ← NEW
│   ├── Listing Policies (Future)
│   ├── Security Review (Future)
│   └── Takedown Process (Future)
│
├── Coaching / Institute Product Line (Future)
├── EdTech Content Platform (Future)
├── Public Developer Ecosystem (Future)
└── LIBOORA Open Platform (Future)

═══════════════════════════════════════════════════════════════
END OF ARCHITECTURE
25 Platforms · 11 duplicates merged (0 nodes lost) · 9 modules re-homed
1 new platform (EVENT PLATFORM) · 3 platform candidates rejected as unnecessary
All V1 / V2 / V3 / Future tags preserved
═══════════════════════════════════════════════════════════════
```

---

## 9. Post-Refinement Platform Scores

| Platform | Before | After | Platform | Before | After |
|---|---|---|---|---|---|
| Foundation | 8.5 | **9.5** | Search Platform | 8.5 | **9.0** |
| Architecture Governance | 8.0 | **9.5** | Analytics Platform | 7.5 | **9.5** |
| Configuration Platform | 9.0 | **9.5** | Audit Platform | 8.5 | **9.5** |
| Shared Core Platform | 5.5 | **9.0** | API Platform | 8.5 | **9.5** |
| Identity & Access | 7.5 | **9.5** | Integration Platform | — | **8.5** |
| Library Management | 8.5 | **9.5** | Platform Services | 7.5 | **9.0** |
| Global Student Platform | 7.0 | **9.0** | Observability Platform | 8.5 | **9.5** |
| AI Platform | 8.0 | **9.5** | Security Platform | — | **9.0** |
| Workflow Platform | 8.5 | **9.0** | Data Platform | 8.0 | **9.5** |
| **Event Platform (NEW)** | — | **9.0** | DevOps Platform | — | **9.0** |
| Business Platform | 8.0 | **9.5** | Quality Platform | — | **8.5** |
| Communication Platform | 8.0 | **9.5** | Infrastructure | — | **9.0** |
| | | | Future Ecosystem | 8.0 | **8.5** |

**Weakest links remaining (deliberate, not oversights):** Quality Platform (8.5) and Integration Platform (8.5) — both are *execution-gated*. They reach 9+ only once contract tests genuinely run in CI and a second payment provider genuinely exists. Architecture cannot pre-earn those points.

---

## 10. Governing Rules & Conventions

These rules are **normative**. Any change to this architecture must satisfy all of them.

### 10.1 Ownership Rules

1. **Single Owner Rule** — every capability has exactly one owning platform. Any other appearance must be annotated `[VIEW over X]`, `[client of X]`, or `→ owned by X`.
2. **No Cross-Module Database Access** — a module may only reach another module through its public module API or via events. Enforced by `Module Boundary Enforcement`.
3. **Domain platforms emit, never store** — audit events, analytics events and search documents are *emitted*; they are stored by Audit, Analytics and Search respectively.
4. **Configuration resolves, Business entitles** — `Configuration Platform` answers *"is this flag on?"*; `Business Platform → Entitlement Service` answers *"is this tenant allowed?"*.
5. **Workflow orchestrates, Platform Services executes** — scheduling intent lives in Workflow; workers and queues live in Platform Services `Job Runtime`.
6. **AI authors, Workflow executes** — AI may propose or generate a workflow; only Workflow Platform runs it.
7. **Security owns all secrets** — no other platform stores credentials; they hold *references* only.
8. **Analytics owns metric definitions** — no dashboard may define its own metric formula; it must consume the Metric Layer.

### 10.2 Multi-Tenant Invariants

1. Every request carries a resolved tenant context (`API Gateway → Tenant Resolution`).
2. Every persisted row carries an enforced `tenant_id` (`Data Platform → Tenant Data Isolation`).
3. Every emitted event carries tenant context (`Event Platform → Tenant Context in Events`).
4. Every search index and vector namespace is tenant-partitioned.
5. Every RAG retrieval is both tenant-scoped and permission-aware.
6. Cross-tenant leakage is covered by an automated test suite (`Quality Platform → Multi-Tenant Test Suite`).

### 10.3 Version Tag Semantics

| Tag | Meaning |
|---|---|
| **V1** | MVP — required to launch and operate the core product |
| **V2** | Growth — required to scale operations and sell to multi-branch customers |
| **V3** | Enterprise — required to pass enterprise procurement, security review and compliance |
| **Future** | Ecosystem — post-product-market-fit expansion; do not design for it now, only avoid blocking it |

### 10.4 Naming Conventions

- Platforms: `UPPERCASE PLATFORM` (e.g. `SEARCH PLATFORM`)
- Modules: `Title Case` (e.g. `Seat Management`)
- Sub-modules: `Title Case`, verbs where behavioural (e.g. `Seat Locking & Concurrency`)
- Avoid synonyms for the same concept — `Standards` (normative), `Guidelines` (advisory), `Conventions` (stylistic) are distinct and must not be interchanged.

### 10.5 Change Process

1. Propose the change as an **ADR** (`Architecture Governance → ADR`).
2. Verify against the **Single Owner Rule** and the **Duplicate Resolution Matrix** in section 3.
3. Assign a version tag (V1/V2/V3/Future) using 10.3.
4. Update this document and bump the version in the header table.
5. Register any new cross-module dependency in `Dependency Rules → Allowed Dependencies Matrix`.

---

## 11. Changelog

### `v2.3` — 2026-08-25 — Two Community capabilities enumerated by append-only addendum (`ADR-0079`)

**No node was inserted into the capability tree. No existing line moved.** `Community (V2)` at **L967–973** is
byte-identical to `v2.2`. The two capabilities this document failed to enumerate — **Community Comments** and
**Community Reactions** — are recorded in the new **§12**, which sits below **every** line cited by line number
anywhere in the repository (highest such citation: **L2404**, `PRD-012a_PART8` → `EA L2404`).

| Capability | Was | Now | Authority |
|---|---|---|---|
| `Community Comments` *(Layer 2 → GLOBAL STUDENT PLATFORM → Community)* | **absent** | **V2** | **Rank 1** `MP-SCOPE-04` (`MASTER_PRD.md` **L92**) places `BC-14`/`BC-15` at **V2**; §10.3 defines V2 as Growth · recorded `ADR-0075`, executed `ADR-0079` |
| `Community Reactions` *(Layer 2 → GLOBAL STUDENT PLATFORM → Community)* | **absent** | **V2** | as above. Before this entry `reaction` occurred **0** times in this document — the defect `ADR-0075` §8.6 measured |

**Why an addendum and not a tree insertion.** `ADR-0075` measured that inserting two nodes at **L972**
invalidates **240** EA line-citations across **39** files, three of them **FROZEN** (`PRD-017` and the
`PRD-012a` family). `PRD_LIFECYCLE.md` **L177** states *"A frozen PRD is never silently modified."*
`ADR-0079` therefore executed **`ADR-0075` §8.5 Option A**, reproducing the shape of **`ADR-0042`**: header
token replaced in place, content appended below all citations, **net tree shift zero**. This document is
**descriptive** at **precedence rank 6** (`MP-CON-08`, **L519**), so this entry **records a determination made
at Rank 1** — it does not make one. The underlying class defect — the EA being cited by bare line number
**281** times — is **not** closed here; it remains `ADR-0075` §8.5 **Option B**, routed to the Governance
Owner by `ADR-0080`.

### `v2.2` — 2026-08-15 — One version tag corrected to match Rank 4 (`MP-CON-08`)

**One token changed. No platform added, removed or re-homed; no node added or lost; no capability renamed; no
new dependency.** This document is **descriptive** and sits at **precedence rank 6**
(`DOCUMENTATION_BASELINE.md` §4, `MP-CON-08`), so where it disagreed with a higher rank the rule is that
**this document is corrected to match — never the reverse.**

| Node | Was | Now | Authority |
|---|---|---|---|
| `Refunds` *(Layer 2 → LIBRARY MANAGEMENT PLATFORM → Revenue & Finance)* | V2 | **V1** | **Rank 4** `LIBOORA_BOUNDED_CONTEXT_MAP.md` **L100** (`BC-05` owns refunds, row Release **V1**), **L374** (`RefundRecord` is a declared `FeeLedger` member with the invariant `refund ≤ received`), **L422** (`fee.RefundIssued` is a declared published event) · **Rank 3 FROZEN** `PRD-005` **L942** (*"a refund decision by `BC-05`"*) · Product Owner V1 refund scope recorded in **`ADR-0039` §3** and executed by **`ADR-0042`** |

**Why this was a defect and not a choice.** Four higher-ranked statements — three of them in a **Rank 4**
document and one in a **frozen Rank 3** PRD — already placed student-fee refunds in V1. This document alone
said V2. `DOCUMENTATION_BASELINE.md` §4 states *"**A conflict is a defect.** If you find one, do not choose —
raise it"*, and `MP-CON-08` states that the higher-ranked document wins **and this document is updated to
match**. The correction therefore **records a decision made elsewhere**; it does not make one.

**`Refund Management (V2)` at L1408 is deliberately NOT changed, and the distinction is measured, not
assumed.** That node's parent is **`Payment Gateway (V1)`** inside **LAYER 4 — BUSINESS & ENGAGEMENT**, beside
`Payment Gateway Abstraction (V1)`, `Razorpay (V1)` and `Webhook Reconciliation (V1)`. It describes a
**gateway-side** refund capability owned by the Business Platform, which is a different question from whether
`BC-05` may record a refund in its own ledger. **No Rank 1–4 document places gateway-executed refund in V1**,
so changing it would be an invention rather than a correction. It is left standing and routed to the
Architecture Owner in `ADR-0042` §6.

### `v2.1` — 2026-08-02 — Alignment with Authentication PRD v2.0

Version-tag corrections only. **No platform added, removed or re-homed. No node lost. No capability renamed except
where the existing name was self-contradictory.** Every change resolves a conflict recorded in
`docs/DOCUMENTATION_AUDIT-001.md` §2 and is traceable to a binding rule.

| Node | Was | Now | Authority |
|---|---|---|---|
| `Session Revocation` | V2 | **V1** | `MP-GBR-26` — revocation is immediate and global with no propagation window; `AUTH-11.66` |
| `Concurrent Session Limits` | V2 | **V1** | `CFG-8` maximum registered devices; `BR-6.31` one active session per device |
| `Device Management` | V2 | **V1** | Bounded Context Map §3: `BC-18` owns devices; Auth PRD v2.0 Chapter 6 §§6.4–6.7 |
| `Device Registration` | V2 | **V1** | `AUTH-8.41` every session is associated with exactly one device record |
| `Multi Device Management` | V2 | **V1** | `AUTH-8.45` unrecognised-device detection is the sole SIM-swap defence in a single-factor system |
| `OTP Emails` | V1 | **V2** | `MP-GBR-25` / `MP-CON-11` — mobile OTP is the sole V1 factor; Authentication holds no email address (`AUTH-8.60`) |
| `Passwordless Login (Future)` | Future | **`Passkeys / WebAuthn` (V3)** | The platform is passwordless in V1 by construction (`AUTH-11.68`); the old name implied V1 had passwords |

**Why the device-management retag matters.** With mobile OTP as the sole factor, an attacker who captures the
number through SIM swap authenticates successfully. Nothing in the authentication path detects this. The only
control that does is new-device notification (`EV-16`). Shipping V1 without device management would ship V1
without any account-takeover detection.

### `v2.0` — 2026-07-30 — Enterprise Architecture Review & Refinement

**Structural**
- Added `EVENT PLATFORM (V2)` — the runtime event backbone (Outbox, Schema Registry, Broker, Consumer Groups, Replay, DLQ, CDC). Total platforms: 24 → 25.
- Introduced a 10-layer logical ordering (Layer 0 Governance → Layer 9 Ecosystem) with dependency-correct sequencing.
- Rejected 4 candidate platforms (Job, Developer, Data Governance, Tenant) with documented reasoning to avoid unnecessary complexity.

**Duplicates merged (11 — zero nodes lost, all preserved as children)**
- `Prompt Library` + `Prompt Versioning` → `Prompt Registry`
- `Prompt Evaluation` → `AI Evaluation`
- `AI Memory Layer` → `AI Memory Store`
- `Multi Device Management` → `Device Management`
- `Notification Preferences` (duplicate within Communication) → `Notification Management`
- `Custom Reports` + `Scheduled Reports` (duplicates within Analytics) → `Reporting Engine`
- `ADR Index` (duplicate within Foundation) → `ADR Summary`
- `Tenant Branding` (Org Mgmt + Library Settings) → `Branding Configuration`
- `Tenant Configuration` (Org Mgmt) → `Configuration Platform → Tenant Overrides`

**Modules re-homed (9)**
- Shared Core → Configuration Platform: `Settings & Configuration`, `Configuration Management`, `Feature Flags`
- Shared Core → Identity & Access: `Roles & Permissions (RBAC)`
- Shared Core → Search Platform: `Search Engine`
- Shared Core → Communication Platform: `Notification Engine`
- Shared Core → Audit Platform: `Audit Logs`, `Activity Timeline`
- Shared Core → Platform Services: `Background Jobs`
- AI Platform → Workflow Platform: `AI Workflow Engine`
- Configuration Platform → Security Platform: `Secrets Management`

**Major capability additions**
- **Security**: full `SECURITY PLATFORM` — secrets, encryption, zero trust, threat detection, WAF/DDoS, vulnerability management, DPDP/GDPR, DSR, SOC 2 / ISO readiness, incident response.
- **Reliability**: SLO Management, Error Budgets, Incident Management, Runbooks, Tenant-Level Observability, Mobile Observability, AI Observability.
- **Multi-tenancy**: Tenant Context Propagation, Tenant Tiers & Quotas, Data Residency, Noisy Neighbour Protection, Tenant Offboarding & Data Export, Tenant Data Isolation + leak tests.
- **AI safety & governance**: AI Governance, Model Cards, PII Redaction Gateway, Human-in-the-Loop, Input/Output Guardrails, Jailbreak Detection, Permission-Aware Retrieval, AI Rate Limits, ML & Prediction Services.
- **Data**: Data Governance branch, Data Lifecycle, Schema Migration, Backup & PITR, Analytics Store, Module Schema Ownership.
- **Analytics integrity**: Metric Layer (Semantic Layer), Analytics Data Contracts, Read Model Store (CQRS), Product Analytics.
- **Trust & Safety**: full branch for the student social platform including Minor Safety Controls, Moderation Pipeline, Appeals.
- **Mobile reality**: Offline Sync Engine, Conflict Resolution, Mobile Release Management, Forced Upgrade, Client Kill Switch, Staged Rollout, Client Compatibility Matrix.
- **Correctness**: Idempotency at every boundary — API, Workflow, Events, Payments, Attendance Check-In, Platform Services.
- **Commercial**: Entitlement Service, Proration Engine, Dunning Management, Revenue Recognition, Payment Gateway Abstraction, Customer Lifecycle.
- **Cost**: FinOps & Cost Management, Cost Model, Cost per Tenant, AI Cost Attribution.
- **Governance runtime**: Architecture Fitness Functions, Module Boundary Enforcement, Dependency Rules, ADR Traceability.
- **Extraction path**: Modularization Strategy, Service Extraction Playbook, Strangler Fig Strategy.
- **Reconstructed platforms**: `INTEGRATION`, `SECURITY`, `DEVOPS`, `QUALITY`, `INFRASTRUCTURE`, plus completion of `PLATFORM SERVICES` and `DATA PLATFORM`.

**Scores**: Overall 6.8 → **9.1** · Scalability 6.5 → **9.0** · Enterprise Readiness 6.0 → **9.2** · Maintainability 6.2 → **9.0** · AI Readiness 7.5 → **9.3** · SaaS Readiness 6.5 → **9.2** · Production Readiness 5.5 → **8.8** · Future-proof 6.8 → **9.2**

### `v1.0` — Baseline

Original LIBOORA Enterprise Architecture Tree (24 platforms) prior to review.

---

## 12. Capability Enumeration Addenda

> Appended by **`ADR-0079`** executing **`ADR-0075` §8.5 Option A**. Every line in this section lies **below
> every line cited by line number anywhere in the repository** (highest: **L2404**), so enumerating a
> capability here shifts **no** cited line and touches **no** frozen document.
> ⛔ **Nothing in the Layer 2 capability tree was inserted, moved, renamed or reworded.**

### 12.1 GLOBAL STUDENT PLATFORM → Community (V2)

The `Community (V2)` subtree at **L967–973** enumerates public/private communities, feed, roles, moderation
and analytics. It does **not** enumerate comments or reactions, although **Rank 1** `MP-SCOPE-04`
(`MASTER_PRD.md` **L92**) places `BC-14`/`BC-15` at **V2** and the owning Rank 3 PRD specifies both. The two
missing capabilities are therefore enumerated here.

| Capability | Version | Owning BC | Authority |
|---|---|---|---|
| **Community Comments** | **V2** | `BC-15` | **Rank 1** `MP-SCOPE-04` (`MASTER_PRD.md` **L92**) · §10.3 (**L2422–2429**): V2 = Growth · recorded by `ADR-0075`, executed by `ADR-0079` |
| **Community Reactions** | **V2** | `BC-15` | as above. Reaction **kinds** are enumerated by the owning **Rank 3** PRD, not by this Rank 6 document |

⚠ **Scope of this addendum.** Enumerating a capability in a **descriptive, rank 6** document creates no field,
no event, no bounded-context edge, no aggregate row, no permission identifier and no configurable. It records
that the capability is in scope at **V2** and that `BC-15` owns it. Every such artefact remains owned by the
higher-ranked document that defines it, and the open gaps that require them are unaffected.

⚠ **No cross-reference marker was added at L967–973, deliberately.** A marker would not shift any line, but it
would change the **content** of lines that **39** files cite — including `EA L967`, cited exactly by
`PRD-021A_A1`. Changing cited content is the same defect class as changing cited numbering. This section is
therefore reachable only through its own heading and through `ADR-0079`. `ADR-0075` §8.5 predicted this
trade-off as *"ugly, but shifts nothing"*; it is accepted knowingly.

---

*End of document.*

