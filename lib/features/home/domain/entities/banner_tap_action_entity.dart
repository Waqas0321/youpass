import 'package:equatable/equatable.dart';

enum BannerTapActionType {
  eventDetail,
  externalUrl,
  promoterPage,
  landingPage,
}

class BannerTapActionEntity extends Equatable {
  const BannerTapActionEntity({
    required this.type,
    this.eventId,
    this.url,
    this.producerId,
    this.landingSlug,
  });

  final BannerTapActionType type;
  final String? eventId;
  final String? url;
  final String? producerId;
  final String? landingSlug;

  static BannerTapActionEntity fromJson(Object? value) {
    if (value is! Map<String, dynamic>) {
      return const BannerTapActionEntity(type: BannerTapActionType.eventDetail);
    }

    final rawType = value['type']?.toString() ?? 'event_detail';
    return BannerTapActionEntity(
      type: _parseType(rawType),
      eventId: value['event_id']?.toString() ?? value['eventId']?.toString(),
      url: value['url']?.toString(),
      producerId: value['producer_id']?.toString() ?? value['producerId']?.toString(),
      landingSlug: value['landing_slug']?.toString() ?? value['landingSlug']?.toString(),
    );
  }

  static BannerTapActionType _parseType(String raw) {
    switch (raw) {
      case 'external_url':
        return BannerTapActionType.externalUrl;
      case 'promoter_page':
        return BannerTapActionType.promoterPage;
      case 'landing_page':
        return BannerTapActionType.landingPage;
      case 'event_detail':
      default:
        return BannerTapActionType.eventDetail;
    }
  }

  @override
  List<Object?> get props => [type, eventId, url, producerId, landingSlug];
}
