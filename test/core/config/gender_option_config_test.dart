import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/core/config/auth_product_config_model.dart';

void main() {
  group('GenderOptionConfig', () {
    test('parses flat label_en/label_es/label_pt from /config/auth', () {
      final option = GenderOptionConfig.fromJson({
        'value': 'male',
        'label_en': 'Man',
        'label_es': 'Hombre',
        'label_pt': 'Homem',
      });

      expect(option.value, 'male');
      expect(option.labelFor('en'), 'Man');
      expect(option.labelFor('es'), 'Hombre');
      expect(option.labelFor('pt'), 'Homem');
    });

    test('parses nested labels map', () {
      final option = GenderOptionConfig.fromJson({
        'value': 'female',
        'labels': {'en': 'Woman', 'es': 'Mujer'},
      });

      expect(option.labelFor('en'), 'Woman');
      expect(option.labelFor('es'), 'Mujer');
    });

    test('falls back to value when labels are missing', () {
      final option = GenderOptionConfig.fromJson({'value': 'other'});

      expect(option.labelFor('en'), 'other');
    });
  });
}
