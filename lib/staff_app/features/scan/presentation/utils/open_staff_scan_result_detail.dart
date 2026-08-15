import 'package:flutter/material.dart';

import 'package:youpass/staff_app/features/home/domain/models/staff_scan_entry.dart';
import 'package:youpass/staff_app/features/scan/routes/staff_qr_scan_route_args.dart';
import 'package:youpass/staff_app/features/scan/routes/staff_qr_scan_result_route_args.dart';
import 'package:youpass/staff_app/routes/app_routes.dart';

void openStaffScanResultDetail(
  BuildContext context, {
  required StaffScanEntry scan,
  required StaffQrScanPurpose purpose,
}) {
  Navigator.of(context).pushNamed(
    StaffAppRoutes.qrScanResult,
    arguments: StaffQrScanResultRouteArgs(
      result: scan.toQrScanResult(purpose),
    ),
  );
}
