import 'package:youpass/core/utils/json_readers.dart';
import 'package:youpass/features/favorites/data/models/favorite_producer_model.dart';
import 'package:youpass/features/favorites/data/models/producer_calendar_event_model.dart';
import 'package:youpass/features/favorites/domain/repositories/favorites_repository.dart';

class ProducerCalendarResponseModel extends ProducerCalendarSnapshot {
  const ProducerCalendarResponseModel({
    required super.producer,
    required super.events,
    super.isFollower,
  });

  factory ProducerCalendarResponseModel.fromRawData(Object? data) {
    if (data is! Map<String, dynamic>) {
      throw const FormatException('Invalid producer calendar response');
    }

    final producerRaw = data['producer'];
    final meta = data['meta'];
    final isFollower = meta is Map<String, dynamic>
        ? JsonReaders.boolean(meta, 'is_follower', fallback: true)
        : true;

    return ProducerCalendarResponseModel(
      producer: producerRaw is Map<String, dynamic>
          ? FavoriteProducerModel.fromJson(producerRaw)
          : const FavoriteProducerModel(id: '', name: ''),
      events: ProducerCalendarEventModel.listFromJson(data['events']),
      isFollower: isFollower,
    );
  }
}
