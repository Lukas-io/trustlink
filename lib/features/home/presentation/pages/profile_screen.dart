import 'package:flutter/material.dart';
import 'package:trustlink/core/constants/app_colors.dart';

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
                  CircleAvatar(
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
                    title: Text("Change Pin",
                        style: Theme.of(context).textTheme.bodyLarge),
                    horizontalTitleGap: 0.0,
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text("Report an issue",
                        style: Theme.of(context).textTheme.bodyLarge),
                    horizontalTitleGap: 0.0,
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text("Report an issue",
                        style: Theme.of(context).textTheme.bodyLarge),
                    horizontalTitleGap: 0.0,
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text("Log out",
                        style: Theme.of(context).textTheme.bodyLarge),
                    horizontalTitleGap: 0.0,
                    onTap: () {},
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
