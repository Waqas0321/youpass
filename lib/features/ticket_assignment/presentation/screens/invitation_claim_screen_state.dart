import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/l10n/ticket_assignment_error_extension.dart';
import 'package:youpass/core/theme/tickets_screen_theme.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/features/ticket_assignment/presentation/providers/ticket_assignment_load_status.dart';
import 'package:youpass/features/home/presentation/utils/app_drawer_navigation.dart';
import 'package:youpass/features/ticket_assignment/presentation/providers/ticket_assignment_provider.dart';
import 'package:youpass/features/ticket_assignment/presentation/screens/invitation_claim_screen.dart';
import 'package:youpass/features/tickets/presentation/tickets_design_spec.dart';
import 'package:youpass/l10n/app_localizations.dart';
import 'package:youpass/routes/app_routes.dart';

class InvitationClaimScreenState extends State<InvitationClaimScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      context.read<TicketAssignmentProvider>().loadClaim(widget.token);
    });
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final provider = context.watch<TicketAssignmentProvider>();

    return AppDrawerNavigation.wrap(
      scaffoldKey: scaffoldKey,
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          AppStrings.invitationClaimTitle(strings),
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: TicketsScreenTheme.accent(context),
          ),
        ),
        actions: [
          AppDrawerNavigation.menuIconButton(
            context: context,
            scaffoldKey: scaffoldKey,
          ),
        ],
      ),
      body: buildBody(context, provider, strings),
    );
  }

  Widget buildBody(
    BuildContext context,
    TicketAssignmentProvider provider,
    AppLocalizations strings,
  ) {
    if (provider.claimStatus == TicketAssignmentLoadStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.claimStatus == TicketAssignmentLoadStatus.error) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(
            TicketsDesignSpec.px(context, TicketsDesignSpec.horizontalPadding),
          ),
          child: AppText(
            provider.localizedErrorMessage(strings) ??
                AppStrings.errorGeneric(strings),
            variant: AppTextVariant.body,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    final claim = provider.claim;
    if (claim == null) {
      return const SizedBox.shrink();
    }

    return ListView(
      padding: EdgeInsets.all(
        TicketsDesignSpec.px(context, TicketsDesignSpec.horizontalPadding),
      ),
      children: [
        Text(
          claim.eventTitle,
          style: TextStyle(
            fontSize: TicketsDesignSpec.px(context, 22),
            fontWeight: FontWeight.w700,
            color: TicketsScreenTheme.title(context),
          ),
        ),
        SizedBox(height: TicketsDesignSpec.px(context, 16)),
        Text(
          '${AppStrings.invitationClaimGuestLabel(strings)}: ${claim.guestName}',
          style: TextStyle(
            fontSize: TicketsDesignSpec.px(context, 15),
            color: TicketsScreenTheme.body(context),
          ),
        ),
        SizedBox(height: TicketsDesignSpec.px(context, 8)),
        Text(
          '${AppStrings.invitationClaimInvitedByLabel(strings)}: ${claim.invitedBy}',
          style: TextStyle(
            fontSize: TicketsDesignSpec.px(context, 15),
            color: TicketsScreenTheme.body(context),
          ),
        ),
        SizedBox(height: TicketsDesignSpec.px(context, 24)),
        Text(
          AppStrings.invitationClaimStepsTitle(strings),
          style: TextStyle(
            fontSize: TicketsDesignSpec.px(context, 16),
            fontWeight: FontWeight.w700,
            color: TicketsScreenTheme.title(context),
          ),
        ),
        SizedBox(height: TicketsDesignSpec.px(context, 12)),
        ...claim.steps.map(
          (step) => Padding(
            padding: EdgeInsets.only(
              bottom: TicketsDesignSpec.px(context, 10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.check_circle_outline,
                  size: TicketsDesignSpec.px(context, 18),
                  color: TicketsScreenTheme.accent(context),
                ),
                SizedBox(width: TicketsDesignSpec.px(context, 10)),
                Expanded(
                  child: Text(
                    step,
                    style: TextStyle(
                      fontSize: TicketsDesignSpec.px(context, 14),
                      color: TicketsScreenTheme.body(context),
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: TicketsDesignSpec.px(context, 24)),
        FilledButton(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.login,
              (_) => false,
            );
          },
          child: Text(AppStrings.invitationClaimLoginRegister(strings)),
        ),
        SizedBox(height: TicketsDesignSpec.px(context, 12)),
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.myInvitations);
          },
          child: Text(AppStrings.invitationClaimOpenInvitations(strings)),
        ),
      ],
    );
  }
}
