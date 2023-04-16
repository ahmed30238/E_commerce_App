// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:e_commerce_app/core/base_usecase/base_usecase.dart';
import 'package:e_commerce_app/core/failure/failure.dart';
import 'package:e_commerce_app/domain/Entity/category_entity.dart';
import 'package:e_commerce_app/domain/repository/base_repository.dart';

class GetCategoryUseCase extends BaseUseCase<CategoryEntity,NoParameter> {
  BaseRepository baseRepository;
  GetCategoryUseCase({
    required this.baseRepository,
  });
  @override
  Future<Either<Failure, CategoryEntity>> call(NoParameter parameters) async{
    return await baseRepository.getCategory();
  }
}
