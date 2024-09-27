import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trustlink/core/constants/app_assets.dart';
import 'package:trustlink/core/constants/app_colors.dart';

import 'features/auth/presentation/pages/onboarding_screen.dart';
import 'features/home/presentation/home.dart';
import 'injection_container.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      if (sl<SharedPreferences>().getString("bearer") != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const Home(),
          ),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets.logo,
              height: 250,
              fit: BoxFit.fitHeight,
            ),
            RichText(
              text: TextSpan(
                text: "Trust",
                style: Theme.of(context).textTheme.displayMedium,
                children: <TextSpan>[
                  TextSpan(
                      text: 'Link',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
