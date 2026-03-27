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
    String firstName = "";
    String lastName = "";
    String userName = "";
    String email = "";
    String phone = "";
    String password = "";

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
        },
        builder: (context, state) {
          bool obscure = true;

          return Scaffold(
            backgroundColor: AppColors.bg,
            body: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      Center(
                        child: Image.asset(
                          AppAssets.logo,
                          height: 120,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        "Create your account",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: AppColors.text,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Set up your profile to start using escrow",
                        style: TextStyle(
                          fontSize: 15,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 28),
                      TextField(
                        autofillHints: const [AutofillHints.givenName],
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          hintText: "First Name",
                          prefixIcon: Icon(Icons.person_outline,
                              color: AppColors.grey),
                        ),
                        onChanged: (text) => firstName = text,
                      ),
                      const SizedBox(height: 14),
                      TextField(
                        autofillHints: const [AutofillHints.familyName],
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          hintText: "Last Name",
                          prefixIcon: Icon(Icons.person_outline,
                              color: AppColors.grey),
                        ),
                        onChanged: (text) => lastName = text,
                      ),
                      const SizedBox(height: 14),
                      TextField(
                        autofillHints: const [AutofillHints.username],
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          hintText: "Username",
                          prefixIcon:
                              Icon(CupertinoIcons.at, color: AppColors.grey),
                        ),
                        onChanged: (text) => userName = text,
                      ),
                      const SizedBox(height: 14),
                      TextField(
                        autofillHints: const [AutofillHints.email],
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: "Email",
                          prefixIcon: Icon(Icons.email_outlined,
                              color: AppColors.grey),
                        ),
                        onChanged: (text) => email = text,
                      ),
                      const SizedBox(height: 14),
                      TextField(
                        autofillHints: const [AutofillHints.telephoneNumber],
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          hintText: "Phone Number",
                          prefixIcon: Icon(Icons.phone_outlined,
                              color: AppColors.grey),
                        ),
                        onChanged: (text) => phone = text,
                      ),
                      const SizedBox(height: 14),
                      StatefulBuilder(builder: (context, setState) {
                        return TextField(
                          autofillHints: const [AutofillHints.password],
                          obscureText: obscure,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            hintText: "Password",
                            prefixIcon: const Icon(
                                Icons.lock_outline_rounded,
                                color: AppColors.grey),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() => obscure = !obscure);
                              },
                              icon: Icon(
                                obscure
                                    ? CupertinoIcons.eye_fill
                                    : CupertinoIcons.eye_slash_fill,
                                color: AppColors.grey,
                              ),
                            ),
                          ),
                          onChanged: (text) => password = text,
                        );
                      }),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
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
                                message: "Please fill in all fields",
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
                          child: state is AuthLoading<RegisterEvent>
                              ? const SizedBox(
                                  height: 22,
                                  width: 22,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.5,
                                  ),
                                )
                              : const Text("Create account"),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Center(
                        child: GestureDetector(
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
                              style: TextStyle(
                                fontSize: 15,
                                color: AppColors.textSecondary,
                              ),
                              children: [
                                TextSpan(
                                  text: "Sign in",
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
