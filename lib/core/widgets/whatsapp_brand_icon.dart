import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:youpass/core/constants/app_colors.dart';

class WhatsAppBrandIcon extends StatelessWidget {
  const WhatsAppBrandIcon({
    super.key,
    required this.size,
    this.color = AppColors.whatsAppGreen,
  });

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return FaIcon(
      FontAwesomeIcons.whatsapp,
      size: size,
      color: color,
    );
  }
}
