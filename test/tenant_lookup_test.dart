/// `IMPL-100` / `AC-70-1` / `AC-70-2` — tenant lookup safety.
///
/// Safe tenant lookup: known IDs resolve correctly; unknown IDs throw
/// DomainError.notFound and never return another tenant.  This prevents the
/// AC-70-1 failure mode where a silent default opens a cross-tenant leak.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:liboora/bootstrap/di.dart';
import 'package:liboora/bootstrap/seed.dart';
import 'package:liboora_contracts/liboora_contracts.dart';

void main() {
  group('tenantById — AC-70-1 / AC-70-2', () {
    test('known tenantId returns the correct Tenant', () async {
      final seeded = await AppContainer.boot(seeder: seedDemoData);

      final found = seeded.tenantById(kDemoTenant);
      expect(found.id, kDemoTenant);
      expect(found.name, 'Aspirants Study Hub');
    });

    test('AC-70-1: unknown tenantId throws DomainError.notFound, never '
        'returns another tenant', () async {
      final seeded = await AppContainer.boot(seeder: seedDemoData);

      expect(
        () => seeded.tenantById(const TenantId('not_a_real_id')),
        throwsA(
          isA<DomainError>()
              .having((e) => e.code, 'code', DomainErrorCode.notFound)
              .having(
                (e) => e.message,
                'message',
                contains('not_a_real_id'),
              ),
        ),
      );
    });

    test('AC-70-2: tenantById does not return a different tenant for an '
        'unknown id', () async {
      final seeded = await AppContainer.boot(seeder: seedDemoData);
      final firstTenantBefore = seeded.tenants.first;

      try {
        seeded.tenantById(const TenantId('unknown_tenant'));
        fail('Expected DomainError.notFound');
      } on DomainError {
        final firstTenantAfter = seeded.tenants.first;
        expect(firstTenantAfter.id, firstTenantBefore.id);
        expect(firstTenantAfter.name, firstTenantBefore.name);
      }
    });
  });
}
