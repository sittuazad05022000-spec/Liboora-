/// `BC-02` Membership — snapshot integrity, the aggregate field set, and the
/// payment-gate split.
///
/// Covers `IMPL-408` (price-snapshot integrity — the snapshot and
/// `planVersionAtPurchase` taken *together*), `IMPL-410` (the `Membership`
/// aggregate root, its transaction boundary and its field set) and `IMPL-412`
/// (the payment-gate split — this module never touches money) against FROZEN
/// `PRD-005` v1.4.
///
/// Two of the three test obligations are *negative* and structural, so this
/// file reads the aggregate's source as well as calling it:
///
///   * `IMPL-410` — *"no `BC-01`/`BC-03`/`BC-04`/ledger field present"*. A
///     test that asserts "we did not read a ledger" passes vacuously; the
///     field could appear tomorrow. So the declared field set is scanned.
///   * `IMPL-412` — *"no gateway call, no ledger write, no credential; the
///     split is provable **by inspection**"*. The task doc chose that phrase;
///     inspection is therefore the test.
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:liboora/domain/library/membership/membership.dart';
import 'package:liboora_contracts/liboora_contracts.dart';

const String _aggregatePath =
    'lib/domain/library/membership/domain/membership.dart';
const String _modulePath = 'lib/domain/library/membership/membership.dart';

final DateTime _t0 = DateTime.utc(2026, 3, 1);
const _tenant = TenantId('tnt_a');
const _branch = BranchId('brn_a');

MembershipPlan _plan({
  String id = 'plan_1',
  String name = 'Monthly',
  int durationDays = 30,
  Money? price,
  int seatQuota = 1,
  int version = 1,
}) => MembershipPlan(
  id: id,
  tenantId: _tenant,
  branchId: _branch,
  name: name,
  durationDays: durationDays,
  price: price ?? Money.rupees(1200),
  createdAt: _t0,
  createdBy: 'owner_1',
  seatQuota: seatQuota,
  version: version,
);

Membership _membership({
  MembershipPlan? plan,
  MembershipStatus status = MembershipStatus.active,
  DateTime? activatedAt,
}) => Membership.fromPlan(
  id: 'mem_1',
  studentRecordId: const StudentRecordId('stu_1'),
  plan: plan ?? _plan(),
  term: DateRange.days(_t0, 30),
  status: status,
  createdAt: _t0,
  createdBy: 'owner_1',
  activatedAt: activatedAt,
);

DomainError _rejection(void Function() act) {
  try {
    act();
  } on DomainError catch (e) {
    return e;
  }
  fail('Expected a typed DomainError, but the call succeeded.');
}

/// Source with comments removed.
///
/// The inspection tests below ban words like `balance` and `gateway`. Those
/// same words appear in the module's own doc comments *stating that they are
/// forbidden* — so a naive scan fails on the prose that documents compliance.
/// Stripping comments makes the test measure the code, which is what
/// `IMPL-412`'s "provable by inspection" obligation actually means.
String _codeOnly(String source) => source
    .replaceAll(RegExp(r'/\*.*?\*/', dotAll: true), '')
    .split('\n')
    .map((line) {
      final i = line.indexOf('//');
      return i == -1 ? line : line.substring(0, i);
    })
    .join('\n');

/// Every `final`/`var` field declared in a class body.
Set<String> _declaredFieldNames(String classBody) {
  final pattern = RegExp(
    r'^\s*(?:final\s+|late\s+final\s+)?[A-Za-z0-9_<>?,\s]+\s+(_?[a-z][A-Za-z0-9_]*)\s*;',
    multiLine: true,
  );
  return pattern.allMatches(classBody).map((m) => m.group(1)!).toSet();
}

String _classBody(String source, String className) {
  final start = source.indexOf('final class $className {');
  if (start == -1) {
    // Thrown rather than `expect`ed because this runs at load time, outside
    // any test. A vacuous empty body would make every scan below pass.
    throw StateError(
      'Class $className not found — this scan is measuring nothing.',
    );
  }
  var depth = 0;
  var i = source.indexOf('{', start);
  final from = i;
  for (; i < source.length; i++) {
    if (source[i] == '{') depth++;
    if (source[i] == '}') {
      depth--;
      if (depth == 0) break;
    }
  }
  return source.substring(from, i);
}

