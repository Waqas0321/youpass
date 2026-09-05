import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/l10n/invitations_error_extension.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/shimmer/invitations_list_shimmer.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_list_tab.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';
import 'package:youpass/features/invitations/presentation/providers/invitations_provider.dart';
import 'package:youpass/features/invitations/presentation/providers/invitations_status.dart';
import 'package:youpass/features/home/presentation/utils/app_drawer_navigation.dart';
import 'package:youpass/features/invitations/presentation/screens/my_invitations_screen.dart';
import 'package:youpass/features/invitations/presentation/utils/invitations_filter_helper.dart';
import 'package:youpass/features/invitations/presentation/utils/invitations_screen_actions.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitations_list_content_widget.dart';
import 'package:youpass/features/waitlist/domain/entities/waitlist_entry_entity.dart';
import 'package:youpass/features/waitlist/presentation/utils/waitlist_flow_actions.dart';
import 'package:youpass/l10n/app_localizations.dart';

class MyInvitationsScreenState extends State<MyInvitationsScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  InvitationListTab selectedTab = InvitationListTab.pending;
  String? selectedEventTypeSlug;
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

  void updateFilter(String? eventTypeSlug) {
    setState(() => selectedEventTypeSlug = eventTypeSlug);
  }

  void updateTab(InvitationListTab tab) {
    setState(() => selectedTab = tab);
  }

  List<WaitlistEntryEntity> _visibleWaitlistEntries(
    List<WaitlistEntryEntity> entries,
  ) {
    if (selectedTab != InvitationListTab.pending) {
      return const [];
    }
    if (selectedEventTypeSlug != null) {
      return const [];
    }

    final query = searchQuery.trim().toLowerCase();
    if (query.isEmpty) {
      return entries;
    }

    return entries
        .where(
          (entry) =>
              entry.eventTitle.toLowerCase().contains(query) ||
              entry.locationLabel.toLowerCase().contains(query),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final provider = context.watch<InvitationsProvider>();
    final actions = InvitationsScreenActions(context);
    final visibleInvitations = InvitationsFilterHelper.filterInvitations(
      invitations: provider.invitations,
      selectedTab: selectedTab,
      selectedEventTypeSlug: selectedEventTypeSlug,
      searchQuery: searchQuery,
    );
    final visibleWaitlist = _visibleWaitlistEntries(provider.waitlistEntries);

    return AppDrawerNavigation.wrap(
      scaffoldKey: scaffoldKey,
      context: context,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () =>
              AppDrawerNavigation.openDrawer(context, scaffoldKey),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: InvitationsDesignSpec.primary,
            size: InvitationsDesignSpec.px(context, 20),
          ),
        ),
        title: Text(
          AppStrings.drawerInvitations(strings),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: InvitationsDesignSpec.primary,
            letterSpacing: 0.4,
          ),
        ),
      ),
      body: buildBody(
        strings,
        provider,
        actions,
        visibleInvitations,
        visibleWaitlist,
      ),
    );
  }

  Widget buildBody(
    AppLocalizations strings,
    InvitationsProvider provider,
    InvitationsScreenActions actions,
    List<InvitationEntity> visibleInvitations,
    List<WaitlistEntryEntity> visibleWaitlist,
  ) {
    final waitlistActions = WaitlistFlowActions(context);

    if (provider.status == InvitationsStatus.loading &&
        provider.invitations.isEmpty &&
        provider.waitlistEntries.isEmpty) {
      return const InvitationsListShimmer();
    }

    if (provider.status == InvitationsStatus.error &&
        provider.invitations.isEmpty &&
        provider.waitlistEntries.isEmpty) {
      return Center(
        child: AppText(
          provider.localizedErrorMessage(strings) ??
              AppStrings.errorGeneric(strings),
        ),
      );
    }

    return InvitationsListContentWidget(
      selectedTab: selectedTab,
      onTabSelected: updateTab,
      invitations: visibleInvitations,
      waitlistEntries: visibleWaitlist,
      totalInvitations: provider.invitations
          .where((item) => !InvitationsFilterHelper.isHiddenFromLists(item))
          .length,
      searchQuery: searchQuery,
      eventTypes: provider.eventTypeFilters,
      selectedEventTypeSlug: selectedEventTypeSlug,
      onFilterSelected: updateFilter,
      onSearchChanged: updateSearch,
      onConfirmAttendance: actions.confirmAttendance,
      onRejectInvitation: actions.rejectInvitation,
      onCancelInvitation: actions.cancelInvitation,
      onViewTicket: actions.openTicket,
      onOpenDetail: actions.openInvitationDetail,
      onLeaveWaitlist: waitlistActions.leaveWaitlist,
      onClaimWaitlistSlot: waitlistActions.claimSlot,
      isActionLoading: provider.isActionLoading,
      isAnyActionLoading: (id) => provider.isAnyActionLoading(id),
    );
  }
}
