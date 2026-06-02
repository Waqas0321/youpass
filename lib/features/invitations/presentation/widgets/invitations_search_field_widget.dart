import 'package:flutter/material.dart';
import 'package:youpass/core/widgets/youpass_search_field_widget.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';

class InvitationsSearchFieldWidget extends StatelessWidget {
  const InvitationsSearchFieldWidget({
    super.key,
    required this.hintText,
    this.onChanged,
  });

  final String hintText;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return YouPassSearchFieldWidget(
      hintText: hintText,
      onChanged: onChanged,
      fillColor: const Color(0xFFF5F5F5),
      borderColor: InvitationsDesignSpec.cardBorder,
      focusedBorderColor: InvitationsDesignSpec.primary,
      hintColor: InvitationsDesignSpec.bodyText,
      iconColor: InvitationsDesignSpec.metaIcon,
    );
  }
}