void main() {
  final aggregateSource = File(_aggregatePath).readAsStringSync();
  final moduleSource = File(_modulePath).readAsStringSync();
  final membershipBody = _classBody(aggregateSource, 'Membership');

  // Comment-free views, for the "provable by inspection" tests.
  final aggregateCode = _codeOnly(aggregateSource);
  final moduleCode = _codeOnly(moduleSource);

  // The scan must not pass by finding nothing.
  test('guard: the aggregate scan is actually reading a class body', () {
    expect(membershipBody.length, greaterThan(500));
    expect(_declaredFieldNames(membershipBody), contains('priceSnapshot'));
  });

  // ════════════════════════════════════════════════════════════════════
  // IMPL-408 — price-snapshot integrity
  // Obligation: "Historical pricing cannot change; amount and version
  // always agree."
  // ════════════════════════════════════════════════════════════════════
  group('IMPL-408 price-snapshot integrity', () {
    test('the snapshot and planVersionAtPurchase are taken together from the '
        'plan being sold (MM-FR-026)', () {
      final plan = _plan(price: Money.rupees(1200), version: 4);
      final m = _membership(plan: plan);

      // "Taken together" is the whole point of MM-INV-006: an amount that
      // came from one version and a version number that came from another
      // is exactly the disagreement BC-05 cannot detect.
      expect(m.priceSnapshot, Money.rupees(1200));
      expect(m.planVersionAtPurchase, 4);
      expect(m.currencySnapshot, plan.price.currency);
    });

    test('editing the plan afterwards does not move the sold price or its '
        'version (MM-BR-033, MM-INV-006)', () {
      final plan = _plan(price: Money.rupees(1200), version: 1);
      final m = _membership(plan: plan);

      final repriced = plan.withEdits(price: Money.rupees(1800));

      // The plan moved.
      expect(repriced.price, Money.rupees(1800));
      expect(repriced.version, 2);

      // The membership did not. This is MM-XC-015 — "silently changing the
      // price of an existing membership" — made impossible rather than
      // merely discouraged.
      expect(m.priceSnapshot, Money.rupees(1200));
      expect(m.planVersionAtPurchase, 1);
    });

    test('the snapshot fields are declared final, so no command can reassign '
        'them (MM-INV-006)', () {
      // MM-AC-086: "No command changes priceSnapshot, currencySnapshot or
      // planVersionAtPurchase after creation." Immutability is asserted at
      // the declaration, because a runtime test can only prove that the
      // setters we happen to know about are absent.
      for (final field in const [
        'priceSnapshot',
        'planVersionAtPurchase',
        'seatQuotaSnapshot',
        'planId',
      ]) {
        expect(
          RegExp(
            'final\\s+[A-Za-z0-9_<>?]+\\s+$field\\s*;',
          ).hasMatch(membershipBody),
          isTrue,
          reason:
              '$field must be declared final — MM-INV-006 requires it to '
              'never change after creation.',
        );
      }
    });

    test('no setter exists for any snapshot field (MM-XC-015)', () {
      for (final field in const [
        'priceSnapshot',
        'currencySnapshot',
        'planVersionAtPurchase',
      ]) {
        expect(
          membershipBody.contains('set $field'),
          isFalse,
          reason: 'A setter for $field would defeat MM-INV-006.',
        );
      }
    });

    test('currencySnapshot is derived from the snapshotted price, not re-read '
        'from the plan (MM-FR-028)', () {
      final m = _membership();
      // MM-FR-028: "Historical membership pricing MUST NOT be derivable by
      // re-reading the plan." Deriving the currency from priceSnapshot
      // means there is no second source that could drift.
      expect(m.currencySnapshot, m.priceSnapshot.currency);
      expect(
        RegExp(
          r'String get currencySnapshot\s*=>\s*priceSnapshot\.currency',
        ).hasMatch(membershipBody),
        isTrue,
        reason: 'currencySnapshot must read the snapshot, not the live plan.',
      );
    });

    test('a negative price snapshot is rejected (§13.1)', () {
      final e = _rejection(
        () => Membership(
          id: 'mem_x',
          studentRecordId: const StudentRecordId('stu_1'),
          planId: 'plan_1',
          branchId: _branch,
          term: DateRange.days(_t0, 30),
          priceSnapshot: Money.paise(-1),
          planVersionAtPurchase: 1,
        ),
      );
      expect(e.code, DomainErrorCode.validationFailed);
      expect(e.context['field'], 'priceSnapshot');
    });

    test('a zero price snapshot is allowed — a free plan is priced, not '
        'unpriced (MM-FR-041)', () {
      final m = _membership(plan: _plan(price: Money.zero));
      expect(m.priceSnapshot, Money.zero);
      expect(m.applicableAmount, Money.zero);
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // IMPL-410 — the aggregate root, transaction boundary and field set
  // Obligation: "One membership, one transaction; no BC-01/BC-03/BC-04/
  // ledger field present; exactly one plan reference, never zero."
  // ════════════════════════════════════════════════════════════════════
  group('IMPL-410 aggregate root and field set', () {
    test('the aggregate carries exactly one plan reference and never zero '
        '(MM-INV-010)', () {
      final m = _membership();
      expect(m.planId, 'plan_1');

      // Never zero: a blank reference is refused at construction rather
      // than tolerated and discovered later by a null read.
      final e = _rejection(
        () => Membership(
          id: 'mem_x',
          studentRecordId: const StudentRecordId('stu_1'),
          planId: '   ',
          branchId: _branch,
          term: DateRange.days(_t0, 30),
          priceSnapshot: Money.rupees(10),
          planVersionAtPurchase: 1,
        ),
      );
      expect(e.code, DomainErrorCode.validationFailed);
      expect(e.context['field'], 'planId');
    });

    test('never more than one: the aggregate declares no collection of plans '
        '(MM-INV-010)', () {
      expect(
        RegExp(r'List<\s*MembershipPlan\s*>').hasMatch(membershipBody),
        isFalse,
        reason:
            'A membership references exactly one plan. A list of plans '
            'would make MM-INV-010 unrepresentable in the type.',
      );
    });

    test('no BC-01, BC-03, BC-04 or ledger field is representable '
        '(MM-BR-021, MM-XC-001, MM-XC-004)', () {
      final fields = _declaredFieldNames(membershipBody);

      // BC-01 Student (identity belongs to the student record, not here),
      // BC-03 Seat, BC-04 Attendance, BC-05's ledger.
      const forbidden = <String>[
        // BC-01 — student identity and enrollment
        'studentName', 'name', 'phone', 'email', 'dateOfBirth', 'photoUrl',
        'address', 'guardianName', 'enrollmentStatus', 'admissionNumber',
        // BC-03 — seating
        'seatId', 'seatNumber', 'seatAssignment', 'shiftId',
        // BC-04 — attendance
        'checkInAt', 'checkOutAt', 'attendanceDays', 'lastSeenAt',
        // BC-05 — money movement
        'balance', 'amountPaid', 'amountDue', 'receipt', 'receiptNumber',
        'refund', 'refundAmount', 'ledger', 'ledgerEntries', 'paymentMode',
        'transactionId', 'gatewayRef', 'invoiceId', 'discount',
      ];

      for (final f in forbidden) {
        expect(
          fields,
          isNot(contains(f)),
          reason:
              'Field "$f" is owned by another bounded context. '
              'MM-BR-021 forbids it on this aggregate.',
        );
      }
    });

    test('the aggregate holds a student *reference*, which is not the same as '
        'holding student data (MM-FR-003)', () {
      final m = _membership();
      // A typed id is a reference. It is the one BC-01 fact BC-02 may hold,
      // and it is deliberately opaque — there is no name behind it here.
      expect(m.studentRecordId, const StudentRecordId('stu_1'));
      expect(_declaredFieldNames(membershipBody), contains('studentRecordId'));
    });

    test('the §13.1 normative field set is present and typed', () {
      final m = _membership(status: MembershipStatus.active, activatedAt: _t0);

      expect(m.id, isA<String>());
      expect(m.studentRecordId, isA<StudentRecordId>());
      expect(m.planId, isA<String>());
      expect(m.term, isA<DateRange>());
      expect(m.priceSnapshot, isA<Money>());
      expect(m.currencySnapshot, isA<String>());
      expect(m.planVersionAtPurchase, isA<int>());
      expect(m.seatQuotaSnapshot, isA<int>());
      expect(m.status, isA<MembershipStatus>());
      expect(m.createdAt, _t0);
      expect(m.createdBy, 'owner_1');
      expect(m.activatedAt, _t0);
      expect(m.renewedFromMembershipId, isNull);
      expect(m.upgradedFromMembershipId, isNull);
    });

    test('membershipId does not encode tenant, student or a guessable sequence '
        '(MM-FR-037)', () {
      final m = _membership();
      // The id this test constructs is a fixture, so the real obligation is
      // checked where ids are minted: the aggregate must not build its own
      // id from tenant or student material.
      expect(m.id, isNot(contains(_tenant.value)));
      expect(m.id, isNot(contains('stu_1')));
      expect(
        RegExp(r"id\s*=\s*'\$\{?tenant").hasMatch(aggregateCode),
        isFalse,
        reason: 'MM-FR-037 forbids encoding tenant information in the id.',
      );
    });

    test('seatQuotaSnapshot is snapshotted so a plan edit cannot invalidate a '
        'seat already in use (MM-FR-025)', () {
      final plan = _plan(seatQuota: 1);
      final m = _membership(plan: plan);

      final shrunk = plan.withEdits(seatQuota: 0);
      expect(shrunk.seatQuota, 0);

      // The student sitting in the seat keeps the entitlement they bought.
      expect(m.seatQuotaSnapshot, 1);
    });

    test('one membership, one transaction: no command mutates two memberships '
        '(MM-BR-020, MM-AC-077)', () {
      // Structural: an instance method that accepted another Membership
      // would put two aggregates inside one transaction boundary.
      final crossAggregate = RegExp(
        r'^\s{2}(?!static)(?:\w[\w<>?,\s]*)\s+\w+\([^)]*\bMembership\b[^)]*\)',
        multiLine: true,
      ).allMatches(membershipBody);

      expect(
        crossAggregate.map((m) => m.group(0)!.trim()).toList(),
        isEmpty,
        reason:
            'MM-BR-020 makes Membership the transaction boundary. An '
            'instance method taking another Membership would cross it. '
            '(assertNoOverlap is static and reads a snapshot list.)',
      );
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // IMPL-412 — the payment-gate split
  // Obligation: "No gateway call, no ledger write, no credential; the split
  // is provable by inspection."
  // ════════════════════════════════════════════════════════════════════
  group('IMPL-412 payment-gate split', () {
    test('the initial status is decided by the payment condition, never '
        'invented (MM-FR-041)', () {
      // Amount owed, no outcome yet -> PendingPayment.
      expect(
        Membership.initialStatusFor(
          applicableAmount: Money.rupees(1200),
          paymentAlreadyReceived: false,
        ),
        MembershipStatus.pendingPayment,
      );

      // Amount owed, outcome already received -> Active.
      expect(
        Membership.initialStatusFor(
          applicableAmount: Money.rupees(1200),
          paymentAlreadyReceived: true,
        ),
        MembershipStatus.active,
      );

      // Nothing owed -> Active, with or without an outcome. A free plan
      // has no payment to wait for.
      expect(
        Membership.initialStatusFor(
          applicableAmount: Money.zero,
          paymentAlreadyReceived: false,
        ),
        MembershipStatus.active,
      );
      expect(
        Membership.initialStatusFor(
          applicableAmount: Money.zero,
          paymentAlreadyReceived: true,
        ),
        MembershipStatus.active,
      );
    });

    test('the gate decides between exactly two statuses and never a third '
        '(MM-FR-041)', () {
      final produced = <MembershipStatus>{};
      for (final amount in [Money.zero, Money.rupees(1)]) {
        for (final received in [true, false]) {
          produced.add(
            Membership.initialStatusFor(
              applicableAmount: amount,
              paymentAlreadyReceived: received,
            ),
          );
        }
      }
      expect(produced, {
        MembershipStatus.active,
        MembershipStatus.pendingPayment,
      });
    });

    test('a PendingPayment membership confers no entitlement (MM-FR-042)', () {
      final m = _membership(status: MembershipStatus.pendingPayment);
      expect(m.status.confersEntitlement, isFalse);
      // Inside its own term, and still not valid. The term is not the
      // authority; the status is.
      expect(m.term.contains(_t0), isTrue);
      expect(m.isValidOn(_t0), isFalse);
    });

    test('the gate reads an outcome, not an amount paid — so no balance is '
        'computed here (MM-BR-001, MM-BR-002)', () {
      // The parameter's type is the argument: a bool cannot carry a partial
      // payment, so this module cannot be tempted to decide "enough paid?".
      // That question is BC-05's, and MM-BR-001 forbids a second ledger.
      expect(
        RegExp(r'required bool paymentAlreadyReceived').hasMatch(aggregateCode),
        isTrue,
        reason:
            'MM-BR-002 says the outcome arrives as a fact over E-10. An '
            'amount parameter here would invite a balance computation.',
      );
    });

    test('no ledger, balance, receipt or refund record exists in this module '
        '(MM-BR-001, MM-XC-004)', () {
      for (final source in [aggregateCode, moduleCode]) {
        for (final banned in const [
          'FeeLedger',
          'LedgerEntry',
          'Receipt',
          'Refund',
          'balance',
        ]) {
          expect(
            source.contains(banned),
            isFalse,
            reason:
                'MM-BR-001 forbids a payment ledger, balance, receipt or '
                'refund record in BC-02. Found "$banned".',
          );
        }
      }
    });

    test('no gateway call and no credential appears in this module '
        '(MM-BR-002, MM-XC-004)', () {
      for (final source in [aggregateCode, moduleCode]) {
        for (final banned in const [
          'gateway',
          'Gateway',
          'razorpay',
          'Razorpay',
          'stripe',
          'Stripe',
          'apiKey',
          'secretKey',
          'merchantId',
          'http',
        ]) {
          expect(
            source.contains(banned),
            isFalse,
            reason:
                'MM-BR-002 forbids polling a gateway from BC-02, and no '
                'credential belongs here. Found "$banned".',
          );
        }
      }
    });

    test('this module does not create the FeeDue itself — it emits and lets '
        'BC-05 raise it (MM-BR-003)', () {
      for (final banned in const [
        'FeeDue(',
        'raiseFeeDue',
        'collectFee',
        'createFeeDue',
      ]) {
        expect(
          moduleCode.contains(banned),
          isFalse,
          reason:
              'MM-BR-003: BC-02 emits MM-EVT-001/003/004 so BC-05 can raise '
              'the FeeDue over E-07. It must not create it. Found "$banned".',
        );
      }

      // And the event it does emit carries the snapshot BC-05 needs.
      expect(moduleCode.contains('membership.MembershipCreated'), isTrue);
      expect(moduleCode.contains("'priceMinor': m.priceSnapshot"), isTrue);
    });

    test('activatedAt is not set while the membership is PendingPayment '
        '(MM-INV-011)', () {
      final e = _rejection(
        () => _membership(
          status: MembershipStatus.pendingPayment,
          activatedAt: _t0,
        ),
      );
      expect(e.code, DomainErrorCode.validationFailed);
      expect(e.context['field'], 'activatedAt');
    });

    test('activation stamps activatedAt once and does not re-stamp it '
        '(MM-INV-011)', () {
      final m = _membership(status: MembershipStatus.pendingPayment);
      expect(m.activatedAt, isNull);

      final first = DateTime.utc(2026, 3, 2);
      m.activate(at: first, by: 'owner_1');
      expect(m.status, MembershipStatus.active);
      expect(m.activatedAt, first);
      expect(m.activatedBy, 'owner_1');

      // MM-INV-011 is "if and only if it has *ever* been Active" — the
      // first activation is the historical fact, so a later one must not
      // overwrite it.
      m.expire();
      m.activatedAt;
      expect(m.activatedAt, first);
    });
  });
}
