import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/theme/youpass_theme_extension.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/core/widgets/event_network_image.dart';
import 'package:youpass/features/home/presentation/widgets/event_meta_row_widget.dart';
import 'package:youpass/features/events/domain/entities/event_entity.dart';

class EventListCardWidget extends StatelessWidget {
  const EventListCardWidget({
    super.key,
    required this.event,
    this.onEventTap,
    this.showProximity = false,
    this.onJoinWaitlist,
    this.onLeaveWaitlist,
  });

  final EventEntity event;
  final VoidCallback? onEventTap;
  final bool showProximity;
  final VoidCallback? onJoinWaitlist;
  final VoidCallback? onLeaveWaitlist;

  bool get _showWaitlistCta {
    final waitlist = event.waitlist;
    if (waitlist == null || !waitlist.enabled) {
      return false;
    }
    return waitlist.canJoin || waitlist.canLeave;
  }

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final theme = YouPassThemeExtension.of(context);
    final strings = context.l10n;
    final imageSize = layout.spacing(96);
    final cardHeight = layout.spacing(_showWaitlistCta ? 120 : 96);
    final cardRadius = layout.radius(10);
    final horizontalPadding = layout.spacing(16);
    final verticalPadding = layout.spacing(_showWaitlistCta ? 10 : 16);
    final waitlist = event.waitlist;

    return SizedBox(
      height: cardHeight,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.cardBackground,
          borderRadius: BorderRadius.circular(cardRadius),
          border: Border.all(color: theme.cardBorder),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(cardRadius),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onEventTap,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: imageSize,
                    height: cardHeight,
                    child: EventNetworkImage(
                      imageUrl: event.imageUrl,
                      fit: BoxFit.cover,
                      width: imageSize,
                      height: cardHeight,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                        vertical: verticalPadding,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppText(
                            event.title,
                            variant: AppTextVariant.listTitle,
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: layout.fontSize(16),
                            fontWeight: FontWeight.w700,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: layout.spacing(4)),
                          EventMetaRowWidget(
                            icon: Icons.calendar_today_outlined,
                            label: event.dateLabel,
                            iconColor: AppColors.homeAccentYellow,
                            labelColor: AppColors.homeAccentYellow,
                            fontWeight: FontWeight.w600,
                            maxLines: 1,
                          ),
                          SizedBox(height: layout.spacing(2)),
                          EventMetaRowWidget(
                            icon: Icons.location_on_outlined,
                            label: event.locationLabel,
                            maxLines: 1,
                          ),
                          if (showProximity && event.distanceKm != null) ...[
                            SizedBox(height: layout.spacing(2)),
                            _ProximityRow(event: event, layout: layout),
                          ],
                          if (_showWaitlistCta) ...[
                            SizedBox(height: layout.spacing(4)),
                            GestureDetector(
                              onTap: waitlist!.canJoin ? onJoinWaitlist : onLeaveWaitlist,
                              behavior: HitTestBehavior.opaque,
                              child: Text(
                                waitlist.canJoin
                                    ? AppStrings.waitlistJoinButton(strings).toUpperCase()
                                    : AppStrings.waitlistLeave(strings),
                                style: TextStyle(
                                  fontSize: layout.fontSize(11),
                                  fontWeight: waitlist.canJoin
                                      ? FontWeight.w700
                                      : FontWeight.w600,
                                  color: waitlist.canJoin
                                      ? AppColors.primaryMustard
                                      : Theme.of(context).colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProximityRow extends StatelessWidget {
  const _ProximityRow({
    required this.event,
    required this.layout,
  });

  final EventEntity event;
  final ResponsiveLayout layout;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final distance = event.distanceKm!;
    final distanceLabel = distance < 10
        ? distance.toStringAsFixed(1)
        : distance.round().toString();
    final travelMinutes = event.travelTimeMinutes;

    return Row(
      children: [
        Icon(
          Icons.near_me_outlined,
          size: layout.fontSize(12),
          color: Colors.grey.shade600,
        ),
        SizedBox(width: layout.spacing(4)),
        Text(
          l10n.homeEventDistanceKm(distanceLabel),
          style: TextStyle(
            fontSize: layout.fontSize(11),
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w500,
          ),
        ),
        if (travelMinutes != null) ...[
          SizedBox(width: layout.spacing(8)),
          Icon(
            Icons.directions_car_outlined,
            size: layout.fontSize(12),
            color: Colors.grey.shade600,
          ),
          SizedBox(width: layout.spacing(4)),
          Text(
            l10n.homeEventTravelMinutes(travelMinutes),
            style: TextStyle(
              fontSize: layout.fontSize(11),
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }
}
