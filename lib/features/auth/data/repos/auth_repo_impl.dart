import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:grocery_app/core/errors/custom_exception.dart';
import 'package:grocery_app/core/errors/failure.dart';
import 'package:grocery_app/core/services/firebase_auth_service.dart';
import 'package:grocery_app/core/services/firebase_store_service.dart';
import 'package:grocery_app/core/services/shared_preferences_singleton.dart';
import 'package:grocery_app/features/auth/data/models/user_model.dart';
import 'package:grocery_app/features/auth/domain/entities/user_entity.dart';
import 'package:grocery_app/features/auth/domain/repos/auth_repo.dart';

import '../../../../core/constants/constants.dart';

class AuthRepoImpl extends AuthRepo{
  final FirebaseAuthService  firebaseAuthService = FirebaseAuthService();
  final FirebaseStoreService  firebaseStoreService = FirebaseStoreService();

  @override
  Future<Either<Failure, UserEntity>> createAccountWithEmailPassword({required String fName, required String lName, required String email, required String password}) async{
    try {
      final user = await firebaseAuthService.createAccountWithEmail(email: email, password: password);
      UserEntity userEntity = UserEntity(uId:user.uid, fName: fName, lName: lName, email: email);
      await firebaseStoreService.addUserData(data: UserModel.fromEntity(userEntity).toJson(), docId: userEntity.uId);
      return right(userEntity);
    } on CustomExceptions catch (e) {
      return left(ServerFailure(e.toString()));
    }catch (e){
      return left(ServerFailure('Something went wrong, please try again.'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailPassword({required String email, required String password}) async{
    try {
      final user = await firebaseAuthService.signInWithEmailPassword(email: email, password: password);
      UserModel userModel = await firebaseStoreService.getUserData(docId: user.uid);
      await saveUserData(user: userModel.toEntity());
      return right(userModel.toEntity());
    } on CustomExceptions catch (e) {
      return left(ServerFailure(e.toString()));
    }catch (e){
      return left(ServerFailure('Something went wrong, please try again.'));
    }
  }

  @override
  Future saveUserData({required UserEntity user}) async{
    var jsonData = jsonEncode(UserModel.fromEntity(user).toJson());
    await AppPrefs.setString(kUserData, jsonData);
  }

  @override
  Future deleteUserData() async{
    await AppPrefs.delete(kUserData);
  }
}