/// `BC-02` Membership — the authoritative validity rule, the two independent
/// status machines, and void-before-activation.
///
/// Covers `IMPL-421` (validity and entitlement derivation), `IMPL-422`
/// (membership status vs student status) and `IMPL-423` (void before
/// activation — not a cancellation) against FROZEN `PRD-005` v1.4.
///
/// `IMPL-421`'s obligation is *"exactly **one** validity answer per
/// membership per date (`MM-BR-031`); the five non-active statuses confer
/// nothing"* — so the five are enumerated from the enum rather than named by
/// hand, and the single-answer property is asserted by repetition rather than
/// assumed.
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:liboora/domain/library/membership/membership.dart';
import 'package:liboora/platform/data/data.dart';
import 'package:liboora_contracts/liboora_contracts.dart';

const String _modulePath = 'lib/domain/library/membership/membership.dart';
const String _aggregatePath =
    'lib/domain/library/membership/domain/membership.dart';

/// Source with comments removed.
///
/// The inspection tests below ban words like `refund` and `SeatAllocation`.
/// Those same words appear in the module's own doc comments *stating that they
/// are forbidden*, so a naive scan fails on the prose that documents
/// compliance. Stripping comments makes the test measure the code.
String _codeOnly(String source) => source
    .replaceAll(RegExp(r'/\*.*?\*/', dotAll: true), '')
    .split('\n')
    .map((line) {
      final i = line.indexOf('//');
      return i == -1 ? line : line.substring(0, i);
    })
    .join('\n');

final DateTime _t0 = DateTime(2026, 3, 1);
const _tenant = TenantId('tnt_a');
const _branch = BranchId('brn_a');
const _student = StudentRecordId('stu_1');

final class _Ctx implements TenantContext {
  @override
  TenantId get tenantId => _tenant;
  @override
  BranchId get branchId => _branch;
  @override
  String? get actorId => 'owner_1';
  @override
  bool get hasTenant => true;
  @override
  String get correlationId => 'corr_test';
}

/// An `E-01` double whose answer can be changed between reads.
final class _Enrollment implements EnrollmentStatusReader {
  _Enrollment(this.state);
  MembershipEnrollmentState? state;

  @override
  MembershipEnrollmentState? stateFor(StudentRecordId id) => state;
}

MembershipPlan _plan({int seatQuota = 1}) => MembershipPlan.create(
  id: 'plan_1',
  tenantId: _tenant,
  branchId: _branch,
  name: 'Monthly',
  durationDays: 30,
  price: Money.rupees(1200),
  createdAt: _t0,
  createdBy: 'owner_1',
  seatQuota: seatQuota,
);

Membership _membership({
  MembershipStatus status = MembershipStatus.active,
  DateTime? start,
  int durationDays = 30,
}) {
  final s = start ?? _t0;
  return Membership.fromPlan(
    id: 'mem_1',
    studentRecordId: _student,
    plan: _plan(),
    term: DateRange.days(s, durationDays),
    status: status,
    createdAt: s,
    createdBy: 'owner_1',
    activatedAt: status == MembershipStatus.active ? s : null,
  );
}

DomainError _rejects(void Function() act) {
  try {
    act();
  } on DomainError catch (e) {
    return e;
  }
  fail('Expected a typed DomainError, but the call succeeded.');
}

({
  MembershipValidityService svc,
  InMemoryMembershipRepository repo,
  _Enrollment enr,
})
_service({
  MembershipEnrollmentState? enrollmentState = MembershipEnrollmentState.active,
}) {
  final ctx = _Ctx();
  final repo = InMemoryMembershipRepository(
    TenantPartitionedStore<Membership>(ctx),
  );
  final plans = InMemoryMembershipPlanRepository(
    TenantPartitionedStore<MembershipPlan>(ctx),
  );
  plans.save(_plan());
  final enr = _Enrollment(enrollmentState);
  return (
    svc: MembershipValidityService(repo, plans, enrollment: enr),
    repo: repo,
    enr: enr,
  );
}

