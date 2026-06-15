import 'dart:async';

import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_design_spec.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_screen_theme.dart';

class VipTableLockCountdownWidget extends StatefulWidget {
  const VipTableLockCountdownWidget({
    super.key,
    required this.expiresAt,
    required this.onExpired,
  });

  final DateTime expiresAt;
  final VoidCallback onExpired;

  @override
  State<VipTableLockCountdownWidget> createState() =>
      _VipTableLockCountdownWidgetState();
}

class _VipTableLockCountdownWidgetState extends State<VipTableLockCountdownWidget> {
  Timer? _timer;
  Duration remaining = Duration.zero;
  bool _notifiedExpiry = false;

  @override
  void initState() {
    super.initState();
    _syncRemaining();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _syncRemaining());
  }

  @override
  void didUpdateWidget(covariant VipTableLockCountdownWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.expiresAt != widget.expiresAt) {
      _notifiedExpiry = false;
      _syncRemaining();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _syncRemaining() {
    final next = widget.expiresAt.difference(DateTime.now());
    if (!mounted) {
      return;
    }

    if (next <= Duration.zero) {
      setState(() => remaining = Duration.zero);
      if (!_notifiedExpiry) {
        _notifiedExpiry = true;
        widget.onExpired();
      }
      return;
    }

    setState(() => remaining = next);
  }

  String _format(Duration value) {
    final minutes = value.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = value.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final isUrgent = remaining <= const Duration(minutes: 2);
    final accent = isUrgent
        ? VipVenueDesignSpec.tableSold
        : VipVenueScreenTheme.accent(context);

    return Container(
      padding: EdgeInsets.all(VipVenueDesignSpec.px(context, 14)),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(VipVenueDesignSpec.px(context, 12)),
        border: Border.all(color: accent.withValues(alpha: isUrgent ? 0.75 : 0.35)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.timer_outlined,
            color: accent,
            size: VipVenueDesignSpec.px(context, 20),
          ),
          SizedBox(width: VipVenueDesignSpec.px(context, 10)),
          Expanded(
            child: Text(
              AppStrings.vipTableLockReservedCountdown(strings, _format(remaining)),
              style: TextStyle(
                fontSize: VipVenueDesignSpec.px(context, 13),
                fontWeight: FontWeight.w600,
                color: isUrgent
                    ? VipVenueDesignSpec.tableSold
                    : VipVenueScreenTheme.title(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
