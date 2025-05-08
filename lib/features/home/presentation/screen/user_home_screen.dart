import 'package:alharamin_app/features/auth/data/models/user_model.dart';
import 'package:alharamin_app/features/home/presentation/widgets/user_home_screen_body.dart';
import 'package:flutter/material.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: UserHomeScreenBody(user: user)));
  }
}
