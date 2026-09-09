import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';

class EventTicketQrAcceptedDialog extends StatefulWidget {
  const EventTicketQrAcceptedDialog({
    super.key,
    this.autoDismissAfter = const Duration(seconds: 3),
  });

  final Duration autoDismissAfter;

  static Future<void> show(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withValues(alpha: 0.72),
      builder: (_) => const EventTicketQrAcceptedDialog(),
    );
  }

  @override
  State<EventTicketQrAcceptedDialog> createState() =>
      _EventTicketQrAcceptedDialogState();
}

class _EventTicketQrAcceptedDialogState
    extends State<EventTicketQrAcceptedDialog> {
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
    final radius = InvitationsDesignSpec.px(context, 20);

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: EdgeInsets.symmetric(
        horizontal: InvitationsDesignSpec.px(context, 32),
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(
          InvitationsDesignSpec.px(context, 24),
          InvitationsDesignSpec.px(context, 28),
          InvitationsDesignSpec.px(context, 24),
          InvitationsDesignSpec.px(context, 28),
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
              width: InvitationsDesignSpec.px(context, 72),
              height: InvitationsDesignSpec.px(context, 72),
              decoration: BoxDecoration(
                color: _successGreen.withValues(alpha: 0.16),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle_rounded,
                color: _successGreen,
                size: InvitationsDesignSpec.px(context, 42),
              ),
            ),
            SizedBox(height: InvitationsDesignSpec.px(context, 18)),
            Text(
              AppStrings.entryTicketQrAcceptedTitle(strings),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: InvitationsDesignSpec.px(context, 18),
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: InvitationsDesignSpec.px(context, 8)),
            Text(
              AppStrings.entryTicketQrAcceptedMessage(strings),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.78),
                fontSize: InvitationsDesignSpec.px(context, 14),
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
