import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_assets.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/widgets/app_asset_image.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/core/widgets/youpass_compact_button.dart';
import 'package:youpass/features/home/domain/entities/event_item_entity.dart';

class EventListCardWidget extends StatelessWidget {
  const EventListCardWidget({
    super.key,
    required this.event,
    this.onBuyTickets,
  });

  final EventItemEntity event;
  final VoidCallback? onBuyTickets;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final thumbnailSize = layout.spacing(88);

    return Container(
      padding: EdgeInsets.all(layout.spacing(12)),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(layout.radius(14)),
        border: Border.all(color: AppColors.homeDividerGrey),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppAssetImage(
            assetPath: AppAssets.dummyImage,
            width: thumbnailSize,
            height: thumbnailSize,
            borderRadius: BorderRadius.circular(layout.radius(12)),
          ),
          SizedBox(width: layout.spacing(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: AppText(
                        event.title,
                        variant: AppTextVariant.listTitle,
                        fontSize: layout.fontSize(16),
                      ),
                    ),
                    Icon(
                      Icons.favorite_border,
                      size: layout.fontSize(20),
                      color: AppColors.homeBlack,
                    ),
                  ],
                ),
                SizedBox(height: layout.spacing(8)),
                EventMetaRow(
                  icon: Icons.calendar_today_outlined,
                  label: event.dateLabel,
                  labelColor: AppColors.homeAccentYellow,
                ),
                SizedBox(height: layout.spacing(4)),
                EventMetaRow(
                  icon: Icons.location_on_outlined,
                  label: event.locationLabel,
                ),
                SizedBox(height: layout.spacing(10)),
                Align(
                  alignment: Alignment.centerRight,
                  child: YouPassCompactButton(
                    label: AppStrings.buyTickets(context.l10n),
                    onPressed: onBuyTickets ?? () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EventMetaRow extends StatelessWidget {
  const EventMetaRow({
    super.key,
    required this.icon,
    required this.label,
    this.labelColor,
  });

  final IconData icon;
  final String label;
  final Color? labelColor;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: layout.fontSize(14),
          color: labelColor ?? AppColors.secondaryGrey,
        ),
        SizedBox(width: layout.spacing(6)),
        Expanded(
          child: AppText(
            label,
            variant: AppTextVariant.body,
            color: labelColor ?? AppColors.secondaryGrey,
            fontSize: layout.fontSize(12),
            fontWeight: labelColor != null ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
