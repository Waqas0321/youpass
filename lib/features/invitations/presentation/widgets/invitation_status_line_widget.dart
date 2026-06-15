import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_status.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_status_extensions.dart';
import 'package:youpass/core/theme/invitations_screen_theme.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';
import 'package:youpass/features/invitations/presentation/utils/invitations_text_factory.dart';

class InvitationStatusLineWidget extends StatelessWidget {
  const InvitationStatusLineWidget({
    super.key,
    required this.status,
  });

  final InvitationStatus status;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final isConfirmed = status.isAccepted;
    final statusColor = isConfirmed
        ? InvitationsDesignSpec.statusConfirmed
        : InvitationsDesignSpec.statusPending;
    final statusLabel = InvitationsTextFactory.statusLabel(strings, status);

    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: InvitationsDesignSpec.px(context, 12),
          fontWeight: FontWeight.w600,
          color: InvitationsScreenTheme.body(context),
          height: 1.3,
        ),
        children: [
          TextSpan(text: '${AppStrings.invitationsStatusPrefix(strings)} '),
          TextSpan(
            text: statusLabel,
            style: TextStyle(color: statusColor),
          ),
        ],
      ),
    );
  }
}
