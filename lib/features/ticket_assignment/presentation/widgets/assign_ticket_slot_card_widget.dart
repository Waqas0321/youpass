import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/theme/tickets_screen_theme.dart';
import 'package:youpass/core/widgets/app_text_field.dart';
import 'package:youpass/core/widgets/app_text_field_variant.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/ticket_assignment_slot_entity.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/ticket_slot_status.dart';
import 'package:youpass/features/ticket_assignment/presentation/utils/contact_picker_helper.dart';
import 'package:youpass/features/ticket_assignment/presentation/utils/ticket_assignment_label_formatter.dart';
import 'package:youpass/features/tickets/presentation/tickets_design_spec.dart';
import 'package:youpass/features/tickets/presentation/widgets/ticket_outline_button_widget.dart';
import 'package:youpass/features/tickets/presentation/widgets/ticket_status_badge_widget.dart';

class AssignTicketSlotCardWidget extends StatefulWidget {
  const AssignTicketSlotCardWidget({
    super.key,
    required this.slot,
    required this.orderId,
    required this.onAssign,
    required this.onCancel,
    required this.onResend,
    this.isAssignLoading = false,
    this.isCancelLoading = false,
    this.isResendLoading = false,
  });

  final TicketAssignmentSlotEntity slot;
  final String orderId;
  final Future<bool> Function(String guestName, String guestPhone) onAssign;
  final Future<bool> Function() onCancel;
  final Future<bool> Function() onResend;
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

  @override
  void initState() {
    super.initState();
    syncGuestFields(widget.slot);
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

  Future<void> pickContact() async {
    final result = await ContactPickerHelper.pickContact();
    if (!mounted || result == null) {
      return;
    }

    nameController.text = result.displayName;
    phoneController.text = result.phone;
    setState(() {});
  }

  Future<void> submitAssign() async {
    final name = nameController.text.trim();
    final phone = phoneController.text.trim();
    if (name.isEmpty || phone.isEmpty) {
      return;
    }

    final success = widget.slot.status == TicketSlotStatus.pending &&
            widget.slot.canResend
        ? await widget.onResend()
        : await widget.onAssign(name, phone);

    if (!mounted) {
      return;
    }

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppStrings.ticketAssignmentSentSuccess(context.l10n)),
        ),
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

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final radius = TicketsDesignSpec.px(context, TicketsDesignSpec.cardRadius);
    final slot = widget.slot;

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
        boxShadow: TicketsScreenTheme.cardShadow(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  TicketAssignmentLabelFormatter.slotLabel(strings, slot),
                  style: TextStyle(
                    fontSize: TicketsDesignSpec.px(context, 16),
                    fontWeight: FontWeight.w700,
                    color: TicketsScreenTheme.title(context),
                  ),
                ),
              ),
              if (slot.status == TicketSlotStatus.pending)
                TicketStatusBadgeWidget(
                  label: AppStrings.ticketAssignmentPendingBadge(strings),
                )
              else if (slot.status == TicketSlotStatus.available)
                TicketStatusBadgeWidget(
                  label: AppStrings.ticketAssignmentAvailableBadge(strings),
                ),
            ],
          ),
          SizedBox(height: TicketsDesignSpec.px(context, 14)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: TicketsDesignSpec.px(context, 44),
                height: TicketsDesignSpec.px(context, 44),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: TicketsScreenTheme.accent(context),
                    width: 1.5,
                  ),
                ),
                child: Icon(
                  Icons.person_outline,
                  color: TicketsScreenTheme.accent(context),
                  size: TicketsDesignSpec.px(context, 22),
                ),
              ),
              SizedBox(width: TicketsDesignSpec.px(context, 10)),
              Expanded(
                child: AppTextField(
                  controller: nameController,
                  hintText: AppStrings.ticketAssignmentGuestNameHint(strings),
                  variant: AppTextFieldVariant.outlined,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: TicketsDesignSpec.px(context, 12),
                    vertical: TicketsDesignSpec.px(context, 12),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: TicketsDesignSpec.px(context, 10)),
          AppTextField(
            controller: phoneController,
            hintText: AppStrings.ticketAssignmentGuestPhoneHint(strings),
            variant: AppTextFieldVariant.outlined,
            keyboardType: TextInputType.phone,
            contentPadding: EdgeInsets.symmetric(
              horizontal: TicketsDesignSpec.px(context, 12),
              vertical: TicketsDesignSpec.px(context, 12),
            ),
          ),
          SizedBox(height: TicketsDesignSpec.px(context, 12)),
          Row(
            children: [
              Expanded(
                child: TicketOutlineButtonWidget(
                  label: AppStrings.ticketAssignmentPickContact(strings),
                  icon: Icons.person_add_alt_1_outlined,
                  onPressed: pickContact,
                  fontSize: TicketsDesignSpec.px(context, 11),
                ),
              ),
              SizedBox(width: TicketsDesignSpec.px(context, 10)),
              Expanded(
                child: TicketOutlineButtonWidget(
                  label: AppStrings.ticketAssignmentSendTicket(strings),
                  icon: Icons.send_outlined,
                  onPressed: submitAssign,
                  isLoading: widget.isAssignLoading || widget.isResendLoading,
                  fontSize: TicketsDesignSpec.px(context, 11),
                ),
              ),
            ],
          ),
          if (slot.canCancel || slot.status == TicketSlotStatus.pending) ...[
            SizedBox(height: TicketsDesignSpec.px(context, 10)),
            TicketOutlineButtonWidget(
              label: AppStrings.ticketAssignmentCancelTicket(strings),
              icon: Icons.delete_outline,
              onPressed: submitCancel,
              isLoading: widget.isCancelLoading,
              foregroundColor: AppColors.profileDeleteRed,
              borderColor: AppColors.profileDeleteRed,
            ),
          ],
        ],
      ),
    );
  }
}
