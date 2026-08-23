import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/youpass_brand_logo.dart';
import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/features/auth/presentation/providers/staff_auth_provider.dart';
import 'package:youpass/staff_app/features/home/presentation/providers/staff_work_mode_provider.dart';
import 'package:youpass/staff_app/features/home/presentation/utils/staff_logout.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/utils/staff_supervisor_access.dart';

class StaffHomeHeader extends StatelessWidget {
  const StaffHomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final profile = context.watch<StaffAuthProvider>().profile;
    final workMode = context.watch<StaffWorkModeProvider>().mode;
    final showDrawer = profile?.shouldShowMenuDrawer(workMode) ?? false;
    final sideSlotWidth = layout.spacing(48);

    return Padding(
      padding: EdgeInsets.fromLTRB(
        layout.spacing(4),
        layout.spacing(4),
        layout.spacing(16),
        layout.spacing(4),
      ),
      child: Row(
        children: [
          SizedBox(
            width: sideSlotWidth,
            child: showDrawer
                ? Builder(
                    builder: (context) => IconButton(
                      onPressed: () => Scaffold.of(context).openDrawer(),
                      icon: Icon(
                        Icons.menu_rounded,
                        color: AppColors.primaryMustard,
                        size: layout.spacing(28),
                      ),
                    ),
                  )
                : null,
          ),
          const Expanded(
            child: Center(
              child: YouPassBrandLogo(compact: true),
            ),
          ),
          SizedBox(
            width: sideSlotWidth,
            child: showDrawer
                ? null
                : IconButton(
                    onPressed: () => performStaffLogout(context),
                    tooltip: context.l10n.staffLogout,
                    icon: Icon(
                      Icons.logout_rounded,
                      color: AppColors.primaryMustard,
                      size: layout.spacing(24),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
