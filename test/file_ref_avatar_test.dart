import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:liboora/app/shared/widgets/common.dart';
import 'package:liboora/platform/services/services.dart';
import 'package:liboora_contracts/liboora_contracts.dart';

void main() {
  group('E-22 file access', () {
    test('unauthorized consumer is denied before object resolution', () {
      final access = InProcessFileAccess();
      final ref = FileRef('photo-1');
      access.seed(ref);

      expect(
        () => access.resolve(const BoundedContextId('BC-11'), ref),
        throwsA(
          isA<DomainError>().having(
            (error) => error.code,
            'code',
            DomainErrorCode.forbidden,
          ),
        ),
      );
    });

    test('permitted consumer receives null for an unknown reference', () {
      final access = InProcessFileAccess();

      expect(
        access.resolve(const BoundedContextId('BC-01'), FileRef('missing')),
        isNull,
      );
    });
  });

  group('FileRefAvatar', () {
    testWidgets('renders the monogram when media resolution is unavailable',
        (tester) async {
      final access = _UnavailableFileAccess();

      await tester.pumpWidget(
        MaterialApp(
          home: FileRefAvatar(
            name: 'Ada Lovelace',
            fileRef: FileRef('photo-1'),
            fileAccess: access,
          ),
        ),
      );

      expect(find.text('AL'), findsOneWidget);
    });
  });
}

final class _UnavailableFileAccess implements FileAccess {
  @override
  bool isPermittedConsumer(BoundedContextId context) => true;

  @override
  FileRef? resolve(BoundedContextId context, FileRef ref) {
    throw const DomainError(DomainErrorCode.notFound, 'Unavailable.');
  }

  @override
  void grantRead(
    BoundedContextId context,
    FileRef ref, {
    required PersonId recipient,
    required EligibilityDecisionRef decision,
  }) {}
}
