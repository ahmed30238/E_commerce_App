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
    return await baseRepository.postLogout(parameters.fcmToken);
  }
}

class LogoutParameters extends Equatable {
  final String fcmToken;

  const LogoutParameters(this.fcmToken);

  @override
  List<Object> get props => [fcmToken];
}
