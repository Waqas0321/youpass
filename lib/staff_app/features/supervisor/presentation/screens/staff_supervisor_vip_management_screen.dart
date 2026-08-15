import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_snack_bar.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';
import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_vip_table_result.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/providers/staff_supervisor_vip_management_provider.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_pin_input_widget.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_access_scaffold.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_buttons.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_form_utils.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_radio_tile.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_section_card.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_vip_components.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_vip_search_field.dart';
import 'package:youpass/l10n/app_localizations.dart';

class StaffSupervisorVipManagementRoute extends StatelessWidget {
  const StaffSupervisorVipManagementRoute({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return ChangeNotifierProvider(
      create: (_) => StaffSupervisorVipManagementProvider(
        genericError: l10n.staffSupervisorSearchEntrySearchError,
      ),
      child: const StaffSupervisorVipManagementScreen(),
    );
  }
}

class StaffSupervisorVipManagementScreen extends StatelessWidget {
  const StaffSupervisorVipManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StaffSupervisorVipManagementProvider>(
      builder: (context, provider, _) {
        final l10n = context.l10n;
        final layout = ResponsiveLayout(context);
        final result = provider.tableContext;

        return StaffSupervisorAccessScaffold(
          onRefresh: result != null
              ? () => _refresh(context, provider, l10n)
              : null,
          footer: result != null && provider.selectedAction != null
              ? StaffSupervisorExecuteFooter(
                  label: _footerLabel(l10n, provider.selectedAction),
                  icon: Icons.verified_user_outlined,
                  enabled: provider.canSubmit,
                  isLoading: provider.isSubmitting,
                  onPressed: () => _submit(context, provider, l10n),
                )
              : null,
          children: [
            if (result == null) ...[
              StaffSupervisorVipSearchField(
                controller: provider.search,
                hint: l10n.staffSupervisorVipSearchPlaceholder,
                sectionTitle: l10n.staffSupervisorVipSearchSectionTitle,
                onResultSelected: provider.onSearchResultSelected,
              ),
            ] else ...[
              StaffSupervisorVipSearchField(
                controller: provider.search,
                hint: l10n.staffSupervisorVipSearchPlaceholder,
                wrapInCard: false,
                onResultSelected: provider.onSearchResultSelected,
              ),
              SizedBox(height: layout.spacing(14)),
              StaffSupervisorVipTableCard(
                tableName: result.tableName,
                accessLabel: result.accessLabel,
                eventName: result.eventName,
                statusLabel: l10n.staffSupervisorVipStatusLabel,
                activeStatusText: l10n.staffSupervisorVipStatusActive,
                capacityLabel: l10n.staffSupervisorVipCapacityLabel,
                capacityValue: l10n.staffSupervisorVipCapacityPeople(result.capacity),
                enteredLabel: l10n.staffSupervisorVipEnteredLabel,
                enteredValue: '${result.enteredCount}',
                pendingLabel: l10n.staffSupervisorVipPendingLabel,
                pendingValue: '${result.pendingCount}',
                purchaseResponsibleLabel: l10n.staffSupervisorVipPurchaseResponsibleLabel,
                purchaseResponsible: result.purchaseResponsible,
                purchaseIdLabel: l10n.staffSupervisorSearchEntryPurchaseIdLabel,
                purchaseId: result.purchaseId,
                isActive: result.isActive,
              ),
              SizedBox(height: layout.spacing(14)),
              StaffSupervisorVipGuestList(
                title: l10n.staffSupervisorVipGuestsTitle,
                guests: result.guests,
                enteredSubtitle: (time) => l10n.staffSupervisorVipGuestEntered(time),
                pendingSubtitle: l10n.staffSupervisorVipGuestPending,
                selectedSlotId: provider.selectedSlotId,
                selectionEnabled: provider.requiresGuestSelection,
                selectionHint: _guestSelectionHint(l10n, provider.selectedAction),
                isGuestSelectable: (guest) => switch (provider.selectedAction) {
                  StaffSupervisorVipAction.releaseInvitation => guest.canRelease,
                  StaffSupervisorVipAction.changeAccess => guest.canRelease,
                  StaffSupervisorVipAction.moveGuest => guest.canMove,
                  _ => false,
                },
                onGuestTap: provider.requiresGuestSelection
                    ? (guest) => provider.selectGuestSlot(guest.slotId)
                    : null,
              ),
              SizedBox(height: layout.spacing(14)),
              StaffSupervisorSectionCard(
                title: l10n.staffSupervisorDuplicateSupervisorActionsTitle,
                child: Row(
                  children: [
                    Expanded(
                      child: StaffSupervisorActionTile(
                        icon: Icons.person_add_alt_1_rounded,
                        label: l10n.staffSupervisorVipActionAuthorizeExtra,
                        selected: provider.selectedAction ==
                            StaffSupervisorVipAction.authorizeExtraGuest,
                        onTap: () => provider.selectAction(
                          StaffSupervisorVipAction.authorizeExtraGuest,
                        ),
                      ),
                    ),
                    SizedBox(width: layout.spacing(6)),
                    Expanded(
                      child: StaffSupervisorActionTile(
                        icon: Icons.workspace_premium_outlined,
                        label: l10n.staffSupervisorVipActionChangeAccess,
                        selected: provider.selectedAction ==
                            StaffSupervisorVipAction.changeAccess,
                        onTap: () => provider.selectAction(
                          StaffSupervisorVipAction.changeAccess,
                        ),
                      ),
                    ),
                    SizedBox(width: layout.spacing(6)),
                    Expanded(
                      child: StaffSupervisorActionTile(
                        icon: Icons.swap_horiz_rounded,
                        label: l10n.staffSupervisorVipActionMoveGuest,
                        selected: provider.selectedAction ==
                            StaffSupervisorVipAction.moveGuest,
                        onTap: () => provider.selectAction(
                          StaffSupervisorVipAction.moveGuest,
                        ),
                      ),
                    ),
                    SizedBox(width: layout.spacing(6)),
                    Expanded(
                      child: StaffSupervisorActionTile(
                        icon: Icons.lock_open_rounded,
                        label: l10n.staffSupervisorVipActionReleaseInvitation,
                        selected: provider.selectedAction ==
                            StaffSupervisorVipAction.releaseInvitation,
                        onTap: () => provider.selectAction(
                          StaffSupervisorVipAction.releaseInvitation,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (provider.selectedAction ==
                  StaffSupervisorVipAction.authorizeExtraGuest) ...[
                SizedBox(height: layout.spacing(14)),
                StaffSupervisorSectionCard(
                  title: l10n.staffSupervisorVipNewExtraGuestTitle,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppText(
                        l10n.staffSupervisorVipGuestNameLabel,
                        variant: AppTextVariant.label,
                        color: AppColors.secondaryGrey,
                        fontSize: layout.fontSize(13),
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: layout.spacing(8)),
                      TextField(
                        controller: provider.nameController,
                        onChanged: (_) => provider.notifyFormChanged(),
                        decoration: staffSupervisorInputDecoration(
                          layout,
                          hint: l10n.staffSupervisorVipGuestNamePlaceholder,
                        ),
                      ),
                      SizedBox(height: layout.spacing(14)),
                      AppText(
                        l10n.staffSupervisorVipGuestPhoneLabel,
                        variant: AppTextVariant.label,
                        color: AppColors.secondaryGrey,
                        fontSize: layout.fontSize(13),
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: layout.spacing(8)),
                      TextField(
                        controller: provider.phoneController,
                        keyboardType: TextInputType.phone,
                        onChanged: (_) => provider.notifyFormChanged(),
                        decoration: staffSupervisorInputDecoration(
                          layout,
                          hint: l10n.staffSupervisorVipGuestPhonePlaceholder,
                        ),
                      ),
                      SizedBox(height: layout.spacing(14)),
                      _VipPinReasonForm(provider: provider, l10n: l10n, layout: layout),
                    ],
                  ),
                ),
              ] else if (provider.selectedAction ==
                  StaffSupervisorVipAction.changeAccess) ...[
                if (provider.selectedSlotId != null) ...[
                  SizedBox(height: layout.spacing(14)),
                  StaffSupervisorVipAccessPicker(
                    title: l10n.staffSupervisorVipSelectAccessTitle,
                    options: result.accessOptions,
                    selectedLabel: provider.selectedAccessLabel,
                    onOptionSelected: provider.selectAccessLabel,
                  ),
                ],
                SizedBox(height: layout.spacing(14)),
                StaffSupervisorSectionCard(
                  child: _VipPinReasonForm(provider: provider, l10n: l10n, layout: layout),
                ),
              ] else if (provider.selectedAction ==
                  StaffSupervisorVipAction.moveGuest) ...[
                if (provider.selectedSlotId != null) ...[
                  SizedBox(height: layout.spacing(14)),
                  StaffSupervisorVipSlotPicker(
                    title: l10n.staffSupervisorVipSelectDestinationTitle,
                    slots: result.availableSlots,
                    selectedSlotId: provider.selectedTargetSlotId,
                    onSlotSelected: provider.selectTargetSlot,
                    emptyLabel: l10n.staffSupervisorVipNoAvailableSeats,
                  ),
                ],
                SizedBox(height: layout.spacing(14)),
                StaffSupervisorSectionCard(
                  child: _VipPinReasonForm(provider: provider, l10n: l10n, layout: layout),
                ),
              ] else if (provider.selectedAction ==
                  StaffSupervisorVipAction.releaseInvitation) ...[
                SizedBox(height: layout.spacing(14)),
                StaffSupervisorSectionCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (provider.selectedSlotId != null)
                        Padding(
                          padding: EdgeInsets.only(bottom: layout.spacing(14)),
                          child: AppText(
                            l10n.staffSupervisorVipReleaseInvitationHint,
                            variant: AppTextVariant.body,
                            color: AppColors.secondaryGrey,
                            fontSize: layout.fontSize(13),
                          ),
                        ),
                      _VipPinReasonForm(provider: provider, l10n: l10n, layout: layout),
                    ],
                  ),
                ),
              ],
              SizedBox(height: layout.spacing(14)),
              StaffSupervisorVipHistorySection(
                title: l10n.staffSupervisorVipHistoryTitle,
                entries: result.history,
                supervisorPrefix: l10n.staffSupervisorVipHistorySupervisorPrefix,
                entryTitle: (type) => _historyTitle(l10n, type),
              ),
            ],
          ],
        );
      },
    );
  }

