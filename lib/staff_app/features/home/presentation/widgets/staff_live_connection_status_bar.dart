import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import 'package:youpass/staff_app/core/network/staff_connectivity.dart';
import 'package:youpass/staff_app/features/home/presentation/widgets/staff_connection_status_bar.dart';

/// Live network status for staff screens (fixes hardcoded Online in airplane mode).
class StaffLiveConnectionStatusBar extends StatefulWidget {
  const StaffLiveConnectionStatusBar({
    super.key,
    this.validatorLabel,
    this.style = StaffConnectionStatusStyle.standard,
  });

  final String? validatorLabel;
  final StaffConnectionStatusStyle style;

  @override
  State<StaffLiveConnectionStatusBar> createState() =>
      _StaffLiveConnectionStatusBarState();
}

class _StaffLiveConnectionStatusBarState
    extends State<StaffLiveConnectionStatusBar> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _subscription;
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    unawaited(_refresh());
    _subscription = _connectivity.onConnectivityChanged.listen((results) {
      if (!mounted) return;
      setState(() => _isConnected = staffHasUsableNetwork(results));
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  Future<void> _refresh() async {
    final results = await _connectivity.checkConnectivity();
    if (!mounted) return;
    setState(() => _isConnected = staffHasUsableNetwork(results));
  }

  @override
  Widget build(BuildContext context) {
    return StaffConnectionStatusBar(
      isConnected: _isConnected,
      isOnline: _isConnected,
      validatorLabel: widget.validatorLabel,
      style: widget.style,
    );
  }
}
