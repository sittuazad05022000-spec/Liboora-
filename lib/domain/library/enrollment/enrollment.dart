/// **BC-01 Enrollment** — public barrel.
library;

export 'domain/student_record.dart';
// GuardianLink lives in the shared kernel; re-exported so existing consumers
// of this barrel keep resolving it.
export 'package:liboora_contracts/liboora_contracts.dart' show GuardianLink;

import 'package:liboora_contracts/liboora_contracts.dart';

import '../../../platform/business/business.dart';
import '../../../platform/data/data.dart';
import '../../../platform/event/event.dart';
import '../../../platform/identity/identity.dart';
import 'domain/student_record.dart';

/// Port declared BY this context (law L3). The adapter lives in infrastructure.
abstract interface class StudentRepository {
  StudentRecord? byId(StudentRecordId id);
  List<StudentRecord> all();
  PaginatedStudents paginatedList({String? cursor});
  bool enrollmentNumberExists(String number);
  void save(StudentRecord s);

  /// `SM-3.11`/`SM-3.12` — duplicate detection is by `personId`, never by
  /// name, mobile or email. Partition-scoped, so a different tenant's records
  /// are never consulted (`SM-3.15` permits cross-tenant re-enrollment).
  StudentRecord? findActiveByPerson(PersonId personId);

  /// `SM-3.14` — the archived records for this person, in this tenant, in
  /// most-recently-archived order (`archivedAt` desc, then greater
  /// `StudentRecordId` ordinal first — the deterministic tiebreak).
  List<StudentRecord> findArchivedByPerson(PersonId personId);

  /// Verifies [cursor] was issued for the tenant currently in scope — the
  /// tenant-scoped check the pagination contract (PG-1..PG-4) requires.
  /// Throws a domain error for an unknown or foreign-tenant cursor.
  void verifyCursorTenant(String cursor);
}

/// `SM-3.6` — idempotency declared as a port by this consumer (law L3),
/// mirroring `BC-02`'s `MembershipIdempotencyStore`. Two methods only.
abstract interface class EnrollmentIdempotencyStore {
  /// The student previously registered under [key] in this tenant, or `null`.
  StudentRecord? recall(IdempotencyKey key);

  /// Record [result] against [key]. Tenant-scoped (`SM-3.6` pattern of
  /// `MP-GBR-18`/`MM-FR-048`).
  void remember(IdempotencyKey key, StudentRecord result);
}

final class PaginatedStudents {
  const PaginatedStudents({required this.items, required this.nextCursor});
  final List<StudentRecord> items;
  final String? nextCursor;
}

final class InMemoryStudentRepository implements StudentRepository {
  InMemoryStudentRepository(this._store);
  final TenantPartitionedStore<StudentRecord> _store;

  // Per-tenant ordered index for TRUE bounded reads — key = "$fullName\x00$enrollmentNumber\x00${id.value}".
  // Maintained incrementally on [save]; no `all()` scan on paginated path.
  final Map<String, Map<String, String>> _idToKey = {};
  final Map<String, Map<String, StudentRecord>> _ordered = {};
  // Server-side opaque cursor registry: token → anchor (tenant + composite key).
  final Map<String, _CursorEntry> _cursorRegistry = {};
  int _cursorSeq = 0;

  @override
  StudentRecord? byId(StudentRecordId id) => _store.get(id.value);

  @override
  List<StudentRecord> all() => _store.all();

  @override
  StudentRecord? findActiveByPerson(PersonId personId) {
    for (final s in _store.all()) {
      if (s.personId == personId && s.status != EnrollmentStatus.archived) {
        return s;
      }
    }
    return null;
  }

  @override
  List<StudentRecord> findArchivedByPerson(PersonId personId) {
    final archived =
        _store
            .where((s) => s.personId == personId && s.status == EnrollmentStatus.archived)
            .toList()
          ..sort((a, b) {
            // SM-3.14a — most recently archived first; `archivedAt` ties break
            // on the greater StudentRecordId ordinal (deterministic).
            final aAt = a.archivedAt;
            final bAt = b.archivedAt;
            if (aAt != null && bAt != null && !aAt.isAtSameMomentAs(bAt)) {
              return bAt.compareTo(aAt);
            }
            return b.id.value.compareTo(a.id.value);
          });
    return archived;
  }

