import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/features/profile/data/models/support_faq_model.dart';

void main() {
  test('SupportContactModel parses contact info payload', () {
    final model = SupportContactModel.fromJson({
      'whatsapp_number': '+56911111111',
      'email': 'help@youpass.app',
      'business_hours': {
        'timezone': 'America/Santiago',
        'weekdays': {'from': '09:00', 'to': '18:00'},
        'saturday': {'from': '10:00', 'to': '14:00'},
        'sunday': null,
      },
      'outside_hours_auto_reply_es': 'Te responderemos pronto.',
      'outside_hours_auto_reply_en': 'We will reply soon.',
      'outside_hours_reply_within_hours': 12,
      'is_within_business_hours': false,
    });

    expect(model.whatsappNumber, '+56911111111');
    expect(model.email, 'help@youpass.app');
    expect(model.businessHours.timezone, 'America/Santiago');
    expect(model.businessHours.weekdays?.from, '09:00');
    expect(model.outsideHoursReplyWithinHours, 12);
    expect(model.isWithinBusinessHours, isFalse);
    expect(model.outsideHoursAutoReplyFor('es'), 'Te responderemos pronto.');
  });

  test('SupportFaqResponseModel parses grouped FAQs', () {
    final model = SupportFaqResponseModel.fromJson({
      'total': 1,
      'categories': [
        {
          'category': 'ticket_purchasing',
          'label_es': 'Compra de entradas',
          'label_en': 'Ticket purchasing',
          'items': [
            {
              'id': 'faq-buy-tickets',
              'question_es': '¿Cómo compro?',
              'question_en': 'How do I buy?',
              'answer_es': 'Desde la ficha del evento.',
              'answer_en': 'From the event page.',
            },
          ],
        },
      ],
    });

    expect(model.total, 1);
    expect(model.categories, hasLength(1));
    expect(model.categories.first.items.first.id, 'faq-buy-tickets');
  });
}
