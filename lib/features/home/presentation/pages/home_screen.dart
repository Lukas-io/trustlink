import 'package:flutter/material.dart';

import '../components/quick_items.dart';
import '../components/recent_transactions.dart';
import '../components/wallet_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Account"),
        centerTitle: false,
        titleSpacing: 24,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 24.0),
            child: Icon(Icons.info_outline),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const WalletWidget(),
              const QuickItems(),
              const RecentTransactions(),
              Padding(padding: MediaQuery.paddingOf(context)),
            ],
          ),
        ),
      ),
    );
  }
}
