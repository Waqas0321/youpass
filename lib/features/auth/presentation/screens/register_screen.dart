import 'package:flutter/material.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/auth_back_button_widget.dart';
import 'package:youpass/core/widgets/auth_content_container.dart';
import 'package:youpass/core/widgets/auth_scaffold.dart';
import 'package:youpass/core/widgets/youpass_logo.dart';
import 'package:youpass/features/auth/presentation/widgets/register_footer_widget.dart';
import 'package:youpass/features/auth/presentation/widgets/register_form_widget.dart';
import 'package:youpass/features/auth/presentation/widgets/register_header_widget.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return AuthScaffold(
      body: AuthContentContainer(
        child: SingleChildScrollView(
          padding: layout.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: layout.spacing(8)),
              const AuthBackButtonWidget(),
              SizedBox(height: layout.spacing(16)),
              const Center(child: YouPassLogo()),
              SizedBox(height: layout.spacing(32)),
              const RegisterHeaderWidget(),
              SizedBox(height: layout.spacing(28)),
              const RegisterFormWidget(),
              SizedBox(height: layout.spacing(28)),
              const RegisterFooterWidget(),
              SizedBox(height: layout.spacing(24)),
            ],
          ),
        ),
      ),
    );
  }
}
