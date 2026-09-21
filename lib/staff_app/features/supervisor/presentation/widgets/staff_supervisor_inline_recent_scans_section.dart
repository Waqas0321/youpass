import 'package:flutter/material.dart';

import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/staff_app/core/network/api_client.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/features/home/domain/models/staff_scan_entry.dart';
import 'package:youpass/staff_app/features/home/presentation/utils/open_staff_recent_scans_list.dart';
import 'package:youpass/staff_app/features/home/presentation/widgets/staff_recent_scan_tile.dart';
import 'package:youpass/staff_app/features/scan/data/staff_scan_api_service.dart';
import 'package:youpass/staff_app/features/scan/presentation/utils/open_staff_scan_result_detail.dart';
import 'package:youpass/staff_app/features/scan/routes/staff_qr_scan_route_args.dart';

/// Fills supervisor empty space with the same recent scan list used on staff home.
class StaffSupervisorInlineRecentScansSection extends StatefulWidget {
  const StaffSupervisorInlineRecentScansSection({
    super.key,
    required this.purpose,
    this.limit = 12,
  });

  final StaffQrScanPurpose purpose;
  final int limit;

  @override
  State<StaffSupervisorInlineRecentScansSection> createState() =>
      _StaffSupervisorInlineRecentScansSectionState();
}

class _StaffSupervisorInlineRecentScansSectionState
    extends State<StaffSupervisorInlineRecentScansSection> {
  final StaffScanApiService _scanApiService = StaffScanApiService(ApiClient());

  List<StaffScanEntry> _entries = const [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _isLoading = true);

    try {
      final response = widget.purpose == StaffQrScanPurpose.entry
          ? await _scanApiService.fetchRecentEntryScans(limit: widget.limit)
          : await _scanApiService.fetchRecentProductScans(limit: widget.limit);
      if (!mounted) {
        return;
      }
      setState(() {
        _entries = response.scans;
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _entries = const [];
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final layout = ResponsiveLayout(context);
    final emptyMessage = widget.purpose == StaffQrScanPurpose.entry
        ? l10n.staffSupervisorAccessHistoryEmpty
        : l10n.staffSupervisorRedemptionHistoryEmpty;

    return Padding(
      padding: EdgeInsets.only(top: layout.spacing(20)),
      child: StaffRecentScansSection(
        entries: _entries,
        isLoading: _isLoading,
        emptyMessage: emptyMessage,
        onViewAllTap: () => openStaffRecentScansList(
          context,
          purpose: widget.purpose,
        ),
        onScanTap: (scan) => openStaffScanResultDetail(
          context,
          scan: scan,
          purpose: widget.purpose,
        ),
      ),
    );
  }
}
