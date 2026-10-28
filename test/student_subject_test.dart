/// TASK-D10 D10-9/D10-10 regression — subject resolution uses an **explicit**
/// parent→student link, never a hardcoded constant.
///
/// `kDemoChildPhone` (`'9810000004'`) used to silently resolve every parent
/// session to one specific student — a cross-tenant exposure with a plausible
/// comment above it (`MP-CON-11`). `Accepted` `ADR-0085` §5 (Product Owner,
/// 2026-09-01) rules the link must be **explicit** and never inferred
/// (Option B), so `subjectStudentId` resolves a parent through their OWN
/// authenticated phone against the explicit link map at the composition root.
///
/// The test reads the delivered message, not private state (ADR-0007): the
/// container's transport is the debug-console sink, so the test captures what
/// was actually delivered and verifies with it — exactly what a legitimate
/// user does.
library;

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:liboora/app/shared/session.dart';
import 'package:liboora/app/student/student_subject.dart';
import 'package:liboora/bootstrap/di.dart';
import 'package:liboora/bootstrap/seed.dart';
import 'package:liboora/platform/data/data.dart';
import 'package:liboora/platform/identity/identity.dart';
import 'package:liboora_contracts/liboora_contracts.dart';

const _parentPhone = '9810000005';
const _childPhone = '9810000004';
const _staffPhone = '9810000001';

final List<String> _delivered = <String>[];
late DebugPrintCallback _previousDebugPrint;

void _capture(String? message, {int? wrapWidth}) {
  if (message != null) _delivered.add(message);
}

/// Captures the challenge from the wired debug-console transport — the one
/// observable place a code appears. Never inspects private service state.
String _lastDeliveredCode(String phone) {
  final pattern = RegExp(r'\[OTP\] ' + phone + r' -> (\d{6})');
  for (final message in _delivered.reversed) {
    final m = pattern.firstMatch(message);
    if (m != null) return m.group(1)!;
  }
  throw StateError('No challenge was delivered to $phone');
}

/// Sign in a seeded account through the REAL request/verify path.
Future<SessionController> _signInAs(AppContainer container, String phone) async {
  final s = SessionController(container);
  s.requestOtp(phone);
  final issued = s.verifyOtp(phone: phone, code: _lastDeliveredCode(phone));
  expect(issued, isTrue, reason: 'seeded $phone must be able to sign in');
  return s;
}

Future<AppContainer> _boot() => AppContainer.boot(
      seeder: seedDemoData,
      durable: InMemoryKeyValueStore(),
    );

void main() {
  setUp(() {
    _delivered.clear();
    _previousDebugPrint = debugPrint;
    debugPrint = _capture;
  });

  tearDown(() {
    debugPrint = _previousDebugPrint;
    _delivered.clear();
  });

  test('a parent resolves their child via the explicit link on their own phone',
      () async {
    final container = await _boot();

    // The link is stored, keyed by the PARENT's phone, and points at the
    // child's record — never at a constant. The student's own link supplies
    // the expected child id without a tenant-scoped read (no session yet).
    final childId = container.studentAccountLinks[_childPhone];
    expect(childId, isNotNull, reason: 'the student must have a record link');
    expect(
      container.studentAccountLinks[_parentPhone],
      childId,
      reason: 'the explicit parent→student link must be on record',
    );

    final s = await _signInAs(container, _parentPhone);
    expect(s.role, AccessRole.parent);
    expect(s.subjectStudentId, childId);
  });

  test('a student still resolves themselves (unchanged behaviour)', () async {
    final container = await _boot();
    final selfId = container.studentAccountLinks[_childPhone];

    final s = await _signInAs(container, _childPhone);
    expect(s.role, AccessRole.student);
    expect(s.subjectStudentId, selfId);
  });

  test('staff roles have no subject at all', () async {
    final container = await _boot();

    final s = await _signInAs(container, _staffPhone);
    expect(s.role, AccessRole.owner);
    expect(s.subjectStudentId, isNull);
  });
}
