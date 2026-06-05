import 'package:youpass/features/invitations/domain/entities/invitation_qr_status.dart';
import 'package:youpass/features/tickets/domain/entities/ticket_tier.dart';

class TicketModelJsonReader {
  static String readString(
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

  static int readInt(Object? value, {int fallback = 0}) {
    if (value is int) {
      return value;
    }
    if (value is num) {
      return value.toInt();
    }
    return int.tryParse(value?.toString() ?? '') ?? fallback;
  }

  static bool readBool(Object? value) {
    if (value is bool) {
      return value;
    }
    if (value is num) {
      return value != 0;
    }
    final normalized = value?.toString().toLowerCase();
    return normalized == 'true' || normalized == '1';
  }

  static TicketTier parseTier(Object? value) {
    final normalized = value?.toString().toLowerCase();
    if (normalized == 'vip') {
      return TicketTier.vip;
    }
    return TicketTier.general;
  }

  static InvitationQrStatus? parseQrStatus(Object? value) {
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
}
