import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trustlink/core/constants/app_colors.dart';
import 'package:trustlink/features/auth/presentation/pages/login_screen.dart';
import 'package:trustlink/features/home/presentation/components/profile_widget.dart';
import 'package:trustlink/features/home/presentation/pages/change_password_screen.dart';
import 'package:trustlink/features/home/presentation/pages/how_to_use_screen.dart';

import '../../../../core/components/page_info_dialog.dart';
import '../../../../injection_container.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _showProfileInfo(BuildContext context) {
    showPageInfoDialog(
      context: context,
      title: "Your Profile",
      items: const [
        InfoItem(
          icon: Icons.person_outline,
          title: "Account Details",
          description:
              "View and manage your personal information and account settings.",
        ),
        InfoItem(
          icon: Icons.lock_outline,
          title: "Security",
          description:
              "Change your password to keep your account secure.",
        ),
        InfoItem(
          icon: Icons.help_outline,
          title: "Need Help?",
          description:
              "Check 'How to Use Trustlink' for a quick guide on escrow, payments, and more.",
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        centerTitle: false,
        titleSpacing: 24,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () => _showProfileInfo(context),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.outline.withOpacity(0.3),
                  ),
                ),
                child: const Icon(
                  Icons.info_outline,
                  size: 20,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const ProfileWidget(),
              const SizedBox(height: 24),
              _ProfileTile(
                icon: Icons.lock_outline,
                title: "Change Password",
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ChangePasswordScreen()));
                },
              ),
              const SizedBox(height: 8),
              _ProfileTile(
                icon: Icons.menu_book_outlined,
                title: "How to Use Trustlink",
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HowToUseScreen()));
                },
              ),
              const SizedBox(height: 8),
              _ProfileTile(
                icon: Icons.logout_rounded,
                title: "Log out",
                isDestructive: true,
                onTap: () {
                  sl<SharedPreferences>().remove("bearer");
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const LoginScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isDestructive;

  const _ProfileTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? AppColors.error : AppColors.text;

    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: isDestructive
                      ? AppColors.error.withOpacity(0.08)
                      : AppColors.primary.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  size: 18,
                  color: isDestructive ? AppColors.error : AppColors.primary,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ),
              Icon(
                CupertinoIcons.chevron_right,
                size: 16,
                color: isDestructive
                    ? AppColors.error.withOpacity(0.5)
                    : AppColors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
