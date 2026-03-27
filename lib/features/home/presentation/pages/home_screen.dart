import 'package:flutter/material.dart';

import '../../../../core/components/page_info_dialog.dart';
import '../../../../core/constants/app_colors.dart';
import '../components/quick_items.dart';
import '../components/recent_transactions.dart';
import '../components/wallet_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _showHomeInfo(BuildContext context) {
    showPageInfoDialog(
      context: context,
      title: "Your Dashboard",
      items: const [
        InfoItem(
          icon: Icons.account_balance_wallet_outlined,
          title: "Wallet Balance",
          description:
              "Your available balance. Tap 'Fund Wallet' to add money via bank transfer or card.",
        ),
        InfoItem(
          icon: Icons.flash_on_outlined,
          title: "Quick Actions",
          description:
              "Create payment links, transfer funds to other users, or withdraw to your bank.",
        ),
        InfoItem(
          icon: Icons.receipt_long_outlined,
          title: "Recent Transactions",
          description:
              "Your latest escrow transactions. Tap any to view full details or take action.",
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Account"),
        centerTitle: false,
        titleSpacing: 24,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () => _showHomeInfo(context),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.outline.withOpacity(0.3),
                  ),
                ),
                child: const Icon(
                  Icons.info_outline,
                  size: 20,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 4),
              const WalletWidget(),
              const SizedBox(height: 4),
              const QuickItems(),
              const SizedBox(height: 4),
              const RecentTransactions(),
              Padding(padding: MediaQuery.paddingOf(context)),
            ],
          ),
        ),
      ),
    );
  }
}
