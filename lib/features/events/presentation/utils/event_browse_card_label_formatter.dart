import 'package:youpass/features/events/domain/entities/event_entity.dart';

class EventBrowseCardLabelFormatter {
  EventBrowseCardLabelFormatter._();

  static String scheduleLabel(EventEntity event) {
    final date = event.dateLabel.trim();
    final time = event.timeLabel?.trim();
    if (time != null && time.isNotEmpty) {
      if (date.isEmpty) {
        return time;
      }
      return '$date · $time';
    }
    return date;
  }

  static String? descriptionText(EventEntity event) {
    final dateTime = event.dateTimeLabel.trim();
    final date = event.dateLabel.trim();
    if (dateTime.isEmpty || dateTime == date) {
      return null;
    }
    return dateTime;
  }
}
