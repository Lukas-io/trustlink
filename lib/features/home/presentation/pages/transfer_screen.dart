import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trustlink/core/components/primary_button.dart';
import 'package:trustlink/core/resources/global.dart';
import 'package:trustlink/features/auth/presentation/components/pin_widget.dart';
import 'package:trustlink/features/home/presentation/bloc/account_bloc.dart';
import 'package:trustlink/features/home/presentation/bloc/account_event.dart';
import 'package:trustlink/features/home/presentation/bloc/account_state.dart';
import 'package:trustlink/features/home/presentation/components/amount_text_field.dart';

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
              Text(
                "Send money across the app",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 12.0,
              ),
              AmountTextField(onChanged: (number) {
                amount = number;
              }),
              const SizedBox(
                height: 24.0,
              ),
              const Text("Recipient"),
              TextField(
                  style: Theme.of(context).textTheme.bodyLarge,
                  onChanged: (text) {
                    recipient = text;
                  }),
              const SizedBox(
                height: 12.0,
              ),
              const Text("Description"),
              TextField(
                  style: Theme.of(context).textTheme.bodyLarge,
                  maxLines: 4,
                  onChanged: (text) {
                    description = text;
                  }),
              PrimaryButton(
                  onPressed: () {
                    if (amount == 0 ||
                        recipient.isEmpty ||
                        description.isEmpty) {
                      Global.showErrorMessage(
                          message: "Please input a valid recipient & amount");
                      return;
                    }
                    showDialog(
                      context: context,
                      builder: (context) => BlocProvider<AccountBloc>.value(
                        value: sl<AccountBloc>(),
                        child: BlocConsumer<AccountBloc, AccountState>(
                            listener: (context, state) {
                          if (state is AccountSuccess<WalletPayEvent, String>) {
                            Global.showResponseMessage(message: state.data!);
                            Navigator.pop(context);
                          }
                        }, builder: (context, state) {
                          return Dialog(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Pin",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  PinWidget(
                                      digits: 4,
                                      onPinEntered: (digits) {
                                        pin = digits.join();
                                      }),
                                  PrimaryButton(
                                    onPressed: () {
                                      if (pin.length < 4) {
                                        Global.showErrorMessage(
                                            message:
                                                "Kindly input a valid pin");
                                        return;
                                      }

                                      sl<AccountBloc>().add(WalletPayEvent(
                                          amount: amount,
                                          pin: pin,
                                          description: description,
                                          recipient: recipient));
                                    },
                                    title: "Confirm",
                                    isLoading:
                                        state is AccountLoading<WalletPayEvent>,
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    );
                  },
                  title: "Transfer"),
            ],
          ),
        ),
      ),
    );
  }
}
