/// E-22 file access integration tests for IMPL-309, SM-4.11 / SM-4.12.
library;

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

    test('permited consumer receives the reference for a seeded object', () {
      final access = InProcessFileAccess();
      final ref = FileRef('photo-seeded');
      access.seed(ref);

      expect(
        access.resolve(const BoundedContextId('BC-01'), ref),
        equals(ref),
      );
    });
  });

  group('FileRefAvatar', () {
    testWidgets('renders the monogram when fileRef is null', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FileRefAvatar(
              name: 'Ada Lovelace',
              fileRef: null,
              resolver: _dummyResolver,
            ),
          ),
        ),
      );

      expect(find.text('AL'), findsOneWidget);
    });

    testWidgets('renders the monogram when resolver returns null', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FileRefAvatar(
              name: 'Ada Lovelace',
              fileRef: 'photo-missing',
              resolver: _dummyResolverReturningNull,
            ),
          ),
        ),
      );

      expect(find.text('AL'), findsOneWidget);
    });

    testWidgets('renders the monogram when resolver throws', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FileRefAvatar(
              name: 'Ada Lovelace',
              fileRef: 'photo-1',
              resolver: _resolverThrowing,
            ),
          ),
        ),
      );

      expect(find.text('AL'), findsOneWidget);
    });

    testWidgets('renders resolved widget when resolver succeeds', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FileRefAvatar(
              name: 'Ada Lovelace',
              fileRef: 'photo-1',
              resolver: _resolverSucceeding,
            ),
          ),
        ),
      );

      expect(find.text('IMAGE'), findsOneWidget);
    });
  });
}

Widget _dummyResolver(String refValue) => const SizedBox.shrink();

Widget? _dummyResolverReturningNull(String refValue) => null;

Widget _resolverThrowing(String refValue) =>
    throw const DomainError(DomainErrorCode.forbidden, 'Not permitted.');

Widget _resolverSucceeding(String refValue) => const Text('IMAGE');