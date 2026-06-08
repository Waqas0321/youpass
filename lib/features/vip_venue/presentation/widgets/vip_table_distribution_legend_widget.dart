import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_design_spec.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_map_theme.dart';
import 'package:youpass/features/vip_venue/presentation/widgets/vip_shared_widgets.dart';

class VipTableDistributionLegendWidget extends StatelessWidget {
  const VipTableDistributionLegendWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        VipLegendItemWidget(
          color: VipVenueMapTheme.tableAvailable,
          label: AppStrings.vipLegendTableAvailable(strings),
          shape: VipLegendIndicatorShape.dot,
          labelColor: VipVenueMapTheme.legendLabel(context),
        ),
        SizedBox(width: VipVenueDesignSpec.px(context, 18)),
        VipLegendItemWidget(
          color: VipVenueMapTheme.tableSelected,
          label: AppStrings.vipLegendTableSelection(strings),
          shape: VipLegendIndicatorShape.dot,
          labelColor: VipVenueMapTheme.legendLabel(context),
        ),
        SizedBox(width: VipVenueDesignSpec.px(context, 18)),
        VipLegendItemWidget(
          color: VipVenueMapTheme.tableOccupied,
          label: AppStrings.vipLegendTableSold(strings),
          shape: VipLegendIndicatorShape.dot,
          labelColor: VipVenueMapTheme.legendLabel(context),
        ),
      ],
    );
  }
}
