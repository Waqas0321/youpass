import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/staff_app/core/widgets/app_snack_bar.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';
import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_consumption_result.dart';
import 'package:youpass/staff_app/features/supervisor/drinks/domain/models/staff_supervisor_drink_search_result.dart';
import 'package:youpass/staff_app/features/supervisor/drinks/presentation/providers/staff_supervisor_drink_lookup_provider.dart';
import 'package:youpass/staff_app/features/supervisor/drinks/presentation/widgets/staff_supervisor_drink_consumption_card.dart';
import 'package:youpass/staff_app/features/supervisor/drinks/presentation/widgets/staff_supervisor_drink_search_field.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_pin_input_widget.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_page_header.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_section_card.dart';

class StaffSupervisorCancellationsRoute extends StatelessWidget {
  const StaffSupervisorCancellationsRoute({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return ChangeNotifierProvider(
      create: (_) => StaffSupervisorDrinkLookupProvider(
        genericSearchError: l10n.staffSupervisorSearchDrinkSearchError,
        genericLoadError: l10n.staffSupervisorSearchDrinkSearchError,
      ),
      child: const StaffSupervisorCancellationsScreen(),
    );
  }
}

class StaffSupervisorCancellationsScreen extends StatefulWidget {
  const StaffSupervisorCancellationsScreen({super.key});

