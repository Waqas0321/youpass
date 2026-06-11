import 'package:youpass/core/models/country_code.dart';
import 'package:youpass/core/network/api_client.dart';
import 'package:youpass/core/network/api_endpoints.dart';
import 'package:youpass/core/network/api_response_parser.dart';
import 'package:youpass/core/network/models/app_config_model.dart';
import 'package:youpass/core/network/models/config_category_model.dart';
import 'package:youpass/core/network/models/config_country_model.dart';
import 'package:youpass/core/config/auth_product_config_model.dart';
import 'package:youpass/core/security/security_config_model.dart';

class ConfigApiService {
  ConfigApiService(this.apiClient);

  final ApiClient apiClient;

  Future<AppConfigModel?> fetchAppConfig() async {
    final response = await apiClient.get(ApiEndpoints.config);
    final body = ApiResponseParser.decodeBody(response);

    if (response.statusCode < 200 ||
        response.statusCode >= 300 ||
        body['success'] != true) {
      return null;
    }

    final data = body['data'];
    if (data is! Map<String, dynamic>) {
      return null;
    }

    return AppConfigModel.fromJson(data);
  }

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

  Future<List<ConfigCategoryModel>> fetchCategories() async {
    final response = await apiClient.get(ApiEndpoints.configCategories);
    final body = ApiResponseParser.decodeBody(response);

    if (response.statusCode < 200 ||
        response.statusCode >= 300 ||
        body['success'] != true) {
      return [];
    }

    return ConfigCategoryModel.listFromRawData(body['data']);
  }

  Future<ProductConfigModel?> fetchAuthProductConfig() async {
    final response = await apiClient.get(ApiEndpoints.configAuth);
    final body = ApiResponseParser.decodeBody(response);

    if (response.statusCode < 200 ||
        response.statusCode >= 300 ||
        body['success'] != true) {
      return null;
    }

    final data = body['data'];
    if (data is! Map<String, dynamic>) {
      return null;
    }

    return ProductConfigModel.fromJson(data);
  }

  Future<SecurityConfigModel?> fetchSecurityConfig() async {
    final response = await apiClient.get(ApiEndpoints.configSecurity);
    final body = ApiResponseParser.decodeBody(response);

    if (response.statusCode < 200 ||
        response.statusCode >= 300 ||
        body['success'] != true) {
      return null;
    }

    final data = body['data'];
    if (data is! Map<String, dynamic>) {
      return null;
    }

    return SecurityConfigModel.fromJson(data);
  }
}
