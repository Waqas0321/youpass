import 'package:flutter/material.dart';
import 'package:youpass/core/utils/app_logger.dart';

class AppSnackBar {
  AppSnackBar._();

  static void show(BuildContext context, String message) {
    AppLogger.debug('SnackBar: $message', tag: 'UI');
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
