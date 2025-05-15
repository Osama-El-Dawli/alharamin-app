import 'package:alharamin_app/core/error/failure.dart';
import 'package:alharamin_app/features/booking/data/models/appointment_model.dart';
import 'package:alharamin_app/features/booking/data/repositories/booking_repository.dart'; // Import repository
import 'package:alharamin_app/features/doctor/data/model/doctor_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  final DoctorModel doctor;
  final String patientId;
  final IBookingRepository _bookingRepository;

  DateTime? selectedDate;
  String? selectedTime;
  List<String> bookedTimes = [];

  BookingCubit({
    required this.doctor,
    required this.patientId,
    required IBookingRepository bookingRepository,
  }) : _bookingRepository = bookingRepository,
       super(BookingInitial()) {
    // Automatically select tomorrow as the first day
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day).add(const Duration(days: 1));
    selectDate(tomorrow);
  }

  Future<Either<Failure, AppointmentModel?>> checkIsAlreadyBooked() async {
    if (isClosed) {
      return Left(AuthFailure(message: 'Cubit closed before check completed'));
    }
    emit(BookingLoading());
    final result = await _bookingRepository.checkExistingBooking(
      doctorId: doctor.id,
      patientId: patientId,
    );

    result.fold(
      (failure) {
        emit(BookingOperationFailure(errMessage: failure.message));
      },
      (existingAppointment) {
        if (isClosed) return;
        if (existingAppointment != null) {
          emit(BookingSuccess(appointmentModel: existingAppointment));
        } else {
          emit(BookingInitial());
        }
      },
    );
    return result;
  }

  Future<void> selectDate(DateTime date) async {
    if (isClosed) return;
    emit(BookingLoading());
    selectedDate = date;
    selectedTime = null;

    final result = await _bookingRepository.getBookedTimes(
      doctorId: doctor.id,
      date: date,
    );

    result.fold(
      (failure) {
        if (isClosed) return;
        emit(BookingOperationFailure(errMessage: failure.message));
      },
      (bookedTimesList) {
        if (isClosed) return;
        bookedTimes = bookedTimesList;
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
      },
    );
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
          selectedTime: time,
        ),
      );
    } else {
      emit(
        BookingFailure(
          errMessage:
              'Cannot select time: Date not properly selected or loaded.',
        ),
      );
    }
  }

  Future<void> bookAppointment() async {
    if (isClosed) return;
    if (selectedDate == null || selectedTime == null) {
      emit(
        const BookingOperationFailure(
          errMessage: 'Please select a date and time first',
        ),
      );
      return;
    }

    emit(BookingOperationLoading());

    final result = await _bookingRepository.bookAppointment(
      doctorId: doctor.id,
      patientId: patientId,
      date: selectedDate!,
      time: selectedTime!,
      price: doctor.price,
    );

    result.fold(
      (failure) {
        if (isClosed) return;
        emit(BookingOperationFailure(errMessage: failure.message));
        selectDate(selectedDate!);
      },
      (appointment) {
        if (isClosed) return;
        emit(BookingSuccess(appointmentModel: appointment));
      },
    );
  }

  Future<void> cancelAppointment({required String appointmentId}) async {
    if (isClosed) return;
    emit(AppointmentCanceledLoading());
    final result = await _bookingRepository.cancelAppointment(
      appointmentId: appointmentId,
    );

    result.fold(
      (failure) {
        if (isClosed) return;
        emit(BookingOperationFailure(errMessage: failure.message));
        if (selectedDate != null) {
          if (isClosed) return;
          selectDate(selectedDate!);
        }
      },
      (_) {
        if (isClosed) return;
        emit(AppointmentCanceledSuccess());
        if (selectedDate != null) {
          if (isClosed) return;
          selectDate(selectedDate!);
        }
      },
    );
  }
}
