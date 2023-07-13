import 'package:e_commerce_app/core/helper_methods/helper_methods.dart';

class TokenUtil {
  static String? _token = "";

  static Future<void> saveToken(String myToken) async {
    _token =
        prefs?.setString(TokenEnum.token.name.toString(), myToken).toString();
    await loadTokenFromMemory();
  }

  static Future<void> loadTokenFromMemory() async {
    _token = prefs?.getString(TokenEnum.token.name.toString()).toString();
  }

  static String getTokenFromMemory() {
    return _token ?? "";
  }

  static Future<void> loadTokenToMemory() async {
    // _token = GetStorage().read(TokenEnum.token.name).toString();
  }

  static String getTokenFrkomMemory() {
    // return _token;
    return "";
  }

  // static Future<void> saveToken(String myToken) async {
  // GetStorage().write(TokenEnum.token.name, myToken);
  // await loadTokenToMemory();
  // }

  static void clearToken() {
    _token = '';
  }
}
// }

enum TokenEnum { token }
