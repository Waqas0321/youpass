import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/features/ticket_assignment/presentation/utils/assign_ticket_phone_helper.dart';

void main() {
  test('resolvePhone splits Chile E164 into country and national digits', () {
    final resolved = AssignTicketPhoneHelper.resolvePhone(
      rawPhone: '+56988777123',
      isoCode: 'CL',
    );

    expect(resolved.country.isoCode, 'CL');
    expect(resolved.nationalDigits, '988777123');
  });

  test('resolvePhone detects Chile dial code without iso hint', () {
    final resolved = AssignTicketPhoneHelper.resolvePhone(
      rawPhone: '56988777123',
    );

    expect(resolved.country.isoCode, 'CL');
    expect(resolved.nationalDigits, '988777123');
  });
}
