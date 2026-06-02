import 'package:flutter/material.dart';
import 'package:youpass/features/favorites/presentation/favorites_design_spec.dart';

class FavoritesEventMetaRowWidget extends StatelessWidget {
  const FavoritesEventMetaRowWidget({
    super.key,
    required this.icon,
    required this.label,
    this.labelColor,
  });

  final IconData icon;
  final String label;
  final Color? labelColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: FavoritesDesignSpec.px(context, 4)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: FavoritesDesignSpec.px(context, 14),
            color: labelColor ?? FavoritesDesignSpec.metaIcon,
          ),
          SizedBox(width: FavoritesDesignSpec.px(context, 6)),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: FavoritesDesignSpec.px(context, 12),
                fontWeight: FontWeight.w400,
                color: labelColor ?? FavoritesDesignSpec.bodyText,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
