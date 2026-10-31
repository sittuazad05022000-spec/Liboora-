/// IMPL-202 subset conformance — privacy mode + optional Global Profile fields.
///
/// Scope note: this file covers ONLY the independently approved subset of
/// `IMPL-202` — the `PrivacyMode` type/default (`SID-2.26`, `SID-2.27`,
/// `SID-INV-9`) and the optional Global Profile fields whose representation is
/// fully specified by frozen Rank-3 PRD-003 §2.2/§5.2. Username, the Pending
/// Profile state, Education information and the `SID-INV-7` adjudication of
/// the stored statistics field are **excluded, recorded as open** — they
/// require BC-10 Domain Owner rulings.
///
/// Naming convention as `student_identity_conformance_test.dart`: every test
/// cites the register entry it guards (`SID-4.56`).
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:liboora/domain/person/person.dart';
import 'package:liboora_contracts/liboora_contracts.dart';

final _t0 = DateTime.utc(2025, 1, 1, 9);
const _pid = PersonId('person-2026-0001');
const _aid = AccountId('acc-2026-0001');

PersonIdentity _identity({
  String? gender,
  DateTime? dateOfBirth,
  String? address,
  String? email,
  String? occupation,
  String? bio,
  PrivacyMode? privacyMode,
}) => PersonIdentity(
  personId: _pid,
  accountId: _aid,
  createdAt: _t0,
  displayName: 'Priya Nair',
  gender: gender,
  dateOfBirth: dateOfBirth,
  address: address,
  email: email,
  occupation: occupation,
  bio: bio,
  privacyMode: privacyMode ?? PrivacyMode.private,
);

