import 'package:flutter/material.dart';
import 'package:youpass/features/home/presentation/party_drinks/models/party_drink_orders_list_mode.dart';
import 'package:youpass/features/home/presentation/screens/party_drink_orders_list_screen.dart';

class PartyDrinkPurchasesScreen extends StatelessWidget {
  const PartyDrinkPurchasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PartyDrinkOrdersListScreen(
      mode: PartyDrinkOrdersListMode.purchases,
    );
  }
}
