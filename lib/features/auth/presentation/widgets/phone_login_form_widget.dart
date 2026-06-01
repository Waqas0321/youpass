import 'package:flutter/material.dart';
import 'package:youpass/core/constants/country_code_list.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/utils/phone_formatter.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/youpass_primary_button.dart';
import 'package:youpass/features/auth/presentation/widgets/phone_input_widget.dart';
import 'package:youpass/features/auth/routes/verification_route_args.dart';
import 'package:youpass/routes/app_routes.dart';

class PhoneLoginFormWidget extends StatefulWidget {
  const PhoneLoginFormWidget({super.key});

  @override
  State<PhoneLoginFormWidget> createState() => PhoneLoginFormWidgetState();
}

class PhoneLoginFormWidgetState extends State<PhoneLoginFormWidget> {
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<PhoneInputWidgetState> phoneInputKey =
      GlobalKey<PhoneInputWidgetState>();

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  String buildPhoneDisplay() {
    final country =
        phoneInputKey.currentState?.currentCountry ?? CountryCodeList.defaultCountry;
    final dialCode = country.dialCode;
    final digits = PhoneFormatter.digitsOnly(phoneController.text);

    if (digits.isEmpty) {
      return PhoneFormatter.formatDisplay(dialCode, '912345678');
    }

    return PhoneFormatter.formatDisplay(dialCode, digits);
  }

  void navigateToVerification() {
    final args = VerificationRouteArgs(phoneDisplay: buildPhoneDisplay());

    Navigator.of(context).pushNamed(
      AppRoutes.verification,
      arguments: args,
    );
  }

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PhoneInputWidget(
          key: phoneInputKey,
          phoneController: phoneController,
        ),
        SizedBox(height: layout.spacing(28)),
        YouPassPrimaryButton(
          label: context.l10n.sendCodeButton,
          onPressed: navigateToVerification,
        ),
      ],
    );
  }
}