  static String _guestSelectionHint(
    AppLocalizations l10n,
    StaffSupervisorVipAction? action,
  ) {
    return switch (action) {
      StaffSupervisorVipAction.releaseInvitation =>
        l10n.staffSupervisorVipSelectGuestRelease,
      StaffSupervisorVipAction.changeAccess =>
        l10n.staffSupervisorVipSelectGuestChangeAccess,
      StaffSupervisorVipAction.moveGuest => l10n.staffSupervisorVipSelectGuestMove,
      StaffSupervisorVipAction.authorizeExtraGuest || null => '',
    };
  }

  static String _footerLabel(
    AppLocalizations l10n,
    StaffSupervisorVipAction? action,
  ) {
    return switch (action) {
      StaffSupervisorVipAction.changeAccess =>
        l10n.staffSupervisorVipActionChangeAccess,
      StaffSupervisorVipAction.moveGuest => l10n.staffSupervisorVipActionMoveGuest,
      StaffSupervisorVipAction.releaseInvitation =>
        l10n.staffSupervisorVipActionReleaseInvitation,
      StaffSupervisorVipAction.authorizeExtraGuest || null =>
        l10n.staffSupervisorVipActionAuthorizeExtra,
    };
  }

  static String _historyTitle(
    AppLocalizations l10n,
    StaffSupervisorVipHistoryType type,
  ) {
    return switch (type) {
      StaffSupervisorVipHistoryType.extraGuest =>
        l10n.staffSupervisorVipHistoryExtraGuest,
      StaffSupervisorVipHistoryType.qrReleased =>
        l10n.staffSupervisorVipHistoryQrReleased,
      StaffSupervisorVipHistoryType.tableModified =>
        l10n.staffSupervisorVipHistoryTableModified,
    };
  }

