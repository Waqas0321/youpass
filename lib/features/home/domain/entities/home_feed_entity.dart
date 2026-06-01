import 'package:equatable/equatable.dart';
import 'package:youpass/features/home/domain/entities/event_category_entity.dart';
import 'package:youpass/features/home/domain/entities/event_item_entity.dart';
import 'package:youpass/features/home/domain/entities/featured_event_entity.dart';

class HomeFeedEntity extends Equatable {
  const HomeFeedEntity({
    required this.categories,
    required this.featuredEvents,
    required this.events,
  });

  final List<EventCategoryEntity> categories;
  final List<FeaturedEventEntity> featuredEvents;
  final List<EventItemEntity> events;

  @override
  List<Object?> get props => [categories, featuredEvents, events];
}
