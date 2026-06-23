import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_status.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_status_extensions.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_tier.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_product_kind.dart';
import 'package:youpass/l10n/app_localizations.dart';

class InvitationsTextFactory {
  InvitationsTextFactory._();

  static bool isZeroValueFreeInvitation(InvitationEntity invitation) {
    final type = invitation.type?.toLowerCase();
    if (type != null && type != 'free') {
      return false;
    }

    final kind = InvitationProductKindX.fromApi(invitation.productKind) ??
        InvitationProductKind.free;
    if (kind != InvitationProductKind.free) {
      return false;
    }

    final entryValue = invitation.chargeAmount ?? 0;
    return entryValue <= 0;
  }

  static String statusLabel(
    AppLocalizations strings,
    InvitationStatus status,
  ) {
    switch (status) {
      case InvitationStatus.accepted:
      case InvitationStatus.confirmed:
      case InvitationStatus.validated:
        return AppStrings.invitationsStatusConfirmed(strings);
      case InvitationStatus.rejected:
      case InvitationStatus.expired:
      case InvitationStatus.canceled:
      case InvitationStatus.charged:
      case InvitationStatus.failed:
        return AppStrings.invitationsStatusRejected(strings);
      case InvitationStatus.sent:
      case InvitationStatus.viewed:
      case InvitationStatus.pending:
        return AppStrings.invitationsStatusPending(strings);
    }
  }

  static String productKindLabel(
    AppLocalizations strings,
    InvitationProductKind kind,
  ) {
    switch (kind) {
      case InvitationProductKind.free:
        return AppStrings.invitationsTypeFree(strings);
      case InvitationProductKind.guaranteedPass:
        return AppStrings.invitationsTypeGuaranteedPass(strings);
      case InvitationProductKind.discounted:
        return AppStrings.invitationsTypeDiscounted(strings);
    }
  }

  static String productLabelForInvitation(
    AppLocalizations strings,
    InvitationEntity invitation,
  ) {
    final kind = InvitationProductKindX.fromApi(invitation.productKind) ??
        InvitationProductKind.free;

    if (kind == InvitationProductKind.guaranteedPass ||
        kind == InvitationProductKind.discounted) {
      final apiLabel = invitation.productLabel?.trim();
      if (apiLabel != null && apiLabel.isNotEmpty) {
        return apiLabel;
      }
      return productKindLabel(strings, kind);
    }

    if (isZeroValueFreeInvitation(invitation)) {
      return AppStrings.invitationsTypeFree(strings);
    }

    final apiLabel = invitation.productLabel?.trim();
    if (apiLabel != null && apiLabel.isNotEmpty) {
      return apiLabel;
    }

    final source = invitation.source?.toLowerCase();
    if (source == 'producer') {
      return AppStrings.invitationsTypeFree(strings);
    }

    if (source == 'guest') {
      if (invitation.tier == InvitationTier.vip) {
        return AppStrings.invitationsTypeVip(strings);
      }
      return AppStrings.invitationsTypeAssigned(strings);
    }

    return AppStrings.invitationsTypeFree(strings);
  }

  static String tierLabel(
    AppLocalizations strings,
    InvitationEntity invitation,
  ) {
    final type = invitation.type?.toLowerCase();

    if (type == 'courtesy' && invitation.tier == InvitationTier.vip) {
      return AppStrings.invitationsTierVipDj(strings);
    }

    if (isZeroValueFreeInvitation(invitation)) {
      return AppStrings.invitationsTierFree(strings);
    }

    if (invitation.tier == InvitationTier.vip) {
      return AppStrings.invitationsTierVipMesa(strings);
    }

    return AppStrings.invitationsTierGeneral(strings);
  }

  static String? invitedByLabel(
    AppLocalizations strings,
    InvitationEntity invitation,
  ) {
    final invitedBy = invitation.invitedBy;
    if (invitedBy == null || invitedBy.name.isEmpty) {
      return null;
    }

    return AppStrings.invitationsInvitedBy(strings, invitedBy.name);
  }

  static String? acceptByLabel(
    AppLocalizations strings,
    InvitationEntity invitation,
  ) {
    if (!invitation.status.isPending) {
      return null;
    }

    final deadline = invitation.cancellationDeadlineLabel?.trim();
    if (deadline != null && deadline.isNotEmpty) {
      return AppStrings.invitationsCancelBy(strings, deadline);
    }

    final expires = invitation.expiresAtLabel?.trim();
    if (expires == null || expires.isEmpty) {
      return null;
    }

    return AppStrings.invitationsAcceptBy(strings, expires);
  }

  static String? qrAvailabilityLabel(
    AppLocalizations strings,
    InvitationEntity invitation,
  ) {
    if (!invitation.status.isAccepted || invitation.canFetchQrFromApi) {
      return null;
    }

    final dateLabel = invitation.dateTimeLabel.trim();
    if (dateLabel.isEmpty) {
      return AppStrings.invitationsQrLockedMessage(strings);
    }

    return AppStrings.invitationsQrAvailableOn(strings, dateLabel);
  }
}
