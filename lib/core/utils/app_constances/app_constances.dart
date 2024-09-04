import 'dart:io';

class AppConstances {
  static const baseUrl = 'https://student.valuxapps.com/api/';
  static const bannerPath = '${baseUrl}banners';
  static const changePasswordPath = '${baseUrl}change-password';
  static const homeDataPath = 'https://student.valuxapps.com/api/home';
  static const loginDataPath = 'https://student.valuxapps.com/api/login';
  static const categoriesPath = 'https://student.valuxapps.com/api/categories';
  static const addFavouritesPath =
      'https://student.valuxapps.com/api/favorites';
  static const postSearchPath =
      'https://student.valuxapps.com/api/products/search';
  static const postLogoutPath = '${baseUrl}logout';
  static const postRegisterDataPath =
      'https://student.valuxapps.com/api/register';
  static String get appUrl => Platform.isAndroid ? "androidUrl" : "appleUrl";
}
