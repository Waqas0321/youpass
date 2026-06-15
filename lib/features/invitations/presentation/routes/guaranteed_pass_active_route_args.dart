class GuaranteedPassActiveRouteArgs {
  const GuaranteedPassActiveRouteArgs({
    required this.eventTitle,
    this.cancellationDeadlineLabel,
  });

  final String eventTitle;
  final String? cancellationDeadlineLabel;
}
