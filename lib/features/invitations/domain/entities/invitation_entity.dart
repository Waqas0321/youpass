import 'package:equatable/equatable.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_invited_by_entity.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_qr_status.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_status.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_status_extensions.dart';
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
    this.eventTypeSlug,
    this.type,
    this.source,
    this.productKind,
    this.productLabel,
    this.typeColorHex,
    this.requiresPaymentMethod = false,
    this.termsAcceptedRequired = false,
    this.chargeAmount,
    this.chargeCurrency,
    this.discountPercent,
    this.acceptAmount,
    this.acceptAmountLabel,
    this.noShowChargeAmount,
    this.noShowChargeLabel,
    this.customMessage,
    this.cancellationDeadlineLabel,
    this.entryCode,
    this.qrPayload,
    this.qrStatus,
    this.invitedBy,
    this.expiresAtLabel,
    this.assignedSlot,
    this.statusLabel,
    this.deepLink,
    this.canConfirm = false,
    this.canReject = false,
    this.canCancel = false,
    this.canViewQr = false,
    this.preauthActive = false,
  });

  final String id;
  final String? eventId;
  final String? eventTypeSlug;
  final String eventTitle;
  final String locationLabel;
  final String dateTimeLabel;
  final String imageAssetPath;
  final InvitationTier tier;
  final InvitationStatus status;
  final String? type;
  final String? source;
  final String? productKind;
  final String? productLabel;
  final String? typeColorHex;
  final bool requiresPaymentMethod;
  final bool termsAcceptedRequired;
  final double? chargeAmount;
  final String? chargeCurrency;
  final int? discountPercent;
  final double? acceptAmount;
  final String? acceptAmountLabel;
  final double? noShowChargeAmount;
  final String? noShowChargeLabel;
  final String? customMessage;
  final String? cancellationDeadlineLabel;
  final String? entryCode;
  final String? qrPayload;
  final InvitationQrStatus? qrStatus;
  final InvitationInvitedByEntity? invitedBy;
  final String? expiresAtLabel;
  final String? assignedSlot;
  final String? statusLabel;
  final String? deepLink;
  final bool canConfirm;
  final bool canReject;
  final bool canCancel;
  final bool canViewQr;
  final bool preauthActive;

  bool get isGuaranteedPass => productKind == 'guaranteed_pass';

  bool get usesNetworkImage {
    final value = imageAssetPath.trim().toLowerCase();
    return value.startsWith('http://') || value.startsWith('https://');
  }

  bool get canFetchQrFromApi {
    return status.isAccepted && qrStatus == InvitationQrStatus.available;
  }

  bool get isQrLockedForDisplay {
    return status.isAccepted &&
        (qrStatus == InvitationQrStatus.locked ||
            (qrStatus == null && (qrPayload == null || qrPayload!.isEmpty)));
  }

  bool get isQrExpiredForDisplay {
    return status.isAccepted && qrStatus == InvitationQrStatus.expired;
  }

  @override
  List<Object?> get props => [
        id,
        eventId,
        eventTypeSlug,
        eventTitle,
        locationLabel,
        dateTimeLabel,
        imageAssetPath,
        tier,
        status,
        type,
        source,
        productKind,
        productLabel,
        typeColorHex,
        requiresPaymentMethod,
        termsAcceptedRequired,
        chargeAmount,
        chargeCurrency,
        discountPercent,
        acceptAmount,
        acceptAmountLabel,
        noShowChargeAmount,
        noShowChargeLabel,
        customMessage,
        cancellationDeadlineLabel,
        entryCode,
        qrPayload,
        qrStatus,
        invitedBy,
        expiresAtLabel,
        assignedSlot,
        statusLabel,
        deepLink,
        canConfirm,
        canReject,
        canCancel,
        canViewQr,
        preauthActive,
      ];
}
