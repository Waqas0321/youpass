import 'package:flutter/material.dart';
import 'package:youpass/features/ticket_assignment/presentation/screens/assign_tickets_screen_state.dart';

class AssignTicketsScreen extends StatefulWidget {
  const AssignTicketsScreen({
    super.key,
    required this.ticketId,
    this.orderId,
  });

  final String ticketId;
  final String? orderId;

  @override
  State<AssignTicketsScreen> createState() => AssignTicketsScreenState();
}
