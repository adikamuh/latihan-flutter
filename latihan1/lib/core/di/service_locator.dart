import 'package:isar_community/isar.dart';
import 'package:latihan1/core/services/dio_client.dart';
import 'package:latihan1/core/services/env_service.dart';
import 'package:latihan1/core/services/isar_service.dart';
import 'package:latihan1/core/services/shared_pref_service.dart';
import 'package:latihan1/features/attendance/data/datasources/geoapify_datasource.dart';
import 'package:latihan1/features/attendance/data/datasources/geoapify_datasource_impl.dart';
import 'package:latihan1/features/attendance/data/repositories/geoapify_repository_impl.dart';
import 'package:latihan1/features/attendance/domain/repositories/geoapify_repository.dart';
import 'package:latihan1/features/attendance/domain/usecases/get_reverse_geoapify.dart';
import 'package:latihan1/features/attendance/presentation/providers/attendance_confirm_provider.dart';
import 'package:latihan1/features/attendance/presentation/providers/attendance_location_provider.dart';
import 'package:latihan1/features/attendance/presentation/providers/attendance_selfie_provider.dart';
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
  sl.registerLazySingleton<GeoapifyDatasource>(() => GeoapifyDatasourceImpl());

  /// Repositories
  sl.registerLazySingleton<AuthRepository>(
    // PERBAIKAN: Berikan tipe eksplisit
    () => AuthRepositoryImpl(sl<AuthDatasource>(), sl<AuthLocalDatasource>()),
  );
  sl.registerLazySingleton<GeoapifyRepository>(
    // PERBAIKAN: Berikan tipe eksplisit
    () => GeoapifyRepositoryImpl(
      sl<GeoapifyDatasource>(),
      // Catatan: Parameter kedua di konstruktor GeoapifyRepositoryImpl adalah `Object`.
      // Jika tidak dibutuhkan, sebaiknya dihapus dari konstruktor, tetapi untuk saat ini
      // kita bisa berikan `sl<GeoapifyDatasource>()` lagi atau `Object` dummy.
      sl<GeoapifyDatasource>(),
    ),
  );

  /// Usecases
  sl.registerLazySingleton<LoginUsecase>(
    () => LoginUsecase(sl<AuthRepository>()),
  );
  sl.registerLazySingleton<TenantUsecase>(
    () => TenantUsecase(sl<AuthRepository>()),
  );
  sl.registerLazySingleton<GetTenant>(() => GetTenant(sl<AuthRepository>()));
  sl.registerLazySingleton<SaveTenant>(() => SaveTenant(sl<AuthRepository>()));
  sl.registerLazySingleton<CheckAuth>(() => CheckAuth(sl<AuthRepository>()));
  sl.registerLazySingleton<GetReverseGeoapify>(
    () => GetReverseGeoapify(sl<GeoapifyRepository>()),
  );

  /// Providers
  sl.registerLazySingleton<SplashProvider>(
    () => SplashProvider(
      getTenantUsecase: sl<GetTenant>(),
      checkAuthUsecase: sl<CheckAuth>(),
    ),
  );
  sl.registerLazySingleton<TenantProvider>(
    () => TenantProvider(
      getTenant: sl<GetTenant>(),
      saveTenant: sl<SaveTenant>(),
      // Jika Anda memiliki GetSavedTenant, tambahkan di sini:
      // getSavedTenant: sl<GetSavedTenant>(),
    ),
  );
  sl.registerLazySingleton<AuthProvider>(
    () => AuthProvider(
      loginUsecase: sl<LoginUsecase>(),
      getTenantUsecase: sl<GetTenant>(),
      authRepository: sl<AuthRepository>(),
    ),
  );
  sl.registerLazySingleton<AttendanceLocationProvider>(
    () => AttendanceLocationProvider(
      getReverseGeoapify: sl<GetReverseGeoapify>(),
    ),
  );
  sl.registerLazySingleton<AttendanceSelfieProvider>(
    () => AttendanceSelfieProvider(),
  );
  sl.registerLazySingleton<AttendanceConfirmProvider>(
    () => AttendanceConfirmProvider(),
  );
}
