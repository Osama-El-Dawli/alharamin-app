import 'package:alharamin_app/features/login/user_login/logic/cubit/user_login_cubit/user_login_cubit.dart';
import 'package:alharamin_app/features/login/user_login/presentation/widgets/user_login_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserLoginScreen extends StatelessWidget {
  const UserLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => UserLoginCubit(),
        child: UserLoginBody(),
      ),
    );
  }
}
