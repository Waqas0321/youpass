import 'package:flutter/material.dart';
import 'package:youpass/features/home/presentation/utils/app_drawer_navigation.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_design_spec.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_screen_theme.dart';
import 'package:youpass/features/vip_venue/presentation/widgets/vip_navigation_widgets.dart';

enum VipFlowHeaderStyle {
  leftTitle,
  branded,
}

class VipFlowScaffold extends StatefulWidget {
  const VipFlowScaffold({
    super.key,
    required this.title,
    this.subtitle,
    required this.body,
    this.bottomBar,
    this.headerStyle = VipFlowHeaderStyle.leftTitle,
    this.showNotification = false,
  });

  final String title;
  final String? subtitle;
  final Widget body;
  final Widget? bottomBar;
  final VipFlowHeaderStyle headerStyle;
  final bool showNotification;

  @override
  State<VipFlowScaffold> createState() => _VipFlowScaffoldState();
}

class _VipFlowScaffoldState extends State<VipFlowScaffold> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final background = VipVenueScreenTheme.screenBackground(context);
    final horizontalPadding =
        VipVenueDesignSpec.px(context, VipVenueDesignSpec.horizontalPadding);

    return AppDrawerNavigation.wrap(
      scaffoldKey: scaffoldKey,
      context: context,
      backgroundColor: background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            VipFlowTopBarWidget(
              onMenuTap: () =>
                  AppDrawerNavigation.openDrawer(context, scaffoldKey),
              brandedHeader: widget.headerStyle == VipFlowHeaderStyle.branded,
              showNotification: widget.showNotification,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                VipVenueDesignSpec.px(context, 4),
                horizontalPadding,
                VipVenueDesignSpec.px(context, 12),
              ),
              child: VipFlowPageHeaderWidget(
                title: widget.title,
                subtitle: widget.subtitle,
              ),
            ),
            Expanded(child: widget.body),
            ?widget.bottomBar,
          ],
        ),
      ),
    );
  }
}
