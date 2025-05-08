import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorModel {
  final String id;
  final String nameEn;
  final String nameAr;
  final String speciality;
  final List<String> appointments;

  const DoctorModel({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.speciality,
    required this.appointments,
  });

  factory DoctorModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    final appointments = (data['appointments'] as List?)?.cast<String>() ?? [];

    return DoctorModel(
      id: doc.id,
      nameAr: data['nameAr'],
      nameEn: data['nameEn'],
      speciality: data['speciality'],
      appointments: appointments,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'nameEn': nameEn,
      'nameAr': nameAr,
      'speciality': speciality,
      'appointments': appointments,
    };
  }
}
