import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/youpass_bottom_nav_bar.dart';
import 'package:youpass/features/home/presentation/screens/home_screen.dart';
import 'package:youpass/core/navigation/invitation_deep_link_service.dart';
import 'package:youpass/features/invitations/presentation/providers/invitations_provider.dart';
import 'package:youpass/features/invitations/presentation/screens/my_invitations_screen.dart';
import 'package:youpass/features/invitations/presentation/utils/invitation_detail_navigation.dart';
import 'package:youpass/features/tickets/presentation/providers/tickets_provider.dart';
import 'package:youpass/features/tickets/presentation/screens/my_tickets_screen.dart';

class MainShellScreen extends StatefulWidget {
  const MainShellScreen({super.key});

  @override
  State<MainShellScreen> createState() => MainShellScreenState();
}

class MainShellScreenState extends State<MainShellScreen> {
  int selectedIndex = 0;

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

    setState(() => selectedIndex = 1);

    final destination = invitation != null
        ? InvitationDetailNavigation.resolve(invitation)
        : InvitationDetailNavigation.resolveById(invitationId);

    await Navigator.of(context).pushNamed(
      destination.route,
      arguments: destination.args,
    );
  }

  void onTabSelected(int index) {
    if (selectedIndex == index) {
      return;
    }
    setState(() => selectedIndex = index);
    if (index == 1) {
      context.read<InvitationsProvider>().ensureLoaded();
    } else if (index == 2) {
      context.read<TicketsProvider>().ensureUpcomingLoaded();
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final invitationsProvider = context.watch<InvitationsProvider>();

    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: const [
          HomeScreen(),
          MyInvitationsScreen(embeddedInShell: true),
          MyTicketsScreen(embeddedInShell: true),
        ],
      ),
      bottomNavigationBar: YouPassBottomNavBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: onTabSelected,
        destinations: [
          YouPassBottomNavDestination(
            icon: Icons.home_outlined,
            selectedIcon: Icons.home_rounded,
            label: AppStrings.bottomNavHome(strings),
          ),
          YouPassBottomNavDestination(
            icon: Icons.mail_outline_rounded,
            selectedIcon: Icons.mail_rounded,
            label: AppStrings.bottomNavInvitations(strings),
            badgeCount: invitationsProvider.invitationsBadgeCount,
          ),
          YouPassBottomNavDestination(
            icon: Icons.confirmation_number_outlined,
            selectedIcon: Icons.confirmation_number_rounded,
            label: AppStrings.bottomNavTickets(strings),
          ),
        ],
      ),
    );
  }
}
