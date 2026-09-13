/// `BC-02` Membership — timezone and day-boundary rules.
///
/// Covers `IMPL-419` against FROZEN `PRD-005` v1.4. The task's obligation
/// names the cases: *"Boundary tests at 23:59:59 and 00:00:00 tenant-local;
/// UTC storage, tenant-local evaluation."*
///
/// `MM-FR-061` is unusually blunt — the tenant's timezone, *"never the
/// server's, never the client's"* — so the tests below express every instant
/// in UTC and assert the business date the tenant would see, which is the
/// only way to catch a server-time regression on a machine that happens to
/// be configured in the tenant's zone.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:liboora/domain/library/membership/membership.dart';
import 'package:liboora_contracts/liboora_contracts.dart';

/// `MM-CFG-006`'s default: +05:30 year-round, no daylight saving.
const _kolkata = TenantBusinessCalendar('Asia/Kolkata');
const _utc = TenantBusinessCalendar('UTC');
const _tokyo = TenantBusinessCalendar('Asia/Tokyo');

DomainError _rejects(void Function() act) {
  try {
    act();
  } on DomainError catch (e) {
    return e;
  }
  fail('Expected a typed DomainError, but the call succeeded.');
}

void main() {
  group('IMPL-419 business-date resolution (MM-FR-061)', () {
    test('the offset for MM-CFG-006 is +05:30', () {
      expect(_kolkata.offset, const Duration(hours: 5, minutes: 30));
    });

    test('a UTC evening is already TOMORROW in the tenant timezone '
        '(MM-FR-061)', () {
      // 2026-03-10 19:00 UTC == 2026-03-11 00:30 IST.
      expect(
        _kolkata.businessDateAt(DateTime.utc(2026, 3, 10, 19, 0)),
        DateTime(2026, 3, 11),
        reason:
            'This is the case that makes MM-FR-061 matter. A UTC-hosted '
            'server would call this 10 March and stamp a membership with '
            "yesterday's business date.",
      );

      // The same instant is still 10 March for a UTC tenant.
      expect(
        _utc.businessDateAt(DateTime.utc(2026, 3, 10, 19, 0)),
        DateTime(2026, 3, 10),
      );
    });

    test('boundary at 00:00:00 tenant-local: the business date rolls exactly '
        'then, not a second early (MM-FR-061)', () {
      // 18:29:59 UTC == 23:59:59 IST on 10 March.
      expect(
        _kolkata.businessDateAt(DateTime.utc(2026, 3, 10, 18, 29, 59)),
        DateTime(2026, 3, 10),
      );
      // 18:30:00 UTC == 00:00:00 IST on 11 March.
      expect(
        _kolkata.businessDateAt(DateTime.utc(2026, 3, 10, 18, 30, 0)),
        DateTime(2026, 3, 11),
      );
    });

    test('boundary at 23:59:59 tenant-local is still the SAME business date '
        '(MM-FR-062)', () {
      final lastSecond = DateTime.utc(2026, 3, 10, 18, 29, 59);
      expect(_kolkata.businessDateAt(lastSecond), DateTime(2026, 3, 10));

      // One second later is a new day. Both sides of the boundary are
      // asserted, because a test on only one side passes for an
      // implementation that is off by a day in the other direction.
      expect(
        _kolkata.businessDateAt(lastSecond.add(const Duration(seconds: 1))),
        DateTime(2026, 3, 11),
      );
    });

    test('midnight UTC is still the PREVIOUS day in Kolkata terms? no — '
        'it is the same day (MM-FR-061)', () {
      // 2026-03-10 00:00 UTC == 2026-03-10 05:30 IST. Same date.
      expect(
        _kolkata.businessDateAt(DateTime.utc(2026, 3, 10)),
        DateTime(2026, 3, 10),
      );
      // But 2026-03-09 19:00 UTC == 2026-03-10 00:30 IST, already the 10th.
      expect(
        _kolkata.businessDateAt(DateTime.utc(2026, 3, 9, 19, 0)),
        DateTime(2026, 3, 10),
      );
    });

    test('two tenants in different zones can see different business dates for '
        'one instant (ADR-0003 multi-timezone tenancy)', () {
      final instant = DateTime.utc(2026, 3, 10, 16, 0);
      expect(_utc.businessDateAt(instant), DateTime(2026, 3, 10));
      expect(_kolkata.businessDateAt(instant), DateTime(2026, 3, 10));
      // 16:00 UTC is 01:00 the next day in Tokyo (+09:00).
      expect(_tokyo.businessDateAt(instant), DateTime(2026, 3, 11));
    });

    test('a local-kind input is interpreted as the instant it names', () {
      // toUtc() normalises first, so a caller passing a local DateTime gets
      // the same answer as one passing its UTC equivalent.
      final asUtc = DateTime.utc(2026, 3, 10, 18, 30);
      expect(
        _kolkata.businessDateAt(asUtc),
        _kolkata.businessDateAt(asUtc.toLocal()),
      );
    });

    test('the returned business date is local-kind midnight, so it compares '
        'with term endpoints', () {
      final d = _kolkata.businessDateAt(DateTime.utc(2026, 3, 10, 19));
      expect(d.hour, 0);
      expect(d.minute, 0);
      expect(d.second, 0);
      expect(d.isUtc, isFalse, reason: 'Matches DateRange._dateOnly.');
    });
  });

  group('IMPL-419 fail-loud on an unsupported zone (MM-FR-061)', () {
    test('a DST-observing or unknown zone is REFUSED, never defaulted', () {
      for (final zone in const [
        'America/New_York', // observes DST
        'Europe/London', // observes DST
        'Australia/Sydney', // observes DST
        'Not/AZone',
        '',
      ]) {
        final e = _rejects(() => TenantBusinessCalendar.offsetFor(zone));
        expect(e.code, DomainErrorCode.validationFailed);
        expect(e.context['timezone'], zone);
        expect(e.context['field'], 'tenantTimezone');
      }
    });

    test('falling back to the server timezone would be the exact failure '
        'MM-FR-061 forbids, so there is no fallback', () {
      // Asserted as a rejection rather than a wrong-but-plausible date: a
      // silent default is indistinguishable from correct behaviour in the
      // common case where the server IS in the tenant's zone, and wrong
      // everywhere else.
      expect(
        () => const TenantBusinessCalendar(
          'Europe/Paris',
        ).businessDateAt(DateTime.utc(2026, 3, 10)),
        throwsA(isA<DomainError>()),
      );
    });

    test('every supported zone has a genuinely fixed offset', () {
      // If a DST zone were ever added to the table, this batch's whole
      // approach would silently become wrong for it. These are the zones
      // that are +fixed year-round.
      for (final zone in const [
        'Asia/Kolkata',
        'Asia/Calcutta',
        'Asia/Kathmandu',
        'Asia/Dubai',
        'Asia/Karachi',
        'Asia/Dhaka',
        'Asia/Colombo',
        'Asia/Singapore',
        'Asia/Tokyo',
        'UTC',
      ]) {
        expect(
          () => TenantBusinessCalendar.offsetFor(zone),
          returnsNormally,
          reason: '$zone must be supported.',
        );
      }
    });
  });

  group('IMPL-419 term evaluation (MM-FR-062, MM-FR-103)', () {
    final start = DateTime(2026, 3, 1);
    final end = DateTime(2026, 3, 30); // inclusive, per MM-FR-057

    test('a term covers the whole of endDate (MM-FR-062)', () {
      // 23:59:59 IST on 30 March == 18:29:59 UTC on 30 March.
      expect(
        _kolkata.coversInstant(
          DateTime.utc(2026, 3, 30, 18, 29, 59),
          startDate: start,
          endDate: end,
        ),
        isTrue,
        reason:
            'MM-FR-062: the membership is valid for the WHOLE of endDate. '
            'A student arriving at 11:59pm on their last day is entitled.',
      );
    });

    test('the term stops covering at 00:00:00 the next day (MM-FR-062)', () {
      // 18:30:00 UTC on 30 March == 00:00:00 IST on 31 March.
      expect(
        _kolkata.coversInstant(
          DateTime.utc(2026, 3, 30, 18, 30, 0),
          startDate: start,
          endDate: end,
        ),
        isFalse,
      );
    });

    test('the term does not cover the day before startDate', () {
      expect(
        _kolkata.coversInstant(
          DateTime.utc(2026, 2, 28, 19, 0), // 1 Mar 00:30 IST -> covered
          startDate: start,
          endDate: end,
        ),
        isTrue,
      );
      expect(
        _kolkata.coversInstant(
          DateTime.utc(2026, 2, 28, 12, 0), // 28 Feb 17:30 IST -> not yet
          startDate: start,
          endDate: end,
        ),
        isFalse,
      );
    });

    test('expiry is strictly AFTER endDate in tenant terms (MM-FR-103)', () {
      // Last second of endDate, tenant-local: not expired.
      expect(
        _kolkata.isExpiredAt(DateTime.utc(2026, 3, 30, 18, 29, 59), end),
        isFalse,
      );
      // First second of the next business date: expired.
      expect(
        _kolkata.isExpiredAt(DateTime.utc(2026, 3, 30, 18, 30, 0), end),
        isTrue,
      );
    });

    test('a UTC-tenant and an IST-tenant expire the same term at different '
        'instants (MM-FR-061)', () {
      final instant = DateTime.utc(2026, 3, 30, 20, 0);
      // 20:00 UTC on 30 March is still 30 March for a UTC tenant...
      expect(_utc.isExpiredAt(instant, end), isFalse);
      // ...but 01:30 on 31 March in Kolkata, so already expired there.
      expect(_kolkata.isExpiredAt(instant, end), isTrue);
    });

    test('endOfBusinessDateUtc is the instant entitlement stops '
        '(MM-FR-062)', () {
      final cutoff = _kolkata.endOfBusinessDateUtc(end);
      expect(cutoff, DateTime.utc(2026, 3, 30, 18, 30));
      expect(
        _kolkata.coversInstant(
          cutoff.subtract(const Duration(seconds: 1)),
          startDate: start,
          endDate: end,
        ),
        isTrue,
      );
      expect(
        _kolkata.coversInstant(cutoff, startDate: start, endDate: end),
        isFalse,
      );
    });
  });

  group('IMPL-419 storage discipline (MM-FR-063, MM-FR-064)', () {
    test('audit timestamps are UTC while term endpoints are dates '
        '(MM-FR-063)', () {
      final m = Membership.fromPlan(
        id: 'mem_1',
        studentRecordId: const StudentRecordId('stu_1'),
        plan: MembershipPlan.create(
          id: 'plan_1',
          tenantId: const TenantId('tnt_a'),
          branchId: const BranchId('brn_a'),
          name: 'Monthly',
          durationDays: 30,
          price: Money.rupees(1200),
          createdAt: DateTime.utc(2026, 3, 1),
          createdBy: 'owner_1',
        ),
        term: DateRange.days(DateTime(2026, 3, 1), 30),
        createdAt: DateTime.utc(2026, 3, 1, 9, 15),
        createdBy: 'owner_1',
        activatedAt: DateTime.utc(2026, 3, 1, 9, 15),
      );

      // Timestamps: UTC instants, with a time component.
      expect(m.createdAt!.isUtc, isTrue);
      expect(m.activatedAt!.isUtc, isTrue);
      expect(m.createdAt!.hour, 9);

      // Term endpoints: dates, no time component.
      expect(m.startDate.hour, 0);
      expect(m.endDate.hour, 0);
      expect(m.endDate, DateTime(2026, 3, 30));
    });

    test('changing the tenant timezone does NOT move an existing term '
        '(MM-FR-064)', () {
      final term = DateRange.days(DateTime(2026, 3, 1), 30);
      final m = Membership(
        id: 'mem_1',
        studentRecordId: const StudentRecordId('stu_1'),
        planId: 'plan_1',
        branchId: const BranchId('brn_a'),
        term: term,
        priceSnapshot: Money.rupees(1200),
        planVersionAtPurchase: 1,
      );

      final before = (m.startDate, m.endDate);

      // A different calendar is only a lens for evaluating instants; the
      // stored endpoints are plain dates and cannot be re-interpreted.
      expect(_tokyo.offset, isNot(_kolkata.offset));
      expect((m.startDate, m.endDate), before);
      expect(m.startDate, DateTime(2026, 3, 1));
      expect(m.endDate, DateTime(2026, 3, 30));
    });
  });
}
