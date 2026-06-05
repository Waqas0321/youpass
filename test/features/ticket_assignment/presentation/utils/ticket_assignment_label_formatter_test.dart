import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/core/locale/app_locale.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/ticket_assignment_slot_entity.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/ticket_slot_status.dart';
import 'package:youpass/features/ticket_assignment/presentation/utils/ticket_assignment_label_formatter.dart';
import 'package:youpass/l10n/app_localizations.dart';

void main() {
  const slotFromApi = TicketAssignmentSlotEntity(
    id: 'slot-2',
    slotNumber: 2,
    label: 'Entrada 2',
    status: TicketSlotStatus.available,
    canSend: true,
  );

  test('slotLabel localizes Entrada N using app locale', () {
    final english = lookupAppLocalizations(AppLocale.english);
    final spanish = lookupAppLocalizations(AppLocale.spanish);

    expect(
      TicketAssignmentLabelFormatter.slotLabel(english, slotFromApi),
      'Ticket 2',
    );
    expect(
      TicketAssignmentLabelFormatter.slotLabel(spanish, slotFromApi),
      'Entrada 2',
    );
  });

  test('slotLabel uses slotNumber when API label is empty', () {
    const slot = TicketAssignmentSlotEntity(
      id: 'slot-3',
      slotNumber: 3,
      label: '',
      status: TicketSlotStatus.available,
      canSend: true,
    );

    final english = lookupAppLocalizations(AppLocale.english);
    expect(
      TicketAssignmentLabelFormatter.slotLabel(english, slot),
      'Ticket 3',
    );
  });
}
