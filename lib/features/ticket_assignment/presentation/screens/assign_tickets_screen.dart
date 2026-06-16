import 'package:flutter/material.dart';
import 'package:youpass/features/ticket_assignment/presentation/screens/assign_tickets_screen_state.dart';

class AssignTicketsScreen extends StatefulWidget {
  const AssignTicketsScreen({
    super.key,
    required this.ticketId,
    this.orderId,
    this.isVip = false,
  });

  final String ticketId;
  final String? orderId;
  final bool isVip;

  @override
  State<AssignTicketsScreen> createState() => AssignTicketsScreenState();
}
