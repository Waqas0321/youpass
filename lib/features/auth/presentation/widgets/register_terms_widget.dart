import 'package:flutter/material.dart';
import 'package:youpass/core/config/app_product_config.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/theme/youpass_theme_extension.dart';
import 'package:youpass/core/utils/payment_url_launcher.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';

class RegisterTermsWidget extends StatelessWidget {
  const RegisterTermsWidget({
    super.key,
    required this.isAccepted,
    required this.onChanged,
  });

  final bool isAccepted;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final strings = context.l10n;
    final theme = YouPassThemeExtension.of(context);
    final termsUrl = AppProductConfig.registration.termsUrl;
    final privacyUrl = AppProductConfig.registration.privacyUrl;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: layout.spacing(24),
          height: layout.spacing(24),
          child: Checkbox(
            value: isAccepted,
            onChanged: (value) => onChanged(value ?? false),
            activeColor: AppColors.primaryMustard,
            checkColor: AppColors.darkNavy,
            side: BorderSide(color: theme.cardBorder),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(layout.radius(4)),
            ),
          ),
        ),
        SizedBox(width: layout.spacing(10)),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: layout.spacing(2)),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                AppText(strings.termsPrefix, variant: AppTextVariant.body),
                _TermsLink(
                  label: strings.termsLink,
                  url: termsUrl,
                ),
                if (privacyUrl != null && privacyUrl.isNotEmpty) ...[
                  AppText(' ${strings.termsAnd} ', variant: AppTextVariant.body),
                  _TermsLink(
                    label: strings.privacyLink,
                    url: privacyUrl,
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _TermsLink extends StatelessWidget {
  const _TermsLink({
    required this.label,
    required this.url,
  });

  final String label;
  final String? url;

  @override
  Widget build(BuildContext context) {
    final hasUrl = url != null && url!.isNotEmpty;

    if (!hasUrl) {
      return AppText(label, variant: AppTextVariant.timer);
    }

    return GestureDetector(
      onTap: () => PaymentUrlLauncher.openExternalUrl(url!),
      child: AppText(label, variant: AppTextVariant.timer),
    );
  }
}
