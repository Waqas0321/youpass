import 'package:equatable/equatable.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_qr_status.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_status.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_tier.dart';

class InvitationEntity extends Equatable {
  const InvitationEntity({
    required this.id,
    required this.eventTitle,
    required this.locationLabel,
    required this.dateTimeLabel,
    required this.imageAssetPath,
    required this.tier,
    required this.status,
    this.eventId,
    this.type,
    this.requiresPaymentMethod = false,
    this.entryCode,
    this.qrPayload,
    this.qrStatus,
  });

  final String id;
  final String? eventId;
  final String eventTitle;
  final String locationLabel;
  final String dateTimeLabel;
  final String imageAssetPath;
  final InvitationTier tier;
  final InvitationStatus status;
  final String? type;
  final bool requiresPaymentMethod;
  final String? entryCode;
  final String? qrPayload;
  final InvitationQrStatus? qrStatus;

  bool get usesNetworkImage {
    final value = imageAssetPath.trim().toLowerCase();
    return value.startsWith('http://') || value.startsWith('https://');
  }

  bool get canFetchQrFromApi {
    return status == InvitationStatus.confirmed &&
        qrStatus != InvitationQrStatus.expired;
  }

  @override
  List<Object?> get props => [
        id,
        eventId,
        eventTitle,
        locationLabel,
        dateTimeLabel,
        imageAssetPath,
        tier,
        status,
        type,
        requiresPaymentMethod,
        entryCode,
        qrPayload,
        qrStatus,
      ];
}
