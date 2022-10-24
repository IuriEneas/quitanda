// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String?,
      token: json['token'] as String?,
      fullname: json['fullname'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      cpf: json['cpf'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'token': instance.token,
      'fullname': instance.fullname,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'cpf': instance.cpf,
      'password': instance.password,
    };
