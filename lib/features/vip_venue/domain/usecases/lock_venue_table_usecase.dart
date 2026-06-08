import 'package:youpass/features/vip_venue/domain/entities/table_lock_result_entity.dart';
import 'package:youpass/features/vip_venue/domain/repositories/vip_venue_repository.dart';

class LockVenueTableUseCase {
  LockVenueTableUseCase(this.repository);

  final VipVenueRepository repository;

  Future<TableLockResultEntity> call({
    required String eventId,
    required String tableId,
  }) {
    return repository.lockTable(eventId: eventId, tableId: tableId);
  }
}
