import 'package:youpass/core/models/country_code.dart';
import 'package:youpass/core/network/api_client.dart';
import 'package:youpass/core/network/api_endpoints.dart';
import 'package:youpass/core/network/api_response_parser.dart';

class ConfigApiService {
  ConfigApiService(this.apiClient);

  final ApiClient apiClient;

  Future<List<CountryCode>> fetchSupportedCountries() async {
    final response = await apiClient.get(ApiEndpoints.configCountries);
    final body = ApiResponseParser.decodeBody(response);

    if (response.statusCode < 200 ||
        response.statusCode >= 300 ||
        body['success'] != true) {
      return [];
    }

    final data = body['data'];
    if (data is! List) {
      return [];
    }

    final countries = <CountryCode>[];
    for (final item in data) {
      if (item is Map<String, dynamic>) {
        final country = _mapCountry(item);
        if (country != null) {
          countries.add(country);
        }
      }
    }

    return countries;
  }

  CountryCode? _mapCountry(Map<String, dynamic> json) {
    final isoCode = json['code'] as String?;
    final name = json['name'] as String?;
    final dialCodeRaw = json['dialCode'] as String?;
    if (isoCode == null || name == null || dialCodeRaw == null) {
      return null;
    }

    final dialCode = dialCodeRaw.replaceAll(RegExp(r'\D'), '');
    if (dialCode.isEmpty) {
      return null;
    }

    return CountryCode(
      name: name,
      isoCode: isoCode,
      dialCode: dialCode,
      flagEmoji: json['flagEmoji'] as String? ?? '',
      phoneHint: _phoneHintForIso(isoCode),
    );
  }

  String _phoneHintForIso(String isoCode) {
    switch (isoCode) {
      case 'CL':
        return '9 1234 5678';
      case 'PK':
        return '321 6548001';
      default:
        return '';
    }
  }
}
