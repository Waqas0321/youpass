import 'package:youpass/core/utils/json_readers.dart';
import 'package:youpass/features/vip_venue/domain/entities/table_availability_snapshot_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/table_lock_result_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/table_lock_status_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/ticket_offering_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/ticket_offering_section.dart';
import 'package:youpass/features/vip_venue/domain/entities/ticket_types_bundle_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/venue_floor_plan_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/venue_table_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/venue_table_status.dart';
import 'package:youpass/features/vip_venue/domain/entities/venue_zone_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/venue_zone_kind.dart';
import 'package:youpass/features/vip_venue/domain/entities/venue_zone_status.dart';
import 'package:youpass/features/vip_venue/domain/entities/zone_tables_bundle_entity.dart';

class TicketOfferingModel extends TicketOfferingEntity {
  const TicketOfferingModel({
    required super.id,
    required super.label,
    required super.price,
    required super.section,
    super.offeringId,
    super.mapsToTier,
    super.mapsToType,
    super.currency,
    super.description,
    super.badgeLabel,
    super.quantity,
    super.vouchersPerTicket,
    super.isSoldOut,
    super.isSelectable,
  });

  @override
  TicketOfferingModel copyWith({
    int? quantity,
    bool? isSoldOut,
    bool? isSelectable,
  }) {
    return TicketOfferingModel(
      id: id,
      label: label,
      price: price,
      section: section,
      offeringId: offeringId,
      mapsToTier: mapsToTier,
      mapsToType: mapsToType,
      currency: currency,
      description: description,
      badgeLabel: badgeLabel,
      quantity: quantity ?? this.quantity,
      vouchersPerTicket: vouchersPerTicket,
      isSoldOut: isSoldOut ?? this.isSoldOut,
      isSelectable: isSelectable ?? this.isSelectable,
    );
  }

  factory TicketOfferingModel.fromJson(Map<String, dynamic> json) {
    final sectionRaw =
        JsonReaders.string(json, 'section', fallback: 'general').toLowerCase();
    final slug = JsonReaders.nullableString(json, 'slug') ??
        JsonReaders.nullableString(json, 'id') ??
        '';

    return TicketOfferingModel(
      id: slug,
      offeringId: JsonReaders.nullableString(json, 'offering_id') ??
          JsonReaders.nullableString(json, 'offeringId'),
      label: JsonReaders.string(json, 'label'),
      price: JsonReaders.integer(json, 'price'),
      section: sectionRaw == 'vip'
          ? TicketOfferingSection.vip
          : TicketOfferingSection.general,
      mapsToTier: JsonReaders.nullableString(json, 'maps_to_tier') ??
          JsonReaders.nullableString(json, 'mapsToTier'),
      mapsToType: JsonReaders.nullableString(json, 'maps_to_type') ??
          JsonReaders.nullableString(json, 'mapsToType'),
      currency: JsonReaders.string(json, 'currency', fallback: 'CLP'),
      description: JsonReaders.nullableString(json, 'description'),
      badgeLabel: JsonReaders.nullableString(json, 'badge_label') ??
          JsonReaders.nullableString(json, 'badgeLabel'),
      isSoldOut: _readBool(json, 'is_sold_out') || _readBool(json, 'isSoldOut'),
      isSelectable: json.containsKey('is_selectable') || json.containsKey('isSelectable')
          ? (_readBool(json, 'is_selectable') || _readBool(json, 'isSelectable'))
          : !(_readBool(json, 'is_sold_out') || _readBool(json, 'isSoldOut')),
    );
  }

  static bool _readBool(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value is bool) {
      return value;
    }
    return false;
  }
}

class TicketTypesBundleModel extends TicketTypesBundleEntity {
  const TicketTypesBundleModel({
    required super.eventId,
    required super.serviceFeeRate,
    required super.offerings,
  });

  factory TicketTypesBundleModel.fromJson(Map<String, dynamic> json) {
    final offeringsRaw = json['offerings'];
    final offerings = <TicketOfferingModel>[];
    if (offeringsRaw is List) {
      for (final item in offeringsRaw) {
        if (item is Map<String, dynamic>) {
          offerings.add(TicketOfferingModel.fromJson(item));
        }
      }
    }

    final rate = json['service_fee_rate'] ?? json['serviceFeeRate'];
    return TicketTypesBundleModel(
      eventId: JsonReaders.string(json, 'event_id', fallback: '') != ''
          ? JsonReaders.string(json, 'event_id')
          : JsonReaders.string(json, 'eventId'),
      serviceFeeRate: rate is num ? rate.toDouble() : 0.05,
      offerings: List<TicketOfferingEntity>.from(offerings),
    );
  }
}

class VenueZoneModel extends VenueZoneEntity {
  const VenueZoneModel({
    required super.id,
    required super.kind,
    required super.name,
    required super.status,
    super.capacityPerTable,
    super.isSelectable,
  });

