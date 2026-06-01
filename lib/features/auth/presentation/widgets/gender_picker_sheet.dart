import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';

class GenderPickerSheet extends StatelessWidget {
  const GenderPickerSheet({
    super.key,
    required this.onGenderSelected,
  });

  final ValueChanged<String> onGenderSelected;

  static Future<String?> show(BuildContext context) {
    return showModalBottomSheet<String>(
      context: context,
      backgroundColor: AppColors.backgroundWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => GenderPickerSheet(
        onGenderSelected: (gender) => Navigator.of(context).pop(gender),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final strings = context.l10n;
    final options = [
      strings.genderMale,
      strings.genderFemale,
      strings.genderOther,
    ];

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: layout.spacing(16)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(
              strings.genderHint,
              variant: AppTextVariant.title,
              fontSize: layout.fontSize(18),
            ),
            SizedBox(height: layout.spacing(12)),
            ...options.map(
              (option) => ListTile(
                title: AppText(option, variant: AppTextVariant.listTitle),
                onTap: () => onGenderSelected(option),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
