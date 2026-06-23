import 'package:flutter/material.dart';
import 'package:youpass/features/home/presentation/party_drinks/party_drinks_design_spec.dart';

class PartyDrinkCheckoutQuantityStepperWidget extends StatelessWidget {
  const PartyDrinkCheckoutQuantityStepperWidget({
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
    final height = PartyDrinksDesignSpec.px(
      context,
      PartyDrinksDesignSpec.checkoutStepperHeight,
    );
    final tapWidth = PartyDrinksDesignSpec.px(context, 30);
    final qtyWidth = PartyDrinksDesignSpec.px(context, 28);
    final radius = PartyDrinksDesignSpec.px(
      context,
      PartyDrinksDesignSpec.stepperButtonRadius,
    );
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: PartyDrinksDesignSpec.gold),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: height),
          child: IntrinsicHeight(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _StepperTap(
                  width: tapWidth,
                  label: '-',
                  onTap: quantity > 0 ? onDecrement : null,
                ),
                const _GoldDivider(),
                SizedBox(
                  width: qtyWidth,
                  child: Center(
                    child: Text(
                      '$quantity',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: PartyDrinksDesignSpec.px(context, 14),
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        height: 1,
                      ),
                    ),
                  ),
                ),
                const _GoldDivider(),
                _StepperTap(
                  width: tapWidth,
                  label: '+',
                  onTap: onIncrement,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GoldDivider extends StatelessWidget {
  const _GoldDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      color: PartyDrinksDesignSpec.gold,
    );
  }
}

class _StepperTap extends StatelessWidget {
  const _StepperTap({
    required this.width,
    required this.label,
    required this.onTap,
  });

  final double width;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final color = onTap == null
        ? PartyDrinksDesignSpec.gold.withValues(alpha: 0.35)
        : PartyDrinksDesignSpec.gold;

    return SizedBox(
      width: width,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: PartyDrinksDesignSpec.px(context, 17),
              fontWeight: FontWeight.w500,
              color: color,
              height: 1,
            ),
          ),
        ),
      ),
    );
  }
}
