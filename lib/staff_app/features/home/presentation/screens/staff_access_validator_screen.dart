import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/staff_app/core/network/api_client.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/features/auth/domain/staff_scan_permissions.dart';
import 'package:youpass/staff_app/features/auth/presentation/providers/staff_auth_provider.dart';
import 'package:youpass/staff_app/features/home/domain/models/staff_scan_entry.dart';
import 'package:youpass/staff_app/features/home/presentation/utils/open_staff_recent_scans_list.dart';
import 'package:youpass/staff_app/features/scan/presentation/utils/open_staff_scan_result_detail.dart';
import 'package:youpass/staff_app/features/home/presentation/providers/staff_work_mode_provider.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/utils/open_staff_supervisor_flow.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/utils/staff_supervisor_access.dart';
import 'package:youpass/staff_app/features/home/presentation/widgets/staff_access_validator_card.dart';
import 'package:youpass/staff_app/features/home/presentation/widgets/staff_active_event_banner.dart';
import 'package:youpass/staff_app/features/home/presentation/widgets/staff_connection_status_bar.dart';
import 'package:youpass/staff_app/features/home/presentation/widgets/staff_home_header.dart';
import 'package:youpass/staff_app/features/home/presentation/widgets/staff_menu_drawer.dart';
import 'package:youpass/staff_app/features/home/presentation/widgets/staff_recent_access_section.dart';
import 'package:youpass/staff_app/features/scan/data/staff_scan_api_service.dart';
import 'package:youpass/staff_app/features/scan/presentation/utils/open_staff_qr_scanner.dart';
import 'package:youpass/staff_app/features/scan/routes/staff_qr_scan_route_args.dart';

class StaffAccessValidatorScreen extends StatefulWidget {
  const StaffAccessValidatorScreen({
    super.key,
    this.scanApiService,
  });

  final StaffScanApiService? scanApiService;

  @override
  State<StaffAccessValidatorScreen> createState() =>
      _StaffAccessValidatorScreenState();
}

class _StaffAccessValidatorScreenState extends State<StaffAccessValidatorScreen> {
  late final StaffScanApiService _scanApiService =
      widget.scanApiService ?? StaffScanApiService(ApiClient());

  List<StaffScanEntry> _recentAccess = const [];
  String? _activeEventName;
  bool _isLoadingRecent = true;

  @override
  void initState() {
    super.initState();
    _loadRecentAccess();
  }

  Future<void> _loadRecentAccess() async {
    setState(() => _isLoadingRecent = true);

    try {
      final response = await _scanApiService.fetchRecentEntryScans();
      if (!mounted) {
        return;
      }
      setState(() {
        _recentAccess = response.scans;
        _activeEventName = response.scans
            .map((scan) => scan.eventTitle)
            .whereType<String>()
            .where((title) => title.isNotEmpty)
            .firstOrNull;
        _isLoadingRecent = false;
      });
    } catch (_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _recentAccess = const [];
        _isLoadingRecent = false;
      });
    }
  }

  Future<void> _openScanner() async {
    await openStaffQrScannerAndWait(
      context,
      purpose: StaffQrScanPurpose.entry,
    );
    if (mounted) {
      await _loadRecentAccess();
    }
  }

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final profile = context.watch<StaffAuthProvider>().profile;
    final workMode = context.watch<StaffWorkModeProvider>().mode;
    final showDrawer = profile?.shouldShowMenuDrawer(workMode) ?? false;
    final showManualEntry = profile?.hasEntrySupervisorAccess ?? false;

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      drawer: showDrawer ? const StaffMenuDrawer() : null,
      body: SafeArea(
        child: Column(
          children: [
            const StaffHomeHeader(),
            Expanded(
              child: RefreshIndicator(
                color: AppColors.primaryMustard,
                onRefresh: _loadRecentAccess,
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(
                    layout.spacing(20),
                    layout.spacing(8),
                    layout.spacing(20),
                    layout.spacing(8),
                  ),
                  children: [
                    StaffAccessValidatorCard(
                      onScanTap: _openScanner,
                      onManualEntryTap: () => openStaffSupervisorFlow(context),
                      showManualEntry: showManualEntry,
                    ),
                    if (_activeEventName != null) ...[
                      SizedBox(height: layout.spacing(24)),
                      StaffActiveEventBanner(eventName: _activeEventName!),
                    ],
                    SizedBox(height: layout.spacing(24)),
                    StaffRecentAccessSection(
                      scans: _recentAccess,
                      isLoading: _isLoadingRecent,
                      emptyMessage: context.l10n.staffRecentAccessEmpty,
                      onViewAllTap: () => openStaffRecentScansList(
                        context,
                        purpose: StaffQrScanPurpose.entry,
                      ),
                      onScanTap: (scan) => openStaffScanResultDetail(
                        context,
                        scan: scan,
                        purpose: StaffQrScanPurpose.entry,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const StaffConnectionStatusBar(),
          ],
        ),
      ),
    );
  }
}
