import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:youpass/core/utils/app_logger.dart';
import 'package:youpass/features/invitations/data/models/invitation_ticket_model.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_ticket_entity.dart';
import 'package:youpass/features/tickets/data/services/tickets_api_service.dart';
import 'package:youpass/features/tickets/domain/entities/upcoming_ticket_entity.dart';

class TicketQrCacheService {
  TicketQrCacheService({
    required TicketsApiService ticketsApiService,
    required SharedPreferences preferences,
  })  : _ticketsApiService = ticketsApiService,
        _preferences = preferences;

  static const String keyPrefix = 'ticket_qr_cache_v1';

  final TicketsApiService _ticketsApiService;
  final SharedPreferences _preferences;
  Timer? _midnightTimer;

  void scheduleMidnightPrecache(List<UpcomingTicketEntity> tickets) {
    _midnightTimer?.cancel();
    final now = DateTime.now();
    final nextMidnight = DateTime(now.year, now.month, now.day + 1);
    final delay = nextMidnight.difference(now);

    _midnightTimer = Timer(delay, () {
      unawaited(precacheEligibleTickets(tickets));
      scheduleMidnightPrecache(tickets);
    });

    unawaited(precacheEligibleTickets(tickets));
  }

  void dispose() {
    _midnightTimer?.cancel();
  }

  Future<void> precacheEligibleTickets(List<UpcomingTicketEntity> tickets) async {
    final today = DateTime.now();
    final todayKey = _dayKey(today);

    for (final ticket in tickets) {
      final startsAt = ticket.eventStartsAt;
      if (startsAt == null) {
        continue;
      }

      final isEventDay = _isSameDay(startsAt, today);
      if (!isEventDay || !ticket.canViewQr) {
        continue;
      }

      final cacheKey = '$keyPrefix:${ticket.id}:$todayKey';
      if (_preferences.containsKey(cacheKey)) {
        continue;
      }

      try {
        final qrTicket = await _ticketsApiService.fetchTicketQr(ticket.id);
        await _save(cacheKey, qrTicket);
        AppLogger.info('Pre-cached QR for ticket ${ticket.id}');
      } catch (error, stackTrace) {
        AppLogger.error(
          'Failed to pre-cache QR for ticket ${ticket.id}',
          error: error,
          stackTrace: stackTrace,
        );
      }
    }
  }

  InvitationTicketEntity? readCached(String ticketId) {
    final cacheKey = '$keyPrefix:$ticketId:${_dayKey(DateTime.now())}';
    final raw = _preferences.getString(cacheKey);
    if (raw == null || raw.isEmpty) {
      return null;
    }

    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map<String, dynamic>) {
        return null;
      }
      return InvitationTicketModel.fromJson(
        decoded,
        invitationId: decoded['invitation_id']?.toString() ?? ticketId,
      );
    } catch (_) {
      return null;
    }
  }

  Future<void> _save(String cacheKey, InvitationTicketEntity ticket) async {
    final payload = {
      'invitation_id': ticket.invitationId,
      'event_title': ticket.eventTitle,
      'date_time_label': ticket.dateTimeLabel,
      'location': ticket.locationLabel,
      'entry_code': ticket.entryCode,
      'qr_payload': ticket.qrPayload,
      'seat_label': ticket.seatLabel,
    };
    await _preferences.setString(cacheKey, jsonEncode(payload));
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  String _dayKey(DateTime date) =>
      '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
}
