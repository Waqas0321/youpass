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
  });

  final int quantity;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final accent = VipVenueScreenTheme.accent(context);
    final barHeight = VipVenueDesignSpec.px(context, 40);
    final buttonSize = VipVenueDesignSpec.px(context, 28);

    return Container(
      height: barHeight,
      padding: EdgeInsets.symmetric(
        horizontal: VipVenueDesignSpec.px(context, 6),
      ),
      decoration: BoxDecoration(
        color: VipVenueScreenTheme.stepperBarBackground(context),
        borderRadius: BorderRadius.circular(barHeight / 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          VipQuantityStepperButtonWidget(
            icon: Icons.remove,
            onPressed: quantity > 0 ? () => onChanged(quantity - 1) : null,
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
          VipQuantityStepperButtonWidget(
            icon: Icons.add,
            onPressed: () => onChanged(quantity + 1),
            size: buttonSize,
            filled: true,
            accent: accent,
          ),
        ],
      ),
    );
  }
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
    final background = filled
        ? accent ?? VipVenueScreenTheme.accent(context)
        : VipVenueScreenTheme.stepperButtonBackground(context);
    final iconColor = filled
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
