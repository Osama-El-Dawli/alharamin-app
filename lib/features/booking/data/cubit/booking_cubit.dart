import 'package:alharamin_app/features/booking/data/models/appointment_model.dart';
import 'package:alharamin_app/features/doctor/data/model/doctor_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  final DoctorModel doctor;
  final String patientId;
  final FirebaseFirestore _firestore;

  DateTime? selectedDate;
  String? selectedTime;
  List<String> bookedTimes = [];

  BookingCubit({
    required this.doctor,
    required this.patientId,
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance,
       super(BookingInitial());

  Future<void> selectDate(DateTime date) async {
    emit(BookingLoading());
    selectedDate = date;
    selectedTime = null;

    try {
      bookedTimes = await _getBookedTimes(doctor.id, date);

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
      emit(
        BookingFailure(
          errMessage: 'Failed to load appointments: ${e.toString()}',
        ),
      );
    }
  }

  Future<void> selectTime(String time) async {
    if (selectedDate == null) {
      emit(BookingFailure(errMessage: 'Please select a date first'));
      return;
    }

    selectedTime = time;
    if (state is DateSelectedState) {
      final currentState = state as DateSelectedState;
      emit(
        DateSelectedState(
          date: currentState.date,
          availableAppointments: currentState.availableAppointments,
          selectedTime: time, // Pass the selected time here
        ),
      );
    }
  }

  Future<List<String>> _getBookedTimes(String doctorId, DateTime date) async {
    try {
      final startOfDay = DateTime(date.year, date.month, date.day);
      final endOfDay = DateTime(
        date.year,
        date.month,
        date.day,
        23,
        59,
        59,
        999,
      );

      final snapshot =
          await _firestore
              .collection('appointments')
              .where('doctorId', isEqualTo: doctorId)
              .where(
                'date',
                isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay),
              )
              .where('date', isLessThanOrEqualTo: Timestamp.fromDate(endOfDay))
              .get();

      return snapshot.docs.map((doc) => doc['time'] as String).toList();
    } catch (e) {
      throw Exception('Failed to fetch booked times: ${e.toString()}');
    }
  }

  Future<void> bookAppointment(String time) async {
    if (selectedDate == null) {
      emit(BookingFailure(errMessage: 'Please select a date first'));
      return;
    }

    emit(BookingLoading());

    try {
      final appointmentRef = _firestore.collection('appointments').doc();
      final dateOnly = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
      );

      await _firestore.runTransaction((transaction) async {
        final querySnapshot =
            await _firestore
                .collection('appointments')
                .where('doctorId', isEqualTo: doctor.id)
                .where('date', isEqualTo: Timestamp.fromDate(dateOnly))
                .where('time', isEqualTo: time)
                .get();

        if (querySnapshot.docs.isNotEmpty) {
          throw Exception('This time slot has already been booked.');
        }

        final appointment = AppointmentModel(
          id: appointmentRef.id,
          doctorId: doctor.id,
          patientId: patientId,
          date: selectedDate!,
          time: time,
        );

        transaction.set(appointmentRef, appointment.toFirestore());
      });

      await selectDate(selectedDate!);

      emit(BookingSuccess());

      if (state is DateSelectedState) {
        final currentState = state as DateSelectedState;
        emit(
          DateSelectedState(
            date: currentState.date,
            availableAppointments: currentState.availableAppointments,
            selectedTime: null,
          ),
        );
      }
    } catch (e) {
      emit(
        BookingFailure(
          errMessage: 'Failed to book appointment: ${e.toString()}',
        ),
      );
    }
  }
}
