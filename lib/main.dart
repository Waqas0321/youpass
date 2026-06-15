import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_constants.dart';
import 'package:youpass/core/utils/app_logger.dart';
import 'package:youpass/core/utils/webview_platform_init.dart';
import 'package:youpass/dependency_injection/injection_container.dart';
import 'package:youpass/youpass_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ensureWebViewPlatformInitialized();
  AppLogger.info('Starting ${AppConstants.appName}');
  await initDependencies();
  AppLogger.info('Dependencies initialized');
  runApp(YouPassApp());
}
