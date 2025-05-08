import 'package:alharamin_app/features/auth/data/models/user_model.dart';
import 'package:alharamin_app/features/booking/data/models/appointment_model.dart';
import 'package:alharamin_app/features/doctor/data/model/doctor_model.dart';

class BookingScreenParams {
  final DoctorModel doctorModel;
  final UserModel userModel;

  BookingScreenParams({required this.doctorModel, required this.userModel});
}

class DoctorScreeenParams {
  final String specialityName;
  final UserModel userModel;

  DoctorScreeenParams({
    required this.specialityName,
    required this.userModel,
  });
}

class BookingDetailsParams {
  final DoctorModel doctorModel;
  final AppointmentModel appointmentModel;
  final UserModel userModel;

  BookingDetailsParams({
    required this.doctorModel,
    required this.userModel,
    required this.appointmentModel,
  });
}
