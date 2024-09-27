import 'package:flutter/material.dart';
import 'package:trustlink/features/home/presentation/components/recent_transactions.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Transactions"),
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
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [RecentTransactions()],
          ),
        ),
      ),
    );
  }
}
