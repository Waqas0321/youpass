import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/events/presentation/event_detail_design_spec.dart';

class EventDetailBuyTicketsBarWidget extends StatelessWidget {
  const EventDetailBuyTicketsBarWidget({
    super.key,
    required this.canBuyTickets,
    required this.onBuyTickets,
    this.isSoldOut = false,
    this.canJoinWaitlist = false,
    this.canLeaveWaitlist = false,
    this.onJoinWaitlist,
    this.onLeaveWaitlist,
    this.enabled = true,
  });

  final bool canBuyTickets;
  final VoidCallback? onBuyTickets;
  final bool isSoldOut;
  final bool canJoinWaitlist;
  final bool canLeaveWaitlist;
  final VoidCallback? onJoinWaitlist;
  final VoidCallback? onLeaveWaitlist;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final theme = EventDetailTheme.of(context);
    final horizontalPadding =
        EventDetailDesignSpec.px(context, EventDetailDesignSpec.horizontalPadding);
    final buttonHeight =
        EventDetailDesignSpec.px(context, EventDetailDesignSpec.buyButtonHeight);
    final radius =
        EventDetailDesignSpec.px(context, EventDetailDesignSpec.buyButtonRadius);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.screenBackground,
        border: Border(top: BorderSide(color: theme.barDivider)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            horizontalPadding,
            EventDetailDesignSpec.px(context, 10),
            horizontalPadding,
            EventDetailDesignSpec.px(context, 12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (canJoinWaitlist)
                Padding(
                  padding: EdgeInsets.only(
                    bottom: EventDetailDesignSpec.px(context, 8),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: buttonHeight,
                    child: OutlinedButton(
                      onPressed: enabled ? onJoinWaitlist : null,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: theme.gold,
                        side: BorderSide(color: theme.gold),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(radius),
                        ),
                      ),
                      child: Text(
                        AppStrings.waitlistJoinButton(strings).toUpperCase(),
                        style: TextStyle(
                          fontSize: EventDetailDesignSpec.px(context, 14),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              if (canLeaveWaitlist)
                Padding(
                  padding: EdgeInsets.only(
                    bottom: EventDetailDesignSpec.px(context, 8),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: buttonHeight,
                    child: OutlinedButton(
                      onPressed: enabled ? onLeaveWaitlist : null,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: theme.textSecondary,
                        side: BorderSide(color: theme.promoterCardBorder),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(radius),
                        ),
                      ),
                      child: Text(
                        AppStrings.waitlistLeave(strings),
                        style: TextStyle(
                          fontSize: EventDetailDesignSpec.px(context, 14),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              if (isSoldOut)
                SizedBox(
                  width: double.infinity,
                  height: buttonHeight,
                  child: ElevatedButton(
                    onPressed: null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.textMuted.withValues(alpha: 0.35),
                      disabledBackgroundColor:
                          theme.textMuted.withValues(alpha: 0.35),
                      disabledForegroundColor: theme.textSecondary,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(radius),
                      ),
                    ),
                    child: Text(
                      AppStrings.eventDetailSoldOut(strings),
                      style: TextStyle(
                        fontSize: EventDetailDesignSpec.px(context, 16),
                        fontWeight: FontWeight.w700,
                        color: theme.textSecondary,
                      ),
                    ),
                  ),
                )
              else if (canBuyTickets)
                SizedBox(
                  width: double.infinity,
                  height: buttonHeight,
                  child: ElevatedButton(
                    onPressed: enabled ? onBuyTickets : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.gold,
                      disabledBackgroundColor: theme.gold.withValues(alpha: 0.45),
                      foregroundColor: const Color(0xFF0F0F14),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(radius),
                      ),
                    ),
                    child: Text(
                      AppStrings.eventDetailBuyTicketsLabel(strings),
                      style: TextStyle(
                        fontSize: EventDetailDesignSpec.px(context, 16),
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F0F14),
                      ),
                    ),
                  ),
                )
              else if (!canJoinWaitlist && !canLeaveWaitlist)
                Text(
                  AppStrings.eventDetailTicketsUnavailable(strings),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: EventDetailDesignSpec.px(context, 13),
                    color: theme.textMuted,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
