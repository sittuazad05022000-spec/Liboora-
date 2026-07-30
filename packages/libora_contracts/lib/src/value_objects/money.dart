/// LIBORA Shared Kernel (R0) — Money.
library;

/// Money stored in minor units (paise) to eliminate floating-point drift.
///
/// Used by BC-05 Fee & Collection (`FeePayment`) and BC-20 Subscription &
/// Billing (`SubscriptionCharge`). These are two different money *domains*
/// (context map §5) but they share this one arithmetic primitive.
final class Money implements Comparable<Money> {
  const Money._(this.minorUnits, this.currency);

  /// Construct from whole rupees.
  factory Money.rupees(num amount) =>
      Money._((amount * 100).round(), 'INR');

  /// Construct from paise.
  factory Money.paise(int minorUnits) => Money._(minorUnits, 'INR');

  static const Money zero = Money._(0, 'INR');

  final int minorUnits;
  final String currency;

  bool get isZero => minorUnits == 0;
  bool get isPositive => minorUnits > 0;
  bool get isNegative => minorUnits < 0;

  double get asDouble => minorUnits / 100;

  Money operator +(Money other) {
    _assertSameCurrency(other);
    return Money._(minorUnits + other.minorUnits, currency);
  }

  Money operator -(Money other) {
    _assertSameCurrency(other);
    return Money._(minorUnits - other.minorUnits, currency);
  }

  Money operator *(num factor) =>
      Money._((minorUnits * factor).round(), currency);

  Money get abs => Money._(minorUnits.abs(), currency);

  /// Pro-rate this amount by [numerator]/[denominator].
  ///
  /// Used by BC-02 Membership proration (open question Q-06: Membership
  /// computes the entitlement delta, Business Platform executes the money).
  Money prorate(int numerator, int denominator) {
    if (denominator == 0) return Money.zero;
    return Money._((minorUnits * numerator / denominator).round(), currency);
  }

  void _assertSameCurrency(Money other) {
    if (other.currency != currency) {
      throw ArgumentError(
        'Currency mismatch: $currency vs ${other.currency}. '
        'Cross-currency arithmetic is not permitted in the shared kernel.',
      );
    }
  }

  /// Indian formatting with lakh/crore grouping.
  String get formatted {
    final whole = (minorUnits.abs() ~/ 100).toString();
    final paise = (minorUnits.abs() % 100).toString().padLeft(2, '0');
    final sign = isNegative ? '-' : '';

    String grouped;
    if (whole.length <= 3) {
      grouped = whole;
    } else {
      final last3 = whole.substring(whole.length - 3);
      var rest = whole.substring(0, whole.length - 3);
      final parts = <String>[];
      while (rest.length > 2) {
        parts.insert(0, rest.substring(rest.length - 2));
        rest = rest.substring(0, rest.length - 2);
      }
      if (rest.isNotEmpty) parts.insert(0, rest);
      grouped = '${parts.join(',')},$last3';
    }
    return '$sign₹$grouped.$paise';
  }

  /// Compact display without paise, for dashboard tiles.
  String get compact {
    final v = minorUnits.abs() ~/ 100;
    final sign = isNegative ? '-' : '';
    if (v >= 10000000) return '$sign₹${(v / 10000000).toStringAsFixed(2)}Cr';
    if (v >= 100000) return '$sign₹${(v / 100000).toStringAsFixed(2)}L';
    if (v >= 1000) return '$sign₹${(v / 1000).toStringAsFixed(1)}K';
    return '$sign₹$v';
  }

  @override
  int compareTo(Money other) {
    _assertSameCurrency(other);
    return minorUnits.compareTo(other.minorUnits);
  }

  bool operator >(Money other) => compareTo(other) > 0;
  bool operator <(Money other) => compareTo(other) < 0;
  bool operator >=(Money other) => compareTo(other) >= 0;
  bool operator <=(Money other) => compareTo(other) <= 0;

  @override
  String toString() => formatted;

  @override
  bool operator ==(Object other) =>
      other is Money &&
      other.minorUnits == minorUnits &&
      other.currency == currency;

  @override
  int get hashCode => Object.hash(minorUnits, currency);
}
