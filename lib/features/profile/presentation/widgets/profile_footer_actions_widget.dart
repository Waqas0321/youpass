import 'package:flutter/material.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_design_spec.dart';

/// Footer actions at the end of My Profile with safe-area clearance
/// for iOS home indicator and Android navigation/gesture bars.
class ProfileFooterActionsWidget extends StatelessWidget {
  const ProfileFooterActionsWidget({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      left: false,
      right: false,
      minimum: EdgeInsets.only(
        bottom: ProfileDesignSpec.px(
          context,
          ProfileDesignSpec.scrollBottomExtraPadding,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }
}
