import 'package:youpass/core/constants/app_assets.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/features/tickets/domain/entities/past_event_entity.dart';
import 'package:youpass/features/tickets/domain/entities/past_event_filter.dart';
import 'package:youpass/features/tickets/domain/entities/ticket_tier.dart';
import 'package:youpass/features/tickets/domain/entities/tickets_yearly_summary_entity.dart';
import 'package:youpass/features/tickets/domain/entities/upcoming_ticket_entity.dart';
import 'package:youpass/l10n/app_localizations.dart';

class TicketsMockData {
  TicketsMockData._();

  static List<UpcomingTicketEntity> upcoming(AppLocalizations l10n) => [
        UpcomingTicketEntity(
          id: 'upcoming-1',
          eventId: 'event-festival-verano',
          title: AppStrings.mockEventFestivalVerano2026(l10n),
          dateLabel: AppStrings.mockDateSaturdayMay15(l10n),
          locationLabel: AppStrings.mockLocationClubAmandaShort(l10n),
          ticketTypeLabel: AppStrings.mockTicketGeneralOne(l10n),
          imageAssetPath: AppAssets.dummyImage,
          tier: TicketTier.general,
          canViewQr: true,
          canAssignTickets: true,
        ),
        UpcomingTicketEntity(
          id: 'upcoming-2',
          eventId: 'event-concierto-x',
          title: AppStrings.mockEventConciertoX(l10n),
          dateLabel: AppStrings.mockDateSaturdayMay15(l10n),
          locationLabel: AppStrings.mockLocationMovistarArena(l10n),
          ticketTypeLabel: AppStrings.mockTicketVipTwo(l10n),
          imageAssetPath: AppAssets.dummyImage,
          tier: TicketTier.vip,
          canViewQr: true,
          canAssignTickets: true,
        ),
      ];

  static List<PastEventEntity> past(AppLocalizations l10n) => [
        PastEventEntity(
          id: 'past-1',
          eventId: 'event-youfest-2026',
          title: AppStrings.mockEventYoufest2026(l10n),
          locationLabel: AppStrings.mockLocationCentroEventosHilaria(l10n),
          dateLabel: AppStrings.mockDateSaturdayJuly4(l10n),
          imageAssetPath: AppAssets.dummyImage,
          entryTime: '22:41',
          consumptionCount: 6,
          stayDurationLabel: AppStrings.mockStayDuration5h14m(l10n),
          category: PastEventFilter.parties,
          isFavorite: false,
          showStatistics: true,
        ),
        PastEventEntity(
          id: 'past-2',
          eventId: 'event-iguana-summer',
          title: AppStrings.mockEventIguanaSummer(l10n),
          locationLabel: AppStrings.mockLocationCentroEventosHilaria(l10n),
          dateLabel: AppStrings.mockDateSaturdayJuly4(l10n),
          imageAssetPath: AppAssets.dummyImage,
          entryTime: '22:41',
          consumptionCount: 6,
          stayDurationLabel: AppStrings.mockStayDuration5h14m(l10n),
          category: PastEventFilter.concerts,
          isFavorite: true,
          showStatistics: true,
        ),
      ];

  static TicketsYearlySummaryEntity yearlySummary(AppLocalizations l10n) =>
      TicketsYearlySummaryEntity(
        year: DateTime.now().year,
        eventsAttended: 3,
        currentCategory: 'gold',
        favoriteProducerName: AppStrings.mockProducerYoufest(l10n),
        favoriteProducerEventsAttended: 2,
      );
}
