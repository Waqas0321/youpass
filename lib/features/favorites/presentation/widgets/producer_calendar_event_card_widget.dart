import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/theme/youpass_theme_extension.dart';
import 'package:youpass/core/widgets/event_network_image.dart';
import 'package:youpass/features/favorites/domain/entities/producer_calendar_event_entity.dart';
import 'package:youpass/features/favorites/presentation/favorites_design_spec.dart';
import 'package:youpass/features/favorites/presentation/utils/producer_calendar_price_formatter.dart';
import 'package:youpass/features/favorites/presentation/utils/producer_calendar_time_formatter.dart';
import 'package:youpass/features/favorites/presentation/widgets/favorites_event_meta_row_widget.dart';

class ProducerCalendarEventCardWidget extends StatelessWidget {
  const ProducerCalendarEventCardWidget({
    super.key,
    required this.event,
    required this.onBuyTicket,
    this.onEventTap,
  });

  final ProducerCalendarEventEntity event;
  final VoidCallback onBuyTicket;
  final VoidCallback? onEventTap;

  static const double _designCardHeight = 240;
  static const int _textFlex = 52;
  static const int _imageFlex = 48;

  String _ctaLabel(BuildContext context) {
    final strings = context.l10n;
    switch (event.ticketCta) {
      case ProducerTicketCta.presale:
        return AppStrings.producerEventPresale(strings);
      case ProducerTicketCta.prepay:
        return AppStrings.producerEventPrepay(strings);
      case ProducerTicketCta.buy:
        return AppStrings.producerEventBuyTicket(strings);
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final theme = YouPassThemeExtension.of(context);
    final radius = FavoritesDesignSpec.px(context, FavoritesDesignSpec.cardRadius);
    final cardHeight = FavoritesDesignSpec.px(context, _designCardHeight);
    final priceParts = ProducerCalendarPriceFormatter.parts(
      strings: strings,
      localeName: strings.localeName,
      minPrice: event.minPrice,
      currencyCode: event.currencyCode,
    );
    final dateLabel = ProducerCalendarTimeFormatter.displayDate(
      localeName: strings.localeName,
      fallbackLabel: event.dateLabel,
      startsAt: event.startsAt,
    );
    final timeLabel = ProducerCalendarTimeFormatter.displayTime(
      localeName: strings.localeName,
      startsAt: event.startsAt,
    );

    return Container(
      margin: EdgeInsets.only(bottom: FavoritesDesignSpec.px(context, 14)),
      height: cardHeight,
      decoration: BoxDecoration(
        color: theme.cardBackground,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: FavoritesDesignSpec.px(context, 12),
            offset: Offset(0, FavoritesDesignSpec.px(context, 3)),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: _textFlex,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                FavoritesDesignSpec.px(context, 14),
                FavoritesDesignSpec.px(context, 12),
                FavoritesDesignSpec.px(context, 6),
                FavoritesDesignSpec.px(context, 12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: onEventTap,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            event.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: FavoritesDesignSpec.px(context, 15),
                              fontWeight: FontWeight.w700,
                              color: FavoritesDesignSpec.titleText,
                              height: 1.2,
                            ),
                          ),
                          SizedBox(height: FavoritesDesignSpec.px(context, 6)),
                          FavoritesEventMetaRowWidget(
                            icon: Icons.calendar_today_outlined,
                            label: dateLabel,
                            fontSize: 11,
                            iconSize: 13,
                            iconColor: FavoritesDesignSpec.metaIcon,
                            labelColor: FavoritesDesignSpec.bodyText,
                            spacing: 7,
                            maxLines: 2,
                          ),
                          if (timeLabel != null)
                            FavoritesEventMetaRowWidget(
                              icon: Icons.schedule_outlined,
                              label: timeLabel,
                              fontSize: 11,
                              iconSize: 13,
                              iconColor: FavoritesDesignSpec.metaIcon,
                              labelColor: FavoritesDesignSpec.bodyText,
                              spacing: 7,
                              maxLines: 2,
                            ),
                          FavoritesEventMetaRowWidget(
                            icon: Icons.location_on_outlined,
                            label: event.venueName ?? event.locationLabel,
                            fontSize: 11,
                            iconSize: 13,
                            iconColor: FavoritesDesignSpec.metaIcon,
                            labelColor: FavoritesDesignSpec.bodyText,
                            spacing: 7,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (priceParts != null) ...[
                        Divider(
                          height: FavoritesDesignSpec.px(context, 12),
                          thickness: 1,
                          color: FavoritesDesignSpec.divider,
                        ),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: FavoritesDesignSpec.px(context, 12),
                              fontWeight: FontWeight.w500,
                              color: FavoritesDesignSpec.titleText,
                            ),
                            children: [
                              TextSpan(text: '${priceParts.prefix} '),
                              TextSpan(
                                text: priceParts.amount,
                                style: TextStyle(
                                  fontSize: FavoritesDesignSpec.px(context, 14),
                                  fontWeight: FontWeight.w700,
                                  color: FavoritesDesignSpec.buyAccent,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: FavoritesDesignSpec.px(context, 8)),
                      ],
                      _ProducerCalendarBuyButton(
                        label: _ctaLabel(context),
                        onPressed: onBuyTicket,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: _imageFlex,
            child: GestureDetector(
              onTap: onEventTap,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  EventNetworkImage(
                    imageUrl: event.imageUrl,
                    fit: BoxFit.cover,
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          theme.cardBackground,
                          theme.cardBackground.withValues(alpha: 0.92),
                          theme.cardBackground.withValues(alpha: 0.45),
                          theme.cardBackground.withValues(alpha: 0),
                        ],
                        stops: const [0.0, 0.12, 0.32, 0.55],
                      ),
                    ),
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

class _ProducerCalendarBuyButton extends StatelessWidget {
  const _ProducerCalendarBuyButton({
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final height = FavoritesDesignSpec.px(context, 32);

    return Material(
      color: FavoritesDesignSpec.buyAccent,
      child: InkWell(
        onTap: onPressed,
        child: SizedBox(
          width: double.infinity,
          height: height,
          child: Center(
            child: Text(
              label.toUpperCase(),
              style: TextStyle(
                fontSize: FavoritesDesignSpec.px(context, 10),
                fontWeight: FontWeight.w700,
                letterSpacing: 0.4,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
