import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trustlink/core/components/primary_button.dart';
import 'package:trustlink/features/home/presentation/components/bank_details_modal.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/resources/global.dart';
import '../../../../injection_container.dart';
import '../bloc/account_bloc.dart';
import '../bloc/account_event.dart';
import '../bloc/account_state.dart';
import '../components/amount_text_field.dart';

class FundScreen extends StatelessWidget {
  const FundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    num amount = 0;
    String number = "";
    String cvv = "";
    String expiryMonth = "";
    String expiryYear = "";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Fund Wallet"),
      ),
      body: BlocProvider<AccountBloc>.value(
        value: sl<AccountBloc>(),
        child:
            BlocConsumer<AccountBloc, AccountState>(listener: (context, state) {
          if (state is AccountSuccess<CardDepositEvent, String>) {
            Global.showResponseMessage(message: state.data!);
            Navigator.pop(context);
          }
        }, builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Fund with Debit Card",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => const BankDetailsModal(),
                      );
                    },
                    child: Text(
                      "or transfer with bank",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppColors.primary,
                          ),
                    ),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  AmountTextField(onChanged: (number) {
                    amount = number;
                  }),
                  SizedBox(
                    height: 24.0,
                  ),
                  Text("Card Number"),
                  Form(
                    child: Column(
                      children: [
                        TextField(
                            autofillHints: const [
                              AutofillHints.creditCardNumber
                            ],
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CreditCardFormatter(),
                            ],
                            decoration: InputDecoration(
                              hintText: "0000 0000 0000 0000",
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: AppColors.grey),
                              prefixIcon: const Icon(CupertinoIcons.creditcard),
                              labelStyle: Theme.of(context).textTheme.bodyLarge,
                            ),
                            onChanged: (text) {
                              number = text.splitMapJoin(
                                RegExp(r'\D'),
                                // Matches any non-digit character
                                onMatch: (m) => '',
                                // Remove the non-digit characters
                                onNonMatch: (n) => n, // Keep the digits
                              );
                              if (text.length > 18) {
                                FocusManager.instance.primaryFocus?.nextFocus();
                              }
                            }),
                        SizedBox(
                          height: 12.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                autofillHints: const [
                                  AutofillHints.creditCardExpirationDate
                                ],
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  ExpiryDateFormatter(),
                                ],
                                decoration: InputDecoration(
                                  hintText: "MM/YY",
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(color: AppColors.grey),
                                  prefixIcon:
                                      const Icon(CupertinoIcons.calendar_today),
                                  labelStyle:
                                      Theme.of(context).textTheme.bodyLarge,
                                ),
                                onChanged: (text) {
                                  List<String> expiry = text.split("/");
                                  expiryMonth = expiry[0];
                                  expiryYear =
                                      expiry.length == 2 ? expiry[1] : "";
                                  if (text.length > 4) {
                                    FocusManager.instance.primaryFocus
                                        ?.nextFocus();
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              width: 18.0,
                            ),
                            Expanded(
                              child: TextField(
                                  autofillHints: const [
                                    AutofillHints.creditCardSecurityCode
                                  ],
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  decoration: InputDecoration(
                                    hintText: "CVV",
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(color: AppColors.grey),
                                    prefixIcon: const Icon(CupertinoIcons.lock),
                                    labelStyle:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  onChanged: (text) {
                                    cvv = text;
                                  }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  PrimaryButton(
                    onPressed: () {
                      print({
                        amount: amount,
                        number: number,
                        cvv: cvv,
                        expiryMonth: expiryMonth,
                        expiryYear: expiryYear,
                      });
                      // print(object)
                      if (amount == 0 ||
                          number.isEmpty ||
                          expiryYear.isEmpty ||
                          cvv.isEmpty ||
                          expiryMonth.isEmpty) {
                        Global.showErrorMessage(
                          message: "Enter values for all the fields",
                        );
                      } else {
                        sl<AccountBloc>().add(CardDepositEvent(
                          amount: amount,
                          number: number,
                          cvv: cvv,
                          expiryMonth: expiryMonth,
                          expiryYear: expiryYear,
                        ));
                      }
                    },
                    title: "Fund",
                    isLoading: state is AccountLoading<CardDepositEvent>,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
