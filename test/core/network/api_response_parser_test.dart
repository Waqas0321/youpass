import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:youpass/core/network/api_exception.dart';
import 'package:youpass/core/network/api_response_parser.dart';

void main() {
  test('parseData returns data map on success envelope', () {
    final response = http.Response(
      '{"success":true,"data":{"verified":true}}',
      200,
    );

    final data = ApiResponseParser.parseData(response);

    expect(data['verified'], isTrue);
  });

  test('parseData throws ApiException on error envelope', () {
    final response = http.Response(
      '''
      {
        "success": false,
        "error": {
          "code": "RESEND_COOLDOWN",
          "message": "Wait",
          "details": { "retry_after_seconds": 51 }
        }
      }
      ''',
      429,
    );

    expect(
      () => ApiResponseParser.parseData(response),
      throwsA(
        isA<ApiException>()
            .having((e) => e.code, 'code', 'RESEND_COOLDOWN')
            .having((e) => e.retryAfterSeconds, 'retry', 51),
      ),
    );
  });
}
