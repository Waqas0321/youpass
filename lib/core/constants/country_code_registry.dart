import 'package:youpass/core/constants/country_codes_data.dart';
import 'package:youpass/core/models/country_code.dart';
import 'package:youpass/core/network/config_api_service.dart';
import 'package:youpass/core/utils/app_logger.dart';

/// Supported countries from API with static fallback.
class CountryCodeRegistry {
  CountryCodeRegistry._();

  static List<CountryCode> _countries = fallbackCountries;

  static List<CountryCode> get countries => _countries;

  static CountryCode get defaultCountry {
    final chile = _countries.where((c) => c.isoCode == 'CL').firstOrNull;
    return chile ?? fallbackCountries.first;
  }

  static Future<void> loadFromApi(ConfigApiService configApiService) async {
    try {
      final apiCountries = await configApiService.fetchSupportedCountries();
      if (apiCountries.isEmpty) {
        AppLogger.warning(
          'No countries from API; using static list',
          tag: 'Config',
        );
        return;
      }

      _countries = _sortWithChileFirst(apiCountries);
      AppLogger.info(
        'Loaded ${_countries.length} supported countries from API',
        tag: 'Config',
      );
    } catch (error, stackTrace) {
      AppLogger.error(
        'Failed to load countries from API; using static list',
        tag: 'Config',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  static List<CountryCode> _sortWithChileFirst(List<CountryCode> list) {
    final sorted = List<CountryCode>.from(list);
    sorted.sort((a, b) => a.name.compareTo(b.name));

    final chileIndex = sorted.indexWhere((c) => c.isoCode == 'CL');
    if (chileIndex > 0) {
      final chile = sorted.removeAt(chileIndex);
      sorted.insert(0, chile);
    }

    return sorted;
  }

  static CountryCode findByIsoCode(String isoCode) {
    return _countries.firstWhere(
      (country) => country.isoCode == isoCode,
      orElse: () => defaultCountry,
    );
  }

  static List<CountryCode> search(String query) {
    final normalized = query.trim().toLowerCase();
    if (normalized.isEmpty) {
      return _countries;
    }

    return _countries.where((country) {
      return country.name.toLowerCase().contains(normalized) ||
          country.isoCode.toLowerCase().contains(normalized) ||
          country.dialCode.contains(normalized) ||
          country.displayDialCode.contains(normalized);
    }).toList();
  }

  static const CountryCode _defaultCountry = CountryCode(
    name: 'Chile',
    isoCode: 'CL',
    dialCode: '56',
    flagEmoji: '🇨🇱',
    phoneHint: '9 1234 5678',
  );

  /// Full static list when API is unavailable (dev / offline).
  static List<CountryCode> get fallbackCountries => [
        _defaultCountry,
        ...CountryCodesData.all.where(
          (country) => country.isoCode != _defaultCountry.isoCode,
        ),
      ];
}

extension _FirstOrNull<E> on Iterable<E> {
  E? get firstOrNull {
    final iterator = this.iterator;
    if (!iterator.moveNext()) {
      return null;
    }
    return iterator.current;
  }
}
