import 'package:flutter/material.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';

enum StaffConnectionStatusStyle {
  standard,
  supervisorCompact,
}

class StaffConnectionStatusBar extends StatelessWidget {
  const StaffConnectionStatusBar({
    super.key,
    this.isConnected = true,
    this.isOnline = true,
    this.validatorLabel,
    this.style = StaffConnectionStatusStyle.standard,
  });

  final bool isConnected;
  final bool isOnline;
  final String? validatorLabel;
  final StaffConnectionStatusStyle style;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final layout = ResponsiveLayout(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(
        layout.spacing(16),
        layout.spacing(8),
        layout.spacing(16),
        layout.spacing(12),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: layout.spacing(20),
          vertical: layout.spacing(14),
        ),
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          borderRadius: BorderRadius.circular(layout.radius(20)),
          border: Border.all(color: AppColors.homeDividerGrey),
          boxShadow: [
            BoxShadow(
              color: AppColors.scrimBase.withValues(alpha: 0.04),
              blurRadius: layout.spacing(12),
              offset: Offset(0, layout.spacing(2)),
            ),
          ],
        ),
        child: style == StaffConnectionStatusStyle.supervisorCompact
            ? _SupervisorCompactRow(
                layout: layout,
                l10n: l10n,
                isOnline: isOnline,
                validatorLabel: validatorLabel,
              )
            : Row(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.wifi_rounded,
                        size: layout.spacing(18),
                        color: isConnected
                            ? AppColors.homeBlack
                            : AppColors.profileDeleteRed,
                      ),
                      SizedBox(width: layout.spacing(6)),
                      AppText(
                        isConnected
                            ? l10n.staffConnectedLabel
                            : l10n.staffDisconnectedLabel,
                        variant: AppTextVariant.bodyEmphasis,
                        color: AppColors.homeBlack,
                        fontWeight: FontWeight.w700,
                        fontSize: layout.fontSize(14),
                      ),
                    ],
                  ),
                  if (validatorLabel != null) ...[
                    SizedBox(width: layout.spacing(8)),
                    Expanded(
                      child: AppText(
                        validatorLabel!,
                        variant: AppTextVariant.body,
                        color: AppColors.secondaryGrey,
                        fontSize: layout.fontSize(13),
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ] else
                    const Spacer(),
                  SizedBox(width: layout.spacing(8)),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: layout.spacing(8),
                        height: layout.spacing(8),
                        decoration: BoxDecoration(
                          color: isOnline
                              ? const Color(0xFF22C55E)
                              : AppColors.secondaryGrey,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: layout.spacing(6)),
                      AppText(
                        isOnline ? l10n.staffOnlineStatus : l10n.staffAwayStatus,
                        variant: AppTextVariant.body,
                        color: AppColors.secondaryGrey,
                        fontSize: layout.fontSize(14),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}

class _SupervisorCompactRow extends StatelessWidget {
  const _SupervisorCompactRow({
    required this.layout,
    required this.l10n,
    required this.isOnline,
    required this.validatorLabel,
  });

  final ResponsiveLayout layout;
  final dynamic l10n;
  final bool isOnline;
  final String? validatorLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: layout.spacing(8),
          height: layout.spacing(8),
          decoration: BoxDecoration(
            color: isOnline ? const Color(0xFF22C55E) : AppColors.secondaryGrey,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: layout.spacing(8)),
        AppText(
          isOnline ? l10n.staffOnlineStatus : l10n.staffAwayStatus,
          variant: AppTextVariant.bodyEmphasis,
          color: AppColors.homeBlack,
          fontWeight: FontWeight.w800,
          fontSize: layout.fontSize(14),
        ),
        if (validatorLabel != null) ...[
          SizedBox(width: layout.spacing(12)),
          Container(
            width: 1,
            height: layout.spacing(18),
            color: AppColors.homeDividerGrey,
          ),
          SizedBox(width: layout.spacing(12)),
          Expanded(
            child: AppText(
              validatorLabel!,
              variant: AppTextVariant.body,
              color: AppColors.secondaryGrey,
              fontSize: layout.fontSize(13),
              fontWeight: FontWeight.w600,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ],
    );
  }
}
