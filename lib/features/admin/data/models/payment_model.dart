import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentModel {
  final String id;
  final String patientName;
  final String patientPhone;
  final String doctorName;
  final String doctorSpeciality;
  final String time;
  final DateTime date;
  final int price;

  PaymentModel({
    required this.id,
    required this.patientName,
    required this.patientPhone,
    required this.doctorName,
    required this.time,
    required this.date,
    required this.doctorSpeciality,
    this.price = 150,
  });

  factory PaymentModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final date = data['date'] as Timestamp;
    return PaymentModel(
      id: doc.id,
      patientName: data['patientName'],
      patientPhone: data['patientPhone'],
      doctorName: data['doctorName'],
      time: data['time'],
      date: date.toDate(),
      price: data['price'],
      doctorSpeciality: data['doctorSpeciality'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'patientName': patientName,
      'patientPhone': patientPhone,
      'doctorName': doctorName,
      'time': time,
      'date': date,
      'price': price,
      'doctorSpeciality': doctorSpeciality
    };
  }
}
