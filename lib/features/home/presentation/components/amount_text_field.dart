import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/resources/global.dart';

class AmountTextField extends StatelessWidget {
  final Function(num) onChanged;

  const AmountTextField({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        ThousandsSeparatorInputFormatter(),
      ],
      onChanged: (text) {
        String strippedString = text.splitMapJoin(',', onMatch: (match) {
          return "";
        });

        onChanged(num.parse(strippedString));
      },
      decoration: InputDecoration(
          filled: false,
          border: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.grey),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.grey),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary),
          ),
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.error),
          ),
          focusedErrorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.error),
          ),
          prefix: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              "₦",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          hintText: "50,000",
          hintStyle: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.copyWith(color: AppColors.grey)),
      style: Theme.of(context).textTheme.headlineLarge,
    );
  }
}
