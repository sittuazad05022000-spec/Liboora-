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
  bool enrollmentNumberExists(String number);
  void save(StudentRecord s);
}

final class InMemoryStudentRepository implements StudentRepository {
  InMemoryStudentRepository(this._store);
  final TenantPartitionedStore<StudentRecord> _store;

  @override
  StudentRecord? byId(StudentRecordId id) => _store.get(id.value);

  @override
  List<StudentRecord> all() => _store.all();

  @override
  bool enrollmentNumberExists(String number) =>
      _store.where((s) => s.enrollmentNumber == number).isNotEmpty;

  @override
  void save(StudentRecord s) => _store.put(s.id.value, s);
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

  Future<StudentRecord> call({
    required AccessRole actorRole,
    required String fullName,
    required String phone,
    required DateTime dateOfBirth,
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
