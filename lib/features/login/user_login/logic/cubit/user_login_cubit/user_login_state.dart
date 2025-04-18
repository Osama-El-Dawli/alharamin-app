part of 'user_login_cubit.dart';

abstract class UserLoginState extends Equatable {
  const UserLoginState();

  @override
  List<Object> get props => [];
}

class UserLoginInitial extends UserLoginState {
  final bool isCheckingAutoLogin;

  const UserLoginInitial({required this.isCheckingAutoLogin});

  @override
  List<Object> get props => [isCheckingAutoLogin];
}

class UserLoginLoading extends UserLoginState {}

class UserLoginSuccess extends UserLoginState {}

class UserLoginFailure extends UserLoginState {
  final String errMessage;

  const UserLoginFailure({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}
