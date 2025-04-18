import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;

  Future<void> register({
    required String fullName,
    required String email,
    required String password,
    required String phone,
  }) async {
    try {
      emit(RegisterLoading());
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      final uid = userCredential.user!.uid;

      await _fireStore.collection('users').doc(uid).set({
        'uid': uid,
        'fullName': fullName,
        'email': email,
        'phone': phone,
        'role': 'patient',
      });

      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      emit(
        RegisterFailure(errMessage: e.message ?? 'An unknown error occurred'),
      );
    } on Exception catch (e) {
      emit(RegisterFailure(errMessage: e.toString()));
    }
  }
}
