import 'package:flutter/material.dart';
import 'package:youpass/core/utils/map_url_launcher.dart';
import 'package:youpass/core/widgets/event_network_image.dart';
import 'package:youpass/features/events/domain/entities/event_detail_entity.dart';
import 'package:youpass/features/events/presentation/event_detail_design_spec.dart';
import 'package:youpass/features/events/presentation/widgets/event_detail_about_section_widget.dart';
import 'package:youpass/features/events/presentation/widgets/event_detail_promoter_card_widget.dart';
import 'package:youpass/features/favorites/domain/entities/favorite_producer_entity.dart';

class EventDetailContentWidget extends StatelessWidget {
  const EventDetailContentWidget({
    super.key,
    required this.event,
    this.onPromoterTap,
    this.onPromoterFollowToggle,
    this.isFollowPending = false,
  });

  final EventDetailEntity event;
  final void Function(FavoriteProducerEntity producer)? onPromoterTap;
  final void Function(FavoriteProducerEntity producer)? onPromoterFollowToggle;
  final bool isFollowPending;

  Future<void> _openMaps(BuildContext context) async {
    await MapUrlLauncher.openDirections(
      addressLabel: event.addressLabel,
      latitude: event.latitude,
      longitude: event.longitude,
    );
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding =
        EventDetailDesignSpec.px(context, EventDetailDesignSpec.horizontalPadding);
    final imageRadius =
        EventDetailDesignSpec.px(context, EventDetailDesignSpec.imageBottomRadius);
    final theme = EventDetailTheme.of(context);

    return ListView(
      padding: EdgeInsets.only(
        bottom: EventDetailDesignSpec.px(context, 24),
      ),
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(imageRadius),
            bottomRight: Radius.circular(imageRadius),
          ),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: EventNetworkImage(
              imageUrl: event.imageUrl,
              fit: BoxFit.cover,
              useShimmerPlaceholder: true,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
            horizontalPadding,
            EventDetailDesignSpec.px(context, 22),
            horizontalPadding,
            0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                event.title,
                style: TextStyle(
                  fontSize: EventDetailDesignSpec.px(context, 28),
                  fontWeight: FontWeight.w800,
                  color: theme.textPrimary,
                  height: 1.15,
                  letterSpacing: -0.2,
                ),
              ),
              SizedBox(height: EventDetailDesignSpec.px(context, 14)),
              _MetaRow(
                icon: Icons.calendar_today_outlined,
                label: event.scheduleLabel,
                theme: theme,
              ),
              if (event.hasAddress) ...[
                SizedBox(height: EventDetailDesignSpec.px(context, 10)),
                _MetaRow(
                  icon: Icons.location_on_outlined,
                  label: event.addressLabel,
                  onTap: () => _openMaps(context),
                  underline: true,
                  theme: theme,
                ),
              ],
              if (event.hasProducer && event.producer != null) ...[
                SizedBox(height: EventDetailDesignSpec.px(context, 20)),
                EventDetailPromoterCardWidget(
                  producer: event.producer!,
                  isFollowPending: isFollowPending,
                  onCardTap: onPromoterTap == null
                      ? () {}
                      : () => onPromoterTap!(event.producer!),
                  onFollowToggle: onPromoterFollowToggle == null
                      ? () {}
                      : () => onPromoterFollowToggle!(event.producer!),
                ),
              ],
              if (event.hasDescription) ...[
                SizedBox(height: EventDetailDesignSpec.px(context, 24)),
                EventDetailAboutSectionWidget(
                  description: event.description!.trim(),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _MetaRow extends StatelessWidget {
  const _MetaRow({
    required this.icon,
    required this.label,
    required this.theme,
    this.onTap,
    this.underline = false,
  });

  final IconData icon;
  final String label;
  final EventDetailTheme theme;
  final VoidCallback? onTap;
  final bool underline;

  @override
  Widget build(BuildContext context) {
    final labelStyle = TextStyle(
      fontSize: EventDetailDesignSpec.px(context, 15),
      fontWeight: FontWeight.w500,
      color: underline ? theme.gold : theme.textSecondary,
      decoration: underline ? TextDecoration.underline : null,
      decorationColor: theme.gold,
      height: 1.35,
    );

    final content = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: EventDetailDesignSpec.px(context, 18),
          color: theme.gold,
        ),
        SizedBox(width: EventDetailDesignSpec.px(context, 10)),
        Expanded(
          child: Text(
            label,
            style: labelStyle,
          ),
        ),
      ],
    );

    if (onTap == null) {
      return content;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: EventDetailDesignSpec.px(context, 2),
          ),
          child: content,
        ),
      ),
    );
  }
}
