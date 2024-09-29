import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trustlink/features/home/presentation/bloc/account_event.dart';

import '../../../../core/resources/global.dart';
import '../../../../injection_container.dart';
import '../bloc/account_bloc.dart';
import '../bloc/account_state.dart';

class ChangePinScreen extends StatelessWidget {
  const ChangePinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String oldPassword = "";
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Pin"),
      ),
      body: BlocProvider<AccountBloc>.value(
        value: sl<AccountBloc>(),
        child:
            BlocConsumer<AccountBloc, AccountState>(listener: (context, state) {
          if (state is AccountSuccess<UpdatePinEvent, String>) {
            Global.showResponseMessage(message: state.data!);

            Navigator.of(context).pop();
          }
        }, builder: (context, state) {
          return Column(
            children: [],
          );
        }),
      ),
    );
  }
}
