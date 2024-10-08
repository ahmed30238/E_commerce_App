import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/error/error_message_model.dart';
import 'package:e_commerce_app/core/exceptions/exceptions.dart';
import 'package:e_commerce_app/core/global/app_enums/enums.dart';
import 'package:e_commerce_app/core/network_call/network_call.dart';
import 'package:e_commerce_app/core/token_util/token_utile.dart';
import 'package:e_commerce_app/core/utils/app_constances/app_constances.dart';
import 'package:e_commerce_app/data/models/AddOrDeleteFavourites_model.dart';
import 'package:e_commerce_app/data/models/add_to_cart_model.dart';
import 'package:e_commerce_app/data/models/banners_model.dart';
import 'package:e_commerce_app/data/models/category_model.dart';
import 'package:e_commerce_app/data/models/change_password_model.dart';
import 'package:e_commerce_app/data/models/get_carts_model.dart';
import 'package:e_commerce_app/data/models/get_favourites_model.dart';
import 'package:e_commerce_app/data/models/home_model.dart';
import 'package:e_commerce_app/data/models/login_model.dart';
import 'package:e_commerce_app/data/models/logout_model.dart';
import 'package:e_commerce_app/data/models/register_model.dart';
import 'package:e_commerce_app/data/models/search_model.dart';

abstract class BaseRemoteDataSource {
  Future<List<BannersModel>> getBanners();
  Future<HomeModel> getProducts();
  Future<LoginModel> postLoginData(String email, String password);
  Future<CategoryModel> getCategories();
  Future<AddOrDeleteFavouritesModel> addOrDeleteFavourites(int productId);

  Future<GetFavouritesModel> getfavourites();
  Future<GetCartsModel> getCarts();
  Future<SearchModel> postSearch(String text);
  Future<LogoutModel> postLogout(String fcmToken);
  Future<ChangePasswordModel> postChangePassword(
    String currentPasword,
    String newPassword,
  );
  Future<AddToCartModel> postAddToCart(int productId);
  Future<RegisterModel> postRegisterData(
    String name,
    String phone,
    String email,
    String password,
  );
}

class RemoteDataSource extends BaseRemoteDataSource {
  @override
  Future<List<BannersModel>> getBanners() async {
    var response = await NetworkCall().get(path: AppConstances.bannerPath);
    if (response?.statusCode == 200) {
      return List<BannersModel>.from(
        (response?.data['data'] as List).map(
          (e) => BannersModel.fromjson(e),
        ),
      );
    } else {
      throw ServerException(
        ErrorMessageModel.fromJson(
          response?.data,
        ),
      );
    }
  }

  @override
  Future<HomeModel> getProducts() async {
    final response = await NetworkCall().get(path: AppConstances.homeDataPath);
    if (response?.statusCode == 200) {
      return HomeModel.fromjson(response?.data);
    } else {
      throw ServerException(
        ErrorMessageModel.fromJson(response?.data),
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
    final response =
        await NetworkCall().get(path: AppConstances.categoriesPath);
    if (response?.statusCode == 200) {
      return CategoryModel.fromjson(response?.data);
    } else {
      throw ServerException(
        ErrorMessageModel.fromJson(response?.data),
      );
    }
  }

  @override
  Future<AddOrDeleteFavouritesModel> addOrDeleteFavourites(
      int productId) async {
    final response = await Dio().post(
      AppConstances.addFavouritesPath,
      data: {
        'product_id': productId,
      },
      options: Options(
        headers: {
          'Authorization': TokenUtil.getTokenFromMemory(),
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
  Future<GetFavouritesModel> getfavourites() async {
    final response =
        await NetworkCall().get(path: AppConstances.addFavouritesPath);

    if (response?.statusCode == 200) {
      return GetFavouritesModel.fromjson(response?.data);
    } else {
      throw ServerException(
        ErrorMessageModel.fromJson(response?.data),
      );
    }
  }

  @override
  Future<GetCartsModel> getCarts() async {
    final response = await NetworkCall().get(path: AppConstances.getCartPath);

    if (response?.statusCode == 200) {
      return GetCartsModel.fromjson(response?.data);
    } else {
      throw ServerException(
        ErrorMessageModel.fromJson(response?.data),
      );
    }
  }

  @override
  Future<SearchModel> postSearch(String text) async {
    final response = await NetworkCall().post(
      AppConstances.postSearchPath,
      body: FormData.fromMap({
        'text': text,
      }),
    );

    if (response?.statusCode == 200) {
      return SearchModel.fromjson(response?.data);
    } else {
      throw ServerException(
        ErrorMessageModel.fromJson(response?.data),
      );
    }
  }

  @override
  Future<LogoutModel> postLogout(String fcmToken) async {
    final response = await NetworkCall().post(
      AppConstances.postLogoutPath,
      withHeader: false,
      body: FormData.fromMap(
        {
          "fcm_token": fcmToken,
        },
      ),
      headers: {
        "lang": "ar",
        "Content-Type": "application/json",
        'Authorization': TokenUtil.getTokenFromMemory(),
      },
    );

    if (response?.statusCode == 200) {
      return LogoutModel.fromjson(response?.data);
    } else {
      throw ServerException(
        ErrorMessageModel.fromJson(response?.data),
      );
    }
  }

  @override
  Future<AddToCartModel> postAddToCart(int productId) async {
    final response = await NetworkCall().post(
      AppConstances.getCartPath,
      // withHeader: false,
      // headers: {
      //   AppEnum.Authorization.name: TokenUtil.getTokenFromMemory(),
      // },
      body: FormData.fromMap(
        {
          "product_id": productId,
        },
      ),
    );

    if (response?.statusCode == 200) {
      return AddToCartModel.fromjson(response?.data);
    } else {
      throw ServerException(
        ErrorMessageModel.fromJson(response?.data),
      );
    }
  }

  @override
  Future<RegisterModel> postRegisterData(
      String name, String phone, String email, String password) async {
    final response = await NetworkCall().post(
        AppConstances.postRegisterDataPath,
        body: FormData.fromMap({
          'name': name,
          'phone': phone,
          'email': email,
          'password': password
        })
        // data:,
        );
    if (response?.statusCode == 200) {
      return RegisterModel.fromjson(response?.data);
    } else {
      throw ServerException(ErrorMessageModel.fromJson(response?.data));
    }
  }

  @override
  Future<ChangePasswordModel> postChangePassword(
      String currentPasword, String newPassword) async {
    var response = await NetworkCall().post(
      AppConstances.changePasswordPath,
      body: FormData.fromMap(
        {
          AppEnum.current_password.name: currentPasword,
          AppEnum.new_password.name: newPassword,
        },
      ),
      headers: {
        AppEnum.Authorization.name: TokenUtil.getTokenFromMemory(),
      },
      withHeader: false,
    );
    if (response?.statusCode == 200) {
      return ChangePasswordModel.fromjson(response?.data);
    } else {
      throw ServerException(ErrorMessageModel.fromJson(
        response?.data,
      ));
    }
  }
}
