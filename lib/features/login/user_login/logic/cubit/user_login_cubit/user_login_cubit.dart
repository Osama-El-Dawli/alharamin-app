import 'package:alharamin_app/core/helpers/chache_helper.dart';
import 'package:alharamin_app/core/helpers/service_loactor.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'user_login_state.dart';

class UserLoginCubit extends Cubit<UserLoginState> {
  UserLoginCubit() : super(UserLoginInitial(isCheckingAutoLogin: true)) {
    _checkAutoLogin();
  }

  final _auth = FirebaseAuth.instance;
  final _prefs = getIt<CacheHelper>();

  Future<void> _checkAutoLogin() async {
    final token = _prefs.getData(key: 'user_token');
    if (token != null) {
      try {
        // Verify the token is still valid
        await _auth.currentUser?.getIdToken(true);
        if (_auth.currentUser != null) {
          emit(UserLoginSuccess());
          return;
        }
      } catch (e) {
        await _prefs.removeData(key: 'user_token');
      }
    }
    emit(UserLoginInitial(isCheckingAutoLogin: false));
  }

  Future<void> userLogin({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    try {
      emit(UserLoginLoading());
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (rememberMe) {
        final token = await userCredential.user!.getIdToken();
        await _prefs.saveData(key: 'user_token', value: token);
      } else {
        await _prefs.removeData(key: 'user_token');
      }

      emit(UserLoginSuccess());
    } on FirebaseAuthException catch (e) {
      emit(
        UserLoginFailure(errMessage: e.message ?? 'An unknown error occurred'),
      );
    } on Exception catch (e) {
      emit(UserLoginFailure(errMessage: e.toString()));
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    await _prefs.removeData(key: 'user_token');
    emit(UserLoginInitial(isCheckingAutoLogin: false));
  }
}
