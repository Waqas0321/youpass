import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/vip_venue/data/vip_venue_mock_data.dart';
import 'package:youpass/features/vip_venue/domain/entities/venue_zone_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/venue_zone_kind.dart';
import 'package:youpass/features/vip_venue/domain/entities/venue_zone_status.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_design_spec.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_map_theme.dart';
import 'package:youpass/features/vip_venue/presentation/widgets/venue_map_painters.dart';
import 'package:youpass/features/vip_venue/presentation/widgets/vip_shared_widgets.dart';

class VenueMapLegendWidget extends StatelessWidget {
  const VenueMapLegendWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        VipLegendItemWidget(
          color: VipVenueMapTheme.neonGreen,
          label: AppStrings.vipLegendAvailableShort(strings),
          labelColor: VipVenueMapTheme.legendLabel(context),
        ),
        SizedBox(width: VipVenueDesignSpec.px(context, 20)),
        VipLegendItemWidget(
          color: VipVenueMapTheme.neonPink,
          label: AppStrings.vipLegendPremium(strings),
          labelColor: VipVenueMapTheme.legendLabel(context),
        ),
        SizedBox(width: VipVenueDesignSpec.px(context, 20)),
        VipLegendItemWidget(
          color: VipVenueMapTheme.neonPurple,
          label: AppStrings.vipLegendSold(strings),
          labelColor: VipVenueMapTheme.legendLabel(context),
        ),
      ],
    );
  }
}

class VenueFloorPlanWidget extends StatelessWidget {
  const VenueFloorPlanWidget({
    super.key,
    required this.zones,
    required this.onZoneTap,
  });

  final List<VenueZoneEntity> zones;
  final ValueChanged<VenueZoneEntity> onZoneTap;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final padding = VipVenueDesignSpec.px(context, 12);
    final radius = VipVenueDesignSpec.px(context, 18);
    final vip1 = VipVenueMockData.zoneByKind(zones, VenueZoneKind.vip1);
    final vipDj = VipVenueMockData.zoneByKind(zones, VenueZoneKind.vipDj);
    final vip2 = VipVenueMockData.zoneByKind(zones, VenueZoneKind.vip2);
    final stage = VipVenueMockData.zoneByKind(zones, VenueZoneKind.stage);
    final danceFloor =
        VipVenueMockData.zoneByKind(zones, VenueZoneKind.danceFloor);

