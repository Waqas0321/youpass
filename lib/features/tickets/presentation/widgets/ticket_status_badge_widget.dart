import 'package:flutter/material.dart';
import 'package:youpass/core/theme/tickets_screen_theme.dart';
import 'package:youpass/features/tickets/presentation/tickets_design_spec.dart';

enum TicketStatusBadgeVariant {
  active,
  validated,
  expired,
  cancelled,
  refunded,
  pending,
}

class TicketStatusBadgeWidget extends StatelessWidget {
  const TicketStatusBadgeWidget({
    super.key,
    required this.label,
    this.variant = TicketStatusBadgeVariant.active,
  });

  final String label;
  final TicketStatusBadgeVariant variant;

  @override
  Widget build(BuildContext context) {
    final colors = _resolveColors(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: TicketsDesignSpec.px(context, 10),
        vertical: TicketsDesignSpec.px(context, 5),
      ),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(
          TicketsDesignSpec.px(context, TicketsDesignSpec.badgeRadius),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: TicketsDesignSpec.px(context, 6),
            height: TicketsDesignSpec.px(context, 6),
            decoration: BoxDecoration(
              color: colors.foreground,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: TicketsDesignSpec.px(context, 6)),
          Text(
            label,
            style: TextStyle(
              fontSize: TicketsDesignSpec.px(context, 11),
              fontWeight: FontWeight.w700,
              color: colors.foreground,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }

  _BadgeColors _resolveColors(BuildContext context) {
    switch (variant) {
      case TicketStatusBadgeVariant.active:
      case TicketStatusBadgeVariant.pending:
        return _BadgeColors(
          background: TicketsScreenTheme.activeBadgeBackground(context),
          foreground: TicketsScreenTheme.activeBadgeText(context),
        );
      case TicketStatusBadgeVariant.validated:
        return _BadgeColors(
          background: TicketsScreenTheme.accent(context).withValues(alpha: 0.15),
          foreground: TicketsScreenTheme.accent(context),
        );
      case TicketStatusBadgeVariant.expired:
        return _BadgeColors(
          background: Theme.of(context).colorScheme.surfaceContainerHighest,
          foreground: Theme.of(context).colorScheme.onSurfaceVariant,
        );
      case TicketStatusBadgeVariant.cancelled:
      case TicketStatusBadgeVariant.refunded:
        return _BadgeColors(
          background: Theme.of(context).colorScheme.errorContainer,
          foreground: Theme.of(context).colorScheme.onErrorContainer,
        );
    }
  }
}

class _BadgeColors {
  const _BadgeColors({
    required this.background,
    required this.foreground,
  });

  final Color background;
  final Color foreground;
}
