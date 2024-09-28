import 'package:flutter/material.dart';
import 'package:trustlink/features/home/presentation/home.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../auth/presentation/components/pin_widget.dart';

class SetPinScreen extends StatelessWidget {
  const SetPinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String pin = "";
    return Scaffold(
      appBar: AppBar(
        title: const Text("Set up new pin"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            children: [
              SizedBox(
                height: 24.0,
              ),
              PinWidget(
                digits: 4,
                // obscure: true,
                onPinEntered: (pinList) {
                  pin = pinList.join();
                },
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 24.0),
                child: ElevatedButton(
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (pin.length < 4) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: AppColors.error,
                          content: Text("Please fill all the fields")));
                    } else {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const Home(),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0))),
                  child: Text(
                    "Set Pin",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
