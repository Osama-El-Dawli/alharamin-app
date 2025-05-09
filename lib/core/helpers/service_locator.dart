import 'package:alharamin_app/core/helpers/chache_helper.dart';
import 'package:get_it/get_it.dart';
import 'package:alharamin_app/features/auth/data/cubit/auth_cubit.dart';
import 'package:alharamin_app/features/auth/data/repositories/auth_repository.dart';
import 'package:alharamin_app/features/auth/data/repositories/firebase_auth_repository.dart';
import 'package:alharamin_app/features/booking/data/repositories/booking_repository.dart';
import 'package:alharamin_app/features/booking/data/repositories/firebase_booking_repository.dart';
import 'package:alharamin_app/features/doctor/data/repository/i_doctor_repository.dart';
import 'package:alharamin_app/features/doctor/data/repository/firebase_doctor_repository.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  final cacheHelper = CacheHelper();
  await cacheHelper.init();

  getIt.registerLazySingleton<CacheHelper>(() => CacheHelper());

  getIt.registerLazySingleton<IBookingRepository>(
    () => FirebaseBookingRepository(),
  );

  getIt.registerLazySingleton<IAuthRepository>(
    () => FirebaseAuthRepository(),
  );

  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(getIt<IAuthRepository>()),
  );

  getIt.registerLazySingleton<IDoctorRepository>(
    () => FirebaseDoctorRepository(),
  );
}
