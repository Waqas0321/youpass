import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:youpass/l10n/app_localizations.dart';
import 'package:youpass/staff_app/features/supervisor/drinks/domain/models/staff_supervisor_bar_action_history_result.dart';
import 'package:youpass/staff_app/features/supervisor/drinks/presentation/providers/staff_supervisor_drink_lookup_provider.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/screens/staff_supervisor_cancellations_screen.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_inline_bar_history_section.dart';

import '../../../../../helpers/localization_test_helper.dart';

StaffSupervisorBarActionHistoryEntry _entry({
  required String id,
  String productName = 'Piscola',
  String guestName = 'Party QA Guest',
  String timeLabel = '2m',
}) {
  return StaffSupervisorBarActionHistoryEntry(
    id: id,
    scope: 'bar',
    kind: 'redeem',
    dashboardType: 'manual_validation',
    supervisorName: 'Party QA Staff',
    guestName: guestName,
    timeLabel: timeLabel,
    occurredAt: DateTime.now().toIso8601String(),
    redemptionId: 'red_$id',
    entryId: 'entry_$id',
    result: StaffSupervisorRedemptionResult.redeemed,
    productName: productName,
    productQuantity: 1,
    barName: 'Barra Principal',
  );
}

void main() {
  testWidgets('inline bar history shows redemption rows when idle', (tester) async {
    final historyProvider = StaffSupervisorBarDashboardProvider(
      genericLoadError: 'load failed',
    );
    historyProvider.isLoading = false;
    historyProvider.history = StaffSupervisorBarActionHistoryResult(
      eventId: 'evt_1',
      eventTitle: 'Sunset Sessions',
      actions: [
        _entry(id: '1', productName: 'Corona'),
        _entry(id: '2', productName: 'Jager Bomb', guestName: 'Invite Guest'),
      ],
      total: 2,
    );

    await tester.pumpWidget(
      LocalizationTestHelper.wrap(
        child: ChangeNotifierProvider.value(
          value: historyProvider,
          child: const Scaffold(
            body: SingleChildScrollView(
              child: StaffSupervisorInlineBarHistorySection(),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final l10n = lookupAppLocalizations(const Locale('en'));
    expect(find.text(l10n.staffSupervisorRecentActionsTitle), findsOneWidget);
    expect(find.text('Corona'), findsOneWidget);
    expect(find.text('Jager Bomb'), findsOneWidget);
    expect(find.text(l10n.staffSupervisorViewAllActions), findsOneWidget);
  });

  testWidgets('inline bar history shows empty copy when no actions', (tester) async {
    final historyProvider = StaffSupervisorBarDashboardProvider(
      genericLoadError: 'load failed',
    );
    historyProvider.isLoading = false;
    historyProvider.history = const StaffSupervisorBarActionHistoryResult(
      eventId: 'evt_1',
      eventTitle: 'Sunset Sessions',
      actions: [],
      total: 0,
    );

    await tester.pumpWidget(
      LocalizationTestHelper.wrap(
        child: ChangeNotifierProvider.value(
          value: historyProvider,
          child: const Scaffold(
            body: SingleChildScrollView(
              child: StaffSupervisorInlineBarHistorySection(),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final l10n = lookupAppLocalizations(const Locale('en'));
    expect(find.text(l10n.staffSupervisorRedemptionHistoryEmpty), findsOneWidget);
  });

  testWidgets('cancellations screen shows history when no purchase selected', (
    tester,
  ) async {
    final lookup = StaffSupervisorDrinkLookupProvider(
      genericSearchError: 'search failed',
      genericLoadError: 'load failed',
    );
    final historyProvider = StaffSupervisorBarDashboardProvider(
      genericLoadError: 'load failed',
    );
    historyProvider.isLoading = false;
    historyProvider.history = StaffSupervisorBarActionHistoryResult(
      eventId: 'evt_1',
      eventTitle: 'Sunset Sessions',
      actions: [_entry(id: '9', productName: 'Tropical Gin')],
      total: 1,
    );

    await tester.pumpWidget(
      LocalizationTestHelper.wrap(
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: lookup),
            ChangeNotifierProvider.value(value: historyProvider),
          ],
          child: const StaffSupervisorCancellationsScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final l10n = lookupAppLocalizations(const Locale('en'));
    expect(find.text(l10n.staffSupervisorSearchManagePurchaseTitle), findsOneWidget);
    expect(find.text('Tropical Gin'), findsOneWidget);
    expect(find.text(l10n.staffSupervisorRecentActionsTitle), findsOneWidget);
  });
}
