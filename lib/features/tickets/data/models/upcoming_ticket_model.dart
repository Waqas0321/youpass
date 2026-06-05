import 'package:youpass/features/tickets/data/utils/ticket_model_json_reader.dart';
import 'package:youpass/features/tickets/domain/entities/ticket_tier.dart';
import 'package:youpass/features/tickets/domain/entities/upcoming_ticket_entity.dart';

class UpcomingTicketModel extends UpcomingTicketEntity {
  const UpcomingTicketModel({
    required super.id,
    required super.title,
    required super.dateLabel,
    required super.locationLabel,
    required super.ticketTypeLabel,
    required super.imageAssetPath,
    super.eventId,
    super.tier = TicketTier.general,
    super.isActive = true,
    super.canViewQr = false,
    super.canAssignTickets = false,
    super.qrStatus,
    super.ticketOrderId,
    super.assignableCount,
    super.origin,
  });

  factory UpcomingTicketModel.fromJson(Map<String, dynamic> json) {
    final ticketTypeLabel = TicketModelJsonReader.readString(
      json,
      'ticket_type_label',
      'ticketTypeLabel',
      'type',
    );
    final ticketCount = TicketModelJsonReader.readInt(
      json['ticket_count'] ?? json['ticketCount'],
      fallback: 1,
    );
    final composedTypeLabel = ticketTypeLabel.isEmpty
        ? '$ticketCount'
        : '$ticketTypeLabel · $ticketCount';

    final status = json['status']?.toString().toLowerCase();
    final ticketOrderId = readTicketOrderId(json);
    final assignableCount = TicketModelJsonReader.readInt(
      json['assignable_count'] ?? json['assignableCount'],
      fallback: 0,
    );
    final origin = json['origin']?.toString();
    final canAssignTickets = TicketModelJsonReader.readBool(
          json['can_assign_tickets'] ?? json['canAssignTickets'],
        ) ||
        (ticketOrderId != null && ticketOrderId.isNotEmpty) ||
        assignableCount > 0 ||
        origin == 'purchase';

    return UpcomingTicketModel(
      id: json['id']?.toString() ?? '',
      eventId: json['event_id']?.toString() ?? json['eventId']?.toString(),
      title: TicketModelJsonReader.readString(
        json,
        'event_title',
        'eventTitle',
        'title',
      ),
      dateLabel: TicketModelJsonReader.readString(
        json,
        'date_time_label',
        'dateTimeLabel',
        'dateLabel',
      ),
      locationLabel: TicketModelJsonReader.readString(
        json,
        'location',
        'location_label',
        'venue',
      ),
      ticketTypeLabel: composedTypeLabel,
      imageAssetPath: TicketModelJsonReader.readString(
        json,
        'image_url',
        'imageUrl',
        'image_asset_path',
      ),
      tier: TicketModelJsonReader.parseTier(json['tier'] ?? json['type']),
      isActive: status == 'active',
      canViewQr: TicketModelJsonReader.readBool(
        json['can_view_qr'] ?? json['canViewQr'],
      ),
      canAssignTickets: canAssignTickets,
      qrStatus: TicketModelJsonReader.parseQrStatus(
        json['qr_status'] ?? json['qrStatus'],
      ),
      ticketOrderId: ticketOrderId,
      assignableCount: assignableCount,
      origin: origin,
    );
  }

  static String? readTicketOrderId(Map<String, dynamic> json) {
    final direct = json['ticket_order_id'] ??
        json['ticketOrderId'] ??
        json['order_id'] ??
        json['orderId'];
    if (direct != null) {
      final value = direct.toString().trim();
      if (value.isNotEmpty) {
        return value;
      }
    }

    final order = json['order'];
    if (order is Map<String, dynamic>) {
      final nested = order['id'] ?? order['order_id'] ?? order['orderId'];
      if (nested != null) {
        final value = nested.toString().trim();
        if (value.isNotEmpty) {
          return value;
        }
      }
    }

    return null;
  }
}
