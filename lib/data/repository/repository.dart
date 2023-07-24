import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/exceptions/exceptions.dart';
import 'package:e_commerce_app/core/failure/failure.dart';
import 'package:e_commerce_app/data/data_source/remote_data_source.dart';
import 'package:e_commerce_app/data/models/AddOrDeleteFavourites_model.dart';
import 'package:e_commerce_app/data/models/banners_model.dart';
import 'package:e_commerce_app/data/models/get_favourites_model.dart';
import 'package:e_commerce_app/data/models/home_model.dart';
import 'package:e_commerce_app/data/models/login_model.dart';
import 'package:e_commerce_app/data/models/logout_model.dart';
import 'package:e_commerce_app/domain/Entity/category_entity.dart';
import 'package:e_commerce_app/domain/Entity/register_entity.dart';
import 'package:e_commerce_app/domain/Entity/search_entity.dart';
import 'package:e_commerce_app/domain/repository/base_repository.dart';

class ShopRepository extends BaseRepository {
  BaseRemoteDataSource baseRemoteDataSource;
  ShopRepository({required this.baseRemoteDataSource});

  @override
  Future<Either<Failure, List<BannersModel>>> getBanners() async {
    final result = await baseRemoteDataSource.getBanners();
    try {
      return Right(result);
    } on ServerException catch (error) {
      return Left(
        ServerFailure(error.errorMessageModel.message),
      );
    }
  }

  @override
  Future<Either<Failure, HomeModel>> getProducts(String token) async {
    final res = await baseRemoteDataSource.getProducts(token);
    try {
      return Right(res);
    } on ServerException catch (error) {
      return Left(
        ServerFailure(
          error.errorMessageModel.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, LoginModel>> postLoginData(
      String email, String password) async {
    final res = await baseRemoteDataSource.postLoginData(
      email,
      password,
    );
    try {
      return Right(res);
    } on ServerException catch (error) {
      return Left(
        ServerFailure(
          error.errorMessageModel.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, CategoryEntity>> getCategory() async {
    final res = await baseRemoteDataSource.getCategories();
    try {
      return Right(res);
    } on ServerException catch (error) {
      return Left(
        ServerFailure(error.errorMessageModel.message),
      );
    }
  }

  @override
  Future<Either<Failure, AddOrDeleteFavouritesModel>> addOrDeleteFavourites(
    int id,
    String token,
  ) async {
    final res = await baseRemoteDataSource.addOrDeleteFavourites(id, token);
    try {
      return Right(res);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, GetFavouritesModel>> getFavourites(
      String token) async {
    final res = await baseRemoteDataSource.getfavourites(token);
    try {
      return Right(res);
    } on ServerException catch (error) {
      return Left(
        ServerFailure(error.errorMessageModel.message),
      );
    }
  }

  @override
  Future<Either<Failure, SearchEntity>> postSearch(
      String text, String token) async {
    final res = await baseRemoteDataSource.postSearch(text, token);
    try {
      return Right(res);
    } on ServerException catch (error) {
      return Left(
        ServerFailure(error.errorMessageModel.message),
      );
    }
  }

  @override
  Future<Either<Failure, LogoutModel>> postLogout(String token) async {
    final res = await baseRemoteDataSource.postLogout(token);
    try {
      return Right(res);
    } on ServerException catch (error) {
      return Left(
        ServerFailure(error.errorMessageModel.message),
      );
    }
  }

  @override
  Future<Either<Failure, RegisterEntity>> postRegisterData(
      String name, String phone, String email, String password) async {
    final res = await baseRemoteDataSource.postRegisterData(
        name, phone, email, password);
    try {
      return Right(res);
    } on ServerException catch (error) {
      return Left(
        ServerFailure(error.errorMessageModel.message),
      );
    }
  }
}
