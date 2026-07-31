/// **BC-05 Fee & Collection** — public barrel.
library;

export 'domain/fee_ledger.dart';

import 'package:liboora_contracts/liboora_contracts.dart';

import '../../../platform/audit/audit.dart';
import '../../../platform/data/data.dart';
import '../../../platform/event/event.dart';
import '../../../platform/identity/identity.dart';
import '../../../platform/services/services.dart';
import 'domain/fee_ledger.dart';

abstract interface class FeeLedgerRepository {
  FeeLedger? forStudent(StudentRecordId id);
  FeeLedger openFor(StudentRecordId id);
  List<FeeLedger> all();
  void save(FeeLedger ledger);
}

final class InMemoryFeeLedgerRepository implements FeeLedgerRepository {
  InMemoryFeeLedgerRepository(this._store);
  final TenantPartitionedStore<FeeLedger> _store;

  @override
  FeeLedger? forStudent(StudentRecordId id) => _store.get(id.value);

  @override
  FeeLedger openFor(StudentRecordId id) {
    final existing = _store.get(id.value);
    if (existing != null) return existing;
    final ledger = FeeLedger(studentRecordId: id);
    _store.put(id.value, ledger);
    return ledger;
  }

  @override
  List<FeeLedger> all() => _store.all();

  @override
  void save(FeeLedger ledger) =>
      _store.put(ledger.studentRecordId.value, ledger);
}

/// Published read model consumed by Enrollment before archival (edge E-06)
/// and by the dashboards. Enrollment must NOT reach into the ledger itself.
final class OutstandingBalanceService {
  OutstandingBalanceService(this._repo);
  final FeeLedgerRepository _repo;

  Money forStudent(StudentRecordId id) =>
      _repo.forStudent(id)?.balance ?? Money.zero;

  bool hasOpenDues(StudentRecordId id) => forStudent(id).isPositive;
}

/// Use case: raise a fee against a student.
final class RaiseFeeDue {
  RaiseFeeDue({
    required this.repo,
    required this.events,
    required this.clock,
    required this.ids,
    required this.tenant,
    required this.pdp,
  });

  final FeeLedgerRepository repo;
  final EventBus events;
  final Clock clock;
  final IdGenerator ids;
  final TenantContext tenant;
  final PolicyDecisionPoint pdp;

  Future<FeeDue> call({
    required AccessRole actorRole,
    required StudentRecordId studentId,
    required String description,
    required Money amount,
    FeeCategory category = FeeCategory.membership,
    int dueInDays = 7,
    String? sourceRef,
  }) async {
    pdp.require(actorRole, Permission.collectFee);

    final today = clock.today();
    final ledger = repo.openFor(studentId);
    final due = FeeDue(
      id: ids.next('due'),
      description: description,
      amount: amount,
      raisedOn: today,
      dueOn: today.add(Duration(days: dueInDays)),
      category: category,
      sourceRef: sourceRef,
    );
    ledger.raiseDue(due);
    repo.save(ledger);

    events.enqueue([
      DomainEvent(
        eventId: ids.next('evt'),
        eventType: 'fee.FeeDueRaised',
        tenantId: tenant.tenantId,
        aggregateId: studentId.value,
        occurredAt: clock.now(),
        actorId: tenant.actorId,
        correlationId: tenant.correlationId,
        payload: {
          'studentRecordId': studentId.value,
          'dueId': due.id,
          'amountMinor': amount.minorUnits,
          'category': category.name,
          'dueOn': due.dueOn.toIso8601String(),
        },
      ),
    ]);
    await events.drain();
    return due;
  }
}

/// Use case: collect a payment.
///
/// Idempotent by construction. Charging a student twice because the network
/// hiccupped is the single most trust-destroying bug this product can ship,
/// so the guard sits before the aggregate, not in the UI.
final class CollectFee {
  CollectFee({
    required this.repo,
    required this.idempotency,
    required this.audit,
    required this.events,
    required this.clock,
    required this.ids,
    required this.tenant,
    required this.pdp,
  });

  final FeeLedgerRepository repo;
  final IdempotencyService idempotency;
  final AuditTrail audit;
  final EventBus events;
  final Clock clock;
  final IdGenerator ids;
  final TenantContext tenant;
  final PolicyDecisionPoint pdp;

  Future<({Receipt receipt, bool duplicate})> call({
    required AccessRole actorRole,
    required StudentRecordId studentId,
    required Money amount,
    PaymentMode mode = PaymentMode.upi,
    String? againstDueId,
    String? note,
    IdempotencyKey? key,
  }) async {
    pdp.require(actorRole, Permission.collectFee);

    final idem = key ?? IdempotencyKey(ids.next('pay'));
    final prior = idempotency.recall<Receipt>(idem);
    if (prior != null) return (receipt: prior, duplicate: true);

    final now = clock.now();
    final ledger = repo.openFor(studentId);

    final receipt = Receipt(
      id: ids.next('rcpt'),
      receiptNumber:
          'RCP-${now.year}-${(ledger.receipts.length + 1).toString().padLeft(4, '0')}',
      amount: amount,
      mode: mode,
      receivedOn: now,
      collectedBy: tenant.actorId ?? 'system',
      againstDueId: againstDueId,
      note: note,
    );

    ledger.recordReceipt(receipt);
    repo.save(ledger);
    idempotency.remember(idem, receipt);

    audit.append(
      tenantId: tenant.tenantId,
      actor: tenant.actorId ?? 'system',
      action: 'fee.collect',
      target: studentId.value,
      at: now,
      detail: {
        'receiptNumber': receipt.receiptNumber,
        'amountMinor': amount.minorUnits,
        'mode': mode.name,
      },
    );

    events.enqueue([
      DomainEvent(
        eventId: ids.next('evt'),
        eventType: 'fee.FeePaymentReceived',
        tenantId: tenant.tenantId,
        aggregateId: studentId.value,
        occurredAt: now,
        actorId: tenant.actorId,
        correlationId: tenant.correlationId,
        payload: {
          'studentRecordId': studentId.value,
          'receiptNumber': receipt.receiptNumber,
          'amountMinor': amount.minorUnits,
          'mode': mode.name,
          'balanceAfterMinor': ledger.balance.minorUnits,
        },
      ),
    ]);
    await events.drain();
    return (receipt: receipt, duplicate: false);
  }
}
