import 'package:flutter/material.dart';
import 'package:youpass/features/home/presentation/party_drinks/party_drinks_design_spec.dart';

class PartyDrinkQuantityStepperWidget extends StatelessWidget {
  const PartyDrinkQuantityStepperWidget({
    super.key,
    required this.quantity,
    required this.onDecrement,
    required this.onIncrement,
  });

  final int quantity;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  @override
  Widget build(BuildContext context) {
    final buttonSize = PartyDrinksDesignSpec.px(context, 36);
    final gap = PartyDrinksDesignSpec.px(context, 16);

    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _StepperBorderedButton(
            size: buttonSize,
            icon: Icons.remove,
            onTap: quantity > 0 ? onDecrement : null,
          ),
          SizedBox(width: gap),
          Text(
            '$quantity',
            style: TextStyle(
              fontSize: PartyDrinksDesignSpec.px(context, 15),
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(width: gap),
          _StepperBorderedButton(
            size: buttonSize,
            icon: Icons.add,
            onTap: onIncrement,
          ),
        ],
      ),
    );
  }
}

class _StepperBorderedButton extends StatelessWidget {
  const _StepperBorderedButton({
    required this.size,
    required this.icon,
    required this.onTap,
  });

  final double size;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final color = PartyDrinksDesignSpec.gold;
    final iconColor = onTap == null ? color.withValues(alpha: 0.35) : color;
    const borderSide = BorderSide(color: PartyDrinksDesignSpec.gold, width: 1);

    return SizedBox(
      width: size,
      height: size,
      child: Material(
        color: PartyDrinksDesignSpec.cardBackground,
        shape: RoundedRectangleBorder(
          borderRadius: PartyDrinksDesignSpec.stepperButtonBorderRadius,
          side: borderSide,
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: Icon(
              icon,
              size: PartyDrinksDesignSpec.px(context, 16),
              color: iconColor,
            ),
          ),
        ),
      ),
    );
  }
}
