import 'package:flutter/material.dart';

import 'package:youpass/staff_app/features/scan/routes/staff_qr_scan_route_args.dart';
import 'package:youpass/staff_app/routes/app_routes.dart';

void openStaffQrScanner(
  BuildContext context, {
  StaffQrScanPurpose purpose = StaffQrScanPurpose.product,
}) {
  Navigator.of(context).pushNamed(
    StaffAppRoutes.qrScan,
    arguments: StaffQrScanRouteArgs(purpose: purpose),
  );
}

Future<void> openStaffQrScannerAndWait(
  BuildContext context, {
  StaffQrScanPurpose purpose = StaffQrScanPurpose.product,
}) async {
  await Navigator.of(context).pushNamed(
    StaffAppRoutes.qrScan,
    arguments: StaffQrScanRouteArgs(purpose: purpose),
  );
}
