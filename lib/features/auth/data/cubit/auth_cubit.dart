import 'package:alharamin_app/features/auth/data/repositories/auth_repository.dart';
import 'package:alharamin_app/features/auth/data/models/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final IAuthRepository _authRepository;

  // Constructor
  AuthCubit(this._authRepository)
    : super(AuthInitial(isCheckingAutoLogin: true)) {
    _checkAutoLogin();
  }

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

  String? fullName;
  String? email;
  String? password;
  String? phone;
  bool rememberMe = false;
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  Future<void> _checkAutoLogin() async {
    final result = await _authRepository.checkAutoLogin();
    result.fold(
      (failure) {
        emit(AuthInitial(isCheckingAutoLogin: false));
      },
      (userModel) {
        if (userModel != null) {
          emit(AuthSuccess(user: userModel));
        } else {
          emit(AuthInitial(isCheckingAutoLogin: false));
        }
      },
    );
  }

  bool get isLoggedIn => state is AuthSuccess;

  Future<void> login() async {
    if (isClosed) return;
    emit(AuthLoading());
    final result = await _authRepository.login(
      email: email!.trim(),
      password: password!,
      rememberMe: rememberMe,
    );

    if (isClosed) return;
    result.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (userModel) => emit(AuthSuccess(user: userModel)),
    );
  }

  Future<void> register() async {
    if (isClosed) return;
    emit(AuthLoading());
    final result = await _authRepository.register(
      email: email!,
      password: password!,
      fullName: fullName!,
      phone: phone!,
    );

    if (isClosed) return;
    result.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (userModel) => emit(AuthSuccess(user: userModel)),
    );
  }

  Future<void> logout() async {
    if (isClosed) return;
    emit(AuthLoading());
    final result = await _authRepository.logout();

    if (isClosed) return;
    result.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (_) => emit(AuthInitial(isCheckingAutoLogin: false)),
    );
  }
}
