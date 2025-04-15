import 'package:alharamin_app/core/routes/app_routes.dart';
import 'package:alharamin_app/features/login/presentation/screens/login_screen.dart';
import 'package:alharamin_app/features/on_boarding/presentation/screens/on_boarding_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: AppRoutes.onBoarding,
      builder: (context, state) => const OnBoardingScreen(),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginScreen(),
    ),
  ],
);
