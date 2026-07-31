/// **BC-03 Attendance** — public barrel.
library;

export 'domain/attendance_day.dart';

import 'package:liboora_contracts/liboora_contracts.dart';

import '../../../platform/data/data.dart';
import '../../../platform/event/event.dart';
import '../../../platform/identity/identity.dart';
import '../../../platform/services/services.dart';
import '../membership/membership.dart';
import '../policy/policy.dart';
import 'domain/attendance_day.dart';

abstract interface class AttendanceRepository {
  AttendanceDay? find(StudentRecordId id, DateTime date);
  List<AttendanceDay> onDate(DateTime date);
  List<AttendanceDay> forStudent(StudentRecordId id);
  void save(AttendanceDay day);
}

final class InMemoryAttendanceRepository implements AttendanceRepository {
  InMemoryAttendanceRepository(this._store);
  final TenantPartitionedStore<AttendanceDay> _store;

  static String _key(StudentRecordId id, DateTime d) =>
      '${id.value}#${d.toIso8601String().substring(0, 10)}';

  @override
  AttendanceDay? find(StudentRecordId id, DateTime date) =>
      _store.get(_key(id, date));

  @override
  List<AttendanceDay> onDate(DateTime date) {
    final iso = date.toIso8601String().substring(0, 10);
    return _store.where(
      (d) => d.date.toIso8601String().substring(0, 10) == iso,
    );
  }

  @override
  List<AttendanceDay> forStudent(StudentRecordId id) =>
      _store.where((d) => d.studentRecordId == id);

  @override
  void save(AttendanceDay day) =>
      _store.put(_key(day.studentRecordId, day.date), day);
}

/// Use case: check a student in.
///
/// Demonstrates four architectural rules at once —
///  * idempotency (a duplicate punch is a no-op, not an error)
///  * membership read via projection, flagged not blocked (E-03)
///  * policy conformist read (E-04)
///  * offline capture queued through Platform Services
final class CheckInStudent {
  CheckInStudent({
    required this.repo,
    required this.validity,
    required this.policies,
    required this.idempotency,
    required this.sync,
    required this.events,
    required this.clock,
    required this.ids,
    required this.tenant,
    required this.pdp,
  });

  final AttendanceRepository repo;
  final MembershipValidityReader validity;
  final PolicyReader policies;
  final IdempotencyService idempotency;
  final OfflineSyncEngine sync;
  final EventBus events;
  final Clock clock;
  final IdGenerator ids;
  final TenantContext tenant;
  final PolicyDecisionPoint pdp;

  Future<({AttendanceDay day, bool duplicate, bool flagged})> call({
    required AccessRole actorRole,
    required StudentRecordId studentId,
    VerificationMethod method = VerificationMethod.qr,
    IdempotencyKey? key,
  }) async {
    pdp.require(actorRole, Permission.recordAttendance);

    final now = clock.now();
    final today = clock.today();
    final idem = key ?? IdempotencyKey(ids.next('punch'));

    if (idempotency.seen(idem)) {
      final existing = repo.find(studentId, today)!;
      return (day: existing, duplicate: true, flagged: false);
    }

    final policy = policies.forBranch(tenant.branchId);
    final v = validity.forStudent(studentId, today);

    final day =
        repo.find(studentId, today) ??
        AttendanceDay(studentRecordId: studentId, date: today);

    day.membershipValidAtEntry = v.isValid;
    day.lateEntry = policy.isLateEntry(now);

    final accepted = day.checkIn(
      Punch(
        at: now,
        method: method,
        idempotencyKey: idem,
        capturedOffline: !sync.online,
      ),
    );

    if (!accepted) return (day: day, duplicate: true, flagged: false);

    repo.save(day);
    idempotency.remember(idem, day);

    if (!sync.online) {
      sync.enqueue(
        QueuedMutation(
          id: ids.next('sync'),
          description: 'Check-in ${studentId.value}',
          queuedAt: now,
        ),
      );
    }

    events.enqueue([
      DomainEvent(
        eventId: ids.next('evt'),
        eventType: 'attendance.StudentCheckedIn',
        tenantId: tenant.tenantId,
        aggregateId: studentId.value,
        occurredAt: now,
        actorId: tenant.actorId,
        correlationId: tenant.correlationId,
        payload: {
          'studentRecordId': studentId.value,
          'method': method.name,
          'lateEntry': day.lateEntry,
          'membershipValid': v.isValid,
        },
      ),
    ]);
    await events.drain();

    return (day: day, duplicate: false, flagged: !v.isValid);
  }
}

final class CheckOutStudent {
  CheckOutStudent({
    required this.repo,
    required this.events,
    required this.clock,
    required this.ids,
    required this.tenant,
    required this.pdp,
  });

  final AttendanceRepository repo;
  final EventBus events;
  final Clock clock;
  final IdGenerator ids;
  final TenantContext tenant;
  final PolicyDecisionPoint pdp;

  Future<AttendanceDay> call({
    required AccessRole actorRole,
    required StudentRecordId studentId,
  }) async {
    pdp.require(actorRole, Permission.recordAttendance);
    final today = clock.today();
    final day = repo.find(studentId, today);
    if (day == null) {
      throw const DomainError(
        DomainErrorCode.notCheckedIn,
        'No attendance record for today.',
      );
    }

    day.checkOut(
      Punch(
        at: clock.now(),
        method: VerificationMethod.qr,
        idempotencyKey: IdempotencyKey(ids.next('punch')),
      ),
    );
    repo.save(day);

    events.enqueue([
      DomainEvent(
        eventId: ids.next('evt'),
        eventType: 'attendance.StudentCheckedOut',
        tenantId: tenant.tenantId,
        aggregateId: studentId.value,
        occurredAt: clock.now(),
        actorId: tenant.actorId,
        correlationId: tenant.correlationId,
        payload: {
          'studentRecordId': studentId.value,
          'minutesInside': day.timeInside.inMinutes,
        },
      ),
    ]);
    await events.drain();
    return day;
  }
}
