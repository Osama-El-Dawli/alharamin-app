import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'admin_login_state.dart';

class AdminLoginCubit extends Cubit<AdminLoginState> {
  AdminLoginCubit() : super(const AdminLoginInitial());

  void submitPasscode(String passcode) {
    if (passcode == 'Admin') {
      emit(AdminLoginSuccess());
    } else {
      emit(const AdminLoginFailure("Incorrect passcode"));
    }
  }

  void clearError() {
    emit(const AdminLoginInitial(errMessage: null));
  }
}
