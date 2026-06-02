import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/core/auth/jwt_utils.dart';

void main() {
  test('isExpired returns true when exp is in the past', () {
    final expiredToken = _buildJwt(exp: 1_600_000_000);

    expect(
      JwtUtils.isExpired(
        expiredToken,
        now: DateTime.fromMillisecondsSinceEpoch(1_700_000_000_000),
      ),
      isTrue,
    );
  });

  test('isExpired returns false when exp is in the future', () {
    final validToken = _buildJwt(exp: 4_000_000_000);

    expect(
      JwtUtils.isExpired(
        validToken,
        now: DateTime.fromMillisecondsSinceEpoch(1_700_000_000_000),
      ),
      isFalse,
    );
  });
}

String _buildJwt({required int exp}) {
  final header = base64Url.encode(utf8.encode('{"alg":"HS256"}'));
  final payload = base64Url.encode(utf8.encode('{"exp":$exp}'));
  return '$header.$payload.signature';
}
