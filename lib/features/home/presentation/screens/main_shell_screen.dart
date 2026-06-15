import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/navigation/invitation_deep_link_service.dart';
import 'package:youpass/features/home/presentation/screens/home_screen.dart';
import 'package:youpass/features/invitations/presentation/providers/invitations_provider.dart';
import 'package:youpass/features/invitations/presentation/utils/invitation_detail_navigation.dart';
import 'package:youpass/features/tickets/presentation/providers/tickets_provider.dart';

class MainShellScreen extends StatefulWidget {
  const MainShellScreen({super.key});

  @override
  State<MainShellScreen> createState() => MainShellScreenState();
}

class MainShellScreenState extends State<MainShellScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      context.read<TicketsProvider>().ensureUpcomingLoaded();
      context.read<InvitationsProvider>().ensureLoaded();
      _openPendingInvitationDeepLink();
    });
  }

  Future<void> _openPendingInvitationDeepLink() async {
    final invitationId = InvitationDeepLinkService.consumePendingInvitationId();
    if (invitationId == null || !mounted) {
      return;
    }

    final invitationsProvider = context.read<InvitationsProvider>();
    await invitationsProvider.ensureLoaded();
    final matches = invitationsProvider.invitations
        .where((item) => item.id == invitationId);
    final invitation = matches.isEmpty ? null : matches.first;

    if (!mounted) {
      return;
    }

    final destination = invitation != null
        ? InvitationDetailNavigation.resolve(invitation)
        : InvitationDetailNavigation.resolveById(invitationId);

    await Navigator.of(context).pushNamed(
      destination.route,
      arguments: destination.args,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}
