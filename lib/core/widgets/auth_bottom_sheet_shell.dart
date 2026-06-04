import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';

class AuthBottomSheetShell extends StatelessWidget {
  const AuthBottomSheetShell({
    super.key,
    required this.title,
    required this.child,
    this.maxHeightFactor = 0.55,
  });

  final String title;
  final Widget child;
  final double maxHeightFactor;

  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required Widget child,
    bool isScrollControlled = true,
    double maxHeightFactor = 0.55,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => AuthBottomSheetShell(
        title: title,
        maxHeightFactor: maxHeightFactor,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final maxHeight = MediaQuery.sizeOf(context).height * maxHeightFactor;

    return SafeArea(
      child: SizedBox(
        height: maxHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: layout.spacing(12)),
            Center(
              child: Container(
                width: layout.spacing(40),
                height: layout.spacing(4),
                decoration: BoxDecoration(
                  color: AppColors.lightGreyBorder,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            SizedBox(height: layout.spacing(16)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: layout.spacing(24)),
              child: AppText(title, variant: AppTextVariant.title),
            ),
            SizedBox(height: layout.spacing(16)),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
