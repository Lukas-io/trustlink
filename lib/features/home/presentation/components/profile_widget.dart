import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trustlink/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:trustlink/features/auth/presentation/bloc/auth_event.dart';
import 'package:trustlink/features/auth/presentation/bloc/auth_state.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../injection_container.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  void initState() {
    sl<AuthBloc>().add(GetUserEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>.value(
      value: sl<AuthBloc>(),
      child: BlocBuilder<AuthBloc, AuthState>(
        buildWhen: (previous, current) {
          print(current);
          if (current is AuthSuccess<GetUserEvent>) {
            return true;
          }
          if (current is AuthLoading<GetUserEvent>) {
            return true;
          }
          if (current is AuthException) {
            return true;
          }
          return false;
        },
        builder: (context, state) {
          return Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.mainColor.shade100,
                radius: 35.0,
                child: state is AuthSuccess<GetUserEvent>
                    ? Center(
                        child: Text(
                          "${state.user!.user!.firstName![0]}${state.user!.user!.lastName![0]}",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(color: AppColors.primary),
                        ),
                      )
                    : const Text(""),
              ),
              const SizedBox(
                width: 12.0,
              ),
              state is AuthSuccess<GetUserEvent>
                  ? Text(
                      "${state.user!.user!.firstName!} ${state.user!.user!.lastName!}",
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge,
                    )
                  : Shimmer.fromColors(
                      baseColor: AppColors.bg,
                      highlightColor: AppColors.primary,
                      child: Text(
                        "Loading...",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }
}
