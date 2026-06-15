import 'package:youpass/features/vip_venue/domain/entities/venue_table_entity.dart';
import 'package:youpass/features/vip_venue/domain/repositories/vip_venue_repository.dart';

class FetchVenueTableByIdUseCase {
  FetchVenueTableByIdUseCase(this.repository);

  final VipVenueRepository repository;

  Future<VenueTableEntity> call({
    required String eventId,
    required String tableId,
  }) {
    return repository.fetchTableById(eventId: eventId, tableId: tableId);
  }
}
