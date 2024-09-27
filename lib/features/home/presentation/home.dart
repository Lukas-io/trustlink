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
      bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(24)),
          child: BottomNavigationBar(
            currentIndex: selectedIndex,
            iconSize: 30.0,
            selectedItemColor: AppColors.primary,
            backgroundColor: AppColors.white,
            selectedFontSize: 14,
            unselectedFontSize: 14,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.doc_text),
                activeIcon: Icon(CupertinoIcons.doc_text_fill),
                label: "Transactions",
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.profile_circled),
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
