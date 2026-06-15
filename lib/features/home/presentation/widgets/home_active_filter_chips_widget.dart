import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/theme/youpass_theme_extension.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/features/home/presentation/providers/home_provider.dart';

class HomeActiveFilterChipsWidget extends StatelessWidget {
  const HomeActiveFilterChipsWidget({
    super.key,
    required this.chips,
    required this.onRemove,
  });

  final List<HomeActiveFilterChip> chips;
  final ValueChanged<String> onRemove;

  @override
  Widget build(BuildContext context) {
    if (chips.isEmpty) {
      return const SizedBox.shrink();
    }

    final layout = ResponsiveLayout(context);
    final theme = YouPassThemeExtension.of(context);

    return Padding(
      padding: EdgeInsets.only(bottom: layout.spacing(12)),
      child: Wrap(
        spacing: layout.spacing(8),
        runSpacing: layout.spacing(8),
        children: chips
            .map(
              (chip) => InputChip(
                label: AppText(
                  chip.label,
                  variant: AppTextVariant.bodyEmphasis,
                  fontSize: layout.fontSize(12),
                  color: AppColors.outlineButtonForeground,
                ),
                backgroundColor: AppColors.profileCardBackground,
                side: BorderSide(color: theme.chipSelectedBackground),
                deleteIcon: const Icon(
                  Icons.close,
                  size: 16,
                  color: AppColors.outlineButtonForeground,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(layout.radius(20)),
                ),
                onDeleted: () => onRemove(chip.id),
              ),
            )
            .toList(),
      ),
    );
  }
}
