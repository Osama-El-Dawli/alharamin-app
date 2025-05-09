import 'package:alharamin_app/features/doctor/data/model/doctor_model.dart';
import 'package:alharamin_app/features/doctor/data/repository/i_doctor_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDoctorRepository implements IDoctorRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<DoctorModel>> fetchDoctorsBySpeciality({
    required String speciality,
  }) async {
    final snapShot =
        await _firestore
            .collection('doctors')
            .where('speciality', isEqualTo: speciality)
            .get();
    return snapShot.docs.map((doc) => DoctorModel.fromFirestore(doc)).toList();
  }

  @override
  Future<List<DoctorModel>> fetchDoctorsByName({required String nameEn}) async {
    final snapShot =
        await _firestore
            .collection('doctors')
            .where(
              'nameEn',
              isEqualTo: nameEn,
            )
            .get();
    return snapShot.docs.map((doc) => DoctorModel.fromFirestore(doc)).toList();
  }
}
