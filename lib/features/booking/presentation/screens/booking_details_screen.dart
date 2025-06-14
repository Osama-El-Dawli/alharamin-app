import 'package:alharamin_app/core/widgets/custom_app_bar.dart';
import 'package:alharamin_app/features/auth/data/models/user_model.dart';
import 'package:alharamin_app/features/booking/data/models/appointment_model.dart';
import 'package:alharamin_app/features/booking/presentation/widgets/booking_details_body.dart';
import 'package:alharamin_app/features/doctor/data/model/doctor_model.dart';
import 'package:flutter/material.dart';

class BookingDetailsScreen extends StatelessWidget {
  const BookingDetailsScreen({
    super.key,
    required this.doctorModel,
    required this.appointmentModel,
    required this.userModel,
  });
  final DoctorModel doctorModel;
  final AppointmentModel appointmentModel;
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Details', leading: SizedBox.shrink()),
      body: BookingDetailsBody(
        userModel: userModel,
        doctorModel: doctorModel,
        appointmentModel: appointmentModel,
      ),
    );
  }
}
