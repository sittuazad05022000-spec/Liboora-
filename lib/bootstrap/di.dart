/// **Composition Root.**
///
/// The single place in the codebase permitted to know both a port and its
/// adapter. Every `new` of an infrastructure type happens here; nothing above
/// this file imports an adapter. Swapping the in-memory stores for Firestore
/// is a change to this file and nothing else — that is the payoff of the
/// dependency rules in LIBOORA_MODULE_DEPENDENCY_MATRIX.md.
///
/// It is also the only file allowed to call `MutableTenantContext.enter`.
library;

import 'package:liboora_contracts/liboora_contracts.dart';

import '../domain/library/attendance/attendance.dart';
import '../domain/library/enrollment/enrollment.dart';
import '../domain/library/fee/fee.dart';
import '../domain/library/membership/membership.dart';
import '../domain/library/policy/policy.dart';
import '../domain/library/seating/seating.dart';
import '../domain/person/person.dart';
import '../domain/social/social.dart';
import '../platform/analytics/analytics.dart';
import '../platform/audit/audit.dart';
import '../platform/business/business.dart';
import '../platform/data/data.dart';
import '../platform/event/event.dart';
import '../platform/identity/identity.dart';
import '../platform/observability/observability.dart';
import '../platform/services/services.dart';
import '../platform/tenancy/tenancy.dart';
import 'clock.dart';

/// Everything the app needs, assembled once.
final class AppContainer {
  AppContainer._({
    required this.tenantContext,
    required this.clock,
    required this.ids,
    required this.telemetry,
    required this.events,
    required this.entitlements,
    required this.idempotency,
    required this.jobs,
    required this.fileAccess,
    required this.sync,
    required this.audit,
    required this.analytics,
    required this.policies,
    required this.students,
    required this.memberships,
    required this.membershipValidity,
    required this.attendance,
    required this.seatLayouts,
    required this.seatAllocations,
    required this.seatMap,
    required this.ledgers,
    required this.outstanding,
    required this.identities,
    required this.identityService,
    required this.socialPresences,
    required this.auth,
    required this.enrollStudent,
    required this.createMembership,
    required this.checkIn,
    required this.checkOut,
    required this.assignSeat,
    required this.releaseSeat,
    required this.raiseFeeDue,
    required this.collectFee,
  });

  // ── Kernel adapters ──────────────────────────────────────────────
  final MutableTenantContext tenantContext;
  final MutableClock clock;
  final IdGenerator ids;
  final ConsoleTelemetry telemetry;

  // ── Capability platforms ─────────────────────────────────────────
  final EventBus events;
  final EntitlementService entitlements;
  final IdempotencyService idempotency;

  /// The `platform/services:job_runtime` port declared at
  /// `tool/module_dependencies.yaml` L338, which `FIL-XC-017` obliges the File
  /// & Media module to consume rather than reimplement.
  ///
  /// Typed to the **port**, not to [InProcessJobRuntime], deliberately. The V1
  /// adapter is in-process and does not survive a restart (`ADR-0058` §7); the
  /// whole point of naming the abstraction here is that replacing it with a
  /// durable queue stays a change to this file alone.
  final JobRuntime jobs;

  /// The `platform/services:files` port (manifest **L242**) — the `E-22`
  /// boundary made executable by `ADR-0059`.
  ///
  /// Port-typed, so no consumer can reach past it to the in-memory adapter and
  /// so replacing it with a storage-backed implementation stays a change to
  /// this file. `FIL-FR-006` is enforced inside it: a caller whose bounded
  /// context is absent from BC Map L331's consumer list is refused.
  final FileAccess fileAccess;

  final OfflineSyncEngine sync;
  final AuditTrail audit;
  final AnalyticsProjections analytics;

  // ── Domain repositories / read models ────────────────────────────
  final PolicyRepository policies;
  final StudentRepository students;
  final MembershipRepository memberships;
  final MembershipValidityReader membershipValidity;
  final AttendanceRepository attendance;
  final SeatLayoutRepository seatLayouts;
  final SeatAllocationRepository seatAllocations;
  final SeatMapService seatMap;
  final FeeLedgerRepository ledgers;
  final OutstandingBalanceService outstanding;

  /// BC-10 Global Person Identity (rank 7.5). Not tenant-partitioned: identity
  /// is global by construction and holds no tenant key (`SID-4.49`).
  final InMemoryPersonIdentityRepository identities;

  /// The `SPO-1` creation service, wired into `BC-18` through the rank-0
  /// [PersonIdentityFactory] port.
  final PersonIdentityService identityService;

  /// BC-11 social graph presence. A consumer of identity, never its owner.
  final InMemorySocialPresenceRepository socialPresences;

  // ── Identity ─────────────────────────────────────────────────────
  final AuthService auth;

  // ── Use cases ────────────────────────────────────────────────────
  final EnrollStudent enrollStudent;
  final CreateMembership createMembership;
  final CheckInStudent checkIn;
  final CheckOutStudent checkOut;
  final AssignSeat assignSeat;
  final ReleaseSeat releaseSeat;
  final RaiseFeeDue raiseFeeDue;
  final CollectFee collectFee;