  factory VenueZoneModel.fromJson(Map<String, dynamic> json) {
    final id = JsonReaders.string(json, 'id');
    final type = JsonReaders.string(json, 'type', fallback: '') != ''
        ? JsonReaders.string(json, 'type')
        : JsonReaders.string(json, 'kind', fallback: 'vip_table_zone');
    final selectable = json.containsKey('is_selectable')
        ? JsonReaders.boolean(json, 'is_selectable')
        : JsonReaders.boolean(json, 'selectable', fallback: true);

    return VenueZoneModel(
      id: id,
      kind: _mapZoneKind(type, id),
      name: JsonReaders.string(json, 'name'),
      status: _mapZoneStatus(json),
      capacityPerTable: JsonReaders.integerValue(
        json['table_capacity'] ?? json['tableCapacity'],
        fallback: 0,
      ).clamp(0, 999) == 0
          ? null
          : JsonReaders.integerValue(json['table_capacity'] ?? json['tableCapacity']),
      isSelectable: selectable,
    );
  }
}

class VenueFloorPlanModel extends VenueFloorPlanEntity {
  const VenueFloorPlanModel({
    required super.venueName,
    required super.dimensionsLabel,
    required super.zones,
  });

  factory VenueFloorPlanModel.fromJson(Map<String, dynamic> json) {
    final zonesRaw = json['zones'];
    final zones = <VenueZoneModel>[];
    if (zonesRaw is List) {
      for (final item in zonesRaw) {
        if (item is Map<String, dynamic>) {
          zones.add(VenueZoneModel.fromJson(item));
        }
      }
    }

    final dimensionsLabel = JsonReaders.nullableString(json, 'dimensions_label') ??
        JsonReaders.nullableString(json, 'dimensionsLabel') ??
        _formatDimensions(json['dimensions']);

    return VenueFloorPlanModel(
      venueName: JsonReaders.string(json, 'name'),
      dimensionsLabel: dimensionsLabel ?? '',
      zones: zones,
    );
  }

  static String? _formatDimensions(Object? value) {
    if (value is! Map) {
      return null;
    }
    final width = value['width_meters'] ?? value['widthMeters'];
    final height = value['height_meters'] ?? value['heightMeters'];
    if (width == null || height == null) {
      return null;
    }
    return '${width}m × ${height}m';
  }
}

class VenueTableModel extends VenueTableEntity {
  const VenueTableModel({
    required super.id,
    required super.label,
    required super.zoneId,
    required super.status,
    required super.price,
    required super.capacity,
    required super.bottleCount,
    required super.voucherCount,
    super.extras,
    super.positionX,
    super.positionY,
    super.isPremium,
  });

  factory VenueTableModel.fromJson(Map<String, dynamic> json) {
    final includes = json['includes'];
    final people = includes is Map
        ? JsonReaders.integerValue(includes['people'], fallback: 10)
        : 10;
    final bottles = includes is Map
        ? JsonReaders.integerValue(includes['bottles'], fallback: 0)
        : 0;
    final vouchers = includes is Map
        ? JsonReaders.integerValue(
            includes['bar_vouchers'] ?? includes['barVouchers'],
            fallback: 0,
          )
        : 0;
    final extras = includes is Map ? _readStringList(includes['extras']) : const <String>[];

    final zoneId = JsonReaders.string(json, 'zone_id', fallback: '') != ''
        ? JsonReaders.string(json, 'zone_id')
        : JsonReaders.string(json, 'zoneId');

    final position = json['position'];
    final positionX = position is Map
        ? (position['x'] as num?)?.toDouble() ?? 0
        : _readCoordinate(json['position_x'] ?? json['positionX']);
    final positionY = position is Map
        ? (position['y'] as num?)?.toDouble() ?? 0
        : _readCoordinate(json['position_y'] ?? json['positionY']);

    final mappedStatus = _mapTableStatus(json);
    final isPremiumFlag = JsonReaders.boolean(json, 'is_premium') ||
        JsonReaders.boolean(json, 'isPremium');
    final status = isPremiumFlag && mappedStatus == VenueTableStatus.available
        ? VenueTableStatus.premium
        : mappedStatus;

    return VenueTableModel(
      id: JsonReaders.string(json, 'id'),
      label: JsonReaders.string(json, 'label'),
      zoneId: zoneId,
      status: status,
      price: JsonReaders.integer(json, 'price'),
      capacity: people,
      bottleCount: bottles,
      voucherCount: vouchers,
      extras: extras,
      positionX: positionX,
      positionY: positionY,
      isPremium: isPremiumFlag || status == VenueTableStatus.premium,
    );
  }
}

