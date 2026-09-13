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

import 'package:flutter/foundation.dart' show debugPrint;
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
import 'account_store.dart';
import 'codecs.dart';
import 'session_store.dart';

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
    required this.membershipConfig,
    required this.memberships,
    required this.membershipPlans,
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
    required this.messagingEnforcement,
    required this.auth,
    required this.sessionStore,
    required this.accountStore,
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

  /// `IMPL-407` — the nine `MM-CFG-*` configurables, typed.
  ///
  /// Port-typed so that when `BC-25` Configuration is implemented, replacing
  /// the default-carrying adapter stays a change to this file alone.
  final MembershipConfig membershipConfig;
  final AnalyticsProjections analytics;

  // ── Domain repositories / read models ────────────────────────────
  final PolicyRepository policies;
  final StudentRepository students;
  final MembershipRepository memberships;

  /// `MM-FR-006` — the plan catalogue, a tenant/branch-scoped aggregate.
  final MembershipPlanRepository membershipPlans;

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

  /// BC-12's local enforcement read model and fail-closed send-time gate
  /// (`IMPL-1410`, `ADR-0065` §7.1). Fed only by the existing `E-14` event;
  /// creates no `BC-12` -> `BC-13` edge.
  final MessagingEnforcementProjection messagingEnforcement;

  // ── Identity ─────────────────────────────────────────────────────
  final AuthService auth;

  /// Persistence for the signed-in session (P1 session restore).
  ///
  /// Talks to `DurableKeyValueStore` directly rather than through a
  /// `TenantPartitionedStore`, because a session is what *establishes* the
  /// tenant scope — see `SessionStore` for why that is not an `X-13` hole.
  final SessionStore sessionStore;

  /// Persistence for the global account directory (`BC-18`, `ADR-0003`).
  ///
  /// Not tenant-partitioned, because an account is not a tenant-scoped row —
  /// see `AccountStore`. Tenant isolation lives in each account's `roles` map.
  final AccountStore accountStore;

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

  /// The plan catalogue of the tenant currently in scope.
  ///
  /// `MM-FR-006`/`MM-FR-007` made this an aggregate scoped to one tenant, so
  /// it is no longer a plain list held at the composition root: reading it
  /// without a tenant in scope throws `TenantContextMissing`, exactly like
  /// every other tenant-partitioned read. Ordered by name so a UI listing and
  /// a seeded index are both stable (`MM-FR-030`).
  List<MembershipPlan> get plans {
    final all = membershipPlans.all();
    all.sort((a, b) => a.name.compareTo(b.name));
    return all;
  }

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
  /// Build, restore and optionally seed.
  ///
  /// [durable] is the persistence adapter. It is a **parameter, not a
  /// constant**, for the same reason the seeder is: the technology choice
  /// belongs to whoever composes the application. `main.dart` supplies the
  /// Hive-backed adapter; a test supplies an in-memory one and gets identical
  /// write-through and restore behaviour without touching a filesystem.
  ///
  /// Passing nothing keeps the historical behaviour exactly — in-memory only —
  /// so every existing test and any caller that wants an ephemeral world is
  /// unaffected.
  /// Opens the durable adapter for the named box, falling back to memory.
  ///
  /// **Why this lives in `di.dart` and not in `main.dart`.** The composition
  /// root is the one place permitted to know both a port and its adapter, and
  /// `no_orphan_ports_test` enforces that literally: an adapter constructed
  /// anywhere else leaves the port looking unwired. Selecting the adapter is
  /// therefore this file's job, and `main.dart` only says *whether* it wants
  /// durability and under what box name.
  ///
  /// A failure to open is deliberately **not** fatal. Losing durability is
  /// bad; refusing to start is worse, because it turns a storage problem into
  /// a total outage. The caller is told which adapter it got via
  /// [DurableKeyValueStore] identity, and the reason is logged.
  static Future<DurableKeyValueStore> openDurableStore(String boxName) async {
    try {
      return await HiveKeyValueStore.open(boxName);
    } catch (error) {
      debugPrint(
        'Liboora: durable storage unavailable ($error). '
        'Continuing in memory — data will not survive restart.',
      );
      return InMemoryKeyValueStore();
    }
  }

  static Future<AppContainer> boot({
    ContainerSeeder? seeder,
    DurableKeyValueStore? durable,
  }) async {
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
    // IMPL-1410 / ADR-0065 §7.1. Subscribes to safety.EnforcementActionTaken
    // only. Freshness is NOT declared here: until the stream is observed live
    // the gate fails closed, which is the intended cold-start posture rather
    // than an oversight (TSF-FR-031, SID-4.56).
    final messagingEnforcement = MessagingEnforcementProjection(
      clock,
      telemetry,
    );
    events.subscribe(
      kEnforcementActionTaken,
      messagingEnforcement.apply,
      consumer: 'messaging-enforcement',
    );

    // Tenant-partitioned stores. Every one of these refuses to answer
    // without a tenant in scope — cross-tenant leaks fail loud, not silent.
    final policies = PolicyRepository();

    // The six persisted aggregates. Each store is handed the durable adapter,
    // a namespace and the codec for its own type; with `durable == null` all
    // three are absent and the store stays in memory, which is why this one
    // expression serves both the persistent app and an ephemeral test.
    //
    // The namespace strings are the durable schema. They are written once,
    // here, because a namespace typed at two call sites is a silent data-loss
    // bug the first time the two disagree.
    final studentStore = TenantPartitionedStore<StudentRecord>(
      tenantContext,
      durable: durable,
      namespace: durable == null ? null : 'student_records',
      encode: durable == null ? null : encodeStudentRecord,
      decode: durable == null ? null : decodeStudentRecord,
    );
    final membershipStore = TenantPartitionedStore<Membership>(
      tenantContext,
      durable: durable,
      namespace: durable == null ? null : 'memberships',
      encode: durable == null ? null : encodeMembership,
      decode: durable == null ? null : decodeMembership,
    );
    // MM-FR-006: the plan is a separate aggregate root, so it gets its own
    // store and its own durable namespace. Sharing one would make a single
    // transaction across both aggregates easy to write by accident.
    final membershipPlanStore = TenantPartitionedStore<MembershipPlan>(
      tenantContext,
      durable: durable,
      namespace: durable == null ? null : 'membership_plans',
      encode: durable == null ? null : encodeMembershipPlan,
      decode: durable == null ? null : decodeMembershipPlan,
    );
    final attendanceStore = TenantPartitionedStore<AttendanceDay>(
      tenantContext,
      durable: durable,
      namespace: durable == null ? null : 'attendance_days',
      encode: durable == null ? null : encodeAttendanceDay,
      decode: durable == null ? null : decodeAttendanceDay,
    );
    final seatLayoutStore = TenantPartitionedStore<SeatLayout>(
      tenantContext,
      durable: durable,
      namespace: durable == null ? null : 'seat_layouts',
      encode: durable == null ? null : encodeSeatLayout,
      decode: durable == null ? null : decodeSeatLayout,
    );
    final seatAllocationStore = TenantPartitionedStore<SeatAllocation>(
      tenantContext,
      durable: durable,
      namespace: durable == null ? null : 'seat_allocations',
      encode: durable == null ? null : encodeSeatAllocation,
      decode: durable == null ? null : decodeSeatAllocation,
    );
    final ledgerStore = TenantPartitionedStore<FeeLedger>(
      tenantContext,
      durable: durable,
      namespace: durable == null ? null : 'fee_ledgers',
      encode: durable == null ? null : encodeFeeLedger,
      decode: durable == null ? null : decodeFeeLedger,
    );

    // ── RESTORE, BEFORE ANYTHING ELSE TOUCHES A STORE ──────────────
    //
    // Runs here rather than after the container is built, so no use case can
    // observe a half-loaded world. No tenant scope is entered: restore is
    // tenant-agnostic by design (see TenantPartitionedStore.restore), because
    // the tenant is not known until sign-in.
    final restoredRows =
        studentStore.restore() +
        membershipStore.restore() +
        membershipPlanStore.restore() +
        attendanceStore.restore() +
        seatLayoutStore.restore() +
        seatAllocationStore.restore() +
        ledgerStore.restore();

    final students = InMemoryStudentRepository(studentStore);
    // IMPL-407: BC-25 Configuration has no implementation yet, so the port is
    // satisfied by the adapter carrying PRD-005 §13.4's published defaults.
    // Task document L128 requires exactly this — build against the port with
    // a fake, never defer.
    const membershipConfig = DefaultMembershipConfig();

    final memberships = InMemoryMembershipRepository(membershipStore);
    final membershipPlans = InMemoryMembershipPlanRepository(
      membershipPlanStore,
    );
    final membershipValidity = MembershipValidityService(
      memberships,
      membershipPlans,
      // MM-FR-077: a suspended student reports isValid: false for the
      // duration of the suspension, without the membership being mutated.
      enrollment: StudentRecordEnrollmentAcl(students),
    );
    final attendance = InMemoryAttendanceRepository(attendanceStore);
    final seatLayouts = InMemorySeatLayoutRepository(seatLayoutStore);
    final seatAllocations = InMemorySeatAllocationRepository(
      seatAllocationStore,
    );
    final ledgers = InMemoryFeeLedgerRepository(ledgerStore);

    const pdp = PolicyDecisionPoint();

    // ── ACCOUNT DIRECTORY (BC-18) ───────────────────────────────────
    //
    // One durable adapter for both stores, so the session and the directory it
    // depends on can never disagree about whether persistence exists. An
    // in-memory adapter when none was supplied keeps both fields
    // non-nullable.
    final persistence = durable ?? InMemoryKeyValueStore();
    final accountStore = AccountStore(persistence);
    final sessionStore = SessionStore(persistence);

    // Restored BEFORE AuthService is constructed, because the directory is an
    // input to authentication, not an output of it. `ADR-0003` makes accounts
    // global and cross-tenant, so this happens with NO tenant in scope —
    // correctly: tenant isolation for an account lives in its `roles` map, not
    // in where the record is stored.
    final accounts = <Account>[...accountStore.restoreAll()];

    // Counted separately from `accounts.length`: a directory of only corrupt
    // records must not look like a first launch and be seeded over.
    final persistedAccountCount = accountStore.persistedCount;

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
      membershipConfig: membershipConfig,
      memberships: memberships,
      membershipPlans: membershipPlans,
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
      messagingEnforcement: messagingEnforcement,
      // P1 session restore. Shares one adapter with the account directory, so
      // a restored session is always validated against a directory from the
      // same storage.
      sessionStore: sessionStore,
      accountStore: accountStore,
      auth: AuthService(
        accounts,
        clock: clock,
        // Challenges are drawn from a secure source, never derived (F-02).
        random: SecureRandomSource(),
        ids: ids,
        // SID-4.11: identity is created in the same unit of work as the account.
        identities: identityService,
        // IMPL-020. The SMS transport is an external dependency (TRAI DLT
        // registration), so the only honest release wiring is "not
        // configured": the sign-in surface then says so instead of asking for
        // a code that can never arrive.
        //
        // Outside a product build the challenge is written to the developer
        // console. That is a transport terminating in a console, NOT a demo
        // account and NOT a guest mode — no account is created and no role is
        // granted, so MP-CON-11 is untouched. Swapping in the real gateway is
        // a change to this expression alone.
        // ONE adapter, whose own flag decides whether it is switched on. A
        // ternary between two adapters would register two implementations of
        // one port here, which is ambiguous wiring.
        // Every account added at runtime — by a first successful OTP, or by
        // reception provisioning a walk-in — is written through immediately.
        // A callback rather than a store: BC-18 is rank 4 and the adapter is
        // rank 2, so injecting a store would invert the dependency.
        onAccountChanged: accountStore.save,
        delivery: DebugConsoleOtpDelivery(
          enabled: !const bool.fromEnvironment('dart.vm.product'),
          sink: debugPrint,
        ),
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
        plans: membershipPlans,
        // E-01, through the ACL below -- BC-02 never imports BC-01.
        enrollment: StudentRecordEnrollmentAcl(students),
        config: membershipConfig,
        idempotency: MembershipIdempotencyAdapter(idempotency),
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
    // ── DEMO DATA NEVER OVERWRITES REAL DATA ───────────────────────
    //
    // The seeder drives the real use cases, so running it over a restored
    // world would not merely duplicate rows — it would re-raise fees, re-punch
    // attendance and re-allocate seats against live aggregates, and
    // `assertNoOverlap`/`assertSeatFree` would start throwing at boot.
    //
    // `restoredRows > 0` is the test rather than "is this the first launch?",
    // because it asks the only question that matters: is there already data
    // here? A tenant that legitimately has zero rows is seeded, which is
    // correct — an empty library is indistinguishable from a new one, and
    // seeding it writes through to durable storage, so it happens exactly
    // once.
    //
    // ⭐ THE ACCOUNT DIRECTORY IS A SECOND, INDEPENDENT CONDITION.
    //
    // `persistedAccountCount` is checked as well as `restoredRows`, because
    // the two can legitimately disagree and the seeder must be blocked if
    // EITHER holds data. A directory that already contains accounts must never
    // be re-seeded: doing so would mint duplicate identities for numbers that
    // already have one, breaching the 1:1 account/identity invariant
    // (`SID-INV-1`), and would silently overwrite live roles with demo roles.
    //
    // The count is used rather than `accounts.isNotEmpty` on purpose: a
    // directory whose records all fail to decode has a count above zero but an
    // empty list. Seeding over it would destroy the damaged records — and the
    // only evidence of the damage — so a corrupt directory fails CLOSED
    // (sign-in unavailable, records preserved for recovery) rather than being
    // quietly replaced by demo data.
    final hasPersistedState = restoredRows > 0 || persistedAccountCount > 0;

    if (seeder != null && !hasPersistedState) {
      await seeder(container, accounts);

      // Persist the seeded directory, so the NEXT boot can resolve the
      // accounts a persisted session points at. Written after the seeder
      // rather than inside it: the seeder builds the account list, and
      // persistence is the composition root's concern, not its.
      //
      // This is what makes P1 session restore work end to end — without it a
      // restored session finds an empty directory and is correctly refused.
      accountStore.saveAll(accounts);
    }
    return container;
  }
}

