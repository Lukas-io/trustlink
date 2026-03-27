import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trustlink/core/resources/global.dart';
import 'package:trustlink/features/auth/presentation/components/pin_widget.dart';
import 'package:trustlink/features/home/presentation/bloc/account_bloc.dart';
import 'package:trustlink/features/home/presentation/bloc/account_event.dart';
import 'package:trustlink/features/home/presentation/bloc/account_state.dart';
import 'package:trustlink/features/home/presentation/components/amount_text_field.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../injection_container.dart';

class TransferScreen extends StatelessWidget {
  const TransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    num amount = 0;
    String pin = "";
    String description = "";
    String recipient = "";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Transfer Funds"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                "Send money to another Trustlink user from your wallet.",
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 24),
              AmountTextField(onChanged: (number) {
                amount = number;
              }),
              const SizedBox(height: 20),
              TextField(
                decoration: const InputDecoration(
                  hintText: "Recipient username or email",
                  prefixIcon:
                      Icon(Icons.person_outline, color: AppColors.grey),
                ),
                onChanged: (text) => recipient = text,
              ),
              const SizedBox(height: 14),
              TextField(
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: "What's this for?",
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(bottom: 48),
                    child: Icon(Icons.receipt_long_outlined,
                        color: AppColors.grey),
                  ),
                ),
                onChanged: (text) => description = text,
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (amount == 0 ||
                        recipient.isEmpty ||
                        description.isEmpty) {
                      Global.showErrorMessage(
                          message:
                              "Please enter a recipient, amount, and description");
                      return;
                    }
                    showCupertinoDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) => _TransferPinDialog(
                        amount: amount,
                        recipient: recipient,
                        description: description,
                        onPinChanged: (p) => pin = p,
                      ),
                    );
                  },
                  child: const Text("Continue"),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _TransferPinDialog extends StatelessWidget {
  final num amount;
  final String recipient;
  final String description;
  final Function(String) onPinChanged;

  const _TransferPinDialog({
    required this.amount,
    required this.recipient,
    required this.description,
    required this.onPinChanged,
  });

  @override
  Widget build(BuildContext context) {
    String pin = "";

    return BlocProvider<AccountBloc>.value(
      value: sl<AccountBloc>(),
      child: BlocConsumer<AccountBloc, AccountState>(
        listener: (context, state) {
          if (state is AccountSuccess<WalletPayEvent, String>) {
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
                      color: AppColors.primary.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.lock_outline_rounded,
                      color: AppColors.primary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Confirm Transfer",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.text,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Enter your 4-digit PIN to send ${Global.formatCurrency(amount.toString())} to $recipient.",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  PinWidget(
                    digits: 4,
                    onPinEntered: (digits) {
                      pin = digits.join();
                    },
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (pin.length < 4) {
                          Global.showErrorMessage(
                              message: "Enter a valid 4-digit PIN.");
                          return;
                        }
                        sl<AccountBloc>().add(WalletPayEvent(
                          amount: amount,
                          pin: pin,
                          description: description,
                          recipient: recipient,
                        ));
                      },
                      child: state is AccountLoading<WalletPayEvent>
                          ? const SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.5,
                              ),
                            )
                          : const Text("Send"),
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
