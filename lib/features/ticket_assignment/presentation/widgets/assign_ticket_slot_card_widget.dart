import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/theme/tickets_screen_theme.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/ticket_assignment_slot_entity.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/ticket_slot_status.dart';
import 'package:youpass/features/ticket_assignment/presentation/providers/ticket_assignment_provider.dart';
import 'package:youpass/features/ticket_assignment/presentation/ticket_assignment_design_spec.dart';
import 'package:youpass/features/ticket_assignment/presentation/utils/ticket_assignment_label_formatter.dart';
import 'package:youpass/features/ticket_assignment/presentation/widgets/assign_guest_search_sheet.dart';
import 'package:youpass/features/ticket_assignment/presentation/widgets/assign_ticket_action_button_widget.dart';
import 'package:youpass/features/ticket_assignment/presentation/widgets/assign_ticket_guest_field_widget.dart';
import 'package:youpass/features/ticket_assignment/presentation/utils/assign_ticket_whatsapp_actions.dart';
import 'package:youpass/features/ticket_assignment/presentation/widgets/assign_ticket_pending_badge_widget.dart';
import 'package:youpass/features/tickets/presentation/tickets_design_spec.dart';

class AssignTicketSlotCardWidget extends StatefulWidget {
  const AssignTicketSlotCardWidget({
    super.key,
    required this.slot,
    required this.orderId,
    required this.onAssign,
    required this.onCancel,
    required this.onResend,
    this.slotDisplayNumber,
    this.isVip = false,
    this.isAssignLoading = false,
    this.isCancelLoading = false,
    this.isResendLoading = false,
  });

  final TicketAssignmentSlotEntity slot;
  final String orderId;
  final Future<bool> Function(
    String guestName,
    String guestPhone,
    String countryCode,
  ) onAssign;
  final Future<bool> Function() onCancel;
  final Future<bool> Function() onResend;
  final int? slotDisplayNumber;
  final bool isVip;
  final bool isAssignLoading;
  final bool isCancelLoading;
  final bool isResendLoading;

  @override
  State<AssignTicketSlotCardWidget> createState() =>
      AssignTicketSlotCardWidgetState();
}

class AssignTicketSlotCardWidgetState extends State<AssignTicketSlotCardWidget> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  String? guestCountryCode;
  String? _submitPhoneE164;

  @override
  void initState() {
    super.initState();
    syncGuestFields(widget.slot);
    phoneController.addListener(() => _submitPhoneE164 = null);
  }

  @override
  void didUpdateWidget(covariant AssignTicketSlotCardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.slot.id != widget.slot.id ||
        oldWidget.slot.guestName != widget.slot.guestName ||
        oldWidget.slot.guestPhone != widget.slot.guestPhone) {
      syncGuestFields(widget.slot);
    }
  }

  void syncGuestFields(TicketAssignmentSlotEntity slot) {
    nameController.text = slot.guestName ?? '';
    final guestPhone = slot.guestPhone?.trim() ?? '';
    if (guestPhone.isNotEmpty) {
      phoneController.text = guestPhone;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> openGuestSearch() async {
    final selection = await AssignGuestSearchSheet.show(context);
    if (!mounted || selection == null) {
      return;
    }

    nameController.text = selection.displayName;
    phoneController.text =
        selection.phoneDisplay?.trim().isNotEmpty == true
            ? selection.phoneDisplay!.trim()
            : selection.phone;
    guestCountryCode = selection.countryCode.trim().isEmpty
        ? null
        : selection.countryCode.trim().toUpperCase();
    _submitPhoneE164 = selection.isRegistered ? selection.phone : null;
    setState(() {});
  }

  Future<void> submitAssign() async {
    final strings = context.l10n;
    final name = nameController.text.trim();
    final phone = (_submitPhoneE164 ?? phoneController.text).trim();
    if (name.isEmpty || phone.isEmpty) {
      return;
    }

    final countryCode = guestCountryCode ?? '';

    final success = widget.slot.status == TicketSlotStatus.pending &&
            widget.slot.canResend
        ? await widget.onResend()
        : await widget.onAssign(name, phone, countryCode);

    if (!mounted) {
      return;
    }

    if (success) {
      final provider = context.read<TicketAssignmentProvider>();
      final whatsappActions = AssignTicketWhatsAppActions(context);
      await whatsappActions.openGuestInviteUrl(provider.lastWhatsAppUrl);

      if (!mounted) {
        return;
      }

      final message = provider.lastSuccessMessage ??
          AppStrings.ticketAssignmentSentSuccess(strings);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  Future<void> submitCancel() async {
    final success = await widget.onCancel();
    if (!mounted || !success) {
      return;
    }

    nameController.clear();
    phoneController.clear();
    setState(() {});
  }

  bool get showsAssignmentForm => widget.slot.isAssignable;

  Color accentColor(BuildContext context) =>
      TicketsScreenTheme.assignFlowAccent(context, isVip: widget.isVip);

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final radius = TicketAssignmentDesignSpec.cardRadius(context);
    final slot = widget.slot;
    final accent = accentColor(context);
    final avatarSize = TicketAssignmentDesignSpec.avatarSize(context);

    if (!showsAssignmentForm) {
      return const SizedBox.shrink();
    }

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
              AssignTicketPendingBadgeWidget(
                label: AppStrings.ticketAssignmentPendingBadge(strings),
                accentColor: accent,
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
                    ),
                    SizedBox(height: TicketsDesignSpec.px(context, 10)),
                    AssignTicketGuestFieldWidget(
                      controller: phoneController,
                      hintText:
                          AppStrings.ticketAssignmentGuestPhoneHint(strings),
                      keyboardType: TextInputType.phone,
                      borderColor: accent,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: TicketsDesignSpec.px(context, 12)),
          Row(
            children: [
              Expanded(
                child: AssignTicketActionButtonWidget(
                  label: AppStrings.ticketAssignmentPickContact(strings),
                  foregroundColor: accent,
                  onPressed: openGuestSearch,
                ),
              ),
              SizedBox(width: TicketsDesignSpec.px(context, 10)),
              Expanded(
                child: AssignTicketActionButtonWidget(
                  label: AppStrings.ticketAssignmentSendTicket(strings),
                  foregroundColor: accent,
                  onPressed: submitAssign,
                  isLoading: widget.isAssignLoading || widget.isResendLoading,
                ),
              ),
            ],
          ),
          SizedBox(height: TicketsDesignSpec.px(context, 10)),
          AssignTicketActionButtonWidget(
            label: AppStrings.ticketAssignmentCancelTicket(strings),
            icon: Icons.delete_outline,
            foregroundColor: AppColors.profileDeleteRed,
            backgroundColor: TicketAssignmentDesignSpec.cancelButtonFill,
            borderColor: AppColors.profileDeleteRed,
            onPressed: submitCancel,
            isLoading: widget.isCancelLoading,
          ),
        ],
      ),
    );
  }
}
