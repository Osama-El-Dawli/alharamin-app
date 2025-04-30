import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorModel {
  final String id;
  final String nameEn;
  final String nameAr;
  final String image;
  final String speciality;
  final List<dynamic> appointments;

  const DoctorModel({
    required this.id,
    required this.nameEn,
    required this.image,
    required this.speciality,
    required this.nameAr,
    required this.appointments,
  });

  factory DoctorModel.fromFirestore(DocumentSnapshot doc, String id) {
    final data = doc.data() as Map<String, dynamic>;

    return DoctorModel(
      id: doc.id,
      nameAr: data['nameAr'],
      nameEn: data['nameEn'],
      image: data['image'],
      speciality: data['speciality'],
      appointments: data['appointments'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'nameEn': nameEn,
      'nameAr': nameAr,
      'image': image,
      'speciality': speciality,
      'appointments': appointments,
    };
  }
}
