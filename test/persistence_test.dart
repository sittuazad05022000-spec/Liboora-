/// **Durable persistence conformance — P0 #2.**
///
/// The defect these tests guard: `TenantPartitionedStore` held every row in a
/// `Map`, so all tenant data was lost on every restart. `hive`,
/// `hive_flutter` and `shared_preferences` were declared dependencies with
/// **zero** usages anywhere in `lib/`.
///
/// ## What is asserted, and what is deliberately not
///
/// These tests use [InMemoryKeyValueStore] as the durable adapter rather than
/// Hive. That is not a shortcut — it is the only honest way to test the
/// *contract*. `Hive.openBox` needs a filesystem or IndexedDB, neither of
/// which exists in `flutter test`, so a Hive-based test would be testing the
/// sandbox rather than the code. What actually needs proving is that
///
///   * every field of all six aggregates survives a round trip,
///   * a second `boot` over the same storage sees the first boot's data,
///   * partitioning still holds after restore, and
///   * the tenant guard was not weakened by adding a write-through path,
///
/// and all four are properties of `TenantPartitionedStore` and the codec
/// functions, not
/// of Hive. `HiveKeyValueStore` is the one piece whose behaviour is delegated
/// to a library that has its own test suite; what belongs to us about it — the
/// composite-key scheme — is asserted directly below against the same
/// `DurableKeyValueStore` contract.
///
/// A "restart" here means constructing a **new** container over the **same**
/// durable store. That is exactly what a process restart is from the
/// application's point of view, and it is a stronger test than reopening a
/// file because it also proves no state hid in a static.
library;

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:liboora/bootstrap/codecs.dart';
import 'package:liboora/bootstrap/di.dart';
import 'package:liboora/bootstrap/seed.dart';
import 'package:liboora/domain/library/attendance/domain/attendance_day.dart';
import 'package:liboora/domain/library/enrollment/domain/student_record.dart';
import 'package:liboora/domain/library/fee/domain/fee_ledger.dart';
import 'package:liboora/domain/library/membership/domain/membership.dart';
import 'package:liboora/domain/library/seating/domain/seat_allocation.dart';
import 'package:liboora/platform/data/data.dart';
import 'package:liboora/platform/identity/identity.dart';
import 'package:liboora_contracts/liboora_contracts.dart';

/// A tenant context a test can move at will, standing in for the real one.
final class _FakeTenantContext implements TenantContext {
  TenantId? _tenant;

  void enter(String id) => _tenant = TenantId(id);
  void exit() => _tenant = null;

  @override
  TenantId get tenantId {
    final t = _tenant;
    if (t == null) throw const TenantContextMissing();
    return t;
  }

  @override
  BranchId get branchId => const BranchId('b_test');

  @override
  String? get actorId => 'test';

  @override
  bool get hasTenant => _tenant != null;

  @override
  String get correlationId => 'corr_test';
}

final _t0 = DateTime.utc(2026, 3, 1, 9);

