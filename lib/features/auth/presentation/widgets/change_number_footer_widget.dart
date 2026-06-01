import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/core/widgets/youpass_link_text.dart';

class ChangeNumberFooterWidget extends StatelessWidget {
  const ChangeNumberFooterWidget({
    super.key,
    required this.onChangeNumber,
  });

  final VoidCallback onChangeNumber;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final strings = context.l10n;

    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Divider(color: Colors.grey.shade300)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: layout.spacing(12)),
              child: AppText(
                strings.incorrectNumberQuestion,
                variant: AppTextVariant.sectionCaption,
              ),
            ),
            Expanded(child: Divider(color: Colors.grey.shade300)),
          ],
        ),
        SizedBox(height: layout.spacing(16)),
        YouPassLinkText(
          label: strings.changeNumberLink,
          color: AppColors.primaryMustard,
          onTap: onChangeNumber,
        ),
      ],
    );
  }
}
