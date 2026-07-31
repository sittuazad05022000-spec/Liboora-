/// Liboora design tokens.
///
/// One place for colour and type so a hundred widgets cannot each invent their
/// own shade of blue. Uses `CardThemeData` / `DialogThemeData` per the
/// Flutter 3.35 theme API.
library;

import 'package:flutter/material.dart';

abstract final class LiblColors {
  /// Deep indigo — trust, focus, "study". Reads well in the low light of a
  /// basement reading hall, which is where this app is actually used.
  static const Color brand = Color(0xFF2D3E8F);
  static const Color brandDark = Color(0xFF1B2761);
  static const Color accent = Color(0xFFF5A524);

  static const Color success = Color(0xFF15803D);
  static const Color warning = Color(0xFFB45309);
  static const Color danger = Color(0xFFB91C1C);
  static const Color info = Color(0xFF0E7490);

  static const Color surface = Color(0xFFF7F8FC);
  static const Color card = Colors.white;
  static const Color border = Color(0xFFE3E6F0);
  static const Color textPrimary = Color(0xFF14183A);
  static const Color textMuted = Color(0xFF6B7194);
}

abstract final class LiblSpace {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
}

ThemeData buildLiblTheme() {
  final scheme = ColorScheme.fromSeed(
    seedColor: LiblColors.brand,
    primary: LiblColors.brand,
    surface: LiblColors.surface,
  );

  final base = ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: LiblColors.surface,
    fontFamily: 'Roboto',
  );

  return base.copyWith(
    appBarTheme: const AppBarTheme(
      backgroundColor: LiblColors.brand,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        letterSpacing: 0.1,
      ),
    ),
    cardTheme: CardThemeData(
      color: LiblColors.card,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: LiblColors.border),
      ),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: LiblSpace.lg,
        vertical: LiblSpace.lg,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: LiblColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: LiblColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: LiblColors.brand, width: 1.6),
      ),
      labelStyle: const TextStyle(color: LiblColors.textMuted),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: LiblColors.brand,
        foregroundColor: Colors.white,
        minimumSize: const Size.fromHeight(52),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: LiblColors.brand,
        minimumSize: const Size.fromHeight(48),
        side: const BorderSide(color: LiblColors.border),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.white,
      indicatorColor: LiblColors.brand.withValues(alpha: 0.12),
      surfaceTintColor: Colors.transparent,
      elevation: 8,
      labelTextStyle: const WidgetStatePropertyAll(
        TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: LiblColors.border,
      thickness: 1,
      space: 1,
    ),
    textTheme: base.textTheme.apply(
      bodyColor: LiblColors.textPrimary,
      displayColor: LiblColors.textPrimary,
    ),
  );
}
