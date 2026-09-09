import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:youpass/l10n/app_localizations.dart';
import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_action_history_result.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/providers/staff_supervisor_action_history_provider.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_inline_access_history_section.dart';

import '../../../../../helpers/localization_test_helper.dart';

StaffSupervisorActionHistoryEntry _entry({
  required String id,
  String guestName = 'Invite Test Guest',
  String entryCode = 'QR-001',
  StaffSupervisorAccessResult result = StaffSupervisorAccessResult.valid,
  String timeLabel = '2m',
}) {
  return StaffSupervisorActionHistoryEntry(
    id: id,
    category: StaffSupervisorActionHistoryCategory.access,
    kind: 'scan',
    supervisorName: 'Party QA Staff',
    timeLabel: timeLabel,
    occurredAt: DateTime.now().toIso8601String(),
    result: result,
    guestName: guestName,
    entryCode: entryCode,
    ticketId: 'tkt_$id',
    ticketType: 'General',
    accessPoint: 'Puerta A',
  );
}

void main() {
  testWidgets('inline access history shows ticket scan rows when idle',
      (tester) async {
    final historyProvider = StaffSupervisorActionHistoryProvider(
      genericError: 'load failed',
    );
    historyProvider.isLoading = false;
    historyProvider.history = StaffSupervisorActionHistoryResult(
      eventId: 'evt_1',
      eventTitle: 'Urban Night Live',
      actions: [
        _entry(id: '1', guestName: 'Ana Pérez'),
        _entry(
          id: '2',
          guestName: 'Luis Soto',
          result: StaffSupervisorAccessResult.rejected,
        ),
      ],
      total: 2,
    );

    await tester.pumpWidget(
      LocalizationTestHelper.wrap(
        child: ChangeNotifierProvider.value(
          value: historyProvider,
          child: const Scaffold(
            body: SingleChildScrollView(
              child: StaffSupervisorInlineAccessHistorySection(),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final l10n = lookupAppLocalizations(const Locale('en'));
    expect(find.text(l10n.staffSupervisorRecentActionsTitle), findsOneWidget);
    expect(find.text('Ana Pérez'), findsOneWidget);
    expect(find.text('Luis Soto'), findsOneWidget);
    expect(find.text(l10n.staffSupervisorViewAllActions), findsOneWidget);
  });

  testWidgets('inline access history shows empty copy when no actions',
      (tester) async {
    final historyProvider = StaffSupervisorActionHistoryProvider(
      genericError: 'load failed',
    );
    historyProvider.isLoading = false;
    historyProvider.history = const StaffSupervisorActionHistoryResult(
      eventId: 'evt_1',
      eventTitle: 'Urban Night Live',
      actions: [],
      total: 0,
    );

    await tester.pumpWidget(
      LocalizationTestHelper.wrap(
        child: ChangeNotifierProvider.value(
          value: historyProvider,
          child: const Scaffold(
            body: SingleChildScrollView(
              child: StaffSupervisorInlineAccessHistorySection(),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final l10n = lookupAppLocalizations(const Locale('en'));
    expect(find.text(l10n.staffSupervisorAccessHistoryEmpty), findsOneWidget);
  });
}
