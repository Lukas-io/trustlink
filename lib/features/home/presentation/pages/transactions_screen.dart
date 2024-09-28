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
        child: Column(
          children: [
            SizedBox(
              height: 60.0,
              child: ListView(
                padding: EdgeInsets.only(left: 20.0),
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 12.0),
                    child: FilterChip(
                      label: Text("Pending"),
                      selected: true,
                      onSelected: (bool value) {},
                    ),
                  ),
                ],
              ),
            ),
            RecentTransactions()
          ],
        ),
      ),
    );
  }
}
