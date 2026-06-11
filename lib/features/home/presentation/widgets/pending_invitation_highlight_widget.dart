import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';

class PendingInvitationHighlightWidget extends StatelessWidget {
  const PendingInvitationHighlightWidget({
    super.key,
    required this.pendingCount,
    this.eventTitle,
    required this.onTap,
  });

  final int pendingCount;
  final String? eventTitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final strings = context.l10n;
    final title = eventTitle?.trim().isNotEmpty == true
        ? eventTitle!.trim()
        : strings.drawerMyInvitations;

    return Padding(
      padding: EdgeInsets.only(bottom: layout.spacing(16)),
      child: Material(
        color: AppColors.primaryMustard.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(layout.radius(12)),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(layout.radius(12)),
          child: Padding(
            padding: EdgeInsets.all(layout.spacing(14)),
            child: Row(
              children: [
                Icon(
                  Icons.mail_outline,
                  color: AppColors.primaryMustard,
                  size: layout.iconSize,
                ),
                SizedBox(width: layout.spacing(12)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        title,
                        variant: AppTextVariant.bodyEmphasis,
                      ),
                      if (pendingCount > 0) ...[
                        SizedBox(height: layout.spacing(4)),
                        AppText(
                          '$pendingCount',
                          variant: AppTextVariant.body,
                          color: AppColors.profileLabelGrey,
                        ),
                      ],
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: AppColors.profileLabelGrey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
