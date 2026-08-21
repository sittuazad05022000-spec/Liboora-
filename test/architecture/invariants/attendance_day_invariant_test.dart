/// **Architecture test — aggregate invariants for `BC-03 Attendance`.**
///
/// Required by `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` §10.3
/// (`every_aggregate_has_invariant_tests_test.dart`).
///
/// `AttendanceDay`'s own doc comment names the three invariants that justify a
/// student-day aggregate rather than a punch aggregate: **check-out after
/// check-in**, **one open session**, and **idempotent punch**. Those three are
/// the spine of this file. A fourth — **corrections are append-only** — is the
/// audit property that makes the record defensible after the fact.
///
/// **Why idempotency is tested hardest.** Edge `E-03` records that Attendance
/// *records and flags* rather than blocking, and the aggregate comment names
/// the two real replay sources: a double-tapped QR scanner and an offline punch
/// replayed on reconnect. Idempotency is therefore not a nicety here; it is the
/// only thing standing between one reconnect and a duplicated attendance day.
///
/// **No wall clock** (`X-09`): every instant is a fixed constant.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:liboora/domain/library/attendance/domain/attendance_day.dart';
import 'package:liboora_contracts/liboora_contracts.dart';

const StudentRecordId _student = StudentRecordId('SR-2026-0001');

/// A fixed working day. 2026-03-02 was chosen; nothing samples the clock.
final DateTime _date = DateTime.utc(2026, 3, 2);

DateTime _at(int hour, [int minute = 0]) =>
    DateTime.utc(2026, 3, 2, hour, minute);

Punch _punch(
  DateTime at, {
  required String key,
  VerificationMethod method = VerificationMethod.qr,
  bool capturedOffline = false,
}) => Punch(
  at: at,
  method: method,
  idempotencyKey: IdempotencyKey(key),
  capturedOffline: capturedOffline,
);

AttendanceDay _day() =>
    AttendanceDay(studentRecordId: _student, date: _date);

