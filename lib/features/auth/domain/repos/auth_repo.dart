import 'package:dartz/dartz.dart';
import 'package:grocery_app/core/errors/failure.dart';
import 'package:grocery_app/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserEntity>> createAccountWithEmailPassword(
      {required String fName, required String lName, required String email, required String password}
  );

  Future<Either<Failure, UserEntity>> signInWithEmailPassword({required String email, required String password});

  Future saveUserData({required UserEntity user});
  Future deleteUserData();
}
