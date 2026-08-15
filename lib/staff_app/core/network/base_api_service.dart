import 'api_client.dart';
import 'api_response_parser.dart';

abstract class BaseApiService {
  BaseApiService(this.apiClient);

  final ApiClient apiClient;

  Future<Map<String, dynamic>> postData(
    String endpoint, {
    Object? body,
    bool authenticated = false,
  }) async {
    final response = await apiClient.post(
      endpoint,
      body: body,
      authenticated: authenticated,
    );
    return ApiResponseParser.parseData(response);
  }

  Future<void> postVoid(
    String endpoint, {
    Object? body,
    bool authenticated = false,
  }) async {
    final response = await apiClient.post(
      endpoint,
      body: body,
      authenticated: authenticated,
    );
    ApiResponseParser.parseSuccess(response);
  }

  Future<Map<String, dynamic>> getData(
    String endpoint, {
    bool authenticated = false,
  }) async {
    final response = await apiClient.get(
      endpoint,
      authenticated: authenticated,
    );
    return ApiResponseParser.parseData(response);
  }

  Future<T> postModel<T>(
    String endpoint, {
    required T Function(Map<String, dynamic> json) fromJson,
    Object? body,
    bool authenticated = false,
  }) async {
    final data = await postData(
      endpoint,
      body: body,
      authenticated: authenticated,
    );
    return fromJson(data);
  }

  Future<T> getModel<T>(
    String endpoint, {
    required T Function(Map<String, dynamic> json) fromJson,
    bool authenticated = false,
  }) async {
    final data = await getData(
      endpoint,
      authenticated: authenticated,
    );
    return fromJson(data);
  }
}
