import 'package:get_it/get_it.dart';
import 'package:alharamin_app/core/helpers/chache_helper.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  final cacheHelper = CacheHelper();
  await cacheHelper.init();

  getIt.registerLazySingleton<CacheHelper>(() => cacheHelper);
}
