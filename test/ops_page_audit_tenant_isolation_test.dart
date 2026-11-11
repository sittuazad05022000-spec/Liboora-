/// `IMPL-103` V1-B1 — OpsPage audit tenant isolation hotfix.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:liboora/platform/audit/audit.dart';
import 'package:liboora_contracts/liboora_contracts.dart';

final DateTime _now = DateTime.utc(2026, 3, 10, 4, 0);

final class _SeqIds implements IdGenerator {
  _SeqIds(this._prefix);
  final String _prefix;
  int _n = 0;
  @override
  String next([String prefix = 'id']) => '${prefix}_${_prefix}_${++_n}';
}

void main() {
  group('OpsPage V1-B1 — audit data tenant isolation', () {
    test('forTenant returns only entries for that tenant', () {
      final auditA = AuditTrail(_SeqIds('ta'));
      final auditB = AuditTrail(_SeqIds('tb'));

      auditA.append(
        tenantId: TenantId('tnt_a'),
        actor: 'owner_a',
        action: 'membership.MembershipCreated',
        target: 'mem_a1',
        at: _now,
      );
      auditB.append(
        tenantId: TenantId('tnt_b'),
        actor: 'owner_b',
        action: 'membership.MembershipCreated',
        target: 'mem_b1',
        at: _now,
      );
      auditB.append(
        tenantId: TenantId('tnt_b'),
        actor: 'owner_b',
        action: 'membership.MembershipActivated',
        target: 'mem_b2',
        at: _now.add(const Duration(minutes: 1)),
      );

      final entriesA = auditA.forTenant(TenantId('tnt_a'));
      final entriesB = auditA.forTenant(TenantId('tnt_b'));

      expect(entriesA.map((e) => e.action).toList(),
          ['membership.MembershipCreated']);
      expect(entriesB.map((e) => e.action).toList(),
          ['membership.MembershipCreated', 'membership.MembershipActivated']);
    });

    test('forTenant count reflects only that tenant', () {
      final auditA = AuditTrail(_SeqIds('ta'));
      final auditB = AuditTrail(_SeqIds('tb'));

      for (int i = 0; i < 3; i++) {
        auditA.append(
          tenantId: TenantId('tnt_a'),
          actor: 'owner_a',
          action: 'membership.MembershipCreated',
          target: 'mem_a$i',
          at: _now,
        );
      }
      for (int i = 0; i < 5; i++) {
        auditB.append(
          tenantId: TenantId('tnt_b'),
          actor: 'owner_b',
          action: 'membership.MembershipCreated',
          target: 'mem_b$i',
          at: _now,
        );
      }

      expect(auditA.forTenant(TenantId('tnt_a')).length, 3);
      expect(auditA.forTenant(TenantId('tnt_b')).length, 5);
    });

    test('most recent 8 entries in descending order', () {
      final audit = AuditTrail(_SeqIds('t'));
      for (int i = 0; i < 12; i++) {
        audit.append(
          tenantId: TenantId('tnt_a'),
          actor: 'owner_1',
          action: 'membership.Event$i',
          target: 'mem_$i',
          at: _now.add(Duration(minutes: i)),
        );
      }

      final recent = audit
          .forTenant(TenantId('tnt_a'))
          .reversed
          .take(8)
          .toList();

      expect(recent.length, 8);
      expect(recent.first.action, 'membership.Event11');
      expect(recent.last.action, 'membership.Event4');
    });
  });
}
