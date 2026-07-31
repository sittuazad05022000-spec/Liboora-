/// Seat map.
///
/// Tapping a free seat assigns it; tapping an occupied one offers release.
/// Both go through the use cases, so the "one active allocation per seat"
/// invariant and the membership-required rule are enforced here exactly as
/// they would be from an API call.
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/library/seating/seating.dart';
import '../session.dart';
import '../theme.dart';
import '../widgets/common.dart';

class SeatMapPage extends StatelessWidget {
  const SeatMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.watch<SessionController>();
    final occupancy = s.container.seatMap.currentMap(s.nameOf);
    final summary = s.container.seatMap.summary();

    if (occupancy.isEmpty) {
      return const EmptyState(
        icon: Icons.grid_off_outlined,
        title: 'No seat layout for this branch',
        message: 'Configure the seating plan in branch policy first.',
      );
    }

    final zones = <String, List<SeatOccupancy>>{};
    for (final o in occupancy) {
      zones.putIfAbsent(o.seat.zone, () => []).add(o);
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        LiblSpace.lg,
        LiblSpace.md,
        LiblSpace.lg,
        LiblSpace.xxl,
      ),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(LiblSpace.lg),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${summary.occupied} of ${summary.total} reserved',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${s.branchInfo.name} · ${zones.length} zones',
                        style: const TextStyle(
                          fontSize: 12,
                          color: LiblColors.textMuted,
                        ),
                      ),
                      const SizedBox(height: LiblSpace.md),
                      MeterBar(
                        fraction: summary.total == 0
                            ? 0
                            : summary.occupied / summary.total,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: LiblSpace.lg),
                Column(
                  children: [
                    Text(
                      '${summary.free}',
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: LiblColors.success,
                        height: 1,
                      ),
                    ),
                    const Text(
                      'free',
                      style: TextStyle(
                        fontSize: 11,
                        color: LiblColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        for (final entry in zones.entries) ...[
          SectionHeader(
            title: entry.key,
            subtitle:
                '${entry.value.where((o) => o.isOccupied).length} of ${entry.value.length} taken',
          ),
          _SeatGrid(seats: entry.value),
        ],
        const SizedBox(height: LiblSpace.lg),
        const _Legend(),
      ],
    );
  }
}

class _SeatGrid extends StatelessWidget {
  const _SeatGrid({required this.seats});
  final List<SeatOccupancy> seats;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(LiblSpace.md),
        child: Wrap(
          spacing: LiblSpace.sm,
          runSpacing: LiblSpace.sm,
          children: [for (final o in seats) _SeatChip(occupancy: o)],
        ),
      ),
    );
  }
}

class _SeatChip extends StatelessWidget {
  const _SeatChip({required this.occupancy});
  final SeatOccupancy occupancy;

  @override
  Widget build(BuildContext context) {
    final s = context.read<SessionController>();
    final taken = occupancy.isOccupied;
    final color = taken ? LiblColors.brand : LiblColors.success;

    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () => _onTap(context, s),
      child: Container(
        width: 62,
        height: 58,
        decoration: BoxDecoration(
          color: color.withValues(alpha: taken ? 0.12 : 0.07),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withValues(alpha: 0.35)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              taken ? Icons.person : Icons.chair_alt_outlined,
              size: 15,
              color: color,
            ),
            const SizedBox(height: 3),
            Text(
              occupancy.seat.label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
            if (occupancy.seat.hasPowerSocket)
              const Icon(Icons.power, size: 9, color: LiblColors.textMuted),
          ],
        ),
      ),
    );
  }

  Future<void> _onTap(BuildContext context, SessionController s) async {
    final alloc = occupancy.allocation;

    if (alloc != null) {
      final release = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Seat ${occupancy.seat.label}'),
          content: Text(
            '${occupancy.studentName ?? 'A student'} holds this seat until '
            '${alloc.window.end.toIso8601String().substring(0, 10)}.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('Close'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                minimumSize: const Size(90, 42),
                backgroundColor: LiblColors.danger,
              ),
              onPressed: () => Navigator.of(ctx).pop(true),
              child: const Text('Release'),
            ),
          ],
        ),
      );
      if (release == true) {
        final msg = await s.releaseSeat(alloc.id);
        if (context.mounted) {
          _snack(context, msg ?? 'Seat ${occupancy.seat.label} released');
        }
      }
      return;
    }

    // Free seat — pick a student to assign it to.
    final students = s.students;
    final picked = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(LiblSpace.lg),
              child: Text(
                'Assign seat ${occupancy.seat.label}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Divider(height: 1),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: students.length,
                itemBuilder: (_, i) {
                  final st = students[i];
                  final v = s.validityOf(st.id);
                  return ListTile(
                    leading: Monogram(st.fullName, size: 36),
                    title: Text(
                      st.fullName,
                      style: const TextStyle(fontSize: 14),
                    ),
                    subtitle: Text(
                      v.isValid ? v.planName : 'No active membership',
                      style: TextStyle(
                        fontSize: 11.5,
                        color: v.isValid
                            ? LiblColors.textMuted
                            : LiblColors.danger,
                      ),
                    ),
                    onTap: () => Navigator.of(ctx).pop(st.id.value),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );

    if (picked == null || !context.mounted) return;
    final target = s.students.where((st) => st.id.value == picked).toList();
    if (target.isEmpty) return;

    final msg = await s.assignSeat(target.first.id, occupancy.seat.id);
    if (context.mounted) {
      _snack(
        context,
        msg ?? '${occupancy.seat.label} assigned to ${target.first.fullName}',
      );
    }
  }

  static void _snack(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Pill('Free', color: LiblColors.success, icon: Icons.chair_alt_outlined),
        SizedBox(width: LiblSpace.sm),
        Pill('Reserved', color: LiblColors.brand, icon: Icons.person),
        SizedBox(width: LiblSpace.sm),
        Expanded(
          child: Text(
            'Assigning blocks without an active plan — by design.',
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 10.5, color: LiblColors.textMuted),
          ),
        ),
      ],
    );
  }
}
