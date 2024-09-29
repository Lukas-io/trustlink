import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trustlink/core/constants/app_colors.dart';
import 'package:trustlink/features/auth/presentation/pages/login_screen.dart';

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
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: AppColors.grey,
                    radius: 35.0,
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  Text(
                    "Your name",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              ListView(
                shrinkWrap: true,
                children: [
                  ListTile(
                    title: Text("Change Password",
                        style: Theme.of(context).textTheme.bodyLarge),
                    horizontalTitleGap: 0.0,
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text("Change Pin"),
                    horizontalTitleGap: 0.0,
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text(
                      "Log out",
                    ),
                    textColor: AppColors.error,
                    horizontalTitleGap: 0.0,
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
