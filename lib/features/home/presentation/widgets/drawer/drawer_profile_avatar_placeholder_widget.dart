import 'package:flutter/material.dart';

class DrawerProfileAvatarPlaceholderWidget extends StatelessWidget {
  const DrawerProfileAvatarPlaceholderWidget({
    super.key,
    required this.initial,
    required this.size,
    required this.backgroundColor,
    required this.iconColor,
    required this.initialColor,
  });

  final String initial;
  final double size;
  final Color backgroundColor;
  final Color iconColor;
  final Color initialColor;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: backgroundColor,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.person_outline,
            size: size * 0.52,
            color: iconColor,
          ),
          Text(
            initial,
            style: TextStyle(
              fontSize: size * 0.34,
              fontWeight: FontWeight.w700,
              color: initialColor,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}
