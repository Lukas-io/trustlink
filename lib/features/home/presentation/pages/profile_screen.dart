import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trustlink/core/constants/app_colors.dart';
import 'package:trustlink/features/auth/presentation/pages/login_screen.dart';
import 'package:trustlink/features/home/presentation/components/profile_widget.dart';
import 'package:trustlink/features/home/presentation/pages/change_password_screen.dart';
import 'package:trustlink/features/home/presentation/pages/change_pin_screen.dart';

import '../../../../injection_container.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        centerTitle: false,
        titleSpacing: 24,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 24.0),
            child: Icon(Icons.info_outline),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const ProfileWidget(),
              ListView(
                shrinkWrap: true,
                children: [
                  ListTile(
                    title: const Text("Change Password"),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ChangePasswordScreen()));
                    },
                  ),
                  ListTile(
                    title: const Text("Change Pin"),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ChangePinScreen()));
                    },
                  ),
                  ListTile(
                    title: const Text(
                      "Log out",
                    ),
                    textColor: AppColors.error,
                    onTap: () {
                      sl<SharedPreferences>().remove("bearer");
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
