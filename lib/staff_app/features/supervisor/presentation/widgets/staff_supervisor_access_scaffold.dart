import 'package:flutter/material.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';
import 'package:youpass/staff_app/features/scan/presentation/widgets/staff_scan_screen_header.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_design.dart';

class StaffSupervisorAccessScaffold extends StatelessWidget {
  const StaffSupervisorAccessScaffold({
    super.key,
    required this.children,
    this.footer,
    this.bottomBar,
    this.padding,
    this.onRefresh,
  });

  final List<Widget> children;
  final Widget? footer;
  final Widget? bottomBar;
  final EdgeInsetsGeometry? padding;
  final Future<void> Function()? onRefresh;

  static const _refreshAccent = AppColors.homeAccentYellow;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final l10n = context.l10n;
    final listPadding = padding ??
        EdgeInsets.fromLTRB(
          layout.spacing(20),
          0,
          layout.spacing(20),
          layout.spacing(12),
        );

    final listView = ListView(
      physics: onRefresh != null
          ? const AlwaysScrollableScrollPhysics()
          : null,
      padding: listPadding,
      children: children,
    );

    return Scaffold(
      backgroundColor: StaffSupervisorDesign.pageBackground,
      body: Column(
        children: [
          StaffScanScreenHeader(showBottomDivider: true),
          Padding(
            padding: EdgeInsets.fromLTRB(
              layout.spacing(20),
              layout.spacing(8),
              layout.spacing(20),
              layout.spacing(12),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: AppText(
                l10n.staffSupervisorSearchEntryHeaderSubtitle,
                variant: AppTextVariant.body,
                color: AppColors.secondaryGrey,
                fontSize: layout.fontSize(13),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: onRefresh == null
                ? listView
                : RefreshIndicator(
                    color: _refreshAccent,
                    onRefresh: onRefresh!,
                    child: listView,
                  ),
          ),
          if (footer != null) footer!,
          if (bottomBar != null) bottomBar!,
        ],
      ),
    );
  }
}
