/// Demo data seeder.
///
/// Deliberately drives the **real use cases** rather than stuffing the stores
/// directly. Consequences that matter:
///
///  * Every dashboard number is derived from published events, so the
///    projections are exercised on the very first frame.
///  * Every invariant is exercised too — if `Membership.assertNoOverlap` or
///    `SeatAllocation.assertSeatFree` were wrong, boot would throw.
///  * A second tenant is seeded so cross-tenant isolation is demonstrable,
///    not merely asserted in a document.
library;

import 'package:liboora_contracts/liboora_contracts.dart';

import '../domain/library/attendance/attendance.dart';
import '../domain/library/enrollment/enrollment.dart';
import '../domain/library/fee/fee.dart';
import '../domain/library/membership/membership.dart';
import '../domain/library/policy/policy.dart';
import '../domain/library/seating/seating.dart';
import '../domain/social/social.dart';
import '../platform/identity/identity.dart';
import '../platform/tenancy/tenancy.dart';
import 'di.dart';

/// The tenant the demo signs into.
const kDemoTenant = TenantId('tnt_aspirants');
const kDemoBranch = BranchId('brn_lajpat');
const kDemoBranchTwo = BranchId('brn_saket');

/// A second tenant, seeded to prove partitioning.
const kOtherTenant = TenantId('tnt_focuszone');
const kOtherBranch = BranchId('brn_kota');

Future<void> seedDemoData(AppContainer c, List<Account> accounts) async {
  _seedTenants(c);
  _seedPolicies(c);
  _seedPlans(c);
  _seedAccounts(c, accounts);

  // ── Demo tenant ────────────────────────────────────────────────
  c.enterScope(tenant: kDemoTenant, branch: kDemoBranch, actor: 'seed');
  _seedSeatLayout(c);
  await _seedStudents(c);
  c.leaveScope();

  // ── Second tenant, so isolation is visible ─────────────────────
  c.enterScope(tenant: kOtherTenant, branch: kOtherBranch, actor: 'seed');
  _seedOtherTenantSeats(c);
  await _seedOtherTenantStudents(c);
  c.leaveScope();

  c.clock.unpin();
}

// ───────────────────────────────────────────────────────────────────
// Tenancy, policy, catalogue
// ───────────────────────────────────────────────────────────────────

void _seedTenants(AppContainer c) {
  c.tenants.addAll([
    const Tenant(
      id: kDemoTenant,
      name: 'Aspirants Study Hub',
      tier: TenantTier.growth,
      branches: [
        Branch(
          id: kDemoBranch,
          name: 'Lajpat Nagar',
          address: 'Block C, Lajpat Nagar II, New Delhi',
        ),
        Branch(
          id: kDemoBranchTwo,
          name: 'Saket',
          address: 'Press Enclave Road, Saket, New Delhi',
        ),
      ],
    ),
    const Tenant(
      id: kOtherTenant,
      name: 'FocusZone Library',
      tier: TenantTier.starter,
      branches: [
        Branch(
          id: kOtherBranch,
          name: 'Kota Main',
          address: 'Talwandi, Kota, Rajasthan',
        ),
      ],
    ),
  ]);

  c.entitlements.registerTenant(kDemoTenant, TenantTier.growth);
  c.entitlements.registerTenant(kOtherTenant, TenantTier.starter);
}

void _seedPolicies(AppContainer c) {
  final from = DateTime(DateTime.now().year, 1, 1);

  // 06:00 – 23:00, the realistic window for an Indian study hall.
  c.policies.save(
    BranchPolicy(
      branchId: kDemoBranch,
      workingHours: const WorkingHours(opensAt: 6 * 60, closesAt: 23 * 60),
      effectiveFrom: from,
      graceMinutes: 30,
    ),
  );
  c.policies.save(
    BranchPolicy(
      branchId: kDemoBranchTwo,
      workingHours: const WorkingHours(opensAt: 7 * 60, closesAt: 22 * 60),
      effectiveFrom: from,
    ),
  );
  c.policies.save(
    BranchPolicy(
      branchId: kOtherBranch,
      workingHours: const WorkingHours(opensAt: 5 * 60, closesAt: 24 * 60 - 1),
      effectiveFrom: from,
    ),
  );
}

void _seedPlans(AppContainer c) {
  c.plans.addAll([
    MembershipPlan(
      id: 'plan_float',
      name: 'Floating Monthly',
      price: Money.rupees(1200),
      durationDays: 30,
      seatQuota: 0, // no reserved chair — first come, first served
    ),
    MembershipPlan(
      id: 'plan_reserved',
      name: 'Reserved Seat Monthly',
      price: Money.rupees(1800),
      durationDays: 30,
      seatQuota: 1,
    ),
    MembershipPlan(
      id: 'plan_quarter',
      name: 'Reserved Quarterly',
      price: Money.rupees(4800),
      durationDays: 90,
      seatQuota: 1,
      freezeDaysAllowed: 15,
    ),
    MembershipPlan(
      id: 'plan_ac',
      name: 'AC Cabin Monthly',
      price: Money.rupees(2500),
      durationDays: 30,
      seatQuota: 1,
      freezeDaysAllowed: 10,
    ),
  ]);
}

