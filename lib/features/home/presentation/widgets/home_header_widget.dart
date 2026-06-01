import 'package:flutter/material.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/features/home/domain/entities/home_entity.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({
    super.key,
    required this.homeData,
  });

  final HomeEntity homeData;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(strings.homeDashboardTitle, variant: AppTextVariant.headline),
        const SizedBox(height: 8),
        AppText(strings.homeDashboardSubtitle, variant: AppTextVariant.bodyLarge),
      ],
    );
  }
}
