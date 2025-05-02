import 'package:alharamin_app/features/booking/data/models/appointment_model.dart';
import 'package:alharamin_app/features/booking/presentation/widgets/booking_details_body.dart';
import 'package:alharamin_app/features/doctor/data/model/doctor_model.dart';
import 'package:flutter/material.dart';

class BookingDetailsScreen extends StatelessWidget {
  const BookingDetailsScreen({
    super.key,
    required this.doctorModel,
    required this.appointmentModel,
  });
  final DoctorModel doctorModel;
  final AppointmentModel appointmentModel;

  @override
  Widget build(BuildContext context) {
    return BookingDetailsBody(
      doctorModel: doctorModel,
      appointmentModel: appointmentModel,
    );
  }
}
