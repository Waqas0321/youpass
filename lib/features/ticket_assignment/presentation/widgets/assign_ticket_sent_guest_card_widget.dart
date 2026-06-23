import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/theme/tickets_screen_theme.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/ticket_assignment_slot_entity.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/ticket_slot_status.dart';
import 'package:youpass/features/ticket_assignment/presentation/ticket_assignment_design_spec.dart';
import 'package:youpass/features/ticket_assignment/presentation/utils/ticket_assignment_label_formatter.dart';
import 'package:youpass/features/ticket_assignment/presentation/widgets/assign_ticket_action_button_widget.dart';
import 'package:youpass/features/ticket_assignment/presentation/widgets/assign_ticket_guest_field_widget.dart';
import 'package:youpass/features/ticket_assignment/presentation/widgets/assign_ticket_guest_phone_field_widget.dart';
import 'package:youpass/features/ticket_assignment/presentation/widgets/assign_ticket_pending_badge_widget.dart';
import 'package:youpass/features/tickets/presentation/tickets_design_spec.dart';
import 'package:youpass/l10n/app_localizations.dart';

class AssignTicketSentGuestCardWidget extends StatefulWidget {
  const AssignTicketSentGuestCardWidget({
    super.key,
    required this.slot,
    this.slotDisplayNumber,
    this.isVip = false,
    this.onCancel,
    this.onResend,
    this.isCancelLoading = false,
    this.isResendLoading = false,
  });

  final TicketAssignmentSlotEntity slot;
  final int? slotDisplayNumber;
  final bool isVip;
  final Future<bool> Function()? onCancel;
  final Future<bool> Function()? onResend;
  final bool isCancelLoading;
  final bool isResendLoading;

  @override
  State<AssignTicketSentGuestCardWidget> createState() =>
      _AssignTicketSentGuestCardWidgetState();
}

