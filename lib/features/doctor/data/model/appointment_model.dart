import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentModel {
  final String id;
  final bool available;
  final DateTime date;
  final String patientId;

  const AppointmentModel({
    required this.id,
    required this.available,
    required this.date,
    required this.patientId,
  });

  factory AppointmentModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return AppointmentModel(
      id: doc.id,
      available: data['available'],
      date: (data['date'] as Timestamp).toDate(),
      patientId: data['patientId'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'available': available,
      'date': Timestamp.fromDate(date),
      'patientId': patientId,
    };
  }
}
