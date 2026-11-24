// PRD-004 §3.4 wave 4 — the app-facing read ports and their composition-root
// adapters. The adapters map domain aggregates onto rank-0 contract DTOs;
// these tests pin every mapping field a screen consumes, so a DTO drift is a
// failing test rather than a silent UI change.
//
// A container booted WITHOUT a seeder starts empty; a tenant scope is entered
// manually (the same entry sign-in performs) so every tenant-partitioned
// read answers.
import 'package:flutter_test/flutter_test.dart';
import 'package:liboora/bootstrap/di.dart';
import 'package:liboora/domain/library/membership/membership.dart';
import 'package:liboora/domain/library/seating/seating.dart';
import 'package:liboora/platform/identity/identity.dart';
import 'package:liboora_contracts/liboora_contracts.dart';

void main() {
  late AppContainer c;

  setUp(() async {
    c = await AppContainer.boot();
    c.enterScope(
      tenant: const TenantId('t_test'),
      branch: const BranchId('b_test'),
      actor: 'tester',
    );
  });

  MembershipPlan plan() => MembershipPlan(
    id: 'plan_test',
    tenantId: const TenantId('t_test'),
    branchId: const BranchId('b_test'),
    name: 'Monthly Study',
    durationDays: 30,
    price: Money.rupees(1000),
    createdAt: DateTime(2026, 1, 1),
    createdBy: 'tester',
    // The seating test allocates a reserved seat against this plan.
    seatQuota: 1,
  );

  Future<StudentRecordId> enrollStudent(String name, String phone) async {
    final personId = c.provisionIdentityForEnrollment(
      phone: phone,
      displayName: name,
    );
    final student = await c.enrollStudent(
      actorRole: AccessRole.owner,
      fullName: name,
      phone: phone,
      dateOfBirth: DateTime(2000, 1, 1),
      personId: personId,
    );
    return student.id;
  }

  group('StudentDirectoryPort', () {
    test('maps every roster field the UI renders', () async {
      final id = await enrollStudent('Asha Verma', '9000000001');
      final entry = c.studentDirectory.byId(id);

      expect(entry, isNotNull);
      expect(entry!.id, id);
      expect(entry.fullName, 'Asha Verma');
      expect(entry.phone, '9000000001');
      expect(entry.enrollmentNumber, isNotEmpty);
    });

    test('all() and page() agree on the same tenant partition', () async {
      await enrollStudent('Bilal Khan', '9000000002');
      await enrollStudent('Chitra Rao', '9000000003');

      final all = c.studentDirectory.all();
      expect(all, hasLength(2));

      final page = c.studentDirectory.page();
      expect(page.items, hasLength(2));
      expect(page.nextCursor, isNull); // fewer than one page
    });

    test(
      'withOpenDues lists exactly the students with a positive balance',
      () async {
        final paid = await enrollStudent('Devi Nair', '9000000004');
        final debtor = await enrollStudent('Eshwar Iyer', '9000000005');

        expect(c.studentDirectory.withOpenDues(), isEmpty);

        c.collectFee(
          actorRole: AccessRole.owner,
          studentId: debtor,
          amount: Money.rupees(100),
        );
        // `paid` owes nothing — an empty ledger is not an open due.
        expect(c.studentDirectory.withOpenDues(), isEmpty);

        await c.raiseFeeDue(
          actorRole: AccessRole.owner,
          studentId: debtor,
          description: 'Monthly plan',
          amount: Money.rupees(500),
        );
        expect(c.studentDirectory.withOpenDues().map((s) => s.id), [debtor]);
        expect(c.feeReads.outstandingFor(debtor), Money.rupees(400));
        expect(paid, isNotNull);
      },
    );

    test(
      'a foreign-tenant cursor is refused, never silently reset (PG-4)',
      () async {
        expect(
          () => c.studentDirectory.verifyCursorTenant('garbage'),
          throwsA(isA<DomainError>()),
        );
      },
    );
  });

  group('MembershipReadPort', () {
    test('validityOf maps the four fields the UI renders', () async {
      final id = await enrollStudent('Farah Singh', '9000000006');
      final v = c.membershipReads.validityOf(id);

      // No membership sold yet: the none shape.
      expect(v.isValid, isFalse);
      expect(v.validUntil, isNull);
      expect(v.seatQuota, 0);
      expect(v.planName, '—');
    });

    test('historyFor resolves the plan name and snapshots the price', () async {
      final id = await enrollStudent('Gaurav Mehta', '9000000007');
      c.membershipPlans.save(plan());
      await c.createMembership(
        actorRole: AccessRole.owner,
        idempotencyKey: IdempotencyKey('mm_1'),
        studentId: id,
        plan: plan(),
        // The seeder's own pattern: payment precedes issuance, so the term
        // lands Active rather than PendingPayment.
        paymentAlreadyReceived: true,
      );

      final history = c.membershipReads.historyFor(id);
      expect(history, hasLength(1));
      expect(history.first.planName, 'Monthly Study');
      expect(history.first.price, Money.rupees(1000));
      expect(history.first.isActiveOn, isTrue);
      expect(history.first.term.lengthInDays, 30);
      expect(
        history.first.endsOn,
        history.first.term.end.subtract(const Duration(days: 1)),
      );
    });
  });

  group('FeeReadPort', () {
    test('ledgerFor maps dues and receipts field-for-field', () async {
      final id = await enrollStudent('Hema Joshi', '9000000008');
      await c.raiseFeeDue(
        actorRole: AccessRole.owner,
        studentId: id,
        description: 'Seat reservation',
        amount: Money.rupees(300),
      );
      await c.collectFee(
        actorRole: AccessRole.owner,
        studentId: id,
        amount: Money.rupees(200),
        mode: PaymentMode.cash,
      );

      final l = c.feeReads.ledgerFor(id);
      expect(l, isNotNull);
      expect(l!.totalDue, Money.rupees(300));
      expect(l.totalReceived, Money.rupees(200));
      expect(l.dues.single.description, 'Seat reservation');
      expect(l.dues.single.netAmount, Money.rupees(300));
      expect(l.receipts.single.mode, PaymentMode.cash);
      expect(l.receipts.single.amount, Money.rupees(200));
      expect(l.receipts.single.collectedBy, isNotEmpty);
      expect(l.receipts.single.receiptNumber, startsWith('RCP-'));
    });

    test('no ledger reads as zero, not null, for outstanding', () async {
      final id = await enrollStudent('Imran Ali', '9000000009');
      expect(c.feeReads.ledgerFor(id), isNull);
      expect(c.feeReads.outstandingFor(id), Money.zero);
      expect(c.feeReads.hasOpenDues(id), isFalse);
    });

    test('totals() and allReceipts() aggregate across every ledger', () async {
      final a = await enrollStudent('Jaya Bose', '9000000010');
      final b = await enrollStudent('Kiran Pillai', '9000000011');
      await c.raiseFeeDue(
        actorRole: AccessRole.owner,
        studentId: a,
        description: 'Plan',
        amount: Money.rupees(400),
      );
      await c.raiseFeeDue(
        actorRole: AccessRole.owner,
        studentId: b,
        description: 'Plan',
        amount: Money.rupees(600),
      );
      await c.collectFee(
        actorRole: AccessRole.owner,
        studentId: a,
        amount: Money.rupees(150),
      );

      final totals = c.feeReads.totals();
      expect(totals.raised, Money.rupees(1000));
      expect(totals.received, Money.rupees(150));
      expect(c.feeReads.totalOutstanding(), Money.rupees(850));
      expect(c.feeReads.allReceipts(), hasLength(1));
    });
  });

  group('SeatingReadPort', () {
    test('an empty branch layout maps to an empty map and zero summary', () {
      expect(c.seatingReads.currentMap((_) => ''), isEmpty);
      final s = c.seatingReads.summary();
      expect((s.total, s.occupied, s.free), (0, 0, 0));
    });

    test('the map mirrors seat facts and live allocations', () async {
      // Seed the branch layout through the platform's own store.
      c.seatLayouts.save(
        SeatLayout(
          branchId: const BranchId('b_test'),
          seats: [
            const Seat(
              id: 's1',
              label: 'A-1',
              zone: 'Silent Zone',
              hasPowerSocket: true,
            ),
            const Seat(id: 's2', label: 'A-2', zone: 'Silent Zone'),
          ],
        ),
      );
      final id = await enrollStudent('Lata Menon', '9000000012');
      c.membershipPlans.save(plan());
      await c.createMembership(
        actorRole: AccessRole.owner,
        idempotencyKey: IdempotencyKey('mm_2'),
        studentId: id,
        plan: plan(),
        paymentAlreadyReceived: true,
      );
      await c.assignSeat(
        actorRole: AccessRole.owner,
        studentId: id,
        seatId: 's1',
      );

      final map = c.seatingReads.currentMap(
        (sid) => c.studentDirectory.byId(sid)?.fullName ?? sid.value,
      );
      expect(map, hasLength(2));

      final taken = map.singleWhere((o) => o.isOccupied);
      expect(taken.seatId, 's1');
      expect(taken.label, 'A-1');
      expect(taken.zone, 'Silent Zone');
      expect(taken.hasPowerSocket, isTrue);
      expect(taken.studentName, 'Lata Menon');
      expect(taken.allocationId, isNotNull);
      expect(taken.allocatedUntil, isNotNull);

      final free = map.singleWhere((o) => !o.isOccupied);
      expect(free.seatId, 's2');
      expect(free.studentName, isNull);
      expect(free.allocationId, isNull);

      final summary = c.seatingReads.summary();
      expect(summary.occupied, 1);
      expect(summary.free, 1);
    });
  });
}
