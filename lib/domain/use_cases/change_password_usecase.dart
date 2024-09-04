// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:e_commerce_app/core/base_usecase/base_usecase.dart';
import 'package:e_commerce_app/core/failure/failure.dart';
import 'package:e_commerce_app/domain/Entity/change_password.dart';
import 'package:e_commerce_app/domain/repository/base_repository.dart';

class ChangePasswordUsecase
    extends BaseUseCase<ChangePasswordEntity, ChangePasswordParameters> {
  BaseRepository baseRepository;
  ChangePasswordUsecase({
    required this.baseRepository,
  });
  @override
  Future<Either<Failure, ChangePasswordEntity>> call(
      ChangePasswordParameters parameters) async {
    return await baseRepository.changePassword(
        parameters.currentPasword, parameters.newPassword);
  }
}

class ChangePasswordParameters {
  final String currentPasword;
  final String newPassword;

  ChangePasswordParameters(
      {required this.currentPasword, required this.newPassword});
}
