import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../constants/app_colors.dart';

class Global {
  static void showAppLoader(BuildContext context) {
    // final overlay = LoadingOverlay(context);
    // overlay.show(context);
  }

  static void dismissAppLoader(BuildContext context) {
    // final overlay = LoadingOverlay(context);
    // overlay.hide();
  }

  static String formatCurrency(String price, [bool removeDecimalZero = true]) {
    final formatter = NumberFormat.currency(locale: 'en_NG', symbol: '₦');
    double value = double.tryParse(price) ?? 0;
    String formattedPrice = formatter.format(value);

    if (removeDecimalZero) {
      // Remove the decimal point and trailing zeros
      if (formattedPrice.contains('.')) {
        formattedPrice = formattedPrice.replaceAll(RegExp(r'\.0+'), '');
      }
    }
    return formattedPrice;
  }

  // static void showAppLoader({required WidgetRef ref}) {
  //   final context = ref.read(mainKeyProvider).currentContext;
  //   if (context != null) {
  //     final overlay = LoadingOverlay.of(context);
  //     overlay.show();
  //   } else {
  //     print('Context is null. Cannot show loading overlay.');
  //   }
  // }

  // static void dismissAppLoader({required WidgetRef ref}) {
  //   final context = ref.read(mainKeyProvider).currentContext;
  //   print("mainKeyProvider: $mainKeyProvider");
  //   print("this is the context $context");
  //   if (context != null) {
  //     final overlay = LoadingOverlay.of(context);
  //     overlay.hide();
  //   } else {
  //     print('Context is null. Cannot dismiss loading overlay.');
  //   }
  // }

  static showSuccessDialog(
      {required BuildContext context,
      description,
      title,
      required buttonText,
      required Function() onPressed,
      required String imagePath}) {
    // showDialog(
    //     context: context,
    //     builder: (context) => CustomDialog(
    //           title: title,
    //           description: description,
    //           onPressed: onPressed,
    //           imagePath: imagePath,
    //           buttonText: buttonText,
    //         ));
  }

  static showErrorDialog(
      {required BuildContext context,
      required String description,
      required String buttonText,
      required Function() onPressed,
      required String imagePath}) {
    // showDialog(
    //     context: context,
    //     builder: (context) => CustomDialog(
    //           description: description,
    //           onPressed: onPressed,
    //           imagePath: imagePath,
    //           buttonText: buttonText,
    //         ));
  }

  static showErrorMessage({required String message}) {
    HapticFeedback.mediumImpact();
    Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 4,
        backgroundColor: AppColors.error,
        textColor: AppColors.white,
        fontSize: 16.0);
  }

  static showResponseMessage({required String message}) {
    HapticFeedback.mediumImpact();

    Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 4,
        backgroundColor: AppColors.secondary,
        textColor: AppColors.bg,
        fontSize: 16.0);
  }

  static showSnackbar({
    required BuildContext context,
    required String message,
    Color backgroundColor = AppColors.primary,
    Color textColor = AppColors.white,
    Duration duration = const Duration(seconds: 3),
  }) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: textColor),
      ),
      backgroundColor: backgroundColor,
      duration: duration,
      // animation: CurvedAnimation(
      //   parent: AnimationController(
      //     vsync: ScaffoldMessenger.of(context),
      //     duration: const Duration(milliseconds: 500),
      //   ),
      //   curve: Curves.easeInOut,
      // ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static showBottomSheet({
    required BuildContext context,
    required Widget child,
    bool isDismissible = true,
    bool enableDrag = true,
  }) {
    showModalBottomSheet(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      builder: (context) => child,
    );
  }

  static snackUnavailableFeature({
    required BuildContext context,
    Color backgroundColor = AppColors.text,
    Duration duration = const Duration(seconds: 5),
  }) {
    final snackBar = SnackBar(
      content: const Text(
        "Currently unavailable. Hang tight, good things come to those who wait!",
        style: TextStyle(color: AppColors.primary),
      ),
      backgroundColor: backgroundColor,
      duration: duration,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      animation: CurvedAnimation(
        parent: AnimationController(
          vsync: Scaffold.of(context),
          duration: const Duration(milliseconds: 500),
        ),
        curve: Curves.easeInOut,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static toastUnavailableFeature(BuildContext context) {
    Fluttertoast.showToast(
        msg:
            "Currently unavailable. Hang tight, good things come to those who wait!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: AppColors.primary,
        textColor: Colors.black,
        fontSize: 16);
  }

// static Future<bool> checkConnection() async {
//   try {
//     final isConnected = await InternetConnectionChecker().hasConnection;
//     debugPrint('Connection check result: $isConnected');
//     return isConnected;
//   } catch (e) {
//     debugPrint('Error checking internet connection: $e');
//     return false;
//   }
// }
}

String formatDate(DateTime date) {
  return "${date.weekdayShort} ${date.day} ${date.monthShort}";
}

// String formatTime(TimeOfDay time) {
//   final now = DateTime.now();
//   final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
//   final format =
//       DateFormat.jm(); // This is the date format for 12-hour format with AM/PM
//   return format.format(dt);
// }

extension DateTimeExtension on DateTime {
  String get weekdayShort {
    switch (weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  String get monthShort {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return '';
    }
  }
}

class CreditCardFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text
        .replaceAll(RegExp(r'\D'), ''); // Remove non-digit characters
    String formattedText = '';

    if (text.length > 16) {
      text = text.substring(0, 16); // Limit the input to 4 digits
    }
    for (int i = 0; i < text.length; i++) {
      if (i % 4 == 0 && i != 0) {
        formattedText += ' '; // Add space every 4 characters
      }
      formattedText += text[i];
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

class ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text
        .replaceAll(RegExp(r'\D'), ''); // Remove non-digit characters

    if (text.length > 4) {
      text = text.substring(0, 4); // Limit the input to 4 digits
    }

    if (text.length >= 3) {
      text = '${text.substring(0, 2)}/${text.substring(2)}'; // Format as MM/YY
    }

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat.decimalPattern();

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;

    if (newText.isEmpty) return newValue;

    newText = newText.replaceAll(',', '');

    final int? value = int.tryParse(newText);
    if (value == null) {
      return oldValue;
    } // If the input is invalid, keep the old value

    // Format the number with commas
    final String formattedText = _formatter.format(value);

    // Create the new cursor position
    final int newSelectionIndex =
        formattedText.length - (newValue.text.length - newValue.selection.end);

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: newSelectionIndex),
    );
  }
}
