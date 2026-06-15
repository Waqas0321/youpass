import 'package:youpass/features/vip_venue/domain/entities/table_lock_status_entity.dart';
import 'package:youpass/features/vip_venue/domain/repositories/vip_venue_repository.dart';

class FetchTableLockStatusUseCase {
  FetchTableLockStatusUseCase(this.repository);

  final VipVenueRepository repository;

  Future<TableLockStatusEntity> call({
    required String eventId,
    required String tableId,
  }) {
    return repository.fetchTableLockStatus(eventId: eventId, tableId: tableId);
  }
}
