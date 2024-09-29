import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trustlink/features/home/presentation/pages/fund_screen.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/resources/global.dart';
import '../../../../injection_container.dart';
import '../../data/models/account/wallet_model.dart';
import '../bloc/account_bloc.dart';
import '../bloc/account_event.dart';
import '../bloc/account_state.dart';

class WalletWidget extends StatefulWidget {
  const WalletWidget({
    super.key,
  });

  @override
  State<WalletWidget> createState() => _WalletWidgetState();
}

class _WalletWidgetState extends State<WalletWidget> {
  @override
  void initState() {
    sl<AccountBloc>().add(GetWalletEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AccountBloc>.value(
      value: sl<AccountBloc>(),
      child: BlocBuilder<AccountBloc, AccountState>(
          buildWhen: (previous, current) {
        if (current is AccountSuccess<GetWalletEvent, WalletModel>
            // ||
            // current is AccountLoading<GetWalletEvent>
            ) {
          return true;
        } else {
          return false;
        }
      }, builder: (context, state) {
        return Card(
          child: Container(
            width: double.infinity,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Wallet Balance",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: AppColors.grey),
                    ),
                    state is AccountSuccess<GetWalletEvent, WalletModel>
                        ? Text(
                            Global.formatCurrency(
                                state.data!.wallet!.balance!.toString()),
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.headlineMedium,
                          )
                        : Shimmer.fromColors(
                            baseColor: AppColors.bg,
                            highlightColor: AppColors.secondary,
                            child: Text(
                              "Loading...",
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const FundScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      padding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 0.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0))),
                  child: Text(
                    "Fund",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
