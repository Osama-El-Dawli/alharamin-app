import 'package:alharamin_app/core/functions/snack_bar.dart';
import 'package:alharamin_app/core/routes/app_routes.dart';
import 'package:alharamin_app/features/auth/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            snackBar(context, content: state.errMessage);
          } else if (state is AuthInitial && !state.isCheckingAutoLogin) {
            // 🚀 Navigates after logout
            context.go(AppRoutes.onBoarding);
          }
        },
        child: Scaffold(
          body: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is AuthLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return Center(
                child: ElevatedButton(
                  onPressed: () {
                    context.read<AuthCubit>().logout();
                  },
                  child: const Text('Logout'),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
