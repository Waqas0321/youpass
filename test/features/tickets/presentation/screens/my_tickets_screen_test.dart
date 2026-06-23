import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/constants/app_assets.dart';
import 'package:youpass/core/locale/app_locale.dart';
import 'package:youpass/core/services/screen_secure_service.dart';
import 'package:youpass/core/services/ticket_qr_cache_service.dart';
import 'package:youpass/core/services/tickets_cache.dart';
import 'package:youpass/features/events/domain/repositories/events_repository.dart';
import 'package:youpass/features/events/domain/usecases/toggle_event_favorite_usecase.dart'
    as events_usecases;
import 'package:youpass/features/invitations/domain/usecases/confirm_invitation_usecase.dart';
import 'package:youpass/features/invitations/domain/usecases/fetch_invitations_usecase.dart';
import 'package:youpass/features/invitations/domain/usecases/reject_invitation_usecase.dart';
import 'package:youpass/features/tickets/domain/entities/past_tickets_query.dart';
import 'package:youpass/features/tickets/domain/entities/tickets_page_result.dart';
import 'package:youpass/features/tickets/domain/entities/tickets_yearly_summary_entity.dart';
import 'package:youpass/features/tickets/domain/entities/upcoming_ticket_entity.dart';
import 'package:youpass/features/tickets/domain/usecases/cancel_ticket_usecase.dart';
import 'package:youpass/features/tickets/domain/usecases/fetch_past_tickets_usecase.dart';
import 'package:youpass/features/tickets/domain/usecases/fetch_ticket_order_id_usecase.dart';
import 'package:youpass/features/tickets/domain/usecases/fetch_ticket_qr_usecase.dart';
import 'package:youpass/features/tickets/domain/usecases/fetch_tickets_yearly_summary_usecase.dart';
import 'package:youpass/features/tickets/domain/usecases/fetch_upcoming_tickets_usecase.dart';
import 'package:youpass/features/tickets/presentation/providers/tickets_provider.dart';
import 'package:youpass/features/tickets/presentation/screens/my_tickets_screen.dart';
import 'package:youpass/l10n/app_localizations.dart';

import '../../../../helpers/localization_test_helper.dart';

class MockFetchUpcomingTicketsUseCase extends Mock
    implements FetchUpcomingTicketsUseCase {}

class MockFetchPastTicketsUseCase extends Mock
    implements FetchPastTicketsUseCase {}

class MockFetchTicketsYearlySummaryUseCase extends Mock
    implements FetchTicketsYearlySummaryUseCase {}

class MockFetchTicketQrUseCase extends Mock implements FetchTicketQrUseCase {}

class MockFetchTicketOrderIdUseCase extends Mock
    implements FetchTicketOrderIdUseCase {}

class MockToggleEventFavoriteUseCase extends Mock
    implements events_usecases.ToggleEventFavoriteUseCase {}

class MockFetchInvitationsUseCase extends Mock
    implements FetchInvitationsUseCase {}

class MockConfirmInvitationUseCase extends Mock
    implements ConfirmInvitationUseCase {}

class MockRejectInvitationUseCase extends Mock
    implements RejectInvitationUseCase {}

class MockCancelTicketUseCase extends Mock implements CancelTicketUseCase {}

class MockEventsRepository extends Mock implements EventsRepository {}

class MockTicketsCache extends Mock implements TicketsCache {}

class MockTicketQrCacheService extends Mock implements TicketQrCacheService {}

class MockScreenSecureService extends Mock implements ScreenSecureService {}

