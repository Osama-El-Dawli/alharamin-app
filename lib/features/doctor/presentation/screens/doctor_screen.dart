import 'package:alharamin_app/features/doctor/presentation/widgets/doctor_screen_body.dart';
import 'package:flutter/material.dart';

class DoctorScreen extends StatelessWidget {
  const DoctorScreen({super.key, required this.specialityName});
  final String specialityName;

  @override
  Widget build(BuildContext context) {
    return DoctorScreenBody(specialityName: specialityName);
  }
}