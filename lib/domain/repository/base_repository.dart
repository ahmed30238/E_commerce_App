import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/failure/failure.dart';
import 'package:e_commerce_app/domain/Entity/add&delete_favourites_entity.dart';
import 'package:e_commerce_app/domain/Entity/banners_entity.dart';
import 'package:e_commerce_app/domain/Entity/category_entity.dart';
import 'package:e_commerce_app/domain/Entity/get_favourites_entity.dart';
import 'package:e_commerce_app/domain/Entity/home_entity.dart';
import 'package:e_commerce_app/domain/Entity/login.dart';
import 'package:e_commerce_app/domain/Entity/logout_entity.dart';
import 'package:e_commerce_app/domain/Entity/register_entity.dart';
import 'package:e_commerce_app/domain/Entity/search_entity.dart';

abstract class BaseRepository {
  Future<Either<Failure, List<BannersEntity>>> getBanners();
  Future<Either<Failure, HomeEntity>> getProducts();
  Future<Either<Failure, LoginEntity>> postLoginData(
      String email, String password);
  Future<Either<Failure, CategoryEntity>> getCategory();

  Future<Either<Failure, AddOrDeleteFavouritesEntity>> addOrDeleteFavourites(
      int id, String token);
  Future<Either<Failure, GetFavouritesEntity>> getFavourites();
  Future<Either<Failure, SearchEntity>> postSearch(String text);
  Future<Either<Failure, LogoutEntity>> postLogout(String token);
  Future<Either<Failure, RegisterEntity>> postRegisterData(
      String name, String phone, String email, String password);
}
