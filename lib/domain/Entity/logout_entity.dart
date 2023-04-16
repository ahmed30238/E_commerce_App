import 'package:equatable/equatable.dart';

class LogoutEntity extends Equatable {
  final bool status;
  final String message;
  final LogoutData logoutData;

  const LogoutEntity(this.status, this.message, this.logoutData);

  @override
  List<Object> get props => [status, message, logoutData];
}

class LogoutData extends Equatable {
  final int id;
  final String token;

  const LogoutData(this.id, this.token);

  @override
  List<Object> get props => [id, token];
}
