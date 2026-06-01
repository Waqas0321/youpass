import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/core/utils/otp_timer_formatter.dart';

void main() {
  test('formatCountdown formats mm:ss', () {
    expect(OtpTimerFormatter.formatCountdown(24), '00:24');
    expect(OtpTimerFormatter.formatCountdown(61), '01:01');
    expect(OtpTimerFormatter.formatCountdown(0), '00:00');
  });
}
