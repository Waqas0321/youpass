enum StaffSupervisorManualValidationReason {
  phoneBattery,
  noConnection,
  damagedQr,
  brokenScreen,
  other,
}

class StaffSupervisorManualValidationResult {
  const StaffSupervisorManualValidationResult({
    required this.guestName,
    required this.eventName,
    required this.productName,
    required this.barName,
    required this.lastIdDigits,
    required this.isDocumentConfirmed,
    required this.isQrUnavailable,
  });

  final String guestName;
  final String eventName;
  final String productName;
  final String barName;
  final String lastIdDigits;
  final bool isDocumentConfirmed;
  final bool isQrUnavailable;

  static const demo = StaffSupervisorManualValidationResult(
    guestName: 'Daniel Rojas',
    eventName: 'YouFest 2026',
    productName: 'Jager Bomb',
    barName: 'Red Bull',
    lastIdDigits: '2048',
    isDocumentConfirmed: true,
    isQrUnavailable: true,
  );
}
