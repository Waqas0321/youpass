import 'package:flutter/material.dart';
import 'package:youpass/features/favorites/presentation/favorites_design_spec.dart';

class FavoritesEventMetaRowWidget extends StatelessWidget {
  const FavoritesEventMetaRowWidget({
    super.key,
    required this.icon,
    required this.label,
    this.labelColor,
    this.iconColor,
    this.iconSize,
    this.fontSize,
    this.spacing,
    this.maxLines = 1,
  });

  final IconData icon;
  final String label;
  final Color? labelColor;
  final Color? iconColor;
  final double? iconSize;
  final double? fontSize;
  final double? spacing;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final resolvedIconSize =
        FavoritesDesignSpec.px(context, iconSize ?? 14);
    final resolvedFontSize =
        FavoritesDesignSpec.px(context, fontSize ?? 12);
    final resolvedSpacing =
        FavoritesDesignSpec.px(context, spacing ?? 6);

    return Padding(
      padding: EdgeInsets.only(bottom: FavoritesDesignSpec.px(context, 3)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: resolvedIconSize,
            color: iconColor ??
                labelColor ??
                Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          SizedBox(width: resolvedSpacing),
          Expanded(
            child: Text(
              label,
              maxLines: maxLines,
              softWrap: true,
              overflow: maxLines == 1
                  ? TextOverflow.ellipsis
                  : TextOverflow.visible,
              style: TextStyle(
                fontSize: resolvedFontSize,
                fontWeight: FontWeight.w400,
                color: labelColor ??
                    Theme.of(context).colorScheme.onSurfaceVariant,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
