import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/domain/Entity/home_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:e_commerce_app/core/base_usecase/base_usecase.dart';
import 'package:e_commerce_app/core/failure/failure.dart';
import 'package:e_commerce_app/domain/repository/base_repository.dart';

class GetHomeProductsUseCase
    extends BaseUseCase<HomeEntity, ProductsParameter> {
  BaseRepository baseRepository;
  GetHomeProductsUseCase({
    required this.baseRepository,
  });
  @override
  Future<Either<Failure, HomeEntity>> call(
      ProductsParameter parameters) async {
    return await baseRepository.getProducts(
      parameters.token,
    );
  }
}

class ProductsParameter extends Equatable {
 final String token;
 const ProductsParameter({
    required this.token,
  });

  @override
  List<Object> get props => [token];
}
