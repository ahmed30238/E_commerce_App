import 'package:dartz/dartz.dart';

import 'package:e_commerce_app/core/base_usecase/base_usecase.dart';
import 'package:e_commerce_app/core/failure/failure.dart';
import 'package:e_commerce_app/domain/Entity/add_to_cart.dart';
import 'package:e_commerce_app/domain/repository/base_repository.dart';

class AddToCartUsecase
    implements BaseUseCase<AddToCartEntity, AddToCartParameters> {
  BaseRepository baseRepository;
  AddToCartUsecase({
    required this.baseRepository,
  });

  @override
  Future<Either<Failure, AddToCartEntity>> call(
      AddToCartParameters parameters) async {
    return await baseRepository.postAddCarts(parameters.productId);
  }
}

class AddToCartParameters {
  final int productId;

  AddToCartParameters({required this.productId});
}
