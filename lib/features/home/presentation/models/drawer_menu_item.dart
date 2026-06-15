import 'package:flutter/material.dart';
import 'package:youpass/features/home/domain/entities/drawer_menu_id.dart';

class DrawerMenuItem {
  const DrawerMenuItem({
    required this.id,
    required this.label,
    this.icon,
    this.isHighlighted = false,
  });

  final DrawerMenuId id;
  final String label;
  final IconData? icon;
  final bool isHighlighted;
}
