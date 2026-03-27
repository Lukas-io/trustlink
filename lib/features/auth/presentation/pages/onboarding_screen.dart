import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trustlink/core/constants/app_assets.dart';
import 'package:trustlink/core/constants/app_colors.dart';
import 'package:trustlink/features/auth/presentation/pages/login_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const List<Widget> pages = [
      OnboardingPage(
        image: AppAssets.onboarding2,
        title: "Secure Your Transactions",
        body:
            "Our escrow system ensures that both buyers and sellers are protected throughout the transaction process. Payments are held securely until both parties are satisfied.",
      ),
      OnboardingPage(
        image: AppAssets.onboarding1,
        title: "Monitor Every Step",
        body:
            "Track the progress of your deals in real-time. From initiating a transaction to release of funds, stay informed and in control at every stage.",
      ),
      OnboardingPage(
        image: AppAssets.onboarding3,
        title: "Fast & Reliable",
        body:
            "With quick approvals and an easy-to-use interface, you can complete your transactions smoothly and without hassle. Security and trust are our top priorities.",
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.onboardingBg,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              children: pages,
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        color: Colors.transparent,
        width: double.infinity,
        margin: EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: MediaQuery.of(context).padding.bottom + 12.0,
        ),
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.white,
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0))),
          child: Text(
            "Get Started",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: AppColors.primary, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String body;

  const OnboardingPage({super.key, required this.image, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36.0),
            child: SvgPicture.asset(
              image,
            ),
          ),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(color: AppColors.white, fontWeight: FontWeight.w600),
          ),
          Text(
            body,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.white),
          ),
        ],
      ),
    );
  }
}
