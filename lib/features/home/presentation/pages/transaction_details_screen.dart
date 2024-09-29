import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trustlink/core/components/primary_button.dart';
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

  @override
  Widget build(BuildContext context) {
    DateTime localDate = transaction.date!.toLocal();
    bool isPm = localDate.hour > 12;
    String? email = sl<SharedPreferences>().getString("email");

    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaction Details"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "${transaction.type! == TransactionType.credit ? "+" : "-"}${Global.formatCurrency(transaction.amount.toString())}",
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: transaction.type! == TransactionType.credit
                        ? Colors.green
                        : AppColors.error),
              ),
              Text(
                "${localDate.hour - (isPm ? 12 : 0)}:${localDate.minute}${isPm ? "PM" : "AM"} ${transaction.date?.day} ${transaction.date?.monthShort}, ${transaction.date?.year} ",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: AppColors.grey),
              ),
              const SizedBox(
                height: 4.0,
              ),
              Wrap(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    margin: const EdgeInsets.only(top: 8.0),
                    decoration: BoxDecoration(
                        color: transaction.colorMode.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4.0)),
                    child: Text(
                      transaction.mode!.name.toUpperCase(),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: transaction.colorMode,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    margin: const EdgeInsets.only(top: 8.0),
                    decoration: BoxDecoration(
                        color: transaction.color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Text(
                      transaction.status!.name.toUpperCase(),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: transaction.color,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12.0,
              ),
              DescriptionColumn(
                title: "Receiver",
                description: transaction.receiver!.email!,
                isMe: transaction.receiver!.email! == email,
              ),
              DescriptionColumn(
                title: "Sender",
                description: transaction.sender!.email!,
                isMe: transaction.sender!.email! == email,
              ),
              DescriptionColumn(
                  title: "Description", description: transaction.description!),
              if (transaction.type == TransactionType.credit &&
                  transaction.status == TransactionStatus.pending)
                PrimaryButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) =>
                              VerifyDialog(id: transaction.id!.toString()));
                    },
                    title: "Verify Payment"),
              if (transaction.type == TransactionType.debit &&
                  transaction.status == TransactionStatus.pending)
                PrimaryButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => RequestRefundDialog(
                              id: transaction.id!.toString()));
                    },
                    title: "Request Refund"),
              if (transaction.type == TransactionType.debit &&
                  transaction.status == TransactionStatus.canceled)
                PrimaryButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) =>
                              ConfirmDialog(id: transaction.id!.toString()));
                    },
                    title: "Confirm Refund"),
            ],
          ),
        ),
      ),
    );
  }
}

class VerifyDialog extends StatelessWidget {
  final String id;

  const VerifyDialog({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    String pin = "";
    return BlocProvider<AccountBloc>.value(
      value: sl<AccountBloc>(),
      child:
          BlocConsumer<AccountBloc, AccountState>(listener: (context, state) {
        if (state is AccountSuccess<VerifyTransactionEvent, String>) {
          Global.showResponseMessage(message: state.data!);
          Navigator.pop(context);
        }
      }, builder: (context, state) {
        return Dialog(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                    "This code is gotten from the sender. It would be sent by mail."),
                PinWidget(
                    digits: 4,
                    onPinEntered: (pinList) {
                      pin = pinList.join();
                    }),
                PrimaryButton(
                    onPressed: () {
                      if (pin.length < 4) {
                        Global.showErrorMessage(message: "Input a valid pin.");
                      }
                      sl<AccountBloc>()
                          .add(VerifyTransactionEvent(id: id, code: pin));
                    },
                    isLoading: state is AccountLoading<VerifyTransactionEvent>,
                    title: "Verify Payment"),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class ConfirmDialog extends StatelessWidget {
  final String id;

  const ConfirmDialog({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    String pin = "";
    return BlocProvider<AccountBloc>.value(
      value: sl<AccountBloc>(),
      child:
          BlocConsumer<AccountBloc, AccountState>(listener: (context, state) {
        if (state is AccountSuccess<CompleteRefundEvent, String>) {
          Global.showResponseMessage(message: state.data!);
          Navigator.pop(context);
        }
      }, builder: (context, state) {
        return Dialog(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                    "This code is gotten from the sender. It would be sent by mail."),
                PinWidget(
                    digits: 4,
                    onPinEntered: (pinList) {
                      pin = pinList.join();
                    }),
                PrimaryButton(
                    onPressed: () {
                      if (pin.length < 4) {
                        Global.showErrorMessage(message: "Input a valid pin.");
                      }
                      sl<AccountBloc>()
                          .add(CompleteRefundEvent(id: id, code: pin));
                    },
                    isLoading: state is AccountLoading<CompleteRefundEvent>,
                    title: "Confirm Refund"),
              ],
            ),
          ),
        );
      }),
    );
  }
}

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
      child:
          BlocConsumer<AccountBloc, AccountState>(listener: (context, state) {
        if (state is AccountSuccess<RequestRefundEvent, String>) {
          Global.showResponseMessage(message: state.data!);
          Navigator.pop(context);
        }
      }, builder: (context, state) {
        return Dialog(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Please give a valid reason why you want a refund."),
                const SizedBox(
                  height: 16.0,
                ),
                TextField(
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: "Reason",
                  ),
                  maxLines: 3,
                  onChanged: (text) => reason = text,
                ),
                SizedBox(
                  height: 8.0,
                ),
                StatefulBuilder(builder: (context, setState) {
                  return InkWell(
                    onTap: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles();

                      if (result != null) {
                        proof = File(result.files.single.path!);
                        setState(() {
                          proofName = result.files.single.name;
                        });
                      } else {
                        Global.showErrorMessage(
                            message: "You need proof to request a refund");
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 12.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.grey),
                          borderRadius: BorderRadius.circular(4.0)),
                      child: Row(
                        children: [
                          Text(
                            proofName.isEmpty
                                ? "Proof file (optional)"
                                : proofName,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: AppColors.grey),
                          ),
                          const Spacer(),
                          const Icon(Icons.arrow_drop_down)
                        ],
                      ),
                    ),
                  );
                }),
                PrimaryButton(
                    onPressed: () {
                      if (reason.isEmpty) {
                        Global.showErrorMessage(
                            message: "Kindly input a reason.");
                      }
                      sl<AccountBloc>()
                          .add(RequestRefundEvent(id: id, reason: reason));
                    },
                    isLoading: state is AccountLoading<RequestRefundEvent>,
                    title: "Request Refund"),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class DescriptionColumn extends StatelessWidget {
  final String title;
  final String description;
  final bool isMe;

  const DescriptionColumn(
      {super.key,
      required this.title,
      required this.description,
      this.isMe = false});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$title:",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.grey),
            ),
            Text(
              description + (isMe ? " (Me)" : ""),
              style: Theme.of(context).textTheme.titleLarge,
              // overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
