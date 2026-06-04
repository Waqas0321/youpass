import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/l10n/invitations_error_extension.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/shimmer/invitations_list_shimmer.dart';
import 'package:youpass/core/widgets/youpass_branded_app_bar_widget.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_filter.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';
import 'package:youpass/features/invitations/presentation/providers/invitation_submit_action.dart';
import 'package:youpass/features/invitations/presentation/providers/invitations_provider.dart';
import 'package:youpass/features/invitations/presentation/providers/invitations_status.dart';
import 'package:youpass/features/invitations/presentation/screens/my_invitations_screen.dart';
import 'package:youpass/features/invitations/presentation/utils/invitations_filter_helper.dart';
import 'package:youpass/features/invitations/presentation/utils/invitations_screen_actions.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitations_list_content_widget.dart';
import 'package:youpass/l10n/app_localizations.dart';

class MyInvitationsScreenState extends State<MyInvitationsScreen> {
  InvitationFilter selectedFilter = InvitationFilter.all;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      context.read<InvitationsProvider>().ensureLoaded();
    });
  }

  void updateSearch(String value) {
    setState(() => searchQuery = value);
  }

  void updateFilter(InvitationFilter filter) {
    setState(() => selectedFilter = filter);
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final provider = context.watch<InvitationsProvider>();
    final actions = InvitationsScreenActions(context);
    final visibleInvitations = InvitationsFilterHelper.filterInvitations(
      invitations: provider.invitations,
      selectedFilter: selectedFilter,
      searchQuery: searchQuery,
    );

    return Scaffold(
      appBar: YouPassBrandedAppBarWidget(
        onBack: () => Navigator.of(context).pop(),
        primaryColor: InvitationsDesignSpec.primary,
      ),
      body: buildBody(strings, provider, actions, visibleInvitations),
    );
  }

  Widget buildBody(
    AppLocalizations strings,
    InvitationsProvider provider,
    InvitationsScreenActions actions,
    List<InvitationEntity> visibleInvitations,
  ) {
    if (provider.status == InvitationsStatus.loading &&
        provider.invitations.isEmpty) {
      return const InvitationsListShimmer();
    }

    if (provider.status == InvitationsStatus.error &&
        provider.invitations.isEmpty) {
      return Center(
        child: AppText(
          provider.localizedErrorMessage(strings) ??
              AppStrings.errorGeneric(strings),
        ),
      );
    }

    return InvitationsListContentWidget(
      invitations: visibleInvitations,
      selectedFilter: selectedFilter,
      onFilterSelected: updateFilter,
      onSearchChanged: updateSearch,
      onConfirmAttendance: actions.confirmAttendance,
      onRejectInvitation: actions.rejectInvitation,
      onCancelInvitation: actions.rejectInvitation,
      onViewTicket: actions.openTicket,
      isConfirmLoading: (id) =>
          provider.isActionLoading(id, InvitationSubmitAction.confirm),
      isRejectLoading: (id) =>
          provider.isActionLoading(id, InvitationSubmitAction.reject),
      isViewQrLoading: (id) =>
          provider.isActionLoading(id, InvitationSubmitAction.viewQr),
    );
  }
}
