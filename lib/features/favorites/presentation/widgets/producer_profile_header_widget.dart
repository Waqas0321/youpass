import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/favorites/domain/entities/favorite_producer_entity.dart';
import 'package:youpass/features/favorites/presentation/favorites_design_spec.dart';

class ProducerProfileHeaderWidget extends StatelessWidget {
  const ProducerProfileHeaderWidget({
    super.key,
    required this.producer,
  });

  final FavoriteProducerEntity producer;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final typeLabel = producer.typeLabel?.trim().isNotEmpty == true
        ? producer.typeLabel!.trim()
        : AppStrings.favoritesProducerType(strings);

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: FavoritesDesignSpec.px(context, 12),
      ),
      child: Column(
        children: [
          Text(
            producer.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: FavoritesDesignSpec.px(context, 22),
              fontWeight: FontWeight.w800,
              color: FavoritesDesignSpec.buyAccent,
              letterSpacing: 0.2,
              height: 1.25,
            ),
          ),
          SizedBox(height: FavoritesDesignSpec.px(context, 8)),
          Text(
            typeLabel,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: FavoritesDesignSpec.px(context, 13),
              fontWeight: FontWeight.w400,
              color: FavoritesDesignSpec.bodyText,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}
