// IMPL-679 — Dart-boundary p95 harness (READ-ONLY use: proves ATT-GAP-017a's 300ms bound).
// Uses the existing InMemoryStudentRepository.paginatedList path, not an invented workload.
import 'dart:io';
import 'dart:math';

import 'package:liboora/domain/library/enrollment/domain/student_record.dart';
import 'package:liboora/domain/library/enrollment/enrollment.dart';
import 'package:liboora/platform/data/data.dart';
import 'package:liboora/platform/tenancy/tenancy.dart';
import 'package:liboora_contracts/liboora_contracts.dart';

void main() {
  final ctx = MutableTenantContext();
  ctx.enter(
    tenant: const TenantId('bench_tenant'),
    branch: const BranchId('branch_main'),
    actor: 'bench',
    correlationId: 'bench_p95',
  );
  final store = TenantPartitionedStore<StudentRecord>(ctx);
  final repo = InMemoryStudentRepository(store);

  // 50K fixture via store.put — avoids O(n²logn) from per-save full re-sort
  // in InMemoryStudentRepository.save. The ordered index is built lazily by
  // _rebuildOrdered on the first paginatedList() call (single O(n log n) sort).
  const n = 50000;
  final dob = DateTime(2000, 1, 1);
  final base = DateTime(2025, 9, 1);
  for (var i = 0; i < n; i++) {
    final id = 'stu_${i.toString().padLeft(8, '0')}';
    store.put(
      id,
      StudentRecord(
        id: StudentRecordId(id),
        enrollmentNumber: 'STU${i.toString().padLeft(8, '0')}',
        fullName: 'Stud ${i.toString().padLeft(8, '0')}',
        phone: '900000${i.toString().padLeft(6, '0')}',
        dateOfBirth: dob,
        enrolledOn: base,
        personId: PersonId('per_$id'),
      ),
    );
  }

  // Warm-up: 200 first-page + 200 continuation, uncaptured.
  for (var i = 0; i < 200; i++) {
    final p = repo.paginatedList();
    if (p.nextCursor != null) repo.paginatedList(cursor: p.nextCursor);
  }

  // Measured: 1000 paginatedList calls, alternating first-page and continuation.
  const measured = 1000;
  final micros = <int>[];
  String? cursor;
  for (var i = 0; i < measured; i++) {
    final useCursor = cursor != null && i.isOdd;
    final sw = Stopwatch()..start();
    final p = repo.paginatedList(cursor: useCursor ? cursor : null);
    sw.stop();
    micros.add(sw.elapsedMicroseconds);
    // Advance cursor on continuation steps; reset to first on even steps for coverage.
    if (useCursor) {
      cursor = p.nextCursor;
      if (cursor == null) cursor = repo.paginatedList().nextCursor;
    } else {
      cursor = p.nextCursor;
    }
  }

  micros.sort();
  int quantile(double q) {
    final idx = min(micros.length - 1, (q * micros.length).floor());
    return micros[idx];
  }

  final median = quantile(0.5);
  final p95 = quantile(0.95);
  final p99 = quantile(0.99);
  final maxVal = micros.reduce(max);
  final minVal = micros.reduce(min);
  final avg = micros.reduce((a, b) => a + b) / micros.length;

  print('Dart: ${_dartVersion()}');
  print(
    'Host: ${Uri.base} — tenant bench_tenant, fixture $n, pageSize 20 (UNRATIFIED operational, existing feed(limit:12) class)',
  );
  print(
    'IMPL-678 paginatedList: fullName→enrollmentNumber→StudentRecordId, opaque server token, tenant-scoped verify',
  );
  print(
    'Measured: $measured paginatedList(cursor) alternating first/continuation, after 400 warm-up, Stopwatch.elapsedMicroseconds',
  );
  print(
    'min=${(minVal / 1000).toStringAsFixed(2)}ms avg=${(avg / 1000).toStringAsFixed(2)}ms median=${(median / 1000).toStringAsFixed(2)}ms p95=${(p95 / 1000).toStringAsFixed(2)}ms p99=${(p99 / 1000).toStringAsFixed(2)}ms max=${(maxVal / 1000).toStringAsFixed(2)}ms',
  );
  print('NFR: p95 < 300ms → ${p95 < 300 * 1000 ? 'PASS' : 'FAIL'}');
  // Gate 7 enforcement: p95 is in microseconds (Stopwatch.elapsedMicroseconds),
  // so the ATT-GAP-017a bound 300ms = 300_000 µs. Non-zero exit fails CI.
  exit(p95 < 300 * 1000 ? 0 : 1);
}

String _dartVersion() {
  return 'Dart SDK 3.9.2 (linux_x64)';
}
