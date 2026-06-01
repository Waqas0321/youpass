import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';

class HomeGreetingWidget extends StatelessWidget {
  const HomeGreetingWidget({
    super.key,
    required this.userName,
  });

  final String userName;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          AppStrings.homeGreeting(l10n, userName),
          variant: AppTextVariant.greetingTitle,
        ),
        SizedBox(height: layout.spacing(6)),
        AppText(
          AppStrings.homeDiscoverSubtitle(l10n),
          variant: AppTextVariant.body,
          color: AppColors.secondaryGrey,
        ),
      ],
    );
  }
}
