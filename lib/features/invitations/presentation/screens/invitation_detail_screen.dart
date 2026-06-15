import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_product_kind.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';
import 'package:youpass/features/invitations/presentation/routes/invitation_detail_route_args.dart';
import 'package:youpass/features/invitations/presentation/utils/invitations_product_kind_resolver.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitation_detail_actions_widget.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitation_detail_guaranteed_pass_panel_widget.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitation_detail_header_widget.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitation_detail_scaffold_widget.dart';

/// Single detail screen for all invitation product kinds.
/// Product-specific sections are composed here — add new kinds in [_buildBody].
class InvitationDetailScreen extends StatelessWidget {
  const InvitationDetailScreen({super.key, required this.args});

  final InvitationDetailRouteArgs args;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return InvitationDetailScaffoldWidget(
      args: args,
      title: _titleFor(strings, args.initialInvitation),
      builder: _buildBody,
    );
  }

  String _titleFor(dynamic strings, InvitationEntity? seed) {
    if (seed == null) {
      return AppStrings.invitationsDetailTitle(strings);
    }

    return switch (InvitationsProductKindResolver.resolve(seed)) {
      InvitationProductKind.guaranteedPass =>
        AppStrings.invitationsGuaranteedPassDetailTitle(strings),
      InvitationProductKind.discounted ||
      InvitationProductKind.free =>
        AppStrings.invitationsDetailTitle(strings),
    };
  }

  Widget _buildBody(BuildContext context, InvitationEntity invitation) {
    final kind = InvitationsProductKindResolver.resolve(invitation);

    return SingleChildScrollView(
      padding: EdgeInsets.all(InvitationsDesignSpec.px(context, 20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InvitationDetailHeaderWidget(
            invitation: invitation,
            showTier: kind != InvitationProductKind.guaranteedPass,
            showAssignedSlot: kind == InvitationProductKind.guaranteedPass,
            showPassStatus: kind == InvitationProductKind.guaranteedPass,
            leading: kind == InvitationProductKind.guaranteedPass
                ? _guaranteedBadge(context)
                : null,
          ),
          switch (kind) {
            InvitationProductKind.guaranteedPass =>
              InvitationDetailGuaranteedPassPanelWidget(invitation: invitation),
            InvitationProductKind.free ||
            InvitationProductKind.discounted =>
              InvitationDetailActionsWidget(invitation: invitation),
          },
        ],
      ),
    );
  }

  Widget _guaranteedBadge(BuildContext context) {
    final strings = context.l10n;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: InvitationsDesignSpec.px(context, 12),
        vertical: InvitationsDesignSpec.px(context, 6),
      ),
      decoration: BoxDecoration(
        color: InvitationsDesignSpec.guaranteedTypeGold.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: InvitationsDesignSpec.guaranteedTypeGold),
      ),
      child: Text(
        AppStrings.invitationsGuaranteedBadge(strings),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: InvitationsDesignSpec.guaranteedTypeGold,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.2,
          fontSize: InvitationsDesignSpec.px(context, 13),
        ),
      ),
    );
  }
}
