import 'package:flutter/material.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/youpass_link_text.dart';
import 'package:youpass/routes/app_routes.dart';

class PhoneLoginFooterWidget extends StatelessWidget {
  const PhoneLoginFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: YouPassLinkText(
        label: context.l10n.createAccountLink,
        onTap: () {
          Navigator.of(context).pushNamed(AppRoutes.register);
        },
      ),
    );
  }
}
