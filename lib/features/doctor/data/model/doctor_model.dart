import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorModel {
  final String id;
  final String name;
  final String image;
  final String speciality;

  const DoctorModel({
    required this.id,
    required this.name,
    required this.image,
    required this.speciality,
  });

  factory DoctorModel.fromFirestore(DocumentSnapshot doc, String id) {
    final data = doc.data() as Map<String, dynamic>;

    return DoctorModel(
      id: doc.id,
      name: data['name'],
      image: data['image'],
      speciality: data['speciality'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'speciality': speciality,
    };
  }
}