class ZoneTablesBundleModel extends ZoneTablesBundleEntity {
  const ZoneTablesBundleModel({
    required super.zoneId,
    required super.zoneName,
    required super.tableCapacity,
    required super.tables,
  });

  factory ZoneTablesBundleModel.fromJson(Map<String, dynamic> json) {
    final tablesRaw = json['tables'];
    final tables = <VenueTableModel>[];
    if (tablesRaw is List) {
      for (final item in tablesRaw) {
        if (item is Map<String, dynamic>) {
          tables.add(VenueTableModel.fromJson(item));
        }
      }
    }

    return ZoneTablesBundleModel(
      zoneId: JsonReaders.string(json, 'zone_id', fallback: '') != ''
          ? JsonReaders.string(json, 'zone_id')
          : JsonReaders.string(json, 'zoneId'),
      zoneName: JsonReaders.string(json, 'zone_name', fallback: '') != ''
          ? JsonReaders.string(json, 'zone_name')
          : JsonReaders.string(json, 'zoneName'),
      tableCapacity: JsonReaders.integerValue(
        json['table_capacity'] ?? json['tableCapacity'],
        fallback: 10,
      ),
      tables: tables,
    );
  }
}

class TableLockResultModel extends TableLockResultEntity {
  const TableLockResultModel({
    required super.lockId,
    required super.tableId,
    required super.expiresAt,
    required super.expiresInSeconds,
    required super.table,
  });

  factory TableLockResultModel.fromJson(Map<String, dynamic> json) {
    final tableJson = json['table'];
    final table = tableJson is Map<String, dynamic>
        ? VenueTableModel.fromJson(tableJson)
        : VenueTableModel(
            id: JsonReaders.string(json, 'table_id', fallback: '') != ''
                ? JsonReaders.string(json, 'table_id')
                : JsonReaders.string(json, 'tableId'),
            label: '',
            zoneId: '',
            status: VenueTableStatus.selected,
            price: 0,
            capacity: 10,
            bottleCount: 0,
            voucherCount: 0,
          );

    final expiresAtRaw =
        json['expires_at']?.toString() ?? json['expiresAt']?.toString() ?? '';

    return TableLockResultModel(
      lockId: JsonReaders.string(json, 'lock_id', fallback: '') != ''
          ? JsonReaders.string(json, 'lock_id')
          : JsonReaders.string(json, 'lockId'),
      tableId: JsonReaders.string(json, 'table_id', fallback: '') != ''
          ? JsonReaders.string(json, 'table_id')
          : JsonReaders.string(json, 'tableId'),
      expiresAt: DateTime.tryParse(expiresAtRaw) ??
          DateTime.now().add(const Duration(minutes: 10)),
      expiresInSeconds: JsonReaders.integerValue(
        json['expires_in_seconds'] ?? json['expiresInSeconds'],
        fallback: 600,
      ),
      table: table,
    );
  }
}

class TableLockStatusModel extends TableLockStatusEntity {
  const TableLockStatusModel({
    super.lockId,
    required super.status,
    super.lockedAt,
    super.expiresAt,
    required super.remainingSeconds,
    required super.isLockedByMe,
  });

  factory TableLockStatusModel.fromJson(Map<String, dynamic> json) {
    final expiresAtRaw =
        json['expires_at']?.toString() ?? json['expiresAt']?.toString();
    final lockedAtRaw =
        json['locked_at']?.toString() ?? json['lockedAt']?.toString();

    return TableLockStatusModel(
      lockId: JsonReaders.string(json, 'lock_id', fallback: '') != ''
          ? JsonReaders.string(json, 'lock_id')
          : JsonReaders.string(json, 'lockId', fallback: ''),
      status: JsonReaders.string(json, 'status', fallback: 'NONE'),
      lockedAt: lockedAtRaw != null && lockedAtRaw.isNotEmpty
          ? DateTime.tryParse(lockedAtRaw)
          : null,
      expiresAt: expiresAtRaw != null && expiresAtRaw.isNotEmpty
          ? DateTime.tryParse(expiresAtRaw)
          : null,
      remainingSeconds: JsonReaders.integerValue(
        json['remaining_seconds'] ?? json['remainingSeconds'],
        fallback: 0,
      ),
      isLockedByMe: JsonReaders.boolean(json, 'is_locked_by_me') ||
          JsonReaders.boolean(json, 'isLockedByMe'),
    );
  }
}

class TableAvailabilitySnapshotModel extends TableAvailabilitySnapshotEntity {
  const TableAvailabilitySnapshotModel({
    required super.eventId,
    required super.zones,
    super.updatedAt,
  });

