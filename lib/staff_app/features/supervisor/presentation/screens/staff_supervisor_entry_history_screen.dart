import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/staff_app/core/network/api_client.dart';
import 'package:youpass/staff_app/core/network/api_exception.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';
import 'package:youpass/staff_app/features/auth/presentation/providers/staff_auth_provider.dart';
import 'package:youpass/staff_app/features/home/presentation/widgets/staff_connection_status_bar.dart';
import 'package:youpass/staff_app/features/scan/presentation/widgets/staff_scan_screen_header.dart';
import 'package:youpass/staff_app/features/supervisor/data/staff_supervisor_api_service.dart';
import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_entry_search_result.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_entry_events_timeline.dart';
import 'package:youpass/staff_app/features/supervisor/routes/staff_supervisor_entry_history_route_args.dart';
import 'package:youpass/l10n/app_localizations.dart';

class StaffSupervisorEntryHistoryScreen extends StatefulWidget {
  const StaffSupervisorEntryHistoryScreen({
    super.key,
    required this.args,
    this.supervisorApiService,
  });

  final StaffSupervisorEntryHistoryRouteArgs args;
  final StaffSupervisorApiService? supervisorApiService;

  @override
  State<StaffSupervisorEntryHistoryScreen> createState() =>
      _StaffSupervisorEntryHistoryScreenState();
}

class _StaffSupervisorEntryHistoryScreenState
    extends State<StaffSupervisorEntryHistoryScreen> {
  static const _accent = Color(0xFFD4A044);
  static const _pageBg = Color(0xFFF8F9FA);

  late final StaffSupervisorApiService _supervisorApiService =
      widget.supervisorApiService ?? StaffSupervisorApiService(ApiClient());

  List<StaffSupervisorEntryEventLog> _events = const [];
  bool _isInitialLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory({bool fromRefresh = false}) async {
    if (!fromRefresh) {
      setState(() {
        _isInitialLoading = true;
        _errorMessage = null;
      });
    } else {
      setState(() => _errorMessage = null);
    }

    try {
      final response =
          await _supervisorApiService.getEntryHistory(widget.args.ticketId);

      if (!mounted) {
        return;
      }

      setState(() {
        _events = response.events;
        _isInitialLoading = false;
      });
    } on ApiException catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _events = const [];
        _isInitialLoading = false;
        _errorMessage = error.message;
      });
    } catch (_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _events = const [];
        _isInitialLoading = false;
        _errorMessage = context.l10n.staffSupervisorSearchEntrySearchError;
      });
    }
  }

  String _validatorFooterLabel(AppLocalizations l10n) {
    final zoneLabel = context.read<StaffAuthProvider>().profile?.zoneLabel;
    if (zoneLabel == null || zoneLabel.isEmpty) {
      return l10n.staffSupervisorValidatorLabel('VAL-AC-02');
    }

    final code = zoneLabel
        .trim()
        .toUpperCase()
        .replaceAll(RegExp(r'[^\w]+'), '-')
        .replaceAll(RegExp(r'^-|-$'), '');

    return l10n.staffSupervisorValidatorLabel(
      code.length >= 3 ? code : zoneLabel,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final layout = ResponsiveLayout(context);
    final args = widget.args;

    return Scaffold(
      backgroundColor: _pageBg,
      body: Column(
        children: [
          StaffScanScreenHeader(
            onBack: () => Navigator.of(context).pop(),
            showBottomDivider: true,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              layout.spacing(20),
              layout.spacing(8),
              layout.spacing(20),
              layout.spacing(12),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: AppText(
                l10n.staffSupervisorSearchEntryHeaderSubtitle,
                variant: AppTextVariant.body,
                color: AppColors.secondaryGrey,
                fontSize: layout.fontSize(13),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              color: _accent,
              onRefresh: () => _loadHistory(fromRefresh: true),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.fromLTRB(
                  layout.spacing(20),
                  0,
                  layout.spacing(20),
                  layout.spacing(12),
                ),
                children: [
                  AppText(
                    l10n.staffSupervisorEntryHistoryTitle,
                    variant: AppTextVariant.sectionTitle,
                    color: AppColors.homeBlack,
                    fontWeight: FontWeight.w800,
                    fontSize: layout.fontSize(22),
                  ),
                  SizedBox(height: layout.spacing(14)),
                  Container(
                    padding: EdgeInsets.all(layout.spacing(16)),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundWhite,
                      borderRadius: BorderRadius.circular(layout.radius(16)),
                      border: Border.all(color: AppColors.homeDividerGrey),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          args.guestName,
                          variant: AppTextVariant.bodyEmphasis,
                          color: AppColors.homeBlack,
                          fontWeight: FontWeight.w800,
                          fontSize: layout.fontSize(17),
                        ),
                        if (args.eventTitle.isNotEmpty) ...[
                          SizedBox(height: layout.spacing(4)),
                          AppText(
                            args.eventTitle,
                            variant: AppTextVariant.body,
                            color: AppColors.secondaryGrey,
                            fontSize: layout.fontSize(13),
                          ),
                        ],
                        if (args.qrId.isNotEmpty) ...[
                          SizedBox(height: layout.spacing(8)),
                          AppText(
                            l10n.staffSupervisorEntryHistoryQrLabel(args.qrId),
                            variant: AppTextVariant.label,
                            color: AppColors.secondaryGrey,
                            fontWeight: FontWeight.w600,
                            fontSize: layout.fontSize(12),
                          ),
                        ],
                      ],
                    ),
                  ),
                  SizedBox(height: layout.spacing(20)),
                  if (_isInitialLoading)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: layout.spacing(32)),
                      child: const Center(
                        child: CircularProgressIndicator(color: _accent),
                      ),
                    )
                  else if (_errorMessage != null)
                    AppText(
                      _errorMessage!,
                      variant: AppTextVariant.body,
                      textAlign: TextAlign.center,
                      color: const Color(0xFFEF4444),
                      fontSize: layout.fontSize(14),
                    )
                  else if (_events.isEmpty)
                    AppText(
                      l10n.staffSupervisorEntryHistoryEmpty,
                      variant: AppTextVariant.body,
                      textAlign: TextAlign.center,
                      color: AppColors.secondaryGrey,
                      fontSize: layout.fontSize(14),
                    )
                  else
                    Container(
                      padding: EdgeInsets.all(layout.spacing(16)),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundWhite,
                        borderRadius: BorderRadius.circular(layout.radius(16)),
                        border: Border.all(color: AppColors.homeDividerGrey),
                      ),
                      child: StaffSupervisorEntryEventsTimeline(
                        layout: layout,
                        logs: _events,
                      ),
                    ),
                ],
              ),
            ),
          ),
          StaffConnectionStatusBar(
            validatorLabel: _validatorFooterLabel(l10n),
          ),
        ],
      ),
    );
  }
}
