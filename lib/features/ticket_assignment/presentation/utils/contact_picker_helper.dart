import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:youpass/features/ticket_assignment/presentation/utils/contact_pick_result.dart';

class ContactPickerHelper {
  static Future<ContactPickResult?> pickContact() async {
    final granted = await FlutterContacts.requestPermission(readonly: true);
    if (!granted) {
      return null;
    }

    final contact = await FlutterContacts.openExternalPick();
    if (contact == null) {
      return null;
    }

    final phone = contact.phones.isNotEmpty ? contact.phones.first.number : '';
    if (phone.trim().isEmpty) {
      return null;
    }

    return ContactPickResult(
      displayName: contact.displayName.trim().isEmpty
          ? phone
          : contact.displayName.trim(),
      phone: phone.trim(),
    );
  }
}
