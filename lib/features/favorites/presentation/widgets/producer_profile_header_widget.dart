import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/event_network_image.dart';
import 'package:youpass/features/favorites/domain/entities/favorite_producer_entity.dart';
import 'package:youpass/features/favorites/presentation/favorites_design_spec.dart';

class ProducerProfileHeaderWidget extends StatelessWidget {
  const ProducerProfileHeaderWidget({
    super.key,
    required this.producer,
  });

  final FavoriteProducerEntity producer;

  static const double _designLogoMaxWidth = 228;
  static const double _designLogoHeight = 78;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final logoMaxWidth =
        FavoritesDesignSpec.px(context, _designLogoMaxWidth);
    final logoHeight = FavoritesDesignSpec.px(context, _designLogoHeight);
    final typeLabel = producer.typeLabel?.trim().isNotEmpty == true
        ? producer.typeLabel!.trim()
        : AppStrings.favoritesProducerType(strings);
    final hasLogo = producer.logoUrl?.trim().isNotEmpty == true;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: FavoritesDesignSpec.px(context, 4),
      ),
      child: Column(
        children: [
          if (hasLogo)
            SizedBox(
              width: logoMaxWidth,
              height: logoHeight,
              child: EventNetworkImage(
                imageUrl: producer.logoUrl,
                fit: BoxFit.contain,
              ),
            )
          else
            Text(
              producer.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: FavoritesDesignSpec.px(context, 22),
                fontWeight: FontWeight.w800,
                color: FavoritesDesignSpec.buyAccent,
                letterSpacing: 0.2,
              ),
            ),
          SizedBox(height: FavoritesDesignSpec.px(context, 8)),
          Text(
            typeLabel,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: FavoritesDesignSpec.px(context, 12),
              fontWeight: FontWeight.w400,
              color: FavoritesDesignSpec.bodyText,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}
