import 'package:flutter/material.dart';

import 'package:youpass/staff_app/core/config/otp_policy.dart';

class OtpAutofillHelper {
  OtpAutofillHelper._();

  static String? normalizePrefillCode(String? code) {
    if (code == null || code.trim().isEmpty) {
      return null;
    }

    final digits = code.replaceAll(RegExp(r'\D'), '');
    if (digits.length != OtpPolicy.codeLength) {
      return null;
    }

    return digits;
  }

  static void applyToController(TextEditingController controller, String code) {
    controller.value = TextEditingValue(
      text: code,
      selection: TextSelection.collapsed(offset: code.length),
    );
  }
}
