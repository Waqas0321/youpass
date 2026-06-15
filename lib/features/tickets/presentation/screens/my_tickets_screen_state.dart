import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/l10n/tickets_error_extension.dart';
import 'package:youpass/core/services/screen_secure_service.dart';
import 'package:youpass/core/theme/tickets_screen_theme.dart';
import 'package:youpass/core/widgets/shimmer/tickets_tab_shimmer.dart';
import 'package:youpass/dependency_injection/injection_container.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
import 'package:youpass/features/invitations/presentation/providers/invitations_provider.dart';
import 'package:youpass/features/invitations/presentation/utils/guaranteed_pass_flow_actions.dart';
import 'package:youpass/features/invitations/presentation/utils/invitations_screen_actions.dart';
import 'package:youpass/features/tickets/presentation/providers/tickets_load_status.dart';
import 'package:youpass/features/tickets/presentation/providers/tickets_provider.dart';
import 'package:youpass/features/home/presentation/utils/app_drawer_navigation.dart';
import 'package:youpass/features/tickets/presentation/screens/my_tickets_screen.dart';
import 'package:youpass/features/tickets/presentation/tickets_design_spec.dart';
import 'package:youpass/features/tickets/presentation/utils/tickets_screen_actions.dart';
import 'package:youpass/features/tickets/presentation/utils/tickets_yearly_summary_formatter.dart';
import 'package:youpass/features/tickets/presentation/widgets/my_tickets_empty_state_widget.dart';
import 'package:youpass/features/tickets/presentation/widgets/my_tickets_error_state_widget.dart';
import 'package:youpass/features/tickets/presentation/widgets/past_events_attended_header_widget.dart';
import 'package:youpass/features/tickets/presentation/widgets/past_events_tab_widget.dart';
import 'package:youpass/features/tickets/presentation/widgets/upcoming_tickets_tab_widget.dart';

