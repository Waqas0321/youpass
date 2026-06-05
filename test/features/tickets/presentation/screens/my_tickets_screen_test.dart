import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/constants/app_assets.dart';
import 'package:youpass/core/locale/app_locale.dart';
import 'package:youpass/features/events/domain/usecases/toggle_event_favorite_usecase.dart'
    as events_usecases;
import 'package:youpass/features/tickets/domain/entities/past_tickets_query.dart';
import 'package:youpass/features/tickets/domain/entities/tickets_yearly_summary_entity.dart';
import 'package:youpass/features/tickets/domain/entities/upcoming_ticket_entity.dart';
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

void main() {
  late MockFetchUpcomingTicketsUseCase fetchUpcomingTicketsUseCase;
  late MockFetchPastTicketsUseCase fetchPastTicketsUseCase;
  late MockFetchTicketsYearlySummaryUseCase fetchTicketsYearlySummaryUseCase;
  late MockFetchTicketQrUseCase fetchTicketQrUseCase;
  late MockFetchTicketOrderIdUseCase fetchTicketOrderIdUseCase;
  late MockToggleEventFavoriteUseCase toggleEventFavoriteUseCase;
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

    ticketsProvider = TicketsProvider(
      fetchUpcomingTicketsUseCase: fetchUpcomingTicketsUseCase,
      fetchPastTicketsUseCase: fetchPastTicketsUseCase,
      fetchTicketsYearlySummaryUseCase: fetchTicketsYearlySummaryUseCase,
      fetchTicketQrUseCase: fetchTicketQrUseCase,
      fetchTicketOrderIdUseCase: fetchTicketOrderIdUseCase,
      toggleEventFavoriteUseCase: toggleEventFavoriteUseCase,
    );

    when(() => fetchUpcomingTicketsUseCase()).thenAnswer(
      (_) async => const [
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
    );
    when(() => fetchPastTicketsUseCase(any())).thenAnswer(
      (_) async => const [],
    );
    when(() => fetchTicketsYearlySummaryUseCase()).thenAnswer(
      (_) async => const TicketsYearlySummaryEntity(
        year: 2026,
        eventsAttended: 1,
      ),
    );
  });

  testWidgets('MyTicketsScreen shows tabs and upcoming ticket card', (tester) async {
    final strings = lookupAppLocalizations(AppLocale.spanish);

    await tester.pumpWidget(
      LocalizationTestHelper.wrap(
        locale: const Locale('es'),
        child: ChangeNotifierProvider<TicketsProvider>.value(
          value: ticketsProvider,
          child: const MyTicketsScreen(),
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
