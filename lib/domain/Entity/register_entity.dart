import 'package:equatable/equatable.dart';

class RegisterEntity extends Equatable {
  final bool status;
  final String message;
  final RegisterData registerData;

  const RegisterEntity(this.status, this.message, this.registerData);

  @override
  List<Object> get props => [status, message,registerData];
}

class RegisterData extends Equatable {
  final String name;
  final String phone;
  final String email;
  final String token;

  const RegisterData(this.name, this.phone, this.email,this.token);

  @override
  List<Object> get props => [name, phone, email,token];
}
