/// Serialisation for the six persisted aggregates.
///
/// **Why this file is in `bootstrap/` and not in `platform/data`.**
///
/// Encoding a `StudentRecord` requires naming it, which means importing
/// `domain/library` (rank 8). `platform/data` is rank 2, and law **L4** states
/// that no capability may import a domain module — ever. That is the rule that
/// keeps service extraction a deployment change rather than a rewrite, and it
/// has no exceptions.
///
/// `bootstrap/` is the composition layer: it is already the one place
/// permitted to know both a port and its adapter, so it is the correct home
/// for the translation between the two. The data platform stays ignorant of
/// what a row means, which is also why it can persist any aggregate without
/// modification.
///
/// **Why hand-written JSON and not `hive_generator`/`build_runner`.**
///
/// A `TypeAdapter` per aggregate would require either annotating the domain
/// classes — putting a storage concern inside the domain, the same L3 leak —
/// or generating adapters that must be regenerated whenever a field changes.
/// Hand-written maps keep the storage concern here, and make the field list
/// auditable by reading one function.
///
/// **Every codec below is a round-trip of fields that already exist.** No
/// field is invented, defaulted into existence, or renamed. Where a field is
/// nullable in the domain it stays nullable here; where the domain rejects a
/// value, decode lets the constructor reject it rather than pre-empting it, so
/// a persisted row can never bypass an invariant that a live one must satisfy.
library;

import 'dart:convert';

import 'package:liboora_contracts/liboora_contracts.dart';

import '../domain/library/attendance/domain/attendance_day.dart';
import '../domain/library/enrollment/domain/student_record.dart';
import '../domain/library/fee/domain/fee_ledger.dart';
import '../domain/library/membership/domain/membership.dart';
import '../domain/library/seating/domain/seat_allocation.dart';

// ───────────────────────────────────────────────────────────────────
// Shared primitives
// ───────────────────────────────────────────────────────────────────

/// ISO-8601, so a stored date is readable in a debugger and sortable as text.
String _date(DateTime d) => d.toIso8601String();
DateTime _readDate(Object? v) => DateTime.parse(v! as String);
DateTime? _readDateOrNull(Object? v) =>
    v == null ? null : DateTime.parse(v as String);

/// Money is persisted as minor units plus currency — never as a double.
///
/// The whole point of `Money` is that it has no floating-point representation;
/// serialising `asDouble` would reintroduce exactly the drift the type exists
/// to prevent, and it would do so invisibly.
Map<String, Object?> _money(Money m) => {
  'minorUnits': m.minorUnits,
  'currency': m.currency,
};

Money _readMoney(Object? v) {
  final map = v! as Map<String, Object?>;
  // Money.paise is the only constructor that takes minor units directly, and
  // the kernel is INR-only today; a stored non-INR row is a corruption, and
  // throwing here means restore skips that row rather than silently
  // converting it.
  final currency = map['currency'] as String?;
  if (currency != null && currency != 'INR') {
    throw FormatException('Unsupported stored currency: $currency');
  }
  return Money.paise(map['minorUnits']! as int);
}

DateRange _readRange(Object? v) {
  final map = v! as Map<String, Object?>;
  return DateRange(start: _readDate(map['start']), end: _readDate(map['end']));
}

Map<String, Object?> _range(DateRange r) => {
  'start': _date(r.start),
  'end': _date(r.end),
};

/// Enums are stored by **name**, never by index.
///
/// An index would silently re-point every stored row if a future value is
/// inserted into the middle of the enum. A name that no longer exists throws,
/// which surfaces the problem instead of mislabelling data.
T _readEnum<T>(List<T> values, Object? raw, String Function(T) nameOf) {
  final name = raw! as String;
  for (final v in values) {
    if (nameOf(v) == name) return v;
  }
  throw FormatException('Unknown enum value: $name');
}

// ───────────────────────────────────────────────────────────────────
// 1 — StudentRecord (BC-01 Enrollment)
// ───────────────────────────────────────────────────────────────────

String encodeStudentRecord(StudentRecord s) => jsonEncode({
  'id': s.id.value,
  'enrollmentNumber': s.enrollmentNumber,
  'fullName': s.fullName,
  'phone': s.phone,
  'email': s.email,
  'dateOfBirth': _date(s.dateOfBirth),
  'enrolledOn': _date(s.enrolledOn),
  'personId': s.personId.value,
  'status': s.status.name,
  'photoRef': s.photoRef?.value,
  'guardian': s.guardian == null
      ? null
      : {
          'name': s.guardian!.name,
          'phone': s.guardian!.phone,
          'relation': s.guardian!.relation,
        },
});

