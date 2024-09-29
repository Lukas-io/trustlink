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
    return Card(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            QuickItem(
              icon: CupertinoIcons.link,
              title: 'Create Link',
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CreateLinkScreen()));
              },
            ),
            QuickItem(
              icon: CupertinoIcons.paperplane,
              title: 'Transfer',
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const TransferScreen()));
              },
            ),
            QuickItem(
              icon: CupertinoIcons.arrow_2_circlepath,
              title: 'Withdraw',
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const WithdrawScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class QuickItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function() onPressed;

  const QuickItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.grey.withOpacity(0.1),
                radius: 25.0,
                child: Icon(
                  icon,
                  color: AppColors.primary,
                  size: 30.0,
                ),
              ),
              Text(title)
            ],
          ),
        ),
      ),
    );
  }
}
