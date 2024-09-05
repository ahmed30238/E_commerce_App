import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/exceptions/exceptions.dart';
import 'package:e_commerce_app/core/failure/failure.dart';
import 'package:e_commerce_app/data/data_source/remote_data_source.dart';
import 'package:e_commerce_app/data/models/AddOrDeleteFavourites_model.dart';
import 'package:e_commerce_app/data/models/banners_model.dart';
import 'package:e_commerce_app/data/models/get_carts_model.dart';
import 'package:e_commerce_app/data/models/get_favourites_model.dart';
import 'package:e_commerce_app/data/models/home_model.dart';
import 'package:e_commerce_app/data/models/login_model.dart';
import 'package:e_commerce_app/data/models/logout_model.dart';
import 'package:e_commerce_app/domain/Entity/category_entity.dart';
import 'package:e_commerce_app/domain/Entity/change_password.dart';
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
  Future<Either<Failure, HomeModel>> getProducts() async {
    final res = await baseRemoteDataSource.getProducts();
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
    int productId,
  ) async {
    final res = await baseRemoteDataSource.addOrDeleteFavourites(productId);
    try {
      return Right(res);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, GetFavouritesModel>> getFavourites() async {
    final res = await baseRemoteDataSource.getfavourites();
    try {
      return Right(res);
    } on ServerException catch (error) {
      return Left(
        ServerFailure(error.errorMessageModel.message),
      );
    }
  }
  @override
  Future<Either<Failure, GetCartsModel>> getCarts() async {
    final res = await baseRemoteDataSource.getCarts();
    try {
      return Right(res);
    } on ServerException catch (error) {
      return Left(
        ServerFailure(error.errorMessageModel.message),
      );
    }
  }

  @override
  Future<Either<Failure, SearchEntity>> postSearch(String text) async {
    final res = await baseRemoteDataSource.postSearch(text);
    try {
      return Right(res);
    } on ServerException catch (error) {
      return Left(
        ServerFailure(error.errorMessageModel.message),
      );
    }
  }

  @override
  Future<Either<Failure, LogoutModel>> postLogout(String fcmToken) async {
    final res = await baseRemoteDataSource.postLogout(fcmToken);
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

  @override
  Future<Either<Failure, ChangePasswordEntity>> changePassword(
      String currentPasword, String newPassword) async {
    var result = await baseRemoteDataSource.postChangePassword(
      currentPasword,
      newPassword,
    );
    try {
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        e.errorMessageModel.message,
      ));
    }
  }
}
