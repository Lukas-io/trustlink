import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trustlink/features/home/presentation/pages/home_screen.dart';
import 'package:trustlink/features/home/presentation/pages/profile_screen.dart';
import 'package:trustlink/features/home/presentation/pages/transactions_screen.dart';

import '../../../core/constants/app_colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

List<Widget> screens = [
  const HomeScreen(),
  const TransactionsScreen(),
  const ProfileScreen(),
];

int selectedIndex = 0;

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border(
              top: BorderSide(
                color: AppColors.outline.withOpacity(0.3),
                width: 1,
              ),
            ),
          ),
          child: BottomNavigationBar(
            currentIndex: selectedIndex,
            iconSize: 26.0,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.grey,
            backgroundColor: AppColors.white,
            elevation: 0,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Icon(Icons.home_outlined),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Icon(Icons.home),
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Icon(CupertinoIcons.doc_text),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Icon(CupertinoIcons.doc_text_fill),
                ),
                label: "Transactions",
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Icon(CupertinoIcons.profile_circled),
                ),
                label: "Profile",
              ),
            ],
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          )),
      body: screens[selectedIndex],
    );
  }
}
