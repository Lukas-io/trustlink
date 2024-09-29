import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:trustlink/core/resources/global.dart';

import '../../../../core/components/primary_button.dart';
import '../../../../injection_container.dart';
import '../bloc/account_bloc.dart';
import '../bloc/account_event.dart';
import '../bloc/account_state.dart';
import '../components/amount_text_field.dart';

class CreateLinkScreen extends StatelessWidget {
  const CreateLinkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    num amount = 0;
    String description = "";
    String email = "";
    String recipient = "";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Payment Link"),
      ),
      body: BlocProvider<AccountBloc>.value(
        value: sl<AccountBloc>(),
        child:
            BlocConsumer<AccountBloc, AccountState>(listener: (context, state) {
          if (state is AccountSuccess<GenerateLinkEvent, String>) {
            String generatedLink = state.data!;
            String copyText =
                "Recipient: $recipient, \nAmount: $amount, \nPayment link: $generatedLink";

            showDialog(
              context: context,
              builder: (context) => Dialog(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Created Successfully",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                          "Warning, This link should only be used to the recipient of this email ($email)"),
                      GestureDetector(
                        onTap: () {
                          Clipboard.setData(ClipboardData(
                              text:
                                  "Recipient: $recipient, \nAmount: $amount, \nPayment link: $generatedLink"));
                          HapticFeedback.lightImpact();
                          Global.showResponseMessage(message: "Link Copied");
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4.0),
                          child: Text(
                            generatedLink,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.lightBlue),
                          ),
                        ),
                      ),
                      PrimaryButton(
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: copyText));
                            HapticFeedback.lightImpact();
                            Share.share(copyText,
                                subject: "Payment for $description");
                          },
                          title: "Share")
                    ],
                  ),
                ),
              ),
            );
          }
        }, builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "The payment link is only for the the recipient",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  AmountTextField(onChanged: (number) {
                    amount = number;
                  }),
                  const SizedBox(
                    height: 24.0,
                  ),
                  const Text("Recipient Name"),
                  TextField(
                      style: Theme.of(context).textTheme.bodyLarge,
                      onChanged: (text) => recipient = text),
                  const SizedBox(
                    height: 12.0,
                  ),
                  const Text("Recipient Email"),
                  TextField(
                      style: Theme.of(context).textTheme.bodyLarge,
                      autofillHints: [AutofillHints.email],
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (text) => email = text),
                  const SizedBox(
                    height: 12.0,
                  ),
                  const Text("Narration"),
                  TextField(
                      style: Theme.of(context).textTheme.bodyLarge,
                      maxLines: 4,
                      decoration: const InputDecoration(
                          hintText: "Eg. Hikers Crocs, Bob Wig"),
                      onChanged: (text) => description = text),
                  PrimaryButton(
                    onPressed: () {
                      if (amount == 0 || recipient.isEmpty || email.isEmpty) {
                        Global.showErrorMessage(
                            message: "Kindly fill all the fields");
                      } else {
                        sl<AccountBloc>().add(GenerateLinkEvent(
                          amount: amount.toString(),
                          customerEmail: email,
                          narration: description,
                          customerName: recipient,
                        ));
                      }
                    },
                    title: "Create",
                    isLoading: state is AccountLoading<GenerateLinkEvent>,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
