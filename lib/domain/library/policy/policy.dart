/// **BC-06 Library Policy** — public barrel.
///
/// Other contexts may import ONLY this file (barrel-only rule, §9.2).
library;

export 'domain/branch_policy.dart';

import 'package:liboora_contracts/liboora_contracts.dart';
import 'domain/branch_policy.dart';

/// Read port other contexts conform to.
abstract interface class PolicyReader {
  BranchPolicy forBranch(BranchId id);
}

final class PolicyRepository implements PolicyReader {
  final Map<String, BranchPolicy> _byBranch = {};

  void save(BranchPolicy p) => _byBranch[p.branchId.value] = p;

  @override
  BranchPolicy forBranch(BranchId id) {
    final p = _byBranch[id.value];
    if (p == null) {
      throw DomainError(
        DomainErrorCode.notFound,
        'No policy configured for branch ${id.value}.',
      );
    }
    return p;
  }
}
