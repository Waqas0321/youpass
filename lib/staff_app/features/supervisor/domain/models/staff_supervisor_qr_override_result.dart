enum StaffSupervisorQrOverrideAction {
  releaseQr,
  revalidateQr,
  revertValidation,
  authorizeReconsumption,
  temporaryUnlock,
}

class StaffSupervisorQrOverrideResult {
  const StaffSupervisorQrOverrideResult({
    required this.guestName,
    required this.productName,
    required this.eventName,
    required this.qrId,
    required this.isBlocked,
    required this.lastUsedAtLabel,
    required this.barName,
    required this.scannerId,
  });

  final String guestName;
  final String productName;
  final String eventName;
  final String qrId;
  final bool isBlocked;
  final String lastUsedAtLabel;
  final String barName;
  final String scannerId;

  static const demo = StaffSupervisorQrOverrideResult(
    guestName: 'Daniel Rojas',
    productName: 'Jager Bomb',
    eventName: 'YouFest 2026',
    qrId: 'YP-BAR-2048',
    isBlocked: true,
    lastUsedAtLabel: '00:41',
    barName: 'Red Bull',
    scannerId: 'BAR-03',
  );
}

class StaffSupervisorQrLogEntry {
  const StaffSupervisorQrLogEntry({
    required this.timeLabel,
    required this.label,
    this.isBlocked = false,
    this.isPending = false,
  });

  final String timeLabel;
  final String label;
  final bool isBlocked;
  final bool isPending;

  static const demoLogs = [
    StaffSupervisorQrLogEntry(timeLabel: '00:38', label: 'Validado'),
    StaffSupervisorQrLogEntry(
      timeLabel: '00:41',
      label: 'QR bloqueado',
      isBlocked: true,
    ),
    StaffSupervisorQrLogEntry(
      timeLabel: '00:45',
      label: 'Override pendiente',
      isPending: true,
    ),
  ];
}
