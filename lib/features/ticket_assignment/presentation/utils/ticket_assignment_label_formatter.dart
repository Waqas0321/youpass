import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/ticket_assignment_slot_entity.dart';
import 'package:youpass/l10n/app_localizations.dart';

class TicketAssignmentLabelFormatter {
  TicketAssignmentLabelFormatter._();

  static final RegExp _entradaPattern = RegExp(
    r'^(entrada|ticket)\s*(\d+)$',
    caseSensitive: false,
  );

  static String slotLabel(
    AppLocalizations l10n,
    TicketAssignmentSlotEntity slot, {
    int? displayNumber,
  }) {
    if (displayNumber != null && displayNumber > 0) {
      return AppStrings.ticketAssignmentSlotLabel(l10n, displayNumber);
    }

    final parsedNumber = _parseSlotNumber(slot.label);
    final number = parsedNumber ?? (slot.slotNumber > 0 ? slot.slotNumber : null);
    if (number != null) {
      return AppStrings.ticketAssignmentSlotLabel(l10n, number);
    }

    final apiLabel = slot.label.trim();
    if (apiLabel.isNotEmpty) {
      return apiLabel;
    }

    return AppStrings.ticketAssignmentSlotLabel(l10n, 1);
  }

  static int? _parseSlotNumber(String label) {
    final match = _entradaPattern.firstMatch(label.trim());
    if (match == null) {
      return null;
    }

    return int.tryParse(match.group(2) ?? '');
  }
}
