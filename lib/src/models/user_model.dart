// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String? id;
  String? token;
  String? fullname;
  String? email;
  String? phoneNumber;
  String? cpf;
  String? password;

  UserModel({
    this.id,
    this.token,
    this.fullname,
    this.email,
    this.phoneNumber,
    this.cpf,
    this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  String toString() {
    return 'UserModel(id: $id, token: $token, name: $fullname, email: $email, phoneNumber: $phoneNumber, cpf: $cpf, password: $password)';
  }
}
