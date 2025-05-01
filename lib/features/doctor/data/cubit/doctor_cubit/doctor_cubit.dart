import 'package:alharamin_app/features/doctor/data/model/doctor_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'doctor_state.dart';

class DoctorCubit extends Cubit<DoctorState> {
  DoctorCubit() : super(DoctorInitial());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> fetchDoctorsBySpeciality({required String speciality}) async {
    emit(DoctorLoading());
    try {
      final snapShot =
          await _firestore
              .collection('doctors')
              .where('speciality', isEqualTo: speciality)
              .get();
      final doctors =
          snapShot.docs
              .map((doc) => DoctorModel.fromFirestore(doc, doc.id))
              .toList();

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
      final snapShot =
          await _firestore
              .collection('doctors')
              .where('nameEn', isGreaterThanOrEqualTo: nameEn)
              .where('nameEn', isLessThanOrEqualTo: '$nameEn\uf8ff')
              .get();

      final doctors =
          snapShot.docs
              .map((doc) => DoctorModel.fromFirestore(doc, doc.id))
              .toList();

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
