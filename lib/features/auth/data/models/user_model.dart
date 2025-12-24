import 'package:grocery_app/features/auth/domain/entities/user_entity.dart';

class UserModel {
  final String uId;
  final String fName;
  final String lName;
  final String email;

  UserModel({
    required this.uId,
    required this.fName,
    required this.lName,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uId: json['uId'],
      fName: json['fName'],
      lName: json['lName'],
      email: json['email'],
    );
  }

  factory UserModel.fromEntity(UserEntity userEntity) {
    return UserModel(
      uId: userEntity.uId,
      fName: userEntity.fName,
      lName: userEntity.lName,
      email: userEntity.email,
    );
  }

  UserEntity toEntity() {
    return UserEntity(uId: uId, fName: fName, lName: lName, email: email);
  }

  Map<String, dynamic> toJson() {
    return {
      'uId': uId,
      'fName': fName,
      'lName': lName,
      'email': email,
    };
  }
}
