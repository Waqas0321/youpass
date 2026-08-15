import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/core/widgets/auth_bottom_sheet_shell.dart';
import 'package:youpass/features/home/domain/entities/home_feed_meta_entity.dart';

/// Lets the user pick which event drink menu to open when multiple tickets qualify.
class PartyDrinkEventChooserSheet {
  PartyDrinkEventChooserSheet._();

  static Future<HomePartyModeEligibleEventEntity?> show(
    BuildContext context, {
    required List<HomePartyModeEligibleEventEntity> events,
    String? recommendedEventId,
  }) {
    final l10n = context.l10n;
    return AuthBottomSheetShell.show<HomePartyModeEligibleEventEntity>(
      context: context,
      title: AppStrings.partyDrinkEventChooserTitle(l10n),
      maxHeightFactor: 0.62,
      child: _PartyDrinkEventChooserBody(
        events: events,
        recommendedEventId: recommendedEventId,
      ),
    );
  }
}

class _PartyDrinkEventChooserBody extends StatelessWidget {
  const _PartyDrinkEventChooserBody({
    required this.events,
    this.recommendedEventId,
  });

  final List<HomePartyModeEligibleEventEntity> events;
  final String? recommendedEventId;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final l10n = context.l10n;
    final dateFormat = DateFormat('EEE d MMM · HH:mm');

    return ListView(
      padding: EdgeInsets.fromLTRB(
        layout.spacing(24),
        0,
        layout.spacing(24),
        layout.spacing(24),
      ),
      children: [
        AppText(
          AppStrings.partyDrinkEventChooserSubtitle(l10n),
          variant: AppTextVariant.body,
          color: AppColors.secondaryGrey,
          fontSize: layout.fontSize(13),
        ),
        SizedBox(height: layout.spacing(16)),
        for (final event in events) ...[
          _EventOptionTile(
            title: event.eventTitle,
            subtitle: event.startsAt == null
                ? null
                : dateFormat.format(event.startsAt!.toLocal()),
            isRecommended: event.eventId == recommendedEventId,
            recommendedLabel:
                AppStrings.partyDrinkEventChooserRecommended(l10n),
            onTap: () => Navigator.of(context).pop(event),
          ),
          SizedBox(height: layout.spacing(10)),
        ],
      ],
    );
  }
}

class _EventOptionTile extends StatelessWidget {
  const _EventOptionTile({
    required this.title,
    required this.onTap,
    required this.recommendedLabel,
    this.subtitle,
    this.isRecommended = false,
  });

  final String title;
  final String? subtitle;
  final String recommendedLabel;
  final bool isRecommended;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return Material(
      color: isRecommended
          ? AppColors.drawerMenuHighlight
          : AppColors.backgroundWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(layout.radius(14)),
        side: BorderSide(
          color: isRecommended
              ? AppColors.homeAccentYellow
              : AppColors.lightGreyBorder,
          width: isRecommended ? 1.5 : 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: layout.spacing(16),
            vertical: layout.spacing(14),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isRecommended) ...[
                      AppText(
                        recommendedLabel,
                        variant: AppTextVariant.sectionCaption,
                        color: AppColors.homeAccentYellow,
                        fontSize: layout.fontSize(11),
                        fontWeight: FontWeight.w700,
                      ),
                      SizedBox(height: layout.spacing(4)),
                    ],
                    AppText(
                      title,
                      variant: AppTextVariant.bodyEmphasis,
                      color: AppColors.homeBlack,
                      fontSize: layout.fontSize(15),
                      fontWeight: FontWeight.w700,
                    ),
                    if (subtitle != null) ...[
                      SizedBox(height: layout.spacing(4)),
                      AppText(
                        subtitle!,
                        variant: AppTextVariant.label,
                        color: AppColors.secondaryGrey,
                        fontSize: layout.fontSize(12),
                      ),
                    ],
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: AppColors.homeBlack,
                size: layout.spacing(22),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