  @override
  State<StaffSupervisorCancellationsScreen> createState() =>
      _StaffSupervisorCancellationsScreenState();
}

class _StaffSupervisorCancellationsScreenState
    extends State<StaffSupervisorCancellationsScreen> {
  static const _accent = AppColors.homeAccentYellow;
  static const _pageBg = Color(0xFFF8F9FA);

  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();

  StaffSupervisorCancellationAction? _selectedAction;
  _RestoreReasonPreset? _selectedReason;

  @override
  void dispose() {
    _reasonController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  String _composeReasonNotes() {
    final preset = _selectedReason;
    if (preset == null) {
      return _reasonController.text.trim();
    }
    if (preset == _RestoreReasonPreset.other) {
      final note = _reasonController.text.trim();
      return note.isEmpty ? 'Other' : 'Other: $note';
    }
    return preset.label;
  }

  Future<void> _submitCancellation(
    BuildContext context,
    StaffSupervisorDrinkLookupProvider provider,
  ) async {
    final action = _selectedAction;
    if (action == null) {
      return;
    }

    final success = await provider.submitCancellation(
      pin: _pinController.text,
      notes: _composeReasonNotes(),
      action: action,
    );

    if (!context.mounted) {
      return;
    }

    if (success) {
      AppSnackBar.showSuccess(
        context,
        context.l10n.staffSupervisorCancellationSuccess,
      );
      Navigator.of(context).pop(true);
      return;
    }

    if (provider.submitError != null) {
      AppSnackBar.show(context, provider.submitError!);
    }
  }

  String _actionLabel(
    dynamic l10n,
    StaffSupervisorCancellationAction action,
  ) {
    return switch (action) {
      StaffSupervisorCancellationAction.cancelConsumption =>
        l10n.staffSupervisorCancelConsumption,
      StaffSupervisorCancellationAction.revertValidation =>
        l10n.staffSupervisorRestoreConsumptionAction,
      StaffSupervisorCancellationAction.releaseBlockedQr =>
        l10n.staffSupervisorReleaseBlockedQr,
    };
  }

  List<StaffSupervisorCancellationAction> _availableActions(
    StaffSupervisorDrinkSearchDetail detail,
  ) {
    // Contextual: Restore only when redeemed. Other legacy actions remain
    // available only for blocked/error edge cases (commented primary radios).
    if (detail.status == StaffSupervisorDrinkStatus.validated ||
        detail.isValidated) {
      return const [StaffSupervisorCancellationAction.revertValidation];
    }
    if (detail.status == StaffSupervisorDrinkStatus.blocked) {
      return const [StaffSupervisorCancellationAction.releaseBlockedQr];
    }
    // PREVIOUS: always showed cancel / restore / release.
    return const [];
  }

  InputDecoration _inputDecoration(ResponsiveLayout layout, {required String hint}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        color: AppColors.secondaryGrey.withValues(alpha: 0.85),
        fontSize: layout.fontSize(14),
      ),
      filled: true,
      fillColor: AppColors.backgroundWhite,
      contentPadding: EdgeInsets.all(layout.spacing(14)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(layout.radius(12)),
        borderSide: const BorderSide(color: AppColors.homeDividerGrey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(layout.radius(12)),
        borderSide: const BorderSide(color: AppColors.homeDividerGrey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(layout.radius(12)),
        borderSide: const BorderSide(color: _accent, width: 1.5),
      ),
    );
  }

  bool _canSubmit(StaffSupervisorDrinkLookupProvider provider) {
    if (provider.detail == null ||
        provider.isSubmitting ||
        _selectedAction == null ||
        _pinController.text.length != 4) {
      return false;
    }
    if (_selectedAction == StaffSupervisorCancellationAction.revertValidation) {
      if (_selectedReason == null) {
        return false;
      }
      if (_selectedReason == _RestoreReasonPreset.other &&
          _reasonController.text.trim().isEmpty) {
        return false;
      }
      return true;
    }
    return _reasonController.text.trim().isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final layout = ResponsiveLayout(context);

    return Consumer<StaffSupervisorDrinkLookupProvider>(
      builder: (context, provider, _) {
        final detail = provider.detail;
        final availableActions =
            detail == null ? const <StaffSupervisorCancellationAction>[] : _availableActions(detail);

        return Scaffold(
          backgroundColor: _pageBg,
          body: Column(
            children: [
              StaffSupervisorPageHeader(
                title: l10n.staffSupervisorSearchManagePurchaseTitle,
                subtitle: l10n.staffSupervisorSearchManagePurchaseLine1,
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.fromLTRB(
                    layout.spacing(20),
                    layout.spacing(16),
                    layout.spacing(20),
                    layout.spacing(12),
                  ),
                  children: [
                    StaffSupervisorDrinkSearchField(
                      controller: provider.search,
                      hint: l10n.staffSupervisorSearchPlaceholder,
                      sectionTitle: l10n.staffSupervisorSearchConsumptionHeading,
                      onResultSelected: (result) {
                        setState(() {
                          _selectedAction = null;
                          _selectedReason = null;
                          _reasonController.clear();
                        });
                        provider.onSearchResultSelected(result);
                      },
                    ),
                    if (provider.isLoadingDetail)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: layout.spacing(24)),
                        child: const Center(
                          child: CircularProgressIndicator(color: _accent),
                        ),
                      )
                    else if (provider.detailError != null)
                      Padding(
                        padding: EdgeInsets.only(top: layout.spacing(14)),
                        child: AppText(
                          provider.detailError!,
                          variant: AppTextVariant.body,
                          color: const Color(0xFFEF4444),
                          fontSize: layout.fontSize(13),
                          textAlign: TextAlign.center,
                        ),
                      )
                    else if (provider.submitError != null)
                      Padding(
                        padding: EdgeInsets.only(top: layout.spacing(14)),
                        child: AppText(
                          provider.submitError!,
                          variant: AppTextVariant.body,
                          color: const Color(0xFFEF4444),
                          fontSize: layout.fontSize(13),
                          textAlign: TextAlign.center,
                        ),
                      )
                    else if (detail != null) ...[
                      SizedBox(height: layout.spacing(14)),
                      StaffSupervisorDrinkConsumptionCard(
                        layout: layout,
                        l10n: l10n,
                        detail: detail,
                      ),
                      if (availableActions.isEmpty) ...[
                        SizedBox(height: layout.spacing(14)),
                        AppText(
                          l10n.staffSupervisorNoRestoreActionAvailable,
                          variant: AppTextVariant.body,
                          color: AppColors.secondaryGrey,
                          fontSize: layout.fontSize(13),
                          height: 1.4,
                        ),
                      ] else ...[
                        SizedBox(height: layout.spacing(14)),
                        StaffSupervisorSectionCard(
                          title: l10n.staffSupervisorActionsTitle,
                          child: Column(
                            children: availableActions
                                .map(
                                  (action) => _ActionRadioTile(
                                    layout: layout,
                                    label: _actionLabel(l10n, action),
                                    selected: _selectedAction == action,
                                    onTap: () => setState(() {
                                      _selectedAction = action;
                                      if (action !=
                                          StaffSupervisorCancellationAction
                                              .revertValidation) {
                                        _selectedReason = null;
                                      }
                                    }),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        if (_selectedAction ==
                            StaffSupervisorCancellationAction.revertValidation) ...[
                          SizedBox(height: layout.spacing(14)),
                          StaffSupervisorSectionCard(
                            title: l10n.staffSupervisorRestoreReasonTitle,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                for (final reason in _RestoreReasonPreset.values)
                                  _ActionRadioTile(
                                    layout: layout,
                                    label: reason.localized(l10n),
                                    selected: _selectedReason == reason,
                                    onTap: () =>
                                        setState(() => _selectedReason = reason),
                                  ),
                                if (_selectedReason ==
                                    _RestoreReasonPreset.other) ...[
                                  SizedBox(height: layout.spacing(10)),
                                  TextField(
                                    controller: _reasonController,
                                    maxLines: 2,
                                    onChanged: (_) => setState(() {}),
                                    style: TextStyle(
                                      fontSize: layout.fontSize(14),
                                      color: AppColors.homeBlack,
                                    ),
                                    decoration: _inputDecoration(
                                      layout,
                                      hint: l10n.staffSupervisorRestoreReasonOtherHint,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ] else if (_selectedAction != null) ...[
                          SizedBox(height: layout.spacing(14)),
                          StaffSupervisorSectionCard(
                            title: l10n.staffSupervisorReasonTitle,
                            child: TextField(
                              controller: _reasonController,
                              maxLines: 3,
                              onChanged: (_) => setState(() {}),
                              style: TextStyle(
                                fontSize: layout.fontSize(14),
                                color: AppColors.homeBlack,
                              ),
                              decoration: _inputDecoration(
                                layout,
                                hint: l10n.staffSupervisorReasonPlaceholder,
                              ),
                            ),
                          ),
                        ],
                        SizedBox(height: layout.spacing(14)),
                        StaffSupervisorSectionCard(
                          title: l10n.staffSupervisorAuthorizationTitle,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              AppText(
                                l10n.staffSupervisorAuthorizationPinLabel,
                                variant: AppTextVariant.label,
                                color: AppColors.secondaryGrey,
                                fontSize: layout.fontSize(13),
                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(height: layout.spacing(12)),
                              StaffPinInputWidget(
                                controller: _pinController,
                                style: StaffPinInputStyle.boxes,
                                obscureBoxDigits: true,
                                autofocus: false,
                                onChanged: (_) => setState(() {}),
                              ),
                            ],
                          ),
                        ),
                      ],
                      SizedBox(height: layout.spacing(14)),
                      StaffSupervisorDrinkHistorySection(
                        layout: layout,
                        l10n: l10n,
                        detail: detail,
                      ),
                    ],
                  ],
                ),
              ),
              if (availableActions.isNotEmpty)
                _ExecuteFooter(
                  layout: layout,
                  label: l10n.staffSupervisorRestoreExecuteButton,
                  enabled: _canSubmit(provider),
                  onPressed: () => _submitCancellation(context, provider),
                ),
            ],
          ),
        );
      },
    );
  }
}

enum _RestoreReasonPreset {
  productNotDelivered,
  accidentalScan,
  operationalIssue,
  other,
}

extension on _RestoreReasonPreset {
  String get label {
    return switch (this) {
      _RestoreReasonPreset.productNotDelivered => 'Product not delivered',
      _RestoreReasonPreset.accidentalScan => 'Accidental scan',
      _RestoreReasonPreset.operationalIssue => 'Operational issue',
      _RestoreReasonPreset.other => 'Other',
    };
  }

  String localized(dynamic l10n) {
    return switch (this) {
      _RestoreReasonPreset.productNotDelivered =>
        l10n.staffSupervisorRestoreReasonProductNotDelivered,
      _RestoreReasonPreset.accidentalScan =>
        l10n.staffSupervisorRestoreReasonAccidentalScan,
      _RestoreReasonPreset.operationalIssue =>
        l10n.staffSupervisorRestoreReasonOperationalIssue,
      _RestoreReasonPreset.other => l10n.staffSupervisorRestoreReasonOther,
    };
  }
}

class _ExecuteFooter extends StatelessWidget {
  const _ExecuteFooter({
    required this.layout,
    required this.label,
    required this.enabled,
    required this.onPressed,
  });

  static const _accent = AppColors.homeAccentYellow;
  static const _pageBg = Color(0xFFF8F9FA);

  final ResponsiveLayout layout;
  final String label;
  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _pageBg,
      padding: EdgeInsets.fromLTRB(
        layout.spacing(20),
        layout.spacing(8),
        layout.spacing(20),
        layout.spacing(24),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          width: double.infinity,
          height: layout.buttonHeight,
          child: ElevatedButton.icon(
            onPressed: enabled ? onPressed : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: _accent,
              disabledBackgroundColor: _accent.withValues(alpha: 0.42),
              foregroundColor: AppColors.backgroundWhite,
              disabledForegroundColor:
                  AppColors.backgroundWhite.withValues(alpha: 0.85),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(layout.radius(16)),
              ),
            ),
            icon: Icon(Icons.lock_outline_rounded, size: layout.spacing(20)),
            label: AppText(
              label,
              variant: AppTextVariant.button,
              color: AppColors.backgroundWhite,
              fontWeight: FontWeight.w800,
              fontSize: layout.fontSize(14),
              letterSpacing: 0.7,
            ),
          ),
        ),
      ),
    );
  }
}

class _ActionRadioTile extends StatelessWidget {
  const _ActionRadioTile({
    required this.layout,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  static const _accent = AppColors.homeAccentYellow;

  final ResponsiveLayout layout;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(layout.radius(10)),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: layout.spacing(10)),
          child: Row(
            children: [
              Container(
                width: layout.spacing(22),
                height: layout.spacing(22),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: selected ? _accent : AppColors.lightGreyBorder,
                    width: selected ? 2 : 1.5,
                  ),
                ),
                child: selected
                    ? Center(
                        child: Container(
                          width: layout.spacing(10),
                          height: layout.spacing(10),
                          decoration: const BoxDecoration(
                            color: _accent,
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                    : null,
              ),
              SizedBox(width: layout.spacing(12)),
              Expanded(
                child: AppText(
                  label,
                  variant: AppTextVariant.body,
                  color: AppColors.homeBlack,
                  fontSize: layout.fontSize(14),
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