void _seedAccounts(AppContainer c, List<Account> accounts) {
  const demo = 'tnt_aspirants';
  accounts.addAll([
    Account(
      id: const AccountId('acc_owner'),
      phone: '9810000001',
      displayName: 'Rajesh Sharma',
      roles: const {
        demo: {AccessRole.owner},
      },
    ),
    Account(
      id: const AccountId('acc_manager'),
      phone: '9810000002',
      displayName: 'Priya Nair',
      roles: const {
        demo: {AccessRole.manager},
      },
    ),
    Account(
      id: const AccountId('acc_reception'),
      phone: '9810000003',
      displayName: 'Amit Kumar',
      roles: const {
        demo: {AccessRole.reception},
      },
    ),
    Account(
      id: const AccountId('acc_student'),
      phone: '9810000004',
      displayName: 'Sneha Verma',
      personId: const PersonId('per_sneha'),
      roles: const {
        demo: {AccessRole.student},
      },
    ),
    Account(
      id: const AccountId('acc_parent'),
      phone: '9810000005',
      displayName: 'Suresh Verma',
      roles: const {
        demo: {AccessRole.parent},
      },
    ),
  ]);

  // The social persona exists in a separate store, cross-tenant, linked only
  // by PersonId. Nothing in the library domain reads this.
  c.socialProfiles.save(
    GlobalStudentProfile(
      personId: const PersonId('per_sneha'),
      displayName: 'Sneha Verma',
      headline: 'B.Com final year · targeting CAT 2026',
      examTrack: 'CAT',
    )..lifetimeStudyMinutes = 41 * 60,
  );
}

// ───────────────────────────────────────────────────────────────────
// Seats
// ───────────────────────────────────────────────────────────────────

void _seedSeatLayout(AppContainer c) {
  final seats = <Seat>[];
  for (var i = 1; i <= 14; i++) {
    seats.add(
      Seat(
        id: 'A$i',
        label: 'A-${i.toString().padLeft(2, '0')}',
        zone: 'Silent Zone',
        hasPowerSocket: i % 2 == 0,
        isCorner: i == 1 || i == 14,
      ),
    );
  }
  for (var i = 1; i <= 8; i++) {
    seats.add(
      Seat(
        id: 'B$i',
        label: 'B-${i.toString().padLeft(2, '0')}',
        zone: 'AC Hall',
        hasPowerSocket: true,
      ),
    );
  }
  for (var i = 1; i <= 6; i++) {
    seats.add(
      Seat(
        id: 'C$i',
        label: 'C-${i.toString().padLeft(2, '0')}',
        zone: 'Discussion Zone',
      ),
    );
  }
  c.seatLayouts.save(SeatLayout(branchId: kDemoBranch, seats: seats));
}

void _seedOtherTenantSeats(AppContainer c) {
  c.seatLayouts.save(
    SeatLayout(
      branchId: kOtherBranch,
      seats: [
        for (var i = 1; i <= 10; i++)
          Seat(
            id: 'K$i',
            label: 'K-${i.toString().padLeft(2, '0')}',
            zone: 'Main Hall',
          ),
      ],
    ),
  );
}

// ───────────────────────────────────────────────────────────────────
// Students, memberships, seats, fees, attendance
// ───────────────────────────────────────────────────────────────────

/// (name, phone, birth year, plan index, seat id or null, paid in full)
const _roster =
    <
      ({
        String name,
        String phone,
        int birthYear,
        int plan,
        String? seat,
        bool paidInFull,
      })
    >[
      (
        name: 'Sneha Verma',
        phone: '9810000004',
        birthYear: 2003,
        plan: 2,
        seat: 'A3',
        paidInFull: true,
      ),
      (
        name: 'Arjun Mehta',
        phone: '9810000011',
        birthYear: 2001,
        plan: 1,
        seat: 'A5',
        paidInFull: true,
      ),
      (
        name: 'Kavya Iyer',
        phone: '9810000012',
        birthYear: 2002,
        plan: 3,
        seat: 'B2',
        paidInFull: false,
      ),
      (
        name: 'Rohan Gupta',
        phone: '9810000013',
        birthYear: 2000,
        plan: 0,
        seat: null,
        paidInFull: true,
      ),
      (
        name: 'Ananya Singh',
        phone: '9810000014',
        birthYear: 2004,
        plan: 1,
        seat: 'A8',
        paidInFull: false,
      ),
      (
        name: 'Vikram Reddy',
        phone: '9810000015',
        birthYear: 1999,
        plan: 1,
        seat: 'B5',
        paidInFull: true,
      ),
      (
        name: 'Meera Joshi',
        phone: '9810000016',
        birthYear: 2003,
        plan: 0,
        seat: null,
        paidInFull: false,
      ),
      (
        name: 'Karan Malhotra',
        phone: '9810000017',
        birthYear: 2002,
        plan: 2,
        seat: 'A11',
        paidInFull: true,
      ),
      (
        name: 'Divya Menon',
        phone: '9810000018',
        birthYear: 2001,
        plan: 3,
        seat: 'B7',
        paidInFull: true,
      ),
      (
        name: 'Siddharth Rao',
        phone: '9810000019',
        birthYear: 2005,
        plan: 1,
        seat: 'A14',
        paidInFull: false,
      ),
      (
        name: 'Ishita Bansal',
        phone: '9810000020',
        birthYear: 2000,
        plan: 0,
        seat: null,
        paidInFull: true,
      ),
      (
        name: 'Nikhil Chawla',
        phone: '9810000021',
        birthYear: 2002,
        plan: 1,
        seat: 'C2',
        paidInFull: false,
      ),
    ];

