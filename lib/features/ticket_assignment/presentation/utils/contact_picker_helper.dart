import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:youpass/features/ticket_assignment/presentation/utils/contact_pick_result.dart';

class ContactPickerHelper {
  static Future<ContactPickResult?> pickContact() async {
    final status = await FlutterContacts.permissions.request(PermissionType.read);
    if (status != PermissionStatus.granted &&
        status != PermissionStatus.limited) {
      return null;
    }

    final contact = await FlutterContacts.native.showPicker(
      properties: {ContactProperty.phone},
    );
    if (contact == null) {
      return null;
    }

    final phone = contact.phones.isNotEmpty ? contact.phones.first.number : '';
    if (phone.trim().isEmpty) {
      return null;
    }

    final displayName = (contact.displayName ?? '').trim();
    return ContactPickResult(
      displayName: displayName.isEmpty ? phone : displayName,
      phone: phone.trim(),
    );
  }
}
