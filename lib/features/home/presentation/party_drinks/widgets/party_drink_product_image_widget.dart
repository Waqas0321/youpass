import 'package:flutter/material.dart';
import 'package:youpass/features/home/presentation/party_drinks/models/party_drink_item.dart';

class PartyDrinkProductImageWidget extends StatelessWidget {
  const PartyDrinkProductImageWidget({
    super.key,
    required this.drink,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
  });

  final PartyDrinkItem drink;
  final double? width;
  final double? height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    if (drink.hasNetworkImage) {
      return Image.network(
        drink.imageUrl!,
        width: width,
        height: height,
        fit: fit,
        alignment: Alignment.center,
        errorBuilder: (context, error, stackTrace) => _placeholder(),
      );
    }

    final assetPath = drink.imageAsset?.trim();
    if (assetPath != null && assetPath.isNotEmpty) {
      return Image.asset(
        assetPath,
        width: width,
        height: height,
        fit: fit,
        alignment: Alignment.center,
        errorBuilder: (context, error, stackTrace) => _placeholder(),
      );
    }

    return _placeholder();
  }

  Widget _placeholder() {
    return SizedBox(
      width: width,
      height: height,
      child: const Center(
        child: Icon(
          Icons.local_bar_outlined,
          color: Colors.white54,
          size: 40,
        ),
      ),
    );
  }
}
