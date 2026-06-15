import 'package:flutter/material.dart';
import 'package:youpass/dependency_injection/injection_container.dart';
import 'package:youpass/features/invitations/domain/repositories/invitations_repository.dart';
import 'package:youpass/features/invitations/presentation/providers/invitations_provider.dart';
import 'package:youpass/features/invitations/presentation/utils/guaranteed_pass_flow_actions.dart';
import 'package:youpass/features/invitations/presentation/utils/invitations_screen_actions.dart';
import 'package:youpass/features/home/presentation/providers/home_provider.dart';
import 'package:youpass/features/waitlist/domain/entities/waitlist_entry_entity.dart';
import 'package:youpass/features/waitlist/presentation/dialogs/leave_waitlist_dialog.dart';
import 'package:youpass/features/waitlist/presentation/screens/join_waitlist_screen.dart';
import 'package:provider/provider.dart';

class WaitlistFlowActions {
  WaitlistFlowActions(this.context);

  final BuildContext context;
  final InvitationsRepository _repository = sl<InvitationsRepository>();

  Future<void> openJoinScreen({
    required String eventId,
    required String eventTitle,
  }) async {
    final joined = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => JoinWaitlistScreen(eventId: eventId, eventTitle: eventTitle),
      ),
    );

    if (joined == true && context.mounted) {
      await context.read<InvitationsProvider>().loadInvitations(force: true);
      if (context.mounted) {
        await context.read<HomeProvider>().refreshHome();
      }
    }
  }

  Future<void> leaveWaitlistForEvent({
    required String eventId,
  }) async {
    final confirmed = await LeaveWaitlistDialog.show(context);
    if (!confirmed || !context.mounted) {
      return;
    }

    try {
      await _repository.leaveWaitlist(eventId);
      if (context.mounted) {
        await context.read<InvitationsProvider>().loadInvitations(force: true);
        await context.read<HomeProvider>().refreshHome();
      }
    } catch (error) {
      if (context.mounted) {
        InvitationsScreenActions(context).showError(error.toString());
      }
    }
  }

  Future<void> leaveWaitlist(WaitlistEntryEntity entry) async {
    final confirmed = await LeaveWaitlistDialog.show(context);
    if (!confirmed || !context.mounted) {
      return;
    }

    try {
      await _repository.leaveWaitlist(entry.eventId);
      if (context.mounted) {
        await context.read<InvitationsProvider>().loadInvitations(force: true);
        await context.read<HomeProvider>().refreshHome();
      }
    } catch (error) {
      if (context.mounted) {
        InvitationsScreenActions(context).showError(error.toString());
      }
    }
  }

  Future<void> claimSlot(WaitlistEntryEntity entry) async {
    final offerId = entry.offerId;
    if (offerId == null) {
      return;
    }

    try {
      final invitation = await _repository.claimWaitlistOffer(offerId);
      if (!context.mounted) {
        return;
      }

      await context.read<InvitationsProvider>().loadInvitations(force: true);
      await GuaranteedPassFlowActions(context).acceptFromList(invitation);
    } catch (error) {
      if (context.mounted) {
        InvitationsScreenActions(context).showError(error.toString());
      }
    }
  }
}
