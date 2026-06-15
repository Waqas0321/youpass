import 'package:youpass/features/events/data/models/event_model.dart';
import 'package:youpass/features/home/domain/entities/main_banner_carousel_config_entity.dart';

class FeaturedEventsResponseModel {
  const FeaturedEventsResponseModel({
    required this.carouselEvents,
    required this.featuredEvents,
    this.mainBannerCarouselConfig,
  });

  final List<EventModel> carouselEvents;
  final List<EventModel> featuredEvents;
  final MainBannerCarouselConfigEntity? mainBannerCarouselConfig;

  factory FeaturedEventsResponseModel.fromJson(Map<String, dynamic> json) {
    final mainBanner = json['main_banner'] ?? json['mainBanner'];
    final slides = _resolveSlides(json, mainBanner);
    final carouselConfig = _resolveCarouselConfig(json, mainBanner);

    return FeaturedEventsResponseModel(
      carouselEvents: slides,
      featuredEvents: EventModel.listFromJson(json['events']),
      mainBannerCarouselConfig: carouselConfig,
    );
  }

  static List<EventModel> _resolveSlides(
    Map<String, dynamic> json,
    Object? mainBanner,
  ) {
    if (mainBanner is Map<String, dynamic>) {
      final bannerSlides = EventModel.listFromJson(mainBanner['slides']);
      if (bannerSlides.isNotEmpty) {
        return bannerSlides;
      }
    }

    final carousel = EventModel.listFromJson(json['carousel']);
    if (carousel.isNotEmpty) {
      return carousel;
    }

    return EventModel.listFromJson(json['slides']);
  }

  static MainBannerCarouselConfigEntity? _resolveCarouselConfig(
    Map<String, dynamic> json,
    Object? mainBanner,
  ) {
    if (mainBanner is Map<String, dynamic>) {
      final carousel = mainBanner['carousel'];
      if (carousel != null) {
        return MainBannerCarouselConfigEntity.fromJson(carousel);
      }
    }

    final topLevel = json['carousel_config'] ?? json['carouselConfig'];
    if (topLevel != null) {
      return MainBannerCarouselConfigEntity.fromJson(topLevel);
    }

    return null;
  }
}
