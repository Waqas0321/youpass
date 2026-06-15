import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class HomeSearchHistoryCache {
  HomeSearchHistoryCache({required SharedPreferences preferences})
      : _preferences = preferences;

  static const String storageKey = 'home_search_history_v1';
  static const int defaultLimit = 10;

  final SharedPreferences _preferences;

  List<String> read({int limit = defaultLimit}) {
    final raw = _preferences.getString(storageKey);
    if (raw == null || raw.isEmpty) {
      return const [];
    }

    try {
      final decoded = jsonDecode(raw);
      if (decoded is! List) {
        return const [];
      }

      return decoded
          .whereType<String>()
          .map((item) => item.trim())
          .where((item) => item.isNotEmpty)
          .take(limit)
          .toList();
    } catch (_) {
      return const [];
    }
  }

  Future<void> addTerm(String term, {int limit = defaultLimit}) async {
    final normalized = term.trim();
    if (normalized.isEmpty) {
      return;
    }

    final current = read(limit: limit * 2);
    final next = [
      normalized,
      ...current.where((item) => item.toLowerCase() != normalized.toLowerCase()),
    ].take(limit).toList();

    await _preferences.setString(storageKey, jsonEncode(next));
  }

  Future<void> clear() async {
    await _preferences.remove(storageKey);
  }
}
