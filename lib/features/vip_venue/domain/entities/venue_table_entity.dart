import 'package:equatable/equatable.dart';
import 'package:youpass/features/vip_venue/domain/entities/venue_table_status.dart';

class VenueTableEntity extends Equatable {
  const VenueTableEntity({
    required this.id,
    required this.label,
    required this.zoneId,
    required this.status,
    required this.price,
    required this.capacity,
    required this.bottleCount,
    required this.voucherCount,
    this.extras = const [],
    this.positionX = 0,
    this.positionY = 0,
    this.isPremium = false,
    this.currency = 'CLP',
    this.tableNumber,
    this.eventId,
    this.internalTableId,
    this.lockedUntil,
    this.soldAt,
  });

  final String id;
  final String label;
  final String zoneId;
  final VenueTableStatus status;
  final int price;
  final int capacity;
  final int bottleCount;
  final int voucherCount;
  final List<String> extras;
  final double positionX;
  final double positionY;
  final bool isPremium;
  final String currency;
  final int? tableNumber;
  final String? eventId;
  final String? internalTableId;
  final DateTime? lockedUntil;
  final DateTime? soldAt;

  bool get isSelectable =>
      status == VenueTableStatus.available ||
      status == VenueTableStatus.premium ||
      status == VenueTableStatus.selected;

  bool get showsAsPremium =>
      isPremium || status == VenueTableStatus.premium;

  bool get hasConfiguredPosition => positionX > 0 || positionY > 0;

  VenueTableEntity copyWith({
    VenueTableStatus? status,
    double? positionX,
    double? positionY,
    bool? isPremium,
    DateTime? lockedUntil,
  }) {
    return VenueTableEntity(
      id: id,
      label: label,
      zoneId: zoneId,
      status: status ?? this.status,
      price: price,
      capacity: capacity,
      bottleCount: bottleCount,
      voucherCount: voucherCount,
      extras: extras,
      positionX: positionX ?? this.positionX,
      positionY: positionY ?? this.positionY,
      isPremium: isPremium ?? this.isPremium,
      currency: currency,
      tableNumber: tableNumber,
      eventId: eventId,
      internalTableId: internalTableId,
      lockedUntil: lockedUntil ?? this.lockedUntil,
      soldAt: soldAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        label,
        zoneId,
        status,
        price,
        capacity,
        bottleCount,
        voucherCount,
        extras,
        positionX,
        positionY,
        isPremium,
        currency,
        tableNumber,
        eventId,
        internalTableId,
        lockedUntil,
        soldAt,
      ];
}
