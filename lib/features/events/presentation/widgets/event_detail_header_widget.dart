import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/features/events/presentation/event_detail_design_spec.dart';

class EventDetailHeaderWidget extends StatelessWidget {
  const EventDetailHeaderWidget({
    super.key,
    required this.onBack,
    this.isFavorite = false,
    this.onFavoriteToggle,
    this.isFavoriteEnabled = true,
  });

  final VoidCallback onBack;
  final bool isFavorite;
  final VoidCallback? onFavoriteToggle;
  final bool isFavoriteEnabled;

  @override
  Widget build(BuildContext context) {
    final theme = EventDetailTheme.of(context);

    return Material(
      color: theme.headerBackground,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: EventDetailDesignSpec.px(context, 52),
          child: Row(
            children: [
              IconButton(
                onPressed: onBack,
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppColors.homeAccentYellow,
                  size: 20,
                ),
              ),
              const Spacer(),
              if (onFavoriteToggle != null)
                IconButton(
                  onPressed: isFavoriteEnabled ? onFavoriteToggle : null,
                  icon: Icon(
                    isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                    color: isFavorite ? theme.gold : theme.iconDefault,
                    size: 24,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
