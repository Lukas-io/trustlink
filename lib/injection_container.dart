import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/resources/interceptor.dart';
import 'features/auth/data/repositories/auth_repository.dart';
import 'features/auth/data/sources/auth_api_service.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/home/data/repositories/account_repository.dart';
import 'features/home/data/sources/account_api_service.dart';
import 'features/home/presentation/bloc/account/account_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());
  String? token = sl<SharedPreferences>().getString("bearer");
  //dio
  sl.registerSingleton<Dio>(Dio());
  if (token != null) {
    sl<Dio>().interceptors.add(AuthInterceptor(token));
  }

  //Auth
  sl.registerSingleton<AuthApiService>(AuthApiService(sl<Dio>()));
  sl.registerSingleton<AuthRepository>(AuthRepository(sl<AuthApiService>()));
  sl.registerSingleton<AuthBloc>(AuthBloc(sl<AuthRepository>()));

  //Account
  sl.registerSingleton<AccountApiService>(AccountApiService(sl<Dio>()));
  sl.registerSingleton<AccountRepository>(
      AccountRepository(sl<AccountApiService>()));
  sl.registerSingleton<AccountBloc>(AccountBloc(sl<AccountRepository>()));

  // //Transaction
  // sl.registerSingleton<TransactionApiService>(TransactionApiService(sl<Dio>()));
  // sl.registerSingleton<TransactionRepository>(
  //     TransactionRepository(sl<TransactionApiService>()));
  // sl.registerSingleton<TransactionBloc>(
  //     TransactionBloc(sl<TransactionRepository>()));
}
