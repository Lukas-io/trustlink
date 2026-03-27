import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trustlink/core/constants/app_colors.dart';
import 'package:trustlink/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:trustlink/features/auth/presentation/bloc/auth_event.dart';
import 'package:trustlink/features/auth/presentation/bloc/auth_state.dart';
import 'package:trustlink/features/auth/presentation/pages/forgot_password_screen.dart';
import 'package:trustlink/features/auth/presentation/pages/register_screen.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/resources/global.dart';
import '../../../../core/resources/interceptor.dart';
import '../../../../injection_container.dart';
import '../../../home/presentation/home.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String email = "techintern";
    String password = "Asdfghjkl;";

    return BlocProvider<AuthBloc>.value(
        value: sl<AuthBloc>(),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (BuildContext context, AuthState<dynamic> state) {
            if (state is AuthSuccess<LoginEvent>) {
              final String? token = state.user?.token!;
              sl<SharedPreferences>().setString("bearer", token!);
              sl<SharedPreferences>()
                  .setString("email", state.user!.user!.email!);
              sl<Dio>().interceptors.add(AuthInterceptor(token));
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const Home(),
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
                          "Welcome back",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: AppColors.text,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Sign in to manage your escrow and payments",
                          style: TextStyle(
                            fontSize: 15,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 32),
                        TextField(
                            autofillHints: const [AutofillHints.email],
                            keyboardType: TextInputType.emailAddress,
                            controller: TextEditingController(text: email),
                            decoration: const InputDecoration(
                              hintText: "Email",
                              prefixIcon: Icon(Icons.email_outlined,
                                  color: AppColors.grey),
                            ),
                            onChanged: (text) => email = text),
                        const SizedBox(height: 14),
                        StatefulBuilder(builder: (context, setState) {
                          return TextField(
                            autofillHints: const [AutofillHints.password],
                            obscureText: obscure,
                            keyboardType: TextInputType.emailAddress,
                            controller: TextEditingController(text: password),
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
                                    ))),
                            onChanged: (text) => password = text,
                          );
                        }),
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ForgotPasswordScreen(),
                              ),
                            );
                          },
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              "Forgot password?",
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              if (email.isEmpty || password.isEmpty) {
                                Global.showErrorMessage(
                                  message:
                                      "Please enter a valid field for email & password",
                                );
                              } else {
                                sl<AuthBloc>().add(
                                    LoginEvent(id: email, password: password));
                              }
                            },
                            child: state is AuthLoading<LoginEvent>
                                ? const SizedBox(
                                    height: 22,
                                    width: 22,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2.5,
                                    ),
                                  )
                                : const Text("Sign in"),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const RegisterScreen(),
                                ),
                              );
                            },
                            child: RichText(
                              text: TextSpan(
                                  text: "Don't have an account? ",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: AppColors.textSecondary,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "Create one",
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
