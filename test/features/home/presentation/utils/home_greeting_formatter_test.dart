import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/features/home/presentation/utils/home_greeting_formatter.dart';

void main() {
  group('HomeGreetingFormatter.abbreviatedName', () {
    test('case 1: short name uses first name and full first surname', () {
      expect(
        HomeGreetingFormatter.abbreviatedName('juan pérez'),
        'Juan Pérez',
      );
    });

    test('case 2: compound surname keeps first surname only', () {
      expect(
        HomeGreetingFormatter.abbreviatedName('alejandro ruiz garcía'),
        'Alejandro Ruiz',
      );
    });

    test('case 3: very long name uses surname initial', () {
      expect(
        HomeGreetingFormatter.abbreviatedName('maximiliano vanderwalden'),
        'Maximiliano V.',
      );
    });

    test('case 4: extensive name falls back to first name only', () {
      expect(
        HomeGreetingFormatter.abbreviatedName('alexandernicholas vontrapp'),
        'Alexandernicholas',
      );
    });

    test('case 5: extreme first name uses nickname', () {
      expect(
        HomeGreetingFormatter.abbreviatedName('maximiliano'),
        'Maxi',
      );
    });

    test('single short first name is unchanged', () {
      expect(
        HomeGreetingFormatter.abbreviatedName('Ana'),
        'Ana',
      );
    });
  });
}
