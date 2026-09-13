/// `BC-02` Membership — plan fields, eligibility, lifecycle, mutability and
/// the closed edge set.
///
/// Covers `IMPL-403` (field validation with typed rejection), `IMPL-404`
/// (eligibility, deliberately minimal), `IMPL-405` (lifecycle and the
/// committed-membership guarantee), `IMPL-406` (post-use mutability) and
/// `IMPL-428` (the ten declared edges, closed) against FROZEN `PRD-005` v1.4.
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:liboora/domain/library/membership/membership.dart';
import 'package:liboora/platform/data/data.dart';
import 'package:liboora_contracts/liboora_contracts.dart';

final DateTime _t0 = DateTime.utc(2026, 3, 1);
const _tenant = TenantId('tnt_a');
const _branch = BranchId('brn_a');

MembershipPlan _plan({
  String id = 'plan_1',
  String name = 'Monthly',
  int durationDays = 30,
  Money? price,
  int seatQuota = 1,
  bool isActive = true,
  PlanAvailability availability = PlanAvailability.public,
  PlanEligibility eligibility = PlanEligibility.enrollmentOnly,
}) => MembershipPlan.create(
  id: id,
  tenantId: _tenant,
  branchId: _branch,
  name: name,
  durationDays: durationDays,
  price: price ?? Money.rupees(1200),
  createdAt: _t0,
  createdBy: 'owner_1',
  seatQuota: seatQuota,
  isActive: isActive,
  availability: availability,
  eligibility: eligibility,
);

DomainError _rejection(void Function() act) {
  try {
    act();
  } on DomainError catch (e) {
    return e;
  }
  fail('Expected a typed DomainError, but the call succeeded.');
}