  factory TableAvailabilitySnapshotModel.fromJson(Map<String, dynamic> json) {
    final zonesRaw = json['zones'];
    final zones = <ZoneAvailabilityModel>[];
    if (zonesRaw is List) {
      for (final item in zonesRaw) {
        if (item is Map<String, dynamic>) {
          zones.add(ZoneAvailabilityModel.fromJson(item));
        }
      }
    }

    final updatedAtRaw =
        json['updated_at']?.toString() ?? json['updatedAt']?.toString();

    return TableAvailabilitySnapshotModel(
      eventId: JsonReaders.string(json, 'event_id', fallback: '') != ''
          ? JsonReaders.string(json, 'event_id')
          : JsonReaders.string(json, 'eventId'),
      updatedAt: updatedAtRaw == null ? null : DateTime.tryParse(updatedAtRaw),
      zones: zones,
    );
  }
}

class ZoneAvailabilityModel extends ZoneAvailabilityEntity {
  const ZoneAvailabilityModel({
    required super.zoneId,
    required super.availableTables,
    required super.lockedTables,
    required super.soldTables,
    required super.tables,
  });

  factory ZoneAvailabilityModel.fromJson(Map<String, dynamic> json) {
    final tablesRaw = json['tables'];
    final tables = <TableAvailabilityItemModel>[];
    if (tablesRaw is List) {
      for (final item in tablesRaw) {
        if (item is Map<String, dynamic>) {
          tables.add(TableAvailabilityItemModel.fromJson(item));
        }
      }
    }

    return ZoneAvailabilityModel(
      zoneId: JsonReaders.string(json, 'zone_id', fallback: '') != ''
          ? JsonReaders.string(json, 'zone_id')
          : JsonReaders.string(json, 'zoneId'),
      availableTables: JsonReaders.integerValue(
        json['available_tables'] ?? json['availableTables'],
        fallback: 0,
      ),
      lockedTables: JsonReaders.integerValue(
        json['locked_tables'] ?? json['lockedTables'],
        fallback: 0,
      ),
      soldTables: JsonReaders.integerValue(
        json['sold_tables'] ?? json['soldTables'],
        fallback: 0,
      ),
      tables: tables,
    );
  }
}

class TableAvailabilityItemModel extends TableAvailabilityItemEntity {
  const TableAvailabilityItemModel({
    required super.id,
    required super.label,
    required super.status,
  });

  factory TableAvailabilityItemModel.fromJson(Map<String, dynamic> json) {
    return TableAvailabilityItemModel(
      id: JsonReaders.string(json, 'id'),
      label: JsonReaders.string(json, 'label', fallback: ''),
      status: _mapTableStatus(json),
    );
  }
}

double _readCoordinate(Object? value) {
  if (value is num) {
    return value.toDouble();
  }
  return 0;
}

List<String> _readStringList(Object? value) {
  if (value is! List) {
    return const [];
  }

  final extras = <String>[];
  for (final item in value) {
    if (item is String && item.trim().isNotEmpty) {
      extras.add(item.trim());
    }
  }
  return extras;
}

VenueZoneKind _mapZoneKind(String type, String id) {
  final normalizedType = type.toLowerCase();
  final normalizedId = id.toLowerCase();

  if (normalizedType.contains('premium') ||
      normalizedId.contains('dj') ||
      normalizedId.contains('vip-dj')) {
    return VenueZoneKind.vipDj;
  }
  if (normalizedType.contains('stage') || normalizedId.contains('stage')) {
    return VenueZoneKind.stage;
  }
  if (normalizedType.contains('floor') ||
      normalizedType.contains('dance') ||
      normalizedId.contains('dance')) {
    return VenueZoneKind.danceFloor;
  }
  if (normalizedId.contains('vip-2') || normalizedId.endsWith('-2')) {
    return VenueZoneKind.vip2;
  }
  return VenueZoneKind.vip1;
}

VenueZoneStatus _mapZoneStatus(Map<String, dynamic> json) {
  final status = JsonReaders.string(json, 'status', fallback: '').toLowerCase();
  final color = JsonReaders.string(json, 'color', fallback: '').toLowerCase();

  if (status.contains('sold') || color.contains('red')) {
    return VenueZoneStatus.sold;
  }
  if (status.contains('premium') || color.contains('gold')) {
    return VenueZoneStatus.premium;
  }
  return VenueZoneStatus.available;
}

VenueTableStatus _mapTableStatus(Map<String, dynamic> json) {
  final status = JsonReaders.string(json, 'status', fallback: '').toLowerCase();
  final lockedByMe = JsonReaders.boolean(json, 'locked_by_me') ||
      JsonReaders.boolean(json, 'lockedByMe');

  if (lockedByMe || status == 'selected') {
    return VenueTableStatus.selected;
  }
  switch (status) {
    case 'locked':
      return VenueTableStatus.locked;
    case 'sold':
    case 'sold_out':
      return VenueTableStatus.sold;
    case 'premium':
      return VenueTableStatus.premium;
    default:
      return VenueTableStatus.available;
  }
}
