import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/base_usecase/base_usecase.dart';
import 'package:e_commerce_app/core/failure/failure.dart';
import 'package:e_commerce_app/domain/Entity/banners_entity.dart';
import 'package:e_commerce_app/domain/repository/base_repository.dart';

class GetBannersUseCase extends BaseUseCase<List<BannersEntity>, NoParameter> {
  BaseRepository baseRepository;
  GetBannersUseCase(this.baseRepository);

  @override
  Future<Either<Failure, List<BannersEntity>>> call(
      NoParameter parameters) async {
    return await baseRepository.getBanners();
  }
}
