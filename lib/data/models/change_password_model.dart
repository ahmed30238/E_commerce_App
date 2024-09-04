import 'package:e_commerce_app/domain/Entity/change_password.dart';

class ChangePasswordModel extends ChangePasswordEntity {
  ChangePasswordModel({
    required super.status,
    required super.message,
    required super.data,
  });

  factory ChangePasswordModel.fromjson(Map<String, dynamic> json) =>
      ChangePasswordModel(
        status: json["status"],
        message: json["message"],
        data: PasswordModificationDataModel.fromson(json["data"]),
      );
}

class PasswordModificationDataModel extends PasswordModificationData {
  PasswordModificationDataModel({required super.email});
  factory PasswordModificationDataModel.fromson(Map<String, dynamic> json) =>
      PasswordModificationDataModel(email: json["email"]);
}
