import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
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
    super.type,
    super.requiresPaymentMethod = false,
    super.entryCode,
    super.qrPayload,
    super.qrStatus,
  });

  factory InvitationModel.fromJson(Map<String, dynamic> json) {
    return InvitationModel(
      id: json['id']?.toString() ?? '',
      eventId: json['event_id']?.toString() ?? json['eventId']?.toString(),
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
      status: _parseStatus(json['status']),
      requiresPaymentMethod: _parseBool(
        json['requires_payment_method'] ?? json['requiresPaymentMethod'],
      ),
      entryCode: json['entry_code']?.toString() ?? json['entryCode']?.toString(),
      qrPayload: json['qr_payload']?.toString() ?? json['qrPayload']?.toString(),
      qrStatus: _parseQrStatus(json['qr_status'] ?? json['qrStatus']),
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
      case 'confirmed':
        return InvitationStatus.confirmed;
      case 'rejected':
      case 'declined':
        return InvitationStatus.rejected;
      default:
        return InvitationStatus.pending;
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
