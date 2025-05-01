part of 'booking_cubit.dart';

sealed class BookingState extends Equatable {
  const BookingState();

  @override
  List<Object> get props => [];
}

final class BookingInitial extends BookingState {}

final class BookingLoading extends BookingState {}

final class DateSelectedState extends BookingState {
  final DateTime date;
  final List<String> availableAppointments;

  const DateSelectedState({
    required this.date,
    required this.availableAppointments,
  });

  @override
  List<Object> get props => [date, availableAppointments];
}

final class BookingSuccess extends BookingState {}

final class BookingError extends BookingState {
  final String message;

  const BookingError({required this.message});

  @override
  List<Object> get props => [message];
}
