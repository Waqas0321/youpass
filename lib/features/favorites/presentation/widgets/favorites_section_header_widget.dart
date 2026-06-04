import 'package:flutter/material.dart';
import 'package:youpass/features/favorites/presentation/favorites_design_spec.dart';

class FavoritesSectionHeaderWidget extends StatelessWidget {
  const FavoritesSectionHeaderWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.leadingIcon = Icons.favorite,
    this.leadingIconColor = FavoritesDesignSpec.favoriteActive,
  });

  final String title;
  final String subtitle;
  final IconData leadingIcon;
  final Color leadingIconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          leadingIcon,
          size: FavoritesDesignSpec.px(context, 22),
          color: leadingIconColor,
        ),
        SizedBox(width: FavoritesDesignSpec.px(context, 8)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: FavoritesDesignSpec.px(context, 18),
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.onSurface,
                  height: 1.2,
                ),
              ),
              SizedBox(height: FavoritesDesignSpec.px(context, 4)),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: FavoritesDesignSpec.px(context, 13),
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
