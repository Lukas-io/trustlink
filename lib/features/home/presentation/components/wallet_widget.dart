import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class WalletWidget extends StatelessWidget {
  const WalletWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Wallet Balance",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: AppColors.grey),
            ),
            Text(
              "₦23,2333",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}
