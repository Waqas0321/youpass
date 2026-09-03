import 'package:flutter/material.dart';
import 'package:youpass/staff_app/features/auth/presentation/screens/verification_screen.dart';
import 'package:youpass/staff_app/features/auth/routes/verification_route_args.dart';
import 'package:youpass/staff_app/features/home/presentation/screens/staff_recent_scans_list_screen.dart';
import 'package:youpass/staff_app/features/home/routes/staff_recent_scans_list_route_args.dart';
import 'package:youpass/staff_app/features/scan/presentation/screens/staff_manual_code_entry_screen.dart';
import 'package:youpass/staff_app/features/scan/presentation/screens/staff_qr_scan_result_screen.dart';
import 'package:youpass/staff_app/features/scan/presentation/screens/staff_qr_scan_screen.dart';
import 'package:youpass/staff_app/features/scan/routes/staff_qr_scan_result_route_args.dart';
import 'package:youpass/staff_app/features/scan/routes/staff_qr_scan_route_args.dart';
import 'package:youpass/staff_app/features/shell/presentation/screens/staff_shell_screen.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/screens/staff_supervisor_access_dashboard_screen.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/screens/staff_supervisor_action_history_screen.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/screens/staff_supervisor_bar_action_history_screen.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/screens/staff_supervisor_cancellations_screen.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/screens/staff_supervisor_dashboard_screen.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/screens/staff_supervisor_entry_history_screen.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/screens/staff_supervisor_entry_manual_validation_screen.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/screens/staff_supervisor_entry_qr_override_screen.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/screens/staff_supervisor_manual_validation_screen.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/screens/staff_supervisor_pin_screen.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/screens/staff_supervisor_qr_override_screen.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/screens/staff_supervisor_resolve_duplicate_screen.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/screens/staff_supervisor_search_entry_screen.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/screens/staff_supervisor_system_status_screen.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/screens/staff_supervisor_vip_management_screen.dart';
import 'package:youpass/staff_app/features/supervisor/routes/staff_supervisor_entry_history_route_args.dart';
import 'package:youpass/staff_app/features/supervisor/routes/staff_supervisor_entry_manual_validation_route_args.dart';
import 'package:youpass/staff_app/features/supervisor/routes/staff_supervisor_entry_qr_override_route_args.dart';
import 'package:youpass/staff_app/features/supervisor/routes/staff_supervisor_resolve_duplicate_route_args.dart';
import 'package:youpass/staff_app/routes/app_routes.dart';

