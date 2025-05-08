import 'package:alharamin_app/core/helpers/chache_helper.dart';
import 'package:alharamin_app/features/auth/data/cubit/auth_cubit.dart'; // Import AuthCubit
import 'package:alharamin_app/features/auth/data/repositories/auth_repository.dart'; // Import IAuthRepository
import 'package:alharamin_app/features/auth/data/repositories/firebase_auth_repository.dart'; // Import FirebaseAuthRepository
import 'package:alharamin_app/features/booking/data/repositories/firebase_booking_repository.dart'; // Import repository implementation
import 'package:alharamin_app/features/booking/data/repositories/booking_repository.dart'; // Import repository interface
import 'package:get_it/get_it.dart';

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
}
