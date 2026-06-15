import 'package:equatable/equatable.dart';

class MainBannerCarouselConfigEntity extends Equatable {
  const MainBannerCarouselConfigEntity({
    required this.minSlides,
    required this.maxSlides,
    required this.autoplayIntervalMs,
    required this.aspectRatio,
    required this.aspectRatioAlternate,
    required this.heightScreenFractionMin,
    required this.heightScreenFractionMax,
  });

  final int minSlides;
  final int maxSlides;
  final int autoplayIntervalMs;
  final String aspectRatio;
  final String aspectRatioAlternate;
  final double heightScreenFractionMin;
  final double heightScreenFractionMax;

  static const MainBannerCarouselConfigEntity defaults = MainBannerCarouselConfigEntity(
    minSlides: 5,
    maxSlides: 11,
    autoplayIntervalMs: 6000,
    aspectRatio: '16:9',
    aspectRatioAlternate: '21:9',
    heightScreenFractionMin: 0.25,
    heightScreenFractionMax: 0.30,
  );

  factory MainBannerCarouselConfigEntity.fromJson(Object? value) {
    if (value is! Map<String, dynamic>) {
      return defaults;
    }

    return MainBannerCarouselConfigEntity(
      minSlides: _readInt(value, 'min_slides', defaults.minSlides),
      maxSlides: _readInt(value, 'max_slides', defaults.maxSlides),
      autoplayIntervalMs: _readInt(
        value,
        'autoplay_interval_ms',
        defaults.autoplayIntervalMs,
      ),
      aspectRatio: value['aspect_ratio']?.toString() ?? defaults.aspectRatio,
      aspectRatioAlternate:
          value['aspect_ratio_alternate']?.toString() ?? defaults.aspectRatioAlternate,
      heightScreenFractionMin: _readDouble(
        value,
        'height_screen_fraction_min',
        defaults.heightScreenFractionMin,
      ),
      heightScreenFractionMax: _readDouble(
        value,
        'height_screen_fraction_max',
        defaults.heightScreenFractionMax,
      ),
    );
  }

  static int _readInt(Map<String, dynamic> json, String snakeKey, int fallback) {
    final camelKey = _toCamelCase(snakeKey);
    final raw = json[snakeKey] ?? json[camelKey];
    if (raw is int) {
      return raw;
    }
    if (raw is num) {
      return raw.toInt();
    }
    return fallback;
  }

  static double _readDouble(Map<String, dynamic> json, String snakeKey, double fallback) {
    final camelKey = _toCamelCase(snakeKey);
    final raw = json[snakeKey] ?? json[camelKey];
    if (raw is double) {
      return raw;
    }
    if (raw is num) {
      return raw.toDouble();
    }
    return fallback;
  }

  static String _toCamelCase(String value) {
    final parts = value.split('_');
    if (parts.isEmpty) {
      return value;
    }
    return parts.first +
        parts.skip(1).map((part) {
          if (part.isEmpty) {
            return part;
          }
          return part[0].toUpperCase() + part.substring(1);
        }).join();
  }

  double resolveAspectRatio(String? slideAspectRatio) {
    final normalized = (slideAspectRatio ?? aspectRatio).trim();
    if (normalized == aspectRatioAlternate) {
      return _parseRatio(aspectRatioAlternate);
    }
    return _parseRatio(normalized);
  }

  static double _parseRatio(String value) {
    final parts = value.split(':');
    if (parts.length != 2) {
      return 16 / 9;
    }
    final width = double.tryParse(parts[0]);
    final height = double.tryParse(parts[1]);
    if (width == null || height == null || height == 0) {
      return 16 / 9;
    }
    return width / height;
  }

  @override
  List<Object?> get props => [
        minSlides,
        maxSlides,
        autoplayIntervalMs,
        aspectRatio,
        aspectRatioAlternate,
        heightScreenFractionMin,
        heightScreenFractionMax,
      ];
}
