import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/vip_venue/domain/entities/venue_table_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/venue_table_status.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_design_spec.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_map_theme.dart';

class VipTableDistributionMapWidget extends StatelessWidget {
  const VipTableDistributionMapWidget({
    super.key,
    required this.zoneName,
    required this.tables,
    required this.selectedTableId,
    required this.onTableTap,
  });

  final String zoneName;
  final List<VenueTableEntity> tables;
  final String? selectedTableId;
  final ValueChanged<VenueTableEntity> onTableTap;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final padding = VipVenueDesignSpec.px(context, 16);
    final radius = VipVenueDesignSpec.px(context, 18);

    return Container(
      decoration: BoxDecoration(
        color: VipVenueMapTheme.tableDistributionCanvas,
        borderRadius: BorderRadius.circular(radius),
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: EdgeInsets.fromLTRB(padding, padding, padding, padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              AppStrings.vipTableDistributionTitle(strings, zoneName),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: VipVenueMapTheme.tableDistributionTitleText,
                fontSize: VipVenueDesignSpec.px(context, 13),
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
              ),
            ),
            SizedBox(height: VipVenueDesignSpec.px(context, 18)),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: VipVenueDesignSpec.px(context, 14),
                crossAxisSpacing: VipVenueDesignSpec.px(context, 8),
                childAspectRatio: 0.92,
              ),
              itemCount: tables.length,
              itemBuilder: (context, index) {
                final table = tables[index];
                return VipTableSeatWidget(
                  table: table,
                  isSelected: table.id == selectedTableId,
                  onTap: table.status == VenueTableStatus.sold
                      ? null
                      : () => onTableTap(table),
                );
              },
            ),
            SizedBox(height: VipVenueDesignSpec.px(context, 16)),
            _StageFooter(label: AppStrings.vipTableDistributionStage(strings)),
          ],
        ),
      ),
    );
  }
}

class VipTableSeatWidget extends StatelessWidget {
  const VipTableSeatWidget({
    super.key,
    required this.table,
    required this.isSelected,
    required this.onTap,
  });

  final VenueTableEntity table;
  final bool isSelected;
  final VoidCallback? onTap;

  Color tableColor() {
    if (isSelected) {
      return VipVenueMapTheme.tableSelected;
    }
    switch (table.status) {
      case VenueTableStatus.available:
        return table.showsAsPremium
            ? VipVenueMapTheme.tablePremium
            : VipVenueMapTheme.tableAvailable;
      case VenueTableStatus.premium:
        return VipVenueMapTheme.tablePremium;
      case VenueTableStatus.sold:
        return VipVenueMapTheme.tableOccupied;
      case VenueTableStatus.locked:
        return VipVenueMapTheme.tableBlocked;
      case VenueTableStatus.selected:
        return VipVenueMapTheme.tableSelected;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = tableColor();
    final tableSize = VipVenueDesignSpec.px(context, 46);
    final orbitRadius = VipVenueDesignSpec.px(context, 30);
    final chairWidth = VipVenueDesignSpec.px(context, 11);
    final chairHeight = VipVenueDesignSpec.px(context, 7);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          height: VipVenueDesignSpec.px(context, 88),
          child: Stack(
            alignment: Alignment.center,
            children: [
              for (var index = 0; index < 8; index++)
                _ChairSeat(
                  color: color,
                  angle: (index * math.pi / 4) - (math.pi / 2),
                  orbitRadius: orbitRadius,
                  width: chairWidth,
                  height: chairHeight,
                ),
              Container(
                width: tableSize,
                height: tableSize,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: isSelected
                      ? Border.all(color: Colors.white, width: 2.5)
                      : null,
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: color.withValues(alpha: 0.65),
                            blurRadius: VipVenueDesignSpec.px(context, 14),
                            spreadRadius: VipVenueDesignSpec.px(context, 2),
                          ),
                        ]
                      : null,
                ),
                alignment: Alignment.center,
                child: Text(
                  table.label,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: VipVenueDesignSpec.px(context, 14),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChairSeat extends StatelessWidget {
  const _ChairSeat({
    required this.color,
    required this.angle,
    required this.orbitRadius,
    required this.width,
    required this.height,
  });

  final Color color;
  final double angle;
  final double orbitRadius;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: Transform.translate(
        offset: Offset(0, -orbitRadius),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(height / 2),
          ),
        ),
      ),
    );
  }
}

class _StageFooter extends StatelessWidget {
  const _StageFooter({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: VipVenueDesignSpec.px(context, 12),
      ),
      decoration: BoxDecoration(
        color: VipVenueMapTheme.tableDistributionStageBar,
        borderRadius: BorderRadius.circular(VipVenueDesignSpec.px(context, 12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.headphones,
            color: VipVenueMapTheme.neonPink,
            size: VipVenueDesignSpec.px(context, 18),
          ),
          SizedBox(width: VipVenueDesignSpec.px(context, 8)),
          Text(
            label,
            style: TextStyle(
              color: VipVenueMapTheme.tableDistributionStageText,
              fontSize: VipVenueDesignSpec.px(context, 13),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
