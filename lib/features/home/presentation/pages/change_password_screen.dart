import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trustlink/features/auth/presentation/bloc/auth_event.dart';

import '../../../../core/components/primary_button.dart';
import '../../../../core/resources/global.dart';
import '../../../../injection_container.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String oldPassword = "";
    bool oldPasswordObscure = true;
    String newPassword = "";
    bool newPasswordObscure = true;
    String confirm = "";
    bool confirmObscure = true;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Password"),
      ),
      body: BlocProvider<AuthBloc>.value(
        value: sl<AuthBloc>(),
        child: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
          if (state is AuthSuccess<ChangePasswordEvent>) {
            Global.showResponseMessage(message: state.email!);

            Navigator.of(context).pop();
          }
        }, builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                StatefulBuilder(builder: (context, setState) {
                  return TextField(
                    autofillHints: const [AutofillHints.password],
                    obscureText: oldPasswordObscure,
                    autofocus: true,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
                        hintText: "Old Password",
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() =>
                                  oldPasswordObscure = !oldPasswordObscure);
                            },
                            icon: Icon(oldPasswordObscure
                                ? CupertinoIcons.eye_fill
                                : CupertinoIcons.eye_slash_fill))),
                    onChanged: (text) => oldPassword = text,
                  );
                }),
                const SizedBox(
                  height: 16.0,
                ),
                StatefulBuilder(builder: (context, setState) {
                  return TextField(
                    autofillHints: const [AutofillHints.password],
                    obscureText: newPasswordObscure,
                    decoration: InputDecoration(
                        hintText: "New Password",
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() =>
                                  newPasswordObscure = !newPasswordObscure);
                            },
                            icon: Icon(newPasswordObscure
                                ? CupertinoIcons.eye_fill
                                : CupertinoIcons.eye_slash_fill))),
                    onChanged: (text) => newPassword = text,
                  );
                }),
                const SizedBox(
                  height: 8.0,
                ),
                StatefulBuilder(builder: (context, setState) {
                  return TextField(
                    autofillHints: const [AutofillHints.password],
                    obscureText: confirmObscure,
                    controller: TextEditingController(text: confirm),
                    decoration: InputDecoration(
                        hintText: "Confirm Password",
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() => confirmObscure = !confirmObscure);
                            },
                            icon: Icon(confirmObscure
                                ? CupertinoIcons.eye_fill
                                : CupertinoIcons.eye_slash_fill))),
                    onChanged: (text) => confirm = text,
                  );
                }),
                PrimaryButton(
                  onPressed: () {
                    if (oldPassword.isEmpty ||
                        newPassword.isEmpty ||
                        confirm.isEmpty) {
                      Global.showErrorMessage(
                          message: "Please fill all the fields");
                    } else {
                      sl<AuthBloc>().add(
                        ChangePasswordEvent(
                            oldPassword: oldPassword,
                            newPassword: newPassword,
                            confirm: confirm),
                      );
                    }
                  },
                  title: "Change",
                  isLoading: state is AuthLoading<ChangePasswordEvent>,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