  @override
  /// Paginated roster — PG-1..PG-4. Cursor is opaque server-issued token (PG-1
  /// + PG-3: carries no tenantId/ordering keys/IDs on the wire); client treats
  /// it as opaque (PG-2); malformed input is a domain error not a silent
  /// reset (PG-4). Bounded-read traverses the per-tenant ordered index;
  /// [cursor] is a server-side anchor handle, not an offset.
  PaginatedStudents paginatedList({String? cursor}) {
    final tenant = _store.currentTenantId;
    final index = _ordered[tenant];
    // Lazy-sync on first paginated call for tenants seeded before this patch.
    if (index == null || index.length != _store.count) _rebuildOrdered(tenant);
    final ordered = _ordered[tenant]!;
    if (cursor == null) {
      return _pageFrom(ordered, null);
    }
    final entry = _cursorRegistry[cursor];
    if (entry == null || entry.tenantId != tenant) {
      throw const DomainError(
        DomainErrorCode.validationFailed,
        'Invalid cursor.',
      );
    }
    return _pageFrom(ordered, entry.anchorKey);
  }

  PaginatedStudents _pageFrom(
    Map<String, StudentRecord> ordered,
    String? anchorKey,
  ) {
    const pageSize = 20;
    Iterable<MapEntry<String, StudentRecord>> window;
    if (anchorKey == null) {
      window = ordered.entries;
    } else {
      // SplayTreeMap semantics: keys are sorted; skip anchor itself.
      var pastAnchor = false;
      window = ordered.entries.where((e) {
        if (pastAnchor) return true;
        if (e.key == anchorKey) {
          pastAnchor = true;
          return false;
        }
        // Anchor may be stale (rename/delete) — first key greater than anchor.
        if (e.key.compareTo(anchorKey) > 0 && !pastAnchor) {
          pastAnchor = true;
          return true;
        }
        return false;
      });
      // If anchor was last key, window is empty → end of list.
    }
    final page = <StudentRecord>[];
    String? lastKey;
    var count = 0;
    for (final e in window) {
      if (count >= pageSize) break;
      page.add(e.value);
      lastKey = e.key;
      count++;
    }
    final hasMore =
        lastKey != null && ordered.keys.any((k) => k.compareTo(lastKey!) > 0);
    final next = hasMore ? _issueCursor(anchorKey: lastKey) : null;
    return PaginatedStudents(items: page, nextCursor: next);
  }

  String _issueCursor({required String anchorKey}) {
    final tenant = _store.currentTenantId;
    final token = 'c${_cursorSeq++}_${tenant.hashCode.abs()}';
    // Opaque token — no ordering data on the wire; server holds anchor.
    final opaque = _opaqueToken(token);
    _cursorRegistry[opaque] = _CursorEntry(
      tenantId: tenant,
      anchorKey: anchorKey,
    );
    return opaque;
  }

  String _opaqueToken(String raw) {
    // Minimal opaque encoding: base64 of random-ish raw; PG-3 requires that
    // decoding reveals nothing about ordering or tenancy — this token's
    // plaintext is a sequence counter, not an anchor.
    const alphabet =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
    final bytes = raw.codeUnits;
    var out = StringBuffer();
    for (var i = 0; i < bytes.length; i += 3) {
      final b0 = bytes[i];
      final b1 = i + 1 < bytes.length ? bytes[i + 1] : 0;
      final b2 = i + 2 < bytes.length ? bytes[i + 2] : 0;
      out
        ..write(alphabet[(b0 >> 2) & 0x3F])
        ..write(alphabet[((b0 & 0x3) << 4) | ((b1 >> 4) & 0xF)])
        ..write(
          i + 1 < bytes.length
              ? alphabet[((b1 & 0xF) << 2) | ((b2 >> 6) & 0x3)]
              : '=',
        )
        ..write(i + 2 < bytes.length ? alphabet[b2 & 0x3F] : '=');
    }
    return out.toString();
  }

  @override
  void verifyCursorTenant(String cursor) {
    final entry = _cursorRegistry[cursor];
    if (entry == null || entry.tenantId != _store.currentTenantId) {
      throw const DomainError(
        DomainErrorCode.validationFailed,
        'Invalid cursor.',
      );
    }
  }

