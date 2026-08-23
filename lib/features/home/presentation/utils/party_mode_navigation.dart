import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/theme/presentation/providers/app_theme_provider.dart';
import 'package:youpass/core/widgets/app_snack_bar.dart';
import 'package:youpass/dependency_injection/injection_container.dart';
import 'package:youpass/core/services/party_mode_event_preference.dart';
import 'package:youpass/features/home/domain/entities/home_feed_meta_entity.dart';
import 'package:youpass/features/home/presentation/party_drinks/routes/party_drink_menu_route_args.dart';
import 'package:youpass/features/home/presentation/party_drinks/widgets/party_drink_event_chooser_sheet.dart';
import 'package:youpass/features/home/presentation/providers/home_provider.dart';
import 'package:youpass/routes/app_routes.dart';

/// Handles Party Mode toggle side-effects (theme + navigation).
class PartyModeNavigation {
  PartyModeNavigation._();

  /// Toggle Party Mode from Home. Turning it on opens the drink menu
  /// (or an event chooser when multiple tickets qualify).
  static Future<void> toggleFromHome(
    BuildContext context, {
    required bool eligible,
  }) async {
    final themeProvider = context.read<AppThemeProvider>();
    final enabling = !themeProvider.isFiestaMode;

    if (!enabling) {
      await themeProvider.setFiestaMode(false);
      return;
    }

    // Resolve an event before flipping the theme so we don't leave the user
    // stuck on a dark Home with no party content.
    final selected = await _resolveOrRefreshDrinkMenuEvent(context);
    if (!context.mounted) {
      return;
    }

    if (selected == null) {
      AppSnackBar.show(
        context,
        AppStrings.partyModeUnavailable(context.l10n),
      );
      return;
    }

    await themeProvider.setFiestaMode(true, eligible: eligible);
    if (!context.mounted) {
      return;
    }

    final opened = await _navigateToDrinkMenu(
      context,
      selected,
      replaceCurrent: false,
    );
    if (!context.mounted) {
      return;
    }

    if (!opened) {
      await themeProvider.setFiestaMode(false);
      if (!context.mounted) {
        return;
      }
      AppSnackBar.show(
        context,
        AppStrings.partyModeUnavailable(context.l10n),
      );
    }
  }

  /// Toggle Party Mode from a party screen. Turning it off returns Home.
  static Future<void> toggleFromPartyScreen(
    BuildContext context, {
    required bool eligible,
  }) async {
    final themeProvider = context.read<AppThemeProvider>();
    final disabling = themeProvider.isFiestaMode;
    await themeProvider.toggleFiestaMode(eligible: eligible);
    if (!context.mounted || !disabling || themeProvider.isFiestaMode) {
      return;
    }

    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.home,
      (route) => false,
    );
  }

  /// Opens the drink menu. Returns `false` when no eligible event is available.
  static Future<bool> openDrinkMenu(
    BuildContext context, {
    bool replaceCurrent = false,
  }) async {
    final selected = await _resolveOrRefreshDrinkMenuEvent(context);
    if (!context.mounted || selected == null) {
      return false;
    }

    return _navigateToDrinkMenu(
      context,
      selected,
      replaceCurrent: replaceCurrent,
    );
  }

  /// Lets the user pick a different live event after the first choice.
  static Future<void> changeDrinkMenuEvent(BuildContext context) async {
    final homeProvider = context.read<HomeProvider>();
    final eligible = homeProvider.partyModeEligibleEvents;
    if (eligible.length < 2) {
      return;
    }

    final picked = await PartyDrinkEventChooserSheet.show(
      context,
      events: eligible,
      recommendedEventId: homeProvider.partyModeEventId,
    );
    if (picked == null || !context.mounted) {
      return;
    }

    await sl<PartyModeEventPreference>().remember(
      eventId: picked.eventId,
      eventTitle: picked.eventTitle,
    );
    if (!context.mounted) {
      return;
    }
    await _navigateToDrinkMenu(
      context,
      picked,
      replaceCurrent: true,
    );
  }

  static Future<HomePartyModeEligibleEventEntity?>
      _resolveOrRefreshDrinkMenuEvent(BuildContext context) async {
    var selected = await resolveDrinkMenuEvent(context);
    if (selected != null) {
      return selected;
    }
    if (!context.mounted) {
      return null;
    }

    final homeProvider = context.read<HomeProvider>();
    try {
      await homeProvider.refreshPartyModeEligibility().timeout(
        const Duration(seconds: 4),
      );
    } catch (_) {
      // Keep cached eligibility if refresh/GPS is slow or fails.
    }
    if (!context.mounted) {
      return null;
    }

    return resolveDrinkMenuEvent(context);
  }

  static Future<bool> _navigateToDrinkMenu(
    BuildContext context,
    HomePartyModeEligibleEventEntity selected, {
    required bool replaceCurrent,
  }) async {
    final args = PartyDrinkMenuRouteArgs(
      eventId: selected.eventId,
      eventTitle: selected.eventTitle,
    );

    final currentRoute = ModalRoute.of(context)?.settings.name;
    if (currentRoute == AppRoutes.partyDrinkMenu || replaceCurrent) {
      await Navigator.of(context).pushReplacementNamed(
        AppRoutes.partyDrinkMenu,
        arguments: args,
      );
      return true;
    }

    await Navigator.of(context).pushNamed(
      AppRoutes.partyDrinkMenu,
      arguments: args,
    );
    return true;
  }

  static Future<HomePartyModeEligibleEventEntity?> resolveDrinkMenuEvent(
    BuildContext context,
  ) async {
    final homeProvider = context.read<HomeProvider>();
    final eligible = homeProvider.partyModeEligibleEvents;
    final recommendedId = homeProvider.partyModeEventId;
    final recommendedTitle = homeProvider.partyModeEventTitle;
    final preference = sl<PartyModeEventPreference>();

    if (eligible.isEmpty) {
      await preference.clear();
      if (recommendedId != null && recommendedId.isNotEmpty) {
        return HomePartyModeEligibleEventEntity(
          eventId: recommendedId,
          eventTitle: recommendedTitle ?? '',
        );
      }
      return null;
    }

    if (eligible.length == 1) {
      final only = eligible.first;
      await preference.remember(
        eventId: only.eventId,
        eventTitle: only.eventTitle,
      );
      return only;
    }

    final rememberedId = preference.eventId;
    if (rememberedId != null) {
      final remembered = eligible.where((event) => event.eventId == rememberedId);
      if (remembered.isNotEmpty) {
        return remembered.first;
      }
      await preference.clear();
    }

    if (!context.mounted) {
      return null;
    }

    final picked = await PartyDrinkEventChooserSheet.show(
      context,
      events: eligible,
      recommendedEventId: recommendedId,
    );
    if (picked == null) {
      return null;
    }

    await preference.remember(
      eventId: picked.eventId,
      eventTitle: picked.eventTitle,
    );
    return picked;
  }
}
