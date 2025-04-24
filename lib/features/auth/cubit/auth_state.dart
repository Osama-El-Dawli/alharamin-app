part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  final bool isCheckingAutoLogin;
  const AuthInitial({required this.isCheckingAutoLogin});

  @override
  List<Object?> get props => [isCheckingAutoLogin];
}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String userName;
  const AuthSuccess({required this.userName});

  @override
  List<Object?> get props => [userName];
}

class AuthFailure extends AuthState {
  final String errMessage;
  const AuthFailure({required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}
