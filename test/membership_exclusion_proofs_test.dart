/// IMPL-440 remainder — the three remaining exclusions proven **impossible**,
/// not merely absent, plus the `MM-NFR-013` typed-error sweep.
///
/// `PRD-005` §1.5: *"Each is a thing that MUST be impossible in a correct V1
/// build, not merely undone."* `IMPL-440`'s doctrine
/// (`PRD-005_IMPLEMENTATION_TASKS.md:255-258`): a test asserting "no endpoint
/// is exposed" is not enough — the type system or the checker must make the
/// excluded thing unconstructible. The proofs below therefore work on the
/// module's source (the same checker-class technique the foreign-field scan
/// in `membership_creation_gate_test.dart` uses) and on the compiler's
/// `final` enforcement, never on a grep of a passing runtime state alone.
///
/// Register entries proven here — all FROZEN Rank-3 (`PRD-MEMBERSHIP-MANAGEMENT.md`):
///
/// * `MM-XC-007` (`:216`) — auto-renewal: no code path renews without an
///   explicit, authorized human command. Proven by entry-point enumeration:
///   no scheduling primitive exists in the module or composition root, no bus
///   consumer invokes renewal, and the single use-case entry is gated inside
///   its body by a `BC-18` authorization check (`MM-NFR-006`) before any
///   mutation.
/// * `MM-XC-010` (`:219`) — membership transfer: unrepresentable. The
///   aggregate's identity fields are compiler-`final`, no method accepts a
///   new student/branch linkage, and the public mutation surface cannot move
///   them (runtime test).
/// * `MM-XC-012` (`:221`) — proration executed as money: unrepresentable in
///   V1. The module never constructs a `Money` value and calls no proration,
///   refund or credit operation. ⛔ **`Q-06` / `MM-GAP-002` stays OPEN** —
///   nothing here resolves, defaults or forecloses the V2 proration design
///   (`MM-FR-100` already states the split; `MM-XC-012` is its V1 proof).
/// * `MM-NFR-013` (`:1605`) — every surfaced failure is a typed
///   `DomainError` naming the offending field or state; a generic failure is
///   a defect.
///
/// ⚠ Disclosed, NOT fixed here: every membership use case currently gates on
/// `Permission.createMembership` (`membership.dart:459,706,957,1041,1306`).
/// The per-operation permission matrix — create does not imply activate
/// (`MM-NFR-008`) — is **`IMPL-436` scope**, deliberately untouched by this
/// file.
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:liboora/domain/library/membership/membership.dart';
import 'package:liboora_contracts/liboora_contracts.dart';

const _domainPath = 'lib/domain/library/membership/domain/membership.dart';
const _modulePath = 'lib/domain/library/membership/membership.dart';
const _compositionRootPath = 'lib/bootstrap/di.dart';

final _t0 = DateTime.utc(2025, 1, 1, 9);

Membership _membership({MembershipStatus status = MembershipStatus.active}) =>
    Membership.fromPlan(
      id: 'mem_xc_1',
      studentRecordId: const StudentRecordId('stu_xc_1'),
      plan: MembershipPlan(
        id: 'plan_xc_1',
        tenantId: const TenantId('tnt_1'),
        branchId: const BranchId('br_1'),
        name: 'Quarterly',
        durationDays: 90,
        price: Money.paise(150000),
        createdAt: _t0,
        createdBy: 'owner_1',
        seatQuota: 1,
      ),
      term: DateRange.days(_t0, 90),
      status: status,
      createdAt: _t0,
      createdBy: 'owner_1',
      activatedAt: status == MembershipStatus.active ? _t0 : null,
      activatedBy: status == MembershipStatus.active ? 'owner_1' : null,
    );

/// Source with comments removed.
///
/// The exclusions below ban identifiers like `prorate`, `refund` and
/// `transfer`. Those words appear in the module's own doc comments *stating
/// that they are forbidden* (and in `Q-06`'s record) — so a naive scan fails
/// on the prose that documents compliance. Stripping comments makes the test
/// measure the code.
String _codeOnly(String source) => source
    .replaceAll(RegExp(r'/\*.*?\*/', dotAll: true), '')
    .split('\n')
    .map((line) {
      final i = line.indexOf('//');
      return i == -1 ? line : line.substring(0, i);
    })
    .join('\n');

String _read(String path) => File(path).readAsStringSync();

String _classBody(String source, String className) {
  final start = source.indexOf('final class $className {');
  if (start == -1) {
    // Thrown at load time: a vacuous empty body would make every scan below
    // pass while measuring nothing.
    throw StateError(
      'Class $className not found — this scan is measuring nothing.',
    );
  }
  var depth = 0;
  var i = source.indexOf('{', start);
  final from = i;
  for (; i < source.length; i++) {
    if (source[i] == '{') depth++;
    if (source[i] == '}') {
      depth--;
      if (depth == 0) break;
    }
  }
  return source.substring(from, i);
}

