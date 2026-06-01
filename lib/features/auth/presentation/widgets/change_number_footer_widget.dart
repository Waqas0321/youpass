import 'package:flutter/material.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/auth_divider_link_footer_widget.dart';

class ChangeNumberFooterWidget extends StatelessWidget {
  const ChangeNumberFooterWidget({
    super.key,
    required this.onChangeNumber,
  });

  final VoidCallback onChangeNumber;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return AuthDividerLinkFooterWidget(
      caption: strings.incorrectNumberQuestion,
      linkLabel: strings.changeNumberLink,
      onLinkTap: onChangeNumber,
    );
  }
}
