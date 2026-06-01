import 'package:youpass/features/home/domain/entities/home_feed_entity.dart';

class HomeFeedModel extends HomeFeedEntity {
  const HomeFeedModel({
    required super.categories,
    required super.featuredEvents,
    required super.events,
  });

  factory HomeFeedModel.fromEntity(HomeFeedEntity entity) {
    return HomeFeedModel(
      categories: entity.categories,
      featuredEvents: entity.featuredEvents,
      events: entity.events,
    );
  }
}
