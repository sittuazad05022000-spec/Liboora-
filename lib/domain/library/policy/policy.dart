/// **BC-06 Library Policy** — public barrel.
///
/// Other contexts may import ONLY this file (barrel-only rule, §9.2).
library;

export 'domain/branch_policy.dart';
export 'domain/branch_display.dart';

import 'package:liboora_contracts/liboora_contracts.dart';
import 'domain/branch_display.dart';
import 'domain/branch_policy.dart';

/// Read port other contexts conform to.
abstract interface class PolicyReader {
  BranchPolicy forBranch(BranchId id);
}

/// Read port for branch **display** data, per the Architecture Owner decision
/// applying Option 1 of the `Branch` display-data package.
///
/// Separate from [PolicyReader] deliberately. That port answers *"what are
/// the operating rules of this branch?"*; this one answers *"what is this
/// branch called?"*. Collapsing them would make every rules consumer
/// (`BC-03`, `BC-04`, `BC-05` over edges `E-04`/`E-05`/`E-06`) depend on
/// presentation fields it has no use for.
///
/// ⛔ **Read-only by contract.** There is no write method here: branch
/// *lifecycle* — creation, the `LIB-9.1` one-branch rule, `Floor`, `Zone` —
/// is `PRD-002` `LIB-9`…`LIB-11` and is **NOT** implemented by this slice.
abstract interface class BranchReader {
  /// The display record for [id].
  ///
  /// Throws [DomainError] with [DomainErrorCode.notFound] when the branch is
  /// unknown, matching [PolicyReader.forBranch]. It never invents a
  /// placeholder name: a screen showing a fabricated branch label is worse
  /// than one that fails loudly.
  BranchDisplay displayFor(BranchId id);

  /// Every known branch, for a switcher. Ordering is by [BranchDisplay.name]
  /// so the UI need not sort.
  List<BranchDisplay> allDisplays();
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

/// In-memory [BranchReader], shaped on [PolicyRepository] above rather than
/// on a new pattern.
///
/// [save] is the seam the composition root uses; it is **not** on the
/// [BranchReader] port, so a consumer holding the port cannot write. That
/// asymmetry is the same one [PolicyRepository] uses and is why branch
/// *lifecycle* stays outside this slice: enforcing `LIB-9.1`'s one-branch
/// rule would require a rule this record deliberately does not carry.
final class BranchDisplayRepository implements BranchReader {
  final Map<String, BranchDisplay> _byBranch = {};

  void save(BranchDisplay b) => _byBranch[b.id.value] = b;

  @override
  BranchDisplay displayFor(BranchId id) {
    final b = _byBranch[id.value];
    if (b == null) {
      throw DomainError(
        DomainErrorCode.notFound,
        'No branch registered for ${id.value}.',
      );
    }
    return b;
  }

  @override
  List<BranchDisplay> allDisplays() {
    final all = _byBranch.values.toList();
    all.sort((a, b) => a.name.compareTo(b.name));
    return all;
  }
}
