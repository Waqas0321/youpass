import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youpass/core/widgets/youpass_confirm_dialog.dart';

/// Intercepts the system back gesture on a root screen and asks before exiting.
class AppExitGuard extends StatefulWidget {
  const AppExitGuard({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<AppExitGuard> createState() => _AppExitGuardState();
}

class _AppExitGuardState extends State<AppExitGuard> {
  bool _isConfirming = false;

  Future<void> _onPopInvoked(bool didPop) async {
    if (didPop || _isConfirming) {
      return;
    }

    _isConfirming = true;
    final shouldExit = await YouPassConfirmDialog.showExitApp(context);
    _isConfirming = false;

    if (shouldExit && mounted) {
      SystemNavigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) => _onPopInvoked(didPop),
      child: widget.child,
    );
  }
}
