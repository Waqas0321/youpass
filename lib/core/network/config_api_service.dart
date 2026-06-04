import 'package:youpass/core/models/country_code.dart';
import 'package:youpass/core/network/api_client.dart';
import 'package:youpass/core/network/api_endpoints.dart';
import 'package:youpass/core/network/api_response_parser.dart';
import 'package:youpass/core/network/models/config_country_model.dart';

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

    return ConfigCountryModel.listFromRawData(body['data'])
        .map((country) => country.toEntity())
        .toList();
  }
}