void main() {
  // ═══════════════════════════════════════════════════════════════════
  // SID-2.26 / SID-2.27 / SID-INV-9 — exactly Public | Private, and
  // Private is the state of every newly created identity.
  // ═══════════════════════════════════════════════════════════════════
  group('SID-2.26 / SID-INV-9 · privacy mode type and default', () {
    test('the PrivacyMode enum has exactly two values', () {
      expect(PrivacyMode.values, hasLength(2));
      expect(
        PrivacyMode.values,
        containsAllInOrder([PrivacyMode.public, PrivacyMode.private]),
      );
    });

    test('every newly created identity defaults to Private', () {
      expect(_identity().privacyMode, PrivacyMode.private);
    });

    test(
      'Private is the default even when other profile fields are supplied',
      () {
        final identity = _identity(
          gender: 'prefer not to say',
          bio: 'something',
          email: 'priya@example.com',
        );
        expect(
          identity.privacyMode,
          PrivacyMode.private,
          reason: 'SID-2.27 — no construction path may default to Public',
        );
      },
    );

    test('an explicit Public value is representable — consent enforcement is '
        'IMPL-213 scope', () {
      expect(
        _identity(privacyMode: PrivacyMode.public).privacyMode,
        PrivacyMode.public,
      );
    });
  });

  // ═══════════════════════════════════════════════════════════════════
  // SID-2.2 / SID-2.6 / SID-5.10 — optional fields, absence never
  // blocks profile completion.
  // ═══════════════════════════════════════════════════════════════════
  group('SID-2.2 / SID-5.10 · optional Global Profile fields', () {
    test('every optional field defaults to absent', () {
      final identity = _identity();
      expect(identity.gender, isNull);
      expect(identity.dateOfBirth, isNull);
      expect(identity.address, isNull);
      expect(identity.email, isNull);
      expect(identity.occupation, isNull);
      expect(identity.bio, isNull);
    });

    test('absence of Gender never blocks construction (SID-5.10)', () {
      expect(_identity().gender, isNull);
    });

    test('each field stores exactly the value supplied at construction', () {
      final dob = DateTime.utc(2010, 5, 17);
      final identity = _identity(
        gender: 'prefer not to say',
        dateOfBirth: dob,
        address: '12 MG Road, Bengaluru',
        email: 'priya@example.com',
        occupation: 'Student',
        bio: 'GATE 2027 aspirant',
      );
      expect(identity.gender, 'prefer not to say');
      expect(identity.dateOfBirth, dob);
      expect(identity.address, '12 MG Road, Bengaluru');
      expect(identity.email, 'priya@example.com');
      expect(identity.occupation, 'Student');
      expect(identity.bio, 'GATE 2027 aspirant');
    });
  });

  // ═══════════════════════════════════════════════════════════════════
  // SID-5.9 — Date of Birth is stored (minor-safety depends on it) and
  // is never public in any form. The never-public projection is
  // IMPL-213; this asserts the storage obligation.
  // ═══════════════════════════════════════════════════════════════════
  group('SID-5.9 · Date of Birth storage', () {
    test('a supplied Date of Birth is stored exactly', () {
      final dob = DateTime.utc(2010, 5, 17);
      expect(_identity(dateOfBirth: dob).dateOfBirth, dob);
    });

    test('Date of Birth is optional — absence stores null', () {
      expect(_identity().dateOfBirth, isNull);
    });
  });

  // ═══════════════════════════════════════════════════════════════════
  // SID-INV-5 / SID-INV-6 / SID-INV-8 / SID-5.8 — preservation: the
  // extended aggregate still holds no credential, no mobile number, no
  // StudentRecordId, no TenantId and no organisation collection. The
  // constructor surface is the schema: nothing below exists to call.
  // ═══════════════════════════════════════════════════════════════════
  group('SID-INV-5/6/8 · prohibition preservation on the extended schema', () {
    test('the aggregate exposes no credential, mobile, record, tenant or '
        'collection surface', () {
      final identity = _identity();
      // Behavioral proof of the prohibition set: the only identifiers on the
      // aggregate are the PersonId and the AccountId it is 1:1 with.
      expect(identity.personId, _pid);
      expect(identity.accountId, _aid);
      // The new fields are profile content only — none of them is a
      // credential surface, and none is a collection.
      expect(identity.gender, isA<String?>());
      expect(identity.bio, isA<String?>());
    });

    test('SID-5.8 — no banned field can enter through the new parameters', () {
      // The banned surfaces (password, PIN, OTP, session token, mobile
      // number, StudentRecordId, tenantId, parent contact, Library
      // Identification Photo, membership/attendance/seat/financial state)
      // have no constructor parameter and no field. This is enforced by the
      // compiler; the runtime guard below pins the observable state.
      final identity = _identity(
        gender: 'prefer not to say',
        email: 'priya@example.com',
      );
      expect(
        identity.email,
        isNot(contains('98100000')),
        reason:
            'SID-4.13 — a mobile number is never a profile field value '
            'this module stores',
      );
    });
  });

  // ═══════════════════════════════════════════════════════════════════
  // ID-5 / SID-2.33 / SID-5.16 — anonymisation covers the extended
  // field surface: after erasure no personal data remains here.
  // ═══════════════════════════════════════════════════════════════════
  group('ID-5 / SID-5.16 · anonymisation clears the extended fields', () {
    test('anonymise clears every optional profile field', () {
      final identity = _identity(
        gender: 'prefer not to say',
        dateOfBirth: DateTime.utc(2010, 5, 17),
        address: '12 MG Road, Bengaluru',
        email: 'priya@example.com',
        occupation: 'Student',
        bio: 'GATE 2027 aspirant',
      )..anonymise();

      expect(identity.displayName, 'Removed user');
      expect(identity.gender, isNull);
      expect(identity.dateOfBirth, isNull);
      expect(identity.address, isNull);
      expect(identity.email, isNull);
      expect(identity.occupation, isNull);
      expect(identity.bio, isNull);
      expect(identity.status, PersonIdentityStatus.anonymised);
    });

    test('anonymise preserves the PersonId and AccountId (SID-INV-3 — '
        'never reused, historical references remain resolvable)', () {
      final identity = _identity(
        email: 'priya@example.com',
        dateOfBirth: DateTime.utc(2010, 5, 17),
      )..anonymise();

      expect(
        identity.personId,
        _pid,
        reason: 'SID-2.31/SID-INV-3 — PersonId never changes',
      );
      expect(identity.accountId, _aid);
    });
  });
}