class MyTicketsScreenState extends State<MyTicketsScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController tabController;
  ScreenSecureService? _screenSecureService;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(handleTabChange);
    _screenSecureService =
        widget.screenSecureService ?? _tryResolveScreenSecureService();
    _screenSecureService?.enable();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      context.read<TicketsProvider>().ensureUpcomingLoaded();
    });
  }

  void handleTabChange() {
    if (!tabController.indexIsChanging && tabController.index == 1) {
      context.read<TicketsProvider>().ensurePastLoaded();
    }
  }

  @override
  void dispose() {
    tabController.removeListener(handleTabChange);
    tabController.dispose();
    _screenSecureService?.disable();
    super.dispose();
  }

  ScreenSecureService? _tryResolveScreenSecureService() {
    try {
      return sl<ScreenSecureService>();
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final provider = context.watch<TicketsProvider>();
    final actions = TicketsScreenActions(context);

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
          onPressed: () => AppDrawerNavigation.openDrawer(context, scaffoldKey),
          icon: Icon(
            Icons.menu,
            color: TicketsScreenTheme.accent(context),
            size: TicketsDesignSpec.px(
              context,
              TicketsDesignSpec.backIconSize,
            ),
          ),
        ),
        title: Text(
          AppStrings.drawerMyTickets(strings),
          style: TextStyle(
            fontSize: TicketsDesignSpec.px(
              context,
              TicketsDesignSpec.appBarTitleSize,
            ),
            fontWeight: FontWeight.w700,
            color: TicketsScreenTheme.accent(context),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(
            TicketsDesignSpec.px(context, 44),
          ),
          child: TabBar(
            controller: tabController,
            indicatorColor: TicketsScreenTheme.accent(context),
            indicatorWeight: 2.5,
            labelColor: TicketsScreenTheme.accent(context),
            unselectedLabelColor: Theme.of(context).colorScheme.onSurfaceVariant,
            labelStyle: TextStyle(
              fontSize: TicketsDesignSpec.px(context, TicketsDesignSpec.tabFontSize),
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: TicketsDesignSpec.px(context, TicketsDesignSpec.tabFontSize),
              fontWeight: FontWeight.w600,
              letterSpacing: 0.4,
            ),
            tabs: [
              Tab(text: AppStrings.ticketsTabUpcoming(strings)),
              Tab(text: AppStrings.ticketsTabPast(strings)),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          buildUpcomingTab(context, provider, actions),
          buildPastTab(context, provider),
        ],
      ),
    );
  }

  Widget buildUpcomingTab(
    BuildContext context,
    TicketsProvider provider,
    TicketsScreenActions actions,
  ) {
    final strings = context.l10n;
    final invitationsProvider = context.watch<InvitationsProvider>();
    final hasContent = provider.pendingInvitations.isNotEmpty ||
        provider.upcomingTickets.isNotEmpty;

    if (provider.upcomingStatus == TicketsLoadStatus.loading &&
        !hasContent) {
      return const UpcomingTicketsTabShimmer(cardCount: 2);
    }

    if (provider.upcomingStatus == TicketsLoadStatus.error &&
        !hasContent) {
      return MyTicketsErrorStateWidget(
        message: provider.localizedUpcomingErrorMessage(strings) ??
            AppStrings.errorGeneric(strings),
        onRetry: () => provider.loadUpcoming(force: true),
      );
    }

    if (!hasContent) {
      return RefreshIndicator(
        onRefresh: provider.refreshUpcoming,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.45,
              child: MyTicketsEmptyStateWidget(
                message: AppStrings.ticketsEmptyUpcoming(strings),
              ),
            ),
          ],
        ),
      );
    }

    return UpcomingTicketsTabWidget(
      tickets: provider.upcomingTickets,
      pendingInvitations: provider.pendingInvitations,
      onRefresh: provider.refreshUpcoming,
      onViewQr: actions.openTicketQr,
      onAssignTickets: actions.openAssignTickets,
      onCancelTicket: (ticket) => _handleCancelTicket(provider, ticket.id, strings),
      onAcceptInvitation: (invitationId) =>
          _handleAcceptPendingInvitation(provider, invitationId),
      onDeclineInvitation: (invitationId) =>
          _handleDeclinePendingInvitation(provider, invitationId),
      isViewQrLoading: provider.isViewQrLoading,
      isInvitationSubmitting: (invitationId) =>
          provider.isInvitationSubmitting(invitationId) ||
          invitationsProvider.submittingInvitationId == invitationId,
      isTicketCancelling: provider.isTicketCancelling,
      isLoadingMore: provider.isLoadingMoreUpcoming,
      hasMore: provider.hasMoreUpcoming,
      onLoadMore: provider.loadMoreUpcoming,
    );
  }

  Future<void> _handleCancelTicket(
    TicketsProvider provider,
    String ticketId,
    dynamic strings,
  ) async {
    final invitationsProvider = context.read<InvitationsProvider>();
    await invitationsProvider.ensureLoaded();
    InvitationEntity? invitation;
    for (final item in invitationsProvider.invitations) {
      if (item.id == ticketId) {
        invitation = item;
        break;
      }
    }

    if (invitation?.isGuaranteedPass == true && invitation!.canCancel) {
      await GuaranteedPassFlowActions(context).cancelConfirmedPass(invitation);
      if (!mounted) {
        return;
      }
      await provider.refreshUpcoming();
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppStrings.ticketsCancelTicketTitle(strings)),
        content: Text(AppStrings.ticketsCancelTicketMessage(strings)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(AppStrings.confirmDialogCancel(strings)),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(AppStrings.ticketsCancelTicketConfirm(strings)),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) {
      return;
    }

    final cancelled = await provider.cancelTicket(ticketId);
    if (!mounted) {
      return;
    }
    if (!cancelled) {
      final error = provider.localizedUpcomingErrorMessage(strings);
      if (error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error)),
        );
      }
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppStrings.ticketsCancelTicketSuccess(strings))),
    );
  }

  Future<bool> _handleAcceptPendingInvitation(
    TicketsProvider provider,
    String invitationId,
  ) async {
    InvitationEntity? invitation;
    for (final item in provider.pendingInvitations) {
      if (item.id == invitationId) {
        invitation = item;
        break;
      }
    }
    if (invitation == null) {
      return false;
    }

    await InvitationsScreenActions(context).confirmAttendance(invitation);
    if (!mounted) {
      return false;
    }

    await provider.refreshUpcoming();
    return !provider.pendingInvitations.any((item) => item.id == invitationId);
  }

  Future<bool> _handleDeclinePendingInvitation(
    TicketsProvider provider,
    String invitationId,
  ) async {
    await InvitationsScreenActions(context).rejectInvitation(invitationId);
    if (!mounted) {
      return false;
    }

    await provider.refreshUpcoming();
    return !provider.pendingInvitations.any((item) => item.id == invitationId);
  }

  Widget buildPastTab(BuildContext context, TicketsProvider provider) {
    final strings = context.l10n;
    final subtitle = TicketsYearlySummaryFormatter.buildSubtitle(
      strings,
      provider.yearlySummary,
    );

    if (provider.pastStatus == TicketsLoadStatus.loading &&
        provider.pastEvents.isEmpty) {
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.all(
              TicketsDesignSpec.px(context, TicketsDesignSpec.horizontalPadding),
            ),
            child: PastEventsAttendedHeaderWidget(subtitle: subtitle),
          ),
          const Expanded(
            child: PastEventsListShimmer(cardCount: 2),
          ),
        ],
      );
    }

    if (provider.pastStatus == TicketsLoadStatus.error &&
        provider.pastEvents.isEmpty) {
      return MyTicketsErrorStateWidget(
        message: provider.localizedPastErrorMessage(strings) ??
            AppStrings.errorGeneric(strings),
        onRetry: () => provider.loadPast(force: true),
      );
    }

    return PastEventsTabWidget(
      events: provider.pastEvents,
      headerSubtitle: subtitle,
      selectedFilter: provider.pastQuery.filter,
      onSearchChanged: provider.applyPastSearch,
      onFilterSelected: provider.applyPastFilter,
      onFavoriteToggle: provider.togglePastEventFavorite,
      onRefresh: provider.refreshPast,
      hasMore: provider.hasMorePast,
      isLoadingMore: provider.isLoadingMorePast,
      onLoadMore: provider.loadMorePast,
    );
  }
}
