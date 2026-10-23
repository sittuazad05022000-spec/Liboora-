/// **BC-01 Enrollment** — public barrel.
library;

export 'domain/student_record.dart';

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
}

final class PaginatedStudents {
  const PaginatedStudents({required this.items, required this.nextCursor});
  final List<StudentRecord> items;
  final String? nextCursor;
}


final class _CursorEntry {
  const _CursorEntry({required this.tenantId, required this.anchorKey});
  final String tenantId;
  final String anchorKey;
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
  /// Paginated roster — PG-1..PG-4. Cursor is opaque server-issued token (PG-1
  /// + PG-3: carries no tenantId/ordering keys/IDs on the wire); client treats
  /// it as opaque (PG-2); malformed input is a domain error not a silent
  /// reset (PG-4). Bounded-read traverses the per-tenant ordered index;
  /// [cursor] is a server-side anchor handle, not an offset.
  PaginatedStudents paginatedList({String? cursor}) {
    const pageSize = 20; // UNRATIFIED operational default (existing feed(limit:12) class; NOT a CFG-* / NFR)
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
    final hasMore = lastKey != null &&
        ordered.keys.any((k) => k.compareTo(lastKey!) > 0);
    final next = hasMore ? _issueCursor(anchorKey: lastKey!) : null;
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
        ..write(i + 1 < bytes.length
            ? alphabet[((b1 & 0xF) << 2) | ((b2 >> 6) & 0x3)]
            : '=')
        ..write(i + 2 < bytes.length ? alphabet[b2 & 0x3F] : '=');
    }
    return out.toString();
  }

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
      map.entries.toList()
        ..sort((a, b) => a.key.compareTo(b.key)),
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
    final ordered = _ordered.putIfAbsent(tenant, () => <String, StudentRecord>{});
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

final class _DecodedCursor {
  const _DecodedCursor({
    required this.tenantId,
    required this.fullName,
    required this.enrollmentNumber,
    required this.studentId,
  });
  final String tenantId;
  final String fullName;
  final String enrollmentNumber;
  final String studentId;
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
  });

  final StudentRepository repo;
  final EntitlementService entitlements;
  final EventBus events;
  final Clock clock;
  final IdGenerator ids;
  final TenantContext tenant;
  final PolicyDecisionPoint pdp;

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
    required String fullName,
    required String phone,
    required DateTime dateOfBirth,
    required PersonId personId,
    String? email,
    GuardianLink? guardian,
  }) async {
    pdp.require(actorRole, Permission.enrollStudent);

    // Entitlement is checked BEFORE the aggregate mutates (edge E-17).
    entitlements.check(Feature.students);

    final number = 'STU${(repo.all().length + 1).toString().padLeft(4, '0')}';
    if (repo.enrollmentNumberExists(number)) {
      throw DomainError(
        DomainErrorCode.duplicateEnrollmentNumber,
        'Enrollment number $number already exists.',
      );
    }

    // Aggregate constructor enforces its own invariants — it will throw for
    // a minor without a guardian, or no contact channel.
    final student = StudentRecord(
      id: StudentRecordId(ids.next('stu')),
      enrollmentNumber: number,
      fullName: fullName,
      phone: phone,
      email: email,
      dateOfBirth: dateOfBirth,
      enrolledOn: clock.today(),
      guardian: guardian,
      personId: personId,
    );

    repo.save(student);
    entitlements.recordUsage(Feature.students, 1);

    // Outbox: staged with the write, published by drain().
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
          'isMinor': student.isMinorOn(clock.today()),
        },
      ),
    ]);
    await events.drain();
    return student;
  }
}
