import 'package:equatable/equatable.dart';
import 'package:youpass/features/events/domain/entities/event_entity.dart';
import 'package:youpass/features/favorites/domain/entities/favorite_producer_entity.dart';

class FavoritesSnapshotEntity extends Equatable {
  const FavoritesSnapshotEntity({
    required this.producers,
    required this.events,
    this.producersCount = 0,
    this.eventsCount = 0,
  });

  final List<FavoriteProducerEntity> producers;
  final List<EventEntity> events;
  final int producersCount;
  final int eventsCount;

  bool get isEmpty => producers.isEmpty && events.isEmpty;

  @override
  List<Object?> get props => [
        producers,
        events,
        producersCount,
        eventsCount,
      ];
}
