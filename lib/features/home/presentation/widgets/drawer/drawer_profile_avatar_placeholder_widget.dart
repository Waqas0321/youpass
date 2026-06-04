import 'package:flutter/material.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_design_spec.dart';

class DrawerProfileAvatarPlaceholderWidget extends StatelessWidget {
  const DrawerProfileAvatarPlaceholderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(
        Icons.person,
        size: DrawerDesignSpec.px(context, DrawerDesignSpec.avatarIconSize),
        color: DrawerDesignSpec.avatarIcon,
      ),
    );
  }
}
