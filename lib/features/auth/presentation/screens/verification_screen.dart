import 'package:flutter/material.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/auth_content_container.dart';
import 'package:youpass/core/widgets/auth_scaffold.dart';
import 'package:youpass/core/widgets/youpass_logo.dart';
import 'package:youpass/features/auth/presentation/widgets/change_number_footer_widget.dart';
import 'package:youpass/features/auth/presentation/widgets/resend_code_widget.dart';
import 'package:youpass/features/auth/presentation/widgets/verification_form_widget.dart';
import 'package:youpass/features/auth/presentation/widgets/verification_header_widget.dart';
class VerificationScreen extends StatelessWidget {
  const VerificationScreen({
    super.key,
    this.phoneDisplay = '+56 9 1234 5678',
  });

  final String phoneDisplay;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return AuthScaffold(
      showBackButton: true,
      body: AuthContentContainer(
        child: SingleChildScrollView(
          padding: layout.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: layout.spacing(8)),
              const Center(child: YouPassLogo()),
              SizedBox(height: layout.spacing(40)),
              VerificationHeaderWidget(phoneDisplay: phoneDisplay),
              SizedBox(height: layout.spacing(32)),
              const VerificationFormWidget(),
              SizedBox(height: layout.spacing(20)),
              const ResendCodeWidget(),
              SizedBox(height: layout.spacing(40)),
              ChangeNumberFooterWidget(
                onChangeNumber: () => Navigator.of(context).pop(),
              ),
              SizedBox(height: layout.spacing(24)),
            ],
          ),
        ),
      ),
    );
  }
}
