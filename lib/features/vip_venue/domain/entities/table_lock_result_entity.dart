import 'package:equatable/equatable.dart';
import 'package:youpass/features/vip_venue/domain/entities/venue_table_entity.dart';

class TableLockResultEntity extends Equatable {
  const TableLockResultEntity({
    required this.lockId,
    required this.tableId,
    required this.expiresAt,
    required this.expiresInSeconds,
    required this.table,
  });

  final String lockId;
  final String tableId;
  final DateTime expiresAt;
  final int expiresInSeconds;
  final VenueTableEntity table;

  @override
  List<Object?> get props => [
        lockId,
        tableId,
        expiresAt,
        expiresInSeconds,
        table,
      ];
}
