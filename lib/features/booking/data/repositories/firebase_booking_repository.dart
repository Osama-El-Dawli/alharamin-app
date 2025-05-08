import 'package:alharamin_app/core/error/failure.dart'; // Import Failure
import 'package:alharamin_app/features/booking/data/models/appointment_model.dart';
import 'package:alharamin_app/features/booking/data/repositories/booking_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart'; // Import dartz

class FirebaseBookingRepository implements IBookingRepository {
  final FirebaseFirestore _firestore;

  FirebaseBookingRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<Either<Failure, AppointmentModel?>> checkExistingBooking({
    required String doctorId,
    required String patientId,
  }) async {
    try {
      final querySnapshot =
          await _firestore
              .collection('appointments')
              .where('doctorId', isEqualTo: doctorId)
              .where('patientId', isEqualTo: patientId)
              .limit(1)
              .get();

      if (querySnapshot.docs.isEmpty) {
        return const Right(null);
      }

      final appointment = AppointmentModel.fromFirestore(
        querySnapshot.docs.first,
      );
      return Right(appointment);
    } on FirebaseException catch (e) {
      return Left(
        ServerFailure(
          message: 'Firebase error checking booking: ${e.message ?? e.code}',
        ),
      );
    } catch (e) {
      return Left(
        ServerFailure(message: 'An unexpected error occurred: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, List<String>>> getBookedTimes({
    required String doctorId,
    required DateTime date,
  }) async {
    try {
      final dateOnly = DateTime(date.year, date.month, date.day);
      final querySnapshot =
          await _firestore
              .collection('appointments')
              .where('doctorId', isEqualTo: doctorId)
              .where('date', isEqualTo: Timestamp.fromDate(dateOnly))
              .get();

      final bookedTimes =
          querySnapshot.docs.map((doc) => doc['time'] as String).toList();

      return Right(bookedTimes);
    } on FirebaseException catch (e) {
      return Left(
        ServerFailure(
          message:
              'Firebase error fetching booked times: ${e.message ?? e.code}',
        ),
      );
    } catch (e) {
      return Left(
        ServerFailure(message: 'An unexpected error occurred: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, AppointmentModel>> bookAppointment({
    required String doctorId,
    required String patientId,
    required DateTime date,
    required String time,
  }) async {
    try {
      final appointmentsRef = _firestore.collection('appointments');

      final querySnapshot =
          await appointmentsRef
              .where('doctorId', isEqualTo: doctorId)
              .where('date', isEqualTo: Timestamp.fromDate(date))
              .where('time', isEqualTo: time)
              .limit(1)
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        return Left(
          BookingConflictFailure(
            message: 'This time slot is no longer available.',
          ),
        );
      }

      final docRef = await appointmentsRef.add({
        'doctorId': doctorId,
        'patientId': patientId,
        'date': Timestamp.fromDate(date),
        'time': time,
      });

      final newDocSnapshot = await docRef.get();
      final newAppointment = AppointmentModel.fromFirestore(newDocSnapshot);

      return Right(newAppointment);
    } on FirebaseException catch (e) {
      return Left(
        ServerFailure(
          message: 'Firebase error during booking: ${e.message ?? e.code}',
        ),
      );
    } catch (e) {
      return Left(
        ServerFailure(message: 'An unexpected error occurred: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> cancelAppointment({
    required String appointmentId,
  }) async {
    try {
      await _firestore.collection('appointments').doc(appointmentId).delete();
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(
        ServerFailure(
          message:
              'Firebase error cancelling appointment: ${e.message ?? e.code}',
        ),
      );
    } catch (e) {
      return Left(
        ServerFailure(message: 'An unexpected error occurred: ${e.toString()}'),
      );
    }
  }
}
