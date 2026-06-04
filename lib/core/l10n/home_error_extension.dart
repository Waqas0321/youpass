import 'package:youpass/core/l10n/app_message_localizer.dart';
import 'package:youpass/features/home/presentation/providers/home_provider.dart';
import 'package:youpass/l10n/app_localizations.dart';

extension HomeProviderErrorExtension on HomeProvider {
  String? localizedErrorMessage(AppLocalizations l10n) {
    if (errorMessage == null || errorMessage!.trim().isEmpty) {
      return null;
    }

    return AppMessageLocalizer.fromApiError(
      l10n,
      fallbackMessage: errorMessage,
    );
  }
}
