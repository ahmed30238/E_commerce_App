// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:e_commerce_app/core/base_usecase/base_usecase.dart';
import 'package:e_commerce_app/core/failure/failure.dart';
import 'package:e_commerce_app/domain/Entity/logout_entity.dart';
import 'package:e_commerce_app/domain/repository/base_repository.dart';

class LogoutUseCase extends BaseUseCase<LogoutEntity, LogoutParameters> {
  BaseRepository baseRepository;
  LogoutUseCase({
    required this.baseRepository,
  });
  @override
  Future<Either<Failure, LogoutEntity>> call(
      LogoutParameters parameters) async {
    return await baseRepository.postLogout(parameters.token);
  }
}

class LogoutParameters extends Equatable {
  final String token;

  const LogoutParameters(this.token);

  @override
  List<Object> get props => [token];
}