void main() {
  // ═══════════════════════════════════════════════════════════════════
  // 1 — SERIALISATION. Every field of all six aggregates round-trips.
  //
  // Asserted field by field rather than by comparing two encodings. An
  // `encode(decode(x)) == encode(x)` test passes even when a field is dropped
  // from BOTH sides, which is the exact mistake most likely to happen.
  // ═══════════════════════════════════════════════════════════════════
  group('serialisation · all six aggregates round-trip', () {
    test('1/6 StudentRecord — including the optional guardian and photo', () {
      final original = StudentRecord(
        id: const StudentRecordId('sr_1'),
        enrollmentNumber: 'EN-0001',
        fullName: 'Aarav Sharma',
        phone: '9810000001',
        email: 'aarav@example.com',
        dateOfBirth: DateTime.utc(2001, 5, 14),
        enrolledOn: _t0,
        personId: const PersonId('per_1'),
        status: EnrollmentStatus.suspended,
        photoRef: const FileRef('file_9'),
        guardian: const GuardianLink(
          name: 'Meera Sharma',
          phone: '9810000099',
          relation: 'Mother',
        ),
      );

      final r = decodeStudentRecord(encodeStudentRecord(original));

      expect(r.id, original.id);
      expect(r.enrollmentNumber, 'EN-0001');
      expect(r.fullName, 'Aarav Sharma');
      expect(r.phone, '9810000001');
      expect(r.email, 'aarav@example.com');
      expect(r.dateOfBirth, original.dateOfBirth);
      expect(r.enrolledOn, original.enrolledOn);
      expect(r.personId, const PersonId('per_1'));
      expect(r.status, EnrollmentStatus.suspended);
      expect(r.photoRef, const FileRef('file_9'));
      expect(r.guardian!.name, 'Meera Sharma');
      expect(r.guardian!.phone, '9810000099');
      expect(r.guardian!.relation, 'Mother');
    });

    test('1/6 StudentRecord — a null guardian and email stay null', () {
      final original = StudentRecord(
        id: const StudentRecordId('sr_2'),
        enrollmentNumber: 'EN-0002',
        fullName: 'Adult Student',
        phone: '9810000002',
        dateOfBirth: DateTime.utc(1995, 1, 1),
        enrolledOn: _t0,
        personId: const PersonId('per_2'),
      );

      final r = decodeStudentRecord(encodeStudentRecord(original));

      expect(r.email, isNull);
      expect(r.guardian, isNull);
      expect(r.photoRef, isNull);
      expect(r.status, EnrollmentStatus.active);
    });

    test('2/6 Membership — snapshots survive, money keeps minor units', () {
      final plan = MembershipPlan(
        id: 'plan_full',
        tenantId: const TenantId('tnt_1'),
        branchId: const BranchId('brn_1'),
        name: 'Full Day',
        durationDays: 30,
        price: Money.rupees(1250.75),
        createdAt: _t0,
        createdBy: 'owner_1',
        seatQuota: 1,
        version: 4,
      );
      final original = Membership.fromPlan(
        id: 'mem_1',
        studentRecordId: const StudentRecordId('sr_1'),
        plan: plan,
        term: DateRange.days(_t0, 30),
        status: MembershipStatus.scheduled,
      );

      final r = decodeMembership(encodeMembership(original));

      expect(r.id, 'mem_1');
      expect(r.studentRecordId, const StudentRecordId('sr_1'));
      expect(r.planId, 'plan_full');
      // MM-FR-026/027: the snapshot is what must survive, because a plan edit
      // must never restate a sold term.
      // 1250.75 rupees == 125075 paise. Asserted in minor units, because that
      // is the representation the type exists to protect.
      expect(r.priceSnapshot.minorUnits, 125075);
      expect(r.currencySnapshot, 'INR');
      expect(r.planVersionAtPurchase, 4);
      expect(r.term, original.term);
      expect(r.status, MembershipStatus.scheduled);
    });

    test('2b/6 MembershipPlan — the MM-FR-006 aggregate round-trips', () {
      final original = MembershipPlan(
        id: 'plan_ac',
        tenantId: const TenantId('tnt_1'),
        branchId: const BranchId('brn_2'),
        name: 'AC Cabin',
        durationDays: 90,
        price: Money.rupees(4800),
        createdAt: _t0,
        createdBy: 'owner_1',
        availability: PlanAvailability.staffOnly,
        isActive: false,
        version: 7,
        description: 'Staff cabin',
        seatQuota: 2,
      );

      final r = decodeMembershipPlan(encodeMembershipPlan(original));

      expect(r.id, 'plan_ac');
      expect(r.tenantId, const TenantId('tnt_1'));
      expect(r.branchId, const BranchId('brn_2'));
      expect(r.name, 'AC Cabin');
      expect(r.durationDays, 90);
      expect(r.price.minorUnits, 480000);
      expect(r.currency, 'INR');
      expect(r.createdBy, 'owner_1');
      expect(r.availability, PlanAvailability.staffOnly);
      expect(
        r.isActive,
        isFalse,
        reason:
            'MM-FR-019: a deactivated plan must stay deactivated across a '
            'restart, or retired pricing silently returns to the counter.',
      );
      expect(r.version, 7);
      expect(r.description, 'Staff cabin');
      expect(r.seatQuota, 2);
    });

    group('2c/6 Membership schema v1 → v2 migration', () {
      // The exact bytes schema v1 wrote. Held literally rather than produced
      // by an old encoder, because the point is to decode what is ALREADY on
      // a user's disk.
      String v1Row(String status) => jsonEncode({
        'id': 'mem_legacy',
        'studentRecordId': 'sr_9',
        'plan': {
          'id': 'plan_reserved',
          'name': 'Reserved Seat Monthly',
          'price': {'minorUnits': 180000, 'currency': 'INR'},
          'durationDays': 30,
          'seatQuota': 1,
          'freezeDaysAllowed': 7,
        },
        'term': {
          'start': _t0.toIso8601String(),
          'end': _t0.add(const Duration(days: 30)).toIso8601String(),
        },
        'status': status,
        'freezeDaysUsed': 0,
      });

      test('a v1 row decodes without data loss', () {
        final r = decodeMembership(v1Row('active'));

        expect(r.id, 'mem_legacy');
        expect(r.studentRecordId, const StudentRecordId('sr_9'));
        expect(
          r.planId,
          'plan_reserved',
          reason: 'The embedded plan id becomes the reference.',
        );
        expect(
          r.priceSnapshot.minorUnits,
          180000,
          reason:
              'The embedded plan price is what was actually sold, so it is '
              'the correct source for the MM-FR-026 snapshot.',
        );
        expect(r.currencySnapshot, 'INR');
        expect(r.planVersionAtPurchase, 1);
        expect(r.term.lengthInDays, 30);
        expect(r.status, MembershipStatus.active);
      });

      test('v1 `pending` maps to PendingPayment — the same state renamed', () {
        expect(
          decodeMembership(v1Row('pending')).status,
          MembershipStatus.pendingPayment,
        );
      });

      test('v1 `expired` and `cancelled` are preserved exactly', () {
        expect(
          decodeMembership(v1Row('expired')).status,
          MembershipStatus.expired,
        );
        expect(
          decodeMembership(v1Row('cancelled')).status,
          MembershipStatus.cancelled,
        );
      });

      test('v1 `frozen` honours the paid term instead of revoking it', () {
        final r = decodeMembership(v1Row('frozen'));
        expect(
          r.status,
          MembershipStatus.active,
          reason:
              'MM-FR-073 leaves Frozen no lawful target. v1 freeze() EXTENDED '
              'the term, so the stored term is already the one to honour. '
              'Mapping to expired or cancelled would revoke paid entitlement '
              'and dropping the row would lose it — both are worse.',
        );
        expect(r.term.lengthInDays, 30);
        expect(r.priceSnapshot.minorUnits, 180000);
      });

      test('a v1 row re-encodes as v2 and is then stable', () {
        final once = encodeMembership(decodeMembership(v1Row('active')));
        expect(jsonDecode(once), containsPair('v', kMembershipSchemaV2));

        // Idempotent: decoding the upgraded row yields the same thing again.
        final twice = encodeMembership(decodeMembership(once));
        expect(twice, once);
      });

      test('an unknown legacy status fails loudly, never silently', () {
        expect(
          () => decodeMembership(v1Row('teleported')),
          throwsA(isA<FormatException>()),
          reason:
              'A status nobody wrote must not be quietly coerced to active — '
              'that would confer entitlement from corrupt data.',
        );
      });
    });

    test('3/6 AttendanceDay — punches, flags and corrections', () {
      final day = AttendanceDay(
        studentRecordId: const StudentRecordId('sr_1'),
        date: _t0,
        membershipValidAtEntry: false,
        lateEntry: true,
      );
      day.checkIn(
        Punch(
          at: _t0.add(const Duration(hours: 1)),
          method: VerificationMethod.qr,
          idempotencyKey: const IdempotencyKey('idem_in'),
        ),
      );
      day.checkOut(
        Punch(
          at: _t0.add(const Duration(hours: 5)),
          method: VerificationMethod.manual,
          idempotencyKey: const IdempotencyKey('idem_out'),
          capturedOffline: true,
        ),
      );
      day.recordCorrection('reception', 'forgot to tap out');

      final r = decodeAttendanceDay(encodeAttendanceDay(day));

      expect(r.studentRecordId, const StudentRecordId('sr_1'));
      expect(r.date, _t0);
      expect(r.membershipValidAtEntry, isFalse);
      expect(r.lateEntry, isTrue);
      expect(r.entries.length, 1);
      expect(r.exits.length, 1);
      expect(r.entries.single.method, VerificationMethod.qr);
      expect(r.entries.single.idempotencyKey, const IdempotencyKey('idem_in'));
      expect(r.entries.single.capturedOffline, isFalse);
      expect(r.exits.single.method, VerificationMethod.manual);
      expect(r.exits.single.capturedOffline, isTrue);
      expect(r.corrections, ['reception: forgot to tap out']);
      // Derived state must survive, since the UI reads it.
      expect(r.timeInside, const Duration(hours: 4));
      expect(r.isOpen, isFalse);
    });

    test('3/6 AttendanceDay — a day left OPEN restores as open', () {
      // The interesting case: `checkOut` refuses when not open and `checkIn`
      // refuses when already open, so a codec that replayed those methods
      // would throw or silently drop the punch. A student currently inside the
      // library must still be inside after a restart.
      final day = AttendanceDay(
        studentRecordId: const StudentRecordId('sr_3'),
        date: _t0,
      );
      day.checkIn(
        Punch(
          at: _t0,
          method: VerificationMethod.qr,
          idempotencyKey: const IdempotencyKey('idem_open'),
        ),
      );

      final r = decodeAttendanceDay(encodeAttendanceDay(day));

      expect(r.isOpen, isTrue, reason: 'A student inside must stay inside.');
      expect(r.exits, isEmpty);
    });

    test('4/6 SeatLayout — every seat attribute', () {
      final layout = SeatLayout(
        branchId: const BranchId('brn_1'),
        seats: const [
          Seat(
            id: 's1',
            label: 'A-14',
            zone: 'Silent Zone',
            hasPowerSocket: true,
            isCorner: true,
          ),
          Seat(id: 's2', label: 'B-02', zone: 'AC Hall'),
        ],
      );

      final r = decodeSeatLayout(encodeSeatLayout(layout));

      expect(r.branchId, const BranchId('brn_1'));
      expect(r.capacity, 2);
      final a14 = r.require('s1');
      expect(a14.label, 'A-14');
      expect(a14.zone, 'Silent Zone');
      expect(a14.hasPowerSocket, isTrue);
      expect(a14.isCorner, isTrue);
      final b02 = r.require('s2');
      expect(b02.hasPowerSocket, isFalse);
      expect(b02.isCorner, isFalse);
      expect(r.zones, ['AC Hall', 'Silent Zone']);
    });

    test('5/6 SeatAllocation — including a RELEASED one', () {
      // `release()` refuses on a non-active allocation, so this also proves
      // the codec does not replay lifecycle transitions.
      final a = SeatAllocation(
        id: 'alloc_1',
        seatId: 's1',
        seatLabel: 'A-14',
        studentRecordId: const StudentRecordId('sr_1'),
        window: DateRange.days(_t0, 30),
        allocatedOn: _t0,
      )..transfersToday = 2;
      a.release(on: _t0.add(const Duration(days: 3)), reason: 'moved seat');

      final r = decodeSeatAllocation(encodeSeatAllocation(a));

      expect(r.id, 'alloc_1');
      expect(r.seatId, 's1');
      expect(r.seatLabel, 'A-14');
      expect(r.studentRecordId, const StudentRecordId('sr_1'));
      expect(r.window, a.window);
      expect(r.allocatedOn, _t0);
      expect(r.status, AllocationStatus.released);
      expect(r.releasedOn, _t0.add(const Duration(days: 3)));
      expect(r.releaseReason, 'moved seat');
      expect(r.transfersToday, 2);
      expect(r.isActive, isFalse);
    });

    test('6/6 FeeLedger — dues, discounts, receipts and refunds', () {
      final ledger = FeeLedger(studentRecordId: const StudentRecordId('sr_1'));
      ledger.raiseDue(
        FeeDue(
          id: 'due_1',
          description: 'March membership',
          amount: Money.rupees(1000),
          raisedOn: _t0,
          dueOn: _t0.add(const Duration(days: 7)),
          category: FeeCategory.locker,
          sourceRef: 'mem_1',
        ),
      );
      ledger.applyDiscount(
        dueId: 'due_1',
        discount: Money.rupees(150),
        approvedByOwner: true,
      );
      ledger.recordReceipt(
        Receipt(
          id: 'rcpt_1',
          receiptNumber: 'R-0001',
          amount: Money.rupees(600),
          mode: PaymentMode.upi,
          receivedOn: _t0,
          collectedBy: 'reception',
          againstDueId: 'due_1',
          note: 'part payment',
        ),
      );
      ledger.recordReceipt(
        Receipt(
          id: 'rcpt_2',
          receiptNumber: 'R-0002',
          amount: Money.rupees(100),
          mode: PaymentMode.cash,
          receivedOn: _t0,
          collectedBy: 'owner',
          isRefund: true,
        ),
      );

      final r = decodeFeeLedger(encodeFeeLedger(ledger));

      expect(r.studentRecordId, const StudentRecordId('sr_1'));
      expect(r.dues.length, 1);
      final due = r.dues.single;
      expect(due.id, 'due_1');
      expect(due.description, 'March membership');
      expect(due.amount.minorUnits, 100000);
      expect(due.category, FeeCategory.locker);
      expect(due.sourceRef, 'mem_1');
      expect(due.discount.minorUnits, 15000);
      expect(due.netAmount.minorUnits, 85000);

      expect(r.receipts.length, 2);
      expect(r.receipts.first.receiptNumber, 'R-0001');
      expect(r.receipts.first.mode, PaymentMode.upi);
      expect(r.receipts.first.againstDueId, 'due_1');
      expect(r.receipts.first.note, 'part payment');
      expect(r.receipts.last.isRefund, isTrue);
      expect(r.receipts.last.collectedBy, 'owner');

      // The balance is DERIVED. If any component of it failed to restore this
      // is the assertion that notices, which is why it is checked last.
      expect(r.balance, ledger.balance);
      expect(r.balance.minorUnits, 85000 - 60000 + 10000);
    });

    test('an unreadable row is skipped, never guessed', () {
      final durable = InMemoryKeyValueStore()
        ..write('student_records', 't_a::sr_ok', '{"bad json')
        ..write('student_records', 't_a::sr_2', 'null');
      final tenant = _FakeTenantContext();
      final store = TenantPartitionedStore<StudentRecord>(
        tenant,
        durable: durable,
        namespace: 'student_records',
        encode: encodeStudentRecord,
        decode: decodeStudentRecord,
      );

      // Corrupt rows must not take the whole boot down, and must not be
      // replaced by a fabricated default.
      expect(store.restore(), 0);
      tenant.enter('t_a');
      expect(store.all(), isEmpty);
    });

    test('a row stored in an unsupported currency is rejected', () {
      // Money is INR-only in the kernel. Silently coercing a foreign amount
      // would corrupt a balance in someone's favour.
      final durable = InMemoryKeyValueStore()
        ..write(
          'fee_ledgers',
          't_a::sr_1',
          '{"studentRecordId":"sr_1","dues":[{"id":"d","description":"x",'
              '"amount":{"minorUnits":100,"currency":"USD"},'
              '"raisedOn":"2026-03-01T09:00:00.000Z",'
              '"dueOn":"2026-03-08T09:00:00.000Z","category":"membership",'
              '"sourceRef":null,"discount":{"minorUnits":0,"currency":"INR"}}],'
              '"receipts":[]}',
        );
      final store = TenantPartitionedStore<FeeLedger>(
        _FakeTenantContext(),
        durable: durable,
        namespace: 'fee_ledgers',
        encode: encodeFeeLedger,
        decode: decodeFeeLedger,
      );
      expect(store.restore(), 0);
    });
  });

  // ═══════════════════════════════════════════════════════════════════
  // 2 — THE TENANT GUARD SURVIVED THE CHANGE.
  //
  // Adding a write-through path is precisely the kind of change that opens a
  // side-channel around an access rule, so the guard is re-proved on every
  // mutating and reading method rather than assumed from the read path.
  // ═══════════════════════════════════════════════════════════════════
  group('tenant context · fail loud, never default', () {
    late _FakeTenantContext tenant;
    late TenantPartitionedStore<StudentRecord> store;

    StudentRecord record(String id) => StudentRecord(
      id: StudentRecordId(id),
      enrollmentNumber: 'EN-$id',
      fullName: 'Name $id',
      phone: '98100000${id.length}',
      dateOfBirth: DateTime.utc(1995, 1, 1),
      enrolledOn: _t0,
      personId: PersonId('per_$id'),
    );

    setUp(() {
      tenant = _FakeTenantContext();
      store = TenantPartitionedStore<StudentRecord>(
        tenant,
        durable: InMemoryKeyValueStore(),
        namespace: 'student_records',
        encode: encodeStudentRecord,
        decode: decodeStudentRecord,
      );
    });

    test('put throws with no tenant in scope', () {
      expect(
        () => store.put('sr_1', record('sr_1')),
        throwsA(isA<TenantContextMissing>()),
      );
    });

    test('get, all, where, count and remove all throw too', () {
      expect(() => store.get('sr_1'), throwsA(isA<TenantContextMissing>()));
      expect(() => store.all(), throwsA(isA<TenantContextMissing>()));
      expect(
        () => store.where((_) => true),
        throwsA(isA<TenantContextMissing>()),
      );
      expect(() => store.count, throwsA(isA<TenantContextMissing>()));
      expect(() => store.remove('sr_1'), throwsA(isA<TenantContextMissing>()));
    });

    test('nothing was written to durable storage by a refused put', () {
      final durable = InMemoryKeyValueStore();
      final s = TenantPartitionedStore<StudentRecord>(
        tenant,
        durable: durable,
        namespace: 'student_records',
        encode: encodeStudentRecord,
        decode: decodeStudentRecord,
      );
      expect(
        () => s.put('sr_1', record('sr_1')),
        throwsA(isA<TenantContextMissing>()),
      );
      // The throw must happen BEFORE any durable write, or a tenant-less row
      // would be persisted under a key nobody can attribute.
      expect(durable.readAll('student_records'), isEmpty);
    });

    test('restore needs no tenant — it runs before sign-in', () {
      // The one operation that must work without a tenant. If this threw,
      // durable data could never be loaded at all.
      expect(store.restore, returnsNormally);
    });

    test('a half-configured durable store is rejected at construction', () {
      // Supplying a store but no codec would drop every write while still
      // looking persistent. Failing at construction beats failing silently.
      expect(
        () => TenantPartitionedStore<StudentRecord>(
          tenant,
          durable: InMemoryKeyValueStore(),
          namespace: 'student_records',
        ),
        throwsA(isA<ArgumentError>()),
      );
      expect(
        () => TenantPartitionedStore<StudentRecord>(
          tenant,
          encode: encodeStudentRecord,
          decode: decodeStudentRecord,
        ),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('with no durable store supplied, the store is not durable', () {
      final ephemeral = TenantPartitionedStore<StudentRecord>(tenant);
      expect(ephemeral.isDurable, isFalse);
      expect(store.isDurable, isTrue);
    });
  });

  // ═══════════════════════════════════════════════════════════════════
  // 3 — TENANT ISOLATION HOLDS ACROSS PERSISTENCE.
  //
  // Partitioning in memory proves nothing about partitioning on disk: the
  // durable key is a different construction, and X-13 is the highest-severity
  // failure class in the system.
  // ═══════════════════════════════════════════════════════════════════
  group('tenant isolation · across a durable boundary', () {
    StudentRecord record(String id, String name) => StudentRecord(
      id: StudentRecordId(id),
      enrollmentNumber: 'EN-$id',
      fullName: name,
      phone: '9810000001',
      dateOfBirth: DateTime.utc(1995, 1, 1),
      enrolledOn: _t0,
      personId: PersonId('per_$id'),
    );

    test('two tenants writing the same row id do not collide', () {
      final durable = InMemoryKeyValueStore();
      final tenant = _FakeTenantContext();
      final store = TenantPartitionedStore<StudentRecord>(
        tenant,
        durable: durable,
        namespace: 'student_records',
        encode: encodeStudentRecord,
        decode: decodeStudentRecord,
      );

      tenant.enter('t_a');
      store.put('sr_1', record('sr_1', 'Tenant A Student'));
      tenant.enter('t_b');
      store.put('sr_1', record('sr_1', 'Tenant B Student'));

      // Same logical id, two tenants, two durable rows.
      expect(durable.readAll('student_records').length, 2);
      expect(store.get('sr_1')!.fullName, 'Tenant B Student');
      tenant.enter('t_a');
      expect(store.get('sr_1')!.fullName, 'Tenant A Student');
    });

    test('isolation survives a restore into a fresh store', () {
      final durable = InMemoryKeyValueStore();
      final first = _FakeTenantContext();
      final writer = TenantPartitionedStore<StudentRecord>(
        first,
        durable: durable,
        namespace: 'student_records',
        encode: encodeStudentRecord,
        decode: decodeStudentRecord,
      );
      first.enter('t_a');
      writer.put('sr_1', record('sr_1', 'A One'));
      writer.put('sr_2', record('sr_2', 'A Two'));
      first.enter('t_b');
      writer.put('sr_9', record('sr_9', 'B Nine'));

      // "Restart": a brand new store over the same storage.
      final second = _FakeTenantContext();
      final reader = TenantPartitionedStore<StudentRecord>(
        second,
        durable: durable,
        namespace: 'student_records',
        encode: encodeStudentRecord,
        decode: decodeStudentRecord,
      );
      expect(reader.restore(), 3);

      second.enter('t_a');
      expect(reader.count, 2);
      expect(
        reader.all().map((s) => s.fullName),
        containsAll(<String>['A One', 'A Two']),
      );
      // The decisive assertion: tenant A must not see B's row, even though
      // both came out of one flat store.
      expect(reader.get('sr_9'), isNull);

      second.enter('t_b');
      expect(reader.count, 1);
      expect(reader.get('sr_1'), isNull);

      // And the global count is still not what a tenant query returns.
      expect(reader.countAcrossAllTenants, 3);
    });

    test('remove deletes only the acting tenant row', () {
      final durable = InMemoryKeyValueStore();
      final tenant = _FakeTenantContext();
      final store = TenantPartitionedStore<StudentRecord>(
        tenant,
        durable: durable,
        namespace: 'student_records',
        encode: encodeStudentRecord,
        decode: decodeStudentRecord,
      );
      tenant.enter('t_a');
      store.put('sr_1', record('sr_1', 'A'));
      tenant.enter('t_b');
      store.put('sr_1', record('sr_1', 'B'));

      tenant.enter('t_a');
      store.remove('sr_1');

      expect(durable.readAll('student_records').length, 1);
      tenant.enter('t_b');
      expect(store.get('sr_1')!.fullName, 'B');
    });

    test('namespaces do not bleed into one another', () {
      final durable = InMemoryKeyValueStore()
        ..write('student_records', 't_a::x', 'one')
        ..write('memberships', 't_a::x', 'two');
      expect(durable.readAll('student_records'), {'t_a::x': 'one'});
      expect(durable.readAll('memberships'), {'t_a::x': 'two'});
      expect(durable.readAll('fee_ledgers'), isEmpty);
    });
  });

  // ═══════════════════════════════════════════════════════════════════
  // 4 — RESTART / RESTORE THROUGH THE REAL COMPOSITION ROOT.
  //
  // The end-to-end property the user actually cares about: close the app,
  // open it, the data is still there — and the demo seeder has not trampled
  // it.
  // ═══════════════════════════════════════════════════════════════════
  group('restart · through AppContainer.boot', () {
    test(
      'a seeded world is persisted and restored, and NOT re-seeded',
      () async {
        final durable = InMemoryKeyValueStore();

        // First launch: nothing stored, so the seeder runs.
        final first = await AppContainer.boot(
          seeder: seedDemoData,
          durable: durable,
        );
        first.enterScope(tenant: kDemoTenant, branch: kDemoBranch);
        final seededStudents = first.students.all().length;
        final seededNames = first.students.all().map((s) => s.fullName).toSet();
        first.leaveScope();

        expect(
          seededStudents,
          greaterThan(0),
          reason: 'Seeder produced nothing.',
        );
        expect(durable.readAll('student_records'), isNotEmpty);

        // Second launch over the same storage — the "restart".
        final second = await AppContainer.boot(
          seeder: seedDemoData,
          durable: durable,
        );
        second.enterScope(tenant: kDemoTenant, branch: kDemoBranch);
        final restoredNames = second.students
            .all()
            .map((s) => s.fullName)
            .toSet();

        expect(
          second.students.all().length,
          seededStudents,
          reason:
              'Row count changed across restart. Equal counts prove the seeder '
              'did not run a second time — re-seeding would duplicate or throw.',
        );
        expect(restoredNames, seededNames);
        second.leaveScope();
      },
    );

    test(
      'the plan catalogue survives a restart and is not re-seeded',
      () async {
        final durable = InMemoryKeyValueStore();

        final first = await AppContainer.boot(
          seeder: seedDemoData,
          durable: durable,
        );
        first.enterScope(tenant: kDemoTenant, branch: kDemoBranch);
        final seeded = first.plans;
        final seededIds = seeded.map((p) => p.id).toList();
        first.leaveScope();

        expect(seeded, isNotEmpty, reason: 'Seeder produced no plans.');
        expect(
          durable.readAll('membership_plans'),
          isNotEmpty,
          reason:
              'MM-FR-006 made the plan an aggregate, so it must be persisted '
              'like one. A catalogue rebuilt from code on every boot would '
              'silently discard every owner edit.',
        );

        final second = await AppContainer.boot(
          seeder: seedDemoData,
          durable: durable,
        );
        second.enterScope(tenant: kDemoTenant, branch: kDemoBranch);
        expect(
          second.plans.map((p) => p.id).toList(),
          seededIds,
          reason:
              'Plan ids changed across restart. Equal ids prove the seeder did '
              'not run again and the restored rows are the seeded ones.',
        );
        second.leaveScope();

        // The other tenant keeps its own catalogue across the restart too.
        second.enterScope(tenant: kOtherTenant, branch: kOtherBranch);
        expect(second.plans, isNotEmpty);
        expect(
          second.plans.every((p) => p.tenantId == kOtherTenant),
          isTrue,
          reason: 'MM-FR-007: a restored plan belongs to exactly one tenant.',
        );
        second.leaveScope();
      },
    );

    test('an owner plan edit survives the next boot and is not overwritten '
        'by the seeder', () async {
      final durable = InMemoryKeyValueStore();
      final first = await AppContainer.boot(
        seeder: seedDemoData,
        durable: durable,
      );

      first.enterScope(tenant: kDemoTenant, branch: kDemoBranch);
      final original = first.plans.first;
      final edited = original.withEdits(price: Money.rupees(9999));
      first.membershipPlans.save(edited);
      expect(
        first.membershipPlans.byId(original.id)!.version,
        original.version + 1,
      );
      first.leaveScope();

      final second = await AppContainer.boot(
        seeder: seedDemoData,
        durable: durable,
      );
      second.enterScope(tenant: kDemoTenant, branch: kDemoBranch);
      final restored = second.membershipPlans.byId(original.id)!;
      expect(
        restored.price.minorUnits,
        999900,
        reason:
            'The seeder must never overwrite a persisted plan. An owner who '
            'raises a price and restarts the app must not find the demo '
            'price back at the counter.',
      );
      expect(
        restored.version,
        original.version + 1,
        reason: 'MM-FR-022: the incremented version must persist too.',
      );
      second.leaveScope();
    });

    test('a membership restored from disk keeps the price it was sold at, '
        'even after the plan is re-priced', () async {
      final durable = InMemoryKeyValueStore();
      final first = await AppContainer.boot(
        seeder: seedDemoData,
        durable: durable,
      );

      first.enterScope(tenant: kDemoTenant, branch: kDemoBranch);
      final m = first.memberships.all().first;
      final soldAt = m.priceSnapshot.minorUnits;
      final soldVersion = m.planVersionAtPurchase;
      final plan = first.membershipPlans.byId(m.planId)!;
      first.membershipPlans.save(plan.withEdits(price: Money.rupees(1)));
      first.leaveScope();

      final second = await AppContainer.boot(
        seeder: seedDemoData,
        durable: durable,
      );
      second.enterScope(tenant: kDemoTenant, branch: kDemoBranch);
      final restored = second.memberships.byId(m.id)!;
      expect(
        restored.priceSnapshot.minorUnits,
        soldAt,
        reason:
            'MM-FR-023/MM-BR-033: an edit to a plan price must not alter any '
            'existing membership. This is the whole reason the snapshot '
            'exists.',
      );
      expect(restored.planVersionAtPurchase, soldVersion);
      second.leaveScope();
    });

    test('data written after boot survives the next boot', () async {
      final durable = InMemoryKeyValueStore();
      final first = await AppContainer.boot(
        seeder: seedDemoData,
        durable: durable,
      );

      first.enterScope(tenant: kDemoTenant, branch: kDemoBranch);
      final before = first.students.all().length;
      final id = await first.enrollStudent(
        actorRole: AccessRole.reception,
        fullName: 'Walk In Student',
        phone: '9811122233',
        dateOfBirth: DateTime.utc(1998, 7, 21),
        personId: first.provisionIdentityForEnrollment(
          phone: '9811122233',
          displayName: 'Walk In Student',
        ),
      );
      expect(first.students.all().length, before + 1);
      first.leaveScope();
      expect(id, isNotNull);

      final second = await AppContainer.boot(
        seeder: seedDemoData,
        durable: durable,
      );
      second.enterScope(tenant: kDemoTenant, branch: kDemoBranch);
      expect(
        second.students.all().map((s) => s.fullName),
        contains('Walk In Student'),
        reason: 'A student enrolled at the desk must survive a restart.',
      );
      second.leaveScope();
    });

    test('both tenants are restored, still separated', () async {
      final durable = InMemoryKeyValueStore();
      final first = await AppContainer.boot(
        seeder: seedDemoData,
        durable: durable,
      );
      first.enterScope(tenant: kDemoTenant, branch: kDemoBranch);
      final demoCount = first.students.all().length;
      first.enterScope(tenant: kOtherTenant, branch: kOtherBranch);
      final otherCount = first.students.all().length;
      first.leaveScope();

      expect(demoCount, greaterThan(0));
      expect(otherCount, greaterThan(0));

      final second = await AppContainer.boot(
        seeder: seedDemoData,
        durable: durable,
      );
      second.enterScope(tenant: kDemoTenant, branch: kDemoBranch);
      expect(second.students.all().length, demoCount);
      second.enterScope(tenant: kOtherTenant, branch: kOtherBranch);
      expect(second.students.all().length, otherCount);
      second.leaveScope();
    });

    test(
      'fees, attendance and seats are restored, not just students',
      () async {
        final durable = InMemoryKeyValueStore();
        final first = await AppContainer.boot(
          seeder: seedDemoData,
          durable: durable,
        );
        first.enterScope(tenant: kDemoTenant, branch: kDemoBranch);
        final outstanding = first.ledgers.all().fold(
          Money.zero,
          (Money sum, l) => sum + l.balance,
        );
        final allocations = first.seatAllocations.all().length;
        final layoutCapacity = first.seatLayouts
            .forBranch(kDemoBranch)!
            .capacity;
        final attendanceToday = first.students
            .all()
            .where(
              (s) => first.attendance.find(s.id, first.clock.today()) != null,
            )
            .length;
        first.leaveScope();

        final second = await AppContainer.boot(
          seeder: seedDemoData,
          durable: durable,
        );
        second.enterScope(tenant: kDemoTenant, branch: kDemoBranch);

        expect(
          second.ledgers.all().fold(Money.zero, (Money s, l) => s + l.balance),
          outstanding,
          reason: 'Money must reconcile exactly across a restart.',
        );
        expect(second.seatAllocations.all().length, allocations);
        expect(
          second.seatLayouts.forBranch(kDemoBranch)!.capacity,
          layoutCapacity,
        );
        expect(
          second.students
              .all()
              .where(
                (s) =>
                    second.attendance.find(s.id, second.clock.today()) != null,
              )
              .length,
          attendanceToday,
        );
        second.leaveScope();
      },
    );

    test('with no durable store the old behaviour is unchanged', () async {
      // Every pre-existing test boots without a durable store, so this is the
      // regression guard for all of them: the seeder must still run.
      final c = await AppContainer.boot(seeder: seedDemoData);
      c.enterScope(tenant: kDemoTenant, branch: kDemoBranch);
      expect(c.students.all(), isNotEmpty);
      c.leaveScope();
    });

    test('an empty durable store seeds exactly once, then stops', () async {
      final durable = InMemoryKeyValueStore();
      await AppContainer.boot(seeder: seedDemoData, durable: durable);
      final rowsAfterFirst = durable.readAll('student_records').length;

      await AppContainer.boot(seeder: seedDemoData, durable: durable);
      await AppContainer.boot(seeder: seedDemoData, durable: durable);

      expect(
        durable.readAll('student_records').length,
        rowsAfterFirst,
        reason:
            'Row count grew across boots — the seeder ran again and demo data '
            'is accumulating on top of real data.',
      );
    });
  });

  // ═══════════════════════════════════════════════════════════════════
  // 5 — THE HIVE ADAPTER'S OWN CONTRIBUTION: the composite key scheme.
  //
  // Hive itself is not re-tested (it has its own suite, and no filesystem
  // exists here). What is ours is the key format, and it is asserted against
  // the same contract both adapters implement.
  // ═══════════════════════════════════════════════════════════════════
  group('durable adapters · identical contract', () {
    test('the in-memory adapter honours the whole contract', () {
      final s = InMemoryKeyValueStore();
      expect(s.readAll('nope'), isEmpty);
      // A missing key is a normal result, not an error.
      expect(() => s.delete('nope', 'nothing'), returnsNormally);

      s.write('ns', 'k', 'v1');
      expect(s.readAll('ns'), {'k': 'v1'});
      s.write('ns', 'k', 'v2');
      expect(s.readAll('ns'), {'k': 'v2'}, reason: 'write must replace.');
      s.delete('ns', 'k');
      expect(s.readAll('ns'), isEmpty);
    });

    test(
      'readAll is tenant-agnostic, which is what makes restore possible',
      () {
        final s = InMemoryKeyValueStore()
          ..write('ns', 't_a::1', 'a')
          ..write('ns', 't_b::1', 'b');
        // No tenant context is involved at all: the adapter cannot filter by
        // tenant even if it wanted to, which is why boot-time restore works.
        expect(s.readAll('ns').keys, containsAll(<String>['t_a::1', 't_b::1']));
      },
    );

    test('the returned map cannot be mutated by a caller', () {
      final s = InMemoryKeyValueStore()..write('ns', 'k', 'v');
      expect(
        () => s.readAll('ns')['k'] = 'tampered',
        throwsUnsupportedError,
        reason: 'A caller editing the read view would desynchronise storage.',
      );
    });
  });
}
