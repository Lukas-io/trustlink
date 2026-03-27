import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trustlink/features/home/presentation/pages/create_link_screen.dart';
import 'package:trustlink/features/home/presentation/pages/withdraw_screen.dart';

import '../../../../core/constants/app_colors.dart';
import '../pages/transfer_screen.dart';

class QuickItems extends StatelessWidget {
  const QuickItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        spacing: 12,
        children: [
          Expanded(
            child: QuickItem(
              icon: CupertinoIcons.link,
              title: 'Create Link',
              color: AppColors.primary,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CreateLinkScreen()));
              },
            ),
          ),
          Expanded(
            child: QuickItem(
              icon: CupertinoIcons.paperplane,
              title: 'Transfer',
              color: AppColors.secondary,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const TransferScreen()));
              },
            ),
          ),
          Expanded(
            child: QuickItem(
              icon: CupertinoIcons.arrow_2_circlepath,
              title: 'Withdraw',
              color: AppColors.orange,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const WithdrawScreen()));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class QuickItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final Function() onPressed;

  const QuickItem({
    super.key,
    required this.icon,
    required this.title,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.shade100, width: 0.2)),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            spacing: 6,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 22,
                ),
              ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.text,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
