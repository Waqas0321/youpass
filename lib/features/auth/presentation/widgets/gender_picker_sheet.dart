import 'package:flutter/material.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/core/widgets/auth_bottom_sheet_shell.dart';

class GenderPickerSheet extends StatelessWidget {
  const GenderPickerSheet({
    super.key,
    required this.onGenderSelected,
  });

  final ValueChanged<String> onGenderSelected;

  static Future<String?> show(BuildContext context) {
    return AuthBottomSheetShell.show<String>(
      context: context,
      title: context.l10n.genderHint,
      isScrollControlled: false,
      maxHeightFactor: 0.4,
      child: GenderPickerSheet(
        onGenderSelected: (gender) => Navigator.of(context).pop(gender),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final options = [
      strings.genderMale,
      strings.genderFemale,
      strings.genderOther,
      strings.genderPreferNotToSay,
    ];

    return ListView(
      shrinkWrap: true,
      children: options
          .map(
            (option) => ListTile(
              title: AppText(option, variant: AppTextVariant.listTitle),
              onTap: () => onGenderSelected(option),
            ),
          )
          .toList(),
    );
  }
}
