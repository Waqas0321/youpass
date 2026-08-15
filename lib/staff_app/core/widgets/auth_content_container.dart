import 'package:flutter/material.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';

class AuthContentContainer extends StatelessWidget {
  const AuthContentContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: layout.contentMaxWidth),
        child: child,
      ),
    );
  }
}
