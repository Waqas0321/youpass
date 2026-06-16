import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/theme/youpass_theme_extension.dart';
import 'package:youpass/core/widgets/event_network_image.dart';
import 'package:youpass/features/events/presentation/widgets/event_browse_card_action_button_widget.dart';
import 'package:youpass/features/favorites/domain/entities/favorite_producer_entity.dart';
import 'package:youpass/features/favorites/presentation/favorites_design_spec.dart';
import 'package:youpass/features/favorites/presentation/widgets/favorites_event_meta_row_widget.dart';
import 'package:youpass/l10n/app_localizations.dart';

class FavoriteProducerCardWidget extends StatelessWidget {
  const FavoriteProducerCardWidget({
    super.key,
    required this.producer,
    required this.onViewEvents,
    this.onUnfollow,
    this.isUnfollowPending = false,
    this.descriptionOverride,
  });

  final FavoriteProducerEntity producer;
  final VoidCallback onViewEvents;
  final VoidCallback? onUnfollow;
  final bool isUnfollowPending;
  final String? descriptionOverride;

  String _description(AppLocalizations strings) {
    if (descriptionOverride != null && descriptionOverride!.isNotEmpty) {
      return descriptionOverride!;
    }
    return producer.description?.trim() ?? '';
  }

  String _typeLabel(AppLocalizations strings) {
    final label = producer.typeLabel?.trim();
    if (label != null && label.isNotEmpty) {
      return label;
    }
    return AppStrings.favoritesProducerType(strings);
  }

  String _coverageLabel(AppLocalizations strings) {
    final label = producer.coverageLabel?.trim();
    if (label != null && label.isNotEmpty) {
      return label;
    }
    return AppStrings.favoritesProducerCoverage(strings);
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final theme = YouPassThemeExtension.of(context);
    final radius = FavoritesDesignSpec.px(context, FavoritesDesignSpec.cardRadius);
    final description = _description(strings);

    return Container(
      margin: EdgeInsets.only(bottom: FavoritesDesignSpec.px(context, 14)),
      padding: EdgeInsets.all(FavoritesDesignSpec.px(context, 14)),
      decoration: BoxDecoration(
        color: theme.cardBackground,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: theme.cardBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: FavoritesDesignSpec.px(context, 10),
            offset: Offset(0, FavoritesDesignSpec.px(context, 2)),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(
                  FavoritesDesignSpec.px(context, FavoritesDesignSpec.imageRadius),
                ),
                child: SizedBox(
                  width: FavoritesDesignSpec.px(context, 64),
                  height: FavoritesDesignSpec.px(context, 64),
                  child: EventNetworkImage(
                    imageUrl: producer.logoUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: FavoritesDesignSpec.px(context, 12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      producer.name.toUpperCase(),
                      style: TextStyle(
                        fontSize: FavoritesDesignSpec.px(context, 15),
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: FavoritesDesignSpec.px(context, 6)),
                    FavoritesEventMetaRowWidget(
                      icon: Icons.storefront_outlined,
                      label: _typeLabel(strings),
                    ),
                    FavoritesEventMetaRowWidget(
                      icon: Icons.calendar_today_outlined,
                      label: _coverageLabel(strings),
                    ),
                  ],
                ),
              ),
              if (onUnfollow != null)
                IconButton(
                  onPressed: isUnfollowPending ? null : onUnfollow,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: Icon(
                    Icons.favorite,
                    color: FavoritesDesignSpec.favoriteActive,
                    size: FavoritesDesignSpec.px(context, 22),
                  ),
                ),
            ],
          ),
          if (description.isNotEmpty) ...[
            SizedBox(height: FavoritesDesignSpec.px(context, 10)),
            Text(
              description,
              style: TextStyle(
                fontSize: FavoritesDesignSpec.px(context, 13),
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                height: 1.35,
              ),
            ),
          ],
          SizedBox(height: FavoritesDesignSpec.px(context, 12)),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: FavoritesDesignSpec.px(context, 148),
              child: EventBrowseCardActionButtonWidget(
                label: AppStrings.favoritesViewEvents(strings),
                onPressed: onViewEvents,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
