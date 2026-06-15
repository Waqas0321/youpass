import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/favorites/presentation/favorites_design_spec.dart';

class FavoritesFooterCountersWidget extends StatelessWidget {
  const FavoritesFooterCountersWidget({
    super.key,
    required this.eventsCount,
    this.producersCount = 0,
  });

  final int producersCount;
  final int eventsCount;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return Column(
      children: [
        if (producersCount > 0) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.groups_outlined,
                size: FavoritesDesignSpec.px(context, 16),
                color: FavoritesDesignSpec.primary,
              ),
              SizedBox(width: FavoritesDesignSpec.px(context, 6)),
              Text(
                AppStrings.favoritesSavedProducersCount(strings, producersCount),
                style: TextStyle(
                  fontSize: FavoritesDesignSpec.px(context, 13),
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          SizedBox(height: FavoritesDesignSpec.px(context, 6)),
        ],
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite,
              size: FavoritesDesignSpec.px(context, 16),
              color: FavoritesDesignSpec.favoriteActive,
            ),
            SizedBox(width: FavoritesDesignSpec.px(context, 6)),
            Text(
              AppStrings.favoritesSavedEventsCount(strings, eventsCount),
              style: TextStyle(
                fontSize: FavoritesDesignSpec.px(context, 13),
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
