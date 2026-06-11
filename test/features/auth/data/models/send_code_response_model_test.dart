import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/features/auth/data/models/send_code_response_model.dart';
import 'package:youpass/features/auth/domain/entities/otp_purpose.dart';

void main() {
  test('fromJson maps account_exists and effective purpose', () {
    final model = SendCodeResponseModel.fromJson({
      'message': 'Code sent via SMS',
      'phone': '+923216548001',
      'purpose': 'register',
      'account_exists': false,
      'channel': 'whatsapp',
      'expires_in_seconds': 180,
      'resend_available_in_seconds': 60,
      'phone_display': '+92 321 6548001',
    });

    expect(model.accountExists, isFalse);
    expect(model.effectivePurpose, OtpPurpose.register);
    expect(model.channel, 'whatsapp');
    expect(model.expiresInSeconds, 180);
  });
}
