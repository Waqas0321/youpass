import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';

class HomeGreetingWidget extends StatelessWidget {
  const HomeGreetingWidget({
    super.key,
    this.subtitle,
  });

  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AppText(
      subtitle?.trim().isNotEmpty == true
          ? subtitle!.trim()
          : AppStrings.homeDiscoverSubtitle(l10n),
      variant: AppTextVariant.body,
    );
  }
}
