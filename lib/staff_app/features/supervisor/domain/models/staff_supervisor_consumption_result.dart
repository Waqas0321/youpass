enum StaffSupervisorCancellationAction {
  cancelConsumption,
  revertValidation,
  releaseBlockedQr,
}

class StaffSupervisorConsumptionResult {
  const StaffSupervisorConsumptionResult({
    required this.guestName,
    required this.productName,
    required this.barName,
    required this.validatedAtLabel,
    required this.consumptionId,
    required this.isValidated,
  });

  final String guestName;
  final String productName;
  final String barName;
  final String validatedAtLabel;
  final String consumptionId;
  final bool isValidated;

  static const demo = StaffSupervisorConsumptionResult(
    guestName: 'Daniel Rojas',
    productName: 'Jager Bomb',
    barName: 'Red Bull',
    validatedAtLabel: '00:41',
    consumptionId: 'YP-CNS-2048',
    isValidated: true,
  );
}
