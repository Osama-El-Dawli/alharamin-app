import 'dart:io';

import 'package:alharamin_app/core/helpers/service_loactor.dart';
import 'package:alharamin_app/core/routes/app_routes.dart';
import 'package:alharamin_app/core/routes/extra_params.dart';
import 'package:alharamin_app/features/admin/cubits/admin_login_cubit/admin_login_cubit.dart';
import 'package:alharamin_app/features/admin/presentation/screens/admin_home_screen.dart';
import 'package:alharamin_app/features/auth/cubit/auth_cubit.dart';
import 'package:alharamin_app/features/auth/models/user_model.dart';
import 'package:alharamin_app/features/booking/data/cubit/booking_cubit.dart';
import 'package:alharamin_app/features/booking/presentation/screens/booking_details_screen.dart';
import 'package:alharamin_app/features/booking/presentation/screens/booking_screen.dart';
import 'package:alharamin_app/features/chatbot/presentation/screens/chat_bot_screen.dart';
import 'package:alharamin_app/features/doctor/data/cubit/doctor_cubit/doctor_cubit.dart';
import 'package:alharamin_app/features/doctor/presentation/screens/doctor_screen.dart';
import 'package:alharamin_app/features/home/presentation/screen/user_home_screen.dart';
import 'package:alharamin_app/features/admin/presentation/screens/admin_login_screen.dart';
import 'package:alharamin_app/features/auth/presentation/screens/user_login_screen.dart';
import 'package:alharamin_app/features/on_boarding/presentation/screens/auth_gate.dart';
import 'package:alharamin_app/features/on_boarding/presentation/screens/on_boarding_screen.dart';
import 'package:alharamin_app/features/auth/presentation/screens/register_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

bool isMobile() => !kIsWeb && (Platform.isAndroid || Platform.isIOS);
bool isDesktop() =>
    !kIsWeb && (Platform.isWindows || Platform.isMacOS || Platform.isLinux);

final router = GoRouter(
  initialLocation: AppRoutes.onBoarding,
  routes: [
    GoRoute(
      path: AppRoutes.authGate,
      builder: (context, state) {
        return BlocProvider(
          create: (context) => getIt.get<AuthCubit>(),
          child: AuthGate(),
        );
      },
    ),
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
      builder:
          (context, state) => BlocProvider(
            create: (context) => getIt.get<AuthCubit>(),
            child: const UserLoginScreen(),
          ),
    ),

    GoRoute(
      path: AppRoutes.adminLogin,
      builder: (context, state) => const AdminLoginScreen(),
    ),

    GoRoute(
      path: AppRoutes.register,
      builder:
          (context, state) => BlocProvider(
            create: (context) => AuthCubit(),
            child: const RegisterScreen(),
          ),
    ),

    GoRoute(
      path: AppRoutes.adminHome,
      builder:
          (context, state) => BlocProvider(
            create: (context) => AdminLoginCubit(),
            child: const AdminHomeScreen(),
          ),
    ),

    GoRoute(
      path: AppRoutes.userHome,
      builder: (context, state) {
        final userModel = state.extra as UserModel;
        return UserHomeScreen(user: userModel);
      },
    ),

    GoRoute(
      path: AppRoutes.doctor,
      builder: (context, state) {
        final doctorScreeenParams = state.extra as DoctorScreeenParams;
        return BlocProvider(
          create:
              (context) =>
                  DoctorCubit()..fetchDoctorsBySpeciality(
                    speciality: doctorScreeenParams.specialityName,
                  ),

          child: DoctorScreen(
            specialityName: doctorScreeenParams.specialityName,
            userModel: doctorScreeenParams.userModel,
          ),
        );
      },
    ),

    GoRoute(
      path: AppRoutes.booking,
      builder: (context, state) {
        final bookingScreenParams = state.extra as BookingScreenParams;
        return BlocProvider(
          create:
              (context) => BookingCubit(
                doctor: bookingScreenParams.doctorModel,
                patientId: bookingScreenParams.userModel.uid,
              ),
          child: BookingScreen(
            doctorModel: bookingScreenParams.doctorModel,
            userModel: bookingScreenParams.userModel,
          ),
        );
      },
    ),

    GoRoute(
      path: AppRoutes.bookingDetails,
      builder: (context, state) {
        final bookingDetailsParams = state.extra as BookingDetailsParams;
        return BlocProvider(
          create:
              (context) => BookingCubit(
                doctor: bookingDetailsParams.doctorModel,
                patientId: bookingDetailsParams.userModel.uid,
              ),
          child: BookingDetailsScreen(
            doctorModel: bookingDetailsParams.doctorModel,
            appointmentModel: bookingDetailsParams.appointmentModel,
            userModel: bookingDetailsParams.userModel,
          ),
        );
      },
    ),

    GoRoute(
      path: AppRoutes.chatBot,
      builder: (context, state) => ChatBotScreen(),
    ),
  ],
);
