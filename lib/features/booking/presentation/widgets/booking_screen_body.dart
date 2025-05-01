import 'package:alharamin_app/features/doctor/data/model/doctor_model.dart';
import 'package:flutter/material.dart';

class BookingScreenBody extends StatelessWidget {
  const BookingScreenBody({super.key, required this.doctorModel});
  final DoctorModel doctorModel;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Booking Screen')));
  }
}
