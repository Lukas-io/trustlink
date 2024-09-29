import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trustlink/core/components/primary_button.dart';
import 'package:trustlink/features/auth/presentation/bloc/auth_event.dart';

import '../../../../core/resources/global.dart';
import '../../../../injection_container.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String email = "";
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
      ),
      body: BlocProvider<AuthBloc>.value(
        value: sl<AuthBloc>(),
        child: BlocConsumer<AuthBloc, AuthState>(
            listener: (BuildContext context, AuthState<dynamic> state) {
          if (state is AuthSuccess<ResetPasswordEvent>) {
            Global.showResponseMessage(message: state.email!);
            Navigator.pop(context);
          }
        }, builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text("A link would be sent to your email"),
                ),
                TextField(
                    autofillHints: const [AutofillHints.email],
                    keyboardType: TextInputType.emailAddress,
                    controller: TextEditingController(text: email),
                    decoration: const InputDecoration(
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    onChanged: (text) => email = text),
                PrimaryButton(
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (email.isEmpty) {
                      Global.showErrorMessage(
                        message: "Please enter a valid field for email",
                      );
                    } else {
                      sl<AuthBloc>().add(ResetPasswordEvent(
                        email: email,
                      ));
                    }
                  },
                  title: "Continue",
                  isLoading: state is AuthLoading<ResetPasswordEvent>,
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
