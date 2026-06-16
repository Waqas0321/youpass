import 'package:flutter/material.dart';
import 'package:youpass/features/favorites/presentation/favorites_design_spec.dart';

class FavoritesSectionHeaderWidget extends StatelessWidget {
  const FavoritesSectionHeaderWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.leadingIcon = Icons.favorite,
    this.leadingIconColor = FavoritesDesignSpec.favoriteActive,
    this.showLeadingIcon = true,
  });

  final String title;
  final String subtitle;
  final IconData leadingIcon;
  final Color leadingIconColor;
  final bool showLeadingIcon;

  @override
  Widget build(BuildContext context) {
    final titleStyle = TextStyle(
      fontSize: FavoritesDesignSpec.px(
        context,
        showLeadingIcon ? 18 : 16,
      ),
      fontWeight: FontWeight.w700,
      color: FavoritesDesignSpec.titleText,
      height: 1.2,
      letterSpacing: showLeadingIcon ? 0 : 0.2,
    );
    final subtitleStyle = TextStyle(
      fontSize: FavoritesDesignSpec.px(
        context,
        showLeadingIcon ? 13 : 12,
      ),
      color: FavoritesDesignSpec.bodyText,
      height: 1.35,
    );

    final textColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: titleStyle),
        SizedBox(height: FavoritesDesignSpec.px(context, 4)),
        Text(subtitle, style: subtitleStyle),
      ],
    );

    if (!showLeadingIcon) {
      return textColumn;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          leadingIcon,
          size: FavoritesDesignSpec.px(context, 22),
          color: leadingIconColor,
        ),
        SizedBox(width: FavoritesDesignSpec.px(context, 8)),
        Expanded(child: textColumn),
      ],
    );
  }
}
