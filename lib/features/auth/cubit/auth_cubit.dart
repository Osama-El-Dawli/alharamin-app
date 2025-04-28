import 'package:alharamin_app/features/auth/models/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:alharamin_app/core/helpers/chache_helper.dart';
import 'package:alharamin_app/core/helpers/service_loactor.dart';
import 'package:flutter/material.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    fullNameController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }

  AuthCubit() : super(AuthInitial(isCheckingAutoLogin: true)) {
    _checkAutoLogin();
  }

  String? fullName;
  String? email;
  String? password;
  String? phone;
  bool rememberMe = false;
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  final _prefs = getIt<CacheHelper>();

  toggleRememberMe() {
    rememberMe = !rememberMe;
    emit(RememberMeState(rememberMe: rememberMe));
  }

  // Auto login check
  Future<void> _checkAutoLogin() async {
    final token = _prefs.getData(key: 'user_token');
    if (token != null) {
      try {
        await _auth.currentUser?.getIdToken(true);
        final user = _auth.currentUser;

        if (user != null) {
          final doc = await _fireStore.collection('users').doc(user.uid).get();

          if (doc.exists) {
            final data = doc.data()!;
            final userModel = UserModel.fromJson(data);

            emit(AuthSuccess(user: userModel));
            return;
          }
        }
      } catch (_) {
        await _prefs.removeData(key: 'user_token');
      }
    }
    emit(AuthInitial(isCheckingAutoLogin: false));
  }

  bool get isLoggedIn => state is AuthSuccess;

  // User login
  Future<void> login() async {
    try {
      emit(AuthLoading());
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email!,
        password: password!,
      );

      final user = userCredential.user!;

      if (rememberMe) {
        final token = await user.getIdToken();
        await _prefs.saveData(key: 'user_token', value: token);
      } else {
        await _prefs.removeData(key: 'user_token');
      }

      final doc = await _fireStore.collection('users').doc(user.uid).get();
      final data = doc.data()!;
      final userModel = UserModel.fromJson(data);

      emit(AuthSuccess(user: userModel));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        emit(AuthFailure(errMessage: 'Invalid email or password.'));
      } else if (e.code == 'wrong-password') {
        emit(AuthFailure(errMessage: 'Wrong password provided for that user.'));
      } else {
        emit(AuthFailure(errMessage: e.toString()));
      }
    } catch (e) {
      emit(AuthFailure(errMessage: e.toString()));
    }
  }

  // User registration
  Future<void> register() async {
    try {
      emit(AuthLoading());

      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email!, password: password!);

      final uid = userCredential.user!.uid;

      final userModel = UserModel(
        uid: uid,
        fullName: fullName!,
        email: email!,
        phone: phone!,
        role: 'patient',
      );

      await _fireStore.collection('users').doc(uid).set(userModel.toJson());

      emit(AuthSuccess(user: userModel));
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Registration failed, please try again.';

      if (e.code == 'weak-password') {
        emit(AuthFailure(errMessage: 'The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(
          AuthFailure(errMessage: 'The account already exists for that email.'),
        );
      } else if (e.code == 'invalid-email') {
        emit(AuthFailure(errMessage: 'Please enter a valid email'));
      }

      emit(AuthFailure(errMessage: errorMessage));
    } on FirebaseException catch (e) {
      emit(AuthFailure(errMessage: e.toString()));
    } catch (e) {
      emit(AuthFailure(errMessage: e.toString()));
    }
  }

  // Logout
  Future<void> logout() async {
    emit(AuthLoading());
    await _auth.signOut();
    await _prefs.removeData(key: 'user_token');
    emit(AuthInitial(isCheckingAutoLogin: false));
  }
}
