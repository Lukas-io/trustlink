import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trustlink/core/constants/app_colors.dart';

import '../../../../core/components/primary_button.dart';
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
        child:
            BlocConsumer<AccountBloc, AccountState>(listener: (context, state) {
          if (state is AccountSuccess<WithdrawEvent, String>) {
            Global.showResponseMessage(message: state.data!);
            Navigator.pop(context);
          }
        }, buildWhen: (previous, current) {
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
        }, builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Withdraw to your bank account",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),

                  //You would see 3 if statements, it has to be either one of them.
//Apparently it didn't work, ignore the comment above
//                 Yippeeeeee, it worked, ignore the comment directly above
                  if (state is AccountSuccess<GetUserBankEvent, BanksBean>)
                    Text(
                      "-",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),

                  if (state is AccountException<GetUserBankEvent>)
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          Text("You don't have a withdrawal account, ",
                              style: Theme.of(context).textTheme.bodyMedium),
                          Text(
                            "Add one.",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: AppColors.secondary),
                          ),
                        ],
                      ),
                    ),
                  if (state is AccountLoading<GetUserBankEvent>)
                    Text(
                      "-",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  AmountTextField(onChanged: (number) {
                    amount = number;
                  }),
                  PrimaryButton(
                      onPressed: () {
                        if (amount == 0) {
                          Global.showErrorMessage(
                              message: "Please input an amount");
                          return;
                        }
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  PinWidget(
                                      digits: 4,
                                      onPinEntered: (digits) {
                                        pin = digits.join();
                                      }),
                                  BlocProvider<AccountBloc>.value(
                                    value: sl<AccountBloc>(),
                                    child:
                                        BlocBuilder<AccountBloc, AccountState>(
                                            builder: (context, state) {
                                      return PrimaryButton(
                                        onPressed: () {
                                          if (pin.length < 4) {
                                            Global.showErrorMessage(
                                                message:
                                                    "Kindly input a valid pin");
                                            return;
                                          }
                                          sl<AccountBloc>().add(WithdrawEvent(
                                            amount: amount,
                                            pin: pin,
                                          ));
                                        },
                                        title: "Confirm",
                                        isLoading: state
                                            is AccountLoading<WithdrawEvent>,
                                      );
                                    }),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      title: "Withdraw"),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
