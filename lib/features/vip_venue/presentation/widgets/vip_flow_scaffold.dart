import 'package:flutter/material.dart';
import 'package:youpass/core/widgets/youpass_logo.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_design_spec.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_screen_theme.dart';
import 'package:youpass/features/vip_venue/presentation/widgets/vip_navigation_widgets.dart';

enum VipFlowHeaderStyle {
  leftTitle,
  branded,
}

class VipFlowScaffold extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final background = VipVenueScreenTheme.screenBackground(context);
    final accent = VipVenueScreenTheme.accent(context);
    final horizontalPadding =
        VipVenueDesignSpec.px(context, VipVenueDesignSpec.horizontalPadding);

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                VipVenueDesignSpec.px(context, 4),
                VipVenueDesignSpec.px(context, 4),
                horizontalPadding,
                0,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.arrow_back,
                      color: accent,
                      size: VipVenueDesignSpec.px(context, 24),
                    ),
                  ),
                  if (headerStyle == VipFlowHeaderStyle.branded)
                    const Expanded(child: Center(child: YouPassLogo()))
                  else
                    const Spacer(),
                  if (headerStyle == VipFlowHeaderStyle.branded && showNotification)
                    const VipFlowNotificationButtonWidget()
                  else if (headerStyle == VipFlowHeaderStyle.branded)
                    SizedBox(width: VipVenueDesignSpec.px(context, 48)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                VipVenueDesignSpec.px(context, 4),
                horizontalPadding,
                VipVenueDesignSpec.px(context, 12),
              ),
              child: VipFlowPageHeaderWidget(
                title: title,
                subtitle: subtitle,
              ),
            ),
            Expanded(child: body),
            ?bottomBar,
          ],
        ),
      ),
    );
  }
}