Future<void> _seedStudents(AppContainer c) async {
  const owner = AccessRole.owner;
  final records = <StudentRecordId>[];

  for (final r in _roster) {
    c.clock.pin(c.clock.todayAt(9, 0));

    final student = await c.enrollStudent(
      actorRole: owner,
      fullName: r.name,
      phone: r.phone,
      dateOfBirth: DateTime(r.birthYear, 6, 15),
      guardian: DateTime.now().year - r.birthYear < 18
          ? GuardianLink(
              name: 'Guardian of ${r.name}',
              phone: '98100999${records.length}',
            )
          : null,
    );
    records.add(student.id);
    c.studentAccountLinks[r.phone] = student.id;

    final plan = c.plans[r.plan];

    // Membership starts staggered in the past so the dashboard shows a mix of
    // "expiring soon" and "comfortable".
    final startedDaysAgo = 3 + (records.length * 2);
    await c.createMembership(
      actorRole: owner,
      studentId: student.id,
      plan: plan,
      startingOn: c.clock.today().subtract(Duration(days: startedDaysAgo)),
    );

    // Fee: raise the plan price, collect fully or partially.
    await c.raiseFeeDue(
      actorRole: owner,
      studentId: student.id,
      description: '${plan.name} — ${_monthName(c.clock.today().month)}',
      amount: plan.price,
      sourceRef: plan.id,
    );
    if (r.paidInFull) {
      await c.collectFee(
        actorRole: owner,
        studentId: student.id,
        amount: plan.price,
        mode: records.length.isEven ? PaymentMode.upi : PaymentMode.cash,
      );
    } else {
      await c.collectFee(
        actorRole: owner,
        studentId: student.id,
        amount: plan.price.prorate(50, 100),
        mode: PaymentMode.upi,
        note: 'Part payment',
      );
    }

    // Seat, where the plan includes one.
    if (r.seat != null) {
      await c.assignSeat(
        actorRole: owner,
        studentId: student.id,
        seatId: r.seat!,
      );
    }
  }

  await _seedTodaysAttendance(c, records);
}

/// A believable day: some early birds already checked out, most still inside.
Future<void> _seedTodaysAttendance(
  AppContainer c,
  List<StudentRecordId> records,
) async {
  const times = <(int, int)>[
    (6, 10),
    (6, 25),
    (7, 5),
    (7, 40),
    (8, 15),
    (8, 50),
    (9, 30),
    (10, 5),
    (10, 45),
    (11, 20),
  ];

  for (var i = 0; i < times.length && i < records.length; i++) {
    final (h, m) = times[i];
    c.clock.pin(c.clock.todayAt(h, m));
    await c.checkIn(
      actorRole: AccessRole.reception,
      studentId: records[i],
      method: i.isEven ? VerificationMethod.qr : VerificationMethod.gps,
    );
  }

  // First three have gone home for lunch.
  for (var i = 0; i < 3; i++) {
    c.clock.pin(c.clock.todayAt(13, 30 + i * 5));
    await c.checkOut(actorRole: AccessRole.reception, studentId: records[i]);
  }

  // Idempotency demonstration: the same key replayed is a no-op, not a
  // second punch. This is what an offline queue flush looks like.
  c.clock.pin(c.clock.todayAt(11, 21));
  const replayKey = IdempotencyKey('idem_offline_replay_demo');
  await c.checkIn(
    actorRole: AccessRole.reception,
    studentId: records[10],
    key: replayKey,
  );
  await c.checkIn(
    actorRole: AccessRole.reception,
    studentId: records[10],
    key: replayKey,
  );

  c.clock.unpin();
}

Future<void> _seedOtherTenantStudents(AppContainer c) async {
  c.clock.pin(c.clock.todayAt(9, 0));
  for (final name in ['Aditya Nair', 'Pooja Sharma', 'Harsh Tiwari']) {
    final s = await c.enrollStudent(
      actorRole: AccessRole.owner,
      fullName: name,
      phone: '9990000${c.students.all().length + 1}',
      dateOfBirth: DateTime(2002, 3, 10),
    );
    await c.createMembership(
      actorRole: AccessRole.owner,
      studentId: s.id,
      plan: c.plans[1],
      startingOn: c.clock.today(),
    );
  }
  c.clock.unpin();
}

String _monthName(int m) => const [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
][m - 1];
