import 'dart:io';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:youpass/core/security/device_id_service.dart';

typedef PackageInfoLoader = Future<PackageInfo> Function();
typedef LanguageCodeLoader = String? Function();

/// Builds standard client headers for every API request.
class ClientRequestHeaders {
  ClientRequestHeaders({
    required DeviceIdService deviceIdService,
    PackageInfoLoader? packageInfoLoader,
    LanguageCodeLoader? languageCodeLoader,
  })  : _deviceIdService = deviceIdService,
        _packageInfoLoader =
            packageInfoLoader ?? PackageInfo.fromPlatform,
        _languageCodeLoader = languageCodeLoader;

  final DeviceIdService _deviceIdService;
  final PackageInfoLoader _packageInfoLoader;
  final LanguageCodeLoader? _languageCodeLoader;
  PackageInfo? _packageInfo;

  Future<Map<String, String>> build() async {
    final deviceId = await _deviceIdService.getId();
    _packageInfo ??= await _packageInfoLoader();
    final languageCode = _languageCodeLoader?.call()?.trim();

    return {
      // Lets the API format dates/messages in the app's UI language.
      if (languageCode != null && languageCode.isNotEmpty)
        'Accept-Language': languageCode,
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
