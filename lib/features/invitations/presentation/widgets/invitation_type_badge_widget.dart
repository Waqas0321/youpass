import 'package:flutter/material.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';
import 'package:youpass/features/invitations/presentation/utils/invitations_product_kind_resolver.dart';
import 'package:youpass/features/invitations/presentation/utils/invitations_product_kind_style.dart';
import 'package:youpass/features/invitations/presentation/utils/invitations_text_factory.dart';

class InvitationTypeBadgeWidget extends StatelessWidget {
  const InvitationTypeBadgeWidget({
    super.key,
    required this.invitation,
  });

  final InvitationEntity invitation;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final kind = InvitationsProductKindResolver.resolve(invitation);
    final color = InvitationsProductKindStyle.parseHexColor(invitation.typeColorHex) ??
        InvitationsProductKindStyle.colorFor(kind);
    final label = InvitationsTextFactory.productLabelForInvitation(strings, invitation);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: InvitationsDesignSpec.px(context, 8),
        vertical: InvitationsDesignSpec.px(context, 4),
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(InvitationsDesignSpec.px(context, 6)),
        border: Border.all(color: color, width: 1.2),
      ),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontSize: InvitationsDesignSpec.px(context, 10),
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
          color: color,
        ),
      ),
    );
  }
}