class _AssignTicketSentGuestCardWidgetState
    extends State<AssignTicketSentGuestCardWidget> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final phoneInputKey = GlobalKey<AssignTicketGuestPhoneFieldWidgetState>();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.slot.guestName?.trim() ?? '';
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      syncPhoneField(widget.slot);
    });
  }

  @override
  void didUpdateWidget(covariant AssignTicketSentGuestCardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.slot.id != widget.slot.id ||
        oldWidget.slot.guestName != widget.slot.guestName ||
        oldWidget.slot.guestPhone != widget.slot.guestPhone) {
      nameController.text = widget.slot.guestName?.trim() ?? '';
      syncPhoneField(widget.slot);
    }
  }

  void syncPhoneField(TicketAssignmentSlotEntity slot) {
    final guestPhone = slot.guestPhone?.trim() ?? '';
    if (guestPhone.isEmpty) {
      phoneController.clear();
      return;
    }

    phoneInputKey.currentState?.applyPhone(guestPhone);
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Color accentColor(BuildContext context) =>
      TicketsScreenTheme.assignFlowAccent(context, isVip: widget.isVip);

  String statusLabel(BuildContext context) {
    final strings = context.l10n;
    if (widget.slot.status == TicketSlotStatus.claimed) {
      return AppStrings.ticketAssignmentAcceptedBadge(strings);
    }
    return AppStrings.ticketAssignmentPendingBadge(strings);
  }

  Color statusColor(BuildContext context) {
    if (widget.slot.status == TicketSlotStatus.claimed) {
      return const Color(0xFF2E7D32);
    }
    return accentColor(context);
  }

  bool get isPending => widget.slot.status == TicketSlotStatus.pending;

  bool get showsPendingActions =>
      isPending && (widget.slot.canCancel || widget.slot.canResend);

  bool get showsClaimedCancel =>
      widget.slot.status == TicketSlotStatus.claimed && widget.slot.canCancel;

  Future<void> submitCancel() async {
    final onCancel = widget.onCancel;
    if (onCancel == null) {
      return;
    }
    await onCancel();
  }

  Future<void> submitResend() async {
    final onResend = widget.onResend;
    if (onResend == null) {
      return;
    }
    await onResend();
  }

  Widget buildCancelButton(BuildContext context, AppLocalizations strings) {
    return AssignTicketActionButtonWidget(
      label: AppStrings.ticketAssignmentCancelTicket(strings),
      foregroundColor: TicketAssignmentDesignSpec.cancelButtonForeground,
      backgroundColor: TicketAssignmentDesignSpec.cancelButtonFill,
      borderColor: TicketAssignmentDesignSpec.cancelButtonBorder,
      onPressed: submitCancel,
      isLoading: widget.isCancelLoading,
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final radius = TicketAssignmentDesignSpec.cardRadius(context);
    final slot = widget.slot;
    final accent = accentColor(context);
    final avatarSize = TicketAssignmentDesignSpec.avatarSize(context);

    return Container(
      margin: EdgeInsets.only(bottom: TicketsDesignSpec.px(context, 14)),
      padding: EdgeInsets.all(TicketsDesignSpec.px(context, 16)),
      decoration: BoxDecoration(
        color: TicketsScreenTheme.cardBackground(context),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: TicketsScreenTheme.cardBorder(context)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: TicketsDesignSpec.px(context, 8),
            runSpacing: TicketsDesignSpec.px(context, 6),
            children: [
              Text(
                TicketAssignmentLabelFormatter.slotLabel(
                  strings,
                  slot,
                  displayNumber: widget.slotDisplayNumber,
                ),
                style: TextStyle(
                  fontSize: TicketsDesignSpec.px(context, 16),
                  fontWeight: FontWeight.w700,
                  color: TicketsScreenTheme.title(context),
                ),
              ),
              if (isPending)
                AssignTicketPendingBadgeWidget(
                  label: AppStrings.ticketAssignmentPendingBadge(strings),
                  accentColor: accent,
                )
              else if (widget.slot.status == TicketSlotStatus.claimed)
                AssignTicketPendingBadgeWidget(
                  label: statusLabel(context),
                  accentColor: statusColor(context),
                ),
            ],
          ),
          SizedBox(height: TicketsDesignSpec.px(context, 14)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: avatarSize,
                height: avatarSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: accent,
                    width: 1.5,
                  ),
                ),
                child: Icon(
                  Icons.person_outline,
                  color: accent,
                  size: TicketsDesignSpec.px(context, 22),
                ),
              ),
              SizedBox(width: TicketsDesignSpec.px(context, 10)),
              Expanded(
                child: Column(
                  children: [
                    AssignTicketGuestFieldWidget(
                      controller: nameController,
                      hintText:
                          AppStrings.ticketAssignmentGuestNameHint(strings),
                      borderColor: accent,
                      readOnly: true,
                    ),
                    SizedBox(height: TicketsDesignSpec.px(context, 10)),
                    AssignTicketGuestPhoneFieldWidget(
                      key: phoneInputKey,
                      controller: phoneController,
                      initialCountryIsoCode: 'CL',
                      borderColor: accent,
                      readOnly: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: TicketsDesignSpec.px(context, 12)),
          if (showsPendingActions)
            Row(
              children: [
                if (slot.canCancel) ...[
                  Expanded(
                    child: buildCancelButton(context, strings),
                  ),
                  if (slot.canResend)
                    SizedBox(width: TicketsDesignSpec.px(context, 10)),
                ],
                if (slot.canResend)
                  Expanded(
                    child: AssignTicketActionButtonWidget(
                      label: AppStrings.ticketAssignmentResendWhatsApp(strings),
                      foregroundColor: accent,
                      onPressed: submitResend,
                      isLoading: widget.isResendLoading,
                    ),
                  ),
              ],
            )
          else if (showsClaimedCancel)
            buildCancelButton(context, strings)
          else if (widget.slot.status == TicketSlotStatus.claimed)
            AssignTicketActionButtonWidget(
              label: statusLabel(context),
              foregroundColor: statusColor(context),
              backgroundColor: statusColor(context).withValues(alpha: 0.08),
              borderColor: statusColor(context),
              displayOnly: true,
            ),
        ],
      ),
    );
  }
}
