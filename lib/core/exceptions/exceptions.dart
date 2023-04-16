import 'package:e_commerce_app/core/error/error_message_model.dart';

class ServerException implements Exception {
  ErrorMessageModel errorMessageModel;
  ServerException(
    this.errorMessageModel,
  );
}

class LocalDatabaseException implements Exception {
  final String message;
  LocalDatabaseException(
    this.message,
  );
}
