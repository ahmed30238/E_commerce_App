import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/base_usecase/base_usecase.dart';
import 'package:e_commerce_app/core/failure/failure.dart';
import 'package:e_commerce_app/domain/Entity/get_carts_entity.dart';
import 'package:e_commerce_app/domain/repository/base_repository.dart';

class GetCartUsecase extends BaseUseCase<GetCartEntity, NoParameter> {
  BaseRepository baseRepository;
  GetCartUsecase({
    required this.baseRepository,
  });
  @override
  Future<Either<Failure, GetCartEntity>> call(NoParameter parameters) async{
    return await baseRepository.getCarts();
  }
}
