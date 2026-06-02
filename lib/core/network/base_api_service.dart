import 'package:youpass/core/network/api_client.dart';
import 'package:youpass/core/network/api_response_parser.dart';

abstract class BaseApiService {
  BaseApiService(this.apiClient);

  final ApiClient apiClient;

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
    await postData(
      endpoint,
      body: body,
      authenticated: authenticated,
    );
  }
}
