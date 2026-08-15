import 'package:flutter/material.dart';

import 'package:youpass/staff_app/features/home/routes/staff_recent_scans_list_route_args.dart';
import 'package:youpass/staff_app/features/scan/routes/staff_qr_scan_route_args.dart';
import 'package:youpass/staff_app/routes/app_routes.dart';

Future<void> openStaffRecentScansList(
  BuildContext context, {
  required StaffQrScanPurpose purpose,
}) {
  return Navigator.of(context).pushNamed(
    StaffAppRoutes.recentScansList,
    arguments: StaffRecentScansListRouteArgs(purpose: purpose),
  );
}
