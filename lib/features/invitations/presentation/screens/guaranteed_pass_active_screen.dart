import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';
import 'package:youpass/features/invitations/presentation/routes/guaranteed_pass_active_route_args.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitation_filled_action_button_widget.dart';
import 'package:youpass/routes/app_routes.dart';

class GuaranteedPassActiveScreen extends StatelessWidget {
  const GuaranteedPassActiveScreen({super.key, required this.args});

  final GuaranteedPassActiveRouteArgs args;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(InvitationsDesignSpec.px(context, 24)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.verified,
                size: InvitationsDesignSpec.px(context, 72),
                color: InvitationsDesignSpec.guaranteedTypeGold,
              ),
              SizedBox(height: InvitationsDesignSpec.px(context, 20)),
              Text(
                AppStrings.invitationsGpActiveTitle(strings),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: InvitationsDesignSpec.px(context, 24),
                  fontWeight: FontWeight.w800,
                  color: InvitationsDesignSpec.guaranteedTypeGold,
                ),
              ),
              SizedBox(height: InvitationsDesignSpec.px(context, 12)),
              Text(
                AppStrings.invitationsGpActiveMessage(
                  strings,
                  args.eventTitle,
                  args.cancellationDeadlineLabel ?? '—',
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: InvitationsDesignSpec.px(context, 15),
                  height: 1.4,
                ),
              ),
              SizedBox(height: InvitationsDesignSpec.px(context, 28)),
              InvitationFilledActionButtonWidget(
                label: AppStrings.invitationsGpActiveCta(strings),
                backgroundColor: InvitationsDesignSpec.guaranteedTypeGold,
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    AppRoutes.home,
                    (_) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
