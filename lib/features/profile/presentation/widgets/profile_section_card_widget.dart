import 'package:flutter/material.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_design_spec.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_theme.dart';

class ProfileSectionCardWidget extends StatelessWidget {
  const ProfileSectionCardWidget({
    super.key,
    required this.child,
    this.padding,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final theme = ProfileTheme.of(context);
    final radius =
        ProfileDesignSpec.px(context, ProfileDesignSpec.sectionCardRadius);

    return Container(
      width: double.infinity,
      padding: padding ??
          EdgeInsets.symmetric(
            horizontal: ProfileDesignSpec.px(context, 16),
            vertical: ProfileDesignSpec.px(context, 4),
          ),
      decoration: BoxDecoration(
        color: theme.sectionCardBackground,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: theme.sectionCardBorder,
          width: 1,
        ),
        boxShadow: theme.sectionCardShadow == Colors.transparent
            ? null
            : [
                BoxShadow(
                  color: theme.sectionCardShadow,
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: child,
    );
  }
}
