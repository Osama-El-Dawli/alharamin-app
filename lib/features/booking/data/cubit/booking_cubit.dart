import 'package:alharamin_app/features/booking/data/models/appointment_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:alharamin_app/features/doctor/data/model/doctor_model.dart';

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  final DoctorModel doctor;
  final String patientId;
  final FirebaseFirestore _firestore;

  DateTime? selectedDate;
  String? selectedTime;

  BookingCubit({
    required this.doctor,
    required this.patientId,
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance,
       super(BookingInitial());

  Future<List<String>> _getBookedTimes(String doctorId, DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    try {
      final snapshot =
          await _firestore
              .collection('appointments')
              .where('doctorId', isEqualTo: doctorId)
              .where(
                'date',
                isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay),
              )
              .where('date', isLessThan: Timestamp.fromDate(endOfDay))
              .where('status', whereIn: ['pending', 'confirmed'])
              .get();

      return snapshot.docs.map((doc) => doc['time'] as String).toList();
    } catch (e) {
      emit(BookingError(message: 'Failed to load booked appointments'));
      return [];
    }
  }

  Future<void> selectDate(DateTime date) async {
    emit(BookingLoading());
    selectedDate = date;
    selectedTime = null;

    try {
      final bookedTimes = await _getBookedTimes(doctor.id, date);
      final availableAppointments =
          doctor.appointments
              .where((time) => !bookedTimes.contains(time))
              .toList();

      emit(
        DateSelectedState(
          date: date,
          availableAppointments: availableAppointments,
        ),
      );
    } catch (e) {
      emit(BookingError(message: 'Failed to load available appointments'));
    }
  }

  Future<void> bookAppointment(String time) async {
    if (selectedDate == null) return;
    emit(BookingLoading());

    try {
      final appointment = AppointmentModel(
        id: '',
        doctorId: doctor.id,
        patientId: patientId,
        date: selectedDate!,
        time: time,
      );

      await _firestore
          .collection('appointments')
          .add(appointment.toFirestore());
      emit(BookingSuccess());
    } catch (e) {
      emit(BookingError(message: 'Failed to book appointment'));
    }
  }
}
