import 'package:flutter/material.dart';
import 'package:youpass/staff_app/core/constants/country_code_list.dart';
import 'package:youpass/staff_app/core/l10n/country_code_display_helper.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/staff_app/core/models/country_code.dart';
import 'package:youpass/staff_app/core/widgets/app_text_field.dart';
import 'package:youpass/staff_app/core/widgets/app_text_field_variant.dart';
import 'package:youpass/staff_app/core/widgets/auth_field_container.dart';
import 'package:youpass/staff_app/core/widgets/auth_field_divider_widget.dart';
import 'package:youpass/staff_app/core/widgets/auth_labeled_field_widget.dart';
import 'package:youpass/staff_app/features/auth/presentation/widgets/country_code_selector_widget.dart';

class PhoneInputWidget extends StatefulWidget {
  const PhoneInputWidget({
    super.key,
    required this.phoneController,
    this.initialCountryIsoCode,
    this.onCountryChanged,
    this.enabled = true,
  });

  final TextEditingController phoneController;
  final String? initialCountryIsoCode;
  final ValueChanged<CountryCode>? onCountryChanged;
  final bool enabled;

  @override
  State<PhoneInputWidget> createState() => PhoneInputWidgetState();
}

class PhoneInputWidgetState extends State<PhoneInputWidget> {
  late CountryCode selectedCountry;

  @override
  void initState() {
    super.initState();
    final iso = widget.initialCountryIsoCode;
    selectedCountry = iso == null
        ? CountryCodeList.defaultCountry
        : CountryCodeList.findByIsoCode(iso);
  }

  void updateCountry(CountryCode country) {
    setState(() => selectedCountry = country);
    widget.onCountryChanged?.call(country);
  }

  CountryCode get currentCountry => selectedCountry;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return AuthLabeledFieldWidget(
      label: strings.phoneNumberLabel,
      child: AuthFieldContainer(
        child: Row(
          children: [
            CountryCodeSelectorWidget(
              selectedCountry: selectedCountry,
              onCountryChanged: updateCountry,
            ),
            const AuthFieldDividerWidget(),
            Expanded(
              child: AppTextField(
                controller: widget.phoneController,
                variant: AppTextFieldVariant.borderless,
                keyboardType: TextInputType.phone,
                enabled: widget.enabled,
                textInputAction: TextInputAction.done,
                hintText: CountryCodeDisplayHelper.localizedPhoneHint(
                  selectedCountry,
                  strings,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
