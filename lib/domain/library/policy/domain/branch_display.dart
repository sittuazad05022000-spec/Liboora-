/// **BC-06 Library Policy** — the branch display record.
///
/// Created by the Architecture Owner decision applying **Option 1** of the
/// `Branch` display-data decision package, which resolved code defect
/// **`D-013-01`** (`ADR-0050` §3.1).
library;

import 'package:liboora_contracts/liboora_contracts.dart';

/// The minimum identifying facts about a physical branch: who it is and where
/// it is.
///
/// **Why this exists at all.** A `Branch` class carrying `name` and `address`
/// lived in `platform/tenancy` from commit `a44ebb0` until `IMPL-801`. That
/// was defect `D-013-01`: Bounded Context Map **L210** assigns `Branch` to
/// **BC-06**, `PRD-002` **L56** defines it, and `TEN-FR-003` forbids BC-19
/// owning any tenant-facing business record beyond `Tenant`. `ADR-0050` §3.1
/// held that ownership *"is not in doubt"* and that moving the type is a
/// Stage-8 code act. This is that move.
///
/// **What this is NOT — and the distinction is load-bearing.**
///
///  * ⛔ **Not an aggregate root.** BC-06's aggregate is `BranchPolicy`
///    (Bounded Context Map §8 **L375**). This is a read/display record with
///    no invariant of its own and no lifecycle method.
///  * ⛔ **Not the `PRD-002` branch registry.** `LIB-9.1` (*"A V1 library
///    MUST have exactly one `Branch`. Creating a second MUST be refused"*),
///    `LIB-10` (`Floor`) and `LIB-11` (`Zone`) are **16 requirements that
///    remain unimplemented**. This slice enforces none of them and claims
///    none of them. A future act implementing `LIB-9`…`LIB-11` may absorb or
///    replace this record; it is deliberately small enough to make that
///    cheap.
///  * ⛔ **No `Floor` and no `Zone`.** Explicitly excluded by the decision.
///  * ⛔ **Not an R0 contract.** `Branch` was *not* promoted to
///    `liboora_contracts`: that package holds identifiers and generic value
///    objects (`Money`, `DateRange`) and **zero** bounded-context business
///    records. Putting a BC-06 record there would make ownership a comment
///    rather than a boundary.
///
/// ⭐ **`BranchId` is untouched** and still the rank-0 contract whose own doc
/// comment already reads *"Owned by BC-06 Library Policy"* — so this record
/// changes nothing about identity, partitioning or persistence keys.
final class BranchDisplay {
  const BranchDisplay({
    required this.id,
    required this.name,
    required this.address,
  });

  /// The rank-0 identifier. Unchanged by this act.
  final BranchId id;

  /// Human-readable branch name, e.g. shown beside a role in an app bar.
  final String name;

  /// Postal address, shown in the branch switcher.
  final String address;
}
