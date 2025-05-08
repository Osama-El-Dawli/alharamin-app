import 'package:alharamin_app/core/helpers/service_locator.dart';
import 'package:alharamin_app/core/routes/router.dart';
import 'package:alharamin_app/core/theme/app_colors.dart';
import 'package:alharamin_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupServiceLocator();
  runApp(AlharaminApp());
}

class AlharaminApp extends StatelessWidget {
  const AlharaminApp({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    Size designSize = width > 600 ? Size(1440, 900) : Size(375, 812);
    return ScreenUtilInit(
      designSize: designSize,
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
