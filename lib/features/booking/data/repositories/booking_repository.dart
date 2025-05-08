import 'package:alharamin_app/features/booking/data/models/appointment_model.dart';
import 'package:dartz/dartz.dart';
import 'package:alharamin_app/core/error/failure.dart';

abstract class IBookingRepository {
  Future<Either<Failure, AppointmentModel?>> checkExistingBooking({
    required String doctorId,
    required String patientId,
  });

  Future<Either<Failure, List<String>>> getBookedTimes({
    required String doctorId,
    required DateTime date,
  });

  Future<Either<Failure, AppointmentModel>> bookAppointment({
    required String doctorId,
    required String patientId,
    required DateTime date,
    required String time,
  });

  Future<Either<Failure, void>> cancelAppointment({
    required String appointmentId,
  });
}
