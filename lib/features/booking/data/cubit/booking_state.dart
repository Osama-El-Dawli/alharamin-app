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
  final String? selectedTime;

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

class BookingOperationLoading extends BookingState {}

class BookingOperationFailure extends BookingState {
  final String errMessage;
  const BookingOperationFailure({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}

class AppointmentCanceledSuccess extends BookingState {}

class AppointmentCanceledLoading extends BookingState {}

class AppointmentCanceledFailure extends BookingState {
  final String errMessage;
  const AppointmentCanceledFailure({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}

class AlreadyBooked extends BookingState {
  final AppointmentModel appointmentModel;

  const AlreadyBooked({required this.appointmentModel});

  @override
  List<Object> get props => [appointmentModel];
}

class NotBooked extends BookingState {}
