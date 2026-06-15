import 'package:flutter/material.dart';
import 'package:youpass/core/config/app_product_config.dart';
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
        onGenderSelected: (apiValue) => Navigator.of(context).pop(apiValue),
      ),
    );
  }

  static List<({String value, String label})> resolveOptions(
    BuildContext context,
  ) {
    final strings = context.l10n;
    final locale = Localizations.localeOf(context).languageCode;
    final configured = AppProductConfig.registration.genderOptions;

    if (configured.isNotEmpty) {
      final resolved = configured
          .map(
            (option) => (
              value: option.value,
              label: option.labelFor(locale),
            ),
          )
          .where((option) => option.value.isNotEmpty && option.label.isNotEmpty)
          .toList();
      if (resolved.isNotEmpty) {
        return resolved;
      }
    }

    return [
      (value: 'male', label: strings.genderMale),
      (value: 'female', label: strings.genderFemale),
      (value: 'other', label: strings.genderOther),
      (value: 'prefer_not_to_say', label: strings.genderPreferNotToSay),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final options = resolveOptions(context);

    return ListView(
      shrinkWrap: true,
      children: options
          .map(
            (option) => ListTile(
              title: AppText(option.label, variant: AppTextVariant.listTitle),
              onTap: () => onGenderSelected(option.value),
            ),
          )
          .toList(),
    );
  }
}
