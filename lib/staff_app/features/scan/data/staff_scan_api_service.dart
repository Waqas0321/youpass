import 'package:youpass/staff_app/core/network/base_api_service.dart';
import 'package:youpass/staff_app/core/network/staff_api_endpoints.dart';
import 'package:youpass/staff_app/features/home/domain/models/staff_scan_entry.dart';
import 'package:youpass/staff_app/features/scan/domain/models/staff_qr_scan_result.dart';
import 'package:youpass/staff_app/features/scan/routes/staff_qr_scan_route_args.dart';

class StaffScanApiService extends BaseApiService {
  StaffScanApiService(super.apiClient);

  Future<StaffQrScanResult> scanEntry({required String qrPayload}) {
    return _scan(
      endpoint: StaffApiEndpoints.scanEntry,
      qrPayload: qrPayload,
      purpose: StaffQrScanPurpose.entry,
    );
  }

  Future<StaffQrScanResult> scanProduct({required String qrPayload}) {
    return _scan(
      endpoint: StaffApiEndpoints.scanProduct,
      qrPayload: qrPayload,
      purpose: StaffQrScanPurpose.product,
    );
  }

  Future<StaffRecentScansResponse> fetchRecentEntryScans({int limit = 10}) {
    return getModel(
      '${StaffApiEndpoints.scanRecent}?scan_type=entry&limit=$limit',
      authenticated: true,
      fromJson: StaffRecentScansResponse.fromJson,
    );
  }

  Future<StaffRecentScansResponse> fetchRecentProductScans({int limit = 10}) {
    return getModel(
      '${StaffApiEndpoints.scanRecent}?scan_type=product&limit=$limit',
      authenticated: true,
      fromJson: StaffRecentScansResponse.fromJson,
    );
  }

  Future<StaffQrScanResult> _scan({
    required String endpoint,
    required String qrPayload,
    required StaffQrScanPurpose purpose,
  }) {
    return postModel(
      endpoint,
      body: {'qr_payload': qrPayload},
      authenticated: true,
      fromJson: (json) => StaffQrScanResult.fromApiJson(
        json,
        purpose: purpose,
        qrPayload: qrPayload,
      ),
    );
  }
}
