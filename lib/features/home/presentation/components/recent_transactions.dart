import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class RecentTransactions extends StatelessWidget {
  final int transactionLength;

  const RecentTransactions({
    super.key,
    this.transactionLength = 5,
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
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recent Transactions",
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: AppColors.grey),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "View all",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.grey,
                          ),
                    ),
                    const Icon(
                      CupertinoIcons.forward,
                      color: AppColors.grey,
                      size: 16.0,
                    )
                  ],
                ),
              ],
            ),
            ListView.separated(
                padding: const EdgeInsets.only(top: 0),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundColor: AppColors.grey.withOpacity(0.1),
                      child: const Icon(
                        CupertinoIcons.archivebox,
                        size: 28.0,
                        color: AppColors.primary,
                      ),
                    ),
                    title: Text(
                      "Transactions Descriptions",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    subtitle: Text(
                      "Transactions Date",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "+23,000",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 2.0, vertical: 1.0),
                          decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(4.0)),
                          child: Text(
                            "Completed".toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    color: Colors.red,
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                  );
                },
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return const Divider(
                    height: 0.0,
                    color: AppColors.grey,
                    thickness: 0.2,
                  );
                },
                itemCount: transactionLength)
          ],
        ),
      ),
    );
  }
}