abstract final class StaffRouteGenerator {
  static Route<dynamic>? maybeGenerate(RouteSettings settings) {
    final name = settings.name;
    if (name == null || !name.startsWith('/staff/')) {
      return null;
    }

    switch (name) {
      case StaffAppRoutes.verification:
        final args = settings.arguments;
        if (args is! VerificationRouteArgs) {
          return MaterialPageRoute(builder: (_) => const StaffShellScreen());
        }
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => VerificationScreen(args: args),
        );
      case StaffAppRoutes.home:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const StaffShellScreen(),
        );
      case StaffAppRoutes.qrScan:
        final scanArgs = settings.arguments;
        final purpose = scanArgs is StaffQrScanRouteArgs
            ? scanArgs.purpose
            : StaffQrScanPurpose.product;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => StaffQrScanScreen(purpose: purpose),
        );
      case StaffAppRoutes.manualCodeEntry:
        final manualArgs = settings.arguments;
        final purpose = manualArgs is StaffQrScanRouteArgs
            ? manualArgs.purpose
            : StaffQrScanPurpose.product;
        return MaterialPageRoute<bool?>(
          settings: settings,
          builder: (_) => StaffManualCodeEntryScreen(purpose: purpose),
        );
      case StaffAppRoutes.qrScanResult:
        final args = settings.arguments;
        if (args is! StaffQrScanResultRouteArgs) {
          return MaterialPageRoute<bool?>(
            builder: (_) => const StaffQrScanScreen(),
          );
        }
        return MaterialPageRoute<bool?>(
          settings: settings,
          builder: (_) => StaffQrScanResultScreen(result: args.result),
        );
      case StaffAppRoutes.recentScansList:
        final listArgs = settings.arguments;
        if (listArgs is! StaffRecentScansListRouteArgs) {
          return MaterialPageRoute(builder: (_) => const StaffShellScreen());
        }
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => StaffRecentScansListScreen(purpose: listArgs.purpose),
        );
      case StaffAppRoutes.supervisorPin:
        return MaterialPageRoute(
          builder: (_) => const StaffSupervisorPinScreen(),
        );
      case StaffAppRoutes.supervisorDashboard:
        return MaterialPageRoute(
          builder: (_) => const StaffSupervisorDashboardRoute(),
        );
      case StaffAppRoutes.supervisorCancellations:
        return MaterialPageRoute(
          builder: (_) => const StaffSupervisorCancellationsRoute(),
        );
      case StaffAppRoutes.supervisorManualValidation:
        return MaterialPageRoute(
          builder: (_) => const StaffSupervisorManualValidationRoute(),
        );
      case StaffAppRoutes.supervisorQrOverride:
        return MaterialPageRoute(
          builder: (_) => const StaffSupervisorQrOverrideRoute(),
        );
      case StaffAppRoutes.supervisorBarActionHistory:
        return MaterialPageRoute(
          builder: (_) => const StaffSupervisorBarActionHistoryRoute(),
        );
      case StaffAppRoutes.supervisorAccessDashboard:
        return MaterialPageRoute(
          builder: (_) => const StaffSupervisorAccessDashboardScreen(),
        );
      case StaffAppRoutes.supervisorSearchEntry:
        return MaterialPageRoute(
          builder: (_) => const StaffSupervisorSearchEntryScreen(),
        );
      case StaffAppRoutes.supervisorResolveDuplicate:
        final duplicateArgs = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => StaffSupervisorResolveDuplicateScreen(
            args: duplicateArgs is StaffSupervisorResolveDuplicateRouteArgs
                ? duplicateArgs
                : null,
          ),
        );
      case StaffAppRoutes.supervisorEntryQrOverride:
        final overrideArgs = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => StaffSupervisorEntryQrOverrideScreen(
            args: overrideArgs is StaffSupervisorEntryQrOverrideRouteArgs
                ? overrideArgs
                : null,
          ),
        );
      case StaffAppRoutes.supervisorEntryManualValidation:
        final manualValidationArgs = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => StaffSupervisorEntryManualValidationRoute(
            args: manualValidationArgs
                    is StaffSupervisorEntryManualValidationRouteArgs
                ? manualValidationArgs
                : null,
          ),
        );
      case StaffAppRoutes.supervisorEntryHistory:
        final historyArgs = settings.arguments;
        if (historyArgs is! StaffSupervisorEntryHistoryRouteArgs) {
          return MaterialPageRoute(
            builder: (_) => const StaffSupervisorSearchEntryScreen(),
          );
        }
        return MaterialPageRoute(
          builder: (_) => StaffSupervisorEntryHistoryScreen(args: historyArgs),
        );
      case StaffAppRoutes.supervisorVipManagement:
        return MaterialPageRoute(
          builder: (_) => const StaffSupervisorVipManagementRoute(),
        );
      case StaffAppRoutes.supervisorSystemStatus:
        return MaterialPageRoute(
          builder: (_) => const StaffSupervisorSystemStatusRoute(),
        );
      case StaffAppRoutes.supervisorActionHistory:
        return MaterialPageRoute(
          builder: (_) => const StaffSupervisorActionHistoryRoute(),
        );
      default:
        return MaterialPageRoute(builder: (_) => const StaffShellScreen());
    }
  }
}
