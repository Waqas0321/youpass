import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/staff_app/features/scan/data/staff_offline_scan_queue.dart';

/// Cross-check Flutter HMAC against known backend vectors (Node crypto).
void main() {
  group('M10 offline HMAC alignment', () {
    const secret = 'test-offline-signing-secret-32chars!!';
    const clientScanId = '11111111-2222-3333-4444-555555555555';
    const scanType = 'entry';
    const qrPayload = 'YP-ENTRY-TEST-001';
    const scannedAtIso = '2026-09-23T20:00:00.000Z';
    const deviceId = 'device-e2e-abc12345';

    test('canonical format matches backend v1|… join', () {
      final canonical = [
        'v1',
        clientScanId,
        scanType,
        qrPayload,
        scannedAtIso,
        deviceId,
      ].join('|');
      expect(
        canonical,
        'v1|$clientScanId|$scanType|$qrPayload|$scannedAtIso|$deviceId',
      );
    });

    test('signOfflineScan produces stable hex digest', () {
      final a = signOfflineScan(
        signingSecret: secret,
        clientScanId: clientScanId,
        scanType: scanType,
        qrPayload: qrPayload,
        scannedAtIso: scannedAtIso,
        deviceId: deviceId,
      );
      final b = signOfflineScan(
        signingSecret: secret,
        clientScanId: clientScanId,
        scanType: scanType,
        qrPayload: qrPayload,
        scannedAtIso: scannedAtIso,
        deviceId: deviceId,
      );
      expect(a, b);
      expect(a.length, 64);
      expect(RegExp(r'^[0-9a-f]{64}$').hasMatch(a), isTrue);
    });

    test('matches Node-compatible HMAC digest', () {
      final canonical =
          'v1|$clientScanId|$scanType|$qrPayload|$scannedAtIso|$deviceId';
      final nodeStyle = Hmac(sha256, utf8.encode(secret))
          .convert(utf8.encode(canonical))
          .toString();
      final app = signOfflineScan(
        signingSecret: secret,
        clientScanId: clientScanId,
        scanType: scanType,
        qrPayload: qrPayload,
        scannedAtIso: scannedAtIso,
        deviceId: deviceId,
      );
      expect(app, nodeStyle);
    });

    test('toSyncJson omits device_id (batch root only)', () {
      final item = StaffOfflineScanItem(
        clientScanId: clientScanId,
        scanType: scanType,
        qrPayload: qrPayload,
        scannedAtIso: scannedAtIso,
        deviceId: deviceId,
        hmac: 'abc',
      );
      expect(item.toSyncJson().containsKey('device_id'), isFalse);
      expect(item.toSyncJson()['scanned_at'], scannedAtIso);
      expect(item.toJson()['device_id'], deviceId);
    });

    test('tampered payload changes HMAC', () {
      final good = signOfflineScan(
        signingSecret: secret,
        clientScanId: clientScanId,
        scanType: scanType,
        qrPayload: qrPayload,
        scannedAtIso: scannedAtIso,
        deviceId: deviceId,
      );
      final bad = signOfflineScan(
        signingSecret: secret,
        clientScanId: clientScanId,
        scanType: scanType,
        qrPayload: '$qrPayload-TAMPERED',
        scannedAtIso: scannedAtIso,
        deviceId: deviceId,
      );
      expect(good, isNot(equals(bad)));
    });
  });
}
