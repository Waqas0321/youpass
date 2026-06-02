import 'package:flutter/material.dart';
import 'package:youpass/core/widgets/youpass_logo.dart';
import 'package:youpass/features/favorites/presentation/favorites_design_spec.dart';

class FavoritesBrandedAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const FavoritesBrandedAppBarWidget({
    super.key,
    this.screenTitle,
    required this.onBack,
  });

  final String? screenTitle;
  final VoidCallback onBack;

  @override
  Size get preferredSize => Size.fromHeight(
        screenTitle == null ? kToolbarHeight : kToolbarHeight + 12,
      );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: FavoritesDesignSpec.screenBackground,
      surfaceTintColor: FavoritesDesignSpec.screenBackground,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      leading: IconButton(
        onPressed: onBack,
        icon: Icon(
          Icons.arrow_back,
          color: FavoritesDesignSpec.primary,
          size: FavoritesDesignSpec.px(context, FavoritesDesignSpec.backIconSize),
        ),
      ),
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (screenTitle != null) ...[
            Text(
              screenTitle!,
              style: TextStyle(
                fontSize: FavoritesDesignSpec.px(
                  context,
                  FavoritesDesignSpec.appBarSubtitleSize,
                ),
                fontWeight: FontWeight.w500,
                color: FavoritesDesignSpec.bodyText,
              ),
            ),
            SizedBox(height: FavoritesDesignSpec.px(context, 2)),
          ],
          const YouPassLogo(),
        ],
      ),
    );
  }
}
