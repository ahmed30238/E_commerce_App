// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:e_commerce_app/core/base_usecase/base_usecase.dart';
import 'package:e_commerce_app/core/failure/failure.dart';
import 'package:e_commerce_app/domain/Entity/register_entity.dart';
import 'package:e_commerce_app/domain/repository/base_repository.dart';

class PostRegisterDataUseCase
    extends BaseUseCase<RegisterEntity, RegisterDataParameters> {
  BaseRepository baseRepository;
    PostRegisterDataUseCase({
    required this.baseRepository,
  });
  @override
  Future<Either<Failure, RegisterEntity>> call(
      RegisterDataParameters parameters) async {
    return await baseRepository.postRegisterData(
      parameters.name,
      parameters.phone,
      parameters.email,
      parameters.password,
    );
  }
}

class RegisterDataParameters extends Equatable {
  final String name;
  final String password;
  final String email;
  final String phone;

  const RegisterDataParameters(
    this.name,
    this.password,
    this.email,
    this.phone,
  );

  @override
  List<Object> get props => [
        name,
        password,
        email,
        phone,
      ];
}
