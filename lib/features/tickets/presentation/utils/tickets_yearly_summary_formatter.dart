import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/features/tickets/domain/entities/tickets_yearly_summary_entity.dart';
import 'package:youpass/l10n/app_localizations.dart';

class TicketsYearlySummaryFormatter {
  TicketsYearlySummaryFormatter._();

  static String buildSubtitle(
    AppLocalizations l10n,
    TicketsYearlySummaryEntity? summary,
  ) {
    if (summary == null) {
      return AppStrings.ticketsAttendedSectionSubtitle(l10n);
    }

    final attendedLine = AppStrings.ticketsYearlySummaryAttended(
      l10n,
      count: summary.eventsAttended,
      year: summary.year,
    );

    final producerName = summary.favoriteProducerName;
    final producerCount = summary.favoriteProducerEventsAttended;
    if (producerName == null ||
        producerName.isEmpty ||
        producerCount == null ||
        producerCount <= 0) {
      return attendedLine;
    }

    return '$attendedLine\n${AppStrings.ticketsYearlySummaryProducer(
      l10n,
      name: producerName,
      count: producerCount,
    )}';
  }
}
