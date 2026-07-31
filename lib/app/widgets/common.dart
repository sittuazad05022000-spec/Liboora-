/// Shared presentation widgets.
///
/// Presentation only: these take primitives and value objects, never a
/// repository or a use case. That keeps the widget tree testable without a
/// container and keeps rendering out of the domain.
library;

import 'package:flutter/material.dart';

import '../theme.dart';

/// Dashboard metric tile.
class MetricTile extends StatelessWidget {
  const MetricTile({
    super.key,
    required this.label,
    required this.value,
    this.sublabel,
    this.icon,
    this.tint = LiblColors.brand,
  });

  final String label;
  final String value;
  final String? sublabel;
  final IconData? icon;
  final Color tint;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(LiblSpace.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                if (icon != null) ...[
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: tint.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(icon, size: 15, color: tint),
                  ),
                  const SizedBox(width: LiblSpace.sm),
                ],
                Expanded(
                  child: Text(
                    label.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.6,
                      color: LiblColors.textMuted,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: LiblSpace.md),
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  height: 1.05,
                  color: LiblColors.textPrimary,
                ),
              ),
            ),
            if (sublabel != null) ...[
              const SizedBox(height: LiblSpace.xs),
              Text(
                sublabel!,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 11.5,
                  color: LiblColors.textMuted,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.trailing,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: LiblSpace.md, top: LiblSpace.lg),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15.5,
                    fontWeight: FontWeight.w700,
                    color: LiblColors.textPrimary,
                  ),
                ),
                if (subtitle != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      subtitle!,
                      style: const TextStyle(
                        fontSize: 11.5,
                        color: LiblColors.textMuted,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

/// Small status chip.
class Pill extends StatelessWidget {
  const Pill(this.text, {super.key, this.color = LiblColors.brand, this.icon});

  final String text;
  final Color color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.24)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 11, color: color),
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              color: color,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}

/// Circular monogram avatar derived from a name.
class Monogram extends StatelessWidget {
  const Monogram(this.name, {super.key, this.size = 40});

  final String name;
  final double size;

  static const List<Color> _palette = [
    Color(0xFF2D3E8F),
    Color(0xFF0E7490),
    Color(0xFF7C3AED),
    Color(0xFFB45309),
    Color(0xFF15803D),
    Color(0xFFBE123C),
  ];

  String get _initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '?';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final color = _palette[name.hashCode.abs() % _palette.length];
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        shape: BoxShape.circle,
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Text(
        _initials,
        style: TextStyle(
          fontSize: size * 0.36,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.message,
  });

  final IconData icon;
  final String title;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: LiblSpace.xxl,
        horizontal: LiblSpace.lg,
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 38,
            color: LiblColors.textMuted.withValues(alpha: 0.5),
          ),
          const SizedBox(height: LiblSpace.md),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: LiblColors.textPrimary,
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: LiblSpace.xs),
            Text(
              message!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12.5,
                color: LiblColors.textMuted,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Full-width list card wrapper with consistent inner padding.
class PanelCard extends StatelessWidget {
  const PanelCard({super.key, required this.children, this.padding});

  final List<Widget> children;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: padding ?? const EdgeInsets.symmetric(vertical: LiblSpace.xs),
        child: Column(children: children),
      ),
    );
  }
}

/// Thin horizontal progress meter used for occupancy and collection rate.
class MeterBar extends StatelessWidget {
  const MeterBar({
    super.key,
    required this.fraction,
    this.color = LiblColors.brand,
    this.height = 7,
  });

  final double fraction;
  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) {
    final f = fraction.isNaN ? 0.0 : fraction.clamp(0.0, 1.0);
    return ClipRRect(
      borderRadius: BorderRadius.circular(height),
      child: LinearProgressIndicator(
        value: f,
        minHeight: height,
        backgroundColor: LiblColors.border,
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
    );
  }
}
