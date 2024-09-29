import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final Function() onPressed;
  final EdgeInsets? padding;
  final String title;
  final bool? isLoading;

  const PrimaryButton({
    super.key,
    required this.onPressed,
    this.padding,
    required this.title,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
      child: ElevatedButton(
        onPressed: () {
          FocusManager.instance.primaryFocus?.unfocus();
          onPressed();
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            padding: padding ??
                const EdgeInsets.symmetric(
                  vertical: 16.0,
                ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0))),
        child: isLoading ?? false
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.white, fontWeight: FontWeight.w600),
              ),
      ),
    );
  }
}
