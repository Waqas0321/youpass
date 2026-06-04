import 'package:equatable/equatable.dart';
import 'package:youpass/features/events/domain/entities/event_entity.dart';
import 'package:youpass/features/home/domain/entities/event_category_entity.dart';

class HomeFeedEntity extends Equatable {
  const HomeFeedEntity({
    required this.categories,
    required this.carouselEvents,
    required this.featuredEvents,
  });

  final List<EventCategoryEntity> categories;
  final List<EventEntity> carouselEvents;
  final List<EventEntity> featuredEvents;

  HomeFeedEntity copyWith({
    List<EventCategoryEntity>? categories,
    List<EventEntity>? carouselEvents,
    List<EventEntity>? featuredEvents,
  }) {
    return HomeFeedEntity(
      categories: categories ?? this.categories,
      carouselEvents: carouselEvents ?? this.carouselEvents,
      featuredEvents: featuredEvents ?? this.featuredEvents,
    );
  }

  HomeFeedEntity copyWithEventFavorite({
    required String eventId,
    required bool isFavorite,
  }) {
    return copyWith(
      carouselEvents: _updateFavorite(carouselEvents, eventId, isFavorite),
      featuredEvents: _updateFavorite(featuredEvents, eventId, isFavorite),
    );
  }

  List<EventEntity> _updateFavorite(
    List<EventEntity> events,
    String eventId,
    bool isFavorite,
  ) {
    return events
        .map(
          (event) => event.id == eventId
              ? event.copyWith(isFavorite: isFavorite)
              : event,
        )
        .toList();
  }

  @override
  List<Object?> get props => [categories, carouselEvents, featuredEvents];
}
