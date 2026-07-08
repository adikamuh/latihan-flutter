import 'package:isar_community/isar.dart';
import 'package:latihan1/core/services/dio_client.dart';
import 'package:latihan1/core/services/env_service.dart';
import 'package:latihan1/core/services/isar_service.dart';
import 'package:latihan1/core/services/shared_pref_service.dart';
import 'package:latihan1/features/auth/data/datasource/auth_datasource.dart';
import 'package:latihan1/features/auth/data/datasource/auth_datasource_impl.dart';
import 'package:latihan1/features/auth/data/datasource/auth_local_datasource.dart';
import 'package:latihan1/features/auth/data/datasource/auth_local_datasource_impl.dart';
import 'package:latihan1/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:latihan1/features/auth/domain/repositories/auth_repository.dart';
import 'package:latihan1/features/auth/domain/usecases/check_auth.dart';
import 'package:latihan1/features/auth/domain/usecases/get_tenant.dart';
import 'package:latihan1/features/auth/domain/usecases/login_usecase.dart';
import 'package:latihan1/features/auth/domain/usecases/save_tenant.dart';
import 'package:latihan1/features/auth/domain/usecases/tenant_usecase.dart';
import 'package:latihan1/features/auth/presentation/providers/attendance_selfie_provider.dart';
import 'package:latihan1/features/auth/presentation/providers/auth_provider.dart';
import 'package:latihan1/features/auth/presentation/providers/splash_provider.dart';
import 'package:latihan1/features/auth/presentation/providers/tenant_provider.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initDependecies() async {
  await EnvService.init();
  await SharedPrefService.init();

  DioClient.init();
  await IsarService.init();

  sl.registerLazySingleton<Isar>(() => IsarService.isar);

  /// Features - Auth
  /// Data sources
  sl.registerLazySingleton<AuthDatasource>(
    () => AuthDatasourceImpl(DioClient.instance),
  );
  sl.registerLazySingleton<AuthLocalDatasource>(
    () => AuthLocalDatasourceImpl(sl<Isar>()),
  );

  /// Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()),
  );

  /// Usecases
  sl.registerLazySingleton<LoginUsecase>(() => LoginUsecase(sl()));
  sl.registerLazySingleton<TenantUsecase>(() => TenantUsecase(sl()));
  sl.registerLazySingleton<GetTenant>(() => GetTenant(sl()));
  sl.registerLazySingleton<SaveTenant>(() => SaveTenant(sl()));
  sl.registerLazySingleton<CheckAuth>(() => CheckAuth(sl()));

  /// Providers
  sl.registerLazySingleton<SplashProvider>(
    () => SplashProvider(getTenantUsecase: sl(), checkAuthUsecase: sl()),
  );
  sl.registerLazySingleton<TenantProvider>(
    () => TenantProvider(getTenant: sl(), saveTenant: sl()),
  );
  sl.registerLazySingleton<AuthProvider>(
    () => AuthProvider(
      loginUsecase: sl(),
      getTenantUsecase: sl(),
      authRepository: sl(),
    ),
  );
  sl.registerLazySingleton<AttendanceSelfieProvider>(
    () => AttendanceSelfieProvider(),
  );
}