void main() {
  // ════════════════════════════════════════════════════════════════════
  // INVARIANT 1 — idempotent by (studentRecordId, date, idempotencyKey).
  // ════════════════════════════════════════════════════════════════════
  group('BC-03 invariant: a punch is idempotent within the student-day', () {
    test('replaying a check-in with the same key adds nothing and reports '
        'not-applied rather than throwing', () {
      final day = _day();

      expect(day.checkIn(_punch(_at(9), key: 'IK-1')), isTrue);
      final replay = day.checkIn(_punch(_at(9), key: 'IK-1'));

      expect(
        replay,
        isFalse,
        reason:
            'The aggregate contract (attendance_day.dart L68) is that a '
            'duplicate returns false and the caller treats it as success. '
            'Throwing would turn a normal reconnect into a visible error.',
      );
      expect(
        day.entries.length,
        1,
        reason:
            'A replayed punch that appends is a duplicated attendance day, '
            'which is a fraud signal fired against an honest student.',
      );
    });

    test('replay is keyed on the idempotency key, not on the timestamp', () {
      final day = _day();
      day.checkIn(_punch(_at(9), key: 'IK-1'));

      // Same key, different instant, different capture method.
      final replay = day.checkIn(
        _punch(_at(9, 30), key: 'IK-1', method: VerificationMethod.manual),
      );

      expect(replay, isFalse);
      expect(day.entries.length, 1);
      expect(
        day.entries.single.at,
        _at(9),
        reason:
            'A replay must not overwrite the original punch time. The first '
            'observation is the one the audit trail has to reproduce.',
      );
    });

    test('the key namespace is shared across entries AND exits — '
        'entry key replayed as an exit', () {
      final day = _day();
      day.checkIn(_punch(_at(9), key: 'IK-1'));

      // An exit reusing the entry's key is a replay, not a new event.
      final asExit = day.checkOut(_punch(_at(17), key: 'IK-1'));

      expect(
        asExit,
        isFalse,
        reason:
            '_alreadyProcessed() scans both lists (L61-63). If the namespaces '
            'were separate, a client retrying with one key could produce a '
            'check-in and a check-out from a single intended action.',
      );
      expect(day.exits, isEmpty);
      expect(day.isOpen, isTrue);
    });

    test('the key namespace is shared across entries AND exits — '
        'exit key replayed as a check-in', () {
      // This is the OTHER direction, and it is the one that catches an
      // _alreadyProcessed() that scans only `entries`. Added after a mutation
      // run showed that dropping the `exits` scan left the entry-key-replayed-
      // as-exit case above still passing: with the key sitting in `entries`,
      // an entries-only scan still answers "already processed". Only a key
      // that lives EXCLUSIVELY in `exits` can distinguish the two
      // implementations.
      final day = _day();
      day.checkIn(_punch(_at(9), key: 'IK-IN'));
      day.checkOut(_punch(_at(12), key: 'IK-OUT'));

      // 'IK-OUT' exists only in `exits`. Replaying it as a check-in must be
      // recognised as a duplicate.
      final replayedAsEntry = day.checkIn(_punch(_at(14), key: 'IK-OUT'));

      expect(
        replayedAsEntry,
        isFalse,
        reason:
            'A retry of the check-OUT request must never be absorbed as a new '
            'check-IN. That would silently re-open the session and bill the '
            'student for an afternoon they never sat.',
      );
      expect(
        day.entries.length,
        1,
        reason: 'The replay must not append a second entry.',
      );
      expect(
        day.isOpen,
        isFalse,
        reason:
            'The day was closed by the check-out; a replayed exit key must '
            'leave it closed.',
      );
    });

    test('a distinct key is accepted — idempotency is not a blanket refusal',
        () {
      // Vacuity guard: without this, an implementation that refused every
      // second punch would pass all three tests above.
      final day = _day();
      expect(day.checkIn(_punch(_at(9), key: 'IK-1')), isTrue);
      expect(day.checkOut(_punch(_at(13), key: 'IK-2')), isTrue);
      expect(day.checkIn(_punch(_at(14), key: 'IK-3')), isTrue);
      expect(day.entries.length, 2);
      expect(day.exits.length, 1);
    });

    test('an offline-captured punch is idempotent on exactly the same terms',
        () {
      // The reconnect path is the one that actually replays in production.
      final day = _day();
      expect(
        day.checkIn(_punch(_at(9), key: 'IK-OFF', capturedOffline: true)),
        isTrue,
      );
      expect(
        day.checkIn(_punch(_at(9), key: 'IK-OFF', capturedOffline: true)),
        isFalse,
        reason:
            'Offline capture must not get a weaker guarantee than online '
            'capture; it is the replay source the guarantee exists for.',
      );
      expect(day.entries.single.capturedOffline, isTrue);
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // INVARIANT 2 — at most one open session per student-day.
  // ════════════════════════════════════════════════════════════════════
  group('BC-03 invariant: at most one open session', () {
    test('a second check-in while open is refused', () {
      final day = _day();
      day.checkIn(_punch(_at(9), key: 'IK-1'));

      DomainError? caught;
      try {
        day.checkIn(_punch(_at(10), key: 'IK-2'));
      } on DomainError catch (e) {
        caught = e;
      }

      expect(caught, isNotNull);
      expect(caught!.code, DomainErrorCode.alreadyCheckedIn);
      expect(
        day.entries.length,
        1,
        reason: 'A refused check-in must not append.',
      );
    });

    test('re-entry after a completed session is permitted', () {
      final day = _day();
      day.checkIn(_punch(_at(9), key: 'IK-1'));
      day.checkOut(_punch(_at(12), key: 'IK-2'));

      expect(
        day.checkIn(_punch(_at(14), key: 'IK-3')),
        isTrue,
        reason:
            'Students leave for lunch. "One open session" is not "one session '
            'per day"; conflating the two would lock the afternoon out.',
      );
      expect(day.isOpen, isTrue);
    });

    test('checking out when not checked in is refused', () {
      final day = _day();

      DomainError? caught;
      try {
        day.checkOut(_punch(_at(17), key: 'IK-1'));
      } on DomainError catch (e) {
        caught = e;
      }

      expect(caught, isNotNull);
      expect(caught!.code, DomainErrorCode.notCheckedIn);
      expect(day.exits, isEmpty);
    });

    test('a double check-out is refused rather than silently balanced', () {
      final day = _day();
      day.checkIn(_punch(_at(9), key: 'IK-1'));
      day.checkOut(_punch(_at(12), key: 'IK-2'));

      DomainError? caught;
      try {
        day.checkOut(_punch(_at(13), key: 'IK-3'));
      } on DomainError catch (e) {
        caught = e;
      }

      expect(caught, isNotNull);
      expect(caught!.code, DomainErrorCode.notCheckedIn);
      expect(
        day.exits.length,
        1,
        reason:
            'exits.length may never exceed entries.length, or timeInside '
            'silently drops a pair and under-reports the student.',
      );
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // INVARIANT 3 — a check-out may never precede its check-in.
  // ════════════════════════════════════════════════════════════════════
  group('BC-03 invariant: check-out cannot precede check-in', () {
    test('an earlier check-out instant is refused', () {
      final day = _day();
      day.checkIn(_punch(_at(9), key: 'IK-1'));

      DomainError? caught;
      try {
        day.checkOut(_punch(_at(8), key: 'IK-2'));
      } on DomainError catch (e) {
        caught = e;
      }

      expect(caught, isNotNull);
      expect(caught!.code, DomainErrorCode.checkOutBeforeCheckIn);
      expect(
        day.exits,
        isEmpty,
        reason:
            'Accepting it would make timeInside negative, and a negative '
            'duration propagates into every occupancy and billing projection '
            'downstream.',
      );
    });

    test('a same-instant check-out is permitted — the bound is strict', () {
      final day = _day();
      day.checkIn(_punch(_at(9), key: 'IK-1'));

      expect(
        day.checkOut(_punch(_at(9), key: 'IK-2')),
        isTrue,
        reason:
            'The guard is isBefore (L90), so equality is allowed. A zero-length '
            'visit is odd but not contradictory, and refusing it would reject '
            'legitimate same-second scanner pairs.',
      );
      expect(day.timeInside, Duration.zero);
    });

    test('timeInside is never negative across a multi-session day', () {
      final day = _day();
      day.checkIn(_punch(_at(9), key: 'A'));
      day.checkOut(_punch(_at(12), key: 'B'));
      day.checkIn(_punch(_at(14), key: 'C'));
      day.checkOut(_punch(_at(18), key: 'D'));

      expect(day.timeInside, const Duration(hours: 7));
      expect(day.timeInside.isNegative, isFalse);
      expect(day.firstEntry, _at(9));
      expect(day.lastExit, _at(18));
    });

    test('an open session contributes nothing to timeInside', () {
      final day = _day();
      day.checkIn(_punch(_at(9), key: 'A'));

      expect(
        day.timeInside,
        Duration.zero,
        reason:
            'An unpaired entry must not be silently closed at "now" — that '
            'would be a wall-clock read inside a domain rule (X-09).',
      );
      expect(day.isOpen, isTrue);
      expect(day.lastExit, isNull);
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // INVARIANT 4 — corrections are append-only, with actor and reason.
  // ════════════════════════════════════════════════════════════════════
  group('BC-03 invariant: corrections are append-only', () {
    test('a correction appends and carries both actor and reason', () {
      final day = _day();
      day.checkIn(_punch(_at(9), key: 'A'));

      day.recordCorrection('staff-7', 'scanner offline, manual entry');
      day.recordCorrection('owner-1', 'verified against CCTV');

      expect(day.corrections.length, 2);
      expect(day.corrections.first, contains('staff-7'));
      expect(day.corrections.first, contains('scanner offline'));
      expect(
        day.corrections.last,
        contains('owner-1'),
        reason:
            'A correction without an actor is an anonymous edit, which defeats '
            'the reason corrections are recorded instead of applied.',
      );
    });

    test('recording a correction does not mutate the punches it explains', () {
      final day = _day();
      day.checkIn(_punch(_at(9), key: 'A'));
      day.checkOut(_punch(_at(17), key: 'B'));
      final inside = day.timeInside;

      day.recordCorrection('staff-7', 'entry time disputed');

      expect(
        day.entries.single.at,
        _at(9),
        reason:
            'A correction is a NEW statement about the record, never an edit '
            'to it (L100). The original observation must survive verbatim.',
      );
      expect(day.timeInside, inside);
      expect(day.exits.length, 1);
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // INVARIANT 5 — E-03: Attendance records and flags, it does not block.
  // ════════════════════════════════════════════════════════════════════
  group('BC-03 invariant: an invalid membership is flagged, not blocked', () {
    test('a student with no valid membership can still be checked in, with '
        'the flag set', () {
      final day = AttendanceDay(
        studentRecordId: _student,
        date: _date,
        membershipValidAtEntry: false,
        lateEntry: true,
      );

      expect(
        day.checkIn(_punch(_at(10), key: 'IK-1')),
        isTrue,
        reason:
            'Edge E-03 is explicit: "never lock a paying student out at the '
            'door over a stale projection". Turning this into a refusal moves '
            'a Membership decision into Attendance and breaks the edge.',
      );
      expect(day.membershipValidAtEntry, isFalse);
      expect(day.lateEntry, isTrue);
      expect(day.entries.length, 1);
    });
  });
}
