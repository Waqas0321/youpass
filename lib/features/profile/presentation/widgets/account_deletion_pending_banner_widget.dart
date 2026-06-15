import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_design_spec.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_theme.dart';

class AccountDeletionPendingBannerWidget extends StatelessWidget {
  const AccountDeletionPendingBannerWidget({
    super.key,
    required this.daysRemaining,
    this.deletionScheduledAt,
    required this.onCancelTap,
  });

  final int daysRemaining;
  final DateTime? deletionScheduledAt;
  final VoidCallback onCancelTap;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final theme = ProfileTheme.of(context);
    final scheduledLabel = _formatScheduledDate(context);

    return Material(
      color: const Color(0xFF3A1515),
      borderRadius: BorderRadius.circular(ProfileDesignSpec.px(context, 12)),
      child: InkWell(
        onTap: onCancelTap,
        borderRadius: BorderRadius.circular(ProfileDesignSpec.px(context, 12)),
        child: Padding(
          padding: EdgeInsets.all(ProfileDesignSpec.px(context, 14)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: theme.deleteButtonForeground,
                size: ProfileDesignSpec.px(context, 22),
              ),
              SizedBox(width: ProfileDesignSpec.px(context, 12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.accountDeletionPendingBannerTitle(strings),
                      style: TextStyle(
                        color: theme.deleteButtonForeground,
                        fontWeight: FontWeight.w700,
                        fontSize: ProfileDesignSpec.px(context, 14),
                      ),
                    ),
                    SizedBox(height: ProfileDesignSpec.px(context, 4)),
                    Text(
                      scheduledLabel == null
                          ? AppStrings.profileDeletePendingMessage(
                              strings,
                              daysRemaining,
                            )
                          : AppStrings.accountDeletionPendingBannerSubtitle(
                              strings,
                              scheduledLabel,
                              daysRemaining,
                            ),
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        height: 1.35,
                        fontSize: ProfileDesignSpec.px(context, 13),
                      ),
                    ),
                    SizedBox(height: ProfileDesignSpec.px(context, 8)),
                    Text(
                      AppStrings.accountDeletionCancelAction(strings),
                      style: TextStyle(
                        color: theme.deleteButtonForeground,
                        fontWeight: FontWeight.w700,
                        fontSize: ProfileDesignSpec.px(context, 13),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _formatScheduledDate(BuildContext context) {
    if (deletionScheduledAt == null) {
      return null;
    }

    final locale = Localizations.localeOf(context).toString();
    return DateFormat.yMMMd(locale).format(deletionScheduledAt!.toLocal());
  }
}
