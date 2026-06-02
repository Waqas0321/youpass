import 'package:youpass/core/constants/app_assets.dart';
import 'package:youpass/features/favorites/domain/entities/favorite_producer_entity.dart';
import 'package:youpass/features/favorites/domain/entities/favorite_producer_filter.dart';
import 'package:youpass/features/favorites/domain/entities/producer_event_category.dart';
import 'package:youpass/features/favorites/domain/entities/producer_event_entity.dart';

class FavoritesMockData {
  FavoritesMockData._();

  static const String youfestId = 'producer-youfest';
  static const String iguanaId = 'producer-iguana';

  static const List<FavoriteProducerEntity> producers = [
    FavoriteProducerEntity(
      id: youfestId,
      name: 'YouFest',
      imageAssetPath: AppAssets.dummyImage,
      coverageLabel: 'chile',
      tags: [
        FavoriteProducerFilter.upcoming,
        FavoriteProducerFilter.parties,
      ],
    ),
    FavoriteProducerEntity(
      id: iguanaId,
      name: 'IGUANA',
      imageAssetPath: AppAssets.dummyImage,
      coverageLabel: 'chile',
      tags: [
        FavoriteProducerFilter.parties,
        FavoriteProducerFilter.vip,
      ],
    ),
  ];

  static List<ProducerEventEntity> eventsForProducer(String producerId) {
    if (producerId == youfestId) {
      return _youfestEvents;
    }
    if (producerId == iguanaId) {
      return _iguanaEvents;
    }
    return const [];
  }

  static const List<ProducerEventEntity> _youfestEvents = [
    ProducerEventEntity(
      id: 'event-youfest-winter',
      producerId: youfestId,
      title: 'YouFest Winter 2026',
      dateLabel: 'Sáb 18 Julio 2026',
      timeLabel: '22:00 hrs',
      locationLabel: 'Centro Eventos Hilaria',
      priceLabel: r'$35.000 CLP',
      imageAssetPath: AppAssets.dummyImage,
      category: ProducerEventCategory.festivals,
    ),
    ProducerEventEntity(
      id: 'event-neon-rooftop',
      producerId: youfestId,
      title: 'Neon Rooftop Sessions',
      dateLabel: 'Vie 7 Agosto 2026',
      timeLabel: '23:00 hrs',
      locationLabel: 'Sky Costanera',
      priceLabel: r'$50.000 CLP',
      imageAssetPath: AppAssets.dummyImage,
      category: ProducerEventCategory.parties,
    ),
    ProducerEventEntity(
      id: 'event-summer-closing',
      producerId: youfestId,
      title: 'Summer Closing Party',
      dateLabel: 'Sáb 12 Septiembre 2026',
      timeLabel: '21:30 hrs',
      locationLabel: 'Club Océano',
      priceLabel: r'$28.000 CLP',
      imageAssetPath: AppAssets.dummyImage,
      category: ProducerEventCategory.parties,
    ),
  ];

  static const List<ProducerEventEntity> _iguanaEvents = [
    ProducerEventEntity(
      id: 'event-iguana-summer',
      producerId: iguanaId,
      title: 'IGUANA SUMMER',
      dateLabel: 'Sáb 4 Julio 2026',
      timeLabel: '22:00 hrs',
      locationLabel: 'Centro Eventos Hilaria',
      priceLabel: r'$40.000 CLP',
      imageAssetPath: AppAssets.dummyImage,
      category: ProducerEventCategory.parties,
    ),
  ];
}
