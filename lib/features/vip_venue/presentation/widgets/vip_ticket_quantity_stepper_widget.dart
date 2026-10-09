import 'package:flutter/material.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_design_spec.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_screen_theme.dart';

class VipTicketQuantityStepperWidget extends StatelessWidget {
  const VipTicketQuantityStepperWidget({
    super.key,
    required this.quantity,
    required this.onChanged,
    this.minQuantity = 0,
    this.maxQuantity,
    this.alignControlsEnd = false,
    this.accentColor,
  });

  final int quantity;
  final ValueChanged<int> onChanged;
  final int minQuantity;

  /// Upper bound (e.g. per-user ticket limit); null = no cap.
  final int? maxQuantity;
  final bool alignControlsEnd;
  final Color? accentColor;

  @override
  Widget build(BuildContext context) {
    final accent = accentColor ?? VipVenueScreenTheme.accent(context);
    final barHeight = VipVenueDesignSpec.px(context, 40);
    final buttonSize = VipVenueDesignSpec.px(context, 28);
    final canIncrement = maxQuantity == null || quantity < maxQuantity!;

    final controls = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        VipQuantityStepperButtonWidget(
          icon: Icons.remove,
          onPressed: quantity > minQuantity ? () => onChanged(quantity - 1) : null,
          size: buttonSize,
          filled: false,
        ),
        SizedBox(width: VipVenueDesignSpec.px(context, 12)),
        AppText(
          '$quantity',
          variant: AppTextVariant.bodyEmphasis,
          color: VipVenueScreenTheme.title(context),
          fontSize: VipVenueDesignSpec.px(context, 16),
          fontWeight: FontWeight.w800,
        ),
        SizedBox(width: VipVenueDesignSpec.px(context, 12)),
        _absorbWhenCapped(
          canIncrement,
          VipQuantityStepperButtonWidget(
            icon: Icons.add,
            onPressed: canIncrement ? () => onChanged(quantity + 1) : null,
            size: buttonSize,
            filled: true,
            accent: accent,
          ),
        ),
      ],
    );

    return SizedBox(
      height: barHeight,
      child: alignControlsEnd
          ? Row(
              children: [
                const Spacer(),
                controls,
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                VipQuantityStepperButtonWidget(
                  icon: Icons.remove,
                  onPressed:
                      quantity > minQuantity ? () => onChanged(quantity - 1) : null,
                  size: buttonSize,
                  filled: false,
                ),
                AppText(
                  '$quantity',
                  variant: AppTextVariant.bodyEmphasis,
                  color: VipVenueScreenTheme.title(context),
                  fontSize: VipVenueDesignSpec.px(context, 16),
                  fontWeight: FontWeight.w800,
                ),
                _absorbWhenCapped(
                  canIncrement,
                  VipQuantityStepperButtonWidget(
                    icon: Icons.add,
                    onPressed: canIncrement ? () => onChanged(quantity + 1) : null,
                    size: buttonSize,
                    filled: true,
                    accent: accent,
                  ),
                ),
              ],
            ),
    );
  }
}

/// A disabled "+" must swallow taps; otherwise they reach the parent ticket card,
/// whose tap toggles the selection off.
Widget _absorbWhenCapped(bool canIncrement, Widget button) {
  if (canIncrement) {
    return button;
  }
  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () {},
    child: button,
  );
}

class VipQuantityStepperButtonWidget extends StatelessWidget {
  const VipQuantityStepperButtonWidget({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.size,
    required this.filled,
    this.accent,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final double size;
  final bool filled;
  final Color? accent;

  @override
  Widget build(BuildContext context) {
    final disabled = onPressed == null;
    final background = filled && !disabled
        ? accent ?? VipVenueScreenTheme.accent(context)
        : VipVenueScreenTheme.stepperButtonBackground(context);
    final iconColor = filled && !disabled
        ? Colors.white
        : onPressed == null
            ? VipVenueScreenTheme.muted(context)
            : VipVenueScreenTheme.title(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: background,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: VipVenueDesignSpec.px(context, 16),
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
