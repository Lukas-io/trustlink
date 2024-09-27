import 'package:flutter/material.dart';
import 'package:trustlink/config/themes.dart';
import 'package:trustlink/splash_screen.dart';

import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.appThemeData,
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
