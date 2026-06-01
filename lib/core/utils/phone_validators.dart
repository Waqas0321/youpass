class PhoneValidators {
  static const int chilePhoneLength = 9;

  static String? chileMobile(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'El número telefónico es requerido';
    }
    final digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.length != chilePhoneLength) {
      return 'Ingresa un número de 9 dígitos';
    }
    if (!digits.startsWith('9')) {
      return 'El número debe comenzar con 9';
    }
    return null;
  }

  static String? otpCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ingresa el código de verificación';
    }
    if (value.length != 6) {
      return 'El código debe tener 6 dígitos';
    }
    return null;
  }
}
