import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_design_spec.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_screen_theme.dart';
import 'package:youpass/features/vip_venue/presentation/widgets/vip_primary_button_widget.dart';

class PurchaseSuccessDialog {
  PurchaseSuccessDialog._();

  static Future<void> show(
    BuildContext context, {
    required int ticketCount,
    required VoidCallback onAssignTickets,
    required VoidCallback onGoToMyTickets,
    required VoidCallback onViewQr,
    required VoidCallback onClose,
  }) {
    final strings = context.l10n;
    final canAssignTickets = ticketCount > 1;

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        final closeSize = VipVenueDesignSpec.px(context, 36);

        return Dialog(
          backgroundColor: VipVenueScreenTheme.dialogBackground(context),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(VipVenueDesignSpec.px(context, 20)),
          ),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(VipVenueDesignSpec.px(context, 24)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green.shade600,
                      size: VipVenueDesignSpec.px(context, 56),
                    ),
                    SizedBox(height: VipVenueDesignSpec.px(context, 16)),
                    AppText(
                      AppStrings.vipPurchaseSuccessTitle(strings),
                      textAlign: TextAlign.center,
                      variant: AppTextVariant.bodyEmphasis,
                      color: VipVenueScreenTheme.title(context),
                      fontSize: VipVenueDesignSpec.px(context, 18),
                      fontWeight: FontWeight.w800,
                    ),
                    SizedBox(height: VipVenueDesignSpec.px(context, 8)),
                    AppText(
                      AppStrings.vipPurchaseSuccessMessage(strings),
                      textAlign: TextAlign.center,
                      variant: AppTextVariant.body,
                      color: VipVenueScreenTheme.body(context),
                      fontSize: VipVenueDesignSpec.px(context, 14),
                    ),
                    SizedBox(height: VipVenueDesignSpec.px(context, 20)),
                    VipPrimaryButtonWidget(
                      label: canAssignTickets
                          ? AppStrings.ticketAssignmentTitle(strings)
                          : AppStrings.vipPurchaseGoToMyTickets(strings),
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                        if (canAssignTickets) {
                          onAssignTickets();
                        } else {
                          onGoToMyTickets();
                        }
                      },
                    ),
                    SizedBox(height: VipVenueDesignSpec.px(context, 10)),
                    VipSecondaryButtonWidget(
                      label: AppStrings.vipViewQr(strings),
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                        onViewQr();
                      },
                    ),
                  ],
                ),
              ),
              Positioned(
                top: VipVenueDesignSpec.px(context, 8),
                right: VipVenueDesignSpec.px(context, 8),
                child: SizedBox(
                  width: closeSize,
                  height: closeSize,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints.tightFor(
                      width: closeSize,
                      height: closeSize,
                    ),
                    tooltip: MaterialLocalizations.of(dialogContext)
                        .closeButtonTooltip,
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                      onClose();
                    },
                    icon: Icon(
                      Icons.close,
                      size: VipVenueDesignSpec.px(context, 22),
                      color: VipVenueScreenTheme.muted(context),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
