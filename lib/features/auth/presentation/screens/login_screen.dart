import 'package:flutter/material.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/auth_content_container.dart';
import 'package:youpass/core/widgets/auth_scaffold.dart';
import 'package:youpass/core/widgets/youpass_logo.dart';
import 'package:youpass/features/auth/presentation/widgets/phone_login_footer_widget.dart';
import 'package:youpass/features/auth/presentation/widgets/phone_login_form_widget.dart';
import 'package:youpass/features/auth/presentation/widgets/phone_login_header_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
              SizedBox(height: layout.spacing(24)),
              const Center(child: YouPassLogo()),
              SizedBox(height: layout.spacing(40)),
              const PhoneLoginHeaderWidget(),
              SizedBox(height: layout.spacing(32)),
              PhoneLoginFormWidget(),
              SizedBox(height: layout.spacing(32)),
              const PhoneLoginFooterWidget(),
              SizedBox(height: layout.spacing(24)),
            ],
          ),
        ),
      ),
    );
  }
}
