import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/events/domain/entities/event_type_entity.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_list_tab.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_status_extensions.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';
import 'package:youpass/features/invitations/presentation/providers/invitation_submit_action.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitation_card_widget.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitations_empty_state_widget.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitations_filter_chips_widget.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitations_footer_note_widget.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitations_search_field_widget.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitations_section_header_widget.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitations_tab_bar_widget.dart';
import 'package:youpass/features/waitlist/domain/entities/waitlist_entry_entity.dart';
import 'package:youpass/features/waitlist/presentation/widgets/waitlist_card_widget.dart';

class InvitationsListContentWidget extends StatelessWidget {
  const InvitationsListContentWidget({
    super.key,
    required this.selectedTab,
    required this.onTabSelected,
    required this.invitations,
    required this.waitlistEntries,
    required this.totalInvitations,
    required this.searchQuery,
    required this.eventTypes,
    required this.selectedEventTypeSlug,
    required this.onFilterSelected,
    required this.onSearchChanged,
    required this.onConfirmAttendance,
    required this.onRejectInvitation,
    required this.onCancelInvitation,
    required this.onViewTicket,
    required this.onOpenDetail,
    required this.onLeaveWaitlist,
    required this.onClaimWaitlistSlot,
    required this.isActionLoading,
    required this.isAnyActionLoading,
  });

  final InvitationListTab selectedTab;
  final ValueChanged<InvitationListTab> onTabSelected;
  final List<InvitationEntity> invitations;
  final List<WaitlistEntryEntity> waitlistEntries;
  final int totalInvitations;
  final String searchQuery;
  final List<EventTypeEntity> eventTypes;
  final String? selectedEventTypeSlug;
  final ValueChanged<String?> onFilterSelected;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<InvitationEntity> onConfirmAttendance;
  final ValueChanged<String> onRejectInvitation;
  final ValueChanged<InvitationEntity> onCancelInvitation;
  final ValueChanged<InvitationEntity> onViewTicket;
  final ValueChanged<InvitationEntity> onOpenDetail;
  final ValueChanged<WaitlistEntryEntity> onLeaveWaitlist;
  final ValueChanged<WaitlistEntryEntity> onClaimWaitlistSlot;
  final bool Function(String invitationId, InvitationSubmitAction action)
      isActionLoading;
  final bool Function(String invitationId) isAnyActionLoading;

  String _emptyMessage(BuildContext context) {
    final strings = context.l10n;
    if (searchQuery.trim().isNotEmpty) {
      return AppStrings.invitationsEmptySearch(strings);
    }
    if (totalInvitations == 0) {
      return AppStrings.invitationsEmptyNone(strings);
    }
    return selectedTab == InvitationListTab.pending
        ? AppStrings.invitationsEmptyPending(strings)
        : AppStrings.invitationsEmptyConfirmed(strings);
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final horizontalPadding =
        InvitationsDesignSpec.px(context, InvitationsDesignSpec.horizontalPadding);
    final bottomPadding = InvitationsDesignSpec.px(context, 24);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
            horizontalPadding,
            InvitationsDesignSpec.px(context, 8),
            horizontalPadding,
            0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InvitationsSectionHeaderWidget(
                title: AppStrings.invitationsScreenTitle(strings),
                subtitle: AppStrings.invitationsSubtitle(strings),
              ),
              SizedBox(height: InvitationsDesignSpec.px(context, 16)),
              InvitationsTabBarWidget(
                selectedTab: selectedTab,
                onTabSelected: onTabSelected,
              ),
              SizedBox(height: InvitationsDesignSpec.px(context, 16)),
              InvitationsSearchFieldWidget(
                hintText: AppStrings.invitationsSearchHint(strings),
                onChanged: onSearchChanged,
              ),
              SizedBox(height: InvitationsDesignSpec.px(context, 14)),
              InvitationsFilterChipsWidget(
                eventTypes: eventTypes,
                selectedEventTypeSlug: selectedEventTypeSlug,
                onFilterSelected: onFilterSelected,
              ),
              SizedBox(height: InvitationsDesignSpec.px(context, 16)),
            ],
          ),
        ),
        Expanded(
          child: invitations.isEmpty && waitlistEntries.isEmpty
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Center(
                          child: InvitationsEmptyStateWidget(
                            message: _emptyMessage(context),
                          ),
                        ),
                      ),
                      const InvitationsFooterNoteWidget(),
                      SizedBox(height: bottomPadding),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding,
                    0,
                    horizontalPadding,
                    InvitationsDesignSpec.px(context, 8),
                  ),
                  itemCount: waitlistEntries.length + invitations.length,
                  itemBuilder: (context, index) {
                    if (index < waitlistEntries.length) {
                      final entry = waitlistEntries[index];
                      return WaitlistCardWidget(
                        entry: entry,
                        onLeave: () => onLeaveWaitlist(entry),
                        onClaim: () => onClaimWaitlistSlot(entry),
                      );
                    }

                    final invitation = invitations[index - waitlistEntries.length];
                    final waiting = isAnyActionLoading(invitation.id);
                    return InvitationCardWidget(
                      invitation: invitation,
                      isWaitingForConfirmation: waiting,
                      onOpenDetail:
                          waiting ? null : () => onOpenDetail(invitation),
                      onConfirm: invitation.status.isPending && !waiting
                          ? () => onConfirmAttendance(invitation)
                          : null,
                      onReject: invitation.status.isPending && !waiting
                          ? () => onRejectInvitation(invitation.id)
                          : null,
                      onCancel: invitation.status.isAccepted && !waiting
                          ? () => onCancelInvitation(invitation)
                          : null,
                      onViewQr: waiting ? null : () => onViewTicket(invitation),
                      isConfirmLoading: isActionLoading(
                        invitation.id,
                        InvitationSubmitAction.confirm,
                      ),
                      isRejectLoading: isActionLoading(
                        invitation.id,
                        InvitationSubmitAction.reject,
                      ),
                      isCancelLoading: isActionLoading(
                        invitation.id,
                        InvitationSubmitAction.cancel,
                      ),
                      isViewQrLoading: invitation.canFetchQrFromApi &&
                          isActionLoading(
                            invitation.id,
                            InvitationSubmitAction.viewQr,
                          ),
                    );
                  },
                ),
        ),
        if (invitations.isNotEmpty || waitlistEntries.isNotEmpty)
          Padding(
            padding: EdgeInsets.fromLTRB(
              horizontalPadding,
              InvitationsDesignSpec.px(context, 8),
              horizontalPadding,
              bottomPadding,
            ),
            child: const InvitationsFooterNoteWidget(),
          ),
      ],
    );
  }
}