void main() {
  late MockFetchUpcomingTicketsUseCase fetchUpcomingTicketsUseCase;
  late MockFetchPastTicketsUseCase fetchPastTicketsUseCase;
  late MockFetchTicketsYearlySummaryUseCase fetchTicketsYearlySummaryUseCase;
  late MockFetchTicketQrUseCase fetchTicketQrUseCase;
  late MockFetchTicketOrderIdUseCase fetchTicketOrderIdUseCase;
  late MockToggleEventFavoriteUseCase toggleEventFavoriteUseCase;
  late MockFetchInvitationsUseCase fetchInvitationsUseCase;
  late MockConfirmInvitationUseCase confirmInvitationUseCase;
  late MockRejectInvitationUseCase rejectInvitationUseCase;
  late MockCancelTicketUseCase cancelTicketUseCase;
  late MockEventsRepository eventsRepository;
  late MockTicketsCache ticketsCache;
  late MockTicketQrCacheService ticketQrCacheService;
  late MockScreenSecureService screenSecureService;
  late TicketsProvider ticketsProvider;

  setUpAll(() {
    registerFallbackValue(const PastTicketsQuery());
  });

  setUp(() {
    fetchUpcomingTicketsUseCase = MockFetchUpcomingTicketsUseCase();
    fetchPastTicketsUseCase = MockFetchPastTicketsUseCase();
    fetchTicketsYearlySummaryUseCase = MockFetchTicketsYearlySummaryUseCase();
    fetchTicketQrUseCase = MockFetchTicketQrUseCase();
    fetchTicketOrderIdUseCase = MockFetchTicketOrderIdUseCase();
    toggleEventFavoriteUseCase = MockToggleEventFavoriteUseCase();
    fetchInvitationsUseCase = MockFetchInvitationsUseCase();
    confirmInvitationUseCase = MockConfirmInvitationUseCase();
    rejectInvitationUseCase = MockRejectInvitationUseCase();
    cancelTicketUseCase = MockCancelTicketUseCase();
    eventsRepository = MockEventsRepository();
    ticketsCache = MockTicketsCache();
    ticketQrCacheService = MockTicketQrCacheService();
    screenSecureService = MockScreenSecureService();

    ticketsProvider = TicketsProvider(
      fetchUpcomingTicketsUseCase: fetchUpcomingTicketsUseCase,
      fetchPastTicketsUseCase: fetchPastTicketsUseCase,
      fetchTicketsYearlySummaryUseCase: fetchTicketsYearlySummaryUseCase,
      fetchTicketQrUseCase: fetchTicketQrUseCase,
      fetchTicketOrderIdUseCase: fetchTicketOrderIdUseCase,
      toggleEventFavoriteUseCase: toggleEventFavoriteUseCase,
      fetchInvitationsUseCase: fetchInvitationsUseCase,
      confirmInvitationUseCase: confirmInvitationUseCase,
      rejectInvitationUseCase: rejectInvitationUseCase,
      cancelTicketUseCase: cancelTicketUseCase,
      eventsRepository: eventsRepository,
      ticketsCache: ticketsCache,
      ticketQrCacheService: ticketQrCacheService,
    );

    when(() => eventsRepository.fetchEventTypes()).thenAnswer((_) async => const []);
    when(() => ticketsCache.readUpcoming()).thenReturn(const []);
    when(() => ticketsCache.readPast(any())).thenReturn(const []);
    when(() => ticketsCache.saveUpcoming(any())).thenAnswer((_) async {});
    when(() => ticketsCache.savePast(any(), any())).thenAnswer((_) async {});
    when(() => ticketQrCacheService.scheduleMidnightPrecache(any()))
        .thenAnswer((_) {});

    when(() => screenSecureService.enable()).thenAnswer((_) async {});
    when(() => screenSecureService.disable()).thenAnswer((_) async {});

    when(() => fetchUpcomingTicketsUseCase(page: any(named: 'page'), limit: any(named: 'limit')))
        .thenAnswer(
      (_) async => const TicketsPageResult(
        items: [
          UpcomingTicketEntity(
            id: 'upcoming-1',
            title: 'Festival Verano 2026',
            dateLabel: 'Sábado 15 May · 22:00',
            locationLabel: 'Club Amanda',
            ticketTypeLabel: 'General · 1',
            imageAssetPath: AppAssets.dummyImage,
            canViewQr: true,
          ),
        ],
        total: 1,
        page: 1,
        limit: 20,
        totalPages: 1,
      ),
    );
    when(() => fetchPastTicketsUseCase(any())).thenAnswer(
      (_) async => const TicketsPageResult(
        items: [],
        total: 0,
        page: 1,
        limit: 20,
        totalPages: 1,
      ),
    );
    when(() => fetchTicketsYearlySummaryUseCase()).thenAnswer(
      (_) async => const TicketsYearlySummaryEntity(
        year: 2026,
        eventsAttended: 1,
      ),
    );
    when(() => ticketsCache.clearPast(any())).thenAnswer((_) async {});
    when(() => fetchInvitationsUseCase()).thenAnswer((_) async => const []);
  });

  testWidgets('MyTicketsScreen shows tabs and upcoming ticket card', (tester) async {
    final strings = lookupAppLocalizations(AppLocale.spanish);

    await tester.pumpWidget(
      LocalizationTestHelper.wrap(
        locale: const Locale('es'),
        child: ChangeNotifierProvider<TicketsProvider>.value(
          value: ticketsProvider,
          child: MyTicketsScreen(
            screenSecureService: screenSecureService,
          ),
        ),
      ),
    );

    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.text(strings.drawerMyTickets), findsOneWidget);
    expect(find.text(strings.ticketsTabUpcoming), findsOneWidget);
    expect(find.text(strings.ticketsTabPast), findsOneWidget);
    expect(find.text('Festival Verano 2026'), findsOneWidget);
    expect(find.text(strings.ticketsViewQr), findsWidgets);

    await tester.tap(find.text(strings.ticketsTabPast));
    await tester.pumpAndSettle();

    expect(find.text(strings.ticketsAttendedSectionTitle), findsOneWidget);
    verify(() => fetchPastTicketsUseCase(any())).called(1);
  });
}
