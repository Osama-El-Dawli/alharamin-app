part of 'admin_login_cubit.dart';

@immutable
abstract class AdminLoginState extends Equatable {
  final String? errMessage;

  const AdminLoginState({this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}

class AdminLoginInitial extends AdminLoginState {
  const AdminLoginInitial({super.errMessage});
}

class AdminLoginSuccess extends AdminLoginState {}

class AdminLoginFailure extends AdminLoginState {
  const AdminLoginFailure(String errorMessage)
    : super(errMessage: errorMessage);
}