  void _rebuildOrdered(String tenant) {
    final map = <String, StudentRecord>{};
    for (final s in _store.all()) {
      map[_compositeKey(s)] = s;
    }
    // SplayTreeMap via sorted keys insertion order is not guaranteed; use
    // sorted entries insertion into a LinkedHashMap-equivalent sorted map
    // by re-sorting keys. For TRUE ordered iteration, keep a SplayTreeMap.
    final sorted = Map<String, StudentRecord>.fromEntries(
      map.entries.toList()..sort((a, b) => a.key.compareTo(b.key)),
    );
    _ordered[tenant] = sorted;
    final idMap = _idToKey.putIfAbsent(tenant, () => <String, String>{});
    idMap.clear();
    for (final e in sorted.entries) {
      idMap[e.value.id.value] = e.key;
    }
  }

  String _compositeKey(StudentRecord s) =>
      '${s.fullName}\u0000${s.enrollmentNumber}\u0000${s.id.value}';

  @override
  bool enrollmentNumberExists(String number) =>
      _store.where((s) => s.enrollmentNumber == number).isNotEmpty;

  @override
  void save(StudentRecord s) {
    final tenant = _store.currentTenantId;
    // Maintain ordered index incrementally for bounded reads.
    final key = _compositeKey(s);
    final ordered = _ordered.putIfAbsent(
      tenant,
      () => <String, StudentRecord>{},
    );
    final idMap = _idToKey.putIfAbsent(tenant, () => <String, String>{});
    final oldKey = idMap[s.id.value];
    if (oldKey != null && oldKey != key) ordered.remove(oldKey);
    ordered[key] = s;
    idMap[s.id.value] = key;
    // Keep ordered map sorted — re-sort only the affected tenant's map.
    if (ordered.length > 1) {
      final sorted = Map<String, StudentRecord>.fromEntries(
        ordered.entries.toList()..sort((a, b) => a.key.compareTo(b.key)),
      );
      _ordered[tenant] = sorted;
    }
    _store.put(s.id.value, s);
  }
}

final class _CursorEntry {
  const _CursorEntry({required this.tenantId, required this.anchorKey});
  final String tenantId;
  final String anchorKey;
}

/// Use case: enroll a walk-in student.
final class EnrollStudent {
  EnrollStudent({
    required this.repo,
    required this.entitlements,
    required this.events,
    required this.clock,
    required this.ids,
    required this.tenant,
    required this.pdp,
    required this.identities,
    required this.idempotency,
  });

  final StudentRepository repo;
  final EntitlementService entitlements;
  final EventBus events;
  final Clock clock;
  final IdGenerator ids;
  final TenantContext tenant;
  final PolicyDecisionPoint pdp;

  /// `E-13` — the BC-10 anti-corruption layer. Age derives from the DOB it
  /// returns (`SM-4.5`); this module never stores a DOB of its own
  /// (`SM-4.2`, `ADR-0179`).
  final IdentityDirectoryPort identities;

  /// `SM-3.6` — idempotency port, adapter at the composition root.
  final EnrollmentIdempotencyStore idempotency;

