import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_status.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_tier.dart';
import 'package:youpass/l10n/app_localizations.dart';

class InvitationsTextFactory {
  InvitationsTextFactory._();

  static String statusLabel(
    AppLocalizations strings,
    InvitationStatus status,
  ) {
    switch (status) {
      case InvitationStatus.confirmed:
        return AppStrings.invitationsStatusConfirmed(strings);
      case InvitationStatus.rejected:
        return AppStrings.invitationsStatusRejected(strings);
      case InvitationStatus.pending:
        return AppStrings.invitationsStatusPending(strings);
    }
  }

  static String tierLabel(
    AppLocalizations strings,
    InvitationEntity invitation,
  ) {
    if (invitation.tier == InvitationTier.vip) {
      return AppStrings.invitationsTierVipMesa(strings);
    }
    return AppStrings.invitationsTierGeneral(strings);
  }
}
