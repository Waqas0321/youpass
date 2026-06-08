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
  });

  final String id;
  final String label;
  final String zoneId;
  final VenueTableStatus status;
  final int price;
  final int capacity;
  final int bottleCount;
  final int voucherCount;

  bool get isSelectable =>
      status == VenueTableStatus.available ||
      status == VenueTableStatus.premium ||
      status == VenueTableStatus.selected;

  VenueTableEntity copyWith({VenueTableStatus? status}) {
    return VenueTableEntity(
      id: id,
      label: label,
      zoneId: zoneId,
      status: status ?? this.status,
      price: price,
      capacity: capacity,
      bottleCount: bottleCount,
      voucherCount: voucherCount,
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
      ];
}