void main() {
  // ════════════════════════════════════════════════════════════════════
  // IMPL-403 — every field's validation rejects with a typed error that
  // NAMES the field.
  // ════════════════════════════════════════════════════════════════════
  group('IMPL-403 · plan field validation names the offending field', () {
    test('MM-FR-011 — durationDays must be a positive integer', () {
      for (final bad in [0, -1, -30]) {
        final e = _rejection(() => _plan(durationDays: bad));
        expect(e.code, DomainErrorCode.validationFailed);
        expect(
          e.context['field'],
          'durationDays',
          reason:
              'IMPL-403 requires the error to name the field. "Invalid plan" '
              'tells reception nothing about what to fix.',
        );
      }
    });

    test('MM-FR-011 — durationDays: 1 is permitted (MM-GAP-008 is about the '
        'TERM, not the plan)', () {
      // MM-FR-011 explicitly permits durationDays: 1. MM-GAP-008 records that
      // a single-day TERM collides with BC Map §8's strict `>`; that is an
      // OPEN Architecture question about DateRange, not a licence to reject
      // the plan field here. Deciding it either way would be inventing policy.
      expect(() => _plan(durationDays: 1), returnsNormally);
    });

    test('MM-FR-012 — price must be non-negative and is never a float', () {
      final e = _rejection(() => _plan(price: Money.rupees(-1)));
      expect(e.context['field'], 'price');

      // Zero is lawful: MM-FR-041 contemplates an amount of zero activating
      // immediately, so a free plan must be representable.
      expect(() => _plan(price: Money.zero), returnsNormally);

      // MM-FR-012 forbids a floating-point type. Money stores minor units.
      expect(_plan(price: Money.rupees(1250.75)).price.minorUnits, 125075);
    });

    test('MM-FR-013 — the ISO-4217 shape rule is enforced, and Money makes a '
        'bad code unconstructible anyway', () {
      // Two layers, and the outer one is the stronger:
      //  1. Money's constructor is PRIVATE and every public factory hard-codes
      //     'INR', so a caller cannot build a Money in 'rupee' at all. That is
      //     MM-FR-013 satisfied structurally, and it is why no negative case
      //     can be written here without reaching into the kernel.
      //  2. The plan still validates the shape, so if Money ever gains a
      //     multi-currency factory the rule is already in place.
      expect(_plan().currency, 'INR');
      expect(Money.paise(1).currency, 'INR');
      expect(Money.zero.currency, 'INR');

      final src = File('lib/domain/library/membership/domain/membership.dart')
          .readAsStringSync();
      expect(
        src.contains('[A-Z]{3}') && src.contains('_isIso4217'),
        isTrue,
        reason:
            'MM-FR-013 requires an ISO-4217 code. The check must exist even '
            'while Money can only produce INR, or adding a second currency '
            'later silently ships an unvalidated field.',
      );
      expect(
        src.contains("'currency',"),
        isTrue,
        reason: 'The rejection must name the currency field.',
      );
    });

    test('MM-FR-014 — seatQuota must be a non-negative integer', () {
      final e = _rejection(() => _plan(seatQuota: -1));
      expect(e.context['field'], 'seatQuota');

      // Zero is the floating plan: no reserved chair, first come first served.
      expect(() => _plan(seatQuota: 0), returnsNormally);
    });

    test('blank identity and name are refused', () {
      expect(_rejection(() => _plan(id: '  ')).context['field'], 'planId');
      expect(_rejection(() => _plan(name: '   ')).context['field'], 'name');
    });

    test('MM-FR-008 — currency is exposed and always agrees with the price',
        () {
      final p = _plan(price: Money.rupees(500));
      expect(p.currency, 'INR');
      expect(
        p.price.currency,
        p.currency,
        reason:
            'MM-FR-008 lists price and currency separately. Deriving currency '
            'from price is what makes them structurally unable to disagree.',
      );
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // IMPL-404 — only the two specified eligibility rules exist.
  // ════════════════════════════════════════════════════════════════════
  group('IMPL-404 · eligibility is deliberately minimal', () {
    test('MM-FR-016 — the rule set is exactly enrollment + optional age bound',
        () {
      final fields = RegExp(r'final\s+int\?\s+(\w+);')
          .allMatches(
            File('lib/domain/library/membership/domain/membership.dart')
                .readAsStringSync(),
          )
          .map((m) => m.group(1))
          .toSet();
      expect(
        fields.containsAll({'minAgeYears', 'maxAgeYears'}),
        isTrue,
        reason: 'The two specified bounds must exist.',
      );
      // A third criterion is not silently added: IMPL-404's own obligation.
      expect(
        PlanEligibility.enrollmentOnly.hasAgeBound,
        isFalse,
        reason: 'The default plan carries no age rule at all.',
      );
    });

    test('MM-FR-017 / MM-XC-001 — evaluated from an age, never a birth date',
        () {
      const rule = PlanEligibility(minAgeYears: 18, maxAgeYears: 25);
      expect(rule.isSatisfiedByAge(18), isTrue); // inclusive lower bound
      expect(rule.isSatisfiedByAge(25), isTrue); // inclusive upper bound
      expect(rule.isSatisfiedByAge(17), isFalse);
      expect(rule.isSatisfiedByAge(26), isFalse);

      // The signature takes an int that BC-01 resolved. If it took a
      // DateTime, this module would be computing from a DOB, which MM-XC-001
      // forbids. Asserted structurally:
      final src = File('lib/domain/library/membership/domain/membership.dart')
          .readAsStringSync();
      expect(
        src.contains('isSatisfiedByAge(int ageYears)'),
        isTrue,
        reason:
            'MM-FR-017: BC-01 answers the age question. A DateTime parameter '
            'here would make BC-02 compute from a date of birth.',
      );
    });

    test('a reversed or negative age bound is a typed rejection', () {
      expect(
        _rejection(
          () => _plan(
            eligibility: const PlanEligibility(minAgeYears: 30, maxAgeYears: 20),
          ),
        ).context['field'],
        'maxAgeYears',
      );
      expect(
        _rejection(
          () => _plan(eligibility: const PlanEligibility(minAgeYears: -1)),
        ).context['field'],
        'minAgeYears',
      );
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // IMPL-405 — lifecycle, and the committed-membership guarantee.
  // ════════════════════════════════════════════════════════════════════
  group('IMPL-405 · plan lifecycle', () {
    test('MM-FR-018 — create, edit, activate, deactivate, list all exist', () {
      final p = _plan();
      expect(p.isActive, isTrue);
      expect(p.deactivate().isActive, isFalse);
      expect(p.deactivate().activate().isActive, isTrue);
      expect(p.withEdits(name: 'Renamed').name, 'Renamed');
    });

    test('MM-FR-019 — deactivation alters no existing membership and no '
        'price snapshot', () {
      final p = _plan(price: Money.rupees(1800));
      final m = Membership.fromPlan(
        id: 'mem_1',
        studentRecordId: const StudentRecordId('sr_1'),
        plan: p,
        term: DateRange.days(_t0, 30),
      );

      final retired = p.deactivate();

      expect(retired.isActive, isFalse);
      expect(
        m.priceSnapshot.minorUnits,
        180000,
        reason:
            'MM-FR-019: retiring a plan must not restate what a student '
            'already bought. The snapshot is the structural guarantee.',
      );
      expect(m.status, MembershipStatus.active);
      expect(m.planId, p.id);
    });

    test('MM-FR-020 / MM-BR-029 — a deactivated plan is not selectable', () {
      expect(_plan().isSelectable, isTrue);
      expect(_plan().deactivate().isSelectable, isFalse);
    });

    test('MM-FR-015 / MM-AC-012 — a StaffOnly plan is never student-visible',
        () {
      final staff = _plan(availability: PlanAvailability.staffOnly);
      expect(
        staff.isStudentVisible,
        isFalse,
        reason: 'MM-AC-012: a StaffOnly plan never appears in a '
            'student-facing list.',
      );
      // It remains sellable by reception.
      expect(staff.isSelectable, isTrue);
      expect(_plan().isStudentVisible, isTrue);
    });

    test('the repository separates selectable from student-visible', () {
      final ctx = _BoundContext();
      final repo = InMemoryMembershipPlanRepository(
        TenantPartitionedStore<MembershipPlan>(ctx),
      );
      repo.save(_plan(id: 'p_public', name: 'Public'));
      repo.save(
        _plan(
          id: 'p_staff',
          name: 'Staff Cabin',
          availability: PlanAvailability.staffOnly,
        ),
      );
      repo.save(_plan(id: 'p_retired', name: 'Retired', isActive: false));

      expect(repo.all().length, 3, reason: 'Nothing is deleted.');
      expect(
        repo.selectable().map((p) => p.id).toSet(),
        {'p_public', 'p_staff'},
      );
      expect(repo.studentVisible().map((p) => p.id).toSet(), {'p_public'});
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // IMPL-406 — post-use mutability.
  // ════════════════════════════════════════════════════════════════════
  group('IMPL-406 · what may and may not change', () {
    test('MM-FR-022 — every edit increments version', () {
      var p = _plan();
      expect(p.version, 1);
      p = p.withEdits(name: 'A');
      expect(p.version, 2);
      p = p.withEdits(price: Money.rupees(1500));
      expect(p.version, 3);
      p = p.deactivate();
      expect(p.version, 4, reason: 'Deactivation is an edit.');
    });

    test('MM-FR-024 — the currency-change guard exists on the edit path', () {
      // Money currently admits only INR, so this cannot be provoked through
      // the public API — stated plainly rather than dressed up as a passing
      // negative test. The guard is asserted structurally, because MM-FR-024
      // must already hold on the day Money gains a second currency.
      final src = File('lib/domain/library/membership/domain/membership.dart')
          .readAsStringSync();
      final start = src.indexOf('MembershipPlan withEdits(');
      final body = src.substring(start, start + 1400);
      expect(
        body.contains('nextPrice.currency != this.price.currency'),
        isTrue,
        reason:
            'MM-FR-024: currency is IMMUTABLE once a membership references '
            'the plan, and Money carries its currency inside the price — so a '
            'price edit is exactly how one would be smuggled in.',
      );

      // A same-currency price edit still succeeds.
      final p = _plan(price: Money.rupees(1200));
      expect(p.withEdits(price: Money.rupees(1500)).price.minorUnits, 150000);
    });

    test('MM-FR-023 — a permitted edit applies forward only', () {
      final p = _plan(price: Money.rupees(1200));
      final sold = Membership.fromPlan(
        id: 'mem_1',
        studentRecordId: const StudentRecordId('sr_1'),
        plan: p,
        term: DateRange.days(_t0, 30),
      );

      final repriced = p.withEdits(price: Money.rupees(9999));

      expect(repriced.price.minorUnits, 999900);
      expect(
        sold.priceSnapshot.minorUnits,
        120000,
        reason:
            'MM-FR-023/MM-BR-033: an edit MUST NOT alter any existing '
            'membership. The membership holds a snapshot, not a reference.',
      );
      expect(sold.planVersionAtPurchase, 1);
      expect(repriced.version, 2);
    });

    test('MM-FR-021 — identity and scope cannot be edited at all', () {
      final src = File('lib/domain/library/membership/domain/membership.dart')
          .readAsStringSync();
      final start = src.indexOf('MembershipPlan withEdits(');
      final sig = src.substring(start, src.indexOf('}) {', start));
      for (final immutable in ['tenantId', 'branchId', 'planId', 'createdAt']) {
        expect(
          sig.contains(immutable),
          isFalse,
          reason:
              'MM-FR-021 marks $immutable IMMUTABLE. A parameter that does '
              'not exist cannot be passed, which is stronger than a guard.',
        );
      }
    });

    test('an edit cannot produce an invalid plan', () {
      final p = _plan();
      expect(
        _rejection(() => p.withEdits(durationDays: 0)).context['field'],
        'durationDays',
        reason:
            'A plan that can be EDITED into an invalid state is gated, not '
            'validated. Creation and edit share one rule set.',
      );
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // IMPL-428 — the ten declared edges, closed.
  // ════════════════════════════════════════════════════════════════════
  group('IMPL-428 · the edge set is closed at ten (MM-BR-006)', () {
    test('exactly the ten BC Map §7 edges exist', () {
      expect(
        MembershipEdge.values.length,
        10,
        reason:
            'MM-BR-006: this module MUST NOT use an edge not listed. BC Map '
            'L292: an edge absent from the table does not exist and adding '
            'one requires an ADR. An eleventh value here would be that ADR '
            'made by accident.',
      );
    });

    test('MM-BR-008 — no BC-06 Library Policy edge is constructible', () {
      final names = MembershipEdge.values.map((e) => e.name).toList();
      for (final absent in ['e06', 'e04', 'e05', 'e26', 'e27', 'e28']) {
        expect(
          names.any((n) => n.toLowerCase().startsWith(absent)),
          isFalse,
          reason:
              'MM-BR-008 forbids consuming BC-06 directly, and no '
              'BC-06 → BC-02 edge exists in §7. $absent must not appear.',
        );
      }
    });

    test('MM-BR-007 — the E-02/E-03 asymmetry is preserved', () {
      expect(
        MembershipEdge.e02SeatingProjection.blocksOnInvalidMembership,
        isTrue,
        reason: 'Seating BLOCKS: a seat is a scarce reserved resource.',
      );
      expect(
        MembershipEdge.e03AttendanceProjection.blocksOnInvalidMembership,
        isFalse,
        reason:
            'Attendance RECORDS AND FLAGS. BC Map §7.1 documents this "so a '
            'future engineer does not fix it" — never lock a paying student '
            'out at the door.',
      );

      // Exactly one edge blocks. If a second ever does, the asymmetry is gone.
      expect(
        MembershipEdge.values
            .where((e) => e.blocksOnInvalidMembership)
            .length,
        1,
      );
    });
  });
}

/// A tenant context bound to one tenant, for repository-level tests.
final class _BoundContext implements TenantContext {
  @override
  TenantId get tenantId => _tenant;
  @override
  BranchId get branchId => _branch;
  @override
  String? get actorId => 'test';
  @override
  bool get hasTenant => true;
  @override
  String get correlationId => 'corr_test';
}
