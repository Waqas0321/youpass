import 'package:flutter/foundation.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

/// Registers the native WebView implementation before any [WebViewController] is created.
void ensureWebViewPlatformInitialized() {
  if (WebViewPlatform.instance != null) {
    return;
  }

  switch (defaultTargetPlatform) {
    case TargetPlatform.android:
      WebViewPlatform.instance = AndroidWebViewPlatform();
    case TargetPlatform.iOS:
    case TargetPlatform.macOS:
      WebViewPlatform.instance = WebKitWebViewPlatform();
    case TargetPlatform.linux:
    case TargetPlatform.windows:
    case TargetPlatform.fuchsia:
      break;
  }
}

bool get isWebViewPlatformSupported => WebViewPlatform.instance != null;
