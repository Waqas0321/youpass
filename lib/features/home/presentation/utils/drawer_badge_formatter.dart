class DrawerBadgeFormatter {
  DrawerBadgeFormatter._();

  /// Returns null when the badge should be hidden (0 invitations).
  static String? formatCount(int count) {
    if (count <= 0) {
      return null;
    }
    if (count >= 100) {
      return '99+';
    }
    return count.toString();
  }
}
