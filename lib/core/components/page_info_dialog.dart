import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class InfoItem {
  final IconData icon;
  final String title;
  final String description;

  const InfoItem({
    required this.icon,
    required this.title,
    required this.description,
  });
}

void showPageInfoDialog({
  required BuildContext context,
  required String title,
  required List<InfoItem> items,
}) {
  showCupertinoDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 16),
            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        item.icon,
                        size: 18,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppColors.text,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            item.description,
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Got it",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
