// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:e_commerce_app/core/base_usecase/base_usecase.dart';
import 'package:e_commerce_app/core/failure/failure.dart';
import 'package:e_commerce_app/domain/Entity/login.dart';
import 'package:e_commerce_app/domain/repository/base_repository.dart';

class PostLoginDataUseCase extends BaseUseCase<LoginEntity,LoginParameters> {
  BaseRepository baseRepository;
  PostLoginDataUseCase({
    required this.baseRepository,
  });
  @override
  Future<Either<Failure, LoginEntity>> call(LoginParameters parameters)async {
    return await baseRepository.postLoginData(parameters.email, parameters.password);

  }

}

class LoginParameters {
  const LoginParameters({required this.email,required this.password,});
  final String email;
  final String password;
}