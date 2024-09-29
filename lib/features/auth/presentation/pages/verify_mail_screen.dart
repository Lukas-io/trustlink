import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trustlink/core/resources/global.dart';
import 'package:trustlink/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:trustlink/features/auth/presentation/bloc/auth_event.dart';
import 'package:trustlink/features/home/presentation/pages/set_pin_screen.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/resources/interceptor.dart';
import '../../../../injection_container.dart';
import '../bloc/auth_state.dart';
import '../components/pin_widget.dart';

class VerifyMailScreen extends StatelessWidget {
  final String email;

  const VerifyMailScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    String otp = "";
    return BlocProvider<AuthBloc>.value(
      value: sl<AuthBloc>(),
      child: BlocConsumer<AuthBloc, AuthState>(
          listener: (BuildContext context, AuthState<dynamic> state) {
        if (state is AuthSuccess<ResendOTPEvent>) {
          Global.showResponseMessage(message: "OTP sent successfully");
        }
        if (state is AuthSuccess<VerifyMailEvent>) {
          final String token = state.user!.token!;
          sl<SharedPreferences>().setString("bearer", token);
          sl<SharedPreferences>().setString("email", state.user!.user!.email!);

          sl<Dio>().interceptors.add(AuthInterceptor(token));
          Global.showResponseMessage(message: "Email Verified Successfully!");
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const SetPinScreen(),
            ),
          );
        }
      }, builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Verify Your Mail"),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  Text(
                    "An OTP has been sent to $email, Kindly input the code below",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 12.0),
                  PinWidget(
                    digits: 6,
                    onPinEntered: (pinList) {
                      otp = pinList.join();
                    },
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(24.0),
                    child: ElevatedButton(
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (otp.length < 6) {
                          Global.showErrorMessage(
                              message: "Please fill all the fields");
                        } else {
                          sl<AuthBloc>()
                              .add(VerifyMailEvent(email: email, otp: otp));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(
                            vertical: 16.0,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0))),
                      child: state is AuthLoading<VerifyMailEvent>
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              "Verify",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w600),
                            ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      sl<AuthBloc>().add(ResendOTPEvent(email: email));
                    },
                    child: RichText(
                      text: TextSpan(
                          text: "Didn't receive a mail? ",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: AppColors.text),
                          children: [
                            TextSpan(
                              text: "Resend OTP!",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      color: AppColors.secondary,
                                      fontWeight: FontWeight.w600),
                            )
                          ]),
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
