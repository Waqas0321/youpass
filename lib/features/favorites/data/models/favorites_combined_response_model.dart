import 'package:youpass/core/utils/json_readers.dart';
import 'package:youpass/features/events/data/models/event_model.dart';
import 'package:youpass/features/favorites/data/models/favorite_producer_model.dart';
import 'package:youpass/features/favorites/domain/entities/favorites_snapshot_entity.dart';

class FavoritesCombinedResponseModel extends FavoritesSnapshotEntity {
  const FavoritesCombinedResponseModel({
    required super.producers,
    required super.events,
    super.producersCount,
    super.eventsCount,
  });

  factory FavoritesCombinedResponseModel.fromRawData(Object? data) {
    if (data is! Map<String, dynamic>) {
      return const FavoritesCombinedResponseModel(
        producers: [],
        events: [],
      );
    }

    final meta = data['meta'];
    final producersCount = meta is Map<String, dynamic>
        ? JsonReaders.integer(meta, 'producers_count')
        : 0;
    final eventsCount = meta is Map<String, dynamic>
        ? JsonReaders.integer(meta, 'events_count')
        : 0;

    return FavoritesCombinedResponseModel(
      producers: FavoriteProducerModel.listFromJson(data['producers']),
      events: EventModel.listFromJson(data['events']),
      producersCount: producersCount,
      eventsCount: eventsCount,
    );
  }
}
