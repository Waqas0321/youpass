import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/home/presentation/party_drinks/party_drinks_design_spec.dart';

class PartyDrinkQrAcceptedDialog extends StatefulWidget {
  const PartyDrinkQrAcceptedDialog({
    super.key,
    this.autoDismissAfter = const Duration(seconds: 3),
  });

  final Duration autoDismissAfter;

  static Future<void> show(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withValues(alpha: 0.72),
      builder: (_) => const PartyDrinkQrAcceptedDialog(),
    );
  }

  @override
  State<PartyDrinkQrAcceptedDialog> createState() =>
      _PartyDrinkQrAcceptedDialogState();
}

class _PartyDrinkQrAcceptedDialogState extends State<PartyDrinkQrAcceptedDialog> {
  static const _successGreen = Color(0xFF22C55E);

  @override
  void initState() {
    super.initState();
    Future<void>.delayed(widget.autoDismissAfter, () {
      if (!mounted) {
        return;
      }
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final radius = PartyDrinksDesignSpec.px(context, 20);

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: EdgeInsets.symmetric(
        horizontal: PartyDrinksDesignSpec.px(context, 32),
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(
          PartyDrinksDesignSpec.px(context, 24),
          PartyDrinksDesignSpec.px(context, 28),
          PartyDrinksDesignSpec.px(context, 24),
          PartyDrinksDesignSpec.px(context, 28),
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF121212),
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: _successGreen.withValues(alpha: 0.55)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: PartyDrinksDesignSpec.px(context, 72),
              height: PartyDrinksDesignSpec.px(context, 72),
              decoration: BoxDecoration(
                color: _successGreen.withValues(alpha: 0.16),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle_rounded,
                color: _successGreen,
                size: PartyDrinksDesignSpec.px(context, 42),
              ),
            ),
            SizedBox(height: PartyDrinksDesignSpec.px(context, 18)),
            Text(
              AppStrings.partyDrinkQrAcceptedTitle(strings),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: PartyDrinksDesignSpec.px(context, 18),
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: PartyDrinksDesignSpec.px(context, 8)),
            Text(
              AppStrings.partyDrinkQrAcceptedMessage(strings),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.78),
                fontSize: PartyDrinksDesignSpec.px(context, 14),
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
