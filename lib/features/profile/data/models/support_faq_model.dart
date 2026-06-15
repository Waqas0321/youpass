import 'package:youpass/core/utils/json_readers.dart';

class SupportHoursSlotModel {
  const SupportHoursSlotModel({
    required this.from,
    required this.to,
  });

  final String from;
  final String to;

  factory SupportHoursSlotModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const SupportHoursSlotModel(from: '09:00', to: '18:00');
    }

    return SupportHoursSlotModel(
      from: JsonReaders.string(json, 'from', fallback: '09:00'),
      to: JsonReaders.string(json, 'to', fallback: '18:00'),
    );
  }
}

class SupportBusinessHoursModel {
  const SupportBusinessHoursModel({
    required this.timezone,
    this.weekdays,
    this.saturday,
    this.sunday,
  });

  final String timezone;
  final SupportHoursSlotModel? weekdays;
  final SupportHoursSlotModel? saturday;
  final SupportHoursSlotModel? sunday;

  factory SupportBusinessHoursModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const SupportBusinessHoursModel(timezone: 'America/Santiago');
    }

    SupportHoursSlotModel? slot(String key) {
      final value = json[key];
      if (value is! Map<String, dynamic>) {
        return null;
      }
      return SupportHoursSlotModel.fromJson(value);
    }

    return SupportBusinessHoursModel(
      timezone: JsonReaders.string(
        json,
        'timezone',
        fallback: 'America/Santiago',
      ),
      weekdays: slot('weekdays'),
      saturday: slot('saturday'),
      sunday: slot('sunday'),
    );
  }
}

class SupportContactModel {
  const SupportContactModel({
    required this.whatsappNumber,
    required this.email,
    required this.businessHours,
    required this.outsideHoursAutoReplyEs,
    required this.outsideHoursAutoReplyEn,
    required this.outsideHoursReplyWithinHours,
    required this.isWithinBusinessHours,
  });

  final String whatsappNumber;
  final String email;
  final SupportBusinessHoursModel businessHours;
  final String outsideHoursAutoReplyEs;
  final String outsideHoursAutoReplyEn;
  final int outsideHoursReplyWithinHours;
  final bool isWithinBusinessHours;

  factory SupportContactModel.fromJson(Map<String, dynamic> json) {
    final businessHours = json['business_hours'];
    return SupportContactModel(
      whatsappNumber: JsonReaders.string(json, 'whatsapp_number'),
      email: JsonReaders.string(json, 'email'),
      businessHours: businessHours is Map<String, dynamic>
          ? SupportBusinessHoursModel.fromJson(businessHours)
          : const SupportBusinessHoursModel(timezone: 'America/Santiago'),
      outsideHoursAutoReplyEs: JsonReaders.string(
        json,
        'outside_hours_auto_reply_es',
      ),
      outsideHoursAutoReplyEn: JsonReaders.string(
        json,
        'outside_hours_auto_reply_en',
      ),
      outsideHoursReplyWithinHours: JsonReaders.integer(
        json,
        'outside_hours_reply_within_hours',
        fallback: 24,
      ),
      isWithinBusinessHours: JsonReaders.boolean(
        json,
        'is_within_business_hours',
        fallback: true,
      ),
    );
  }

  String outsideHoursAutoReplyFor(String languageCode) {
    return languageCode == 'es'
        ? outsideHoursAutoReplyEs
        : outsideHoursAutoReplyEn;
  }
}

class SupportFaqResponseModel {
  const SupportFaqResponseModel({
    required this.categories,
    required this.total,
  });

  final List<SupportFaqCategoryModel> categories;
  final int total;

  factory SupportFaqResponseModel.fromJson(Map<String, dynamic> json) {
    final categories = json['categories'];
    return SupportFaqResponseModel(
      categories: categories is List
          ? categories
              .whereType<Map<String, dynamic>>()
              .map(SupportFaqCategoryModel.fromJson)
              .toList()
          : const [],
      total: JsonReaders.integer(json, 'total'),
    );
  }
}

class SupportFaqCategoryModel {
  const SupportFaqCategoryModel({
    required this.category,
    required this.labelEs,
    required this.labelEn,
    required this.items,
  });

  final String category;
  final String labelEs;
  final String labelEn;
  final List<SupportFaqItemModel> items;

  factory SupportFaqCategoryModel.fromJson(Map<String, dynamic> json) {
    final items = json['items'];
    return SupportFaqCategoryModel(
      category: JsonReaders.string(json, 'category'),
      labelEs: JsonReaders.string(json, 'label_es'),
      labelEn: JsonReaders.string(json, 'label_en'),
      items: items is List
          ? items
              .whereType<Map<String, dynamic>>()
              .map(SupportFaqItemModel.fromJson)
              .toList()
          : const [],
    );
  }
}

class SupportFaqItemModel {
  const SupportFaqItemModel({
    required this.id,
    required this.questionEs,
    required this.questionEn,
    required this.answerEs,
    required this.answerEn,
  });

  final String id;
  final String questionEs;
  final String questionEn;
  final String answerEs;
  final String answerEn;

  factory SupportFaqItemModel.fromJson(Map<String, dynamic> json) {
    return SupportFaqItemModel(
      id: JsonReaders.string(json, 'id'),
      questionEs: JsonReaders.string(json, 'question_es'),
      questionEn: JsonReaders.string(json, 'question_en'),
      answerEs: JsonReaders.string(json, 'answer_es'),
      answerEn: JsonReaders.string(json, 'answer_en'),
    );
  }
}
