import 'package:youpass/features/home/domain/entities/home_feed_entity.dart';

class HomeFeedModel extends HomeFeedEntity {
  const HomeFeedModel({
    required super.categories,
    required super.carouselEvents,
    required super.featuredEvents,
  });

  factory HomeFeedModel.fromEntity(HomeFeedEntity entity) {
    return HomeFeedModel(
      categories: entity.categories,
      carouselEvents: entity.carouselEvents,
      featuredEvents: entity.featuredEvents,
    );
  }
}
