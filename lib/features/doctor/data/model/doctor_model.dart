import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorModel {
  final String id;
  final String nameEn;
  final String nameAr;
  final String speciality;
  final List<String> appointments;
  final int price;

  const DoctorModel({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.speciality,
    required this.appointments,
    this.price = 150,
  });

  factory DoctorModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;
    final appointments = (data['appointments'] as List?)?.cast<String>() ?? [];

    return DoctorModel(
      id: doc.id,
      nameAr: data['nameAr'],
      nameEn: data['nameEn'],
      speciality: data['speciality'],
      appointments: appointments,
      price: data['price'] ?? 150,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'nameEn': nameEn,
      'nameAr': nameAr,
      'speciality': speciality,
      'appointments': appointments,
      'price': price,
    };
  }
}
