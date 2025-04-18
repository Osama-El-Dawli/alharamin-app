import 'package:alharamin_app/features/register/logic/cubits/register_cubit/register_cubit.dart';
import 'package:alharamin_app/features/register/presentation/widgets/register_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => RegisterCubit(),
        child: RegisterScreenBody(),
      ),
    );
  }
}
