import 'package:youpass/features/vip_venue/domain/repositories/vip_venue_repository.dart';

class ReleaseVenueTableLockUseCase {
  ReleaseVenueTableLockUseCase(this.repository);

  final VipVenueRepository repository;

  Future<void> call({
    required String eventId,
    required String tableId,
  }) {
    return repository.releaseTableLock(eventId: eventId, tableId: tableId);
  }
}
