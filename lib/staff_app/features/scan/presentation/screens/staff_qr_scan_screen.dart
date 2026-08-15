import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/staff_app/core/l10n/staff_scan_message_localizer.dart';
import 'package:youpass/staff_app/core/network/api_client.dart';
import 'package:youpass/staff_app/core/network/api_exception.dart';
import 'package:youpass/staff_app/core/widgets/app_snack_bar.dart';
import 'package:youpass/staff_app/features/scan/data/staff_scan_api_service.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';
import 'package:youpass/staff_app/features/home/presentation/widgets/staff_qr_viewfinder_icon.dart';
import 'package:youpass/staff_app/features/scan/domain/models/staff_qr_scan_result.dart';
import 'package:youpass/staff_app/features/scan/presentation/widgets/staff_scan_screen_header.dart';
import 'package:youpass/staff_app/features/scan/presentation/widgets/staff_scan_viewfinder_overlay.dart';
import 'package:youpass/staff_app/features/scan/routes/staff_qr_scan_route_args.dart';
import 'package:youpass/staff_app/features/scan/routes/staff_qr_scan_result_route_args.dart';
import 'package:youpass/staff_app/routes/app_routes.dart';

class StaffQrScanScreen extends StatefulWidget {
  const StaffQrScanScreen({
    super.key,
    this.purpose = StaffQrScanPurpose.product,
  });

  final StaffQrScanPurpose purpose;

  @override
  State<StaffQrScanScreen> createState() => _StaffQrScanScreenState();
}

class _StaffQrScanScreenState extends State<StaffQrScanScreen> {
  final MobileScannerController _controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    facing: CameraFacing.back,
  );
  final StaffScanApiService _scanApiService = StaffScanApiService(ApiClient());

  bool _isProcessingScan = false;
  bool _torchEnabled = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _toggleFlash() async {
    await _controller.toggleTorch();
    if (mounted) {
      setState(() => _torchEnabled = !_torchEnabled);
    }
  }

  Future<void> _handleBarcode(BarcodeCapture capture) async {
    if (_isProcessingScan) {
      return;
    }

    final value = capture.barcodes
        .map((barcode) => barcode.rawValue)
        .whereType<String>()
        .map((code) => code.trim())
        .firstWhere((code) => code.isNotEmpty, orElse: () => '');

    if (value.isEmpty) {
      return;
    }

    setState(() => _isProcessingScan = true);
    await _controller.stop();

    if (!mounted) {
      return;
    }

    StaffQrScanResult result;
    try {
      result = widget.purpose == StaffQrScanPurpose.entry
          ? await _scanApiService.scanEntry(qrPayload: value)
          : await _scanApiService.scanProduct(qrPayload: value);
    } catch (error) {
      if (!mounted) {
        return;
      }

      AppSnackBar.show(
        context,
        StaffScanMessageLocalizer.fromError(context.l10n, error),
      );

      if (error is ApiException &&
          (error.code == 'UNAUTHORIZED' || error.code == 'SESSION_INVALID')) {
        Navigator.of(context).pop();
        return;
      }

      await _controller.start();
      if (mounted) {
        setState(() => _isProcessingScan = false);
      }
      return;
    }

    if (!mounted) {
      return;
    }

    final delivered = await Navigator.of(context).pushNamed<bool>(
      StaffAppRoutes.qrScanResult,
      arguments: StaffQrScanResultRouteArgs(result: result),
    );

    if (!mounted) {
      return;
    }

    if (delivered == true) {
      Navigator.of(context).pop();
      return;
    }

    await _controller.start();
    if (mounted) {
      setState(() => _isProcessingScan = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final layout = ResponsiveLayout(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            const StaffScanScreenHeader(),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final metrics = StaffScanLayoutMetrics(
                    viewportSize: constraints.biggest,
                    screenWidth: layout.width,
                  );
                  final window = metrics.windowRect;

                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      MobileScanner(
                        controller: _controller,
                        onDetect: _handleBarcode,
                        errorBuilder: (context, error) {
                          return _CameraFallback(layout: layout);
                        },
                      ),
                      StaffScanViewfinderOverlay(metrics: metrics),
                      Positioned(
                        top: metrics.flashTop,
                        left: 0,
                        right: 0,
                        child: _FlashControl(
                          layout: layout,
                          enabled: _torchEnabled,
                          label: l10n.staffScanFlashLabel,
                          onTap: _toggleFlash,
                        ),
                      ),
                      Positioned(
                        left: window.left,
                        top: window.top + layout.spacing(28),
                        width: window.width,
                        child: Text(
                          l10n.staffScanQrAreaLabel,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          softWrap: false,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: layout.fontSize(13),
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.6,
                            height: 1,
                          ),
                        ),
                      ),
                      Positioned(
                        top: metrics.bottomContentTop,
                        left: layout.spacing(32),
                        right: layout.spacing(32),
                        child: Column(
                          children: [
                            StaffQrViewfinderIcon(
                              size: layout.spacing(32),
                              color: staffScanAccent,
                            ),
                            SizedBox(height: layout.spacing(14)),
                            AppText(
                              l10n.staffScanQrInstruction,
                              variant: AppTextVariant.body,
                              textAlign: TextAlign.center,
                              color: Colors.white,
                              fontSize: layout.fontSize(15),
                              fontWeight: FontWeight.w500,
                              height: 1.4,
                            ),
                          ],
                        ),
                      ),
                      if (_isProcessingScan)
                        Container(
                          color: Colors.black.withValues(alpha: 0.45),
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FlashControl extends StatelessWidget {
  const _FlashControl({
    required this.layout,
    required this.enabled,
    required this.label,
    required this.onTap,
  });

  final ResponsiveLayout layout;
  final bool enabled;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            enabled ? Icons.flash_on_rounded : Icons.flash_on_outlined,
            color: staffScanAccent,
            size: layout.spacing(24),
          ),
          SizedBox(height: layout.spacing(4)),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: layout.fontSize(11),
              fontWeight: FontWeight.w500,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _CameraFallback extends StatelessWidget {
  const _CameraFallback({required this.layout});

  final ResponsiveLayout layout;

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF1C1C1C),
            Color(0xFF080808),
          ],
        ),
      ),
    );
  }
}
