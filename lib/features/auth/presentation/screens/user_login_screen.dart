import 'package:alharamin_app/features/auth/presentation/widgets/user_login_body.dart';
import 'package:flutter/material.dart';

class UserLoginScreen extends StatelessWidget {
  const UserLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UserLoginBody(),
    );
  }
}
