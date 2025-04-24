import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:alharamin_app/core/helpers/chache_helper.dart';
import 'package:alharamin_app/core/helpers/service_loactor.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial(isCheckingAutoLogin: true)) {
    _checkAutoLogin();
  }

  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  final _prefs = getIt<CacheHelper>();

  // Auto login check
  Future<void> _checkAutoLogin() async {
    final token = _prefs.getData(key: 'user_token');
    if (token != null) {
      try {
        await _auth.currentUser?.getIdToken(true);
        final user = _auth.currentUser;
        if (user != null) {
          final doc = await _fireStore.collection('users').doc(user.uid).get();
          final name = doc.data()?['fullName'] ?? '';
          emit(AuthSuccess(userName: name));
          return;
        }
      } catch (_) {
        await _prefs.removeData(key: 'user_token');
      }
    }
    emit(AuthInitial(isCheckingAutoLogin: false));
  }

  // User login
  Future<void> login({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    try {
      emit(AuthLoading());
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user!;
      if (rememberMe) {
        final token = await user.getIdToken();
        await _prefs.saveData(key: 'user_token', value: token);
      } else {
        await _prefs.removeData(key: 'user_token');
      }

      final doc = await _fireStore.collection('users').doc(user.uid).get();
      final name = doc.data()?['fullName'] ?? '';

      emit(AuthSuccess(userName: name));
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(errMessage: e.message ?? 'An unknown error occurred'));
    } catch (e) {
      emit(AuthFailure(errMessage: e.toString()));
    }
  }

  // User registration
  Future<void> register({
    required String fullName,
    required String email,
    required String password,
    required String phone,
  }) async {
    try {
      emit(AuthLoading());

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

      emit(AuthSuccess(userName: fullName));
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(errMessage: e.message ?? 'An unknown error occurred'));
    } catch (e) {
      emit(AuthFailure(errMessage: e.toString()));
    }
  }

  // Logout
  Future<void> logout() async {
    await _auth.signOut();
    await _prefs.removeData(key: 'user_token');
    emit(AuthInitial(isCheckingAutoLogin: false));
  }
}
