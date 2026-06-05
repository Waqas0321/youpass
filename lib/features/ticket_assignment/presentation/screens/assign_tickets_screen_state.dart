import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/l10n/ticket_assignment_error_extension.dart';
import 'package:youpass/core/theme/tickets_screen_theme.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/core/widgets/shimmer/assign_tickets_screen_shimmer.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/assign_ticket_guest_request_entity.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/ticket_assignment_slot_entity.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/ticket_order_assignments_entity.dart';
import 'package:youpass/features/ticket_assignment/presentation/providers/ticket_assignment_action.dart';
import 'package:youpass/features/ticket_assignment/presentation/providers/ticket_assignment_load_status.dart';
import 'package:youpass/features/ticket_assignment/presentation/providers/ticket_assignment_provider.dart';
import 'package:youpass/features/ticket_assignment/presentation/screens/assign_tickets_screen.dart';
import 'package:youpass/features/ticket_assignment/presentation/utils/ticket_assignment_screen_actions.dart';
import 'package:youpass/features/ticket_assignment/presentation/utils/ticket_assignment_slot_filter.dart';
import 'package:youpass/features/ticket_assignment/presentation/widgets/assign_ticket_privacy_footer_widget.dart';
import 'package:youpass/features/ticket_assignment/presentation/widgets/assign_ticket_slot_card_widget.dart';
import 'package:youpass/features/ticket_assignment/presentation/widgets/assign_ticket_summary_header_widget.dart';
import 'package:youpass/features/ticket_assignment/presentation/widgets/assign_ticket_whatsapp_info_widget.dart';
import 'package:youpass/features/tickets/presentation/tickets_design_spec.dart';
import 'package:youpass/l10n/app_localizations.dart';

class AssignTicketsScreenState extends State<AssignTicketsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      context.read<TicketAssignmentProvider>().loadAssignments(
            orderId: widget.orderId,
            ticketId: widget.ticketId,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final provider = context.watch<TicketAssignmentProvider>();
    final actions = TicketAssignmentScreenActions(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back,
            color: TicketsScreenTheme.accent(context),
          ),
        ),
        title: Text(
          AppStrings.drawerMyTickets(strings),
          style: TextStyle(
            fontSize: TicketsDesignSpec.px(context, 18),
            fontWeight: FontWeight.w700,
            color: TicketsScreenTheme.accent(context),
          ),
        ),
      ),
      body: buildBody(context, provider, actions, strings),
    );
  }

  List<TicketAssignmentSlotEntity> assignableSlots(
    TicketOrderAssignmentsEntity assignments,
  ) {
    return TicketAssignmentSlotFilter.assignableOnly(
      slots: assignments.slots,
    );
  }

  Widget buildBody(
    BuildContext context,
    TicketAssignmentProvider provider,
    TicketAssignmentScreenActions actions,
    AppLocalizations strings,
  ) {
    if (provider.loadStatus == TicketAssignmentLoadStatus.loading) {
      return const AssignTicketsScreenShimmer();
    }

    if (provider.loadStatus == TicketAssignmentLoadStatus.error &&
        provider.assignments == null) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(
            TicketsDesignSpec.px(context, TicketsDesignSpec.horizontalPadding),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText(
                provider.localizedErrorMessage(strings) ??
                    AppStrings.errorGeneric(strings),
                variant: AppTextVariant.body,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: TicketsDesignSpec.px(context, 16)),
              FilledButton(
                onPressed: () => provider.loadAssignments(
                  orderId: widget.orderId,
                  ticketId: widget.ticketId,
                ),
                child: Text(AppStrings.ticketAssignmentRetry(strings)),
              ),
            ],
          ),
        ),
      );
    }

    final assignments = provider.assignments;
    if (assignments == null) {
      return const SizedBox.shrink();
    }

    final visibleSlots = assignableSlots(assignments);
    final orderId = assignments.orderId.trim().isNotEmpty
        ? assignments.orderId.trim()
        : provider.resolvedOrderId;

    if (visibleSlots.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(
            TicketsDesignSpec.px(context, TicketsDesignSpec.horizontalPadding),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText(
                AppStrings.ticketAssignmentNoAssignableTickets(strings),
                variant: AppTextVariant.body,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: TicketsDesignSpec.px(context, 16)),
              FilledButton(
                onPressed: () => provider.loadAssignments(
                  orderId: widget.orderId,
                  ticketId: widget.ticketId,
                ),
                child: Text(AppStrings.ticketAssignmentRetry(strings)),
              ),
            ],
          ),
        ),
      );
    }

    return ListView(
      padding: EdgeInsets.fromLTRB(
        TicketsDesignSpec.px(context, TicketsDesignSpec.horizontalPadding),
        TicketsDesignSpec.px(context, 16),
        TicketsDesignSpec.px(context, TicketsDesignSpec.horizontalPadding),
        TicketsDesignSpec.px(context, 24),
      ),
      children: [
        AssignTicketSummaryHeaderWidget(
          assignments: assignments,
          visibleSlotCount: visibleSlots.length,
        ),
        SizedBox(height: TicketsDesignSpec.px(context, 16)),
        ...visibleSlots.map(
          (slot) => AssignTicketSlotCardWidget(
            slot: slot,
            orderId: orderId ?? '',
            isAssignLoading: provider.isSlotLoading(
              slot.id,
              TicketAssignmentAction.assign,
            ),
            isCancelLoading: provider.isSlotLoading(
              slot.id,
              TicketAssignmentAction.cancel,
            ),
            isResendLoading: provider.isSlotLoading(
              slot.id,
              TicketAssignmentAction.resend,
            ),
            onAssign: (guestName, guestPhone) async {
              if (orderId == null || orderId.isEmpty) {
                return false;
              }

              final success = await provider.assignGuest(
                orderId: orderId,
                slotId: slot.id,
                request: AssignTicketGuestRequestEntity(
                  guestName: guestName,
                  guestPhone: guestPhone,
                ),
              );
              await actions.handleSessionInvalid(provider);
              if (!context.mounted) {
                return false;
              }
              if (!success) {
                final error = provider.localizedErrorMessage(strings);
                if (error != null) {
                  actions.showError(error);
                }
              }
              return success;
            },
            onCancel: () async {
              if (orderId == null || orderId.isEmpty) {
                return false;
              }

              final success = await provider.cancelAssignment(
                orderId: orderId,
                slotId: slot.id,
              );
              await actions.handleSessionInvalid(provider);
              if (!context.mounted) {
                return false;
              }
              if (!success) {
                final error = provider.localizedErrorMessage(strings);
                if (error != null) {
                  actions.showError(error);
                }
              }
              return success;
            },
            onResend: () async {
              if (orderId == null || orderId.isEmpty) {
                return false;
              }

              final success = await provider.resendAssignment(
                orderId: orderId,
                slotId: slot.id,
              );
              await actions.handleSessionInvalid(provider);
              if (!context.mounted) {
                return false;
              }
              if (!success) {
                final error = provider.localizedErrorMessage(strings);
                if (error != null) {
                  actions.showError(error);
                }
              }
              return success;
            },
          ),
        ),
        SizedBox(height: TicketsDesignSpec.px(context, 16)),
        const AssignTicketWhatsAppInfoWidget(),
        SizedBox(height: TicketsDesignSpec.px(context, 16)),
        const AssignTicketPrivacyFooterWidget(),
      ],
    );
  }
}
