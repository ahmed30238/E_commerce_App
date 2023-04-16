import 'package:e_commerce_app/domain/Entity/logout_entity.dart';

class LogoutModel extends LogoutEntity {
  const LogoutModel(super.status, super.message, super.logoutData);

  factory LogoutModel.fromjson(Map<String, dynamic> json) => LogoutModel(
        json['status'],
        json['message'],
        LogoutDataModel.fromjson(json['data']),
      );
}

class LogoutDataModel extends LogoutData {
  const LogoutDataModel(super.id, super.token);

  factory LogoutDataModel.fromjson(Map<String, dynamic> json) =>
      LogoutDataModel(json['id'], json['token']);
}