StudentRecord decodeStudentRecord(String raw) {
  final m = jsonDecode(raw) as Map<String, Object?>;
  final g = m['guardian'] as Map<String, Object?>?;
  return StudentRecord(
    id: StudentRecordId(m['id']! as String),
    enrollmentNumber: m['enrollmentNumber']! as String,
    fullName: m['fullName']! as String,
    phone: m['phone']! as String,
    email: m['email'] as String?,
    dateOfBirth: _readDate(m['dateOfBirth']),
    enrolledOn: _readDate(m['enrolledOn']),
    // Non-nullable by ID-4 / SID-4.17. Read without a fallback so a row
    // missing it fails to decode rather than producing a record the
    // constructor would have rejected.
    personId: PersonId(m['personId']! as String),
    status: _readEnum(EnrollmentStatus.values, m['status'], (e) => e.name),
    photoRef: m['photoRef'] == null ? null : FileRef(m['photoRef']! as String),
    guardian: g == null
        ? null
        : GuardianLink(
            name: g['name']! as String,
            phone: g['phone']! as String,
            relation: g['relation']! as String,
          ),
  );
}

// ───────────────────────────────────────────────────────────────────
// 2 — Membership (BC-02 Membership)
// ───────────────────────────────────────────────────────────────────

/// Schema version for the membership row.
///
/// v1 embedded the whole plan and used the five-value status enum
/// `{pending, active, frozen, expired, cancelled}`. v2 stores `planId` plus
/// the `MM-FR-026` snapshots, and the six-value `MM-FR-072` set. [
/// decodeMembership] reads both; [encodeMembership] only ever writes v2.
const int kMembershipSchemaV2 = 2;

/// `MM-FR-026` \u2014 the snapshots are persisted, the plan is referenced.
///
/// v1 embedded the plan because the catalogue was re-seeded on every boot and
/// an id-only reference would have let a catalogue edit rewrite history. The
/// snapshots achieve the same protection correctly: price, currency and plan
/// version are frozen onto the membership, so history is immune to plan edits
/// (`MM-FR-023`) while the catalogue itself is now a persisted aggregate.
String encodeMembership(Membership m) => jsonEncode({
  'v': kMembershipSchemaV2,
  'id': m.id,
  'studentRecordId': m.studentRecordId.value,
  'planId': m.planId,
  'term': _range(m.term),
  'status': m.status.name,
  'priceSnapshot': _money(m.priceSnapshot),
  'planVersionAtPurchase': m.planVersionAtPurchase,
});

/// Status names as written by schema v1.
///
/// `pending` \u2192 `pendingPayment` is a rename of the same state: v1's `pending`
/// meant "created, payment not yet received", which is `MM-FR-072`'s
/// `PendingPayment` exactly.
///
/// `frozen` is the one lossy case, and it is handled explicitly rather than
/// silently. `MM-FR-073`/`MM-XC-009` make `Frozen` unreachable in V1, so a
/// persisted `frozen` row has no lawful target. It maps to `active`: the
/// student paid for a term that has not ended, and v1's `freeze()` *extended*
/// the term, so the term on disk is already the correct one to honour.
/// Mapping it to `expired` or `cancelled` would revoke paid entitlement, and
/// dropping the row would lose it \u2014 both are worse than honouring the term.
const Map<String, MembershipStatus> _legacyMembershipStatus = {
  'pending': MembershipStatus.pendingPayment,
  'active': MembershipStatus.active,
  'frozen': MembershipStatus.active,
  'expired': MembershipStatus.expired,
  'cancelled': MembershipStatus.cancelled,
};

Membership decodeMembership(String raw) {
  final m = jsonDecode(raw) as Map<String, Object?>;
  final version = m['v'] as int? ?? 1;

  if (version >= kMembershipSchemaV2) {
    return Membership(
      id: m['id']! as String,
      studentRecordId: StudentRecordId(m['studentRecordId']! as String),
      planId: m['planId']! as String,
      term: _readRange(m['term']),
      priceSnapshot: _readMoney(m['priceSnapshot']),
      planVersionAtPurchase: m['planVersionAtPurchase']! as int,
      status: _readEnum(MembershipStatus.values, m['status'], (e) => e.name),
    );
  }

  // ── Schema v1 ────────────────────────────────────────────────────
  // The embedded plan carries the price that was actually sold, so it is the
  // correct source for the MM-FR-026 snapshot. Version 1 is recorded because
  // v1 had no plan versioning and MembershipPlan.version defaults to 1.
  final p = m['plan']! as Map<String, Object?>;
  final legacyName = m['status'] as String?;
  final status = _legacyMembershipStatus[legacyName];
  if (status == null) {
    throw FormatException('Unknown legacy membership status: $legacyName');
  }
  return Membership(
    id: m['id']! as String,
    studentRecordId: StudentRecordId(m['studentRecordId']! as String),
    planId: p['id']! as String,
    term: _readRange(m['term']),
    priceSnapshot: _readMoney(p['price']),
    planVersionAtPurchase: 1,
    status: status,
  );
}