  /// Registered tenants. Populated by the seeder.
  final List<Tenant> tenants = [];

  /// Catalogue offered by the seeded tenant. Plans are configuration in V1,
  /// not an aggregate (open question Q-05).
  final List<MembershipPlan> plans = [];

  /// Phone number → the student record that account represents.
  ///
  /// The Identity Triad forbids deriving one id from another, so the link is
  /// explicit and stored rather than inferred.
  final Map<String, StudentRecordId> studentAccountLinks = {};

  Tenant tenantById(TenantId id) =>
      tenants.firstWhere((t) => t.id == id, orElse: () => tenants.first);

  /// Resolve the Global Person Identity to record against a new enrollment,
  /// provisioning the account if reception is enrolling a walk-in student who
  /// has never signed in.
  ///
  /// **Why this lives at the composition root.** It spans `BC-18` (rank 4) and
  /// `BC-10` (rank 7.5). No domain or platform module may know both, so the
  /// orchestration belongs here — the one file already permitted to know a port
  /// and its adapter. Enrollment itself receives only a finished [PersonId] and
  /// is never given the means to create one (`SPO-1`, `SID-4.11`).
  ///
  /// The provisioned account is deliberately **role-less and unverified**:
  /// possession of the mobile number is the sole authentication factor
  /// (`MP-GBR-25`), and reception cannot prove it on the student's behalf. The
  /// student claims it at their own first sign-in (`E-11`). Creating it grants
  /// no access whatsoever — [AuthService.issueSession] refuses an account with
  /// no role in the tenant.
  PersonId provisionIdentityForEnrollment({
    required String phone,
    required String displayName,
  }) {
    for (final a in auth.accounts) {
      // An identity already exists for this number; enrollment reuses it. A
      // second library enrolling the same person yields a second
      // StudentRecord and the SAME PersonId — the asymmetry ID-5 depends on.
      if (a.phone == phone) return a.personId;
    }

    // MP-GBR-02: the account and its identity are created together. The
    // identity is minted first so that a failure leaves neither behind.
    final accountId = AccountId(ids.next('acc'));
    final personId = identityService.createFor(
      account: accountId,
      displayName: displayName,
    );
    auth.registerProvisionedAccount(
      Account(
        id: accountId,
        phone: phone,
        displayName: displayName,
        personId: personId,
        roles: const {},
      ),
    );
    return personId;
  }

  /// Enter a tenant scope. The ONLY caller permitted by the dependency rules.
  void enterScope({
    required TenantId tenant,
    required BranchId branch,
    String? actor,
  }) {
    tenantContext.enter(
      tenant: tenant,
      branch: branch,
      actor: actor,
      correlationId: ids.next('corr'),
    );
  }

  void leaveScope() => tenantContext.exit();

