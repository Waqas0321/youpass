import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/core/locale/app_locale.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/ticket_assignment_slot_entity.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/ticket_slot_status.dart';
import 'package:youpass/features/ticket_assignment/presentation/widgets/assign_ticket_slot_card_widget.dart';
import 'package:youpass/l10n/app_localizations.dart';

void main() {
  testWidgets('shows guest phone from API on pending slots', (tester) async {
    const slot = TicketAssignmentSlotEntity(
      id: 'slot-2',
      slotNumber: 2,
      label: 'Entrada 2',
      status: TicketSlotStatus.pending,
      guestName: 'Me Jazz',
      guestPhone: '+56216548001',
      canCancel: true,
      canResend: true,
    );

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('es'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: AssignTicketSlotCardWidget(
            slot: slot,
            orderId: 'order-1',
            onAssign: (_, __) async => true,
            onCancel: () async => true,
            onResend: () async => true,
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Me Jazz'), findsOneWidget);
    expect(find.text('+56216548001'), findsOneWidget);
  });

  testWidgets('updates phone when slot guest_phone changes after refresh',
      (tester) async {
    const initialSlot = TicketAssignmentSlotEntity(
      id: 'slot-2',
      slotNumber: 2,
      label: 'Entrada 2',
      status: TicketSlotStatus.pending,
      guestName: 'Me Jazz',
      guestPhone: '03216548001',
      canCancel: true,
      canResend: true,
    );

    const refreshedSlot = TicketAssignmentSlotEntity(
      id: 'slot-2',
      slotNumber: 2,
      label: 'Entrada 2',
      status: TicketSlotStatus.pending,
      guestName: 'Me Jazz',
      guestPhone: '+56216548001',
      canCancel: true,
      canResend: true,
    );

    await tester.pumpWidget(
      MaterialApp(
        locale: AppLocale.spanish,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: _SlotHost(initialSlot: initialSlot, refreshedSlot: refreshedSlot),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('03216548001'), findsOneWidget);

    await tester.tap(find.text('Refresh'));
    await tester.pumpAndSettle();

    expect(find.text('+56216548001'), findsOneWidget);
    expect(find.text('03216548001'), findsNothing);
  });
}

class _SlotHost extends StatefulWidget {
  const _SlotHost({
    required this.initialSlot,
    required this.refreshedSlot,
  });

  final TicketAssignmentSlotEntity initialSlot;
  final TicketAssignmentSlotEntity refreshedSlot;

  @override
  State<_SlotHost> createState() => _SlotHostState();
}

class _SlotHostState extends State<_SlotHost> {
  late TicketAssignmentSlotEntity slot;

  @override
  void initState() {
    super.initState();
    slot = widget.initialSlot;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AssignTicketSlotCardWidget(
            slot: slot,
            orderId: 'order-1',
            onAssign: (_, __) async => true,
            onCancel: () async => true,
            onResend: () async => true,
          ),
          TextButton(
            onPressed: () => setState(() => slot = widget.refreshedSlot),
            child: const Text('Refresh'),
          ),
        ],
      ),
    );
  }
}
