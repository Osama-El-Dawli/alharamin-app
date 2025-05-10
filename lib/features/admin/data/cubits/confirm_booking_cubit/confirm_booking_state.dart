part of 'confirm_booking_cubit.dart';

sealed class ConfirmBookingState extends Equatable {
  const ConfirmBookingState();

  @override
  List<Object> get props => [];
}

final class ConfirmBookingInitial extends ConfirmBookingState {}

final class ConfirmBookingLoading extends ConfirmBookingState {}

final class ConfirmBookingFailure extends ConfirmBookingState {
  final String message;
  const ConfirmBookingFailure({required this.message});
}

final class ConfirmBookingSuccess extends ConfirmBookingState {
  final List<PaymentModel> bookings;
  const ConfirmBookingSuccess({required this.bookings});
}

final class ConfirmBookingEmpty extends ConfirmBookingState {
  final String message;
  const ConfirmBookingEmpty({required this.message});
}

final class ConfirmBookingConfirmed extends ConfirmBookingState {}

final class ConfirmBookingDeleted extends ConfirmBookingState {}
