import 'package:alharamin_app/features/auth/data/cubit/auth_cubit.dart';
import 'package:alharamin_app/features/auth/presentation/screens/user_login_screen.dart';
import 'package:alharamin_app/features/home/presentation/screen/user_home_screen.dart';
import 'package:alharamin_app/features/home/presentation/widgets/home_screen_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthInitial && state.isCheckingAutoLogin) {
          return const Scaffold(body: HomeShimmerScreen());
        } else if (state is AuthSuccess) {
          return UserHomeScreen(user: state.user);
        } else {
          return const UserLoginScreen();
        }
      },
    );
  }
}
