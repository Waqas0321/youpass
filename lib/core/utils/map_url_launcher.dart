import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

class MapUrlLauncher {
  MapUrlLauncher._();

  static Future<bool> openDirections({
    required String addressLabel,
    double? latitude,
    double? longitude,
  }) async {
    final uri = _buildDirectionsUri(
      addressLabel: addressLabel,
      latitude: latitude,
      longitude: longitude,
    );
    if (uri == null) {
      return false;
    }

    return launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  static Uri? _buildDirectionsUri({
    required String addressLabel,
    double? latitude,
    double? longitude,
  }) {
    if (latitude != null && longitude != null) {
      if (Platform.isIOS) {
        return Uri.parse(
          'http://maps.apple.com/?daddr=$latitude,$longitude&dirflg=d',
        );
      }
      return Uri.parse(
        'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude&travelmode=driving',
      );
    }

    final trimmed = addressLabel.trim();
    if (trimmed.isEmpty) {
      return null;
    }

    final encoded = Uri.encodeComponent(trimmed);
    if (Platform.isIOS) {
      return Uri.parse('http://maps.apple.com/?daddr=$encoded&dirflg=d');
    }
    return Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=$encoded&travelmode=driving',
    );
  }
}
