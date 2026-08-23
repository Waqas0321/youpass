import 'package:shared_preferences/shared_preferences.dart';

/// Remembers which Party Mode event the user picked when several tickets
/// are live, so we don't ask again until that event is no longer eligible.
class PartyModeEventPreference {
  PartyModeEventPreference({required SharedPreferences preferences})
      : _preferences = preferences;

  static const String _eventIdKey = 'party_mode_selected_event_id';
  static const String _eventTitleKey = 'party_mode_selected_event_title';

  final SharedPreferences _preferences;

  String? get eventId {
    final value = _preferences.getString(_eventIdKey)?.trim();
    return value == null || value.isEmpty ? null : value;
  }

  String? get eventTitle {
    final value = _preferences.getString(_eventTitleKey)?.trim();
    return value == null || value.isEmpty ? null : value;
  }

  Future<void> remember({
    required String eventId,
    required String eventTitle,
  }) async {
    await _preferences.setString(_eventIdKey, eventId);
    await _preferences.setString(_eventTitleKey, eventTitle);
  }

  Future<void> clear() async {
    await _preferences.remove(_eventIdKey);
    await _preferences.remove(_eventTitleKey);
  }
}
