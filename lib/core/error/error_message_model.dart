import 'package:equatable/equatable.dart';

class ErrorMessageModel extends Equatable {
  final String message;
  final bool status;
  const ErrorMessageModel(this.message, this.status);

  factory ErrorMessageModel.fromJson(Map<String, dynamic> json) =>
      ErrorMessageModel(
        json['message'],
        json['status'],
      );

  @override
  List<Object> get props => [
        message,
        status,
      ];
}
