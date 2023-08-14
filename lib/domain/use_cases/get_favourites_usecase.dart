// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:e_commerce_app/core/base_usecase/base_usecase.dart';
import 'package:e_commerce_app/core/failure/failure.dart';
import 'package:e_commerce_app/domain/Entity/get_favourites_entity.dart';
import 'package:e_commerce_app/domain/repository/base_repository.dart';

class GetFavouritesUseCase
    extends BaseUseCase<GetFavouritesEntity, NoParameter> {
  BaseRepository baseRepository;
  GetFavouritesUseCase({
    required this.baseRepository,
  });
  @override
  Future<Either<Failure, GetFavouritesEntity>> call(
      NoParameter parameters) async {
    return await baseRepository.getFavourites();
  }
}

class GetFavouritesParameters extends Equatable {
  final String token;

  const GetFavouritesParameters(this.token);

  @override
  List<Object> get props => [token];
}
