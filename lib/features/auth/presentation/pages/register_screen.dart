import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trustlink/features/auth/presentation/pages/login_screen.dart';
import 'package:trustlink/features/auth/presentation/pages/verify_mail_screen.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/resources/global.dart';
import '../../../../injection_container.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String firstName = "Luke";
    String lastName = "Cole";
    String userName = "lukasio";
    String email = "lukecocplay2@gmail.com";
    String phone = "09039477535";
    String password = "lukasiuu";
    return BlocProvider<AuthBloc>.value(
      value: sl<AuthBloc>(),
      child: BlocConsumer<AuthBloc, AuthState>(
          listener: (BuildContext context, AuthState<dynamic> state) {
        if (state is AuthSuccess<RegisterEvent>) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => VerifyMailScreen(
                email: state.email!,
              ),
            ),
          );
        }
      }, builder: (context, state) {
        bool obscure = true;
        return Scaffold(
          body: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    Center(
                      child: Image.asset(
                        AppAssets.logo,
                        height: 250,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    Text(
                      "Register an account to get started!",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: AppColors.text),
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: TextField(
                        autofillHints: const [AutofillHints.namePrefix],
                        controller: TextEditingController(text: firstName),
                        keyboardType: TextInputType.name,
                        onChanged: (text) {
                          firstName = text;
                        },
                        decoration: const InputDecoration(
                          hintText: "First Name",
                          prefixIcon: Icon(Icons.person_outline),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: TextField(
                        controller: TextEditingController(text: lastName),
                        autofillHints: const [AutofillHints.nameSuffix],
                        keyboardType: TextInputType.name,
                        onChanged: (text) {
                          lastName = text;
                        },
                        decoration: const InputDecoration(
                          hintText: "Last Name",
                          prefixIcon: Icon(Icons.person_outline),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: TextField(
                        controller: TextEditingController(text: userName),
                        autofillHints: const [AutofillHints.username],
                        keyboardType: TextInputType.name,
                        onChanged: (text) {
                          userName = text;
                        },
                        decoration: const InputDecoration(
                          hintText: "Username",
                          prefixIcon: Icon(CupertinoIcons.at),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: TextField(
                        controller: TextEditingController(text: email),
                        autofillHints: const [AutofillHints.email],
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (text) {
                          email = text;
                        },
                        decoration: const InputDecoration(
                          hintText: "Email",
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: TextField(
                        controller: TextEditingController(text: phone),
                        autofillHints: const [AutofillHints.telephoneNumber],
                        keyboardType: TextInputType.phone,
                        onChanged: (text) {
                          phone = text;
                        },
                        decoration: const InputDecoration(
                          hintText: "Phone Number",
                          prefixIcon: Icon(Icons.phone_outlined),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: StatefulBuilder(builder: (context, setState) {
                        return TextField(
                          autofillHints: const [AutofillHints.password],
                          obscureText: obscure,
                          keyboardType: TextInputType.emailAddress,
                          controller: TextEditingController(text: password),
                          decoration: InputDecoration(
                              hintText: "Password",
                              prefixIcon:
                                  const Icon(Icons.lock_outline_rounded),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() => obscure = !obscure);
                                  },
                                  icon: Icon(obscure
                                      ? CupertinoIcons.eye_fill
                                      : CupertinoIcons.eye_slash_fill))),
                          onChanged: (text) => password = text,
                        );
                      }),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.all(24.0),
                      child: ElevatedButton(
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (firstName.isEmpty ||
                              lastName.isEmpty ||
                              userName.isEmpty ||
                              email.isEmpty ||
                              password.isEmpty ||
                              phone.isEmpty) {
                            Global.showErrorMessage(
                              message: "Enter values for all the fields",
                            );
                          } else {
                            sl<AuthBloc>().add(RegisterEvent(
                              phone: phone,
                              firstName: firstName,
                              lastName: lastName,
                              email: email,
                              username: userName,
                              password: password,
                            ));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            padding: const EdgeInsets.symmetric(
                              vertical: 16.0,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0))),
                        child: state is AuthLoading<RegisterEvent>
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                "Create account",
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
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: RichText(
                        text: TextSpan(
                            text: "Already have an account? ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: AppColors.text),
                            children: [
                              TextSpan(
                                text: "Login!",
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
          ),
        );
      }),
    );
  }
}
