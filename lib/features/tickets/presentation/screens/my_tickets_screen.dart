import 'package:flutter/material.dart';
import 'package:youpass/core/services/screen_secure_service.dart';
import 'package:youpass/features/tickets/presentation/screens/my_tickets_screen_state.dart';

class MyTicketsScreen extends StatefulWidget {
  const MyTicketsScreen({
    super.key,
    this.embeddedInShell = false,
    this.screenSecureService,
  });

  final bool embeddedInShell;
  final ScreenSecureService? screenSecureService;

  @override
  State<MyTicketsScreen> createState() => MyTicketsScreenState();
}
