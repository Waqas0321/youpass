import 'package:flutter/material.dart';
import 'package:youpass/features/ticket_assignment/presentation/screens/invitation_claim_screen_state.dart';

class InvitationClaimScreen extends StatefulWidget {
  const InvitationClaimScreen({super.key, required this.token});

  final String token;

  @override
  State<InvitationClaimScreen> createState() => InvitationClaimScreenState();
}
