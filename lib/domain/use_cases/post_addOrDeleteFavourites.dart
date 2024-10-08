import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:e_commerce_app/core/base_usecase/base_usecase.dart';
import 'package:e_commerce_app/core/failure/failure.dart';
import 'package:e_commerce_app/domain/Entity/add&delete_favourites_entity.dart';
import 'package:e_commerce_app/domain/repository/base_repository.dart';

class AddOrDeleteFavouritesUseCase extends BaseUseCase<
    AddOrDeleteFavouritesEntity, AddOrDeleteFavouritesParameters> {
  BaseRepository baseRepository;
  AddOrDeleteFavouritesUseCase({
    required this.baseRepository,
  });
  @override
  Future<Either<Failure, AddOrDeleteFavouritesEntity>> call(
      AddOrDeleteFavouritesParameters parameters) async {
    return await baseRepository.addOrDeleteFavourites(
        parameters.productId);
  }
}

class AddOrDeleteFavouritesParameters extends Equatable {
  final int productId;
  
  const AddOrDeleteFavouritesParameters(this.productId);

  @override
  List<Object> get props => [productId];
}
