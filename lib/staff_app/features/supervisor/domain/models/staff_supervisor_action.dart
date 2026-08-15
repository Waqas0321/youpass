enum StaffSupervisorActionType {
  qrReleased,
  manualValidation,
  consumptionCancelled,
}

class StaffSupervisorAction {
  const StaffSupervisorAction({
    required this.type,
    required this.title,
    required this.timeLabel,
  });

  final StaffSupervisorActionType type;
  final String title;
  final String timeLabel;
}
