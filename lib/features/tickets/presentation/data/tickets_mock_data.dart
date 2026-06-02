import 'package:youpass/core/constants/app_assets.dart';
import 'package:youpass/features/tickets/domain/entities/past_event_entity.dart';
import 'package:youpass/features/tickets/domain/entities/past_event_filter.dart';
import 'package:youpass/features/tickets/domain/entities/ticket_tier.dart';
import 'package:youpass/features/tickets/domain/entities/upcoming_ticket_entity.dart';

class TicketsMockData {
  TicketsMockData._();

  static const List<UpcomingTicketEntity> upcoming = [
    UpcomingTicketEntity(
      id: 'upcoming-1',
      title: 'Festival Verano 2026',
      dateLabel: 'Sábado 15 May · 22:00',
      locationLabel: 'Club Amanda',
      ticketTypeLabel: 'General · 1 entrada',
      imageAssetPath: AppAssets.dummyImage,
      tier: TicketTier.general,
    ),
    UpcomingTicketEntity(
      id: 'upcoming-2',
      title: 'Concierto X',
      dateLabel: 'Sábado 15 May · 22:00',
      locationLabel: 'Movistar Arena',
      ticketTypeLabel: 'VIP · 2 entradas',
      imageAssetPath: AppAssets.dummyImage,
      tier: TicketTier.vip,
    ),
  ];

  static const List<PastEventEntity> past = [
    PastEventEntity(
      id: 'past-1',
      title: 'YouFest 2026',
      locationLabel: 'Centro Eventos Hilaria',
      dateLabel: 'Sáb 4 Julio · 22:00',
      imageAssetPath: AppAssets.dummyImage,
      entryTime: '22:41',
      consumptionCount: 6,
      stayDurationLabel: '5h 14m',
      category: PastEventFilter.parties,
      isFavorite: false,
    ),
    PastEventEntity(
      id: 'past-2',
      title: 'IGUANA SUMMER',
      locationLabel: 'Centro Eventos Hilaria',
      dateLabel: 'Sáb 4 Julio · 22:00',
      imageAssetPath: AppAssets.dummyImage,
      entryTime: '22:41',
      consumptionCount: 6,
      stayDurationLabel: '5h 14m',
      category: PastEventFilter.concerts,
      isFavorite: true,
    ),
  ];
}
