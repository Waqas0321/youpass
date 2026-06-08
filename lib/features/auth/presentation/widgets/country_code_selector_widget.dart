import 'package:flutter/material.dart';
import 'package:youpass/core/models/country_code.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/features/auth/presentation/widgets/country_code_picker_sheet.dart';

class CountryCodeSelectorWidget extends StatelessWidget {
  const CountryCodeSelectorWidget({
    super.key,
    required this.selectedCountry,
    required this.onCountryChanged,
  });

  final CountryCode selectedCountry;
  final ValueChanged<CountryCode> onCountryChanged;

  Future<void> openCountryPicker(BuildContext context) async {
    final country = await CountryCodePickerSheet.show(
      context: context,
      selectedCountry: selectedCountry,
    );

    if (country != null) {
      onCountryChanged(country);
    }
  }

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final scheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: () => openCountryPicker(context),
      borderRadius: BorderRadius.circular(layout.radius(8)),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: layout.spacing(12),
          vertical: layout.spacing(14),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(
              selectedCountry.flagEmoji,
              variant: AppTextVariant.emojiMedium,
            ),
            SizedBox(width: layout.spacing(6)),
            AppText(
              selectedCountry.displayDialCode,
              variant: AppTextVariant.dialCode,
            ),
            SizedBox(width: layout.spacing(2)),
            Icon(
              Icons.keyboard_arrow_down,
              size: layout.fontSize(20),
              color: scheme.onSurfaceVariant.withValues(alpha: 0.8),
            ),
          ],
        ),
      ),
    );
  }
}
