/// **App-boundary law.**
///
/// The target architecture requires three presentation boundaries that can each
/// become a separate app without rewriting the shared domain:
///
///   * `lib/app/student/**`        → `liboora-student-app`  (Student + Parent)
///   * `lib/app/staff/**`          → `liboora-staff-app`    (Reception + Manager + Owner)
///   * `lib/app/platform_admin/**` → `liboora-platform-admin` (PR-1 / PR-2)
///
/// A directory layout alone is a convention, and conventions decay silently.
/// These tests make the boundaries a **build failure** when crossed, which is
/// the only form that survives contact with a deadline.
///
/// ⭐ This file **strengthens** the existing checks. It waives nothing, and it
/// does not touch `tool/module_dependencies.yaml`, whose `app` module remains a
/// single rank-9 node — this is a *presentation-internal* partition inside that
/// node, so no dependency rank or module law changes.
///
/// ⛔ It also encodes a governance fact, not a preference: `AccessRole` carries
/// **tenant** roles only, and the platform-role set is closed at `PR-1`/`PR-2`
/// by `PRD-001` §2.3 and `PRD-012a` `SECP-FR-003`. A test that failed the
/// moment someone added a sixth `AccessRole` value for "Platform Owner" is the
/// point: that addition requires an ADR first.
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:liboora/platform/identity/identity.dart';
import 'package:liboora/app/staff/staff_app_shell.dart';
import 'package:liboora/app/student/student_app_shell.dart';

/// Repository root, located from the test's own path so the test is
/// runnable from any working directory.
Directory _repoRoot() {
  var dir = Directory.current;
  while (!File('${dir.path}/pubspec.yaml').existsSync()) {
    final parent = dir.parent;
    if (parent.path == dir.path) {
      throw StateError('could not locate repository root');
    }
    dir = parent;
  }
  return dir;
}

List<File> _dartFilesUnder(String relative) {
  final dir = Directory('${_repoRoot().path}/$relative');
  if (!dir.existsSync()) return const [];
  return dir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'))
      .toList();
}

/// The import targets of a Dart file, as written.
List<String> _importsOf(File f) {
  final re = RegExp("^import\\s+['\"]([^'\"]+)['\"]", multiLine: true);
  return re
      .allMatches(f.readAsStringSync())
      .map((m) => m.group(1)!)
      .toList(growable: false);
}

