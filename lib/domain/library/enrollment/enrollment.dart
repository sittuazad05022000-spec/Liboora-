/// **BC-01 Enrollment** — public barrel.
library;

export 'domain/student_record.dart';

import 'dart:convert';
import 'dart:math';
import 'dart:collection';

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
  void verifyCursorTenant(String cursor);
}

final class PaginatedStudents {
  const PaginatedStudents({required this.items, required this.nextCursor});
  final List<StudentRecord> items;
  final String? nextCursor;
}

final class _CursorEntry {
  const _CursorEntry({required this.tenantId, required this.anchorKey});
  final String tenantId;
  final _StudentOrderKey anchorKey;
}

final class _StudentOrderKey implements Comparable<_StudentOrderKey> {
  const _StudentOrderKey({
    required this.fullName,
    required this.enrollmentNumber,
    required this.studentId,
  });

  final String fullName;
  final String enrollmentNumber;
  final String studentId;

  @override
  bool operator ==(Object other) =>
      other is _StudentOrderKey &&
      other.fullName == fullName &&
      other.enrollmentNumber == enrollmentNumber &&
      other.studentId == studentId;

  @override
  int get hashCode => Object.hash(fullName, enrollmentNumber, studentId);

  @override
  int compareTo(_StudentOrderKey other) {
    final name = fullName.compareTo(other.fullName);
    if (name != 0) return name;
    final enrollment = enrollmentNumber.compareTo(other.enrollmentNumber);
    if (enrollment != 0) return enrollment;
    return studentId.compareTo(other.studentId);
  }
}

final class InMemoryStudentRepository implements StudentRepository {
  InMemoryStudentRepository(this._store);
  final TenantPartitionedStore<StudentRecord> _store;

  static final Random _secureRandom = Random.secure();

  // Per-tenant ordered index for TRUE bounded reads.
  // Maintained incrementally on [save]; no `all()` scan on paginated path.
  final Map<String, Map<String, _StudentOrderKey>> _idToKey = {};
  final Map<String, SplayTreeMap<_StudentOrderKey, StudentRecord>> _ordered =
      {};
  // Sorted keys for each tenant for O(log n) cursor seeking.
  final Map<String, List<_StudentOrderKey>> _orderedKeys = {};
  // Server-side opaque cursor registry: token → anchor (tenant + composite key).
  final Map<String, _CursorEntry> _cursorRegistry = {};

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
    final tenant = _store.currentTenantId;
    final index = _ordered[tenant];
    // Lazy-sync on first paginated call for tenants seeded before this patch.
    if (index == null || index.length != _store.count) _rebuildOrdered(tenant);
    final ordered = _ordered[tenant]!;
    final keys = _orderedKeys[tenant]!;
    if (cursor == null) {
      return _pageFrom(ordered, null, keys);
    }
    final entry = _cursorRegistry[cursor];
    if (entry == null || entry.tenantId != tenant) {
      throw const DomainError(
        DomainErrorCode.validationFailed,
        'Invalid cursor.',
      );
    }
    return _pageFrom(ordered, entry.anchorKey, keys);
  }

  PaginatedStudents _pageFrom(
    SplayTreeMap<_StudentOrderKey, StudentRecord> ordered,
    _StudentOrderKey? anchorKey,
    List<_StudentOrderKey> keys,
  ) {
    const pageSize =
        20; // UNRATIFIED operational default (existing feed(limit:12) class; NOT a CFG-* / NFR)
    final page = <StudentRecord>[];
    _StudentOrderKey? lastKey;

    int startIndex = 0;
    if (anchorKey != null) {
      if (!ordered.containsKey(anchorKey)) {
        throw const DomainError(
          DomainErrorCode.validationFailed,
          'Invalid cursor.',
        );
      }
      // Binary search to find the anchor position (exclusive - start AFTER anchor).
      int low = 0;
      int high = keys.length;
      while (low < high) {
        final mid = (low + high) >> 1;
        if (keys[mid].compareTo(anchorKey) <= 0) {
          low = mid + 1;
        } else {
          high = mid;
        }
      }
      startIndex = low;
    }

    var count = 0;
    for (var i = startIndex; i < keys.length && count < pageSize; i++) {
      final key = keys[i];
      final value = ordered[key]!;
      page.add(value);
      lastKey = key;
      count++;
    }

    final hasMore = startIndex + count < keys.length;
    final next = hasMore ? _issueCursor(anchorKey: lastKey!) : null;
    return PaginatedStudents(items: page, nextCursor: next);
  }

  String _issueCursor({required _StudentOrderKey anchorKey}) {
    final tenant = _store.currentTenantId;
    final opaque = base64UrlEncode(
      List<int>.generate(32, (_) => _secureRandom.nextInt(256)),
    );
    _cursorRegistry[opaque] = _CursorEntry(
      tenantId: tenant,
      anchorKey: anchorKey,
    );
    return opaque;
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
    final map = <_StudentOrderKey, StudentRecord>{};
    for (final s in _store.all()) {
      map[_compositeKey(s)] = s;
    }
    // SplayTreeMap maintains sorted order and enables O(log n) cursor seeking.
    final sorted = SplayTreeMap<_StudentOrderKey, StudentRecord>.of(map);
    _ordered[tenant] = sorted;
    // Maintain sorted keys array for O(log n) cursor seeking.
    _orderedKeys[tenant] = sorted.keys.toList();
    final idMap = _idToKey.putIfAbsent(
      tenant,
      () => <String, _StudentOrderKey>{},
    );
    idMap.clear();
    for (final e in sorted.entries) {
      idMap[e.value.id.value] = e.key;
    }
  }

  _StudentOrderKey _compositeKey(StudentRecord s) => _StudentOrderKey(
    fullName: s.fullName,
    enrollmentNumber: s.enrollmentNumber,
    studentId: s.id.value,
  );

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
      () => SplayTreeMap<_StudentOrderKey, StudentRecord>(),
    );
    final idMap = _idToKey.putIfAbsent(
      tenant,
      () => <String, _StudentOrderKey>{},
    );
    final keys = _orderedKeys.putIfAbsent(tenant, () => []);
    final oldKey = idMap[s.id.value];
    if (oldKey != null && oldKey != key) {
      ordered.remove(oldKey);
      // Remove old key from sorted keys list.
      final oldIndex = _indexOfKey(keys, oldKey);
      if (oldIndex >= 0) keys.removeAt(oldIndex);
    }
    ordered[key] = s;
    idMap[s.id.value] = key;
    if (oldKey != key) {
      // Insert new key in sorted position.
      final index = _insertionIndex(keys, key);
      keys.insert(index, key);
    }
    _store.put(s.id.value, s);
  }

  int _indexOfKey(List<_StudentOrderKey> keys, _StudentOrderKey target) {
    var low = 0;
    var high = keys.length;
    while (low < high) {
      final middle = (low + high) >> 1;
      final comparison = keys[middle].compareTo(target);
      if (comparison < 0) {
        low = middle + 1;
      } else {
        high = middle;
      }
    }
    return low < keys.length && keys[low] == target ? low : -1;
  }

  int _insertionIndex(List<_StudentOrderKey> keys, _StudentOrderKey target) {
    var low = 0;
    var high = keys.length;
    while (low < high) {
      final middle = (low + high) >> 1;
      if (keys[middle].compareTo(target) < 0) {
        low = middle + 1;
      } else {
        high = middle;
      }
    }
    return low;
  }
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
