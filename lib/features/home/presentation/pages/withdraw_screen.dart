import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trustlink/core/constants/app_colors.dart';

import '../../../../core/resources/global.dart';
import '../../../../injection_container.dart';
import '../../../auth/presentation/components/pin_widget.dart';
import '../../data/models/account/bank_model.dart';
import '../bloc/account_bloc.dart';
import '../bloc/account_event.dart';
import '../bloc/account_state.dart';
import '../components/amount_text_field.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  @override
  void initState() {
    sl<AccountBloc>().add(GetUserBankEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    num amount = 0;
    String pin = "";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Withdraw Funds"),
      ),
      body: BlocProvider<AccountBloc>.value(
        value: sl<AccountBloc>(),
        child: BlocConsumer<AccountBloc, AccountState>(
          listener: (context, state) {
            if (state is AccountSuccess<WithdrawEvent, String>) {
              Global.showResponseMessage(message: state.data!);
              Navigator.pop(context);
            }
          },
          buildWhen: (previous, current) {
            if (current is AccountSuccess<GetUserBankEvent, BanksBean>) {
              return true;
            }
            if (current is AccountLoading<GetUserBankEvent>) {
              return true;
            }
            if (current is AccountException<GetUserBankEvent>) {
              return true;
            }
            return false;
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      "Move funds from your wallet to your bank account.",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Bank account status
                    if (state is AccountSuccess<GetUserBankEvent, BanksBean>)
                      _BankCard(bank: state.data!),
                    if (state is AccountException<GetUserBankEvent>)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.pendingBg.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.warning_amber_rounded,
                                size: 18, color: AppColors.pendingText),
                            const SizedBox(width: 10),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  text: "No withdrawal account linked. ",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: AppColors.text,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "Add one.",
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (state is AccountLoading<GetUserBankEvent>)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          "Loading bank details...",
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    const SizedBox(height: 20),
                    AmountTextField(onChanged: (number) {
                      amount = number;
                    }),
                    const SizedBox(height: 28),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (amount == 0) {
                            Global.showErrorMessage(
                                message: "Please enter an amount");
                            return;
                          }
                          showCupertinoDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (context) => _WithdrawPinDialog(
                              amount: amount,
                            ),
                          );
                        },
                        child: const Text("Withdraw"),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _BankCard extends StatelessWidget {
  final BanksBean bank;

  const _BankCard({required this.bank});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.outline.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.account_balance_outlined,
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
                  bank.name ?? "Bank Account",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.text,
                  ),
                ),
                if (bank.code != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    bank.code!,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const Icon(
            Icons.check_circle,
            size: 18,
            color: AppColors.completedText,
          ),
        ],
      ),
    );
  }
}

class _WithdrawPinDialog extends StatelessWidget {
  final num amount;

  const _WithdrawPinDialog({required this.amount});

  @override
  Widget build(BuildContext context) {
    String pin = "";

    return BlocProvider<AccountBloc>.value(
      value: sl<AccountBloc>(),
      child: BlocBuilder<AccountBloc, AccountState>(
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
                      color: AppColors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.lock_outline_rounded,
                      color: AppColors.orange,
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Confirm Withdrawal",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.text,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Enter your PIN to withdraw ${Global.formatCurrency(amount.toString())} to your bank account.",
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
                        sl<AccountBloc>().add(WithdrawEvent(
                          amount: amount,
                          pin: pin,
                        ));
                      },
                      child: state is AccountLoading<WithdrawEvent>
                          ? const SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.5,
                              ),
                            )
                          : const Text("Confirm"),
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
