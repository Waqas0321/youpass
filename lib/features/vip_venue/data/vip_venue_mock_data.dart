import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/features/vip_venue/domain/entities/ticket_offering_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/ticket_offering_section.dart';
import 'package:youpass/features/vip_venue/domain/entities/venue_floor_plan_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/venue_table_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/venue_table_status.dart';
import 'package:youpass/features/vip_venue/domain/entities/venue_zone_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/venue_zone_kind.dart';
import 'package:youpass/features/vip_venue/domain/entities/venue_zone_status.dart';
import 'package:youpass/l10n/app_localizations.dart';

class VipVenueMockData {
  VipVenueMockData._();

  static const String vipZone1Id = 'vip-1';
  static const String vipZone2Id = 'vip-2';
  static const String vipDjZoneId = 'vip-dj';
  static const String stageZoneId = 'stage';
  static const String danceFloorZoneId = 'dance-floor';
  static const String mockEntryCode = '8F7A2B';

  static List<TicketOfferingEntity> ticketOfferings(AppLocalizations l10n) {
    return [
      ...generalTicketOfferings(l10n),
      vipGeneralTicketOffering(l10n),
    ];
  }

  static List<TicketOfferingEntity> generalTicketOfferings(AppLocalizations l10n) {
    final description = AppStrings.vipOfferingGeneralAccessDescription(l10n);

    return [
      TicketOfferingEntity(
        id: 'preventa-1',
        label: AppStrings.vipOfferingPreventa1(l10n),
        price: 10000,
        section: TicketOfferingSection.general,
        description: description,
      ),
      TicketOfferingEntity(
        id: 'preventa-2',
        label: AppStrings.vipOfferingPreventa2(l10n),
        price: 13000,
        section: TicketOfferingSection.general,
        description: description,
      ),
      TicketOfferingEntity(
        id: 'general-cover',
        label: AppStrings.vipOfferingGeneralCover(l10n),
        price: 18000,
        section: TicketOfferingSection.general,
        description: description,
      ),
    ];
  }

  static TicketOfferingEntity vipGeneralTicketOffering(AppLocalizations l10n) {
    return TicketOfferingEntity(
      id: 'vip-general',
      label: AppStrings.vipOfferingVipGeneral(l10n),
      price: 35000,
      section: TicketOfferingSection.vip,
      description: AppStrings.vipOfferingGeneralAccessDescription(l10n),
      badgeLabel: AppStrings.vipOfferingWithoutTable(l10n),
    );
  }

  static VenueFloorPlanEntity floorPlan(AppLocalizations l10n) {
    return VenueFloorPlanEntity(
      venueName: AppStrings.vipFloorPlanVenueName(l10n),
      dimensionsLabel: AppStrings.vipFloorPlanDimensions(l10n),
      zones: [
        VenueZoneEntity(
          id: vipZone1Id,
          kind: VenueZoneKind.vip1,
          name: AppStrings.vipZone1Name(l10n),
          status: VenueZoneStatus.available,
          capacityPerTable: 10,
        ),
        VenueZoneEntity(
          id: vipDjZoneId,
          kind: VenueZoneKind.vipDj,
          name: AppStrings.vipZoneDj(l10n),
          status: VenueZoneStatus.premium,
          capacityPerTable: 15,
        ),
        VenueZoneEntity(
          id: vipZone2Id,
          kind: VenueZoneKind.vip2,
          name: AppStrings.vipZone2Name(l10n),
          status: VenueZoneStatus.available,
          capacityPerTable: 10,
        ),
        VenueZoneEntity(
          id: stageZoneId,
          kind: VenueZoneKind.stage,
          name: AppStrings.vipZoneStage(l10n),
          status: VenueZoneStatus.premium,
          isSelectable: false,
        ),
        VenueZoneEntity(
          id: danceFloorZoneId,
          kind: VenueZoneKind.danceFloor,
          name: AppStrings.vipZoneDanceFloor(l10n),
          status: VenueZoneStatus.sold,
          isSelectable: false,
        ),
      ],
    );
  }

  static VenueZoneEntity? zoneByKind(
    List<VenueZoneEntity> zones,
    VenueZoneKind kind,
  ) {
    for (final zone in zones) {
      if (zone.kind == kind) {
        return zone;
      }
    }
    return null;
  }

  static List<VenueTableEntity> tablesForZone(String zoneId) {
    if (zoneId != vipZone1Id) {
      return const [];
    }

    return const [
      VenueTableEntity(
        id: 'm1',
        label: 'M1',
        zoneId: vipZone1Id,
        status: VenueTableStatus.available,
        price: 320000,
        capacity: 10,
        bottleCount: 2,
        voucherCount: 20,
      ),
      VenueTableEntity(
        id: 'm2',
        label: 'M2',
        zoneId: vipZone1Id,
        status: VenueTableStatus.available,
        price: 320000,
        capacity: 10,
        bottleCount: 2,
        voucherCount: 20,
      ),
      VenueTableEntity(
        id: 'm3',
        label: 'M3',
        zoneId: vipZone1Id,
        status: VenueTableStatus.sold,
        price: 320000,
        capacity: 10,
        bottleCount: 2,
        voucherCount: 20,
      ),
      VenueTableEntity(
        id: 'm4',
        label: 'M4',
        zoneId: vipZone1Id,
        status: VenueTableStatus.available,
        price: 320000,
        capacity: 10,
        bottleCount: 2,
        voucherCount: 20,
      ),
      VenueTableEntity(
        id: 'm5',
        label: 'M5',
        zoneId: vipZone1Id,
        status: VenueTableStatus.available,
        price: 320000,
        capacity: 10,
        bottleCount: 2,
        voucherCount: 20,
      ),
      VenueTableEntity(
        id: 'm6',
        label: 'M6',
        zoneId: vipZone1Id,
        status: VenueTableStatus.sold,
        price: 320000,
        capacity: 10,
        bottleCount: 2,
        voucherCount: 20,
      ),
      VenueTableEntity(
        id: 'm7',
        label: 'M7',
        zoneId: vipZone1Id,
        status: VenueTableStatus.available,
        price: 320000,
        capacity: 10,
        bottleCount: 2,
        voucherCount: 20,
      ),
      VenueTableEntity(
        id: 'm8',
        label: 'M8',
        zoneId: vipZone1Id,
        status: VenueTableStatus.available,
        price: 320000,
        capacity: 10,
        bottleCount: 2,
        voucherCount: 20,
      ),
    ];
  }
}
