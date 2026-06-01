import 'package:flutter/material.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/auth_header_widget.dart';
import 'package:youpass/features/auth/presentation/widgets/verification_message_widget.dart';

class VerificationHeaderWidget extends StatelessWidget {
  const VerificationHeaderWidget({
    super.key,
    required this.phoneDisplay,
    this.isSmsChannel = true,
  });

  final String phoneDisplay;
  final bool isSmsChannel;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return Column(
      children: [
        AuthHeaderWidget(title: context.l10n.verificationCodeTitle),
        SizedBox(height: layout.spacing(12)),
        VerificationMessageWidget(
          phoneDisplay: phoneDisplay,
          isSmsChannel: isSmsChannel,
        ),
      ],
    );
  }
}
