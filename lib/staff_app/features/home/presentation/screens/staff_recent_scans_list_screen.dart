import 'package:flutter/material.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/staff_app/core/network/api_client.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';
import 'package:youpass/staff_app/features/home/domain/models/staff_access_entry.dart';
import 'package:youpass/staff_app/features/home/domain/models/staff_scan_entry.dart';
import 'package:youpass/staff_app/features/home/presentation/widgets/staff_recent_access_section.dart';
import 'package:youpass/staff_app/features/home/presentation/widgets/staff_recent_scan_tile.dart';
import 'package:youpass/staff_app/features/scan/data/staff_scan_api_service.dart';
import 'package:youpass/staff_app/features/scan/presentation/utils/open_staff_scan_result_detail.dart';
import 'package:youpass/staff_app/features/scan/presentation/widgets/staff_scan_screen_header.dart';
import 'package:youpass/staff_app/features/scan/routes/staff_qr_scan_route_args.dart';

class StaffRecentScansListScreen extends StatefulWidget {
  const StaffRecentScansListScreen({
    super.key,
    required this.purpose,
    this.scanApiService,
  });

  final StaffQrScanPurpose purpose;
  final StaffScanApiService? scanApiService;

  @override
  State<StaffRecentScansListScreen> createState() =>
      _StaffRecentScansListScreenState();
}

class _StaffRecentScansListScreenState extends State<StaffRecentScansListScreen> {
  static const _pageLimit = 50;

  late final StaffScanApiService _scanApiService =
      widget.scanApiService ?? StaffScanApiService(ApiClient());

  List<StaffScanEntry> _scans = const [];
  bool _isLoading = true;

  bool get _isEntryList => widget.purpose == StaffQrScanPurpose.entry;

  @override
  void initState() {
    super.initState();
    _loadScans();
  }

  Future<void> _loadScans() async {
    setState(() => _isLoading = true);

    try {
      final response = _isEntryList
          ? await _scanApiService.fetchRecentEntryScans(limit: _pageLimit)
          : await _scanApiService.fetchRecentProductScans(limit: _pageLimit);

      if (!mounted) {
        return;
      }

      setState(() {
        _scans = response.scans;
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _scans = const [];
        _isLoading = false;
      });
    }
  }

  void _openScanDetail(StaffScanEntry scan) {
    openStaffScanResultDetail(
      context,
      scan: scan,
      purpose: widget.purpose,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final layout = ResponsiveLayout(context);
    final title =
        _isEntryList ? l10n.staffRecentAccessTitle : l10n.staffRecentScansTitle;
    final emptyMessage = _isEntryList
        ? l10n.staffRecentAccessEmpty
        : l10n.staffRecentScansEmpty;

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: Column(
        children: [
          StaffScanScreenHeader(
            onBack: () => Navigator.of(context).pop(),
            showBottomDivider: true,
          ),
          Expanded(
            child: RefreshIndicator(
              color: AppColors.primaryMustard,
              onRefresh: _loadScans,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.fromLTRB(
                  layout.spacing(20),
                  layout.spacing(16),
                  layout.spacing(20),
                  layout.spacing(24),
                ),
                children: [
                  AppText(
                    title,
                    variant: AppTextVariant.sectionTitle,
                    color: AppColors.homeBlack,
                    fontWeight: FontWeight.w700,
                    fontSize: layout.fontSize(22),
                  ),
                  SizedBox(height: layout.spacing(16)),
                  _RecentScansListBody(
                    isLoading: _isLoading,
                    emptyMessage: emptyMessage,
                    scans: _scans,
                    isEntryList: _isEntryList,
                    onScanTap: _openScanDetail,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RecentScansListBody extends StatelessWidget {
  const _RecentScansListBody({
    required this.isLoading,
    required this.emptyMessage,
    required this.scans,
    required this.isEntryList,
    required this.onScanTap,
  });

  final bool isLoading;
  final String emptyMessage;
  final List<StaffScanEntry> scans;
  final bool isEntryList;
  final ValueChanged<StaffScanEntry> onScanTap;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    if (isLoading) {
      return Padding(
        padding: EdgeInsets.all(layout.spacing(48)),
        child: Center(
          child: SizedBox(
            width: layout.spacing(28),
            height: layout.spacing(28),
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors.primaryMustard,
            ),
          ),
        ),
      );
    }

    if (scans.isEmpty) {
      return Padding(
        padding: EdgeInsets.all(layout.spacing(24)),
        child: AppText(
          emptyMessage,
          variant: AppTextVariant.body,
          textAlign: TextAlign.center,
          color: AppColors.secondaryGrey,
          fontSize: layout.fontSize(14),
          height: 1.4,
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(layout.radius(18)),
        border: Border.all(color: AppColors.homeDividerGrey),
      ),
      child: Column(
        children: [
          if (isEntryList)
            for (var index = 0; index < scans.length; index++) ...[
              StaffRecentAccessTile(
                entry: scans[index].toAccessEntry(),
                onTap: () => onScanTap(scans[index]),
              ),
              if (index < scans.length - 1)
                Divider(
                  height: 1,
                  thickness: 1,
                  color: AppColors.homeDividerGrey,
                  indent: layout.spacing(60),
                  endIndent: layout.spacing(16),
                ),
            ]
          else
            for (var index = 0; index < scans.length; index++) ...[
              StaffRecentScanTile(
                entry: scans[index],
                onTap: () => onScanTap(scans[index]),
              ),
              if (index < scans.length - 1)
                Divider(
                  height: 1,
                  thickness: 1,
                  color: AppColors.homeDividerGrey,
                  indent: layout.spacing(68),
                  endIndent: layout.spacing(16),
                ),
            ],
        ],
      ),
    );
  }
}
