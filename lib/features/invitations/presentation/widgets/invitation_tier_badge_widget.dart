import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_tier.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';

class InvitationTierBadgeWidget extends StatelessWidget {
  const InvitationTierBadgeWidget({
    super.key,
    required this.tier,
  });

  final InvitationTier tier;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final isVip = tier == InvitationTier.vip;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: InvitationsDesignSpec.px(context, 8),
        vertical: InvitationsDesignSpec.px(context, 4),
      ),
      decoration: BoxDecoration(
        color: isVip
            ? InvitationsDesignSpec.vipBadgeBackground
            : InvitationsDesignSpec.generalBadgeBackground,
        borderRadius: BorderRadius.circular(
          InvitationsDesignSpec.px(context, 6),
        ),
      ),
      child: Text(
        isVip
            ? AppStrings.invitationsTierVip(strings)
            : AppStrings.invitationsTierGeneral(strings),
        style: TextStyle(
          fontSize: InvitationsDesignSpec.px(context, 10),
          fontWeight: FontWeight.w700,
          color: Colors.white,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}
