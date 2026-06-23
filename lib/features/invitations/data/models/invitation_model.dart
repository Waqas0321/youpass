import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_invited_by_entity.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_qr_status.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_status.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_tier.dart';

class InvitationModel extends InvitationEntity {
  const InvitationModel({
    required super.id,
    required super.eventTitle,
    required super.locationLabel,
    required super.dateTimeLabel,
    required super.imageAssetPath,
    required super.tier,
    required super.status,
    super.eventId,
    super.eventTypeSlug,
    super.type,
    super.source,
    super.productKind,
    super.productLabel,
    super.typeColorHex,
    super.requiresPaymentMethod = false,
    super.termsAcceptedRequired = false,
    super.chargeAmount,
    super.chargeCurrency,
    super.discountPercent,
    super.acceptAmount,
    super.acceptAmountLabel,
    super.noShowChargeAmount,
    super.noShowChargeLabel,
    super.customMessage,
    super.cancellationDeadlineLabel,
    super.entryCode,
    super.qrPayload,
    super.qrStatus,
    super.invitedBy,
    super.expiresAtLabel,
    super.assignedSlot,
    super.statusLabel,
    super.deepLink,
    super.canConfirm = false,
    super.canReject = false,
    super.canCancel = false,
    super.canViewQr = false,
    super.preauthActive = false,
  });

  factory InvitationModel.fromJson(Map<String, dynamic> json) {
    return InvitationModel(
      id: json['id']?.toString() ?? '',
      eventId: json['event_id']?.toString() ?? json['eventId']?.toString(),
      eventTypeSlug: _readEventTypeSlug(json),
      eventTitle: _readString(json, 'event_title', 'eventTitle', 'title'),
      locationLabel: _readString(json, 'location', 'location_label', 'venue'),
      dateTimeLabel: _readString(
        json,
        'date_time_label',
        'dateTimeLabel',
        'datetime',
      ),
      imageAssetPath: _readString(
        json,
        'image_url',
        'imageUrl',
        'image_asset_path',
        fallback: '',
      ),
      tier: _parseTier(json['tier'] ?? json['ticket_tier']),
      type: json['type']?.toString(),
      source: json['source']?.toString(),
      productKind: json['product_kind']?.toString() ?? json['productKind']?.toString(),
      productLabel: json['product_label']?.toString() ?? json['productLabel']?.toString(),
      typeColorHex: json['type_color']?.toString() ?? json['typeColor']?.toString(),
      status: _parseStatus(json['lifecycle_state'] ?? json['status']),
      requiresPaymentMethod: _parseBool(
        json['requires_payment_method'] ?? json['requiresPaymentMethod'],
      ),
      termsAcceptedRequired: _parseBool(
        json['terms_accepted_required'] ?? json['termsAcceptedRequired'],
      ),
      chargeAmount: _parseDouble(
        json['entry_value'] ?? json['charge_amount'] ?? json['chargeAmount'],
      ),
      chargeCurrency: json['charge_currency']?.toString() ?? json['chargeCurrency']?.toString(),
      discountPercent: _parseInt(
        json['discount_percentage'] ?? json['discount_percent'] ?? json['discountPercent'],
      ),
      acceptAmount: _parseDouble(
        json['amount_to_pay'] ?? json['accept_amount'] ?? json['acceptAmount'],
      ),
      acceptAmountLabel:
          json['accept_amount_label']?.toString() ?? json['acceptAmountLabel']?.toString(),
      noShowChargeAmount:
          _parseDouble(json['no_show_charge_amount'] ?? json['noShowChargeAmount']),
      noShowChargeLabel:
          json['no_show_charge_label']?.toString() ?? json['noShowChargeLabel']?.toString(),
      customMessage: json['custom_message']?.toString() ?? json['customMessage']?.toString(),
      cancellationDeadlineLabel: json['cancellation_deadline_label']?.toString() ??
          json['cancellationDeadlineLabel']?.toString(),
      entryCode: json['entry_code']?.toString() ?? json['entryCode']?.toString(),
      qrPayload: json['qr_payload']?.toString() ?? json['qrPayload']?.toString(),
      qrStatus: _parseQrStatus(json['qr_status'] ?? json['qrStatus']),
      invitedBy: _parseInvitedBy(json['invited_by'] ?? json['invitedBy']),
      expiresAtLabel: json['expires_at_label']?.toString() ??
          json['expiresAtLabel']?.toString(),
      assignedSlot:
          json['assigned_slot']?.toString() ?? json['assignedSlot']?.toString(),
      statusLabel:
          json['status_label']?.toString() ?? json['statusLabel']?.toString(),
      deepLink: json['deep_link']?.toString() ?? json['deepLink']?.toString(),
      canConfirm: _parseBool(json['can_confirm'] ?? json['canConfirm']),
      canReject: _parseBool(json['can_reject'] ?? json['canReject']),
      canCancel: _parseBool(json['can_cancel'] ?? json['canCancel']),
      canViewQr: _parseBool(json['can_view_qr'] ?? json['canViewQr']),
      preauthActive:
          _parseBool(json['preauth_active'] ?? json['preauthActive']),
    );
  }

