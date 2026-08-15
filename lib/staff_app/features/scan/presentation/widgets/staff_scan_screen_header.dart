import 'package:flutter/material.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/youpass_logo.dart';
import 'package:youpass/staff_app/features/scan/presentation/widgets/staff_scan_viewfinder_overlay.dart';

class StaffScanScreenHeader extends StatelessWidget {
  const StaffScanScreenHeader({
    super.key,
    this.onBack,
    this.showBottomDivider = false,
  });

  final VoidCallback? onBack;
  final bool showBottomDivider;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return ColoredBox(
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                layout.spacing(4),
                layout.spacing(2),
                layout.spacing(16),
                layout.spacing(10),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: onBack ?? () => Navigator.of(context).maybePop(),
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: staffScanAccent,
                      size: layout.spacing(20),
                    ),
                  ),
                  const Expanded(
                    child: YouPassLogo(color: staffScanAccent),
                  ),
                  SizedBox(width: layout.spacing(48)),
                ],
              ),
            ),
            if (showBottomDivider)
              Divider(
                height: 1,
                thickness: 1,
                color: AppColors.homeDividerGrey,
              ),
          ],
        ),
      ),
    );
  }
}
