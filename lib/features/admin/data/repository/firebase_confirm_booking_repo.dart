import 'package:alharamin_app/core/error/failure.dart';
import 'package:alharamin_app/features/admin/data/models/payment_model.dart';
import 'package:alharamin_app/features/admin/data/repository/confrim_booking_repo.dart';
import 'package:alharamin_app/features/booking/data/models/appointment_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class FirebaseConfirmBookingRepo implements IConfirmBookingRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Future<Either<Failure, void>> confirmBooking({required String id}) async {
    try {
      final docRef = _firestore.collection('appointments').doc(id);
      final docSnapshot = await docRef.get();

      if (!docSnapshot.exists) {
        return Left(ServerFailure(message: 'Appointment not found.'));
      }

      final appointment = AppointmentModel.fromFirestore(docSnapshot);

      final patientSnapshot =
          await _firestore.collection('users').doc(appointment.patientId).get();
      if (!patientSnapshot.exists) {
        return Left(ServerFailure(message: 'Patient not found.'));
      }
      final patientData = patientSnapshot.data() as Map<String, dynamic>;
      final patientName = patientData['name'];
      final patientPhone = patientData['phone'];

      final doctorSnapshot =
          await _firestore
              .collection('doctors')
              .doc(appointment.doctorId)
              .get();
      if (!doctorSnapshot.exists) {
        return Left(ServerFailure(message: 'Doctor not found.'));
      }
      final doctorData = doctorSnapshot.data() as Map<String, dynamic>;
      final doctorName = doctorData['name'];
      final doctorSpeciality = doctorData['speciality'];

      final payment = PaymentModel(
        id: appointment.id,
        patientName: patientName,
        patientPhone: patientPhone,
        doctorName: doctorName,
        time: appointment.time,
        date: appointment.date,
        price: appointment.price,
        doctorSpeciality: doctorSpeciality,
      );

      await _firestore
          .collection('payments')
          .doc(id)
          .set(payment.toFirestore());

      await docRef.delete();

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteBooking({required String id}) async {
    try {
      final docRef = _firestore.collection('appointments').doc(id);
      await docRef.delete();

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PaymentModel>>> fetchBooking() async {
    try {
      final appointmentsSnapshot =
          await _firestore.collection('appointments').get();

      List<PaymentModel> bookings = [];

      for (var doc in appointmentsSnapshot.docs) {
        final appointment = AppointmentModel.fromFirestore(doc);

        final patientSnapshot =
            await _firestore
                .collection('users')
                .doc(appointment.patientId)
                .get();
        if (!patientSnapshot.exists) {
          print('Missing patient ${appointment.patientId}');
          continue;
        }
        final patientData = patientSnapshot.data() as Map<String, dynamic>;
        final patientName = patientData['name'];
        final patientPhone = patientData['phone'];

        final doctorSnapshot =
            await _firestore
                .collection('doctors')
                .doc(appointment.doctorId)
                .get();
        if (!doctorSnapshot.exists) {
          print('Missing doctor ${appointment.doctorId}');
          continue;
        }
        final doctorData = doctorSnapshot.data() as Map<String, dynamic>;
        final doctorName = doctorData['name'];
        final doctorSpeciality = doctorData['speciality'];

        final payment = PaymentModel(
          id: appointment.id,
          patientName: patientName,
          patientPhone: patientPhone,
          doctorName: doctorName,
          time: appointment.time,
          date: appointment.date,
          price: appointment.price,
          doctorSpeciality: doctorSpeciality,
        );

        bookings.add(payment);
      }

      bookings.sort((a, b) {
        final dateTimeA = DateTime(
          a.date.year,
          a.date.month,
          a.date.day,
          _parseHour(a.time),
          _parseMinute(a.time),
        );
        final dateTimeB = DateTime(
          b.date.year,
          b.date.month,
          b.date.day,
          _parseHour(b.time),
          _parseMinute(b.time),
        );
        return dateTimeA.compareTo(dateTimeB);
      });

      return Right(bookings);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  int _parseHour(String time) {
    final match = RegExp(r'(\d+):(\d+)\s*(AM|PM)').firstMatch(time);
    if (match == null) return 0;

    int hour = int.parse(match.group(1)!);
    String period = match.group(3)!.toUpperCase();

    if (period == 'PM' && hour != 12) hour += 12;
    if (period == 'AM' && hour == 12) hour = 0;

    return hour;
  }

  int _parseMinute(String time) {
    final match = RegExp(r'(\d+):(\d+)\s*(AM|PM)').firstMatch(time);
    if (match == null) return 0;

    return int.parse(match.group(2)!);
  }
}