void main() {
  // ════════════════════════════════════════════════════════════════════
  // IMPL-421 — the authoritative validity rule
  // ════════════════════════════════════════════════════════════════════
  group('IMPL-421 validity rule (MM-FR-065)', () {
    test('all four clauses must hold for a membership to be valid', () {
      final m = _membership();

      // Status Active, and D inside [startDate, endDate].
      expect(m.isValidOn(m.startDate), isTrue);
      expect(m.isValidOn(m.endDate), isTrue);

      // D before startDate.
      expect(
        m.isValidOn(m.startDate.subtract(const Duration(days: 1))),
        isFalse,
      );
      // D after endDate.
      expect(m.isValidOn(m.endDate.add(const Duration(days: 1))), isFalse);
    });

    test('the FIVE non-active statuses confer nothing, enumerated from the '
        'enum (MM-BR-032, MM-AC-085)', () {
      final nonActive = MembershipStatus.values
          .where((s) => s != MembershipStatus.active)
          .toList();

      expect(
        nonActive,
        hasLength(5),
        reason:
            'MM-FR-072 fixes six statuses, so exactly five are non-active. '
            'If this count changes the status set changed.',
      );

      for (final status in nonActive) {
        final m = _membership(status: status);
        // Inside its own term, and still invalid: the term is not the
        // authority, the status is.
        expect(
          m.isValidOn(_t0),
          isFalse,
          reason: '$status must confer no entitlement.',
        );
        expect(m.status.confersEntitlement, isFalse);
      }
    });

    test(
      'exactly ONE answer per membership per date (MM-BR-031, MM-AC-084)',
      () {
        final m = _membership();
        // Asked repeatedly for the same date: the same answer, because the
        // rule is a pure function of (status, term, day) with no clock, no
        // cache and no stored isValid column that could disagree.
        final answers = <bool>{};
        for (var i = 0; i < 50; i++) {
          answers.add(m.isValidOn(_t0));
        }
        expect(answers, hasLength(1));
        expect(answers.single, isTrue);
      },
    );

    test('there is no stored isValid field on the aggregate — validity is '
        'derived (MM-BR-031)', () {
      final source = _codeOnly(File(_aggregatePath).readAsStringSync());
      expect(
        RegExp(r'\bbool\s+_?isValid\s*;').hasMatch(source),
        isFalse,
        reason:
            'A stored flag is a second source of truth, and MM-BR-031 '
            'requires exactly one answer. It is computed instead.',
      );
    });

    test('the rule is implemented ONCE and exposed through the projection '
        '(MM-FR-066)', () {
      final source = _codeOnly(File(_modulePath).readAsStringSync());
      // Every validity decision in this module routes through isValidOn.
      // A second inline `status == active && term.contains(...)` would be
      // the reimplementation MM-FR-066 forbids.
      final inlineRule = RegExp(
        r'confersEntitlement\s*&&\s*term\.contains',
      ).allMatches(source);
      expect(
        inlineRule,
        isEmpty,
        reason:
            'MM-FR-066: implemented once, inside BC-02. The service must '
            'call isValidOn rather than restate the conjunction.',
      );
    });

    test('the projection carries every MM-FR-067 field, so consumers never '
        're-derive the rule', () {
      final s = _service();
      s.repo.save(_membership());

      final v = s.svc.forStudent(_student, _t0);
      expect(v.isValid, isTrue);
      expect(v.validUntil, DateTime(2026, 3, 30));
      expect(v.seatQuota, 1);
      expect(v.studentRecordId, _student);
      expect(v.status, MembershipStatus.active);
      expect(v.planId, 'plan_1');
      expect(v.planName, 'Monthly');
    });

    test('PendingPayment, Scheduled and Expired report isValid: false AND say '
        'why (MM-FR-068, MM-FR-067)', () {
      for (final status in const [
        MembershipStatus.pendingPayment,
        MembershipStatus.scheduled,
        MembershipStatus.expired,
      ]) {
        final s = _service();
        s.repo.save(_membership(status: status));

        final v = s.svc.forStudent(_student, _t0);
        expect(v.isValid, isFalse, reason: '$status');
        expect(
          v.status,
          status,
          reason:
              'MM-FR-067: status lets the Directory show WHY something is '
              'invalid (PRD-004 LMD-16/LMD-26), instead of every consumer '
              'guessing from validUntil.',
        );
        expect(v.seatQuota, 0, reason: 'No entitlement, no quota.');
      }
    });

    test('a student with no membership at all reports none', () {
      final s = _service();
      final v = s.svc.forStudent(_student, _t0);
      expect(v.isValid, isFalse);
      expect(v.status, isNull);
      expect(v.validUntil, isNull);
    });

    test('an Expired membership confers nothing under the read path '
        '(MM-FR-109, MM-INV-004)', () {
      final s = _service();
      final m = _membership();
      m.expire();
      s.repo.save(m);

      final v = s.svc.forStudent(_student, _t0);
      expect(v.isValid, isFalse);
      expect(v.status, MembershipStatus.expired);
      expect(
        v.seatQuota,
        0,
        reason: 'MM-AC-044: there is no grace path in V1.',
      );
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // IMPL-422 — two independent state machines
  // ════════════════════════════════════════════════════════════════════
  group('IMPL-422 membership status vs student status', () {
    test(
      'a student suspension does NOT change MembershipStatus (MM-FR-077)',
      () {
        final s = _service();
        final m = _membership();
        s.repo.save(m);
        expect(s.svc.forStudent(_student, _t0).isValid, isTrue);

        // Suspend the student.
        s.enr.state = MembershipEnrollmentState.suspended;

        final v = s.svc.forStudent(_student, _t0);
        expect(
          v.isValid,
          isFalse,
          reason:
              'MM-FR-077: the projection reports false for the duration of '
              'the suspension.',
        );
        expect(
          s.repo.byId(m.id)!.status,
          MembershipStatus.active,
          reason:
              'MM-FR-077: "without mutating the membership record". A '
              'suspension that expired the membership would be '
              'irreversible.',
        );
        expect(
          v.status,
          MembershipStatus.active,
          reason:
              'MM-FR-076: the two statuses are separate fields, so the '
              'membership still reports its own.',
        );
      },
    );

    test('reinstating the student restores entitlement without re-selling '
        'anything (MM-FR-077)', () {
      final s = _service();
      s.repo.save(_membership());

      s.enr.state = MembershipEnrollmentState.suspended;
      expect(s.svc.forStudent(_student, _t0).isValid, isFalse);

      s.enr.state = MembershipEnrollmentState.active;
      expect(
        s.svc.forStudent(_student, _t0).isValid,
        isTrue,
        reason:
            'This is the payoff for not mutating: the membership was never '
            'damaged, so it simply becomes valid again.',
      );
    });

    test('losing validity does not delete the membership or alter a snapshot '
        '(MM-FR-070)', () {
      final s = _service();
      final m = _membership();
      s.repo.save(m);
      final priceBefore = m.priceSnapshot;
      final versionBefore = m.planVersionAtPurchase;

      m.expire();
      s.repo.save(m);

      expect(
        s.repo.byId(m.id),
        isNotNull,
        reason: 'MM-BR-024: terminal states are the retirement path.',
      );
      expect(s.repo.byId(m.id)!.priceSnapshot, priceBefore);
      expect(s.repo.byId(m.id)!.planVersionAtPurchase, versionBefore);
    });

    test('this module writes to no downstream context when validity ends '
        '(MM-FR-071)', () {
      final source = _codeOnly(File(_modulePath).readAsStringSync());
      for (final banned in const [
        'releaseSeat',
        'SeatAllocation',
        'AttendanceDay',
        'cancelAttendance',
      ]) {
        expect(
          source.contains(banned),
          isFalse,
          reason:
              'MM-FR-071: BC-02 emits MM-EVT-005 and downstream contexts '
              'apply their own policy. Q-01 (does expiry release the seat?) '
              'is OPEN and is not decided here. Found "$banned".',
        );
      }
    });

    test('the two machines have different value sets, so one cannot be '
        'assigned to the other (MM-FR-076)', () {
      // Structural independence: MembershipStatus and the enrollment state
      // are distinct types, so a refactor cannot quietly unify them.
      expect(MembershipStatus.values.length, 6);
      expect(MembershipEnrollmentState.values.length, 4);
      expect(
        MembershipStatus.values
            .map((e) => e.name)
            .toSet()
            .intersection(
              MembershipEnrollmentState.values.map((e) => e.name).toSet(),
            ),
        {'active'},
        reason:
            'Only the word "active" is shared, and they are separate types '
            'so it cannot be confused at a call site.',
      );
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // IMPL-423 — void before activation
  // ════════════════════════════════════════════════════════════════════
  group('IMPL-423 void before activation (MM-FR-078)', () {
    test('a PendingPayment membership may be voided with a reason', () {
      final m = _membership(status: MembershipStatus.pendingPayment);
      m.voidBeforeActivation(reason: 'Paid at another branch', by: 'owner_1');

      expect(m.status, MembershipStatus.cancelled);
      expect(m.voidReason, 'Paid at another branch');
      expect(m.voidedBy, 'owner_1');
      expect(m.wasVoidedBeforeActivation, isTrue);
    });

    test('a Scheduled membership may be voided (MM-FR-078)', () {
      final m = _membership(status: MembershipStatus.scheduled);
      m.voidBeforeActivation(reason: 'Student withdrew');
      expect(m.status, MembershipStatus.cancelled);
      expect(m.voidReason, 'Student withdrew');
    });

    test('an ACTIVE membership may NOT be voided — that is V2 cancellation '
        '(MM-FR-079, MM-XC-011)', () {
      final m = _membership();
      final e = _rejects(() => m.voidBeforeActivation(reason: 'Refund'));

      expect(e.code, DomainErrorCode.validationFailed);
      expect(e.context['status'], 'active');
      expect(
        m.status,
        MembershipStatus.active,
        reason:
            'MM-FR-079: this must not be extended to an Active membership '
            'and must not be presented as "cancel membership".',
      );
    });

    test('a terminal membership may not be voided again', () {
      for (final status in MembershipStatus.values.where((s) => s.isTerminal)) {
        final m = _membership(status: status);
        final e = _rejects(() => m.voidBeforeActivation(reason: 'x'));
        expect(e.code, DomainErrorCode.validationFailed);
      }
    });

    test('a reason is REQUIRED, not optional (MM-FR-078)', () {
      for (final blank in const ['', '   ', '\n']) {
        final m = _membership(status: MembershipStatus.pendingPayment);
        final e = _rejects(() => m.voidBeforeActivation(reason: blank));
        expect(e.code, DomainErrorCode.validationFailed);
        expect(e.context['field'], 'voidReason');
        expect(
          m.status,
          MembershipStatus.pendingPayment,
          reason: 'A void without a reason must not happen at all.',
        );
      }
    });

    test('a void frees the MM-INV-001 slot, because Cancelled is terminal', () {
      final s = _service();
      final m = _membership(status: MembershipStatus.pendingPayment);
      s.repo.insertGuardingOverlap(m);

      // Before the void, an overlapping term is refused.
      final clash = Membership.fromPlan(
        id: 'mem_2',
        studentRecordId: _student,
        plan: _plan(),
        term: DateRange.days(_t0.add(const Duration(days: 5)), 30),
        createdAt: _t0,
      );
      expect(
        () => s.repo.insertGuardingOverlap(clash),
        throwsA(isA<DomainError>()),
      );

      // Void, and the slot is free.
      m.voidBeforeActivation(reason: 'Wrong plan selected');
      s.repo.save(m);

      expect(
        () => s.repo.insertGuardingOverlap(clash),
        returnsNormally,
        reason:
            'IMPL-423: a voided pre-activation membership frees the '
            'MM-INV-001 slot.',
      );
    });

    test('a void is distinguishable from an ordinary Cancelled row '
        '(MM-FR-079)', () {
      final voided = _membership(status: MembershipStatus.pendingPayment);
      voided.voidBeforeActivation(reason: 'Duplicate entry');

      final plainCancelled = _membership(
        status: MembershipStatus.pendingPayment,
      );
      plainCancelled.cancel();

      expect(voided.status, plainCancelled.status);
      expect(voided.wasVoidedBeforeActivation, isTrue);
      expect(
        plainCancelled.wasVoidedBeforeActivation,
        isFalse,
        reason:
            'MM-FR-079 forbids presenting a void as a cancellation, and a '
            'consumer can only honour that if it can tell them apart.',
      );
    });

    test('a void triggers no refund and records no money (MM-FR-079)', () {
      final source = _codeOnly(File(_aggregatePath).readAsStringSync());
      for (final banned in const ['refund', 'Refund']) {
        expect(
          source.contains(banned),
          isFalse,
          reason:
              'MM-FR-079: a void MUST NOT trigger a refund. Refund-bearing '
              'cancellation is V2 (MM-XC-011). Found "$banned".',
        );
      }
    });
  });
}
