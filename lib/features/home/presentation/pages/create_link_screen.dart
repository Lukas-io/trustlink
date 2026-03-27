import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:trustlink/core/resources/global.dart';

import '../../../../core/constants/app_colors.dart';
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
        child: BlocConsumer<AccountBloc, AccountState>(
          listener: (context, state) {
            if (state is AccountSuccess<GenerateLinkEvent, String>) {
              String generatedLink = state.data!;
              String copyText =
                  "Recipient: $recipient\nAmount: $amount\nPayment link: $generatedLink";

              showCupertinoDialog(
                context: context,
                barrierDismissible: true,
                builder: (context) => Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppColors.completedBg,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.check_circle_outline,
                            color: AppColors.completedText,
                            size: 24,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Link Created",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.text,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "This link is only for $email. Don't share it with anyone else.",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: () {
                            Clipboard.setData(
                                ClipboardData(text: generatedLink));
                            HapticFeedback.lightImpact();
                            Global.showResponseMessage(
                                message: "Link copied");
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.06),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    generatedLink,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(
                                  Icons.copy_rounded,
                                  size: 16,
                                  color: AppColors.primary,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Clipboard.setData(
                                  ClipboardData(text: copyText));
                              HapticFeedback.lightImpact();
                              Share.share(copyText,
                                  subject: "Payment for $description");
                            },
                            icon: const Icon(Icons.share_outlined, size: 18),
                            label: const Text("Share Link"),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            "Done",
                            style:
                                TextStyle(color: AppColors.textSecondary),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      "Generate a payment link for your buyer. The link is unique to the recipient.",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 24),
                    AmountTextField(onChanged: (number) {
                      amount = number;
                    }),
                    const SizedBox(height: 20),
                    TextField(
                      decoration: const InputDecoration(
                        hintText: "Recipient Name",
                        prefixIcon: Icon(Icons.person_outline,
                            color: AppColors.grey),
                      ),
                      onChanged: (text) => recipient = text,
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      autofillHints: const [AutofillHints.email],
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: "Recipient Email",
                        prefixIcon: Icon(Icons.email_outlined,
                            color: AppColors.grey),
                      ),
                      onChanged: (text) => email = text,
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      maxLines: 3,
                      decoration: const InputDecoration(
                        hintText: "What's this payment for?",
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(bottom: 48),
                          child: Icon(Icons.receipt_long_outlined,
                              color: AppColors.grey),
                        ),
                      ),
                      onChanged: (text) => description = text,
                    ),
                    const SizedBox(height: 28),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (amount == 0 ||
                              recipient.isEmpty ||
                              email.isEmpty) {
                            Global.showErrorMessage(
                                message: "Please fill in all required fields");
                          } else {
                            sl<AccountBloc>().add(GenerateLinkEvent(
                              amount: amount.toString(),
                              customerEmail: email,
                              narration: description,
                              customerName: recipient,
                            ));
                          }
                        },
                        child: state is AccountLoading<GenerateLinkEvent>
                            ? const SizedBox(
                                height: 22,
                                width: 22,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : const Text("Generate Payment Link"),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
