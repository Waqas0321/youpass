import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youpass/features/auth/presentation/providers/auth_provider.dart';
import 'package:youpass/features/ticket_assignment/presentation/providers/ticket_assignment_provider.dart';
import 'package:youpass/routes/app_routes.dart';

class TicketAssignmentScreenActions {
  const TicketAssignmentScreenActions(this.context);

  final BuildContext context;

  Future<void> handleSessionInvalid(TicketAssignmentProvider provider) async {
    if (provider.errorCode != 'SESSION_INVALID' &&
        provider.errorCode != 'UNAUTHORIZED') {
      return;
    }

    await context.read<AuthProvider>().logout();
    if (!context.mounted) {
      return;
    }

    await Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.login,
      (_) => false,
    );
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
