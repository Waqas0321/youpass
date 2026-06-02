import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
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
    super.entryCode,
    super.qrPayload,
  });

  factory InvitationModel.fromJson(Map<String, dynamic> json) {
    return InvitationModel(
      id: json['id']?.toString() ?? '',
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
      status: _parseStatus(json['status']),
      entryCode: json['entry_code']?.toString() ?? json['entryCode']?.toString(),
      qrPayload: json['qr_payload']?.toString() ?? json['qrPayload']?.toString(),
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
