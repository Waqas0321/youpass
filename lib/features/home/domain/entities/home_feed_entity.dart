import 'package:equatable/equatable.dart';
import 'package:youpass/features/events/domain/entities/event_entity.dart';
import 'package:youpass/features/home/domain/entities/event_category_entity.dart';
import 'package:youpass/features/home/domain/entities/home_feed_meta_entity.dart';

class HomeFeedEntity extends Equatable {
  const HomeFeedEntity({
    required this.categories,
    required this.carouselEvents,
    required this.featuredEvents,
    this.greeting,
    this.partyMode,
    this.invitations,
    this.postRegistration = false,
    this.headerGreeting,
    this.upcomingSectionTitle,
    this.searchPlaceholder,
  });

  final List<EventCategoryEntity> categories;
  final List<EventEntity> carouselEvents;
  final List<EventEntity> featuredEvents;
  final HomeGreetingEntity? greeting;
  final HomePartyModeEntity? partyMode;
  final HomeInvitationsMetaEntity? invitations;
  final bool postRegistration;
  final String? headerGreeting;
  final String? upcomingSectionTitle;
  final String? searchPlaceholder;

  HomeFeedEntity copyWith({
    List<EventCategoryEntity>? categories,
    List<EventEntity>? carouselEvents,
    List<EventEntity>? featuredEvents,
    HomeGreetingEntity? greeting,
    HomePartyModeEntity? partyMode,
    HomeInvitationsMetaEntity? invitations,
    bool? postRegistration,
    String? headerGreeting,
    String? upcomingSectionTitle,
    String? searchPlaceholder,
  }) {
    return HomeFeedEntity(
      categories: categories ?? this.categories,
      carouselEvents: carouselEvents ?? this.carouselEvents,
      featuredEvents: featuredEvents ?? this.featuredEvents,
      greeting: greeting ?? this.greeting,
      partyMode: partyMode ?? this.partyMode,
      invitations: invitations ?? this.invitations,
      postRegistration: postRegistration ?? this.postRegistration,
      headerGreeting: headerGreeting ?? this.headerGreeting,
      upcomingSectionTitle: upcomingSectionTitle ?? this.upcomingSectionTitle,
      searchPlaceholder: searchPlaceholder ?? this.searchPlaceholder,
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
  List<Object?> get props => [
        categories,
        carouselEvents,
        featuredEvents,
        greeting,
        partyMode,
        invitations,
        postRegistration,
        headerGreeting,
        upcomingSectionTitle,
        searchPlaceholder,
      ];
}
