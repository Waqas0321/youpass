import 'package:flutter/material.dart';
import 'package:youpass/core/theme/invitations_screen_theme.dart';
import 'package:youpass/core/widgets/youpass_search_field_widget.dart';

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
      focusedBorderColor: InvitationsScreenTheme.accent(context),
    );
  }
}
