part of 'doctor_cubit.dart';

sealed class DoctorState extends Equatable {
  const DoctorState();

  @override
  List<Object> get props => [];
}

final class DoctorInitial extends DoctorState {}

final class DoctorLoading extends DoctorState {}

final class DoctorLoaded extends DoctorState {
  final List<DoctorModel> doctors;

  const DoctorLoaded({required this.doctors});
}

final class DoctorEmpty extends DoctorState {
  final String errMessage;
  const DoctorEmpty({required this.errMessage});
}

final class DoctorFailure extends DoctorState {
  final String errMessage;
  const DoctorFailure({required this.errMessage});
}