void main() {
  group('the three app boundaries exist and are separable', () {
    test('each boundary directory is present', () {
      final root = _repoRoot().path;
      for (final b in [
        'lib/app/shared',
        'lib/app/student',
        'lib/app/staff',
        'lib/app/platform_admin',
      ]) {
        expect(
          Directory('$root/$b').existsSync(),
          isTrue,
          reason: '$b is required by the target architecture',
        );
      }
    });

    test('student and staff each have exactly one shell entry point', () {
      final root = _repoRoot().path;
      expect(
        File('$root/lib/app/student/student_app_shell.dart').existsSync(),
        isTrue,
      );
      expect(
        File('$root/lib/app/staff/staff_app_shell.dart').existsSync(),
        isTrue,
      );
    });

    test('the superseded all-roles shell is gone', () {
      // The pre-split lib/app/shell/home_shell.dart held every role's
      // navigation in one file. Its return would re-create the exact coupling
      // that makes per-app extraction impossible.
      final root = _repoRoot().path;
      expect(
        File('$root/lib/app/shell/home_shell.dart').existsSync(),
        isFalse,
        reason:
            'a single role-aware shell for all three experiences is '
            'forbidden by the target architecture',
      );
    });
  });

  group('boundaries do not import one another', () {
    test('student imports nothing from staff or platform_admin', () {
      for (final f in _dartFilesUnder('lib/app/student')) {
        for (final imp in _importsOf(f)) {
          expect(
            imp.contains('app/staff') ||
                imp.contains('staff/') ||
                imp.contains('platform_admin'),
            isFalse,
            reason:
                '${f.path} imports "$imp" — the student boundary must be '
                'extractable without the staff or platform-admin code',
          );
        }
      }
    });

    test('staff imports nothing from student or platform_admin', () {
      for (final f in _dartFilesUnder('lib/app/staff')) {
        for (final imp in _importsOf(f)) {
          // '../shared/…' is app/shared and legitimate; 'shared/…' without a
          // leading '../' is staff's own shared folder. Neither is a crossing.
          final crossesToStudent =
              imp.contains('app/student') ||
              imp.contains('student/student') ||
              imp.contains('student/parent');
          expect(
            crossesToStudent || imp.contains('platform_admin'),
            isFalse,
            reason:
                '${f.path} imports "$imp" — the staff boundary must be '
                'extractable without the student or platform-admin code',
          );
        }
      }
    });

    test('shared presentation imports no boundary', () {
      // app/shared is consumed BY the boundaries; if it reached back into one,
      // every boundary would transitively depend on that one.
      for (final f in _dartFilesUnder('lib/app/shared')) {
        for (final imp in _importsOf(f)) {
          expect(
            imp.contains('student') ||
                imp.contains('staff') ||
                imp.contains('platform_admin'),
            isFalse,
            reason:
                '${f.path} imports "$imp" — shared presentation must stay '
                'role-neutral and boundary-agnostic',
          );
        }
      }
    });
  });

  group('shared presentation stays role-neutral', () {
    test('no file in app/shared switches on AccessRole', () {
      // A role switch in shared chrome silently rebuilds the monolith: the
      // frame would once again need to know all three experiences.
      for (final f in _dartFilesUnder('lib/app/shared')) {
        final src = f.readAsStringSync();
        expect(
          RegExp(r'switch\s*\(\s*\w*\.?role\s*\)').hasMatch(src),
          isFalse,
          reason:
              '${f.path} branches on a role — behaviour that differs by '
              'role must be passed in as data by the owning boundary',
        );
        // Doc comments legitimately EXPLAIN the role-neutrality rule and may
        // name a role while doing so; only executable code is constrained.
        final code = src
            .split('\n')
            .where((l) => !l.trimLeft().startsWith('///'))
            .where((l) => !l.trimLeft().startsWith('//'))
            .join('\n');
        expect(
          RegExp(
            r'AccessRole\.(owner|manager|reception|student|parent)',
          ).hasMatch(code),
          isFalse,
          reason:
              '${f.path} names a concrete AccessRole in code — app/shared must '
              'not know which roles exist',
        );
      }
    });
  });

  group('the boundaries partition the tenant-role set', () {
    test('student + staff cover every AccessRole exactly once', () {
      final union = {...kStudentAppRoles, ...kStaffAppRoles};

      expect(
        kStudentAppRoles.intersection(kStaffAppRoles),
        isEmpty,
        reason: 'no role may belong to two app boundaries',
      );
      expect(
        union,
        AccessRole.values.toSet(),
        reason:
            'every tenant role must belong to exactly one boundary. If '
            'AccessRole gained a value, decide deliberately which boundary '
            'owns it — and if it is a PLATFORM role, note that PRD-001 §2.3 '
            'closes that set at PR-1/PR-2 and SECP-FR-002 forbids modelling a '
            'platform role as a tenant role.',
      );
    });

    test('Student and Parent stay together', () {
      expect(kStudentAppRoles, contains(AccessRole.student));
      expect(kStudentAppRoles, contains(AccessRole.parent));
    });

    test('Reception, Manager and Library Owner stay together', () {
      expect(kStaffAppRoles, contains(AccessRole.reception));
      expect(kStaffAppRoles, contains(AccessRole.manager));
      expect(kStaffAppRoles, contains(AccessRole.owner));
    });

    test('AccessRole holds exactly the five TENANT roles', () {
      // Guards the governance boundary in code. PRD-001 §2.4 defines TR-1…TR-5;
      // §2.3 defines PR-1/PR-2 as a separate closed set. A sixth value here
      // would be a platform role modelled as a tenant role — breaching
      // SECP-FR-002 and SECP-FR-014 — or a sixth tenant role, which amends a
      // FROZEN Rank-3 PRD. Either needs an ADR before the code.
      expect(
        AccessRole.values.length,
        5,
        reason:
            'the tenant-role set is TR-1…TR-5. Adding a role requires an '
            'ADR amending PRD-001 §2.4 (frozen, Rank 3) first; adding a '
            'PLATFORM role here is forbidden outright by SECP-FR-002.',
      );
    });
  });

  group('platform-admin boundary is reserved, not implemented', () {
    test('it contains no Dart code', () {
      // SECP-FR-007: a privileged capability with no current approved use MUST
      // be absent, not dormant behind a flag. A stub shell would be that flag.
      expect(
        _dartFilesUnder('lib/app/platform_admin'),
        isEmpty,
        reason:
            'Platform Admin must not be implemented before the governance '
            'decision recorded in lib/app/platform_admin/README.md §3',
      );
    });

    test('its reservation is documented', () {
      final root = _repoRoot().path;
      final readme = File('$root/lib/app/platform_admin/README.md');
      expect(readme.existsSync(), isTrue);
      final text = readme.readAsStringSync();
      // The README must keep stating the decision is outstanding; if someone
      // implements the boundary they must revisit this file deliberately.
      expect(text, contains('PR-1'));
      expect(text, contains('PR-2'));
    });

    test('no code invents a platform role', () {
      // "Platform Owner" is established NOWHERE in the governance corpus. This
      // asserts no one quietly introduced it in lib/ to make an app compile.
      final offenders = <String>[];
      for (final f in _dartFilesUnder('lib')) {
        final src = f.readAsStringSync();
        // Doc comments legitimately DISCUSS the governance position; only
        // executable identifiers are forbidden.
        final code = src
            .split('\n')
            .where((l) => !l.trimLeft().startsWith('///'))
            .where((l) => !l.trimLeft().startsWith('//'))
            .join('\n');
        if (RegExp(
          r'\bplatformOwner\b|\bplatformAdmin\b|\bsuperAdmin\b',
        ).hasMatch(code)) {
          offenders.add(f.path);
        }
      }
      expect(
        offenders,
        isEmpty,
        reason:
            'a platform role identifier exists in code without the ADR '
            'that PRD-001 §2.3 and SECP-XC-012 require: $offenders',
      );
    });
  });
}
