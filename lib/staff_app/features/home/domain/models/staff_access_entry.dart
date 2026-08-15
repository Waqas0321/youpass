import 'package:youpass/staff_app/features/home/domain/models/staff_scan_entry.dart';

class StaffAccessEntry {
  const StaffAccessEntry({
    required this.ticketLabel,
    required this.entryCode,
    required this.timeLabel,
    required this.status,
  });

  final String ticketLabel;
  final String entryCode;
  final String timeLabel;
  final StaffScanStatus status;
}

extension StaffScanEntryAccessMapping on StaffScanEntry {
  StaffAccessEntry toAccessEntry() {
    return StaffAccessEntry(
      ticketLabel: itemName,
      entryCode: transactionId ?? guestName,
      timeLabel: timeLabel,
      status: status,
    );
  }
}