  /// Build, and optionally seed. Async because use cases publish events
  /// through the bus.
  ///
  /// [seeder] is injected rather than imported: see the note at the end of this
  /// method for why law L1 requires it.
  static Future<AppContainer> boot({ContainerSeeder? seeder}) async {
    final tenantContext = MutableTenantContext();
    final clock = MutableClock();
    final ids = SequentialIdGenerator();
    final telemetry = ConsoleTelemetry(tenantContext);

    final events = EventBus(telemetry);
    final entitlements = EntitlementService(tenantContext);
    final idempotency = IdempotencyService(tenantContext);
    // ADR-0058: the V1 adapter for the job_runtime port. Takes the clock so
    // the FIL-FR-095 deadline is measured against injected time and a test can
    // pin it, rather than reading the wall clock inside the adapter.
    final JobRuntime jobs = InProcessJobRuntime(clock);
    // ADR-0059: the E-22 enforcement point. Takes no tenant identifier — E-22
    // already serves the global-class consumer BC-10 (ADR-0016), so a mandatory
    // tenant parameter would be unsatisfiable there and would breach
    // TEN-FR-018.
    final FileAccess fileAccess = InProcessFileAccess();
    final sync = OfflineSyncEngine();
    final audit = AuditTrail(ids);
    final analytics = AnalyticsProjections(clock)..register(events);

    // Tenant-partitioned stores. Every one of these refuses to answer
    // without a tenant in scope — cross-tenant leaks fail loud, not silent.
    final policies = PolicyRepository();
    final students = InMemoryStudentRepository(
      TenantPartitionedStore<StudentRecord>(tenantContext),
    );
    final memberships = InMemoryMembershipRepository(
      TenantPartitionedStore<Membership>(tenantContext),
    );
    final membershipValidity = MembershipValidityService(memberships);
    final attendance = InMemoryAttendanceRepository(
      TenantPartitionedStore<AttendanceDay>(tenantContext),
    );
    final seatLayouts = InMemorySeatLayoutRepository(
      TenantPartitionedStore<SeatLayout>(tenantContext),
    );
    final seatAllocations = InMemorySeatAllocationRepository(
      TenantPartitionedStore<SeatAllocation>(tenantContext),
    );
    final ledgers = InMemoryFeeLedgerRepository(
      TenantPartitionedStore<FeeLedger>(tenantContext),
    );

    const pdp = PolicyDecisionPoint();
    final accounts = <Account>[];

    // BC-10 Global Person Identity. Constructed BEFORE AuthService, because
    // account creation now depends on identity creation rather than the reverse
    // (ADR-0011). The dependency is expressed as the rank-0
    // PersonIdentityFactory port, so rank 4 never points upward at rank 7.5.
    final identities = InMemoryPersonIdentityRepository();
    final identityService = PersonIdentityService(
      repository: identities,
      clock: clock,
      ids: ids,
    );

    final container = AppContainer._(
      tenantContext: tenantContext,
      clock: clock,
      ids: ids,
      telemetry: telemetry,
      events: events,
      entitlements: entitlements,
      idempotency: idempotency,
      jobs: jobs,
      fileAccess: fileAccess,
      sync: sync,
      audit: audit,
      analytics: analytics,
      policies: policies,
      students: students,
      memberships: memberships,
      membershipValidity: membershipValidity,
      attendance: attendance,
      seatLayouts: seatLayouts,
      seatAllocations: seatAllocations,
      seatMap: SeatMapService(
        layouts: seatLayouts,
        allocations: seatAllocations,
        clock: clock,
        tenant: tenantContext,
      ),
      ledgers: ledgers,
      outstanding: OutstandingBalanceService(ledgers),
      identities: identities,
      identityService: identityService,
      socialPresences: InMemorySocialPresenceRepository(),
      auth: AuthService(
        accounts,
        clock: clock,
        // Challenges are drawn from a secure source, never derived (F-02).
        random: SecureRandomSource(),
        ids: ids,
        // SID-4.11: identity is created in the same unit of work as the account.
        identities: identityService,
        // Debug-only peek. False in any release build.
        challengePeekEnabled: !const bool.fromEnvironment('dart.vm.product'),
      ),
      enrollStudent: EnrollStudent(
        repo: students,
        entitlements: entitlements,
        events: events,
        clock: clock,
        ids: ids,
        tenant: tenantContext,
        pdp: pdp,
      ),
      createMembership: CreateMembership(
        repo: memberships,
        events: events,
        clock: clock,
        ids: ids,
        tenant: tenantContext,
        pdp: pdp,
      ),
      checkIn: CheckInStudent(
        repo: attendance,
        validity: membershipValidity,
        policies: policies,
        idempotency: idempotency,
        sync: sync,
        events: events,
        clock: clock,
        ids: ids,
        tenant: tenantContext,
        pdp: pdp,
      ),
      checkOut: CheckOutStudent(
        repo: attendance,
        events: events,
        clock: clock,
        ids: ids,
        tenant: tenantContext,
        pdp: pdp,
      ),
      assignSeat: AssignSeat(
        allocations: seatAllocations,
        layouts: seatLayouts,
        validity: membershipValidity,
        entitlements: entitlements,
        events: events,
        clock: clock,
        ids: ids,
        tenant: tenantContext,
        pdp: pdp,
      ),
      releaseSeat: ReleaseSeat(
        allocations: seatAllocations,
        entitlements: entitlements,
        events: events,
        clock: clock,
        ids: ids,
        tenant: tenantContext,
        pdp: pdp,
      ),
      raiseFeeDue: RaiseFeeDue(
        repo: ledgers,
        events: events,
        clock: clock,
        ids: ids,
        tenant: tenantContext,
        pdp: pdp,
      ),
      collectFee: CollectFee(
        repo: ledgers,
        idempotency: idempotency,
        audit: audit,
        events: events,
        clock: clock,
        ids: ids,
        tenant: tenantContext,
        pdp: pdp,
      ),
    );

    // Law L1 (acyclic) is the one law with zero exceptions, and it is never
    // granted one by the Architecture Review Board. `di.dart` previously
    // imported `seed.dart` to call the seeder, while `seed.dart` imports
    // `di.dart` for `AppContainer` — a file-level cycle.
    //
    // Resolved by the documented pattern (MODULE_DEPENDENCY_MATRIX §8.2, port
    // inversion): the wiring declares *what* it needs — a function that
    // populates a built container — and the caller supplies it. `di.dart` now
    // names no seeder, so the edge points one way only: seed -> di.
    //
    // The parameter is optional because a container is valid unseeded; tests
    // that want an empty world simply pass nothing. `main.dart`, which is the
    // composition root and already knows both files, supplies the demo seeder.
    if (seeder != null) {
      await seeder(container, accounts);
    }
    return container;
  }
}

/// What [AppContainer.boot] needs from a seeder, expressed without naming one.
///
/// Declared here and implemented in `seed.dart`, so the dependency runs
/// upward-to-caller rather than forming the `di -> seed -> di` cycle that
/// law L1 forbids. See `MODULE_DEPENDENCY_MATRIX` §8.2.
typedef ContainerSeeder =
    Future<void> Function(AppContainer container, List<Account> accounts);
