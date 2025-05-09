import 'package:alharamin_app/features/doctor/data/model/doctor_model.dart';
import 'package:alharamin_app/features/doctor/data/repository/i_doctor_repository.dart'; // Added import
import 'package:bloc/bloc.dart';
// import 'package:cloud_firestore/cloud_firestore.dart'; // Removed import
import 'package:equatable/equatable.dart';

part 'doctor_state.dart';

class DoctorCubit extends Cubit<DoctorState> {
  final IDoctorRepository _doctorRepository;

  DoctorCubit(this._doctorRepository) : super(DoctorInitial());

  Future<void> fetchDoctorsBySpeciality({required String speciality}) async {
    emit(DoctorLoading());
    try {
      final doctors = await _doctorRepository.fetchDoctorsBySpeciality(speciality: speciality);

      if (doctors.isEmpty) {
        emit(DoctorEmpty(errMessage: 'No Doctors Found'));
      } else {
        emit(DoctorLoaded(doctors: doctors));
      }
    } catch (e) {
      emit(DoctorFailure(errMessage: e.toString()));
    }
  }

  Future<void> fetchDoctorsByName({required String nameEn}) async {
    emit(DoctorLoading());
    try {
      final doctors = await _doctorRepository.fetchDoctorsByName(nameEn: nameEn);

      if (doctors.isEmpty) {
        emit(DoctorEmpty(errMessage: 'No Doctors Found'));
      } else {
        emit(DoctorLoaded(doctors: doctors));
      }
    } catch (e) {
      emit(DoctorFailure(errMessage: e.toString()));
    }
  }
}
