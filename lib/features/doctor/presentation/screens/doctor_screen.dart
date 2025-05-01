import 'package:alharamin_app/features/auth/models/user_model.dart';
import 'package:alharamin_app/features/doctor/presentation/widgets/doctor_screen_body.dart';
import 'package:flutter/material.dart';

class DoctorScreen extends StatelessWidget {
  const DoctorScreen({super.key, required this.specialityName, required this.userModel});
  final String specialityName;
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return DoctorScreenBody(
      specialityName: specialityName,
      userModel: userModel,
    );
  }
}
