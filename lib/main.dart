import 'package:alharamin_app/core/helpers/service_loactor.dart';
import 'package:alharamin_app/core/routes/router.dart';
import 'package:alharamin_app/core/theme/app_colors.dart';
import 'package:alharamin_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupServiceLocator();
  runApp(AlharaminApp());
}

class AlharaminApp extends StatelessWidget {
  const AlharaminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp.router(
        theme: ThemeData(
          checkboxTheme: CheckboxThemeData(
            side: BorderSide(color: AppColors.lightGrey),
          ),
          scaffoldBackgroundColor: Colors.white,
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: AppColors.primary,
            selectionColor: AppColors.primary,
            selectionHandleColor: AppColors.lighterGrey,
          ),
        ),
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}
