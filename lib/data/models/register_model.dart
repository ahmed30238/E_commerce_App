import 'package:e_commerce_app/domain/Entity/register_entity.dart';

class RegisterModel extends RegisterEntity {
  const RegisterModel(
    super.status,
    super.message,
    super.registerData,
  );

  factory RegisterModel.fromjson(Map<String, dynamic> json) => RegisterModel(
        json['status'],
        json['message'],
        RegisterDataModel.fromjson(json['data']),
      );
}

class RegisterDataModel extends RegisterData {
  const RegisterDataModel(
    super.name,
    super.phone,
    super.email,
    super.token,
  );
  factory RegisterDataModel.fromjson(Map<String, dynamic> json) =>
      RegisterDataModel(
        json['name'],
        json['phone'],
        json['email'],
        json['token'],
      );
}
