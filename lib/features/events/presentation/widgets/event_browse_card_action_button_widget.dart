import 'package:flutter/material.dart';
import 'package:youpass/features/favorites/presentation/favorites_design_spec.dart';

class EventBrowseCardActionButtonWidget extends StatelessWidget {
  const EventBrowseCardActionButtonWidget({
    super.key,
    required this.label,
    this.onPressed,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(
      FavoritesDesignSpec.px(context, 8),
    );

    return Material(
      elevation: FavoritesDesignSpec.px(context, 2),
      shadowColor: Colors.black.withValues(alpha: 0.18),
      color: FavoritesDesignSpec.primary,
      borderRadius: radius,
      child: InkWell(
        onTap: onPressed,
        borderRadius: radius,
        child: SizedBox(
          width: double.infinity,
          height: FavoritesDesignSpec.px(context, 36),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: FavoritesDesignSpec.px(context, 11),
                fontWeight: FontWeight.w700,
                letterSpacing: 0.4,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
