import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentModel {
  final String id;
  final String doctorId;
  final String patientId;
  final DateTime date;
  final String time;
  final int price;

  const AppointmentModel({
    required this.id,
    required this.doctorId,
    required this.patientId,
    required this.date,
    required this.time,
    required this.price,
  });

  factory AppointmentModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final date = (data['date'] as Timestamp).toDate();

    return AppointmentModel(
      id: doc.id,
      doctorId: data['doctorId'],
      patientId: data['patientId'],
      date: date,
      time: data['time'],
      price: data['price'] ?? 150,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'doctorId': doctorId,
      'patientId': patientId,
      'date': Timestamp.fromDate(date),
      'time': time,
      'price': price,
    };
  }
}
