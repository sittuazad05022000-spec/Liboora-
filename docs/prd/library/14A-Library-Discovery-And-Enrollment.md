<!--
  PROVENANCE — do not edit this block by hand.

  Document      : Library PRD — Section 14A, Library Discovery & Enrollment
  Status        : RECEIVED VERBATIM · UNDER ENTERPRISE REVIEW · NOT FROZEN
  Source        : Supplied by the product owner as the "latest enterprise version".
                  Declared to supersede every previous Library PRD draft.
  Capture rule  : Everything below the VERBATIM marker is the owner's text,
                  reproduced without addition, deletion, reordering, rewording,
                  normalisation or summarisation.
  Review status : See ../library/REVIEW_14A.md for the enterprise review.
                  Open items are recorded there, NOT inline, so this file
                  remains a faithful capture of what was approved.
  Sections 1-25 : NOT RECEIVED. This file is section 14A only. See README.md.
-->

<!-- ===== VERBATIM SOURCE BEGINS ===== -->

# 14A. Library Discovery & Enrollment

## 14A.1 Purpose

The Library Discovery & Enrollment capability enables prospective students to discover, evaluate, compare, and initiate joining libraries through the platform before authentication.

It serves as the primary user acquisition, library discovery, and enrollment entry point of the platform.

This capability is responsible only for public library discovery and enrollment initiation. Authentication, Registration, Authorization, Membership, Student Identity, and Student Management remain owned by their respective modules.

---

## 14A.2 Objectives

Enable students to discover libraries before authentication.

Allow students to compare libraries before joining.

Reduce onboarding friction.

Increase membership conversion.

Provide transparent public library information.

Support location-based library discovery.

Protect confidential operational information.

Maintain clear module ownership without duplication.

---

## 14A.3 Scope

### In Scope

Public Library Discovery

Library Search

Location-based Discovery

Public Library Profiles

Library Visibility

Join Library Entry Flow

Public Information Policy

### Out of Scope

Authentication

Registration

OTP Verification

Authorization

Student Identity

Membership

Seat Booking

Attendance

Payments

Notifications

---

## 14A.4 Public Library Discovery

Users may discover public libraries without authentication.

Supported capabilities include:

Search by Library Name

Search by City

Search by Locality

Search by PIN Code

Discover Nearby Libraries (with location permission)

Distance-based Sorting

Facility Filters

Membership Fee Filters

Operating Hours Filters

Library Type Filters

Future Availability Filters

View Public Library Profile

Browse Gallery & Branding

Compare Membership Plans

---

## 14A.5 Public Library Profile

The following information may be publicly accessible:

Library Name

Logo

Cover Image

Gallery

Description

Business Address

Map Location

Operating Hours

Weekly Holidays

Facilities & Amenities

Membership Plans & Pricing

Seat Capacity (Optional)

Library Status

Business Contact Information

The following information shall never be publicly accessible:

Student Information

Member Directory

Staff Information

Financial Information

Revenue

Attendance Records

Internal Analytics

Security Configuration

Administrative Settings

Owner Authentication Information

---

## 14A.6 Library Visibility

Every library shall define one visibility mode.

### Public

A Public Library:

Appears in search results.

Appears in location-based discovery.

Has a publicly accessible profile.

Allows students to initiate the Join Library process.

### Private

A Private Library:

Does not appear in public search.

Does not appear in nearby discovery.

Is accessible only through:

Invitation Link

QR Code

Library Invitation Code

Accepts membership requests only from invited users.

---

## 14A.7 Join Library Entry Flow

```
Discover Library
↓
View Library Profile
↓
Join Library
↓
Authentication
↓
Registration (if required)
↓
Membership Processing
↓
Library Member
```

The Library module owns only discovery and enrollment initiation.

Authentication and Registration are delegated to the Authentication module.

Membership creation is delegated to the Membership module.

Student profile creation is delegated to the Student Identity module.

---

## 14A.8 Authentication Boundary

Browsing public libraries does not require authentication.

Authentication becomes mandatory only when a protected operation is initiated.

The Library module shall never perform authentication, registration, OTP verification, authorization, or session management directly.

---

## 14A.9 Protected Operations

Authentication is mandatory before:

Join Library

Membership Purchase

Membership Renewal

Seat Booking

Attendance

Personal Dashboard

AI Services

Chat

Member-only Features

If an unauthenticated user initiates any protected operation, the platform shall redirect the user to the Authentication flow and continue the original action after successful authentication.

---

## 14A.10 Public Information Policy

Only information explicitly designated as public may be exposed through Library Discovery.

Business Contact Information shall be separate from the Library Owner's authentication credentials.

Confidential operational, financial, security, administrative, staff, and member information shall never be exposed through public discovery.

---

## 14A.11 Business Rules

LIB-DISC-001 Every library shall define one visibility mode.

LIB-DISC-002 Libraries become publicly discoverable only after successful verification and activation, unless configured as Private by the Library Owner.

LIB-DISC-003 Public libraries shall be searchable through all supported discovery methods.

LIB-DISC-004 Private libraries shall never appear in public discovery.

LIB-DISC-005 Public browsing shall not require authentication.

LIB-DISC-006 Protected operations shall always require successful authentication.

LIB-DISC-007 The Library module owns only discovery and enrollment initiation.

LIB-DISC-008 Authentication and Registration are owned by the Authentication module.

LIB-DISC-009 Membership creation is owned by the Membership module.

LIB-DISC-010 Student identity is owned by the Student Identity module.

LIB-DISC-011 Only approved public information may be exposed.

LIB-DISC-012 The platform shall preserve the user's intended action after successful authentication.

LIB-DISC-013 Library discovery shall prioritize nearby libraries when location permission is available.

---

## 14A.12 Integrations

Authentication

Authorization

Student Identity & Profile

Membership

Library Management

Search

Maps

Notifications

---

## 14A.13 Acceptance Criteria

The capability shall be considered complete when:

Public libraries can be discovered without authentication.

Students can search libraries using all supported discovery methods.

Students can compare public libraries before joining.

Public library profiles are accessible.

Private libraries remain hidden from public discovery.

Protected operations always redirect to Authentication.

After successful authentication, users return to the original action they initiated.

No confidential library information is exposed.

Module responsibilities remain separated without duplication.

The Library module does not implement Authentication, Registration, Authorization, Membership, or Student Identity logic.

<!-- ===== VERBATIM SOURCE ENDS ===== -->
