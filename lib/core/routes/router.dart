import 'package:alharamin_app/core/routes/app_routes.dart';
import 'package:alharamin_app/features/home/presentation/screen/admin_home_screen.dart';
import 'package:alharamin_app/features/login/presentation/screens/admin_login_screen.dart';
import 'package:alharamin_app/features/login/presentation/screens/user_login_screen.dart';
import 'package:alharamin_app/features/login/presentation/screens/login_selection_screen.dart';
import 'package:alharamin_app/features/on_boarding/presentation/screens/on_boarding_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: AppRoutes.onBoarding,
      builder: (context, state) => const OnBoardingScreen(),
    ),

    GoRoute(
      path: AppRoutes.loginSelection,
      builder: (context, state) => const LoginSelectionScreen(),
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
      path: AppRoutes.adminHome,
      builder: (context, state) => const AdminHomeScreen(),
    )
  ],
);
