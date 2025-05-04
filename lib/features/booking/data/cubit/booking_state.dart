part of 'booking_cubit.dart';

abstract class BookingState extends Equatable {
  const BookingState();

  @override
  List<Object> get props => [];
}

class BookingInitial extends BookingState {}

class BookingLoading extends BookingState {}

class DateSelectedState extends BookingState {
  final DateTime date;
  final List<String> availableAppointments;
  final String? selectedTime; // Add this

  const DateSelectedState({
    required this.date,
    required this.availableAppointments,
    this.selectedTime,
  });

  @override
  List<Object> get props => [date, availableAppointments, selectedTime ?? ''];
}

class BookingSuccess extends BookingState {
  final AppointmentModel appointmentModel;

  const BookingSuccess({required this.appointmentModel});

  @override
  List<Object> get props => [appointmentModel];
}

class BookingFailure extends BookingState {
  final String errMessage;

  const BookingFailure({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}

class BookedTimeLoading extends BookingState{}

class BookedTimeFailure extends BookingState{
  final String errMessage;
  const BookedTimeFailure({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}