  /// [personId] is the enrolling person's Global Person Identity, resolved by
  /// the caller before enrollment. It is **required**: every account has exactly
  /// one identity (`MP-GBR-02`), every student has an account (`MP-GBR-01`), and
  /// a Student Record's reference to it is non-nullable (`SID-4.17`).
  ///
  /// This context does **not** create identities — creation is `BC-18`'s, in the
  /// same transaction as the account (`SPO-1`, `SID-4.11`). Enrollment only ever
  /// *holds* a `PersonId` it was given.
  Future<StudentRecord> call({
    required AccessRole actorRole,
    required IdempotencyKey idempotencyKey,
    required AccountId accountId,
    required PersonId personId,
    required String fullName,
    required String phone,
    RegistrationSource registrationSource = RegistrationSource.staffAssisted,
    String? email,
    GuardianLink? guardian,
    AgeDeclaration? declaration,
  }) async {
    pdp.require(actorRole, Permission.enrollStudent);

    // Entitlement is checked BEFORE the aggregate mutates (edge E-17).
    entitlements.check(Feature.students);

    // (2) `E-13` — resolve the identity core for the held PersonId
    // (`SM-3.4` step 2). Fail-closed: without the core, `SM-INV-3` cannot be
    // evaluated, so registration cannot proceed (`SID-4.56`).
    final core = identities.resolve(personId);
    if (core == null) {
      throw DomainError(
        DomainErrorCode.notFound,
        'No Global Person Identity exists for ${personId.value}; provision '
        'the identity first (SM-3.2, AR-2).',
        context: {'personId': personId.value},
      );
    }

    // (3) `SM-3.6` — idempotent replay: the same (tenant, person, key)
    // returns the prior record and emits nothing. A key reused for a
    // DIFFERENT person is misuse, never a silent success.
    final prior = idempotency.recall(idempotencyKey);
    if (prior != null) {
      if (prior.personId == personId) return prior;
      throw DomainError(
        DomainErrorCode.conflict,
        'Idempotency key ${idempotencyKey.value} was already used for a '
        'different person.',
        context: {
          'key': idempotencyKey.value,
          'expectedPersonId': prior.personId.value,
          'suppliedPersonId': personId.value,
        },
      );
    }

    // (4) `SM-3.11`/`SM-3.12` — duplicate check by personId only.
    final existing = repo.findActiveByPerson(personId);
    if (existing != null) {
      // `SM-3.13` — return the existing StudentRecordId so staff can open
      // the record instead of retrying.
      throw DomainError(
        DomainErrorCode.conflict,
        '${core.displayName} is already enrolled here '
        '(${existing.enrollmentNumber}).',
        context: {'existingStudentRecordId': existing.id.value},
      );
    }

    // (4b) `SM-3.14`/`SM-3.14b` — archived records are restored, not
    // duplicated. The count travels so the caller can present it; the
    // most-recently-archived record is the restore target (`SM-3.14a`).
    final archivedRecords = repo.findArchivedByPerson(personId);
    if (archivedRecords.isNotEmpty) {
      throw DomainError(
        DomainErrorCode.conflict,
        '${core.displayName} has ${archivedRecords.length} archived '
        'record(s); restore the most recent one instead of re-enrolling.',
        context: {
          'archivedStudentRecordId': archivedRecords.first.id.value,
          'archivedCount': archivedRecords.length,
        },
      );
    }

    // (5) Validate — resolve the minor question from the E-13 DOB (`SM-4.5`),
    // falling back to the audited `SM-4.5a` declaration only when BC-10 holds
    // none. `SM-4.5b`: unknown and undeclared is treated as a minor.
    final dob = core.dateOfBirth;
    final MinorStatus minorStatus;
    if (dob != null) {
      final today = clock.today();
      var age = today.year - dob.year;
      if (today.month < dob.month ||
          (today.month == dob.month && today.day < dob.day)) {
        age--;
      }
      minorStatus = age < 18 ? MinorStatus.minor : MinorStatus.adult;
    } else if (declaration != null) {
      minorStatus = declaration.isMinor ? MinorStatus.minor : MinorStatus.unknown;
    } else {
      minorStatus = MinorStatus.unknown;
    }
    final guardianRequired = switch (minorStatus) {
      MinorStatus.minor => true,
      MinorStatus.adult => false,
      MinorStatus.unknown => declaration?.isMinor ?? true,
    };
    if (guardianRequired && guardian == null) {
      throw const DomainError(
        DomainErrorCode.guardianRequiredForMinor,
        'A guardian is mandatory for minors, and for any record whose minor '
        'status is unknown (SM-4.5b fail-safe).',
      );
    }
    if (dob == null && declaration == null) {
      // `SM-4.5a` — the record may not leave the draft unresolved.
      throw const DomainError(
        DomainErrorCode.validationFailed,
        'No date of birth is recorded for this person; a staff age '
        'declaration is required before enrollment (SM-4.5a).',
      );
    }

    // (6) `SM-3.17` — allocate inside the synchronous critical section, AFTER
    // validation, so a failure never consumes a number (`SM-3.5`). This is
    // single-isolate in-memory atomicity (no `await` until after save) — NOT
    // database-level concurrency protection; `SM-3.16`'s unique constraint is
    // the future persistence migration's obligation.
    var number = 'STU${(repo.all().length + 1).toString().padLeft(4, '0')}';
    while (repo.enrollmentNumberExists(number)) {
      final seq = int.parse(number.substring(3)) + 1;
      number = 'STU${seq.toString().padLeft(4, '0')}';
    }

    // (7) Persist with EnrollmentStatus = Active; the registration is the
    // first, real entry of the append-only status history (`SM-2.13`). The
    // aggregate constructor re-checks every invariant.
    final student = StudentRecord(
      id: StudentRecordId(ids.next('stu')),
      enrollmentNumber: number,
      fullName: fullName,
      phone: phone,
      email: email,
      enrolledOn: clock.today(),
      guardian: guardian,
      personId: personId,
      accountId: accountId,
      registrationSource: registrationSource,
      minorStatus: minorStatus,
      ageDeclaration: dob == null ? declaration : null,
      status: EnrollmentStatus.active,
      statusHistory: [
        StudentStatusChange(
          to: EnrollmentStatus.active,
          at: clock.today(),
          actor: tenant.actorId ?? 'system',
        ),
      ],
    );

    repo.save(student);
    entitlements.recordUsage(Feature.students, 1);
    // Remembered after save: a crash between the two replays into the
    // personId duplicate check above, which returns the existing id.
    idempotency.remember(idempotencyKey, student);

    // Outbox: staged with the write, published by drain(). A failed
    // registration never reaches this point, so it emits nothing (`SM-3.7`).
    events.enqueue([
      DomainEvent(
        eventId: ids.next('evt'),
        eventType: 'enrollment.StudentEnrolled',
        tenantId: tenant.tenantId,
        aggregateId: student.id.value,
        occurredAt: clock.now(),
        actorId: tenant.actorId,
        correlationId: tenant.correlationId,
        payload: {
          'studentRecordId': student.id.value,
          'enrollmentNumber': student.enrollmentNumber,
          'fullName': student.fullName,
          'isMinor': student.requiresGuardian,
          'registrationSource': (student.registrationSource ??
                  RegistrationSource.staffAssisted)
              .name,
        },
      ),
    ]);
    await events.drain();
    return student;
  }
}

