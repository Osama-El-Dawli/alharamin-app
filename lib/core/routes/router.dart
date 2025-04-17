import 'package:alharamin_app/core/routes/app_routes.dart';
import 'package:alharamin_app/features/home/presentation/screen/admin_home_screen.dart';
import 'package:alharamin_app/features/home/presentation/screen/user_home_screen.dart';
import 'package:alharamin_app/features/login/admin_login/presentation/admin_login_screen.dart';
import 'package:alharamin_app/features/login/user_login/presentation/user_login_screen.dart';
import 'package:alharamin_app/features/login/selection_login/presentation/screens/login_selection_screen.dart';
import 'package:alharamin_app/features/on_boarding/presentation/screens/on_boarding_screen.dart';
import 'package:alharamin_app/features/register/presentation/screens/register_screen.dart';
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
