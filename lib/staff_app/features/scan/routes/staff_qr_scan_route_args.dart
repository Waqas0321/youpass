enum StaffQrScanPurpose {
  product,
  entry,
}

class StaffQrScanRouteArgs {
  const StaffQrScanRouteArgs({
    this.purpose = StaffQrScanPurpose.product,
  });

  final StaffQrScanPurpose purpose;
}
