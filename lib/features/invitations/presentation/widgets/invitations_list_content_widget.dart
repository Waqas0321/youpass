import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_filter.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_status.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitation_card_widget.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitations_filter_chips_widget.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitations_footer_note_widget.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitations_search_field_widget.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitations_section_header_widget.dart';

class InvitationsListContentWidget extends StatelessWidget {
  const InvitationsListContentWidget({
    super.key,
    required this.invitations,
    required this.selectedFilter,
    required this.onFilterSelected,
    required this.onSearchChanged,
    required this.onConfirmAttendance,
    required this.onRejectInvitation,
    required this.onCancelInvitation,
    required this.onViewTicket,
    this.isConfirmLoading,
    this.isRejectLoading,
    this.isViewQrLoading,
  });

  final List<InvitationEntity> invitations;
  final InvitationFilter selectedFilter;
  final ValueChanged<InvitationFilter> onFilterSelected;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<InvitationEntity> onConfirmAttendance;
  final ValueChanged<String> onRejectInvitation;
  final ValueChanged<String> onCancelInvitation;
  final ValueChanged<InvitationEntity> onViewTicket;
  final bool Function(String invitationId)? isConfirmLoading;
  final bool Function(String invitationId)? isRejectLoading;
  final bool Function(String invitationId)? isViewQrLoading;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final horizontalPadding =
        InvitationsDesignSpec.px(context, InvitationsDesignSpec.horizontalPadding);

    return ListView(
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        InvitationsDesignSpec.px(context, 8),
        horizontalPadding,
        InvitationsDesignSpec.px(context, 24),
      ),
      children: [
        InvitationsSectionHeaderWidget(
          title: AppStrings.invitationsScreenTitle(strings),
          subtitle: AppStrings.invitationsSubtitle(strings),
        ),
        SizedBox(height: InvitationsDesignSpec.px(context, 16)),
        InvitationsSearchFieldWidget(
          hintText: AppStrings.invitationsSearchHint(strings),
          onChanged: onSearchChanged,
        ),
        SizedBox(height: InvitationsDesignSpec.px(context, 14)),
        InvitationsFilterChipsWidget(
          selectedFilter: selectedFilter,
          onFilterSelected: onFilterSelected,
        ),
        SizedBox(height: InvitationsDesignSpec.px(context, 16)),
        ...invitations.map(
          (invitation) => InvitationCardWidget(
            invitation: invitation,
            onConfirm: invitation.status == InvitationStatus.pending
                ? () => onConfirmAttendance(invitation)
                : null,
            onReject: invitation.status == InvitationStatus.pending
                ? () => onRejectInvitation(invitation.id)
                : null,
            onCancel: invitation.status == InvitationStatus.confirmed
                ? () => onCancelInvitation(invitation.id)
                : null,
            onViewQr: () => onViewTicket(invitation),
            isConfirmLoading:
                isConfirmLoading?.call(invitation.id) ?? false,
            isRejectLoading: isRejectLoading?.call(invitation.id) ?? false,
            isViewQrLoading: isViewQrLoading?.call(invitation.id) ?? false,
          ),
        ),
        SizedBox(height: InvitationsDesignSpec.px(context, 8)),
        const InvitationsFooterNoteWidget(),
      ],
    );
  }
}
