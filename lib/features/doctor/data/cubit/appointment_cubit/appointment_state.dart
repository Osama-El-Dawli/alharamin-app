part of 'appointment_cubit.dart';

sealed class AppointmentState extends Equatable {
  const AppointmentState();

  @override
  List<Object> get props => [];
}

final class AppointmentInitial extends AppointmentState {}

final class AppointmentLoading extends AppointmentState {}

final class AppointmentLoaded extends AppointmentState {
  final List<AppointmentModel> appointments;

  const AppointmentLoaded({required this.appointments});
}

final class AppointmentEmpty extends AppointmentState {
  final String errMessage;
  const AppointmentEmpty({required this.errMessage});
}

final class AppointmentFailure extends AppointmentState {
  final String errMessage;
  const AppointmentFailure({required this.errMessage});
}

final class AppointmentBookedSuccess extends AppointmentState {}

final class AppointmentBookedCancelled extends AppointmentState {}
