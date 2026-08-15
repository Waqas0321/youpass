class OtpTimerFormatter {
  OtpTimerFormatter._();

  static String formatCountdown(int totalSeconds) {
    final safeSeconds = totalSeconds < 0 ? 0 : totalSeconds;
    final minutes = (safeSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (safeSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
