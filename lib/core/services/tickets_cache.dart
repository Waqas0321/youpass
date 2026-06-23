import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:youpass/core/utils/app_logger.dart';
import 'package:youpass/features/tickets/data/models/past_ticket_model.dart';
import 'package:youpass/features/tickets/data/models/upcoming_ticket_model.dart';
import 'package:youpass/features/tickets/domain/entities/past_event_entity.dart';
import 'package:youpass/features/tickets/domain/entities/past_tickets_query.dart';
import 'package:youpass/features/tickets/domain/entities/upcoming_ticket_entity.dart';

class TicketsCache {
  TicketsCache(this._preferences);

  static const String upcomingKey = 'tickets_cache_upcoming_v4';
  static const String pastKeyPrefix = 'tickets_cache_past_v1';

  final SharedPreferences _preferences;

  Future<void> saveUpcoming(List<UpcomingTicketEntity> tickets) async {
    try {
      final encoded = jsonEncode(tickets.map(_upcomingToJson).toList());
      await _preferences.setString(upcomingKey, encoded);
    } catch (error, stackTrace) {
      AppLogger.error(
        'Failed to cache upcoming tickets',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  List<UpcomingTicketEntity> readUpcoming() {
    final raw = _preferences.getString(upcomingKey);
    if (raw == null || raw.isEmpty) {
      return const [];
    }

    try {
      final decoded = jsonDecode(raw);
      if (decoded is! List) {
        return const [];
      }

      return decoded
          .whereType<Map<String, dynamic>>()
          .map(UpcomingTicketModel.fromJson)
          .toList();
    } catch (_) {
      return const [];
    }
  }

  Future<void> savePast(PastTicketsQuery query, List<PastEventEntity> events) async {
    try {
      final encoded = jsonEncode(events.map(_pastToJson).toList());
      await _preferences.setString(_pastKey(query), encoded);
    } catch (error, stackTrace) {
      AppLogger.error(
        'Failed to cache past tickets',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  List<PastEventEntity> readPast(PastTicketsQuery query) {
    final raw = _preferences.getString(_pastKey(query));
    if (raw == null || raw.isEmpty) {
      return const [];
    }

    try {
      final decoded = jsonDecode(raw);
      if (decoded is! List) {
        return const [];
      }

      return decoded
          .whereType<Map<String, dynamic>>()
          .map(PastTicketModel.fromJson)
          .toList();
    } catch (_) {
      return const [];
    }
  }

  Future<void> clearPast(PastTicketsQuery query) async {
    await _preferences.remove(_pastKey(query));
  }

  Future<void> clearAll() async {
    await clearAllPast();
  }

  Future<void> clearAllPast() async {
    final keys = _preferences
        .getKeys()
        .where((key) => key == upcomingKey || key.startsWith(pastKeyPrefix))
        .toList();
    for (final key in keys) {
      await _preferences.remove(key);
    }
  }

  String _pastKey(PastTicketsQuery query) {
    final search = query.search?.trim().toLowerCase() ?? '';
    final type = query.eventTypeSlug?.trim().toLowerCase() ?? 'all';
    return '$pastKeyPrefix:$type:$search';
  }

  Map<String, dynamic> _upcomingToJson(UpcomingTicketEntity ticket) {
    return {
      'id': ticket.id,
      'event_id': ticket.eventId,
      'event_title': ticket.title,
      'date_time_label': ticket.dateLabel,
      'location': ticket.locationLabel,
      'ticket_type_label': ticket.ticketTypeLabel,
      'image_url': ticket.imageAssetPath,
      'tier': ticket.tier.name,
      'status': ticket.displayStatus.name,
      'can_view_qr': ticket.canViewQr,
      'can_assign_tickets': ticket.canAssignTickets,
      'can_view_assigned_tickets': ticket.canViewAssignedTickets,
      'can_cancel': ticket.canCancel,
      'qr_status': ticket.qrStatus?.name,
      'ticket_order_id': ticket.ticketOrderId,
      'assignable_count': ticket.assignableCount,
      'origin': ticket.origin,
      'event_starts_at': ticket.eventStartsAt?.toIso8601String(),
    };
  }

  Map<String, dynamic> _pastToJson(PastEventEntity event) {
    return {
      'id': event.id,
      'event_id': event.eventId,
      'event_title': event.title,
      'location': event.locationLabel,
      'date_time_label': event.dateLabel,
      'image_url': event.imageAssetPath,
      'status': event.displayStatus.name,
      'is_favorite': event.isFavorite,
      'statistics': {
        'entry_time': event.entryTime,
        'consumption_count': event.consumptionCount,
        'stay_label': event.stayDurationLabel,
      },
    };
  }
}
