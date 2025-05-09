import 'package:alharamin_app/features/doctor/data/model/doctor_model.dart';

abstract class IDoctorRepository {
  Future<List<DoctorModel>> fetchDoctorsBySpeciality({
    required String speciality,
  });
  Future<List<DoctorModel>> fetchDoctorsByName({required String nameEn});
}
