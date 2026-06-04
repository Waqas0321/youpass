import 'package:flutter/material.dart';
import 'package:youpass/features/favorites/presentation/favorites_design_spec.dart';

class ProducerEventBuyTicketButtonWidget extends StatelessWidget {
  const ProducerEventBuyTicketButtonWidget({
    super.key,
    required this.label,
    this.onPressed,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: FavoritesDesignSpec.px(context, 38),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: FavoritesDesignSpec.buyAccent,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              FavoritesDesignSpec.px(context, 10),
            ),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: FavoritesDesignSpec.px(context, 11),
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }
}
