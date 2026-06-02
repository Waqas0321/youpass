import 'package:flutter/material.dart';
import 'package:youpass/core/widgets/youpass_logo.dart';

class YouPassBrandedAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const YouPassBrandedAppBarWidget({
    super.key,
    this.screenTitle,
    required this.onBack,
    this.primaryColor = const Color(0xFFE69D17),
    this.backgroundColor = Colors.white,
    this.subtitleColor = const Color(0xFF757575),
  });

  final String? screenTitle;
  final VoidCallback onBack;
  final Color primaryColor;
  final Color backgroundColor;
  final Color subtitleColor;

  @override
  Size get preferredSize => Size.fromHeight(
        screenTitle == null ? kToolbarHeight : kToolbarHeight + 12,
      );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      surfaceTintColor: backgroundColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      leading: IconButton(
        onPressed: onBack,
        icon: Icon(Icons.arrow_back, color: primaryColor, size: 24),
      ),
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (screenTitle != null) ...[
            Text(
              screenTitle!,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: subtitleColor,
              ),
            ),
            const SizedBox(height: 2),
          ],
          const YouPassLogo(),
        ],
      ),
    );
  }
}
