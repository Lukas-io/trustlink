import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trustlink/core/constants/app_colors.dart';
import 'package:trustlink/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:trustlink/features/auth/presentation/bloc/auth_event.dart';
import 'package:trustlink/features/auth/presentation/bloc/auth_state.dart';
import 'package:trustlink/features/auth/presentation/pages/register_screen.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/resources/global.dart';
import '../../../../injection_container.dart';
import '../../../home/presentation/home.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String email = "olakay739@gmail.com";
    String password = "Ibukunoluwa.1";

    return BlocProvider<AuthBloc>.value(
        value: sl<AuthBloc>(),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (BuildContext context, AuthState<dynamic> state) {
            if (state is AuthSuccess<LoginEvent>) {
              // sl<SharedPreferences>().setString("token", state.response.token!);

              // sl<Dio>().interceptors.add(AuthInterceptor(state.response.token!));
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const Home(),
                ),
              );
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: SafeArea(
                child: SingleChildScrollView(
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
                          "Sign in to your account to continue ",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(color: AppColors.text),
                        ),
                        const SizedBox(
                          height: 24.0,
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
                        const SizedBox(
                          height: 12.0,
                        ),
                        TextField(
                          autofillHints: const [AutofillHints.password],
                          obscureText: true,
                          keyboardType: TextInputType.emailAddress,
                          controller: TextEditingController(text: password),
                          decoration: const InputDecoration(
                            hintText: "Password",
                            prefixIcon: Icon(Icons.lock_outline_rounded),
                          ),
                          onChanged: (text) => password = text,
                        ),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 24.0),
                          child: ElevatedButton(
                            onPressed: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              if (email.isEmpty || password.isEmpty) {
                                Global.showToastMessage(
                                  message:
                                      "Please enter a valid field for email & password",
                                );
                              } else {
                                sl<AuthBloc>().add(
                                    LoginEvent(id: email, password: password));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16.0,
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0))),
                            child: state is AuthLoading<LoginEvent>
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    "Login",
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
                                builder: (context) => const RegisterScreen(),
                              ),
                            );
                          },
                          child: RichText(
                            text: TextSpan(
                                text: "Don't have an Account? ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(color: AppColors.text),
                                children: [
                                  TextSpan(
                                    text: "Create one!",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                            color: AppColors.primary,
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
          },
        ));
  }
}
