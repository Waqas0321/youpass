import 'package:youpass/staff_app/features/scan/routes/staff_qr_scan_route_args.dart';

class StaffRecentScansListRouteArgs {
  const StaffRecentScansListRouteArgs({
    required this.purpose,
  });

  final StaffQrScanPurpose purpose;
}
