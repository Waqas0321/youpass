import 'package:flutter/foundation.dart';
import 'package:screen_protector/screen_protector.dart';
import 'package:youpass/core/utils/app_logger.dart';

class ScreenSecureService {
  int _refCount = 0;

  Future<void> enable() async {
    _refCount += 1;
    if (_refCount > 1) {
      return;
    }

    try {
      await ScreenProtector.preventScreenshotOn();
      await ScreenProtector.protectDataLeakageOn();
    } catch (error, stackTrace) {
      AppLogger.error(
        'Failed to enable screen protection',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> disable() async {
    if (_refCount == 0) {
      return;
    }

    _refCount -= 1;
    if (_refCount > 0) {
      return;
    }

    try {
      await ScreenProtector.preventScreenshotOff();
      await ScreenProtector.protectDataLeakageOff();
    } catch (error, stackTrace) {
      if (kDebugMode) {
        AppLogger.error(
          'Failed to disable screen protection',
          error: error,
          stackTrace: stackTrace,
        );
      }
    }
  }
}
