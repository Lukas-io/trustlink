import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trustlink/features/auth/presentation/components/pin_widget.dart';
import 'package:trustlink/features/home/data/models/transaction/transaction_model.dart';
import 'package:trustlink/features/home/presentation/bloc/account_event.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/resources/enums.dart';
import '../../../../core/resources/global.dart';
import '../../../../injection_container.dart';
import '../bloc/account_bloc.dart';
import '../bloc/account_state.dart';

class TransactionDetailsScreen extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionDetailsScreen(this.transaction, {super.key});

  Color get _statusBgColor {
    switch (transaction.status) {
      case TransactionStatus.pending:
        return AppColors.pendingBg;
      case TransactionStatus.completed:
        return AppColors.completedBg;
      case TransactionStatus.canceled:
        return AppColors.canceledBg;
      case TransactionStatus.refunded:
        return AppColors.refundedBg;
      default:
        return AppColors.shade100;
    }
  }

  Color get _statusTextColor {
    switch (transaction.status) {
      case TransactionStatus.pending:
        return AppColors.pendingText;
      case TransactionStatus.completed:
        return AppColors.completedText;
      case TransactionStatus.canceled:
        return AppColors.canceledText;
      case TransactionStatus.refunded:
        return AppColors.refundedText;
      default:
        return AppColors.text;
    }
  }

  String get _formattedTime {
    final d = transaction.date!.toLocal();
    final hour = d.hour % 12 == 0 ? 12 : d.hour % 12;
    final minute = d.minute.toString().padLeft(2, '0');
    final period = d.hour >= 12 ? "PM" : "AM";
    return "$hour:$minute $period";
  }

  String get _formattedDate {
    return "${transaction.date?.day} ${transaction.date?.monthShort}, ${transaction.date?.year}";
  }

  @override
  Widget build(BuildContext context) {
    String? email = sl<SharedPreferences>().getString("email");

    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaction Details"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 8),
              // Amount card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 24),
                decoration: BoxDecoration(
                  color: _statusBgColor.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Text(
                      "${transaction.type! == TransactionType.credit ? "+" : "-"}${Global.formatCurrency(transaction.amount.toString())}",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                        color: transaction.type! == TransactionType.credit ? AppColors.completedText : AppColors.error,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "$_formattedTime  ·  $_formattedDate",
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _badge(
                          label: transaction.mode!.name.toUpperCase(),
                          color: transaction.colorMode,
                        ),
                        const SizedBox(width: 8),
                        _badge(
                          label: transaction.status!.name.toUpperCase(),
                          color: _statusTextColor,
                          bg: _statusBgColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Parties
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: AppColors.outline.withOpacity(0.2),
                  ),
                ),
                child: Column(
                  children: [
                    _partyRow(
                      context,
                      label: "From",
                      name: "${transaction.sender!.firstName} ${transaction.sender!.lastName}",
                      email: transaction.sender!.email!,
                      isMe: transaction.sender!.email! == email,
                    ),
                    _divider(),
                    _partyRow(
                      context,
                      label: "To",
                      name: "${transaction.receiver!.firstName} ${transaction.receiver!.lastName}",
                      email: transaction.receiver!.email!,
                      isMe: transaction.receiver!.email! == email,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              // Description
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: AppColors.outline.withOpacity(0.2),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      transaction.description!,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: AppColors.text,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Action buttons
              if (transaction.type == TransactionType.credit && transaction.status == TransactionStatus.pending)
                _actionButton(
                  context,
                  label: "Verify Payment",
                  onTap: () {
                    showCupertinoDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) => VerifyDialog(id: transaction.id!.toString()),
                    );
                  },
                ),
              if (transaction.type == TransactionType.debit && transaction.status == TransactionStatus.pending)
                _actionButton(
                  context,
                  label: "Request Refund",
                  onTap: () {
                    showCupertinoDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) => RequestRefundDialog(id: transaction.id!.toString()),
                    );
                  },
                ),
              if (transaction.type == TransactionType.debit && transaction.status == TransactionStatus.canceled)
                _actionButton(
                  context,
                  label: "Confirm Refund",
                  onTap: () {
                    showCupertinoDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) => ConfirmDialog(id: transaction.id!.toString()),
                    );
                  },
                ),
              Padding(padding: MediaQuery.paddingOf(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _badge({
    required String label,
    required Color color,
    Color? bg,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg ?? color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  Widget _partyRow(
    BuildContext context, {
    required String label,
    required String name,
    required String email,
    bool isMe = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 42,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        name,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.text,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (isMe)
                      Container(
                        margin: const EdgeInsets.only(left: 6),
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          "You",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  email,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Divider(
      height: 1,
      color: AppColors.outline.withOpacity(0.15),
    );
  }

  Widget _actionButton(
    BuildContext context, {
    required String label,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        child: Text(label),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Verify Payment Dialog
// ---------------------------------------------------------------------------

class VerifyDialog extends StatelessWidget {
  final String id;

  const VerifyDialog({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    String pin = "";
    return BlocProvider<AccountBloc>.value(
      value: sl<AccountBloc>(),
      child: BlocConsumer<AccountBloc, AccountState>(
        listener: (context, state) {
          if (state is AccountSuccess<VerifyTransactionEvent, String>) {
            Global.showResponseMessage(message: state.data!);
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.completedBg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.verified_outlined,
                      color: AppColors.completedText,
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Verify Payment",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.text,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Enter the 4-digit PIN sent to the sender's email to verify this transaction.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  PinWidget(
                    digits: 4,
                    onPinEntered: (pinList) {
                      pin = pinList.join();
                    },
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (pin.length < 4) {
                          Global.showErrorMessage(message: "Enter a valid 4-digit PIN.");
                          return;
                        }
                        sl<AccountBloc>().add(VerifyTransactionEvent(id: id, code: pin));
                      },
                      child: state is AccountLoading<VerifyTransactionEvent>
                          ? const SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.5,
                              ),
                            )
                          : const Text("Verify Payment"),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Confirm Refund Dialog (with PIN)
// ---------------------------------------------------------------------------

class ConfirmDialog extends StatelessWidget {
  final String id;

  const ConfirmDialog({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    String pin = "";
    return BlocProvider<AccountBloc>.value(
      value: sl<AccountBloc>(),
      child: BlocConsumer<AccountBloc, AccountState>(
        listener: (context, state) {
          if (state is AccountSuccess<CompleteRefundEvent, String>) {
            Global.showResponseMessage(message: state.data!);
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.refundedBg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.replay_rounded,
                      color: AppColors.refundedText,
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Confirm Refund",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.text,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Enter the 4-digit PIN from the receiver's email to complete this refund.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  PinWidget(
                    digits: 4,
                    onPinEntered: (pinList) {
                      pin = pinList.join();
                    },
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (pin.length < 4) {
                          Global.showErrorMessage(message: "Enter a valid 4-digit PIN.");
                          return;
                        }
                        sl<AccountBloc>().add(CompleteRefundEvent(id: id, code: pin));
                      },
                      child: state is AccountLoading<CompleteRefundEvent>
                          ? const SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.5,
                              ),
                            )
                          : const Text("Confirm Refund"),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Request Refund Dialog
// ---------------------------------------------------------------------------

class RequestRefundDialog extends StatelessWidget {
  final String id;

  const RequestRefundDialog({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    String reason = "";
    String proofName = "";
    File? proof;

    return BlocProvider<AccountBloc>.value(
      value: sl<AccountBloc>(),
      child: BlocConsumer<AccountBloc, AccountState>(
        listener: (context, state) {
          if (state is AccountSuccess<RequestRefundEvent, String>) {
            Global.showResponseMessage(message: state.data!);
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.canceledBg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.flag_outlined,
                      color: AppColors.canceledText,
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Request Refund",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.text,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Tell us why you'd like a refund. Attach proof if you have it.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    autofocus: true,
                    decoration: const InputDecoration(
                      hintText: "Reason for refund",
                    ),
                    maxLines: 3,
                    onChanged: (text) => reason = text,
                  ),
                  const SizedBox(height: 12),
                  StatefulBuilder(builder: (context, setState) {
                    return InkWell(
                      onTap: () async {
                        FilePickerResult? result = await FilePicker.platform.pickFiles();
                        if (result != null) {
                          proof = File(result.files.single.path!);
                          setState(() {
                            proofName = result.files.single.name;
                          });
                        }
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.outline.withOpacity(0.4),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              proofName.isEmpty ? Icons.attach_file_rounded : Icons.insert_drive_file_outlined,
                              size: 18,
                              color: AppColors.textSecondary,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                proofName.isEmpty ? "Attach proof (optional)" : proofName,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: proofName.isEmpty ? AppColors.grey : AppColors.text,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (proofName.isNotEmpty)
                              Icon(
                                Icons.check_circle,
                                size: 16,
                                color: AppColors.completedText,
                              ),
                          ],
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (reason.isEmpty) {
                          Global.showErrorMessage(message: "Please enter a reason for the refund.");
                          return;
                        }
                        sl<AccountBloc>().add(RequestRefundEvent(id: id, reason: reason));
                      },
                      child: state is AccountLoading<RequestRefundEvent>
                          ? const SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.5,
                              ),
                            )
                          : const Text("Request Refund"),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
