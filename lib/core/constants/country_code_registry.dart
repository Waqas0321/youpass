import 'package:youpass/core/constants/country_codes_data.dart';
import 'package:youpass/core/models/country_code.dart';
import 'package:youpass/core/network/config_api_service.dart';
import 'package:youpass/core/config/app_product_config.dart';
import 'package:youpass/core/security/app_security_config.dart';
import 'package:youpass/core/utils/app_logger.dart';

/// Supported countries from API with static fallback.
class CountryCodeRegistry {
  CountryCodeRegistry._();

  static List<CountryCode> _countries = fallbackCountries;
  static String _defaultCountryCode = 'CL';

  static List<CountryCode> get countries => _countries;

  static String get defaultCountryCode => _defaultCountryCode;

  static CountryCode get defaultCountry {
    return findByIsoCode(_defaultCountryCode);
  }

  static Future<void> loadFromApi(ConfigApiService configApiService) async {
    try {
      final productConfig = await configApiService.fetchAuthProductConfig();
      AppProductConfig.apply(productConfig);

      final appConfig = await configApiService.fetchAppConfig();
      if (appConfig != null) {
        final security = appConfig.security ??
            await configApiService.fetchSecurityConfig();
        AppSecurityConfig.apply(security);
        if (appConfig.countries.isNotEmpty) {
          _applyCountries(
            appConfig.countries,
            defaultCountryCode: appConfig.defaultCountryCode,
          );
          AppLogger.info(
            'Loaded ${_countries.length} countries from /config',
            tag: 'Config',
          );
          return;
        }
      }

      final apiCountries = await configApiService.fetchSupportedCountries();
      if (apiCountries.isEmpty) {
        AppLogger.warning(
          'No countries from API; using static list',
          tag: 'Config',
        );
        return;
      }

      _applyCountries(apiCountries);
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

  static void _applyCountries(
    List<CountryCode> list, {
    String? defaultCountryCode,
  }) {
    _countries = _sortWithDefaultFirst(list, defaultCountryCode ?? 'CL');
    _defaultCountryCode = defaultCountryCode ?? _countries.first.isoCode;
  }

  static List<CountryCode> _sortWithDefaultFirst(
    List<CountryCode> list,
    String preferredIso,
  ) {
    final sorted = List<CountryCode>.from(list);
    sorted.sort((a, b) => a.name.compareTo(b.name));

    final preferredIndex =
        sorted.indexWhere((country) => country.isoCode == preferredIso);
    if (preferredIndex > 0) {
      final preferred = sorted.removeAt(preferredIndex);
      sorted.insert(0, preferred);
    }

    return sorted;
  }

  static CountryCode findByIsoCode(String isoCode) {
    final normalized = isoCode.toUpperCase();
    for (final country in _countries) {
      if (country.isoCode == normalized) {
        return country;
      }
    }
    for (final country in CountryCodesData.all) {
      if (country.isoCode == normalized) {
        return country;
      }
    }
    return defaultCountry;
  }

  static CountryCode? findByCurrency(String currencyCode) {
    final normalized = currencyCode.toUpperCase();
    for (final country in _countries) {
      if (country.defaultCurrency == normalized) {
        return country;
      }
    }
    for (final country in CountryCodesData.all) {
      if (country.defaultCurrency == normalized) {
        return country;
      }
    }
    return null;
  }

  static List<CountryCode> search(String query) {
    final normalized = query.trim().toLowerCase();
    final pool = _countries.length > 1 ? _countries : fallbackCountries;
    if (normalized.isEmpty) {
      return pool;
    }

    return pool.where((country) {
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
    defaultLanguage: 'es',
    defaultCurrency: 'CLP',
    timezone: 'America/Santiago',
    paymentGateway: 'kushki',
    currencyDecimals: 0,
    currencySymbol: r'$',
  );

  static List<CountryCode> get fallbackCountries => [
        _defaultCountry,
        ...CountryCodesData.all.where(
          (country) => country.isoCode != _defaultCountry.isoCode,
        ),
      ];
}
