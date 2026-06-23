import 'package:flutter/material.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/auth_header_widget.dart';
import 'package:youpass/core/widgets/auth_page_layout.dart';
import 'package:youpass/features/auth/presentation/widgets/register_footer_widget.dart';
import 'package:youpass/features/auth/presentation/widgets/register_form_widget.dart';
import 'package:youpass/features/auth/routes/register_route_args.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  RegisterRouteArgs? _readArgs(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    return args is RegisterRouteArgs ? args : null;
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final routeArgs = _readArgs(context);

    final hasVerifiedOtp =
        routeArgs?.otpCode != null && routeArgs!.otpCode!.isNotEmpty;

    return AuthPageLayout(
      showVolterBackButton: true,
      headerSpacing: 32,
      header: AuthHeaderWidget(
        title: strings.createAccountTitle,
        subtitle: hasVerifiedOtp
            ? strings.createAccountSubtitle
            : strings.phoneLoginSubtitle,
      ),
      body: RegisterFormWidget(routeArgs: routeArgs),
      footer: const RegisterFooterWidget(),
    );
  }
}
