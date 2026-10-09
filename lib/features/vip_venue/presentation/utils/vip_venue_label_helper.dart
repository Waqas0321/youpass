import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/features/vip_venue/domain/entities/ticket_offering_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/ticket_offering_section.dart';
import 'package:youpass/features/vip_venue/domain/entities/venue_zone_entity.dart';
import 'package:youpass/l10n/app_localizations.dart';

class VipVenueLabelHelper {
  VipVenueLabelHelper._();

  /// "Table 1" / "Mesa 1" / "M11" -> "1" / "11". Strings like "Table {table}"
  /// already add the word, so the raw admin label would read "Table Table 1".
  static String tableDisplayNumber(String label) {
    final trimmed = label.trim();
    final withoutWord = trimmed.replaceFirst(
      RegExp(r'^(table|mesa)\s*', caseSensitive: false),
      '',
    );
    if (withoutWord != trimmed && withoutWord.isNotEmpty) {
      return withoutWord;
    }
    return RegExp(r'^M\d').hasMatch(trimmed) ? trimmed.substring(1) : trimmed;
  }

  static String offeringDescription(
    AppLocalizations l10n,
    TicketOfferingEntity offering,
  ) {
    final apiDescription = offering.description?.trim();
    if (apiDescription != null && apiDescription.isNotEmpty) {
      return apiDescription;
    }

    if (offering.section == TicketOfferingSection.vip) {
      return AppStrings.vipOfferingWithoutTable(l10n);
    }

    return AppStrings.vipOfferingGeneralAccessDescription(l10n);
  }

  static String zoneScreenTitle(AppLocalizations l10n, VenueZoneEntity zone) {
    return AppStrings.vipZoneTablesScreenTitle(l10n, zone.name);
  }

  static String tablesCapacitySubtitle(
    AppLocalizations l10n,
    VenueZoneEntity zone,
  ) {
    return AppStrings.vipTablesCapacitySubtitle(
      l10n,
      zone.capacityPerTable ?? 10,
    );
  }

  static String tableReserveLabel(AppLocalizations l10n, String tableLabel) {
    return AppStrings.vipTableReserve(l10n, tableDisplayNumber(tableLabel));
  }
}
