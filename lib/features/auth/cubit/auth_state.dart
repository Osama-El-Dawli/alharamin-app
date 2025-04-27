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
  final UserModel user;
  const AuthSuccess({required this.user});

  @override
  List<Object?> get props => [user];
}

class AuthFailure extends AuthState {
  final String errMessage;
  const AuthFailure({required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}
