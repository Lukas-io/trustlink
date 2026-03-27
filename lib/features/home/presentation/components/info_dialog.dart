import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class InfoDialog extends StatelessWidget {
  const InfoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Transaction Statuses",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(height: 16),
              _statusRow(
                color: AppColors.pendingText,
                bg: AppColors.pendingBg,
                icon: Icons.schedule,
                title: "Pending",
                description:
                    "Awaiting verification by the receiver. The sender's PIN is needed to confirm.",
              ),
              _statusRow(
                color: AppColors.completedText,
                bg: AppColors.completedBg,
                icon: Icons.check_circle_outline,
                title: "Completed",
                description:
                    "Successfully verified and settled. No further action needed.",
              ),
              _statusRow(
                color: AppColors.canceledText,
                bg: AppColors.canceledBg,
                icon: Icons.cancel_outlined,
                title: "Cancelled",
                description:
                    "Cancelled by the sender. A refund may be in progress — the receiver's PIN completes it.",
              ),
              _statusRow(
                color: AppColors.refundedText,
                bg: AppColors.refundedBg,
                icon: Icons.replay,
                title: "Refunded",
                description:
                    "Funds have been returned. The refund process is complete.",
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

  Widget _statusRow({
    required Color color,
    required Color bg,
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
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
    );
  }
}
