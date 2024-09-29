import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PinWidget extends StatelessWidget {
  final int digits;
  final void Function(List<String>) onPinEntered;
  final bool obscure;

  const PinWidget(
      {super.key,
      required this.digits,
      required this.onPinEntered,
      this.obscure = false});

  @override
  Widget build(BuildContext context) {
    FocusNode node = FocusNode();
    List<String> stringList = List.generate(digits, (index) => "");
    int currentIndex = 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(digits, (index) {
        TextEditingController textC = TextEditingController();

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 64.0,
              ),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: textC,
                textAlign: TextAlign.center,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                autofocus: true,
                decoration: const InputDecoration(),
                focusNode: currentIndex == index ? node : null,
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(fontWeight: FontWeight.w600),
                onChanged: (text) {
                  if (text.isNotEmpty) {
                    textC.text = text.split("").last;
                    stringList[index] = textC.text;

                    Timer(const Duration(milliseconds: 400), () {
                      textC.text = "*";
                    });

                    onPinEntered(stringList);
                    node.nextFocus();
                  }
                },
                onTapOutside: (event) =>
                    FocusManager.instance.primaryFocus?.unfocus(),
              ),
            ),
          ),
        );
      }),
    );
  }
}
