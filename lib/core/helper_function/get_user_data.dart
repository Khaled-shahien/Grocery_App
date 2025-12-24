import 'dart:convert';
import 'package:grocery_app/features/auth/data/models/user_model.dart';
import 'package:grocery_app/features/auth/domain/entities/user_entity.dart';

import '../constants/constants.dart';
import '../services/shared_preferences_singleton.dart';

UserEntity getUser(){
  var jsonString = AppPrefs.getString(kUserData);
  var userEntity =  UserModel.fromJson(jsonDecode(jsonString)).toEntity();
  return userEntity;
}