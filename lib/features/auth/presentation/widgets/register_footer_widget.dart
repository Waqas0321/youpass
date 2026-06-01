import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/core/widgets/youpass_link_text.dart';
import 'package:youpass/routes/app_routes.dart';

class RegisterFooterWidget extends StatelessWidget {
  const RegisterFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final strings = context.l10n;

    return Column(
      children: [
        AppText(
          strings.alreadyHaveAccountQuestion,
          variant: AppTextVariant.sectionCaption,
          color: AppColors.darkNavy,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: layout.spacing(8)),
        YouPassLinkText(
          label: strings.signInLink,
          color: AppColors.primaryMustard,
          onTap: () {
            Navigator.of(context).pushReplacementNamed(AppRoutes.login);
          },
        ),
      ],
    );
  }
}