/// `SM-2.3` — `Archived → Active` restore, **TR-1 only**. The aggregate
/// performs the transition; this use case owns the PDP check, the targeting
/// rule (`SM-3.14a`) and the `SM-EV-2` emission (`SM-2.12`).
final class RestoreStudent {
  RestoreStudent({
    required this.repo,
    required this.events,
    required this.clock,
    required this.ids,
    required this.tenant,
    required this.pdp,
  });

  final StudentRepository repo;
  final EventBus events;
  final Clock clock;
  final IdGenerator ids;
  final TenantContext tenant;
  final PolicyDecisionPoint pdp;

  Future<StudentRecord> call({
    required AccessRole actorRole,
    required StudentRecordId studentId,
  }) async {
    // `SM-2.3` — restore authority is TR-1 only; enforced HERE, never in UI.
    pdp.require(actorRole, Permission.restoreStudent);

    final student = repo.byId(studentId);
    if (student == null) {
      throw DomainError(
        DomainErrorCode.notFound,
        'No student record ${studentId.value} exists in this tenant.',
        context: {'studentRecordId': studentId.value},
      );
    }

    student.restore(actor: tenant.actorId ?? 'system', at: clock.today());
    repo.save(student);

    // `SM-2.12` — every transition emits `SM-EV-2`; the restore's new audit
    // entry rides the same event (the composition root subscribes
    // `enrollment.*` to the audit trail).
    events.enqueue([
      DomainEvent(
        eventId: ids.next('evt'),
        eventType: 'enrollment.StudentStatusChanged',
        tenantId: tenant.tenantId,
        aggregateId: student.id.value,
        occurredAt: clock.now(),
        actorId: tenant.actorId,
        correlationId: tenant.correlationId,
        payload: {
          'studentRecordId': student.id.value,
          'from': EnrollmentStatus.archived.name,
          'to': student.status.name,
          'reason': 'restore',
        },
      ),
    ]);
    await events.drain();
    return student;
  }
}