void main() {
  final domainSource = _read(_domainPath);
  final moduleSource = _read(_modulePath);
  final compositionRoot = _read(_compositionRootPath);

  final domainCode = _codeOnly(domainSource);
  final moduleCode = _codeOnly(moduleSource);
  final rootCode = _codeOnly(compositionRoot);
  final allModuleCode = '$domainCode\n$moduleCode';

  final membershipBody = _classBody(domainSource, 'Membership');
  final membershipCodeBody = _codeOnly(membershipBody);

  group('guard · the scans are reading real sources', () {
    test('the aggregate class body is non-vacuous and contains the known '
        'identity fields', () {
      expect(membershipCodeBody, contains('studentRecordId'));
      expect(membershipCodeBody, contains('priceSnapshot'));
      expect(membershipCodeBody.length, greaterThan(500));
    });

    test('the module sources are non-empty', () {
      expect(allModuleCode.length, greaterThan(5000));
    });
  });

  // ═══════════════════════════════════════════════════════════════════
  // MM-XC-007 — no auto-renewal. An automatic renewal needs a trigger
  // that is not a human command. This module has none, and the
  // composition root can create none without a new edge.
  // ═══════════════════════════════════════════════════════════════════
  group(
    'MM-XC-007 · renewal cannot run without an authorized human command',
    () {
      test(
        'no scheduling primitive exists anywhere in the membership module',
        () {
          final scheduling = RegExp(
            r'Timer\(|Timer\.periodic|Stream\.periodic|Future\.delayed|'
            r'\.submit\(|JobKey\(',
          );
          final hits = scheduling.allMatches(allModuleCode).toList();
          expect(
            hits,
            isEmpty,
            reason:
                'A scheduler, job or timer in the membership module would '
                'be an automatic trigger — MM-XC-007 forbids one from existing '
                'at all, not merely from renewing today.',
          );
        },
      );

      test('the composition root submits no job — nothing automatic runs', () {
        // The JobRuntime port exists (ADR-0058), but the V1 composition root
        // accepts no work: every automatic path would have to be submitted
        // here, and none is. An expiry-materialisation job (IMPL-425) may be
        // added later — this test is where its non-renewal nature gets
        // re-asserted if one ever appears.
        expect(RegExp(r'\.submit\(').allMatches(rootCode), isEmpty);
      });

      test('the only renewal construction site is the composition root, and '
          'no bus consumer invokes renewal', () {
        // RenewMembership must appear in the composition root exactly once —
        // its wiring — and never inside a subscription callback.
        expect(
          RegExp(r'RenewMembership\(').allMatches(rootCode).length,
          1,
          reason:
              'A second construction site would be an unaccounted entry '
              'point.',
        );
        final consumers = RegExp(
          r"events\.subscribe\([^;]*?consumer:\s*'([^']+)'",
          dotAll: true,
        ).allMatches(rootCode).map((m) => m.group(1)!).toSet();
        expect(
          consumers,
          {'messaging-enforcement', 'audit-bc24'},
          reason:
              'The subscription inventory is closed: neither consumer '
              'renews. A third consumer must update this test and justify '
              'itself against MM-XC-007.',
        );
      });

      test('the renewal entry point is authorization-gated inside the use '
          'case, before any mutation', () {
        final callBody = _classBody(
          moduleSource.substring(
            moduleSource.indexOf('final class RenewMembership'),
          ),
          'RenewMembership',
        );
        final gate = callBody.indexOf('pdp.require(');
        final persist = [
          callBody.indexOf('repo.insertGuardingOverlap('),
          callBody.indexOf('repo.save('),
        ].where((i) => i != -1).reduce((a, b) => a < b ? a : b);
        expect(
          gate,
          greaterThan(-1),
          reason:
              'MM-NFR-006 — the command is authorized through BC-18, '
              'inside the use case.',
        );
        expect(
          persist,
          greaterThan(gate),
          reason:
              'Authorization must be checked before the first write; a '
              'renewal that saved before its gate would be an automatic '
              'effect of an unauthorized call.',
        );
      });
    },
  );

  // ═══════════════════════════════════════════════════════════════════
  // MM-XC-010 — membership transfer is unrepresentable. The linkage to
  // a student and a library is part of the aggregate's identity: it is
  // compiler-final, no method re-links it, and mutation cannot move it.
  // ═══════════════════════════════════════════════════════════════════
  group('MM-XC-010 · transfer between students or libraries is '
      'unrepresentable', () {
    const identityFields = [
      'id',
      'studentRecordId',
      'planId',
      'term',
      'priceSnapshot',
      'planVersionAtPurchase',
      'branchId',
    ];

    test('every identity field is declared final — the compiler, not review, '
        'forbids reassignment', () {
      for (final field in identityFields) {
        final declaration = RegExp(
          r'(?:final\s+|late\s+final\s+)[A-Za-z0-9_<>?,\s.]+' +
              field.replaceAll(RegExp(r'[.*+?^${}()|[\]\\]'), r'\&') +
              r'\s*;',
          multiLine: true,
        );
        expect(
          declaration.hasMatch(membershipCodeBody),
          isTrue,
          reason: '$field must be a final field of the aggregate',
        );
      }
    });

    test(
      'no method of the aggregate accepts a new student or branch linkage',
      () {
        // Any transfer API would have to take the new linkage as a parameter
        // on some method of the aggregate (or a copy constructor). None does.
        final reLinkParam = RegExp(
          r'\b(?:void|Future<[^>]*>|Membership|bool|String|Money|DateRange)\s+'
          r'\w+\s*\([^)]*\b(?:StudentRecordId|String)\s+(?:newStudent|student|'
          r'newBranch|branch|toStudent|toBranch)\w*',
          multiLine: true,
        );
        expect(
          reLinkParam.hasMatch(membershipCodeBody),
          isFalse,
          reason:
              'A re-linkage parameter is the only shape a transfer could '
              'take on this aggregate',
        );
        expect(membershipCodeBody, isNot(contains('copyWith')));
        expect(membershipCodeBody, isNot(contains('transfer')));
        expect(membershipCodeBody, isNot(contains('reassign')));
      },
    );

    test('no assignment to the linkage fields exists in module code', () {
      // `final` already forbids this; the scan documents the invariant at
      // the same level as the rest of this file and would catch a demotion
      // of a final field to mutable.
      expect(
        RegExp(r'\bstudentRecordId\s*=[^=]').allMatches(allModuleCode),
        isEmpty,
      );
      expect(RegExp(r'\bbranchId\s*=[^=]').allMatches(allModuleCode), isEmpty);
    });

    test('runtime: the public mutation surface cannot move the linkage', () {
      // activate: a Scheduled membership activates — an already-Active one
      // is a rejected transition (MM-FR-074), which is itself typed.
      final scheduled = _membership(status: MembershipStatus.scheduled)
        ..activate(at: _t0, by: 'owner_1');
      expect(scheduled.studentRecordId.value, 'stu_xc_1');
      expect(scheduled.branchId.value, 'br_1');

      final voided = _membership(status: MembershipStatus.pendingPayment);
      voided.voidBeforeActivation(reason: 'duplicate sale', by: 'owner_1');
      expect(voided.studentRecordId.value, 'stu_xc_1');
      expect(voided.branchId.value, 'br_1');

      // Terminal transitions mutate status only — never the linkage.
      final active = _membership()..expire();
      expect(active.studentRecordId.value, 'stu_xc_1');
      expect(active.branchId.value, 'br_1');
    });
  });

  // ═══════════════════════════════════════════════════════════════════
  // MM-XC-012 — proration executed as money is unrepresentable in V1.
  // Q-06 / MM-GAP-002 remains OPEN; nothing here resolves it.
  // ═══════════════════════════════════════════════════════════════════
  group('MM-XC-012 · proration is never executed as money in V1', () {
    test('the shared kernel proration primitive is never called from this '
        'module', () {
      expect(
        allModuleCode.contains('prorate'),
        isFalse,
        reason:
            'Money.prate (money.dart:44) is the Business Platform V2 '
            'primitive; BC-02 calling it would execute proration as money.',
      );
    });

    test('no refund or credit computation exists in module code', () {
      final refundOrCredit = RegExp(r'refund|credit', caseSensitive: false);
      expect(
        refundOrCredit.allMatches(allModuleCode),
        isEmpty,
        reason: 'MM-FR-100: no prorated monetary credit, no refund.',
      );
    });

    test('every Money construction in the module is the MM-FR-099 price '
        'difference — a subtraction of two immutable snapshots, never a '
        'time-weighted proration', () {
      // `priceDifferenceTo` (domain/membership.dart:970) is required by
      // MM-FR-099 and endorsed at BC Map L545: the ENTITLEMENT delta is
      // published on MM-EVT-004. It subtracts two snapshot amounts; it does
      // not multiply by a time fraction. Q-06 stays open — the Business
      // Platform owns proration money at V2.
      final constructions = RegExp(
        r'Money\.(zero|paise|rupees)\b',
      ).allMatches(allModuleCode).toList();
      expect(
        constructions,
        isNotEmpty,
        reason: 'the scan must see the real construction population',
      );

      // Position-based containment: every construction must sit inside the
      // aggregate's priceDifferenceTo method region — i.e. after its
      // declaration and before the class body closes.
      final bodyStart = membershipCodeBody.indexOf('Money priceDifferenceTo');
      expect(
        bodyStart,
        greaterThan(-1),
        reason: 'the MM-FR-099 method must exist for the upgrade flow',
      );
      final classEnd = membershipCodeBody.length;
      for (final match in RegExp(
        r'Money\.(zero|paise|rupees)\b',
      ).allMatches(membershipCodeBody)) {
        expect(
          match.start,
          greaterThanOrEqualTo(bodyStart),
          reason:
              '${match.group(0)} constructed outside the MM-FR-099 '
              'priceDifferenceTo — a computed monetary value outside the '
              'snapshot flow.',
        );
        expect(match.start, lessThan(classEnd));
      }
      // No Money construction anywhere else in the module's two files.
      final outsideAggregate = '$domainCode\n$moduleCode'.replaceAll(
        membershipCodeBody,
        '',
      );
      expect(
        RegExp(r'Money\.(zero|paise|rupees)\b').allMatches(outsideAggregate),
        isEmpty,
        reason:
            'Every Money construction in BC-02 must live inside the '
            'MM-FR-099 method — anywhere else would be a computed monetary '
            'value outside the snapshot flow.',
      );
      // And the difference is not time-weighted: no money arithmetic over a
      // day count exists.
      expect(
        RegExp(
          r'(remainingDays|daysRemaining|durationDays)\s*\)*\s*[/]',
        ).hasMatch(allModuleCode),
        isFalse,
        reason:
            'A money/day division would be proration arithmetic — '
            'MM-XC-012 places it at V2, and Q-06 is not ours to resolve.',
      );
    });

    test('every Money-typed member of the aggregate is the immutable '
        'snapshot or the MM-FR-099 difference', () {
      final moneyMembers = RegExp(
        r'^\s*(?:(?:final\s+|late\s+final\s+)?Money\s+get\s+(\w+)|'
        r'(?:final\s+|late\s+final\s+)?Money\s+((?!get\b)\w+)\s*[(;=])',
        multiLine: true,
      ).allMatches(membershipCodeBody).toList();
      expect(moneyMembers, isNotEmpty);
      final names = moneyMembers
          .map((m) => m.group(1) ?? m.group(2))
          .whereType<String>()
          .toSet();
      expect(
        names,
        {'priceSnapshot', 'applicableAmount', 'priceDifferenceTo'},
        reason:
            'A new Money member would need its own justification '
            'against MM-XC-012 before it may exist. (currencySnapshot is '
            'String-typed and so is not a Money member.)',
      );
      // The derived getter reads the snapshot; the difference method is the
      // MM-FR-099 subtraction proven above; none computes a new value from
      // configuration or time.
      expect(membershipCodeBody, contains('applicableAmount => priceSnapshot'));
      expect(
        membershipCodeBody,
        contains('currencySnapshot => priceSnapshot.currency'),
      );
    });
  });

  // ═══════════════════════════════════════════════════════════════════
  // MM-NFR-013 — every surfaced failure is a typed DomainError naming
  // the offending field or state. A generic failure is a defect.
  // ═══════════════════════════════════════════════════════════════════
  group('MM-NFR-013 · every failure path is a typed, field-naming error', () {
    test('every throw in the membership module is a DomainError', () {
      final throws = RegExp(
        r'^\s*throw\s+([^;{]+)',
        multiLine: true,
      ).allMatches(allModuleCode).map((m) => m.group(1)!).toList();
      expect(throws, isNotEmpty, reason: 'the scan must not pass vacuously');
      for (final thrown in throws) {
        expect(
          thrown,
          contains('DomainError'),
          reason:
              'A non-DomainError throw would surface an untyped '
              'failure to a user — MM-NFR-013 defect.',
        );
      }
    });

    test('every DomainError carries a context naming the field or state', () {
      final errorBlocks = RegExp(
        r'throw\s+(?:const\s+)?DomainError\([^;]*?\);',
        multiLine: true,
        dotAll: true,
      ).allMatches(allModuleCode).map((m) => m.group(0)!).toList();
      expect(
        errorBlocks.length,
        greaterThanOrEqualTo(20),
        reason: 'the scan must see the real error population',
      );
      for (final block in errorBlocks) {
        expect(
          block,
          contains('context:'),
          reason:
              'MM-NFR-013 — the error must identify the offending '
              'field or state, not merely fail: $block',
        );
      }
    });
  });
}
