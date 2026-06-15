import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class UserLocationResult {
  const UserLocationResult({
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;
}

class UserLocationException implements Exception {
  const UserLocationException(this.message);

  final String message;

  @override
  String toString() => message;
}

class UserLocationService {
  Future<bool> isServiceEnabled() => Geolocator.isLocationServiceEnabled();

  Future<PermissionStatus> requestPermission() async {
    return Permission.locationWhenInUse.request();
  }

  Future<UserLocationResult> getCurrentPosition() async {
    final serviceEnabled = await isServiceEnabled();
    if (!serviceEnabled) {
      throw const UserLocationException('Location services are disabled.');
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      throw const UserLocationException('Location permission denied.');
    }

    if (permission == LocationPermission.deniedForever) {
      throw const UserLocationException('Location permission permanently denied.');
    }

    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.medium,
        timeLimit: Duration(seconds: 15),
      ),
    );

    return UserLocationResult(
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }
}