    return Container(
      decoration: BoxDecoration(
        color: VipVenueMapTheme.mapCanvasBackground(context),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: VipVenueMapTheme.mapFrameBorder(context),
          width: 2,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _YouFestMapHeader(),
          Padding(
            padding: EdgeInsets.fromLTRB(padding, 0, padding, padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (vip1 != null && vipDj != null && vip2 != null)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _VipZoneCard(
                          zone: vip1,
                          zonePrefix: AppStrings.vipZoneLabel(strings),
                          capacityLabel: AppStrings.vipZoneCapacity(
                            strings,
                            vip1.capacityPerTable ?? 10,
                          ),
                          onTap: () => onZoneTap(vip1),
                        ),
                      ),
                      SizedBox(width: VipVenueDesignSpec.px(context, 8)),
                      Expanded(
                        child: _VipZoneCard(
                          zone: vipDj,
                          zonePrefix: AppStrings.vipZoneLabel(strings),
                          capacityLabel: AppStrings.vipZoneCapacity(
                            strings,
                            vipDj.capacityPerTable ?? 15,
                          ),
                          onTap: vipDj.isSelectable &&
                                  vipDj.status != VenueZoneStatus.sold
                              ? () => onZoneTap(vipDj)
                              : null,
                        ),
                      ),
                      SizedBox(width: VipVenueDesignSpec.px(context, 8)),
                      Expanded(
                        child: _VipZoneCard(
                          zone: vip2,
                          zonePrefix: AppStrings.vipZoneLabel(strings),
                          capacityLabel: AppStrings.vipZoneCapacity(
                            strings,
                            vip2.capacityPerTable ?? 10,
                          ),
                          onTap: vip2.isSelectable &&
                                  vip2.status != VenueZoneStatus.sold
                              ? () => onZoneTap(vip2)
                              : null,
                        ),
                      ),
                    ],
                  ),
                if (stage != null) ...[
                  SizedBox(height: VipVenueDesignSpec.px(context, 10)),
                  _StageBar(label: stage.name),
                ],
                if (danceFloor != null) ...[
                  SizedBox(height: VipVenueDesignSpec.px(context, 10)),
                  _DanceFloorSection(
                    title: danceFloor.name,
                    subtitle: AppStrings.vipDanceFloorGeneral(strings),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _YouFestMapHeader extends StatelessWidget {
  const _YouFestMapHeader();

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final logoSize = VipVenueDesignSpec.px(context, 34);

    return Padding(
      padding: EdgeInsets.fromLTRB(
        VipVenueDesignSpec.px(context, 12),
        VipVenueDesignSpec.px(context, 14),
        VipVenueDesignSpec.px(context, 12),
        VipVenueDesignSpec.px(context, 10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: logoSize,
                height: logoSize,
                child: CustomPaint(
                  painter: YouFestBunnyLogoPainter(
                    color: VipVenueMapTheme.neonPink,
                  ),
                ),
              ),
              Text(
                AppStrings.vipYouFestBrand(strings),
                style: TextStyle(
                  color: VipVenueMapTheme.neonPink,
                  fontSize: VipVenueDesignSpec.px(context, 24),
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
          SizedBox(height: VipVenueDesignSpec.px(context, 10)),
          SizedBox(
            height: VipVenueDesignSpec.px(context, 30),
            child: CustomPaint(
              painter: VenueMapDashedBorderPainter(
                color: VipVenueMapTheme.emergencyExitBorder(context),
                radius: VipVenueDesignSpec.px(context, 8),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: VipVenueDesignSpec.px(context, 10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.emergency_outlined,
                      size: VipVenueDesignSpec.px(context, 14),
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                    SizedBox(width: VipVenueDesignSpec.px(context, 8)),
                    Text(
                      AppStrings.vipEmergencyExit(strings),
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: VipVenueDesignSpec.px(context, 11),
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.6,
                      ),
                    ),
                    SizedBox(width: VipVenueDesignSpec.px(context, 8)),
                    Icon(
                      Icons.emergency_outlined,
                      size: VipVenueDesignSpec.px(context, 14),
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _VipZoneCard extends StatelessWidget {
  const _VipZoneCard({
    required this.zone,
    required this.zonePrefix,
    required this.capacityLabel,
    required this.onTap,
  });

  final VenueZoneEntity zone;
  final String zonePrefix;
  final String capacityLabel;
  final VoidCallback? onTap;

  Color get borderColor {
    switch (zone.status) {
      case VenueZoneStatus.available:
        return VipVenueMapTheme.neonGreen;
      case VenueZoneStatus.premium:
        return VipVenueMapTheme.neonPink;
      case VenueZoneStatus.sold:
        return VipVenueMapTheme.neonPurple;
    }
  }

  Color get iconBackground {
    switch (zone.status) {
      case VenueZoneStatus.available:
        return VipVenueMapTheme.neonGreen.withValues(alpha: 0.18);
      case VenueZoneStatus.premium:
        return VipVenueMapTheme.neonPink.withValues(alpha: 0.18);
      case VenueZoneStatus.sold:
        return VipVenueMapTheme.neonPurple.withValues(alpha: 0.18);
    }
  }

  IconData get icon {
    switch (zone.kind) {
      case VenueZoneKind.vipDj:
        return Icons.headphones;
      case VenueZoneKind.vip1:
      case VenueZoneKind.vip2:
      case VenueZoneKind.stage:
      case VenueZoneKind.danceFloor:
        return Icons.diamond_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final iconSize = VipVenueDesignSpec.px(context, 38);

    return Material(
      color: VipVenueMapTheme.mapInnerBlack,
      borderRadius: BorderRadius.circular(VipVenueDesignSpec.px(context, 12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(VipVenueDesignSpec.px(context, 12)),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: VipVenueDesignSpec.px(context, 6),
            vertical: VipVenueDesignSpec.px(context, 10),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(VipVenueDesignSpec.px(context, 12)),
            border: Border.all(color: borderColor, width: 2),
          ),
          child: Column(
            children: [
              Container(
                width: iconSize,
                height: iconSize,
                decoration: BoxDecoration(
                  color: iconBackground,
                  shape: BoxShape.circle,
                  border: Border.all(color: borderColor, width: 1.5),
                ),
                child: Icon(
                  icon,
                  color: borderColor,
                  size: VipVenueDesignSpec.px(context, 18),
                ),
              ),
              SizedBox(height: VipVenueDesignSpec.px(context, 6)),
              Text(
                zonePrefix,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.75),
                  fontSize: VipVenueDesignSpec.px(context, 9),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                ),
              ),
              Text(
                zone.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: VipVenueMapTheme.zoneLabelText(context),
                  fontSize: VipVenueDesignSpec.px(context, 13),
                  fontWeight: FontWeight.w900,
                  height: 1.05,
                ),
              ),
              SizedBox(height: VipVenueDesignSpec.px(context, 4)),
              Text(
                capacityLabel,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.65),
                  fontSize: VipVenueDesignSpec.px(context, 8),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StageBar extends StatelessWidget {
  const _StageBar({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: VipVenueDesignSpec.px(context, 8),
      ),
      decoration: BoxDecoration(
        color: VipVenueMapTheme.mapInnerBlack,
        borderRadius: BorderRadius.circular(VipVenueDesignSpec.px(context, 10)),
        border: Border.all(
          color: VipVenueMapTheme.stageBorder(context),
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.headphones,
            color: VipVenueMapTheme.neonPink,
            size: VipVenueDesignSpec.px(context, 16),
          ),
          SizedBox(width: VipVenueDesignSpec.px(context, 8)),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: VipVenueDesignSpec.px(context, 12),
              fontWeight: FontWeight.w800,
              letterSpacing: 0.6,
            ),
          ),
        ],
      ),
    );
  }
}

class _DanceFloorSection extends StatelessWidget {
  const _DanceFloorSection({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final height = VipVenueDesignSpec.px(context, 170);
    final radius = VipVenueDesignSpec.px(context, 12);

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: SizedBox(
        height: height,
        child: Stack(
          fit: StackFit.expand,
          children: [
            DecoratedBox(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    VipVenueMapTheme.danceFloorPurple,
                    VipVenueMapTheme.danceFloorPurpleDark,
                    VipVenueMapTheme.mapBlack,
                  ],
                  stops: [0.0, 0.55, 1.0],
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              width: VipVenueDesignSpec.px(context, 42),
              child: CustomPaint(
                painter: VenueMapHalftonePainter(
                  dotColor: Colors.white.withValues(alpha: 0.08),
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              width: VipVenueDesignSpec.px(context, 42),
              child: CustomPaint(
                painter: VenueMapHalftonePainter(
                  dotColor: Colors.white.withValues(alpha: 0.08),
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(height: VipVenueDesignSpec.px(context, 10)),
                SizedBox(
                  width: VipVenueDesignSpec.px(context, 42),
                  height: VipVenueDesignSpec.px(context, 42),
                  child: CustomPaint(
                    painter: YouFestBunnyLogoPainter(
                      color: VipVenueMapTheme.neonPink,
                    ),
                  ),
                ),
                SizedBox(height: VipVenueDesignSpec.px(context, 6)),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: VipVenueDesignSpec.px(context, 16),
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.75),
                    fontSize: VipVenueDesignSpec.px(context, 11),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: height * 0.42,
              child: CustomPaint(
                painter: VenueMapCrowdPainter(
                  color: Colors.black.withValues(alpha: 0.85),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
