import 'package:alharamin_app/core/error/failure.dart';
import 'package:alharamin_app/core/helpers/chache_helper.dart';
import 'package:alharamin_app/core/helpers/service_locator.dart';
import 'package:alharamin_app/features/auth/data/repositories/auth_repository.dart'; // Interface from the same dir
import 'package:alharamin_app/features/auth/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart'; // For kDebugMode

class FirebaseAuthRepository implements IAuthRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final CacheHelper _prefs;

  FirebaseAuthRepository({
    FirebaseAuth? auth,
    FirebaseFirestore? firestore,
    CacheHelper? prefs,
  }) : _auth = auth ?? FirebaseAuth.instance,
       _firestore = firestore ?? FirebaseFirestore.instance,
       _prefs = prefs ?? getIt<CacheHelper>();

  @override
  Future<Either<AuthFailure, UserModel?>> checkAutoLogin() async {
    final token = _prefs.getData(key: 'user_token');
    if (token == null || token is! String || token.isEmpty) {
      return const Right(null);
    }

    try {
      final user = _auth.currentUser;
      if (user != null) {
        await user.getIdToken(true);

        if (_auth.currentUser != null) {
          final userModel = await _getUserData(user.uid);
          return Right(userModel);
        } else {
          await _prefs.removeData(key: 'user_token');
          return const Right(null);
        }
      } else {
        await _prefs.removeData(key: 'user_token');
        return const Right(null);
      }
    } on FirebaseAuthException catch (e) {
      await _prefs.removeData(key: 'user_token');
      if (kDebugMode) {
        print('Error during auto-login: ${e.toString()}');
      }
      return const Right(null);
    } catch (e) {
      await _prefs.removeData(key: 'user_token');
      return Left(AuthFailure(message: 'Auto-login failed: ${e.toString()}'));
    }
  }

  @override
  Future<Either<AuthFailure, UserModel>> login({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      final user = userCredential.user!;

      if (rememberMe) {
        final token = await user.getIdToken();
        await _prefs.saveData(key: 'user_token', value: token);
      } else {
        await _prefs.removeData(key: 'user_token');
      }

      final userModel = await _getUserData(user.uid);
      return Right(userModel);
    } on FirebaseAuthException catch (e) {
      String message = 'Login failed. Please try again.';
      if (e.code == 'invalid-credential' ||
          e.code == 'wrong-password' ||
          e.code == 'user-not-found') {
        message = 'Invalid email or password.';
      } else if (e.code == 'invalid-email') {
        message = 'Invalid email format.';
      } else if (e.code == 'user-disabled') {
        message = 'This user account has been disabled.';
      }
      if (kDebugMode) {
        print('FirebaseAuthException during login: ${e.code}');
      }
      return Left(AuthFailure(message: message));
    } catch (e) {
      if (kDebugMode) {
        print('Error during login: $e');
      }
      return Left(
        AuthFailure(
          message: 'An unexpected error occurred during login: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<AuthFailure, UserModel>> register({
    required String email,
    required String password,
    required String fullName,
    required String phone,
  }) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
            email: email.trim(),
            password: password,
          );
      final uid = userCredential.user!.uid;

      final userModel = UserModel(
        uid: uid,
        fullName: fullName,
        email: email.trim(),
        phone: phone,
        role: 'patient',
      );

      await _firestore.collection('users').doc(uid).set(userModel.toJson());

      await _prefs.removeData(key: 'user_token');

      return Right(userModel);
    } on FirebaseAuthException catch (e) {
      String message = 'Registration failed. Please try again.';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        message = 'Please enter a valid email address.';
      }
      if (kDebugMode) {
        print('FirebaseAuthException during registration: ${e.code}');
      }
      return Left(AuthFailure(message: message));
    } catch (e) {
      if (kDebugMode) {
        print('Error during registration: $e');
      }
      return Left(
        AuthFailure(
          message:
              'An unexpected error occurred during registration: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<AuthFailure, void>> logout() async {
    try {
      await _auth.signOut();
      await _prefs.removeData(key: 'user_token');
      return const Right(
        null,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error during logout: $e');
      }
      await _prefs.removeData(key: 'user_token');
      return Left(AuthFailure(message: 'Logout failed: ${e.toString()}'));
    }
  }

  Future<UserModel> _getUserData(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    if (!doc.exists || doc.data() == null) {
      throw Exception('User data not found in Firestore (uid: $uid).');
    }
    try {
      final data = doc.data()!;
      return UserModel.fromJson(data);
    } catch (e) {
      throw Exception(
        'Failed to parse user data from Firestore (uid: $uid): $e',
      );
    }
  }
}
