/// OTP sign-in.
///
/// Two steps, one screen. The OTP is displayed on screen because no SMS
/// gateway is wired into the scaffold — the *port* is real, the adapter is a
/// stub. When the Integration Platform lands, this hint disappears and nothing
/// else changes.
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../session.dart';
import '../theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phone = TextEditingController();
  final _code = TextEditingController();
  bool _otpSent = false;

  @override
  void dispose() {
    _phone.dispose();
    _code.dispose();
    super.dispose();
  }

  void _send() {
    final s = context.read<SessionController>();
    if (s.requestOtp(_phone.text)) {
      setState(() => _otpSent = true);
      _code.text = s.otpHint ?? '';
    }
  }

  void _verify() {
    final s = context.read<SessionController>();
    s.verifyOtp(phone: _phone.text, code: _code.text);
  }

  void _useAccount(String phone) {
    _phone.text = phone;
    _send();
  }

  @override
  Widget build(BuildContext context) {
    final s = context.watch<SessionController>();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [LiblColors.brandDark, LiblColors.brand, Color(0xFF3C51B5)],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, box) => SingleChildScrollView(
              padding: const EdgeInsets.all(LiblSpace.xl),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: box.maxHeight - LiblSpace.xl * 2,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const _Brand(),
                    const SizedBox(height: LiblSpace.xxl),
                    _card(s),
                    const SizedBox(height: LiblSpace.lg),
                    _seededAccounts(),
                    const SizedBox(height: LiblSpace.lg),
                    const Text(
                      'Liboora · multi-tenant library platform',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 11, color: Colors.white54),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _card(SessionController s) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(LiblSpace.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              _otpSent ? 'Enter the 6-digit code' : 'Sign in',
              style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: LiblSpace.xs),
            Text(
              _otpSent
                  ? 'Sent to +91 ${_phone.text}'
                  : 'Use your registered mobile number',
              style: const TextStyle(
                fontSize: 12.5,
                color: LiblColors.textMuted,
              ),
            ),
            const SizedBox(height: LiblSpace.xl),
            if (!_otpSent)
              TextField(
                controller: _phone,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onSubmitted: (_) => _send(),
                decoration: const InputDecoration(
                  labelText: 'Mobile number',
                  prefixText: '+91  ',
                  counterText: '',
                  prefixIcon: Icon(Icons.phone_outlined, size: 20),
                ),
              )
            else
              TextField(
                controller: _code,
                keyboardType: TextInputType.number,
                maxLength: 6,
                autofocus: true,
                textAlign: TextAlign.center,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onSubmitted: (_) => _verify(),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 10,
                ),
                decoration: const InputDecoration(counterText: ''),
              ),
            if (s.error != null) ...[
              const SizedBox(height: LiblSpace.md),
              Row(
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 15,
                    color: LiblColors.danger,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      s.error!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: LiblColors.danger,
                      ),
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: LiblSpace.lg),
            FilledButton(
              onPressed: _otpSent ? _verify : _send,
              child: Text(_otpSent ? 'Verify & continue' : 'Send OTP'),
            ),
            if (_otpSent) ...[
              const SizedBox(height: LiblSpace.sm),
              TextButton(
                onPressed: () => setState(() {
                  _otpSent = false;
                  _code.clear();
                }),
                child: const Text('Change number'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Seeded accounts, exposed because the scaffold has no sign-up backend.
  /// This block is the first thing to delete when a real gateway is wired.
  Widget _seededAccounts() {
    const accounts = <(String, String, String)>[
      ('9810000001', 'Rajesh Sharma', 'Owner'),
      ('9810000002', 'Priya Nair', 'Manager'),
      ('9810000003', 'Amit Kumar', 'Reception'),
      ('9810000004', 'Sneha Verma', 'Student'),
      ('9810000005', 'Suresh Verma', 'Parent'),
    ];

    return Container(
      padding: const EdgeInsets.all(LiblSpace.md),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 4, bottom: LiblSpace.sm),
            child: Text(
              'SEEDED ACCOUNTS · TAP TO SIGN IN',
              style: TextStyle(
                fontSize: 9.5,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.8,
                color: Colors.white70,
              ),
            ),
          ),
          for (final (phone, name, role) in accounts)
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () => _useAccount(phone),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: LiblSpace.sm,
                  horizontal: LiblSpace.sm,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      role,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 11.5,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(
                      Icons.chevron_right,
                      size: 16,
                      color: Colors.white54,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _Brand extends StatelessWidget {
  const _Brand();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.18),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Center(
            child: Text(
              'L',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w800,
                color: LiblColors.brand,
                height: 1,
              ),
            ),
          ),
        ),
        const SizedBox(height: LiblSpace.lg),
        const Text(
          'Liboora',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: LiblSpace.xs),
        const Text(
          'Run your library. Not your spreadsheets.',
          style: TextStyle(fontSize: 13, color: Colors.white70),
        ),
      ],
    );
  }
}
