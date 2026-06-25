import 'package:latihan1/core/services/dio_client.dart';
import 'package:latihan1/core/services/env_service.dart';
import 'package:latihan1/core/services/shared_pref_service.dart';
import 'package:latihan1/features/auth/data/datasource/auth_datasource.dart';
import 'package:latihan1/features/auth/data/datasource/auth_datasource_impl.dart';
import 'package:latihan1/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:latihan1/features/auth/domain/repositories/auth_repository.dart';
import 'package:latihan1/features/auth/domain/usecases/login_usecase.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initDependecies() async {
  DioClient.init();
  await SharedPrefService.init();
  await EnvService.init();

  /// Features - Auth
  /// Data sources
  sl.registerLazySingleton<AuthDatasource>(
    () => AuthDatasourceImpl(DioClient.instance),
  );

  /// Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  /// Usecases
  sl.registerLazySingleton(() => LoginUsecase(sl()));
}
