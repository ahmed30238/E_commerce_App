import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/utils/app_constances/app_constances.dart';
import 'package:e_commerce_app/core/error/error_message_model.dart';
import 'package:e_commerce_app/core/exceptions/exceptions.dart';
import 'package:e_commerce_app/data/models/AddOrDeleteFavourites_model.dart';
import 'package:e_commerce_app/data/models/banners_model.dart';
import 'package:e_commerce_app/data/models/category_model.dart';
import 'package:e_commerce_app/data/models/get_favourites_model.dart';
import 'package:e_commerce_app/data/models/home_model.dart';
import 'package:e_commerce_app/data/models/login_model.dart';
import 'package:e_commerce_app/data/models/logout_model.dart';
import 'package:e_commerce_app/data/models/register_model.dart';
import 'package:e_commerce_app/data/models/search_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseRemoteDataSource {
  Future<List<BannersModel>> getBanners();
  Future<HomeModel> getProducts(String token);
  Future<LoginModel> postLoginData(String email, String password);
  Future<CategoryModel> getCategories();
  Future<AddOrDeleteFavouritesModel> addOrDeleteFavourites(
      int id, String token);

  Future<GetFavouritesModel> getfavourites(String token);
  Future<SearchModel> postSearch(String text, String token);
  Future<LogoutModel> postLogout(String token);
  Future<RegisterModel> postRegisterData(
      String name, String phone, String email, String password);
}

class RemoteDataSource extends BaseRemoteDataSource {
  @override
  Future<List<BannersModel>> getBanners() async {
    var response = await Dio().get(AppConstances.bannerPath,
        options:
            Options(receiveDataWhenStatusError: true, receiveTimeout: 2000));

    if (response.statusCode == 200) {
      return List<BannersModel>.from(
        (response.data['data'] as List).map(
          (e) => BannersModel.fromjson(e),
        ),
      );
    } else {
      throw ServerException(
        ErrorMessageModel.fromJson(
          response.data,
        ),
      );
    }
  }

  @override
  Future<HomeModel> getProducts(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await Dio().get(AppConstances.homeDataPath,
        options: Options(
          receiveDataWhenStatusError: true,
          headers: {
            'Authorization': prefs.getString('token'),
            'lang':'en',
          },
        ));
    if (response.statusCode == 200) {
      return HomeModel.fromjson(response.data);
    } else {
      throw ServerException(
        ErrorMessageModel.fromJson(response.data),
      );
    }
  }



  @override
  Future<LoginModel> postLoginData(String email, String password) async {
    final response = await Dio().post(
      AppConstances.loginDataPath,
      data: {'email': email, 'password': password},
    );
    if (response.statusCode == 200) {
      return LoginModel.fromjson(response.data);
    } else {
      throw ServerException(ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<CategoryModel> getCategories() async {
    final response = await Dio().get(
      AppConstances.categoriesPath,
      options: Options(receiveTimeout: 2000,headers: {'lang':'en'}),
      
    );
    if (response.statusCode == 200) {
      return CategoryModel.fromjson(response.data);
    } else {
      throw ServerException(
        ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<AddOrDeleteFavouritesModel> addOrDeleteFavourites(
      int id, String token) async {
    final response = await Dio().post(
      AppConstances.addFavouritesPath,
      data: {
        'product_id': id,
      },
      options: Options(
        headers: {
          'Authorization': token,
        },
      ),
    );
    if (response.statusCode == 200) {
      return AddOrDeleteFavouritesModel.fromjson(response.data);
    } else {
      throw ServerException(
        ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<GetFavouritesModel> getfavourites(String token) async {
    final response = await Dio().get(
      AppConstances.addFavouritesPath,
      options: Options(
        headers: {
          'Authorization': token,
          'lang':'en'
        },
      ),
    );

    if (response.statusCode == 200) {
      return GetFavouritesModel.fromjson(response.data);
    } else {
      throw ServerException(
        ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<SearchModel> postSearch(String text, String token) async {
    final response = await Dio().post(
      AppConstances.postSearchPath,
      options: Options(
        headers: {
          'Authorization': token,
        },
        receiveDataWhenStatusError: true,
      ),
      data: {
        'text': text,
      },
    );

    if (response.statusCode == 200) {
      return SearchModel.fromjson(response.data);
    } else {
      throw ServerException(
        ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<LogoutModel> postLogout(String token) async {
    final response = await Dio().post(
      AppConstances.postLogoutPath,
      options: Options(
        headers: {
          'Authorization': token,
        },
        receiveDataWhenStatusError: true,
      ),
      data: {
        "fcm_token": 'SomeFcmToken',
      },
    );
    if (response.statusCode == 200) {
      return LogoutModel.fromjson(response.data);
    } else {
      throw ServerException(
        ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<RegisterModel> postRegisterData(
      String name, String phone, String email, String password) async {
    final response = await Dio().post(AppConstances.postRegisterDataPath,
        data: {
          'name': name,
          'phone': phone,
          'email': email,
          'password': password
        });
    if (response.statusCode == 200) {
      return RegisterModel.fromjson(response.data);
    } else {
      throw ServerException(ErrorMessageModel.fromJson(response.data));
    }
  }
}
