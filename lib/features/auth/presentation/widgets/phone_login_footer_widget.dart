import 'package:flutter/material.dart';
import 'package:youpass/core/constants/country_code_list.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/utils/phone_formatter.dart';
import 'package:youpass/core/utils/phone_validators.dart';
import 'package:youpass/core/widgets/app_snack_bar.dart';
import 'package:youpass/core/widgets/youpass_link_text.dart';
import 'package:youpass/features/auth/presentation/utils/register_otp_flow.dart';
import 'package:youpass/features/auth/presentation/widgets/phone_input_widget.dart';
import 'package:youpass/routes/app_routes.dart';

class PhoneLoginFooterWidget extends StatelessWidget {
  const PhoneLoginFooterWidget({
    super.key,
    required this.phoneController,
    required this.phoneInputKey,
  });

  final TextEditingController phoneController;
  final GlobalKey<PhoneInputWidgetState> phoneInputKey;

  Future<void> startSignup(BuildContext context) async {
    final l10n = context.l10n;
    final country = phoneInputKey.currentState?.currentCountry ??
        CountryCodeList.defaultCountry;
    final phoneDigits = PhoneFormatter.digitsOnly(phoneController.text);

    if (phoneDigits.isEmpty) {
      Navigator.of(context).pushNamed(AppRoutes.register);
      return;
    }

    final validationError = PhoneValidators.validateNationalNumber(
      l10n,
      phoneDigits,
      isoCode: country.isoCode,
    );
    if (validationError != null) {
      AppSnackBar.show(context, validationError);
      return;
    }

    await RegisterOtpFlow.sendCodeAndOpenVerification(
      context: context,
      phoneDigits: phoneDigits,
      countryIsoCode: country.isoCode,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: YouPassLinkText(
        label: context.l10n.createAccountLink,
        onTap: () => startSignup(context),
      ),
    );
  }
}
