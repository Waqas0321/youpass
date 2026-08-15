import 'package:flutter/material.dart';
import 'package:youpass/core/utils/responsive_layout.dart';

class AuthContentContainer extends StatelessWidget {
  const AuthContentContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    // Vertically center auth content (logo + form). BACK is rendered separately
    // in AuthScaffold.topBar so it can stay pinned under the status bar.
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: layout.contentMaxWidth),
        child: child,
      ),
    );
  }
}