// ───────────────────────────────────────────────────────────────────
// 2b — MembershipPlan (BC-02 Membership) — MM-FR-006 aggregate root
// ───────────────────────────────────────────────────────────────────

String encodeMembershipPlan(MembershipPlan p) => jsonEncode({
  'id': p.id,
  'tenantId': p.tenantId.value,
  'branchId': p.branchId.value,
  'name': p.name,
  'durationDays': p.durationDays,
  'price': _money(p.price),
  'createdAt': _date(p.createdAt),
  'createdBy': p.createdBy,
  'availability': p.availability.name,
  'isActive': p.isActive,
  'version': p.version,
  'description': p.description,
  'seatQuota': p.seatQuota,
});

MembershipPlan decodeMembershipPlan(String raw) {
  final p = jsonDecode(raw) as Map<String, Object?>;
  return MembershipPlan(
    id: p['id']! as String,
    tenantId: TenantId(p['tenantId']! as String),
    branchId: BranchId(p['branchId']! as String),
    name: p['name']! as String,
    durationDays: p['durationDays']! as int,
    price: _readMoney(p['price']),
    createdAt: _readDate(p['createdAt']),
    createdBy: p['createdBy']! as String,
    availability: _readEnum(
      PlanAvailability.values,
      p['availability'],
      (e) => e.name,
    ),
    isActive: p['isActive']! as bool,
    version: p['version']! as int,
    description: p['description'] as String?,
    seatQuota: p['seatQuota']! as int,
  );
}

// ───────────────────────────────────────────────────────────────────
// 3 — AttendanceDay (BC-03 Attendance)
// ───────────────────────────────────────────────────────────────────

Map<String, Object?> _punch(Punch p) => {
  'at': _date(p.at),
  'method': p.method.name,
  'idempotencyKey': p.idempotencyKey.value,
  'capturedOffline': p.capturedOffline,
};

Punch _readPunch(Object? v) {
  final m = v! as Map<String, Object?>;
  return Punch(
    at: _readDate(m['at']),
    method: _readEnum(VerificationMethod.values, m['method'], (e) => e.name),
    idempotencyKey: IdempotencyKey(m['idempotencyKey']! as String),
    capturedOffline: m['capturedOffline']! as bool,
  );
}

String encodeAttendanceDay(AttendanceDay d) => jsonEncode({
  'studentRecordId': d.studentRecordId.value,
  'date': _date(d.date),
  'membershipValidAtEntry': d.membershipValidAtEntry,
  'lateEntry': d.lateEntry,
  'entries': d.entries.map(_punch).toList(),
  'exits': d.exits.map(_punch).toList(),
  'corrections': d.corrections,
});

/// Punches are appended through the public lists rather than via
/// `checkIn`/`checkOut`.
///
/// Those methods enforce *transition* rules — "already checked in", "check-out
/// before check-in" — which were already enforced when the punch was first
/// recorded. Replaying them on restore would re-run a decision against a
/// state that is being rebuilt, and a day that legitimately ended open would
/// throw. Restoring a fact is not the same act as making it.
AttendanceDay decodeAttendanceDay(String raw) {
  final m = jsonDecode(raw) as Map<String, Object?>;
  final day = AttendanceDay(
    studentRecordId: StudentRecordId(m['studentRecordId']! as String),
    date: _readDate(m['date']),
    membershipValidAtEntry: m['membershipValidAtEntry']! as bool,
    lateEntry: m['lateEntry']! as bool,
  );
  for (final p in m['entries']! as List<Object?>) {
    day.entries.add(_readPunch(p));
  }
  for (final p in m['exits']! as List<Object?>) {
    day.exits.add(_readPunch(p));
  }
  for (final c in m['corrections']! as List<Object?>) {
    day.corrections.add(c! as String);
  }
  return day;
}

// ───────────────────────────────────────────────────────────────────
// 4 — SeatLayout (BC-04 Seating)
// ───────────────────────────────────────────────────────────────────

String encodeSeatLayout(SeatLayout l) => jsonEncode({
  'branchId': l.branchId.value,
  'seats': [
    for (final s in l.seats)
      {
        'id': s.id,
        'label': s.label,
        'zone': s.zone,
        'hasPowerSocket': s.hasPowerSocket,
        'isCorner': s.isCorner,
      },
  ],
});

SeatLayout decodeSeatLayout(String raw) {
  final m = jsonDecode(raw) as Map<String, Object?>;
  return SeatLayout(
    branchId: BranchId(m['branchId']! as String),
    seats: [
      for (final s in m['seats']! as List<Object?>)
        Seat(
          id: (s! as Map<String, Object?>)['id']! as String,
          label: (s as Map<String, Object?>)['label']! as String,
          zone: s['zone']! as String,
          hasPowerSocket: s['hasPowerSocket']! as bool,
          isCorner: s['isCorner']! as bool,
        ),
    ],
  );
}

