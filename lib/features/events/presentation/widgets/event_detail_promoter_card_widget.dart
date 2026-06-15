import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/event_network_image.dart';
import 'package:youpass/features/events/presentation/event_detail_design_spec.dart';
import 'package:youpass/features/favorites/domain/entities/favorite_producer_entity.dart';

class EventDetailPromoterCardWidget extends StatelessWidget {
  const EventDetailPromoterCardWidget({
    super.key,
    required this.producer,
    required this.onCardTap,
    required this.onFollowToggle,
    this.isFollowPending = false,
  });

  final FavoriteProducerEntity producer;
  final VoidCallback onCardTap;
  final VoidCallback onFollowToggle;
  final bool isFollowPending;

  @override
  Widget build(BuildContext context) {
    final theme = EventDetailTheme.of(context);
    final avatarSize = EventDetailDesignSpec.px(
      context,
      EventDetailDesignSpec.promoterAvatarSize,
    );
    final radius = EventDetailDesignSpec.px(context, 14);

    return Material(
      color: theme.promoterCardBackground,
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        padding: EdgeInsets.all(EventDetailDesignSpec.px(context, 16)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: theme.promoterCardBorder),
        ),
        child: Row(
          children: [
            Expanded(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onCardTap,
                  borderRadius: BorderRadius.circular(radius),
                  child: Row(
                    children: [
                      ClipOval(
                        child: SizedBox(
                          width: avatarSize,
                          height: avatarSize,
                          child: EventNetworkImage(
                            imageUrl: producer.logoUrl,
                            fit: BoxFit.cover,
                            width: avatarSize,
                            height: avatarSize,
                          ),
                        ),
                      ),
                      SizedBox(width: EventDetailDesignSpec.px(context, 12)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              producer.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: EventDetailDesignSpec.px(context, 16),
                                fontWeight: FontWeight.w700,
                                color: theme.textPrimary,
                              ),
                            ),
                            SizedBox(
                              height: EventDetailDesignSpec.px(context, 2),
                            ),
                            Text(
                              AppStrings.eventDetailPromoterLabel(context.l10n),
                              style: TextStyle(
                                fontSize: EventDetailDesignSpec.px(context, 12),
                                fontWeight: FontWeight.w500,
                                color: theme.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: isFollowPending ? null : onFollowToggle,
              icon: Icon(
                producer.isFollowing
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                color: producer.isFollowing ? theme.gold : theme.textSecondary,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
