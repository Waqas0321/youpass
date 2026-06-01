import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/constants/country_code_list.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/models/country_code.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_field.dart';
import 'package:youpass/core/widgets/app_text_field_variant.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/features/auth/presentation/widgets/country_code_selector_widget.dart';

class PhoneInputWidget extends StatefulWidget {
  const PhoneInputWidget({
    super.key,
    required this.phoneController,
    this.onCountryChanged,
  });

  final TextEditingController phoneController;
  final ValueChanged<CountryCode>? onCountryChanged;

  @override
  State<PhoneInputWidget> createState() => PhoneInputWidgetState();
}

class PhoneInputWidgetState extends State<PhoneInputWidget> {
  CountryCode selectedCountry = CountryCodeList.defaultCountry;

  void updateCountry(CountryCode country) {
    setState(() => selectedCountry = country);
    widget.onCountryChanged?.call(country);
  }

  CountryCode get currentCountry => selectedCountry;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final fieldRadius = layout.radius(12);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          context.l10n.phoneNumberLabel,
          variant: AppTextVariant.label,
        ),
        SizedBox(height: layout.spacing(8)),
        Container(
          decoration: BoxDecoration(
            color: AppColors.backgroundWhite,
            borderRadius: BorderRadius.circular(fieldRadius),
            border: Border.all(color: AppColors.lightGreyBorder),
          ),
          child: Row(
            children: [
              CountryCodeSelectorWidget(
                selectedCountry: selectedCountry,
                onCountryChanged: updateCountry,
              ),
              Container(
                width: 1,
                height: layout.spacing(28),
                color: AppColors.lightGreyBorder,
              ),
              Expanded(
                child: AppTextField(
                  controller: widget.phoneController,
                  variant: AppTextFieldVariant.borderless,
                  keyboardType: TextInputType.phone,
                  hintText: selectedCountry.phoneHint,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
