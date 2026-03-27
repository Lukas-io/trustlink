import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trustlink/features/home/presentation/bloc/account_bloc.dart';
import 'package:trustlink/features/home/presentation/bloc/account_event.dart';
import 'package:trustlink/features/home/presentation/home.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/resources/global.dart';
import '../../../../injection_container.dart';
import '../../../auth/presentation/components/pin_widget.dart';
import '../bloc/account_state.dart';

class SetPinScreen extends StatelessWidget {
  const SetPinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String pin = "";
    return BlocProvider<AccountBloc>.value(
      value: sl<AccountBloc>(),
      child:
          BlocConsumer<AccountBloc, AccountState>(listener: (context, state) {
        if (state is AccountSuccess<CreateWalletEvent, String>) {
          Global.showResponseMessage(message: state.data!);

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const Home(),
            ),
          );
        }
      }, builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Set up new pin"),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 24.0,
                  ),
                  PinWidget(
                    digits: 4,
                    // obscure: true,
                    onPinEntered: (pinList) {
                      pin = pinList.join();
                    },
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(vertical: 24.0),
                    child: ElevatedButton(
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (pin.length < 4) {
                          Global.showErrorMessage(
                              message: "Please fill all the fields");
                        } else {
                          sl<AccountBloc>().add(CreateWalletEvent(pin: pin));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(
                            vertical: 16.0,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0))),
                      child: state is AccountLoading<CreateWalletEvent>
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              "Set Pin",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w600),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
