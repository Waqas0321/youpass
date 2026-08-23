import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/youpass_confirm_dialog.dart';
import 'package:youpass/features/auth/presentation/providers/auth_provider.dart';
import 'package:youpass/features/home/domain/entities/drawer_menu_id.dart';
import 'package:youpass/features/home/presentation/models/drawer_menu_item.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_design_spec.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_menu_tile_widget.dart';
import 'package:youpass/routes/app_routes.dart';

/// Bottom drawer action: Logout only.
class DrawerFooterActionsWidget extends StatelessWidget {
  const DrawerFooterActionsWidget({
    super.key,
    required this.onSelect,
  });

  /// Kept for call-site compatibility with the drawer footer slot.
  final ValueChanged<DrawerMenuId> onSelect;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final horizontalPadding =
        DrawerDesignSpec.px(context, DrawerDesignSpec.horizontalPadding);

    return Padding(
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        DrawerDesignSpec.px(context, DrawerDesignSpec.menuTileGap),
        horizontalPadding,
        DrawerDesignSpec.px(context, 16),
      ),
      child: DrawerMenuTileWidget(
        item: DrawerMenuItem(
          id: DrawerMenuId.logout,
          label: AppStrings.profileLogout(strings),
          icon: Icons.logout,
        ),
        onTap: () => _handleLogout(context),
      ),
    );
  }

  Future<void> _handleLogout(BuildContext context) async {
    final confirmed = await YouPassConfirmDialog.showLogout(context);
    if (!confirmed || !context.mounted) {
      return;
    }

    // Capture navigator before closing the drawer — the footer context is
    // disposed when the drawer pops, so we must not rely on it after await.
    final navigator = Navigator.of(context);
    final authProvider = context.read<AuthProvider>();

    if (navigator.canPop()) {
      navigator.pop();
    }

    await authProvider.logout();
    navigator.pushNamedAndRemoveUntil(
      AppRoutes.login,
      (_) => false,
    );
  }
}
