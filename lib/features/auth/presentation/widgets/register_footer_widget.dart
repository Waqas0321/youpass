import 'package:flutter/material.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/auth_prompt_footer_widget.dart';
import 'package:youpass/routes/app_routes.dart';

class RegisterFooterWidget extends StatelessWidget {
  const RegisterFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return AuthPromptFooterWidget(
      prompt: strings.alreadyHaveAccountQuestion,
      linkLabel: strings.signInLink,
      onLinkTap: () {
        Navigator.of(context).pushReplacementNamed(AppRoutes.login);
      },
    );
  }
}
