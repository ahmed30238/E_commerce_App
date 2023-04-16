import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  final bool status;
  final String message;
  final LoginDataEntity? loginData;

  const LoginEntity(this.status, this.message,
   this.loginData
   );

  @override
  List<Object> get props => [status, message];
}

class LoginDataEntity extends Equatable {
  // id,name,email,phone,token,image
  final int id;
  final String name;
  final String email;
  final String phone;
  final String token;
  final String image;

  const LoginDataEntity(
    this.id,
    this.name,
    this.email,
    this.phone,
    this.token,
    this.image,
  );

  @override
  List<Object> get props {
    return [
      id,
      name,
      email,
      phone,
      token,
      image,
    ];
  }
}
