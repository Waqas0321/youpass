import 'package:youpass/staff_app/core/config/api_config.dart';
import 'package:youpass/l10n/app_localizations.dart';

abstract final class ApiConfigLabels {
  static String activeApiLabel(AppLocalizations l10n) {
    const override = String.fromEnvironment('API_BASE_URL');
    if (override.isNotEmpty) {
      return l10n.staffApiEnvCustom;
    }

    const useLocalApi = bool.fromEnvironment(
      'USE_LOCAL_API',
      defaultValue: false,
    );

    if (useLocalApi) {
      if (ApiConfig.useNgrokTunnel) {
        return l10n.staffApiEnvDevNgrok;
      }
      return l10n.staffApiEnvDevLocal;
    }
    return l10n.staffApiEnvProduction;
  }
}
