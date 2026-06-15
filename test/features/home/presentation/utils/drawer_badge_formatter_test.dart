import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/features/home/presentation/utils/drawer_badge_formatter.dart';

void main() {
  test('DrawerBadgeFormatter hides badge for zero invitations', () {
    expect(DrawerBadgeFormatter.formatCount(0), isNull);
  });

  test('DrawerBadgeFormatter shows exact count for 1-99', () {
    expect(DrawerBadgeFormatter.formatCount(1), '1');
    expect(DrawerBadgeFormatter.formatCount(42), '42');
    expect(DrawerBadgeFormatter.formatCount(99), '99');
  });

  test('DrawerBadgeFormatter caps count at 99+', () {
    expect(DrawerBadgeFormatter.formatCount(100), '99+');
    expect(DrawerBadgeFormatter.formatCount(250), '99+');
  });
}
