import 'dart:io';

import 'package:alharamin_app/core/routes/app_routes.dart';
import 'package:alharamin_app/features/admin/presentation/screens/admin_home_screen.dart';
import 'package:alharamin_app/features/home/presentation/screen/user_home_screen.dart';
import 'package:alharamin_app/features/admin/presentation/screens/admin_login_screen.dart';
import 'package:alharamin_app/features/auth/presentation/screens/user_login_screen.dart';
import 'package:alharamin_app/features/on_boarding/presentation/screens/on_boarding_screen.dart';
import 'package:alharamin_app/features/auth/presentation/screens/register_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

bool isMobile() => !kIsWeb && (Platform.isAndroid || Platform.isIOS);
bool isDesktop() =>
    !kIsWeb && (Platform.isWindows || Platform.isMacOS || Platform.isLinux);

final router = GoRouter(
  initialLocation: AppRoutes.onBoarding,
  routes: [
    GoRoute(
      path: AppRoutes.onBoarding,
      builder: (context, state) => const OnBoardingScreen(),
    ),
    GoRoute(
      path: AppRoutes.login,
      redirect: (context, state) {
        if (kIsWeb) {
          return AppRoutes.adminLogin;
        } else if (isMobile()) {
          return AppRoutes.userLogin;
        } else if (isDesktop()) {
          return AppRoutes.adminLogin;
        }
        return null;
      },
    ),
    GoRoute(
      path: AppRoutes.userLogin,
      builder: (context, state) => const UserLoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.adminLogin,
      builder: (context, state) => const AdminLoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.register,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: AppRoutes.adminHome,
      builder: (context, state) => const AdminHomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.userHome,
      builder: (context, state) => const UserHomeScreen(),
    ),
  ],
);
