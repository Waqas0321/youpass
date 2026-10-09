import 'package:flutter/material.dart';
import 'package:image_picker_android/image_picker_android.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:youpass/core/constants/app_constants.dart';
import 'package:youpass/core/utils/app_logger.dart';
import 'package:youpass/core/utils/webview_platform_init.dart';
import 'package:youpass/dependency_injection/injection_container.dart';
import 'package:youpass/youpass_app.dart';

void _enableAndroidPhotoPicker() {
  final implementation = ImagePickerPlatform.instance;
  if (implementation is ImagePickerAndroid) {
    // One-time profile photo selection — use system Photo Picker so we do not
    // need READ_MEDIA_IMAGES (Google Play Photo and Video Permissions policy).
    implementation.useAndroidPhotoPicker = true;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _enableAndroidPhotoPicker();
  ensureWebViewPlatformInitialized();
  AppLogger.info('Starting ${AppConstants.appName}');
  AppLogger.info('API: ${AppConstants.apiBaseUrl}', tag: 'API');
  await initDependencies();
  AppLogger.info('Dependencies initialized');
  runApp(YouPassApp());
}