  Future<void> _refresh(
    BuildContext context,
    StaffSupervisorVipManagementProvider provider,
    AppLocalizations l10n,
  ) async {
    await provider.refreshTableContext();
    if (!context.mounted) {
      return;
    }

    final error = provider.refreshError;
    if (error != null) {
      AppSnackBar.show(context, error);
    }
  }

  Future<void> _submit(
    BuildContext context,
    StaffSupervisorVipManagementProvider provider,
    AppLocalizations l10n,
  ) async {
    final result = await provider.submit();
    if (!context.mounted) {
      return;
    }

    if (result != null) {
      AppSnackBar.showSuccess(context, l10n.staffSupervisorVipActionSuccess);
      return;
    }

    final error = provider.submitError;
    if (error != null) {
      AppSnackBar.show(context, error);
    }
  }
}

class _VipPinReasonForm extends StatelessWidget {
  const _VipPinReasonForm({
    required this.provider,
    required this.l10n,
    required this.layout,
  });

  final StaffSupervisorVipManagementProvider provider;
  final AppLocalizations l10n;
  final ResponsiveLayout layout;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppText(
          l10n.staffSupervisorVipAuthorizationReasonLabel,
          variant: AppTextVariant.label,
          color: AppColors.secondaryGrey,
          fontSize: layout.fontSize(13),
          fontWeight: FontWeight.w500,
        ),
        SizedBox(height: layout.spacing(8)),
        TextField(
          controller: provider.reasonController,
          minLines: 2,
          maxLines: 2,
          onChanged: (_) => provider.notifyFormChanged(),
          decoration: staffSupervisorInputDecoration(
            layout,
            hint: l10n.staffSupervisorVipAuthorizationReasonPlaceholder,
          ),
        ),
        SizedBox(height: layout.spacing(14)),
        AppText(
          l10n.staffSupervisorAuthorizationPinLabel,
          variant: AppTextVariant.label,
          color: AppColors.secondaryGrey,
          fontSize: layout.fontSize(13),
          fontWeight: FontWeight.w500,
        ),
        SizedBox(height: layout.spacing(10)),
        StaffPinInputWidget(
          controller: provider.pinController,
          style: StaffPinInputStyle.boxes,
          obscureBoxDigits: true,
          autofocus: false,
          expandFullWidth: true,
          onChanged: (_) => provider.notifyFormChanged(),
        ),
      ],
    );
  }
}
