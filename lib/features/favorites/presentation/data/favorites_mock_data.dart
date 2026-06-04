import 'package:youpass/core/constants/app_assets.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/features/favorites/domain/entities/favorite_producer_entity.dart';
import 'package:youpass/features/favorites/domain/entities/favorite_producer_filter.dart';
import 'package:youpass/features/favorites/domain/entities/producer_event_category.dart';
import 'package:youpass/features/favorites/domain/entities/producer_event_entity.dart';
import 'package:youpass/l10n/app_localizations.dart';

class FavoritesMockData {
  FavoritesMockData._();

  static const String youfestId = 'producer-youfest';
  static const String iguanaId = 'producer-iguana';

  static List<FavoriteProducerEntity> producers(AppLocalizations l10n) => [
        FavoriteProducerEntity(
          id: youfestId,
          name: AppStrings.mockProducerYoufest(l10n),
          imageAssetPath: AppAssets.dummyImage,
          coverageLabel: 'chile',
          tags: const [
            FavoriteProducerFilter.upcoming,
            FavoriteProducerFilter.parties,
          ],
        ),
        FavoriteProducerEntity(
          id: iguanaId,
          name: AppStrings.mockProducerIguana(l10n),
          imageAssetPath: AppAssets.dummyImage,
          coverageLabel: 'chile',
          tags: const [
            FavoriteProducerFilter.parties,
            FavoriteProducerFilter.vip,
          ],
        ),
      ];

  static List<ProducerEventEntity> eventsForProducer(
    String producerId,
    AppLocalizations l10n,
  ) {
    if (producerId == youfestId) {
      return youfestEvents(l10n);
    }
    if (producerId == iguanaId) {
      return iguanaEvents(l10n);
    }
    return const [];
  }

  static List<ProducerEventEntity> youfestEvents(AppLocalizations l10n) => [
        ProducerEventEntity(
          id: 'event-youfest-winter',
          producerId: youfestId,
          title: AppStrings.mockEventYoufestWinter2026(l10n),
          dateLabel: AppStrings.mockDateSaturdayJuly18(l10n),
          timeLabel: AppStrings.mockTime2200Hrs(l10n),
          locationLabel: AppStrings.mockLocationCentroEventosHilaria(l10n),
          priceLabel: AppStrings.mockPriceFrom35000(l10n),
          imageAssetPath: AppAssets.dummyImage,
          category: ProducerEventCategory.festivals,
        ),
        ProducerEventEntity(
          id: 'event-neon-rooftop',
          producerId: youfestId,
          title: AppStrings.mockEventNeonRooftopSessions(l10n),
          dateLabel: AppStrings.mockDateFridayAugust7(l10n),
          timeLabel: AppStrings.mockTime2300Hrs(l10n),
          locationLabel: AppStrings.mockLocationSkyCostanera(l10n),
          priceLabel: AppStrings.mockPriceFrom50000(l10n),
          imageAssetPath: AppAssets.dummyImage,
          category: ProducerEventCategory.parties,
        ),
        ProducerEventEntity(
          id: 'event-summer-closing',
          producerId: youfestId,
          title: AppStrings.mockEventSummerClosingParty(l10n),
          dateLabel: AppStrings.mockDateSaturdaySeptember12(l10n),
          timeLabel: AppStrings.mockTime2130Hrs(l10n),
          locationLabel: AppStrings.mockLocationClubOceano(l10n),
          priceLabel: AppStrings.mockPriceFrom28000(l10n),
          imageAssetPath: AppAssets.dummyImage,
          category: ProducerEventCategory.parties,
        ),
      ];

  static List<ProducerEventEntity> iguanaEvents(AppLocalizations l10n) => [
        ProducerEventEntity(
          id: 'event-iguana-summer',
          producerId: iguanaId,
          title: AppStrings.mockEventIguanaSummer(l10n),
          dateLabel: AppStrings.mockDateSaturdayJuly4Short(l10n),
          timeLabel: AppStrings.mockTime2200Hrs(l10n),
          locationLabel: AppStrings.mockLocationCentroEventosHilaria(l10n),
          priceLabel: AppStrings.mockPriceFrom42000(l10n),
          imageAssetPath: AppAssets.dummyImage,
          category: ProducerEventCategory.parties,
        ),
      ];
}