  static InvitationInvitedByEntity? _parseInvitedBy(Object? value) {
    if (value is! Map<String, dynamic>) {
      return null;
    }

    final name = value['name']?.toString();
    if (name == null || name.isEmpty) {
      return null;
    }

    return InvitationInvitedByEntity(
      name: name,
      role: value['role']?.toString() ?? 'producer',
    );
  }

  static String _readString(
    Map<String, dynamic> json,
    String key,
    String altKey,
    String altKey2, {
    String fallback = '',
  }) {
    final value = json[key] ?? json[altKey] ?? json[altKey2];
    if (value == null) {
      return fallback;
    }
    return value.toString();
  }

  static bool _parseBool(Object? value) {
    if (value is bool) {
      return value;
    }
    if (value is num) {
      return value != 0;
    }
    final normalized = value?.toString().toLowerCase();
    return normalized == 'true' || normalized == '1';
  }

  static double? _parseDouble(Object? value) {
    if (value is num) {
      return value.toDouble();
    }
    return double.tryParse(value?.toString() ?? '');
  }

  static int? _parseInt(Object? value) {
    if (value is int) {
      return value;
    }
    if (value is num) {
      return value.toInt();
    }
    return int.tryParse(value?.toString() ?? '');
  }

  static InvitationTier _parseTier(Object? value) {
    final normalized = value?.toString().toLowerCase();
    if (normalized == 'vip') {
      return InvitationTier.vip;
    }
    return InvitationTier.general;
  }

  static InvitationStatus _parseStatus(Object? value) {
    final normalized = value?.toString().toLowerCase();
    switch (normalized) {
      case 'sent':
        return InvitationStatus.sent;
      case 'viewed':
        return InvitationStatus.viewed;
      case 'accepted':
      case 'confirmed':
        return InvitationStatus.accepted;
      case 'rejected':
      case 'declined':
        return InvitationStatus.rejected;
      case 'expired':
        return InvitationStatus.expired;
      case 'canceled':
      case 'cancelled':
        return InvitationStatus.canceled;
      case 'validated':
        return InvitationStatus.validated;
      case 'charged':
        return InvitationStatus.charged;
      case 'failed':
        return InvitationStatus.failed;
      case 'pending':
        return InvitationStatus.pending;
      default:
        return InvitationStatus.sent;
    }
  }

  static InvitationQrStatus? _parseQrStatus(Object? value) {
    final normalized = value?.toString().toLowerCase();
    switch (normalized) {
      case 'available':
      case 'ready':
      case 'unlocked':
        return InvitationQrStatus.available;
      case 'expired':
        return InvitationQrStatus.expired;
      case 'locked':
        return InvitationQrStatus.locked;
      default:
        return null;
    }
  }

  static String? _readEventTypeSlug(Map<String, dynamic> json) {
    final eventType = json['event_type'] ?? json['eventType'];
    if (eventType is Map<String, dynamic>) {
      return eventType['slug']?.toString();
    }
    return eventType?.toString();
  }

  static List<InvitationModel> listFromPayload(Object? payload) {
    if (payload is List) {
      return payload
          .whereType<Map<String, dynamic>>()
          .map(InvitationModel.fromJson)
          .toList();
    }

    if (payload is Map<String, dynamic>) {
      final nested = payload['invitations'] ?? payload['items'] ?? payload['data'];
      return listFromPayload(nested);
    }

    return const [];
  }
}
