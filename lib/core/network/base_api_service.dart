import 'package:http/http.dart' as http;
import 'package:youpass/core/network/api_client.dart';
import 'package:youpass/core/network/api_response_parser.dart';

abstract class BaseApiService {
  BaseApiService(this.apiClient);

  final ApiClient apiClient;

  Future<Map<String, dynamic>> getData(
    String endpoint, {
    bool authenticated = false,
    String? accessTokenOverride,
  }) async {
    final response = await apiClient.get(
      endpoint,
      authenticated: authenticated,
      accessTokenOverride: accessTokenOverride,
    );
    return ApiResponseParser.parseData(response);
  }

  Future<Object?> getRawData(
    String endpoint, {
    bool authenticated = false,
    String? accessTokenOverride,
  }) async {
    final response = await apiClient.get(
      endpoint,
      authenticated: authenticated,
      accessTokenOverride: accessTokenOverride,
    );
    return ApiResponseParser.parseRawData(response);
  }

  Future<Map<String, dynamic>> postData(
    String endpoint, {
    Object? body,
    bool authenticated = false,
    String? accessTokenOverride,
  }) async {
    final response = await apiClient.post(
      endpoint,
      body: body,
      authenticated: authenticated,
      accessTokenOverride: accessTokenOverride,
    );
    return ApiResponseParser.parseData(response);
  }

  Future<void> postVoid(
    String endpoint, {
    Object? body,
    bool authenticated = false,
    String? accessTokenOverride,
  }) async {
    final response = await apiClient.post(
      endpoint,
      body: body,
      authenticated: authenticated,
      accessTokenOverride: accessTokenOverride,
    );
    ApiResponseParser.parseSuccess(response);
  }

  Future<void> deleteVoid(
    String endpoint, {
    bool authenticated = false,
    String? accessTokenOverride,
  }) async {
    final response = await apiClient.delete(
      endpoint,
      authenticated: authenticated,
      accessTokenOverride: accessTokenOverride,
    );
    ApiResponseParser.parseSuccess(response);
  }

  Future<Map<String, dynamic>> deleteData(
    String endpoint, {
    bool authenticated = false,
    String? accessTokenOverride,
  }) async {
    final response = await apiClient.delete(
      endpoint,
      authenticated: authenticated,
      accessTokenOverride: accessTokenOverride,
    );
    return ApiResponseParser.parseData(response);
  }

  Future<Map<String, dynamic>> postMultipartData(
    String endpoint, {
    required List<http.MultipartFile> files,
    Map<String, String>? fields,
    bool authenticated = false,
    String? accessTokenOverride,
  }) async {
    final response = await apiClient.postMultipart(
      endpoint,
      files: files,
      fields: fields,
      authenticated: authenticated,
      accessTokenOverride: accessTokenOverride,
    );
    return ApiResponseParser.parseData(response);
  }

  Future<T> getModel<T>(
    String endpoint, {
    required T Function(Map<String, dynamic> json) fromJson,
    bool authenticated = false,
    String? accessTokenOverride,
  }) async {
    final data = await getData(
      endpoint,
      authenticated: authenticated,
      accessTokenOverride: accessTokenOverride,
    );
    return fromJson(data);
  }

  Future<T> getRawModel<T>(
    String endpoint, {
    required T Function(Object? data) fromRawData,
    bool authenticated = false,
    String? accessTokenOverride,
  }) async {
    final data = await getRawData(
      endpoint,
      authenticated: authenticated,
      accessTokenOverride: accessTokenOverride,
    );
    return fromRawData(data);
  }

  Future<T> postModel<T>(
    String endpoint, {
    required T Function(Map<String, dynamic> json) fromJson,
    Object? body,
    bool authenticated = false,
    String? accessTokenOverride,
  }) async {
    final data = await postData(
      endpoint,
      body: body,
      authenticated: authenticated,
      accessTokenOverride: accessTokenOverride,
    );
    return fromJson(data);
  }
}
