import 'package:flutter/material.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/auth_header_widget.dart';
import 'package:youpass/core/widgets/auth_page_layout.dart';
import 'package:youpass/features/auth/presentation/widgets/phone_login_footer_widget.dart';
import 'package:youpass/features/auth/presentation/widgets/phone_login_form_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return AuthPageLayout(
      header: AuthHeaderWidget(
        title: strings.welcomeBackTitle,
        subtitle: strings.phoneLoginSubtitle,
      ),
      body: const PhoneLoginFormWidget(),
      footer: const PhoneLoginFooterWidget(),
    );
  }
}
