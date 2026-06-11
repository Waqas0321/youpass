import 'package:youpass/features/home/domain/entities/home_feed_entity.dart';

class HomeFeedModel extends HomeFeedEntity {
  const HomeFeedModel({
    required super.categories,
    required super.carouselEvents,
    required super.featuredEvents,
    super.greeting,
    super.partyMode,
    super.invitations,
    super.postRegistration,
    super.headerGreeting,
    super.upcomingSectionTitle,
    super.searchPlaceholder,
  });

  factory HomeFeedModel.fromEntity(HomeFeedEntity entity) {
    return HomeFeedModel(
      categories: entity.categories,
      carouselEvents: entity.carouselEvents,
      featuredEvents: entity.featuredEvents,
      greeting: entity.greeting,
      partyMode: entity.partyMode,
      invitations: entity.invitations,
      postRegistration: entity.postRegistration,
      headerGreeting: entity.headerGreeting,
      upcomingSectionTitle: entity.upcomingSectionTitle,
      searchPlaceholder: entity.searchPlaceholder,
    );
  }
}
