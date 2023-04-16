import 'package:e_commerce_app/domain/Entity/login.dart';

class LoginModel extends LoginEntity {
 const LoginModel(
    super.status, // bool
    super.message, // String
    super.loginData, // object
  );

  factory LoginModel.fromjson(Map<String, dynamic> json) => LoginModel(
        json['status'],
        json['message'],
      json['data'] != null? LoginDataModel.fromjson(json ['data']):null,
      );
}

class LoginDataModel extends LoginDataEntity {
 const LoginDataModel(
    super.id,
    super.name,
    super.email,
    super.phone,
    super.token,
    super.image,
  );
  factory LoginDataModel.fromjson(Map<String, dynamic> json) => LoginDataModel(
        json['id'],
        json['name'],
        json['name'],
        json['phone'],
        json['token'],
        json['image'],
      );
}
