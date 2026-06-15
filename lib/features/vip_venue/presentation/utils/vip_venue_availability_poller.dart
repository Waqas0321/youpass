import 'dart:async';

class VipVenueAvailabilityPoller {
  VipVenueAvailabilityPoller({
    required this.onPoll,
    this.interval = const Duration(seconds: 15),
  });

  final Future<void> Function() onPoll;
  final Duration interval;

  Timer? _timer;

  void start() {
    _timer?.cancel();
    _timer = Timer.periodic(interval, (_) => onPoll());
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  void dispose() => stop();
}