/// `IMPL-414` — adapter for `BC-02`'s idempotency port.
///
/// `BC-02` declares [MembershipIdempotencyStore]; `platform/services` owns
/// the mechanism. Binding them here keeps `domain/library` off the
/// `platform/services` import edge, which `ADR-0012` currently waives only
/// because *"the interfaces are missing"*.
final class MembershipIdempotencyAdapter implements MembershipIdempotencyStore {
  const MembershipIdempotencyAdapter(this._service);
  final IdempotencyService _service;

  @override
  Membership? recall(IdempotencyKey key) => _service.recall<Membership>(key);

  @override
  void remember(IdempotencyKey key, Membership result) =>
      _service.remember(key, result);
}

/// `IMPL-411` — the `E-01` anti-corruption layer.
///
/// `BC-02` declares [EnrollmentStatusReader]; `BC-01` owns the state. Neither
/// imports the other. The translation lives in the composition root, which is
/// the one place already permitted to know both contexts, so the edge stays a
/// port rather than becoming a compile-time dependency.
///
/// It is an ACL and not a pass-through: a `StudentRecord` carries name, phone
/// and address, all of which `MM-BR-021` forbids on `BC-02`'s side. Only the
/// enrollment state crosses, mapped value-by-value so that adding a fifth
/// state upstream is a compile error here instead of a silent admission.
final class StudentRecordEnrollmentAcl implements EnrollmentStatusReader {
  const StudentRecordEnrollmentAcl(this._students);
  final StudentRepository _students;

  @override
  MembershipEnrollmentState? stateFor(StudentRecordId id) {
    final record = _students.byId(id);
    if (record == null) return null;
    return switch (record.status) {
      EnrollmentStatus.active => MembershipEnrollmentState.active,
      EnrollmentStatus.inactive => MembershipEnrollmentState.inactive,
      EnrollmentStatus.suspended => MembershipEnrollmentState.suspended,
      EnrollmentStatus.archived => MembershipEnrollmentState.archived,
    };
  }
}

/// What [AppContainer.boot] needs from a seeder, expressed without naming one.
///
/// Declared here and implemented in `seed.dart`, so the dependency runs
/// upward-to-caller rather than forming the `di -> seed -> di` cycle that
/// law L1 forbids. See `MODULE_DEPENDENCY_MATRIX` §8.2.
typedef ContainerSeeder =
    Future<void> Function(AppContainer container, List<Account> accounts);
