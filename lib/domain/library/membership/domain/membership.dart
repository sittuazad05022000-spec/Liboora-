/// **BC-02 Membership** — aggregate `Membership`.
///
/// Owns the commercial right-to-use. `MembershipPlan` here is what a library
/// sells to a *student* — not `SubscriptionPlan`, which is what Liboora sells
/// to a *library* (BC-20).
library;

import 'package:liboora_contracts/liboora_contracts.dart';

enum MembershipStatus { pending, active, frozen, expired, cancelled }

final class MembershipPlan {
  const MembershipPlan({
    required this.id,
    required this.name,
    required this.price,
    required this.durationDays,
    required this.seatQuota,
    this.freezeDaysAllowed = 7,
  });

  final String id;
  final String name;
  final Money price;
  final int durationDays;

  /// Seats *included*, distinct from `Seat` (BC-04) which is a physical
  /// position. See the ubiquitous language table.
  final int seatQuota;
  final int freezeDaysAllowed;
}

final class Membership {
  Membership({
    required this.id,
    required this.studentRecordId,
    required this.plan,
    required this.term,
    this.status = MembershipStatus.active,
    this.freezeDaysUsed = 0,
  });

  final String id;
  final StudentRecordId studentRecordId;
  final MembershipPlan plan;
  DateRange term;
  MembershipStatus status;
  int freezeDaysUsed;

  bool isValidOn(DateTime day) =>
      status == MembershipStatus.active && term.contains(day);

  int daysRemainingFrom(DateTime now) => term.daysRemainingFrom(now);

  bool expiringSoon(DateTime now, {int within = 7}) {
    final d = daysRemainingFrom(now);
    return status == MembershipStatus.active && d > 0 && d <= within;
  }

  /// Invariant: no overlapping active terms for one student.
  /// [existing] is supplied by the repository — the aggregate does not query.
  static void assertNoOverlap(List<Membership> existing, DateRange proposed) {
    for (final m in existing) {
      if (m.status == MembershipStatus.active && m.term.overlaps(proposed)) {
        throw DomainError(
          DomainErrorCode.overlappingMembershipTerm,
          'This student already has an active membership until '
          '${m.term.end.toIso8601String().substring(0, 10)}.',
          context: {'existingMembershipId': m.id},
        );
      }
    }
  }

  void renew({required int days}) {
    if (status == MembershipStatus.cancelled) {
      throw const DomainError(
        DomainErrorCode.membershipNotActive,
        'A cancelled membership cannot be renewed.',
      );
    }
    term = term.extendBy(days);
    status = MembershipStatus.active;
  }

  void freeze({required int days}) {
    if (freezeDaysUsed + days > plan.freezeDaysAllowed) {
      throw DomainError(
        DomainErrorCode.freezeAllowanceExceeded,
        'Plan allows ${plan.freezeDaysAllowed} freeze days; '
        '$freezeDaysUsed already used.',
      );
    }
    freezeDaysUsed += days;
    term = term.extendBy(days);
    status = MembershipStatus.frozen;
  }

  void unfreeze() {
    if (status == MembershipStatus.frozen) status = MembershipStatus.active;
  }

  void expire() => status = MembershipStatus.expired;

  /// Q-06: Membership computes the entitlement *delta*; the Business Platform
  /// executes the money. This method deliberately returns value, not a charge.
  Money prorationCreditFor(DateTime now) {
    final remaining = daysRemainingFrom(now);
    if (remaining <= 0) return Money.zero;
    return plan.price.prorate(remaining, plan.durationDays);
  }
}
