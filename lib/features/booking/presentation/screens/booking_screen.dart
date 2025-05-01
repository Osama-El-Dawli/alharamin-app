import 'package:alharamin_app/features/auth/models/user_model.dart';
import 'package:alharamin_app/features/booking/presentation/widgets/booking_screen_body.dart';
import 'package:alharamin_app/features/doctor/data/model/doctor_model.dart';
import 'package:flutter/material.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({
    super.key,
    required this.doctorModel,
    required this.userModel,
  });
  final DoctorModel doctorModel;
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return BookingScreenBody(doctorModel: doctorModel, userModel: userModel);
  }
}
