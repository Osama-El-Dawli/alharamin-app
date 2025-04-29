import 'package:alharamin_app/features/doctor/data/model/appointment_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  AppointmentCubit() : super(AppointmentInitial());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> fetchAvailableAppointment(String doctorId) async {
    emit(AppointmentLoading());
    try {
      final snapShot =
          await _firestore
              .collection('doctors')
              .doc(doctorId)
              .collection('appointments')
              .where('available', isEqualTo: true)
              .get();

      final appointments =
          snapShot.docs
              .map((doc) => AppointmentModel.fromFirestore(doc))
              .toList();

      if (appointments.isEmpty) {
        emit(AppointmentEmpty(errMessage: 'No Available Appointments'));
      } else {
        emit(AppointmentLoaded(appointments: appointments));
      }
    } catch (e) {
      emit(AppointmentFailure(errMessage: e.toString()));
    }
  }
}