// ───────────────────────────────────────────────────────────────────
// 5 — SeatAllocation (BC-04 Seating)
// ───────────────────────────────────────────────────────────────────

String encodeSeatAllocation(SeatAllocation a) => jsonEncode({
  'id': a.id,
  'seatId': a.seatId,
  'seatLabel': a.seatLabel,
  'studentRecordId': a.studentRecordId.value,
  'window': _range(a.window),
  'allocatedOn': _date(a.allocatedOn),
  'status': a.status.name,
  'releasedOn': a.releasedOn == null ? null : _date(a.releasedOn!),
  'releaseReason': a.releaseReason,
  'transfersToday': a.transfersToday,
});

/// The post-construction fields are assigned directly rather than through
/// `release()`/`expire()`, for the same reason attendance punches are: those
/// methods refuse to act on a non-active allocation, so replaying them would
/// make a released allocation impossible to restore.
SeatAllocation decodeSeatAllocation(String raw) {
  final m = jsonDecode(raw) as Map<String, Object?>;
  return SeatAllocation(
      id: m['id']! as String,
      seatId: m['seatId']! as String,
      seatLabel: m['seatLabel']! as String,
      studentRecordId: StudentRecordId(m['studentRecordId']! as String),
      window: _readRange(m['window']),
      allocatedOn: _readDate(m['allocatedOn']),
      status: _readEnum(AllocationStatus.values, m['status'], (e) => e.name),
    )
    ..releasedOn = _readDateOrNull(m['releasedOn'])
    ..releaseReason = m['releaseReason'] as String?
    ..transfersToday = m['transfersToday']! as int;
}

// ───────────────────────────────────────────────────────────────────
// 6 — FeeLedger (BC-05 Fee & Collection)
// ───────────────────────────────────────────────────────────────────

String encodeFeeLedger(FeeLedger l) => jsonEncode({
  'studentRecordId': l.studentRecordId.value,
  'dues': [
    for (final d in l.dues)
      {
        'id': d.id,
        'description': d.description,
        'amount': _money(d.amount),
        'raisedOn': _date(d.raisedOn),
        'dueOn': _date(d.dueOn),
        'category': d.category.name,
        'sourceRef': d.sourceRef,
        // Discount is a mutable field on the due and part of the balance
        // invariant, so it must round-trip or restored balances would be
        // wrong in the library's favour.
        'discount': _money(d.discount),
      },
  ],
  'receipts': [
    for (final r in l.receipts)
      {
        'id': r.id,
        'receiptNumber': r.receiptNumber,
        'amount': _money(r.amount),
        'mode': r.mode.name,
        'receivedOn': _date(r.receivedOn),
        'collectedBy': r.collectedBy,
        'againstDueId': r.againstDueId,
        'isRefund': r.isRefund,
        'note': r.note,
      },
  ],
});

/// Entries are appended through `dues`/`receipts` rather than
/// `raiseDue`/`recordReceipt`.
///
/// `recordReceipt` rejects a refund exceeding receipts recorded *so far*,
/// which is order-dependent: a ledger whose refund was legitimately valid
/// when issued can fail if its rows are replayed in a different order.
/// Balance is derived, never stored, so appending the entries reproduces the
/// same balance without re-litigating history.
FeeLedger decodeFeeLedger(String raw) {
  final m = jsonDecode(raw) as Map<String, Object?>;
  final ledger = FeeLedger(
    studentRecordId: StudentRecordId(m['studentRecordId']! as String),
  );

  for (final raw in m['dues']! as List<Object?>) {
    final d = raw! as Map<String, Object?>;
    ledger.dues.add(
      FeeDue(
        id: d['id']! as String,
        description: d['description']! as String,
        amount: _readMoney(d['amount']),
        raisedOn: _readDate(d['raisedOn']),
        dueOn: _readDate(d['dueOn']),
        category: _readEnum(FeeCategory.values, d['category'], (e) => e.name),
        sourceRef: d['sourceRef'] as String?,
      )..discount = _readMoney(d['discount']),
    );
  }

  for (final raw in m['receipts']! as List<Object?>) {
    final r = raw! as Map<String, Object?>;
    ledger.receipts.add(
      Receipt(
        id: r['id']! as String,
        receiptNumber: r['receiptNumber']! as String,
        amount: _readMoney(r['amount']),
        mode: _readEnum(PaymentMode.values, r['mode'], (e) => e.name),
        receivedOn: _readDate(r['receivedOn']),
        collectedBy: r['collectedBy']! as String,
        againstDueId: r['againstDueId'] as String?,
        isRefund: r['isRefund']! as bool,
        note: r['note'] as String?,
      ),
    );
  }

  return ledger;
}
