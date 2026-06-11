import 'dart:io';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:youpass/core/security/device_id_service.dart';

typedef PackageInfoLoader = Future<PackageInfo> Function();

/// Builds standard client headers for every API request.
class ClientRequestHeaders {
  ClientRequestHeaders({
    required DeviceIdService deviceIdService,
    PackageInfoLoader? packageInfoLoader,
  })  : _deviceIdService = deviceIdService,
        _packageInfoLoader =
            packageInfoLoader ?? PackageInfo.fromPlatform;

  final DeviceIdService _deviceIdService;
  final PackageInfoLoader _packageInfoLoader;
  PackageInfo? _packageInfo;

  Future<Map<String, String>> build() async {
    final deviceId = await _deviceIdService.getId();
    _packageInfo ??= await _packageInfoLoader();

    return {
      'X-Device-Id': deviceId,
      'X-Platform': Platform.isIOS
          ? 'ios'
          : Platform.isAndroid
              ? 'android'
              : 'other',
      'X-App-Version': _packageInfo!.version,
    };
  }
}
