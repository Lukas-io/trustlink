import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trustlink/core/constants/app_colors.dart';

import '../../../../injection_container.dart';
import '../bloc/account_bloc.dart';
import '../bloc/account_state.dart';

class BankDetailsModal extends StatefulWidget {
  const BankDetailsModal({super.key});

  @override
  State<BankDetailsModal> createState() => _BankDetailsModalState();
}

class _BankDetailsModalState extends State<BankDetailsModal> {
  @override
  void initState() {
    // sl<AccountBloc>().add(Get)
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: BlocProvider<AccountBloc>.value(
        value: sl<AccountBloc>(),
        child:
            BlocBuilder<AccountBloc, AccountState>(builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Bank Details",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  "Bank name: TestAccount",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Row(
                  children: [
                    Text(
                      "Bank Account: 9032092332",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    IconButton(
                      onPressed: () =>
                          Clipboard.setData(ClipboardData(text: "3298322")),
                      icon: Icon(
                        Icons.copy,
                        size: 20.0,
                        color: AppColors.secondary,
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
