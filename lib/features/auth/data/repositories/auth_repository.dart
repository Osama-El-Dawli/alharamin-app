import 'package:alharamin_app/core/error/failure.dart';
import 'package:alharamin_app/features/auth/data/models/user_model.dart';
import 'package:dartz/dartz.dart';

abstract class IAuthRepository {
  Future<Either<Failure, UserModel?>> checkAutoLogin();

  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
    required bool rememberMe,
  });

  Future<Either<Failure, UserModel>> register({
    required String email,
    required String password,
    required String fullName,
    required String phone,
  });

  Future<Either<Failure, void>> logout();
}
